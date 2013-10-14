package mochi.as3 {
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;

    dynamic public class MochiSync extends Proxy
    {
        public static var SYNC_REQUEST:String = "SyncRequest";
        public static var SYNC_PROPERTY:String = "UpdateProperty";
        private var _syncContainer:Object;

        public function MochiSync():void
        {
            _syncContainer = {};
        }

        override flash_proxy function getProperty(name:*):* {
            return _syncContainer[name];
        }

        override flash_proxy function setProperty(name:*, value:*):void {
            if( _syncContainer[name] == value )
                return ;

            var n:String = name.toString();

            _syncContainer[n] = value;
            MochiServices.send("sync_propUpdate", {name:n,value:value});
        }

        public function triggerEvent( eventType:String, args:Object ):void
        {
            switch( eventType )
            {
                case SYNC_REQUEST:
                    MochiServices.send("sync_syncronize", _syncContainer );
                    break ;
                case SYNC_PROPERTY:
                    _syncContainer[args.name] = args.value;
                    break ;
            }
        }
    }
}
