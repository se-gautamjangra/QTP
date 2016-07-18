'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright SeaChange
'
' File Name						:	ScheduleNewReport_RegionSummary_ValidateSites
' Description					:	Validate "Sites" List box.
' Author 						:   SeaChange
' Date 							:   03-07-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
 executionController.startTestCase_w_TestCaseNumber "ScheduleNewReport_RegionSummary_ValidateSites", "SCR_NEW_RSR_TC_002"
 
ivm.NavigateToMenu MENU_SCHEDULED_REPORTS
wait Wait30

strSitesAll=testcasedata.getvalue("strSitesAll")
strSites=testcasedata.getvalue("strSites")
strSites1=testcasedata.getvalue("strSites1")

 With ivm.page(ScheduledReports_Page)

							.webLink("ScheduleNewReport").press
							  wait Wait15
							
							.webRadiogroup("ReportType").selectGroupItem reportRegionSummary
							 wait Wait12	
							.selectDate "FirstDate", FIRST_DATE
							wait Wait3									
							.selectDate "LastDate", LAST_DATE
							 wait Wait3
							
							.webEdit("Sites").assertExist "True"
							.webEdit("Sites").assertStatus "Visible"
							
							.validateSelectedListItem MULTI_LIST_SITES,"All","False"
							
							.assertListItems MULTI_LIST_SITES & ";" & reportRegionSummary,""
							wait Wait5
							.assertListDGWDB MULTI_LIST_SITES & ";"& reportRegionSummary, ""
					  	     wait Wait8
							
							.selectListItem MULTI_LIST_SITES,strSites,"True"
							 wait Wait5
							
							.selectListItem MULTI_LIST_SITES,strSites1,"True"
							 wait Wait5
							
							strSites=testcasedata.getvalue("strSites")
							strSites1=testcasedata.getvalue("strSites1")
							
							.validateSelectedListItem MULTI_LIST_SITES,strSites,"True"
							.validateSelectedListItem MULTI_LIST_SITES,strSites1,"True"
							
							
							strSitesAll=testcasedata.getvalue("strSitesAll")
							
							.selectListItem MULTI_LIST_SITES,strSitesAll,"True"
							 wait Wait2
							.validateSelectedListItem MULTI_LIST_SITES,strSitesAll,"True" '''all items selected function
							
							.selectListItem MULTI_LIST_SITES,strSitesAll,"False"
							 wait Wait2
							.validateSelectedListItem MULTI_LIST_SITES,strSitesAll,"False" '''all items deselected function
							
							strSitesAll=testcasedata.getvalue("strSitesAll")
							strSites=testcasedata.getvalue("strSites")
							
							.selectListItem MULTI_LIST_SITES,strSitesAll,"True"
							 wait Wait2
							 
							.selectListItem MULTI_LIST_SITES,strSites,"False"
							 wait Wait2
							 
							.validateSelectedListItem MULTI_LIST_SITES,strSitesAll,"False" 	
							
							.webButton("Cancel").press

End With

'End Test Case 
executionController.stopTestCase_w_TestCaseNumber "ScheduleNewReport_RegionSummary_ValidateSites", "SCR_NEW_RSR_TC_002"
