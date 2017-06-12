/**
* File: reportController.cfc
* Author: R S Devi Prasad, Satyapriya Baral
* Path: controller/reportController.cfc
* Purpose: contains functions for report generation and display to the user.
* Date: 08-06-2017
*/

component {
    reportObject = CreateObject("component", "model.reportModel");
	error = CreateObject("component", "log.error");

    /**
    * Function to display report for the user by reading the company id and report id.
    * @author R S Devi Prasad
    * @param string cid - company id of the company for which the report is to be generated.
    * @param string rid - report id of the report.
    * @return struct - containing data to be displayed or the errors.
    */
    public any function generateReport(numeric cid, numeric rid) {

        try {
			return reportObject.getReportViewData(ARGUMENTS.cid, ARGUMENTS.rid).getResult();
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
    }

    /**
    * Function to add record of highlight.
    * @author Satyapriya Baral
    * @param string subject - contains the highlight subject.
    * @param string body - contains the highlight body.
    * @param string tag - contains the highlight tag.
    * @param string rid - contains the recordId.
    * @return struct of all highlited data.
    */
    remote function addHighlight(string subject, string body, string tag, string rid) {

        try {
            createTag = reportObject.addTag(tag, rid);
            createHighlight = reportObject.addHighlight(subject, body, #createTag.getprefix().identitycol#);
            getData = reportObject.getHighlightData(rid);
            writedump("#getData#");
          //  reportObject.addHighlight(ARGUMENTS.subject)
			//return reportObject.getReportViewData(ARGUMENTS.cid, ARGUMENTS.rid).getResult();
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
    }

    remote function saveAnalysis(any data) method="POST" {
        try {
            
        } 

        catch (any exception) {
            error.errorLog(exception);
        }
    }
}