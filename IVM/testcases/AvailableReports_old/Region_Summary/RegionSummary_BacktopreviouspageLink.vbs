'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	RegionSummary_BacktopreviouspageLink
' Description					:	Validate the "Back to Previous Page" link in "RegionSummary" page.
' Author 						:   Fonantrix Solution
' Date 							:   03-07-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "RegionSummary_BacktopreviouspageLink", "REP_RSR_TC_018"

DataSet=testcasedata.getvalue("DataSet")
strTimeRange=testcasedata.getvalue("strTimeRange")
strCampaign=testcasedata.getvalue("strCampaign")
strEmail=testcasedata.getvalue("strEmail")
strStorageLocation=testcasedata.getvalue("strStorageLocation")
strReportFormat=testcasedata.getvalue("strReportFormat")
strDataType=testcasedata.getvalue("strDataType")
strComments=testcasedata.getvalue("strComments")

With ivm.page(report_page)

						.webTable("AvailableReports").presstblLink reportRegionSummary,3
						 wait 10	
						 
						.webTable("DataSet").presstblRadioBtn DataSet,1 
						wait 7
						.selectListItem MULTI_LIST_TIMERANGE_AVAI1,strTimeRange,"True"
						.selectListItem MULTI_LIST_CAMPAIGNNAMES_AVAI,strCampaign,"True"

						wait 2
						.webEdit("EmailRecipients").setValue strEmail
							
						.webEdit("StorageLocation").setValue strStorageLocation
							
						.webList("ReportFormat").selectItem strReportFormat
							
						.webList("DataType").selectItem strDataType
							
						.webEdit("Comments").setValue strComments
						.webButton("Generate").press
						wait 10
End with 

With ivm.page(preferredData_page)
						
						.weblink("FiltersAndComments").assertExist "True"							
						.weblink("FiltersAndComments").assertStatus "Visible"
							
						.weblink("BackToPreviousPage").assertExist "True"
						.weblink("BackToPreviousPage").assertStatus "Visible"
						.weblink("BackToPreviousPage").press
						 wait 7	
End With

With ivm.page(report_page)
							
						.webElement("SelectaDatasetforThisReport").assertExist "True"							
						.webElement("SelectaDatasetforThisReport").assertStatus "Visible"
							
						.weblink("BackToPreviousPage").press
						wait 5
							
						.webTable("AvailableReports").assertExist "True"
End with
		
'End Test Case
executionController.stopTestCase_w_TestCaseNumber "RegionSummary_BacktopreviouspageLink", "REP_RSR_TC_018"