'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright SeaChange
'
' File Name						:	AdvertisementAndProgramDetailsReport_GenerateOptionsLink_ValidateUIControls
' Description					:   Validate Default view Controls of "Advertisement And Program Details" report..			
' Author 						:   SeaChange
' Date 							:   07-06-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "AdvertisementAndProgramDetailsReport_GenerateOptionsLink_ValidateUIControls", "REP_APD_TC_002"

ivm.ClickToMenu MENU_AVAILABLE_REPORTS
	wait Wait5
strDataSetName=testcasedata.getvalue("strDataSetName")	 
with ivm.page(report_page)

							.webTable("AvailableReports").presstblLink reportRawData,3
							wait Wait10

							.webTable("DataSet").assertTableData "DataSet",reportRawData
							
	End with
executionController.stopTestCase_w_TestCaseNumber "AdvertisementAndProgramDetailsReport_GenerateOptionsLink_ValidateUIControls", "REP_APD_TC_002"