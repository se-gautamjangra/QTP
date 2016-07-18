'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	EndOfCampaign_Generate_PreferredData_ValidateWithWebServiceData 
' Description					:	Validate the UI controls of Preferred Data tab.
' Author 						:   Fonantrix Solution
' Date 							:   29-05-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "EndOfCampaign_Generate_PreferredData_ValidateWithWebServiceData", "REP_EOC_TC_023"

'DataSet=testcasedata.getvalue("DataSet")
strCampaign=testcasedata.getvalue("strCampaign")
strEmail=testcasedata.getvalue("strEmail")
strStorageLocation=testcasedata.getvalue("strStorageLocation")
strReportFormat=testcasedata.getvalue("strReportFormat")
strDataType=testcasedata.getvalue("strDataType")
strComments=testcasedata.getvalue("strComments")
strTimeRange=testcasedata.getvalue("strTimeRange")
DataSet=DATASET_ENDOFCAMPAIGN
if status=False Then
Browser("SeaChangeManagementConsole").Refresh
end if
ivm.NavigateToMenu MENU_AVAILABLE_REPORTS
wait 15
with ivm.page(report_page)

						 .webTable("AvailableReports").presstblLink reportEndOfCampaign,3
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
						
						.selectListItem MULTI_LIST_TIMERANGE_AVAI1,strTimeRange,"True"
						
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

							.webTable("PreferredData_EOC").assertExist "True"
							
							
							.webTable("PreferredData_EOC").assertTableData reportEndOfCampaignPreferred,DataSet
							
							
End with	

'End Test Case
executionController.stopTestCase_w_TestCaseNumber "EndOfCampaign_Generate_PreferredData_ValidateWithWebServiceData", "REP_EOC_TC_023"