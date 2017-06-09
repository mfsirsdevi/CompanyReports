/**
* File: reportController.cfc
* Author: R S Devi Prasad
* Path: controller/reportController.cfc
* Purpose: contains functions for report generation and display to the user.
* Date: 08-06-2017
*/

component {
    userObject = CreateObject("component", "model.userModel");
	error = CreateObject("component", "log.error");

    /**
    * Function to display report for the user by reading the company id and report id.
    * @author R S Devi Prasad
    * @param string cid - company id of the company for which the report is to be generated.
    * @param string rid - report id of the report.
    * @return struct - containing data to be displayed or the errors.
    */
    public struct function generateReport(int cid, int rid) {

        try {
			
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
    }
}