<?php

// Only respond to POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') die();

// Check our honeypot field and bail if it's been filled out
if ($_POST['comment']) die();

$ch = curl_init('https://api.mailgun.net/v2/ideum.mailgun.org/messages');
curl_setopt($ch, CURLOPT_POST, true);

curl_setopt($ch, CURLOPT_USERPWD, 'api:key-5tkpjau9edpkwon-k9b7gn2p8px5d250');  
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query(array(
    'from'    => "${_POST['name']} <${_POST['email']}>",
    'to'      => 'support@gestureworks.com',
    'subject' => 'Comment from Gestureworks.com',
    'text'    => $_POST['message']
)));

curl_exec($ch);
curl_close($ch);

http_response_code(303); // See Other
header("Location: http://$_SERVER[HTTP_HOST]/contact-sent");
