VERSION 5.00
Begin VB.Form frmJudgesNew 
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
   Begin VB.Frame Frame5 
      Caption         =   "Additional:"
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
      TabIndex        =   43
      Top             =   6720
      Width           =   7815
      Begin VB.CommandButton cmdNotes 
         Height          =   615
         Left            =   6840
         Picture         =   "frmJudges.frx":0000
         Style           =   1  'Graphical
         TabIndex        =   46
         ToolTipText     =   "Notes"
         Top             =   240
         Width           =   735
      End
      Begin VB.CommandButton cmdCases 
         Height          =   615
         Left            =   6120
         Picture         =   "frmJudges.frx":08CA
         Style           =   1  'Graphical
         TabIndex        =   45
         ToolTipText     =   "View Cases"
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame Frame7 
      Caption         =   "Additional Information"
      Height          =   2055
      Left            =   120
      TabIndex        =   42
      Top             =   4560
      Width           =   7815
      Begin VB.TextBox sAddInfo 
         Height          =   1695
         Left            =   120
         MaxLength       =   255
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   19
         Top             =   240
         Width           =   7575
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Contact:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1935
      Left            =   8040
      TabIndex        =   37
      Top             =   1560
      Width           =   3375
      Begin VB.TextBox sMobile 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   340
         Left            =   1440
         TabIndex        =   16
         Top             =   600
         Width           =   1815
      End
      Begin VB.TextBox sEmail 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   340
         Left            =   1440
         TabIndex        =   18
         Top             =   1320
         Width           =   1815
      End
      Begin VB.TextBox sFax 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   340
         Left            =   1440
         TabIndex        =   17
         Top             =   960
         Width           =   1815
      End
      Begin VB.TextBox sPhone 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   340
         Left            =   1440
         TabIndex        =   15
         Top             =   240
         Width           =   1815
      End
      Begin VB.Label Label11 
         Caption         =   "E-mail:"
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
         Left            =   240
         TabIndex        =   41
         Top             =   1440
         Width           =   855
      End
      Begin VB.Label Label12 
         Caption         =   "Fax:"
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
         Left            =   240
         TabIndex        =   40
         Top             =   1080
         Width           =   855
      End
      Begin VB.Label Label13 
         Caption         =   "Phone:"
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
         Left            =   240
         TabIndex        =   39
         Top             =   360
         Width           =   855
      End
      Begin VB.Label Label15 
         Caption         =   "Alt. Phone:"
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
         Left            =   240
         TabIndex        =   38
         Top             =   720
         Width           =   855
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Living:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   4080
      TabIndex        =   30
      Top             =   1560
      Width           =   3855
      Begin VB.TextBox sAddress3 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   340
         Left            =   1800
         TabIndex        =   11
         Top             =   960
         Width           =   1815
      End
      Begin VB.TextBox sAddress2 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   340
         Left            =   1800
         TabIndex        =   10
         Top             =   600
         Width           =   1815
      End
      Begin VB.TextBox sAddress1 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   340
         Left            =   1800
         TabIndex        =   9
         Top             =   240
         Width           =   1815
      End
      Begin VB.ComboBox cbCity 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1800
         TabIndex        =   14
         Top             =   2160
         Width           =   1815
      End
      Begin VB.ComboBox cbCountry 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1800
         TabIndex        =   12
         Top             =   1440
         Width           =   1815
      End
      Begin VB.ComboBox cbDistrict 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1800
         TabIndex        =   13
         Top             =   1800
         Width           =   1815
      End
      Begin VB.Label Label4 
         Caption         =   "Address 3:"
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
         Left            =   240
         TabIndex        =   36
         Top             =   1080
         Width           =   855
      End
      Begin VB.Label Label5 
         Caption         =   "Address 2:"
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
         Left            =   240
         TabIndex        =   35
         Top             =   720
         Width           =   855
      End
      Begin VB.Label Label6 
         Caption         =   "Address 1:"
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
         Left            =   240
         TabIndex        =   34
         Top             =   360
         Width           =   855
      End
      Begin VB.Label Label7 
         Caption         =   "City:"
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
         Left            =   240
         TabIndex        =   33
         Top             =   2280
         Width           =   855
      End
      Begin VB.Label Label8 
         Caption         =   "Country:"
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
         Left            =   240
         TabIndex        =   32
         Top             =   1560
         Width           =   855
      End
      Begin VB.Label Label10 
         Caption         =   "State:"
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
         Left            =   240
         TabIndex        =   31
         Top             =   1920
         Width           =   855
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "General:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   120
      TabIndex        =   23
      Top             =   1560
      Width           =   3855
      Begin VB.ComboBox cbYear 
         Height          =   315
         ItemData        =   "frmJudges.frx":1194
         Left            =   2880
         List            =   "frmJudges.frx":1196
         TabIndex        =   6
         ToolTipText     =   "Year"
         Top             =   1680
         Width           =   855
      End
      Begin VB.ComboBox cbDay 
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "MM/dd/yyyy"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
         Height          =   315
         ItemData        =   "frmJudges.frx":1198
         Left            =   1680
         List            =   "frmJudges.frx":119A
         TabIndex        =   4
         ToolTipText     =   "Day"
         Top             =   1680
         Width           =   615
      End
      Begin VB.ComboBox cbMonth 
         Height          =   315
         Left            =   2280
         TabIndex        =   5
         ToolTipText     =   "Month"
         Top             =   1680
         Width           =   615
      End
      Begin VB.ComboBox cbSex 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1920
         TabIndex        =   8
         Top             =   2400
         Width           =   1815
      End
      Begin VB.TextBox sJudgeID 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   340
         Left            =   1800
         TabIndex        =   0
         Top             =   240
         Width           =   1815
      End
      Begin VB.TextBox sLastName 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   340
         Left            =   1800
         TabIndex        =   1
         Top             =   600
         Width           =   1815
      End
      Begin VB.TextBox sFirstName 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   340
         Left            =   1800
         TabIndex        =   2
         Top             =   960
         Width           =   1815
      End
      Begin VB.TextBox sOtherName 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   340
         Left            =   1800
         TabIndex        =   3
         Top             =   1320
         Width           =   1815
      End
      Begin VB.ComboBox cbNationality 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1920
         TabIndex        =   7
         Top             =   2040
         Width           =   1815
      End
      Begin VB.Label Label16 
         Caption         =   "Sex:"
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
         Left            =   240
         TabIndex        =   44
         Top             =   2520
         Width           =   1575
      End
      Begin VB.Label Label1 
         Caption         =   "ID:"
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
         Left            =   240
         TabIndex        =   29
         Top             =   360
         Width           =   855
      End
      Begin VB.Label Label2 
         Caption         =   "Last Name:"
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
         Left            =   240
         TabIndex        =   28
         Top             =   720
         Width           =   855
      End
      Begin VB.Label Label3 
         Caption         =   "First Name:"
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
         Left            =   240
         TabIndex        =   27
         Top             =   1080
         Width           =   855
      End
      Begin VB.Label Label9 
         Caption         =   "Date of Birth:"
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
         Left            =   240
         TabIndex        =   26
         Top             =   1800
         Width           =   1575
      End
      Begin VB.Label label 
         Caption         =   "M.I.:"
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
         Left            =   240
         TabIndex        =   25
         Top             =   1440
         Width           =   1455
      End
      Begin VB.Label Label14 
         Caption         =   "Nationality:"
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
         Left            =   240
         TabIndex        =   24
         Top             =   2160
         Width           =   1575
      End
   End
   Begin VB.Frame Frame6 
      Height          =   1095
      Left            =   120
      TabIndex        =   20
      Top             =   360
      Width           =   11295
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
         TabIndex        =   22
         Top             =   600
         Width           =   11055
      End
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
         TabIndex        =   21
         Top             =   240
         Width           =   11055
      End
   End
End
Attribute VB_Name = "frmJudgesNew"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cbCountry_Click()
'Purpose: Load Districts for chosen Country
Dim w_Recordset As New Recordset
Dim w_SQL As String

    On Error GoTo errHandler
    
    'Empty the combo contents
    cbDistrict.Clear
    
    'Pull Up Districts in that Country
    w_SQL = "Select * from districts where countrycode = " & getCode("COUNTRY")
    
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        Do Until .EOF
            'Populate the Districts Combo
            cbDistrict.AddItem (!Description)
            .MoveNext
        Loop
        
        If .State = 1 Then
            .Close
        End If
    End With
    
    Exit Sub

errHandler:
MsgBox "District Information Not Loaded", vbCritical, "Load Error"

End Sub

Private Sub cbDistrict_Click()
'Purpose: Load appropriate Cities for chosen District
Dim w_Recordset As New Recordset
Dim w_SQL As String

    On Error GoTo errHandler
    
    'Clear the combo contents
    cbCity.Clear
    
    'Pull Up Districts in that Country
    w_SQL = "Select * from cities where districtcode = " & getCode("DISTRICT")
        
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        Do Until .EOF
            'Populate the Cities Combo
            cbCity.AddItem (!Description)
            .MoveNext
        Loop
        
        If .State = 1 Then
            .Close
        End If
    End With

    Exit Sub

errHandler:
MsgBox "City Information Not Loaded", vbCritical, "Load Error"

End Sub

Private Sub cmdCases_Click()
    frmCases.Show
    g_CaseViewMode = "JUDGE"
End Sub

Private Sub cmdNotes_Click()
    If g_JudgeMode = "VIEW" Then
        g_NoteMode = "VIEW"
    Else
        g_NoteMode = "NEW"
    End If
    g_ButtonMode = "NOTES"
    g_NoteCallingModule = "frmJudgesNew"
    frmNotes.Show
End Sub


Public Sub write_DB()
'Purpose: Carry out Database Operations (Insert, Update, Delete)
Dim w_SQL As String
Dim w_Recordset As New Recordset

    'Based on mode
    Select Case g_JudgeMode
        'Construct appropriate SQL query
        Case "NEW"
           w_SQL = getSQL("INSERT")
        
        Case "MODIFY"
           w_SQL = getSQL("MODIFY")
            
        Case "DELETE"
           w_SQL = getSQL("DELETE")
            
    End Select

    'If DB Error occurs resume operation
    On Error Resume Next
    
    'Perform Database operation
     With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        'If the Judge ID creates a Duplicate Entry
        If Err.Number = -2147467259 Then
            'Display Error Msg
            MsgBox "Judge ID Already Exists" & vbCr, vbExclamation, "Duplicate ID"
            Exit Sub
        End If
       
       If .State = 1 Then
            .Close
        End If
    End With
    
    'Write a log in the system
    system_db.write_systemLog g_JudgeMode, dbModuleJudge, sJudgeID.Text

    'Show respective confirmation message
    showSuccess
    frmMDI.showModuleButtons
    
    'Return to search screen
    returnToPreviousScreen
    
End Sub

Public Sub deleteJudge()
'Purpose:   Called by frmMDI when user clicks the delete toolbar button
'           FrmMDI sets the global attorney id (ie, the client that
'           was selected in frmClientSearch)
Dim w_SQL       As String
Dim w_Recordset As New Recordset
Dim confMsg     As Integer

    On Error GoTo errHandler
    
    confMsg = MsgBox("Please Confirm Delete Instruction", vbOKCancel, "Confirmation Dialog")
    
    If confMsg = 1 Then
    
        'Create query to delete attorney information according to id
        w_SQL = "Delete * From judges Where judgeid=" & Chr(34) & g_JudgeID & Chr(34) & ";"
    
        With w_Recordset
            'Execute the query
            .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            
            If .State = 1 Then
                .Close
            End If
            
            'Create query to delete notes according to id
            w_SQL = "Delete * from notes where itemid =" & Chr(34) & g_JudgeID & Chr(34) & ";"

            'Execute the query
            .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
    
            If .State = 1 Then
                .Close
            End If
        End With
        
        'Show success
        MsgBox "Judge Information Deleted Successfully", vbOKOnly, "Deletion Confirmation"
        
    End If

    Exit Sub

errHandler:
MsgBox "Error In Deleting Judge", vbCritical, "Error"
    
End Sub
Public Sub returnToPreviousScreen()
    
    frmJudgesNew.Hide
    frmJudgesSearch.Show
End Sub

Function getSQL(typeSQL)

Dim w_SQL As String
Dim w_Recordset As New Recordset
Dim w_DateofBirth As String

Dim countryCode As String
Dim nationalityCode As String
Dim cityCode As String
Dim districtCode As String
Dim sexCode As String

    w_DateofBirth = cbYear.Text & cbMonth.Text & cbDay.Text

    countryCode = getCode("COUNTRY")
    nationalityCode = getCode("NATIONALITY")
    cityCode = getCode("CITY")
    districtCode = getCode("DISTRICT")
    sexCode = getCode("SEX")
        
    Select Case typeSQL
    
        Case "INSERT"
            getSQL = "Insert into judges values ('" & _
                sJudgeID.Text & "', '" & _
                sLastName.Text & "', '" & _
                sFirstName.Text & "', '" & _
                sOtherName.Text & "', '" & _
                w_DateofBirth & "', '" & _
                sexCode & "', '" & _
                nationalityCode & "', '" & _
                sAddress1.Text & "', '" & _
                sAddress2.Text & "', '" & _
                sAddress3.Text & "', '" & _
                cityCode & "', '" & _
                districtCode & "', '" & _
                countryCode & "', '" & _
                sPhone.Text & "', '" & _
                sMobile.Text & "', '" & _
                sFax.Text & "', '" & _
                sEmail.Text & "', '" & _
                sAddInfo.Text & "')"
    
        Case "MODIFY"
            getSQL = "Update judges Set " & _
                "lastname=" & Chr(34) & sLastName.Text & Chr(34) & _
                ", firstname=" & Chr(34) & sFirstName.Text & Chr(34) & _
                ", Othername=" & Chr(34) & sOtherName.Text & Chr(34) & _
                ", dateofbirth=" & Chr(34) & w_DateofBirth & Chr(34) & _
                ", nationality=" & Chr(34) & nationalityCode & Chr(34) & _
                ", sex=" & Chr(34) & sexCode & Chr(34) & _
                ", phone=" & Chr(34) & sPhone.Text & Chr(34) & _
                ", mobile=" & Chr(34) & sMobile.Text & Chr(34) & _
                ", fax=" & Chr(34) & sFax.Text & Chr(34) & _
                ", email=" & Chr(34) & sEmail.Text & Chr(34) & _
                ", address1=" & Chr(34) & sAddress1.Text & Chr(34) & _
                ", address2=" & Chr(34) & sAddress2.Text & Chr(34) & _
                ", address3=" & Chr(34) & sAddress3.Text & Chr(34) & _
                ", city=" & Chr(34) & cityCode & Chr(34) & _
                ", district=" & Chr(34) & districtCode & Chr(34) & _
                ", country=" & Chr(34) & countryCode & Chr(34) & _
                ", additional=" & Chr(34) & sAddInfo.Text & Chr(34) & _
                " Where judgeid=" & Chr(34) & sJudgeID.Text & Chr(34) & ";"
        
        Case "DELETE"
            getSQL = "Delete * From judges Where judgeid=" & Chr(34) & sJudgeID.Text & Chr(34) & ";"
    End Select
    
End Function

Function getCode(codeType As String)
Dim w_SQL As String
Dim w_Recordset As New Recordset
    
    On Error GoTo errHandler
    
    Select Case codeType
        Case "COUNTRY"
            w_SQL = "Select countrycode from countries where description = " & Chr(34) & _
                cbCountry.Text & Chr(34)
        Case "CITY"
            w_SQL = "Select citycode from cities where description = " & Chr(34) & _
                cbCity.Text & Chr(34)
        Case "NATIONALITY"
            w_SQL = "Select nationalitycode from nationalities where description = " & Chr(34) & _
                cbNationality.Text & Chr(34)
        Case "DISTRICT"
            w_SQL = "Select districtcode from districts where description = " & Chr(34) & _
                cbDistrict.Text & Chr(34)
        Case "SEX"
            w_SQL = "Select sexcode from sex where description = " & Chr(34) & _
                cbSex.Text & Chr(34)
    End Select
    
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
       
        If Not .EOF Then
            Select Case codeType
                Case "SEX"
                    getCode = !sexCode
                Case "DISTRICT"
                    getCode = !districtCode
                Case "CITY"
                    getCode = !cityCode
                Case "COUNTRY"
                    getCode = !countryCode
                Case "NATIONALITY"
                    getCode = !nationalityCode
            End Select
        End If
       
        If .State = 1 Then
            .Close
        End If
    End With
    
    Exit Function

errHandler:
Dim errorMsg As Integer
    errorMsg = MsgBox("Code Not Loaded", vbExclamation, "Code Error")

End Function

Function showError()
Dim errorMsg As Integer
    'Based on mode
    Select Case g_JudgeMode
        'Show appropriate error dialog box
        Case "NEW"
            errorMsg = MsgBox("Judge Information Not Entered" & vbCr & "     Please check the ID Number", 0, "Creation Error")
        Case "MODIFY"
            errorMsg = MsgBox("Judge Information Not Modified" & vbCr & "     Database Error", 0, "Modification Error")
        Case "DELETE"
            errorMsg = MsgBox("Judge Information Not Deleted" & vbCr & "     Database Error", 0, "Deletion Error")
    End Select

End Function

Function showSuccess()
Dim doneMsg As Integer
       'Based on mode
       Select Case g_JudgeMode
        'Show appropriate confirmation dialog box
        Case "NEW"
            doneMsg = MsgBox("Judge Information Entered Successfully", 0, "Entry Confirmation")
            clear_Fields
        Case "MODIFY"
            doneMsg = MsgBox("Judge Information Modified Successfully", 0, "Modification Confirmation")
            clear_Fields
            Hide
            showSelectScreen
        Case "DELETE"
            doneMsg = MsgBox("Judge Information Deleted Successfully", 0, "Deletion Confirmation")
            clear_Fields
            Hide
            showSelectScreen
    End Select

End Function

Function clear_Fields()
    'Function will clear the text fields (reset)
            sJudgeID.Text = vbNullString
            sLastName.Text = vbNullString
            sFirstName.Text = vbNullString
            sOtherName.Text = vbNullString
            cbDay.Text = vbNullString
            cbMonth.Text = vbNullString
            cbYear.Text = vbNullString
            sPhone.Text = vbNullString
            sMobile.Text = vbNullString
            sFax.Text = vbNullString
            sEmail.Text = vbNullString
            sAddress1.Text = vbNullString
            sAddress2.Text = vbNullString
            sAddress3.Text = vbNullString
            cbCity.Text = "Select"
            cbDistrict.Text = "Select"
            cbCountry.Text = "Select"
            cbNationality.Text = "Select"
            cbSex.Text = "Select"
            sAddInfo.Text = vbNullString
            
End Function

Private Sub Form_Deactivate()
    'Me.Hide
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0

    setDateCombos
End Sub

Private Sub Form_Activate()
    'Upon Form Activation
    
    setFormProperties
    
    sJudgeID.Enabled = True

    Select Case g_JudgeMode
        
        Case "NEW"
            lblWindow.Caption = "Judges - Add"
            lblFunction.Caption = "Enter Judge Details and Press Save"
            frmMDI.setSaveRecToolTip ("Save Record")
            
        Case "MODIFY"
            load_Data
            'User cannot change the ID of a Judge
            sJudgeID.Enabled = False
            lblWindow.Caption = "Judges - Modify Details"
            frmMDI.setSaveRecToolTip ("Modify Record")
            lblFunction.Caption = "Modify Judge Details and Press Save"
                
        Case "VIEW"
            Me.clear_Fields
            load_Data
            frmMDI.makeSaveRecInvisible
            frmMDI.makePrintButtonVisible
            lblWindow.Caption = "Judges - View Details"
            lblFunction.Caption = "Judge Details Listed Below"
    End Select
      
End Sub

Function setFormProperties()

    Load_Combo_Info
    
    frmMDI.showModuleButtons
    isRightScreenToHide ("frmJudgesNew")
    
    setCurrentScreen ("frmJudgesNew")
    frmMDI.hideSelfModuleButton
    
    judgeChange = False
    
    'Set title of window in Status Bar
    frmMDI.setStatusBar (lblWindow.Caption)
End Function

Private Sub load_Data()
Dim w_SQL As String
Dim w_SQLc As String
Dim w_SQLco As String
Dim w_SQLd As String
Dim w_SQLn As String
Dim w_SQLs As String

Dim w_Recordset As New Recordset

    On Error GoTo errHandler

    w_SQL = "select * from judges where judgeid = '" & g_JudgeID & "'"
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        If Not .EOF Then
            sJudgeID.Text = !judgeid
            sLastName.Text = !lastname
            sFirstName.Text = !firstname
            sOtherName.Text = !Othername
            cbDay.Text = Mid(!dateofbirth, 7, 2)
            cbMonth.Text = Mid(!dateofbirth, 5, 2)
            cbYear.Text = Mid(!dateofbirth, 1, 4)
            sPhone.Text = !phone
            sMobile.Text = !mobile
            sFax.Text = !fax
            sEmail.Text = !email
            sAddress1.Text = !address1
            sAddress2.Text = !address2
            sAddress3.Text = !address3
            sAddInfo.Text = !additional
            
            w_SQLc = "Select description from cities where citycode = " & !city
            w_SQLn = "Select description from nationalities where nationalitycode = " & !nationality
            w_SQLco = "Select description from countries where countrycode = " & !country
            w_SQLd = "Select description from districts where districtcode = " & !district
            w_SQLs = "Select description from sex where sexcode = " & !sex
        End If
        If .State = 1 Then
            .Close
        End If
    End With
    
    '''''''Lookup Information for City, District, Country, and Nationality'''''''
    
    'Get City Info
    setComboInfo w_SQLc, cbCity
    
    'Get District Info
    setComboInfo w_SQLd, cbDistrict
    
    'Get Country Info
    setComboInfo w_SQLco, cbCountry
    
    'Get Nationality Info
    setComboInfo w_SQLn, cbNationality
    
    'Get Sex Info
    setComboInfo w_SQLs, cbSex
        
    Exit Sub
    
errHandler:
    Dim errorMsg As Integer
    errorMsg = MsgBox("Judge Information Not Loaded", 0, "Error")

End Sub

Function setComboInfo(sqlSelectDescription As String, ByRef comboName As ComboBox)
Dim w_Recordset As New Recordset

    On Error GoTo errHandler
    
    With w_Recordset
        .Open sqlSelectDescription, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        If Not .EOF Then
            comboName.Text = !Description
        End If
        If .State = 1 Then
            .Close
        End If
    End With
    Exit Function

errHandler:
Dim errorMsg As Integer
    errorMsg = MsgBox("Combo Information Not Found", vbExclamation, "Combo Error")
    
End Function

Function setDateCombos()
'Purpose: Add the month, day, and year items to the combos.
Dim counter As Integer
    
    'Initialize
    counter = 1
    
    'Load Months
    Do While counter <= 12
        If counter < 10 Then
            'Add a '0' to the beginning of the string
            cbMonth.AddItem ("0" & CStr(counter))
        Else
            cbMonth.AddItem (CStr(counter))
        End If
        
        counter = counter + 1
    Loop
    
    'Reset Counter
    counter = 1
    
    'Load Days
    Do While counter <= 31
        If counter < 10 Then
            cbDay.AddItem ("0" & CStr(counter))
        Else
            cbDay.AddItem (CStr(counter))
        End If
        
        counter = counter + 1
    Loop
    
    'Reset Counter
    counter = 1
    
    'Load Years
    'Load only years starting from current year to 90 years back
    Dim currYear As Integer
    currYear = Val(Format(Now, "yyyy"))
    
    Do While counter <= 90
        cbYear.AddItem (CStr(currYear))
        currYear = currYear - 1
        counter = counter + 1
    Loop

End Function

Private Function Load_Combo_Info()
Dim w_SQL As String
Dim w_Recordset As New Recordset

    'Clear the combo boxes
    cbNationality.Clear
    cbCity.Clear
    cbDistrict.Clear
    cbCountry.Clear
    cbSex.Clear
    
    'Load Country info
    w_SQL = "select * from countries"
    addComboItems w_SQL, cbCountry
    
    'Load City info
    w_SQL = "select * from cities"
    addComboItems w_SQL, cbCity

    'Load District info
    w_SQL = "select * from districts"
    addComboItems w_SQL, cbDistrict
    
    'Load Nationality info
    w_SQL = "select * from nationalities"
    addComboItems w_SQL, cbNationality
    
    'Load Sex info
    w_SQL = "select * from sex"
    addComboItems w_SQL, cbSex
    
End Function

Function addComboItems(sqlSelect As String, ByRef comboName As ComboBox)
Dim w_Recordset As New Recordset
    
    On Error GoTo errHandler

    With w_Recordset
        .Open sqlSelect, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        Do Until .EOF
            comboName.AddItem Trim(!Description)
            .MoveNext
        Loop
        If .State = 1 Then
            .Close
        End If
    End With
    Exit Function
    
errHandler:
Dim errorMsg As Integer
    errorMsg = MsgBox("Combo Information Not Set", vbExclamation, "Combo Error")
    
End Function

Private Sub sAddInfo_Change()
    judgeChange = True
End Sub

Private Sub sAddress1_Change()
    judgeChange = True
End Sub

Private Sub sAddress2_Change()
    judgeChange = True
End Sub

Private Sub sAddress3_Change()
    judgeChange = True
End Sub

Private Sub sEmail_Change()
    judgeChange = True
End Sub

Private Sub sFax_Change()
    judgeChange = True
End Sub

Private Sub sFirstName_Change()
    judgeChange = True
End Sub

Private Sub sJudgeID_Change()
    judgeChange = True
End Sub

Private Sub sLastName_Change()
    judgeChange = True
End Sub

Private Sub sMobile_Change()
    judgeChange = True
End Sub

Private Sub sOtherName_Change()
    judgeChange = True
End Sub

Private Sub sPhone_Change()
    judgeChange = True
End Sub
