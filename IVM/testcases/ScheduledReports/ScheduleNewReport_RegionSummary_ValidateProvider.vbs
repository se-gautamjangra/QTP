'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright SeaChange
'
' File Name						:	ScheduleNewReport_RegionSummary_ValidateProviderIDs
' Description					:	Validate "Provider Ids" List box.
' Author 						:   SeaChange
' Date 							:   03-07-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
 executionController.startTestCase_w_TestCaseNumber "ScheduleNewReport_RegionSummary_ValidateProviderIDs", "SCR_NEW_RSR_TC_004"
 
ivm.NavigateToMenu MENU_SCHEDULED_REPORTS
wait Wait30
strProviderAll=testcasedata.getvalue("strProviderAll")
strProvider=testcasedata.getvalue("strProvider")
strProvider1=testcasedata.getvalue("strProvider1")

 With ivm.page(ScheduledReports_Page)

							.webLink("ScheduleNewReport").press
							  wait Wait15
							
							.webRadiogroup("ReportType").selectGroupItem reportRegionSummary
							 wait Wait12	
							.selectDate "FirstDate", FIRST_DATE
							wait Wait3									
							.selectDate "LastDate", LAST_DATE
							 wait Wait3							
							.webEdit("Provider").assertExist "True"
							.webEdit("Provider").assertStatus "Visible"
							
							.validateSelectedListItem MULTI_LIST_PROVIDER,"All","False"
							
							.assertListItems MULTI_LIST_PROVIDER & ";" & reportRegionSummary,""
							wait Wait5
							.assertListDGWDB MULTI_LIST_PROVIDER & ";"& reportRegionSummary, ""
					  	 wait Wait8
							
							.selectListItem MULTI_LIST_PROVIDER,strProvider,"True"
							 wait Wait5
							 
							.selectListItem MULTI_LIST_PROVIDER,strProvider1,"True"
							 wait Wait5
							 
							strProvider=testcasedata.getvalue("strProvider")
							strProvider1=testcasedata.getvalue("strProvider1")
							
							.validateSelectedListItem MULTI_LIST_PROVIDER,strProvider,"True"
							.validateSelectedListItem MULTI_LIST_PROVIDER,strProvider1,"True"
							
							
							strProviderAll=testcasedata.getvalue("strProviderAll")
							
							.selectListItem MULTI_LIST_PROVIDER,strProviderAll,"True"
							 wait Wait7
							.validateSelectedListItem MULTI_LIST_PROVIDER,strProviderAll,"True" '''all items selected function
							
							.selectListItem MULTI_LIST_PROVIDER,strProviderAll,"False"
							 wait Wait7
							.validateSelectedListItem MULTI_LIST_PROVIDER,strProviderAll,"False" '''all items deselected function
							
							strProviderAll=testcasedata.getvalue("strProviderAll")
							strProvider=testcasedata.getvalue("strProvider")
							
							.selectListItem MULTI_LIST_PROVIDER,strProviderAll,"True"
							 wait Wait5
							.selectListItem MULTI_LIST_PROVIDER,strProvider,"False"
							 wait Wait5
							.validateSelectedListItem MULTI_LIST_PROVIDER,strProviderAll,"False" 	
							
							.webButton("Cancel").press

End With
'End Test Case 
executionController.stopTestCase_w_TestCaseNumber "ScheduleNewReport_RegionSummary_ValidateProviderIDs", "SCR_NEW_RSR_TC_004"
