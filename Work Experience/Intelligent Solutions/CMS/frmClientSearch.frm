VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form frmClientSearch 
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
      Top             =   1440
      Width           =   11295
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
         Left            =   840
         TabIndex        =   1
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
         Left            =   4920
         TabIndex        =   2
         Top             =   240
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
         Left            =   8160
         TabIndex        =   3
         Top             =   240
         Width           =   1815
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
         Left            =   360
         TabIndex        =   13
         Top             =   360
         Width           =   375
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
         Left            =   3840
         TabIndex        =   12
         Top             =   360
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
      TabIndex        =   6
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
         Left            =   8400
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
      Begin VB.Label Label4 
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
         Left            =   7680
         TabIndex        =   15
         Top             =   480
         Width           =   615
      End
   End
   Begin MSFlexGridLib.MSFlexGrid sLblista 
      Height          =   4695
      Left            =   120
      TabIndex        =   0
      Top             =   2280
      Width           =   11325
      _ExtentX        =   19976
      _ExtentY        =   8281
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
      FormatString    =   $"frmClientSearch.frx":0000
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
Attribute VB_Name = "frmClientSearch"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim idAsc As Boolean
Dim lastNameAsc As Boolean
Dim firstNameAsc As Boolean

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
        w_SQL = "Select * from clients"
    Else
        w_SQL = getSQL_Query
    End If
    
    'Append ORDER BY clause to query and order by selected item in combobox
    
    Select Case cbSortby.Text
        Case "ID"
            sortByField = "clientid"
            idAsc = Not idAsc
            
            If idAsc = True Then
                ascOrDsc = " ASC"
            Else
                ascOrDsc = " DESC"
            End If
        
        Case "First Name"
            sortByField = "firstname"
            firstNameAsc = Not firstNameAsc
            
            If firstNameAsc = True Then
                ascOrDsc = " ASC"
            Else
                ascOrDsc = " DESC"
            End If

        Case "Last Name"
            sortByField = "lastname"
            lastNameAsc = Not lastNameAsc
            
            If lastNameAsc = True Then
                ascOrDsc = " ASC"
            Else
                ascOrDsc = " DESC"
            End If

    End Select
    
    w_SQL = w_SQL & sqlOrderBy & sortByField & ascOrDsc
    
    executeNewQuery (w_SQL)
  
End Sub

Function executeNewQuery(query)
Dim w_Recordset As New Recordset
Dim counter As Integer

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
        Do While .EOF = False And counter < 10
            counter = counter + 1
            sLblista.AddItem !clientid & vbTab & !lastname & vbTab & !firstname & vbTab & !address1 & ", " & !address2
            .MoveNext
        Loop
        If .State = 1 Then
            .Close
        End If
    End With


End Function

Function clearGrid()
    Dim formatString As String
    formatString = "ID               |Last Name                                          | First Name                                           |<Address                                                                                      "
    
    'Empty the list
    With sLblista
        .Clear
        .Rows = .FixedRows
        'Redraw Col headings
        .formatString = formatString
    End With

End Function

Function getSQL_Query()

    If sLastName.Text = "" And sFirstName.Text <> "" Then
        'Query if User defines only First Name (soft search)
        getSQL_Query = "Select * from clients where firstname >= '" & Trim(sFirstName.Text) & "' ORDER BY firstname ASC"
    
    ElseIf sFirstName.Text = "" And sLastName.Text <> "" Then
        'Query if User defines only Last Name (soft search)
        getSQL_Query = "Select * from clients where lastname >= '" & Trim(sLastName.Text) & "' ORDER BY lastname ASC"
    
    ElseIf sFirstName.Text <> "" And sLastName.Text <> "" Then
        'Query if User defines First Name & Last Name (specific search)
        getSQL_Query = "Select * from clients where firstname = '" & Trim(sFirstName.Text) & "' and lastname = '" & Trim(sLastName.Text) & "' ORDER BY lastname ASC"
    
    ElseIf sClientID.Text <> "" And sFirstName.Text = "" And sLastName.Text = "" Then
        'Query if User defines ID only (soft search)
        getSQL_Query = "Select * from clients where clientid >= '" & Val(sClientID.Text) & "' ORDER BY clientid ASC"
    End If
    
End Function

Private Sub cmdNext_Click()
    'Get Client ID from Table
    g_ClientID = sLblista.TextMatrix(sLblista.Row, 0)
    'Show Details in interface
    frmClientNew.Show
  
End Sub

Private Sub cmdSearch_Click()
    executeSearch
End Sub

Private Sub load_List()
Dim w_SQL As String
Dim w_SQL2 As String
Dim w_Recordset As New Recordset

    'Default Query (show all)
    w_SQL = "Select * from clients ORDER BY clientid ASC"
    
    w_SQL2 = getSQL_Query
    
    'Execute Default Query
    executeNewQuery (w_SQL)
    
    If w_SQL2 <> "" Then
         executeNewQuery (w_SQL2)
    End If
End Sub

Public Sub clear_Fields()

    sClientID.Text = vbNullString
    sFirstName.Text = vbNullString
    sLastName.Text = vbNullString

End Sub

Private Sub Form_Activate()

    setFormProperties
    
    'Execute Default query
    executeSearch

End Sub

Function setFormProperties()
    
    frmMDI.showSearchModuleButtons
    
    isRightScreenToHide ("frmClientSearch")
    setCurrentScreen ("frmClientSearch")
    frmMDI.hideSelfModuleButton
    
    If g_ClientMode = g_SystemNew Then
        g_ClientMode = g_SystemView
    End If
    
    cmdNext.Caption = "View Details"
    lblWindow.Caption = "Client - Search"

    Select Case g_ClientMode
        Case "VIEW"
            lblFunction.Caption = "Search For Client Whose Details You Want To View"
       
        Case "MODIFY"
            lblFunction.Caption = "Search For Client Whose Details You Want To Modify"
        
        Case "DELETE"
            lblFunction.Caption = "Search For Client Whose Details You Want To Delete"
        
        Case "SEARCH"
            lblFunction.Caption = "Double Click the Desired Client"
    End Select
    
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
    idAsc = True
    lastNameAsc = False
    firstNameAsc = False
    
    'Load SortBy info
    loadComboSortby
    
End Sub



Private Sub sClientID_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
        
        Case KeyCodeConstants.vbKeyReturn
            executeSearch
        
    End Select

End Sub

Private Sub sLastName_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
        
        Case KeyCodeConstants.vbKeyReturn
                executeSearch
        
    End Select
End Sub

Private Sub sFirstName_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
        
        Case KeyCodeConstants.vbKeyReturn
                executeSearch
        
    End Select
End Sub


Private Sub sLblista_DblClick()
    If g_ClientMode = "SEARCH" Then
        'Set CaseNew info to the selected entry
        frmCaseNew.sCid = sLblista.TextMatrix(sLblista.Row, 0)
        frmCaseNew.sCfirstname = sLblista.TextMatrix(sLblista.Row, 2)
        frmCaseNew.sClastname = sLblista.TextMatrix(sLblista.Row, 1)
        Hide
        frmCaseNew.Show
    Else
        'Get Client ID from Table
        g_ClientID = sLblista.TextMatrix(sLblista.Row, 0)
        'Show Details in interface
        frmClientNew.Show
    End If
End Sub

Function executeSearch()
                
    sLblista.Rows = 1
    load_List

End Function

Function loadComboSortby()
    
    cbSortby.AddItem ("ID")
    cbSortby.AddItem ("First Name")
    cbSortby.AddItem ("Last Name")
    
End Function
