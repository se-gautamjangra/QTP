'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	UniqueCustomers_ValidateCancel
' Description					:	Validate the Cancel operation on generate options page .
' Author 						:   Fonantrix Solution
' Date 							:   05-07-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "UniqueCustomers_ValidateCancel", "REP_UCR_TC_018"
status=Browser("SeaChangeManagementConsole").Page("pgAvailableReports").Frame("Frame").Exist(10)
if status=False Then
Browser("SeaChangeManagementConsole").Refresh
end if
DataSet=testcasedata.getvalue("DataSet")
ProviderID_val=testcasedata.getvalue("ProviderID_val")
strTimeRange=testcasedata.getvalue("strTimeRange")
Campaign_val=testcasedata.getvalue("Campaign_val")
strProgramPID=testcasedata.getvalue("strProgramPID")
strEmail=testcasedata.getvalue("strEmail")
strStorageLocation=testcasedata.getvalue("strStorageLocation")
strReportFormat=testcasedata.getvalue("strReportFormat")
strDataType=testcasedata.getvalue("strDataType")
strComments=testcasedata.getvalue("strComments")

ivm.ClickToMenu MENU_AVAILABLE_REPORTS
wait Wait10

DataSet=DATASET_UNIQUECUSTOMERS

With ivm.page(report_page)

							.webTable("AvailableReports").presstblLink reportUniqueCustomers,3
							 wait Wait10	
						 
							.webLink("AdvancedSearch").press
							wait Wait3
							.webEdit("DatasetName").setValue DataSet
							.webLink("AdvSearch").press
							wait Wait3
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
							.webButton("Cancel").press
							wait Wait5
			
							.webTable("AvailableReports").assertExist "True"
							
							.webTable("AvailableReports").presstblLink reportUniqueCustomers,3
							 wait Wait10	
							.webButton("Cancel").press
							
							wait Wait5
							.webTable("AvailableReports").assertExist "True"
End with						
		
'End Test Case
executionController.stopTestCase_w_TestCaseNumber "UniqueCustomers_ValidateCancel", "REP_UCR_TC_018"