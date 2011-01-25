
// NOTE: For this to work it needs to be uploaded to a webserver along with the googleUrlShortener_proxy.php file.


package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.text.StyleSheet;

	import com.adrianparr.utils.GoogleUrlShortener;
	
	public class Main extends Sprite 
	{
		// Get your API key from http://code.google.com/apis/console/
		//private const _apiKey:String = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
		private const _apiKey:String = "AIzaSyDx5TjJXZ_w3Q1LJ61RfgOV236Iod2aZZ4";
		
		private var _styleSheet:StyleSheet;
		
		public function Main():void 
		{
			_styleSheet = new StyleSheet();
			_styleSheet.setStyle("a", {color:'#0000FF', textDecoration:'underline'});
			output_txt.styleSheet = _styleSheet;
			
			output_txt.htmlText = "<b>Accessing Google's URL Shortening API from Flash (AS3)</b>";
			
			var shortUrl:String = "http://goo.gl/t4myF";
			var urlShortener1:GoogleUrlShortener = new GoogleUrlShortener();
			urlShortener1.addEventListener(Event.COMPLETE, onExpandComplete);
			urlShortener1.addEventListener(IOErrorEvent.IO_ERROR, onExpandIOError);
			urlShortener1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onExpandSecurityError);
			// NOTE: The second API key (String) parameter is optional.
			urlShortener1.expand(shortUrl, _apiKey);
			
			var longUrl:String = "https://github.com/adrianparr/as3googleurlshortener";
			var urlShortener2:GoogleUrlShortener = new GoogleUrlShortener();
			urlShortener2.addEventListener(Event.COMPLETE, onShortenComplete);
			urlShortener2.addEventListener(IOErrorEvent.IO_ERROR, onShortenIOError);
			urlShortener2.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onShortenSecurityError);
			// NOTE: The second API key (String) parameter is optional.
			urlShortener2.shorten(longUrl, _apiKey);
			
			output_txt.htmlText += "<br>Data sent, waiting for Google's response ...";
		}
		
		private function onExpandComplete(event:Event):void 
		{
			var shortUrl:String = GoogleUrlShortener(event.target).shortUrl;
			var longUrl:String = GoogleUrlShortener(event.target).longUrl;
			
			output_txt.htmlText += "<br>------------------------------------------<br>";
			output_txt.htmlText += "shortUrl: <a href='" + shortUrl + "' target='_blank'>" + shortUrl + "</a>";
			output_txt.htmlText += "<br>has been expanded to ...<br>";
			output_txt.htmlText += "longUrl: <a href='" + longUrl + "' target='_blank'>" + longUrl + "</a>";
		}
		
		private function onExpandIOError(event:Event):void 
		{
			output_txt.htmlText += "<br>------------------------------------------<br>";
			output_txt.htmlText += "onExpandError()<br>";
			output_txt.htmlText += event.target.errorText;
		}
		
		private function onExpandSecurityError(event:Event):void 
		{
			output_txt.htmlText += "<br>------------------------------------------<br>";
			output_txt.htmlText += "onExpandSecurityError()<br>";
			output_txt.htmlText += event.target.errorText;
		}
		
		private function onShortenComplete(event:Event):void 
		{
			var longUrl:String = GoogleUrlShortener(event.target).longUrl;
			var shortUrl:String = GoogleUrlShortener(event.target).shortUrl;
			
			output_txt.htmlText += "<br>------------------------------------------<br>";
			output_txt.htmlText += "longUrl: <a href='" + longUrl + "' target='_blank'>" + longUrl + "</a>";
			output_txt.htmlText += "<br>has been shortened to ...<br>";
			output_txt.htmlText += "shortUrl: <a href='" + shortUrl + "' target='_blank'>" + shortUrl + "</a>";
		}
		
		private function onShortenIOError(event:Event):void 
		{
			output_txt.htmlText += "<br>------------------------------------------<br>";
			output_txt.htmlText += "onShortenError()<br>";
			output_txt.htmlText += event.target.errorText;
		}
		
		private function onShortenSecurityError(event:Event):void 
		{
			output_txt.htmlText += "<br>------------------------------------------<br>";
			output_txt.htmlText += "onShortenSecurityError()<br>";
			output_txt.htmlText += event.target.errorText;
		}
		
	}	
}