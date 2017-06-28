/**
* File: companyController.cfc
* Author: Satyapriya Baral
* Path: model/companyController.cfc
* Purpose: contains functions interacting with bdatabase.
* Date: 01-05-2017
*/
component {

    analystObject = CreateObject("component", "model.analystModel");
    companyObject = CreateObject("component", "model.companyModel");
    include "../include/include.cfm";

    /**
    * Function to get the all analyst details.
    *
    * @param null.
    * @return - Returns userinfo details.
    */
    public query function analystDetails()
    {
        try {
            LOCAL.analystInfo = analystObject.analystDetails();
            return LOCAL.analystInfo;
        }

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
			return LOCAL.errorData;
        }
    }

    /**
    * Function to get all company search data
    *
    * @param string searchText - contains the search text to be searched.
    * @param numeric selectAnalyst - contains the analyst id that is searched.
    * @return - Returns searched info details.
    */
    public query function companySearch(string searchText, numeric selectAnalyst)
    {
        try {
            LOCAL.searchInfo = companyObject.companyDetailsSearch(searchText, selectAnalyst);
            return LOCAL.searchInfo;
        }

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
			return LOCAL.errorData;
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
    public query function companyPerPage(required numeric start, required numeric end, string search, numeric selectAnalyst)
    {
        try {
            LOCAL.searchInfo = companyObject.companyPerPageSearch(start, end, search, selectAnalyst);
            return LOCAL.searchInfo;
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
            LOCAL.reportInfo = companyObject.getReportId(companyId);
            return LOCAL.reportInfo;
        }

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
			return LOCAL.errorData;
        }
    }

    /**
    * Function to get analyst data of the company
    * @author R S Devi Prasad
    * @param numeric cid - contains the id of the company
    * @return - Returns query result of data.
    */

    public any function getAnalyst(required numeric cid) {
        try {
            return analystObject.getAnalyst(ARGUMENTS.cid).getResult();
        } catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to add Credit Facility
    * @author Satyapriya Baral
    * @param string formData - contains the formData
    * @param string obj - contains all tinymce data
    * @return - Returns query result of data.
    */
    remote function addCreditFacility(required string formData, required string obj) returnformat="JSON"
    {
        try {
            LOCAL.formData = deserializeJSON(ARGUMENTS.formData);
            LOCAL.textareaData = deserializeJSON(ARGUMENTS.obj);
            //function call to add all credit facility details
            LOCAL.createCreditFacility = companyObject.addCreditFacility(LOCAL.formData, LOCAL.textareaData);
            addextraCreditFieldData(LOCAL.formData, LOCAL.createCreditFacility.getPrefix().identitycol);
            LOCAL.creditFacilityColumns = companyObject.getCreditFacilityColumns();
            //assign of sort id for all colums
            LOCAL.addSortId = companyObject.addSortId(LOCAL.creditFacilityColumns, LOCAL.createCreditFacility.getPrefix().identitycol, LOCAL.formData.companyID);
            creditFacilityDataJson(LOCAL.createCreditFacility.getPrefix().identitycol, LOCAL.formData.companyID);
        }

        catch (any exception){
            error.errorLog(exception);
            return "false";
        }
    }

    /**
    * Function to add Credit Facility
    * @author Satyapriya Baral
    * @param string formData - contains the formData
    * @param string obj - contains all tinymce data
    * @return - Returns query result of data.
    */
    remote function editCreditFacility(required string formData, required string obj) returnformat="JSON"
    {
        try {
            LOCAL.formData = deserializeJSON(ARGUMENTS.formData);
            LOCAL.textareaData = deserializeJSON(ARGUMENTS.obj);
            //function call to add all credit facility details
            LOCAL.createCreditFacility = companyObject.editCreditFacility(LOCAL.formData, LOCAL.textareaData);
            addextraCreditFieldData(LOCAL.formData, LOCAL.formData.rcfid);
            creditFacilityDataJson(LOCAL.formData.rcfid, LOCAL.formData.companyID);
        }

        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }

    public boolean function addextraCreditFieldData(required struct formData, required numeric rcfid) {
        try {
            LOCAL.array = ArrayNew(1);
            if(isDefined("ARGUMENTS.formData.otherLenders")) {
                //creating an array if only one data found
                if(NOT IsArray(ARGUMENTS.formData.otherLenders)) {                
                    LOCAL.array[1] = ARGUMENTS.formData.otherLenders;
                    LOCAL.createLenders = companyObject.addLenders(LOCAL.array, ARGUMENTS.rcfid);
                } else {
                    LOCAL.createLenders = companyObject.addLenders(ARGUMENTS.formData.otherLenders, ARGUMENTS.rcfid);
                }
            }
            if(isDefined("ARGUMENTS.formData.amendmentDate")) {
                //creating an array if only one data found
                if(NOT IsArray(ARGUMENTS.formData.amendmentDate)) {                
                    LOCAL.array[1] = ARGUMENTS.formData.amendmentDate;
                    LOCAL.createLenders = companyObject.addAmendment(LOCAL.array, ARGUMENTS.rcfid);
                } else {
                    LOCAL.createAmendment = companyObject.addAmendment(ARGUMENTS.formData.amendmentDate, ARGUMENTS.rcfid);
                }
            }
            if(isDefined("ARGUMENTS.formData.agentBank")) {
                //creating an array if only one data found
                if(NOT IsArray(ARGUMENTS.formData.agentBank)) {                
                    LOCAL.array[1] =ARGUMENTS.formData.agentBank;
                    LOCAL.createLenders = companyObject.addAgentBank(LOCAL.array, ARGUMENTS.rcfid);
                } else {
                    LOCAL.createAgentBank = companyObject.addAgentBank(ARGUMENTS.formData.agentBank, ARGUMENTS.rcfid);
                }
            }
            if(isDefined("ARGUMENTS.formData.simultaneous")) {
                //creating an array if only one data found
                if(NOT IsArray(ARGUMENTS.formData.simultaneous)) {                
                    LOCAL.array[1] = ARGUMENTS.formData.simultaneous;
                    LOCAL.createLenders = companyObject.addSimultaneous(LOCAL.array, ARGUMENTS.rcfid);
                } else {
                    LOCAL.createSimultaneous = companyObject.addSimultaneous(ARGUMENTS.formData.simultaneous, ARGUMENTS.rcfid);
                }
            }
            if(isDefined("ARGUMENTS.formData.financial")) {
                //creating an array if only one data found
                if(NOT IsArray(ARGUMENTS.formData.financial)) {                
                    LOCAL.array[1] = ARGUMENTS.formData.financial;
                    LOCAL.createLenders = companyObject.addFinancial(LOCAL.array, ARGUMENTS.rcfid);
                } else {
                    LOCAL.createFinancial = companyObject.addFinancial(ARGUMENTS.formData.financial, ARGUMENTS.rcfid);
                }
            }
            return true;
        } 

        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }
    /**
    * Function to get customize details of respective record
    * @author Satyapriya Baral
    * @param numeric rcfid - contains the rcfid of the record
    * @return - Returns query result of data.
    */

    remote function creditFacilityDataJson(required numeric rcfId ,required numeric cId) returnformat="JSON"
    {
        try {
            LOCAL.totalData = companyObject.getCreditFacilityData(ARGUMENTS.cId).recordCount;
            LOCAL.creditFieldData = companyObject.getCreditFacilitySpecificData(ARGUMENTS.rcfId);
            LOCAL.sortDetails = companyObject.getSortDetails(ARGUMENTS.rcfid);
            LOCAL.columnDetails = companyObject.getCreditFacilityColumns();
            LOCAL.extraColumnDetails = getMultiColumnDetails(ARGUMENTS.rcfid); 
            obj = {
                "creditFieldData" = "#LOCAL.creditFieldData#",
                "sortDetails" = "#LOCAL.sortDetails#",
                "columnDetails" = "#LOCAL.columnDetails#",
                "extraColumnDetails" = "#LOCAL.extraColumnDetails#",
                "totalRecords" = "#LOCAL.totalData#"
            };
            writeOutput("#serializeJSON(obj)#");
        } 

        catch (any exception){
            error.errorLog(exception);
            //LOCAL.errorData = queryNew("error, varchar");
            return "false";
        }
    }

    /**
    * Function to get customize details of respective record
    * @author Satyapriya Baral
    * @param numeric rcfid - contains the rcfid of the record
    * @return - Returns query result of data.
    */

    remote function creditFacilityDataJsonFormat(required numeric rcfId) returnformat="JSON"
    {
        try {
            LOCAL.creditFieldData = companyObject.getCreditFacilitySpecificData(ARGUMENTS.rcfId);
            LOCAL.columnDetails = companyObject.getCreditFacilityColumns();
            LOCAL.extraColumnDetails = getMultiColumnDetails(ARGUMENTS.rcfid); 
            obj=structNew();
            for(i=1 ; i<=LOCAL.columnDetails.recordCount ; i++)
            {
                if(LOCAL.columnDetails.str_credit_facility_columns[i] EQ "date_amendment")
                {
                    for(j=1 ; j<=LOCAL.extraColumnDetails.amendment.recordCount ;j++) 
                    {
                        obj["#LOCAL.columnDetails.str_credit_facility_columns[i]#"] = LOCAL.extraColumnDetails.amendment["#LOCAL.columnDetails.str_credit_facility_columns[i]#"];
                    }
                } 
                else if(LOCAL.columnDetails.str_credit_facility_columns[i] EQ "str_lenders") 
                {
                    for(j=1 ; j<=LOCAL.extraColumnDetails.lenders.recordCount ;j++) 
                    {
                        obj["#LOCAL.columnDetails.str_credit_facility_columns[i]#"] = LOCAL.extraColumnDetails.lenders["#LOCAL.columnDetails.str_credit_facility_columns[i]#"];
                    }
                }
                else if(LOCAL.columnDetails.str_credit_facility_columns[i] EQ "str_agent_bank")
                {
                    for(j=1 ; j<=LOCAL.extraColumnDetails.agentBank.recordCount ;j++) 
                    {
                        obj["#LOCAL.columnDetails.str_credit_facility_columns[i]#"] = LOCAL.extraColumnDetails.agentBank["#LOCAL.columnDetails.str_credit_facility_columns[i]#"];
                    }
                }
                else if(LOCAL.columnDetails.str_credit_facility_columns[i] EQ "str_convenants")
                {
                    for(j=1 ; j<=LOCAL.extraColumnDetails.convenants.recordCount ;j++) 
                    {
                        obj["#LOCAL.columnDetails.str_credit_facility_columns[i]#"] = LOCAL.extraColumnDetails.convenants["#LOCAL.columnDetails.str_credit_facility_columns[i]#"];
                    }
                }
                else if(LOCAL.columnDetails.str_credit_facility_columns[i] EQ "str_financial_convenants_data")
                {
                    for(j=1 ; j<=LOCAL.extraColumnDetails.financialConvenants.recordCount ;j++) 
                    {
                        obj["#LOCAL.columnDetails.str_credit_facility_columns[i]#"] = LOCAL.extraColumnDetails.financialConvenants["#LOCAL.columnDetails.str_credit_facility_columns[i]#"];
                    }
                } 
                else 
                {
                 obj["#LOCAL.columnDetails.str_credit_facility_columns[i]#"] = LOCAL.creditFieldData["#LOCAL.columnDetails.str_credit_facility_columns[i]#"];
                }
            }
            writeOutput("#serializeJSON(obj)#");
        } 

        catch (any exception){
            error.errorLog(exception);
            //LOCAL.errorData = queryNew("error, varchar");
            return "false";
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
            return companyObject.getCreditFacilityData(ARGUMENTS.cid);
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
            return companyObject.getSortDetails(ARGUMENTS.rcfid);
        } 

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
            return LOCAL.errorData;
        }
    }

    /**
    * Function to get customize details of respective record
    * @author Satyapriya Baral
    * @param numeric rcfid - contains the rcfid of the record
    * @return - Returns query result of data.
    */

    remote string function getCustomLayoutDetails(required numeric rcfId) returnformat="JSON"
    {
        try {
            LOCAL.sortDetails = companyObject.getSortDetails(ARGUMENTS.rcfid);
            LOCAL.columnDetails = companyObject.getCreditFacilityColumns();
            LOCAL.columnFeatureData = [];
            //createing a json data for returning to the ajax call.
            for(i=1 ; i <= LOCAL.sortDetails.recordcount ; i++) {
                    obj = {
                        "id" = "#LOCAL.sortDetails.int_sort_credit_id[i]#",
                        "columnId" = "#LOCAL.sortDetails.int_cf_id[i]#",
                        "sortId" = "#LOCAL.sortDetails.int_cf_sort_id[i]#",
                        "customizeId" = "#LOCAL.sortDetails.int_cf_costomize_sort_id[i]#",
                        "columnName" = "#LOCAL.columnDetails.str_credit_facility_columns[LOCAL.sortDetails.int_cf_id[i]]#",
                        "columnNameText" = "#LOCAL.columnDetails.str_column_names[LOCAL.sortDetails.int_cf_id[i]]#"
                    };
                    arrayAppend(LOCAL.columnFeatureData, obj);
            }
            return ("#serializeJSON(LOCAL.columnFeatureData)#");
        } 

        catch (any exception){
            error.errorLog(exception);
            //LOCAL.errorData = queryNew("error, varchar");
            return false;
        }
    }

    /**
    * Function to get all column detailsfield_custom_headerfield_custom_section
    * @author Satyapriya Baral
    * @return - Returns query result of data.
    */
    public query function getColumnDetails() 
    {
        try {
            return companyObject.getCreditFacilityColumns();
        } 

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = queryNew("error, varchar");
            return LOCAL.errorData;
        }
    }

    /**
    * Function to get some credit facility column details of perticular record
    * @author Satyapriya Baral
    * @param numeric rcfid - contains the rcfid of the record
    * @return - Returns query result of data.
    */
    public struct function getMultiColumnDetails(required numeric rcfid) 
    {
        try {
            //creating struct to return all data of columns
            LOCAL.columnDetails = structNew();
            LOCAL.columnDetails.amendment = companyObject.getAmendment(ARGUMENTS.rcfid);
            LOCAL.columnDetails.lenders = companyObject.getLenders(ARGUMENTS.rcfid);
            LOCAL.columnDetails.agentBank = companyObject.getAgentBank(ARGUMENTS.rcfid);
            LOCAL.columnDetails.convenants = companyObject.getConvenants(ARGUMENTS.rcfid);
            LOCAL.columnDetails.financialConvenants = companyObject.getFinancialConvenants(ARGUMENTS.rcfid);
            return LOCAL.columnDetails;
        } 

        catch (any exception){
            error.errorLog(exception);
            return {};
        }
    }

    /**
    * Function to update highlight data sortId.
    * @author Satyapriya Baral
    * @param number rcfid - report id of the report.
    * @param string sortData - contains sort data.
    * @return null.
    */
    remote boolean function updateCreditFacilitySortOrder(required string sortData, required numeric rcfid) returnformat="JSON"
    {
        try {
            LOCAL.getData = companyObject.getSortDetails(ARGUMENTS.rcfid);
            writeDump(LOCAL.getData);
            writeDump(ARGUMENTS.sortData);
            writeDump(ARGUMENTS.rcfid);
            for(i=1 ; i <= LOCAL.getData.recordcount ; i++) {
                LOCAL.item = listGetAt(ARGUMENTS.sortData, i);
                LOCAL.id = listGetAt(item,2,"_");
                LOCAL.updateSortOrder = companyObject.updateSortOrder(i, LOCAL.id);
                writeDump(i);

                writeDump(LOCAL.id);
                
            }
            return true;
        }

        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }

    /**
    * Function to edit customize data
    * @author Satyapriya Baral
    * @param string obj - contains details of customize fields
    * @return - Returns query result of data.
    */
    remote string function editCustomize(required string obj)
    {
        try {
            LOCAL.customizeData = deserializeJSON(ARGUMENTS.obj);
            LOCAL.array = StructKeyArray(LOCAL.customizeData);
            for(i=1 ; i<=arrayLen(LOCAL.array) ; i++) {
                companyObject.updateCustomize(LOCAL.array[i], LOCAL.customizeData[LOCAL.array[i]]);
            }
            return "true";
        }

        catch (any exception){
            error.errorLog(exception);
            return "false";
        }
    }
}