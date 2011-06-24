VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.MDIForm frmMDI 
   BackColor       =   &H8000000C&
   Caption         =   "IS Case Management System -- Young's Law Firm"
   ClientHeight    =   8190
   ClientLeft      =   285
   ClientTop       =   -2670
   ClientWidth     =   11685
   Icon            =   "MDIForm1.frx":0000
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   0
      Top             =   7815
      Width           =   11685
      _ExtentX        =   20611
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   5
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Text            =   "Ready..."
            TextSave        =   "Ready..."
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   4057
            MinWidth        =   4057
            Text            =   "Main Menu"
            TextSave        =   "Main Menu"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   3528
            MinWidth        =   3528
            Text            =   "User Logged"
            TextSave        =   "User Logged"
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            TextSave        =   "10/20/2006"
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            TextSave        =   "12:36 AM"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar ToolbarMain 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   11685
      _ExtentX        =   20611
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   20
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Save Record"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Go Back"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Exit Application"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Attorneys"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Clients"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Judges"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cases"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Print Report"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "View"
            Style           =   3
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Add"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Modify"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Delete"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button15 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button16 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Case Listing"
            Style           =   3
         EndProperty
         BeginProperty Button17 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Attorney File Listing"
            Style           =   3
         EndProperty
         BeginProperty Button18 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Client File Listing"
            Style           =   3
         EndProperty
         BeginProperty Button19 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button20 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Get Balance -- Quickbooks"
            ImageIndex      =   15
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   1320
      Top             =   2760
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   15
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":0ECA
            Key             =   "attorney"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":17A4
            Key             =   "client"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":1ABE
            Key             =   "judge"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":2398
            Key             =   "case"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":26B2
            Key             =   "print"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":29CC
            Key             =   "add"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":32A6
            Key             =   "modify"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":35C0
            Key             =   "delete"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":38DA
            Key             =   "save"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":3BF4
            Key             =   "return"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":44CE
            Key             =   "exit"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":4DA8
            Key             =   "casefiles"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":5682
            Key             =   "notes"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":5F5C
            Key             =   "documents"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":6276
            Key             =   "quickbooks"
         EndProperty
      EndProperty
   End
   Begin VB.Menu mnuFile 
      Caption         =   "File"
      Begin VB.Menu mnuLogout 
         Caption         =   "Logout"
         Shortcut        =   ^L
      End
      Begin VB.Menu mnuExit 
         Caption         =   "Exit CMS"
      End
   End
   Begin VB.Menu mnuAMenu 
      Caption         =   "Attorneys"
      Begin VB.Menu mnuViewA 
         Caption         =   "View Attorney Details"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuASlash1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAddA 
         Caption         =   "Add an Attorney"
         Shortcut        =   ^A
      End
      Begin VB.Menu mnuModifyA 
         Caption         =   "Modify Existing Attorney Details "
      End
      Begin VB.Menu mnuDeleteA 
         Caption         =   "Delete an Attorney "
      End
   End
   Begin VB.Menu mnuCMenu 
      Caption         =   "Clients"
      Begin VB.Menu mnuViewC 
         Caption         =   "View Client Details"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuCSlash1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAddC 
         Caption         =   "Add a Client"
      End
      Begin VB.Menu mnuModifyC 
         Caption         =   "Modify Existing Client Details"
      End
      Begin VB.Menu mnuDeleteC 
         Caption         =   "Delete a Client"
      End
   End
   Begin VB.Menu mnuJMenu 
      Caption         =   "Judges"
      Begin VB.Menu mnuViewJ 
         Caption         =   "View Judge Details"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuJSlash1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAddJ 
         Caption         =   "Add a Judge"
      End
      Begin VB.Menu mnuModifyJ 
         Caption         =   "Modify Existing Judge Details "
      End
      Begin VB.Menu mnuDeleteJ 
         Caption         =   "Delete a Judge "
      End
   End
   Begin VB.Menu mnuFMenu 
      Caption         =   "Cases"
      Begin VB.Menu mnuViewF 
         Caption         =   "View Case Details"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFSlash1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAddF 
         Caption         =   "Add a Case"
      End
      Begin VB.Menu mnuModifyF 
         Caption         =   "Modify Existing Case Details"
      End
      Begin VB.Menu mnuDeleteF 
         Caption         =   "Delete a Case "
      End
   End
   Begin VB.Menu mnuRMenu 
      Caption         =   "Reports"
      Begin VB.Menu mnuReportF 
         Caption         =   "Cases"
      End
      Begin VB.Menu mnuReportAF 
         Caption         =   "Attorney Case  Listing"
      End
      Begin VB.Menu mnuReportCF 
         Caption         =   "Client Case Listing "
      End
      Begin VB.Menu mnuSysLog 
         Caption         =   "System Log"
      End
   End
   Begin VB.Menu mnuRemindersMenu 
      Caption         =   "Reminders"
      Begin VB.Menu mnuTodayReminder 
         Caption         =   "Today's Reminders"
         Shortcut        =   ^T
      End
      Begin VB.Menu mnuAllReminders 
         Caption         =   "All Reminders"
      End
   End
   Begin VB.Menu mnuCoMenu 
      Caption         =   "System Administration"
      Begin VB.Menu mnuImport 
         Caption         =   "Import Clients"
      End
      Begin VB.Menu mnuBackup 
         Caption         =   "Data Backup"
      End
      Begin VB.Menu mnuRestore 
         Caption         =   "Data Restore"
      End
      Begin VB.Menu mnuOptions 
         Caption         =   "Parameters"
      End
      Begin VB.Menu mnuUsers 
         Caption         =   "Users"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "Help "
      Begin VB.Menu mnuAbout 
         Caption         =   "About "
      End
      Begin VB.Menu mnuIndex 
         Caption         =   "Contents and Index "
         Shortcut        =   {F1}
      End
   End
End
Attribute VB_Name = "frmMDI"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public SQLConnect As New Connection

'Button Index Constants
Const btnSave = 1
Const btnGoBack = 2
Const btnExit = 3
Const btnAttorney = 5
Const btnClient = 6
Const btnJudge = 7
Const btnCase = 8
Const btnPrint = 10
Const btnAdd = 12
Const btnModify = 13
Const btnDelete = 14
Const btnQuickbooks = 20



Private Sub MDIForm_Load()
    
    'Set Dimensions so that scrollbars only appear when dimensions change.
    
    Me.Height = 9989
    Me.Width = 11800
    
    'Disable select toolbar buttons
    resetToolbar
    
    'Connect to DB
    OpenConnection
    
    'Load the new ClientCounter -- used in creating new clients
    load_NewGlobalClientCounter
    
    'Lock down all features
'    systemLockdown
    'Load user permissions
'    load_GlobalUserPermissions (g_CurrentUser)
    'Grant system access based on permissions
'   grantSystemPermissions

    
End Sub

Private Sub OpenConnection()
Dim w_Ini As New ReadIni
Dim w_Connection As New Connection
Dim w_Location As String
Dim w_Dbase As String

    w_Location = CurDir & "\SEGFILE.INI"
    w_Dbase = w_Ini.GetKey(w_Location, "SETUP", "Database", False)

    Set w_Connection = SQLConnect
    w_Connection.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & w_Dbase & ";"
    
End Sub

Private Sub MDIForm_Resize()
    On Error Resume Next
    ActiveForm.Height = Me.Height
    ActiveForm.Width = Me.Width
End Sub


Private Sub mnuAbout_Click()
    frmAbout.Show
End Sub

Private Sub mnuAllReminders_Click()
    g_ReminderMode = "ALL"
    frmReminders.Show
End Sub

Private Sub mnuBackup_Click()
    frmDataBackup.Show
End Sub

Private Sub mnuImport_Click()
    frmImport.Show
End Sub

Private Sub mnuIndex_Click()
    frmHelp.Show
End Sub

Private Sub mnuLogout_Click()
    frmMainMenu.Hide
    frmLogin2.Show
End Sub

Private Sub mnuOptions_Click()
    frmOptions.Show
End Sub

Private Sub mnuExit_Click()
    End
End Sub


Private Sub mnuReportAF_Click()
    g_ReportMode = "ATTORNEY"
    frmReports.Show
End Sub

Private Sub mnuReportCF_Click()
    g_ReportMode = "CLIENT"
    frmReports.Show
End Sub

Private Sub mnuReportF_Click()
    g_ReportMode = "FILE"
    frmReports.Show
End Sub


Private Sub mnuAddA_Click()
    g_AttorneyMode = "NEW"
    g_ButtonMode = "ATTORNEYS"
    frmAttorneyNew.clear_Fields
    hideShowModuleIfShowing frmAttorneyNew
End Sub

Private Sub mnuAddC_Click()
    g_ClientMode = "NEW"
    g_ButtonMode = "CLIENTS"
    frmClientNew.clear_Fields
    hideShowModuleIfShowing frmClientNew
End Sub

Private Sub mnuAddF_Click()
    g_CaseMode = "NEW"
    g_ButtonMode = "CASES"
    frmCaseNew.clear_Fields
    hideShowModuleIfShowing frmCaseNew
End Sub

Private Sub mnuAddJ_Click()
    g_JudgeMode = "NEW"
    g_ButtonMode = "JUDGES"
    frmJudgesNew.clear_Fields
    hideShowModuleIfShowing frmJudgesNew
End Sub


Private Sub mnuDeleteA_Click()
    g_AttorneyMode = "DELETE"
    g_ButtonMode = "ATTORNEYS"
    'Reload the current form
    hideShowModuleIfShowing frmAttorneySearch
End Sub

Private Sub mnuDeleteC_Click()
    g_ClientMode = "DELETE"
    g_ButtonMode = "CLIENTS"
    'Reload the current form
    hideShowModuleIfShowing frmClientSearch
End Sub

Private Sub mnuDeleteF_Click()
    g_CaseMode = "DELETE"
    g_ButtonMode = "CASES"
    hideShowModuleIfShowing frmCaseSearch
End Sub

Private Sub mnuDeleteJ_Click()
    g_JudgeMode = "DELETE"
    g_ButtonMode = "JUDGES"
    hideShowModuleIfShowing frmJudgesSearch
End Sub


Private Sub mnuModifyA_Click()
    g_AttorneyMode = "MODIFY"
    hideShowModuleIfShowing frmAttorneySearch
End Sub

Private Sub mnuModifyC_Click()
    g_ClientMode = "MODIFY"
    hideShowModuleIfShowing frmClientSearch
End Sub

Private Sub mnuModifyF_Click()
    g_CaseMode = "MODIFY"
    hideShowModuleIfShowing frmCaseSearch
End Sub

Private Sub mnuModifyJ_Click()
    g_JudgeMode = "MODIFY"
    hideShowModuleIfShowing frmJudgesSearch
End Sub


Private Sub mnuRestore_Click()
    frmDataRestore.Show
End Sub

Private Sub mnuTodayReminder_Click()
    g_ReminderMode = "TODAY"
    frmReminders.Show
End Sub

Private Sub mnuUsers_Click()
    frmUsers.Show
End Sub

Public Sub mnuViewA_Click()
    g_AttorneyMode = "VIEW"
    frmAttorneySearch.Show
End Sub

Public Sub mnuViewC_Click()
    g_ClientMode = "VIEW"
    frmClientSearch.Show
End Sub

Public Sub mnuViewF_Click()
    g_CaseMode = "VIEW"
    g_CaseCallingModule = vbNullString
    frmCaseSearch.Show
End Sub

Public Sub mnuViewJ_Click()
    g_JudgeMode = "VIEW"
    frmJudgesSearch.Show
End Sub

Function hideShowModuleIfShowing(ByRef moduleName As Form)
'Purpose: Hide then Show the module if it is already visible,
'           so changes will take effect.

    'If user wants a functionality that uses the current screen
    If g_CurrentScreen = moduleName.Name Then
        'Hide the current screen
        moduleName.Hide
        'Clear its contents
        moduleName.clear_Fields
        'Re-show as new form
        moduleName.Show
    
    'If functionality does not use current screen
    Else
        'Show the respective screen
        moduleName.Show
    End If
    
End Function

Private Sub ToolbarMain_ButtonClick(ByVal Button As MSComctlLib.Button)
'Purpose: Define the actions for each toolbar button

    With Button
        Select Case .Index
        
            '''''Actions'''''
            
            'Save Record
            Case btnSave
                If isConfirmed("Save") Then
                    'If action is confirmed, then carry out save
                    Select Case g_CurrentScreen
                        'Activate save method of current screen
                        Case "frmAttorneyNew"
                            frmAttorneyNew.write_DB
                        Case "frmClientNew"
                            frmClientNew.write_DB
                        Case "frmCaseNew"
                            frmCaseNew.write_DB
                        Case "frmJudgesNew"
                            frmJudgesNew.write_DB
                        Case "frmNotes"
                            frmNotes.write_DB
                        Case "frmDocuments"
                            frmDocuments.write_DB
                    End Select
                Else
                    frmMDI.showModuleButtons
                End If

            'Go Back
            Case btnGoBack
                'Hide Appropriate Screen if confirmed
                If hideScreenWithConfirm = True Then
                    'Show form when returning to Search Modules
                    showSelectScreen
                End If
            
            'Exit
            Case btnExit
                End
                
            '''''Modules'''''
            
            'Attorney
            Case btnAttorney
                g_ButtonMode = "ATTORNEYS"
                makeModuleActionButtonsVisible
                mnuViewA_Click
            'Client
            Case btnClient
                g_ButtonMode = "CLIENTS"
                makeModuleActionButtonsVisible
                mnuViewC_Click
            'Judges
            Case btnJudge
                g_ButtonMode = "JUDGES"
                makeModuleActionButtonsVisible
                mnuViewJ_Click
            'Cases
            Case btnCase
                g_ButtonMode = "CASES"
                makeModuleActionButtonsVisible
                mnuViewF_Click
               
            '''''Module Actions'''''
            
            'Print
            Case btnPrint
            
            'Add
            Case btnAdd
                Select Case g_ButtonMode
                    Case "ATTORNEYS"
                        mnuAddA_Click
                    Case "CLIENTS"
                        mnuAddC_Click
                    Case "JUDGES"
                        mnuAddJ_Click
                    Case "CASES"
                        mnuAddF_Click
                    Case "NOTES"
                        addNote
                    Case "DOCUMENTS"
                        addDocument
                End Select
            'Modify
            Case btnModify
                Select Case g_ButtonMode
                    Case "ATTORNEYS"
                        mnuModifyA_Click
                    Case "CLIENTS"
                        mnuModifyC_Click
                    Case "JUDGES"
                        mnuModifyJ_Click
                    Case "CASES"
                        mnuModifyF_Click
                    Case "NOTES"
                        modifyNote
                    Case "DOCUMENTS"
                        modifyDocument
                End Select
            'Delete
            Case btnDelete
                Select Case g_ButtonMode
                    Case "ATTORNEYS"
                        'Get the id from the selected list entry and make it available
                        g_AttorneyID = frmAttorneySearch.sLblista.TextMatrix(frmAttorneySearch.sLblista.Row, 0)
                        'Make call to function in AttorneyNew that will delete attorney
                        frmAttorneyNew.deleteAttorney
                        'Refresh list of attorneys
                        frmAttorneySearch.executeSearch
                    
                    Case "CLIENTS"
                        'Get the id from the selected list entry and make it available
                        g_ClientID = frmClientSearch.sLblista.TextMatrix(frmClientSearch.sLblista.Row, 0)
                        'Make call to function in ClientNew that will delete Client
                        frmClientNew.deleteClient
                        'Refresh list of clients
                        frmClientSearch.executeSearch
                    
                    Case "JUDGES"
                        g_JudgeID = frmJudgesSearch.sLblista.TextMatrix(frmJudgesSearch.sLblista.Row, 0)
                        frmJudgesNew.deleteJudge
                        'Refresh list of judges
                        frmJudgesSearch.executeSearch
                        
                    Case "CASES"
                        g_CaseID = frmCaseSearch.sLblista.TextMatrix(frmCaseSearch.sLblista.Row, 0)
                        
                        If isConfirmed("Delete") Then
                            frmCaseNew.deleteCase (g_CaseID)
                            frmCaseSearch.executeSearch
                        End If
                    
                    Case "NOTES"
                        frmNotes.deleteNote
                        
                    Case "DOCUMENTS"
                        frmDocuments.deleteDocument
                            
                End Select
            
            '''''Quickbooks Financial Balance'''''
            
            'Get Balance
            Case btnQuickbooks
            
        End Select
    End With
End Sub

Private Sub addDocument()
'Purpose: Prepare frmDocuments for add capabilities.

    g_DocumentMode = "NEW"
    frmDocuments.clear_Fields
    'Refresh the screen
    hideShowModuleIfShowing frmDocuments

End Sub

Private Sub modifyDocument()

    g_DocumentMode = "MODIFY"
    hideShowModuleIfShowing frmDocuments
    
End Sub

Private Sub removeDocument()

    g_DocumentMode = "DELETE"
    hideShowModuleIfShowing frmDocuments

End Sub

Private Sub addNote()
'Purpose: Set up frmNotes for add capabilities.

    'Set note mode to add
    g_NoteMode = "NEW"
    frmNotes.clear_Fields
    
    'Hide then show module so new mode can take effect.
    hideShowModuleIfShowing frmNotes
    
End Sub

Private Sub modifyNote()
'Purpose: Set up frmNotes for modify capabilities.

    g_NoteMode = "MODIFY"
    hideShowModuleIfShowing frmNotes
    
End Sub

Private Sub removeNote()
'Purpose: Set up frmNotes for remove capabilities.

    g_NoteMode = "DELETE"
    hideShowModuleIfShowing frmNotes
    
End Sub

Function isConfirmed(action As String) As Boolean
'Purpose: Present user with a confirmation dialog. Options: 'OK', 'CANCEL'
'Parameter: action: 'Save', 'Delete'

Dim confMsg As Integer

    confMsg = MsgBox("Please Confirm Instruction to " & action, vbOKCancel, "Confirmation Dialog")
    
    If confMsg = 1 Then
        isConfirmed = True
    Else
        isConfirmed = False
    End If
    
End Function


Public Sub makeRecordActionButtonsVisible()
    ToolbarMain.Buttons(btnSave).Visible = True
End Sub

Public Sub makeModuleActionButtonsVisible()
    ToolbarMain.Buttons(btnPrint).Visible = True
    ToolbarMain.Buttons(btnAdd).Visible = True
    ToolbarMain.Buttons(btnModify).Visible = True
    ToolbarMain.Buttons(btnDelete).Visible = True
End Sub

Public Sub makeModuleActionButtonsInvisible()
    ToolbarMain.Buttons(btnPrint).Visible = False
    ToolbarMain.Buttons(btnAdd).Visible = False
    ToolbarMain.Buttons(btnModify).Visible = False
    ToolbarMain.Buttons(btnDelete).Visible = False
End Sub


Public Sub makeRecordActionButtonsInvisible()
    ToolbarMain.Buttons(btnSave).Visible = False
End Sub

Public Sub makeQuickbooksButtonVisible()
    ToolbarMain.Buttons(btnQuickbooks).Visible = True
End Sub

Public Sub makeSaveRecVisible()
    ToolbarMain.Buttons(btnSave).Visible = True
End Sub

Public Sub makeGoBackVisible()
    ToolbarMain.Buttons(btnGoBack).Visible = True
End Sub

Public Sub makeQuickbooksButtonInvisible()
    ToolbarMain.Buttons(btnQuickbooks).Visible = False
End Sub

Public Sub makeSaveRecInvisible()
    ToolbarMain.Buttons(btnSave).Visible = False
End Sub

Public Sub makeGoBackInvisible()
    ToolbarMain.Buttons(btnGoBack).Visible = False
End Sub

Public Sub setSaveRecToolTip(newText)
    ToolbarMain.Buttons(btnSave).ToolTipText = newText
End Sub

Public Sub makePrintButtonVisible()
    ToolbarMain.Buttons(btnPrint).Visible = True
End Sub

Public Sub resetToolbar()
'Purpose: Show set of buttons from system initialization

    makeRecordActionButtonsInvisible
    makeModuleActionButtonsInvisible
    makeQuickbooksButtonInvisible
    makeGoBackInvisible
    makeModuleButtonsVisible

End Sub

Public Sub showSearchModuleButtons()
'Purpose: Show set of buttons appropriate for a system search module.
    makeGoBackVisible
    makeRecordActionButtonsInvisible
    makeModuleActionButtonsVisible
    makeModuleButtonsVisible
    
End Sub

Public Sub showModuleButtons()
'Purpose: Show set of buttons for Attorney, Client, Judge, and Case modules
    makeRecordActionButtonsVisible
    makeGoBackVisible
    makeModuleActionButtonsVisible
    makeModuleButtonsInvisible
    
End Sub

Public Sub makeModuleButtonsVisible()
'Purpose: Make all module buttons visible

    ToolbarMain.Buttons(btnAttorney).Visible = True
    ToolbarMain.Buttons(btnClient).Visible = True
    ToolbarMain.Buttons(btnJudge).Visible = True
    ToolbarMain.Buttons(btnCase).Visible = True

End Sub

Public Sub makeModuleButtonsInvisible()
'Purpose: Make all module buttons invisible

    ToolbarMain.Buttons(btnAttorney).Visible = False
    ToolbarMain.Buttons(btnClient).Visible = False
    ToolbarMain.Buttons(btnJudge).Visible = False
    ToolbarMain.Buttons(btnCase).Visible = False

End Sub

Public Sub hideSelfModuleButton()
'Purpose: Hide the button of the module user is currently in.
    
    Select Case g_CurrentScreen
    
        Case "frmAttorneySearch"
            ToolbarMain.Buttons(btnAttorney).Visible = False
        
        Case "frmAttorneyNew"
            ToolbarMain.Buttons(btnAttorney).Visible = False
        
        Case "frmClientSearch"
            ToolbarMain.Buttons(btnClient).Visible = False
        
        Case "frmClientNew"
            ToolbarMain.Buttons(btnClient).Visible = False
        
        Case "frmJudgesSearch"
            ToolbarMain.Buttons(btnJudge).Visible = False
        
        Case "frmJudgesNew"
            ToolbarMain.Buttons(btnJudge).Visible = False
        
        Case "frmCaseSearch"
            ToolbarMain.Buttons(btnCase).Visible = False
        
        Case "frmCaseNew"
            If g_CaseCallingModule = "frmAttorneyNew" Then
                ToolbarMain.Buttons(btnAttorney).Visible = False
            
            ElseIf g_CaseCallingModule = "frmClientNew" Then
                ToolbarMain.Buttons(btnClient).Visible = False
            
            Else
                ToolbarMain.Buttons(btnCase).Visible = False
            End If
        
        Case "frmCases"
            ToolbarMain.Buttons(btnCase).Visible = False
        
        Case "frmDocuments"
            ToolbarMain.Buttons(btnCase).Visible = False
        
        Case "frmDocumentSearch2"
            ToolbarMain.Buttons(btnCase).Visible = False
            
        Case "frmNotes"
            Select Case g_NoteCallingModule
                Case "frmAttorneyNew"
                    ToolbarMain.Buttons(btnAttorney).Visible = False
                
                Case "frmClientNew"
                    ToolbarMain.Buttons(btnClient).Visible = False
                
                Case "frmJudgesNew"
                    ToolbarMain.Buttons(btnJudge).Visible = False
                
                Case "frmCaseNew"
                    ToolbarMain.Buttons(btnCase).Visible = False
            End Select
    
    End Select
End Sub

Public Sub setStatusBar(windowName As String)
'Purpose: Set WindowName element of status bar
    frmMDI.StatusBar1.Panels(2).Text = windowName
End Sub

Public Sub setUserStatusBar(username As String)
'Purpose: Set Current User Element of status bar
    frmMDI.StatusBar1.Panels(3).Text = username
End Sub

Private Sub makeMenuItemsInvisible()
    mnuAMenu.Visible = False
    mnuCMenu.Visible = False
    mnuJMenu.Visible = False
    mnuFMenu.Visible = False
    mnuRMenu.Visible = False
    mnuRemindersMenu.Visible = False
    mnuCoMenu.Visible = False
    
End Sub

Private Sub makeMenuSubItemsInvisible()
    'Attorney Menu Subitems
    mnuAddA.Visible = False
    mnuModifyA.Visible = False
    mnuDeleteA.Visible = False
    
    'Client Menu Subitems
    mnuAddC.Visible = False
    mnuModifyC.Visible = False
    mnuDeleteC.Visible = False
    
    'Judge Menu Subitems
    mnuAddJ.Visible = False
    mnuModifyJ.Visible = False
    mnuDeleteJ.Visible = False
    
    'Case Menu Subitems
    mnuAddF.Visible = False
    mnuModifyF.Visible = False
    mnuDeleteF.Visible = False

    'System Admin Subitems
    mnuImport.Visible = False
    mnuBackup.Visible = False
    mnuRestore.Visible = False
    mnuOptions.Visible = False
'    mnuUsers.Visible = False
    
End Sub

Public Sub systemLockdown()
'Purpose: Disable All menu Items and Toolbar Buttons
'       No system features available prior to login.

    'Hide Attorney, Client, Judge, Case Buttons
    makeModuleButtonsInvisible
    'Make module action buttons invisible
    makeModuleActionButtonsInvisible
    'Make menus invisble
    makeMenuItemsInvisible
    'Make menu subitems invisible
    makeMenuSubItemsInvisible
    'Make record Action buttons invisible
    makeRecordActionButtonsInvisible
    'Make go back button invisible
    makeGoBackInvisible
    'Make Quickbooks button invisible
    makeQuickbooksButtonInvisible
    
End Sub

Public Sub grantSystemPermissions()
'Purpose: Grant access to system functionalities
'based on the user's global permission levels
    
    grantAttorneyAccess
    grantClientAccess
    grantJudgeAccess
    grantCaseAccess
    grantSystemAdminAccess
    

End Sub

Private Sub grantAttorneyAccess()
'Purpose: Grant access to attorney features
'based on user's attorney permission level
    
    'Make Attorney Menu Visible
    mnuAMenu.Visible = True
    
    'Make Attorney Module Button Visible
    ToolbarMain.Buttons(btnAttorney).Visible = True
    
    Select Case g_PermAttorney
        Case p_View
            'At start of granting permissions:
            
            'Current Module button is visible, if you click on that
            'you are taken to the search module, where you can
            'view details.
            
            'Current Module button is then invisible due to
            'hiding self module button.
            
            'Therefore, view capabilities are handled by default.
        
        Case p_All
            'Make menu subitems visible
            mnuAddA.Visible = True
            mnuModifyA.Visible = True
            mnuDeleteA.Visible = True
            
            'Make Module action buttons visible
            makeModuleActionButtonsVisible
        
        Case p_Add
            'Make add button visible
            ToolbarMain.Buttons(btnAdd).Visible = True
            'Make add menu item visible
            mnuAddA.Visible = True
        
        Case p_Modify
            'Make modify button visible
            ToolbarMain.Buttons(btnModify).Visible = True
            'Make modify menu item visible
            mnuModifyA.Visible = True
       
        Case p_Delete
            'Make Delete button visible
            ToolbarMain.Buttons(btnModify).Visible = True
            'Make Delete menu item visible
            mnuDeleteA.Visible = True
        
        Case p_ViewAdd
            'User can view details by default.
            'Therefore, we only need to allow add capabilities.
            
            'Make add button visible
            ToolbarMain.Buttons(btnAdd).Visible = True
            'Make add menu item visible
            mnuAddA.Visible = True
                
        Case p_ViewAddModify
            'User can view details by default.
            'There we need to include ADD and MODIFY capabilities.
            
            'Make add button visible
            ToolbarMain.Buttons(btnAdd).Visible = True
            'Make add menu item visible
            mnuAddA.Visible = True
            
            'Make modify button visible
            ToolbarMain.Buttons(btnModify).Visible = True
            'Make modify menu item visible
            mnuModifyA.Visible = True
        
    End Select
        

End Sub

Private Sub grantClientAccess()
'Purpose: Grant access to client features
'based on user's client permission level
    
    'Make Attorney Menu Visible
    mnuCMenu.Visible = True
    
    'Make Attorney Module Button Visible
    ToolbarMain.Buttons(btnClient).Visible = True
    
    Select Case g_PermClient
        Case p_View
            'At start of granting permissions:
            
            'Current Module button is visible, if you click on that
            'you are taken to the search module, where you can
            'view details.
            
            'Current Module button is then invisible due to
            'hiding self module button.
            
            'Therefore, view capabilities are handled by default.
        
        Case p_All
            'Make menu subitems visible
            mnuAddC.Visible = True
            mnuModifyC.Visible = True
            mnuDeleteC.Visible = True
            
            'Make Module action buttons visible
            'makeModuleActionButtonsVisible
        
        Case p_Add
            'Make add button visible
            ToolbarMain.Buttons(btnAdd).Visible = True
            'Make add menu item visible
            mnuAddC.Visible = True
        
        Case p_Modify
            'Make modify button visible
            ToolbarMain.Buttons(btnModify).Visible = True
            'Make modify menu item visible
            mnuModifyC.Visible = True
       
        Case p_Delete
            'Make Delete button visible
            ToolbarMain.Buttons(btnModify).Visible = True
            'Make Delete menu item visible
            mnuDeleteC.Visible = True
        
        Case p_ViewAdd
            'User can view details by default.
            'Therefore, we only need to allow add capabilities.
            
            'Make add button visible
            ToolbarMain.Buttons(btnAdd).Visible = True
            'Make add menu item visible
            mnuAddC.Visible = True
                
        Case p_ViewAddModify
            'User can view details by default.
            'There we need to include ADD and MODIFY capabilities.
            
            'Make add button visible
            ToolbarMain.Buttons(btnAdd).Visible = True
            'Make add menu item visible
            mnuAddC.Visible = True
            
            'Make modify button visible
            ToolbarMain.Buttons(btnModify).Visible = True
            'Make modify menu item visible
            mnuModifyC.Visible = True
        
    End Select
End Sub

Private Sub grantJudgeAccess()

End Sub

Private Sub grantCaseAccess()

End Sub

Private Sub grantSystemAdminAccess()

End Sub
