'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	RegionSummary_Generate_DetailedData_ValidateUIControls
' Description					:	Validate the UI controls of Detailed Data tab.
' Author 						:   Fonantrix Solution
' Date 							:   03-07-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "RegionSummary_Generate_DetailedData_ValidateUIControls", "REP_RSR_TC_036"

DataSet=testcasedata.getvalue("DataSet")
strEmail=testcasedata.getvalue("strEmail")
strStorageLocation=testcasedata.getvalue("strStorageLocation")
strReportFormat=testcasedata.getvalue("strReportFormat")
strDataType=testcasedata.getvalue("strDataType")
strComments=testcasedata.getvalue("strComments")


ivm.ClickToMenu MENU_AVAILABLE_REPORTS
wait 7

With ivm.page(report_page)

						.webTable("AvailableReports").presstblLink reportRegionSummary,3
						 wait 10	
						 
						.webTable("DataSet").presstblRadioBtn DataSet,1 
						wait 7
						
						.webEdit("EmailRecipients").setValue strEmail
							
						.webEdit("StorageLocation").setValue strStorageLocation
							
						.webList("ReportFormat").selectItem strReportFormat
							
						.webList("DataType").selectItem strDataType
							
						.webEdit("Comments").setValue strComments
						.webButton("Generate").press
						wait 10
End with 
	
	

With ivm.page(detailedData_page)	

						.webLink("DetailedData").press
						wait 5
						
											
						.webEdit("Search").assertExist "True"
						.webEdit("Search").assertStatus "Visible"
						
						.webLink("AdvancedSearch").assertExist "True"
						.webLink("AdvancedSearch").assertStatus "Visible"
						
						.webTable("DetailedData_Header_RS").assertExist "True"
						
						.webTable("DetailedData_RS").assertExist "True"
				
						.webTable("DetailedData_Header_RS").assertColumnExist "Time Range", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Campaign Name", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Program PID", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Program PAID", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Clock Number", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Unique Customers", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Channel", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Program Title", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Program Series Title", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Advert Placements", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Advert Full Views", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Advert Partial Views", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Advert Fasr Forward Views", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Advert Placements Not Viewed", "True"
											
						.webTable("DetailedData_Header_RS").assertColumnExist "Total Home Views", "True"
						
						.webTable("DetailedData_Header_RS").assertColumnExist "Total Ad Views", "True"
						
End with
executionController.stopTestCase_w_TestCRDeNumber "RegionSummary_Generate_DetailedData_ValidateUIControls", "REP_RSR_TC_036"