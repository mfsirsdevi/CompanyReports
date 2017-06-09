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
	public any function analystDetails()
	{
		try {
			LOCAL.analystInfo = analystObject.analystDetails();
			return LOCAL.analystInfo;
		}
		
		catch (any exception){
			error.errorLog(exception);
            return false;
		}
	}

	/**
    * Function to get all company search data
    *
    * @param string searchText - contains the search text to be searched.
	* @param numeric selectAnalyst - contains the analyst id that is searched.
    * @return - Returns searched info details.
    */
	public any function companySearch(string searchText, numeric selectAnalyst)
	{
		try {
			LOCAL.searchInfo = companyObject.companyDetailsSearch(searchText, selectAnalyst);
			return LOCAL.searchInfo;
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
	public any function companyPerPage(numeric start, numeric end, string search, numeric selectAnalyst)
	{
		try {
			LOCAL.searchInfo = companyObject.companyPerPageSearch(start, end, search, selectAnalyst);
			return LOCAL.searchInfo;
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
			LOCAL.reportInfo = companyObject.getReportId(companyId);
			return LOCAL.reportInfo;
		}
		
		catch (any exception){
			error.errorLog(exception);
			return false;
		}
	}

	/**
    * Function to get analyst data of the company
    * @author R S Devi Prasad
    * @param numeric cid - contains the id of the company
    * @return - Returns query result of data.
    */

	public any function getAnalyst(numeric cid) {
		try {
			return analystObject.getAnalyst(ARGUMENTS.cid).getResult();
		} catch (any exception){
			error.errorLog(exception);
			return false;
		}
	}
}