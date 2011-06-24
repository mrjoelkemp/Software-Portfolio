VERSION 5.00
Begin VB.Form frmLogin2 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "CMS Login"
   ClientHeight    =   2430
   ClientLeft      =   2835
   ClientTop       =   3480
   ClientWidth     =   4875
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1435.724
   ScaleMode       =   0  'User
   ScaleWidth      =   4577.361
   ShowInTaskbar   =   0   'False
   Begin VB.TextBox sUserName 
      Height          =   345
      Left            =   1650
      TabIndex        =   1
      Top             =   855
      Width           =   2325
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   390
      Left            =   1080
      TabIndex        =   4
      Top             =   1800
      Width           =   1140
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   390
      Left            =   2700
      TabIndex        =   5
      Top             =   1800
      Width           =   1140
   End
   Begin VB.TextBox sPassword 
      Height          =   345
      IMEMode         =   3  'DISABLE
      Left            =   1650
      PasswordChar    =   "*"
      TabIndex        =   3
      Top             =   1245
      Width           =   2325
   End
   Begin VB.Label lblError 
      Caption         =   "Username Password Combination Incorrect"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   600
      TabIndex        =   7
      Top             =   480
      Visible         =   0   'False
      Width           =   3615
   End
   Begin VB.Label lblFunction 
      Caption         =   "Please Enter Your Username and Password"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   255
      Left            =   360
      TabIndex        =   6
      Top             =   120
      Width           =   4215
   End
   Begin VB.Label lblLabels 
      Caption         =   "&User Name:"
      Height          =   270
      Index           =   0
      Left            =   465
      TabIndex        =   0
      Top             =   870
      Width           =   1080
   End
   Begin VB.Label lblLabels 
      Caption         =   "&Password:"
      Height          =   270
      Index           =   1
      Left            =   465
      TabIndex        =   2
      Top             =   1260
      Width           =   1080
   End
End
Attribute VB_Name = "frmLogin2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Copyright ©1996-2006 VBnet, Randy Birch, All Rights Reserved.
' Some pages may also contain other copyrights by the author.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Distribution: You can freely use this code in your own
'               applications, but you may not reproduce
'               or publish this code on any web site,
'               online service, or distribute as source
'               on any media without express permission.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private serverName As String

Private Const SEC_E_OK = 0
Private Const HEAP_ZERO_MEMORY = &H8
Private Const SEC_WINNT_AUTH_IDENTITY_ANSI = &H1
Private Const SECBUFFER_TOKEN = &H2
Private Const SECURITY_NATIVE_DREP = &H10
Private Const SECPKG_CRED_INBOUND = &H1
Private Const SECPKG_CRED_OUTBOUND = &H2
Private Const SEC_I_CONTINUE_NEEDED = &H90312
Private Const SEC_I_COMPLETE_NEEDED = &H90313
Private Const SEC_I_COMPLETE_AND_CONTINUE = &H90314
Private Const VER_PLATFORM_WIN32_NT = &H2

Private Type SecPkgInfo
   fCapabilities As Long
   wVersion As Integer
   wRPCID As Integer
   cbMaxToken As Long
   Name As Long
   Comment As Long
End Type

Private Type SecHandle
    dwLower As Long
    dwUpper As Long
End Type

Private Type AUTH_SEQ
   fInitialized As Boolean
   fHaveCredHandle As Boolean
   fHaveCtxtHandle As Boolean
   hcred As SecHandle
   hctxt As SecHandle
End Type

Private Type SEC_WINNT_AUTH_IDENTITY
   User As String
   UserLength As Long
   Domain As String
   DomainLength As Long
   Password As String
   PasswordLength As Long
   Flags As Long
End Type

Private Type SEC_WINNT_AUTH_IDENTITYL
   User As Long
   UserLength As Long
   Domain As Long
   DomainLength As Long
   Password As Long
   PasswordLength As Long
   Flags As Long
End Type

Private Type TimeStamp
   LowPart As Long
   HighPart As Long
End Type

Private Type SecBuffer
   cbBuffer As Long
   BufferType As Long
   pvBuffer As Long
End Type

Private Type SecBufferDesc
   ulVersion As Long
   cBuffers As Long
   pBuffers As Long
End Type

Private Type OSVERSIONINFO
  OSVSize         As Long
  dwVerMajor      As Long
  dwVerMinor      As Long
  dwBuildNumber   As Long
  PlatformID      As Long
  szCSDVersion    As String * 128
End Type

Private Declare Sub CopyMemory Lib "kernel32" _
   Alias "RtlMoveMemory" _
  (Destination As Any, _
   Source As Any, _
   ByVal Length As Long)
   
Private Declare Function CompleteAuthToken Lib "secur32" _
  (ByRef phContext As SecHandle, _
   ByRef pToken As SecBufferDesc) As Long

Private Declare Function DeleteSecurityContext Lib "secur32" _
  (ByRef phContext As SecHandle) As Long

Private Declare Function FreeCredentialsHandle Lib "secur32" _
  (ByRef phContext As SecHandle) As Long
   
Private Declare Function FreeContextBuffer Lib "secur32" _
  (ByVal pvContextBuffer As Long) As Long

Private Declare Function GetProcessHeap Lib "kernel32" () As Long

Private Declare Function HeapAlloc Lib "kernel32" _
  (ByVal hHeap As Long, _
   ByVal dwFlags As Long, _
   ByVal dwBytes As Long) As Long

Private Declare Function HeapFree Lib "kernel32" _
  (ByVal hHeap As Long, _
   ByVal dwFlags As Long, _
   ByVal lpMem As Long) As Long

Private Declare Function GetVersionEx Lib "kernel32" _
   Alias "GetVersionExA" _
  (lpVersionInformation As OSVERSIONINFO) As Long
   
Private Declare Function QuerySecurityPackageInfo Lib "secur32" _
   Alias "QuerySecurityPackageInfoA" _
  (ByVal PackageName As String, _
   ByRef pPackageInfo As Long) As Long

Private Declare Function InitializeSecurityContext Lib "secur32" _
   Alias "InitializeSecurityContextA" _
  (phCredential As Any, _
   phContext As Any, _
   ByVal pszTargetName As Long, _
   ByVal fContextReq As Long, _
   ByVal Reserved1 As Long, _
   ByVal TargetDataRep As Long, _
   pInput As Any, _
   ByVal Reserved2 As Long, _
   phNewContext As SecHandle, _
   pOutput As SecBufferDesc, _
   pfContextAttr As Long, _
   ptsExpiry As TimeStamp) As Long

Private Declare Function AcquireCredentialsHandle Lib "secur32" _
   Alias "AcquireCredentialsHandleA" _
  (ByVal pszPrincipal As Long, _
   ByVal pszPackage As String, _
   ByVal fCredentialUse As Long, _
   ByVal pvLogonId As Long, _
   pAuthData As Any, _
   ByVal pGetKeyFn As Long, _
   ByVal pvGetKeyArgument As Long, _
   phCredential As SecHandle, _
   ptsExpiry As TimeStamp) As Long

Private Declare Function AcceptSecurityContext Lib "secur32" _
   (phCredential As SecHandle, _
   phContext As Any, _
   pInput As SecBufferDesc, _
   ByVal fContextReq As Long, _
   ByVal TargetDataRep As Long, _
   phNewContext As SecHandle, _
   pOutput As SecBufferDesc, _
   pfContextAttr As Long, _
   ptsExpiry As TimeStamp) As Long



Private Sub Form_Deactivate()
    Me.Hide
End Sub

Private Sub Form_Load()
   
    'Servername for Young is 'youngslawnt'
    serverName = "localhost"      'domain/workstation
    sUserName.Text = ""           'user name
    sPassword.Text = ""           'password
    
    'make error label invisible
    lblError.Visible = False

End Sub


Private Sub cmdOK_Click()
   
    If AuthenticateUser(serverName, sUserName.Text, sPassword.Text) = True Then
     'Grant access to system
     MsgBox "Authentication successful, Welcome to CMS", vbOKOnly, "Login Confirmation"
     Unload Me
    Else
        'Make error label Visible
        lblError.Visible = True
        
    End If
    
'   Label1.Caption = AuthenticateUser(Text1.Text, _
'                                     Text2.Text, _
'                                     Text3.Text)

End Sub


Private Sub sPassword_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      cmdOK.Value = True
   End If
   
End Sub


Private Function GetClientContext(AuthSeq As AUTH_SEQ, _
                                  AuthIdentity As SEC_WINNT_AUTH_IDENTITY, _
                                  ByVal pIn As Long, _
                                  ByVal cbIn As Long, _
                                  ByVal pOut As Long, _
                                  cbOut As Long, _
                                  fDone As Boolean) As Boolean

   Dim sbdOut        As SecBufferDesc
   Dim sbOut         As SecBuffer
   Dim sbdIn         As SecBufferDesc
   Dim sbIn          As SecBuffer
   Dim tsExpiry      As TimeStamp
   Dim fContextAttr  As Long
   Dim success       As Long
   
   If Not AuthSeq.fInitialized Then
      
      If AcquireCredentialsHandle(0&, _
                                  "NTLM", _
                                  SECPKG_CRED_OUTBOUND, _
                                   0&, _
                                  AuthIdentity, _
                                  0&, _
                                  0&, _
                                  AuthSeq.hcred, _
                                  tsExpiry) Then
               
        'failed to get credentials, so bail
         GetClientContext = False
         Exit Function
         
      Else
      
         AuthSeq.fHaveCredHandle = True
      
      End If  'If AcquireCredentialsHandle
   End If  'If Not AuthSeq.fInitialized

  'Prepare the output buffer
   With sbdOut
      .ulVersion = 0
      .cBuffers = 1
      .pBuffers = HeapAlloc(GetProcessHeap(), _
                            HEAP_ZERO_MEMORY, _
                            Len(sbOut))
   End With
   
   With sbOut
      .cbBuffer = cbOut
      .BufferType = SECBUFFER_TOKEN
      .pvBuffer = pOut
   End With
   
   CopyMemory ByVal sbdOut.pBuffers, sbOut, Len(sbOut)
   
  'attempt to establish a security context
  'between the server and a remote client.
   If AuthSeq.fInitialized Then
      
      With sbdIn
         .ulVersion = 0
         .cBuffers = 1
         .pBuffers = HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, _
            Len(sbIn))
      End With
   
      With sbIn
         .cbBuffer = cbIn
         .BufferType = SECBUFFER_TOKEN
         .pvBuffer = pIn
      End With
      
      CopyMemory ByVal sbdIn.pBuffers, sbIn, Len(sbIn)
   
      success = InitializeSecurityContext(AuthSeq.hcred, _
                                     AuthSeq.hctxt, _
                                     0&, _
                                      0, _
                                     0, _
                                     SECURITY_NATIVE_DREP, _
                                     sbdIn, _
                                     0, _
                                     AuthSeq.hctxt, _
                                     sbdOut, _
                                     fContextAttr, _
                                     tsExpiry)
               
               
   Else
      
         success = InitializeSecurityContext(AuthSeq.hcred, _
                                         ByVal 0&, _
                                         0&, _
                                         0, _
                                         0, _
                                         SECURITY_NATIVE_DREP, _
                                         0&, _
                                         0, _
                                         AuthSeq.hctxt, _
                                         sbdOut, _
                                         fContextAttr, _
                                         tsExpiry)
   End If  'If AuthSeq.fInitialized

   If success >= SEC_E_OK Then
   
     'the security context received from
     'the client was accepted. If an output
     'token was generated by the function,
     'it must be sent to the client process.
      AuthSeq.fHaveCtxtHandle = True

     'if a protocol (such as DCE) needs to
     'revise the security information after
     'the transport application has updated
     'some message parameters, pass it to
     'CompleteAuthToken
      If success = SEC_I_COMPLETE_NEEDED Or _
         success = SEC_I_COMPLETE_AND_CONTINUE Then
   
         If CompleteAuthToken(AuthSeq.hctxt, sbdOut) < SEC_E_OK Then
         
           'couldn't complete, so return false
            FreeMemory sbdOut.pBuffers
            FreeMemory sbdIn.pBuffers
            GetClientContext = False
            Exit Function
            
         End If  ' If CompleteAuthToken
                  
      End If  'If success

      CopyMemory sbOut, ByVal sbdOut.pBuffers, Len(sbOut)
      cbOut = sbOut.cbBuffer

      AuthSeq.fInitialized = True

      fDone = Not (success = SEC_I_CONTINUE_NEEDED Or _
                   success = SEC_I_COMPLETE_AND_CONTINUE)

      GetClientContext = True

   End If  'If success >= SEC_E_OK

   FreeMemory sbdOut.pBuffers
   FreeMemory sbdIn.pBuffers

End Function


Private Function GetServerContext(AuthSeq As AUTH_SEQ, _
                                  ByVal pIn As Long, _
                                  ByVal cbIn As Long, _
                                  ByVal pOut As Long, _
                                  cbOut As Long, _
                                  fDone As Boolean) As Boolean

   Dim sbdOut        As SecBufferDesc
   Dim sbOut         As SecBuffer
   Dim sbdIn         As SecBufferDesc
   Dim sbIn          As SecBuffer
   Dim tsExpiry      As TimeStamp
   Dim fContextAttr  As Long
   Dim success       As Long
   
   If Not AuthSeq.fInitialized Then
      
      If AcquireCredentialsHandle(0&, _
                                  "NTLM", _
                                  SECPKG_CRED_INBOUND, _
                                  0&, _
                                  ByVal 0&, _
                                  0&, _
                                  0&, _
                                  AuthSeq.hcred, _
                                  tsExpiry) Then
               
        'failed to get credentials, so bail
         GetServerContext = False
         Exit Function
         
      Else:
      
         AuthSeq.fHaveCredHandle = True
      
      End If  'If AcquireCredentialsHandle
   
   End If  'If Not AuthSeq.fInitialized


  'Prepare the output and input buffers
   With sbdOut
      .ulVersion = 0
      .cBuffers = 1
      .pBuffers = HeapAlloc(GetProcessHeap(), _
                            HEAP_ZERO_MEMORY, _
                            Len(sbOut))
   End With
   
   With sbOut
      .cbBuffer = cbOut
      .BufferType = SECBUFFER_TOKEN
      .pvBuffer = pOut
   End With
   
   With sbdIn
      .ulVersion = 0
      .cBuffers = 1
      .pBuffers = HeapAlloc(GetProcessHeap(), _
                            HEAP_ZERO_MEMORY, _
                            Len(sbIn))
   End With
   
   With sbIn
      .cbBuffer = cbIn
      .BufferType = SECBUFFER_TOKEN
      .pvBuffer = pIn
   End With
      
   CopyMemory ByVal sbdOut.pBuffers, sbOut, Len(sbOut)
   CopyMemory ByVal sbdIn.pBuffers, sbIn, Len(sbIn)
   
  'attempt to establish a security context
   If AuthSeq.fInitialized Then
  
   
      success = AcceptSecurityContext(AuthSeq.hcred, _
                                      AuthSeq.hctxt, _
                                      sbdIn, _
                                      0, _
                                      SECURITY_NATIVE_DREP, _
                                      AuthSeq.hctxt, _
                                      sbdOut, _
                                      fContextAttr, _
                                      tsExpiry)
   Else
      
      success = AcceptSecurityContext(AuthSeq.hcred, _
                                      ByVal 0&, _
                                      sbdIn, _
                                      0, _
                                      SECURITY_NATIVE_DREP, _
                                      AuthSeq.hctxt, _
                                      sbdOut, _
                                      fContextAttr, _
                                      tsExpiry)

   End If  'If AuthSeq.fInitialized

   If success >= SEC_E_OK Then
   
     'the security context received from
     'the client was accepted. If an output
     'token was generated by the function,
     'it must be sent to the client process.
      AuthSeq.fHaveCtxtHandle = True

     'if a protocol (such as DCE) needs to
     'revise the security information after
     'the transport application has updated
     'some message parameters, pass it to
     'CompleteAuthToken
      If success = SEC_I_COMPLETE_NEEDED Or _
         success = SEC_I_COMPLETE_AND_CONTINUE Then
   
         If CompleteAuthToken(AuthSeq.hctxt, sbdOut) < SEC_E_OK Then
         
           'couldn't complete, so return false
            FreeMemory sbdOut.pBuffers
            FreeMemory sbdIn.pBuffers
            GetServerContext = False
            Exit Function
            
         End If  ' If CompleteAuthToken
                  
      End If  'If success

      CopyMemory sbOut, ByVal sbdOut.pBuffers, Len(sbOut)
      cbOut = sbOut.cbBuffer

      AuthSeq.fInitialized = True

      fDone = Not (success = SEC_I_CONTINUE_NEEDED Or _
                   success = SEC_I_COMPLETE_AND_CONTINUE)

      GetServerContext = True

   End If  'If success >= SEC_E_OK

   FreeMemory sbdOut.pBuffers
   FreeMemory sbdIn.pBuffers

End Function


Private Function AuthenticateUser(ByVal sDomain As String, _
                                  ByVal sUser As String, _
                                  ByVal sPassword As String) As Boolean

   Dim osinfo        As OSVERSIONINFO
   Dim authClient    As AUTH_SEQ
   Dim authServer    As AUTH_SEQ
   Dim swai          As SEC_WINNT_AUTH_IDENTITY
   Dim spi           As SecPkgInfo
   Dim ptrSpi        As Long
   Dim cbMaxToken    As Long
   Dim pClientBuf    As Long
   Dim pServerBuf    As Long
   Dim cbIn          As Long
   Dim cbOut         As Long
   Dim fDone         As Boolean


  'Determine if user's OS version
  'is Windows NT 5.0 or later
   If IsWinNT2000Plus() Then
   
     'Get max token size by passing to
     'QuerySecurityPackageInfo the name
     'of the security package to obtain
     'a pointer to a SECPKGINFO structure
     'containing security package information.
     '"NTLM" refers to "NT LAN Manager"
     'authentication, referred to as an
     '"NT Challenge"
      If QuerySecurityPackageInfo("NTLM", ptrSpi) = SEC_E_OK Then
      
         CopyMemory spi, ByVal ptrSpi, Len(spi)
         cbMaxToken = spi.cbMaxToken
         FreeContextBuffer ptrSpi
      
        'Allocate buffers for client
        'and server messages
         pClientBuf = HeapAlloc(GetProcessHeap(), _
                                HEAP_ZERO_MEMORY, _
                                cbMaxToken)
   
         If pClientBuf <> 0 Then

            pServerBuf = HeapAlloc(GetProcessHeap(), _
                                   HEAP_ZERO_MEMORY, _
                                   cbMaxToken)
         
            If pServerBuf <> 0 Then
       
              'Initialize authentication
              'identity structure
               With swai
                  .Domain = sDomain
                  .DomainLength = Len(sDomain)
                  .User = sUser
                  .UserLength = Len(sUser)
                  .Password = sPassword
                  .PasswordLength = Len(sPassword)
                  
                  'credentials passed are in ANSI
                  .Flags = SEC_WINNT_AUTH_IDENTITY_ANSI
               End With
         
              'Prepare the client message (negotiate)
               cbOut = cbMaxToken
               If GetClientContext(authClient, _
                                   swai, _
                                   0, _
                                   0, _
                                   pClientBuf, _
                                   cbOut, _
                                   fDone) Then
              
                 'Prepare the server message (challenge).
                 'Most likely failure: AcceptServerContext
                 'fails with SEC_E_LOGON_DENIED in the case
                 'of bad szUser or szPassword.
                 '
                 'Note that there can be an unexpected result:
                 'Validation will succeed if you
                 'pass in a bad username to the call
                 'when the guest account is enabled
                 'in the specified domain.
                  cbIn = cbOut
                  cbOut = cbMaxToken
                  
                  If GetServerContext(authServer, _
                                      pClientBuf, _
                                      cbIn, _
                                      pServerBuf, _
                                      cbOut, _
                                      fDone) Then
      
                    'Prepare client message (authenticate)
                     cbIn = cbOut
                     cbOut = cbMaxToken
                     
                     If GetClientContext(authClient, _
                                         swai, _
                                         pServerBuf, _
                                         cbIn, _
                                         pClientBuf, _
                                         cbOut, _
                                         fDone) Then
      
                       'Prepare server message (authenticate)
                        cbIn = cbOut
                        cbOut = cbMaxToken
                        If GetServerContext(authServer, _
                                            pClientBuf, _
                                            cbIn, _
                                            pServerBuf, _
                                            cbOut, _
                                            fDone) Then
         
                           AuthenticateUser = True

                        End If 'If GetServerContext(authServer
                     End If  'If GetClientContext(authClient
                  End If  'If GetServerContext(authServer
               End If  'If GetClientContext(authClient
            End If  'If pServerBuf <> 0
         End If  ' If pClientBuf <> 0
      End If  'If QuerySecurityPackageInfo <> 0

     'Clean up resources
      If authClient.fHaveCtxtHandle Then DeleteSecurityContext authClient.hctxt
      If authServer.fHaveCtxtHandle Then DeleteSecurityContext authServer.hctxt
      If authClient.fHaveCredHandle Then FreeCredentialsHandle authClient.hcred
      If authServer.fHaveCtxtHandle Then FreeCredentialsHandle authServer.hcred
      FreeMemory pClientBuf
      FreeMemory pServerBuf
      
   End If

End Function


Private Function IsWinNT2000Plus() As Boolean

  'returns True if running Win2000 or WinXP
   #If Win32 Then
  
      Dim OSV As OSVERSIONINFO
   
      OSV.OSVSize = Len(OSV)
   
      If GetVersionEx(OSV) = 1 Then
   
        'PlatformId contains a value representing the OS.
         IsWinNT2000Plus = (OSV.PlatformID = VER_PLATFORM_WIN32_NT) And _
                           (OSV.dwVerMajor >= 5)
      End If

   #End If

End Function


Private Sub FreeMemory(memblock As Long)

   If memblock <> 0 Then HeapFree GetProcessHeap(), 0, memblock
   
End Sub



