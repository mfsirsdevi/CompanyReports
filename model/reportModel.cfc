/**
* File: userModel.cfc
* Author: Satyapriya Baral
* Path: model/userModel.cfc
* Purpose: contains functions to connect to the user database table.
* Date: 01-05-2017
*/

component {
    error = CreateObject("component", "log.error");	

    /**
    * Function to create a record of new user registered.
    *
    * @param string $username - contains name of the user.
    * @param string $email - contains email of the user.
    * @return - Returns boolian value if record created or not.
    */
    public struct function getReportViewData(numeric cid, numeric rid) {
        
		getQuery = new Query();
        try {
			getQuery.setSQL("SELECT [tbl_report].[str_title], [tbl_report].[str_summary], [tbl_company].[str_creditscore], [tbl_company].[str_address], [tbl_company].[str_phone], [tbl_company].[str_url], [tbl_company].[str_ceo], [tbl_company].[str_cfo]
            FROM [tbl_report_company]
            JOIN [tbl_company] ON [tbl_company].[int_companyid] = [tbl_report_company].[int_companyid]
            JOIN [tbl_report] ON [tbl_report].[int_reportid] = [tbl_report_company].[int_reportid]
            WHERE [tbl_company].[int_companyid] = :cid AND [tbl_report].[int_reportid] = :rid");
			getQuery.addParam( name = "cid", value = "#arguments.cid#", cfsqltype = "cf_sql_varchar" );
            getQuery.addParam( name = "rid", value = "#arguments.rid#", cfsqltype = "cf_sql_varchar" );
			qryResult = getQuery.execute();
			return qryResult;
		}
		
		catch (any exception){
			error.errorLog(exception);
			return {};
		}
    }

    /**
    * Function to add highlight Tags.
    * @author Satyapriya Baral
    * @param string tag - contains the list of tag.
    * @param string rid - contains the record Id.
    * @return struct of query executed
    */
    public any function addTag(string tag, string rid) 
    {
        try {
			createTag = new Query();
			createTag.setSQL("INSERT into dbo.tbl_report_automation_highlights (int_reportid, str_tags) VALUES (:rid, :tag)");
			createTag.addParam( name = "rid", value = "#arguments.rid#", cfsqltype = "cf_sql_varchar" );
			createTag.addParam( name = "tag", value = "#arguments.tag#", cfsqltype = "cf_sql_varchar" );
			result = createTag.execute();
            return result;
        }
        catch (any exception){
			error.errorLog(exception);
			return false;
		}
    }

    /**
    * Function to add highlight.
    * @author Satyapriya Baral
    * @param string subject - contains the content of subject.
    * @param string body - contains the content of body.
    * @param number sid - contains the sort id of record.
    * @param number id - contains the foreign key of highlight id. 
    * @return struct of query executed
    */
    public any function addHighlight(string subject, string body, numeric sid, numeric id) 
    {
        try {
			createHighlight = new Query();
			createHighlight.setSQL("INSERT into dbo.tbl_report_automation_highlights_section (int_highlight_id, str_subject, str_text, int_sortid) VALUES (:id, :subject, :body, :sortId)");
			createHighlight.addParam( name = "id", value = "#arguments.id#", cfsqltype = "cf_sql_varchar" );
            createHighlight.addParam( name = "subject", value = "#arguments.subject#", cfsqltype = "cf_sql_varchar" );
			createHighlight.addParam( name = "body", value = "#arguments.body#", cfsqltype = "cf_sql_varchar" );
            createHighlight.addParam( name = "sortId", value = "#arguments.sid#", cfsqltype = "cf_sql_varchar" );

			result = createHighlight.execute();
            return result;
        }
        catch (any exception){
			error.errorLog(exception);
			return false;
		}
    }

    /**
    * Function to get highlight data of specific record.
    * @author Satyapriya Baral
    * @param string id - contains the record Id.
    * @return struct of results found
    */
    public any function getHighlightData(numeric id) 
    {
        try {
			getHighlight = new Query();
			getHighlight.setSQL("SELECT [tbl_report_automation_highlights_section].[int_highlight_sec_id], [tbl_report_automation_highlights_section].[int_sortid], 
            [tbl_report_automation_highlights].[str_tags], [tbl_report_automation_highlights_section].[str_subject],
            [tbl_report_automation_highlights_section].[str_text] FROM [tbl_report_automation_highlights]
            JOIN [tbl_report_automation_highlights_section] ON [tbl_report_automation_highlights_section].[int_highlight_id] = [tbl_report_automation_highlights].[int_highlight_id]
            WHERE [tbl_report_automation_highlights].[int_reportid] = :id ORDER BY [tbl_report_automation_highlights_section].[int_sortid] DESC ");
			getHighlight.addParam( name = "id", value = "#arguments.id#", cfsqltype = "cf_sql_varchar" );
            result = getHighlight.execute();
            return result;
        }
        catch (any exception){
			error.errorLog(exception);
			return false;
		}
    }

    /**
    * Function to get all highlight data.
    * @author Satyapriya Baral
    * @param null.
    * @return struct of results found
    */
    public any function getTotalHighlight() 
    {
        try {
			getHighlight = new Query();
			getHighlight.setSQL("SELECT int_sortid, int_highlight_sec_id FROM tbl_report_automation_highlights_section");
            result = getHighlight.execute();
            return result;
		}
		
		catch (any exception){
			error.errorLog(exception);
            return false;
		}
    }

    /**
    * Function to update the sort order of the hilight data.
    * @author Satyapriya Baral
    * @param numeric newId - contains the new sort Id.
    * @param numeric oldId - contains the old sort Id.
    * @return struct of results found
    */
    public any function updateSortOrder(numeric newId, numeric oldId) 
    {
        try {
			updateSortOrder = new Query();
			updateSortOrder.setSQL("UPDATE tbl_report_automation_highlights_section SET int_sortid = :newId WHERE int_highlight_sec_id = :oldId");
            updateSortOrder.addParam( name = "newId", value = "#arguments.newId#", cfsqltype = "cf_sql_varchar" );
            updateSortOrder.addParam( name = "oldId", value = "#arguments.oldId#", cfsqltype = "cf_sql_varchar" );
            result = updateSortOrder.execute();
            return result;
		}

		catch (any exception){
			error.errorLog(exception);
            return false;
		}
    }
}