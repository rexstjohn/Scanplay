/**
* MochiServices
* Class that provides API access to Mochi Coins Service
* @author Mochi Media
*/
package mochi.as3 {

    import flash.display.Sprite;

    public class MochiCoins {
        public static const STORE_SHOW:String = "StoreShow";
        public static const STORE_HIDE:String = "StoreHide";

        // event passes {id: item id, count: number owned}
        public static const ITEM_OWNED:String = "ItemOwned";

        // event passes {id: item id, count: number of new items}
        public static const ITEM_NEW:String = "ItemNew";

        // initiated with getStoreItems() call.
        // event passes array of item metas [ { id: "ab473e7f87129ecb", name: "Super Cannon", desc: "A Super Cannon",
        //    imgURL: "http://..", cost: 150, maxNum: 1, tags: [ level-1, powerup] ], properties: { power: 20 } } ]
        public static const STORE_ITEMS:String = "StoreItems";

        public static const ERROR:String = "Error";
        // error types
        public static const IO_ERROR:String = "IOError";
        public static const NO_USER:String = "NoUser";

        public static var _inventory:MochiInventory;

        // HOOK DEFAULT EVENT LISTENERS
        {
            MochiSocial.addEventListener( MochiSocial.LOGGED_IN, function(args:Object):void {
                _inventory = new MochiInventory();
            } );
            MochiSocial.addEventListener( MochiSocial.LOGGED_OUT, function(args:Object):void {
                _inventory = null;
            } );
        }

        public static function get inventory():MochiInventory
        {
            return _inventory;
        }

        public static function getVersion():String
        {
            return MochiServices.getVersion();
        }

        /**
         * Method: showStore
         * Displays the MochiGames Store.
         * @param   options object containing variables representing the changeable parameters <see: GUI Options>
         */
        public static function showStore(options:Object = null):void
        {
            MochiServices.bringToTop();
            MochiServices.send("coins_showStore", { options: options }, null, null );
        }

        /**
         * Method: showItem
         * Displays the MochiGames with one item.
         * @param   options object containing variables representing the changeable parameters <see: GUI Options>
         */
        public static function showItem(options:Object = null):void
        {
            if ((! options) || (typeof(options.item) != "string")) {
                trace("ERROR: showItem call must pass an Object with an item key");
                return;
            }

            MochiServices.bringToTop();
            MochiServices.send("coins_showItem", { options: options }, null, null );
        }

        /**
         * Method: showVideo
         * Displays the demonstration video for an item
         * @param   options object containing variables representing the changeable parameters <see: GUI Options>
         */
        public static function showVideo(options:Object = null):void
        {
            if ((! options) || (typeof(options.item) != "string")) {
                trace("ERROR: showVideo call must pass an Object with an item key");
                return;
            }

            MochiServices.bringToTop();
            MochiServices.send("coins_showVideo", { options: options }, null, null );
        }

        /**
         * Method: getStoreItems
         * Calls STORE_ITEMS event, passing an object with all store items, keyed by itemID
         * { ab473e7f87129ecb: { name: "Super Cannon", desc: "A Super Cannon", imgURL: "http://..", cost: 150, maxNum: 1, tags:{ levels: "level-1" } } }
         */
        public static function getStoreItems():void
        {
            MochiServices.send("coins_getStoreItems");
        }

        // --- Callback system ----------
        public static function addEventListener( eventType:String, delegate:Function ):void
        {
            MochiSocial.addEventListener( eventType, delegate );
        }

        public static function triggerEvent( eventType:String, args:Object ):void
        {
            MochiSocial.triggerEvent( eventType, args );
        }

        public static function removeEventListener( eventType:String, delegate:Function ):void
        {
            MochiSocial.removeEventListener( eventType, delegate );
        }
    }
}
