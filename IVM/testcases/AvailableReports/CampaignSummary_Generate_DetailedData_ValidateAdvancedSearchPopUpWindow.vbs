'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	CampaignSummary_Generate_DetailedData_ValidateAdvancedSearchPopUpWindow
' Description					:	Validate the UIControls on advanced search window
' Author 						:   Fonantrix Solution
' Date 							:   09-04-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "CampaignSummary_Generate_DetailedData_ValidateAdvancedSearchPopUpWindow", "REP_CSR_TC_040"

DataSet=testcasedata.getvalue("DataSet")
strEmail=testcasedata.getvalue("strEmail")
strStorageLocation=testcasedata.getvalue("strStorageLocation")
strReportFormat=testcasedata.getvalue("strReportFormat")
strDataType=testcasedata.getvalue("strDataType")
strComments=testcasedata.getvalue("strComments")
strTimeRange=testcasedata.getvalue("strTimeRange")
strCampaign=testcasedata.getvalue("strCampaign")
status=Browser("SeaChangeManagementConsole").Page("pgAvailableReports").Frame("Frame").Exist(10)
if status=False Then
Browser("SeaChangeManagementConsole").Refresh
end if
ivm.ClickToMenu MENU_AVAILABLE_REPORTS
wait Wait10
DataSet=DATASET_CAMPAIGNSUMMARY

With ivm.page(report_page)

						.webTable("AvailableReports").presstblLink reportCampaignSummary,3
						 wait Wait5	
						 .webLink("AdvancedSearch").press
						wait Wait3
						.webEdit("DatasetName").setValue DataSet
						.webLink("AdvSearch").press
						wait wait5
						
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
						wait Wait7
						
						
						REM strTimeRange=testcasedata.getvalue("strTimeRange")
						REM .selectListItem MULTI_LIST_TIMERANGE_AVAI1,strTimeRange,"True"
						REM wait wait2
						REM strCampaign=testcasedata.getvalue("strCampaign")
						REM .selectListItem MULTI_LIST_CAMPAIGNNAMES_AVAI,strCampaign,"True"
						REM wait Wait2
						.webEdit("EmailRecipients").setValue strEmail
							
						.webEdit("StorageLocation").setValue strStorageLocation
							
						.webList("ReportFormat").selectItem strReportFormat
							
						.webList("DataType").selectItem strDataType
							
						.webEdit("Comments").setValue strComments
						.webButton("Generate").press
						wait Wait10
End with 

With ivm.page(detailedData_page)	

						.webLink("DetailedData").press
						wait Wait7
							
							.webLink("AdvancedSearch").press
							wait Wait3
							
							.webElement("SearchTerm_Adv").assertExist "True"
							.webElement("SearchTerm_Adv").assertStatus "Visible"
							.webEdit("SearchTerm_Adv").assertExist "True"
							.webEdit("SearchTerm_Adv").assertStatus "Visible"
							.webEdit("SearchTerm_Adv").assertValue "Search..."
							
							.webElement("ElementNumber_Adv").assertExist "True"
							.webElement("ElementNumber_Adv").assertStatus "Visible"
							.webEdit("ElementNumber_Adv").assertExist "True"
							.webEdit("ElementNumber_Adv").assertStatus "Visible"
							
							.webElement("CampaignName_Adv").assertExist "True"
							.webElement("CampaignName_Adv").assertStatus "Visible"
							.webEdit("CampaignName_Adv").assertExist "True"
							.webEdit("CampaignName_Adv").assertStatus "Visible"
							
							.webElement("ClockNumber_Adv").assertExist "True"
							.webElement("ClockNumber_Adv").assertStatus "Visible"
							.webEdit("ClockNumber_Adv").assertExist "True"
							.webEdit("ClockNumber_Adv").assertStatus "Visible"
							
							.webElement("ProgramPID_Adv").assertExist "True"
							.webElement("ProgramPID_Adv").assertStatus "Visible"
							.webEdit("ProgramPID_Adv").assertExist "True"
							.webEdit("ProgramPID_Adv").assertStatus "Visible"
							
							
							.webElement("TimeRange_Adv").assertExist "True"
							.webElement("TimeRange_Adv").assertStatus "Visible"
							.webEdit("TimeRange_Adv").assertExist "True"
							.webEdit("TimeRange_Adv").assertStatus "Visible"
							.webEdit("TimeRange_Adv").assertValue "Type to search..."
														
							
							.webLink("AdvSearch").assertExist "True"
							.webLink("AdvSearch").assertStatus "Visible"
							
							.webLink("AdvCancel").assertExist "True"
							.webLink("AdvCancel").assertStatus "Visible"
							
							.webLink("AdvClearAll").assertExist "True"
							.webLink("AdvClearAll").assertStatus "Visible"
							
							
							.webLink("AdvCancel").press
							
                           
End with

			
'End Test Case
executionController.stopTestCase_w_TestCaseNumber "CampaignSummary_Generate_DetailedData_ValidateAdvancedSearchPopUpWindow", "REP_CSR_TC_040"