/**
 * AS3 Google URL Shortener v1.0 (17/01/2011) <http://www.adrianparr.com/>
 * 
 * Copyright (c) 2011 Adrian Parr <http://www.adrianparr.com/>
 * This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
 * 
 * Thanks to Vijay Joshi for blogging about using cURL in PHP <http://www.vijayjoshi.org/2011/01/12/php-shorten-urls-using-google-url-shortener-api/>
 * 
 * Dependancies include ...
 * - The 'as3corelib' serialization classes <https://github.com/mikechambers/as3corelib>
 * - The 'googleUrlShortener_proxy.php' file (included)
 * 
 * AS3 Google URL Shortener is distributed as a top level class. Projects that utilize
 * code packages should use it with the com.adrianparr.utils package
 */

package com.adrianparr.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.sendToURL;
	import flash.net.URLLoaderDataFormat;
	import flash.events.IOErrorEvent;
	import flash.errors.IOError;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequestMethod;
	import flash.net.URLRequestHeader;
	
	import com.adobe.serialization.json.JSON;
	
	/**
	 * AS3 Google URL Shortener
	 * @author Adrian Parr (http://www.adrianparr.com)
	 */
	public class GoogleUrlShortener extends EventDispatcher
	{
		private static const _googleUrl:String = "https://www.googleapis.com/urlshortener/v1/url";
		private static const _serversideProxyUrl:String = "googleUrlShortener_proxy.php";
		
		private var _apiKey:String;
		private var _shortUrl:String;
		private var _longUrl:String;
		private var _errorText:String;
		private var _jsonData:String;
		
		public function GoogleUrlShortener() 
		{
			super();
		}
		
		public function expand(shortUrl:String, apiKey:String = ""):void 
		{
			_shortUrl = shortUrl;
			_apiKey = apiKey;
			_longUrl = undefined;
			_errorText = undefined;
			_jsonData = undefined;
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = _serversideProxyUrl;
			var vars:URLVariables = new URLVariables();
			vars.googleUrl = _googleUrl;
			vars.shortUrl = shortUrl;
			if (_apiKey != "") {
				vars.key = _apiKey;
			}
			urlRequest.data = vars;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onExpand_COMPLETE);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onExpand_IO_ERROR);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onExpand_SECURITY_ERROR);
			urlLoader.load(urlRequest);
		}
	
		private function onExpand_COMPLETE(event:Event):void 
		{
			var loader:URLLoader = URLLoader(event.target);
			_jsonData = String(loader.data);
			var longUrl:String = JSON.decode(_jsonData).longUrl as String;
			_longUrl = longUrl;
			dispatchEvent(event.clone());
		}
		
		private function onExpand_IO_ERROR(event:IOErrorEvent):void 
		{
			_errorText = event.text;
			dispatchEvent(event.clone());
		}
		
		private function onExpand_SECURITY_ERROR(event:SecurityErrorEvent):void 
		{
			_errorText = event.text;
			dispatchEvent(event.clone());
		}
		
		public function shorten(longUrl:String, apiKey:String = ""):void
		{
			_longUrl = longUrl;
			_apiKey = apiKey;
			_shortUrl = undefined;
			_errorText = undefined;
			_jsonData = undefined;
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = _serversideProxyUrl;
			var vars:URLVariables = new URLVariables();
			vars.googleUrl = _googleUrl;
			if (_apiKey != "") {
				vars.key = _apiKey;
			}
			vars.longUrl = _longUrl;
			urlRequest.data = vars;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, onShorten_COMPLETE);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onShorten_IO_ERROR);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onShorten_SECURITY_ERROR);
			urlLoader.load(urlRequest);
		}
		
		private function onShorten_COMPLETE(event:Event):void 
		{
			var loader:URLLoader = URLLoader(event.target);
			var shortUrl:String = String(loader.data);
			_shortUrl = shortUrl;
			dispatchEvent(event.clone());
		}
		
		private function onShorten_IO_ERROR(event:IOErrorEvent):void 
		{
			_errorText = event.text;
			dispatchEvent(event.clone());
		}
		
		private function onShorten_SECURITY_ERROR(event:SecurityErrorEvent):void 
		{
			_errorText = event.text;
			dispatchEvent(event.clone());
		}
		
		public function get shortUrl():String { return _shortUrl; }
		
		public function get longUrl():String { return _longUrl; }
		
		public function get errorText():String { return _errorText; }
		
		public function get jsonData():String { return _jsonData; }
		
	}

}