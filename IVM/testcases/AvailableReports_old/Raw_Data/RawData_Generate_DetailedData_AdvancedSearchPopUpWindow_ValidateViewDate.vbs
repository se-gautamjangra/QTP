'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	RawData_Generate_DetailedData_AdvancedSearchPopUpWindow_ValidateViewDate 
' Description					:	Validate the date range filter on advanced search window
' Author 						:   Fonantrix Solution
' Date 							:   09-04-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "RawData_Generate_DetailedData_AdvancedSearchPopUpWindow_ValidateViewDate ", "REP_RDR_TC_038"

DataSet=testcasedata.getvalue("DataSet")
strCampaign=testcasedata.getvalue("strCampaign")
strProgramPid=testcasedata.getvalue("strProgramPid")
strEmail=testcasedata.getvalue("strEmail")
strStorageLocation=testcasedata.getvalue("strStorageLocation")
strReportFormat=testcasedata.getvalue("strReportFormat")
strDataType=testcasedata.getvalue("strDataType")
strComments=testcasedata.getvalue("strComments")
strElementNumber=testcasedata.getvalue("strElementNumber")
strElementNumber1=testcasedata.getvalue("strElementNumber1")
strElementNumberInv=testcasedata.getvalue("strElementNumberInv")
strBetweenDate=testcasedata.getvalue("strBetweenDate")
strAndDate=testcasedata.getvalue("strAndDate")
strBetweenDate1=testcasedata.getvalue("strBetweenDate1")
strAndDate1=testcasedata.getvalue("strAndDate1")
strBetweenDateInv=testcasedata.getvalue("strBetweenDateInv")
strAndDateInv=testcasedata.getvalue("strAndDateInv")

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

							.webLink("DetailedData").press
							wait 4
							
							.webTable("DetailedData_RD").assertExist "True"
							
						   .webLink("AdvancedSearch").press
							wait 5
							
							
							.selectDate "BetweenDate",strBetweenDate
							wait 2
							.selectDate "AndDate",strAndDate
							wait 2
							.webLink("AdvSearch").press
							 wait 7	
							.webElement("Between_Filter").assertExist "True"
							If len(strBetweenDate)>9 then 
							.webElement("Between_Filter").assertText  "Between ="& mid(strBetweenDate,1,10) &".." &"   X"
							
							Else
							.webElement("Between_Filter").assertText  "Between ="& strBetweenDate &"   X"
							
							End If
							
							.webElement("And_Filter").assertExist "True"
							If len(strAndDate)>9 then 
							.webElement("And_Filter").assertText  "and ="& mid(strAndDate,1,10) &".." &"   X"
							
							Else
							.webElement("And_Filter").assertText  "and ="& strAndDate &"   X"
							
							End If
						    .webLink("ClearAll").assertExist "True"
							.webLink("ClearAll").assertStatus "Visible"
							
							.webTable("DetailedData_RD").assertExist "True"
							
						
							.webTable("DetailedData_RD").assertValue strBetweenDate1,1
							.webTable("DetailedData_RD").assertValue strAndDate1,1
							wait 5	
							.webTable("DetailedData_RD").assertDelValue strBetweenDateInv
							.webTable("DetailedData_RD").assertDelValue strAndDateInv
							.webLink("ClearAll").press
							wait 5
							
							.webTable("DetailedData_RD").assertValue strBetweenDateInv,1
							.webTable("DetailedData_RD").assertValue strAndDateInv,1
							
							.webElement("And_Filter").assertExist "False"
							.webElement("Between_Filter").assertExist "False"
							
							.webLink("AdvancedSearch").press
							wait 5
							
							
							.selectDate "BetweenDate",strBetweenDate
							
							.webLink("AdvSearch").press
							 wait 7	
							.webElement("Between_Filter").assertExist "True"
							If len(strBetweenDate)>9 then 
							.webElement("Between_Filter").assertText  "Between ="& mid(strBetweenDate,1,10) &".." &"   X"
							
							Else
							.webElement("Between_Filter").assertText  "Between ="& strBetweenDate &"   X"
							
							End If
							.webLink("ClearAll").assertExist "True"
							.webLink("ClearAll").assertStatus "Visible"
							
							.webTable("DetailedData_RD").assertExist "True"
							
						
							.webTable("DetailedData_RD").assertValue strBetweenDate1,1
							.webTable("DetailedData_RD").assertDelValue strAndDate1
							
							.webLink("ClearAll").press
							wait 5
							.webTable("DetailedData_RD").assertValue strAndDate1,1
							.webElement("Between_Filter").assertExist "False"
							
							.webLink("AdvancedSearch").press
							wait 5
							.selectDate "AndDate",strAndDate
							wait 2
							.webLink("AdvSearch").press
							 wait 7	
							 
							 .webElement("And_Filter").assertExist "True"
							If len(strAndDate)>9 then 
							.webElement("And_Filter").assertText  "and ="& mid(strAndDate,1,10) &".." &"   X"
							
							Else
							.webElement("And_Filter").assertText  "and ="& strAndDate &"   X"
							
							End If
						    .webLink("ClearAll").assertExist "True"
							.webLink("ClearAll").assertStatus "Visible"
							
							.webTable("DetailedData_RD").assertExist "True"
							
						
							
							.webTable("DetailedData_RD").assertValue strAndDate1,1
							.webTable("DetailedData_RD").assertDelValue strBetweenDate1
							
							.webLink("ClearAll").press
							wait 5
							.webTable("DetailedData_RD").assertValue strBetweenDate1,1
							.webElement("Between_Filter").assertExist "False"
							
							
							
End with								
'End Test Case
executionController.stopTestCase_w_TestCaseNumber "RawData_Generate_DetailedData_AdvancedSearchPopUpWindow_ValidateViewDate ", "REP_RDR_TC_038"