/**
* File: userController.cfc
* Author: Satyapriya Baral
* Path: model/userController.cfc
* Purpose: contains functions for login and registration.
* Date: 01-05-2017
*/
component {
	
	userObject = CreateObject("component", "model.userModel");
	error = CreateObject("component", "log.error");
	/**
    * Function to check fields and register user.
    *
    * @param string $username - contains name of the user.
    * @param string $email - contains email of the user.
    * @param string $password - contains passwoed of the user.
    * @param string $address - contains address of the user.
    * @param string $number - contains number of the user.
    * @return - Returns messages of errors if any or success msg.
    */
	public any function registerUser(string username, string email, string password, string retypePassword)
	{
		try {
			LOCAL.errorMessages=StructNew();
			if (Len(username) < 5) {
				LOCAL.errorMessages.Name = 'Name Should be of minimum 5 charecters';
			}
			if (email EQ '' OR NOT isValid("email", email)) {
			LOCAL.errorMessages.Email = 'Plese Enter a Valid Email';
			}
			if (Len(password) < 5) {
				LOCAL.errorMessages.Password = 'Password Should be of minimum 5 charecters';
			}
			else if (password NOT EQUAL retypePassword) {
				LOCAL.errorMessages.RetypePassword = 'Password Mismatch';
			}
			var LOCAL.checkUser = userObject.checkUser(email);
			if (checkUser.getResult().recordCount NEQ 0 ) {
				LOCAL.errorMessages.emailExists = 'Email Already Exists';
			} else {
				LOCAL.isRegistered = userObject.createUser(username, email, password);
				LOCAL.errorMessages.succesful = 'Registered Succesfully';
			}
			return errorMessages;
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	
	/**
    * Function to check user details entered and login user.
    *
    * @param string $email - contains email of the user.
    * @param string $password - contains passwoed of the user.
    * @return - Returns to the homepage or returns error.
    */
	public any function loginUser(string email, string password)
	{

		try {
			LOCAL.loginErrorMessages=StructNew();
			if (email EQ '' OR NOT isValid("email", email)) {
				LOCAL.loginErrorMessages.Email = 'Plese Enter a Valid Email';
			}
			if (Len(password) < 5) {
				LOCAL.loginErrorMessages.Password = 'Password Should be of minimum 5 charecters';
			}
			LOCAL.hashPassword = HASH(ARGUMENTS.password);
			LOCAL.isLogged = userObject.checkUser(email);
			if(LOCAL.isLogged.getResult().recordCount EQ 0) {
				LOCAL.loginErrorMessages.user = 'Incorrect Email or Password';
			} else {
				if(LOCAL.isLogged.getResult().UserPassword NEQ LOCAL.hashPassword) {
					LOCAL.loginErrorMessages.user = 'Incorrect Email or Password';
				} else {
					SESSION.isLogged = "true";
					SESSION.userEmail = "#arguments.email#";
					SESSION.user = "#isLogged.getResult().UserName#";
					APPLICATION.currentUsers = listAppend(APPLICATION.currentUsers, #ARGUMENTS.email#);
				}
			}
			return LOCAL.loginErrorMessages;
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	
	/**
    * Function to get the user Details.
    *
    * @param string $email - contains email of the user.
    * @return - Returns userinfo details.
    */
	public any function userDetails(string email)
	{
		try {
			LOCAL.userInfo = userObject.checkUser(email);
			return LOCAL.userInfo;
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
	
	/**
    * Function to get details and make a random value for password reset.
    *
    * @param string email - Contains email data.
    * @return - Returns success or failure msg.
    */
    public any function createToken(string email)
    {
		try {
			LOCAL.message=StructNew();
			//checks if email exist or not
			LOCAL.userInfo = userObject.checkUser(email);
			if(LOCAL.userInfo.getResult().recordCount NEQ 0) {
				LOCAL.random="";
				var i = 0;
				for (i = 0; i <= 20; i++) {
					LOCAL.random=LOCAL.random&Chr(RandRange(65, 90));
				}
				LOCAL.insertToken = userObject.update(random, email, "UserTokenId", "UserEmail");
				savecontent variable="mailBody" {
					writeOutput( "To reset your password please visit this link: http://www.companyreports.com/view/login/resetPassword.cfm?token=#LOCAL.random#&email=#ARGUMENTS.email#");
				};
				mailService = new mail(
					to = "#ARGUMENTS.email#",
					from = "kisansevaodisha@gmail.com",
					subject = "Forgot Password",
					body = mailBody
				);
				mailService.send();
				LOCAL.message.success = 'Reset Link Sent To your Mail';
				return LOCAL.message;
			}
			LOCAL.message.failure = 'Incorrect Email';
			return LOCAL.message;
		}

		catch (any exception){
			error.errorLog(exception);
		}
		
    }
	
	/**
    * Function to update the new password.
    *
    * @param string password - Contains the password.
    * @param string email - Contains the email.
    * @return - Returns boolian value.
    */
    public any function updatePassword(string password, string email)
    {
		try {
			if (Len(password) < 5) {
				return 'Password Should be of minimum 5 charecters';
			}
			var hashPassword = HASH(password);
			LOCAL.updatePassword = userObject.update(LOCAL.hashPassword, ARGUMENTS.email, "UserPassword", "UserEmail");
			return LOCAL.updatePassword;
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
    }
	
	/**
    * Function to signout the user.
    *
    * @param null
    * @return null
    */
	remote void function signoutUser()
	{
		try {
			if(SESSION.userEmail NEQ "") {
				APPLICATION.currentUsers = listDeleteAt(APPLICATION.currentUsers,listFind(APPLICATION.currentUsers, SESSION.userEmail));
			}
			structClear(SESSION);
			SESSION.isLogged = "false";
			SESSION.userEmail = "";
			SESSION.type = "";
			location(url="../../view/login/login.cfm", addToken="false");
			sessionInvalidate();
		}
		
		catch (any exception){
			error.errorLog(exception);
		}
	}
}