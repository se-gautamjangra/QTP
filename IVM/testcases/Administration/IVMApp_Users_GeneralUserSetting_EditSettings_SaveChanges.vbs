'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Seachange
'
' File Name						:	IVMApp_Users_GeneralUserSetting_EditSettings_SaveChanges
' Description					:	Validate the "Edit" functionality of User Page.
' Author 						:   Fonantrix Solution
' Date 							:   20-06-2012
'--------------------------------------------------------------------------------------------------------------------------------------------------
 
 'Start Test Case 

 executionController.startTestCase_w_TestCaseNumber "IVMApp_Users_GeneralUserSetting_EditSettings_SaveChanges", "AAA_UMG_TC_010"
	

ivm.NavigateToMenu MENU_USERS
wait Wait5


strUsername=testcasedata.getvalue("Username")
strFullName=testcasedata.getvalue("FullName")
strRole=testcasedata.getvalue("strRole")
strUsername1=testcasedata.getvalue("strUsername1")
strFullName1=testcasedata.getvalue("strFullName1")
strEmailAddress1=testcasedata.getvalue("strEmailAddress1")
strPhoneNumber=testcasedata.getvalue("strPhoneNumber")

ivm.page(User_page).webTable("Users").presstblLink strUsername,2



'strStatus1 = ivm.page(User_page).webRadioGroup("Status").SelectGroupItem()

with ivm.page(User_page)

                       .webLink("EditDetails").assertStatus "Visible"
					   .webLink("EditDetails").assertExist "True"
					   .webLink("EditDetails").press
					   wait Wait5
                       .webEdit("UserName").assertValue strUsername
                       .webEdit("FullName").assertValue strFullName
                       .weblist("Roles").assertSelectedItem strRole
					   .webEdit("UserName").setValue strUsername1
                       .webEdit("FullName").setValue strFullName1
					   .webLink("AddEmail").press
					   wait 3
					   .webEdit("EmailAddress").setValue strEmailAddress1
					    .webLink("AddPhoneNo").press
					   wait 3
					   .webList("SelectPhonenumber").selectItem "Mobile"
					   wait 2
					   .webEdit("PhoneNumber").setValue strPhoneNumber
					   .webLink("SaveChanges").press
					   
					   wait Wait5
					   
					   .webLink("CreateNewUser").assertExist "True"
					   .webLink("CreateNewUser").assertStatus "Visible" 
                       .webTable("Users").assertColumnExist "Status","True"
					   .webTable("Users").assertColumnExist "Username","True"
					   .webTable("Users").assertColumnExist "Role","True"
					   .webTable("Users").assertColumnExist "Last Log In","True"
					   .webTable("Users").assertColumnExist "Last Updated","True"
					   .webTable("Users").assertColumnExist "Actions","True"
					   .webTable("Users").assertValue strUsername1,2
					   
end with

wait 10
REM ivm.page(Common_page).webList("Page").selectItem strPage
'ivm.page(User_page).webTable("Users").assertValue strUsername,2

strValues = strUsername1 & ";" & strFullname1 &";"& strEmailAddress1 &";" & strRole1 & ";"& strStatus1
ivm.page(Login_page).assertformRecord frmEditUser,"False",strUsername,strUsername
ivm.page(Login_page).assertformRecord frmEditUser,"True",strUsername1,strUsername1


'End Test Case
executionController.stopTestCase_w_TestCaseNumber "IVMApp_Users_GeneralUserSetting_EditSettings_SaveChanges", "AAA_UMG_TC_010"
