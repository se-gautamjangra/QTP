'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	AllDetails_Generate_DetailedDatavancedSearchPopUpWindow_ValidateTypeAheadText
' Description					:	Validate the type ahead search  on advanced search window
' Author 						:   Fonantrix Solution
' Date 							:   08-07-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "AllDetails_Generate_DetailedDatavancedSearchPopUpWindow_ValidateTypeAheadText", "REP_ADR_TC_034"

DataSet=testcasedata.getvalue("DataSet")
'strTimeRange=testcasedata.getvalue("strTimeRange")
strEmail=testcasedata.getvalue("strEmail")
strStorageLocation=testcasedata.getvalue("strStorageLocation")
strReportFormat=testcasedata.getvalue("strReportFormat")
strDataType=testcasedata.getvalue("strDataType")
strComments=testcasedata.getvalue("strComments")
strTimeRange=testcasedata.getvalue("strTimeRange")
strTimeRange1=testcasedata.getvalue("strTimeRange1")


ivm.ClickToMenu MENU_AVAILABLE_REPORTS
wait 10


With ivm.page(report_page)

						.webTable("AvailableReports").presstblLink reportUniqueCustomers,3
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

							.weblink("DetailedData").press
							 wait 5
							 
							
							.webLink("AdvancedSearch").press
							  wait 5
							  
							  
							
							 .webEdit("TimeRange_Adv").assertExist "True"
							.webEdit("TimeRange_Adv").assertStatus "Visible"							 
							.webEdit("TimeRange_Adv").assertValue "Type to search..."																							
							.webEdit("TimeRange_Adv").setValue strTimeRange																								
							.assertListSearch MULTI_LIST_TIMERANGE_AVAI1,strTimeRange
                            wait 5
							.selectlistItem MULTI_LIST_TIMERANGE_AVAI1,strTimeRange1,"True"
						
							
							.webEdit("TimeRange_Adv").assertValue strTimeRange1
							
							.selectListItem MULTI_LIST_TIMERANGE_AVAI1,strTimeRange1,"False"
							
							.webEdit("TimeRange_Adv").assertValue "Type to search..."
								
							
							.webLink("AdvCancel").press	

End With							
executionController.stopTestCase_w_TestCaseNumber "AllDetails_Generate_DetailedDatavancedSearchPopUpWindow_ValidateTypeAheadText", "REP_ADR_TC_034"