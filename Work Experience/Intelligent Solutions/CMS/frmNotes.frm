VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form frmNotes 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   8265
   ClientLeft      =   -45
   ClientTop       =   -735
   ClientWidth     =   11595
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8265
   ScaleWidth      =   11595
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame2 
      Caption         =   "Details"
      Height          =   3135
      Left            =   7080
      TabIndex        =   19
      Top             =   1560
      Width           =   4335
      Begin VB.TextBox sDetails 
         Height          =   2775
         Left            =   120
         MaxLength       =   255
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   7
         Top             =   240
         Width           =   4095
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "General"
      Height          =   3135
      Left            =   120
      TabIndex        =   17
      Top             =   1560
      Width           =   6855
      Begin VB.ComboBox cbAddYear 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "frmNotes.frx":0000
         Left            =   5880
         List            =   "frmNotes.frx":0002
         Style           =   1  'Simple Combo
         TabIndex        =   10
         ToolTipText     =   "Year"
         Top             =   840
         Width           =   855
      End
      Begin VB.ComboBox cbAddDay 
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "MM/dd/yyyy"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "frmNotes.frx":0004
         Left            =   4680
         List            =   "frmNotes.frx":0006
         Style           =   1  'Simple Combo
         TabIndex        =   8
         ToolTipText     =   "Day"
         Top             =   840
         Width           =   615
      End
      Begin VB.ComboBox cbAddMonth 
         Enabled         =   0   'False
         Height          =   315
         Left            =   5280
         Style           =   1  'Simple Combo
         TabIndex        =   9
         ToolTipText     =   "Month"
         Top             =   840
         Width           =   615
      End
      Begin VB.ComboBox cbModYear 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "frmNotes.frx":0008
         Left            =   5880
         List            =   "frmNotes.frx":000A
         Style           =   1  'Simple Combo
         TabIndex        =   13
         ToolTipText     =   "Year"
         Top             =   1320
         Width           =   855
      End
      Begin VB.ComboBox cbModDay 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "frmNotes.frx":000C
         Left            =   4680
         List            =   "frmNotes.frx":000E
         Style           =   1  'Simple Combo
         TabIndex        =   11
         ToolTipText     =   "Day"
         Top             =   1320
         Width           =   615
      End
      Begin VB.ComboBox cbModMonth 
         Enabled         =   0   'False
         Height          =   315
         Left            =   5280
         Style           =   1  'Simple Combo
         TabIndex        =   12
         ToolTipText     =   "Month"
         Top             =   1320
         Width           =   615
      End
      Begin VB.ComboBox cbRemMonth 
         Height          =   315
         Left            =   5280
         TabIndex        =   5
         ToolTipText     =   "Month"
         Top             =   1800
         Width           =   615
      End
      Begin VB.ComboBox cbRemDay 
         Height          =   315
         ItemData        =   "frmNotes.frx":0010
         Left            =   4680
         List            =   "frmNotes.frx":0012
         TabIndex        =   4
         ToolTipText     =   "Day"
         Top             =   1800
         Width           =   615
      End
      Begin VB.ComboBox cbRemYear 
         Height          =   315
         ItemData        =   "frmNotes.frx":0014
         Left            =   5880
         List            =   "frmNotes.frx":0016
         TabIndex        =   6
         ToolTipText     =   "Year"
         Top             =   1800
         Width           =   855
      End
      Begin VB.TextBox sNoteID 
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
         TabIndex        =   0
         Top             =   600
         Width           =   1095
      End
      Begin VB.TextBox sAddUser 
         Enabled         =   0   'False
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
         TabIndex        =   2
         Top             =   1680
         Width           =   1695
      End
      Begin VB.TextBox sModUser 
         Enabled         =   0   'False
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
         TabIndex        =   3
         Top             =   2040
         Width           =   1695
      End
      Begin VB.TextBox sItemID 
         Enabled         =   0   'False
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
         TabIndex        =   1
         Top             =   960
         Width           =   1095
      End
      Begin VB.Label Label7 
         Caption         =   "Note ID:"
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
         Top             =   720
         Width           =   855
      End
      Begin VB.Label Label6 
         Caption         =   "Reminder Date:"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3720
         TabIndex        =   25
         Top             =   1800
         Width           =   855
      End
      Begin VB.Label Label5 
         Caption         =   "Modifying User:"
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
         TabIndex        =   23
         Top             =   2160
         Width           =   1215
      End
      Begin VB.Label Label4 
         Caption         =   "Adding User:"
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
         TabIndex        =   22
         Top             =   1800
         Width           =   1095
      End
      Begin VB.Label Label3 
         Caption         =   "Modify Date:"
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
         Left            =   3720
         TabIndex        =   21
         Top             =   1320
         Width           =   1095
      End
      Begin VB.Label Label2 
         Caption         =   "Add Date:"
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
         Left            =   3720
         TabIndex        =   20
         Top             =   840
         Width           =   855
      End
      Begin VB.Label Label1 
         Caption         =   "Item ID:"
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
         TabIndex        =   18
         Top             =   1080
         Width           =   855
      End
   End
   Begin VB.Frame Frame6 
      Height          =   1095
      Left            =   120
      TabIndex        =   14
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
         TabIndex        =   16
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
         TabIndex        =   15
         Top             =   240
         Width           =   11055
      End
   End
   Begin MSFlexGridLib.MSFlexGrid sLblista 
      Height          =   3375
      Left            =   1440
      TabIndex        =   24
      Top             =   4800
      Width           =   8685
      _ExtentX        =   15319
      _ExtentY        =   5953
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
      FormatString    =   $"frmNotes.frx":0018
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
Attribute VB_Name = "frmNotes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Deactivate()
    'Me.Hide
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    sLblista.Rows = 1
    setDateCombos
    
End Sub

Private Sub Form_Activate()
    
    'Set Form attributes
    setFormProperties

    'If user is coming from frmReminder
'    If g_NoteMode = "VIEW" And g_NoteCallingModule = "frmReminders" Then
    
        'Just load note information for g_NoteID
'        load_Data
'        frmMDI.makeSaveRecInvisible
    
    'If user is in the view mode for a module, they can only view the notes.
    Select Case g_NoteMode
        Case "VIEW"
        
            'Pull Itemid from note calling module
            pullidFromPrevious
            
            'Show all notes associated with this item
            executeNewQuery ("Select * from notes where itemid = '" & sItemID.Text & "'")
            
            'Disabled the save functionality
            frmMDI.makeSaveRecInvisible
            
        Case "NEW"
            'Clear all fields
            clear_Fields
            
            'Make grid disabled so that user may not view details of another note
            sLblista.Enabled = False
            
            'Set which item this note will be about
            pullidFromPrevious
            
            'Make save enabled
            frmMDI.makeSaveRecVisible
        
            'Place default values in AddDate combos
            setCurrentDateAddDate
            
        Case "MODIFY"
            'User cannot change
            sNoteID.Enabled = False
            sItemID.Enabled = False
                
            'Show all notes associated with this item
            executeNewQuery ("Select * from notes where itemid = '" & sItemID.Text & "'")
  
            'Make save enabled
            frmMDI.makeSaveRecVisible
                    
    End Select

End Sub

Private Sub setCurrentDateAddDate()
'Purpose: Set AddDate combos to current date
    
    cbAddDay.Text = Format(Now, "dd")
    cbAddMonth.Text = Format(Now, "mm")
    cbAddYear.Text = Format(Now, "yyyy")

End Sub


Function setFormProperties()
'Purpose: Set form attributes like Window Label, Function Label, status bar, etc
    
    frmMDI.showModuleButtons
    frmMDI.setSaveRecToolTip ("Save Note")

    isRightScreenToHide ("frmNotes")
    setCurrentScreen ("frmNotes")
    frmMDI.hideSelfModuleButton

    sLblista.Enabled = True
    
    noteChange = False
    
    'Make all fields enabled
    makeFieldsEnabled
    
    Select Case g_NoteMode
        Case "NEW"
            lblFunction.Caption = "Enter Note Details and Press the Save Button"
            lblWindow.Caption = "Notes - Add"
        Case "MODIFY"
            lblFunction.Caption = "Modify Note Details and Press the Save Button"
            lblWindow.Caption = "Notes - Modify"
        Case "DELETE"
            lblFunction.Caption = "Select the Note and Press the Save Button to Delete"
            lblWindow.Caption = "Notes - Delete"
        Case "VIEW"
            lblFunction.Caption = "View The Note Details"
            lblWindow.Caption = "Notes - View"
    End Select

    'Set title of window in Status Bar
    frmMDI.setStatusBar (lblWindow.Caption)
    
End Function

Private Sub makeFieldsEnabled()
    sItemID.Enabled = True
    sNoteID.Enabled = True
    
    sDetails.Enabled = True
    
    cbRemDay.Enabled = True
    cbRemMonth.Enabled = True
    cbRemYear.Enabled = True

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
            Dim zeroResultsMsg As Integer
            zeroResultsMsg = MsgBox("No Entries Exist In Database", 64, "Search Results")
        End If

        'Load new structure into list
        Do While .EOF = False
            'Give a prettier date format 'dd/mm/yyyy' than just 'ddmmyyyy'
            maskedAddDate = Mid(!adddate, 1, 2) & "/" & Mid(!adddate, 3, 2) & "/" & Mid(!adddate, 5, 4)
            maskedRemDate = Mid(!reminderdate, 1, 2) & "/" & Mid(!reminderdate, 3, 2) & "/" & Mid(!reminderdate, 5, 4)
            
            sLblista.AddItem !noteID & vbTab & !itemID & vbTab & !adduser & vbTab & maskedAddDate & vbTab & maskedRemDate
            .MoveNext
        Loop
        If .State = 1 Then
            .Close
        End If
    End With

End Function

Public Sub pullidFromPrevious()
'Purpose: Pull ID from Note Calling Module and set as the Note's Item ID

    Select Case g_NoteCallingModule
        Case "frmAttorneyNew"
            sItemID.Text = frmAttorneyNew.sAttorneyID.Text
        Case "frmClientNew"
            sItemID.Text = frmClientNew.sClientID.Text
        Case "frmCaseNew"
            sItemID.Text = frmCaseNew.sCaseID.Text
        Case "frmJudgesNew"
            sItemID.Text = frmJudgesNew.sJudgeID.Text
        Case "frmReminders"
            sItemID.Text = frmReminders.listReminders.TextMatrix(frmReminders.listReminders.Row, 1)
    End Select
End Sub

Public Sub clear_Fields()
'Purpose: Clear fields to prepare for new note

    'Make sNoteID active again
    sNoteID.Enabled = True
    
    sNoteID.Text = vbNullString
    sDetails.Text = vbNullString
    
    'Set Add Date combos to current Date
    setCurrentDateAddDate
        
    cbModDay.Text = vbNullString
    cbModMonth.Text = vbNullString
    cbModYear.Text = vbNullString
    
    'Set to g_CurrentUser to begin adding a new note
    sAddUser.Text = g_CurrentUser
    
    sModUser.Text = vbNullString
    cbRemDay.Text = vbNullString
    cbRemMonth.Text = vbNullString
    cbRemYear.Text = vbNullString

End Sub

Function clearGrid()
    Dim formatString As String
    formatString = "NoteID            |ItemID               |Adding User                        | Add Date                       |<Reminder Date                       "
    
    'Empty the list
    With sLblista
        .Clear
        .Rows = .FixedRows
        'Redraw Col headings
        .formatString = formatString
    End With

End Function

Private Sub sLblista_DblClick()
    'Get note id from row selected
    g_NoteID = sLblista.TextMatrix(sLblista.Row, 0)
    
    'Set the note mode to modify
    g_NoteMode = "MODIFY"
    
    'User cannot change the noteID if they are modifying the note
    sNoteID.Enabled = False
    
    'Load the note data into the textfields
    load_Data
    
End Sub

Public Sub write_DB()
Dim w_Recordset As New Recordset
Dim w_SQL As String
Dim w_OpenTimestamp As String
Dim w_ModTimestamp As String
Dim w_ReminderDate As String
Dim w_AddDate As String
Dim w_ModifyDate As String

    On Error Resume Next
    
    'Initialize
    w_OpenTimestamp = vbNullString
    w_ModTimestamp = vbNullString
    
    'Get Dates from the combo lists
    w_ReminderDate = cbRemDay.Text & cbRemMonth.Text & cbRemYear.Text
    w_AddDate = cbAddDay.Text & cbAddMonth.Text & cbAddYear.Text
    w_ModifyDate = cbModDay.Text & cbModMonth.Text & cbModYear.Text
    
    Select Case g_NoteMode
        Case "NEW"
            'If this is a new Note for the item
            w_OpenTimestamp = Format(Now, "dd/mm/yyyy hh:mm am/pm")
            'Note hasn't been modified, so leave blank
            w_ModifyDate = vbNullString
            sModUser.Text = vbNullString
            
            'Insert Query
            w_SQL = "Insert into notes values ('" & _
                sNoteID.Text & "', '" & _
                sItemID.Text & "', '" & _
                w_AddDate & "', '" & _
                w_OpenTimestamp & "', '" & _
                w_ModifyDate & "', '" & _
                w_ModTimestamp & "', '" & _
                w_ReminderDate & "', '" & _
                sAddUser.Text & "', '" & _
                sModUser.Text & "', '" & _
                sDetails.Text & "')"
            
        Case "MODIFY"
            'If this is a modification to an existing note
            w_ModTimestamp = Format(Now, "dd/mm/yyyy hh:mm am/pm")

            'Update Query
            w_SQL = "Update notes set " & _
                "details =" & Chr(34) & sDetails.Text & Chr(34) & _
                ", moddate =" & Chr(34) & w_ModifyDate & Chr(34) & _
                ", moduser =" & Chr(34) & sModUser & Chr(34) & _
                ", reminderdate = " & Chr(34) & w_ReminderDate & Chr(34) & _
                " Where noteid = " & Chr(34) & sNoteID.Text & Chr(34) & ";"
                
        Case "DELETE"
        
            'Delete Query
            w_SQL = "Delete * from notes where noteid = " & Chr(34) & sLblista.TextMatrix(sLblista.Row, 0) & Chr(34) & ";"
    
    End Select
    
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        'If the ID creates a Duplicate Entry
        If Err.Number = -2147467259 Then
            'Display Error Msg
            MsgBox "Note ID Already Exists" & vbCr & "Enter New ID", vbExclamation, "Duplicate ID"
            Exit Sub
        End If
        
        If .State = 1 Then
              .Close
        End If
    End With
    
    'Write a log in the system
    system_db.write_systemLog g_NoteMode, dbModuleNote, sItemID.Text
    
    'Show Sucess
    showSuccess
    
    'Return to previous screen
    returnToPreviousScreen
    
    Exit Sub
    
'errHandler:
'Dim errorMsg As Integer
'    errorMsg = MsgBox("Note Not Entered", vbExclamation, "Note Error")
    
End Sub

Public Sub deleteNote()
'Purpose:   Called by frmMDI when user clicks the delete toolbar button
Dim w_SQL       As String
Dim w_Recordset As New Recordset
Dim confMsg     As Integer
Dim noteID      As String

    On Error GoTo errHandler
    
    confMsg = MsgBox("Please Confirm Delete Instruction", vbOKCancel, "Confirmation Dialog")
    
    If confMsg = 1 Then
            
        noteID = sLblista.TextMatrix(sLblista.Row, 0)
            
        'Create query to delete information according to id
        w_SQL = "Delete * From notes Where noteid=" & Chr(34) & noteID & Chr(34) & ";"
    
        With w_Recordset
            'Execute the query
            .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            
            If .State = 1 Then
                .Close
            End If
        End With
        
        system_db.write_systemLog g_SystemDelete, dbModuleNote, noteID
        
        'Show success
        MsgBox "Note Information Deleted Successfully", vbOKOnly, "Deletion Confirmation"
        
    End If
    
    'Refresh list of notes
    executeNewQuery ("Select * from notes where itemid = '" & sItemID.Text & "'")

    Exit Sub

errHandler:
MsgBox "Error In Deleting Note", vbCritical, "Error"
    
End Sub

Public Sub deleteANote(noteID As String)
'Purpose: Deletes the note identified by noteID. Writes delete log.
Dim w_SQL       As String
Dim w_Recordset As New Recordset

    On Error GoTo errHandler
        
    'Delete Note information
    w_SQL = "Delete * From notes Where noteid=" & Chr(34) & noteID & Chr(34) & ";"
    
    With w_Recordset
        'Execute the query
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        If .State = 1 Then
            .Close
        End If
    End With
    
    Exit Sub

errHandler:
    MsgBox "Error In Deleting Note", vbCritical, "Error"
    
End Sub

Public Sub returnToPreviousScreen()
'Purpose: Show the screen that you came from.
    
    'Hide Me
    frmNotes.Hide
    
    'Show previous
    Select Case g_NoteCallingModule
        Case "frmAttorneyNew"
            frmAttorneyNew.Show
        Case "frmClientNew"
            frmClientNew.Show
        Case "frmCaseNew"
            frmCaseNew.Show
        Case "frmJudgesNew"
            frmJudgesNew.Show
        Case "frmReminders"
            frmReminders.Show
    End Select
End Sub

Public Sub showSuccess()
Dim successMsg As Integer
    Select Case g_NoteMode
        Case "NEW"
            successMsg = MsgBox("Note Entered Successfully", vbOKOnly, "Note Confirmation")
        Case "MODIFY"
            successMsg = MsgBox("Note Modified Successfully", vbOKOnly, "Note Confirmation")
        Case "DELETE"
            successMsg = MsgBox("Note Deleted Successfully", vbOKOnly, "Note Confirmation")
    End Select
    
    'Clear all the textfields
    clear_Fields
    
End Sub

Public Sub load_Data()
'Purpose: Load existing Note data
Dim w_Recordset As New Recordset
Dim w_SQL As String
        
    On Error GoTo errHandler
    
    w_SQL = "Select * from notes where noteid = '" & g_NoteID & "'"
    
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            sItemID.Text = !itemID
            sDetails.Text = !details
            cbAddDay.Text = Mid(!adddate, 1, 2)
            cbAddMonth.Text = Mid(!adddate, 3, 2)
            cbAddYear.Text = Mid(!adddate, 5, 4)
            sAddUser.Text = !adduser
            cbRemDay.Text = Mid(!reminderdate, 1, 2)
            cbRemMonth.Text = Mid(!reminderdate, 3, 2)
            cbRemYear.Text = Mid(!reminderdate, 5, 4)
            
        If .State = 1 Then
            .Close
        End If
    End With
    
    'Set the NoteId textfield
    sNoteID.Text = g_NoteID
    
    If g_NoteMode <> "VIEW" Then
    
        'Since user wants to modify note, fill in modify fields.
        'Modify date is current date
        cbModDay.Text = Format(Now, "dd")
        cbModMonth.Text = Format(Now, "mm")
        cbModYear.Text = Format(Now, "yyyy")
        
        'Modifying user is the current system user
        sModUser.Text = g_CurrentUser
    End If
    Exit Sub

errHandler:
Dim errorMsg As Integer
    errorMsg = MsgBox("Note Information Not Loaded", vbExclamation, "Load Error")
    
End Sub

Function setDateCombos()
'Purpose: Add the month, day, and year items to the combos.
Dim counter As Integer
    
    'Initialize
    counter = 1
    
    'Load Months
    Do While counter <= 12
        If counter < 10 Then
            'Add a '0' to the beginning of the string
            'cbAddMonth.AddItem ("0" & CStr(counter))
            'cbModMonth.AddItem ("0" & CStr(counter))
            cbRemMonth.AddItem ("0" & CStr(counter))
        Else
            'cbAddMonth.AddItem (CStr(counter))
            'cbModMonth.AddItem (CStr(counter))
            cbRemMonth.AddItem (CStr(counter))
        End If
        
        counter = counter + 1
    Loop
    
    'Reset Counter
    counter = 1
    
    'Load Days
    Do While counter <= 31
        If counter < 10 Then
            'cbAddDay.AddItem ("0" & CStr(counter))
            'cbModDay.AddItem ("0" & CStr(counter))
            cbRemDay.AddItem ("0" & CStr(counter))
        Else
            'cbAddDay.AddItem (CStr(counter))
            'cbModDay.AddItem (CStr(counter))
            cbRemDay.AddItem (CStr(counter))
        
        End If
        counter = counter + 1
    Loop
    
    'Reset Counter
    counter = 1
    
    'Load Years
    'Load only years starting from current year to 15 years back
    Dim currYear As Integer
    currYear = Val(Format(Now, "yyyy"))
    
    Do While counter <= 15
        'cbAddYear.AddItem (CStr(currYear))
        'cbModYear.AddItem (CStr(currYear))
        cbRemYear.AddItem (CStr(currYear))
        currYear = currYear - 1
        counter = counter + 1
    Loop

End Function


Private Sub sDetails_Change()
    noteChange = True
End Sub

Private Sub sItemID_Change()
    noteChange = True
End Sub

Private Sub sNoteID_Change()
    noteChange = True
End Sub

Private Sub cbRemDay_Change()
    noteChange = True
End Sub

Private Sub cbRemMonth_Change()
    noteChange = True
End Sub

Private Sub cbRemYear_Change()
    noteChange = True
End Sub

