'logout and Close IRM application

If Browser("SeaChangeManagementConsole").Page("pgAvailableReports").Frame("Frame").Exist(0) Then
	info "Frame Exists"
	'msgbox "1"
Else
	'msgbox "2"
	ivm.Close
		ivm.startivmBrowser
		ivm.logIn
End if
