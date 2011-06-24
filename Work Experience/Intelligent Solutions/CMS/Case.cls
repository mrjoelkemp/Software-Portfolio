VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Case"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


Public Sub deleteCase(caseID As String)
'Purpose:   Called by frmMDI when user clicks the delete toolbar button
'           Deletes the case according to the passed in caseID
Dim w_SQL       As String
Dim w_Recordset As New Recordset
Dim confMsg     As Integer

    On Error GoTo errHandler
    
    confMsg = MsgBox("Please Confirm Delete Instruction", vbOKCancel, "Confirmation Dialog")
    
    If confMsg = 1 Then
    
        'Create query to delete case information according to id
        w_SQL = "Delete * From cases Where caseid=" & Chr(34) & caseID & Chr(34) & ";"
    
        With w_Recordset
            'Execute the query
            .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            
            If .State = 1 Then
                .Close
            End If
            
            'Create query to delete notes according to id
            w_SQL = "Delete * from notes where itemid =" & Chr(34) & g_CaseID & Chr(34) & ";"

            'Execute the query
            .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            
            If .State = 1 Then
                .Close
            End If
            
            'Create query to delete documents according to id
            w_SQL = "Delete * from documents where caseid =" & Chr(34) & g_CaseID & Chr(34) & ";"

            'Execute the query
            .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            
            If .State = 1 Then
                .Close
            End If

        End With
        
        'Show success
        MsgBox "File Information Deleted Successfully", vbOKOnly, "Deletion Confirmation"
        'Write a log in the system
        system_db.write_systemLog g_SystemDelete, dbModuleCase, g_CaseID
        
    End If

    Exit Sub

errHandler:
MsgBox "Error In Deleting File", vbCritical, "Error"
    
End Sub
