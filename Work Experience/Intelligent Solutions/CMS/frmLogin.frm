VERSION 5.00
Begin VB.Form frmLogin 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "CMS Login"
   ClientHeight    =   1545
   ClientLeft      =   2835
   ClientTop       =   3480
   ClientWidth     =   3750
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   912.837
   ScaleMode       =   0  'User
   ScaleWidth      =   3521.047
   ShowInTaskbar   =   0   'False
   Begin VB.TextBox txtUserName 
      Height          =   345
      Left            =   1290
      TabIndex        =   1
      Top             =   135
      Width           =   2325
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   390
      Left            =   495
      TabIndex        =   4
      Top             =   1020
      Width           =   1140
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   390
      Left            =   2100
      TabIndex        =   5
      Top             =   1020
      Width           =   1140
   End
   Begin VB.TextBox txtPassword 
      Height          =   345
      IMEMode         =   3  'DISABLE
      Left            =   1290
      PasswordChar    =   "*"
      TabIndex        =   3
      Top             =   525
      Width           =   2325
   End
   Begin VB.Label lblLabels 
      Caption         =   "&User Name:"
      Height          =   270
      Index           =   0
      Left            =   105
      TabIndex        =   0
      Top             =   150
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "&Password:"
      Height          =   270
      Index           =   1
      Left            =   105
      TabIndex        =   2
      Top             =   540
      Width           =   1080
   End
End
Attribute VB_Name = "frmLogin"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private username As String
Private Password As String
''''''''''''''''''''''''''''''''''''''''

Public LoginSucceeded As Boolean
Public serverName As String


Private Type USER_INFO
    Name As String
    Comment As String
    UserComment As String
    FullName As String
    Password As String 'Added by me
End Type

Private Type USER_INFO_API
    Name As Long
    Comment As Long
    UserComment As Long
    FullName As Long
    Password As Long 'added by me
End Type


Private Declare Function NetUserEnum Lib "netapi32" _
  (lpServer As Any, ByVal Level As Long, _
   ByVal Filter As Long, lpBuffer As Long, _
   ByVal PrefMaxLen As Long, EntriesRead As Long, _
   TotalEntries As Long, ResumeHandle As Long) As Long
   
Private Declare Function NetApiBufferFree Lib "netapi32" _
   (ByVal pBuffer As Long) As Long

Private Declare Sub CopyMem Lib "kernel32" Alias _
   "RtlMoveMemory" (pTo As Any, uFrom As Any, _
    ByVal lSize As Long)
    
Private Declare Function lstrlenW Lib "kernel32" _
 (ByVal lpString As Long) As Long

Private Const NERR_Success As Long = 0&
Private Const ERROR_MORE_DATA As Long = 234&

Private Const FILTER_TEMP_DUPLICATE_ACCOUNT As Long = &H1&
Private Const FILTER_NORMAL_ACCOUNT As Long = &H2&
Private Const FILTER_PROXY_ACCOUNT As Long = &H4&
Private Const FILTER_INTERDOMAIN_TRUST_ACCOUNT As Long = &H8&
Private Const FILTER_WORKSTATION_TRUST_ACCOUNT As Long = &H10&
Private Const FILTER_SERVER_TRUST_ACCOUNT As Long = &H20&

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


Private Sub cmdCancel_Click()
    'set the global var to false
    'to denote a failed login
    LoginSucceeded = False
    Me.Hide
End Sub

Private Sub cmdOK_Click()
    'check for correct password
    If txtPassword = "password" Then
        'place code to here to pass the
        'success to the calling sub
        'setting a global var is the easiest
        LoginSucceeded = True
        Me.Hide
    Else
        MsgBox "Invalid Password, try again!", , "Login"
        txtPassword.SetFocus
        SendKeys "{Home}+{End}"
    End If
End Sub

Public Function GetUsers(usernames() As String, _
   Optional serverName As String = "") As Boolean
    
    'PURPOSE: Get LoginNames of all users on the domain and
    'save in a string array
    
    'PARAMETERS: UserNames(): Empty String array, passed byref,
      'to hold user names
    
    'ServerName (Optional): Set to "" if you want user
      'names for current machine, otherwise, set to the server
      'you want (e.g., Domain Controller Name)
    
    'RETURNS: True if successful, false otherwise
    
    'EXAMPLE:
        'Dim sUsers() As String
        'dim lCtr as long
        'GetUsers sUsers, "MyDomainController"
        
        'OR FOR LOCAL MACHINE
        
        'GetUsers sUsers
   
    'For lCtr = LBound(sUsers) To UBound(sUsers)
     '   Debug.Print sUsers(lCtr)
    'Next
    
     'NOTES: WINDOWS NT/2000 only
     Dim lptrStrBuffer As Long
    Dim lRet As Long
    Dim lUsersRead As Long
    Dim lTotalUsers As Long
    Dim lHnd As Long
    Dim etUserInfo As USER_INFO_API
    Dim bytServerName() As Byte
    Dim lElement As Long
    Dim Users() As USER_INFO 'This function
    'is designed to return a string of username
    'but optionally, you can change it to
    'get this array of the UDT, which
    'will provide more information
    'about each user
    Dim i As Long
    
    ReDim Users(0) As USER_INFO
    ReDim usernames(0) As String
    
    If Trim(serverName) = "" Then
        'Local users
        bytServerName = vbNullString
    Else
        'Check the syntax of the ServerName string
        If InStr(serverName, "\\") = 1 Then
            bytServerName = serverName & vbNullChar
        Else
            bytServerName = "\\" & serverName & vbNullChar
        End If
    End If
    lHnd = 0

 Do
         'Begin enumerating users
         If Trim(serverName) = "" Then
             lRet = NetUserEnum(vbNullString, 10, _
              FILTER_NORMAL_ACCOUNT, lptrStrBuffer, 1, _
               lUsersRead, lTotalUsers, lHnd)
         Else
             lRet = NetUserEnum(bytServerName(0), 10, _
              FILTER_NORMAL_ACCOUNT, lptrStrBuffer, 1, _
                lUsersRead, lTotalUsers, lHnd)
         End If

         'Populate UserInfo Structure
         'If lRet = ERROR_MORE_DATA Then

         '  If lUsersRead  1 that why th for construct

         For i = 0 To lUsersRead - 1
           CopyMem etUserInfo, ByVal lptrStrBuffer + Len(etUserInfo) * i, _
 Len(etUserInfo)
           If Users(0).Name = "" Then
               lElement = 0
           Else
               lElement = UBound(Users) + 1
           End If
           'ReDim Preserve UserNames(lElement)
           ReDim Preserve Users(lElement) As USER_INFO

           'data of interest
           Users(lElement).Name = PtrToString(etUserInfo.Name)

 'If lRet = ERROR_MORE_DATA Then --  i removed because i lost the last
'entry while the result is NERR_Success

           'Other stuff you can get, but not
           'returned by this function
           'modify this function if you are interested

           Users(lElement).Comment = PtrToString(etUserInfo.Comment)
           Users(lElement).UserComment = PtrToString(etUserInfo.UserComment)
           Users(lElement).FullName = PtrToString(etUserInfo.FullName)
'           Users(lElement).Password = PtrToString(etUserInfo.Password)
            ReDim Preserve usernames(lElement)
           usernames(lElement) = Users(lElement).Name
         Next

         If lptrStrBuffer Then
             Call NetApiBufferFree(lptrStrBuffer)
         End If
         
         DoEvents
         
         If lRet = NERR_Success Then Exit Do
        Loop While lRet = ERROR_MORE_DATA
     
 GetUsers = True
    Exit Function

errHandler:

On Error Resume Next
Call NetApiBufferFree(lptrStrBuffer)

End Function

Public Function GetUsersInfo(userInfo() As String, Optional serverName As String = "") As String
'Purpose: Get LoginNames of all users on the domain and save in a string array
'Parameters:    infoType - can be either 'NAME' or 'PASSWORD'. Used to determine which information is being requested.
'               userInfo() - holds the requested information for all users in the domain
'               ServerName (Optional) - Set to "" if you want user information for current machine, otherwise, set to the server you want (e.g., Domain Controller Name)

'Sample Call:
        'Dim sUsers() As String
        'dim lCtr as long
        'GetUsers sUsers, "MyDomainController"
        
        'OR FOR LOCAL MACHINE
        
        'GetUsers sUsers
   
    'For lCtr = LBound(sUsers) To UBound(sUsers)
     '   Debug.Print sUsers(lCtr)
    'Next
    
Dim lptrStrBuffer As Long
Dim lRet As Long
Dim lUsersRead As Long
Dim lTotalUsers As Long
Dim lHnd As Long
Dim etUserInfo As USER_INFO_API
Dim bytServerName() As Byte
Dim lElement As Long
Dim Users() As USER_INFO
Dim i As Long

ReDim Users(0) As USER_INFO
'Make the referenced array double-scripted
ReDim userInfo(0, 0) As String
    
    If Trim(serverName) = "" Then
        'Local users
        bytServerName = vbNullString
    Else
        'Check the syntax of the ServerName string
        If InStr(serverName, "\\") = 1 Then
            bytServerName = serverName & vbNullChar
        Else
            bytServerName = "\\" & serverName & vbNullChar
        End If
    End If
    lHnd = 0

 Do
         'Begin enumerating users
         If Trim(serverName) = "" Then
             lRet = NetUserEnum(vbNullString, 10, _
              FILTER_NORMAL_ACCOUNT, lptrStrBuffer, 1, _
               lUsersRead, lTotalUsers, lHnd)
         Else
             lRet = NetUserEnum(bytServerName(0), 10, _
              FILTER_NORMAL_ACCOUNT, lptrStrBuffer, 1, _
                lUsersRead, lTotalUsers, lHnd)
         End If

         'Populate UserInfo Structure

         For i = 0 To lUsersRead - 1
         
           CopyMem etUserInfo, ByVal lptrStrBuffer + Len(etUserInfo) * i, Len(etUserInfo)
           
           If Users(0).Name = "" Then
               lElement = 0
           
           Else
               lElement = UBound(Users) + 1
           
           End If
           
            ReDim Preserve userInfo(lElement, lElement)
            ReDim Preserve Users(lElement) As USER_INFO

            'Get the list of usernames
            Users(lElement).Name = PtrToString(etUserInfo.Name)
            'Get the list of passwords
            Users(lElement).Password = PtrToString(etUserInfo.Password)

            'Store the usernames in the first column of 2d array
            userInfo(lElement, 0) = Users(lElement).Name
            'Store the user's passwords in the second column of the 2d array
            userInfo(lElement, 1) = Users(lElement).Password
            
         Next

         If lptrStrBuffer Then
             Call NetApiBufferFree(lptrStrBuffer)
         End If
         
         DoEvents
         
         If lRet = NERR_Success Then Exit Do
        Loop While lRet = ERROR_MORE_DATA
      
    Exit Function

errHandler:

On Error Resume Next
Call NetApiBufferFree(lptrStrBuffer)

End Function

Private Function PtrToString(lpString As Long) As String
    'Convert a windows pointer to a VB string
    Dim bytBuffer() As Byte
    Dim lLen As Long
    
    If lpString Then
        lLen = lstrlenW(lpString) * 2
        If lLen Then
            ReDim bytBuffer(0 To (lLen - 1)) As Byte
            CopyMem bytBuffer(0), ByVal lpString, lLen
            PtrToString = bytBuffer
        End If
    End If
End Function
    
Private Sub Form_Deactivate()
    Me.Hide
End Sub

Private Sub Form_Load()
Dim conn As New ADODB.Connection
Dim cmd As New ADODB.Command

    serverName = "youngslawnt" 'Provided by Young's Law Firm
    
    username = txtUserName.Text
    Password = txtPassword.Text

    conn.Provider = "ADsDSObject"
    conn.Open "Active Directory Provider", username, Password   ' --> username and password are declared globally


'Dim userInfo() As String
'Dim strLength As Integer
'Dim counter As Integer

    'Populate array with AD username and user password information
 '   GetUsersInfo userInfo()
    
 '   On Error Resume Next
    
 '   Do While userInfo(counter, 0) <> vbNullString
 '       Debug.Print "Name: " & userInfo(counter, 0)
 '       Debug.Print "Password: " & userInfo(counter, 1)
            
 '       counter = counter + 1
 '   Loop
    
'    For counter = 0 To 10 Step 1
'        Debug.Print "Name: " & userInfo(counter)
'        Debug.Print "Password: " & userInfoPWD(counter)
        
'        If Err.Number = 9 Then
'          Debug.Print ""
'        End If
'    Next counter
    
        
End Sub
