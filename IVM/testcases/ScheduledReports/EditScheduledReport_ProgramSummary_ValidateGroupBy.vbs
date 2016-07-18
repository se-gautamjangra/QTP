'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright SeaChange
'
' File Name						:	EditScheduledReport_CampaignSummary_ValidateGrouping
' Description					:	Validate "Grouping" List box.
' Author 						:   SeaChange
' Date 							:   16-05-2013
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Start Test Case
 executionController.startTestCase_w_TestCaseNumber "EditScheduledReport_CampaignSummary_ValidateGrouping", "SCR_EDIT_CSR_TC_006"
 
ivm.NavigateToMenu MENU_SCHEDULED_REPORTS
wait Wait30

SearchVal=testcasedata.getvalue("SearchVal")
strGroupBy=testcasedata.getvalue("strGroupBy")
strGroupBy1=testcasedata.getvalue("strGroupBy1")

 With ivm.page(ScheduledReports_Page)

							.webTable("ScheduledReports").pressLink SearchVal,"Edit Options",6
							  wait Wait15	
							
							.webList("GroupBy").assertExist "True"
							.webList("GroupBy").assertStatus "Visible"
							
													
							
							.webList("GroupBy").assertlistitems "GroupBy"& ";" & reportProgramSummary
						
							.webList("GroupBy").assertListDGWDB "GroupBy" & ";"& reportProgramSummary," "
				
							.webList("GroupBy").selectItem strGroupBy
						
							
							.webList("GroupBy").selectItem strGroupBy1
					
							.webList("GroupBy").assertSelectedItem strGroupBy1
							
							.webButton("Cancel").press

End With

'End Test Case 
executionController.stopTestCase_w_TestCaseNumber "EditScheduledReport_CampaignSummary_ValidateGrouping", "SCR_EDIT_CSR_TC_006"