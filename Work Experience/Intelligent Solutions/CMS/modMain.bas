Attribute VB_Name = "modMain"
Option Explicit

Public Declare Function ShellExecute _
    Lib "shell32.dll" Alias "ShellExecuteA" ( _
    ByVal hwnd As Long, _
    ByVal lpOperation As String, _
    ByVal lpFile As String, _
    ByVal lpParameters As String, _
    ByVal lpDirectory As String, _
    ByVal nShowCmd As Long) As Long
    
'Instantiate the system Database class
Public system_db As New DB

'Global DB Action Constants
Public Const g_SystemNew = "NEW"
Public Const g_SystemModify = "MODIFY"
Public Const g_SystemDelete = "DELETE"
Public Const g_SystemView = "VIEW"
Public Const g_SystemBackup = "BACKUP"
Public Const g_SystemRestore = "RESTORE"

'System access right types
Public Const p_Yes = "Yes"
Public Const p_No = "No"
Public Const p_All = "All"
Public Const p_View = "View"
Public Const p_Add = "Add"
Public Const p_Modify = "Modify"
Public Const p_Delete = "Delete"
Public Const p_ViewAdd = "VA"
Public Const p_ViewAddModify = "VAM"

'Global System Attributes

Public g_CurrentUser        As String
Public g_CurrentUserLevel   As String

'User's Module Permissions
Public g_PermAttorney   As String
Public g_PermClient     As String
Public g_PermJudge      As String
Public g_PermCase       As String
Public g_PermAudit      As String
Public g_PermSysParam   As String
Public g_PermUser       As String
Public g_PermBackup     As String
Public g_PermRestore    As String

'Global Module Modes
Public g_AttorneyMode   As String
Public g_ClientMode     As String
Public g_CaseMode       As String
Public g_JudgeMode      As String
Public g_ReportMode     As String
Public g_CaseViewMode   As String
Public g_ButtonMode     As String
Public g_NoteMode       As String
Public g_ReminderMode   As String
Public g_DocumentMode   As String

'Global Client Counter
Public g_ClientCounter  As String

'Global Module IDs
Public g_AttorneyID     As String
Public g_ClientID       As String
Public g_JudgeID        As String
Public g_CaseID         As String
Public g_NoteID         As String
Public g_UserID         As String
Public g_DocumentID     As String

Public g_CurrentScreen              As String
Public g_NoteCallingModule          As String
Public g_CaseCallingModule          As String


'Global Flags to indicate change to forms
Public attorneyChange   As Boolean
Public clientChange     As Boolean
Public judgeChange      As Boolean
Public caseChange       As Boolean
Public noteChange       As Boolean
Public documentChange   As Boolean

'Database elements masked as variables for easier system identification
Public Const dbModuleAttorney = "Attorneys"
Public Const dbModuleClient = "Clients"
Public Const dbModuleJudge = "Judges"
Public Const dbModuleCase = "Cases"
Public Const dbModuleReport = "Reports"
Public Const dbModuleOption = "Options"
Public Const dbModuleDocument = "Documents"
Public Const dbModuleNote = "Notes"
Public Const dbModuleBackup = "Backup"
Public Const dbModuleRestore = "Restore"
Public Const dbModuleUser = "Users"
Public Const dbModuleAudit = "Audit"



Public Sub Main()
    frmSplash.Show
    
''''''''''''''''''''''''''''''''
    'DEBUGGING PURPOSES
    g_CurrentUser = "Youngs Law"
    
''''''''''''''''''''''''''''''''
    
End Sub

Public Sub load_GlobalUserPermissions(username As String)
'Purpose: Load user's (given by userName) permissions into global vars.
Dim w_SQL           As String
Dim w_Recordset     As New Recordset
    
    'Select Query -- Grab all user permissions from DB
    w_SQL = "Select * FROM accessrights WHERE userid = '" & username & "'"
    
    'On Error GoTo errHandler

    With w_Recordset
        
        'Execute Query
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly

        'Store Permissions (descriptions) into global vars
        g_PermAttorney = getPermission(!attorneys)
        g_PermClient = getPermission(!clients)
        g_PermJudge = getPermission(!judges)
        g_PermCase = getPermission(!cases)
        g_PermAudit = getPermission(!auditcontrols)
        g_PermUser = getPermission(!usermanagement)
        g_PermSysParam = getPermission(!systemparameters)
        g_PermBackup = getPermission(!databackup)
        g_PermRestore = getPermission(!datarestore)

        If .State = 1 Then
            .Close
        End If
        
    End With
    
    Exit Sub

errHandler:
    MsgBox "Permissions Not Loaded", vbCritical, "DB Error"

End Sub

Public Sub load_NewGlobalClientCounter()
'Purpose: Load the new ClientCounter/ClientID into a global var
Dim w_SQL       As String
Dim w_Recordset As New Recordset
Dim w_counter   As String
Dim w_ID        As String

    On Error GoTo errHandler
    
    w_SQL = "Select max(clientid) as maxID from clients"
    
    With w_Recordset
        'Execute Query
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        'If there is no current max Client ID
        If IsNull(!maxID) Then
            'The counter is 'CL1'
            g_ClientCounter = "CL" & "1"
            
        Else
            'Store the maxid
            w_ID = !maxID
            'Extract the numerical part of the sequence
            w_counter = Right$(w_ID, Len(w_ID) - InStrRev(w_ID, "L"))
            
            'The counter is 'CL___'
            g_ClientCounter = "CL" & CStr(Val(w_counter) + 1)
        End If
        
        If .State = 1 Then
            .Close
        End If
    End With
    
    Exit Sub

errHandler:
    MsgBox "ClientCounter Error", vbCritical, "ClientID Error"

End Sub

Function getPermission(permissionCode As String) As String
'Purpose: Return Permission description from passed in permissionCode
'Parameters: PermissionCode- values (0-9)
Dim w_SQL           As String
Dim w_Recordset     As New Recordset

    w_SQL = "Select Description from accessrightstypes where typecode = " & permissionCode
    
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            
        'Return permission description
        getPermission = !Description
            
        If .State = 1 Then
            .Close
        End If
        
    End With

End Function

Function isRightScreenToHide(selfScreen)
'Purpose: Used to hide the correct screen.
'Rules: You cannot hide the main menu
'       You cannot hide yourself if you are the currentScreen
    
    If g_CurrentScreen <> "frmMainMenu" And g_CurrentScreen <> selfScreen Then
        'Hide the current screen
        hideScreen
    End If
    
End Function

Function hideScreen()
        Select Case g_CurrentScreen
            'Activate hide method of current screen
            Case "frmAttorneyNew"
                frmAttorneyNew.Hide
            Case "frmAttorneySearch"
                frmAttorneySearch.Hide
            Case "frmClientNew"
                frmClientNew.Hide
            Case "frmClientSearch"
                frmClientSearch.Hide
            Case "frmCaseNew"
                frmCaseNew.Hide
            Case "frmCaseSearch"
                frmCaseSearch.Hide
            Case "frmCases"
                frmCases.Hide
            Case "frmJudgesNew"
                frmJudgesNew.Hide
            Case "frmJudgesSearch"
                frmJudgesSearch.Hide
            Case "frmNotes"
                frmNotes.Hide
            Case "frmReports"
                frmReports.Hide
            Case "frmDocuments"
                frmDocuments.Hide
            Case "frmDocumentSearch2"
                frmDocumentSearch2.Hide
        End Select

End Function

Function hideScreenWithConfirm()
'Purpose: Hide the current screen if user confirms the close. Returns boolean for use in frmMDI.
'Notes: If called before the g_CurrentScreen is set, it will hide the previously opened form.
'       IsConfirmed is called in creation modules where pressing Go Back will erase your current work

        Select Case g_CurrentScreen
            'Activate hide method of current screen
            Case "frmAttorneyNew"
                'If user is Adding or Modifying Attorney, ask for confirmation to leave
                'Also check if any changes were made to the form, if true, then show confirm.
                If g_AttorneyMode <> "VIEW" And g_AttorneyMode <> "DELETE" And attorneyChange Then
                
                    If isConfirmed Then
                        frmAttorneyNew.clear_Fields
                        frmAttorneyNew.Hide
                        hideScreenWithConfirm = True
                    Else
                        hideScreenWithConfirm = False
                    End If
                'Otherwise
                Else
                    'Skip confirmation and just hide the screen
                    hideScreenWithConfirm = True
                    frmAttorneyNew.Hide
                End If
                            
            Case "frmClientNew"
                If g_ClientMode <> "VIEW" And g_ClientMode <> "DELETE" And clientChange Then
                
                    If isConfirmed Then
                        frmClientNew.clear_Fields
                        frmClientNew.Hide
                        hideScreenWithConfirm = True
                    Else
                        hideScreenWithConfirm = False
                    End If
                Else
                    hideScreenWithConfirm = True
                    frmClientNew.Hide
                End If
                
            Case "frmCaseNew"
                If g_CaseMode <> "VIEW" And g_CaseMode <> "DELETE" And caseChange Then
                
                    If isConfirmed Then
                        frmCaseNew.clear_Fields
                        frmCaseNew.Hide
                        hideScreenWithConfirm = True
                    Else
                        hideScreenWithConfirm = False
                    End If
                 Else
                    hideScreenWithConfirm = True
                    frmCaseNew.Hide
                End If
                
            Case "frmJudgesNew"
                If g_JudgeMode <> "VIEW" And g_JudgeMode <> "DELETE" And judgeChange Then

                    If isConfirmed Then
                        frmJudgesNew.clear_Fields
                        frmJudgesNew.Hide
                        hideScreenWithConfirm = True
                    Else
                        hideScreenWithConfirm = False
                    End If
                Else
                    hideScreenWithConfirm = True
                    frmJudgesNew.Hide
                End If
                
            Case "frmNotes"
                If g_NoteMode <> "VIEW" And g_NoteMode <> "DELETE" And noteChange Then
            
                    If isConfirmed Then
                        frmNotes.clear_Fields
                        frmNotes.Hide
                        hideScreenWithConfirm = True
                    Else
                        hideScreenWithConfirm = False
                    End If
                Else
                    hideScreenWithConfirm = True
                    frmNotes.Hide
                End If
            
            Case "frmAttorneySearch"
                frmAttorneySearch.Hide
                'Set equal to true to simulate that user selected to leave.
                'Used to show previous screen in frmMDI
                hideScreenWithConfirm = True
                
            Case "frmReports"
                frmReports.Hide
                hideScreenWithConfirm = True
                
            Case "frmDocuments"
                frmDocuments.clear_Fields
                frmDocuments.Hide
                hideScreenWithConfirm = True
                    
            Case "frmJudgesSearch"
                frmJudgesSearch.Hide
                hideScreenWithConfirm = True
                
            Case "frmDocumentSearch2"
                frmDocumentSearch2.Hide
                hideScreenWithConfirm = True
                
            Case "frmCaseSearch"
                frmCaseSearch.Hide
                hideScreenWithConfirm = True
                
            Case "frmCases"
                frmCases.Hide
                hideScreenWithConfirm = True
                
            Case "frmClientSearch"
                frmClientSearch.Hide
                hideScreenWithConfirm = True
                
            
        End Select

End Function

Function isConfirmed()
'Purpose: Show a Confirmation Dialog.
Dim confMsg As Integer

    confMsg = MsgBox("Data has not been saved." & vbCr & "Changes will be lost.", vbOKCancel Or vbExclamation, "Confirmation Dialog")
    
    If confMsg = 1 Then
        isConfirmed = True
    Else
        isConfirmed = False
    End If
End Function

Function showSelectScreen()
'Function: Used for forms that need to go back to previous form when finished

    Select Case g_CurrentScreen
        Case "frmAttorneyNew"
            'If user was modifying details or about to delete, then leave
            'mode the same so search form shows modify or delete capabilities.
            'i.e. the only time you want to change the mode back to view,
            'is when you are coming from "NEW"
            If g_AttorneyMode = g_SystemNew Then
                g_AttorneyMode = "VIEW"
            End If
            'Restore search screen
            frmAttorneySearch.Show
    
            
        Case "frmClientNew"
            If g_ClientMode = g_SystemNew Then
                g_ClientMode = "VIEW"
            End If
            frmClientSearch.Show
            
        Case "frmJudgesNew"
            If g_JudgeMode = g_SystemNew Then
                g_JudgeMode = "VIEW"
            End If
            frmJudgesSearch.Show
            
        Case "frmCaseNew"
            If g_CaseMode <> vbNullString Then
                If g_CaseMode = g_SystemNew Then
                    g_CaseMode = "VIEW"
                End If
                frmCaseSearch.Show
            End If
            
            'If user was working in Attorney or Client Module
            'and clicked Case New, return them on Go Back
            If g_CaseCallingModule = "frmAttorneyNew" Then
                frmAttorneyNew.Show
            ElseIf g_CaseCallingModule = "frmClientNew" Then
                frmClientNew.Show
            ElseIf g_CaseCallingModule = "frmCases" Then
                frmCases.Show
            End If
            
        Case "frmCases"
            Select Case g_CaseViewMode
                Case "ATTORNEY"
                    frmAttorneyNew.Show
                
                Case "CLIENT"
                    frmClientNew.Show
                
                Case "JUDGE"
                    frmJudgesNew.Show
            End Select

        Case "frmDocuments"
            frmCaseNew.Show
        
        Case "frmDocumentSearch2"
            frmDocuments.Show
        
        Case "frmNotes"
            Select Case g_NoteCallingModule
                Case "frmAttorneyNew"
                    frmAttorneyNew.Show
                Case "frmClientNew"
                    frmClientNew.Show
                Case "frmJudgesNew"
                    frmJudgesNew.Show
                Case "frmCaseNew"
                    frmCaseNew.Show
            End Select
    End Select
End Function

Public Sub setCurrentScreen(currScreen)
'Purpose: Used to activate the save mechanism of a particular screen from the toolbar
    g_CurrentScreen = currScreen
End Sub

