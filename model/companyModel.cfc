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
			errorData = queryNew("error, varchar");
            return errorData;
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
    public query function companyPerPageSearch(required numeric start, required numeric end, string search, numeric selectAnalyst)
    {
        try {
            LOCAL.companyDetails = new Query();
            LOCAL.startIndex = ARGUMENTS.start - 1;
            LOCAL.companyDetails.setSQL("SELECT int_companyid, str_companyname, str_analyst FROM dbo.tbl_company WHERE str_companyname LIKE :search AND int_analystid LIKE :analystId ORDER BY int_companyid OFFSET #LOCAL.startIndex# ROWS FETCH NEXT 2 ROWS ONLY");
            LOCAL.companyDetails.addParam( name = "search", value = "%#ARGUMENTS.search#%", cfsqltype = "cf_sql_varchar" );
            if(ARGUMENTS.selectAnalyst EQ 0 || ARGUMENTS.selectAnalyst EQ "") {
                LOCAL.companyDetails.addParam( name = "analystId", value = "%%", cfsqltype = "cf_sql_varchar" );
            } else {
                LOCAL.companyDetails.addParam( name = "analystId", value = "%#ARGUMENTS.selectAnalyst#%", cfsqltype = "cf_sql_varchar" );
            }
            LOCAL.result = LOCAL.companyDetails.execute();
            return result.getResult();
        }

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
            return LOCAL.errorData;
        }
    }

    /**
    * Function to get all report of the compant
    *
    * @param numeric companyId - contains the id of the company
    * @return - Returns query result of data.
    */
	public query function getReportId(required numeric companyId)
	{
		try {
			LOCAL.reportDetails = new Query();
			LOCAL.reportDetails.setSQL("SELECT int_companyid, int_reportid FROM dbo.tbl_report_company WHERE int_companyid = :companyId");
			LOCAL.reportDetails.addParam( name = "companyId", value = "#ARGUMENTS.companyId#", cfsqltype = "cf_sql_varchar" ); 
			LOCAL.result = LOCAL.reportDetails.execute();
			return LOCAL.result.getResult();
		}
		
		catch (any exception){
			error.errorLog(exception);
			LOCAL.errorData = queryNew("error, varchar");
            return LOCAL.errorData;
		}
	}

    /**
    * Function to add credit facility details
    * @author Satyapriya Baral
    *
    * @param struct formData - contains all data of the form that is submitted.
    * @param struct textareaData - contains all data of tinymce that are submitted.
    * @return - Returns query result of data.
    */
    public struct function addCreditFacility(required struct formData, required struct textareaData)
    {
        try {
            LOCAL.newRecord = new Query();
            LOCAL.newRecord.setSQL("INSERT into dbo.revolvingcreditfacility (int_companyid, original_facility_date, maturity_date, letter_of_credit_sublimit, letter_of_credit_sublimit_currency_id, maximum_borrowings, maximum_borrowings_currency_id, Availbility, availability_currency_id, interest_rate_type, interest_rate, interest_rate_low, interest_rate_high, security, availability_date, availability_period_duration, availability_non_quarter_end_period_duration, availability_comment, interest_rate_comment, security_comment, borrowing_base, comments) VALUES (:companyID, :originalFacilityDate, :maturityDate, :letterOfCreditSublimit, :letterOfCreditSublimitCurrencyId, :maximumBorrowings, :maximumBorrowingsCurrencyId, :availability, :availabilityCurrencyId, :interestRateType, :interestRate, :interestRateLow, :interestRateHigh, :security, :availabilityDate, :availabilityDateType, :availabilityNonQuarterEndPeriodDuration, :availabilityComment, :interestComment, :securityComment, :borrowingBase, :creditFacilityComment)");
            LOCAL.newRecord.addParam( name = "companyID", value = "#ARGUMENTS.formData.companyID#", cfsqltype = "cf_sql_integer" );
            LOCAL.newRecord.addParam( name = "originalFacilityDate", value = "#ARGUMENTS.formData.originalFacilityDate#", cfsqltype = "cf_sql_date" );
            LOCAL.newRecord.addParam( name = "maturityDate", value = "#ARGUMENTS.formData.maturityDate#", cfsqltype = "cf_sql_date" );
            LOCAL.newRecord.addParam( name = "letterOfCreditSublimit", value = "#ARGUMENTS.formData.letterOfCreditSublimit#", null="#YesNoFormat(!Len(ARGUMENTS.formData.letterOfCreditSublimit))#", cfsqltype = "cf_sql_float" );
            LOCAL.newRecord.addParam( name = "letterOfCreditSublimitCurrencyId", value = "#ARGUMENTS.formData.letterOfCreditSublimitCurrencyId#", cfsqltype = "cf_sql_integer" );
            LOCAL.newRecord.addParam( name = "maximumBorrowings", value = "#ARGUMENTS.formData.maximumBorrowings#", null="#YesNoFormat(!Len(ARGUMENTS.formData.maximumBorrowings))#", cfsqltype = "cf_sql_float" );
            LOCAL.newRecord.addParam( name = "maximumBorrowingsCurrencyId", value = "#ARGUMENTS.formData.maximumBorrowingsCurrencyId#", cfsqltype = "cf_sql_integer" );
            LOCAL.newRecord.addParam( name = "availability", value = "#ARGUMENTS.formData.availability#", null="#YesNoFormat(!Len(ARGUMENTS.formData.availability))#", cfsqltype = "cf_sql_float" );
            LOCAL.newRecord.addParam( name = "availabilityCurrencyId", value = "#ARGUMENTS.formData.availabilityCurrencyId#", cfsqltype = "cf_sql_integer" );
            LOCAL.newRecord.addParam( name = "interestRateType", value = "#ARGUMENTS.formData.interestRateType#", cfsqltype = "cf_sql_varchar" );
            LOCAL.newRecord.addParam( name = "interestRate", value = "#ARGUMENTS.formData.interestRate[2]#", null="#YesNoFormat(!Len(ARGUMENTS.formData.interestRate[2]))#", cfsqltype = "cf_sql_float" );
            LOCAL.newRecord.addParam( name = "interestRateLow", value = "#ARGUMENTS.formData.interestRateLow#", null="#YesNoFormat(!Len(ARGUMENTS.formData.interestRateLow))#", cfsqltype = "cf_sql_float");
            LOCAL.newRecord.addParam( name = "interestRateHigh", value = "#ARGUMENTS.formData.interestRateHigh#", null="#YesNoFormat(!Len(ARGUMENTS.formData.interestRateHigh))#", cfsqltype = "cf_sql_float" );
            LOCAL.newRecord.addParam( name = "security", value = "#ARGUMENTS.formData.security#", cfsqltype = "cf_sql_varchar" );
            LOCAL.newRecord.addParam( name = "availabilityDate", value = "#ARGUMENTS.formData.availabilityDate#", cfsqltype = "cf_sql_date" );
            LOCAL.newRecord.addParam( name = "availabilityDateType", value = "#ARGUMENTS.formData.availabilityDateType#", cfsqltype = "cf_sql_varchar" );
            LOCAL.newRecord.addParam( name = "availabilityNonQuarterEndPeriodDuration", value = "#ARGUMENTS.formData.availabilityNonQuarterEndPeriodDuration#", cfsqltype = "cf_sql_varchar" );
            LOCAL.newRecord.addParam( name = "availabilityComment", value = "#ARGUMENTS.textareaData.availabilityComment#", cfsqltype = "cf_sql_varchar" );
            LOCAL.newRecord.addParam( name = "interestComment", value = "#ARGUMENTS.textareaData.interestComment#", cfsqltype = "cf_sql_varchar" );
            LOCAL.newRecord.addParam( name = "securityComment", value = "#ARGUMENTS.textareaData.securityComment#", cfsqltype = "cf_sql_varchar" );
            LOCAL.newRecord.addParam( name = "borrowingBase", value = "#ARGUMENTS.textareaData.borrowingBase#", cfsqltype = "cf_sql_varchar" );
            LOCAL.newRecord.addParam( name = "creditFacilityComment", value = "#ARGUMENTS.textareaData.creditFacilityComment#", cfsqltype = "cf_sql_varchar" );
            LOCAL.result = LOCAL.newRecord.execute();
            return LOCAL.result;
        }
        
        catch (any exception){
            error.errorLog(exception);
            return {};
        }
    }

    /**
    * Function to add lenders
    * @author Satyapriya Baral
    *
    * @param array lenders - contains all data of all lenders.
    * @param numeric id - contains the id of the credit facility record.
    * @return - Returns boolean value of true or false.
    */
    public boolean function addLenders(required array lenders, required numeric id)
    {
        try {
            LOCAL.lenth = ArrayLen(ARGUMENTS.lenders);
            for(i=1; i<=LOCAL.lenth; i++) {
                LOCAL.newRecord = new Query();
                LOCAL.newRecord.setSQL("INSERT into dbo.tbl_lenders (rcf_id, str_lenders) VALUES (:id, :lender)");
                LOCAL.newRecord.addParam( name = "id", value = "#ARGUMENTS.id#", cfsqltype = "cf_sql_integer" );
                LOCAL.newRecord.addParam( name = "lender", value = "#ARGUMENTS.lenders[i]#", cfsqltype = "cf_sql_varchar" );
                LOCAL.result = LOCAL.newRecord.execute();
            }
            return true;
        }
        
        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to add amendment date
    * @author Satyapriya Baral
    *
    * @param array amendment - contains all data of amendment date.
    * @param numeric id - contains the id of the credit facility record.
    * @return - Returns boolean value of true or false.
    */
    public boolean function addAmendment(required array amendment, required numeric id)
    {
        try {
            LOCAL.lenth = ArrayLen(ARGUMENTS.amendment);
            for(i=1; i<=LOCAL.lenth; i++) {
                LOCAL.newRecord = new Query();
                LOCAL.newRecord.setSQL("INSERT into dbo.tbl_amendment (rcf_id, date_amendment) VALUES (:id, :amendment)");
                LOCAL.newRecord.addParam( name = "id", value = "#ARGUMENTS.id#", cfsqltype = "cf_sql_integer" );
                LOCAL.newRecord.addParam( name = "amendment", value = "#ARGUMENTS.amendment[i]#", cfsqltype = "cf_sql_date" );
                LOCAL.result = LOCAL.newRecord.execute();
            }
            return true;
        }
        
        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to add agent bank
    * @author Satyapriya Baral
    *
    * @param array agentBank - contains all data of agent bank.
    * @param numeric id - contains the id of the credit facility record.
    * @return - Returns boolean value of true or false.
    */
    public boolean function addAgentBank(required array agentBank, required numeric id)
    {
        try {
            LOCAL.lenth = ArrayLen(ARGUMENTS.agentBank);
            for(i=1; i<=LOCAL.lenth; i++) {
                LOCAL.newRecord = new Query();
                LOCAL.newRecord.setSQL("INSERT into dbo.tbl_agent_bank (rcf_id, str_agent_bank) VALUES (:id, :agentBank)");
                LOCAL.newRecord.addParam( name = "id", value = "#ARGUMENTS.id#", cfsqltype = "cf_sql_integer" );
                LOCAL.newRecord.addParam( name = "agentBank", value = "#ARGUMENTS.agentBank[i]#", cfsqltype = "cf_sql_varchar" );
                LOCAL.result = LOCAL.newRecord.execute();
            }
            return true;
        }
        
        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to add simultaneous financial convenants
    * @author Satyapriya Baral
    *
    * @param array simultaneous - contains all data of simultaneous financial convenants.
    * @param numeric id - contains the id of the credit facility record.
    * @return - Returns boolean value of true or false.
    */
    public boolean function addSimultaneous(required array simultaneous, required numeric id)
    {
        try {
            LOCAL.lenth = ArrayLen(ARGUMENTS.simultaneous);
            for(i=1; i<=LOCAL.lenth; i++) {
                LOCAL.newRecord = new Query();
                LOCAL.newRecord.setSQL("INSERT into dbo.tbl_simultaneous_financial_convenants (rcf_id, str_convenants) VALUES (:id, :simultaneous)");
                LOCAL.newRecord.addParam( name = "id", value = "#ARGUMENTS.id#", cfsqltype = "cf_sql_integer" );
                LOCAL.newRecord.addParam( name = "simultaneous", value = "#ARGUMENTS.simultaneous[i]#", cfsqltype = "cf_sql_varchar" );
                LOCAL.result = LOCAL.newRecord.execute();
            }
            return true;
        }
        
        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to add financial convenants
    * @author Satyapriya Baral
    *
    * @param array financial - contains all data of financial convenants.
    * @param numeric id - contains the id of the credit facility record.
    * @return - Returns boolean value of true or false.
    */
    public boolean function addFinancial(required array financial, required numeric id)
    {
        try {
            LOCAL.lenth = ArrayLen(ARGUMENTS.financial);
            for(i=1; i<=LOCAL.lenth; i++) {
                LOCAL.newRecord = new Query();
                LOCAL.newRecord.setSQL("INSERT into dbo.tbl_financial_convenants (rcf_id, str_financial_convenants_data) VALUES (:id, :financial)");
                LOCAL.newRecord.addParam( name = "id", value = "#ARGUMENTS.id#", cfsqltype = "cf_sql_integer" );
                LOCAL.newRecord.addParam( name = "financial", value = "#ARGUMENTS.financial[i]#", cfsqltype = "cf_sql_varchar" );
                LOCAL.result = LOCAL.newRecord.execute();
            }
            return true;
        }
        
        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to get all data of credit facility columns
    * @author Satyapriya Baral
    *
    * @param null.
    * @return - Returns query result of data found
    */
    public query function getCreditFacilityColumns()
    {
        try {
            LOCAL.getRecords = new Query();
            LOCAL.getRecords.setSQL("SELECT int_cf_id, str_credit_facility_columns, str_column_names FROM dbo.tbl_credit_facility_columns"); 
            LOCAL.result = LOCAL.getRecords.execute();
            return LOCAL.result.getResult();
        }
        
        catch (any exception){
            error.errorLog(exception);
            errorData = queryNew("error, varchar");
            return errorData;
        }
    }

    /**
    * Function to add sortId to all columns of credit facility
    * @author Satyapriya Baral
    *
    * @param query columnDetails - contains all details of the columns
    * @param numeric id - contains the id of the credit facility record.
    * @return - Returns boolean value of true or false.
    */
    public boolean function addSortId(required query columnDetails, required numeric id, required numeric companyId)
    {
        try {
            LOCAL.lenth = ARGUMENTS.columnDetails.recordCount;
            for(i=1; i<=LOCAL.lenth; i++) {
                LOCAL.newRecord = new Query();
                LOCAL.newRecord.setSQL("INSERT into dbo.tbl_cf_sort (int_cf_id, int_cf_sort_id, int_cf_costomize_sort_id, rcf_id, int_companyid) VALUES (:cfId, :sortId, :customizeId, :recId, :companyId)");
                LOCAL.newRecord.addParam( name = "cfId", value = "#ARGUMENTS.columnDetails.int_cf_id[i]#", cfsqltype = "cf_sql_integer" );
                LOCAL.newRecord.addParam( name = "sortId", value = "#i#", cfsqltype = "cf_sql_integer" );
                LOCAL.newRecord.addParam( name = "customizeId", value = 1, cfsqltype = "cf_sql_integer" );
                LOCAL.newRecord.addParam( name = "recId", value = "#ARGUMENTS.id#", cfsqltype = "cf_sql_integer" );
                LOCAL.newRecord.addParam( name = "companyId", value = "#ARGUMENTS.companyId#", cfsqltype = "cf_sql_integer" );
                LOCAL.result = LOCAL.newRecord.execute();
            }
            return true;
        }
        
        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to get credit facility data
    * @author Satyapriya Baral
    * @param numeric cid - contains the id of the company
    * @return - Returns query result of data.
    */

    public query function getCreditFacilityData(required numeric cid) 
    {
        try {
            LOCAL.getRecord = new Query();
            LOCAL.getRecord.setSQL("SELECT rcf_id, int_companyid, original_facility_date, maturity_date, letter_of_credit_sublimit, letter_of_credit_sublimit_currency_id, maximum_borrowings, maximum_borrowings_currency_id, Availbility, availability_currency_id, interest_rate_type, interest_rate, interest_rate_low, interest_rate_high, security, availability_date, availability_period_duration, availability_non_quarter_end_period_duration, availability_comment, interest_rate_comment, security_comment, borrowing_base, comments FROM dbo.revolvingcreditfacility WHERE int_companyid = :companyId");
            LOCAL.getRecord.addParam( name = "companyID", value = "#ARGUMENTS.cid#", cfsqltype = "cf_sql_integer" );
            LOCAL.result = LOCAL.getRecord.execute();
            return LOCAL.result.getResult();
        } 

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
            return LOCAL.errorData;
        }
    }

    /**
    * Function to get sort details of respective record
    * @author Satyapriya Baral
    * @param numeric rcfid - contains the rcfid of the record
    * @return - Returns query result of data.
    */

    public query function getSortDetails(required numeric rcfId) 
    {
        try {
            LOCAL.getRecord = new Query();
            LOCAL.getRecord.setSQL("SELECT int_sort_credit_id, int_cf_id, int_cf_sort_id, int_cf_costomize_sort_id, rcf_id, int_companyid FROM dbo.tbl_cf_sort WHERE rcf_id = :rcfId ORDER BY int_cf_sort_id ASC");
            LOCAL.getRecord.addParam( name = "rcfId", value = "#ARGUMENTS.rcfId#", cfsqltype = "cf_sql_integer" );
            LOCAL.result = LOCAL.getRecord.execute();
            return LOCAL.result.getResult();
        }  

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
            return LOCAL.errorData;
        }
    }

        /**
    * Function to get amendment details of perticular record
    * @author Satyapriya Baral
    * @return - Returns query result of data.
    */

    public query function getAmendment(required numeric rcfid) 
    {
        try {
            LOCAL.getRecord = new Query();
            LOCAL.getRecord.setSQL("SELECT date_amendment FROM dbo.tbl_amendment WHERE rcf_id = :rcfid");
            LOCAL.getRecord.addParam( name = "rcfid", value = "#ARGUMENTS.rcfid#", cfsqltype = "cf_sql_integer" );
            LOCAL.result = LOCAL.getRecord.execute();
            return LOCAL.result.getResult();
        } 

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
            return LOCAL.errorData;
        }
    }

    /**
    * Function to get all column details
    * @author Satyapriya Baral
    * @return - Returns query result of data.
    */

    public query function getLenders(required numeric rcfid) 
    {
        try {
            LOCAL.getRecord = new Query();
            LOCAL.getRecord.setSQL("SELECT str_lenders FROM dbo.tbl_lenders WHERE rcf_id = :rcfid");
            LOCAL.getRecord.addParam( name = "rcfid", value = "#ARGUMENTS.rcfid#", cfsqltype = "cf_sql_integer" );
            LOCAL.result = LOCAL.getRecord.execute();
            return LOCAL.result.getResult();
        } 

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
            return LOCAL.errorData;
        }
    }

    /**
    * Function to get all column details
    * @author Satyapriya Baral
    * @return - Returns query result of data.
    */

    public query function getAgentBank(required numeric rcfid) 
    {
        try {
            LOCAL.getRecord = new Query();
            LOCAL.getRecord.setSQL("SELECT str_agent_bank FROM dbo.tbl_agent_bank WHERE rcf_id = :rcfid");
            LOCAL.getRecord.addParam( name = "rcfid", value = "#ARGUMENTS.rcfid#", cfsqltype = "cf_sql_integer" );
            LOCAL.result = LOCAL.getRecord.execute();
            return LOCAL.result.getResult();
        } 

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
            return LOCAL.errorData;
        }
    }

    /**
    * Function to get all column details
    * @author Satyapriya Baral
    * @return - Returns query result of data.
    */

    public query function getConvenants(required numeric rcfid) 
    {
        try {
            LOCAL.getRecord = new Query();
            LOCAL.getRecord.setSQL("SELECT str_convenants FROM dbo.tbl_simultaneous_financial_convenants WHERE rcf_id = :rcfid");
            LOCAL.getRecord.addParam( name = "rcfid", value = "#ARGUMENTS.rcfid#", cfsqltype = "cf_sql_integer" );
            LOCAL.result = LOCAL.getRecord.execute();
            return LOCAL.result.getResult();
        } 

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
            return LOCAL.errorData;
        }
    }

    /**
    * Function to get all column details
    * @author Satyapriya Baral
    * @return - Returns query result of data.
    */

    public query function getFinancialConvenants(required numeric rcfid) 
    {
        try {
            LOCAL.getRecord = new Query();
            LOCAL.getRecord.setSQL("SELECT str_financial_convenants_data FROM dbo.tbl_financial_convenants WHERE rcf_id = :rcfid");
            LOCAL.getRecord.addParam( name = "rcfid", value = "#ARGUMENTS.rcfid#", cfsqltype = "cf_sql_integer" );
            LOCAL.result = LOCAL.getRecord.execute();
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
    public struct function updateSortOrder(required numeric newId, required numeric oldId)
    {
        try {
            LOCAL.updateSortOrder = new Query();
            LOCAL.updateSortOrder.setSQL("UPDATE tbl_cf_sort SET int_cf_sort_id = :newId WHERE int_sort_credit_id = :oldId");
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

}