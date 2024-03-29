'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	DataBaseConfig.vbs 
' Description					:	This is proxy file for defining the database creation
' Author 						:   Fonantrix Solution
' Date 							:   
'--------------------------------------------------------------------------------------------------------------------------------------------------

''
' creating database object 
' 

Set database = New DataBaseConfiguration

''
'  Contains database methods for connection and executing queries.
'
Class DataBaseConfiguration
	Private connection, m_reportingName,connectionString
	
	' Setup Initialize event.
	Private Sub Class_Initialize
		m_reportingName = "DataBaseConfig"
		'reportController.reportStep m_reportingName & ".Class_Initialize()"
		
		If isObject(connection) Then
			set connection = Nothing
		End If
		Set connection = createObject("ADODB.Connection")
	End Sub
	
	'Open the database connection
	Public Sub openConnection(connectionString)
		reportController.reportStep m_reportingName & ".openConnection(" & connectionString & ")"
		
		If connectionState = 0 Then
			'Opening the database connection
			Set connection = Nothing
			Set connection = Nothing
			
			'Craete the database connection ADODB object
			Set connection = createObject("ADODB.Connection")
			With connection
				'assign provider
				.Provider = Environment.Value("DATABASE_CONNECTION_PROVIDER")
				.ConnectionString = Environment.Value(connectionString)
				.Open
  			'.Provider = "Microsoft.Jet.OLEDB.4.0"
           '--- .Provider = "Microsoft.ACE.OLEDB.12.0"
	
				'.Provider = "MSDASQL.1"
			'---	.ConnectionString = "Data Source=D:\demo\demo\conf\DB.xlsx" & ";Extended Properties=Excel 8.0;"
				'.ConnectionString = "Driver={Microsoft Excel Driver (*.xls)};" & "DBQ=" & App.Path & "\ExcelSrc.xls; "
				'.CursorLocation = adUseClient
			'---	.Open
	
				'.Provider = "Microsoft.Jet.OLEDB.4.0"
				'.ConnectionString = "Data Source=D:\demo\demo\conf\DB.xls;" & "Extended Properties=Excel 8.0;"
				'.Open

			End With
		End If
		info "Connection opened"
	End Sub
	
	'get the connection current state
	Public Function connectionState
		reportController.reportStep m_reportingName & ".connectionState()"
		connectionState = connection.State
	End Function
	
	'Close the active database connection
	Public Sub closeConnection
		reportController.reportStep m_reportingName & ".closeConnection()"
		
		If connectionState=1 Then
            'Closing the Database connection
			connection.Close
		End If
		info "Connection Closed"
	End Sub
	
	'destroy the database connection
	Public Sub destroyConnection
		reportController.reportStep m_reportingName & ".destroyConnection()"
		
		Set connection  = Nothing
		Set connection = CreateObject("ADODB.Connection")
		openConnection
		closeConnection
		'Set connection  = Nothing
		info "Connection closed"
	End Sub
	
	''
    ' Executes database query.
    ' Note: caller must close connection after using navigating RecordSet
    ' @return RecordSet
    '
    Public Function executeQuery(sql)
		reportController.reportStep m_reportingName & ".executeQuery()"
		openConnection connectionString
        Set executeQuery = connection.Execute(sql)
    End Function
	
	' Setup Terminate event.
	Private Sub Class_Terminate
		'reportController.reportStep m_reportingName & ".Class_Terminate()"
		Set connection = Nothing
	End Sub

End Class
