VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmOptions 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "CMS System Parameters"
   ClientHeight    =   5160
   ClientLeft      =   1050
   ClientTop       =   1500
   ClientWidth     =   6150
   Icon            =   "frmOptions.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5160
   ScaleWidth      =   6150
   ShowInTaskbar   =   0   'False
   Begin VB.Frame fraCountries 
      Caption         =   "System Countries"
      Height          =   3585
      Left            =   240
      TabIndex        =   19
      Top             =   840
      Width           =   5655
      Begin VB.CommandButton CommandRemoveCountry 
         Caption         =   "Remove"
         Height          =   375
         Left            =   720
         TabIndex        =   51
         Top             =   2400
         Width           =   1215
      End
      Begin VB.CommandButton CommandSubmitCountry 
         Caption         =   "Submit"
         Height          =   375
         Left            =   720
         TabIndex        =   21
         Top             =   1320
         Width           =   1215
      End
      Begin VB.TextBox sCountry 
         Height          =   285
         Left            =   960
         TabIndex        =   9
         Text            =   "Enter Country Here"
         Top             =   720
         Width           =   1575
      End
      Begin MSFlexGridLib.MSFlexGrid listCountries 
         Height          =   3255
         Left            =   2880
         TabIndex        =   20
         Top             =   240
         Width           =   2655
         _ExtentX        =   4683
         _ExtentY        =   5741
         _Version        =   393216
         Cols            =   1
         FixedCols       =   0
         FocusRect       =   0
         GridLines       =   2
         SelectionMode   =   1
         AllowUserResizing=   1
         FormatString    =   "Countries                                      "
      End
      Begin VB.Label Label1 
         Caption         =   "Country:"
         Height          =   255
         Left            =   240
         TabIndex        =   22
         Top             =   720
         Width           =   615
      End
   End
   Begin VB.Frame fraNationalities 
      Caption         =   "System Nationalities"
      Height          =   3585
      Left            =   240
      TabIndex        =   58
      Top             =   840
      Width           =   5655
      Begin VB.CommandButton CommandSubmitNationality 
         Caption         =   "Submit"
         Height          =   375
         Left            =   720
         TabIndex        =   60
         Top             =   1320
         Width           =   1215
      End
      Begin VB.TextBox sNationality 
         Height          =   285
         Left            =   480
         TabIndex        =   8
         Text            =   "Enter Nationality Here"
         Top             =   840
         Width           =   1695
      End
      Begin VB.CommandButton CommandRemoveNationality 
         Caption         =   "Remove"
         Height          =   375
         Left            =   720
         TabIndex        =   59
         Top             =   2400
         Width           =   1215
      End
      Begin MSFlexGridLib.MSFlexGrid listNationalities 
         Height          =   3255
         Left            =   2880
         TabIndex        =   61
         Top             =   240
         Width           =   2655
         _ExtentX        =   4683
         _ExtentY        =   5741
         _Version        =   393216
         Cols            =   1
         FixedCols       =   0
         FocusRect       =   0
         GridLines       =   2
         SelectionMode   =   1
         AllowUserResizing=   1
         FormatString    =   "Nationalities                                  "
      End
      Begin VB.Label Label12 
         Caption         =   "Nationality:"
         Height          =   255
         Left            =   240
         TabIndex        =   62
         Top             =   600
         Width           =   975
      End
   End
   Begin VB.Frame fraCourts 
      Caption         =   "System Courts"
      Height          =   3585
      Left            =   240
      TabIndex        =   47
      Top             =   840
      Width           =   5655
      Begin VB.CommandButton CommandRemoveCourt 
         Caption         =   "Remove"
         Height          =   375
         Left            =   480
         TabIndex        =   52
         Top             =   2400
         Width           =   1215
      End
      Begin VB.CommandButton CommandSubmitCourt 
         Caption         =   "Submit"
         Height          =   375
         Left            =   480
         TabIndex        =   48
         Top             =   1440
         Width           =   1215
      End
      Begin VB.TextBox sCourts 
         Height          =   285
         Left            =   120
         TabIndex        =   7
         Text            =   "Enter Court Here"
         Top             =   840
         Width           =   1935
      End
      Begin MSFlexGridLib.MSFlexGrid listCourts 
         Height          =   3255
         Left            =   2160
         TabIndex        =   49
         Top             =   240
         Width           =   3375
         _ExtentX        =   5953
         _ExtentY        =   5741
         _Version        =   393216
         Cols            =   1
         FixedCols       =   0
         ScrollTrack     =   -1  'True
         FocusRect       =   0
         GridLines       =   2
         SelectionMode   =   1
         AllowUserResizing=   1
         FormatString    =   "Courts                                                           "
      End
      Begin VB.Label Label11 
         Caption         =   "Court:"
         Height          =   255
         Left            =   120
         TabIndex        =   50
         Top             =   600
         Width           =   615
      End
   End
   Begin VB.Frame fraStatus 
      Caption         =   "System Case Status"
      Height          =   3585
      Left            =   240
      TabIndex        =   43
      Top             =   840
      Width           =   5655
      Begin VB.CommandButton CommandRemoveStatus 
         Caption         =   "Remove"
         Height          =   375
         Left            =   720
         TabIndex        =   53
         Top             =   2400
         Width           =   1215
      End
      Begin VB.TextBox sStatus 
         Height          =   285
         Left            =   960
         TabIndex        =   6
         Text            =   "Enter Status Here"
         Top             =   720
         Width           =   1575
      End
      Begin VB.CommandButton CommandSubmitStatus 
         Caption         =   "Submit"
         Height          =   375
         Left            =   720
         TabIndex        =   44
         Top             =   1320
         Width           =   1215
      End
      Begin MSFlexGridLib.MSFlexGrid listStatus 
         Height          =   3255
         Left            =   2880
         TabIndex        =   45
         Top             =   240
         Width           =   2655
         _ExtentX        =   4683
         _ExtentY        =   5741
         _Version        =   393216
         Cols            =   1
         FixedCols       =   0
         FocusRect       =   0
         GridLines       =   2
         SelectionMode   =   1
         AllowUserResizing=   1
         FormatString    =   "Status                                           "
      End
      Begin VB.Label Label10 
         Caption         =   "Status:"
         Height          =   255
         Left            =   240
         TabIndex        =   46
         Top             =   720
         Width           =   615
      End
   End
   Begin VB.Frame fraTypes 
      Caption         =   "System Case Types"
      Height          =   3585
      Left            =   240
      TabIndex        =   39
      Top             =   840
      Width           =   5655
      Begin VB.CommandButton CommandRemoveType 
         Caption         =   "Remove"
         Height          =   375
         Left            =   720
         TabIndex        =   54
         Top             =   2400
         Width           =   1215
      End
      Begin VB.CommandButton CommandSubmitType 
         Caption         =   "Submit"
         Height          =   375
         Left            =   720
         TabIndex        =   40
         Top             =   1320
         Width           =   1215
      End
      Begin VB.TextBox sTypes 
         Height          =   285
         Left            =   960
         TabIndex        =   5
         Text            =   "Enter Type Here"
         Top             =   720
         Width           =   1575
      End
      Begin MSFlexGridLib.MSFlexGrid listTypes 
         Height          =   3255
         Left            =   2880
         TabIndex        =   41
         Top             =   240
         Width           =   2655
         _ExtentX        =   4683
         _ExtentY        =   5741
         _Version        =   393216
         Cols            =   1
         FixedCols       =   0
         FocusRect       =   0
         GridLines       =   2
         SelectionMode   =   1
         AllowUserResizing=   1
         FormatString    =   "Types                                           "
      End
      Begin VB.Label Label9 
         Caption         =   "Type:"
         Height          =   255
         Left            =   240
         TabIndex        =   42
         Top             =   720
         Width           =   615
      End
   End
   Begin VB.Frame fraGenders 
      Caption         =   "System Genders"
      Height          =   3585
      Left            =   240
      TabIndex        =   35
      Top             =   840
      Width           =   5655
      Begin VB.CommandButton CommandRemoveGender 
         Caption         =   "Remove"
         Height          =   375
         Left            =   720
         TabIndex        =   55
         Top             =   2400
         Width           =   1215
      End
      Begin VB.TextBox sGender 
         Height          =   285
         Left            =   960
         TabIndex        =   4
         Text            =   "Enter Gender Here"
         Top             =   720
         Width           =   1575
      End
      Begin VB.CommandButton CommandSubmitGender 
         Caption         =   "Submit"
         Height          =   375
         Left            =   720
         TabIndex        =   36
         Top             =   1320
         Width           =   1215
      End
      Begin MSFlexGridLib.MSFlexGrid listGenders 
         Height          =   3255
         Left            =   2880
         TabIndex        =   37
         Top             =   240
         Width           =   2655
         _ExtentX        =   4683
         _ExtentY        =   5741
         _Version        =   393216
         Cols            =   1
         FixedCols       =   0
         FocusRect       =   0
         GridLines       =   2
         SelectionMode   =   1
         AllowUserResizing=   1
         FormatString    =   "Genders                                       "
      End
      Begin VB.Label Label8 
         Caption         =   "Gender:"
         Height          =   255
         Left            =   240
         TabIndex        =   38
         Top             =   720
         Width           =   615
      End
   End
   Begin VB.Frame fraCities 
      Caption         =   "System Cities"
      Height          =   3585
      Left            =   240
      TabIndex        =   29
      Top             =   840
      Width           =   5655
      Begin VB.CommandButton CommandRemoveCity 
         Caption         =   "Remove"
         Height          =   375
         Left            =   720
         TabIndex        =   56
         Top             =   2760
         Width           =   1215
      End
      Begin VB.CommandButton CommandSubmitCity 
         Caption         =   "Submit"
         Height          =   375
         Left            =   720
         TabIndex        =   30
         Top             =   2040
         Width           =   1215
      End
      Begin VB.TextBox sCity 
         Height          =   285
         Left            =   960
         TabIndex        =   2
         Text            =   "Enter City Here"
         Top             =   480
         Width           =   1575
      End
      Begin VB.ComboBox cbDistricts 
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
         Left            =   960
         TabIndex        =   3
         Top             =   1440
         Width           =   1815
      End
      Begin MSFlexGridLib.MSFlexGrid listCities 
         Height          =   3255
         Left            =   2880
         TabIndex        =   31
         Top             =   240
         Width           =   2655
         _ExtentX        =   4683
         _ExtentY        =   5741
         _Version        =   393216
         Cols            =   1
         FixedCols       =   0
         FocusRect       =   0
         GridLines       =   2
         SelectionMode   =   1
         AllowUserResizing=   1
         FormatString    =   "Cities                                            "
      End
      Begin VB.Label Label7 
         Caption         =   "City:"
         Height          =   255
         Left            =   240
         TabIndex        =   34
         Top             =   480
         Width           =   615
      End
      Begin VB.Label Label6 
         Caption         =   "District:"
         Height          =   255
         Left            =   240
         TabIndex        =   33
         Top             =   1560
         Width           =   615
      End
      Begin VB.Label Label5 
         Caption         =   "City in which District?"
         Height          =   255
         Left            =   480
         TabIndex        =   32
         Top             =   1080
         Width           =   1935
      End
   End
   Begin VB.Frame fraDistricts 
      Caption         =   "System Districts"
      Height          =   3585
      Left            =   240
      TabIndex        =   23
      Top             =   840
      Width           =   5655
      Begin VB.CommandButton CommandRemoveDistrict 
         Caption         =   "Remove"
         Height          =   375
         Left            =   720
         TabIndex        =   57
         Top             =   2640
         Width           =   1215
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
         Left            =   960
         TabIndex        =   1
         Top             =   1440
         Width           =   1815
      End
      Begin VB.TextBox sDistrict 
         Height          =   285
         Left            =   960
         TabIndex        =   0
         Text            =   "Enter District Here"
         Top             =   480
         Width           =   1575
      End
      Begin VB.CommandButton CommandSubmitDistrict 
         Caption         =   "Submit"
         Height          =   375
         Left            =   720
         TabIndex        =   24
         Top             =   2040
         Width           =   1215
      End
      Begin MSFlexGridLib.MSFlexGrid listDistricts 
         Height          =   3255
         Left            =   2880
         TabIndex        =   25
         Top             =   240
         Width           =   2655
         _ExtentX        =   4683
         _ExtentY        =   5741
         _Version        =   393216
         Cols            =   1
         FixedCols       =   0
         FocusRect       =   0
         GridLines       =   2
         SelectionMode   =   1
         AllowUserResizing=   1
         FormatString    =   "Districts                                        "
      End
      Begin VB.Label Label4 
         Caption         =   "District in which Country?"
         Height          =   255
         Left            =   480
         TabIndex        =   28
         Top             =   1080
         Width           =   1935
      End
      Begin VB.Label Label3 
         Caption         =   "Country:"
         Height          =   255
         Left            =   240
         TabIndex        =   27
         Top             =   1560
         Width           =   615
      End
      Begin VB.Label Label2 
         Caption         =   "District:"
         Height          =   255
         Left            =   240
         TabIndex        =   26
         Top             =   480
         Width           =   615
      End
   End
   Begin VB.PictureBox picOptions 
      BorderStyle     =   0  'None
      Height          =   3780
      Index           =   3
      Left            =   -20000
      ScaleHeight     =   3780
      ScaleWidth      =   5685
      TabIndex        =   15
      TabStop         =   0   'False
      Top             =   480
      Width           =   5685
      Begin VB.Frame fraSample4 
         Caption         =   "Sample 4"
         Height          =   1785
         Left            =   2100
         TabIndex        =   18
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
      TabIndex        =   14
      TabStop         =   0   'False
      Top             =   480
      Width           =   5685
      Begin VB.Frame fraSample3 
         Caption         =   "Sample 3"
         Height          =   1785
         Left            =   1545
         TabIndex        =   17
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
      TabIndex        =   13
      TabStop         =   0   'False
      Top             =   480
      Width           =   5685
      Begin VB.Frame fraSample2 
         Caption         =   "Sample 2"
         Height          =   1785
         Left            =   645
         TabIndex        =   16
         Top             =   300
         Width           =   2055
      End
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   375
      Left            =   4680
      TabIndex        =   12
      Top             =   4680
      Width           =   1095
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   3360
      TabIndex        =   11
      Top             =   4680
      Width           =   1095
   End
   Begin MSComctlLib.TabStrip tbsOptions 
      Height          =   4485
      Left            =   105
      TabIndex        =   10
      Top             =   120
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   7911
      MultiRow        =   -1  'True
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   8
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Countries"
            Object.ToolTipText     =   "Set System Countries"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Districts"
            Object.ToolTipText     =   "Set System Districts"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Cities"
            Object.ToolTipText     =   "Set Sytem Cities"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab4 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Nationalities"
            Object.ToolTipText     =   "Set System Nationalities"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab5 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Genders"
            Object.ToolTipText     =   "Set System Genders"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab6 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Case Types"
            Object.ToolTipText     =   "Set System Case Types"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab7 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Case Status"
            Object.ToolTipText     =   "Set System Case Status"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab8 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Courts"
            Object.ToolTipText     =   "Set System Courts"
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
Attribute VB_Name = "frmOptions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim currTab As String

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdOK_Click()
    MsgBox "System Parameters Saved Successfully"
    Unload Me
End Sub

Private Sub CommandRemoveCity_Click()
    removeParameter "Delete * from cities where description = " & Chr(34) & listCities.TextMatrix(listCities.Row, 0) & Chr(34) & ";"
    load_List listCities
End Sub

Private Sub CommandRemoveCountry_Click()
    removeParameter "Delete * from countries where description = " & Chr(34) & listCountries.TextMatrix(listCountries.Row, 0) & Chr(34) & ";"
    load_List listCountries
End Sub

Private Sub CommandRemoveCourt_Click()
    removeParameter "Delete * from courts where description = " & Chr(34) & listCourts.TextMatrix(listCourts.Row, 0) & Chr(34) & ";"
    load_List listCourts
End Sub

Private Sub CommandRemoveDistrict_Click()
    removeParameter "Delete * from districts where description = " & Chr(34) & listDistricts.TextMatrix(listDistricts.Row, 0) & Chr(34) & ";"
    load_List listDistricts
End Sub

Private Sub CommandRemoveGender_Click()
    removeParameter "Delete * from sex where description = " & Chr(34) & listGenders.TextMatrix(listGenders.Row, 0) & Chr(34) & ";"
    load_List listGenders
End Sub

Private Sub CommandRemoveNationality_Click()
    removeParameter "Delete * from nationalities where description = " & Chr(34) & listNationalities.TextMatrix(listNationalities.Row, 0) & Chr(34) & ";"
    load_List listNationalities
End Sub

Private Sub CommandRemoveStatus_Click()
    removeParameter "Delete * from status where description = " & Chr(34) & listStatus.TextMatrix(listStatus.Row, 0) & Chr(34) & ";"
    load_List listStatus
End Sub

Private Sub CommandRemoveType_Click()
    removeParameter "Delete * from types where description = " & Chr(34) & listTypes.TextMatrix(listTypes.Row, 0) & Chr(34) & ";"
    load_List listTypes
End Sub

Private Sub CommandSubmitNationality_Click()
    insParameter "Insert into nationalities values ('" & getMaxID("NATIONALITIES") & "', '" & sNationality.Text & "')"
    load_List listNationalities
    sNationality.Text = ""
End Sub

Private Sub CommandSubmitStatus_Click()
    insParameter "Insert into status values ('" & getMaxID("STATUS") & "', '" & sStatus.Text & "')"
    load_List listStatus
    sStatus.Text = ""
End Sub

Private Sub CommandSubmitType_Click()
    insParameter "Insert into types values ('" & getMaxID("TYPES") & "', '" & sTypes.Text & "')"
    load_List listTypes
    sTypes.Text = ""
End Sub

Private Sub CommandSubmitGender_Click()
    insParameter "Insert into sex values ('" & getMaxID("GENDERS") & "', '" & sGender.Text & "')"
    load_List listGenders
    sGender.Text = ""
End Sub

Private Sub CommandSubmitDistrict_Click()
    insParameter "Insert into districts values ('" & getMaxID("DISTRICTS") & "', '" & sDistrict.Text & "', '" & getCode("COUNTRY") & "')"
    load_List listDistricts
    sDistrict.Text = ""
    cbCountry.Text = ""
End Sub

Private Sub CommandSubmitCourt_Click()
    insParameter "Insert into courts values ('" & getMaxID("COURTS") & "', '" & sCourts.Text & "')"
    load_List listCourts
    sCourts.Text = ""
End Sub

Private Sub CommandSubmitCity_Click()
    insParameter "Insert into cities values ('" & getMaxID("CITIES") & "', '" & sCity.Text & "', '" & getCode("DISTRICT") & "', '" & getCode("DISTRICTCOUNTRY") & "')"
    load_List listCities
    sCity.Text = ""
    cbDistricts.Text = ""
End Sub

Private Sub CommandSubmitCountry_Click()
    insParameter "Insert into countries values ('" & getMaxID("COUNTRIES") & "', '" & sCountry.Text & "')"
    'Load new list
    load_List listCountries
    'Clear the text field
    sCountry.Text = ""
End Sub

Function getCode(codeType As String)
'Purpose: Lookup and return parameter code in DB
Dim w_Recordset As New Recordset
Dim w_SQL As String

    Select Case codeType
        'If Admin is in fraDistricts and wants corresponding Country Code
        Case "COUNTRY"
            w_SQL = "Select countrycode from countries where description = '" & cbCountry.Text & "'"
        
        'If Admin is in fraCities and wants corresponding District Code
        Case "DISTRICT"
            w_SQL = "Select districtcode from districts where description = '" & cbDistricts.Text & "'"
        
        'City table requires Country Code for District chosen.
        Case "DISTRICTCOUNTRY"
            'Get Countrycode by getting districtcode of district chosen.
            w_SQL = "Select countrycode from districts where districtcode = " & getCode("DISTRICT")
    End Select
        
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        If Not .EOF Then
            Select Case codeType
                'Return the appropriate Code
                Case "COUNTRY"
                    getCode = !countryCode
                Case "DISTRICT"
                    getCode = !districtCode
                Case "DISTRICTCOUNTRY"
                    getCode = !countryCode
            End Select
        End If
        If .State = 1 Then
            .Close
        End If
    End With
End Function

Function clearGrid()
'Purpose: Clear the grid and reformat headings based on current tab.
Dim formatString As String
    
    Select Case currTab
        Case "fraCountries"
            formatString = "Countries                                      "
            redrawList listCountries, formatString
        Case "fraCities"
            formatString = "Cities                                            "
            redrawList listCities, formatString
        Case "fraCourts"
            formatString = "Courts                                           "
            redrawList listCourts, formatString
        Case "fraDistricts"
            formatString = "Districts                                        "
            redrawList listDistricts, formatString
        Case "fraGenders"
            formatString = "Genders                                       "
            redrawList listGenders, formatString
        Case "fraStatus"
            formatString = "Status                                           "
            redrawList listStatus, formatString
        Case "fraTypes"
            formatString = "Types                                           "
            redrawList listTypes, formatString
        Case "fraNationalities"
            formatString = "Nationalities                                  "
            redrawList listNationalities, formatString
            
    End Select

End Function

Function redrawList(ByRef currList, formatString)
'Purpose: Clear the current list and reformat the headings

    With currList
        'Empty the list
        .Clear
        .Rows = .FixedRows
        'Redraw Col headings
        .formatString = formatString
    End With
    
End Function

Function insParameter(sqlInsertParam As String)
'Purpose: Carry out inserting new system parameter. Takes in the SQL query
Dim w_Recordset As New Recordset
    
    On Error GoTo errHandler
    
    With w_Recordset
        'Insert new parameter into DB
        .Open sqlInsertParam, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        If .State = 1 Then
            .Close
        End If
    End With
    Exit Function
    
    'Write a log in the system
    system_db.write_systemLog "MODIFY", dbModuleOption, vbNullString

errHandler:
Dim errorMsg As Integer
    errorMsg = MsgBox("Parameter Not Inserted", vbExclamation, "Insert Error")
    
End Function

Function removeParameter(sqlRemoveParam)
'Purpose: Remove the selected parameter from the system.
Dim w_Recordset As New Recordset

    On Error GoTo errHandler
    
    'Ask for confirmation
    If isConfirmed Then
        With w_Recordset
        'Remove parameter from DB
        .Open sqlRemoveParam, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        If .State = 1 Then
            .Close
        End If
        End With
    End If
    Exit Function

    'Write a log in the system
    system_db.write_systemLog "DELETE", dbModuleOption, vbNullString

errHandler:
Dim errorMsg As Integer
    errorMsg = MsgBox("Parameter Not Removed", vbExclamation, "Remove Error")
    
End Function

Function load_List(ByRef currList)
'Purpose: Load the existing system Parameters. Takes in reference to the current list
Dim w_Recordset As New Recordset
Dim w_SQL As String

    'Clears the list
    clearGrid
    
    'Get the appropriate query based on the current tab
    Select Case currTab
        Case "fraCountries"
            w_SQL = "Select description from countries"
        Case "fraCities"
            w_SQL = "Select description from cities"
        Case "fraCourts"
            w_SQL = "Select description from courts"
        Case "fraDistricts"
            w_SQL = "Select description from districts"
        Case "fraTypes"
            w_SQL = "Select description from types"
        Case "fraStatus"
            w_SQL = "Select description from status"
        Case "fraGenders"
            w_SQL = "Select description from sex"
        Case "fraNationalities"
            w_SQL = "Select description from nationalities"
    End Select
    
    With w_Recordset
        'Execute query
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        Do While .EOF = False
            'Add the parameters to the list
            currList.AddItem !Description
            .MoveNext
        Loop
        If .State = 1 Then
            .Close
        End If
    End With

End Function

Function getMaxID(parameterType)
'Purpose: Get the max ID for the parameterType
Dim w_SQL As String
Dim w_Recordset As New Recordset

    On Error GoTo errHandler
    
    'Get appropriate query based on parameterType
    Select Case parameterType
        'Mask max(___code) as maxcode for identification purposes
        Case "COUNTRIES"
            w_SQL = "Select max(countrycode) as maxcode from countries"
        Case "CITIES"
            w_SQL = "Select Max(citycode) as maxcode from cities"
        Case "DISTRICTS"
            w_SQL = "Select Max(districtcode) as maxcode from districts"
        Case "GENDERS"
            w_SQL = "Select Max(sexcode) as maxcode from sex"
        Case "NATIONALITIES"
            w_SQL = "Select Max(nationalitycode) as maxcode from nationalities"
        Case "STATUS"
            w_SQL = "Select Max(statuscode) as maxcode from status"
        Case "TYPES"
            w_SQL = "Select Max(typecode) as maxcode from types"
        Case "COURTS"
            w_SQL = "Select Max(courtcode) as maxcode from courts"
    End Select
    
    'Execute Query and Return max ID
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        'Need to keep '01', '02', numbering convention if maxCode is less than 10
        If Val(!maxcode) = 0 Then
            getMaxID = "01"
        ElseIf Val(!maxcode) < 10 Then
            getMaxID = "0" & (!maxcode + 1)
        Else
            getMaxID = !maxcode + 1
        End If
        If .State = 1 Then
            .Close
        End If
    End With
    Exit Function

errHandler:
Dim errorMsg As Integer
    errorMsg = MsgBox("Database Error, ID Not Found", vbExclamation, "ID Error")
End Function

Function isConfirmed()
Dim confMsg As Integer
    
    confMsg = MsgBox("Are You Sure You Want To Do This?", vbYesNo, "Confirmation Dialog")
    
    If confMsg = 6 Then
        isConfirmed = True
    ElseIf confMsg = 7 Then
        isConfirmed = False
    End If
    
End Function

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
    Me.Move (frmMDI.Width - Me.Width) / 2, (frmMDI.Height - Me.Height) / 2
    
    'Set Rows to 1 for all lists
    'Prevents empty first row
    listCountries.Rows = 1
    listCities.Rows = 1
    listGenders.Rows = 1
    listDistricts.Rows = 1
    listStatus.Rows = 1
    listTypes.Rows = 1
    listCourts.Rows = 1
    listNationalities.Rows = 1
    
    'Load all the system parameters in the respective list
    loadAllLists
    
    'current tab is fraCountries by default
    currTab = "fraCountries"
    
    'Load Combo Info
    load_Combos
    
End Sub

Function load_Combos()

   loadComboItems "Select * from countries", cbCountry
   loadComboItems "Select * from districts", cbDistricts
    
End Function

Function loadComboItems(sqlSelect, ByRef comboName)
'Purpose: load items of the combo passed in.
Dim w_Recorset As New Recordset
    
    On Error GoTo errHandler
    
    With w_Recorset
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
    errorMsg = MsgBox("Combo Information Not Loaded", vbExclamation, "Combo Load Error")

End Function

Function loadAllLists()
'Purpose: Load all the system parameters in the respective list

    currTab = "fraCountries"
    load_List listCountries
    
    currTab = "fraCities"
    load_List listCities
    
    currTab = "fraCourts"
    load_List listCourts
    
    currTab = "fraDistricts"
    load_List listDistricts
    
    currTab = "fraTypes"
    load_List listTypes
    
    currTab = "fraStatus"
    load_List listStatus
    
    currTab = "fraGenders"
    load_List listGenders
    
    currTab = "fraNationalities"
    load_List listNationalities
    
End Function

Private Sub tbsOptions_Click()
    
    'show and enable the selected tab's controls
    'and hide and disable all others
    Select Case tbsOptions.SelectedItem.Index
        Case 1: fraCountries.ZOrder 0
                currTab = "fraCountries"
        Case 2: fraDistricts.ZOrder 0
                currTab = "fraDistricts"
        Case 3: fraCities.ZOrder 0
                currTab = "fraCities"
        Case 4: fraNationalities.ZOrder 0
                currTab = "fraNationalities"
        Case 5: fraGenders.ZOrder 0
                currTab = "fraGenders"
        Case 6: fraTypes.ZOrder 0
                currTab = "fraTypes"
        Case 7: fraStatus.ZOrder 0
                currTab = "fraStatus"
        Case 8: fraCourts.ZOrder 0
                currTab = "fraCourts"
    End Select
    
End Sub
