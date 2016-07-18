'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Seachange
'
' File Name						:	Login_WithInvalidCredentials2
' Description					:	Validate login for User with invalid User Name and valid password
' Author 						:   Fonantrix Solution
' Date 							:   20-06-2012
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "Login_WithInvalidCredentials2", "AAA_AUT_TC_003"

'Invalid Username and Password----------------
strUsername =testcasedata.getvalue("Username")
strPassword =testcasedata.getvalue("password")
strErrMessage =testcasedata.getvalue("ErrMessage")

ivm.page(Login_page).webEdit("Username").setValue strUsername 								
ivm.page(Login_page).webEdit("Password").setValue strPassword   							
ivm.page(Login_page).webLink("Login").press         									
ivm.page(Login_page).webElement("ErrorLogIn").assertExist "True"		
ivm.page(Login_page).webElement("ErrorLogIn").assertStatus "Visible"  	
ivm.page(Login_page).webElement("ErrorLogIn").assertErrorText strErrMessage

'End Test Case 
executionController.stopTestCase_w_TestCaseNumber "Login_WithInvalidCredentials2", "AAA_AUT_TC_003"
