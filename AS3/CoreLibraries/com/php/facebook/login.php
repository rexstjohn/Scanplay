<?php

	//this page shows the login nonsense
	//if a session is established, none of this should be visible
    include_once "connection.php";
	include_once "queries.php"; //useful queries and functions

    $config['baseurl']  =   "http://web.scanplaygames.com/test/facebook/index.php";	

	// Get all our stuff if the session is in session
	if ($session) 
	{
	  try 
	  {
		$uid = $facebook->getUser();
		$me = $facebook->api('/me');	
		//get the friends list
		$friends = $facebook->api('/me/friends?fields=id');  
		$friendNames = $facebook->api('/me/friends?fields=name');  
	  } 
	  catch (FacebookApiException $e) 
	  {
		error_log($e);
	  }
	}
 
	
?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>FriendSiege PHP TestBed</title>
    </head>
<body>
    <div id="fb-root"></div>
        <script type="text/javascript">
            window.fbAsyncInit = function() 
			{
                FB.init({appId: '<?=$fbconfig['appid' ]?>', status: true, cookie: true, xfbml: true});
 
                /* All the events registered */
                FB.Event.subscribe('auth.login', function(response) {
                    // do something with response
                    login();
                });
                FB.Event.subscribe('auth.logout', function(response) {
                    // do something with response
                    logout();
                });
            };
            (function() {
                var e = document.createElement('script');
                e.type = 'text/javascript';
                e.src = document.location.protocol +
                    '//connect.facebook.net/en_US/all.js';
                e.async = true;
                document.getElementById('fb-root').appendChild(e);
            }());
 
            function login(){
                document.location.href = "<?=$config['baseurl']?>";
            }
            function logout(){
                document.location.href = "<?=$config['baseurl']?>";
            }
</script>
<style type="text/css">
    .box{
        margin: 5px;
        border: 1px solid #60729b;
        padding: 5px;
        width: 500px;
        height: 200px;
        overflow:auto;
        background-color: #e6ebf8;
    }
</style> 
    <?php if (!$me) { ?>
        You must login using FB Login Button to see api calling result.
    <?php } ?>
    <p>
        <fb:login-button autologoutlink="true" perms="friends_photos,user_photos"></fb:login-button>
    </p> 
	
	<?php if ($me) { ?>
        <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab" width="498" height="380" id="test1">
		<param name="movie" value="http://web.scanplaygames.com/test/facebook/FriendSiege.swf" />
		<embed src="http://web.scanplaygames.com/test/facebook/FriendSiege.swf?<?=GetFriendIDs($friends) ?>" width="800" height="600" name="test" type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer" />
		</object>
    <?php } ?>
    </body>
</html>