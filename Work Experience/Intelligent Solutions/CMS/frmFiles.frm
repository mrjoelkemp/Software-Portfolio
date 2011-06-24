VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form frmCases 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   8265
   ClientLeft      =   0
   ClientTop       =   -300
   ClientWidth     =   11595
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8265
   ScaleWidth      =   11595
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame6 
      Height          =   1095
      Left            =   120
      TabIndex        =   3
      Top             =   120
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
         TabIndex        =   6
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
         Height          =   375
         Left            =   120
         TabIndex        =   4
         Top             =   600
         Width           =   11055
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Actions:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   120
      TabIndex        =   2
      Top             =   6840
      Width           =   4575
      Begin VB.CommandButton cmdMore 
         Caption         =   "More"
         Height          =   615
         Left            =   360
         TabIndex        =   0
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5535
      Left            =   120
      TabIndex        =   1
      Top             =   1200
      Width           =   11295
      Begin MSFlexGridLib.MSFlexGrid sLblista 
         Height          =   5175
         Left            =   240
         TabIndex        =   5
         Top             =   240
         Width           =   10845
         _ExtentX        =   19129
         _ExtentY        =   9128
         _Version        =   393216
         Cols            =   6
         FixedCols       =   0
         ForeColor       =   0
         ForeColorFixed  =   0
         BackColorSel    =   12648447
         ForeColorSel    =   0
         FocusRect       =   0
         GridLines       =   2
         SelectionMode   =   1
         AllowUserResizing=   1
         FormatString    =   $"frmFiles.frx":0000
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
End
Attribute VB_Name = "frmCases"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdBack_Click()
    Hide
End Sub

Private Sub cmdExit_Click()
    End
End Sub

Private Sub cmdMore_Click()
    g_CaseMode = "VIEW"
    g_CaseCallingModule = "frmCases"
    
    'Change the flag so that new information is loaded
    frmCaseNew.setIsLoaded (False)
    g_CaseID = sLblista.TextMatrix(sLblista.Row, 0)
    frmCaseNew.Show
End Sub

Private Sub Form_Activate()

    setFormProperties
    
    'Get Case listing
    load_Data

End Sub
Function setFormProperties()
    
    isRightScreenToHide ("frmCases")
    setCurrentScreen ("frmCases")
    frmMDI.hideSelfModuleButton
    
    Select Case g_CaseViewMode
        Case "ATTORNEY"
            lblFunction.Caption = "Cases Associated With This Attorney"
            lblWindow.Caption = "Attorney - Cases"
        Case "CLIENT"
            lblFunction.Caption = "Cases Associated With This Client"
            lblWindow.Caption = "Client - Cases"
        Case "JUDGE"
            lblFunction.Caption = "Cases Associated With This Judge"
            lblWindow.Caption = "Judge - Cases"
        
    End Select
    
    'Set Status Bar
    frmMDI.setStatusBar (lblWindow.Caption)
    
End Function

Private Sub load_Data()
Dim w_SQL           As String
Dim w_Recordset     As New Recordset
Dim w_Recordset2    As New Recordset

Dim w_SQLa          As String
Dim w_SQLc          As String
Dim w_SQLt          As String
Dim w_SQLs          As String

Dim w_Caseid        As String
Dim w_Dateopen      As String
Dim w_ClientName    As String
Dim w_AttorneyName  As String
Dim w_Status        As String
Dim w_Type          As String
    
    sLblista.Rows = 1
    
    On Error Resume Next
    
    Select Case g_CaseViewMode
        Case "ATTORNEY"
            w_SQL = "select * from cases where attorneyid = '" & g_AttorneyID & "'"
        
        Case "CLIENT"
            w_SQL = "select * from cases where clientid = '" & g_ClientID & "'"
        
        Case "JUDGE"
            w_SQL = "select * from cases where judgeid = '" & g_JudgeID & "'"
    
    End Select
        
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        'If Error Generated due to no records
        If Err.Number = 3021 Then
            'Simply Exit
            Exit Sub
        End If
 
        Do While .EOF = False
        
            w_Caseid = !caseID
            w_Dateopen = !dateopen
            
            'Lookup the Attorney information from the attorneyid
            w_SQLa = "Select firstname, lastname from attorneys where attorneyid = '" & !attorneyid & "'"
            
            'Lookup the Client information from the clientid
            w_SQLc = "Select firstname, lastname from clients where clientid = '" & !clientid & "'"
            
            'Lookup the type description from the type code
            w_SQLt = "Select description from types where typecode = " & !Type
            
            'Lookup the status description from the status code
            w_SQLs = "Select description from status where statuscode = " & !Status
            
            
            
                With w_Recordset2
                
                'If the attorney ID was supplied in the case,load the attorney info
                If !attorneyid <> vbNullString Then
                    'Get firstname and lastname of attorney
                    .Open w_SQLa, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
                       
                    w_AttorneyName = !firstname & " " & !lastname
                    
                    If .State = 1 Then
                        .Close
                    End If
                    
                End If
            
                    'Get firstname and lastname of client
                    .Open w_SQLc, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
                    w_ClientName = !firstname & " " & !lastname
                    
                    If .State = 1 Then
                        .Close
                    End If
                                  
                    'Get description of type
                    .Open w_SQLt, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
                    w_Type = !Description
                    
                    If .State = 1 Then
                        .Close
                    End If
                                  
                    'Get description of status
                    .Open w_SQLs, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
                    w_Status = !Description
                    
                    If .State = 1 Then
                        .Close
                    End If
                End With
        
            sLblista.AddItem w_Caseid & vbTab & w_ClientName & vbTab & w_AttorneyName & vbTab & Mid(w_Dateopen, 7, 2) & "/" & Mid(w_Dateopen, 5, 2) & "/" & Mid(w_Dateopen, 1, 4) & vbTab & w_Type & vbTab & w_Status
            .MoveNext
        
        Loop
    End With

End Sub

Private Sub Form_Deactivate()
    'Me.Hide
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
End Sub

Private Sub sLblista_DblClick()
    cmdMore_Click
End Sub
