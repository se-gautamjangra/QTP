'logout and Close IRM application

If Browser("SeaChangeManagementConsole").Page("pgAvailableReports").Frame("Frame").Exist(0) Then
	info "Frame Exists"
Else
	ivm.Close
		ivm.startivmBrowser
		ivm.logIn
End if
ivm.Close