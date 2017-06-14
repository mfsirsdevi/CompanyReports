/**
* File: userModel.cfc
* Author: Satyapriya Baral
* Path: model/userModel.cfc
* Purpose: contains functions to connect to the user database table.
* Date: 01-05-2017
*/

component {
    include "../include/include.cfm";	

    /**
    * Function to create a record of new user registered.
    * @author R S Devi Prasad
    * @param numeric cid - company id for which the report is being generated.
    * @param numeric rid - report id of the company.
    * @return - Returns struct containing values of rows fetched from database.
    */
    public struct function getReportViewData(numeric cid, numeric rid) {

        LOCAL.getQuery = new Query();
        try {
            getQuery.setSQL("SELECT [tbl_report].[str_title], [tbl_report].[str_summary], [tbl_company].[str_creditscore], [tbl_company].[str_address], [tbl_company].[str_phone], [tbl_company].[str_url], [tbl_company].[str_ceo], [tbl_company].[str_cfo]
            FROM [tbl_report_company]
            JOIN [tbl_company] ON [tbl_company].[int_companyid] = [tbl_report_company].[int_companyid]
            JOIN [tbl_report] ON [tbl_report].[int_reportid] = [tbl_report_company].[int_reportid]
            WHERE [tbl_company].[int_companyid] = :cid AND [tbl_report].[int_reportid] = :rid");
            getQuery.addParam( name = "cid", value = "#arguments.cid#", cfsqltype = "cf_sql_varchar" );
            getQuery.addParam( name = "rid", value = "#arguments.rid#", cfsqltype = "cf_sql_varchar" );
            LOCAL.qryResult = getQuery.execute();
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
            LOCAL.createTag = new Query();
            createTag.setSQL("INSERT into dbo.tbl_report_automation_highlights (int_reportid, str_tags) VALUES (:rid, :tag)");
            createTag.addParam( name = "rid", value = "#arguments.rid#", cfsqltype = "cf_sql_varchar" );
            createTag.addParam( name = "tag", value = "#arguments.tag#", cfsqltype = "cf_sql_varchar" );
            LOCAL.result = createTag.execute();
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
            LOCAL.createHighlight = new Query();
            createHighlight.setSQL("INSERT into dbo.tbl_report_automation_highlights_section (int_highlight_id, str_subject, str_text, int_sortid) VALUES (:id, :subject, :body, :sortId)");
            createHighlight.addParam( name = "id", value = "#arguments.id#", cfsqltype = "cf_sql_varchar" );
            createHighlight.addParam( name = "subject", value = "#arguments.subject#", cfsqltype = "cf_sql_varchar" );
            createHighlight.addParam( name = "body", value = "#arguments.body#", cfsqltype = "cf_sql_varchar" );
            createHighlight.addParam( name = "sortId", value = "#arguments.sid#", cfsqltype = "cf_sql_varchar" );

			result = createHighlight.execute();
            return result.getResult();
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
            LOCAL.getHighlight = new Query();
            getHighlight.setSQL("SELECT [tbl_report_automation_highlights_section].[int_highlight_sec_id], [tbl_report_automation_highlights_section].[int_sortid],
            [tbl_report_automation_highlights].[str_tags], [tbl_report_automation_highlights_section].[str_subject],
            [tbl_report_automation_highlights_section].[str_text] FROM [tbl_report_automation_highlights]
            JOIN [tbl_report_automation_highlights_section] ON [tbl_report_automation_highlights_section].[int_highlight_id] = [tbl_report_automation_highlights].[int_highlight_id]
            WHERE [tbl_report_automation_highlights].[int_reportid] = :id ORDER BY [tbl_report_automation_highlights_section].[int_sortid] DESC ");
			getHighlight.addParam( name = "id", value = "#arguments.id#", cfsqltype = "cf_sql_varchar" );
            result = getHighlight.execute();
            return result.getResult();
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
            return result.getResult();
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
            LOCAL.updateSortOrder = new Query();
            updateSortOrder.setSQL("UPDATE tbl_report_automation_highlights_section SET int_sortid = :newId WHERE int_highlight_sec_id = :oldId");
            updateSortOrder.addParam( name = "newId", value = "#arguments.newId#", cfsqltype = "cf_sql_varchar" );
            updateSortOrder.addParam( name = "oldId", value = "#arguments.oldId#", cfsqltype = "cf_sql_varchar" );
            result = updateSortOrder.execute();
            return result.getResult();
		}

		catch (any exception){
			error.errorLog(exception);
            return false;
		}
    }

    /**
    * Function to delete a highlight data.
    * @author Satyapriya Baral
    * @param number highlightId - contains the highlight id.
    * @return null.
    */
    public any function deleteHighlight(highlightId)
    {
        try {
			deleteHighlight = new Query();
			deleteHighlight.setSQL("DELETE FROM tbl_report_automation_highlights_section WHERE int_highlight_sec_id = :highlightId ");
            deleteHighlight.addParam( name = "highlightId", value = "#arguments.highlightId#", cfsqltype = "cf_sql_varchar" );
            result = deleteHighlight.execute();
            return result.getResult();
		}

    public any function setOverview(numeric id, numeric rid, any data) {
        try {
            LOCAL.setQuery = new Query();
            setQuery.setSQL("INSERT INTO [dbo].[tbl_report_automation_analytical_overview]
           ([int_reportid]
           ,[str_text]
           ,[int_createdby]
           ,[dtm_createddate]
           ,[int_updatedby]
           ,[dtm_updateddate])
            VALUES
            (:rid
            ,:data
            ,:id
            ,GETDATE()
            ,:id
            ,GETDATE())");
            setQuery.addParam(name = "rid", value = "#arguments.rid#", cfsqltype = "cf_sql_varchar");
            setQuery.addParam(name = "data", value = "#arguments.data#", cfsqltype = "cf_sql_varchar");
            setQuery.addParam(name = "id", value = "#arguments.id#", cfsqltype = "cf_sql_varchar");
            LOCAL.result = setQuery.execute();
            return result;
        }
        catch (any exception) {
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to update record of new analytical overview.
    * @author R S Devi Prasad
    * @param numeric id - user id.
    * @param numeric rid - report id of the company.
    * @param any data - data of the analytical overiew of the company
    * @return - Returns struct containing values of rows fetched from database.
    */

    public any function updateOverview(numeric id, any data) {
        try {
            LOCAL.setQuery = new Query();
            setQuery.setSQL("UPDATE [dbo].[tbl_report_automation_analytical_overview]
            SET [str_text] = :data
            ,[int_updatedby] = :id
            ,[dtm_updateddate] = GETDATE()
            WHERE int_reportid = 8");
            setQuery.addParam(name = "data", value = "#arguments.data#", cfsqltype = "cf_sql_varchar");
            setQuery.addParam(name = "id", value = "#arguments.id#", cfsqltype = "cf_sql_varchar");
            LOCAL.result = setQuery.execute();
            return result;
        }
        catch (any exception) {
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to check whether there is a record in this quarter.
    * @author R S Devi Prasad
    * @param numeric id - report id of the company
    * @return - Returns struct containing values of rows fetched from database.
    */

    public struct function hasQuarterlyOverview(numeric id) {
        try {
            LOCAL.hasOverview = new Query();
            hasOverview.setSQL("SELECT int_analytical_overview_id, str_text
                FROM [dbo].[tbl_report_automation_analytical_overview]
                WHERE int_reportid = :id AND (SELECT DATEDIFF(QQ,dtm_createddate,GETDATE())) <= 1");
            hasOverview.addParam(name = "id", value = "#arguments.id#", cfsqltype = "cf_sql_varchar");
            LOCAL.result = hasOverview.execute();
            return result;
        }
        catch (any exception) {
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to check whether there is a record in previous quarter.
    * @author R S Devi Prasad
    * @param numeric id - report id of the company
    * @return - Returns struct containing values of rows fetched from database.
    */

    public struct function hasPreviousOverview(numeric id) {
        try {
            LOCAL.previousOverview = new Query();
            previousOverview.setSQL("SELECT int_analytical_overview_id, str_text
                FROM [dbo].[tbl_report_automation_analytical_overview]
                WHERE int_reportid = :id AND (SELECT DATEDIFF(QQ,dtm_createddate,GETDATE())) > 1 AND (SELECT DATEDIFF(QQ,dtm_createddate,GETDATE())) < 3");
            previousOverview.addParam(name = "id", value = "#arguments.id#", cfsqltype = "cf_sql_varchar");
            LOCAL.previousResult = previousOverview.execute();
            return previousResult;
        }
        catch (any exception) {
            error.errorLog(exception);
            return false;
        }
    }
}