VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmHelp 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "CMS Help Center"
   ClientHeight    =   6405
   ClientLeft      =   2760
   ClientTop       =   3750
   ClientWidth     =   9000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6405
   ScaleWidth      =   9000
   ShowInTaskbar   =   0   'False
   Begin VB.Frame fraDetails 
      Caption         =   "Details"
      Height          =   3975
      Left            =   3240
      TabIndex        =   7
      Top             =   1560
      Width           =   5535
      Begin RichTextLib.RichTextBox RichTextBox1 
         Height          =   3615
         Left            =   120
         TabIndex        =   9
         Top             =   240
         Width           =   5295
         _ExtentX        =   9340
         _ExtentY        =   6376
         _Version        =   393217
         TextRTF         =   $"frmHelp.frx":0000
      End
   End
   Begin VB.Frame fraSubTopics 
      Caption         =   "Sub Topics"
      Height          =   3975
      Left            =   240
      TabIndex        =   6
      Top             =   1560
      Width           =   2775
      Begin MSComctlLib.TreeView TreeView1 
         Height          =   3615
         Left            =   120
         TabIndex        =   8
         Top             =   240
         Width           =   2535
         _ExtentX        =   4471
         _ExtentY        =   6376
         _Version        =   393217
         Style           =   7
         Appearance      =   1
      End
   End
   Begin VB.ComboBox cbTopics 
      Height          =   315
      Left            =   1320
      TabIndex        =   0
      Text            =   "Please Select a Topic"
      Top             =   1080
      Width           =   2655
   End
   Begin VB.Frame Frame6 
      Height          =   735
      Left            =   240
      TabIndex        =   3
      Top             =   120
      Width           =   8535
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
         Left            =   840
         TabIndex        =   4
         Top             =   240
         Width           =   6975
      End
   End
   Begin VB.CommandButton CancelButton 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   7560
      TabIndex        =   2
      Top             =   5760
      Width           =   1215
   End
   Begin VB.CommandButton OKButton 
      Caption         =   "Done"
      Height          =   375
      Left            =   6120
      TabIndex        =   1
      Top             =   5760
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Topics:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   360
      TabIndex        =   5
      Top             =   1080
      Width           =   735
   End
End
Attribute VB_Name = "frmHelp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub Form_Deactivate()
    Me.Hide
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    lblFunction.Caption = "Please Select A Topic Below"
End Sub
