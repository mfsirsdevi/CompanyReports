/**
* File: reportController.cfc
* Author: R S Devi Prasad, Satyapriya Baral
* Path: controller/reportController.cfc
* Purpose: contains functions for report generation and display to the user.
* Date: 08-06-2017
*/

component {
    reportObject = CreateObject("component", "model.reportModel");
	include "../include/include.cfm";

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
    remote function addHighlight(string subject, string body, string tag, string rid) returnformat="JSON"
    {
        try {
            LOCAL.createTag = reportObject.addTag(ARGUMENTS.tag, ARGUMENTS.rid);
            LOCAL.getTotalData = reportObject.getTotalHighlight();
            LOCAL.total = "#LOCAL.getTotalData.recordcount#";
            LOCAL.sId = "#LOCAL.getTotalData.int_highlight_sec_id[LOCAL.total]#";
            LOCAL.createHighlight = reportObject.addHighlight(ARGUMENTS.subject, ARGUMENTS.body,
                    LOCAL.sid+1, #LOCAL.createTag.getPrefix().identitycol#);
            showHighlight(ARGUMENTS.rid);
        }

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = [];
            return serializeJSON(LOCAL.errorData);
        }
    }

    /**
    * Function to get all highlight data according to the record id.
    * @author Satyapriya Baral
    * @param string rid - contains the recordId.
    * @return json data of highlight
    */
    remote function showHighlight(numeric rid) returnformat="JSON"
    {
        try {
            LOCAL.getData = reportObject.getHighlightData(rid);
            LOCAL.highlightData = [];
            for(i=1 ; i <= LOCAL.getData.recordcount ; i++) {
					obj = {
                        "id" = "#LOCAL.getData.int_highlight_sec_id[i]#",
						"sortId" = "#LOCAL.getData.int_sortid[i]#",
						"subject" = "#LOCAL.getData.str_subject[i]#",
						"body" = "#LOCAL.getData.str_text[i]#"
					};
					arrayAppend(LOCAL.highlightData, obj);
			}
			WriteOutput("#serializeJSON(highlightData)#");
		}

		catch (any exception){
			error.errorLog(exception);
            LOCAL.errorData = [];
            return serializeJSON(LOCAL.errorData);
        }
    }

    /**
    * Function to get all highlight data.
    * @author Satyapriya Baral
    * @param string rid - report id of the report.
    * @return struct - containing data of highlight
    */
    public query function getHighlightData(required numeric rid)
    {
        try {
            LOCAL.getData = reportObject.getHighlightData(rid);
            return getData;
        }

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
			return LOCAL.errorData;
        }
    }

    /**
    * Function to update highlight data sortId.
    * @author Satyapriya Baral
    * @param number rid - report id of the report.
    * @param string sortData - contains sort data.
    * @return null.
    */
    remote function updateHighlight(string sortData, numeric rid) returnformat="JSON"
    {
        try {
            LOCAL.getData = reportObject.getHighlightData(rid);
            for(i=1 ; i <= LOCAL.getData.recordcount ; i++) {
                LOCAL.item = listGetAt(ARGUMENTS.sortData, i);
                LOCAL.id = listGetAt(item,2,"_");
                LOCAL.sortOrder = (LOCAL.getData.recordcount - i)+1;
                updateSortOrder = reportObject.updateSortOrder(LOCAL.sortOrder, LOCAL.id);
            }
		}

		catch (any exception){
			error.errorLog(exception);
            LOCAL.errorData = [];
            return serializeJSON(LOCAL.errorData);
        }
    }

    /**
    * Function to delete a highlight data.
    * @author Satyapriya Baral
    * @param number highlightId - contains the highlight id.
    * @param string rid - contains the recordId.
    * @return null.
    */
    remote function deleteHighlight(numeric highlightId, numeric rid) returnformat="JSON"
    {
        try {
            LOCAL.deleteHighlight = reportObject.deleteHighlight(highlightId);
            showHighlight(rid);
		}

		catch (any exception){
			error.errorLog(exception);
            LOCAL.errorData = [];
            return serializeJSON(LOCAL.errorData);
        }
    }

    /**
    * Function to update highlight data sortId.
    * @author R S Devi Prasad
    * @param number cid - report id of the report.
    * @param number rid - company id for which the report is made.
    * @param string data - data for the analytical overview field.
    * @return null.
    */

    remote function saveAnalysis(numeric id, numeric rid, any data) method="POST" {
        try {
            LOCAL.getData = reportObject.hasQuarterlyOverview(rid);
            if(getData.getResult().recordcount EQ 0)
                reportObject.setOverview(id, rid, data);
            else
                reportObject.updateOverview(id, rid, data);
        }

        catch (any exception) {
            error.errorLog(exception);
            return false;
        }
    }
}