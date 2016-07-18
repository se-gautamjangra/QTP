'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	RawData_Generate_PreferredData_ValidateWithWebServiceData
' Description					:	Validate the data with webservices for preferred data 
' Author 						:   Fonantrix Solution
' Date 							:   09-04-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "RawData_Generate_PreferredData_ValidateWithWebServiceData", "REP_CSR_TC_028"

DataSet=testcasedata.getvalue("DataSet")
strCampaign=testcasedata.getvalue("strCampaign")
strProgramPid=testcasedata.getvalue("strProgramPid")
strEmail=testcasedata.getvalue("strEmail")
strStorageLocation=testcasedata.getvalue("strStorageLocation")
strReportFormat=testcasedata.getvalue("strReportFormat")
strDataType=testcasedata.getvalue("strDataType")
strComments=testcasedata.getvalue("strComments")


ivm.ClickToMenu MENU_AVAILABLE_REPORTS
wait 10
 
With ivm.page(report_page)

							.webTable("AvailableReports").presstblLink reportRawData,3
							 wait 5

							.webTable("DataSet").presstblRadioBtn DataSet,1
							
							wait 5
							
							.selectListItem MULTI_LIST_CAMPAIGNNAMES_AVAI,strCampaign,"True"
							.selectListItem MULTI_LIST_PROGRAMPID_AVAI,strProgramPid,"True"
							
							.webEdit("EmailRecipients").setValue strEmail
							
							.webEdit("StorageLocation").setValue strStorageLocation
							
							.webList("ReportFormat").selectItem strReportFormat
							
							.webList("DataType").selectItem strDataType
							
							.webEdit("Comments").setValue strComments
							
						
						.webButton("Generate").press
						wait 8

End with

With ivm.page(preferredData_page)	

							.webLink("PreferredData").press
							wait 5
							
							.webTable("PreferredData_RD").assertExist "True"
							.webTable("PreferredData_RD").assertTableData reportRawDataPreferred,DataSet
					
					''''''validate data with DGW
End with
					
'End Test Case
executionController.stopTestCase_w_TestCaseNumber "RawData_Generate_PreferredData_ValidateWithWebServiceData", "REP_CSR_TC_028"