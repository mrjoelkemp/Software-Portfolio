VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form frmCaseSearch 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   8265
   ClientLeft      =   0
   ClientTop       =   135
   ClientWidth     =   11595
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8265
   ScaleWidth      =   11595
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame4 
      Caption         =   "Search Options:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   120
      TabIndex        =   10
      Top             =   1200
      Width           =   11295
      Begin VB.TextBox sFileType 
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
         Left            =   1560
         TabIndex        =   1
         Top             =   240
         Width           =   1815
      End
      Begin VB.TextBox sAttorneyID 
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
         Left            =   4920
         TabIndex        =   2
         Top             =   240
         Width           =   1815
      End
      Begin VB.TextBox sClientID 
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
         Left            =   8160
         TabIndex        =   3
         Top             =   240
         Width           =   1815
      End
      Begin VB.Label Label1 
         Caption         =   "File Type:"
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
         TabIndex        =   13
         Top             =   360
         Width           =   975
      End
      Begin VB.Label Label5 
         Caption         =   "Attorney ID:"
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
         Left            =   3840
         TabIndex        =   12
         Top             =   360
         Width           =   975
      End
      Begin VB.Label Label4 
         Caption         =   "Client ID:"
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
         Left            =   7080
         TabIndex        =   11
         Top             =   360
         Width           =   855
      End
   End
   Begin VB.Frame Frame3 
      Height          =   1095
      Left            =   120
      TabIndex        =   7
      Top             =   120
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
         TabIndex        =   9
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
         TabIndex        =   8
         Top             =   240
         Width           =   11055
      End
   End
   Begin VB.Frame Frame2 
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
      TabIndex        =   0
      Top             =   6960
      Width           =   11295
      Begin VB.ComboBox cbSortby 
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
         Left            =   8160
         TabIndex        =   14
         Top             =   360
         Width           =   1815
      End
      Begin VB.CommandButton cmdNext 
         Caption         =   "Next"
         Height          =   615
         Left            =   960
         TabIndex        =   5
         Top             =   240
         Width           =   735
      End
      Begin VB.CommandButton cmdSearch 
         Caption         =   "Perform Search"
         Height          =   615
         Left            =   240
         TabIndex        =   4
         Top             =   240
         Width           =   735
      End
      Begin VB.Label Label2 
         Caption         =   "Sort By:"
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
         Left            =   7440
         TabIndex        =   15
         Top             =   480
         Width           =   615
      End
   End
   Begin MSFlexGridLib.MSFlexGrid sLblista 
      Height          =   4815
      Left            =   120
      TabIndex        =   6
      Top             =   2040
      Width           =   11325
      _ExtentX        =   19976
      _ExtentY        =   8493
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
      FormatString    =   $"frmFileSearch.frx":0000
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
Attribute VB_Name = "frmCaseSearch"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim CaseidAsc As Boolean
Dim ClientidAsc As Boolean
Dim AttorneyidAsc As Boolean
Dim DateOpenedAsc As Boolean
Dim TypeAsc As Boolean
Dim StatusAsc As Boolean

Function loadComboSortby()
    
    cbSortby.AddItem ("CaseID")
    cbSortby.AddItem ("Client Name")
    cbSortby.AddItem ("Attorney Name")
    cbSortby.AddItem ("Date Opened")
    cbSortby.AddItem ("Type")
    cbSortby.AddItem ("Status")
    
End Function

Private Sub cbSortby_Click()
    makeAscOrDesc
End Sub

Private Sub makeAscOrDesc()
Dim w_SQL As String
Dim sqlOrderBy As String
Dim sortByField As String
Dim ascOrDsc As String


    ascOrDsc = ""
    sqlOrderBy = " ORDER BY "
    
    'If all textfields are blank, sort default query
    If getSQL_Query = "" Then
        w_SQL = "Select * from cases"
    Else
        w_SQL = getSQL_Query
    End If
    
    'Append ORDER BY clause to query and order by selected item in combobox
    
    Select Case cbSortby.Text
        Case "CaseID"
            sortByField = "caseid"
            CaseidAsc = Not CaseidAsc
            
            If CaseidAsc = True Then
                ascOrDsc = " ASC"
            Else
                ascOrDsc = " DESC"
            End If
        
        Case "Client Name"
            sortByField = "clientid"
            ClientidAsc = Not ClientidAsc
            
            If ClientidAsc = True Then
                ascOrDsc = " ASC"
            Else
                ascOrDsc = " DESC"
            End If

        Case "Attorney Name"
            sortByField = "attorneyid"
            AttorneyidAsc = Not AttorneyidAsc
            
            If AttorneyidAsc = True Then
                ascOrDsc = " ASC"
            Else
                ascOrDsc = " DESC"
            End If
            
        Case "Date Opened"
            sortByField = "dateopen"
            DateOpenedAsc = Not DateOpenedAsc
            
            If DateOpenedAsc = True Then
                ascOrDsc = " ASC"
            Else
                ascOrDsc = " DESC"
            End If
            
        Case "Status"
            sortByField = "status"
            StatusAsc = Not StatusAsc
            
            If StatusAsc = True Then
                ascOrDsc = " ASC"
            Else
                ascOrDsc = " DESC"
            End If
            
         Case "Type"
            sortByField = "type"
            TypeAsc = Not TypeAsc
            
            If TypeAsc = True Then
                ascOrDsc = " ASC"
            Else
                ascOrDsc = " DESC"
            End If
       
    End Select
    
    w_SQL = w_SQL & sqlOrderBy & sortByField & ascOrDsc
    
    executeNewQuery (w_SQL)

End Sub

Function executeNewQuery(query)
'Note: Attorney and Client names are to be loaded into grid, not id. Therefore, lookup information.
'       Same goes for status and type.

Dim w_Recordset     As New Recordset
Dim w_Recordset2    As New Recordset
Dim counter         As Integer
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
Dim w_AttID         As String
     
     On Error Resume Next
     
    'First clear the current list
    clearGrid
    
    'Get Recordset with new ordering
    With w_Recordset
    
    
        'Execute initial query to get attorney, client, type, and status id
        .Open query, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        'If there are no results, then display message
        If .EOF Then
            Dim zeroResultsMsg As Integer
            zeroResultsMsg = MsgBox("No Entries Exist In Database", 64, "Search Results")
        End If

        
            'For the first ten entries in the recordset, load Client & Attorney name,
            'type and status text and rest of case information
            Do While .EOF = False And counter < 10
                
                'Increment Counter
                counter = counter + 1
                
                'Pull out information
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
                
               w_AttID = !attorneyid
                
                With w_Recordset2
                    'If the attorneyId was supplied, lookup attorney info
                    If w_AttID <> vbNullString Then
                    
                        'Get firstname and lastname of attorney
                        .Open w_SQLa, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
                        w_AttorneyName = !firstname & " " & !lastname
                        
                        If Err.Number = 3201 Then
                            MsgBox "Information for Case " & w_Caseid & " Not Found", vbCritical, "Missing Information"
                            Exit Function
                        End If
                        
                        If Err.Number = 3021 Then
                            Exit Function
                        End If
                        
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
                
                'Load new structure into list
                sLblista.AddItem w_Caseid & vbTab & w_ClientName & vbTab & w_AttorneyName & vbTab & Mid(w_Dateopen, 7, 2) & "/" & Mid(w_Dateopen, 5, 2) & "/" & Mid(w_Dateopen, 1, 4) & vbTab & w_Type & vbTab & w_Status
                .MoveNext
                 
            Loop
                
    End With

End Function

Private Sub cmdNext_Click()
    'Set caseCallingModule to a null string bc no one is calling it
    g_CaseCallingModule = vbNullString
    
    'Get File Information
    g_CaseID = sLblista.TextMatrix(sLblista.Row, 0)
    'Show Details in Interface
    frmCaseNew.Show
            
End Sub

Public Sub clear_Fields()
    
    sClientID.Text = vbNullString
    sAttorneyID.Text = vbNullString
    sFileType.Text = vbNullString

End Sub

Private Sub cmdSearch_Click()
    executeSearch
End Sub

Private Sub load_List()
Dim w_SQL2 As String

    w_SQL2 = getSQL_Query
    
    If w_SQL2 <> vbNullString Then
         executeNewQuery (w_SQL2)
    End If

End Sub

Function clearGrid()
    Dim formatString As String
    formatString = "Case ID    |Client Name                        |Attorney Name                     |Date Opened                   |Type                                 |Status                                    "
    'Empty the list
    With sLblista
        .Clear
        .Rows = .FixedRows
        'Redraw Col headings
        .formatString = formatString
    End With

End Function

Function getSQL_Query()

    If sAttorneyID.Text = "" And sClientID.Text <> "" Then
        'Query if User defines only Client ID (soft search)
        getSQL_Query = "Select * from cases where clientid >= '" & Val(sClientID.Text) & "' ORDER BY clientid ASC"
    
    ElseIf sClientID.Text = "" And sAttorneyID.Text <> "" Then
        'Query if User defines only Attorney ID (soft search)
        getSQL_Query = "Select * from cases where attorneyid >= '" & Val(sAttorneyID.Text) & "' ORDER BY attorneyid ASC"
    
    ElseIf sClientID.Text <> "" And sAttorneyID <> "" Then
        'Query if User defines Client ID & Attorney ID (specific search)
        getSQL_Query = "Select * from cases where clientid = '" & Val(sClientID.Text) & "' and attorneyid = '" & Val(sAttorneyID.Text) & "' ORDER BY clientid ASC"
    
    ElseIf sFileType.Text <> "" And sAttorneyID.Text = "" And sClientID.Text = "" Then
        Dim typeCode As Integer
        
        typeCode = getTypeCode(sFileType.Text)
        'Query if User defines File Type only (specific search)
        getSQL_Query = "Select * from cases where type = " & Val(typeCode) & " ORDER BY type ASC"
    End If
    
End Function

Function getTypeCode(typeDesc As String) As Integer
'Purpose: Take in the type description and return the corresponding code
Dim w_SQL       As String
Dim w_Recordset As New Recordset

    w_SQL = "Select typecode from types where description = '" & typeDesc & "'"
    
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        If .EOF Then
            'MsgBox "No Records Found", vbExclamation, "Search Dialog"
            Exit Function
        End If
        getTypeCode = !typeCode
        
        If .State = 1 Then
            .Close
        End If

    End With
    
End Function

Private Sub Form_Activate()
   
    setFormProperties
    
    'Execute Default query on page load
    executeNewQuery ("Select * from cases")
 
    
End Sub

Function setFormProperties()
    
    frmMDI.showSearchModuleButtons

    isRightScreenToHide ("frmCaseSearch")
    setCurrentScreen ("frmCaseSearch")
    frmMDI.hideSelfModuleButton
    
'    If g_CaseMode = g_SystemNew Then
'        g_CaseMode = g_SystemView
'    End If
    
    Select Case g_CaseMode
        Case "VIEW"
            lblFunction.Caption = "Search For Case Whose Details You Want To View"
    
        Case "MODIFY"
            lblFunction.Caption = "Search For Case Whose Details You Want To Modify"
            
        Case "DELETE"
            lblFunction.Caption = "Search For Case Whose Details You Want To Delete"
    
    End Select
    
    cmdNext.Caption = "View Details"
    lblWindow.Caption = "Cases - Search"
    'Set title of window in Status Bar
    frmMDI.setStatusBar (lblWindow.Caption)

End Function

Private Sub Form_Deactivate()
    'Me.Hide
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    sLblista.Rows = 1
    
    CaseidAsc = True
    ClientidAsc = False
    AttorneyidAsc = False
    DateOpenedAsc = False
    StatusAsc = False
    TypeAsc = False
    
    'Load SortBy info
    loadComboSortby
    
End Sub

Private Sub sLblista_DblClick()
    'Get File Information
    g_CaseID = sLblista.TextMatrix(sLblista.Row, 0)
    
    'Set the frmCaseNew isLoaded Bool to false because you are viewing details
    'of a new record
    frmCaseNew.setIsLoaded (False)
    
    'Show Details in Interface
    frmCaseNew.Show

End Sub

Function executeSearch()
                
    sLblista.Rows = 1
    load_List

End Function

Private Sub sAttorneyID_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
        
        Case KeyCodeConstants.vbKeyReturn
                executeSearch
        
    End Select
End Sub

Private Sub sFileType_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
        
        Case KeyCodeConstants.vbKeyReturn
                executeSearch
        
    End Select
End Sub

Private Sub sClientID_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
        
        Case KeyCodeConstants.vbKeyReturn
                executeSearch
        
    End Select
End Sub


