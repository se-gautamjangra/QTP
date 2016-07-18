'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	RawData_GenerateOptionsLink_AdvanceSearchPopUpWindow_ValidateUser
' Description					:	Validate the UI Controls of "Advance Search" popup window.
' Author 						:   Fonantrix Solution
' Date 							:   03-07-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "RawData_GenerateOptionsLink_AdvanceSearchPopUpWindow_ValidateUser", "REP_RSR_TC_006"

ivm.ClickToMenu MENU_AVAILABLE_REPORTS
strUser=testcasedata.getvalue("strUser")
strUser1=testcasedata.getvalue("strUser1")
strUserInv=testcasedata.getvalue("strUserInv")
wait Wait10


with ivm.page(report_page)

						.webTable("AvailableReports").presstblLink reportRegionSummary,3
						wait Wait10

'---------------Assert Back to previous webLink-----------------------
						.webLink("AdvancedSearch").press
						wait Wait2
						
						
					
						.webEdit("User").setValue strDatSetName
						
						.webLink("AdvancedSearch").press
						wait Wait5
						.webElement("User_Filter").assertExist "True"
						If len(strDatSetName)>9 then 
							.webElement("User_Filter").assertText  "User ="& mid(strDatSetName,1,10) &".." &"   X"
							
						Else
						.webElement("User_Filter").assertText  "User ="& strDatSetName &"   X"
							
						End If
						.webLink("ClearAll").assertExist "True"
						.webLink("ClearAll").assertStatus "Visible"
						
						.webTable("DataSet").assertExist "True"
							
						
							.webTable("DataSet").assertValue strDatSetName,"3"
							wait Wait5	
							.webTable("DataSet").assertDelValue strDatSetName1
							.webLink("ClearAll").press
							wait Wait5
							.webElement("DataSetName_Filter").assertExist "False"
							
							'.webLink("ClearAll").assertExist "False"
							'.webLink("ClearAll").assertStatus "NotVisible"
							
							.webTable("DataSet").assertValue strDatSetName1,"3"
							wait Wait5
							
							
REM 'For invalid
							.webLink("AdvancedSearch").press
							wait Wait5
							
							.webEdit("User").setValue strUserInv
						    wait Wait2
							.webLink("AdvSearch").press
							wait Wait5	
							
							'.webTable("SearchCriteria_CS").assertExist "True" 
							' .webTable("SearchCriteria_CS").assertStatus "Visible"
							
							.webElement("User_Filter").assertExist "True"
							If len(strUserInv)>9 then 
							.webElement("User_Filter").assertText  "User ="& mid(strUserInv,1,10) &".." &"   X"
							
							Else
							.webElement("User_Filter").assertText  "User ="& strUserInv &"   X"
							End If
							
							.webElement("User_Filter").assertExist "True"
							.webLink("ClearAll").assertExist "True"
							.webLink("ClearAll").assertStatus "Visible"
							
							.webTable("DataSet").assertExist "True"
						
							.webTable("DataSet").searchData NoRecordFound_msg
							
							.webTable("DataSet").assertDelValue strUser
							.webTable("DataSet").assertDelValue strUser1
							wait Wait5
							
							.webLink("ClearAll").press
							
							wait Wait5
							.webElement("User_Filter").assertExist "False"
							
							'.webLink("ClearAll").assertExist "False"
							
							.webTable("DataSet").assertValue strUser,"3"
							
							.webTable("DataSet").assertValue strUser1,"3"
							
							.webTable("DataSet").assertDelValue NoRecordFound_msg
							
			
End with						         
'End Test Case				
executionController.stopTestCase_w_TestCaseNumber "RawData_GenerateOptionsLink_AdvanceSearchPopUpWindow_ValidateUser", "REP_RSR_TC_006"			