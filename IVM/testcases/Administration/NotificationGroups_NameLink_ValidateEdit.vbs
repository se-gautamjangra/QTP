'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Seachange
'
' File Name						:	NotificationGroups_NameLink_ValidateEdit
' Description					:	Validate UI Controls of Edit page
' Author 						:   Fonantrix Solution
' Date 							:   20-06-2012
'--------------------------------------------------------------------------------------------------------------------------------------------------
 
 'Start Test Case a

executionController.startTestCase_w_TestCaseNumber "NotificationGroups_NameLink_ValidateEdit", "ALC_NGP_TC_14"
  ivm.NavigateToMenu MENU_NOTIFICATION_GROUPS
wait Wait5
strUserName = testcasedata.getvalue("UserName")
strUser = testcasedata.getvalue("User")
strName = testcasedata.getvalue("strName")
strDescription = testcasedata.getvalue("strDescription")

    ivm.page(Common_page).webTable("NotificationGroups").assertValue strName,1
     ivm.page(Common_page).webTable("NotificationGroups").pressLink "Edit",strName,1
	 
	  ivm.page(Common_page).webLink("Actions").press
     wait Wait5

	 ivm.page(Common_page).webLink("Edit").assertExist "True"
     ivm.page(Common_page).webLink("Edit").assertStatus "Visible"
	 
	 ivm.page(Common_page).webLink("Edit").press
	 wait Wait5
	 
	 ivm.page(Common_page).webElement("NotificationGroupName").assertExist "True"
     ivm.page(Common_page).webElement("NotificationGroupName").assertStatus "Visible"
	 
	 ivm.page(Common_page).webElement("NotificationGroupName").assertText " Edit " &strName 

    ivm.page(Common_page).webElement("NotificationGroupdetails").assertExist "True"
    ivm.page(Common_page).webElement("NotificationGroupdetails").assertStatus "Visible"

	ivm.page(Common_page).webElement("Name").assertExist "True"
	ivm.page(Common_page).webElement("Name").assertStatus "Visible"

	ivm.page(Common_page).webEdit("Name").assertExist "True"
    ivm.page(Common_page).webEdit("Name").assertStatus "Visible"
	
	ivm.page(Common_page).webEdit("Name").assertValue strName

	ivm.page(Common_page).webElement("Description").assertExist "True"
	ivm.page(Common_page).webElement("Description").assertStatus "Visible"

	ivm.page(Common_page).webEdit("Description").assertExist "True"
	ivm.page(Common_page).webEdit("Description").assertStatus "Visible"
	
	ivm.page(Common_page).webEdit("Description").assertValue strDescription

	ivm.page(Common_page).webElement("Emailrecipients").assertExist "True"
	ivm.page(Common_page).webElement("Emailrecipients").assertStatus "Visible"


	ivm.page(Common_page).webLink("AddRecipient").assertExist "True"
	ivm.page(Common_page).webLink("AddRecipient").assertStatus "Visible"


	ivm.page(Common_page).webLink("SaveChanges").assertExist "True"
	ivm.page(Common_page).webLink("SaveChanges").assertStatus "Visible"


	ivm.page(Common_page).webLink("Cancel").assertExist "True"
	ivm.page(Common_page).webLink("Cancel").assertStatus "Visible"	
				
	'ivm.page(Common_page).webLink("AddRecipient").press
	'wait 3			
			
				
	ivm.page(Common_page).webList("EmailType").assertSelectedItem strUserName
    ivm.page(Common_page).webList("User").assertSelectedItem strUser
 
    ivm.page(Common_page).webLink("Cancel").press
	wait 3
	
	ivm.page(Common_page).webLink("BackToPreviousPage").assertExist "True"
     ivm.page(Common_page).webLink("BackToPreviousPage").assertStatus "Visible"

     ivm.page(Common_page).webElement("NotificationGroupDetails").assertExist "True"
     ivm.page(Common_page).webElement("NotificationGroupDetails").assertStatus "Visible"
	 
	 ivm.page(Common_page).webElement("NotificationGroupDetails").assertText "Notification Group Details"
	 
	 ivm.page(Common_page).webElement("NotificationGroupName").assertExist "True"
     ivm.page(Common_page).webElement("NotificationGroupName").assertStatus "Visible"
	 
	 ivm.page(Common_page).webElement("NotificationGroupName").assertText strName & " Details"

     ivm.page(Common_page).webElement("Name").assertExist "True"
     ivm.page(Common_page).webElement("Name").assertStatus "Visible"
	 
	 ivm.page(Common_page).webElement("Name_Value").assertExist "True"
     ivm.page(Common_page).webElement("Name_Value").assertStatus "Visible"
     ivm.page(Common_page).webElement("Name_Value").assertText strName
	 
	 ivm.page(Common_page).webElement("Description").assertExist "True"
	 ivm.page(Common_page).webElement("Description").assertStatus "Visible"
	 
	  ivm.page(Common_page).webElement("Description_Value").assertExist "True"
	 ivm.page(Common_page).webElement("Description_Value").assertStatus "Visible"
	 
	 ivm.page(Common_page).webElement("Description_Value").assertText strDescription

     ivm.page(Common_page).webElement("Emailrecipients").assertExist "True"
     ivm.page(Common_page).webElement("Emailrecipients").assertStatus "Visible"
	
    

'End Test Case
executionController.stopTestCase_w_TestCaseNumber "NotificationGroups_NameLink_ValidateEdit", "ALC_NGP_TC_14"	