/*
    Heyzap Tools ActionScript 2 Library
    Version 3.3.1

    (c) 2009 Heyzap
*/

class heyzap.as2.HeyzapTools {
    // Static variables
    static var callbackList:Object = {};
    static var instance:HeyzapTools;
    static var cb:String;
    static var lastOptions:Object;

    // Instance variables
    public var gameKey:String;
    public var clip:MovieClip;
    public var baseUrl:String;
    public var reqUrl:String;
    private var ready:Boolean;
    private var messageQueue:Array;
    private var container:MovieClip;
    private var tools:MovieClip;
    private var loader:MovieClipLoader;
    private var slcName:String;
    private var rlcName:String;
    private var receivingLC:LocalConnection;
    private var sendingLC:LocalConnection;

    private static var MAX_DEPTH:Number = 1048575;

    //
    // Public static functions
    //

    // Load the Heyzap Tools
    public static function load (options:Object):Void {
        if(options.game_key == undefined) {
            throw new Error("[Heyzap] You must provide your 'game_key' as a parameter.");
        }

        if(!instance) {
            // Set up cachebreaker string for loading the swf
            cb = randomString();

            // Allow cross domain access
            var allowedDomains:Array = ["localhost", "heyzap.com", "www.heyzap.com", "tools.heyzap.com", "*"];
            for(var i:Number=0; i<allowedDomains.length; i++) {
                System.security.allowDomain(allowedDomains[i]);
                System.security.allowInsecureDomain(allowedDomains[i]);
            }
        }

        if(instance) {
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
    public static function addEventListener (eventType:String, callback:Function):Void {
        if(!callbackList[eventType]) {
            callbackList[eventType] = [];
        }
        
        callbackList[eventType].push(callback);
    }

    // Remove a previously registered event listener
    public static function removeEventListener (eventType:String, callback:Function):Void {
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
    public static function send (action:String, options:Object):Void {
        if(!instance) {
            if(lastOptions) {
                instance = new HeyzapTools(lastOptions);
            } else {
                throw new Error("[Heyzap] Error: You must call import heyzap.as2.*; HeyzapTools.load({game_key: \"yourgamekeyhere\"}) first.");
            }
        }

        instance.sendMessage(action, options);
    }

    // Launch popups from client library to avoid popup blockers
    public static function launchPage (action:String, options:Object):Void {
        if(!instance) {
            if(lastOptions) {
                instance = new HeyzapTools(lastOptions);
            } else {
                throw new Error("[Heyzap] Error: You must call import heyzap.as2.*; HeyzapTools.load({game_key: \"yourgamekeyhere\"}) first.");
            }
        }
        
        options = options || {};
        options["req"] = action;
        options["game_key"] = instance.gameKey;
        options["game_swf_url"] = instance.clip._url;

        var url:String = buildUrl(instance.reqUrl + "/flash_launcher", options);
        getURL(url, '_blank');
    }

    // Return current API version
    public static function version ():String {
        return "3.3.1";
    }



    //
    // Private static functions
    //

    // Generate a timestamp-prefixed random string
    private static function randomString ():String {
        return (new Date().getTime() + "_" + random(99999));
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
        // Set up initial state
        ready = false;
        messageQueue = [];
        gameKey = options["game_key"];

        if(options["base_server"]) {
            baseUrl = reqUrl = options["base_server"];
        } else {
            baseUrl = "http://tools.heyzap.com";
            reqUrl = "http://www.heyzap.com";
        }

        if(options["clip"]) {
            clip = options["clip"];
        } else {
            clip = _root;
        }

        // Create the heyzap tools container
        if(clip["_hzcontainer"]) {
            clip["_hzcontainer"].removeMovieClip();
        }
        
        if(clip.getNextHighestDepth() > MAX_DEPTH) {
            container = clip.createEmptyMovieClip("_hzcontainer", MAX_DEPTH);
        } else {
            container = clip.createEmptyMovieClip("_hzcontainer", clip.getNextHighestDepth());
        }
        
        container._visible = false;        
        
        // Create a movieclip to load the heyzap tools into
        tools = container.createEmptyMovieClip("_tools", 0);
        tools._lockroot = true;

        // Create the localconnection names
        slcName = "_s" + randomString();
        rlcName = "_r" + randomString();

        // Build URL
        var url:String = buildUrl(baseUrl + "/external/tools/v3.swf", {
            cb: cb,
            slc_name: slcName,
            rlc_name: rlcName,
            game_key: gameKey,
            swf_url: clip._url,
            as_version: 2,
            library_version: version()
        });
        
        // Set up loader callbacks
        var self:HeyzapTools = this;
        var loadHandler:Object = new Object();
        loadHandler.onLoadError = function (mc:MovieClip, error:String, httpStatus:Number):Void {
            trace("[Heyzap] Failed to load heyzap tools from: " + url);
        };

        loadHandler.onLoadInit = function (mc:MovieClip):Void {
            self.receivingLC.connect(self.rlcName);
        };

        // Create loader and load in external swf
        loader = new MovieClipLoader();
        loader.addListener(loadHandler);
        loader.loadClip(url, tools);

        // Set up receiving local connection
        receivingLC = new LocalConnection();
        receivingLC["widgetReady"] = mx.utils.Delegate.create(this, widgetReady);
        receivingLC["fireClientCallback"] = mx.utils.Delegate.create(this, fireClientCallback);
        receivingLC["destroyInstance"] = mx.utils.Delegate.create(this, destroyInstance);
        receivingLC.allowDomain = function (dom:String):Boolean {
            return(true);
        };
        
        // Set up sending local connection
        sendingLC = new LocalConnection();
        sendingLC.onStatus = function (infoObject:Object):Void {
            if(infoObject.level == "error") {
                trace("[Heyzap] Game -> Widget LocalConnection sending failed.");
            }
        };
    }
    
    // Destroy the heyzap tools instance
    private function destroy (clearSettings:Boolean):Void {
        if(clearSettings) {
            lastOptions = undefined;
        }
        
        receivingLC.close();
        receivingLC = undefined;
        sendingLC = undefined;
        
        loader.unloadClip(tools);
        tools.removeMovieClip();
        container.removeMovieClip();
    }
    
    // Send a message to the heyzap tools widget
    private function sendMessage (fName:String, functionArgs:Object):Void {
        if(ready) {
            sendingLC.send(slcName, fName, functionArgs);
        } else {
            messageQueue.push({name: fName, args: functionArgs});
        }
    }

    // Flush any queued messages to the heyzap tools widget swf
    private function flushMessages ():Void {
        for(var i:Number = 0; i < messageQueue.length; i++) {
            var thisMessage:Object = messageQueue[i];
            sendingLC.send(slcName, thisMessage.name, thisMessage.args);
        }
    }
    
    // Local connection event handlers
    private function widgetReady ():Void {
        container._visible = true;
        flushMessages();
        ready = true;
    }
    
    private function fireClientCallback (callbackName:String, response:Object):Void {
        if(clip.getNextHighestDepth() > MAX_DEPTH) {
            container.swapDepths(MAX_DEPTH);
        } else {
            container.swapDepths(clip.getNextHighestDepth());
        }
        
        if(callbackList && callbackList[callbackName]) {
            for(var i:Number=0; i<callbackList[callbackName].length; i++) {
                if(typeof(callbackList[callbackName][i]) == "function") {
                    callbackList[callbackName][i](response);
                }
            }
        }
    }
    
    private function destroyInstance ():Void {
        instance.destroy(false);
        instance = null;        
    }
}
