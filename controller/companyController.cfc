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
    remote boolean function addCreditFacility(required string formData, required string obj)
    {
        try {
            LOCAL.formData = deserializeJSON(ARGUMENTS.formData);
            LOCAL.textareaData = deserializeJSON(ARGUMENTS.obj);
            //function call to add all credit facility details
            LOCAL.createCreditFacility = companyObject.addCreditFacility(LOCAL.formData, LOCAL.textareaData);
            LOCAL.array = ArrayNew(1);
            if(isDefined("LOCAL.formData.otherLenders")) {
                //creating an array if only one data found
                if(NOT IsArray(LOCAL.formData.otherLenders)) {                
                    LOCAL.array[1] = LOCAL.formData.otherLenders;
                    LOCAL.createLenders = companyObject.addLenders(LOCAL.array, LOCAL.createCreditFacility.getPrefix().identitycol);
                } else {
                    LOCAL.createLenders = companyObject.addLenders(LOCAL.formData.otherLenders, LOCAL.createCreditFacility.getPrefix().identitycol);
                }
            }
            if(isDefined("LOCAL.formData.amendmentDate")) {
                //creating an array if only one data found
                if(NOT IsArray(LOCAL.formData.amendmentDate)) {                
                    LOCAL.array[1] = LOCAL.formData.amendmentDate;
                    LOCAL.createLenders = companyObject.addAmendment(LOCAL.array, LOCAL.createCreditFacility.getPrefix().identitycol);
                } else {
                    LOCAL.createAmendment = companyObject.addAmendment(LOCAL.formData.amendmentDate, LOCAL.createCreditFacility.getPrefix().identitycol);
                }
            }
            if(isDefined("LOCAL.formData.agentBank")) {
                //creating an array if only one data found
                if(NOT IsArray(LOCAL.formData.agentBank)) {                
                    LOCAL.array[1] =LOCAL.formData.agentBank;
                    LOCAL.createLenders = companyObject.addAgentBank(LOCAL.array, LOCAL.createCreditFacility.getPrefix().identitycol);
                } else {
                    LOCAL.createAgentBank = companyObject.addAgentBank(LOCAL.formData.agentBank, LOCAL.createCreditFacility.getPrefix().identitycol);
                }
            }
            if(isDefined("LOCAL.formData.simultaneous")) {
                //creating an array if only one data found
                if(NOT IsArray(LOCAL.formData.simultaneous)) {                
                    LOCAL.array[1] = LOCAL.formData.simultaneous;
                    LOCAL.createLenders = companyObject.addSimultaneous(LOCAL.array, LOCAL.createCreditFacility.getPrefix().identitycol);
                } else {
                    LOCAL.createSimultaneous = companyObject.addSimultaneous(LOCAL.formData.simultaneous, LOCAL.createCreditFacility.getPrefix().identitycol);
                }
            }
            if(isDefined("LOCAL.formData.financial")) {
                //creating an array if only one data found
                if(NOT IsArray(LOCAL.formData.financial)) {                
                    LOCAL.array[1] = LOCAL.formData.financial;
                    LOCAL.createLenders = companyObject.addFinancial(LOCAL.array, LOCAL.createCreditFacility.getPrefix().identitycol);
                } else {
                    LOCAL.createFinancial = companyObject.addFinancial(LOCAL.formData.financial, LOCAL.createCreditFacility.getPrefix().identitycol);
                }
            }
            LOCAL.creditFacilityColumns = companyObject.getCreditFacilityColumns();
            //assign of sort id for all colums
            LOCAL.addSortId = companyObject.addSortId(LOCAL.creditFacilityColumns, LOCAL.createCreditFacility.getPrefix().identitycol, LOCAL.formData.companyID);
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
    * Function to get sort details of respective record
    * @author Satyapriya Baral
    * @param numeric rcfid - contains the rcfid of the record
    * @return - Returns query result of data.
    */

    remote function getCustomLayoutDetails(required numeric rcfId) returnformat="JSON"
    {
        try {
            //WriteOutput("#serializeJSON(ARGUMENTS.rcfid)#");
            LOCAL.sortDetails = companyObject.getSortDetails(ARGUMENTS.rcfid);
           
            LOCAL.columnDetails = companyObject.getCreditFacilityColumns();
            LOCAL.columnFeatureData = [];
            for(i=1 ; i <= LOCAL.sortDetails.recordcount ; i++) {
                //LOCAL. = LOCAL.columnDetails.str_credit_facility_columns[#LOCAL.sortDetails.int_cf_id[i]#]>
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
            WriteOutput("#serializeJSON(LOCAL.columnFeatureData)#");
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
    * Function to get amendment details of perticular record
    * @author Satyapriya Baral
    * @return - Returns query result of data.
    */

    public query function getAmendment(required numeric rcfid) 
    {
        try {
            return companyObject.getAmendment(ARGUMENTS.rcfid);
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
            return companyObject.getLenders(ARGUMENTS.rcfid);
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
            return companyObject.getAgentBank(ARGUMENTS.rcfid);
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
            return companyObject.getConvenants(rcfid);
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
            return companyObject.getFinancialConvenants(rcfid);
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
    remote function updateCreditFacilitySortOrder(required string sortData, required numeric rcfid) returnformat="JSON"
    {
        try {
            LOCAL.getData = companyObject.getSortDetails(ARGUMENTS.rcfid);
            for(i=1 ; i <= LOCAL.getData.recordcount ; i++) {
                LOCAL.item = listGetAt(ARGUMENTS.sortData, i);
                LOCAL.id = listGetAt(item,2,"_");
                // LOCAL.sortOrder = (LOCAL.getData.recordcount - i)+1;
                updateSortOrder = companyObject.updateSortOrder(i, LOCAL.id);
            }
        }

        catch (any exception){
            error.errorLog(exception);
            LOCAL.errorData = [];
            return serializeJSON(LOCAL.errorData);
        }
    }

    /**
    * Function to add Credit Facility
    * @author Satyapriya Baral
    * @param string formData - contains the formData
    * @param string obj - contains all tinymce data
    * @return - Returns query result of data.
    */
    remote any function editCustomize(required string obj)
    {
        try {
            LOCAL.textareaData = deserializeJSON(ARGUMENTS.obj);
            LOCAL.array = StructKeyArray(LOCAL.textareaData);
            writeDump(LOCAL.array);

        }

        catch (any exception){
            error.errorLog(exception);
            return false;
        }
    }
}