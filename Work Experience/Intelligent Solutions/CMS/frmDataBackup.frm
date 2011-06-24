VERSION 5.00
Begin VB.Form frmDataBackup 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Data Backup"
   ClientHeight    =   4500
   ClientLeft      =   2760
   ClientTop       =   3750
   ClientWidth     =   6030
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4500
   ScaleWidth      =   6030
   ShowInTaskbar   =   0   'False
   Begin VB.TextBox sFileName 
      Height          =   405
      Left            =   1200
      TabIndex        =   0
      Top             =   3480
      Width           =   3255
   End
   Begin VB.DirListBox listDir 
      Height          =   1890
      Left            =   120
      TabIndex        =   6
      Top             =   1560
      Width           =   5655
   End
   Begin VB.DriveListBox cbDrive 
      Height          =   315
      Left            =   120
      TabIndex        =   5
      Top             =   1200
      Width           =   2415
   End
   Begin VB.Frame Frame6 
      Height          =   975
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   5805
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
         Height          =   615
         Left            =   840
         TabIndex        =   4
         Top             =   240
         Width           =   4035
      End
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   4560
      TabIndex        =   2
      Top             =   3960
      Width           =   1215
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save"
      Height          =   375
      Left            =   4560
      TabIndex        =   1
      Top             =   3480
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "File Name:"
      Height          =   255
      Left            =   240
      TabIndex        =   7
      Top             =   3600
      Width           =   855
   End
End
Attribute VB_Name = "frmDataBackup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdSave_Click()
'Purpose: On Click:
            'Get DBName
            'Copy File to destination
Dim fso As New FileSystemObject
Dim dbSource As String
Dim backupDestination As String
Dim w_DbName As String

    
    'Get DB filepath
    w_DbName = getDbName
    
    'Create DB Source location
    dbSource = CurDir & "\" & w_DbName
    
    'If sFileName is empty, display error msg
    If Len(sFileName.Text) = 0 Then
        GoTo errHandler
        
    'Otherwise, create the backup destination
    ElseIf Len(sFileName.Text) <> 0 Then
        'User-defined directory to store
        backupDestination = listDir.Path & "\" & sFileName.Text & ".mdb"
    End If
    
    On Error Resume Next
    
    'Copy the Access file to the selected location with the entered filename
    fso.CopyFile dbSource, backupDestination
    
    If Err.Number = 76 Then
        MsgBox "Path Not Found", vbCritical, "Path Error"
        Exit Sub
    End If

    system_db.write_systemLog g_SystemBackup, dbModuleBackup, vbNullString
            
    showSuccess
    
    Exit Sub
    
errHandler:
    MsgBox "You Must Enter A Filename", vbExclamation, "Save Error"
End Sub

Function getDbName() As String
'Purpose: Access segfile.ini and return the DbName
Dim fso As New FileSystemObject
Dim segFile As File
Dim w_Ts As TextStream
Dim w_DbName As String
Dim fileContents As String
Dim counter As Integer
Dim strLength As Integer
Dim equalsLocation As Integer

    'Set segfile.ini
    Set segFile = fso.GetFile(CurDir & "\SEGFILE.INI")
    
    'Open sefile for reading
    Set w_Ts = segFile.OpenAsTextStream(ForReading)
    
    'Flush contents to fileContents
    fileContents = w_Ts.ReadAll ' Read all the file
    
    'Get index of "="
    equalsLocation = InStr(fileContents, "=")
    
    'Store length
    strLength = Len(fileContents)
    
    w_DbName = Mid(fileContents, equalsLocation + 1, strLength - equalsLocation)
    
    'Close segfile
    w_Ts.Close
        
    'Return database name
    getDbName = w_DbName
    
End Function

Private Sub showSuccess()
Dim successMsg As Integer
    successMsg = MsgBox("Database Backup Successful", vbOKOnly, "Backup Confirmation")
    Unload Me
End Sub

Private Sub Form_Deactivate()
    Me.Hide
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    
    lblFunction.Caption = "Select The Folder Where The Backup File Should Be Stored"

    'Set a Default filename
    sFileName.Text = "LawBackup_" & Format(Now, "dd-mm-yyyy")

End Sub

Private Sub cbDrive_Change()
    On Error Resume Next
    
    listDir.Path = cbDrive.Drive
    
    If Err.Number = 68 Then
        MsgBox "No Disk Inserted", vbCritical, "ERROR"
        Exit Sub
    End If
End Sub
