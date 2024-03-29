'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	RawData_Generate_PreferredData_ValidateFilterBySearch
' Description					:	Validate the search functionality for the "Preferred Data" table.
' Author 						:   Fonantrix Solution
' Date 							:   12-04-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
 executionController.startTestCase_w_TestCaseNumber "RawData_Generate_PreferredData_ValidateFilterBySearch", "REP_RDR_TC_016"

START_DATE=REPORT_START_DATE1
END_DATE=REPORT_END_DATE1
strSites=testcasedata.getvalue("strSites")
strSiteGroups=testcasedata.getvalue("strSiteGroups")
strProviderId=testcasedata.getvalue("strProviderId")
strCampaign=testcasedata.getvalue("strCampaign")
strComments=testcasedata.getvalue("strComments")
strSearchInvalid=testcasedata.getvalue("strSearchInvalid")
strSearchValid=testcasedata.getvalue("strSearchValid")
strSearchBlank=testcasedata.getvalue("strSearchBlank")

ivm.NavigateToMenu MENU_AVAILABLE_REPORTS
wait 10

With ivm.page(report_page)

						.webTable("AvailableReports").presstblLink reportRawData,3
						 wait 10
					    .selectDate reportRawData,"StartDate",START_DATE

						.selectDate reportRawData,"EndDate",END_DATE
						
						.selectListItem MULTI_LIST_SITES,strSites,"True"
						wait 3	
						.selectListItem MULTI_LIST_SITEGROUPS,strSiteGroups,"True"
						     wait 5							
						.selectListItem MULTI_LIST_PROVIDERIDS,strProviderId,"True"
						wait 3
						.selectListItem MULTI_LIST_CAMPAIGNS,strCampaign,"True"
						wait 3
													
						.webEdit("Comments").setValue strComments
						wait 5
						
						.webButton("Generate").press
						wait 8
End with 

With ivm.page(reportgen_page)

							.weblink("PreferredData").press
							wait 4
							.webTable("PreferredData_RD").assertExist "True"
							
							.webEdit("Search").asserExist "True"
							.webEdit("Search").assertStatus "visible"
							
							.webEdit("Search").setValue strSearchInvalid
							wait 5
							.webImage("Search").press
							wait 5
							
							.webTable("PreferredData_RD").assertExist "True"													
					        .webTable("PreferredData_RD").assertValue NO_RECORD_FOUND,1
							wait 5
							
							.webTable("SearchCriteria_RD")assertExist "True"
							.webElement("SearchCriteria").assertExist "True"
							.webElement("SearchCriteria").assertStatus "Visible"
							
							.webLink("Search_RD").assertExist "True"
							.webLink("Search_RD").assertStatus "Visible"
							
							.webLink("ClearAll_RD").assertExist "True"
							.webLink("ClearAll_RD").assertStatus "Visible"
							
							.webLink("Search_RD").press							
							 wait 5
							
							.webLink("Search_RD").assertExist "False"
							.webLink("ClearAll_RD").assertExist "False"
							
'Search with valid data
							.webEdit("Search").setValue strSearchValid
							wait 5
							.webImage("Search").press
							wait 5
							
							.webTable("PreferredData_RD").assertExist "True"													
					        .webTable("PreferredData_RD").searchData SearchTermValid
							wait 5
							
							.webTable("SearchCriteria_RD")assertExist "True"
							.webElement("SearchCriteria").assertExist "True"
							.webElement("SearchCriteria").assertStatus "Visible"
							
							.webLink("Search_RD").assertExist "True"
							.webLink("Search_RD").assertStatus "Visible"
							
							.webLink("ClearAll_RD").assertExist "True"
							.webLink("ClearAll_RD").assertStatus "Visible"
							
							.webLink("Search_RD").press							
							 wait 5
							
							.webLink("Search_RD").assertExist "False"
							.webLink("ClearAll_RD").assertExist "False"

'Search with blank data							
							.webEdit("Search").setValue strSearchBlank
							wait 5
							.webImage("Search").press
							wait 5
							
							.webTable("PreferredData_RD").assertExist "True"													
					        wait 5
							
							.webTable("SearchCriteria_RD")assertExist "True"
							
							.webElement("SearchCriteria").assertExist "False"
							.webLink("Search_RD").assertExist "False"
							.webLink("ClearAll_RD").assertExist "False"
							
					       .webLink("BackToPreviousPage").press
						    wait 10
			
End with

with ivm.page(report_page)		
								
							.webButton("Cancel").press
							wait 5
					
End with

'End Test Case 
executionController.stopTestCase_w_TestCaseNumber "RawData_Generate_PreferredData_ValidateFilterBySearch", "REP_RDR_TC_016"
