/**
* MochiServices
* Class that provides API access to Mochi Coins Service
* @author Mochi Media
*/
package mochi.as3 {

    import flash.display.Sprite;

    public class MochiSocial {
        public static const LOGGED_IN:String = "LoggedIn";
        public static const LOGGED_OUT:String = "LoggedOut";
        public static const LOGIN_SHOW:String = "LoginShow";
        public static const LOGIN_HIDE:String = "LoginHide";
        public static const LOGIN_SHOWN:String = "LoginShown";
        public static const PROFILE_SHOW:String = "ProfileShow";
        public static const PROFILE_HIDE:String = "ProfileHide";
        public static const PROPERTIES_SAVED:String = "PropertySaved";
        public static const WIDGET_LOADED:String = "WidgetLoaded";

        // initiated with getUserInfo() call.
        // event pass object with user info.
        // {name: "name", uid: unique_identifier, profileImgURL: url_of_player_image, hasCoins: True}
        public static const USER_INFO:String = "UserInfo";

        public static const ERROR:String = "Error";
        // error types
        public static const IO_ERROR:String = "IOError";
        public static const NO_USER:String = "NoUser";
        public static const PROPERTIES_SIZE:String = "PropertiesSize"

        private static var _dispatcher:MochiEventDispatcher = new MochiEventDispatcher();
        public static var _user_info:Object = null;

        public static function getVersion():String
        {
            return MochiServices.getVersion();
        }

        public static function getAPIURL():String
        {
            if (!_user_info) return null;
            return _user_info.api_url;
        }

        public static function getAPIToken():String
        {
            if (!_user_info) return null;
            return _user_info.api_token;
        }

        // Hook default event listener behavior
        {
            MochiSocial.addEventListener( MochiSocial.LOGGED_IN, function(args:Object):void {
                _user_info = args;
            } );
            MochiSocial.addEventListener( MochiSocial.LOGGED_OUT, function(args:Object):void {
                _user_info = null;
            } );
        }

        /**
         * Method: showLoginWidget
         * Displays the MochiGames Login widget.
         * @param   options object containing variables representing the changeable parameters <see: GUI Options>
         * {x: 150, y: 10}
         */
        public static function showLoginWidget(options:Object = null):void
        {
            MochiServices.setContainer();
            MochiServices.bringToTop();
            MochiServices.send("coins_showLoginWidget", { options: options });
        }

        public static function hideLoginWidget():void
        {
            MochiServices.send("coins_hideLoginWidget");
        }

        public static function requestLogin():void
        {
            MochiServices.send("coins_requestLogin");
        }

        /**
         * Method: getUserInfo
         * Calls USER_INFO event.  If a user is logged in, it repeats the same info triggered by the LOGGED_IN event. Otherwise it returns
         * an empty Object.
         * {name: "name", uid: unique_identifier, profileImgURL: url_of_player_image, hasCoins: True}
         */
        public static function getUserInfo():void
        {
            MochiServices.send("coins_getUserInfo");
        }

        public static function saveUserProperties(properties:Object):void
        {
            MochiServices.send("coins_saveUserProperties", properties);
        }

        // --- Callback system ----------
        public static function addEventListener( eventType:String, delegate:Function ):void
        {
            _dispatcher.addEventListener( eventType, delegate );
        }

        public static function get loggedIn():Boolean
        {
            return _user_info != null;
        }

        public static function triggerEvent( eventType:String, args:Object ):void
        {
            _dispatcher.triggerEvent( eventType, args );
        }

        public static function removeEventListener( eventType:String, delegate:Function ):void
        {
            _dispatcher.removeEventListener( eventType, delegate );
        }
    }
}
