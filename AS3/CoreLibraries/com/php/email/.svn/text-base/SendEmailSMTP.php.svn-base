<?php
 require_once "Mail.php";
 
 $from = "ScanPlayGames<support@scanplaygames.com>";
 $to = "Rex St John<rexstjohn@gmail.com>";
 $subject = "Hi!";
 $body = "Support email working correctly";
 
 $host = "mail.scanplaygames.com";
 $username = "support@scanplaygames.com";
 $password = "1killab3";
 
 $headers = array ('From' => $from,
   'To' => $to,
   'Subject' => $subject);
 $smtp = Mail::factory('smtp',
   array ('host' => $host,
     'auth' => true,
     'username' => $username,
     'password' => $password));
 
 $mail = $smtp->send($to, $headers, $body);
 
 if (PEAR::isError($mail)) {
   echo("<p>" . $mail->getMessage() . "</p>");
  } else {
   echo("<p>Message successfully sent!</p>");
  }
 ?>