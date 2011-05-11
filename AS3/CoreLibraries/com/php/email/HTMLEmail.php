<?
	//get the post variables
    $to = $_POST['recipient_name']."<".$_POST['recipient_email'].">"; // replace with your target mail address
    $sender_name = $_POST['sender_name'];
    $sender_email = $_POST['sender_email'];
	$challenge_guid = $_POST['challenge_guid'];
	$included_link  = $_POST['included_link'];
    $subject = stripslashes($_POST['sender_subject']);
	
	//create a boundary string. It must be unique 
	//so we use the MD5 algorithm to generate a random hash
	$random_hash = md5(date('r', time())); 
	//define the headers we want passed. Note that they are separated with \r\n
	$headers = "From: no-reply@scanplaygames.com\r\nReply-To: no-reply@scanplaygames.com";
	//add boundary string and mime type specification
	$headers .= "\r\nContent-Type: multipart/alternative; boundary=\"PHP-alt-".$random_hash."\""; 
	//define the body of the message.
	ob_start(); //Turn on output buffering
?>
--PHP-alt-<?php echo $random_hash; ?>  
Content-Type: text/plain; charset="iso-8859-1" 
Content-Transfer-Encoding: 7bit

Hello World!!! 
This is simple text email message. 

--PHP-alt-<?php echo $random_hash; ?>  
Content-Type: text/html; charset="iso-8859-1" 
Content-Transfer-Encoding: 7bit

<h2>You have Been Apprehended by Sheriff <b><?php echo $sender_name?></b> </h2>
<a href="<?php echo $included_link?>?=<?php echo $challenge_guid?>">Click to view your punishment (and get a shot at revenge).</a> 

--PHP-alt-<?php echo $random_hash; ?>--
<?
	//copy current buffer contents into $message variable and delete current output buffer
	$message = ob_get_clean();
	//send the email
	$mail_sent = @mail( $to, $subject, $message, $headers );
	//if the message is sent successfully print "Mail sent". Otherwise print "Mail failed" 
	echo $mail_sent ? "Mail sent" : "Mail failed";
?>