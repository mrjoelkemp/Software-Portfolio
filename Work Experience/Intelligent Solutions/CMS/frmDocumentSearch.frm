VERSION 5.00
Begin VB.Form frmDocumentSearch 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   8265
   ClientLeft      =   0
   ClientTop       =   -300
   ClientWidth     =   11490
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8265
   ScaleWidth      =   11490
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame4 
      Height          =   1095
      Left            =   120
      TabIndex        =   6
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
         TabIndex        =   8
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
         TabIndex        =   7
         Top             =   240
         Width           =   11055
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "File(s)"
      Height          =   4695
      Left            =   4920
      TabIndex        =   4
      Top             =   2400
      Width           =   4695
      Begin VB.FileListBox File1 
         Appearance      =   0  'Flat
         Height          =   4125
         Left            =   240
         TabIndex        =   5
         Top             =   360
         Width           =   4215
      End
      Begin VB.Shape Shape3 
         BorderWidth     =   2
         Height          =   3615
         Left            =   240
         Top             =   360
         Width           =   4215
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Folder(s)"
      Height          =   4695
      Left            =   120
      TabIndex        =   2
      Top             =   2400
      Width           =   4695
      Begin VB.DirListBox Dir1 
         Appearance      =   0  'Flat
         Height          =   4140
         Left            =   240
         TabIndex        =   3
         Top             =   360
         Width           =   4215
      End
      Begin VB.Shape Shape2 
         BackColor       =   &H8000000F&
         BorderWidth     =   2
         Height          =   4095
         Left            =   240
         Top             =   360
         Width           =   4215
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Hard Disk Drives"
      Height          =   1215
      Left            =   120
      TabIndex        =   0
      Top             =   1200
      Width           =   4695
      Begin VB.DriveListBox Drive1 
         Appearance      =   0  'Flat
         Height          =   315
         Left            =   240
         TabIndex        =   1
         Top             =   480
         Width           =   4215
      End
   End
End
Attribute VB_Name = "frmDocumentSearch"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim docPath As String

Private Sub Dir1_Change()
    File1.Path = Dir1.Path
End Sub

Private Sub Drive1_Change()
    On Error Resume Next
    
    Dir1.Path = Drive1.Drive
    
    If Err.Number = 68 Then
        MsgBox "No Disk Inserted", vbCritical, "ERROR"
        Exit Sub
    End If
End Sub

Private Sub File1_DblClick()

    If (Len(Dir1.Path) = 3) Then
        docPath = Dir1.Path & File1.FileName
        Exit Sub
    Else
        docPath = Dir1.Path & "\" & File1.FileName
    End If
    
    'Set filepath textbox to the filepath of the document selected
    frmDocuments.sFilePath.Text = docPath
    
    Hide
    showSelectScreen
    
End Sub

Private Sub Form_Activate()
        
    setFormProperties
    
End Sub

Function setFormProperties()
    
    isRightScreenToHide ("frmDocumentSearch")
    setCurrentScreen ("frmDocumentSearch")
    frmMDI.hideSelfModuleButton
    
    lblFunction.Caption = "Double Click on the Document to Add"
    
    lblWindow = "Documents - Search"
    
    'Set title of window in Status Bar
    frmMDI.setStatusBar (lblWindow.Caption)

End Function

Private Sub Form_Deactivate()
    'Me.Hide
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0

End Sub

Function getDocumentPath()
    getDocumentPath = docPath
End Function
