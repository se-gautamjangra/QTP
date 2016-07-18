'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	EndOfCampaign_Generate_FilterAndComments_ValidateUIControls
' Description					:   Validate UI of "End Of Campaign" report in Filters And Comments tab with different options.
' Author 						:   Fonantrix Solution
' Date 							:   29-05-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "EndOfCampaign_Generate_FilterAndComments_ValidateUIControls", "REP_EOC_TC_022"
   

DataSet=testcasedata.getvalue("DataSet")
strTimeRange=testcasedata.getvalue("strTimeRange")
strCampaign=testcasedata.getvalue("strCampaign")
strEmail=testcasedata.getvalue("strEmail")
strStorageLocation=testcasedata.getvalue("strStorageLocation")
strReportFormat=testcasedata.getvalue("strReportFormat")
strDataType=testcasedata.getvalue("strDataType")
strComments=testcasedata.getvalue("strComments")


ivm.NavigateToMenu MENU_AVAILABLE_REPORTS
wait 10
With ivm.page(report_page)

						.webTable("AvailableReports").presstblLink reportEndOfCampaign,3
						 wait 10	
						 
						.webTable("DataSet").presstblRadioBtn DataSet,1 
						wait 7
						.selectListItem MULTI_LIST_TIMERANGE_AVAI1,strTimeRange,"True"
						
						.webEdit("EmailRecipients").setValue strEmail
							
						.webEdit("StorageLocation").setValue strStorageLocation
							
						.webList("ReportFormat").selectItem strReportFormat
							
						.webList("DataType").selectItem strDataType
							
						.webEdit("Comments").setValue strComments
						.webButton("Generate").press
						wait 10
End with 

REM 'Market Details table exist					
with ivm.page(preferredData_page)

							.webLink("BackToPreviousPage").assertExist "True"
							.webLink("BackToPreviousPage").assertStatus "Visible"

							.webElement("CampaignSummary").assertExist "True"
							.webElement("CampaignSummary").assertStatus "Visible"
							
						    .webElement("TimeStamp").assertExist "True"
							.webElement("TimeStamp").assertStatus "Visible"
                             wait 5
							.webLink("FiltersAndComments").assertExist "True"
							.webLink("FiltersAndComments").assertStatus "Visible"
							
							.webLink("PreferredData").assertExist "True"
							.webLink("PreferredData").assertStatus "Visible"
							 wait 5
							.webLink("DetailedData").assertExist "True"
							.webLink("DetailedData").assertStatus "Visible"

						    .webLink("Actions").assertExist "True"
							.webLink("Actions").assertStatus "Visible"							
							.webLink("Actions").press							
							 

							'.webElement("ExportToPDF").assertExist "True"
							'.webElement("ExportToPDF").assertStatus "Visible"
		                     
							.webLink("ExportToCSV").assertExist "True"
							.webLink("ExportToCSV").assertStatus "Visible"
		                     
							.webLink("ExportToXLS").assertExist "True"
							.webLink("ExportToXLS").assertStatus "Visible"
		                      
							.webElement("FilterOptions").assertExist "True"
							.webElement("FilterOptions").assertStatus "Visible"
		                     
							
							.webElement("TimeRange").assertExist "True"
							.webElement("TimeRange").assertStatus "Visible"
							 
							.assertExistWE strTimeRange,"True"
							
							.webElement("Comments").assertExist "True"
							.webElement("Comments").assertStatus "Visible"
							
							.webElement("Comments_val").assertText strComments
							
							
							 
					        .webLink("BackToPreviousPage").press
			                 wait 5
End with

with ivm.page(report_page)
							.webTable("DataSet").presstblRadioBtn DataSet,1
							
							wait 5
							
							.webButton("Generate").press
					        wait 5
End With

With ivm.page(preferredData_page)							

							.webElement("TimeRange").assertExist "False"
		
							.webElement("Comments").assertExist "False"
							
End With	
'End Test Case
executionController.stopTestCase_w_TestCaseNumber "EndOfCampaign_Generate_FilterAndComments_ValidateUIControls", "REP_EOC_TC_022"