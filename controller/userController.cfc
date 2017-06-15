/**
* File: userController.cfc
* Author: Satyapriya Baral
* Path: model/userController.cfc
* Purpose: contains functions for login and registration.
* Date: 01-05-2017
*/
component {

    userObject = createObject("component", "model.userModel");
    include "../include/include.cfm";
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
	public struct function registerUser(required string username, required string email, required string password, required string retypePassword)
	{
		try {
			LOCAL.errorMessages=structNew();
			if (Len(ARGUMENTS.username) < 5) {
				LOCAL.errorMessages.Name = 'Name Should be of minimum 5 charecters';
			}
			if (ARGUMENTS.email EQ '' OR NOT isValid("email", ARGUMENTS.email)) {
			LOCAL.errorMessages.Email = 'Plese Enter a Valid Email';
			}
			if (Len(ARGUMENTS.password) < 5) {
				LOCAL.errorMessages.Password = 'Password Should be of minimum 5 charecters';
			}
			else if (ARGUMENTS.password NOT EQUAL ARGUMENTS.retypePassword) {
				LOCAL.errorMessages.RetypePassword = 'Password Mismatch';
			}
			LOCAL.checkUser = userObject.checkUser(ARGUMENTS.email);
			if (isDefined("LOCAL.checkUser.error")) {
				LOCAL.errorMessages.emailExists = 'Something Went Wrong Please Try again Later';
			}
			else if (LOCAL.checkUser.recordCount NEQ 0 ) {
				LOCAL.errorMessages.emailExists = 'Email Already Exists';
			} else {
				LOCAL.isRegistered = userObject.createUser(ARGUMENTS.username, ARGUMENTS.email, ARGUMENTS.password);
				LOCAL.errorMessages.succesful = 'Registered Succesfully';
			}
			return errorMessages;
		}
		
		catch (any exception){
			error.errorLog(exception);
			return {};
		}
	}
	
	/**
    * Function to check user details entered and login user.
    *
    * @param string $email - contains email of the user.
    * @param string $password - contains passwoed of the user.
    * @return - Returns to the homepage or returns error.
    */
	public struct function loginUser(required string email, required string password)
	{

		try {
			LOCAL.loginErrorMessages=structNew();
			if (email EQ '' OR NOT isValid("email", email)) {
				LOCAL.loginErrorMessages.Email = 'Plese Enter a Valid Email';
			}
			if (Len(password) < 5) {
				LOCAL.loginErrorMessages.Password = 'Password Should be of minimum 5 charecters';
			}
			LOCAL.hashPassword = HASH(ARGUMENTS.password);
			LOCAL.isLogged = userObject.checkUser(email);
			if (isDefined("LOCAL.checkUser.error")) {
				LOCAL.errorMessages.emailExists = 'Something Went Wrong Please Try again Later';
			} else if(LOCAL.isLogged.recordCount EQ 0) {
				LOCAL.loginErrorMessages.user = 'Incorrect Email or Password';
			} else {
				if(LOCAL.isLogged.UserPassword NEQ LOCAL.hashPassword) {
					LOCAL.loginErrorMessages.user = 'Incorrect Email or Password';
				} else {
					SESSION.isLogged = "true";
					SESSION.userEmail = "#ARGUMENTS.email#";
					SESSION.user = "#LOCAL.isLogged.UserName#";
					SESSION.id = "#LOCAL.isLogged.UserId#";
					APPLICATION.currentUsers = listAppend(APPLICATION.currentUsers, #ARGUMENTS.email#);
				}
			}
			return LOCAL.loginErrorMessages;
		}
		
		catch (any exception){
			error.errorLog(exception);
			return {};
		}
	}
	
	/**
    * Function to get the user Details.
    *
    * @param string $email - contains email of the user.
    * @return - Returns userinfo details.
    */
	public query function userDetails(required string email)
	{
		try {
			LOCAL.userInfo = userObject.checkUser(email);
			return LOCAL.userInfo;
		}
		
		catch (any exception){
			error.errorLog(exception);
			errorData = queryNew("error, varchar");
			return errorData;
		}
	}
	
	/**
    * Function to get details and make a random value for password reset.
    *
    * @param string email - Contains email data.
    * @return - Returns success or failure msg.
    */
    public struct function createToken(required string email)
    {
		try {
			LOCAL.message=structNew();
			//checks if email exist or not
			LOCAL.userInfo = userObject.checkUser(email);
			if(LOCAL.userInfo.recordCount NEQ 0) {
				LOCAL.random="";
				var i = 0;
				for (i = 0; i <= 20; i++) {
					LOCAL.random=LOCAL.random&Chr(RandRange(65, 90));
				}
				LOCAL.insertToken = userObject.update(random, email, "UserTokenId", "UserEmail");
				SAVECONTENT variable="mailBody" {
					writeOutput( "To reset your password please visit this link: http://www.companyreports.com/view/login/resetPassword.cfm?token=#LOCAL.random#&email=#ARGUMENTS.email#");
				};
				LOCAL.mailService = new mail(
					to = "#ARGUMENTS.email#",
					from = "kisansevaodisha@gmail.com",
					subject = "Forgot Password",
					body = mailBody
				);
				LOCAL.mailService.send();
				LOCAL.message.success = 'Reset Link Sent To your Mail';
				return LOCAL.message;
			}
			LOCAL.message.failure = 'Incorrect Email';
			return LOCAL.message;
		}

		catch (any exception){
			error.errorLog(exception);
			return {};
		}
		
    }

    /**
    * Function to update the new password.
    *
    * @param string password - Contains the password.
    * @param string email - Contains the email.
    * @return - Returns boolian value.
    */
    public boolean function updatePassword(required string password, required string email)
    {
		try {
			var hashPassword = HASH(password);
			LOCAL.updatePassword = userObject.update(LOCAL.hashPassword, ARGUMENTS.email, "UserPassword", "UserEmail");
			return true;
		}
		
		catch (any exception){
			error.errorLog(exception);
			return false;
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
                //APPLICATION.currentUsers = listDeleteAt(APPLICATION.currentUsers,listFind(APPLICATION.currentUsers, SESSION.userEmail));
            }
            writeOutput("no way");
            structClear(SESSION);
            SESSION.isLogged = "false";
            SESSION.id = "";
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