<!-----------------------------------------------------------------------Author 	 :	Luis MajanoDate     :	September 25, 2005Description :	General handler for my hello application. Please remember to alter	your extends base component using the Coldfusion Mapping.	example:		Mapping: fwsample		Argument Type: fwsample.system.eventhandlerModification History:Sep/25/2005 - Luis Majano	-Created the template.-----------------------------------------------------------------------><cfcomponent name="ehGeneral" extends="coldbox.system.eventhandler">	<cffunction name="init" access="public" returntype="any" output="false">		<cfargument name="controller" type="any">		<cfset super.init(arguments.controller)>		<!--- Any constructor code here --->		<cfreturn this>	</cffunction>	<!--- ************************************************************* --->	<cffunction name="onRequestStart" access="public" output="false" returntype="void">	</cffunction>	<!--- ************************************************************* --->	<!--- ************************************************************* --->	<cffunction name="onApplicationStart" access="public" output="false" returntype="void">		<cfset application.luis = "Yes sir">		<cfset application.loader = controller.getPlugin("JavaLoader").setup("includes/helloworld.jar")>		<cfset application.mysiteDSNBean = getDatasource("mysite")>	</cffunction>	<!--- ************************************************************* --->	<!--- ************************************************************* --->	<cffunction name="onRequestEnd" access="public" output="false" returntype="void">	</cffunction>	<cffunction name="preHandler" access="public" output="false" returntype="void">		<cfscript>		var logger = controller.getPlugin("logger");		logger.logEntry("information","I am just inside the pre-handler method. #logger.getHash()#");		</cfscript>	</cffunction>	<cffunction name="postHandler" access="public" output="false" returntype="void">		<cfscript>		var logger = controller.getPlugin("logger");		logger.logEntry("information","I am inside the post-handler method. #logger.getHash()#");		</cfscript>	</cffunction>	<!--- ************************************************************* --->	<cffunction name="dspHello" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfset var logger = controller.getPlugin("logger")>	    <cfset var storage = controller.getPlugin("clientstorage")>	    <cfset var complexStruct = "">	    <cfset var complete = "">	    		<cfset Event.setValue("MailBean",getMailSettings())>				<!--- Get a new instance plugin --->		<cfset event.setValue("mylogger", getPlugin("logger",false,true) )>		<cfset event.getValue("mylogger").setLogFullPath(ExpandPath("./config/luis.log"))>				<!--- Create a tracer message --->		<cfset logger.tracer("Starting dspHello. Using default name")>		<!--- Set the firstname Value --->		<cfset Event.setValue("firstname",controller.getSetting("Codename", true) & controller.getSetting("Version", true))>		<!--- Set the View To Display, after Logic --->		<cfset Event.setView("vwHello")>		<!--- Set another tracer variable --->		<cfset logger.tracer("View has been set")>		<!--- Create a simple permanent variable --->		<cfset storage.setvar("luis","Luis Majano")>		<!--- Permanent Complex Variable --->		<cfset complexStruct = structnew()>		<cfset complexStruct.today = now()>		<cfset complexStruct.message = "This is a complex variable.">		<cfset complexStruct.BitFlag = "1">		<cfset storage.setvar("complexStruct",complexStruct)>		<cfset complete = isEmail("lmajano@gmail.com")>		<cfset Event.setvalue("HelloWorldObj", application.loader.create("HelloWorld").init())>		<!--- Create an info MessageBox --->		<cfset controller.getPlugin("messagebox").setMessage("info", "Hello and welcome to the ColdBox' message box. You can place messages here from any of your applications. You can also choose the desired image to display. You can set error message, warning messages or just plain informative messages like this one. You can do this by using the <b>messagebox</b> plugin.")>		<!--- Get view contents ---->		<cfset Event.setValue("MyQuote", renderView("vwQuote"))>	</cffunction>	<!--- ************************************************************* --->	<!--- ************************************************************* --->	<cffunction name="doChangeLocale" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- Change Locale --->		<cfset controller.getPlugin("i18n").setfwLocale(Event.getValue("locale"))>		<cfset dspHello(Event)>	</cffunction>	<!--- ************************************************************* --->	<!--- ************************************************************* --->	<cffunction name="doLog" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfscript>		var logger = controller.getPlugin("logger");		logger.logEntry("error","This is an error message that I logged.","Home Portals is the best.");		logger.logEntry("information","This is an information message that I logged.");		logger.logEntry("warning","This is an warning message that I logged.");		logger.logEntry("fatal","The whole thing crashed man");		dspHello(Event);		</cfscript>	</cffunction>	<cffunction name="doClearLog" access="public" returntype="void" output="false">		<cfscript>		controller.getPlugin("fileUtilities").removeFile(controller.getSetting("ColdboxLogsLocation"));		controller.setnextevent("ehGeneral.dspHello","fwreinit=1");		</cfscript>	</cffunction>	<cffunction name="docustomplugin" access="public" returntype="void" output="false">		<cfset controller.getMyPlugin("myclientstorage").setvar("MyCustomVariable","Custom Variable has been set by custom plugin at #timeformat(now(),"HH:MM:SS TT")#.")>		<cfset controller.setNextEvent("","usecustomplugin=true")>	</cffunction>	<cffunction name="doFormBean" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfscript>		var rc = Event.getCollection();		//populate bean		rc.FormBean = controller.getPlugin("beanfactory").populateBean("#controller.getSetting("AppMapping")#.model.formBean");		Event.setView("vwFormBean");		</cfscript>	</cffunction></cfcomponent>