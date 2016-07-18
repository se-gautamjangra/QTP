'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	CampaignSummaryReport_Generate_PreferredData_AdvancedSearchPopUpWindow_ValidateClearAll
' Description					:	Validate the clear all operation on advanced search window
' Author 						:   Fonantrix Solution
' Date 							:   08-04-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "CampaignSummaryReport_Generate_PreferredData_AdvancedSearchPopUpWindow_ValidateClearAll", "REP_CSR_TC_026"

START_DATE=REPORT_START_DATE1
END_DATE=REPORT_END_DATE1
strSites=testcasedata.getvalue("strSites")
strProviderId=testcasedata.getvalue("strProviderId")
strCampaign=testcasedata.getvalue("strCampaign")
strGrouping=testcasedata.getvalue("strGrouping")
strComments=testcasedata.getvalue("strComments")
strProgramPID=testcasedata.getvalue("strProgramPID")
strElementNumber=testcasedata.getvalue("strElementNumber")
strCampaignName=testcasedata.getvalue("strCampaignName")

ivm.NavigateToMenu MENU_AVAILABLE_REPORTS
wait 10
 
with ivm.page(report_page)

					    .webTable("AvailableReports").presstblLink reportCampaignSummary,3
						 wait 5
						 
					    .selectDate reportCampaignSummary,"StartDate",START_DATE

						.selectDate reportCampaignSummary,"EndDate",END_DATE
						
						.selectListItem MULTI_LIST_SITES,strSites,"True"
						wait 3																	
						.selectListItem MULTI_LIST_PROVIDERIDS,strProviderId,"True"
						wait 3
						.selectListItem MULTI_LIST_CAMPAIGNS,strCampaign,"True"
						wait 3
						.webList("Grouping").selectItem strGrouping
						wait 3
						
						.webEdit("Comments").setValue strComments
						
						.webbutton("Generate").press 
						wait 8
						
End with	

With ivm.page(reportgen_page)	

						.webLink("PreferredData").press
						wait 5
						
						.webLink("AdvancedSearch").press
						wait 3
						
						.webEdit("ElementNumber").setValue strElementNumber
						wait 3
						.selectListItem MULTI_LIST_CAMPAIGNNAME,strCampaignName,"True"
						wait 3
						.webEdit("ProgramPID").setValue strProgramPID
						wait 3
						
						.selectDate reportCampaignSummary,"StartDate",START_DATE
						
						.selectDate reportCampaignSummary,"EndDate",END_DATE
					
						.webLink("AdvClearAll").press
						wait 5
					
						.webEdit("ElementNumber").assertValue ""
						wait 3
						.validateSelectedListItem MULTI_LIST_CAMPAIGNNAME,strCampaign,"False"
						wait 3
						.webEdit("ProgramPID").assertValue ""
						wait 3
						.webEdit("Between").assertValue ""
						wait 3
						.webEdit("And").assertValue ""
						wait 3
						
						.webLink("AdvCancel").press
						wait 5
						
						.webLink("BackToPreviousPage").press
						wait 10
End with

with ivm.page(report_page)
					
							.webButton("Cancel").press
							wait 5
End with

'End Test Case
executionController.stopTestCase_w_TestCaseNumber "CampaignSummaryReport_Generate_PreferredData_AdvancedSearchPopUpWindow_ValidateClearAll", "REP_CSR_TC_026"