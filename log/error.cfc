/**
* File: error.cfc
* Author: Satyapriya Baral
* Path: log/error.cfc
* Purpose: contains function to log error to file.
* Date: 08-05-2017
*/
component {
	
	/**
    * Function to log error to file.
    *
    * @param mixed $exception - contains all data of error.
    * @return null.
    */
	public any function errorLog(any exception)
	{
		LOCAL.NL = CreateObject("java", "java.lang.System").getProperty("line.separator");
		
		// Details about the error to log //
		savecontent variable="data"
		{
			WriteOutput('DATE/TIME: #Now()# #LOCAL.NL#');
			WriteOutput('ERROR MESSAGE: #exception.Message# #LOCAL.NL#');
			WriteOutput('ERROR DETAILS: #exception.Detail# #LOCAL.NL#');
			WriteOutput('ERROR TEMPLATE: #exception.TagContext[1].Template# #LOCAL.NL#');
			WriteOutput('ERROR LINE: #exception.TagContext[1].Line# #LOCAL.NL#');
			WriteOutput('ERROR TYPE: #exception.Type# #LOCAL.NL#');
			WriteOutput('STACKTRACE: #exception.TagContext[1].Raw_Trace# #LOCAL.NL#');
			WriteOutput('----------------------------------------------------------------------#NL#');
		}
		
		myFile = expandPath( "../../log/errorLog.txt" );
		fileObj = FileOpen( myFile, "append");
		fileWriteLine(fileObj,"#data#");
		fileClose(fileObj);
	}
}
