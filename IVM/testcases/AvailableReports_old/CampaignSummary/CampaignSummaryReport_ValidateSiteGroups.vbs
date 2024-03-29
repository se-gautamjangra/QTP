'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	CampaignSummaryReport_ValidateSiteGroups
' Description					:	Validate the Regions list box available on the "Campaign Summary" report.
' Author 						:   Fonantrix Solution
' Date 							:   08-04-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
executionController.startTestCase_w_TestCaseNumber "CampaignSummaryReport_ValidateSiteGroups", "REP_CSR_TC_005"

strSiteGroups=testcasedata.getvalue("strSiteGroups")
strSiteGroups1=testcasedata.getvalue("strSiteGroups1")
strSiteGroupsAll=testcasedata.getvalue("strSiteGroupsAll")

ivm.NavigateToMenu MENU_AVAILABLE_REPORTS
wait 10

With ivm.page(report_page)

							.webTable("AvailableReports").presstblLink reportCampaignSummary,3
							 wait 10	
							
							.webEdit("SiteGroups").assertExist "True"
							.webEdit("SiteGroups").assertStatus "Visible"
							
							.validateSelectedListItem MULTI_LIST_SITEGROUPS,"All","False"
							
							.assertListItems MULTI_LIST_SITEGROUPS,""
							
							.selectListItem MULTI_LIST_SITEGROUPS,strSiteGroups,"True"
							 wait 5
							.selectListItem MULTI_LIST_SITEGROUPS,strSiteGroups1,"True"
							 wait 5
							
							.validateSelectedListItem MULTI_LIST_SITEGROUPS,strSiteGroups,"True"
							.validateSelectedListItem MULTI_LIST_SITEGROUPS,strSiteGroups1,"True"
							
							strSiteGroupsAll=testcasedata.getvalue("strSiteGroupsAll")
							
							.selectListItem MULTI_LIST_SITEGROUPS,strSiteGroupsAll,"True"
							 wait 5
							.validateSelectedListItem MULTI_LIST_SITEGROUP,strSiteGroupsAll,"True" '''all items selected function
							
							strSiteGroupsAll=testcasedata.getvalue("strSiteGroupsAll")
							.selectListItem MULTI_LIST_SITEGROUPS,strSiteGroupsAll,"False"
							 wait 5
							.validateSelectedListItem MULTI_LIST_SITEGROUPS,strSiteGroupsAll,"False" '''all items deselected function
							
							strSiteGroupsAll=testcasedata.getvalue("strSiteGroupsAll")
							strSiteGroups=testcasedata.getvalue("strSiteGroups")
							
							.selectListItem MULTI_LIST_SITEGROUPS,strSiteGroupsAll,"True"
							 wait 5
							.selectListItem MULTI_LIST_SITEGROUPS,strSiteGroups,"False"
							 wait 5
							.validateSelectedListItem MULTI_LIST_SITEGROUPS,strSiteGroupsAll,"False" 	
							
							.webButton("Cancel").press
End with	

'End Test Case
executionController.stopTestCase_w_TestCaseNumber "CampaignSummaryReport_ValidateSiteGroups", "REP_CSR_TC_005"