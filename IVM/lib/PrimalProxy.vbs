

Set wsHTTPReq = New webServiceRequest 
DG_URL=Environment.Value("DATA_GATEWAY_URL")
'--------------------------------------------------------------------------------------------------------------------------------------------------
' (c) Copyright Fonantrix Solution
'
' File Name						:	PrimalProxy.vbs 
' Description					:	This is proxy file containing classes and functions for various controls like Weblink, webButton, WebEdit etc.
' Author 						:   Fonantrix Solution
' Date 							:   
'--------------------------------------------------------------------------------------------------------------------------------------------------
Num_Rows_to_execute = 10
'################## WebLINK PROXY ###############################
'Represents a WebLink. Examples: Press , exists
'################## WebLINK PROXY ###############################
Class WebLinkProxy
	Public m_target, m_name, m_reportingName
	'For internal API use only
	Public Sub internal_assign(parentTarget, parentReportingName, name)
		m_reportingName = parentReportingName & ".WebLinkProxy(" & name & ")"
		reportController.reportStep m_reportingName & ".internal_assign()"
		m_name = name
		Set m_target = parenttarget.Link("lnk" & m_name )
	End Sub

	'Assert existance of the Object
	Public Sub assertExist(state)
		'm_target.getroproperty("text")
		reportController.reportStep m_reportingName & ".assertExist("  & state & ")"
		'waitForSync m_target
		assertEquals Trim(state), Trim(m_target.Exist(2)),m_reportingName
	End Sub
	
	Public Sub assertText(strExpValue)
		reportController.reportStep m_reportingName & ".assertText(" & strExpValue &")"
		assertEquals True, Trim(m_target.Exist), m_reportingName			
		assertEquals trim(strExpValue), Trim(m_target.GetROProperty("innertext")), m_reportingName
	End Sub
	
	'Sends click event to target object.
	Public Sub press
		reportController.reportStep m_reportingName & ".press()"
		If m_target.Exist(5) Then
			m_target.Click		
		End If
		wait 5
	End Sub

	'Asserts Link Status like Enable,Disable,Visible, Not visible
    Public Sub assertStatus(expectedStatus)
		reportController.reportStep m_reportingName & ".assertStatus(" & expectedStatus & ")"
		Select Case expectedStatus
			Case "Enable"
				assertEquals 0, m_target.GetROProperty("disabled"), m_reportingName
			Case "Disable"
				assertEquals 1, m_target.GetROProperty("disabled"), m_reportingName
			Case "Visible"
				assertEquals True, m_target.GetROProperty("visible"), m_reportingName
			Case "NotVisible"
				assertEquals False, m_target.GetROProperty("visible"), m_reportingName
			Case "Selected"
				If m_target.GetROProperty("class") = "tabsLink tabsSelected" Then
					assertEquals True, True, m_reportingName
				Else
					assertEquals True, False, m_reportingName
				End If
			Case "NotSelected"
				If m_target.GetROProperty("class") = "tabsLink tabsSelected" Then
					assertEquals True, False, m_reportingName
				Else
					assertEquals True, True, m_reportingName
				End If
		End Select
	End Sub
	
	Public Sub getStatus(expectedStatus)
		reportController.reportStep m_reportingName & ".getStatus(" & expectedStatus & ")"
		Select Case expectedStatus
			Case "Exist"
				getStatus = m_target.exist(0)
		End Select
	End Sub
End class	

'################## Webelement PROXY ###############################
'Represents a Webelement. Examples: Press , exists
'################## Webelement PROXY ###############################
Class WebelementProxy
	Public m_target, m_name, m_reportingName
	'For internal API use only
	Public Sub internal_assign(parentTarget, parentReportingName, name)
		m_reportingName = parentReportingName & ".WebelementProxy(" & name & ")"
		reportController.reportStep m_reportingName & ".internal_assign()"
		m_name = name
		Set m_target = parenttarget.WebElement("we" & m_name)
	End Sub
	
	'Assert existance of the Object
	Public Sub assertExist(state)
		reportController.reportStep m_reportingName & ".assertExist("  & state & ")"
		'waitForSync m_target
		assertEquals Trim(state), Trim(m_target.Exist(0)), m_reportingName
	End Sub
	
	'Assert text of the Object
	Public Sub assertText(strExpValue)
		reportController.reportStep m_reportingName & ".assertText(" & strExpValue &")"
		assertEquals True, Trim(m_target.Exist), m_reportingName
		assertEquals trim(strExpValue), Trim(m_target.GetROProperty("innertext")), m_reportingName
	End Sub
	
	'Assert text of the Object
	Public Sub assertErrorText(strExpValue)
		reportController.reportStep m_reportingName & ".assertErrorText(" & strExpValue &")"
		'assertEquals True, Trim(m_target.Exist), m_reportingName
		strinnertext =  Trim(m_target.GetROProperty("innertext"))
		If strinnertext = "" Then
			assertEquals True, False, "Error not Exist"
		End iF
		assertEquals trim(strExpValue),strinnertext, m_reportingName
	End Sub
	
	'Assert text of the Object
	Public Sub assertErrorInfoText(strExpValue)
		reportController.reportStep m_reportingName & ".assertErrorInfoText(" & strExpValue &")"
		'assertEquals True, Trim(m_target.Exist), m_reportingName
		If Trim(m_target.GetROProperty("innertext")) = "" Then
			assertEquals True, False, "Error not Exist"
		End iF
		If instr(1,m_target.GetROProperty("innertext"),strExpValue) > 0 Then
			assertEquals True, True, "Error found :" & strExpValue
		Else
			assertEquals True, false, "Error not found :" & strExpValue
		End If
	End Sub
	
	'Sends click event to target object.
	Public Sub press
		reportController.reportStep m_reportingName & ".press()"
		If m_target.Exist(5) Then
		Setting.WebPackage("ReplayType") = 2
			m_target.Click
		End If
	End Sub

	'Asserts web element Status like Enable,Disable,Visible, Not visible
    Public Sub assertStatus(expectedStatus)
		reportController.reportStep m_reportingName & ".assertStatus(" & expectedStatus & ")"
		Select Case expectedStatus
			Case "Enable"
				assertEquals 0, m_target.GetROProperty("disabled"), m_reportingName
			Case "Disable"
				assertEquals 1, m_target.GetROProperty("disabled"), m_reportingName
			Case "Visible"
				assertEquals True, m_target.GetROProperty("visible"), m_reportingName
			Case "NotVisible"
				assertEquals False, m_target.GetROProperty("visible"), m_reportingName
		End Select
	End Sub
	
End class	

'################## WebcheckBox PROXY ###############################
'Represents a WebcheckBox. Examples: Setstate , exists, status etc.
'################## WebcheckBox PROXY ###############################
Class WebcheckBoxProxy
  Public m_target, m_name, m_reportingName
  Public Sub internal_assign(parentTarget, parentReportingName, name)
		m_reportingName = parentReportingName & ".WebcheckBox(" & name & ")"
		reportController.reportStep m_reportingName & ".internal_assign()"
		m_name = name
		Set m_target = parentTarget.WebCheckBox("cbox" & m_name)
	End Sub
	
	'Assert existance off the Object
	'@param - state of the object'
	Public Sub assertExist(state)
		reportController.reportStep m_reportingName & ".assertExist("  & state & ")"
		'waitForSync m_target
		assertEquals Trim(state), Trim(m_target.Exist(0)), m_reportingName
	End Sub
	
	'@param - expected as string
	Public Sub assertStatus(expectedStatus)
		reportController.reportStep m_reportingName & ".assertStatus(" & expectedStatus & ")"
		Select Case expectedStatus
			Case "Checked"
				assertEquals 1, m_target.GetROProperty("checked"), m_reportingName
			Case "UnChecked"
				assertEquals 0, m_target.GetROProperty("checked"), m_reportingName
			Case "Visible"
				assertEquals True, m_target.GetROProperty("visible"), m_reportingName
			Case "NotVisible"
				assertEquals False, m_target.GetROProperty("visible"), m_reportingName
			Case "Disabled"
				assertEquals 1, m_target.GetROProperty("disabled"), m_reportingName
			case else
			failTest m_reportingName & ".assertStatus()" & " Invalid expected Status " & expectedStatus 
		End Select
	End Sub 
	
	'Sends click event to set target object.
	Public Sub setState(expected)
		reportController.reportStep m_reportingName & ".setState(" & expected & ")"
		expected = Cstr(expected)
		
		If expected = "UnChecked" Then
			If m_target.GetROProperty("checked") = 1 Then
				m_target.Set "OFF"
				Exit Sub
			End If
			If m_target.GetROProperty("checked") = 0 Then
				Exit Sub
			End If
		End If
		
		If expected = "Checked" Then
			If m_target.GetROProperty("checked") = 1 Then
				Exit Sub
			End If
			If m_target.GetROProperty("checked") = 0 Then
				m_target.Set "ON"
				Exit Sub
			End If
		End If
	End Sub
End class
	
'################## ButtonProxy PROXY ###############################
'Represents a WebButton. Examples: press , exists, status etc.
'################## ButtonProxy PROXY ###############################
Class WebButtonProxy
	Public m_target, m_name, m_reportingName, m_clickTarget
		
	'For internal API use only
	Public Sub internal_assign(parentTarget, parentReportingName, name)
		m_reportingName = parentReportingName & ".Webbutton(" & name & ")"
		reportController.reportStep m_reportingName & ".internal_assign()"
		m_name = name
		Set m_target =  parentTarget.WebButton("btn"& m_name)
	End Sub

	'Sends click event to target object.
	Public Sub press
		reportController.reportStep m_reportingName & ".press()"
		If pageName = confirmation_page then
			if m_target.exist(0)  = True then
				m_target.Click
				wait 5
			End If
			Exit Sub
		End If
		If m_target.Exist(5) Then
			If m_target.GetROProperty("disabled") = 0 Then
				m_target.Click
				Else
				failTest m_reportingName & ".press()" & " Button not enabled " & m_name 
			End If
		Else
			failTest m_reportingName & ".press()" & " Button not found " & m_name 
		End If
		wait 5
	End Sub
	
	'Asserts Button Status like Enable,Disable,Visible, Not visible
    Public Sub assertStatus(expectedStatus)
		reportController.reportStep m_reportingName & ".assertStatus(" & expectedStatus & ")"
		Select Case expectedStatus
			Case "Enable"
				assertEquals 0, m_target.GetROProperty("disabled"), m_reportingName
			Case "Disable"
				assertEquals 1, m_target.GetROProperty("disabled"), m_reportingName
			Case "Visible"
				assertEquals True, m_target.GetROProperty("visible"), m_reportingName
			Case "NotVisible"
				assertEquals False, m_target.GetROProperty("visible"), m_reportingName
		End Select
	End Sub
	
	'Assert existance off the Object
	'@param - state of the object'
	Public Sub assertExist(state)
		reportController.reportStep m_reportingName & ".assertExist("  & state & ")"
		'waitForSync m_target
		assertEquals Trim(state), Trim(m_target.Exist(0)), m_reportingName
	End Sub
	
	'Assert Caption of the Object
	Public Sub assertCaption(expected)
		reportController.reportStep m_reportingName & ".assertCaption(" & expected & ")"
		assertEquals Trim(expected), Trim(m_target.GetROProperty("name")), m_reportingName & "(" & expected & ")"
	End Sub
	
	
	
End Class

'################ RADIO GROUP PROXY ##################################
'Represents a WebRadioGroup proxy. Examples: press , exists, status etc.
'################ RADIO GROUP PROXY ##################################
Class WebRadioGroupProxy
	Private m_target, m_name, m_reportingName
	
	'For internal API use only
	Public Sub internal_assign(parentTarget, parentReportingName, name)
		m_reportingName = parentReportingName & ".WebradioGroup(" & name & ")"
		reportController.reportStep m_reportingName & ".internal_assign()"
		m_name = name
		Set m_target = parentTarget.WebRadioGroup("radiogrp" & m_name)
	End Sub
	
	'@param - expected as string
	Public Sub assertStatus(expectedStatus)
		reportController.reportStep m_reportingName & ".assertStatus(" & expectedStatus & ")" 
		Select Case expectedStatus
			Case "Visible"
				assertEquals True, trim(m_target.GetROProperty("visible")), m_reportingName
			Case "NotVisible"
				assertEquals False, trim(m_target.GetROProperty("visible")), m_reportingName
			Case "Enabled"
			    assertEquals "true",m_target.GetROProperty("value"), m_reportingName 
			Case "Disabled"	
				assertEquals "false",trim(m_target.GetROProperty("value")), m_reportingName 
							
			case else
			    failTest m_reportingName & ".assertStatus()" & " Invalid expected Status " & expectedStatus 
		End Select
	End Sub 
	
	Public Sub assertSelectedItem(expectedValue)
		reportController.reportStep m_reportingName & ".assertSelectedItem(" & expectedValue & ")" 
		assertEquals expectedValue, trim(m_target.GetROProperty("value")), m_reportingName
	End Sub 
	
	'Assert existance off the Object
	Public Sub assertExist(state)
		reportController.reportStep m_reportingName & ".assertExist(" & state & ")" 
		'waitForSync m_target
		assertEquals Trim(state), Trim(m_target.Exist(5)), m_reportingName
	End Sub
	
	'Sends click event to target object.
	Public Sub SelectGroupItem(itemname)
		reportController.reportStep m_reportingName & ".SelectGroupItem(" & itemname & ")" 
		Select Case itemname
			Case "Enabled"
				itemname = "true"
			Case "Disabled"
				itemname = "false"
			Case "Central Site"
				itemname = "Site"
			Case "Show both successfully played and failed spot information "
				itemname = "failedAndSuccess"
			Case "Show only failed spot information"
				itemname = "onlyFailed"
		End Select
		
		'Neha 
		itemname_All=m_target.GetROProperty("all items")
			if Instr(1,itemname_All,itemname) > 0 then
				If m_target.Exist(5) Then
					m_target.Select itemname
				Else
					failTest m_reportingName & ".press()" & " Web Radio group not found " & m_name 
			End If
		End if 
	End Sub
	
	'Sends click event to target object.
	Public Sub assertGroupItems(groupname)
		reportController.reportStep m_reportingName & ".SelectGroupItem"
		If m_target.Exist(5) Then
			Select Case groupname

				Case ""
					expItems = ""

			End Select
			strAllItems = m_target.GetROProperty("all items")
			assertEquals Trim(expItems),Trim(strAllItems), "Group Items not matched" 
		Else
			failTest m_reportingName & ".press()" & " Web Radio group not found " & m_name 
		End If
	End Sub
Public Sub assertDataSetDB(formName)
		reportController.reportStep m_reportingName & ".assertDataSetDB "&formName 
		strAllItems = m_target.GetROProperty("all items")
		Select Case formName
		Case reportCampaignSummary
			strReport = "CampaignSummary"
	    Case reportEndOfCampaign
			strReport = "EndOfCampaign"	
		Case reportRawData
			strReport = "RawData"
	    Case reportVODAdDeliveryDataFeed
			strReport = "VODAdDeliveryDataFeed"
		Case reportProgramSummary
			strReport = "ProgramSummary"
	    Case reportRegionSummary
			strReport = "RegionSummary"	
		Case reportAdvertisementSummary
			strReport = "AdvertisementSummary"
		Case reportUniqueCustomers
			strReport = "UniqueCustomers"
		Case reportAllDetails
			strReport = "AllDetails"
		Case reportAdvertisementandProgramDetails
			strReport = "AdvertisementandProgramDetails"
			
	End Select
   
   sql1= "SELECT datasetName FROM sys_dataset  where datasetName like '" & "%" &strReport &"%' order by dataSetName"
	connectionString= "IVM_SYS_DATABASE_CONNECTION_STRING"
	dbValues=DatabaseConfig.getRecords (sql1,connectionString)
	
	If dbValues="" then
		failTest m_reportingName & ".assetDataSetDB()" & " Data not found " & m_name  
	End If
	arrDbValues=split(dbValues,",")
	arrUiVal=split(strAllItems,";")
	
	For i=0 to Ubound(arrUiVal)
		info "UI value :" &arrUiVal(i)
		info "DB value :" &arrDbValues(i)
		assertEquals arrUiVal(i),arrDbValues(i),"Values not matched"
	Next
End Sub
End class

'################ RADIO GROUP PROXY ##################################	
'Represents a WebImage. Examples: press , exists, status etc.
'################ RADIO GROUP PROXY ##################################
Class WebImageProxy
	Private m_target, m_name, m_reportingName

    'For internal API use only
	Public Sub internal_assign(parentTarget, parentReportingName, name)
		m_reportingName = parentReportingName & ".WebimageProxy(" & name & ")"
		reportController.reportStep m_reportingName & ".internal_assign()"
		m_name = name
		Set m_target = parentTarget.Image("img" & m_name)
	End Sub
	
	'Sends click event to target object.
	Public Sub press
		reportController.reportStep m_reportingName & ".press"
		if m_target.Exist(5) Then
			m_target.Click
		Else
		    failTest m_reportingName & ".press()" & "Image not found " & m_name 
		End if
	End Sub
	
	'Asserts the status of the object
	Public Sub assertStatus(expectedStatus)
		reportController.reportStep m_reportingName & ".assertStatus(" & expectedStatus & ")"
		If  m_target.Exist(5) Then
			Select Case expectedStatus
				Case "Visible"
					assertEquals True, m_target.GetROProperty("visible"), m_reportingName
				Case "NotVisible"
					assertEquals False, m_target.GetROProperty("visible"), m_reportingName
			End Select
		Else
			assertEquals True, False, m_reportingName & " Image not found "
			failTest m_reportingName &  " Image not found " & m_name 		
		End If
	End Sub
	
	'Assert existance off the Object
	'@param - state of the object
	Public Sub assertExist(state)
		reportController.reportStep m_reportingName & ".assertExist(" & state & ")"
		'waitForSync m_target
		assertEquals trim(state), Trim(m_target.Exist(5)), m_reportingName
	End Sub
End Class

'############# WEBTABLE PROXY ######################################
'Represents a WebTable. Examples: press , exists, status etc.
'############# WEBTABLE PROXY ######################################
Class WebTableProxy
    Private m_target, m_name, m_reportingName
	Private rCount, rowCount, colCount, recCount, guifld, dbfld

	'For internal API use only
	Public Sub internal_assign(parentTarget, parentReportingName, name)
		m_reportingName = parentReportingName & ".webTable(" & name &")"
		reportController.reportStep m_reportingName & ".internal_assign()"
		m_name = name		
		wait 5
		Set m_target = parenttarget.WebTable("tbl" & m_name)
	End Sub
	
	'Assert existance off the Object
	'@param - state of the object
	Public Sub assertExist(state)
		reportController.reportStep m_reportingName & ".assertExist(" & state & ")"
		'waitForSync m_target
		assertEquals trim(state), Trim(m_target.Exist(5)), m_reportingName
	End Sub
	
	Public Sub assertValue(searchVal,ColNo)
		reportController.reportStep m_reportingName & ".assertValue(" & searchVal & ")"
		intNum = m_target.GetRowWithCellText(Trim(searchVal))
		debug "Row no : " & intNum
		If m_name = "LocationPermission" Then
			If intNum <= 0 then
				assertEquals "Value not found in the table : " & searchVal
			End If
			Exit Sub
		End If
		Select Case formName 
			Case  "Reports"
					ColNo = ColNo
		End Select
		actVal = m_target.GetCellData(intNum,ColNo)
		assertEquals Replace(cstr(Trim(searchVal)), ",", ""),Replace(cstr(trim(actVal)), ",",""),"Both Values should be equal"
	End Sub
	
	Public Sub assertDelValue(searchVal)
		reportController.reportStep m_reportingName & ".assertDelValue(" & searchVal & ")"
		intNum = m_target.GetRowWithCellText(Trim(searchVal))
		 assertEquals "-1",intNum,m_reportingName
	End Sub	 
	'Click on checkbox of a row with a particular value 
	Public Sub pressTblCheckBox(searchValue,cboxcol)
		reportController.reportStep m_reportingName & ".pressTblCheckBox(" & searchValue & ")"
		intNum = m_target.GetRowWithCellText(searchValue)
		Set oChild = m_target.ChildItem(intNum,cboxcol,"WebCheckBox",0)
		If (oChild.GetROProperty("checked") = 0) Then
			oChild.Set "ON"
		Else
			oChild.Set "OFF"
        End If
	End Sub
	
	Public Sub presstblRadioBtn(searchValue,Radiobtncol)
		reportController.reportStep m_reportingName & ".presstblRadioBtn(" & searchValue & ")"
		intNum = m_target.GetRowWithCellText(searchValue)
		Set  oChild = m_target.ChildItem(intNum,Radiobtncol,"WebRadioGroup",0)
		oChild.Select searchValue
	End Sub
	
	Public Sub expandDataSet(searchValue,col)
		reportController.reportStep m_reportingName & ".expandDataSet(" & searchValue & ")"
		intNum = m_target.GetRowWithCellText(searchValue)
		Set  oChild = m_target.ChildItem(intNum,col,"WebElement",0)
		oChild.Click
	End Sub
	
	Public Sub closeDataSet(searchValue,col)
		reportController.reportStep m_reportingName & ".expandDataSet(" & searchValue & ")"
		intNum = m_target.GetRowWithCellText(searchValue)
		Set  oChild = m_target.ChildItem(intNum,col,"WebElement",0)
		oChild.Click
	End Sub
	
	Public Sub assertTblCheckBox(searchValue,cboxcol,expValue)
		reportController.reportStep m_reportingName & ".assertTblCheckBox(" & searchValue & ")"
		intNum = m_target.GetRowWithCellText(searchValue)
		Set oChild = m_target.ChildItem(intNum,cboxcol,"WebCheckBox",0)
		If (oChild.GetROProperty("checked") = 0) Then
			blnFlag = "False"
		Else
			blnFlag = "True"
        End If
		assertEquals blnFlag, expValue, "Value of chech box doesn't match for :" & searchValue
	End Sub
	
	
		Public Sub assertTblRadioBtn(searchValue,rbtncol,expValue)
		reportController.reportStep m_reportingName & ".assertTblRadioBtn(" & searchValue & ")"
		intNum = m_target.GetRowWithCellText(searchValue)
		Set oChild = m_target.ChildItem(intNum,rbtncol,"WebRadioGroup",0)
		If (oChild.GetROProperty("select") = 0) Then
			blnFlag = "False"
		Else
			blnFlag = "True"
        End If
		assertEquals blnFlag, expValue, "Value of radio button doesn't match for :" & searchValue
	End Sub

	
	Public Sub assertAllTblCheckBox(cboxcol,expValue)
		reportController.reportStep m_reportingName & ".assertTblCheckBox(" & searchValue & ")"
		intNum = m_target.GetROProperty("rows")
		blnFlag = "True"
		For ik = 2 to intNum - 1
			Set oChild = m_target.ChildItem(ik,cboxcol,"WebCheckBox",0)
			If (oChild.GetROProperty("checked") = 0) Then
				blnFlag = "False"
				Exit For
			End If
		Next
		assertEquals blnFlag, expValue, "All Value of chech box doesn't match "
	End Sub
	
	'select the list item of a row with a particular value 
	Public Sub selectTblListItem(strSearchVal,selectVal,strColNo)
		reportController.reportStep m_reportingName & ".selectTblListItem(" & strSearchVal & ")"
		intNum = m_target.GetRowWithCellText(strSearchVal)
		Set oChild = m_target.ChildItem(intNum,strColNo,"WebList",0)
		oChild.Select selectVal
	End Sub
	
	'assert the list item of a row with a particular value 
	Public Sub assertTblListItem(strSearchVal,expVal,strColNo)
		reportController.reportStep m_reportingName & ".assertTblListItem(" & strSearchVal & ")"
		intNum = m_target.GetRowWithCellText(strSearchVal)
		Set oChild = m_target.ChildItem(intNum,strColNo,"WebList",0)
		strSelctItem = oChild.GetROProperty("selection")
		assertEquals expVal,strSelctItem, "List Value not matched with expected : " & expVal
	End Sub
	
	'To search data in whole table
	Public sub searchdata(strdata)
	reportController.reportStep m_reportingName & ".searchdata(" & strdata & ")"
			intNum = m_target.getrowwithcelltext(strdata)
		If intNum > 0 then
			Assertequals True, True,"Data found" & strdata
		Else
			Assertequals True, False,"data not found :" & strdata
		End if
	End sub
	
	
	Public Sub selectRow(searchValue)
		reportController.reportStep m_reportingName & ".selectRow(" & searchValue & ")"
		arg=Split(searchValue,";")
		row=m_target.GetROProperty("rows")
		
	
		intnum= m_target.GetRowWithCellText(arg(1)) 
		col=m_target.GetROProperty("cols")
				
					If intnum <> -1 Then
					
						For i=2 to row
						    For ik=1 to col
							Val=m_target.GetCellData(i,ik)
							Val1=m_target.GetCellData(i,ik+1)
						
								If Val=arg(0) and Val1=arg(1) Then
								assertEquals True,True, "Search Data found in the table : " & searchValue
								If arg(2)<>"" then
								For ij = 0 to 2
									Set oChild = m_target.ChildItem(i,6,"Link",ij)
									If 	oChild.GetROProperty("name") = Trim(arg(2)) then
										oChild.fireevent "onclick"
										Setting.WebPackage("ReplayType") = 1
										wait 1
                                    Exit For
									End If
								Next	
								End if
								Exit Sub
								End if
							Next
							If i=row then
							assertEquals True, False, "Search Data not found in the table : " & searchValue
							Exit Sub
							End if
						Next
					
					Else
					assertEquals True, False, "Search Data not found in the table : " & searchValue
			
					End If
			
End Sub
	
	'assert column data of a row with a particular value
	Public Sub assertTblValue(searchVal,Col,expVal)
		reportController.reportStep m_reportingName & ".assertTblValue(" & expVal & ")"
			'm_target.highlight
			intNum = m_target.GetRowWithCellText(Trim(searchVal))
		
			actVal = m_target.GetCellData(intNum,Col)
			
			expVal = Replace(Trim(expVal), ",", "")
			actVal = Replace(trim(actVal), ",","")
			
			If expVal = actVal Then
				assertEquals True,True, "Search Value Found : " & searchVal
			ElseIf instr(1,actVal,expVal,1) > 0 Then
				assertEquals True,True, "Search Value Found : " & searchVal
			Else
				assertEquals True,False,"Both Values should be equal"
			End If
			
	End Sub

	Public Function getTblLink(searchValue,linkcol)
		reportController.reportStep m_reportingName & ".getTblLink(" & searchValue & ")"
		intNum = m_target.GetRowWithCellText(Trim(searchValue))

        If intNum <> 0 Then
			Set oChild = m_target.ChildItem(intNum,linkcol,"Link",0)
			strLink = oChild.GetROProperty("outertext")
			getTblLink = strLink
		Else
			assertEquals True, False, "Search Data not found in the table : " & searchValue
		End If
		wait 15
	End Function

	'Click on Table Link of a row with a particular value
	Public Sub pressTblLink(searchValue,linkcol)
		reportController.reportStep m_reportingName & ".pressTblLink(" & searchValue & ")"
		intNum = m_target.GetRowWithCellText(Trim(searchValue))

        If intNum <> 0 Then
			Set oChild = m_target.ChildItem(intNum,linkcol,"Link",0)
			
			''oChild.Click
			Setting.WebPackage("ReplayType") = 2
			oChild.fireevent "onfocus"
			wait 1
			oChild.fireevent "onclick"
			Setting.WebPackage("ReplayType") = 1
		Else
			assertEquals True, False, "Search Data not found in the table : " & searchValue
		End If
		wait 3
	End Sub
	
		
	Public Sub pressLink(searchValue,linkname,linkcol)
		reportController.reportStep m_reportingName & ".pressTblLink(" & searchValue & ")"
		If instr(1,searchValue,";") > 0 Then
			arr=Split(searchValue,";")
			searchValue=arr(1)
		End If
	  
		intNum = m_target.GetRowWithCellText(Trim(searchValue))
		wait  2
		For ij = 0 to 2
		 Set oChild = m_target.ChildItem(intNum,linkcol,"Link",ij)
		 If oChild.GetROProperty("name") = linkname then
		  oChild.Click
		  Exit For
		 End If
		Next
	wait 15
	 End Sub

	Public Sub assertLink(searchValue,linkname,linkcol)
		
		reportController.reportStep m_reportingName & ".assertTblLink(" & searchValue & ")"
		If instr(1,searchValue,";") > 0 Then
			arr=Split(searchValue,";")
			searchValue=arr(1)
		End If
	   intNum = m_target.GetRowWithCellText(Trim(searchValue))

		For ij = 0 to 2
		 Set oChild = m_target.ChildItem(intNum,linkcol,"Link",ij)
		 If oChild.GetROProperty("name") = linkname then
		  assertEquals True,oChild.Exist(0), "table link doesnt exist"
		  Exit For
		 End If
		Next	
	 End Sub
	 
	'Get the value of specific cell of table
	Function getCellValue(searchValue,colNumber)
		reportController.reportStep m_reportingName & ". getCellValue (" & searchValue & ")"
		intNum = m_target.GetRowWithCellText(Trim(searchValue))
		
		If intNum > 0 Then
			getCellValue = m_target.getCellData(intNum,colNumber)
		Else
			assertEquals True, False, "Search Data not found in the table : " & searchValue
		End If
	End Function
	
	'Get the value from table column
	Public Function getValue()
		reportController.reportStep m_reportingName & ".getValue(" & strExpValue &")"
		assertEquals True, Trim(m_target.Exist), m_reportingName
		getValue =  Trim(m_target.GetROProperty("innertext"))
	End Function
	
	
	'Click on Table Link of a row with a particular value
	Public Sub assertTblLink(searchValue,linkcol)
		reportController.reportStep m_reportingName & ".assertTblLink(" & searchValue & ")"
		If linkcol > m_target.GetROProperty("cols") Then
			assertEquals True,False,"Column Number greater than total columns"
			Exit Sub
		End If
		intNum = m_target.GetRowWithCellText(Trim(searchValue))
        Set oChild = m_target.ChildItem(intNum,linkcol,"Link",0)
        assertEquals True,oChild.Exist(0), "table link doesnt exist"
	End Sub
	
	'Click on Table Image of a row with a particular value
	Public Sub pressTblIcon(searchValue,iconcol)
		reportController.reportStep m_reportingName & ".pressTblIcon(" & searchValue & ")"	
		'm_target.highlight
		intNum = m_target.GetRowWithCellText(Trim(searchValue))

			Select Case iconcol
				Case "M"
						Set oChild = m_target.ChildItem(intNum,2,"Image",0)
				Case "I"
						Set oChild = m_target.ChildItem(intNum,2,"Image",1)
				Case "A"
						Set oChild = m_target.ChildItem(intNum,2,"Image",2)
				Case Else
						Set oChild = m_target.ChildItem(intNum,iconcol,"Image",0)
			End Select
        oChild.Click
	End Sub
	
	Public Sub assertColumnExist(strColumnName,strStatus)
		reportController.reportStep m_reportingName & ".assertColumnExist(" & strColumnName & ")"

        strRowStart=0
		strRowCount  = m_target.GetROProperty("rows")
		If strRowCount  <= 0 Then
			assertEquals True,False,"No Row Found"
		End If

		strColCount  = m_target.GetROProperty("cols")

		blnFlag = False
		For ik = 1 to strColCount

			strData = m_target.GetCellData(strRowStart,ik)
			
			If trim(Replace((strColumnName)," ",""))= trim(Replace((strData)," ","")) Then
			
				blnFlag = True
				Exit For
			End If
			strData = m_target.GetCellData(strRowStart+1,ik)
			
			If trim(strData) = strColumnName Then
				blnFlag = True
				Exit For
			End If
			strData = m_target.GetCellData(strRowStart+2,ik)
			
			If trim(strData) = strColumnName Then
				blnFlag = True
				Exit For
			End If
			strData = m_target.GetCellData(strRowStart+3,ik)
			
			If trim(strData) = strColumnName Then
				blnFlag = True
				Exit For
			End If
	   Next

		If strStatus = True OR strStatus = "True" Then
			If blnFlag = False Then
				assertEquals True, False, "Column not Found : "& strColumnName
			Else
				assertEquals True, True, "Column Found : "& strColumnName
			End If
		Else
			If blnFlag = True Then
				assertEquals False, True, "Column Found : "& strColumnName
			Else
				assertEquals True, True, "Column not Found : "& strColumnName
			End If
		End If
	End Sub
	
	Public Sub assertPermissionAccess()
		reportController.reportStep m_reportingName & ".assertPermissionAccess()"
		strRowCount = m_target.GetROProperty("rows")
		
		If strRowCount > 1 Then
			For ik = 1 to strRowCount
				
				Set oChild = m_target.ChildItem(2,2,"WebList",0)
				
				actListValue = oChild.GetROProperty("all items")
				Exit For
			Next
		Else
			assertEquals True,False,"data not exist in the table : "& m_name
		End If
	
		expListValue =  "Not Displayed;Read Only;Read and Write" 
		DatabaseConfig.compare expListValue, actListValue
	End Sub
	
	
	'added for Column Customization
	Public Sub assertCustomizeColumnExist(strColumnName,strStatus)
		reportController.reportStep m_reportingName & ".assertCustomizeColumnExist(" & strColumnName & ")"
		
		Set Object= Description.Create()
		Object("micclass").value="WebElement"
		Object("html tag").value="DIV"
		
		Set Element_Object=m_target.ChildObjects(Object)
		blnFlag = False
		
		For j=0 to Element_Object.count - 1
			If instr(1,Replace(Element_Object(j).getroproperty("innertext")," ",""),Replace(strColumnName," ","") )> 0 then
			
				
				Select Case strStatus
					Case "True"
						If  Element_Object(j). Object.parentElement.currentStyle.display <> "none" Then
							blnFlag = True
						End if	 
				End Select
				
				If strStatus = True OR strStatus = "True" Then
					If blnFlag = False Then
						assertEquals True, False, "Column not Found : "& strColumnName
					Else
						assertEquals True, True, "Column Found : "& strColumnName
					End If
				Else
					If blnFlag = True Then
						assertEquals True, False, "Column Found : "& strColumnName
					Else
						assertEquals True, True, "Column Found : "& strColumnName
					End If
				End If
			End if                    
		Next
		
	End Sub			  
	
	Public Function getFileNameForImage(rowNumber, colNumber )
		reportController.reportStep m_reportingName & ".GetFileNameforImage(" & rowNumber & " , " & colNumber & " )"
		Set image1 = m_target.ChildItem(rowNumber,colNumber,"Image",0) 
		filename = image1.GetROProperty("filename")
		getFileNameForImage = filename   
	End Function
	
	Public Function getrCount()
		reportController.reportStep m_reportingName & ".getrCount()" 
		getrCount = m_target.GetROProperty("rows")
	End Function
	
	
	Function assertAuditLogRecord(strUser,strUserAction,strItemtype)
		reportController.reportStep m_reportingName & ".assertAuditLogRecord()" 
				
		strRowCount = m_target.GetROProperty("rows")
		strColCount = m_target.GetROProperty("cols")
		
		blnFlag = False
		For ik = 1 to 4
		
			For ij = 1 to strColCount
		
				strData = m_target.GetCellData(ik,ij)
				If strData = strUser Then
					If strUserAction = m_target.GetCellData(ik,ij+1) Then
						If strItemType <> "" Then
							If strItemType = m_target.GetCellData(ik,ij+2) Then
								blnFlag = True
								Exit For
							End If
						Else
							blnFlag = True
							Exit For
						End If
					End If
				End If
			Next
		
			If blnFlag = True Then
				Exit For
			End If
		
		Next

		If blnFlag = False Then
			assertEquals True, False, "Record not found for User : " & strUser & " and User Action :"& strUserAction
		Else
			assertEquals True, True, "Record found for User : " & strUser & " and User Action :"& strUserAction
		End If
	
	End Function
	
	Public Sub pressColumnCustomization()
		reportController.reportStep m_reportingName & ".pressColumnCustomization(" & searchValue & ")"	
		'm_target.highlight
		intNum = 1 'm_target.GetRowWithCellText(Trim(searchValue))
		intCol = m_target.GetROProperty("cols")
		
		Set oChild = m_target.ChildItem(intNum,intCol,"WebElement",0)
		oChild.Click
		Set oChild = m_target.ChildItem(intNum,intCol,"WebElement",1)		
		oChild.Click
	End Sub
	

	''
	'Gets the Column Count
	'
	Public Function getcCount()
		reportController.reportStep m_reportingName & ".getcCount()" 
		getcCount = m_target.GetROProperty("cols")
	End Function
	
	'Get all rows data for Controls in Grid
	Public Function GetAllRowdata(tableName)
		reportController.reportStep m_reportingName & ".GetAllRowdata()"
		colCount = m_target.GetROProperty("cols")
		RowCount = m_target.GetROProperty("rows")
		
		Select Case formName
			Case "Reports"
					strStartRow = 2
					strStartCol = 1
			Case Else
					strStartRow = 2
					strStartCol = 1
		End Select
		For i =strStartRow to RowCount
			
			Select Case tableName
				
				Case "DataSet"
					For j = strStartCol to colCount-2
						str = m_target.GetCellData(i,j)
						If instr(1,str,",") > 0 Then
						str = Replace(str,",","COMMAAA")
						End If
						'info "DGrid ata : i: "& i & ", j: " & j & ", data: " & str
						str1 = str1&";"&str
						str = ""
						strData =  mid(str1,"2")
					Next
				str1 =""
				strData1 = strData1 & "," & strData
				strData = ""
				strData2 =  mid(strData1,"2")
			
			Case Else
				For j = strStartCol to colCount 
					str = m_target.GetCellData(i,j)
					If instr(1,str,",") > 0 Then
					str = Replace(str,",","COMMAAA")
					End If
					'info "DGrid ata : i: "& i & ", j: " & j & ", data: " & str
					str1 = str1&";"&str
					str = ""
					strData =  mid(str1,"2")
				Next
				str1 =""
				strData1 = strData1 & "," & strData
				strData = ""
				strData2 =  mid(strData1,"2")
			End Select
		Next

		GetAllRowdata = strData2

	End Function
	
	
	
	Public Function GetAllTabledata(tableName)
		reportController.reportStep m_reportingName & ".GetAllTabledata()"

		colCount = m_target.GetROProperty("cols")
		RowCount = m_target.GetROProperty("rows")
         
		Select Case tableName			
			Case "ScheduledReports"
				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
			Case reportProgramSummaryDataSet

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
				
			Case reportRegionSummaryPreferred

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
				
			Case reportRegionSummaryDetailed

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
			Case reportVODAdDeliveryDataFeed

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount 
				
			Case reportCampaignSummaryPreferred

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
				
			Case reportCampaignSummaryDetailed

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
				
			Case reportRawDataPreferred

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
				
			Case reportRawDataDetailed

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
				
			Case reportProgramSummaryPreferred

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
				
			Case reportProgramSummaryDetailed

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
				
			Case reportAdvertisementSummaryPreferred

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
				
			Case reportAdvertisementSummaryDetailed

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
				
			Case reportAllDetailsDetailed

				iRow = 2
				iCol = 1
				colCount = colCount-1
				RowCount = RowCount
				
			Case reportAdvertisementandProgramDetailsDetailed

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
				
			Case reportUniqueCustomersDetailed

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
				
			Case reportEndOfCampaignPreferred

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
				
			Case reportEndOfCampaignDetailed

				iRow = 2
				iCol = 1
				colCount = colCount
				RowCount = RowCount
			
		End Select
		
		
		For i = iRow to RowCount			
			For j = iCol to colCount 
				blnFlag = False	
					If blnFlag = False Then
						str = m_target.GetCellData(i,j)
						if instr(1,str,",") > 0 Then
							str = Replace(str,",","COMAAA")
						End If
						print "Grid Data : i: "& i & ", j: " & j & ", data: " & str
						str1 = str1&";"&str
						str = ""
						strData =  mid(str1,"2")
					End If
			Next
			str1 =""
			Select Case tableName
				Case reportCampaignSummaryDetailed,reportEndOfCampaignDetailed,reportAdvertisementSummaryDetailed,reportAdvertisementandProgramDetailsDetailed,reportRegionSummaryDetailed
						strData=Left(strData,len(strData)-2)
				Case Else
						strData=strData
			End Select
			strData1 = strData1 & "," & strData
			strData = ""
			strData2 =  mid(strData1,"2")
		Next
		
		GetAllTabledata = strData2
        
		info strData2
	End Function

	
	'Validate Table Grid value from data base.
	Public Sub assertTableData(tableName, argString)
		reportController.reportStep m_reportingName & ".assertTableData(" & tableName & ")"
		
		sql1 = ""
		sql2 = ""
		
		If argString <> "" Then
			arrArg = Split(argString,";")
		End If
		
		connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
		
		Select Case tableName
			Case reportEndOfCampaignPreferred
				
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
						
			Case reportEndOfCampaignDetailed
				
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
						
			Case reportAdvertisementSummaryPreferred
				
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
			Case reportAdvertisementSummaryDetailed
				
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
						
			Case reportAllDetailsDetailed
				
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
						
			Case reportAdvertisementandProgramDetailsDetailed
				
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
						
			Case reportUniqueCustomersDetailed
				
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
		
			
						
			Case reportProgramSummaryPreferred
				
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
			Case reportRegionSummaryPreferred
				
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
			Case reportRegionSummaryDetailed
				
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
						
			Case reportProgramSummaryDetailed
				
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
						
				
			Case reportVODAdDeliveryDataFeed
				
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
						
			Case reportCampaignSummaryPreferred
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
						
			Case reportCampaignSummaryDetailed
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
						
			Case reportRawDataPreferred
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
						
			Case reportRawDataDetailed
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub
 
			Case "DataSet"
				connectionString= "IVM_SYS_DATABASE_CONNECTION_STRING"
					argString=replace(argString," ","")
					sql1="Select datasetName,creationTime,user from sys_dataset where datasetName like '%"&argString&"%' order by DatasetName DESC"
					sql2="Select count(*) from sys_dataset where datasetName like '%"&argString&"%'"
					
			Case "ScheduledReports"
				connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
						verifyReportableData tableName,argString,sql2,connectionString
						Exit sub				
			Case grdUsers
				connectionString = "IVM_MMC_PRODUCTION_DATABASE_CONNECTION_STRING"
				sql1 = "Select  case status when 1 then 'Enabled' when 0 then 'Disabled' end , user_name, role, DATE_FORMAT(last_session,'%M/%d/%Y') as last_session,DATE_FORMAT(updated_at,'%M/%d/%Y') as updated_at from users order by user_name"
				sql2 = "Select  count(*) from users order by user_name"
				
			Case grdRoles
				connectionString = Environment.value("IVM_PRODUCTION_DATABASE_CONNECTION_STRING")
				sql1 = "Select name,description,location_name,DATE_FORMAT(updated_at,'%d-%m-%Y') as updated_at from roles order by name;"
				sql2 = "Select  count(*) from roles order by name"
						
			Case grdAuditLogs
			    connectionString = "IVM_PRODUCTION_DATABASE_CONNECTION_STRING"
				sql1 = "select date_format(created_at, '%b %c, %Y %h:%i:%s %p') as created_at, user_name,CONCAT(UCASE(MID(event,1,1)),MID(event,2)) AS event,item_type,item_name from audit_log order by created_at desc"
				sql2 = "select count(*) from audit_log"
				
				
			Case grdAllReport
			
				sql1="SELECT R.name,R.description FROM reports R;"
				sql2= "select count(*) from reports R;"
				
			Case Else 
				info m_reportingName & ".assertGridData(), " &  tableName & " grid name not found"
				assertequals True,False,tableName &" not found, argument passed in the script is invalid"
				Exit Sub
		End Select
		
		If sql1 <> "" and sql2 <> "" then
			verifytableData tableName,sql1,sql2,connectionString
			
		End If
	End Sub
	
	
	Private Sub verifytableData(tableName,sql1,sql2,connectionString)
		reportController.reportStep m_reportingName & ".verifytableData(" & tableName & ")"
		info "Sql1 --> " & sql1
		info "Sql2 --> " & sql2
		'connectionString = "DATABASE_CONNECTION_STRING"
		Dim tempr1
		rows=getrCount
		info "rows : "& rows
		cols=getcCount
		info "cols : "& cols
		rcount = DatabaseConfig.getRecordCount(sql2,connectionString)
		info "rcount : "& rcount
		
		
		intNum = m_target.GetRowWithCellText(Trim("No Records Found"))
		intNum1 = m_target.GetRowWithCellText(Trim("met the report filter criteria"))
		intNum2 = m_target.GetRowWithCellText(Trim(NO_RECORD_FOUND))
		intNum3 = m_target.GetRowWithCellText(Trim(NO_RECORD_FOUNDS))
		intNum4 = m_target.GetRowWithCellText(Trim(NO_RECORDS_FOUND))
		intNum5 = m_target.GetRowWithCellText(Trim(EMPTY_SERACH_DATA))
		intNum6 = m_target.GetRowWithCellText(Trim(NO_RECORDS_FOUND_VUT))
		intNum7 = m_target.GetRowWithCellText(Trim(NoRcordFound_IFV_AffectedSpot))
		
		
		intNum = intNum + intNum1 + intNum2 + intNum3 + intNum4 + intNum5 + intNum6 + intNum7
		If Cint(rcount) = 0 then
			Info "No record fetched from the database"
			If intNum > 0 Then
				assertEquals True, False, "Record not available in DB but exists on UI"
			Else
				assertEquals True, True, "Record not available in DB and UI"
			End If
			Exit Sub
		End If
		
		database.openConnection connectionString
		
		info "connection Open"
		info "table Data Query -->" & sql1
		'Executing Query
		Set recordSet = database.executeQuery(sql1)
		'Check If Record set is blank	  
		If recordSet.EOF Then
			info "No record fetched from the database. Check the query"
			Exit Sub
		End If

		Set Fields_Collection=recordSet.Fields
		info Fields_Collection.Count
		r=1	
		cl=1
		
		Select Case tableName
				Case reportTrafficAndBillingMarkets,reportTrafficAndBillingZone,reportTrafficAndBillingChannel,reportAlertSummary,reportDeviceInventory,reportVideoCopySummary,reportProblematicSchedules,reportProblematicScheduleSummary,reportProblematicVerifications,reportProblematicVerificationSummary,reportVideoUsageTrends,reportVideoUsageTrendsInterconnects,reportVideoUsageTrendsRegions,reportVideoUsageTrendsMarkets,reportVideoUsageTrendsZones,reportVideoUsageTrendsNetworks,reportAlertTypeTrendsReportSummary,reportAlertTypeTrends,reportIncorrectLengthVideosAffectedSpots,reportIncorrectLengthVideos,reportIngestFailures,reportIngestAndMissingVideoReportMissing,reportIngestAndMissingVideoReportIngest,EventsView,EventsViewDetail,reportIncorrectlyFormattedVideosAffectedSpots,IncorrectlyFormattedVideos,IncorrectlyFormattedVideosSummary,VideoView,VideoViewScheduleInserter,VideoViewCurrentLocation,VerificationFiles,ScheduleFiles

					strAlldata = GetAllTabledata (tableName)
					arrAllRowData = Split(strAlldata,",")
				Case Else
					strAlldata = GetAllRowdata (tableName)
					arrAllRowData = Split(strAlldata,",")
		End Select
	
		Do While Not recordSet.EOF
		
			'For checking first 20 rows only
			If r=Num_Rows_to_execute Then
				RowFlag=True
				Exit Do
			End If

			Select Case tableName
				
				Case Else
					strGridRowData = arrAllRowData(r-1)
			End Select
						
			arrGridRowData = Split(strGridRowData,";")
			If instr(1,strGridRowData,";") > 0 Then
			    
    			  intGridRowDataCount = Ubound(arrGridRowData) + 1
				
			Else
				intGridRowDataCount =  1
			End If

			'If intGridRowDataCount <> Fields_Collection.Count Then
			'	assertEquals Ubound(arrGridRowData),Fields_Collection.Count, "Fields do not match "
			'	Exit Sub
			'End If
'r = 3
			cl=1
			For i=0 to Fields_Collection.Count-1
				
				info "Row number is "& r
				info "Column number is " & (i + 1)
				
				info "Field Name from DB: "& Fields_Collection(i).Name
				
				dbVal = recordSet.Fields(Fields_Collection(i).Name)
				
				'Checking for null values in the database
				If IsNull(dbVal) Then
					dbVal="Null"
				End If

				Select Case dbVal
					Case "Null"
						dbVal = ""
				End Select 
				
				'GUI value
				guiVal = Trim(arrGridRowData(i))

				If instr(1,guiVal ,"COMMAAA") > 0 Then
					guiVal = Replace(guiVal,"COMMAAA",",")
				End If
				
				Select Case guiVal
					Case "N/A"
						guiVal = ""
				End Select 

				If m_name = "AuditLog" or m_name = "AuditLogs" Then
					dbVal = guiVal
				End If
				
				info "Value from database: "& dbVal
				info "Value from GUI: "& guiVal
				
				If Trim(dbVal) <> Trim(guiVal) Then
					assertEquals guiVal,dbVal, "Records do not match for row "& r &" and column "&(Fields_Collection(i).Name)
					'Commented so that all the rows are checked rather than exiting at the first mismatch
					skipCol="True"
					'Exit For
				Else
					assertEquals True,True, "Records match for row "& r &" and column "&(Fields_Collection(i).Name)
				End If
				cl=cl+1
			Next
		
			'Commented so that all the rows are checked rather than exiting at the first mismatch
			'If skipCol="True" Then
			'	Exit Do
			'End If
	
			recordset.MoveNext
			r=r+1
			If r<Ubound(arrAllRowData) + 1 Then
			else
			Exit do
			End If
		Loop
		
		database.closeConnection
		
		'For checking first 20 rows only
		If RowFlag Then
			If r=Num_Rows_to_execute Then
				assertEquals Num_Rows_to_execute,r," First"&Num_Rows_to_execute& " rows are matching"
			End If
		Else
			If r=rows+1 Then
				assertEquals r,rows+1," All Rows are matching"
			End If
		End If
	End Sub  
	
	Private Sub verifyReportableData(tableName,argString,sql2,connectionString)
		
		reportController.reportStep m_reportingName & ".verifytableData(" & tableName & ")"
		'info "Sql1 --> " & sql1
		'info "Sql2 --> " & sql2
		'connectionString = "DATABASE_CONNECTION_STRING"
		'Dim tempr1
		'rows=getrCount
		'info "rows : "& rows
		'cols=getcCount
		'info "cols : "& cols
		'rcount = DatabaseConfig.getRecordCount(sql2,connectionString)
		'info "rcount : "& rcount
		
		
'		If Cint(rcount) <> Cint(rows) Then
'			assertEquals Cint(rcount),Cint(rows),"No. of records do not match"
'			Exit Sub
'		Else
'			If Cint(rcount) = 0 then
'				Info "No record fetched from the database"
'				Exit Sub
'			End If
'		End If
		'End Select
	
		'database.openConnection connectionString

		'info "connection Open"
		'info "table Data Query -->" & sql1
		'Executing Query
		'Set recordSet = database.executeQuery(sql1)
		'Check If Record set is blank	  
		'If recordSet.EOF Then
		'	info "No record fetched from the database. Check the query"
		'	Exit Sub
		'End If

		'Set Fields_Collection=recordSet.Fields
		'info Fields_Collection.Count
		'r=1	
		'cl=1
		
		Select Case tableName
				
				Case "ScheduledReports"
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getScheduledReportsData("ScheduledReports",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
				
				Case reportEndOfCampaignPreferred
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportEndOfCampaignData("PreferredData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
				
				Case reportEndOfCampaignDetailed
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportEndOfCampaignData("DetailedData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
					
				Case reportAdvertisementSummaryPreferred
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportAdvertisementSummaryData("PreferredData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
					
				Case reportAllDetailsDetailed
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportAllDetailsData("DetailedData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
					
				Case reportAdvertisementandProgramDetailsDetailed
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportAdvertisementandProgramDetailsData("DetailedData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
					
				Case reportUniqueCustomersDetailed
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportUniqueCustomersData("DetailedData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
					
				Case reportAdvertisementSummaryDetailed
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportAdvertisementSummaryData("DetailedData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
					
				Case reportProgramSummaryPreferred
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportProgramSummaryData("PreferredData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
				Case reportRegionSummaryPreferred
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportRegionSummaryData("PreferredData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
				Case reportRegionSummaryDetailed
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportRegionSummaryData("DetailedData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
					
				Case reportProgramSummaryDetailed
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportProgramSummaryData("DetailedData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
					
			Case reportVODAdDeliveryDataFeed
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportVODAdDeliveryDataFeedData("PreferredData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData

				Case reportCampaignSummaryPreferred
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportCampaignSummaryData("PreferredData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
					
				Case reportCampaignSummaryDetailed
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportCampaignSummaryData("DetailedData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
					
				Case reportRawDataDetailed
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportRawDataData("DetailedData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
					
				Case reportRawDataPreferred
					strAlldata = GetAllTabledata(tableName)
					arrAllRowData = Split(strAlldata,",")
					info "From UI---->>>" & strAlldata
                    strWSData = getreportRawDataData("PreferredData",argString)
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData
					
				Case ScheduleFiles
					strAlldata = GetAllTabledata(tableName)
                    arrAllRowData = Split(strAlldata,",")
                    strWSData = getScheduleFiles("ScheduleFiles")
                    arrWSData = Split(strWSData,";")
					Info strAlldata
					info strWSData						
				Case Else
					'strAlldata = GetAllRowdata
					'arrAllRowData = Split(strAlldata,",")
				
		End Select
		
		For ip = 0 to Ubound(ArrAllRowData)
			strGridRowData = arrAllRowData(ip)
			strWSData = arrWSData(ip)
			
			arrGridRowData = Split(strGridRowData,";")
			arrWSData1 = Split(strWSData,",")
			
			for ik = 1 to Ubound(arrGridRowData) + 1
				guiVal = Trim(arrGridRowData(ik-1))
				WSVal = arrWSData1(ik-1)
				
				if instr(1,guiVal,"COMAAA") > 0 Then
					guiVal = Replace(guiVal,"COMAAA",",")
				End If
				if instr(1,WSVal,"COMAAA") > 0 Then
					WSVal = Replace(WSVal,"COMAAA",",")
				End If
				if guiVal ="Null" Then
					guiVal = ""
				End If
				if WSVal ="Null" Then
					WSVal = ""
				End If
				Select Case tableName
					case reportAlertSummary
						If ik = 1 Then
							WSVal = MonthName(month(WSVal)) & " " & day(WSVal)  & "," & " " & Year(WSVal)	
						End If
					Case reportProblematicSchedulesummary,reportProblematicVerificationsummary
					
						If ik = 1 Then
							If instr ( 1,WSVal,"Z") > 0  then
								WSVal = Replace(WSVal,"T"," ")
								WSVal = left(WSVal,len(WSVal)-5)
								WSVal = ConvertDate(cdate(WSVal),"MONTH DATE, YR")
							End If
						End If
						Case reportProblematicSchedules,reportProblematicVerifications
						If  ik = 7 Then
							If instr ( 1,WSVal,"Z") > 0  then
								WSVal = Replace(WSVal,"T"," ")
								WSVal = left(WSVal,len(WSVal)-5)
								WSVal = ConvertDate(cdate(WSVal),"MONTH DATE, YR")
							End If
						End If
					Case reportIncorrectLengthVideos
						If  ik = 3 or ik = 10 Then
							If instr ( 1,WSVal,"Z") > 0  then
								WSVal = Replace(WSVal,"T"," ")
								WSVal = left(WSVal,len(WSVal)-5)
								WSVal = ConvertDate(cdate(WSVal),"MONTH DATE, YR")
							End If
						End If	
					Case reportIncorrectLengthVideosAffectedSpots
						Select Case ik
							Case 6
								If instr ( 1,WSVal,"Z") > 0  then
									WSVal = Replace(WSVal,"T"," ")
									WSVal = left(WSVal,len(WSVal)-5)
									WSVal = ConvertTimeZone (WSVal,"EST")
									WSVal = ConvertDate(cDate(WSVal),"MONTH DATE, YR HR:MIN:SEC AM EST 24")
								End If
							Case 7
								If instr ( 1,WSVal,"Z") > 0  then
									WSVal = Replace(WSVal,"T"," ")
									WSVal = left(WSVal,len(WSVal)-5)
									WSVal = ConvertTimeZone (WSVal,"EST")
									WSVal = ConvertDate(cDate(WSVal),"MONTH DATE, YR HR:MIN:SEC AM EST 24")
								End If
						End Select
					Case reportIngestAndMissingVideoReportMissing
						If  ik = 2 or ik = 3 Then
							If instr ( 1,WSVal,"Z") > 0  then
								WSVal = Replace(WSVal,"T"," ")
								WSVal = left(WSVal,len(WSVal)-5)
								WSVal = ConvertTimeZone (WSVal,"EST")
								WSVal = ConvertDate(cDate(WSVal),"MONTH DATE, YR HR:MIN:SEC AM EST 24")
							End If
						End If
					Case reportIngestAndMissingVideoReportIngest
						If  ik = 2 Then
							If instr ( 1,WSVal,"Z") > 0  then
								WSVal = Replace(WSVal,"T"," ")
								WSVal = left(WSVal,len(WSVal)-5)
								WSVal = ConvertDate(cdate(WSVal),"MONTH DATE, YR")
							End If
						End If
					Case reportIncorrectLengthVideosAffectedSpots
						If  ik = 6 or ik = 7 Then
							If instr ( 1,WSVal,"Z") > 0  then
								WSVal = Replace(WSVal,"T"," ")
								WSVal = left(WSVal,len(WSVal)-5)
								WSVal = ConvertTimeZone (WSVal,"EST")
								WSVal = ConvertDate(cDate(WSVal),"MONTH DATE, YR HR:MIN:SEC AM EST 24")
							End If
						End If	
					Case reportIncorrectLengthVideos
						If  ik = 4 or ik = 10 Then
							If instr ( 1,WSVal,"Z") > 0  then
								WSVal = Replace(WSVal,"T"," ")
								WSVal = left(WSVal,len(WSVal)-5)
								WSVal = ConvertTimeZone (WSVal,"EST")
								WSVal = ConvertDate(cDate(WSVal),"MONTH DATE, YR HR:MIN:SEC AM EST 24")
							End If
						End If	
					Case reportIngestFailures
						If  ik = 3 Then
							If instr ( 1,WSVal,"Z") > 0  then
								WSVal = Replace(WSVal,"T"," ")
								WSVal = left(WSVal,len(WSVal)-5)
								WSVal = ConvertTimeZone (WSVal,"EST")
								WSVal = ConvertDate(cDate(WSVal),"MONTH DATE, YR HR:MIN:SEC AM EST 24")
							End If
						End If	
					Case EventsView
					
						If  ik = 2 or ik = 16  or ik =18 or ik = 8 Then
                            If instr ( 1,WSVal,"Z") > 0  then
								WSVal = Replace(WSVal,"T"," ")
								WSVal = left(WSVal,len(WSVal)-5)
								''WSVal = Replace(WSVal,".000Z","")
								WSVal = ConvertTimeZone (WSVal,"EST")
								WSVal = ConvertDate(cDate(WSVal),"MONTH DATE, YR HR:MIN:SEC AM EST 24")
							End If
							
						End If
						Case ScheduleFiles,VerificationFiles
								Select Case ik
									Case 5
										If instr ( 1,WSVal,"Z") > 0  then
											WSVal = Replace(WSVal,"T"," ")
											WSVal = left(WSVal,len(WSVal)-5)
											WSVal = ConvertDate(cdate(WSVal),"MONTH DATE, YR")
										End If
									Case 6
										If instr ( 1,WSVal,"Z") > 0  then
											WSVal = Replace(WSVal,"T"," ")
											WSVal = left(WSVal,len(WSVal)-5)
											''WSVal = Replace(WSVal,".000Z","")
											WSVal = ConvertTimeZone (WSVal,"EST")
											WSVal = ConvertDate(cDate(WSVal),"MONTH DATE, YR HR:MIN:SEC AM EST 24")
										End If
									End Select
					Case VideoViewScheduleInserter
						If  ik = 4 Then
							If instr ( 1,WSVal,"Z") > 0  then
								WSVal = Replace(WSVal,"T"," ")
								WSVal = left(WSVal,len(WSVal)-5)
								WSVal = ConvertTimeZone (WSVal,"EST")
								WSVal = ConvertDate(cDate(WSVal),"MONTH DATE, YR HR:MIN:SEC AM EST 24")
							End If
						End If
					Case VideoViewCurrentLocation
						If  ik = 7 or ik = 8 Then
							If instr ( 1,WSVal,"Z") > 0  then
								WSVal = Replace(WSVal,"T"," ")
								WSVal = left(WSVal,len(WSVal)-5)
								WSVal = ConvertTimeZone (WSVal,"EST")
								WSVal = ConvertDate(cDate(WSVal),"MONTH DATE, YR HR:MIN:SEC AM EST 24")
							End If
						End If
				End Select
				
				print "Value from database: "& guiVal
				print "Value from WS: "& WSVal

				If Trim(WSVal) <> Trim(guiVal) Then
					assertEquals WSVal,guiVal, "Records do not match for row "& ip &" and column "&ik
					'Commented so that all the rows are checked rather than exiting at the first mismatch
					skipCol="True"
					Exit For
				End If
				
			Next 
			If skipCol="True" Then
				Exit FOR
			End If
		Next
	
		REM If RowFlag Then
			REM If ip-1=Num_Rows_to_execute Then
				REM assertEquals Num_Rows_to_execute,ip-1," First"&Num_Rows_to_execute& " rows are matching"
			REM End If
		REM Else
			REM If r=rows+1 Then
				REM assertEquals r,rows+1," All Rows are matching"
			REM End If
		REM End If
		
		REM Do While Not recordSet.EOF
		
			REM 'For checking first 20 rows only
			REM If r=Num_Rows_to_execute Then
				REM RowFlag=True
				REM Exit Do
			REM End If

			REM Select Case tableName
				
				REM Case Else
					REM strGridRowData = arrAllRowData(r-1)
			REM End Select
						
			REM arrGridRowData = Split(strGridRowData,";")
			REM If instr(1,strGridRowData,";") > 0 Then
			    
    			  REM intGridRowDataCount = Ubound(arrGridRowData) + 1
				
			REM Else
				REM intGridRowDataCount =  1
			REM End If

			REM If intGridRowDataCount <> Fields_Collection.Count Then
				REM assertEquals Ubound(arrGridRowData),Fields_Collection.Count, "Fields do not match "
				REM Exit Sub
			REM End If
			REM r = 3
			REM cl=1
			REM For i=0 to Fields_Collection.Count-1
				
				REM info "Row number is "& r
				REM info "Column number is " & (i + 1)
				
				REM info "Field Name from DB: "& Fields_Collection(i).Name
				
				REM guiVal = Trim(arrGridRowData(i+1))
				REM dbVal = recordSet.Fields(Fields_Collection(i).Name)
				
			    
				REM 'Checking for null values in the database
				REM If IsNull(dbVal) Then
					REM dbVal="Null"
				REM End If

				REM If dbVal="Null" Then
					REM dbVal = ""
					REM 'assertEquals True,False,"The value in the database does not have a corresponding combo box option"
				REM End If
				
			
				REM info "Value from database: "& dbVal
				REM info "Value from GUI: "& guiVal

				REM If Trim(dbVal) <> Trim(guiVal) Then
					REM assertEquals guiVal,dbVal, "Records do not match for row "& r &" and column "&(Fields_Collection(i).Name)
					REM 'Commented so that all the rows are checked rather than exiting at the first mismatch
					REM skipCol="True"
					REM Exit For
				REM End If
				REM cl=cl+1
			REM Next
		
			REM 'Commented so that all the rows are checked rather than exiting at the first mismatch
			REM If skipCol="True" Then
				REM Exit Do
			REM End If
	
			REM recordset.MoveNext
			REM r=r+1
		REM Loop
		
		REM database.closeConnection
		
		'For checking first 20 rows only
		REM If RowFlag Then
			REM If r-1=Num_Rows_to_execute Then
				REM assertEquals Num_Rows_to_execute,r-1," First"&Num_Rows_to_execute& " rows are matching"
			REM End If
		REM Else
			REM If r=rows+1 Then
				REM assertEquals r,rows+1," All Rows are matching"
			REM End If
		REM End If
	End Sub 
	
	Sub validateDatainXMLData(strAlldata,strWSData)
		
		info strAlldata
		info strWSData
		
		strAlldata = Replace(strAlldata," ","")
		reportController.reportStep m_reportingName & ".validateDatainXMLData()"
		arrAllRowData = Split(strAlldata,",")
		arrWSData = Split(strWSData,";")
		For ik = 0 to Ubound(arrAllRowData)-1
			strData = arrWSData(ik)
			blnFlag = False
			For ij = 0 to Ubound(arrAllRowData)
			arrAllRowData(ij)=Replace(arrAllRowData(ij),";",",")
		
		
				if strData = arrAllRowData(ij) Then
					blnFlag = True
					
					Exit For
				Else
					blnFlag = False
				End If
				
			Next
			If blnFlag = False  Then
				assertEquals True, False, "value : " & strData & ", not present on UI"
			Else
				assertEquals True, True, "value : " & strData & ", present on UI"
			End If
		Next
	End Sub
	
	Public Sub norecord(reportname)
		reportController.reportStep m_reportingName & ".norecord(" & reportname & ")"
		
		Select Case reportname
				Case reportProblematicVerifications
					str = "No verification files met the report filter criteria."
					assertvalue str,1
				Case reportVideoUsageTrends
					str = "No videos scheduled met the report filter criteria."
					assertvalue str,1
				Case reportIncorrectLengthVideos
					str = "No videos met the report filter criteria."
					assertvalue str,1
				Case reportIncorrectlyFormattedVideos
					str = "No videos met the report filter criteria."
					assertvalue str,1
				Case reportIngestFailures
					str = "No videos met the report filter criteria."
					assertvalue str,1
				Case reportIngestedAndMissingVideos
					str = "No videos met the report filter criteria."
					assertvalue str,1
				Case reportProblematicSchedules
					str = "No schedules met the report filter criteria."
					assertvalue str,1
		End Select
		
	End Sub
	
End class

'############# WEBEDIT PROXY ######################################
'Represents a WebEdit. Examples: Type , exists, status etc.
'############# WEBEDIT PROXY ######################################

Class WebEditProxy
	Private m_target, m_name, m_reportingName
	''For internal API use only
	
	Public Sub internal_assign(parentTarget, parentReportingName, name)
		m_reportingName = parentReportingName & ".webEdit(" & name & ")"
		reportController.reportStep m_reportingName & ".internal_assign()"
		m_name = name
		Set m_target = parentTarget.webEdit("txt" & m_name)
	End Sub

	' Returns current text input value.
	' @return  string - text input value
	Public Function getValue
		reportController.reportStep m_reportingName & ".getValue()" 
		'waitForSync m_target
		getValue = Replace(m_target.GetROProperty("value")," ","")
	End Function
	Public Function getText
		reportController.reportStep m_reportingName & ".getText()" 
		'waitForSync m_target
		getText = Replace(m_target.GetROProperty("value")," ","")
	End Function
 
    
	' Clears text input value.
	Public Sub clearValue
		reportController.reportStep m_reportingName & ".clearValue"
		'waitForSync m_target
		m_target.Set ""
	End Sub

	' Sets text input value.
	' @param value  string - new value
    Public Sub setValue(value)
		reportController.reportStep m_reportingName & ".setValue(" & value & ")"
		'Added because the Password field was not accepting blank value
		'waitForSync m_target
		If value = ""  Then
			m_target.Set value
			m_target.FireEvent "onkeyup"
			Exit Sub
		End If
		
		'Clear the value
		m_target.Set ""
		'Set the value 	
		m_target.Set value
		m_target.FireEvent "onkeyup"
	End Sub

	' Asserts text value.
	' @param expected  string - expected text
	Public Sub assertValue(expected)
		reportController.reportStep m_reportingName & ".assertValue(" & expected & ")"
		strText = getValue()
		If strText =  "All" Then
				assertEquals  "All", strText, m_reportingName  & "(" & expected & ")"
		Else
			assertEquals  Replace(expected," ",""), strText, m_reportingName  & "(" & expected & ")"
		End If
	End Sub
	Public Sub assertTextValue(expected)
	    reportController.reportStep m_reportingName & ".assertTextValue(" & expected & ")"
		assertEquals  expected, getText, m_reportingName  & "(" & expected & ")"
	End Sub	
	
	' Asserts text value.
	' @param expected  string - expected text
	Public Sub assertError(expected)
		reportController.reportStep m_reportingName & ".assertError(" & expected & ")"
		
		assertErrorExist "True"
		assertEquals  Trim(expected), Trim(m_target.GetROProperty("errorstring")), m_reportingName  & "(" & expected & ")"
	End Sub
	
	
		Public Sub press
		reportController.reportStep m_reportingName & ".press()"
		
		If m_target.Exist(5) Then
				m_target.Click
		Else
			failTest m_reportingName & ".press()" & " Edit Box not found " & m_name 
		End If
		wait 5
	End Sub
	
	
	
	'Assert existance off the Object
	'@param - state of the object'
	Public Sub assertExist(state)
		reportController.reportStep m_reportingName & ".assertExist(" & state & ")"
'		'waitForSync m_target
		assertEquals Trim(state), Trim(m_target.Exist(5)), m_reportingName
	End Sub
	
	'Asserts field value from multi line output value
	
    Public Sub assertMultiLineValue(fieldname,fieldval)
	   reportController.reportStep m_reportingName & ".assertMultiLineValue(" & fieldname &  "," & fieldval &")"

       fieldval = LCase(fieldval)
	   fieldlength = Len(fieldval)
	 
       stringval = m_target.GetROProperty("value")
    
       fieldpos =  Instr(stringval,fieldname)
       equaltopos =   Instr(fieldpos,stringval,"=")
       newlinepos = Instr(equaltopos,stringval,Chr(10))

       lengthofval = newlinepos - equaltopos

       actfieldval = Mid(stringval,equaltopos+1,lengthofval-2)

       If Instr(1,actfieldval,fieldval) > 0 Then
         actvalpos =  Instr(1,actfieldval,fieldval)
         exactval =  Mid(actfieldval,actvalpos,fieldlength+1)
         assertEquals Trim(exactval), Trim(fieldval), m_reportingName
       Else
         assertEquals True, False, m_reportingName
       End If

    End Sub
		'Asserts Text Input Box Status like Editable,Non-Editable,Visible, Not visible
	'@param value  string - Expected state
    Public Sub assertStatus(expectedStatus)
		reportController.reportStep m_reportingName & ".assertStatus(" & expectedStatus & ")"
		Select Case expectedStatus
			Case "disabled"
				assertEquals True, m_target.GetROProperty("disabled"), m_reportingName
			Case "enabled"
				assertEquals False, m_target.GetROProperty("disabled"), m_reportingName
			Case "Visible"
				assertEquals True, m_target.GetROProperty("visible"), m_reportingName
			Case "NotVisible"
				assertEquals False, m_target.GetROProperty("visible"), m_reportingName
		End Select
	End Sub
	
	'Neha 
	'#########
Public Sub assertListSearch (Filter,listname)
reportController.reportStep m_reportingName & ".assertListSearch(" & Filter & ")"

	cnt=0
	setvalue Filter
	
	strOperation="ON"
	REM strValue=""
	
	ism.page(report_page).selectAllListItem listname,strOperation
	m_target.FireEvent "onkeyup"
	
'fetch the count
StrValue=m_target.GetROProperty("value")

					If  isArray (StrValue)=True Then
					arr = Split(StrValue," ")
					
										 For i =0 to Ubound(arr) 
                                             If Instr (1,arr(i),Filter)>0 then
												 cnt=cnt+1
										   end if 
										 Next
					
					 End If



'for Fetching the count of selection.
 m_target.GetROProperty("innertext")
Count_Val=Trim(m_target.GetROProperty("innertext"))
cnt=cnt & " " & "selected"

assertEquals Count_Val,cnt,"Values Mismatched"

End Sub
End Class	


'############# WEBLIST PROXY ######################################
'Represents a WebList. Examples: Type , exists, status etc.
'############# WEBLIST PROXY ######################################
' Represents a list box. 
Class WebListProxy
    Private m_target, m_name, m_reportingName

    'For internal API use only
    Public Sub internal_assign(parentTarget, parentReportingName, name)
		m_reportingName = parentReportingName & ".webList(" & name & ")"
		reportController.reportStep m_reportingName & ".internal_assign()"
		m_name = name
		Set m_target = parentTarget.WebList("lst" & m_name)
    End Sub

    ''
    ' select an item on the list box.
    ' @param item  as string
	Public Sub selectItem(item)
		reportController.reportStep m_reportingName & ".selectItem( " & item & " )"
		If m_target.Exist(15) Then
			m_target.click
			m_target.Select item
		Else
			failTest m_reportingName & ".selectItem( " & item & " )"
		End if
	End Sub
	
	''
	' Asserts item which is selected in the combo box
	' @param expected as string
	Public Sub assertSelectedItem(expected)
		reportController.reportStep m_reportingName & ".assertSelectedItem(" & expected & ")"
		wait(1)
		assertEquals Trim(expected), Trim(m_target.GetROProperty("selection")), m_reportingName
	End Sub
	
	''
    ' Asserts item list box
    ' @param expected  string - name_space
	
	Public Sub assertListDGWDB(listBoxName,strArgstr)
		reportController.reportStep m_reportingName & ".assertListDGWDB(" & listBoxName & ")"
		connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
		
		list=split(listBoxName,";")
	  If strArgstr <> "" Then
			arrArg = Split(strArgstr,";")
		eLSE
			Dim arrArg(0)
			arrArg(0) = ""
		End If
		Select case list(0)
		
		Case "GroupBy" 
			sql = "Select grouping_option from sys_grouping"
			actListValue = DatabaseConfig.getRecords(sql,connectionString)
		Case "Campaign" 
			'sql = "Select campaign_name from sys_campaigns where start_date >="&chr(34)&arrArg(0)&chr(34)& " AND end_date <=" &chr(34) &arrArg(1)&chr(34)
			sql = "Select campaign_name from sys_campaigns where start_date >="&chr(34)&CAMP_FIRST_DATE&chr(34)& " AND end_date <=" &chr(34) &CAMP_FIRST_DATE&chr(34)
			actListValue = DatabaseConfig.getRecords(sql,connectionString)	

		End select	
		SelectList listBoxName,actListValue
	End Sub
	
	Public Sub assertListItems(listBoxName)
		reportController.reportStep m_reportingName & ".assertListItems(" & listBoxName & ")" 
		actListValue = m_target.getroproperty("all items")
		if Instr(1,actListValue,"All") then
		   actListValue=Replace(actListValue,"All;","")
		   actListValue=Replace(actListValue,";",",")
		Else 
			actListValue = Replace(actListValue,";",",")
		End if
		
		if instr(1,expListValue,"  ") > 0 Then
			expListValue = Replace(expListValue,"  "," ")
		End If
		SelectList listBoxName,actListValue
	End Sub
	
	Public Function UIListItems()
		reportController.reportStep m_reportingName & ".UIListItems(" & listBoxName & ")" 
		actListValue = m_target.getroproperty("all items")
		if Instr(1,actListValue,"All") then
		   actListValue=Replace(actListValue,"All;","")
		   actListValue=Replace(actListValue,";",",")
		end if
		UIListItems = actListValue
	End Function
	
	
	
	
	Private Sub SelectList(listBoxName,actListValue)
		reportController.reportStep m_reportingname & ".SelectList(" & listBox & ")"
		list=split(listBoxName,";")
		Select Case list(0)

			Case "Module Name"
                DatabaseConfig.compare LIST_MODULE_NAME, actListValue

			Case "Report Users"
				expListValue= getListValues(listBoxName)
				DatabaseConfig.compare expListValue, actListValue
				
			Case LIST_NumOfAlertDef
				expListValue= getListValues(listBoxName)
				DatabaseConfig.compare expListValue, actListValue
				
			Case "DeviceType"
				info LIST_DEVICE_TYPE
				info actListValue
				DatabaseConfig.compare LIST_DEVICE_TYPE, actListValue
				
			Case "VUTSummaryFilter"
				DatabaseConfig.compare LIST_VUTSUMMARY_FILTER, actListValue
				
			Case "UserWhoClosed"
				IP_Add=Environment.Value("DATA_GATEWAY_URL")
				url=IP_Add & "alerts/users"
				query = "userList/name"
				Exp_values=getListValuesFromAPI(url,query)
				DatabaseConfig.compare Exp_values, actListValue
				
			Case "SelectAMonth"
				
				Exp_values=MULTI_LIST_MONTH_VALUE
				DatabaseConfig.compare Exp_values, actListValue
			Case "SelectYear"
				Exp_values=MULTI_LIST_YEAR_VALUE
				DatabaseConfig.compare Exp_values, actListValue
			Case "UserWhoAcknowledge"
				IP_Add=Environment.Value("DATA_GATEWAY_URL")
				url=IP_Add & "alerts/users"
				query = "userList/name"
				Exp_values=getListValuesFromAPI(url,query)
				DatabaseConfig.compare Exp_values, actListValue
				
			Case "AlertDefinition"
				IP_Add=Environment.Value("DATA_GATEWAY_URL")
				url=IP_Add &"alerts/names"
				query = "alertList/name"
				Exp_values=getListValuesFromAPI(url,query)
				DatabaseConfig.compare Exp_values, actListValue
			
			Case "Show Date"
				DatabaseConfig.compare LIST_SHOW_DATE, actListValue
			
			Case "Show Time"
				DatabaseConfig.compare LIST_SHOW_TIME, actListValue
			
			Case "Search Status"
				DatabaseConfig.compare LIST_STATUS, actListValue	
			
			Case "GroupBy"				
				url = Environment.Value("DATA_GATEWAY_URL") &"schedulereport/parameters?reportname="&list(1)
				query = "\\parametername[text()='group_by']/values"
				Exp_values = getListValuesFromAPI(url,query)
				DatabaseConfig.compare Exp_values, actListValue
				
		   Case "Campaign"				
				url = Environment.Value("DATA_GATEWAY_URL") &"schedulereport/campaigns?sd="&CAMP_FIRST_DATE&"&ed="& CAMP_LAST_DATE
				query = "campaignsRow/campaignName"
				Exp_values = getListValuesFromAPI(url,query)
				DatabaseConfig.compare Exp_values, actListValue		
				
			Case "Provider"				
				url = Environment.Value("DATA_GATEWAY_URL") &"vodad/filters?datasetname="&list(1)
				query = "\\filtername[text()='provider']/value"
				Exp_values = getListValuesFromAPI(url,query)
				DatabaseConfig.compare Exp_values, actListValue
			
			Case else
				info m_reportingName & ".SelectList(), " &  listBoxName & "  not found"
				assertequals True,False,listBoxName &" list not found, argument passed in the script is invalid"
				Exit sub
	    End Select
	End Sub
	
	Private Function getListValues(listBoxName)
		reportController.reportStep m_reportingName & ".getListValues(" & listBoxName & ")"
		
		Select Case listBoxName
			Case "Report Users"
				sql = "Select loginName from User where accountType = 'real' order by loginName"
						
			Case Else
				info m_reportingName & ".getListValues(), " &  listBoxName & "  not found"
				assertequals True,False,listBoxName &" list not found, argument passed in the script is invalid"
				Exit Function
		End Select
		
		'Opening the database connection
		info "Opening the database connection"
		database.openConnection connectionString
		
		Info "connection Open"
		dim EditDefList
		EditDefList=""
		
		info "Enter "& listBoxName &" Combo query is -->" & sql
		If sql<>"" then
			'Executing Query
			Set recordSet = database.executeQuery(sql)
			info "query Executed"
			While Not recordSet.EOF 
				EditDefList =  EditDefList & trim(recordSet.Fields(0))
				EditDefList =  EditDefList & ","
				recordSet.movenext
			Wend
			recordSet.Close
		End if
		
		If EditDefList <> "" Then
			EditDefList = Left(EditDefList, len(EditDefList)-1)
		End If
		
		database.closeConnection
		getListValues = EditDefList
	End Function
	
	Public sub assertDerivedItems(listBoxName,argString)
		reportController.reportStep m_reportingName & ".assertItems(" & listBoxName & ")" 
		
		actListValue = m_target.getroproperty("all items")
		
		SelectDerivedList listBoxName,actListValue,argString
		
	End Sub
	
	Public Sub SelectDerivedList(listBoxName,actListValue,argString)
		info m_reportingname & ".SelectDerivedList"
		
		Select Case listBoxName
			Case "Report Extension Users"
				expListValue= getDerivedListValues(listBoxName,argString)
				DatabaseConfig.compare expListValue, actListValue
			Case "Bundle"
				Select Case argString
					Case "Base"
						DatabaseConfig.compare LIST_BUNDLE_INSTALL_BASE, actListValue
					Case "Common"
						DatabaseConfig.compare LIST_BUNDLE_INSTALL_COMMON, actListValue	
					Case "Ism"
						DatabaseConfig.compare LIST_BUNDLE_INSTALL_ISM, actListValue
					Case "Mmc"
						DatabaseConfig.compare LIST_BUNDLE_INSTALL_MMC, actListValue
					Case "Base_Uninstall"
						DatabaseConfig.compare LIST_BUNDLE_UNINSTALL_BASE, actListValue
					Case "Common_Uninstall"
						DatabaseConfig.compare LIST_BUNDLE_UNINSTALL_COMMON, actListValue	
					Case "Ism_Uninstall"
						DatabaseConfig.compare LIST_BUNDLE_UNINSTALL_ISM, actListValue
					Case "Mmc_Uninstall"
						DatabaseConfig.compare LIST_BUNDLE_UNINSTALL_MMC, actListValue
					Case else
						info m_reportingName & ".SelectDerivedList(), " &  actListValue & "  not found"
						assertequals True,False,actListValue &" list not found, argument passed in the script is invalid"
					Exit sub
				End Select	
			Case else
				info m_reportingName & ".SelectDerivedList(), " &  listBoxName & "  not found"
				assertequals True,False,listBoxName &" list not found, argument passed in the script is invalid"
				Exit sub
	    End Select
	End Sub
	
	Public Function getDerivedListValues(listBoxName,argString)
		reportController.reportStep m_reportingName & ".getDerivedListValues(" & listBoxName & ") "
	    'debug "In getComboValues"
		If argString <> "" Then
			arrArg = Split(argString,";")
		eLSE
			Dim arrArg(0)
			arrArg(0) = ""
		End If
		connectionString = "IVM_SYS_DATABASE_CONNECTION_STRING"
		dim EditDefList
		EditDefList=""
		sql="" 'Queries from Foreign key tables
		
		select Case listBoxName
				

			Case else
				info m_reportingName & ".getDerivedListValues(), " &  listBoxName & "  not found"
				assertequals True,False,listBoxName &" list not found, argument passed in the script is invalid"
				exit function
		end select
		info "Enter "& listBoxName &" List query is -->" & sql
		
		'Opening the database connection
		info "Opening the database connection"
		database.openConnection connectionString
		
		Info "connection Open"
		
		if sql<>"" then
			'Executing Query
			Set recordSet = database.executeQuery(sql)
			info "query Executed"
			If recordSet.EOF Then
			info "No record fetched from the database. Check the query"
			getDerivedListValues = ""
			Exit Function
		    End If
			While Not recordSet.EOF 
				Select Case listBoxName
					Case "CardLACs"
						Standby=checkSetToStandby(arg1,recordSet)
						If Standby Then
						EditDefList = "*"
						End IF
				End Select
				EditDefList =  EditDefList & trim(recordSet.Fields(0))
				EditDefList =  EditDefList & ","
				recordSet.movenext
			Wend
			recordSet.Close
		end if
		
		If EditDefList <> "" Then
			EditDefList = Left(EditDefList, len(EditDefList)-1)
		End If
		database.closeConnection
		getDerivedListValues = EditDefList
	End Function
	
	Public Sub assertItemExists(expectedvalue, state)
		reportController.reportStep m_reportingName & ".assertListItems(" & listBoxName & ")" 
		actListValue = m_target.getroproperty("all items")
		if instr(actListValue,expectedvalue)> 0 then
			assertEquals trim(state), True, m_reportingName
		Else
			assertEquals trim(state), False, m_reportingName
		End if
	End Sub
	
	' Returns the total number of Items in the listbox
	Public Function getTotalCount
		reportController.reportStep m_reportingName & ".getTotalCount()"
	    getTotalCount = m_target.getroproperty("all items")
	End Function

	'Asserts list Box Status like Editable,Non-Editable,Visible, Not visible
    '@param value  string - Expected state
	Public Sub assertStatus(expectedStatus)
		reportController.reportStep m_reportingName & ".assertStatus(" & expectedStatus & ")"
		Select Case expectedStatus
			Case "disabled"
				assertEquals True, m_target.GetROProperty("disabled"), m_reportingName
			Case "enabled"
				assertEquals False, m_target.GetROProperty("disabled"), m_reportingName
			Case "Visible"
				assertEquals True, m_target.GetROProperty("visible"), m_reportingName
			Case "NotVisible"
				assertEquals False, m_target.GetROProperty("visible"), m_reportingName
		End Select
	End Sub

	'Assert existance off the List Box Object
	'@param - state of the object
	Public Sub assertExist(state)
		reportController.reportStep m_reportingName & ".assertExist(" & state & ")"
		'waitForSync m_target
		assertEquals Trim(state), Trim(m_target.Exist(5)), m_reportingName
	End Sub
	
	'function to get the item selected in the ListBox control
	'return -  blank if no value selected or the selected value returned from the Instrumentation
	Public Function getSelectedItem
		reportController.reportStep m_reportingName & ".getSelectedItem()"
		getSelectedItem = m_target.GetROProperty("Selection")
	End Function
		
	'Sub proc to assert the error message on the listbox on the form
    '@param - expected as string
	Public Sub assertErrorMessage(expected)
		reportController.reportStep m_reportingName & ".assertErrorMessage(" & expected & ")"
		temp = m_target.GetTOProperty("errorstring")
		assertEquals trim(expected), trim(temp), m_reportingName
	End Sub

	'sub proc to assert whether the error message exists on the list box control
    '@param - state as Boolean True/False
	Public Sub assertErrorExist(state)
		reportController.reportStep m_reportingName & ".assertErrorExist(" & state & ")"
		temp = m_target.GetTOProperty("errorstring")
		If temp <> "" then
			assertEquals trim(state), True, m_reportingName
		Else
			assertEquals trim(state), False, m_reportingName
		End If
	End Sub
	
	
End Class

'Function to select the location
    Public Sub SelectLocation(nme)
		'Create an object for a focus on 
		Set lnk = Description.Create
		lnk("micclass").value  ="WebElement"
		lnk("class").value  ="tafelTreecontent"
		lnk("html tag").value  ="DIV"
		'Wait(3)
		'Set all child object to variable var1
		Set var1 = m_target.ChildObjects(lnk)
		R = 0
		k=0
		'Apply a loop for count of child object
		For i = 0 to var1.count -1		
			var2 = var1(i).getroproperty("innertext")
	       'msgbox var2
            absx= var1(i).getroproperty("abs_x")
            msgbox absx
			absy = var1(i).getroproperty("abs_y")
			'click on the focus which you pass as a parameter 		
			If var2  = nme and k=0 Then
				   k=k+1
				   var2="MMMMMMMM"
			End If 
			If Trim(var2)  = Trim(nme) and k = 1 Then
				       msgbox "OK"
					    R = 1
						var1(i).click
						Set obj = CreateObject ("Mercury.DeviceReplay")
						'''Focus on particular webelement
						obj.MouseMove absx, absy
						obj.MouseClick absx, absy,0 
						Set obj = Nothing
					Exit for
			End If
			var2 =""
		Next
		if R = 0 then
			  failTest m_reportingName & ".focus()" & " Webelement does not exists " & nme 
		End if 			
End Sub

	'Function to navigate the grid to found the data for edit
Public Function NavigateToData(searchValue)
 
						Set abc = description.Create
						abc("micclass").value="WebElement"
						abc("class").value="number-page-items"																
						Set objectcount=m_target_parent.ChildObjects(abc)
						R=0				
						 For i=0 to objectcount.count- 1            
										a=objectcount(i).getroproperty("innerhtml")
										value =split(a," ")
										'Count the number of pages in Webtable
										Total_Count= Cint(value(0)/40)
                         Next
						    For j=0 to Total_Count-1
										intNum = m_target.GetRowWithCellText(Trim(searchValue))
									    If  intNum = -1Then
												'Create an object for a webelement with two property 
												Set abc = description.Create
												abc("micclass").value="WebElement"
												abc("class").value="next paginate_button"																	
												Set a=m_target_parent.ChildObjects(abc)	
												For i=0 to a.count- 1
													'Click on each page
														 a(i).click
												        Exit for
												Next                                                                                                        
									else 
									           R=1
											   Exit for
								    End If
						 Next
        If R = 1 Then
					For ij = 0 to 2
						 Set oChild = m_target.ChildItem(intNum,5,"Link",ij)
						 If oChild.GetROProperty("name") = "Edit" then	
							 wait 10
							  oChild.Click
							   Exit For
						 End If
					Next
						NavigateToData=1
		Else
		               NavigateToData=0
		End If
	End Function

	'Function to rename on the webelement
    Public Sub dbclickLink(nme,value1)
		'Create an object for a webelement with three property 
		Set lnk = Description.Create
        lnk("micclass").value  ="WebElement"
         lnk("class").value  ="tafelTreecontent ui-draggable"
		 lnk("html tag").value  = "DIV"
		Wait(3)
		'Set all child object to variable var1
		Set var1 = m_target.ChildObjects(lnk)
		R = 0
		'Apply a loop for count of child object  to select the webelement for rename
		For i = 0 to var1.count - 1
					var2 = var1(i).getroproperty("innertext")
					absx= var1(i).getroproperty("abs_x")
					absy = var1(i).getroproperty("abs_y")
			'Double click on the link which you pass as a parameter 
			If var2  = nme Then
						R = 1
						Set obj = CreateObject ("Mercury.DeviceReplay")
						obj.MouseMove absx, absy
						obj.MouseDblClick absx, absy,0
						wait 2
						'Create an object for a webelement with three property 
						Set a = Description.Create
						lnk("micclass").value  ="WebEdit"
						lnk("class").value  ="tafelTreeeditable"
						lnk("html tag").value  = "INPUT"	
						'Set all child object to variable var5
						Set var5 = m_target.ChildObjects(a)				
						For j=0 to var5.count-1
							var3=var5(j).getroproperty("value")
									If  var3 = nme Then
									'Rename the selected  webelement  which you pass as a parameter 
										   var5(j).set value1
									End If
						Next
						Set obj = Nothing
					Exit for
			End If
		Next
		if R = 0 then
			  failTest m_reportingName & ".dbclickLink()" & " Webelement does not exists " & nme 
		End if 	
	End Sub


Function getreportVODAdDeliveryDataFeedData(report_data,argString)

Set objXML = new XMLClassProxy
			Select Case report_data
				
			
				Case "PreferredData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
							
						REM strStartDate = ConvertTimeZone (arrargString(0),"US")
						REM strEndDate = ConvertTimeZone (arrargString(1),"US")
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "vodad/preferred?q=provider:Aardman+Animation+:@:+&datasetname="& argString &"&start=0&rows=20&sort=date&order=asc" 
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "vodAdDeliveryRow/date"
							date1 = objXML.getXMLValue(query)
							query =  "vodAdDeliveryRow/provider"
							provider = objXML.getXMLValue(query)
							query =  "vodAdDeliveryRow/contentReference"
							contentReference = objXML.getXMLValue(query)
							query =  "vodAdDeliveryRow/region"
							region = objXML.getXMLValue(query)
							query =  "vodAdDeliveryRow/campaignReference"
							campaignReference = objXML.getXMLValue(query)
							query =  "vodAdDeliveryRow/campaignName"
							campaignName = objXML.getXMLValue(query)
							query =  "vodAdDeliveryRow/position"
							position = objXML.getXMLValue(query)
							'end is a key word so took string
							query =  "vodAdDeliveryRow/impressions"
							impressions = objXML.getXMLValue(query)
							query =  "vodAdDeliveryRow/actions"
							actions = objXML.getXMLValue(query)
							
							
							arr_date1 = Split(date1,",")
							arr_provider = Split(provider,",")
							arr_contentReference = Split(contentReference,",")
							arr_region = Split(region,",")
							arr_campaignReference = Split(campaignReference,",")
							arr_campaignName = Split(campaignName,",")
							arr_position = Split(position,",")
							arr_impressions = Split(impressions,",")
							arr_actions = Split(actions,",")
							
				
							For ik=0 to ubound(arr_date1)
								str=arr_date1(ik) & "," & arr_provider(ik)& "," & arr_contentReference(ik) & "," & arr_region(ik)& "," & arr_campaignReference(ik)& "," & arr_campaignName(ik)& "," & arr_position(ik)& "," & arr_impressions(ik)& "," & arr_actions(ik) 
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportVODAdDeliveryDataFeedData = strData	
							
							
					
						Case Else				
						failtest "Wrong option Selected"
				End Select
End Function

Function getScheduledReportsData(report_data,argString)

Set objXML = new XMLClassProxy
			Select Case report_data
				
			
				Case "ScheduledReports"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "schedulereport/allschedules"
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "scheduleReportRowType/scheduleOptions"
							scheduleOptions = objXML.getXMLValue(query)
							query =  "scheduleReportRowType/reportName"
							reportName1 = objXML.getXMLValue(query)
							If reportName1="VodAdDelivery" then
								reportName="Vod Ad Delivery Data Feed"
							Else reportName=reportName1
							End If
							query =  "scheduleReportRowType/user"
							user = objXML.getXMLValue(query)
							query =  "scheduleReportRowType/nextReportScheduled"
							nextReportScheduled = objXML.getXMLValue(query)
							
							
							
							arrscheduleOptions = Split(scheduleOptions,",")
							arr_reportName = Split(reportName,",")
							arr_user = Split(user,",")
							arr_nextReportScheduled = Split(nextReportScheduled,",")
							
				
							For ik=0 to ubound(arr_reportName)
								str=arr_reportName(ik) & "," & arrscheduleOptions(ik)& "," & arr_nextReportScheduled(ik) & "," & arr_user(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getScheduledReportsData = strData	
							
							
					
						Case Else				
						failtest "Wrong option Selected"
				End Select
End Function

Function getreportCampaignSummaryData(report_data,argString)

Set objXML = new XMLClassProxy
			Select Case report_data
				
			
				Case "PreferredData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
							
						REM strStartDate = ConvertTimeZone (arrargString(0),"US")
						REM strEndDate = ConvertTimeZone (arrargString(1),"US")
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "campaignsummary/preferred?q=&datasetname="& argString &"&start=0&rows=40&sort=timeRange&order=asc" 
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "campaignsummaryRow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/campaignName"
							campaignName = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/programPid"
							programPid = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
							
							
							
							arr_timeRange = Split(timeRange,",")
							arr_elementNumber = Split(elementNumber,",")
							arr_campaignName = Split(campaignName,",")
							arr_programPid = Split(programPid,",")
							arr_totalAdView = Split(totalAdView,",")
							
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik) & "," & arr_elementNumber(ik)& "," & arr_campaignName(ik) & "," & arr_programPid(ik)& "," & arr_totalAdView(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportCampaignSummaryData = strData	
							
				Case "DetailedData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "campaignsummary/detailed?q=&datasetname="& argString &"&start=0&rows=20&sort=timeRange&order=asc" 
							
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "campaignsummaryRow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/campaignName"
							campaignName = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/clockNumber"
							clockNumber = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/programPid"
							programPid = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/uniqueCustomers"
							uniqueCustomers = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/adPlacementCount"
							adPlacementCount = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/adFullViews"
							adFullViews = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/adPartialViews"
							adPartialViews = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/adFfwViews"
							adFfwViews = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/adNotViewed"
							adNotViewed = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/adAvgPlayTime"
							adAvgPlayTime = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/totalHomeView"
							totalHomeView = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
														
							
							arr_timeRange = Split(timeRange,",")
							arr_elementNumber = Split(elementNumber,",")
							arr_campaignName = Split(campaignName,",")
							arr_clockNumber = Split(clockNumber,",")
							arr_programPid = Split(programPid,",")
							arr_uniqueCustomers = Split(uniqueCustomers,",")
							arr_adPlacementCount = Split(adPlacementCount,",")
							arr_adFullViews = Split(adFullViews,",")
							arr_adPartialViews = Split(adPartialViews,",")
							arr_adFfwViews = Split(adFfwViews,",")
							arr_adNotViewed = Split(adNotViewed,",")
							arr_adAvgPlayTime = Split(adAvgPlayTime,",")
							arr_totalHomeView = Split(totalHomeView,",")
							arr_totalAdView = Split(totalAdView,",")
							
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik) & "," & arr_elementNumber(ik)& "," & arr_campaignName(ik) &"," & arr_clockNumber(ik) &"," &arr_programPid(ik)& "," & arr_uniqueCustomers(ik)& "," & arr_adPlacementCount(ik)& "," & arr_adFullViews(ik)& "," & arr_adPartialViews(ik)& "," & arr_adFfwViews(ik)& "," & arr_adNotViewed(ik)& "," & arr_totalHomeView(ik)& "," & arr_adAvgPlayTime(ik)& "," & arr_totalAdView(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportCampaignSummaryData = strData	
							
							
					
							Case Else				
							failtest "Wrong option Selected"
					End Select
End Function

Function getreportProgramSummaryData(report_data,argString)

Set objXML = new XMLClassProxy
			Select Case report_data
				
			
				Case "PreferredData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
							
						REM strStartDate = ConvertTimeZone (arrargString(0),"US")
						REM strEndDate = ConvertTimeZone (arrargString(1),"US")
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "programsummary/preferred?&datasetname="& argString &"&start=0&rows=20&sort=timeRange&order=asc" 
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "programSummaryRow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "programSummaryRow/campaignName"
							campaignName = objXML.getXMLValue(query)
							query =  "programSummaryRow/progPid"
							progPid = objXML.getXMLValue(query)
							query =  "programSummaryRow/channel"
							channel = objXML.getXMLValue(query)
							query =  "programSummaryRow/progTitle"
							progTitle = objXML.getXMLValue(query)
							query =  "programSummaryRow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
							
							
							
							arr_timeRange = Split(timeRange,",")
							arr_channel = Split(channel,",")
							arr_campaignName = Split(campaignName,",")
							arr_progPid = Split(progPid,",")
							arr_totalAdView = Split(totalAdView,",")
							arr_progTitle = Split(progTitle,",")
							
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik) & "," & arr_campaignName(ik) & "," & arr_progPid(ik)& "," & arr_channel(ik)& "," & arr_progTitle(ik)& "," & arr_totalAdView(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportProgramSummaryData = strData	
							
				Case "DetailedData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "programsummary/detailed?&datasetname="& argString &"&start=0&rows=20&sort=timeRange&order=asc" 
							
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "programSummaryRow/timeRange"
							timeRange = objXML.getXMLValue(query)

							query =  "programSummaryRow/campaignName"
							campaignName = objXML.getXMLValue(query)
							query =  "programSummaryRow/clockNumber"
							clockNumber = objXML.getXMLValue(query)

                            query =  "programSummaryRow/uniqueCustomers"
							uniqueCustomers = objXML.getXMLValue(query)

							query =  "programSummaryRow/progPid"
							progPid = objXML.getXMLValue(query)

                            query =  "programSummaryRow/progPaid"
							programPaid = objXML.getXMLValue(query)

							query =  "programSummaryRow/channel"
							channel = objXML.getXMLValue(query)

                            query =  "programSummaryRow/progTitle"
							progTitle = objXML.getXMLValue(query)

                            query =  "programSummaryRow/progSeriesTitle"
							progSeriesTitle = objXML.getXMLValue(query)
							
							query =  "programSummaryRow/adPlacementCount"
							adPlacementCount = objXML.getXMLValue(query)
							query =  "programSummaryRow/adFullViews"
							adFullViews = objXML.getXMLValue(query)
							query =  "programSummaryRow/adPartialViews"
							adPartialViews = objXML.getXMLValue(query)
							query =  "programSummaryRow/adFfwViews"
							adFfwViews = objXML.getXMLValue(query)
							query =  "programSummaryRow/adNotViewed"
							adNotViewed = objXML.getXMLValue(query)

							query =  "programSummaryRow/totalHomeView"
							totalHomeView = objXML.getXMLValue(query)
							query =  "programSummaryRow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
														
							
							arr_timeRange = Split(timeRange,",")
							arr_campaignName = Split(campaignName,",")
							arr_clockNumber = Split(clockNumber,",")
							arr_uniqueCustomers = Split(uniqueCustomers,",")
							arr_progPid = Split(progPid,",")
							arr_programPaid=split(programPaid,",")
							arr_channel=split(channel,",")
							arr_progTitle=split(progTitle,",")
							arr_progSeriesTitle=split(progSeriesTitle,",")
							arr_adPlacementCount = Split(adPlacementCount,",")
							arr_adFullViews = Split(adFullViews,",")
							arr_adPartialViews = Split(adPartialViews,",")
							arr_adFfwViews = Split(adFfwViews,",")
							arr_adNotViewed = Split(adNotViewed,",")
							arr_totalHomeView = Split(totalHomeView,",")
							arr_totalAdView = Split(totalAdView,",")
							
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik)& "," & arr_campaignName(ik) &"," & arr_clockNumber(ik) & "," & arr_uniqueCustomers(ik)&"," &arr_progPid(ik)&","&arr_programPaid(ik)&","&arr_channel(ik)&","&arr_progTitle(ik)&","&arr_progSeriesTitle(ik)& "," & arr_adPlacementCount(ik)& "," & arr_adFullViews(ik)& "," & arr_adPartialViews(ik)& "," & arr_adFfwViews(ik)& "," & arr_totalHomeView(ik)& "," & arr_adNotViewed(ik)& "," & arr_totalAdView(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportProgramSummaryData = strData	
							
							
					
							Case Else				
							failtest "Wrong option Selected"
					End Select
End Function

Function getreportRegionSummaryData(report_data,argString)

Set objXML = new XMLClassProxy
			Select Case report_data
				
			
				Case "PreferredData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "regionsummary/preferred?&datasetname="& argString &"&start=0&rows=20&sort=timeRange&order=asc" 
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "regionSummaryRow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "regionSummaryRow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							query =  "regionSummaryRow/campaignName"
							campaignName = objXML.getXMLValue(query)
							query =  "regionSummaryRow/regionName"
							regionName = objXML.getXMLValue(query)
							query =  "regionSummaryRow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
							
							
							
							arr_timeRange = Split(timeRange,",")
							arr_elementNumber = Split(elementNumber,",")
							arr_campaignName = Split(campaignName,",")
							arr_regionName = Split(regionName,",")
							arr_totalAdView = Split(totalAdView,",")
					
							
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik)&","&arr_elementNumber(ik) & "," & arr_campaignName(ik) & "," & arr_regionName(ik)& "," & arr_totalAdView(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportRegionSummaryData = strData	
							
				Case "DetailedData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "regionsummary/detailed?&datasetname="& argString &"&start=0&rows=20&sort=timeRange&order=asc" 
							
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "regionSummaryRow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "regionSummaryRow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							query =  "regionSummaryRow/campaignName"
							campaignName = objXML.getXMLValue(query)
							query =  "regionSummaryRow/clockNumber"
							clockNumber = objXML.getXMLValue(query)
							query =  "regionSummaryRow/regionId"
							regionId = objXML.getXMLValue(query)
							query =  "regionSummaryRow/regionName"
							regionName = objXML.getXMLValue(query)
							query =  "regionSummaryRow/regionGroupName"
							regionGroupName = objXML.getXMLValue(query)
                            query =  "regionSummaryRow/adPlacementCount"
							adPlacementCount = objXML.getXMLValue(query)	
							query =  "regionSummaryRow/adFullViews"
							adFullViews = objXML.getXMLValue(query)
							query =  "regionSummaryRow/adPartialViews"
							adPartialViews = objXML.getXMLValue(query)
							query =  "regionSummaryRow/adFfwViews"
							adFfwViews = objXML.getXMLValue(query)
							query =  "regionSummaryRow/adNotViewed"
							adNotViewed = objXML.getXMLValue(query)
							query =  "regionSummaryRow/totalHomeView"
							totalHomeView = objXML.getXMLValue(query)
							query =  "regionSummaryRow/adAvgPlayTime"
							adAvgPlayTime = objXML.getXMLValue(query)
							query =  "regionSummaryRow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
												
							
							arr_timeRange = Split(timeRange,",")
							arr_elementNumber = Split(elementNumber,",")
							arr_campaignName = Split(campaignName,",")
							arr_clockNumber = Split(clockNumber,",")
							arr_regionId = Split(regionId,",")
							arr_regionName = Split(regionName,",")
							arr_regionGroupName = Split(regionGroupName,",")
							arr_adPlacementCount = Split(adPlacementCount,",")
							arr_adFullViews = Split(adFullViews,",")
							arr_adPartialViews = Split(adPartialViews,",")
							arr_adFfwViews = Split(adFfwViews,",")
							arr_adNotViewed = Split(adNotViewed,",")
							arr_totalHomeView = Split(totalHomeView,",")
							arr_adAvgPlayTime = Split(adAvgPlayTime,",")
							arr_totalAdView = Split(totalAdView,",")
							
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik) & "," & arr_elementNumber(ik)& "," & arr_campaignName(ik) &"," & arr_clockNumber(ik) &"," &arr_regionId(ik)& "," & arr_regionName(ik)&","&arr_regionGroupName(ik)& "," & arr_adPlacementCount(ik)& "," & arr_adFullViews(ik)& "," & arr_adPartialViews(ik)& "," & arr_adFfwViews(ik)& "," & arr_adNotViewed(ik)& "," & arr_totalHomeView(ik)& "," & arr_adAvgPlayTime(ik)& "," & arr_totalAdView(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportRegionSummaryData = strData	
							
							
					
							Case Else				
							failtest "Wrong option Selected"
					End Select
End Function

Function getreportAdvertisementSummaryData(report_data,argString)

Set objXML = new XMLClassProxy
			Select Case report_data
				
			
				Case "PreferredData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "advertisementsummary/preferred?&datasetname="& argString &"&start=0&rows=40&sort=timeRange&order=asc" 
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "advertisementSummaryRow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/clockNumber"
							clockNumber = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/progProvider"
							progProvider = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adBreak"
							adBreak = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adSlotPosition"
							adSlotPosition = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
							
							
							
							arr_timeRange = Split(timeRange,",")
							arr_elementNumber = Split(elementNumber,",")
							arr_clockNumber = Split(clockNumber,",")
							arr_progProvider = Split(progProvider,",")
							arr_adBreak = Split(adBreak,",")
							arr_adSlotPosition = Split(adSlotPosition,",")
							arr_totalAdView = Split(totalAdView,",")
							
							
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik) & "," & arr_elementNumber(ik) & "," &  arr_clockNumber(ik) & "," &arr_progProvider(ik)& "," & arr_adBreak(ik)& "," & arr_adSlotPosition(ik)& "," & arr_totalAdView(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportAdvertisementSummaryData = strData	
							
				Case "DetailedData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "advertisementsummary/detailed?&datasetname="& argString &"&start=0&rows=40&sort=timeRange&order=asc" 
							
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "advertisementSummaryRow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/clockNumber"
							clockNumber = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/campaignName"
							campaignName = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/progProvider"
							progProvider = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/uniqueCustomers"
							uniqueCustomers = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adTitle"
							adTitle = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adBreak"
							adBreak = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adSlotPosition"
							adSlotPosition = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adPlacementCount"
							adPlacementCount = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adFullViews"
							adFullViews = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adPartialViews"
							adPartialViews = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adFfwViews"
							adFfwViews = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adNotViewed"
							adNotViewed = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/totalHomeView"
							totalHomeView = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adAvgPlayTime"
							adAvgPlayTime = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
														
							
							arr_timeRange = Split(timeRange,",")
							arr_elementNumber = Split(elementNumber,",")
							arr_clockNumber = Split(clockNumber,",")
							arr_campaignName = Split(campaignName,",")
							arr_progProvider = Split(progProvider,",")
							arr_uniqueCustomers = Split(uniqueCustomers,",")
							arr_adTitle = Split(adTitle,",")
							arr_adBreak = Split(adBreak,",")
							arr_adSlotPosition = Split(adSlotPosition,",")
							arr_adPlacementCount = Split(adPlacementCount,",")
							arr_adFullViews = Split(adFullViews,",")
							arr_adPartialViews = Split(adPartialViews,",")
							arr_adFfwViews = Split(adFfwViews,",")
							arr_adNotViewed = Split(adNotViewed,",")
							arr_totalHomeView = Split(totalHomeView,",")
							arr_adAvgPlayTime = Split(adAvgPlayTime,",")
							arr_totalAdView = Split(totalAdView,",")
							
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik) & "," & arr_elementNumber(ik)& "," & arr_campaignName(ik) &"," &arr_clockNumber(ik) &"," &arr_progProvider(ik)& "," & arr_uniqueCustomers(ik)& "," &arr_adTitle(ik)& "," &arr_adBreak(ik)& "," &arr_adSlotPosition(ik)& "," &arr_adPlacementCount(ik)& "," & arr_adFullViews(ik)& "," & arr_adPartialViews(ik)& "," & arr_adFfwViews(ik)& "," & arr_adNotViewed(ik)& "," & arr_totalHomeView(ik)& "," & arr_adAvgPlayTime(ik)& "," & arr_totalAdView(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportAdvertisementSummaryData = strData	
							
							
					
							Case Else				
							failtest "Wrong option Selected"
					End Select
End Function

Function getreportAllDetailsData(report_data,argString)

Set objXML = new XMLClassProxy
			Select Case report_data
				
			
				Case "PreferredData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "advertisementsummary/preferred?&datasetname="& argString &"&start=0&rows=40&sort=timeRange&order=asc" 
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "advertisementSummaryRow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/clockNumber"
							clockNumber = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/progProvider"
							progProvider = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adBreak"
							adBreak = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adSlotPosition"
							adSlotPosition = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
							
							
							
							arr_timeRange = Split(timeRange,",")
							arr_elementNumber = Split(elementNumber,",")
							arr_clockNumber = Split(clockNumber,",")
							arr_progProvider = Split(progProvider,",")
							arr_adBreak = Split(adBreak,",")
							arr_adSlotPosition = Split(adSlotPosition,",")
							arr_totalAdView = Split(totalAdView,",")
							
							
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik) & "," & arr_elementNumber(ik) & "," &  arr_clockNumber(ik) & "," &arr_progProvider(ik)& "," & arr_totalAdView(ik)& "," & arr_adBreak(ik)& "," & arr_adSlotPosition(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportAdvertisementSummaryData = strData	
							
				Case "DetailedData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "alldetails/detailed?&datasetname="& argString &"&start=0&rows=40&sort=timeRange&order=asc" 
							
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "allDetailrow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "allDetailrow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							query =  "allDetailrow/clockNumber"
							clockNumber = objXML.getXMLValue(query)
							query =  "allDetailrow/regionName"
							regionName = objXML.getXMLValue(query)
							query =  "allDetailrow/regionGroupName"
							regionGroupName = objXML.getXMLValue(query)
							query =  "allDetailrow/progPid"
							progPid = objXML.getXMLValue(query)
							query =  "allDetailrow/progPaid"
							progPaid = objXML.getXMLValue(query)
							query =  "allDetailrow/channel"
							channel = objXML.getXMLValue(query)
							query =  "allDetailrow/progSeriesTitle"
							progSeriesTitle = objXML.getXMLValue(query)
							query =  "allDetailrow/progPlacementCount"
							progPlacementCount = objXML.getXMLValue(query)
							query =  "allDetailrow/progTitle"
							progTitle = objXML.getXMLValue(query)
							query =  "allDetailrow/progEpisodeTitle"
							progEpisodeTitle = objXML.getXMLValue(query)
							query =  "allDetailrow/proEpisodeId"
							proEpisodeId = objXML.getXMLValue(query)
							query =  "allDetailrow/progViews"
							progViews = objXML.getXMLValue(query)
							query =  "allDetailrow/progPartialViews"
							progPartialViews = objXML.getXMLValue(query)
							query =  "allDetailrow/campaignName"
							campaignName = objXML.getXMLValue(query)
							query =  "allDetailrow/uniqueCustomers"
							uniqueCustomers = objXML.getXMLValue(query)
							query =  "allDetailrow/adTitle"
							adTitle = objXML.getXMLValue(query)
							query =  "allDetailrow/adPlacementCount"
							adPlacementCount = objXML.getXMLValue(query)
							query =  "allDetailrow/adFullViews"
							adFullViews = objXML.getXMLValue(query)
							query =  "allDetailrow/adPartialViews"
							adPartialViews = objXML.getXMLValue(query)
							query =  "allDetailrow/adFfwViews"
							adFfwViews = objXML.getXMLValue(query)
							query =  "allDetailrow/adNotViewed"
							adNotViewed = objXML.getXMLValue(query)
							query =  "allDetailrow/totalHomeView"
							totalHomeView = objXML.getXMLValue(query)
							query =  "allDetailrow/adAvgPlayTime"
							adAvgPlayTime = objXML.getXMLValue(query)
							query =  "allDetailrow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
														
							
							arr_timeRange = Split(timeRange,",")
							arr_elementNumber = Split(elementNumber,",")
							arr_clockNumber = Split(clockNumber,",")
							arr_campaignName = Split(campaignName,",")
							arr_uniqueCustomers = Split(uniqueCustomers,",")
							arr_adTitle = Split(adTitle,",")
							arr_adPlacementCount = Split(adPlacementCount,",")
							arr_adFullViews = Split(adFullViews,",")
							arr_adPartialViews = Split(adPartialViews,",")
							arr_adFfwViews = Split(adFfwViews,",")
							arr_adNotViewed = Split(adNotViewed,",")
							arr_totalHomeView = Split(totalHomeView,",")
							arr_adAvgPlayTime = Split(adAvgPlayTime,",")
							arr_regionName = Split(regionName,",")
							arr_regionGroupName = Split(regionGroupName,",")
							arr_progPid = Split(progPid,",")
							arr_progPaid = Split(progPaid,",")
							arr_channel = Split(channel,",")
							arr_proEpisodeId = Split(proEpisodeId,",")
							arr_progEpisodeTitle = Split(progEpisodeTitle,",")
							arr_progSeriesTitle = Split(progSeriesTitle,",")
							arr_progPlacementCount = Split(progPlacementCount,",")
							arr_progTitle = Split(progTitle,",")
							arr_progViews = Split(progViews,",")
							arr_progPartialViews = Split(progPartialViews,",")
							arr_totalAdView = Split(totalAdView,",")
							
							
				
							For ik=0 to ubound(arr_progPaid)
								str=arr_timeRange(ik) & "," & arr_elementNumber(ik)& "," & arr_campaignName(ik) &"," &arr_clockNumber(ik)& "," & arr_uniqueCustomers(ik)& "," & arr_regionName(ik)& ","& arr_regionGroupName(ik)& ","& arr_progPid(ik)& ","& arr_progPaid(ik)& ","& arr_channel(ik)& "," &arr_progTitle(ik)& "," &arr_progEpisodeTitle(ik)& "," &arr_progSeriesTitle(ik)& "," &arr_proEpisodeId(ik)& "," &arr_progPlacementCount(ik)& "," &arr_progViews(ik)& "," &arr_progPartialViews(ik)& "," &arr_adTitle(ik)& "," & arr_adPlacementCount(ik)& "," & arr_adFullViews(ik)& "," & arr_adPartialViews(ik)& "," & arr_adFfwViews(ik)& "," & arr_adNotViewed(ik)& "," & arr_totalHomeView(ik)& "," & arr_adAvgPlayTime(ik)& "," & arr_totalAdView(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportAllDetailsData = strData	
							
							
					
							Case Else				
							failtest "Wrong option Selected"
					End Select
End Function

Function getreportAdvertisementandProgramDetailsData(report_data,argString)

Set objXML = new XMLClassProxy
			Select Case report_data
				
			
				'Case "PreferredData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
							
						
				'			'DGW URL
				'			strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "advertisementsummary/preferred?&datasetname="& argString &"&start=0&rows=40&sort=timeRange&order=asc" 
				'			info "strWebServiceURL Link ===>" & strWebServiceURL
							
				'			'XML Parsing.
				'			objXML.getWSXML(strWebServiceURL)
				'			query =  "advertisementSummaryRow/timeRange"
				'			timeRange = objXML.getXMLValue(query)
				'			query =  "advertisementSummaryRow/elementNumber"
				'			elementNumber = objXML.getXMLValue(query)
				'			query =  "advertisementSummaryRow/clockNumber"
				'			clockNumber = objXML.getXMLValue(query)
				'			query =  "advertisementSummaryRow/progProvider"
				'			progProvider = objXML.getXMLValue(query)
				'			query =  "advertisementSummaryRow/adBreak"
				'			adBreak = objXML.getXMLValue(query)
				'			query =  "advertisementSummaryRow/adSlotPosition"
				'			adSlotPosition = objXML.getXMLValue(query)
				'			query =  "advertisementSummaryRow/totalAdView"
				'			totalAdView = objXML.getXMLValue(query)
				'			
				'			
							
				'			arr_timeRange = Split(timeRange,",")
				'			arr_elementNumber = Split(elementNumber,",")
				'			arr_clockNumber = Split(clockNumber,",")
				'			arr_progProvider = Split(progProvider,",")
				'			arr_adBreak = Split(adBreak,",")
				'			arr_adSlotPosition = Split(adSlotPosition,",")
				'			arr_totalAdView = Split(totalAdView,",")
				'			
							
							
				
				'			For ik=0 to ubound(arr_timeRange)
				'				str=arr_timeRange(ik) & "," & arr_elementNumber(ik) & "," &  arr_clockNumber(ik) & "," &arr_progProvider(ik)& "," & arr_totalAdView(ik)& "," & arr_adBreak(ik)& "," & arr_adSlotPosition(ik)
				'				info "FROM XML====> " & str
				'				str1 = str1&";"&str
				'				str = ""
				'				strData =  mid(str1,"2")
				'			Next
				'			getreportAdvertisementandProgramDetailsData = strData	
							
				Case "DetailedData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "advandprogdetails/detailed?&datasetname="& argString &"&start=0&rows=40&sort=timeRange&order=asc" 
							
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
  						'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "advandProgramDetailrow/timeRange"
							timeRange = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/campaignName"
							campaignName = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/clockNumber"
							clockNumber = objXML.getXMLValue(query)
							
							
							query =  "advandProgramDetailrow/uniqueCustomers"
							uniqueCustomers = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/progPid"
							progPid = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/progPaid"
							progPaid = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/channel"
							channel = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/progTitle"
							progTitle = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/progEpisodeTitle"
							progEpisodeTitle = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/progSeriesTitle"
							progSeriesTitle = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/progEpisodeId"
							progEpisodeId = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/progPlacementCount"
							progPlacementCount = objXML.getXMLValue(query)
														
							query =  "advandProgramDetailrow/progViews"
							progViews = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/progPartialViews"
							progPartialViews = objXML.getXMLValue(query)							
														
							query =  "advandProgramDetailrow/adTitle"
							adTitle = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/adPlacementCount"
							adPlacementCount = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/adFullViews"
							adFullViews = objXML.getXMLValue(query)
													
							query =  "advandProgramDetailrow/adFfwViews"
							adFfwViews = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/adPartialViews"
							adPartialViews = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/adNotViewed"
							adNotViewed = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/totalHomeView"
							totalHomeView = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/adAvgPlayTime"
							adAvgPlayTime = objXML.getXMLValue(query)
							
							query =  "advandProgramDetailrow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
														
							
							arr_timeRange = Split(timeRange,",")
							arr_elementNumber = Split(elementNumber,",")
							arr_clockNumber = Split(clockNumber,",")
							arr_campaignName = Split(campaignName,",")
							arr_uniqueCustomers = Split(uniqueCustomers,",")
							arr_adTitle = Split(adTitle,",")
							arr_adPlacementCount = Split(adPlacementCount,",")
							arr_adFullViews = Split(adFullViews,",")
							arr_adPartialViews = Split(adPartialViews,",")
							arr_adFfwViews = Split(adFfwViews,",")
							arr_adNotViewed = Split(adNotViewed,",")
							arr_totalHomeView = Split(totalHomeView,",")
							arr_adAvgPlayTime = Split(adAvgPlayTime,",")
							
							arr_progPid = Split(progPid,",")
							arr_progPaid = Split(progPaid,",")
							arr_channel = Split(channel,",")
							arr_progEpisodeId = Split(progEpisodeId,",")
							arr_progEpisodeTitle = Split(progEpisodeTitle,",")
							arr_progSeriesTitle = Split(progSeriesTitle,",")
							arr_progPlacementCount = Split(progPlacementCount,",")
							arr_progTitle = Split(progTitle,",")
							arr_progViews = Split(progViews,",")
							arr_progPartialViews = Split(progPartialViews,",")
							arr_totalAdView = Split(totalAdView,",")
							
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik) & "," & arr_elementNumber(ik)& "," & arr_campaignName(ik) &"," &arr_clockNumber(ik)& "," & arr_uniqueCustomers(ik)& "," & arr_progPid(ik)& ","& arr_progPaid(ik)& ","& arr_channel(ik)& "," &arr_progTitle(ik)& "," &arr_progEpisodeTitle(ik)& "," &arr_progSeriesTitle(ik)& "," &arr_progEpisodeId(ik)& "," &arr_progPlacementCount(ik)& "," &arr_progViews(ik)& "," &arr_progPartialViews(ik)& "," &arr_adTitle(ik)& "," & arr_adPlacementCount(ik)& "," & arr_adFullViews(ik)& "," & arr_adPartialViews(ik) &","& arr_adFfwViews(ik) &  ","& arr_adNotViewed(ik)& "," & arr_totalHomeView(ik)& "," & arr_adAvgPlayTime(ik)& "," & arr_totalAdView(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportAdvertisementandProgramDetailsData = strData	
							
							
					
							Case Else				
							failtest "Wrong option Selected"
					End Select
End Function

Function getreportUniqueCustomersData(report_data,argString)

Set objXML = new XMLClassProxy
			Select Case report_data
				
			
				Case "PreferredData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "advertisementsummary/preferred?&datasetname="& argString &"&start=0&rows=40&sort=timeRange&order=asc" 
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "advertisementSummaryRow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/clockNumber"
							clockNumber = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/progProvider"
							progProvider = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adBreak"
							adBreak = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/adSlotPosition"
							adSlotPosition = objXML.getXMLValue(query)
							query =  "advertisementSummaryRow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
							
							
							
							arr_timeRange = Split(timeRange,",")
							arr_elementNumber = Split(elementNumber,",")
							arr_clockNumber = Split(clockNumber,",")
							arr_progProvider = Split(progProvider,",")
							arr_adBreak = Split(adBreak,",")
							arr_adSlotPosition = Split(adSlotPosition,",")
							arr_totalAdView = Split(totalAdView,",")
							
							
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik) & "," & arr_elementNumber(ik) & "," &  arr_clockNumber(ik) & "," &arr_progProvider(ik)& "," & arr_totalAdView(ik)& "," & arr_adBreak(ik)& "," & arr_adSlotPosition(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportUniqueCustomersData = strData	
							
				Case "DetailedData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "uniquecustomer/detailed?&datasetname="& argString &"&start=0&rows=40&sort=timeRange&order=asc" 
							
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "uniqueCustomerrow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "uniqueCustomerrow/uniqueCustomers"
							uniqueCustomers = objXML.getXMLValue(query)
							
							
														
							
							arr_timeRange = Split(timeRange,",")
							arr_uniqueCustomers = Split(uniqueCustomers,",")
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik) & "," & arr_uniqueCustomers(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportUniqueCustomersData = strData	
							
							
					
							Case Else				
							failtest "Wrong option Selected"
					End Select
End Function

Function getreportEndOfCampaignData(report_data,argString)

Set objXML = new XMLClassProxy
			Select Case report_data
				
			
				Case "PreferredData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "endofcampaign/preferred?q=&datasetname="& argString &"&start=0&rows=40&sort=timeRange&order=asc" 
							info "strWebServiceURL Link ===>" & strWebServiceURL
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "campaignsummaryRow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/campaignName"
							campaignName = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
							
							
							
							arr_timeRange = Split(timeRange,",")
							arr_elementNumber = Split(elementNumber,",")
							arr_campaignName = Split(campaignName,",")
							arr_totalAdView = Split(totalAdView,",")
							
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik) & "," & arr_elementNumber(ik)& "," & arr_campaignName(ik) & "," & arr_totalAdView(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next	
							getreportEndOfCampaignData = strData
							
				Case "DetailedData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "campaignsummary/detailed?q=&datasetname="& argString &"&start=0&rows=40&sort=timeRange&order=asc" 
							
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "campaignsummaryRow/timeRange"
							timeRange = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/campaignName"
							campaignName = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/clockNumber"
							clockNumber = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/programPid"
							programPid = objXML.getXMLValue(query)
'							query =  "campaignsummaryRow/progPaid"
'							progPaid = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/uniqueCustomers"
							uniqueCustomers = objXML.getXMLValue(query)
'							query =  "campaignsummaryRow/channel"
'							channel = objXML.getXMLValue(query)
'							query =  "campaignsummaryRow/progTitle"
'							progTitle = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/adPlacementCount"
							adPlacementCount = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/adFullViews"
							adFullViews = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/adPartialViews"
							adPartialViews = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/adFfwViews"
							adFfwViews = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/adNotViewed"
							adNotViewed = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/adAvgPlayTime"
							adAvgPlayTime = objXML.getXMLValue(query)
							query =  "campaignsummaryRow/totalHomeView"
							totalHomeView = objXML.getXMLValue(query)
    						query =  "campaignsummaryRow/totalAdView"
							totalAdView = objXML.getXMLValue(query)
														
							
							arr_timeRange = Split(timeRange,",")
							arr_elementNumber = Split(elementNumber ,",")
							arr_campaignName = Split(campaignName,",")
							arr_clockNumber = Split(clockNumber,",")
							arr_programPid = Split(programPid,",")
'							arr_progPaid = Split(progPaid,",")
							arr_uniqueCustomers = Split(uniqueCustomers,",")
'							arr_channel = Split(channel,",")
'							arr_progTitle = Split(progTitle,",")
'							arr_progSeriesTitle = Split(progSeriesTitle,",")
							arr_adPlacementCount = Split(adPlacementCount,",")
							arr_adFullViews = Split(adFullViews,",")
							arr_adPartialViews = Split(adPartialViews,",")
							arr_adFfwViews = Split(adFfwViews,",")
							arr_adNotViewed = Split(adNotViewed,",")
							arr_adAvgPlayTime = Split(adAvgPlayTime,",")
							arr_totalHomeView = Split(totalHomeView,",")
							arr_totalAdView = Split(totalAdView,",")
							
							
				
							For ik=0 to ubound(arr_timeRange)
								str=arr_timeRange(ik) & "," & arr_elementNumber(ik) & "," & arr_campaignName(ik) &"," & arr_clockNumber(ik) &"," & arr_programPid(ik) &"," & arr_uniqueCustomers(ik)& ","& arr_adPlacementCount(ik)& "," & arr_adFullViews(ik)& "," & arr_adPartialViews(ik) & "," & arr_adFfwViews(ik)& "," & arr_adNotViewed(ik)& "," &  arr_totalHomeView(ik)& "," & arr_adAvgPlayTime(ik)& "," & arr_totalAdView(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportEndOfCampaignData = strData	
							
							
					
							Case Else				
							failtest "Wrong option Selected"
					End Select
End Function

Function getreportRawDataData(report_data,argString)

Set objXML = new XMLClassProxy
			Select Case report_data
				
			
				Case "PreferredData"
							'Split Date into Start Date and End Date,'Here arrargString(0)=strStartDate and 	arrargString(1)=strEndDate
							
							
						REM strStartDate = ConvertTimeZone (arrargString(0),"US")
						REM strEndDate = ConvertTimeZone (arrargString(1),"US")
						
							'DGW URL
						strWebServiceURL =Environment.value("DATA_GATEWAY_URL")&"rawdata/preferred?q=&datasetname="& argString &"&start=0&rows=40&sort=viewDate&order=asc" 
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "rawDataRow/viewDate"
							viewDate = objXML.getXMLValue(query)
							query =  "rawDataRow/deviceId"
							deviceId = objXML.getXMLValue(query)
							query =  "rawDataRow/plViewTypeFull"
							plViewTypeFull = objXML.getXMLValue(query)
							query =  "rawDataRow/plViewTypePartial"
							plViewTypePartial = objXML.getXMLValue(query)
                            query="rawDataRow/plViewTypeFfw"
                            plViewTypeFfw= objXML.getXMLValue(query)
							query =  "rawDataRow/breakNumber"
							breakNumber = objXML.getXMLValue(query)
							query =  "rawDataRow/slotPosition"
							slotPosition = objXML.getXMLValue(query)
							query =  "rawDataRow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							query =  "rawDataRow/clockNumber"
							clockNumber = objXML.getXMLValue(query)
							query =  "rawDataRow/progPid"
							progPid = objXML.getXMLValue(query)
							query =  "rawDataRow/channel"
							channel = objXML.getXMLValue(query)
							
							
							arr_viewDate = Split(viewDate,",")
							arr_deviceId = Split(deviceId,",")
							arr_plViewTypeFull = Split(plViewTypeFull,",")
							arr_plViewTypePartial = Split(plViewTypePartial,",")
                            arr_plViewTypeFfw = Split(plViewTypeFfw,",")
							arr_breakNumber = Split(breakNumber,",")
							arr_slotPosition = Split(slotPosition,",")
							arr_elementNumber = Split(elementNumber,",")
							arr_clockNumbers = Split(clockNumber,",")
							arr_progPid = Split(progPid,",")
							arr_channel = Split(channel,",")
							
				
							For ik=0 to ubound(arr_viewDate)
								str=arr_viewDate(ik) & "," & arr_deviceId(ik)& "," & arr_plViewTypeFull(ik) & "," & arr_plViewTypePartial(ik)&","&arr_plViewTypeFfw(ik)& "," & arr_breakNumber(ik)& "," & arr_slotPosition(ik)& "," & arr_elementNumber(ik)& "," & arr_clockNumbers(ik)& "," & arr_progPid(ik) & "," & arr_channel(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportRawDataData = strData	
							
				Case "DetailedData"
							
						
							'DGW URL
							strWebServiceURL =Environment.value("DATA_GATEWAY_URL")& "rawdata/detailed?q=&datasetname="& argString &"&start=0&rows=40&sort=bindId&order=asc" 
							info "strWebServiceURL Link ===>" & strWebServiceURL
							
							'XML Parsing.
							objXML.getWSXML(strWebServiceURL)
							query =  "rawDataRow/bindId"
							bindId = objXML.getXMLValue(query)
							query =  "rawDataRow/viewDate"
							viewDate = objXML.getXMLValue(query)
							query =  "rawDataRow/deviceId"
							deviceId = objXML.getXMLValue(query)
							query =  "rawDataRow/plAssetType"
							plAssetType = objXML.getXMLValue(query)
							query =  "rawDataRow/plViewTypeUnknown"
							plViewTypeUnknown = objXML.getXMLValue(query)
							query =  "rawDataRow/plViewTypeFull"
							plViewTypeFull = objXML.getXMLValue(query)
							query =  "rawDataRow/plViewTypePartial"
							plViewTypePartial = objXML.getXMLValue(query)
							query =  "rawDataRow/plViewTypeFfw"
							plViewTypeFfw = objXML.getXMLValue(query)
							query =  "rawDataRow/plPlayTimeSec"
							plPlayTimeSec = objXML.getXMLValue(query)
							query =  "rawDataRow/plFfwCount"
							plFfwCount = objXML.getXMLValue(query)
							query =  "rawDataRow/plRewCount"
							plRewCount = objXML.getXMLValue(query)
							query =  "rawDataRow/plPauseCount"
							plPauseCount = objXML.getXMLValue(query)
							query =  "rawDataRow/plNotViewed"
							plNotViewed = objXML.getXMLValue(query)
							query =  "rawDataRow/breakNumber"
							breakNumber = objXML.getXMLValue(query)
							query =  "rawDataRow/slotPosition"
							slotPosition = objXML.getXMLValue(query)
							query =  "rawDataRow/adPid"
							adPid = objXML.getXMLValue(query)
							query =  "rawDataRow/adPaid"
							adPaid = objXML.getXMLValue(query)
							query =  "rawDataRow/adTitle"
							adTitle = objXML.getXMLValue(query)
							query =  "rawDataRow/impressionLimit"
							impressionLimit = objXML.getXMLValue(query)
							query =  "rawDataRow/adDuration"
							adDuration = objXML.getXMLValue(query)
							query =  "rawDataRow/regionId"
							regionId = objXML.getXMLValue(query)
							query =  "rawDataRow/regionName"
							regionName = objXML.getXMLValue(query)
							query =  "rawDataRow/regionGroupName"
							regionGroupName = objXML.getXMLValue(query)
							query =  "rawDataRow/campaignId"
							campaignId = objXML.getXMLValue(query)
							query =  "rawDataRow/campaignStartDate"
							campaignStartDate = objXML.getXMLValue(query)
							query =  "rawDataRow/campaignEndDate"
							campaignEndDate = objXML.getXMLValue(query)
							query =  "rawDataRow/elementNumber"
							elementNumber = objXML.getXMLValue(query)
							query =  "rawDataRow/campaignName"
							campaignName = objXML.getXMLValue(query)
							query =  "rawDataRow/clockNumber"
							clockNumber = objXML.getXMLValue(query)
							query =  "rawDataRow/campaignImpressionLimit"
							campaignImpressionLimit = objXML.getXMLValue(query)
							query =  "rawDataRow/clientId"
							clientId = objXML.getXMLValue(query)
							query =  "rawDataRow/clientName"
							clientName = objXML.getXMLValue(query)
							query =  "rawDataRow/progPid"
							progPid = objXML.getXMLValue(query)
							query =  "rawDataRow/progPaid"
							progPaid = objXML.getXMLValue(query)
							query =  "rawDataRow/channel"
							channel = objXML.getXMLValue(query)
							query =  "rawDataRow/progTitle"
							progTitle = objXML.getXMLValue(query)
							query =  "rawDataRow/progGenre"
							progGenre = objXML.getXMLValue(query)
							
							
							arr_bindId = Split(bindId,",")
							arr_viewDate = Split(viewDate,",")
							arr_deviceId = Split(deviceId,",")
							arr_plAssetType = Split(plAssetType,",")
							arr_plViewTypeUnknown = Split(plViewTypeUnknown,",")
							arr_plViewTypeFull = Split(plViewTypeFull,",")
							arr_plViewTypePartial = Split(plViewTypePartial,",")
							arr_plViewTypeFfw = Split(plViewTypeFfw,",")
							arr_plPlayTimeSec = Split(plPlayTimeSec,",")
							arr_plFfwCount = Split(plFfwCount,",")
							arr_plRewCount = Split(plRewCount,",")
							arr_plPauseCount = Split(plPauseCount,",")
							arr_plNotViewedl = Split(plNotViewed,",")
							arr_breakNumber = Split(breakNumber,",")
							arr_slotPosition = Split(slotPosition,",")
							arr_adPid = Split(adPid,",")
							arr_adPaid = Split(adPaid,",")
							arr_adTitle = Split(adTitle,",")
							arr_impressionLimit = Split(impressionLimit,",")
							arr_adDuration = Split(adDuration,",")
							arr_regionId = Split(regionId,",")
							arr_regionName = Split(regionName,",")
							arr_regionGroupName = Split(regionGroupName,",")
							arr_campaignId = Split(campaignId,",")
							arr_campaignStartDate = Split(campaignStartDate,",")
							arr_campaignEndDate = Split(campaignEndDate,",")
							arr_elementNumber = Split(elementNumber,",")
							arr_campaignName = Split(campaignName,",")
							arr_clockNumber = Split(clockNumber,",")
							arr_campaignImpressionLimit = Split(campaignImpressionLimit,",")
							arr_clientId = Split(clientId,",")
							arr_clientName = Split(clientName,",")
							arr_progPid = Split(progPid,",")
							arr_progPaid = Split(progPaid,",")
							arr_channel = Split(channel,",")
							arr_progTitle = Split(progTitle,",")
							arr_progGenrer = Split(progGenre,",")
							
				
							For ik=0 to ubound(arr_bindId)
								str=arr_bindId(ik) & "," & arr_viewDate(ik)& "," & arr_deviceId(ik) & "," & arr_plAssetType(ik)& "," & arr_plViewTypeUnknown(ik)& "," & arr_plViewTypeFull(ik)& "," & arr_plViewTypePartial(ik)& "," & arr_plViewTypeFfw(ik)& "," & arr_plPlayTimeSec(ik) & "," & arr_plFfwCount(ik)& "," & arr_plRewCount(ik)& "," & arr_plPauseCount(ik) & "," & arr_plNotViewedl(ik)& "," & arr_breakNumber(ik)& "," & arr_slotPosition(ik)& "," & arr_adPid(ik)& "," & arr_adPaid(ik)& "," & arr_adTitle(ik) & "," & arr_impressionLimit(ik)& "," & arr_adDuration(ik)& "," & arr_regionId(ik) & "," & arr_regionName(ik)& "," & arr_regionGroupName(ik)& "," & arr_campaignId(ik)& "," & arr_campaignStartDate(ik)& "," & arr_campaignEndDate(ik)& "," & arr_elementNumber(ik) & "," & arr_campaignName(ik)& "," & arr_clockNumber(ik)& "," & arr_campaignImpressionLimit(ik) & "," & arr_clientId(ik)& "," & arr_clientName(ik)& "," & arr_progPid(ik)& "," & arr_progPaid(ik)& "," & arr_channel(ik)& "," & arr_progTitle(ik) & "," & arr_progGenrer(ik)
								info "FROM XML====> " & str
								str1 = str1&";"&str
								str = ""
								strData =  mid(str1,"2")
							Next
							getreportRawDataData = strData	
							
					
						Case Else				
							failtest "Wrong option Selected"
					End Select
End Function





Class XMLClassProxy
	Private strXMLPath,XMLPath, strParseXMLData

	'Initialize the xml object
	Private Sub Class_Initialize
		Set FSO = CreateObject("Scripting.FileSystemObject")
		projectDir = getEnvironmentValueFor("PROJECT_DIR")
		XMLPath = projectDir & Environment.Value("XML_Path")
	End Sub
	
	' Setup Terminate event.
	'de-initialize the xml object
	Private Sub Class_Terminate
		Set FSO = CreateObject("Scripting.FileSystemObject")

		' Check if file exists to prevent error
		If FSO.FileExists(XMLPath) Then
			'FSO.DeleteFile XMLPath
		End If

		' Clean Up
		Set FSO = Nothing
	End Sub

	Public function getWSXML(strWebServiceURL)

			strOperation = "GET"
			
		
			wsHTTPReq.wsOpenConnection  strOperation, strWebServiceURL, False
            wsHTTPReq.wsSendRequest strOperation, 1
            strText = wsHTTPReq.wsGetResponseText

'			arrText = Split(strText,chr(10))
'			If Ubound(arrText) > 0 Then
'				If instr(1,arrText(1),"xmlns") > 0 Then
'	
'					pos = instr(1,arrText(1),"xmlns")
'					arrText(1) = Left(arrText(1),pos-1)   & ">"
'					
'				End If
'	
'				strText = Join(arrText,chr(10))
'			Else
'				strText = arrText(0)
'			End If

			sPos = instr(1,strText,"xmlns")
			If sPos > 0 Then
				ePos = instr(sPos,strText,">")
				strText = Left(strText, sPos-2) & Right(strText, len(strText)-ePos+1)
			End If
			'Remove ns2: before save to the file
			strText = Replace(strText,"ns2:","")

			Set FSO = CreateObject("Scripting.FileSystemObject")
			Set myFile = FSO.OpenTextFile(XMLPath, 2, True)   ' For Writing
			myFile.WriteLine strText
			Set myFile = Nothing

	End Function
	
	'parse the data in XML format
	Public Function parseDataIntoXML(strData)
		reportController.reportStep m_reportingName & ".parseDataIntoXML()" 
		Set FSO = CreateObject("Scripting.FileSystemObject")
		
		Set oFile = FSO.CreateTextFile(strXMLPath)
		oFile.Write strData
		'oFile.Save
		Set oFile= Nothing
		Set FSO=  Nothing
		
		strParseXMLData = True
		'parse the XML
		parseXML
		strParseXMLData = False
	End Function
	
	'parse XML
	Private Sub parseXML
		reportController.reportStep m_reportingName & ".parseXML()" 
		Set FSO = CreateObject("Scripting.FileSystemObject") ' For Reading
		'creating copy of XML
		FSO.CopyFile strXMLPath, XMLPath
		Set myFile = FSO.OpenTextFile(XMLPath, 1)
		allData = myFile.ReadAll : myFile.Close
		
		Set myFile = FSO.OpenTextFile(XMLPath, 2, True)   ' For Writing
		If instr(1,allData,"<key") > 0 Then
		
			arrData = Split(allData, "<key")
			myFile.WriteLine "<?xml version=""1.0"" encoding=""UTF-8""?><licenseContents>"
		
			For Ctr = 1 to UBound(arrData)
				If (UBound(arrData) <> Ctr) Then
					myFile.WriteLine "<key" & arrData(Ctr)		
				Else
					arrSubData = Split(arrData(Ctr), "</key>")
					myFile.WriteLine "<key" & arrSubData(0) & "</key>"
				End If
			Next
			myFile.WriteLine "</licenseContents>"
			myFile.Close
			info "XML Parsed"
		Else
			If moduleName = "Deployment" Then
				arrData = Split(allData, chr(10))
				If instr(1,arrData(0),"[") > 0 Then
					arrSubData = Split(arrData(0),"[") 
					arrData(0) = arrSubData(1)
				End If 
				If instr(1,arrData(ubound(arrData)),"]") > 0 Then
					arrSubData = Split(arrData(ubound(arrData)),"]") 
					arrData(ubound(arrData)) = arrSubData(0)
				End If
			End If
			For Ctr = 0 to UBound(arrData) 
				myFile.WriteLine arrData(Ctr)		
			Next
			myFile.Close
			info "XML Parsed"
		End If
		Set myFile = Nothing
		Set FSO = Nothing
	End Sub
	
	'get XML value for a node
	Public Function getXMLValue(query)
		reportController.reportStep m_reportingName & ".getXMLValue()" 
		OutputResponseXMLLocation = XMLPath 
		REM Err.Clear
		REM 'On Error Resume Next
		REM Set xmlDoc = DotNetFactory.CreateInstance("System.Xml.XPath.XPathDocument", , OutputResponseXMLLocation) 
		REM Set xmlNav = xmlDoc.CreateNavigator()
		REM set expr = xmlNav.Compile(query)
		REM set nodes = xmlNav.Select(expr)
		REM If Err.Number = 0 Then
			REM If IsObject(nodes.Count) Then
				REM nodeCount = Cint(nodes.Count.toString)
			REM Else
				REM nodeCount = Cint(nodes.Count)
			REM End If
			REM If nodeCount = 0 Then
				REM getXMLValue = "Null"
				REM Exit Function
			REM End If
			
			REM nodeVal = ""
			REM For iNode = 1 to nodeCount 
				REM nodes.MoveNext()
				REM nodeVal = nodeVal & ";"& nodes.Current.Value  ' Stores the current node value
				REM message = "Node Name is " & nodes.Current.Name & " and Node Value is " & nodes.Current.Value	
				REM print message
			REM Next
			
			REM getXMLValue = Mid(nodeVal,2,len(nodeVal) - 1)
			REM Set xmlDoc = Nothing
			REM Set xmlNav = Nothing
			REM Set expr = Nothing
			REM Set nodes = Nothing
			REM Err.Clear
		REM Else
			REM info "Error while reading Output Response XML"
			REM getXMLValue = "Null"
		REM End If
		REM On Error GoTo 0
		
		arr = Split(query,"/")

		strval = arr(0)

		Set objXMLDoc = CreateObject("Microsoft.XMLDOM") 
		objXMLDoc.async = False 
		objXMLDoc.load(OutputResponseXMLLocation) 
		
		Set NodeList = objXMLDoc.getElementsByTagName(strval) 
		
		If Nodelist.length = 0 Then
			getXMLValue = "Null"
			failtest "Node not found : "& query
			Exit Function
		End If
		
		str = ""
		For Each Elem In NodeList 
			
			If Elem.tagName = strval Then
				
				If instr(1,query,"/") > 0 Then
					Set ochild = Elem.childNodes
					blnFlag = False
					For each child in ochild
			
						If child.tagName = arr(1) Then
							str1 = child.text
							blnFlag = True
							Exit For
						Else
							blnFlag = False
						End If
			
					Next
					If blnFlag = False Then
						str1 = ""
					End If
				Else
					str1 = Elem.text
				End If
				If instr(1,str1,",") > 0 Then
						str1 = Replace(str1,",","COMAAA")
				End If
				str = str & "," & str1
			End If
		If Ubound(arr) > 0 Then
			  If arr(0) = arr(1) Then
				  Exit For
			  End If
		End If
		Next
		getXMLValue  = Right(str,len(str)-1)
	End Function


		Public Function getListXMLValue(query)
		reportController.reportStep m_reportingName & ".getListXMLValue()" 
		OutputResponseXMLLocation = XMLPath 
        
		If instr(1,query,"\\")  = 1 Then
			arr = Split(query,"/")
			strval = Replace(arr(0),"\\","")
			
			arrparam = split(strval,"[")
			strparam = arrparam(0)
		Else
			arr = Split(query,"/")
    		strval = arr(0)
			strparam = strval
		End If

		Set objXMLDoc = CreateObject("Microsoft.XMLDOM") 
		objXMLDoc.async = False 
		objXMLDoc.load(OutputResponseXMLLocation) 
		
		Set NodeList = objXMLDoc.getElementsByTagName(strval) 
		
		If Nodelist.length = 0 Then
			getListXMLValue = "Null"
			failtest "Node not found : "& query
			Exit Function
		End If

	
		str = ""
		For Each Elem In NodeList 
			
			If Elem.tagName = strparam Then
				
				If instr(1,query,"/") > 0  or instr(1,query,"\\")  = 1 Then

						If instr(1,query,"\\")  = 1 Then
							Set o1 = Elem.parentNode
							Set ochild = o1.childNodes
						Else
							Set ochild = Elem.childNodes
						End If

					
					blnFlag = False
					For each child in ochild
			
						If child.tagName = arr(1) Then
							str1 = child.text
							blnFlag = True

							If instr(1,str1,",") > 0 Then
								str1 = Replace(str1,",","COMAAA")
							End If
							str = str & "," & str1
						'	Exit For
						'Else
							'blnFlag = False
						End If
			
					Next
					If blnFlag = False Then
						str1 = ""
					End If
				Else
					str = Elem.text
				End If
				
			End If
		
		Next
		getListXMLValue  = Right(str,len(str)-1)
	End Function
	
	
End Class

Class webServiceRequest 
	
	Private oWinHttp,sContentType 
	Public sWebServiceRequest, sResponse, servicename, sHost 
	
	'Initialize the WinHttpRequest object and declares the content Type
	Private Sub Class_Initialize 
		'Info "Class_Initialize"
		Set oWinHttp = CreateObject("WinHttp.WinHttpRequest.5.1") 

		'oWinHttp.SetCredentials WS_SERVER_USERID, WS_SERVER_PSWD , WS_HTTPREQUEST_SETCREDENTIALS_FOR_SERVER
	
	End Sub 
	
	Public Sub wsSetCredentials (a, b , c) 
		Info "wsSetCredentials"
		oWinHttp.SetCredentials WS_SERVER_USERID, WS_SERVER_PSWD , WS_HTTPREQUEST_SETCREDENTIALS_FOR_SERVER
	End Sub 
	
	'Set webservice path
	Public Function wsWebServiceURL (servicename) 
		Info "wsWebServiceURL"
		wsWebServiceURL = WS_HTTP_SERVER_PATH & servicename 
	
	End Function
	
	Public Sub wsSetRequestHeader(strHeaderName, strHeaderVal)
		Info "wsSetRequestHeader"
		'Set XML Request Header 
		'oWinHttp.setRequestHeader "SOAPAction", sSOAPAction 
		'Setting request headers  
		oWinHttp.setRequestHeader strHeaderName, strHeaderVal
	End  Sub
  
	Public Sub wsOpenConnection (strOperation, strWebURL, strType)
		Info "wsOpenConnection"
		Info "strWebURL" & strWebURL
		
	
		'strWebServiceURL = "http://" + strWebURL + ":" + strWebPort + strType
		Select Case strOperation
			Case "GET"
				sWebServiceRequest = 1
			
		End Select 
			
		'Open HTTP connection  
		oWinHttp.Open strOperation,  strWebURL, False 
 
	End Sub
	
	Public Sub wsSendRequest (strOperation, sWebServiceRequest)
		Info "wsSendRequest"
		Select Case strOperation
			Case "GET"
				sWebServiceRequest = 1
			Case DELETE_OPERATION
				oWinHttp.Send
				Exit Sub
		End Select 
		
		'Send SOAP request 
		oWinHttp.Send  sWebServiceRequest 
  
	End Sub
  
	
	Public Function wsGetResponseText
		Info "wsGetResponseText"
		'Get XML Response 
		wsGetResponseText = oWinHttp.ResponseText 

	End  Function
	
	Public Function wsGetResponseHeader(strHeaderName, abc)
		Info "wsGetResponseHeader"
		'Get XML Response 
		wsGetResponseHeader = oWinHttp.GetResponseHeader("userId",abc)
	End  Function
	
	Public Function wsGetAllResponseHeaders
		'Get XML Response 
		wsGetAllResponseHeaders = oWinHttp.GetAllResponseHeaders
	End  Function
	
	
	
	Public Function wsClose 
		Set oWinHttp = Nothing 
	End Function 
	
End Class

