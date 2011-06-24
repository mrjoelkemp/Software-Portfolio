VERSION 5.00
Begin VB.Form frmMainMenu 
   BorderStyle     =   0  'None
   ClientHeight    =   8265
   ClientLeft      =   0
   ClientTop       =   -15
   ClientWidth     =   11595
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8265
   ScaleWidth      =   11595
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   4575
      Left            =   3840
      TabIndex        =   4
      Top             =   2160
      Width           =   3915
      Begin VB.CommandButton cmdAttorney 
         BackColor       =   &H80000005&
         Height          =   900
         Left            =   480
         Picture         =   "frmMainMenu.frx":0000
         Style           =   1  'Graphical
         TabIndex        =   10
         Top             =   360
         Width           =   900
      End
      Begin VB.CommandButton cmdClient 
         BackColor       =   &H80000005&
         Height          =   900
         Left            =   480
         Picture         =   "frmMainMenu.frx":6446
         Style           =   1  'Graphical
         TabIndex        =   9
         Top             =   1680
         Width           =   900
      End
      Begin VB.CommandButton cmdCase 
         BackColor       =   &H80000005&
         Height          =   900
         Left            =   2520
         Picture         =   "frmMainMenu.frx":6750
         Style           =   1  'Graphical
         TabIndex        =   8
         Top             =   360
         Width           =   900
      End
      Begin VB.CommandButton cmdReport 
         BackColor       =   &H80000005&
         Height          =   900
         Left            =   2520
         Picture         =   "frmMainMenu.frx":6A5A
         Style           =   1  'Graphical
         TabIndex        =   7
         Top             =   1680
         Width           =   900
      End
      Begin VB.CommandButton cmdAdministration 
         BackColor       =   &H80000005&
         Height          =   900
         Left            =   2520
         Picture         =   "frmMainMenu.frx":6D64
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   3000
         Width           =   900
      End
      Begin VB.CommandButton cmdJudge 
         BackColor       =   &H80000005&
         Height          =   900
         Left            =   480
         Picture         =   "frmMainMenu.frx":706E
         Style           =   1  'Graphical
         TabIndex        =   5
         Top             =   3000
         Width           =   900
      End
      Begin VB.Label Label1 
         Caption         =   "Attorneys"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   480
         TabIndex        =   17
         Top             =   1320
         Width           =   975
      End
      Begin VB.Label Label2 
         Caption         =   "Clients"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   480
         TabIndex        =   16
         Top             =   2640
         Width           =   975
      End
      Begin VB.Label Label3 
         Caption         =   "Case Files"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2520
         TabIndex        =   15
         Top             =   1320
         Width           =   975
      End
      Begin VB.Label Label4 
         Caption         =   "Reports"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2520
         TabIndex        =   14
         Top             =   2640
         Width           =   855
      End
      Begin VB.Label Label5 
         Caption         =   "System"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2520
         TabIndex        =   13
         Top             =   3960
         Width           =   915
      End
      Begin VB.Label Label8 
         Caption         =   "Judges"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   480
         TabIndex        =   12
         Top             =   3960
         Width           =   975
      End
      Begin VB.Label Label9 
         Caption         =   "Administration"
         Height          =   255
         Left            =   2520
         TabIndex        =   11
         Top             =   4200
         Width           =   1035
      End
   End
   Begin VB.Frame Frame2 
      Height          =   1095
      Left            =   120
      TabIndex        =   0
      Top             =   360
      Width           =   11295
      Begin VB.Label lblWindow 
         Alignment       =   2  'Center
         Caption         =   "Window Name"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   375
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   11055
      End
      Begin VB.Label lblFunction 
         Alignment       =   2  'Center
         Caption         =   "Function"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   120
         TabIndex        =   1
         Top             =   720
         Width           =   11055
      End
   End
   Begin VB.Label lblUserFullName 
      Caption         =   "User Full Name Here"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   960
      TabIndex        =   18
      Top             =   4680
      Width           =   2415
   End
   Begin VB.Label lblUserName 
      Caption         =   "UserID Here"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   720
      TabIndex        =   2
      Top             =   4200
      Width           =   2415
   End
End
Attribute VB_Name = "frmMainMenu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdAdministration_Click()
    frmOptions.Show
End Sub

Private Sub cmdAdministrationDown_Click()
    frmOptions.Show
End Sub

Private Sub cmdAttorney_Click()
    frmMDI.mnuViewA_Click
    'Link toolbar button to respond appropriately
    g_ButtonMode = "ATTORNEYS"
End Sub

Private Sub cmdAttorneyDown_Click()
    frmMDI.mnuViewA_Click
    g_ButtonMode = "ATTORNEYS"
End Sub

Private Sub cmdClient_Click()
    frmMDI.mnuViewC_Click
    g_ButtonMode = "CLIENTS"
End Sub

Private Sub cmdClientDown_Click()
    frmMDI.mnuViewC_Click
    g_ButtonMode = "CLIENTS"
End Sub

Private Sub cmdCase_Click()
    frmMDI.mnuViewF_Click
    g_ButtonMode = "CASES"
End Sub

Private Sub cmdCaseDown_Click()
    frmMDI.mnuViewF_Click
    g_ButtonMode = "CASES"
End Sub

Private Sub cmdJudge_Click()
    frmMDI.mnuViewJ_Click
    g_ButtonMode = "JUDGES"
End Sub

Private Sub cmdReport_Click()
    PopupMenu frmMDI.mnuRMenu
End Sub

Private Sub cmdReportDown_Click()
    PopupMenu frmMDI.mnuRMenu
End Sub

Private Sub Form_Load()
    
    Me.Top = 0
    Me.Left = 0
    
    
    setMainMenuUserName
    setMainMenuUserFullName
    
    
    'Set title of window
    lblWindow.Caption = "Main Menu"
    lblFunction.Caption = "Please Select an Action Button Below"
    
    'Set title of window in Status Bar
    frmMDI.setStatusBar (lblWindow.Caption)
    frmMDI.setUserStatusBar (g_CurrentUser)
    
    
End Sub
Private Sub Form_Activate()

    frmMDI.resetToolbar
    
    modMain.setCurrentScreen ("frmMainMenu")
    
    'Set title of window in Status Bar
    frmMDI.StatusBar1.Panels(2).Text = lblWindow.Caption

End Sub

Private Sub setMainMenuUserName()
'Purpose: Set label in format ("User: USERNAME")
    lblUserName.Caption = "User: " & UCase$(g_CurrentUser)
End Sub

Private Sub setMainMenuUserFullName()
    lblUserFullName.Caption = getUserFullName
End Sub

Function getUserFullName()
'Purpose: Find the first name and last name of the global user
Dim w_SQL       As String
Dim w_Recordset As New Recordset

    w_SQL = "Select firstname, lastname from users where userid = '" & g_CurrentUser & "'"

    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        If .EOF Then
            Exit Function
        End If
        'Return user's Full name
        getUserFullName = !firstname & " " & !lastname
        
        If .State = 1 Then
            .Close
        End If
        
    End With
        
End Function
