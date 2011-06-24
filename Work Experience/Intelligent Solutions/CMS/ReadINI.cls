VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ReadIni"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Private Declare Function GetPrivateProfileStringA Lib "kernel32.dll" (ByVal mSection As String, ByVal w_Key As String, ByVal mDefault As String, ByVal mReturn As String, ByVal mSize As Integer, ByVal mFile As String) As Integer
Private Declare Function WritePrivateProfileStringA Lib "kernel32.dll" (ByVal mSection As String, ByVal w_Key As String, ByVal mValue As String, ByVal mFile As String) As Boolean
Private Declare Sub Des Lib "CMDES" (ByVal Data As String, ByVal Key As String, ByVal CiphData As String)
Private Declare Sub Undes Lib "CMDES" (ByVal CiphData As String, ByVal Key As String, ByVal Data As String)

Public Function WriteKey(ByVal wFile As String, ByVal wSection As String, ByVal wKey As String, ByVal wValue As String, ByVal wDes As Boolean) As Boolean

    Dim w_Key As String
    Dim w_Data As String
    Dim w_Cipher As String

    Dim w_value As String
    Dim w_KeyAux As String

    w_Key = Space(16)
    w_Data = Space(16)
    w_Cipher = Space(16)

    If wDes Then
        w_KeyAux = "ChaNgE"
        w_KeyAux = w_KeyAux & Left(wSection, 2)
        w_Key = w_KeyAux
        w_Data = wValue
        Des w_Data, w_Key, w_Cipher
        w_Data = Mid(wValue, 9)
        Des w_Data, w_Key, w_Cipher
    Else
        w_value = wValue
    End If

    WriteKey = WritePrivateProfileStringA(wSection, wKey, w_value, wFile)

End Function

Public Function GetKey(ByVal wFile As String, ByVal wSection As String, ByVal wKey As String, ByVal wDes As Boolean) As String

    Dim w_Key As String
    Dim w_Data As String
    Dim w_Cipher As String

    Dim w_i As Integer
    Dim w_Return As String
    Dim w_KeyAux As String
    Dim w_DataAux As String

    w_Key = Space(16)
    w_Data = Space(16)
    w_Cipher = Space(16)

    w_Return = Space(500)

    w_i = GetPrivateProfileStringA(wSection, wKey, "", w_Return, 500, wFile)

    w_Return = Left(w_Return, w_i)
    
    GetKey = w_Return
    
End Function

