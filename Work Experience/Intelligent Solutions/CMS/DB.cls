VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "DB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public Sub write_systemLog(actionType As String, moduleName As String, moduleItemID As String)
'Purpose: Create a log entry in the Log table of DB.
    'ActionType refers to NEW, MODIFY, or DELETE
    'ModuleName refers to ATTORNEYS, CLIENTS, JUDGES, CASES, DOCUMENTS, NOTES, OPTIONS, REPORTS
    'ModuleItemID refers to the id of the object acted on (Attorney, Client, Judge, etc)
Dim w_Recordset     As New Recordset
Dim w_SQL           As String
Dim w_Timestamp     As String
Dim actionTypeCode  As String
Dim moduleNameCode  As String
Dim maxID           As String

    On Error GoTo errHandler
    
    w_Timestamp = Format(Now, "mm/dd/yyyy hh:mm am/pm")
    actionTypeCode = getCode("ACTIONTYPE", actionType)
    moduleNameCode = getCode("MODULE", moduleName)
    maxID = getMaxLogID
    
    w_SQL = "Insert into logs values ('" & _
        maxID & "', '" & _
        g_CurrentUser & "', '" & _
        w_Timestamp & "', '" & _
        actionTypeCode & "', '" & _
        moduleNameCode & "', '" & _
        moduleItemID & "')"
        
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        If .State = 1 Then
            .Close
        End If
    End With
    
    Exit Sub

errHandler:
Dim errorMsg As Integer
    errorMsg = MsgBox("Log Not Entered", vbExclamation, "Log Error")

End Sub

Function getCode(codeType As String, codeDescription As String)
'Purpose: Get the code for the corresponding description
        'CodeType refers to ActionType or Module
        'Description refers to an element in either codeType table
Dim w_SQL       As String
Dim w_Recordset As New Recordset
    
    On Error GoTo errHandler
    
    Select Case codeType
        Case "ACTIONTYPE"
            w_SQL = "Select actiontypecode from actiontypes where description = '" & codeDescription & "'"
        Case "MODULE"
            w_SQL = "Select modulecode from modules where description = '" & codeDescription & "'"
    End Select
    
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        Select Case codeType
            Case "ACTIONTYPE"
                getCode = !actionTypeCode
            Case "MODULE"
                getCode = !modulecode
        End Select
        If .State = 1 Then
            .Close
        End If
    End With
    Exit Function
    
errHandler:
Dim errorMsg As Integer
    errorMsg = MsgBox("Code Not Found", vbExclamation, "GetCode Error")
End Function

Function getMaxLogID()
'Purpose: Get maximum logID from log table in DB
Dim w_Recordset As New Recordset
Dim w_SQL       As String

    On Error GoTo errHandler
    
    w_SQL = "Select max(logid) as maxlogid from logs"
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly

        If IsNull(!maxlogid) Then
            getMaxLogID = 1
        Else
            getMaxLogID = !maxlogid + 1
        End If
        
        If .State = 1 Then
            .Close
        End If
    End With
    Exit Function
    
errHandler:
Dim errorMsg As Integer
    errorMsg = MsgBox("Log ID not found", vbExclamation, "Log Error")

End Function

