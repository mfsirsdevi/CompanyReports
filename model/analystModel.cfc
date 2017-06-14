/**
* File: analystModel.cfc
* Author: Satyapriya Baral
* Path: model/analystModel.cfc
* Purpose: contains functions to connect to the analyst database table.
* Date: 01-05-2017
*/
component {
    include "../include/include.cfm";

    /**
    * Function to get all analyst Data.
    *
    * @param null
    * @return - Returns object of all data found.
    */
    public any function analystDetails()
    {
        try {
            LOCAL.analystDetails = new Query();
            analystDetails.setSQL("SELECT int_analystid, str_analyst, str_mail, str_phone, bit_active FROM dbo.tbl_analyst");
            LOCAL.result = analystDetails.execute();
            return result;
        }

        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to get analyst Data of specific company.
    * @author R S Devi Prasad
    * @param cid - company id of the company
    * @return - Returns object of analyst data found.
    */

    public any function getAnalyst(numeric cid) {
        try {
            LOCAL.fetchAnalyst = new Query();
            fetchAnalyst.setSQL("SELECT [tbl_analyst].[str_analyst], [tbl_analyst].[str_phone] FROM [tbl_company] JOIN [tbl_analyst] ON [tbl_analyst].[int_analystid] = [tbl_company].[int_analystid] WHERE [tbl_company].[int_companyid] = :cid");
            fetchAnalyst.addParam( name = "cid", value = "#arguments.cid#", cfsqltype = "cf_sql_varchar" );
            LOCAL.result = fetchAnalyst.execute();
            return result;
        }

        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }
}