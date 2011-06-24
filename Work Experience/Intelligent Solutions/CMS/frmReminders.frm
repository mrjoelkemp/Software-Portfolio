VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form frmReminders 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Reminders"
   ClientHeight    =   5910
   ClientLeft      =   2760
   ClientTop       =   3750
   ClientWidth     =   8145
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5910
   ScaleWidth      =   8145
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame6 
      Height          =   855
      Left            =   240
      TabIndex        =   2
      Top             =   120
      Width           =   7635
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
         Height          =   495
         Left            =   480
         TabIndex        =   3
         Top             =   240
         Width           =   6675
      End
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   1440
      TabIndex        =   1
      Top             =   5400
      Width           =   1215
   End
   Begin VB.CommandButton cmdViewDetails 
      Caption         =   "View Details"
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   5400
      Width           =   1215
   End
   Begin MSFlexGridLib.MSFlexGrid listReminders 
      Height          =   4215
      Left            =   240
      TabIndex        =   4
      Top             =   1080
      Width           =   7725
      _ExtentX        =   13626
      _ExtentY        =   7435
      _Version        =   393216
      Cols            =   5
      FixedCols       =   0
      ForeColor       =   0
      ForeColorFixed  =   0
      BackColorSel    =   12648447
      ForeColorSel    =   0
      FocusRect       =   0
      GridLines       =   2
      SelectionMode   =   1
      AllowUserResizing=   1
      FormatString    =   "NoteID            |ItemID               |Adding User                 | Add Date                  |<Reminder Date              "
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
Attribute VB_Name = "frmReminders"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit


Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdViewDetails_Click()
    listReminders_DblClick
End Sub

Private Sub Form_Deactivate()
'Purpose: When you click outside of the form, hide the form.

    Me.Hide
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    listReminders.Rows = 1
    
    setFormProperties

    load_Reminders
    
End Sub

Function setFormProperties()
    If g_ReminderMode = "ALL" Then
        Me.Caption = "All Reminders"
    ElseIf g_ReminderMode = "TODAY" Then
        Me.Caption = "Today's Reminders"
    End If
    
    lblFunction.Caption = "Double-Click A Reminder To View Its Details"
    frmMDI.setStatusBar ("Reminders - View")
End Function


Private Sub listReminders_DblClick()

    'Set the noteID to the selected item
    g_NoteID = listReminders.TextMatrix(listReminders.Row, 0)
    g_NoteCallingModule = "frmReminders"
    g_NoteMode = "VIEW"
    frmNotes.Show
    
End Sub

Public Sub load_Reminders()
'Purpose: Load either notes based on reminderDate or all notes.
Dim w_SQL As String

    Select Case g_ReminderMode
        
        Case "TODAY"
            Dim today As String
            today = Format(Now, "ddmmyyyy")
            w_SQL = "Select * from notes where reminderdate = '" & today & "'"
            
        Case "ALL"
            w_SQL = "Select * from notes"
            
    End Select

    'Execute query and modify grid accordingly
    executeNewQuery (w_SQL)

End Sub

Function executeNewQuery(query)
'Purpose: Execute a Query and make the grid update accordingly
Dim w_Recordset As New Recordset
Dim maskedAddDate As String
Dim maskedRemDate As String

    'First clear the current list
    clearGrid
    
    'Get Recordset with new ordering
    With w_Recordset
        .Open query, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        'If there are no results, then display message
        If .EOF Then
            'Dim zeroResultsMsg As Integer
            'zeroResultsMsg = MsgBox("No Entries Exist In Database", vbInformation, "Search Results")
        End If

        'Load new structure into list
        Do While .EOF = False
            'Give a prettier date format 'dd/mm/yyyy' than just 'ddmmyyyy'
            maskedAddDate = Mid(!adddate, 1, 2) & "/" & Mid(!adddate, 3, 2) & "/" & Mid(!adddate, 5, 4)
            maskedRemDate = Mid(!reminderdate, 1, 2) & "/" & Mid(!reminderdate, 3, 2) & "/" & Mid(!reminderdate, 5, 4)
            
            listReminders.AddItem !noteid & vbTab & !itemID & vbTab & !adduser & vbTab & maskedAddDate & vbTab & maskedRemDate
            .MoveNext
        Loop
        If .State = 1 Then
            .Close
        End If
    End With

End Function

Function clearGrid()
    Dim formatString As String
    formatString = "NoteID            |ItemID               |Adding User                 | Add Date                  |<Reminder Date              "
    
    'Empty the list
    With listReminders
        .Clear
        .Rows = .FixedRows
        'Redraw Col headings
        .formatString = formatString
    End With

End Function
