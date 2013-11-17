/*
    Heyzap Tools ActionScript 3 Library
    Version 3.3.1

    (c) 2009 Heyzap
*/

package heyzap.as3 {
    import flash.net.navigateToURL;
	import flash.system.Security;
    import flash.display.MovieClip;
    import flash.display.DisplayObjectContainer;
    import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.StatusEvent;
    import flash.net.URLRequest;
    import flash.net.LocalConnection;

    public class HeyzapTools {
        // Static variables
        public static var callbackList:Object = {};
        public static var instance:HeyzapTools;
		public static var cb:String;
		public static var lastOptions:Object;

        // Instance variables
        public var gameKey:String;
        public var clip:DisplayObjectContainer;
        public var baseUrl:String;
        public var reqUrl:String;
        private var ready:Boolean;
        private var messageQueue:Array;
        private var container:MovieClip;
        private var tools:MovieClip;
        private var loader:Loader;
        private var slcName:String;
        private var rlcName:String;
        private var receivingLC:LocalConnection;
        private var sendingLC:LocalConnection;



        //
        // Public static functions
        //

        // Load the Heyzap Tools
        public static function load (options:Object):void {
            if(options.game_key == undefined) {
                throw new Error("[Heyzap] You must provide your 'game_key' as a parameter.");
            }

            if(options.clip == undefined) {
                throw new Error("[Heyzap] You must provide a 'clip' as a parameter (usually root).")
            }

            if(!instance) {
                // Set up cachebreaker string for loading the swf
                cb = randomString();

                // Allow cross domain access
                var allowedDomains:Array = ["localhost", "heyzap.com", "www.heyzap.com", "tools.heyzap.com", "*"];
                for(var i:int=0; i<allowedDomains.length; i++) {
                    Security.allowDomain(allowedDomains[i]);
                    Security.allowInsecureDomain(allowedDomains[i]);
                }
            } else {
                if((options.game_key == instance.gameKey) && (options.clip == instance.clip) && (options.base_server == instance.baseUrl)) {
                    return;
                } else {
                    instance.destroy(true);
                    instance = undefined;
                }
            }

            lastOptions = options;
            instance = new HeyzapTools(options);
        }

        // Register a function to handle responses from heyzap
        public static function addEventListener (eventType:String, callback:Function):void {
            if(!callbackList[eventType]) {
                callbackList[eventType] = [];
            }
            
            callbackList[eventType].push(callback);
        }

        // Remove a previously registered event listener
        public static function removeEventListener (eventType:String, callback:Function):void {
            if(callbackList && callbackList[eventType]) {
                for(var i:Number; i<callbackList[eventType]; i++) {
                    if(callbackList[eventType][i] === callback) {
                        delete callbackList[eventType][i];
                        break;
                    }
                }
            }
        }

        // Send a message to heyzap
        public static function send (action:String, options:Object=null):void {
            if(!instance) {
                if(lastOptions) {
                    instance = new HeyzapTools(lastOptions);
                } else {
                    throw new Error("[Heyzap] Error: You must call import heyzap.as3.*; HeyzapTools.load({game_key: \"yourgamekeyhere\"}) first.");
                }
            }

            instance.sendMessage(action, options);
        }
        
        // Launch popups from client library to avoid popup blockers
        public static function launchPage (action:String, options:Object=null):void {
            if(!instance) {
                if(lastOptions) {
                    instance = new HeyzapTools(lastOptions);
                } else {
                    throw new Error("[Heyzap] Error: You must call import heyzap.as3.*; HeyzapTools.load({game_key: \"yourgamekeyhere\"}) first.");
                }
            }

            options = options || {};
            options["req"] = action;
            options["game_key"] = instance.gameKey;
            options["game_swf_url"] = instance.clip.root.loaderInfo.loaderURL;

            var url:URLRequest = new URLRequest(buildUrl(instance.reqUrl + "/flash_launcher", options));
            navigateToURL(url, "_blank");
        }

        // Return current API version
        public static function version ():String {
            return "3.3.1";
        }



        //
        // Private static functions
        //

        // Generate a timestamp-prefixed random string
        private static function randomString():String {
            return ((new Date()).getTime() + "_" + Math.floor(Math.random() * 99999));
        }
    
        // Build a url with a query string
        private static function buildUrl (url:String, vars:Object):String {
            var q:Boolean = true;
            for(var i:String in vars) {
                if(vars.hasOwnProperty(i)) {
                    if(vars[i]) {
                        url += (q ? "?" : "&") + escape(i) + "=" + escape(vars[i]);
                        if(q) q = false;
                    }
                }
            }
            return url;
        }



        //
        // Private instance functions
        //

        // Constructor
        public function HeyzapTools (options:Object) {
            super();

            ready = false;
            messageQueue = [];
            gameKey = options["game_key"];
            clip = options["clip"];

            if(options["base_server"]) {
                baseUrl = reqUrl = options["base_server"];
            } else {
                baseUrl = "http://tools.heyzap.com";
                reqUrl = "http://www.heyzap.com";
            }

            // Create the heyzap tools container
            container = new MovieClip();
            clip.addChild(container);
            container.visible = false;

            // Create the localconnection names
            slcName = "_s" + randomString();
            rlcName = "_r" + randomString();

            // Build URL
            var url:String = buildUrl(baseUrl + "/external/tools/v3.swf", {
                cb: cb,
                slc_name: slcName,
                rlc_name: rlcName,
                game_key: gameKey,
                swf_url: clip.root.loaderInfo.loaderURL,
                as_version: 3,
                library_version: version()
            });
            
            // Create loader and load in external swf
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
            loader.load(new URLRequest(url));
            container.addChild(loader);

            // Set up receiving local connection
            receivingLC = new LocalConnection();
            receivingLC.allowDomain("www.heyzap.com", "tools.heyzap.com", "localhost");
            receivingLC.allowInsecureDomain("www.heyzap.com", "tools.heyzap.com", "localhost");
            receivingLC.client = container;
            container["widgetReady"] = widgetReady;
            container["fireClientCallback"] = fireClientCallback;
            container["destroyInstance"] = destroyInstance;

            // Set up sending local connection
            sendingLC = new LocalConnection();
            sendingLC.addEventListener(StatusEvent.STATUS, function (e:StatusEvent):void {
                if(e.level == "error") {
                    trace("[Heyzap] Game -> Widget LocalConnection sending failed: " + e.code);
                }
            }, false, 0, true);
            sendingLC.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function (e:SecurityErrorEvent):void {
                trace("[Heyzap] Security error: " + e.text);
            }, false, 0, true);
        }
    
        // Destroy the heyzap tools instance
        private function destroy (clearSettings:Object):void {
            if(clearSettings) {
                lastOptions = undefined;
            }

            receivingLC.close();
            receivingLC = undefined;
            sendingLC = undefined;
            
            // Remove event handler functions for localconnection
            for(var i:String in container) {
                if(container.hasOwnProperty(i)) {
                    if(typeof container[i] == "function") {
                        delete container[i];
                    }
                }
            }
            
            // Remove event handler functions for loader
            loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);

            // Remove movieclips from parents and close localconnection
            container.removeChild(loader);
            clip.removeChild(container);
            
            try {
                var unloadAndStop:Function = loader["unloadAndStop"] as Function;
                unloadAndStop();
            } catch(err:Error) {
                loader.unload();
            }
        }
    
        // Send a message to the heyzap tools widget
        private function sendMessage (fName:String, functionArgs:Object):void {
            if(ready) {
                sendingLC.send(slcName, fName, functionArgs);
            } else {
                messageQueue.push({name: fName, args: functionArgs});
            }
        }

        // Flush any queued messages to the heyzap tools widget swf
        private function flushMessages ():void {
            for(var i:Number = 0; i < messageQueue.length; i++) {
                var thisMessage:Object = messageQueue[i];
                sendingLC.send(slcName, thisMessage.name, thisMessage.args);
            }
        }
    
        // Local connection event handlers
        private function widgetReady ():void {
            container.visible = true;
            flushMessages();
            ready = true;
        }

        private function fireClientCallback (callbackName:String, response:Object):void {
            clip.setChildIndex(container, clip.numChildren - 1);

            if(callbackList && callbackList[callbackName]) {
                for(var i:Number=0; i<callbackList[callbackName].length; i++) {
                    if(typeof(callbackList[callbackName][i]) == "function") {
                        callbackList[callbackName][i](response);
                    }
                }
            }
        }
        
        private function destroyInstance ():void {
            instance.destroy(false);
            instance = null;
        }
        
        // Loade event handlers
        private function completeHandler (e:Event):void {
            receivingLC.connect(rlcName);
        }
        
        private function ioErrorHandler (e:Event):void {
            trace("[Heyzap] Failed to load heyzap tools swf.");
        }
    }
}
