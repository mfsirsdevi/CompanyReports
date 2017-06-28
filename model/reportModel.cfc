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
    public struct function addTag(string tag, required string rid)
    {
        try {
            LOCAL.createTag = new Query();
            LOCAL.createTag.setSQL("INSERT into dbo.tbl_report_automation_highlights (int_reportid, str_tags) VALUES (:rid, :tag)");
            LOCAL.createTag.addParam( name = "rid", value = "#ARGUMENTS.rid#", cfsqltype = "cf_sql_integer" );
            LOCAL.createTag.addParam( name = "tag", value = "#ARGUMENTS.tag#", cfsqltype = "cf_sql_varchar" );
            LOCAL.result = LOCAL.createTag.execute();
            return LOCAL.result;
        }
        catch (any exception){
            error.errorLog(exception);
			return {};
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
    public struct function addHighlight(string subject, string body, required numeric sid, required numeric id)
    {
        try {
            LOCAL.createHighlight = new Query();
            LOCAL.createHighlight.setSQL("INSERT into dbo.tbl_report_automation_highlights_section (int_highlight_id, str_subject, str_text, int_sortid) VALUES (:id, :subject, :body, :sortId)");
            LOCAL.createHighlight.addParam( name = "id", value = "#ARGUMENTS.id#", cfsqltype = "cf_sql_integer" );
            LOCAL.createHighlight.addParam( name = "subject", value = "#ARGUMENTS.subject#", cfsqltype = "cf_sql_varchar" );
            LOCAL.createHighlight.addParam( name = "body", value = "#ARGUMENTS.body#", cfsqltype = "cf_sql_varchar" );
            LOCAL.createHighlight.addParam( name = "sortId", value = "#ARGUMENTS.sid#", cfsqltype = "cf_sql_integer" );
			LOCAL.result = LOCAL.createHighlight.execute();
            return LOCAL.result;
        }
        catch (any exception){
            error.errorLog(exception);
			return {};
        }
    }

    /**
    * Function to get highlight data of specific record.
    * @author Satyapriya Baral
    * @param string id - contains the record Id.
    * @return struct of results found
    */
    public query function getHighlightData(required numeric id)
    {
        try {
            LOCAL.getHighlight = new Query();
            LOCAL.getHighlight.setSQL("SELECT [tbl_report_automation_highlights_section].[int_highlight_sec_id], [tbl_report_automation_highlights_section].[int_sortid],
            [tbl_report_automation_highlights].[str_tags], [tbl_report_automation_highlights_section].[str_subject],
            [tbl_report_automation_highlights_section].[str_text] FROM [tbl_report_automation_highlights]
            JOIN [tbl_report_automation_highlights_section] ON [tbl_report_automation_highlights_section].[int_highlight_id] = [tbl_report_automation_highlights].[int_highlight_id]
            WHERE [tbl_report_automation_highlights].[int_reportid] = :id ORDER BY [tbl_report_automation_highlights_section].[int_sortid] DESC ");
			LOCAL.getHighlight.addParam( name = "id", value = "#ARGUMENTS.id#", cfsqltype = "cf_sql_integer" );
            LOCAL.result = LOCAL.getHighlight.execute();
            return LOCAL.result.getResult();
        }
        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
			return LOCAL.errorData;
        }
    }

    /**
    * Function to get all highlight data.
    * @author Satyapriya Baral
    * @param null.
    * @return struct of results found
    */
    public query function getTotalHighlight()
    {
        try {
			LOCAL.getHighlight = new Query();
			LOCAL.getHighlight.setSQL("SELECT int_sortid, int_highlight_sec_id FROM tbl_report_automation_highlights_section");
            LOCAL.result = LOCAL.getHighlight.execute();
            return LOCAL.result.getResult();
		}

		catch (any exception){
			error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
			return LOCAL.errorData;
        }
    }

    /**
    * Function to update the sort order of the hilight data.
    * @author Satyapriya Baral
    * @param numeric newId - contains the new sort Id.
    * @param numeric oldId - contains the old sort Id.
    * @return struct of results found
    */
    public struct function updateSortOrder(numeric newId, numeric oldId)
    {
        try {
            LOCAL.updateSortOrder = new Query();
            LOCAL.updateSortOrder.setSQL("UPDATE tbl_report_automation_highlights_section SET int_sortid = :newId WHERE int_highlight_sec_id = :oldId");
            LOCAL.updateSortOrder.addParam( name = "newId", value = "#arguments.newId#", cfsqltype = "cf_sql_varchar" );
            LOCAL.updateSortOrder.addParam( name = "oldId", value = "#arguments.oldId#", cfsqltype = "cf_sql_varchar" );
            LOCAL.result = LOCAL.updateSortOrder.execute();
            return LOCAL.result;
		}

		catch (any exception){
			error.errorLog(exception);
			return {};
		}
    }

    /**
    * Function to delete a highlight data.
    * @author Satyapriya Baral
    * @param number highlightId - contains the highlight id.
    * @return null.
    */
    public struct function deleteHighlight(highlightId)
    {
        try {
			LOCAL.deleteHighlight = new Query();
			LOCAL.deleteHighlight.setSQL("DELETE FROM tbl_report_automation_highlights_section WHERE int_highlight_sec_id = :highlightId ");
            LOCAL.deleteHighlight.addParam( name = "highlightId", value = "#arguments.highlightId#", cfsqltype = "cf_sql_varchar" );
            LOCAL.result = LOCAL.deleteHighlight.execute();
            return LOCAL.result;
		}
		catch (any exception){
			error.errorLog(exception);
			return {};
		}
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

    public any function updateOverview(numeric id, numeric rid, any data) {
        try {
            LOCAL.setQuery = new Query();
            setQuery.setSQL("UPDATE [dbo].[tbl_report_automation_analytical_overview]
            SET [str_text] = :data
            ,[int_updatedby] = :id
            ,[dtm_updateddate] = GETDATE()
            WHERE int_reportid = :rid");
            setQuery.addParam(name = "data", value = "#arguments.data#", cfsqltype = "cf_sql_varchar");
            setQuery.addParam(name = "id", value = "#arguments.id#", cfsqltype = "cf_sql_integer");
            setQuery.addParam(name = "rid", value = "#arguments.rid#", cfsqltype = "cf_sql_integer");
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

    /**
    * Function to retrieve the period ranges
    * @author Chandra Sekhar Sahoo
    * @param reportid - the reportid for which to fetch the dates.
    * @return - Returns struct containing values of periods and bit value of hidden fields
    */

    public query function getPeriods(required numeric reportid) {
        try {
            LOCAL.periods = new Query();
            LOCAL.periods.addParam(name="reportid", value="#arguments.reportid#", cfsqltype="cf_sql_integer");
            LOCAL.periods.setSQL("SELECT tfp.int_period_id, tfp.dte_period_end_dt, tfp.bit_hidden, tfdn.num_metric_value
                                    FROM dbo.tbl_fa_period tfp
                                    INNER JOIN dbo.tbl_fa_data_numeric tfdn
                                    ON tfdn.int_period_id = tfp.int_period_id
                                    WHERE tfp.int_reportid = :reportid");
            LOCAL.results = LOCAL.periods.execute().getResult();
            return LOCAL.results;
        }
        catch(any e){
            error.errorLog(e);
            // rethrow;
            return queryNew("error, varchar");
        }
    }


    /**
    * Function to update the hidden fields in chart / save chart preferences
    * @author Chandra Sekhar Sahoo
    * @param hidden_dates(array) - contains the rows that are not to be shown in chart/ set hidden fileds to 1 (true)
    * @param not_hidden_dates(array) - contains the rows that are shown chart/ set bit_hidden field to 0 (false)
    * @return - boolean true or false
    */

    public boolean function updateChartPref(required string hidden_dates, required string not_hidden_dates) {
        try {
            LOCAL.not_hidden_dates = arrayToList(deserializeJSON(ARGUMENTS.not_hidden_dates));
            LOCAL.hidden_dates =   arrayToList(deserializeJSON(ARGUMENTS.hidden_dates));

            LOCAL.prefx = new Query();
            LOCAL.prefx.addParam( name="nhd", value="#LOCAL.not_hidden_dates#", cfsqltype="cf_sql_integer", list="yes");
            LOCAL.prefx.setSQL("UPDATE dbo.tbl_fa_period
                                SET bit_hidden = 0
                                WHERE int_period_id IN (:nhd)");
            LOCAL.prefx.execute().getResult();

            LOCAL.prefy = new Query();
            LOCAL.prefy.addParam( name="hd", value="#LOCAL.hidden_dates#", cfsqltype="cf_sql_integer", list="yes" );
            LOCAL.prefy.setSQL("UPdATE dbo.tbl_fa_period
                                SET bit_hidden = 1
                                WHERE int_period_id IN (:hd)");
            LOCAL.prefy.execute().getResult();
            return true;
        }
        catch(any exception) {
            error.errorLog(e);
            return false;
        }
    }


    /**
    * Function to save the chart vAxis(vertical axis , min max interval between ticks etc..) values
    * @author chandra sekhar sahoo
    * @param min - minimum value on the vAxis
    * @param max - maximum value on the vAxis
    * @return boolean - true|false if operation successful or not.
    */

    public boolean function setChartvAxisValues(numeric cid, required numeric rid, required numeric min, required numeric max, required numeric interval) {
        try{
            LOCAL.pref = new Query();
            LOCAL.pref.addParam(name="cid", value="#ARGUMENTS.cid#", cfsqltype="cf_sql_integer");
            LOCAL.pref.addParam(name="rid", value="#ARGUMENTS.rid#", cfsqltype="cf_sql_integer");
            LOCAL.pref.addParam(name="min", value="#ARGUMENTS.min#", cfsqltype="cf_sql_integer");
            LOCAL.pref.addParam(name="max", value="#ARGUMENTS.max#", cfsqltype="cf_sql_integer");
            LOCAL.pref.addParam(name="interval", value="#ARGUMENTS.interval#", cfsqltype="cf_sql_integer");
            LOCAL.pref.setSQL("INSERT INTO dbo.tbl_fa_chart_preferences  
                                        (int_companyid, int_reportid, int_vAxis_min, int_vAxis_max, int_vAxis_interval)
                                VALUES  (:cid, :rid, :min, :max, :interval)
                                ");
        }
        catch(any exception){
            error.errorLog(exception);
            return false;
        }
    }
}
