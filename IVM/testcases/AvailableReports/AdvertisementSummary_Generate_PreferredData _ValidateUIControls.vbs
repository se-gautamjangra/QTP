'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	AdvertisementSummary_Generate_PreferredData_ValidateUIControls 
' Description					:	Validate the UIControls on preffered data page.
' Author 						:   Fonantrix Solution
' Date 							:   03-07-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "AdvertisementSummary_Generate_PreferredData_ValidateUIControls", "REP_ASR_TC_020"


'DataSet=testcasedata.getvalue("DataSet")
strTimeRange=testcasedata.getvalue("strTimeRange")
strCampaign=testcasedata.getvalue("strCampaign")
strProgramPID=testcasedata.getvalue("strProgramPID")
strEmail=testcasedata.getvalue("strEmail")
strStorageLocation=testcasedata.getvalue("strStorageLocation")
strReportFormat=testcasedata.getvalue("strReportFormat")
strDataType=testcasedata.getvalue("strDataType")
strComments=testcasedata.getvalue("strComments")

status=Browser("SeaChangeManagementConsole").Page("pgAvailableReports").Frame("Frame").Exist(10)
if status="False" Then
Browser("SeaChangeManagementConsole").Refresh
end if

ivm.NavigateToMenu MENU_AVAILABLE_REPORTS
wait Wait10
DataSet=DATASET_ADSUMMARY
With ivm.page(report_page)

						.webTable("AvailableReports").presstblLink reportAdvertisementSummary,3
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
						wait Wait7

						wait Wait2
						.webEdit("EmailRecipients").setValue strEmail
							
						.webEdit("StorageLocation").setValue strStorageLocation
							
						.webList("ReportFormat").selectItem strReportFormat
							
						.webList("DataType").selectItem strDataType
							
						.webEdit("Comments").setValue strComments
						.webButton("Generate").press
						wait Wait10
End with 

REM 'Market Details table exist					
with ivm.page(preferredData_page)
							.webLink("PreferredData").press
							 wait Wait5

					
							
							.webEdit("SearchTerm").assertExist "True"
							.webEdit("SearchTerm").assertStatus "Visible"
							
							.webLink("AdvancedSearch").assertExist "True"
							.webLink("AdvancedSearch").assertStatus "Visible"
							
							.webTable("PreferredData_AS").assertExist "True"
														
							.webTable("PreferredData_Header_AS").assertColumnExist "Time Range", "True"
													
						    .webTable("PreferredData_Header_AS").assertColumnExist "Element Number", "True"
							
							.webTable("PreferredData_Header_AS").assertColumnExist "Clock Number", "True"
							
							.webTable("PreferredData_Header_AS").assertColumnExist "Program Provider", "True"
							
							.webTable("PreferredData_Header_AS").assertColumnExist "Ad Break", "True"
							
							.webTable("PreferredData_Header_AS").assertColumnExist "Ad Slot Position", "True"
																			
							.webTable("PreferredData_Header_AS").assertColumnExist "Total Ad Views", "True"
							
	
End with
			
'End Test Case
executionController.stopTestCase_w_TestCaseNumber "AdvertisementSummary_Generate_PreferredData_ValidateUIControls", "REP_ASR_TC_020"