'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	RegionSummary_ValidateProviderIDs
' Description					:	Validate the Provider ID multiselect list box.
' Author 						:   Fonantrix Solution
' Date 							:   03-07-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "RegionSummary_ValidateProviderIDs", "REP_RSR_TC_014"

strSeachValue=testcasedata.getvalue("strSeachValue")
strProviderId=testcasedata.getvalue("strProviderId")
strProviderId1=testcasedata.getvalue("strProviderId1")
strProviderIdAll=testcasedata.getvalue("strProviderIdAll")

ivm.NavigateToMenu MENU_AVAILABLE_REPORTS
wait 10

With ivm.page(report_page)

							.webTable("AvailableReports").presstblLink reportRegionSummary,3
							 wait 10	
							 
						   .webTable("SelectaDatasetforThisReport").assertExist "True"
						   .webTable("SelectaDatasetforThisReport").assertStatus "Visible"
						   .webTable("SelectaDatasetforThisReport").assertColumnExist "Dataset Name","True"
						   .webTable("SelectaDatasetforThisReport").assertColumnExist "Dataset Creation","True"
						   .webTable("SelectaDatasetforThisReport").assertColumnExist "User","True"
                           .webTable("SelectaDatasetforThisReport").assertColumnExist "Parameters","True"
											
										 
						  .webTable("SelectaDatasetforThisReport").presstblRadioBtn strSeachValue,1 
							wait 5
							 
							.webLink("FilterOptions").assertExist "True"
						    .webLink("FilterOptions").assertStatus "Visible"
							REM .webLink("FilterOptions").press
							REM wait 5
							
							.webEdit("ProviderIDs").assertExist "True"
							.webEdit("ProviderIDs").assertStatus "Visible"
							
							.selectListItem MULTI_LIST_PROVIDERIDS,strProviderIdAll,"False"
							
							.assertListItems MULTI_LIST_PROVIDERIDS,""
							
							.selectListItem MULTI_LIST_PROVIDERIDS,strProviderId,"True"
							 wait 5
							.selectListItem MULTI_LIST_PROVIDERIDS,strProviderId1,"True"
							 wait 5
							
							.validateSelectedListItem MULTI_LIST_PROVIDERIDS,strProviderId,"True"
							.validateSelectedListItem MULTI_LIST_PROVIDERIDS,strProviderId1,"True"
							
							strProviderIdAll=testcasedata.getvalue("strProviderIdAll")
							
							.selectListItem MULTI_LIST_PROVIDERIDS,strProviderIdAll,"True"
							 wait 5
							.validateSelectedListItem MULTI_LIST_PROVIDERIDS,strProviderIdAll,"True" '''all items selected function
							
							strProviderIdAll=testcasedata.getvalue("strProviderIdAll")
							.selectListItem MULTI_LIST_PROVIDERIDS,strProviderIdAll,"False"
							 wait 5
							.validateSelectedListItem MULTI_LIST_PROVIDERIDS,strProviderIdAll,"False" '''all items deselected function
							
							strProviderIdAll=testcasedata.getvalue("strProviderIdAll")
							strProviderId=testcasedata.getvalue("strProviderId")
							
							.selectListItem MULTI_LIST_PROVIDERIDS,strProviderIdAll,"True"
							 wait 5
							.selectListItem MULTI_LIST_PROVIDERIDS,strProviderId,"False"
							 wait 5
							.validateSelectedListItem MULTI_LIST_PROVIDERIDS,strProviderIdAll,"False" 	
							
							.webButton("Cancel").press
End with	

'End Test Case
executionController.stopTestCase_w_TestCaseNumber "RegionSummary_ValidateProviderIDs", "REP_RSR_TC_014"