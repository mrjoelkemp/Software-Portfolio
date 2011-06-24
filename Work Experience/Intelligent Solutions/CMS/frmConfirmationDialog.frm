VERSION 5.00
Begin VB.Form frmConfirmationDialog 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Confirmation Dialog"
   ClientHeight    =   1695
   ClientLeft      =   2760
   ClientTop       =   3750
   ClientWidth     =   3630
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1695
   ScaleWidth      =   3630
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton CancelButton 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   2040
      TabIndex        =   1
      Top             =   1200
      Width           =   1215
   End
   Begin VB.CommandButton OKButton 
      Caption         =   "Continue"
      Height          =   375
      Left            =   480
      TabIndex        =   0
      Top             =   1200
      Width           =   1215
   End
   Begin VB.Label lblBottom 
      Caption         =   "Changes will be lost."
      Height          =   255
      Left            =   1080
      TabIndex        =   3
      Top             =   600
      Width           =   1575
   End
   Begin VB.Label lblTop 
      Caption         =   "Data has not been saved."
      Height          =   255
      Left            =   840
      TabIndex        =   2
      Top             =   240
      Width           =   1935
   End
End
Attribute VB_Name = "frmConfirmationDialog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

'Function CancelButton_Click()
    
'    Hide
'End Function

Public Sub showConfirmationDialog(msgTop As String, msgBottom As String, Optional okBtnText As String, Optional cancelBtnText As String, Optional title As String)
    
    lblTop.Caption = msgTop
    lblBottom.Caption = msgBottom
    
    If title <> vbNullString Then
        Me.title = title
    End If
    
    If okBtnText <> vbNullString Then
        OKButton.Caption = okBtnText
    End If
    
    If cancelBtnText <> vbNullString Then
        CancelButton.Caption = cancelBtnText
    End If

End Sub

'Function OKButton_Click()

    'OKButton_Click = 1
 '   Hide
'End Function
