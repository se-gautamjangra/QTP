'logout and Close IRM application
status=Browser("SeaChangeManagementConsole").Page("pgScheduledReports").Frame("Frame").Exist(10)
	if status = "False" then	
REM If Browser("SeaChangeManagementConsole").Page("pgScheduledReports").Frame("Frame").Exist(0) Then
	REM info "Frame Exists"
	
Browser("SeaChangeManagementConsole").Refresh
	'msgbox "2"
	End if
	REM Else	
	REM ivm.Close
		REM ivm.startivmBrowser
		REM ivm.logIn
REM End if
