<?php

/* This is an exmaple of how to pass flash vars into a flash app and embed
a flash file into a php page easily*/

$flashUrl = "http://web.scanplaygames.com/Prototypes/HangEm/HangEm.swf";
$embedVars = "?guid=".$_POST['challenge_guid'];//get any incoming guid
$flashName = "Test";
	
?>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Flash Embed Example</title>
    </head>
<body>
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
        <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab" width="498" height="380" id="<?=$flashName?>">
		<param name="movie" value="<?=$flashUrl?>" />
		<embed src="<?=$flashUrl.$embedVars?>" width="800" height="600" name="<?=$flashName?>" type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer" />
		</object>
    </body>
</html>