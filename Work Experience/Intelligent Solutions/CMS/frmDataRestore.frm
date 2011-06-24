VERSION 5.00
Begin VB.Form frmDataRestore 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Data Restore"
   ClientHeight    =   4395
   ClientLeft      =   2760
   ClientTop       =   3750
   ClientWidth     =   7080
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4395
   ScaleWidth      =   7080
   ShowInTaskbar   =   0   'False
   Begin VB.FileListBox listFiles 
      Height          =   2625
      Left            =   3120
      Pattern         =   "*.mdb*"
      TabIndex        =   6
      Top             =   1560
      Width           =   2535
   End
   Begin VB.DirListBox listDir 
      Height          =   2565
      Left            =   240
      TabIndex        =   5
      Top             =   1560
      Width           =   2775
   End
   Begin VB.DriveListBox cbDrive 
      Height          =   315
      Left            =   240
      TabIndex        =   4
      Top             =   1200
      Width           =   2415
   End
   Begin VB.Frame Frame6 
      Height          =   975
      Left            =   600
      TabIndex        =   2
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
         TabIndex        =   3
         Top             =   240
         Width           =   4035
      End
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   5760
      TabIndex        =   1
      Top             =   3720
      Width           =   1215
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   5760
      TabIndex        =   0
      Top             =   3240
      Width           =   1215
   End
End
Attribute VB_Name = "frmDataRestore"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdOK_Click()

Dim fso As New FileSystemObject
Dim segFile As File
Dim w_Ts As TextStream

Dim w_FilePath As String
Dim w_DbName As String
Dim w_DbSource As String
   
    w_DbName = CStr(listFiles)
    
    w_FilePath = listFiles.Path & "\" & w_DbName
    
    'Get the segfile
    Set segFile = fso.GetFile(CurDir & "\SEGFILE.INI")
    
    On Error GoTo errHandler
    
    'copy file from source to CurDir
    fso.CopyFile w_FilePath, CurDir & "\" & w_DbName, True
    
    'Open segfile
    Set w_Ts = segFile.OpenAsTextStream(ForWriting)
    
    'Write the segfile with the new DB
    w_Ts.Write ("[SETUP]" & vbCr & "Database=" & w_DbName)
    
    'Close segfile
    w_Ts.Close
    
    'Show success
    showSuccess
    'Write to System Log
    system_db.write_systemLog g_SystemRestore, dbModuleRestore, vbNullString
    
    Exit Sub

errHandler:
    MsgBox "Database Not Restored", vbCritical, "Restore Error"

End Sub

Private Sub Form_Deactivate()
    Me.Hide
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    lblFunction.Caption = "Select The Access File You Wish To Restore"
End Sub

Private Sub listDir_Change()
    listFiles.Path = listDir.Path
End Sub

Private Sub cbDrive_Change()
    On Error Resume Next
    
    listDir.Path = cbDrive.Drive
    
    If Err.Number = 68 Then
        MsgBox "No Disk Inserted", vbCritical, "ERROR"
        Exit Sub
    End If
End Sub

Private Sub showSuccess()
    MsgBox "Database Restore Successful" & vbCr & "Please Restart The Application", vbOKOnly, "Restore Confirmation"
    Unload Me
End Sub
