VERSION 5.00
Begin VB.Form frmCaseNew 
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
   Begin VB.Frame Frame9 
      Caption         =   "Other Details:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1335
      Left            =   3960
      TabIndex        =   50
      Top             =   3600
      Width           =   3615
      Begin VB.ComboBox cbCourts 
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
         Left            =   1080
         TabIndex        =   15
         Top             =   720
         Width           =   2415
      End
      Begin VB.TextBox sProsecutor 
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
         Left            =   1680
         TabIndex        =   14
         Top             =   360
         Width           =   1815
      End
      Begin VB.Label Label16 
         Caption         =   "Court *:"
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
         Left            =   120
         TabIndex        =   52
         Top             =   840
         Width           =   855
      End
      Begin VB.Label Label15 
         Caption         =   "Prosecutor:"
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
         Left            =   120
         TabIndex        =   51
         Top             =   480
         Width           =   855
      End
   End
   Begin VB.Frame Frame8 
      Caption         =   "Judge Details:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2175
      Left            =   7680
      TabIndex        =   46
      Top             =   3600
      Width           =   3615
      Begin VB.TextBox sJlastname 
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
         Left            =   1680
         TabIndex        =   21
         Top             =   720
         Width           =   1815
      End
      Begin VB.TextBox sJfirstname 
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
         Left            =   1680
         TabIndex        =   22
         Top             =   1080
         Width           =   1815
      End
      Begin VB.TextBox sJid 
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
         Left            =   1680
         TabIndex        =   20
         Top             =   360
         Width           =   1815
      End
      Begin VB.CommandButton cmdSearchJ 
         Caption         =   "Search For Judge"
         Height          =   375
         Left            =   1680
         TabIndex        =   23
         Top             =   1560
         Width           =   1815
      End
      Begin VB.Label Label14 
         Caption         =   "ID :"
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
         Left            =   120
         TabIndex        =   49
         Top             =   480
         Width           =   855
      End
      Begin VB.Label Label10 
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
         Left            =   120
         TabIndex        =   48
         Top             =   840
         Width           =   855
      End
      Begin VB.Label Label9 
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
         Left            =   120
         TabIndex        =   47
         Top             =   1200
         Width           =   855
      End
   End
   Begin VB.Frame Frame7 
      Caption         =   "Additional Information"
      Height          =   2535
      Left            =   120
      TabIndex        =   45
      Top             =   4200
      Width           =   3735
      Begin VB.TextBox sAddInfo 
         Height          =   2175
         Left            =   120
         MaxLength       =   255
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   24
         Top             =   240
         Width           =   3495
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Additional:"
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
      Left            =   0
      TabIndex        =   44
      Top             =   6840
      Width           =   7455
      Begin VB.CommandButton cmdDocuments 
         Height          =   615
         Left            =   6600
         Picture         =   "frmFileNew.frx":0000
         Style           =   1  'Graphical
         TabIndex        =   26
         ToolTipText     =   "Documents"
         Top             =   240
         Width           =   735
      End
      Begin VB.CommandButton cmdNotes 
         Height          =   615
         Left            =   5880
         Picture         =   "frmFileNew.frx":030A
         Style           =   1  'Graphical
         TabIndex        =   25
         ToolTipText     =   "Notes"
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame Frame6 
      Height          =   1095
      Left            =   120
      TabIndex        =   36
      Top             =   120
      Width           =   11295
      Begin VB.Label Label22 
         Caption         =   "* Denotes Required Field"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   64
         Top             =   720
         Width           =   2775
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
         TabIndex        =   43
         Top             =   240
         Width           =   11055
      End
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
         TabIndex        =   37
         Top             =   600
         Width           =   11055
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "File Details:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2895
      Left            =   120
      TabIndex        =   32
      Top             =   1320
      Width           =   3735
      Begin VB.ComboBox cbCloseMonth 
         Height          =   315
         Left            =   2160
         TabIndex        =   7
         ToolTipText     =   "Month"
         Top             =   1680
         Width           =   615
      End
      Begin VB.ComboBox cbCloseDay 
         Height          =   315
         ItemData        =   "frmFileNew.frx":0BD4
         Left            =   1560
         List            =   "frmFileNew.frx":0BD6
         TabIndex        =   6
         ToolTipText     =   "Day"
         Top             =   1680
         Width           =   615
      End
      Begin VB.ComboBox cbCloseYear 
         Height          =   315
         ItemData        =   "frmFileNew.frx":0BD8
         Left            =   2760
         List            =   "frmFileNew.frx":0BDA
         TabIndex        =   8
         ToolTipText     =   "Year"
         Top             =   1680
         Width           =   855
      End
      Begin VB.ComboBox cbOpenMonth 
         Height          =   315
         Left            =   2160
         TabIndex        =   4
         ToolTipText     =   "Month"
         Top             =   1320
         Width           =   615
      End
      Begin VB.ComboBox cbOpenDay 
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "MM/dd/yyyy"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
         Height          =   315
         ItemData        =   "frmFileNew.frx":0BDC
         Left            =   1560
         List            =   "frmFileNew.frx":0BDE
         TabIndex        =   3
         ToolTipText     =   "Day"
         Top             =   1320
         Width           =   615
      End
      Begin VB.ComboBox cbOpenYear 
         Height          =   315
         ItemData        =   "frmFileNew.frx":0BE0
         Left            =   2760
         List            =   "frmFileNew.frx":0BE2
         TabIndex        =   5
         ToolTipText     =   "Year"
         Top             =   1320
         Width           =   855
      End
      Begin VB.TextBox sAttendingSecretary 
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
         Left            =   1680
         TabIndex        =   9
         Top             =   2160
         Width           =   1935
      End
      Begin VB.TextBox sCaseID 
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
         Left            =   1800
         TabIndex        =   0
         Top             =   240
         Width           =   1815
      End
      Begin VB.ComboBox cbStatus 
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
         Left            =   1800
         TabIndex        =   2
         Text            =   "Pending"
         Top             =   960
         Width           =   1815
      End
      Begin VB.ComboBox cbType 
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
         Left            =   1800
         TabIndex        =   1
         Top             =   600
         Width           =   1815
      End
      Begin VB.Label Label20 
         Caption         =   "Attending Secretary *:"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   240
         TabIndex        =   63
         Top             =   2160
         Width           =   1095
      End
      Begin VB.Label Label8 
         Caption         =   "File # *:"
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
         TabIndex        =   42
         Top             =   360
         Width           =   1095
      End
      Begin VB.Label Label7 
         Caption         =   "Date Closed:"
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
         TabIndex        =   41
         Top             =   1800
         Width           =   1095
      End
      Begin VB.Label Label13 
         Caption         =   "Type *:"
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
         TabIndex        =   35
         Top             =   720
         Width           =   855
      End
      Begin VB.Label Label12 
         Caption         =   "Status:"
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
         TabIndex        =   34
         Top             =   1080
         Width           =   855
      End
      Begin VB.Label Label11 
         Caption         =   "Date Opened:"
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
         TabIndex        =   33
         Top             =   1440
         Width           =   1095
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Client Details:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2175
      Left            =   3960
      TabIndex        =   31
      Top             =   1320
      Width           =   3615
      Begin VB.Frame Frame4 
         Caption         =   "Client Details:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2175
         Left            =   0
         TabIndex        =   53
         Top             =   0
         Visible         =   0   'False
         Width           =   3615
         Begin VB.TextBox sCFullName 
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
            Left            =   1680
            TabIndex        =   55
            Top             =   720
            Width           =   1815
         End
         Begin VB.TextBox sCid2 
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
            Left            =   1680
            TabIndex        =   54
            Top             =   360
            Width           =   1815
         End
         Begin VB.Label Label18 
            Caption         =   "Full Name:"
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
            Left            =   120
            TabIndex        =   57
            Top             =   840
            Width           =   855
         End
         Begin VB.Label Label17 
            Caption         =   "Account #:"
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
            Left            =   120
            TabIndex        =   56
            Top             =   480
            Width           =   1095
         End
      End
      Begin VB.CommandButton cmdSearchC 
         Caption         =   "Search For Client"
         Height          =   375
         Left            =   1680
         TabIndex        =   13
         Top             =   1560
         Width           =   1815
      End
      Begin VB.TextBox sCid 
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
         Left            =   1680
         TabIndex        =   10
         Top             =   360
         Width           =   1815
      End
      Begin VB.TextBox sClastname 
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
         Left            =   1680
         TabIndex        =   11
         Top             =   720
         Width           =   1815
      End
      Begin VB.TextBox sCfirstname 
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
         Left            =   1680
         TabIndex        =   12
         Top             =   1080
         Width           =   1815
      End
      Begin VB.Label Label6 
         Caption         =   "Account # *:"
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
         Left            =   120
         TabIndex        =   40
         Top             =   480
         Width           =   1095
      End
      Begin VB.Label Label5 
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
         Left            =   120
         TabIndex        =   39
         Top             =   840
         Width           =   855
      End
      Begin VB.Label Label4 
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
         Left            =   120
         TabIndex        =   38
         Top             =   1200
         Width           =   855
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Attorney Details:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2175
      Left            =   7680
      TabIndex        =   27
      Top             =   1320
      Width           =   3615
      Begin VB.Frame Frame10 
         Caption         =   "Attorney Details:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2175
         Left            =   0
         TabIndex        =   58
         Top             =   0
         Visible         =   0   'False
         Width           =   3615
         Begin VB.TextBox sAFullName 
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
            Left            =   1680
            TabIndex        =   61
            Top             =   720
            Width           =   1815
         End
         Begin VB.TextBox sAid2 
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
            Left            =   1680
            TabIndex        =   59
            Top             =   360
            Width           =   1815
         End
         Begin VB.Label Label19 
            Caption         =   "Full Name:"
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
            Left            =   120
            TabIndex        =   62
            Top             =   840
            Width           =   855
         End
         Begin VB.Label Label21 
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
            Left            =   120
            TabIndex        =   60
            Top             =   480
            Width           =   855
         End
      End
      Begin VB.CommandButton cmdSearchA 
         Caption         =   "Search For Attorney"
         Height          =   375
         Left            =   1680
         TabIndex        =   19
         Top             =   1560
         Width           =   1815
      End
      Begin VB.TextBox sAid 
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
         Left            =   1680
         TabIndex        =   16
         Top             =   360
         Width           =   1815
      End
      Begin VB.TextBox sAfirstname 
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
         Left            =   1680
         TabIndex        =   18
         Top             =   1080
         Width           =   1815
      End
      Begin VB.TextBox sALastname 
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
         Left            =   1680
         TabIndex        =   17
         Top             =   720
         Width           =   1815
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
         Left            =   120
         TabIndex        =   30
         Top             =   1200
         Width           =   855
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
         Left            =   120
         TabIndex        =   29
         Top             =   840
         Width           =   855
      End
      Begin VB.Label Label1 
         Caption         =   "ID :"
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
         Left            =   120
         TabIndex        =   28
         Top             =   480
         Width           =   855
      End
   End
End
Attribute VB_Name = "frmCaseNew"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'Flag to keep track of initial data load
'If you loaded the data, you will only load data again,
'when you come from search module.
Dim is_loaded    As Boolean

Public Sub setIsLoaded(value As Boolean)
'Purpose: Set the status of the is_loaded flag to the passed parameter
    is_loaded = value
End Sub

Private Sub cmdDocuments_Click()
    g_DocumentMode = "VIEW"
    
    g_ButtonMode = "DOCUMENTS"
    g_CaseID = sCaseID.Text
    frmDocuments.Show
End Sub

Private Sub cmdNotes_Click()
    If g_CaseMode = "VIEW" Then
        g_NoteMode = "VIEW"
    Else
        g_NoteMode = "NEW"
    End If
    
    g_ButtonMode = "NOTES"
    g_NoteCallingModule = "frmCaseNew"
    frmNotes.Show
End Sub

Private Sub cmdSave_Click()
    write_DB
    
End Sub

Private Sub cmdSearchA_Click()
    g_AttorneyMode = "SEARCH"
    frmAttorneySearch.Show
    
End Sub

Private Sub cmdSearchC_Click()
    g_ClientMode = "SEARCH"
    frmClientSearch.Show
    
End Sub

Private Sub cmdSearchJ_Click()
    g_JudgeMode = "SEARCH"
    frmJudgesSearch.Show
    
End Sub

Function write_DB()
'Purpose: Carry out Database Operations (Insert, Update, Delete)

Dim w_SQL As String
Dim w_Recordset As New Recordset
Dim w_OpenDate As String
Dim w_CloseDate As String
Dim w_OpenTimestamp As String
Dim w_CloseTimestamp As String
Dim courtCode As String
Dim typeCode As String
Dim statusCode As String


    'Initialize
    w_OpenTimestamp = vbNullString
    w_CloseTimestamp = vbNullString

    w_OpenDate = cbOpenYear.Text & cbOpenMonth.Text & cbOpenDay.Text
    w_CloseDate = cbCloseYear.Text & cbCloseMonth.Text & cbCloseDay.Text

    'Only create timestamp when a new case is being created
    If g_CaseMode = "NEW" Then
        If cbStatus.Text = "Open" Then
            'Store Current timestamp
            w_OpenTimestamp = Format(Now, "mm/dd/yyyy hh:mm am/pm")
        End If
    End If
    
    'Once status is set to closed, create timestamp
    If cbStatus.Text = "Closed" Then
        'Status is Closed
        w_CloseTimestamp = Format(Now, "mm/dd/yyyy hh:mm am/pm")
    End If
    
    'Get court code for selected Court
    w_SQL = "Select courtcode from courts where description = " & Chr(34) & _
        cbCourts.Text & Chr(34)
    courtCode = getCode(w_SQL, "Court")

    'Get type code for selected type
    w_SQL = "Select typecode from types where description = " & Chr(34) & _
        cbType.Text & Chr(34)
    typeCode = getCode(w_SQL, "Type")
    
    'Get status code for selected status
    w_SQL = "Select statuscode from status where description = " & Chr(34) & _
        cbStatus.Text & Chr(34)
    statusCode = getCode(w_SQL, "Status")
    
    'Based on mode
    Select Case g_CaseMode
        'Construct appropriate SQL query
        
        Case "NEW"
        'Insert Query
        w_SQL = "Insert into Cases values ('" & _
                sCaseID.Text & "', '" & _
                sCid.Text & "', '" & _
                sAid.Text & "', '" & _
                sJid.Text & "', '" & _
                statusCode & "', '" & _
                typeCode & "', '" & _
                w_OpenDate & "', '" & _
                w_OpenTimestamp & "', '" & _
                w_CloseDate & "', '" & _
                w_CloseTimestamp & "', '" & _
                sAttendingSecretary.Text & "', '" & _
                sProsecutor.Text & "', '" & _
                courtCode & "', '" & _
                sAddInfo.Text & "')"
        
        Case "MODIFY"
        'Update Query
        w_SQL = "Update cases Set " & _
            "Status=" & Chr(34) & statusCode & Chr(34) & _
            ", Type=" & Chr(34) & typeCode & Chr(34) & _
            ", dateopen=" & Chr(34) & w_OpenDate & Chr(34) & _
            ", dateclose=" & Chr(34) & w_CloseDate & Chr(34) & _
            ", dateclosetimestamp= " & Chr(34) & w_CloseTimestamp & Chr(34) & _
            ", attendingsecretary= " & Chr(34) & sAttendingSecretary & Chr(34) & _
            ", additional=" & Chr(34) & sAddInfo.Text & Chr(34) & _
            ", judgeid= " & Chr(34) & sJid.Text & Chr(34) & _
            ", attorneyid= " & Chr(34) & sAid.Text & Chr(34) & _
            ", court= " & Chr(34) & courtCode & Chr(34) & _
            " Where caseid=" & Chr(34) & sCaseID.Text & Chr(34) & ";"
                
    End Select
    
    'If DB Error occurs, resume operation
    On Error Resume Next
    
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        'If the File ID creates a Duplicate Entry
        If Err.Number = -2147467259 Then
            'Display Error Msg
            MsgBox "File ID Already Exists" & vbCr, vbExclamation, "Duplicate ID"
            Exit Function
        End If
 
        If .State = 1 Then
            .Close
        End If
    End With
    
    'Write a log in the system
    system_db.write_systemLog g_CaseMode, dbModuleCase, sCaseID.Text

    'Show respective confirmation message
    showSuccess
    frmMDI.showModuleButtons
    clear_Fields
    
    'Return to search screen
    returnToPreviousScreen

End Function

Public Sub deleteCase(caseID As String)
'Purpose:   Called by frmMDI when user clicks the delete toolbar button
'           Deletes the case according to the passed in caseID
Dim w_SQL       As String
Dim w_Recordset As New Recordset

    On Error GoTo errHandler
        
        'Delete case information
        w_SQL = "Delete * From cases Where caseid=" & Chr(34) & caseID & Chr(34) & ";"
    
        With w_Recordset
            'Execute the query
            .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            
            If .State = 1 Then
                .Close
            End If
            
            'Grab the id of all the case's notes
            w_SQL = "Select noteid from notes where itemid = '" & caseID & "'"
            
            'Execute the query
            .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            Do While .EOF = False
                'Delete the case's notes
                frmNotes.deleteANote (!noteID)
                .MoveNext
            Loop
            
            If .State = 1 Then
                .Close
            End If
            
            'Grab the id of all the case's documents
            w_SQL = "Select documentid from documents where caseid = '" & caseID & "'"
            
            'Execute the query
            .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            Do While .EOF = False
                'Delete the case's documents
                frmDocuments.deleteADocument (!documentID)
                .MoveNext
            Loop
            
            If .State = 1 Then
                .Close
            End If
            
        End With
        
        'Write a log in the system
        system_db.write_systemLog g_SystemDelete, dbModuleCase, caseID

    Exit Sub

errHandler:
MsgBox "Error In Deleting File", vbCritical, "Error"
    
End Sub

Public Sub returnToPreviousScreen()
    
    'Hide me
    frmCaseNew.Hide
    
    If g_CaseCallingModule = vbNullString Then
        frmCaseSearch.Show
    
    End If
    
    Select Case g_CaseCallingModule
        Case "frmCases"
            frmCases.Show
        Case "frmAttorneyNew"
            frmAttorneyNew.Show
        Case "frmClientNew"
            frmClientNew.Show
    End Select
    
End Sub

Function getCode(SQL, codeType)
'Purpose: Function takes in an SQL query and a code type. Returns the appropriate DB code.
'   Code Type refers to 'Court', 'Status', 'Type', etc
Dim w_Recordset As New Recordset

    With w_Recordset
       .Open SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
       
        Select Case codeType
            Case "Type"
                If Not .EOF Then
                     'Get typecode
                     getCode = !typeCode
                End If
            Case "Court"
                If Not .EOF Then
                    'Get courtcode
                    getCode = !courtCode
                End If
            Case "Status"
                If Not .EOF Then
                    'Get statuscode
                    getCode = !statusCode
                End If
        End Select
       If .State = 1 Then
            .Close
        End If
    End With


End Function

Function showError()
    Dim errorMsg As Integer
       'Based on mode
       Select Case g_CaseMode
        'Show appropriate error dialog box
        Case "NEW"
            errorMsg = MsgBox("File Information Not Entered" & vbCr & "Please check the File Number", 0, "Creation Error")
        Case "MODIFY"
            errorMsg = MsgBox("File Information Not Modified" & vbCr & "Database Error", 0, "Modification Error")
           
    End Select

End Function

Function showSuccess()
    Dim doneMsg As Integer
       'Based on mode
       Select Case g_CaseMode
        'Show appropriate confirmation dialog box
        Case "NEW"
            doneMsg = MsgBox("File Information Entered Successfully", 0, "Entry Confirmation")
            clear_Fields
        Case "MODIFY"
            doneMsg = MsgBox("File Information Modified Successfully", 0, "Modification Confirmation")
            clear_Fields
            Hide
            showSelectScreen
    End Select

End Function

Function clear_Fields()
'Purpose: Clear the text fields (reset)
    
    sCaseID.Text = vbNullString
    cbType.Text = "Select"
    cbStatus.Text = "Pending"
    
    cbOpenDay.Text = vbNullString
    cbOpenMonth.Text = vbNullString
    cbOpenYear.Text = vbNullString
    
    cbCloseDay.Text = vbNullString
    cbCloseMonth.Text = vbNullString
    cbCloseYear.Text = vbNullString
    
    sCid.Text = vbNullString
    sClastname.Text = vbNullString
    sCfirstname.Text = vbNullString
    
    sAid.Text = vbNullString
    sAfirstname.Text = vbNullString
    sALastname.Text = vbNullString
    
    sJid.Text = vbNullString
    sJfirstname.Text = vbNullString
    sJlastname.Text = vbNullString
    
    sProsecutor.Text = vbNullString
    cbCourts.Text = "None"
    sAddInfo.Text = vbNullString
    sAttendingSecretary.Text = vbNullString
            
End Function

Private Sub Form_Deactivate()
    'Me.Hide
End Sub

Private Sub Form_Load()

    Me.Top = 0
    Me.Left = 0
    
    setDateCombos
    
End Sub

Private Sub Form_Activate()

    setFormProperties

    Select Case g_CaseMode
        
        Case "NEW"
            'Make all fields enabled
            sCaseID.Enabled = True
            sCid.Enabled = True
            sAid.Enabled = True
            sClastname.Enabled = True
            sCfirstname.Enabled = True
            'Status is only editable when modifying case
            cbStatus.Enabled = False
            lblFunction.Caption = "Enter Case Details And Press Save"
            lblWindow.Caption = "Cases - New"
        
        Case "MODIFY"
            If is_loaded = False Then
                'Load Case data
                load_Data
                'Set flag to true because data has been loaded
                is_loaded = True
            End If
            
            'User cannot change certain attributes
            sCaseID.Enabled = False
            sCid.Enabled = False
            sClastname.Enabled = False
            sCfirstname.Enabled = False
            cbStatus.Enabled = True
            
            lblFunction.Caption = "Modify Case Details And Press Save"
            lblWindow.Caption = "Cases - Modify"
                
        Case "VIEW"
            If is_loaded = False Then
                load_Data
                is_loaded = True
            End If
            lblFunction.Caption = "Case Details Listed Below"
            lblWindow.Caption = "Cases - View"
            frmMDI.makeSaveRecInvisible
            frmMDI.makePrintButtonVisible
            Frame10.Visible = False
            Frame4.Visible = False
            
    End Select
    
    Select Case g_CaseCallingModule
        Case "frmAttorneyNew"
            'Activate Hidden Attorney Frame
            Frame10.Visible = True
            'Get Attorney Information for Hidden Frame
            sAid2.Text = frmAttorneyNew.sAttorneyID.Text
            sAFullName = frmAttorneyNew.sFirstName.Text & " " & _
                frmAttorneyNew.sLastName.Text
            'Set Original Frame Information -- used in storing;
            'avoids creating new SQLquery
            sAid.Text = frmAttorneyNew.sAttorneyID.Text

        Case "frmClientNew"
            'Activate Hidden Client Frame
            Frame4.Visible = True
            'Get Client Information for Hidden Frame
            sCid2.Text = frmClientNew.sClientID.Text
            sCFullName = frmClientNew.sFirstName.Text & " " & _
                frmClientNew.sLastName.Text
            'Set Original Frame Information -- used in storing;
            'avoids creating new SQLquery
            sCid.Text = frmClientNew.sClientID.Text
    End Select
   
End Sub

Function setFormProperties()
    
    Load_Combo_Info
    
    frmMDI.showModuleButtons
    isRightScreenToHide ("frmCaseNew")
    
    Frame4.Visible = False
    Frame10.Visible = False

    'Set Current Screen
    setCurrentScreen ("frmCaseNew")
    frmMDI.hideSelfModuleButton
    
    caseChange = False
  
    'Set title of window in Status Bar
    frmMDI.setStatusBar (lblWindow.Caption)
    
End Function

Private Sub load_Data()
Dim w_SQL As String
Dim w_SQL2 As String
Dim w_SQL3 As String
Dim w_SQLs As String
Dim w_SQLt As String
Dim w_SQLc As String
Dim w_Recordset As New Recordset

    On Error GoTo errHandler:

    w_SQL = "select * from Cases where Caseid = '" & g_CaseID & "'"
    
    With w_Recordset
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        
        If Not .EOF Then
            sCaseID.Text = !caseID

            cbOpenDay.Text = Mid(!dateopen, 7, 2)
            cbOpenMonth.Text = Mid(!dateopen, 5, 2)
            cbOpenYear.Text = Mid(!dateopen, 1, 4)
            
            cbCloseDay.Text = Mid(!dateclose, 7, 2)
            cbCloseMonth.Text = Mid(!dateclose, 5, 2)
            cbCloseYear.Text = Mid(!dateclose, 1, 4)
            
            sAttendingSecretary.Text = !attendingsecretary
            sCid.Text = !clientid
            sAid.Text = !attorneyid
            sJid.Text = !judgeid
            sProsecutor.Text = !prosecutor
            sAddInfo.Text = !additional
            
            w_SQLs = "Select description from status where statuscode = " & !Status '& "'"
            w_SQLt = "Select description from types where typecode = " & !Type '& "'"
            w_SQLc = "Select description from courts where courtcode = " & !court '& "'"

        End If
        
        'Select all information from clients where the clientid is the clientid of the current Case
        w_SQL = "select * from clients where clientid = '" & !clientid & "'"
        w_SQL2 = "select * from attorneys where attorneyid = '" & !attorneyid & "'"
        'Judge Query
        w_SQL3 = "Select * from judges where judgeid = '" & !judgeid & "'"
        
        If .State = 1 Then
            .Close
        End If
        
    End With

    'Get Court info
    cbCourts.Text = getDescription(w_SQLc)
    
    'Get Status Info
    cbStatus.Text = getDescription(w_SQLs)
    
    'Get Type Info
    cbType.Text = getDescription(w_SQLt)

    
    With w_Recordset
        'Load Client Info
        .Open w_SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        sClastname.Text = !lastname
        sCfirstname.Text = !firstname
        If .State = 1 Then
            .Close
        End If
        
        'If the attorney info is blank, then do not load info...
        If sAid.Text <> vbNullString And sAid.Text <> "NA" Then
            'Load Attorney Info
            .Open w_SQL2, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            sAfirstname.Text = !firstname
            sALastname.Text = !lastname
            If .State = 1 Then
                .Close
            End If
        End If
        
        'If the judge info is blank or 'NA', then do not load info...
        If sJid.Text <> vbNullString And sJid.Text <> "NA" Then
            'Load Judge Info
            .Open w_SQL3, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
            sJfirstname.Text = !firstname
            sJlastname.Text = !lastname
            If .State = 1 Then
                .Close
            End If
        End If
    End With
    
    Exit Sub

errHandler:
Dim errorMsg As Integer
    errorMsg = MsgBox("File Information Missing", vbExclamation, "Load Error")

End Sub

Function getDescription(SQL As String)
'Purpose: Return the description after executing the given SQL string
Dim w_Recordset As New Recordset
    
    On Error GoTo errHandler
    
    With w_Recordset
        'Execute the SQL Select statement
        .Open SQL, frmMDI.SQLConnect, adOpenForwardOnly, adLockReadOnly
        If Not .EOF Then
            'Return the description field
             getDescription = !Description
        End If
        If .State = 1 Then
            .Close
        End If
    End With
    Exit Function

errHandler:
Dim errorMsg As Integer
    errorMsg = MsgBox("getDescription Error", vbExclamation, "Description Error")

End Function

Function setDateCombos()
'Purpose: Add the month, day, and year items to the combos.
Dim counter As Integer
    
    'Initialize
    counter = 1
    
    'Load Months
    Do While counter <= 12
        If counter < 10 Then
            'Add a '0' to the beginning of the string
            cbOpenMonth.AddItem ("0" & CStr(counter))
            cbCloseMonth.AddItem ("0" & CStr(counter))
        Else
            cbOpenMonth.AddItem (CStr(counter))
            cbCloseMonth.AddItem (CStr(counter))
        End If
        
        counter = counter + 1
    Loop
    
    'Reset Counter
    counter = 1
    
    'Load Days
    Do While counter <= 31
        If counter < 10 Then
            cbOpenDay.AddItem ("0" & CStr(counter))
            cbCloseDay.AddItem ("0" & CStr(counter))
        Else
            cbOpenDay.AddItem (CStr(counter))
            cbCloseDay.AddItem (CStr(counter))
        End If
        
        counter = counter + 1
    Loop
    
    'Reset Counter
    counter = 1
    
    'Load Years
    'Load only years starting from current year to 20 years back
    Dim currYear As Integer
    currYear = Val(Format(Now, "yyyy"))
    
    Do While counter <= 90
        cbOpenYear.AddItem (CStr(currYear))
        cbCloseYear.AddItem (CStr(currYear))
        
        currYear = currYear - 1
        counter = counter + 1
    Loop

End Function

Private Function Load_Combo_Info()
Dim w_SQL As String
Dim w_Recordset As New Recordset

    'Clear the combo boxes
    cbCourts.Clear
    cbType.Clear
    cbStatus.Clear
    
    'Load Status info
    w_SQL = "select * from status ORDER BY statuscode ASC"
    addComboItems w_SQL, cbStatus
            
    'Load Type info
    w_SQL = "select * from types ORDER BY typecode ASC"
    addComboItems w_SQL, cbType
    
    'Load Court info
    w_SQL = "select * from courts ORDER BY courtcode ASC"
    addComboItems w_SQL, cbCourts
    
    
End Function

Function addComboItems(sqlSelect As String, ByRef comboName As ComboBox)
'Purpose: Populate the referenced combobox
Dim w_Recordset As New Recordset
    
    On Error GoTo errHandler

    With w_Recordset
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
    errorMsg = MsgBox("Combo Information Not Set", vbExclamation, "Combo Error")
    
End Function

Private Sub cbCourts_Change()
    caseChange = True
End Sub

Private Sub cbType_Change()
    caseChange = True
End Sub

Private Sub sAddInfo_Change()
    caseChange = True
End Sub

Private Sub sAfirstname_Change()
    caseChange = True
End Sub

Private Sub sAFullName_Change()
    caseChange = True
End Sub

Private Sub sAid_Change()
    caseChange = True
End Sub

Private Sub sAid2_Change()
    caseChange = True
End Sub

Private Sub sALastname_Change()
    caseChange = True
End Sub

Private Sub sAttendingSecretary_Change()
    caseChange = True
End Sub

Private Sub sCaseID_Change()
    caseChange = True
End Sub

Private Sub sCfirstname_Change()
    caseChange = True
End Sub

Private Sub sCFullName_Change()
    caseChange = True
End Sub

Private Sub sCid_Change()
    caseChange = True
End Sub

Private Sub sCid2_Change()
    caseChange = True
End Sub

Private Sub sClastname_Change()
    caseChange = True
End Sub

Private Sub sJfirstname_Change()
    caseChange = True
End Sub

Private Sub sJid_Change()
    caseChange = True
End Sub

Private Sub sJlastname_Change()
    caseChange = True
End Sub

Private Sub sProsecutor_Change()
    caseChange = True
End Sub
