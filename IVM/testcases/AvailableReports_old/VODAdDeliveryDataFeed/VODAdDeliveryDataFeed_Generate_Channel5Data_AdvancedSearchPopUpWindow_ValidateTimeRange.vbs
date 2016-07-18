'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	VODAdDeliveryDataFeed_Generate_Channel5Data_AdvancedSearchPopUpWindow_ValidateTimeRange
' Description					:	Validate "Time Range" text box in the Advanced Search Popup Window.
' Author 						:   Fonantrix Solution
' Date 							:   15-05-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "VODAdDeliveryDataFeed_Generate_Channel5Data_AdvancedSearchPopUpWindow_ValidateTimeRange", "REP_CSR_TC_046"

START_DATE=REPORT_START_DATE1
END_DATE=REPORT_END_DATE1
strSeachValue=testcasedata.getvalue("strSeachValue")
REM strSites=testcasedata.getvalue("strSites")
REM strSiteGroups=testcasedata.getvalue("strSiteGroups")
strProvider=testcasedata.getvalue("strProvider")
strCampaign=testcasedata.getvalue("strCampaign")
strComments=testcasedata.getvalue("strComments")
TimeRange_Inv=testcasedata.getvalue("TimeRange_Inv")
TimeRange_Inv1=testcasedata.getvalue("TimeRange_Inv1")
TimeRange_val=testcasedata.getvalue("TimeRange_val")
TimeRange_val1=testcasedata.getvalue("TimeRange_val1")


ivm.NavigateToMenu MENU_AVAILABLE_REPORTS
wait 10
 
with ivm.page(report_page)

						.webTable("AvailableReports").presstblLink reportVODAdDeliveryDataFeed,3
						 wait 10
						 
						 .webTable("SelectaDatasetforThisReport").assertExist "True"
						.webTable("SelectaDatasetforThisReport").assertStatus "Visible"
						.webTable("SelectaDatasetforThisReport").assertColumnExist "Report Name","True"
						.webTable("SelectaDatasetforThisReport").assertColumnExist "Dataset Creation","True"
						.webTable("SelectaDatasetforThisReport").assertColumnExist "User","True"
                        .webTable("SelectaDatasetforThisReport").assertColumnExist "Parameters","True"
											
										 
						.webTable("SelectaDatasetforThisReport").presstblRadioBtn strSeachValue,1 
						wait 5
							
						 .webLink("FilterOptions").assertExist "True"
						 .webLink("FilterOptions").assertStatus "Visible"
						 .webLink("FilterOptions").press
						wait 5
							
					    .selectDate reportVODAdDeliveryDataFeed,"StartDate",START_DATE

						.selectDate reportVODAdDeliveryDataFeed,"EndDate",END_DATE
						
						.webList("SelectaProveder").assertExist "True"
					    .webList("SelectaProveder").selectItem strProvider
						 wait 5
						
						REM .selectListItem MULTI_LIST_SITES,strSites,"True"
						REM wait 3												
						.selectListItem MULTI_LIST_PROVIDERIDS,strProvider,"True"
						wait 3
						.selectListItem MULTI_LIST_CAMPAIGNS,strCampaign,"True"
						wait 3
						
							
						.webEdit("Comments").setValue strComments
						wait 5
						
						.webButton("Generate").press
						wait 8
End with	

With ivm.page(reportgen_page)

							.webLink("Channel5").press
							wait 5
							
							.webLink("AdvancedSearch").press
							wait 3
							
							.selectDate reportVODAdDeliveryDataFeed,"StartDate",TimeRange_val	
							wait 5
							.selectDate reportVODAdDeliveryDataFeed,"EndDate",TimeRange_val1
							wait 5
							.webLink("AdvSearch").press
							 wait 5		
							 
							.webTable("SearchCriteria_VOD").assertExist "True" 
							.webTable("SearchCriteria_VOD").assertStatus "Visible"
							
							.webLink("TimeRange_VOD").assertExist "True"
							.webLink("TimeRange_VOD").assertStatus "Visible"
							 
							 strFromTo= "From " & TimeRange_val & " to " & TimeRange_val1	
							 
							.webTable("Channel_5").searchData strFromTo
							wait 5
							
' For invalid							
							.webLink("AdvancedSearch").press					
							 wait 5	
							 
							.selectDate reportVODAdDeliveryDataFeed,"StartDate",TimeRange_Inv	
							wait 5							
							.selectDate reportVODAdDeliveryDataFeed,"EndDate",TimeRange_Inv1	
							wait 5
							.webLink("AdvSearch").press					
							 wait 5		
							 
							.webTable("SearchCriteria_VOD").assertExist "True" 
							.webTable("SearchCriteria_VOD").assertStatus "Visible"
							
							.webTable("Channel_5").assertvalue "No data exists for the selected criteria."
							 wait 5
							 
							.webLink("BackToPreviousPage").press
							 wait 10
End With

With ivm.page(report_page)		
 
						    .webButton("Cancel").press
						     wait 10
							
							.webElement("AvailableReports").assertExist "True"
						    .webElement("AvailableReports").assertStatus "Visible"
						
End With				
'End Test Case
executionController.stopTestCase_w_TestCaseNumber "VODAdDeliveryDataFeed_Generate_Channel5Data_AdvancedSearchPopUpWindow_ValidateTimeRange", "REP_VODR_TC_046"