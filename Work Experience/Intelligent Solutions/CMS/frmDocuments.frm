VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form frmDocuments 
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
   Begin VB.Frame Frame1 
      Caption         =   "Document Details:"
      Height          =   2175
      Left            =   480
      TabIndex        =   8
      Top             =   1440
      Width           =   6735
      Begin VB.TextBox sCaseID 
         Enabled         =   0   'False
         Height          =   375
         Left            =   1320
         TabIndex        =   13
         Top             =   600
         Width           =   1095
      End
      Begin VB.TextBox sDescription 
         Height          =   375
         Left            =   1320
         MaxLength       =   255
         ScrollBars      =   2  'Vertical
         TabIndex        =   3
         Top             =   1440
         Width           =   3255
      End
      Begin VB.TextBox sDocID 
         Height          =   375
         Left            =   1320
         TabIndex        =   0
         Top             =   240
         Width           =   1095
      End
      Begin VB.CommandButton cmdBrowse 
         Caption         =   "Browse"
         Height          =   375
         Left            =   4680
         TabIndex        =   2
         Top             =   1080
         Width           =   1575
      End
      Begin VB.TextBox sFilePath 
         Height          =   375
         Left            =   1320
         TabIndex        =   1
         Top             =   1080
         Width           =   3255
      End
      Begin VB.Label Label5 
         Caption         =   "Case ID:"
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
         Left            =   360
         TabIndex        =   12
         Top             =   720
         Width           =   735
      End
      Begin VB.Label Label3 
         Caption         =   "Description:"
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
         Left            =   360
         TabIndex        =   11
         Top             =   1560
         Width           =   855
      End
      Begin VB.Label Label2 
         Caption         =   "Doc ID:"
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
         Left            =   360
         TabIndex        =   10
         Top             =   360
         Width           =   735
      End
      Begin VB.Label Label1 
         Caption         =   "File Path:"
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
         Left            =   360
         TabIndex        =   9
         Top             =   1200
         Width           =   735
      End
   End
   Begin VB.Frame Frame6 
      Height          =   1095
      Left            =   120
      TabIndex        =   4
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
         TabIndex        =   6
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
         TabIndex        =   5
         Top             =   240
         Width           =   11055
      End
   End
   Begin MSFlexGridLib.MSFlexGrid sLblista 
      Height          =   4095
      Left            =   480
      TabIndex        =   7
      Top             =   3600
      Width           =   10605
      _ExtentX        =   18706
      _ExtentY        =   7223
      _Version        =   393216
      Cols            =   4
      FixedCols       =   0
      ForeColor       =   0
      ForeColorFixed  =   0
      BackColorSel    =   12648447
      ForeColorSel    =   0
      FocusRect       =   0
      GridLines       =   2
      SelectionMode   =   1
      AllowUserResizing=   1
      FormatString    =   $"frmDocuments.frx":0000
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
Attribute VB_Name = "frmDocuments"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

    
Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    sLblista.Rows = 1

End Sub

Private Sub Form_Activate()

    setFormProperties
    
    'Pull CaseID from previous screen
    sCaseID.Text = g_CaseID
    
    'Show all documents associated with the case
    showAllCaseDocuments
    
End Sub

Function setFormProperties()
       
    frmMDI.showModuleButtons
    frmMDI.setSaveRecToolTip ("Save Document")
    
    'Reset vars
    cmdBrowse.Enabled = True
    sLblista.Enabled = True
    documentChange = False
    
    isRightScreenToHide ("frmDocuments")
    setCurrentScreen ("frmDocuments")
    frmMDI.hideSelfModuleButton
    
    
    
    Select Case g_DocumentMode
        Case "VIEW"
            lblFunction.Caption = "View Document Details"
            lblWindow = "Documents - View"
            'User cannot click browse in view mode
            cmdBrowse.Enabled = False
            frmMDI.makeSaveRecInvisible
            
        
        Case "NEW"
            lblFunction.Caption = "Enter Document Details and Press Save"
            lblWindow = "Documents - Add"
            'Make Save enabled
            frmMDI.makeSaveRecVisible
            'Users cannot view details
            sLblista.Enabled = False
            
        Case "MODIFY"
            lblFunction.Caption = "Modify Document Details and Press Save"
            lblWindow = "Documents - Modify"
            'Make Save enabled
            frmMDI.makeSaveRecVisible
            
        Case "DELETE"
            lblFunction.Caption = "Select a Document and Press Delete"
            lblWindow = "Documents - Delete"
            frmMDI.makeSaveRecInvisible
    
    End Select
    
    'Set title of window in Status Bar
    frmMDI.setStatusBar (lblWindow.Caption)

End Function

Private Sub cmdBrowse_Click()
    frmDocumentSearch2.Show
End Sub


Public Sub write_DB()
Dim w_SQL           As String
Dim errorMsg        As Integer
Dim numApost        As Integer
Dim apostLocation   As Integer
Dim filePath        As String
Dim newFilePath     As String
Dim w_DocID         As String

    If sDocID = vbNullString Then
        'Display errorMsg
        showError ("ID")
        Exit Sub
    'If the path is empty
    ElseIf sFilePath = vbNullString Then
        'Display errorMsg
        showError ("FILEPATH")
        'Exit Sub
        Exit Sub
    End If
    
    'Grab Filepath
    filePath = sFilePath.Text
    
    'Grab text from control
    w_DocID = sDocID.Text
    
    'Add escape char to all apostrophes - escape with char to escape
    newFilePath = Replace(filePath, "'", "''")
    
    Select Case g_DocumentMode
        Case "NEW"
            w_SQL = "Insert into documents values ('" & _
                w_DocID & "', '" & _
                g_CaseID & "', '" & _
                sDescription.Text & "', '" & _
                newFilePath & "')"
    
        Case "MODIFY"
            w_SQL = "Update documents set " & _
                "description = " & Chr(34) & Trim(sDescription.Text) & Chr(34) & _
                ", path = " & Chr(34) & newFilePath & Chr(34) & _
                " Where documentid = " & Chr(34) & w_DocID & Chr(34) & ";"
    
    End Select
    
    
    'Insert Entry
    executeSQL (w_SQL)
    
    'Write a log in the system
    system_db.write_systemLog "NEW", dbModuleDocument, w_DocID

    Me.Hide
    g_DocumentMode = g_SystemView
    Me.Show
    
    
End Sub

Public Sub deleteDocument()
'Purpose:   Called by frmMDI when user clicks the delete toolbar button
'           FrmMDI sets the global attorney id (ie, the client that
'           was selected in frmClientSearch)
Dim w_SQL       As String
Dim w_Recordset As New Recordset
Dim confMsg     As Integer
Dim doc_ID      As String

    On Error GoTo errHandler
    
    'Ask for confirmation
    confMsg = MsgBox("Please Confirm Delete Instruction", vbOKCancel, "Confirmation Dialog")
    
    'If confirmed
    If confMsg = 1 Then
        
        'Grab the document ID from the selected Row
        doc_ID = sLblista.TextMatrix(sLblista.Row, 0)

        'Create query to delete information according to id
        w_SQL = "Delete * From documents Where documentid=" & Chr(34) & doc_ID & Chr(34) & ";"
    
        With w_Recordset
            'Execute the query
            .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            
            If .State = 1 Then
                .Close
            End If
        End With
        
        system_db.write_systemLog g_SystemDelete, dbModuleDocument, doc_ID
        
        'Show success
        MsgBox "Document Information Deleted Successfully", vbOKOnly, "Deletion Confirmation"
        
        'Refresh document list
        showAllCaseDocuments
        
    End If
    
    Exit Sub

errHandler:
MsgBox "Error In Deleting Document", vbCritical, "Error"
    
End Sub

Public Sub deleteADocument(docID As String)
'Purpose:   Delete a case's document identified by the passed docID. Write log.
Dim w_SQL       As String
Dim w_Recordset As New Recordset

    On Error GoTo errHandler

    'Create query to delete information according to id
    w_SQL = "Delete * from documents where documentid=" & Chr(34) & docID & Chr(34) & ";"

    With w_Recordset
        'Execute the query
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        If .State = 1 Then
            .Close
        End If
    End With
    
    system_db.write_systemLog g_SystemDelete, dbModuleDocument, docID
                            
    Exit Sub

errHandler:
MsgBox "Error In Deleting Document", vbCritical, "Error"
    
End Sub

Private Sub load_Data()
'Purpose: Load Document info into form controls
Dim w_SQL       As String
Dim w_Recordset As New Recordset

    On Error GoTo errHandler
    
    w_SQL = "Select * from documents where documentid = '" & g_DocumentID & "'"
    
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            sDocID.Text = !documentID
            sDescription.Text = !Description
            sFilePath.Text = !Path
            
            
        If .State = 1 Then
            .Close
        End If
    End With
    
    Exit Sub

errHandler:
    MsgBox "Document Information Not Loaded", vbCritical, "Load Error"
End Sub

Function showAllCaseDocuments()
Dim w_Recordset     As New Recordset
Dim w_DefaultQuery  As String

    On Error GoTo errHandler
    
    w_DefaultQuery = "Select * from documents where caseid = '" & g_CaseID & "'"
    
    'First clear the current list
    clearGrid
    
    'Get Recordset with new ordering
    With w_Recordset
        .Open w_DefaultQuery, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        'Load new structure into list
        Do Until .EOF
            sLblista.AddItem !documentID & vbTab & !caseID & vbTab & !Description & vbTab & !Path
            .MoveNext
        Loop
    End With
    
    Exit Function

errHandler:
    showError ("DATABASE-ERROR")

End Function

Function executeSQL(sqlQuery)
'Purpose: Solely execute an sql query

Dim w_Recordset As New Recordset
Dim w_SQL As String

    On Error Resume Next

    'Write to DB
    With w_Recordset
       .Open sqlQuery, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
       
       If Err.Number = -2147467259 Then
            MsgBox "Document ID Already Taken", vbCritical, "ID Error"
            Exit Function
       End If
       
       If .State = 1 Then
            .Close
        End If
    End With
    
    showSuccess
    
    Exit Function

errHandler:
    showError ("DATABASE-ERROR")

End Function

Function clear_Fields()

        sDocID.Text = vbNullString
        sDescription.Text = vbNullString
        sFilePath.Text = vbNullString
End Function

Function clearGrid()
Dim formatString As String
    formatString = "Doc ID        |Case ID       | Description                              |<Path                                                                                                               "
    
    'Empty the list
    With sLblista
        .Clear
        .Rows = .FixedRows
        'Redraw Col headings
        .formatString = formatString
    End With
End Function

Function showError(errorType)
Dim errorMsg As Integer
    
    Select Case errorType
    
        Case "ID"
            errorMsg = MsgBox("Please Enter a Document ID", vbExclamation, "Save Error")
        
        Case "DATABASE-EMPTY"
            errorMsg = MsgBox("No Entries Exist In Database", 64, "Search Results")
            
        Case "DATABASE-ERROR"
            errorMsg = MsgBox("Database Error", vbExclamation, "Database Error")
        
        Case "FILEPATH"
            errorMsg = MsgBox("Please Enter Document Filepath", vbExclamation, "Save Error")
        
    End Select
End Function

Function showSuccess()
    
    Select Case g_DocumentMode
    Case "NEW"
        MsgBox "Document Added Successfully", 0, "Save Confirmation"
    Case "MODIFY"
        MsgBox "Document Modified Successfully", 0, "Save Confirmation"
    End Select
    
    clear_Fields
    
End Function

Private Sub sLblista_DblClick()
'Purpose: Upon double clicking an entry...
Dim sAppName        As String
Dim sAppPath        As String
Dim slashLocation   As Integer
Dim w_FilePath      As String
Dim w_fileName      As String
Dim w_Directory     As String
Dim w_NewDirectory  As String

    'In View and Add mode, user can open the document by double clicking an entry
    If g_DocumentMode = "VIEW" Or g_DocumentMode = "ADD" Then
        'Grab the filepath from the selected row
        w_FilePath = sLblista.TextMatrix(sLblista.Row, 3)
        
        'Get the location of the last '\' in the filepath -
        'anything after this is the filename
        slashLocation = InStr(w_FilePath, "\")
        
        'Extract all characters up to and including the last '\' char -- get directory
        w_Directory = Left$(w_FilePath, slashLocation)
        
        'Take out apostrophe escape char so that filepath exists
        w_NewDirectory = Replace(w_FilePath, "''", "'")
        
        'Open selected document in maximized screen view
        ShellExecute hwnd, "open", w_FilePath, vbNullString, w_NewDirectory, 6
    
    'Else, user can only modify the details of the document
    Else
        g_DocumentID = sLblista.TextMatrix(sLblista.Row, 0)
        load_Data
    End If
    
End Sub

Private Sub sDescription_Change()
    documentChange = True
End Sub

Private Sub sDocID_Change()
    documentChange = True
End Sub

Private Sub sFilePath_Change()
    documentChange = True
End Sub

