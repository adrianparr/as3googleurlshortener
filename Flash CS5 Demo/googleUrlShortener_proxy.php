<?php

	// http://active.tutsplus.com/tutorials/actionscript/quick-tip-using-a-php-proxy-to-load-assets-into-flash
	// http://www.vijayjoshi.org/2011/01/12/php-shorten-urls-using-google-url-shortener-api/

	$googleUrl = $_GET['googleUrl'];
	$shortUrl = $_GET['shortUrl'];
	$longUrl = $_GET['longUrl'];
	$key = $_GET['key'];
	$jsonStr = $_GET['jsonStr'];

	if ($shortUrl) {
		// Expand a shortUrl in to a longUrl

		if ($key) {
			$filename = $googleUrl."?shortUrl=".$shortUrl."&key=".$key;
		} else {
			$filename = $googleUrl."?shortUrl=".$shortUrl;
		}

		header('Content-Type: application/json');
		readfile($filename);

	} else if ($longUrl) {
		// Shorten a longUrl in to a shortUrl

		$postData = array('longUrl' => $longUrl, 'key' => $key);
		$jsonData = json_encode($postData);

		$curlObj = curl_init();
 
		curl_setopt($curlObj, CURLOPT_URL, $googleUrl);
		curl_setopt($curlObj, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($curlObj, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt($curlObj, CURLOPT_HEADER, 0);
		curl_setopt($curlObj, CURLOPT_HTTPHEADER, array('Content-type:application/json'));
		curl_setopt($curlObj, CURLOPT_POST, 1);
		curl_setopt($curlObj, CURLOPT_POSTFIELDS, $jsonData);
		 
		$response = curl_exec($curlObj);

		$json = json_decode($response);
 
		curl_close($curlObj);
 
		echo $json->id;

	}
	
?>