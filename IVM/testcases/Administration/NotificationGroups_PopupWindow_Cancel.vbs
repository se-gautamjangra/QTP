'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Seachange
'
' File Name						:	NotificationGroups_PopupWindow_Cancel
' Description					:	Validate Functionality of Delete popup window
' Author 						:   Fonantrix Solution
' Date 							:   20-06-2012
'--------------------------------------------------------------------------------------------------------------------------------------------------
 
 'Start Test Case a

executionController.startTestCase_w_TestCaseNumber "NotificationGroups_PopupWindow_Cancel", "ALC_NGP_TC_18"
  ivm.NavigateToMenu MENU_NOTIFICATION_GROUPS
wait Wait5
strName = testcasedata.getvalue("Name")

     ivm.page(Common_page).webTable("NotificationGroups").assertValue strName,1
     ivm.page(Common_page).webTable("NotificationGroups").pressLink strName,"Delete",4
	 
	

     ivm.page(Common_page).webLink("DlDelete").assertExist "True"
     ivm.page(Common_page).webLink("DlDelete").assertStatus "Visible"

	

     ivm.page(Common_page).webLink("DlCancel").assertExist "True"
     ivm.page(Common_page).webLink("DlCancel").assertStatus "Visible"

     ivm.page(Common_page).webLink("DlCancel").press
     wait 3
	 
	 
	 
	 
     ivm.page(Common_page).webElement("NotificationGroups").assertExist "True"
     ivm.page(Common_page).webElement("NotificationGroups").assertStatus "Visible"
	 
	 ivm.page(Common_page).webTable("NotificationGroups").assertValue strName,1



'End Test Case	 
executionController.stopTestCase_w_TestCaseNumber "NotificationGroups_PopupWindow_Cancel", "ALC_NGP_TC_18"