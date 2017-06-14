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
	public boolean function createUser(required string username, required string email, required string password)
	{
		try {
			LOCAL.hashPassword = HASH(password);
			LOCAL.newUser = new Query();
			LOCAL.newUser.setSQL("INSERT into dbo.tbl_user_info (UserName, UserEmail, UserPassword) VALUES (:username, :email, :hashPassword)");
			LOCAL.newUser.addParam( name = "username", value = "#ARGUMENTS.username#", cfsqltype = "cf_sql_varchar" );
			LOCAL.newUser.addParam( name = "email", value = "#ARGUMENTS.email#", cfsqltype = "cf_sql_varchar" );
			LOCAL.newUser.addParam( name = "hashPassword", value = "#LOCAL.hashPassword#", cfsqltype = "cf_sql_varchar" );
			LOCAL.result = LOCAL.newUser.execute();
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
	public query function checkUser(required string email)
	{
		try {
			LOCAL.checkUser = new Query();
			LOCAL.checkUser.setSQL("SELECT UserName, UserEmail, UserPassword, UserTokenId FROM dbo.tbl_user_info WHERE UserEmail = :email");
			LOCAL.checkUser.addParam( name = "email", value = "#ARGUMENTS.email#", cfsqltype = "cf_sql_varchar" );
			LOCAL.userResult = LOCAL.checkUser.execute();
			return LOCAL.userResult.getResult();
		}
		
		catch (any exception){
			error.errorLog(exception);
			errorData = queryNew("error, varchar");
			return errorData;
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
	public boolean function update(required string data1, required string data2, required string field1, required string field2)
	{
		try {
			LOCAL.update = new Query();
			LOCAL.update.setSQL("UPDATE dbo.tbl_user_info SET #ARGUMENTS.field1# = :data1 WHERE #ARGUMENTS.field2# = :data2");
			LOCAL.update.addParam( name = "data1", value = "#ARGUMENTS.data1#", cfsqltype = "cf_sql_varchar" );
			LOCAL.update.addParam( name = "data2", value = "#ARGUMENTS.data2#", cfsqltype = "cf_sql_varchar" );
			LOCAL.result = LOCAL.update.execute();
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
	public query function userDetails()
	{
		try {
			LOCAL.userDetails = new Query();
			LOCAL.userDetails.setSQL("SELECT UserName, UserEmail, UserPassword, UserTokenId FROM dbo.tbl_user_info");
			LOCAL.result = LOCAL.userDetails.execute();
			return LOCAL.result.getResult();
		}
		
		catch (any exception){
			error.errorLog(exception);
			errorData = queryNew("error, varchar");
			return errorData;
		}
	}
}