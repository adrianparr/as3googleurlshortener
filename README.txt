as3googleurlshortener

This class uses Google's URL Shortener API to shorten and expand URLs. To circumvent Google's restrictive crossdomain policy file (http://goo.gl/crossdomain.xml) a PHP file is used as a proxy (included with the source).

There are two public methods ...

shorten
The first parameter is the long URL you wish to shorten (String)
The second parameter is optional and is your API key (String) which can be obtained from Google here http://code.google.com/apis/console/

expand
The first parameter is the short URL you wish to expand (String)
The second parameter is optional and is your API key (String) which can be obtained from Google here http://code.google.com/apis/console/

Due to the asynchronous nature of receiving the data back from Google, it is necessary to set up an event handler that listens for the Event.COMPLETE event. An example of this is provided in the source files.


Example Code

import com.adrianparr.utils.GoogleUrlShortener?;
var longUrl:String = "http://code.google.com/p/as3googleurlshortener/";
var apiKey:String = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
var gus:GoogleUrlShortener = new GoogleUrlShortener();
gus.addEventListener(Event.COMPLETE, onShortenComplete);
gus.shorten(longUrl, apiKey);
function onShortenComplete(event:Event):void {
    var shortUrl:String = GoogleUrlShortener(event.target).shortUrl;
    trace(shortUrl);
}



Credits / Thanks / Useful URLs

'PHP: Shorten URLs using Google URL shortener API' by Vijay Joshi http://www.vijayjoshi.org/2011/01/12/php-shorten-urls-using-google-url-shortener-api/

Google URL Shortener API http://code.google.com/apis/urlshortener/

'Quick Tip: Using a PHP Proxy to Load Assets into Flash' by Daniel Van Houten http://active.tutsplus.com/tutorials/actionscript/quick-tip-using-a-php-proxy-to-load-assets-into-flash/

'as3corelib' by Adobe/Mike Chambers https://github.com/mikechambers/as3corelib
