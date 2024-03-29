'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	DatabaseManager.vbs 
' Description					:	This is proxy file for containing function for database and database validations
' Author 						:   Fonantrix Solution
' Date 							:   
'--------------------------------------------------------------------------------------------------------------------------------------------------

'Public variables
Public DatabaseConfig
Set DatabaseConfig = New DatabaseManagerClass
'Public XMLVar 

'Class used for function related to the database operations - retrieve data, validate data
Class DatabaseManagerClass
	
	'Function to get Record Count from the database
	Public Function getRecordCount(sql2, connectionString)
		reportController.reportStep m_reportingName & ".getRecordCount()" 
		
		database.openConnection connectionString
		
		info "connection Open"
		info "query is -->" & sql2
		Set CountrecordSet = database.executeQuery(sql2)
		info "query Executed"
		If CountrecordSet.EOF Then
			info "No record found in Database"
			rcount = 0
		Else
			rcount = CountrecordSet(0)
		End If
		info "rcount : " & rcount
		CountrecordSet.Close
		database.closeConnection
		getRecordCount = rcount
	End Function
	
	'Function to get all the Records from the database with "," seperated
	Public Function getRecords(sql2,connectionString)
		reportController.reportStep m_reportingName & "getRecords()"
		database.openConnection connectionString
		
		info "connection Open"
		info "query is -->" & sql2
		Set CountrecordSet = database.executeQuery(sql2)
		info "query Executed"
		If CountrecordSet.EOF Then
			info "No record found in Database"
			'failTest "No record found in Database"
			getRecords = ""
			Exit Function
		End If
		
		Set Fields_Collection=CountrecordSet.Fields
		info Fields_Collection.Count
		
		Do While Not CountrecordSet.EOF
			For i=0 to Fields_Collection.Count-1
				info "Field Name from DB: "& Fields_Collection(i).Name
				dbVal = dbVal & ";" & CountrecordSet.Fields(Fields_Collection(i).Name)
			NEXT
			str1 = str1 & "," & Right(dbVal,len(dbVal)-1)
			dbVal = ""
			CountrecordSet.MoveNext
			r=r+1
		Loop
		str1 = Right(str1,len(str1)-1)
		getRecords = str1
		CountrecordSet.Close
		database.closeConnection
	End Function
	
	'Verify the new record been added in the database
	Public Sub assertVerifyRecordAdded(gridName, ExpValue,sql2,connectionString)
		
		reportController.reportStep m_reportingName & "verifyassertRecordDeleted()"
		rcount = getRecordCount(sql2, connectionString)
		info "rCount : " & rcount
		
		If ExpValue Then
			If Cint(rcount)=0 Then
				assertEquals False,ExpValue,"Record not Added"
			Else
				assertEquals True,ExpValue,"Record Added"
			End If
		Else
			If Cint(rcount)=0 Then
				info"Record Added"
				assertEquals False,ExpValue,"Record Added"
			Else
				assertEquals True,ExpValue,"Record got Added"
			End If
		End If
	End Sub
	
	
	'Verify the deleted record with the database
	Public Sub verifyassertRecordDeleted(ExpValue,sql2,connectionString)
		reportController.reportStep m_reportingName & "verifyassertRecordDeleted()"
		
		rcount = getRecordCount(sql2, connectionString)
		info "rCount : " & rcount
		
		If ExpValue Then
			If Cint(rcount)=0 Then
				assertEquals True,ExpValue,"Record got Deleted"
			Else
				assertEquals False,ExpValue,"Record Not Deleted"
			End If
		Else
			If Cint(rcount)=0 Then
				info"Record not Deleted"
				assertEquals True,ExpValue,"Record Not Deleted"
			Else
				assertEquals False,ExpValue,"Record got Deleted"
			End If
		End If
	End Sub
	
	'Validate the new record added in Database
	Public Sub verifyassertRecordAddedinDB(ExpValue,sql2,connectionString)
		reportController.reportStep m_reportingName & "verifyassertRecordAddedinDB()"
		
		rcount = getRecordCount(sql2, connectionString)
		info "rCount : " & rcount
		
		If ExpValue Then
			If Cint(rcount)>=1 Then
				assertEquals True,ExpValue,"Record got Added"
			Else
				assertEquals False,ExpValue,"Multiple Record Added"
			End If
		Else
			If Cint(rcount)>=1 Then
				assertEquals True,ExpValue,"Record Added"
			Else
				assertEquals True,ExpValue,"Multiple Record Added"
			End If
		End If
	End Sub
	
	'verify the form data deleted from the database
	Public Sub assertRecordDeleted_InFunction(formName,ExpValue,argString)
		reportController.reportStep m_reportingName & ".assertRecordDeleted_InFunction(" & formName & ")"
		
		sql1 = ""
		sql2 = ""
		
		If argString <> "" Then
			arrArg = Split(argString,";")
		End If
		
		connectionString = "IVM_PRODUCTION_DATABASE_CONNECTION_STRING"
		
		select Case formName	
			Case frmDeleteRole
				connectionString = "IVM_PRODUCTION_DATABASE_CONNECTION_STRING"
				sql2 = "Select count(*) from roles where name = '" & arrArg(0) & "'"
			
			Case frmDeleteMaintenanceWindow
				sql2 = "select count(*) from maintenance_windows where name = '" & arrArg(0) & "'"
			Case Else 
				info m_reportingName & ".assertRecordDeleted_InFunction(), " &  " parameters not matched"
				assertequals True,False,formName &" not found, argument passed in the script is invalid"
				Exit Sub
		End Select
		
		If sql2 <> "" then
			verifyassertRecordDeleted ExpValue,sql2,connectionString
		End If
	End Sub
	
	'Function to check if the Static or Dynamic value Exists in database and covert the values
	Public Function Static_Dynamic_DBValueExists(gridName,fieldname,fieldval,connectionString)
		reportManager.reportStep m_reportingName & ".Static_Dynamic_DBValueExists(" & gridName & ")" 
		
		select case gridName
				Case grdReportList
                    Static_Dynamic_DBValueExists = ReportList_getDBFieldValue(fieldname,fieldval,connectionString)
		        Case Else
					Static_Dynamic_DBValueExists = fieldval
		End Select
	End function
	
	'Function to run the query for fetching the particular field values
	Public Function getfieldValue(sql,fieldname,connectionString)
		reportController.reportStep m_reportingName & ".getfieldValue()" 
		
        'Opening the database connection
		info "Opening the database connection"
		database.openConnection connectionString
		
		info "sql -> " & sql
		info "fieldname : " & fieldname

		'Executing Query
		Set ComborecordSet = database.executeQuery(sql)
		If ComborecordSet.EOF Then
			getfieldValue="Null"
			ComborecordSet.Close
			Exit Function
		End if
			
		info "query Executed"
		
		dim CmbDescription
		CmbDescription = ComborecordSet.Fields(fieldname)
		ComborecordSet.Close
		getfieldValue = CmbDescription
	End Function
	
	'Function to get the DB row count for a query
	Public Function getDBRowCount(sql1, connectionString)
		reportController.reportStep m_reportingName & ".getDBRowCount()" 
		
		database.openConnection connectionString
		
		info "connection Open"
		info "query is -->" & sql1
		Set CountrecordSet = database.executeQuery(sql1)
		info "query Executed"
		If CountrecordSet.EOF = "True" Then
			info "NO data available"
			Exit Function
		End If
		
		
		rcount = 0
		
		CountrecordSet.MoveFirst
		do until CountrecordSet.EOF
			rcount = rcount+1
			CountrecordSet.MoveNext
		Loop
		
		info "rcount : " & rcount
		CountrecordSet.Close
		database.closeConnection
		getDBRowCount = rcount
	End Function
	
	'Verify the expected data for form with Actual data in database
	Public Sub assertformRecord_InFunction(formName,ExpValue,strUIValues, strArgString)
		reportController.reportStep m_reportingName & ".assertformRecord_InFunction(" & formName & ")"
		
		sql1 = ""
		sql2 = ""
		
		If strArgString <> "" Then
			arrArg = Split(strArgString,";")
		End If
		connectionString = "IVM_PRODUCTION_DATABASE_CONNECTION_STRING"
	
		
		Select Case formName
			
			Case frmCreateNewUser
				'sql1 = "Select U.user_name, U.name, IV.value, U.role, case U.status when 1 then 'Enabled' when 0 then 'Disabled' END as status From users U left join contacts C on U.id = C.user_id left join info_values IV on C.id = IV.contact_id Where U.user_name = '" & arrArg(0) & "'"
				'sql2 = "Select count(*) From users U left join contacts C on U.id = C.user_id left join info_values IV on C.id = IV.contact_id Where U.user_name = '" & arrArg(0) & "'"
				sql1 = "Select U.user_name From users U Where U.user_name = '" & arrArg(0) & "'"
				sql2 = "Select count(*) From users U Where U.user_name = '" & arrArg(0) & "'"
				
			Case frmEditUser
				sql1 = "Select U.user_name From users U Where U.user_name = '" & arrArg(0) & "'"
				sql2 = "Select count(*) From users U Where U.user_name = '" & arrArg(0) & "'"

			Case frmCreateNewRole
				sql1 = "Select name from roles where name = '" & arrArg(0) & "'"
				sql2 = "Select count(*) from roles where name = '" & arrArg(0) & "'"
				
			Case frmEditRole
				sql1 = "Select name, description from roles where name = '" & arrArg(0) & "'"
				sql2 = "Select count(*) from roles where name = '" & arrArg(0) & "'"

				
			Case frmNewMaintenanceWindow
				sql1 = "select name from maintenance_windows where name = '" & arrArg(0) & "'"
				sql2 = "select count(*) from maintenance_windows where name = '" & arrArg(0) & "'"
				
			Case reportCampaignSummary, reportEndOfCampaign, reportAdvertisementSummary, reportVODAdDelivery, reportAdvertisementandProgramDetails,reportProgramSummary, reportRawData, reportVODAdDeliveryDataFeed, reportRegionSummary, reportUniqueCustomers, reportAllDetails
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
     
				ValidateDataSet formName,ExpValue,strUIValues,strArgString
				Exit Sub
			

	

				
			Case Else 
				info m_reportingName & ".assertformRecord_InFunction(), " &  " parameters not matched"
				assertequals True,False,formName &" not found, argument passed in the script is invalid"
				Exit Sub
		End Select
		
		'validate the values
		If sql1 <> "" and sql2 <> "" then
			verifyassertRecord formName,ExpValue,strUIValues,sql1,sql2,connectionString
		End If
	End Sub
	
	
	'Verify the data with database
	Public Sub verifyassertRecord(formName,ExpValue,strUIValues,sql1,sql2,connectionString)
		reportController.reportStep m_reportingName & "verifyassertRecord(" & formName & ")"
		
		rcount = getRecordCount(sql2,connectionString)
		info "rcount : " & rcount
		If Cint(rcount)>1 Then
			assertEquals 1,Cint(rcount),"Multiple records found for the specified arguments"
			Exit Sub
		End If
		
		'Check If Record set is blank
		If Cint(rcount)=0 Then
			If ExpValue Then
				assertEquals ExpValue,False,"No records found for the specified arguments, Record NOT updated"
			Else
				assertEquals ExpValue,False,"No records found for the specified arguments,Record reverted successfully."
			End If
			Exit Sub
		Else
			If Not(ExpValue) Then
				assertEquals True,operation,"Record found in the database for the specified arguments"
				Exit Sub
			End If
		End If
		
		database.openConnection connectionString
		
		info "connection Open"
		info "Assert record exists Query -->" & sql1
		'Executing Query
		Set recordSet = database.executeQuery(sql1)
		
		'Check If Record set is blank	  
		If recordSet.EOF Then
			info "No record fetched from the database. Check the query"
			Exit Sub
		End If
		
		'Retrieving the grid view fields
		FieldsArr=Split(strUIValues,";")
		
		Set Fields_Collection=recordSet.Fields
		info Fields_Collection.Count
		
		info "DB fields count :" & Fields_Collection.Count
		info "CSV field count : "& UBOUND(FieldsArr) + 1
		
		If UBOUND(FieldsArr)<>Fields_Collection.Count-1 Then
			assertEquals UBOUND(FieldsArr),Fields_Collection.Count-1,"No of editable/non editable fields specified does not match the corresponding database fields."
			Exit Sub
		End If

		blnFlag = True
		recordSet.MoveFirst
		For i=0 to Fields_Collection.Count-1
			info "Loop counter : " & i
			info "Database field name is:" & Fields_Collection(i).Name
			
			DBfield_name = Fields_Collection(i).Name
			info "Database field name is:" & DBfield_name
			
			dbVal = recordSet(i)
			info "Database field value:" & recordSet(i)

			info "Value from UI:" & Trim(FieldsArr(i))
			Select Case formName
				Case frmExtensionDetails,frmSystemOrganizationInstance,frmInstance
				
					Select Case DBfield_name
						Case "Id"
							connectionString = "DATABASE_CONNECTION_STRING"
							sql = "Select loginName from User U where U.Id = '" & dbVal & "'"
							dbVal = getfieldValue(sql,"loginName",connectionString)
						Case "tradingDayStartTime","tradingDayEndTime"
						    temp = Split(dbval,";")
							finalhr = temp(0) * 3600
							finalmin = temp(1) * 60
							dbval = finalhr + finalmin				
					End Select
			End Select
			
			UIVal = Trim(FieldsArr(i))
			
			If IsNull(dbVal) Then
				dbVal="Null"
			End If
			
			'UIVal = Static_Dynamic_UIValueExists(formName,Fields_Collection(i).Name,UIVal,connectionString)
			
			'Checking If the Static and Dynamic Combo Exists
			''dbVal=Static_Dynamic_DBValueExists(formName,Fields_Collection(i).Name,dbVal,connectionString)

			If dbVal="Null" Then
				dbVal = ""
			End If
			'If dbVal="False" Then
			'	dbVal=recordSet.Fields(Fields_Collection(i).Name)
			'End If

			'Function to check the date format
			'If IsDate(dbVal) Then
			'	Select Case gridName
			'		Case "Ethernet Subnets"
			'					dbVal = recordSet.Fields(Fields_Collection(i).Name)
			'		Case Else
			'					dbVal=DatabaseConfig.ConvertDate(dbVal)
			'	End Select
			'End If

			info "Value from DB:" & dbVal
			info "Value from UI:" & UIVal
			
			If IsNull(UIVal) Then
				UIVal="Null"
				info "Column does not exist in the UI file for "&FieldsArr(i)
				assertEquals True,False,"Column does not exist in the UI file for "&FieldsArr(i)
				Exit Sub
			End If

			If ExpValue Then
				If Cstr(dbVal) <> UIVal Then
					assertEquals Cstr(dbVal),UIVal, "Records do not match for "& Fields_Collection(i).Name
					info "Mismatch in DB value and UI value:" & "Failed"
					blnFlag = False
				End If
			Else
				If Cstr(dbVal) = UIVal Then
					assertEquals Cstr(dbVal),UIVal, "Records do not match for "& Fields_Collection(i).Name
					info "Mismatch in DB value and UI value:" & "Failed"
					blnFlag = False
				End If
			End If
				
		Next

		If i=Fields_Collection.Count Then
			If blnFlag then
				assertEquals Fields_Collection.Count,i," All column values are matching"
			Else
				assertEquals True, False, "All column values are not matching"
			End if
		End If
		
        'Closing the Database connection
		database.closeConnection
	End Sub
	
	'This function will compare two recordsets generated by executing sql queries
	Function CompareTables(operation,sql1,sql2,tblname)
		reportController.reportStep m_reportingName & ".CompareTables()" 
		
		Set rs1 = database.executeQuery(sql1)
		Set rs2 = database.executeQuery(sql2)
		If rs2.EOF  Then
			If NOT(rs1.EOF) Then
				assertEquals True,False,"No records in source table but record found in new table for"&tblname
				CompareTables=False
			Else
				CompareTables=True
			End if
			Exit Function
		Else
			If rs1.EOF Then
				assertEquals True,False,"Record exists in the source table but no record in the new table for"&tblname
				CompareTables=False
				Exit Function
			End If
		End If
		Set Fields_Collection_rs1=rs1.Fields
		Set Fields_Collection_rs2=rs2.Fields
		
		countrs1=Fields_Collection_rs1.Count
		info "column count from 1st query is "&countrs1
		countrs2=Fields_Collection_rs2.Count
		info "column count from 2nd query is "&countrs2
		If countrs1 <> countrs2 Then
			info "No. of fields in both the queries are not same for"&tblname
			CompareTables=False
			Exit Function
		End if
		
		'Moving to the first row of both the recordsets
		rs1.MoveFirst
		rs2.MoveFirst
		r=0
		
		Do While Not rs2.EOF
			'Verifying first 20 rows only
			If r=20 Then
				RowFlag=True
				info "Exiting after 20th row...."
				Exit Do
			End if
			cnt=0
			For i=0 to Fields_Collection_rs2.Count-1
				info "column no: "&i+1
				info "row no: "&r+1
				info "Field Name from table: "&Fields_Collection_rs2(i).Name
				dbVal = rs1.Fields(Fields_Collection_rs1(i).Name)
				dbVal1 = rs2.Fields(Fields_Collection_rs2(i).Name)
				info "first dbVal is "&dbVal
				info "2nd dbVal is "&dbVal1
                   
				If dbVal<> dbVal1 Then
					info "In If condn as "&dbVal&" not equal to"&dbVal1
					If operation=True then
						assertEquals dbVal1,dbVal, "Records not matched for table: "&tblname&", fieldname is :"&Fields_Collection_rs2(i).Name&" for row number "&r+1
					End If
					CompareTables=False
				Else
					cnt=cnt+1   
				End if
				
			Next
			If cnt<>i Then
				MismatchFound=True
			End If
			rs1.MoveNext
			rs2.MoveNext
			r=r+1
		Loop
		info "cnt is "&cnt
		info "i is "&i
		
		If MismatchFound Then
			CompareTables=False
		Else
			CompareTables=True
		End If
	End Function

	'The function compares two list value expected v/s actual
	Sub compare(ExpValue,ActValue)
		reportController.reportStep m_reportingName & ".compare()"
		info "Expected Value : " & ExpValue
		info "Actual Value : " & ActValue
		expComboValue=Split(ExpValue,",", -1, 1)
		actComboValue=Split(ActValue,",", -1, 1)
		count=0
		If(UBound(expComboValue)=UBound(actComboValue)) then
			For index = 0 to UBound(expComboValue)
				expComboValue(index) = Replace(cstr(expComboValue(index)),"COMAAA",",")
				actComboValue(index) = Replace(cstr(actComboValue(index)),"COMAAA",",")
				If Trim(cstr(expComboValue(index))) =trim(cstr(actComboValue(index))) then 'comparing the values
					count =count+1
				Else
					assertEquals trim(cstr(expComboValue(index))),trim(cstr(actComboValue(index))) ," values not matched"
				End if
			Next
			If (count = ubound(actComboValue)+1) then
				assertEquals count,ubound(actComboValue)+1," values matched"
			Else
				info "Mismatch found in values"
				assertEquals count,ubound(actComboValue)+1," values not matched"
			End if
		Else
			assertEquals Ubound(expComboValue)+1,ubound(actComboValue)+1, "count of values is not equal"
		End if
	End sub
END CLASS


	''Function to convvert the date into required time zone
	Function ConvertTimeZone (strDate,strTimeZone)
		reportController.reportStep m_reportingName & ".ConvertTimeZone(" & strDate & "," &  strTimeZone & ")" 
		
		od = CDate(strDate)
		nd = od
		
		Select Case strTimeZone
			Case "US"   
				offset = -8
			Case "EST"
				offset = -5
			Case "IST"
				offset = -5
			Case "UTC"
				offset = 0
			Case Else
				ConvertTimeZone = strDate
				Info "No timezone found"
				Exit Function
		End Select 
		
		od = nd
	 
		'Find first Sunday in April 
		For i = 1 to 7 
			if weekday("4/" & i & "/" & year(d))=1 then 
				startDST = cdate("4/" & i & "/" & year(d)) 
				exit for 
			end if 
		next 
	 
		'Find last Sunday in October 
		For i = 31 to 25 step -1 
			if weekday("10/" & i & "/" & year(d))=1 then 
				endDST = cdate("10/" & i & "/" & year(d)) 
				exit for 
			end if 
		next 
		
		'Subtract hour from offset if within DST 
		If cdate(od) >= startDST and cdate(od) < endDST then 
			offset = offset - 1 
		end if 
		
		nd = dateadd("h", offset, od) 
		info "Current Time = " & strdate & "<br>UTC time zone = " & nd
		
		ConvertTimeZone = nd
	End Function

	'Fnction to conver the Time zone time
	Function ConvertTime (strTime)
		reportController.reportStep m_reportingName & ".ConvertTimeZone(" & strDate & "," &  strTimeZone & ")" 
		cond=right(strTime,2)
		If ucase(cond)="AM" Then
			strTime=Replace(strTime,"AM","")
		else
			arr=split(strTime,":")
			arr(0)=arr(0)+12
			strTime=join(arr,":")
			strTime=Replace(strTime,"PM","")
		End If	
		ConvertTime = strTime
	End Function
	
	'Function to convert date format
	Function ConvertDate(d_date,strDateFormat)
		reportController.reportStep m_reportingName & ".ConvertDate()" 
		
		info "Converting the Date : " & d_date
		info "Convert date format : " & strDateFormat
		
		yr=Year(d_date)
		mn=Month(d_Date)
		dy=Day(d_date)
		hr=Hour(d_date)
		min=Minute(d_date)
		sec=Second(d_date)
		If hr > 12 then
			strAMPM = "PM"
		Else
			strAMPM = "AM"
		End If
		if instr (1,strDateFormat,"24") > 0 Then
		Else
			If hr > 12 then
				hr = 24 - hr
			End If
		End If
		If Len(mn)=1 Then
			mn="0"&mn
		End If
		If Len(dy)=1 Then
		    dy="0"&dy
		End If
		If Len(hr)=1 Then
		    hr="0"&hr
		End If
		If Len(min)=1 Then
		    min="0"&min
		End If
		If Len(sec)=1 Then
		    sec="0"&sec
		End If
		
		Select Case strDateFormat
		
			Case "MON-DATE-YR HR:MIN:SEC"
				ConvertDate=mn & "-" & dy & "-" & yr & " " & hr & ":" & min & ":" & sec
				
			Case "MON-DATE-YR"
				ConvertDate=mn & "-" & dy & "-" & yr
			Case "YR-MON-DATE"
				ConvertDate=yr & "-" & mn & "-" & dy
				
			Case "DATE-MON-YR"
                ConvertDate= dy & "-" & mn & "-" & yr  
				
			Case "MON/DATE/YR"
				ConvertDate=mn & "/" & dy & "/" & yr
				
			Case "MONTH DATE, YR"
				mn = MonthName(mn,True)
				ConvertDate=mn & " " & dy & ", " & yr
			Case "MONTH DATE, YR HR:MIN:SEC AM EDT"
				mn = MonthName(mn,True)
				REM If hr = 0 Then
					REM hr = "12"
					REM min = "00"
					REM sec = "00"
				REM End If
				ConvertDate=mn & " " & dy & ", " & yr	& " " & hr & ":" & min & ":" & sec	& " "& strAMPM & " EDT"
				
			Case "MONTH DATE, YR HR:MIN:SEC AM EST"
				mn = MonthName(mn,True)
				
				If hr = 0 Then
					hr = "12"
					min = "00"
					sec = "00"
				End If
				ConvertDate=mn & " " & dy & ", " & yr	& " " & hr & ":" & min & ":" & sec	&" "& strAMPM & " EST"
				
			Case "MONTH DATE, YR HR:MIN:SEC AM EST 24"
				mn = MonthName(mn,True)
				REM If hr = 0 Then
					REM hr = "12"
					REM min = "00"
					REM sec = "00"
				REM End If
				ConvertDate=mn & " " & dy & ", " & yr	& " " & hr & ":" & min & ":" & sec	&" "& strAMPM & " EST"
				
			Case "MONTH DATE, YR HR:MIN:SEC EST 24"
				mn = MonthName(mn,True)
				
				ConvertDate=mn & " " & dy & ", " & yr	& " " & hr & ":" & min & ":" & sec & " EST"
				
			Case "MONTH DATE, YR HR:MIN:SEC AM"
				mn = MonthName(mn,True)
				If hr = 0 Then
					hr = "12"
					min = "00"
					sec = "00"
				End If
				ConvertDate=mn & " " & dy & ", " & yr	& " " & hr & ":" & min & ":" & sec	& " "& strAMPM
		
		End Select
	End Function
	
	'Function to get the list values from Web API
	Function getListValuesFromAPI(DG_URL,query)
		reportController.reportStep m_reportingName & ".getListValuesFromAPI(" & query & ")" 
		Info "DG -URL : " & DG_URL
		
		Set objXML = new XMLClassProxy
		'strWebServiceURL = "http://192.168.210.139:8080/datagateway/api/alerts/summary?q="
		strWebServiceURL = DG_URL
		
		objXML.getWSXML(strWebServiceURL)

		'query =  "dataRow/date"
		a_Val = objXML.getListXMLValue(query)

		arr_a_Val = Split(a_Val,";")
						
		If Ubound(arr_a_Val) = 0 Then
			strData = a_Val
		Else
			For ik = 0 to Ubound(arr_a_Val)
				str = arr_a_Val(ik)
				str1 = str1&";"&str
				str = ""
				strData =  mid(str1,"2")
			Next
		End If
		getListValuesFromAPI = strData
		Set objXML = Nothing
		
	End Function
	
	'Function to validate the dataset in the database and values for the dataset
	Public Sub ValidateDataSet (formName,ExpValue,strUIValues,strArgString)
		reportController.reportStep m_reportingName & ".ValidateDataSet(" & formName & ")"
		
		
		Select Case formName
			Case reportCampaignSummary
				strReport = "CampaignSummary"
			Case reportEndOfCampaign
				strReport = "EndOfCampaign"	
				
			Case reportRawData
				strReport = "RawData"
			Case reportVODAdDeliveryDataFeed
				strReport = "VODAdDeliveryDataFeed"
				
			Case reportVODAdDelivery
				strReport = "VodAdDelivery"
				
			Case reportProgramSummary
				strReport = "ProgramSummary"
			Case reportRegionSummary
				strReport = "RegionSummary"	
			Case reportAdvertisementSummary
				strReport = "AdSummary"	
				
			Case reportAdvertisementandProgramDetails
				strReport = "AdProgramDetails"
			Case reportUniqueCustomers
				strReport = "UniqueCustomers"	
			Case reportAllDetails
				strReport = "AllDetails"
		End Select
		
		strDataSetTime=Replace(ExpValue,"-","")
		strDataSetTime=Replace(strDataSetTime,":","")
		
		sql1= "SELECT datasetName FROM sys_dataset  where datasetName like '" & strReport &"%" & strDataSetTime & "%'"
		sql2="SELECT count(*) from sys_dataset  where datasetName like '" & strReport &"%" & strDataSetTime & "%'"

		
		connectionString= "IVM_SYS_DATABASE_CONNECTION_STRING"
		dataCount=DatabaseConfig.getRecordCount(sql2,connectionString)
		If  cint(dataCount)>1 Then
			Info "More than one dataset found"
			Exit sub
		End If
		
		If  cint(dataCount) = 1 Then
			assertEquals strArgString, True, "Dataset  found"
		Else
			assertEquals strArgString, False, "Dataset not found"
			Exit Sub
		End If
		
		datasetname1=DatabaseConfig.getRecords(sql1,connectionString)
		
		sql2="SELECT parameters FROM sys_dataset  where datasetName = '" & datasetname1  & "'"
		param=DatabaseConfig.getRecords (sql2,connectionString)
		
		param1=Replace(param,"[","")
		param1=Replace(param1,"]","")
		param1=Replace(param1,"{","")
		param1=Replace(param1,"}","")
		param1=Replace(param1,"""","")

		param1=Right(param1,len(param1)-11)

		arrDbVal=split(param1,",")
		arrUiVal=split(strUIValues,",")

	 If  cint(dataCount) = 1 Then
		assertEquals strArgString, True, "Dataset  found"
	Else
		assertEquals strArgString, False, "Dataset not found"
		Exit Sub
	End If


	For i=0 to ubound (arrDbVal)

		Val=split(arrDbVal(i),":")
		strParamName=Val(0)

   Select Case formName

					Case "Campaign Summary","Advertisement Summary","End of Campaign","Region Summary","Program Summary","Unique Customers","Advertisement And Program Details","All Details","EndOfCampaign"

						Select Case strParamName

								Case "Start Date"
										info "Value from DB: " &Val(1)
										info "Value from UI: " &arrUiVal(0)
										assertEquals Trim(val(1)),Trim(arrUiVal(0)),"Values are not equal."

								Case "Group By"
										info "Value from DB: " &Val(1)
										info "Value from UI: " &arrUiVal(5)
										assertEquals Trim(val(1)),Trim(arrUiVal(5)),"Values are not equal."

								Case "Provider"
										info "Value from DB: " &Val(1)
										info "Value from UI: " &arrUiVal(3)
										assertEquals Trim(val(1)),Trim(arrUiVal(3)),"Values are not equal."

								Case "End Date"
										info "Value from DB: " &Val(1)
										info "Value from UI: " &arrUiVal(1)
										assertEquals Trim(val(1)),Trim(arrUiVal(1)),"Values are not equal."

								Case "Campaign"
										
										info "Value from DB: " & Val(1)
										info "Value from UI: " &arrUiVal(2)
										assertEquals Trim(val(1)),Trim(arrUiVal(2)),"Values are not equal."

								Case "Site"
										
										info "Value from DB: " &(Val(1))
										info "Value from UI: " &arrUiVal(4)
										assertEquals Trim(Val(1)),Trim(arrUiVal(4)),"Values are not equal."


								End select

					Case "VodAdDelivery"

						Select case strParamName
								Case """Start Date"""
										info "Value from DB: " &Val(1)
										info "Value from UI: " &arrUiVal(0)
										assertEquals Trim(val(1)),""""&Trim(arrUiVal(0))&"""","Values are not equal."

								Case """End Date"""
										info "Value from DB: " &Val(1)
										info "Value from UI: " &arrUiVal(1)
										assertEquals Trim(val(1)),""""&Trim(arrUiVal(1))&"""","Values are not equal."

						End Select
						
				  Case "Raw Data"
				        Select Case strParamName

								Case "Start Date"
										info "Value from DB: " &Val(1)
										info "Value from UI: " &arrUiVal(0)
										assertEquals Trim(val(1)),Trim(arrUiVal(0)),"Values are not equal."

								Case "Provider"
										info "Value from DB: " &Val(1)
										info "Value from UI: " &arrUiVal(3)
										assertEquals Trim(val(1)),Trim(arrUiVal(3)),"Values are not equal."

								Case "End Date"
										info "Value from DB: " &Val(1)
										info "Value from UI: " &arrUiVal(1)
										assertEquals Trim(val(1)),Trim(arrUiVal(1)),"Values are not equal."

								Case "Campaign"
										
										info "Value from DB: " & Val(1)
										info "Value from UI: " &arrUiVal(2)
										assertEquals Trim(val(1)),Trim(arrUiVal(2)),"Values are not equal."

								Case "Site"
										
										info "Value from DB: " &Val(1)
										info "Value from UI: " &arrUiVal(4)
										assertEquals Trim(val(1)),Trim(arrUiVal(4)),"Values are not equal."
								End select		
					
					Case Else
					Info "Invalid parameter"
					assertEquals "True","False", "Report not found"
		End Select

	Next

		sql3="SELECT count(*) from information_schema.tables where table_name = '"& datasetname1 &"'"
		strCount= DatabaseConfig.getRecordCount(sql3,connectionString)


	If cint(strCount )> 0 Then
		Info "Dataset table exist"
		assertequals strArgString,True ,"Dataset Table does not exist"

	Else
	   Info "Dataset table does not exist"
		assertequals strArgString,False ,"Dataset Table does not exist"

	End If

End Sub

'Function to get the 
Function getDate(strOption,strTimeZone,Offset)
	reportController.reportStep m_reportingName & ".ConvertTimeZone(" & strDate & "," &  strTimeZone & ")" 
	
	CurrentTime=now()
	nd = CurrentTime
		
		Select Case strTimeZone
			Case "US"   
				offset = -8
			Case "EST"
				offsetHr=-9 
				offsetMn=-30
			Case"EDT"
				offsetHr=-9 
				offsetMn=-30
			Case "IST"
				offset = -5
			Case "UTC"
				offsetHr=-5
				offsetMn=-30
				
			Case Else
				ConvertTimeZone = strDate
				Info "No timezone found"
				Exit Function
		End Select 
		
		od = nd
		offsetMn=offsetMn+Offset

		nd=dateadd("n",offsetMn,od)
		nd = dateadd("h", offsetHr, nd) 
		


		Select Case strOption

			Case "Time"
				hr=hour(nd)
				min=minute(nd)

				If len(hr)=1 then
				hr="0"&hr
				End if
				If len(min)=1 then
				min="0"&min
				End if
				  
				  strOut=hr&":"&min
		
			Case "Date"
				dt=day(nd)
				mt=month(nd)
				yr=year(nd)
				If len(dt)=1 then
				dt="0"&dt
				End if
				If len(mt)=1 then
				mt="0"&mt
				End if
				
				strOut=yr&"-"&mt&"-"&dt

			Case else
				hr=hour(nd)
				min=minute(nd)
				dt=day(nd)
				mt=month(nd)
				yr=year(nd)

				If len(hr)=1 Then
					strOut=yr&"-"&mt&"-"&dt &" "&"0"& hr&":"&min
				Else
				strOut=yr&"-"&mt&"-"&dt &" "& hr&":"&min
				End If
				
				
		End Select

	Info "Converted date time is:" & strOut
	getDate = strOut

End function

' Function to get the dataset name for the report scheduled at particular time.
Public Function getDataSetName(strReport,ExpValue)
	reportController.reportStep m_reportingName & ".getDataSetName(" & strArg & ")"
		select case strReport
		
			case "VOD Ad Delivery Data Feed"
				strReportName =	"VodAdDelivery"
				
			case "Advertisement Summary"
				strReportName = "AdSummary"

			case "Advertisement And Program Details"
				strReportName =	"AdProgramDetails"

			case else	
			strReportName=Replace(strReport," ","")
			strDataSetTime=Replace(ExpValue,"-","")
			strDataSetTime=Replace(strDataSetTime,":","")
			connectionString= "IVM_SYS_DATABASE_CONNECTION_STRING"
			sql3="SELECT datasetName FROM sys_dataset  where datasetName like '" & strReportName &"%" & strDataSetTime & "%'"
			
			dataSet=databaseConfig.getRecords(sql3,connectionString)
			getDataSetName=dataSet
		End Select	
End function

