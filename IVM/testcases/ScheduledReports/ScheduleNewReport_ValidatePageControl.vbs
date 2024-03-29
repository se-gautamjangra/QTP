'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright SeaChange
'
' File Name						:	ScheduleNewReport_ValidatePageControl
' Description					:	Validate the Page Controls of the Schedule new report page.
' Author 						:   SeaChange
' Date 							:   30-05-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

executionController.startTestCase_w_TestCaseNumber "ScheduleNewReport_ValidatePageControl", "SCR_NEW_RDR_TC_001"

ivm.NavigateToMenu MENU_SCHEDULED_REPORTS
wait 15

'ReportName=testCaseData.getValue("ReportName")


with ivm.page(ScheduledReports_Page)
			
				
									.webLink("ScheduleNewReport").press
									 wait 10
									 
									.webLink("BackToPrevious").assertStatus "Visible"
									.webLink("BackToPrevious").assertExist "True"
																		
									.webElement("ScheduleNewReport").assertExist "True"
									.webElement("ScheduleNewReport").assertStatus "Visible"
									
									.webElement("SelectReport").assertExist "True"
									.webElement("SelectReport").assertStatus "Visible"
									
									.weblist("SelectRowCount_2").selectItem "Show 40 rows"
									
									.webTable("ReportType").assertExist "True"
									.webTable("ReportType_Header").assertExist "True"
									.webTable("ReportType_Header").assertColumnExist "Report Name", "True"
									.webTable("ReportType_Header").assertColumnExist "Description", "True"
									.webTable("ReportType_Header").assertColumnExist "Report Name", "True"
									
									.webRadiogroup("ReportType").assertExist "True"
									
									.webRadiogroup("ReportType").selectGroupItem "Raw Data"
									 wait 8
									 
									 .webElement("Parameters").assertExist "True"
									 .webElement("Parameters").assertStatus "Visible"
									
									
									.webElement("ScheduleOptions").assertExist "True"
									.webElement("ScheduleOptions").assertStatus "Visible"
									
									.webRadiogroup("GenerateOption").assertExist "True"
									.webRadiogroup("GenerateOption").assertStatus "Visible"
								    wait 2 
									.webElement("GenerateReportNow").assertExist "True"
									.webElement("GenerateReportNow").assertStatus "Visible"
									
									.webElement("GenerateReportOnDate").assertExist "True"
									
									.webElement("GenerateReportOnDate").assertStatus "Visible"
									
									
									.webElement("ScheduleDate").assertExist "True"
									.webElement("ScheduleDate").assertStatus "Visible"
									.webEdit("ScheduleDate").assertExist "True"
									.webEdit("ScheduleDate").assertStatus "Visible"
									.webEdit("ScheduleDate").assertValue "dd-mm-yyyy"
								
									.webElement("Time").assertExist "True"
									.webElement("Time").assertStatus "Visible"
									.webEdit("Time").assertExist "True"
									.webEdit("Time").assertStatus "Visible"
									.webEdit("Time").assertValue "00:00"
									
									.webImage("Watch").assertExist "True"
									.webImage("Watch").assertStatus "Visible"
								
									.webList("Frequency").assertExist "True"
									.webList("Frequency").assertStatus "Visible"
								
									.webElement("DefaultReportGenerate").assertExist "True"
									.webElement("DefaultReportGenerate").assertStatus "Visible"
									
									
									.webElement("EmailAndStorageOptions").assertExist "True"
									.webElement("EmailAndStorageOptions").assertStatus "Visible"
                                     
									.webElement("EmailRecipients").assertExist "True"
									.webElement("EmailRecipients").assertStatus "Visible"
									.webEdit("EmailRecipients").assertExist "True"
									.webEdit("EmailRecipients").assertStatus "Visible"
								
									.webButton("AddRecipient").assertExist "True"
									.webButton("AddRecipient").assertStatus "Visible"
									
									.webElement("StorageLocation").assertExist "True"
									.webElement("StorageLocation").assertStatus "Visible"
									.webEdit("StorageLocation").assertExist "True"
									.webEdit("StorageLocation").assertStatus "Visible"
									
									.webElement("ReportFormat").assertExist "True"
									.webElement("ReportFormat").assertStatus "Visible"
									.webList("ReportFormat").assertExist "True"
									.webList("ReportFormat").assertStatus "Visible"
								
									
									.webElement("DataType").assertExist "True"
									.webElement("DataType").assertStatus "Visible"
									.webList("DataType").assertExist "True"
									.webList("DataType").assertStatus "Visible"
								
									
									.webCheckBox("CompressTheFile").assertExist "True"
									.webCheckBox("CompressTheFile").assertStatus "Visible"
									.webElement("CompressTheFile").assertExist "True"
									.webElement("CompressTheFile").assertStatus "Visible"
								
									
									.webElement("Comments").assertExist "True"
									.webElement("Comments").assertStatus "Visible"
									.webEdit("Comments").assertExist "True"
									.webEdit("Comments").assertStatus "Visible"
								
									.webButton("Schedule").assertExist "True"
									.webButton("Schedule").assertStatus "Visible"
									
									.webButton("Cancel").assertExist "True"
									.webButton("Cancel").assertStatus "Visible"
									
									.webButton("Cancel").press			
			
										
			
end with

executionController.stopTestCase_w_TestCaseNumber "ScheduleNewReport_ValidatePageControl", "SCR_NEW_RDR_TC_001"

