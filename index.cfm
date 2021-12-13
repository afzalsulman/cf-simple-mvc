<cfsetting enablecfoutputonly="false"/>
<cfparam name="request.layout" default="main">
<cfparam name="url.event" default="echo.index">
<cfparam name="request.alertMessage" default="">
<cfparam name="request.alertType" default="">

<cfset handler = listFirst(url.event,'.')/>
<cfset action = 'index'/>
<cfif listLen(url.event,'.') EQ 2>
    <cfset action = listLast(url.event,'.')/>
</cfif>

<!--- create the handler object --->
<cfset objHandler = createObject("component", "handlers/#handler#").init()/>
<!--- call specific function of handler for each request --->
<cfset objHandler[action]()/>
<!--- Get the content of each page, it will pass in layout --->
<cfsavecontent variable="request.pageContent">
    <cfinclude template="views/#handler#/#action#.cfm">
</cfsavecontent>

<cfif request.layout EQ 'dashboard'>
    <cfinclude template="layouts/dashboard.cfm"/>
<cfelseif request.layout EQ 'main'>
    <cfinclude template="layouts/main.cfm"/>
<cfelse>
    <cfoutput>#request.pageContent#</cfoutput>
</cfif>

<!--- <cfscript>
	// 
	include "models/applicationHelper.cfm";
	// call request handler
	requestHandler();

	try{

		// call security check
		apiSecurity();

		if(request.isValidRequest){
			// create the handler object
			createObjHandler = createObject("component", "handlers/#request.handler#").init();
			// call specific function of handler for each request
			objHandler = createObjHandler[request.action](argumentCollection=form);
			// pass form struct
			// objHandler(argumentCollection=form);
		}

	}catch(any e){
		errorMessage = e.message & " " & e.detail & " " & e.tagcontext[1].LINE;
		request.messages = request.messages.append('A error occured. '&errorMessage);
	}

	// call response handler
	responseHandler();
</cfscript> --->
