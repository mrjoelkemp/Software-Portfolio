VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Begin VB.Form frmUsers 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "CMS User Management"
   ClientHeight    =   6915
   ClientLeft      =   2565
   ClientTop       =   1500
   ClientWidth     =   6105
   Icon            =   "frmUsers.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6915
   ScaleWidth      =   6105
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame fraUserInfo 
      Caption         =   "User Information"
      Height          =   5535
      Left            =   240
      TabIndex        =   13
      Top             =   480
      Width           =   5655
      Begin VB.TextBox sLastName 
         Height          =   285
         Left            =   240
         TabIndex        =   2
         Top             =   2160
         Width           =   2415
      End
      Begin VB.TextBox sFirstName 
         Height          =   285
         Left            =   240
         TabIndex        =   1
         Top             =   1440
         Width           =   2415
      End
      Begin VB.TextBox sUserID 
         Height          =   285
         Left            =   240
         TabIndex        =   0
         Text            =   "Enter UserID Here"
         Top             =   720
         Width           =   2415
      End
      Begin VB.CommandButton cmdSubmitUserInfo 
         Caption         =   "Submit"
         Height          =   375
         Left            =   3720
         TabIndex        =   3
         Top             =   840
         Width           =   1215
      End
      Begin VB.CommandButton cmdRemoveUser 
         Caption         =   "Remove"
         Height          =   375
         Left            =   3720
         TabIndex        =   14
         Top             =   1680
         Width           =   1215
      End
      Begin MSFlexGridLib.MSFlexGrid listUsers 
         Height          =   2655
         Left            =   120
         TabIndex        =   15
         Top             =   2640
         Width           =   5415
         _ExtentX        =   9551
         _ExtentY        =   4683
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         FocusRect       =   0
         GridLines       =   2
         SelectionMode   =   1
         AllowUserResizing=   1
         FormatString    =   "UserID                         | First Name                    | Last Name                   "
      End
      Begin VB.Label lblMsg 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000001&
         Height          =   255
         Left            =   1320
         TabIndex        =   69
         Top             =   240
         Width           =   3255
      End
      Begin VB.Label Label3 
         Caption         =   "Last Name:"
         Height          =   255
         Left            =   240
         TabIndex        =   18
         Top             =   1920
         Width           =   975
      End
      Begin VB.Label Label2 
         Caption         =   "First Name:"
         Height          =   255
         Left            =   240
         TabIndex        =   17
         Top             =   1200
         Width           =   975
      End
      Begin VB.Label Label1 
         Caption         =   "UserID:"
         Height          =   255
         Left            =   240
         TabIndex        =   16
         Top             =   480
         Width           =   615
      End
   End
   Begin VB.Frame fraAccessRights 
      Caption         =   "User Access Rights:"
      Height          =   5535
      Left            =   240
      TabIndex        =   19
      Top             =   480
      Width           =   5655
      Begin VB.CommandButton cmdSetAccessRights 
         Caption         =   "Set Access Rights"
         Height          =   495
         Left            =   2040
         TabIndex        =   68
         Top             =   4800
         Width           =   1695
      End
      Begin VB.Frame Frame2 
         BorderStyle     =   0  'None
         Height          =   2775
         Left            =   120
         TabIndex        =   27
         Top             =   720
         Width           =   5415
         Begin VB.CheckBox CheckDelete 
            Caption         =   "Check1"
            Height          =   255
            Index           =   4
            Left            =   4560
            TabIndex        =   63
            Top             =   2160
            Width           =   255
         End
         Begin VB.CheckBox CheckDelete 
            Caption         =   "Check1"
            Height          =   255
            Index           =   3
            Left            =   4560
            TabIndex        =   62
            Top             =   1800
            Width           =   255
         End
         Begin VB.CheckBox CheckDelete 
            Caption         =   "Check1"
            Height          =   255
            Index           =   2
            Left            =   4560
            TabIndex        =   61
            Top             =   1440
            Width           =   255
         End
         Begin VB.CheckBox CheckDelete 
            Caption         =   "Check1"
            Height          =   255
            Index           =   1
            Left            =   4560
            TabIndex        =   60
            Top             =   1080
            Width           =   255
         End
         Begin VB.CheckBox CheckModify 
            Caption         =   "Check1"
            Enabled         =   0   'False
            Height          =   255
            Index           =   4
            Left            =   3720
            TabIndex        =   59
            Top             =   2160
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.CheckBox CheckModify 
            Caption         =   "Check1"
            Height          =   255
            Index           =   3
            Left            =   3720
            TabIndex        =   58
            Top             =   1800
            Width           =   255
         End
         Begin VB.CheckBox CheckModify 
            Caption         =   "Check1"
            Height          =   255
            Index           =   2
            Left            =   3720
            TabIndex        =   57
            Top             =   1440
            Width           =   255
         End
         Begin VB.CheckBox CheckModify 
            Caption         =   "Check1"
            Height          =   255
            Index           =   1
            Left            =   3720
            TabIndex        =   56
            Top             =   1080
            Width           =   255
         End
         Begin VB.CheckBox CheckAdd 
            Caption         =   "Check1"
            Enabled         =   0   'False
            Height          =   255
            Index           =   4
            Left            =   3000
            TabIndex        =   55
            Top             =   2160
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.CheckBox CheckAdd 
            Caption         =   "Check1"
            Height          =   255
            Index           =   3
            Left            =   3000
            TabIndex        =   54
            Top             =   1800
            Width           =   255
         End
         Begin VB.CheckBox CheckAdd 
            Caption         =   "Check1"
            Height          =   255
            Index           =   2
            Left            =   3000
            TabIndex        =   53
            Top             =   1440
            Width           =   255
         End
         Begin VB.CheckBox CheckAdd 
            Caption         =   "Check1"
            Height          =   255
            Index           =   1
            Left            =   3000
            TabIndex        =   52
            Top             =   1080
            Width           =   255
         End
         Begin VB.CheckBox CheckInquire 
            Caption         =   "Check1"
            Height          =   255
            Index           =   4
            Left            =   2280
            TabIndex        =   51
            Top             =   2160
            Width           =   255
         End
         Begin VB.CheckBox CheckInquire 
            Caption         =   "Check1"
            Height          =   255
            Index           =   3
            Left            =   2280
            TabIndex        =   50
            Top             =   1800
            Width           =   255
         End
         Begin VB.CheckBox CheckInquire 
            Caption         =   "Check1"
            Height          =   255
            Index           =   2
            Left            =   2280
            TabIndex        =   49
            Top             =   1440
            Width           =   255
         End
         Begin VB.CheckBox CheckInquire 
            Caption         =   "Check1"
            Height          =   255
            Index           =   1
            Left            =   2280
            TabIndex        =   48
            Top             =   1080
            Width           =   255
         End
         Begin VB.CheckBox CheckAll 
            Caption         =   "Check1"
            Enabled         =   0   'False
            Height          =   255
            Index           =   4
            Left            =   1560
            TabIndex        =   47
            Top             =   2160
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.CheckBox CheckAll 
            Caption         =   "Check1"
            Height          =   255
            Index           =   3
            Left            =   1560
            TabIndex        =   46
            Top             =   1800
            Width           =   255
         End
         Begin VB.CheckBox CheckAll 
            Caption         =   "Check1"
            Height          =   255
            Index           =   2
            Left            =   1560
            TabIndex        =   45
            Top             =   1440
            Width           =   255
         End
         Begin VB.CheckBox CheckAll 
            Caption         =   "Check1"
            Height          =   255
            Index           =   1
            Left            =   1560
            TabIndex        =   44
            Top             =   1080
            Width           =   255
         End
         Begin VB.CheckBox CheckDelete 
            Caption         =   "Check1"
            Height          =   255
            Index           =   0
            Left            =   4560
            TabIndex        =   43
            Top             =   720
            Width           =   255
         End
         Begin VB.CheckBox CheckModify 
            Caption         =   "Check1"
            Height          =   255
            Index           =   0
            Left            =   3720
            TabIndex        =   42
            Top             =   720
            Width           =   255
         End
         Begin VB.CheckBox CheckAdd 
            Caption         =   "Check1"
            Height          =   255
            Index           =   0
            Left            =   3000
            TabIndex        =   41
            Top             =   720
            Width           =   255
         End
         Begin VB.CheckBox CheckInquire 
            Caption         =   "Check1"
            Height          =   255
            Index           =   0
            Left            =   2280
            TabIndex        =   40
            Top             =   720
            Width           =   255
         End
         Begin VB.CheckBox CheckAll 
            Caption         =   "Check1"
            Height          =   255
            Index           =   0
            Left            =   1560
            TabIndex        =   39
            Top             =   720
            Width           =   255
         End
         Begin VB.Line Line2 
            Index           =   2
            X1              =   360
            X2              =   360
            Y1              =   240
            Y2              =   2640
         End
         Begin VB.Line Line1 
            Index           =   2
            X1              =   360
            X2              =   5040
            Y1              =   240
            Y2              =   240
         End
         Begin VB.Line Line1 
            Index           =   1
            X1              =   360
            X2              =   5040
            Y1              =   2640
            Y2              =   2640
         End
         Begin VB.Line Line2 
            Index           =   1
            X1              =   5040
            X2              =   5040
            Y1              =   240
            Y2              =   2640
         End
         Begin VB.Line Line2 
            Index           =   0
            X1              =   1320
            X2              =   1320
            Y1              =   240
            Y2              =   2640
         End
         Begin VB.Line Line1 
            Index           =   0
            X1              =   360
            X2              =   5040
            Y1              =   600
            Y2              =   600
         End
         Begin VB.Label Label19 
            Caption         =   "Audit Controls"
            Height          =   375
            Left            =   480
            TabIndex        =   38
            Top             =   2160
            Width           =   855
         End
         Begin VB.Label Label16 
            Caption         =   "Delete"
            Height          =   255
            Left            =   4440
            TabIndex        =   37
            Top             =   360
            Width           =   615
         End
         Begin VB.Label Label15 
            Caption         =   "Modify"
            Height          =   255
            Left            =   3600
            TabIndex        =   36
            Top             =   360
            Width           =   615
         End
         Begin VB.Label Label14 
            Caption         =   "Add"
            Height          =   255
            Left            =   3000
            TabIndex        =   35
            Top             =   360
            Width           =   615
         End
         Begin VB.Label Label13 
            Caption         =   "Inquire"
            Height          =   255
            Left            =   2160
            TabIndex        =   34
            Top             =   360
            Width           =   615
         End
         Begin VB.Label Label12 
            Caption         =   "All"
            Height          =   255
            Left            =   1560
            TabIndex        =   33
            Top             =   360
            Width           =   375
         End
         Begin VB.Label Label9 
            Caption         =   "Cases"
            Height          =   255
            Left            =   480
            TabIndex        =   32
            Top             =   1800
            Width           =   855
         End
         Begin VB.Label Label8 
            Caption         =   "Judges"
            Height          =   255
            Left            =   480
            TabIndex        =   31
            Top             =   1440
            Width           =   855
         End
         Begin VB.Label Label7 
            Caption         =   "Attorneys"
            Height          =   255
            Left            =   480
            TabIndex        =   30
            Top             =   1080
            Width           =   855
         End
         Begin VB.Label Label6 
            Caption         =   "Clients"
            Height          =   255
            Left            =   480
            TabIndex        =   29
            Top             =   720
            Width           =   855
         End
         Begin VB.Label Label5 
            Caption         =   "Function"
            Height          =   255
            Left            =   480
            TabIndex        =   28
            Top             =   360
            Width           =   735
         End
      End
      Begin VB.Frame Frame1 
         BorderStyle     =   0  'None
         Height          =   1335
         Left            =   120
         TabIndex        =   22
         Top             =   3360
         Width           =   5415
         Begin VB.CheckBox CheckYes 
            Caption         =   "Check1"
            Height          =   255
            Index           =   3
            Left            =   4320
            TabIndex        =   67
            Top             =   960
            Width           =   255
         End
         Begin VB.CheckBox CheckYes 
            Caption         =   "Check1"
            Height          =   255
            Index           =   2
            Left            =   4320
            TabIndex        =   66
            Top             =   360
            Width           =   255
         End
         Begin VB.CheckBox CheckYes 
            Caption         =   "Check1"
            Height          =   255
            Index           =   1
            Left            =   1800
            TabIndex        =   65
            Top             =   960
            Width           =   255
         End
         Begin VB.CheckBox CheckYes 
            Caption         =   "Check1"
            Height          =   255
            Index           =   0
            Left            =   1800
            TabIndex        =   64
            Top             =   360
            Width           =   255
         End
         Begin VB.Label Label18 
            Caption         =   "Data Backup"
            Height          =   375
            Left            =   3120
            TabIndex        =   26
            Top             =   240
            Width           =   855
         End
         Begin VB.Label Label17 
            Caption         =   "Data Restore"
            Height          =   375
            Left            =   3120
            TabIndex        =   25
            Top             =   840
            Width           =   855
         End
         Begin VB.Label Label11 
            Caption         =   "System Parameters"
            Height          =   375
            Left            =   600
            TabIndex        =   24
            Top             =   240
            Width           =   855
         End
         Begin VB.Label Label10 
            Caption         =   "User Administration"
            Height          =   375
            Left            =   600
            TabIndex        =   23
            Top             =   840
            Width           =   975
         End
      End
      Begin VB.ComboBox cbUserID 
         Height          =   315
         Left            =   960
         TabIndex        =   20
         Text            =   "Select User"
         Top             =   360
         Width           =   1935
      End
      Begin VB.Label Label4 
         Caption         =   "UserID:"
         Height          =   255
         Left            =   240
         TabIndex        =   21
         Top             =   480
         Width           =   975
      End
   End
   Begin VB.PictureBox picOptions 
      BorderStyle     =   0  'None
      Height          =   3780
      Index           =   3
      Left            =   -20000
      ScaleHeight     =   3780
      ScaleWidth      =   5685
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   480
      Width           =   5685
      Begin VB.Frame fraSample4 
         Caption         =   "Sample 4"
         Height          =   1785
         Left            =   2100
         TabIndex        =   12
         Top             =   840
         Width           =   2055
      End
   End
   Begin VB.PictureBox picOptions 
      BorderStyle     =   0  'None
      Height          =   3780
      Index           =   2
      Left            =   -20000
      ScaleHeight     =   3780
      ScaleWidth      =   5685
      TabIndex        =   8
      TabStop         =   0   'False
      Top             =   480
      Width           =   5685
      Begin VB.Frame fraSample3 
         Caption         =   "Sample 3"
         Height          =   1785
         Left            =   1545
         TabIndex        =   11
         Top             =   675
         Width           =   2055
      End
   End
   Begin VB.PictureBox picOptions 
      BorderStyle     =   0  'None
      Height          =   3780
      Index           =   1
      Left            =   -20000
      ScaleHeight     =   3780
      ScaleWidth      =   5685
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   480
      Width           =   5685
      Begin VB.Frame fraSample2 
         Caption         =   "Sample 2"
         Height          =   1785
         Left            =   645
         TabIndex        =   10
         Top             =   300
         Width           =   2055
      End
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   375
      Left            =   4800
      TabIndex        =   6
      Top             =   6360
      Width           =   1095
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   3480
      TabIndex        =   5
      Top             =   6360
      Width           =   1095
   End
   Begin MSComctlLib.TabStrip tbsOptions 
      Height          =   6045
      Left            =   120
      TabIndex        =   4
      Top             =   120
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   10663
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   2
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Information"
            Object.ToolTipText     =   "Set User Information"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Access Rights"
            Object.ToolTipText     =   "Set User Access Rights"
            ImageVarType    =   2
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "frmUsers"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'Contains the currently viewed tab
Dim currTab As String

'Holds user permissions
Dim perm_Attorneys  As String
Dim perm_Clients    As String
Dim perm_Judges     As String
Dim perm_Cases      As String
Dim perm_Audits     As String
Dim perm_Users      As String
Dim perm_SysParam   As String
Dim perm_DbBackup   As String
Dim perm_DbRestore  As String

'System Checkbox Indices
Const check_Clients = 0
Const check_Attorneys = 1
Const check_Judges = 2
Const check_Cases = 3
Const check_Audits = 4
Const check_Options = 0
Const check_User = 1
Const check_Backup = 2
Const check_Restore = 3

Private Sub cbUserID_Click()
    load_UserPermissionsIntoChecks
End Sub

Private Sub cmdSetAccessRights_Click()
'Purpose: Store the Access Rights for user (in cbUserID) in DB
    setUserAccessRights
End Sub

Private Sub setUserAccessRights()
'Purpose: Grab AccessRights and store them in the Permission Variables

    'Set system parameter permission
    If CheckYes(check_Options).Value = 1 Then
        perm_SysParam = p_Yes
    ElseIf CheckYes(check_Options).Value = 0 Then
        perm_SysParam = p_No
    End If
    
    'Set user administration permission
    If CheckYes(check_User).Value = 1 Then
        perm_Users = p_Yes
    ElseIf CheckYes(check_User).Value = 0 Then
        perm_Users = p_No
    End If
    
    'Set data backup permission
    If CheckYes(check_Backup).Value = 1 Then
        perm_DbBackup = p_Yes
    ElseIf CheckYes(check_Backup).Value = 0 Then
        perm_DbBackup = p_No
    End If
    
    'Set data restore permission
    If CheckYes(check_Restore).Value = 1 Then
        perm_DbRestore = p_Yes
    ElseIf CheckYes(check_Restore).Value = 0 Then
        perm_DbRestore = p_No
    End If
    
    'Set Client permission
    setModulePermissions check_Clients, perm_Clients
    
    'Set Attorney Permission
    setModulePermissions check_Attorneys, perm_Attorneys
    
    'Set Judge Permission
    setModulePermissions check_Judges, perm_Judges
    
    'Set Case Permission
    setModulePermissions check_Cases, perm_Cases
    
    'Set Audit Permission
    setModulePermissions check_Audits, perm_Audits

    'Store the permissions in the DB
    storePermissions
    
End Sub

Private Sub setModulePermissions(moduleRowIndex As Integer, ByRef perm_Var As String)

    'Set Client permission

    'View Only -- Add, Modify OFF
    If CheckInquire(moduleRowIndex).Value = 1 And _
        CheckAdd(moduleRowIndex).Value = 0 And _
        CheckModify(moduleRowIndex).Value = 0 Then
            perm_Var = p_View
    
    'Add Only -- View, Modify OFF
    ElseIf CheckAdd(moduleRowIndex).Value = 1 And _
        CheckInquire(moduleRowIndex).Value = 0 And _
        CheckModify(moduleRowIndex).Value = 0 Then
            perm_Var = p_Add
    
    'Modify Only -- View, Add OFF
    ElseIf CheckModify(moduleRowIndex).Value = 1 And _
        CheckInquire(moduleRowIndex).Value = 0 And _
        CheckAdd(moduleRowIndex).Value = 0 Then
            perm_Var = p_Modify
    
    'Delete -- All OFF
    ElseIf CheckDelete(moduleRowIndex).Value = 1 And _
        CheckAll(moduleRowIndex).Value = 0 Then
            perm_Var = p_Delete
    
    'ViewAdd -- Modify OFF
    ElseIf CheckInquire(moduleRowIndex).Value = 1 And _
        CheckAdd(moduleRowIndex).Value = 1 And _
        CheckModify(moduleRowIndex).Value = 0 Then
            perm_Var = p_ViewAdd
            
    'ViewAddModify -- All OFF
    ElseIf CheckInquire(moduleRowIndex).Value = 1 And _
        CheckAdd(moduleRowIndex).Value = 1 And _
        CheckModify(moduleRowIndex).Value = 1 And _
        CheckAll(moduleRowIndex).Value = 0 Then
            perm_Var = p_ViewAddModify
            
    'All
    ElseIf CheckAll(moduleRowIndex).Value = 1 Then
        perm_Var = p_All
    
    End If

End Sub

Private Sub storePermissions()
'Purpose: Store the permissions into DB
Dim w_SQL       As String
Dim w_Recordset As New Recordset

'In DB, you store the codes, not the descriptions.
Dim w_ClientPermCode    As Integer
Dim w_AttorneyPermCode  As Integer
Dim w_JudgePermCode     As Integer
Dim w_CasePermCode      As Integer
Dim w_AuditPermCode     As Integer
Dim w_SysParamPermCode  As Integer
Dim w_UsersPermCode     As Integer
Dim w_BackupPermCode    As Integer
Dim w_RestorePermCode   As Integer
    
    On Error GoTo errHandler

    'Get Permission Codes for descriptions -- Store codes in local Vars
    w_ClientPermCode = getPermCode(perm_Clients)
    w_AttorneyPermCode = getPermCode(perm_Attorneys)
    w_JudgePermCode = getPermCode(perm_Judges)
    w_CasePermCode = getPermCode(perm_Cases)
    w_AuditPermCode = getPermCode(perm_Audits)
    w_SysParamPermCode = getPermCode(perm_SysParam)
    w_UsersPermCode = getPermCode(perm_Users)
    w_BackupPermCode = getPermCode(perm_DbBackup)
    w_RestorePermCode = getPermCode(perm_DbRestore)
    

    'Modify Query -- Modify the default
    'accessright entry for the selected user
    w_SQL = "UPDATE accessrights SET " & _
        "attorneys= " & Chr(34) & w_AttorneyPermCode & Chr(34) & _
        ", clients= " & Chr(34) & w_ClientPermCode & Chr(34) & _
        ", judges= " & Chr(34) & w_JudgePermCode & Chr(34) & _
        ", cases= " & Chr(34) & w_CasePermCode & Chr(34) & _
        ", auditcontrols= " & Chr(34) & w_AuditPermCode & Chr(34) & _
        ", systemparameters= " & Chr(34) & w_SysParamPermCode & Chr(34) & _
        ", usermanagement= " & Chr(34) & w_UsersPermCode & Chr(34) & _
        ", databackup= " & Chr(34) & w_BackupPermCode & Chr(34) & _
        ", datarestore= " & Chr(34) & w_RestorePermCode & Chr(34) & _
        " WHERE userid= " & Chr(34) & cbUserID.Text & Chr(34) & ";"
        
    
    With w_Recordset
        'Execute Query
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        If .State = 1 Then
            .Close
        End If
        
    End With
    
    Exit Sub

errHandler:
    MsgBox "Could Not Save Access Rights", vbCritical, "DB Error"
    
End Sub

Function getPermCode(permDescr As String) As Integer
'Purpose: Take in Permission Description and return the corresponding code
Dim w_SQL       As String
Dim w_Recordset As New Recordset

    w_SQL = "Select typecode from accessrightstypes where description = '" & permDescr & "'"
    
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        getPermCode = !typeCode
        
        If .State = 1 Then
            .Close
        End If
        
    End With
        
End Function

Private Sub resetCheckmarks()
'Purpose: Clear the current values of the checkboxes (reset controls)
Dim counter As Integer

    'Clear ALL checkboxes.
    Do While counter <= 4
        'Turn off Client, Att, Judge, Case checks
        turnRowChecksOff (counter)
        
        'Rows go from 0-3 for this set
        If counter <= 3 Then
            'Turn off User, SysParam, Backup, and Restore checks
            CheckYes(counter).Value = 0
        End If
        
        counter = counter + 1
    Loop

End Sub



Function load_UserPermissionsIntoChecks()
'Purpose: Load Access Rights for selected UserID into Checkmark Grid
Dim w_SQL           As String
Dim w_Recordset     As New Recordset

    w_SQL = "Select * from accessrights where userid = '" & cbUserID.Text & "'"
    
    On Error GoTo errHandler
    
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        'Grab Permission Codes then get Permission Descriptions
        perm_Attorneys = getPermission(!attorneys)
        perm_Clients = getPermission(!clients)
        perm_Judges = getPermission(!judges)
        perm_Cases = getPermission(!cases)
        perm_Audits = getPermission(!auditcontrols)
        perm_Users = getPermission(!usermanagement)
        perm_SysParam = getPermission(!systemparameters)
        perm_DbBackup = getPermission(!databackup)
        perm_DbRestore = getPermission(!datarestore)
        
        If .State = 1 Then
            .Close
        End If
        
    End With

    'Set Access Right checkmark boxes for each module
    setPermissionCheck perm_Attorneys, dbModuleAttorney
    setPermissionCheck perm_Clients, dbModuleClient
    setPermissionCheck perm_Judges, dbModuleJudge
    setPermissionCheck perm_Cases, dbModuleCase
    setPermissionCheck perm_Audits, dbModuleAudit
    setPermissionCheck perm_SysParam, dbModuleOption
    setPermissionCheck perm_Users, dbModuleUser
    setPermissionCheck perm_DbBackup, dbModuleBackup
    setPermissionCheck perm_DbRestore, dbModuleRestore
    
    Exit Function

errHandler:
    MsgBox "Error Loading User AccessRights", vbCritical, "Load Error"

End Function

Private Sub setPermissionCheck(permissionDescr As String, moduleType As String)
'Purpose: Take in Permission String and set appropriate checkbox
'Parameters: permissionDescr- values ("View", "Add", "Modify", "Delete", "VA", "VAM", "All")
Dim rowIndex As Integer
    
    'Know which row of checkboxes to set.
    Select Case moduleType
        'If permission level is for attorney
        Case dbModuleAttorney
            'Set rowIndex to the index of the attorney row
            rowIndex = check_Attorneys
            
        Case dbModuleClient
            rowIndex = check_Clients
        
        Case dbModuleJudge
            rowIndex = check_Judges
        
        Case dbModuleCase
            rowIndex = check_Cases
        
        Case dbModuleAudit
            rowIndex = check_Audits
            
        Case dbModuleUser
            rowIndex = check_User
        
        Case dbModuleOption
            rowIndex = check_Options
        
        Case dbModuleBackup
            rowIndex = check_Backup
        
        Case dbModuleRestore
            rowIndex = check_Restore
    
    End Select
    
    Select Case permissionDescr
        Case p_All
            turnRowChecksOn (rowIndex)
            
        Case p_View
            CheckInquire(rowIndex).Value = 1
            
        Case p_Add
            CheckAdd(rowIndex).Value = 1
        
        Case p_Modify
            CheckModify(rowIndex).Value = 1
        
        Case p_Delete
            CheckDelete(rowIndex).Value = 1
        
        Case p_ViewAdd
            CheckInquire(rowIndex).Value = 1
            CheckAdd(rowIndex).Value = 1
        
        Case p_ViewAddModify
            CheckInquire(rowIndex).Value = 1
            CheckAdd(rowIndex).Value = 1
            CheckModify(rowIndex).Value = 1
        
        Case p_Yes
            CheckYes(rowIndex).Value = 1
        
        Case p_No
            CheckYes(rowIndex).Value = 0
        
        
    End Select


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

Private Sub CheckAll_Click(Index As Integer)
'Purpose: Check entire row of checkboxes when the ALL checkbox is checked

    'If user checked the box ON
    If CheckAll(Index).Value = 1 Then
    
        'Turn ON all checkboxes for that row
        turnRowChecksOn (Index)
        
    'Or if user checked the box OFF
    ElseIf CheckAll(Index).Value = 0 Then
    
        'Turn OFF all checkboxes for that row
        turnRowChecksOff (Index)
        
    End If

End Sub

Private Sub turnRowChecksOn(rowIndex As Integer)
'Purpose: To turn the checkboxes ON for specified row.
'Parameters: rowIndex- values (0-3)

    CheckAll(rowIndex).Value = 1
    CheckInquire(rowIndex).Value = 1
    CheckAdd(rowIndex).Value = 1
    CheckDelete(rowIndex).Value = 1
    CheckModify(rowIndex).Value = 1

End Sub

Private Sub turnRowChecksOff(rowIndex As Integer)
'Purpose: To turn the checkboxes OFF for specified row.
'Parameters: rowIndex- values (0-3)

    CheckAll(rowIndex).Value = 0
    CheckInquire(rowIndex).Value = 0
    CheckAdd(rowIndex).Value = 0
    CheckDelete(rowIndex).Value = 0
    CheckModify(rowIndex).Value = 0

End Sub

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdOK_Click()
    Unload Me
End Sub

Private Sub cmdRemoveUser_Click()
    removeUser
End Sub


Private Sub cmdSubmitUserInfo_Click()
    insertUser
End Sub

Private Sub Form_Activate()
    resetCheckmarks
End Sub

Private Sub Form_Deactivate()
    Me.Hide
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim i As Integer
    
    'handle ctrl+tab to move to the next tab
    If Shift = vbCtrlMask And KeyCode = vbKeyTab Then
        i = tbsOptions.SelectedItem.Index
        If i = tbsOptions.Tabs.Count Then
            'last tab so we need to wrap to tab 1
            Set tbsOptions.SelectedItem = tbsOptions.Tabs(1)
        Else
            'increment the tab
            Set tbsOptions.SelectedItem = tbsOptions.Tabs(i + 1)
        End If
    End If
End Sub

Private Sub Form_Load()
    'center the form
    Me.Move (Screen.Width - Me.Width) / 2, (Screen.Height - Me.Height) / 2
    
    'Load existing users
    load_List
    
    
End Sub

Private Sub sUserID_Change()
    'A Change in the userid field results in reset of lblmsg
    lblMsg.Caption = vbNullString
End Sub

Private Sub tbsOptions_Click()
    
    'show and enable the selected tab's controls
    'and hide and disable all others
    Select Case tbsOptions.SelectedItem.Index
        Case 1: fraUserInfo.ZOrder 0
                currTab = "fraUserInfo"
        Case 2: fraAccessRights.ZOrder 0
                currTab = "fraAccessRights"
    End Select
    
End Sub

Private Sub load_List()
Dim w_Recordset As New Recordset
Dim w_SQL       As String

    On Error GoTo errHandler
    
    'Clears the list
    clearGrid
    
    'Get all user information
    w_SQL = "Select * from users"
    
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        Do While .EOF = False
            'Add the users to the list
            listUsers.AddItem !userid & vbTab & !firstname & vbTab & !lastname
            
            'Also fill the UserId combo box in access rights tab
            cbUserID.AddItem !userid
            
            .MoveNext
        Loop
        
        If .State = 1 Then
            .Close
        End If
    End With
    
    Exit Sub

errHandler:
    MsgBox "Users Not Loaded", vbCritical, "Load Error"
End Sub

Function clearGrid()
'Purpose: Clear the current list and reformat the headings
Dim formatString As String

    formatString = "UserID                         | First Name                    | Last Name                   "
    With listUsers
        'Empty the list
        .Clear
        .Rows = .FixedRows
        'Redraw Col headings
        .formatString = formatString
    End With
    
End Function

Private Sub insertUser()
'Purpose: Insert a User into the system DB (Users Table)
Dim w_Recordset As New Recordset
Dim w_SQL       As String

    On Error Resume Next
    
    'Create Insert Query
    w_SQL = "Insert into users values ('" & _
        sUserID.Text & "', '" & _
        sFirstName.Text & "', '" & _
        sLastName.Text & "')"
        
    With w_Recordset
        'Insert User
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        If Err.Number = -2147467259 Then
            lblMsg.ForeColor = &HFF&
            lblMsg.Caption = "User ID Already Exists"
            Exit Sub
        End If
        
        If .State = 1 Then
            .Close
        End If
    End With
        
    'Query to create default entry for user's access right
    'User can only VIEW by default. (View = 2; No = 9)
    w_SQL = "Insert into accessrights values ('" & _
        sUserID.Text & "', '2', '2', '2', '2', '2', '9', '9', '9', '9')"
    
    On Error GoTo errHandler
     
    With w_Recordset
        'Insert User's Access right
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        
        If .State = 1 Then
            .Close
        End If
        
    End With
    
    'Create log
    system_db.write_systemLog "NEW", dbModuleUser, sUserID.Text
    
    'Show confirmation
    showSuccess ("NEW")
    
    clear_Fields
    
    'Load modified list of Users
    load_List
    
    Exit Sub

errHandler:
    lblMsg.ForeColor = &HFF&
    lblMsg.Caption = "AccessRights not entered!"
End Sub


Private Sub showSuccess(actionType As String)
'Purpose: Display green success msg.
'Notes: actionType is either "NEW" or "DELETE"

    
    Select Case actionType
        Case "NEW"
            lblMsg.ForeColor = &HFF00&
            lblMsg.Caption = "User Entered Successfully"
            
        Case "DELETE"
            lblMsg.ForeColor = &HFF00&
            lblMsg.Caption = "User Removed Successfully"
    End Select
    
End Sub

Private Sub removeUser()
'Purpose: Remove the User information from the system. Also remove the access rights set for that user.
Dim w_Recordset As New Recordset
Dim w_SQL As String
Dim userid As String

    On Error GoTo errHandler
        
    'Get selected userid from list
    userid = listUsers.TextMatrix(listUsers.Row, 0)
    
    'Create User query
    w_SQL = "Delete * from users where userid = " & Chr(34) & userid & Chr(34) & ";"

    With w_Recordset
        'Remove user information
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        If .State = 1 Then
            .Close
        End If
        
        'Create Delete Access Right query
        w_SQL = "Delete * from accessrights where userid = " & Chr(34) & userid & Chr(34) & ";"
        'Remove user's access rights
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        If .State = 1 Then
            .Close
        End If
        
    End With
    
    system_db.write_systemLog "DELETE", dbModuleUser, sUserID.Text
    
    showSuccess ("DELETE")
    
    'Refresh list of Users
    load_List
    
    Exit Sub

errHandler:
    MsgBox "User Not Removed", vbCritical, "User Error"

End Sub

Public Sub clear_Fields()

    sUserID.Text = vbNullString
    sFirstName.Text = vbNullString
    sLastName.Text = vbNullString
    
End Sub
