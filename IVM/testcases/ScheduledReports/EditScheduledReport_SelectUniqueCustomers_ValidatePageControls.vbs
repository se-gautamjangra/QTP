'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright SeaChange
'
' File Name						:	EditScheduledReport_SelectUniqueCustomers_ValidatePageControls
' Description					:	Validate the Page Controls of the Edit Report.
' Author 						:   SeaChange
' Date 							:   05-07-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

executionController.startTestCase_w_TestCaseNumber "EditScheduledReport_SelectUniqueCustomers_ValidatePageControls", "SCR_EDIT_ASR_TC_001"

ivm.NavigateToMenu MENU_SCHEDULED_REPORTS
wait 30

SearchVal=testcasedata.getvalue("SearchVal")
strCampaign=testcasedata.getvalue("strCampaign")
strProvider=testcasedata.getvalue("strProvider")
strSites=testcasedata.getvalue("strSites")
strFirstDate=FIRST_DATE
strLastDate=LAST_DATE
strScheduleDate=testcasedata.getvalue("strScheduleDate")
strTime=testcasedata.getvalue("strTime")
strEndDate=END_DATE
strGroupBy=testcasedata.getvalue("strGroupBy")
strFrequency=testcasedata.getvalue("strFrequency")
strEmail=testcasedata.getvalue("strEmail")
strComments=testcasedata.getvalue("strComments")
strFrequency=testcasedata.getvalue("strFrequency")
strStorageLocation=testcasedata.getvalue("strStorageLocation")
strReportFormat=testcasedata.getvalue("strReportFormat")
strDataType=testcasedata.getvalue("strDataType")

with ivm.page(ScheduledReports_Page)

                                     
			                        .webLink("ScheduleNewReport").press
									 wait Wait10
									
									.webRadiogroup("ReportType").selectGroupItem reportUniqueCustomers
									 wait 15
											
									.selectDate "FirstDate", strFirstDate
									
																
									.selectDate "LastDate", strLastDate
									
									.selectListItem MULTI_LIST_SITES,strSites,"True"
									 wait Wait3
									 
									
									.selectListItem MULTI_LIST_CAMPAIGN,strCampaign,"True"
									 wait Wait3
									 
									.webList("GroupBy").selectItem strGroupBy
									 wait Wait3
									 
									 SCHEDULED_TIME2=getDate("Time","EDT",5)
									 SCHEDULED_DATE=getDate("Date","EDT",0)
									 
									 SCHEDULED_TIME1=SCHEDULED_TIME2
									 SCHEDULED_TIME=SCHEDULED_TIME1
									 .selectDate "ScheduleDate", SCHEDULED_DATE
									 
									
									.webList("Frequency").selectitem strFrequency
									
																	
									.selectDate "EndDate", strEndDate
									 wait Wait2
									 
									
									.webEdit("Time").setValue SCHEDULED_TIME
									
																
									.webEdit("EmailRecipients").setvalue strEmail
									
									.webEdit("StorageLocation").setvalue strStorageLocation
									
									.webList("ReportFormat").selectItem strReportFormat
							
									.webList("DataType").selectItem strDataType
								
									
									.webEdit("Comments").setvalue strComments
									
									.webButton("Schedule").press
									wait Wait20
				                    SearchVal="Unique Customers" & ";" & "Every day at " & SCHEDULED_TIME &";" & "Edit Options"
										
				
									.webTable("ScheduledReports").selectRow SearchVal
									
									  wait 15
										
									.webElement("EditScheduledReport").assertStatus "Visible"
									.webElement("EditScheduledReport").assertExist "True"
									
									
									.webElement("GeneralReportInformation").assertExist "True"
									.webElement("GeneralReportInformation").assertStatus "Visible"
									
									.webElement("ReportName_UC").assertExist "True"
									.webElement("ReportName_UC").assertStatus "Visible"
									.webElement("ReportName_UC").assertText "Report Name: "& reportUniqueCustomers
									
									.webElement("Description_UC").assertExist "True"
									.webElement("Description_UC").assertStatus "Visible"
									.webElement("Description_UC").assertText "Description: "& Desc_UC
									
									
									
									.webElement("Parameters").assertExist "True"
									.webElement("Parameters").assertStatus "Visible"
									
									strEditFirstDate=ConvertDate(strFirstDate,"DATE-MON-YR")
									strEditLastDate=ConvertDate(strLastDate,"DATE-MON-YR")
								
									
																	
									.webList("FirstDate").assertExist "True"
									.webList("FirstDate").assertStatus "Visible"
									
									.webList("FirstDate").assertSelectedItem "Date"
									
									.webElement("FirstDate").assertExist "True"
									.webElement("FirstDate").assertStatus "Visible"
									
									.webEdit("FirstDate").assertExist "True"
									.webEdit("FirstDate").assertStatus "Visible"
									.webEdit("FirstDate").assertValue strEditFirstDate
									
									.webImage("FirstDate").assertExist "True"
									.webImage("FirstDate").assertStatus "Visible"
									
									.webList("LastDate").assertExist "True"
									.webList("LastDate").assertStatus "Visible"
									.webList("LastDate").assertSelectedItem "Date"
									
									.webElement("LastDate").assertExist "True"
									.webElement("LastDate").assertStatus "Visible"
									
									.webEdit("LastDate").assertExist "True"
									.webEdit("LastDate").assertStatus "Visible"
									.webEdit("LastDate").assertValue strEditLastDate
									
									.webImage("LastDate").assertExist "True"
									.webImage("LastDate").assertStatus "Visible"
									
									.webElement("Campaign").assertExist "True"
									.webElement("Campaign").assertStatus "Visible"
									.webEdit("Campaign").assertExist "True"
									.webEdit("Campaign").assertStatus "Visible"
									'.webEdit("Campaign").assertValue strCampaign
									.validateSelectedListItem MULTI_LIST_CAMPAIGN, strCampaign, "True"
									
									.webElement("Provider").assertExist "True"
									.webElement("Provider").assertStatus "Visible"
									.webEdit("Provider").assertExist "True"
									.webEdit("Provider").assertStatus "Visible"
									
									
									.webElement("Sites").assertExist "True"
									.webElement("Sites").assertStatus "Visible"
									.webEdit("Sites").assertExist "True"
									.webEdit("Sites").assertStatus "Visible"
									.webEdit("Sites").assertValue strSites
									.validateSelectedListItem MULTI_LIST_SITES, strSites, "True"
									
									
									.webElement("GroupBy").assertExist "True"
									.webElement("GroupBy").assertStatus "Visible"
									.webList("GroupBy").assertExist "True"
									.webList("GroupBy").assertStatus "Visible"
									.webList("GroupBy").assertSelectedItem strGroupBy
									
									.webElement("ScheduleOptions").assertExist "True"
									.webElement("ScheduleOptions").assertStatus "Visible"
									
									.webRadiogroup("GenerateOption").assertExist "True"
									.webRadiogroup("GenerateOption").assertStatus "Visible"
									
									.webElement("GenerateReportNow").assertExist "True"
									.webElement("GenerateReportNow").assertStatus "Visible"
									
									.webElement("GenerateReportOnDate").assertExist "True"
									.webElement("GenerateReportOnDate").assertStatus "Visible"
									
									strEditScheduleDate=ConvertDate(SCHEDULED_DATE,"DATE-MON-YR")
									strEditEndDate=ConvertDate(strEndDate,"DATE-MON-YR")
									
									.webElement("ScheduleDate").assertExist "True"
									.webElement("ScheduleDate").assertStatus "Visible"
									.webEdit("ScheduleDate").assertExist "True"
									.webEdit("ScheduleDate").assertStatus "Visible"
									.webEdit("ScheduleDate").assertValue strEditScheduleDate
									
									.webElement("Time").assertExist "True"
									.webElement("Time").assertStatus "Visible"
									.webEdit("Time").assertExist "True"
									.webEdit("Time").assertStatus "Visible"
									.webEdit("Time").assertValue SCHEDULED_TIME
									
									.webImage("Watch").assertExist "True"
									.webImage("Watch").assertStatus "Visible"
									
									.webList("Frequency").assertExist "True"
									.webList("Frequency").assertStatus "Visible"
									.webList("Frequency").assertSelectedItem strFrequency
									
									.webElement("EndDate").assertExist "True"
									.webElement("EndDate").assertStatus "Visible"
									.webEdit("EndDate").assertExist "True"
									.webEdit("EndDate").assertStatus "Visible"
									.webEdit("EndDate").assertValue strEditEndDate
									
									.webElement("DefaultReportGenerate").assertExist "True"
									.webElement("DefaultReportGenerate").assertStatus "Visible"
									.webElement("DefaultReportGenerate").assertText "This report will be generated daily starting on "& strEditScheduleDate &" at " & SCHEDULED_TIME & " until " & strEditEndDate &"."
									
									.webElement("EmailAndStorageOptions").assertExist "True"
									.webElement("EmailAndStorageOptions").assertStatus "Visible"
									
									.webElement("EmailRecipients").assertExist "True"
									.webElement("EmailRecipients").assertStatus "Visible"
									.webEdit("EmailRecipients").assertExist "True"
									.webEdit("EmailRecipients").assertStatus "Visible"
									.webEdit("EmailRecipients").assertValue strEmail
									
									.webButton("AddRecipient").assertExist "True"
									.webButton("AddRecipient").assertStatus "Visible"
									
									.webElement("StorageLocation").assertExist "True"
									.webElement("StorageLocation").assertStatus "Visible"
									.webEdit("StorageLocation").assertExist "True"
									.webEdit("StorageLocation").assertStatus "Visible"
									.webEdit("StorageLocation").assertValue strStorageLocation
									
									.webElement("ReportFormat").assertExist "True"
									.webElement("ReportFormat").assertStatus "Visible"
									.webList("ReportFormat").assertExist "True"
									.webList("ReportFormat").assertStatus "Visible"
									.webList("ReportFormat").assertSelectedItem strReportFormat
									
									.webElement("DataType").assertExist "True"
									.webElement("DataType").assertStatus "Visible"
									.webList("DataType").assertExist "True"
									.webList("DataType").assertStatus "Visible"
									.webList("DataType").assertSelectedItem strDataType
									
									.webCheckBox("CompressTheFile").assertExist "True"
									.webCheckBox("CompressTheFile").assertStatus "Visible"
									.webElement("CompressTheFile").assertExist "True"
									.webElement("CompressTheFile").assertStatus "Visible"
									
									
									.webElement("Comments").assertExist "True"
									.webElement("Comments").assertStatus "Visible"
									.webEdit("Comments").assertExist "True"
									.webEdit("Comments").assertStatus "Visible"
									.webEdit("Comments").assertValue strComments
									
									.webButton("Schedule").assertExist "True"
									.webButton("Schedule").assertStatus "Visible"
									
									.webButton("Cancel").assertExist "True"
									.webButton("Cancel").assertStatus "Visible"
									
									.webButton("Cancel").press
end with
executionController.stopTestCase_w_TestCaseNumber "EditScheduledReport_SelectUniqueCustomers_ValidatePageControls", "SCR_EDIT_ASR_TC_001"

