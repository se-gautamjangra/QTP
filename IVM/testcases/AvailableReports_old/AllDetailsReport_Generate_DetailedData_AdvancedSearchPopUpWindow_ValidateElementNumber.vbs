'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright SeaChange
'
' File Name						:	AllDetailsReport_Generate_DetailedData_AdvancedSearchPopUpWindow_ValidateElementNumber
' Description					:	Validate the ElementNumber filter on advanced search window
' Author 						:   SeaChange
' Date 							:   02-07-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "AllDetailsReport_Generate_DetailedData_AdvancedSearchPopUpWindow_ValidateElementNumber", "REP_ADR_TC_026"


'DataSet=testcasedata.getvalue("DataSet")
strTimeRange=testcasedata.getvalue("strTimeRange")
strCampaign=testcasedata.getvalue("strCampaign")
strEmail=testcasedata.getvalue("strEmail")
strStorageLocation=testcasedata.getvalue("strStorageLocation")
strReportFormat=testcasedata.getvalue("strReportFormat")
strDataType=testcasedata.getvalue("strDataType")
strComments=testcasedata.getvalue("strComments")
strElementNumber=testcasedata.getvalue("strElementNumber")
strElementNumber1=testcasedata.getvalue("strElementNumber1")
strElementNumberInv=testcasedata.getvalue("strElementNumberInv")
status=Browser("SeaChangeManagementConsole").Page("pgAvailableReports").Frame("Frame").Exist(5)
If status="False" Then
Browser("SeaChangeManagementConsole").Refresh
wait 5
End If
ivm.ClickToMenu MENU_AVAILABLE_REPORTS
wait Wait7
DataSet=DATASET_ALLDETAILS
With ivm.page(report_page)

						.webTable("AvailableReports").presstblLink reportAllDetails,3
						 wait Wait10	
						 
						   .webLink("AdvancedSearch").press
						    wait Wait3
						   .webEdit("DatasetName").setValue DataSet
						   .webLink("AdvSearch").press
						    wait wait10
						
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
							wait Wait7
						.selectListItem MULTI_LIST_TIMERANGE_AVAI1,strTimeRange,"True"
						.selectListItem MULTI_LIST_CAMPAIGNNAMES_AVAI,strCampaign,"True"
						wait Wait2
						.webEdit("EmailRecipients").setValue strEmail
							
						.webEdit("StorageLocation").setValue strStorageLocation
							
						.webList("ReportFormat").selectItem strReportFormat
							
						.webList("DataType").selectItem strDataType
							
						.webEdit("Comments").setValue strComments
						.webButton("Generate").press
						wait Wait10
End with 
	

With ivm.page(detailedData_page)	

							.webLink("DetailedData").press
							wait Wait4
							
						    .webLink("AdvancedSearch").press
							wait Wait3
							
							.webEdit("ElementNumber_Adv").setValue strElementNumber
						   
							.webLink("AdvSearch").press
							.webElement("ElementNumber_Filter").assertExist "True"
							If len(strElementNumber)>9 then 
							.webElement("ElementNumber_Filter").assertText  "Element Number ="& mid(strElementNumber,1,8) &".." &"   X"
							
							Else
							.webElement("ElementNumber_Filter").assertText  "Element Number ="& strElementNumber &"   X"
							
							End If
						    .webLink("ClearAll").assertExist "True"
							.webLink("ClearAll").assertStatus "Visible"
							
							.webTable("DetailedData_AD").assertExist "True"
							
							.webLink("ClearAll").press
							wait Wait5
							.webElement("ElementNumber_Filter").assertExist "False"
							
							
							
REM 'For invalid
							.webLink("AdvancedSearch").press
							wait Wait5
							
							.webEdit("ElementNumber_Adv").setValue strElementNumberInv
						    wait Wait2
							.webLink("AdvSearch").press
							wait Wait5	
							
							
							.webElement("ElementNumber_Filter").assertExist "True"
							If len(strElementNumberInv)>9 then 
							.webElement("ElementNumber_Filter").assertText  "Element Number ="& mid(strElementNumberInv,1,8) &".." &"   X"
							
							Else
							.webElement("ElementNumber_Filter").assertText  "Element Number ="& strElementNumberInv &"   X"
							End If
							
							.webElement("ElementNumber_Filter").assertExist "True"
							.webLink("ClearAll").assertExist "True"
							.webLink("ClearAll").assertStatus "Visible"
							
							.webTable("DetailedData_AD").assertExist "True"
						
							.webTable("DetailedData_AD").searchData NoRecordFound_msg
							
							
							.webLink("ClearAll").press
							
							wait Wait5
							.webElement("ElementNumber_Filter").assertExist "False"
							
												        
End with
executionController.stopTestCase_w_TestCaseNumber "AllDetailsReport_Generate_DetailedData_AdvancedSearchPopUpWindow_ValidateElementNumber", "REP_ADR_TC_026"