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
    * @param string $password - contains passwoed of the user.
    * @param string $address - contains address of the user.
    * @param string $number - contains number of the user.
    * @return - Returns boolian value if record created or not.
    */
	public boolean function createUser(string username, string email, string password)
	{
		try {
			var hashPassword = HASH(password);
			newUser = new Query();
			newUser.setSQL("INSERT into dbo.tbl_user_info (UserName, UserEmail, UserPassword) VALUES (:username, :email, :hashPassword)");
			newUser.addParam( name = "username", value = "#arguments.username#", cfsqltype = "cf_sql_varchar" );
			newUser.addParam( name = "email", value = "#arguments.email#", cfsqltype = "cf_sql_varchar" );
			newUser.addParam( name = "hashPassword", value = "#local.hashPassword#", cfsqltype = "cf_sql_varchar" );
			result = newUser.execute();
			return true;
		}
		
		catch (any exception){
			error.errorLog(exception);
			return false;
		}
	}
	
	/**
    * Function to check user exists or not.
    *
    * @param string $email - contains email of the user.
    * @return - Returns the record of the user.
    */
	public any function checkUser(string email)
	{
		try {
			checkUser = new Query();
			checkUser.setSQL("SELECT UserId, UserName, UserEmail, UserPassword, UserTokenId FROM dbo.tbl_user_info WHERE UserEmail = :email");
			checkUser.addParam( name = "email", value = "#arguments.email#", cfsqltype = "cf_sql_varchar" );
			userResult = checkUser.execute();
			return userResult;
		}
		
		catch (any exception){
			error.errorLog(exception);
			return false;
		}
	}
	
	/**
    * Function to update data.
    *
    * @param string $data1 - contains data to be updated.
    * @param string $data2 - contains the column data to be updated.
    * @param string $field1 - contains name of column to be updated.
    * @param string $field2 - contains name of column to be updated.
    * @return - Returns boolian value if token updated or not.
    */
	public boolean function update(string data1, string data2, string field1, string field2)
	{
		try {
			update = new Query();
			update.setSQL("UPDATE dbo.tbl_user_info SET #ARGUMENTS.field1# = :data1 WHERE #ARGUMENTS.field2# = :data2");
			update.addParam( name = "data1", value = "#arguments.data1#", cfsqltype = "cf_sql_varchar" );
			update.addParam( name = "data2", value = "#arguments.data2#", cfsqltype = "cf_sql_varchar" );
			result = update.execute();
			return true;
		}
		
		catch (any exception){
			error.errorLog(exception);
			return false;
		}
	}
	
	/**
    * Function to get all users Data.
    *
    * @param null
    * @return - Returns object of all data found.
    */
	public any function userDetails()
	{
		try {
			userDetails = new Query();
			userDetails.setSQL("SELECT UserName, UserEmail, UserPassword, UserTokenId FROM dbo.tbl_user_info");
			result = userDetails.execute();
			return result;
		}
		
		catch (any exception){
			error.errorLog(exception);
			return false;
		}
	}
}