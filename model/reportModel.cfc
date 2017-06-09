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
}