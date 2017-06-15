/**
* File: companyModel.cfc
* Author: Satyapriya Baral
* Path: model/analystModel.cfc
* Purpose: contains functions to connect to the analyst database table.
* Date: 01-05-2017
*/
component {
    include "../include/include.cfm";
    /**
    * Function to get all company search data
    *
    * @param string searchText - contains the search text to be searched.
    * @param numeric selectAnalyst - contains the analyst id that is searched.
    * @return - Returns searched info details.
    */
	public query function companyDetailsSearch(string searchText, numeric selectAnalyst)
	{
		try {
			companyDetails = new Query();
			companyDetails.setSQL("SELECT int_companyid, str_companyname, str_analyst FROM dbo.tbl_company WHERE str_companyname LIKE :name AND int_analystid LIKE :analystId");
			companyDetails.addParam( name = "name", value = "%#ARGUMENTS.searchText#%", cfsqltype = "cf_sql_varchar" );
			if(ARGUMENTS.selectAnalyst EQ 0 || ARGUMENTS.selectAnalyst EQ "") {
				companyDetails.addParam( name = "analystId", value = "%%", cfsqltype = "cf_sql_varchar" );
			} else {
				companyDetails.addParam( name = "analystId", value = "#ARGUMENTS.selectAnalyst#", cfsqltype = "cf_sql_integer" );
			} 
			result = companyDetails.execute();
			return result.getResult();
		}
		
		catch (any exception){
			error.errorLog(exception);
			return false;
		}
	}

        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to get all company search data per page
    *
    * @param numeric start - contains the staring record of the page.
    * @param numeric end - contains the ending record of the page.
    * @param string search - contains the search text to be searched.
    * @param numeric selectAnalyst - contains the analyst id that is searched.
    * @return - Returns searched info details.
    */
    public any function companyPerPageSearch(numeric start, numeric end, string search, numeric selectAnalyst)
    {
        try {
            LOCAL.companyDetails = new Query();
            LOCAL.startIndex = ARGUMENTS.start - 1;
            companyDetails.setSQL("SELECT int_companyid, str_companyname, str_analyst FROM dbo.tbl_company WHERE str_companyname LIKE :search AND int_analystid LIKE :analystId ORDER BY int_companyid OFFSET #LOCAL.startIndex# ROWS FETCH NEXT 2 ROWS ONLY");
            companyDetails.addParam( name = "search", value = "%#ARGUMENTS.search#%", cfsqltype = "cf_sql_varchar" );
            if(ARGUMENTS.selectAnalyst EQ 0 || ARGUMENTS.selectAnalyst EQ "") {
                companyDetails.addParam( name = "analystId", value = "%%", cfsqltype = "cf_sql_varchar" );
            } else {
                companyDetails.addParam( name = "analystId", value = "%#ARGUMENTS.selectAnalyst#%", cfsqltype = "cf_sql_varchar" );
            }
            LOCAL.result = companyDetails.execute();
            return result;
        }

        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to get all report of the compant
    *
    * @param numeric companyId - contains the id of the company
    * @return - Returns query result of data.
    */
	public any function getReportId(numeric companyId)
	{
		try {
			reportDetails = new Query();
			reportDetails.setSQL("SELECT int_companyid, int_reportid FROM dbo.tbl_report_company WHERE int_companyid = :companyId");
			reportDetails.addParam( name = "companyId", value = "#ARGUMENTS.companyId#", cfsqltype = "cf_sql_varchar" ); 
			result = reportDetails.execute();
			return result.getResult();
		}
		
		catch (any exception){
			error.errorLog(exception);
			return false;
		}
	}
}