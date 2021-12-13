component {

	// Application properties
	this.name = hash( getCurrentTemplatePath() );
	this.applicationTimeout = createTimeSpan(0,1,0,0);
	this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0,1,0,0);
    this.setClientCookies = true;
	// this.timezone = "Asia/Karachi";
	// this.mailservers = [{
	// 	host: "host"
	// 	,port: 25
	// 	,username: "username"
	// 	,password: "password"
	// 	,ssl: false
	// 	,tls: false
	// 	,lifeTimespan: CreateTimeSpan( 0, 0, 1, 0 ) //Overall timeout for the connections established to the mail server.
	// 	,idleTimespan: CreateTimeSpan( 0, 0, 0, 10 ) //Idle timeout for the connections established to the mail server.
	// }];

	devServerList = "127.0.0.1,localhost,development";
	if(listFindNoCase(devServerList, cgi.server_name)){
		this.datasource = "datasource_dev";
	}else{
		this.datasource = "datasource_prod";
	}

	this.appRoot = expandPath('/');
	this.mappings[ "handlers" ] = "#this.appRoot#handlers\";
	this.mappings[ "models" ] = "#this.appRoot#models\";

	public boolean function onApplicationStart(){
		application.isDevelopment = false;
		application.isLocalhost = false;
		application.isProduction = true;

		var devServerList = "127.0.0.1,localhost,development";
		if(listFindNoCase(devServerList, cgi.server_name)){
			if(cgi.server_name EQ '127.0.0.1'){
				application.isLocalhost = true;
			}
			application.isDevelopment = true;
			application.isProduction = false;
		}

		// remove objects from application scope if exists
		if(structKeyExists(application, "util")){
			structDelete(application, "util");
		}
		// if(structKeyExists(application, "jwt")){
		// 	structDelete(application, "jwt");
		// }

		// model objects
		application.util = new models.utility( );

		// lib objects
		// application.jwt = new includes.lib.jwt.jwt( );

		return true;
	}

	// application end
	public boolean function onApplicationEnd( struct applicationScope ) {
		// Destroy application-cached components
		if(structKeyExists(arguments.applicationScope, "util")){
			structDelete(arguments.applicationScope, "util");
		}
		// if(structKeyExists(arguments.applicationScope, "jwt")){
		// 	structDelete(arguments.applicationScope, "jwt");
		// }

		return true;
	}

	// request start
	public boolean function onRequestStart( string targetPage ){
		// reinitialize application
		if(structKeyExists(url, 'reinit') AND url.reinit EQ "dev"){
			onApplicationStart();
			componentCacheClear();
			pagePoolClear();
		}

		if(cgi.server_port_secure){
			request.siteUrl = 'https://' & cgi.http_host & '/';
		}else{
			request.siteUrl = 'http://' & cgi.http_host & '/';
		}

		// establish a browser scope to hold client device properties
		request.browser = structNew();
		request.browser.clientIp = cgi.REMOTE_ADDR;
		request.browser.http_referer = '';
		request.browser.http_user_agent = '';
		request.headers = GetHttpRequestData().headers;
		// replace calling IP in case of cloudflare proxies
		if (structKeyExists(request.headers,'x-forwarded-for')){
			request.browser.clientIp = listFirst(request.headers['x-forwarded-for']);
		}
		if (structKeyExists(request.headers,'CF-Connecting-IP')){
			request.browser.clientIp = listFirst(request.headers['CF-Connecting-IP']);
		}
		if (structKeyExists(cgi,'HTTP_REFERER')){
			request.browser.http_referer = cgi.HTTP_REFERER;
		}
		if (structKeyExists(cgi,'HTTP_USER_AGENT')){
			request.browser.http_user_agent = cgi.HTTP_USER_AGENT;
		}

		return true;
	}

}