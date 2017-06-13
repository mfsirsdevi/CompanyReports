/**
* File: application.cfc
* Author: Satyapriya Baral
* Path: application.cfc
* Purpose: contains all event listner for the application
* Date: 01-05-2017
*/
component {
	this.datasource = "CompanyReports";
	this.name = "CompanyReports";
	this.clientmanagement = true;
	this.sessionmanagement = true; 
	this.setclientcookies = true;
	this.sessiontimeout = "#createTimeSpan(0,0,20,10)#";
	this.applicationtimeout = "#createTimeSpan(0,0,30,10)#";

	/**
    * Function to set current user on applicaton start.
    *
    * @param null.
    */
	function onApplicationStart() {
		APPLICATION.currentUsers = "";
		APPLICATION.baseUrlData = getDirectoryFromPath(getCurrentTemplatePath());
	}
	
	/**
    * Function to set variables on Session start.
    *
    * @param null.
    */
	function onSessionStart() {
		SESSION.isLogged = "false";
		SESSION.userEmail = "";
	}
	
	function onRequestStart( string template ) {
	  
      LOCAL.path = {};
      LOCAL.path.basePath = getDirectoryFromPath(getCurrentTemplatePath());
            
      LOCAL.path.targetPath = getDirectoryFromPath(expandPath( ARGUMENTS.template ));

      LOCAL.path.requestDepth = (listLen( LOCAL.path.targetPath, "\/" ) - listLen( LOCAL.path.basePath, "\/" ));
      REQUEST.webRoot = repeatString("../", LOCAL.path.requestDepth);

      REQUEST.siteUrl = ("http://" & cgi.server_name & reReplace(getDirectoryFromPath( ARGUMENTS.template ), "([^\\/]+[\\/]){#LOCAL.path.requestDepth#}$", "", "one"));

	  return true;
    }

    function onRequest( string targetPage ) {
        include ARGUMENTS.targetPage;
        return;
    }
	
	/**
    * Function to set variables on session end.
    *
    * @param null.
    */
	function onSessionEnd( struct SessionScope, struct ApplicationScope) {
		ApplicationScope.currentUsers = listDeleteAt(ApplicationScope.currentUsers,listFind(ApplicationScope.currentUsers,#SessionScope.userEmail#));
		location(url = "../index.cfm" addtoken = "false");
		structClear(ARGUMENTS.SessionScope);
	}
}