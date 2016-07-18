'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	ProgramSummary_Generate_PreferredData_AdvancedSearchPopUpWindow_ValidateProgramTitle
' Description					:	Validate the Program Summary filter using advanced search.
' Author 						:   Fonantrix Solution
' Date 							:   01-07-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "ProgramSummary_Generate_PreferredData_AdvancedSearchPopUpWindow_ValidateProgramTitle", "REP_PSR_TC_028"

DataSet=testcasedata.getvalue("DataSet")
strTimeRange=testcasedata.getvalue("strTimeRange")
strCampaign=testcasedata.getvalue("strCampaign")
strEmail=testcasedata.getvalue("strEmail")
strStorageLocation=testcasedata.getvalue("strStorageLocation")
strReportFormat=testcasedata.getvalue("strReportFormat")
strDataType=testcasedata.getvalue("strDataType")
strComments=testcasedata.getvalue("strComments")
strProgramTitle=testcasedata.getvalue("strProgramTitle")
strProgramTitle1=testcasedata.getvalue("strProgramTitle1")
strProgramTitleInv=testcasedata.getvalue("strProgramTitleInv")

ivm.ClickToMenu MENU_AVAILABLE_REPORTS
wait 7

With ivm.page(report_page)

						.webTable("AvailableReports").presstblLink reportProgramSummary,3
						 wait 10	
						 
						.webTable("DataSet").presstblRadioBtn DataSet,1 
						wait 7
						.selectListItem MULTI_LIST_TIMERANGE_AVAI1,strTimeRange,"True"
						.selectListItem MULTI_LIST_CAMPAIGNNAMES_AVAI,strCampaign,"True"
						wait 2
						.webEdit("EmailRecipients").setValue strEmail
							
						.webEdit("StorageLocation").setValue strStorageLocation
							
						.webList("ReportFormat").selectItem strReportFormat
							
						.webList("DataType").selectItem strDataType
							
						.webEdit("Comments").setValue strComments
						.webButton("Generate").press
						wait 10
End with 
	

With ivm.page(preferredData_page)	

							.webLink("PreferredData").press
							wait 4
							
						    .webLink("AdvancedSearch").press
							wait 3
							
							.webEdit("ProgramTitle_Adv").setValue strProgramTitle
						   
							.webLink("AdvSearch").press
							.webElement("ProgramTitle_Filter").assertExist "True"
							If len(strProgramTitle)>9 then 
							.webElement("ProgramTitle_Filter").assertText  "Program Title ="& mid(strProgramTitle,1,10) &".." &"   X"
							
							Else
							.webElement("ProgramTitle_Filter").assertText  "Program Title ="& strProgramTitle &"   X"
							
							End If
						    .webLink("ClearAll").assertExist "True"
							.webLink("ClearAll").assertStatus "Visible"
							
							.webTable("PreferredData_PS").assertExist "True"
							
						
							.webTable("PreferredData_PS").assertValue strProgramTitle,"4"
							wait 5	
							.webTable("PreferredData_PS").assertDelValue strProgramTitle1
							.webLink("ClearAll").press
							wait 5
							.webElement("ProgramTitle_Filter").assertExist "False"
							
							
							.webTable("PreferredData_PS").assertValue strProgramTitle1,"4"
				
							
							
REM 'For invalid
							.webLink("AdvancedSearch").press
							wait 5
							
							.webEdit("ProgramTitle_Adv").setValue strProgramTitleInv
						   
							.webLink("AdvSearch").press
							wait 5	
							
							'.webTable("SearchCriteria_CS").assertExist "True" 
							' .webTable("SearchCriteria_CS").assertStatus "Visible"
							
							.webElement("ProgramTitle_Filter").assertExist "True"
							If len(strProgramTitleInv)>9 then 
							.webElement("ProgramTitle_Filter").assertText  "Program Title ="& mid(strProgramTitleInv,1,10) &".." &"   X"
							
							Else
							.webElement("ProgramTitle_Filter").assertText  "Program Title ="& strProgramTitleInv &"   X"
							End If
							
							.webElement("ProgramTitle_Filter").assertExist "True"
							.webLink("ClearAll").assertExist "True"
							.webLink("ClearAll").assertStatus "Visible"
							
							.webTable("PreferredData_PS").assertExist "True"
						
							.webTable("PreferredData_PS").searchData NoRecordFound_msg
							
							.webTable("PreferredData_PS").assertDelValue strProgramTitle
							.webTable("PreferredData_PS").assertDelValue strProgramTitle1
							wait 5
							
							.webLink("ClearAll").press
							
							wait 5
							.webElement("ProgramTitle_Filter").assertExist "False"
							
							'.webLink("ClearAll").assertExist "False"
							
							.webTable("PreferredData_PS").assertValue strProgramTitle,"4"
							
							.webTable("PreferredData_PS").assertValue strProgramTitle1,"4"
							
							.webTable("PreferredData_PS").assertDelValue NoRecordFound_msg
							
					        
End with				
'End Test Case
executionController.stopTestCase_w_TestCaseNumber "ProgramSummary_Generate_PreferredData_AdvancedSearchPopUpWindow_ValidateProgramTitle", "REP_PSR_TC_028"