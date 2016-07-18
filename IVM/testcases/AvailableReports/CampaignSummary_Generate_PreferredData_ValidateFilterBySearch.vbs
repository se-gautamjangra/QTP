'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	CampaignSummary_Generate_PreferredData_ValidateFilterBySearch
' Description					:   Validate the serarch functionality on Preferred Data tab..
' Author 						:   Fonantrix Solution
' Date 							:   10-05-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
 executionController.startTestCase_w_TestCaseNumber "CampaignSummary_Generate_PreferredData_ValidateFilterBySearch", "REP_CSR_TC_025"


strComments=testcasedata.getvalue("strComments")
strSearchInvalid=testcasedata.getvalue("strSearchInvalid")
strSearchValid=testcasedata.getvalue("strSearchValid")


DataSet=DATASET_CAMPAIGNSUMMARY
if status=False Then
Browser("SeaChangeManagementConsole").Refresh
end if
ivm.NavigateToMenu MENU_AVAILABLE_REPORTS
wait 15

With ivm.page(report_page)

						.webTable("AvailableReports").presstblLink reportCampaignSummary,3
						 wait Wait10
						 
											
										 
								.webLink("AdvancedSearch").press
								 wait Wait5
								.webEdit("DatasetName").setValue DataSet
								.webLink("AdvSearch").press
								 wait wait10
						
						status=Browser("SeaChangeManagementConsole").Page("pgAvailableReports").Frame("Frame").Exist(10)
						if status=False Then
							Browser("SeaChangeManagementConsole").Refresh
							wait wait8
							.webLink("AdvancedSearch").press
							wait Wait8
							.webEdit("DatasetName").setValue DataSet
							.webLink("AdvSearch").press
							wait wait8
						end if
						
						.webTable("DataSet").presstblRadioBtn DataSet,1 
						wait Wait10
							
												
						.webEdit("Comments").setValue strComments
						wait Wait5
						
						.webButton("Generate").press
						wait Wait8
End with 

With ivm.page(PreferredData_page)

							.weblink("PreferredData").press
							wait Wait4
							.webTable("PreferredData_CS").assertExist "True"
							.webEdit("FillterBySearch").assertExist "True"
							.webEdit("FillterBySearch").assertStatus "visible"
							.webEdit("FillterBySearch").press
							.webEdit("FillterBySearch").setValue strSearchInvalid
							wait Wait5
							.webElement("Gobutton").press
							wait Wait5
							
							.webElement("SearchTerm_filter").assertExist "True"
							If len(strSearchInvalid)>9 then 
							.webElement("SearchTerm_filter").assertText  "Search Term ="& mid(strSearchInvalid,1,8) &".." &"   X"
							
							Else
							.webElement("SearchTerm_filter").assertText  "Search Term ="& strSearchInvalid &"   X"
							
							End If
												
							
							.webTable("PreferredData_CS").assertExist "True"
							.webElement("SearchTerm_filter").assertExist "True"
							.webElement("SearchTerm_filter").assertStatus "Visible"
							
								.webTable("PreferredData_CS").searchData NoRecordFound_msg											
					        
							wait Wait5
							
							.webLink("ClearAll").press
							wait Wait7
							
'Search with valid data		
						
							
							.webEdit("FillterBySearch").setValue strSearchValid
							wait Wait5
							
							.webElement("Gobutton").press
							wait Wait5
							.webElement("SearchTerm_filter").assertExist "True"
							If len(strSearchValid)>9 then 
							.webElement("SearchTerm_filter").assertText  "Search Term ="& mid(strSearchValid,1,8) &".." &"   X"
							
							Else
							.webElement("SearchTerm_filter").assertText  "Search Term ="& strSearchValid &"   X"
							
							End If
												
							
							.webTable("PreferredData_CS").assertExist "True"
							.webElement("SearchTerm_filter").assertExist "True"
							.webElement("SearchTerm_filter").assertStatus "Visible"
												
							.webTable("PreferredData_CS").searchData strSearchValid	
							.webLink("ClearAll").press
							wait Wait2
							
							.webElement("SearchTerm_filter").assertExist "False"

							.webLink("BackToPreviousPage").press
							wait wait2

			
End with

with ivm.page(report_page)		
								
							.webButton("Cancel").press
							wait Wait5
										
End with

'End Test Case 
executionController.stopTestCase_w_TestCaseNumber "CampaignSummary_Generate_PreferredData_ValidateFilterBySearch", "REP_CSR_TC_025"