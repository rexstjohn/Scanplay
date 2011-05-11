            
<?
if(!empty($_POST['sender_mail'])
    || !empty($_POST['sender_message'])
    || !empty($_POST['sender_subject'])
    || !empty($_POST['sender_name']))
{
    $to = $_POST['recipient_name']."<".$_POST['recipient_mail'].">"; // replace with your target mail address
    $s_name = $_POST['sender_name'];
    $s_mail = $_POST['sender_mail'];
    $subject = stripslashes($_POST['sender_subject']);
    $body = stripslashes($_POST['sender_message']);
    $body .= "Click To View Your Punishment: ".$_POST['included_link'];
    $body .= "\n\n---------------------------\n";
    $body .= "Mail sent by: $s_name <$s_mail>\n";
    $header = "From: $s_name <$s_mail>\n";
    $header .= "Reply-To: $s_name <$s_mail>\n";
    $header .= "X-Mailer: PHP/" . phpversion() . "\n";
    $header .= "X-Priority: 1";
    if(@mail($to, $subject, $body, $header))
    {
        echo "output=sent";
    } else {
        echo "output=error";
    }
} else {
    echo "output=error";
}
?>
