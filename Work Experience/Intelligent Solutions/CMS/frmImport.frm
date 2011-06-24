VERSION 5.00
Begin VB.Form frmImport 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Import Clients"
   ClientHeight    =   4395
   ClientLeft      =   2760
   ClientTop       =   3750
   ClientWidth     =   7080
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   4395
   ScaleWidth      =   7080
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   5760
      TabIndex        =   6
      Top             =   3240
      Width           =   1215
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   5760
      TabIndex        =   5
      Top             =   3720
      Width           =   1215
   End
   Begin VB.DriveListBox cbDrive 
      Height          =   315
      Left            =   240
      TabIndex        =   4
      Top             =   1200
      Width           =   2415
   End
   Begin VB.DirListBox listDir 
      Height          =   2565
      Left            =   240
      TabIndex        =   3
      Top             =   1560
      Width           =   2775
   End
   Begin VB.FileListBox listFiles 
      Height          =   2625
      Left            =   3120
      Pattern         =   "*.csv*"
      TabIndex        =   2
      Top             =   1560
      Width           =   2535
   End
   Begin VB.Frame Frame6 
      Height          =   975
      Left            =   600
      TabIndex        =   0
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
         TabIndex        =   1
         Top             =   240
         Width           =   4035
      End
   End
End
Attribute VB_Name = "frmImport"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdOK_Click()
'Purpose: Upon click, import the clients from the selected Quickbooks Company File.
    importClients
    
End Sub
Function getQBXmlRequest() As String
'Purpose: Generate qbXML Request and return it
'Note: To use this code, you must have references to MSXML v4.0

' This function creates a block of XML which looks basically like this:
   
    '<?xml version="1.0" ?>
    ' <!DOCTYPE QBXML PUBLIC '-//INTUIT//DTD QBXML QBD 1.0//EN' >
    ' <QBXML>
    '    <QBXMLMsgsRq onError="continueOnError">
    '       <CustomerQueryRq requestID="2" />
    '    </QBXMLMsgsRq>
    ' </QBXML>
    
    ' create a new MSXML object
    Dim doc As New MSXML2.DOMDocument
    Set doc = CreateObject("MSXML2.DOMDocument")
   
    ' <QBXML> .... </QBXML>
    Dim rootElement As IXMLDOMNode
    Set rootElement = doc.createElement("QBXML")
    doc.appendChild rootElement
   
    ' <QBXMLMsgsRq onError="continueOnError"> .... </QBXMLMsgsRq>
    Dim MsgsRqNode As IXMLDOMNode
    Set MsgsRqNode = doc.createElement("QBXMLMsgsRq")
    rootElement.appendChild MsgsRqNode
   
    Dim onErrorAttr As IXMLDOMAttribute
    Set onErrorAttr = doc.createAttribute("onError")
    onErrorAttr.Text = "continueOnError"
    MsgsRqNode.Attributes.setNamedItem onErrorAttr
   
    ' <CustomerQueryRq requestID="1" > .... </CustomerQueryRq>
    Dim CQRNode As IXMLDOMNode
    Set CQRNode = doc.createElement("CustomerQueryRq")
    MsgsRqNode.appendChild CQRNode
   
    Dim requestIDAttr As IXMLDOMAttribute
    Set requestIDAttr = doc.createAttribute("requestID")
    requestIDAttr.Text = "2"
    CQRNode.Attributes.setNamedItem requestIDAttr
       
    ' Add typical header lines to the beginning of the string  of
    '  xml now stored in doc.xml.
    ' <?xml version="1.0" ?>
    ' <!DOCTYPE QBXML PUBLIC '-//INTUIT//DTD QBXML QBD 1.0//EN' >
    Dim xmlRequest As String
    xmlRequest = "<?xml version=""1.0"" ?>"
    xmlRequest = xmlRequest & "<!DOCTYPE QBXML PUBLIC '- //INTUIT//DTD QBXML QBD 1.0//EN' >"
    xmlRequest = xmlRequest & doc.xml
    getQBXmlRequest = xmlRequest

End Function

Public Function processQBXmlResponse(theXML As String)
'Purpose: This function parses a VendorQueryRs we have been handed back by
    ' QuickBooks.  It goes through a list of vendors, and for each pulls
    ' out the company name, postal code, and contact.  It returns a
    ' report of these companies, postal codes, and contacts in a string.
   
    ' Here is an example of what the qbXML sent to this function might
    ' look like.  This particular example contains two vendors.
   
    ' <?xml version="1.0" ?>
    ' <QBXML>
    '   <QBXMLMsgsRs>
    '      <VendorQueryRs requestID="1" statusCode="0" statusSeverity="Info" statusMessage="Status OK">
    '         <VendorRet>
    '            <ListID>2818048</ListID>
    '            <TimeCreated>1999-07-29T14:24:18-0400</TimeCreated>
    '            <TimeModified>2003-12-15T16:13:01-0500</TimeModified>
    '            <EditSequence>1071522781</EditSequence>
    '            <Name>Bayshore CalOil Service</Name>
    '            <IsActive>true</IsActive>
    '            <CompanyName>Bayshore CalOil Service</CompanyName>
    '            <VendorAddress>
    '               <Addr1>Bayshore CalOil Service</Addr1>
    '               <Addr2>771 S. Lerimore</Addr2>
    '               <City>Bayshore</City>
    '               <State>CA</State>
    '               <PostalCode>98323</PostalCode>
    '            </VendorAddress>
    '            <Phone>415-555-7378</Phone>
    '            <Contact>Kurt Rutherford</Contact>
    '            <NameOnCheck>Bayshore CalOil Service</NameOnCheck>
    '            <IsVendorEligibleFor1099>false</IsVendorEligibleFor1099>
    '            <Balance>0.00</Balance>
    '         </VendorRet>
    '         <VendorRet>
    '            <ListID>196608</ListID>
    '            <TimeCreated>1999-07-29T14:24:16-0400</TimeCreated>
    '            <TimeModified>2003-12-15T18:03:16-0500</TimeModified>
    '            <EditSequence>1071529396</EditSequence>
    '            <Name>C.U. Electric</Name>
    '            <IsActive>true</IsActive>
    '            <CompanyName>C. U. Electric</CompanyName>
    '            <FirstName>Carrick</FirstName>
    '            <LastName>Underdown</LastName>
    '            <VendorAddress>
    '               <Addr1>C. U. Electric</Addr1>
    '               <Addr2>P.O. Box 2816</Addr2>
    '               <City>Bayshore</City>
    '               <State>CA</State>
    '               <PostalCode>94326</PostalCode>
    '            </VendorAddress>
    '            <Phone>415-555-0797</Phone>
    '            <Fax>415-555-7283</Fax>
    '            <Email>cu-service@samplename.com</Email>
    '            <Contact>Carrick Underdown</Contact>
    '            <NameOnCheck>C. U. Electric</NameOnCheck>
    '            <VendorTypeRef>
    '               <ListID>262144</ListID>
    '               <FullName>Subcontractors</FullName>
    '            </VendorTypeRef>
    '            <TermsRef>
    '               <ListID>65536</ListID>
    '               <FullName>Net 30</FullName>
    '            </TermsRef>
    '            <IsVendorEligibleFor1099>false</IsVendorEligibleFor1099>
    '            <Balance>-750.00</Balance>
    '         </VendorRet>
    '      </VendorQueryRs>
    '   </QBXMLMsgsRs>
    ' </QBXML>
   
    ' create a new MSXML object
    Dim doc As New MSXML2.DOMDocument
    Set doc = CreateObject("MSXML2.DOMDocument")

    doc.async = False
    doc.loadXML (theXML) ' put input string of XML into an MSXML object

    ' nodeList will hold all elements named CustomerQueryRs,
    ' just 1 in this case
    Dim nodeList As IXMLDOMNodeList
    Set nodeList = doc.getElementsByTagName("CustomerQueryRs")
   
    ' cusQRsNode will grab the CustomerQueryRs element we need from
    ' the array of 1 element
    Dim cusQRsNode As IXMLDOMNode
    Set cusQRsNode = nodeList.Item(0)
    
    ' CustomerQueryRs has four attributes:
    ' requestID, statusCode, statusSeverity, statusMessage
    Dim cusQRsAttr As IXMLDOMNamedNodeMap
    Set cusQRsAttr = cusQRsNode.Attributes
   
    ' we only want the statusCode attribute
    Dim cusQRsAttrNode As IXMLDOMNode
    Dim statusCode ' will hold the value of the statusCode attribute
    If cusQRsAttr.Length > 0 Then
        Set cusQRsAttrNode = cusQRsAttr.getNamedItem("statusCode")
        statusCode = cusQRsAttrNode.nodeValue
    End If
       
       
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    
    ' A statusCode of 0 indicates that there is no error.  We only want to
    ' continue on if there is no error in the CustomerQueryRs
    If statusCode = 0 Then
       
        ' customerList will contain an array of nodes named VendorRet.  There
        ' could be any number of these, depending on how many items are
        ' listed.  In our example qbXML shown above, there are two.
        Dim customerList As IXMLDOMNodeList
        Set customerList = doc.getElementsByTagName("CustomerRet")
        
        Dim numCustomers As Integer
        numCustomers = customerList.Length

        Dim names()     'customer names
        Dim add1()      'address 1
        Dim add2()      'address 2
        Dim add3()      'address 3
        Dim phones()    'phone numbers
        Dim altPhones() 'alt phone numbers
        Dim emails()    'emails
        Dim balances()  'account balances
        
       
        ' Have to ReDim these in order to assign the size of these
        ' arrays dynamically, depending on the number of vendors.
        ReDim names(numCustomers)     'customer names
        ReDim add1(numCustomers)      'address 1
        ReDim add2(numCustomers)      'address 2
        ReDim add3(numCustomers)      'address 3
        ReDim phones(numCustomers)    'phone numbers
        ReDim altPhones(numCustomers) 'alt phone numbers
        ReDim emails(numCustomers)    'emails
        ReDim balances(numCustomers)  'account balances
        
        ' outputString will hold a report of all of the company names, postal
        ' codes, and contacts, and will be returned by this function
        Dim outputString
        outputString = "Customer Report:"
       
        ' Iterate through customers, picking out the info we want
        Dim i As Integer
        For i = 0 To numCustomers - 1
            Dim customerNode As IXMLDOMNode
            Set customerNode = customerList.Item(i)
           
            ' get customer name info
            Dim nameElement As IXMLDOMElement
            Set nameElement = customerNode.selectSingleNode("Name")
            names(i) = nameElement.Text
           
            ' Note that the address elements are nested in the BillAddress
            ' element so we need the correct syntax for pulling them out.
            Dim addElement As IXMLDOMElement
            Set addElement = customerNode.selectSingleNode("BillAddress//Addr1")
            add1(i) = addElement.Text
            
            'Get address 2
            Set addElement = customerNode.selectSingleNode("BillAddress//Addr2")
            add2(i) = addElement.Text
            
            'Get address 3
            Set addElement = customerNode.selectSingleNode("BillAddress//Addr3")
            add3(i) = addElement.Text
            
            ' get Phone info
            Dim phoneElement As IXMLDOMElement
            Set phoneElement = customerNode.selectSingleNode("Phone")
            phones(i) = phoneElement.Text
            
            'Get Alternate Phone info
            Set phoneElement = customerNode.selectSingleNode("AltPhone")
            altPhones(i) = phoneElement.Text
        
            'Get Email Info
            Dim emailElement As IXMLDOMElement
            Set emailElement = customerNode.selectSingleNode("Email")
            
            'Get Balance Info
            Dim balanceElement As IXMLDOMElement
            Set balanceElement = customerNode.selectSingleNode("Balance")
            
            'Store the customer info in the CMS DB as a client....
            
            
            ' Add the new information to the string of output
'            outputString = outputString & vbCrLf & companies(i) & ", postal code=" & _
'                pcodes(i) & ", contact=" & contacts(i)
        Next
       
        ' At this point outputString holds the Vendor report
        processQBXmlResponse = outputString
          
    ' This part displays errors if the statusCode was not equal to 0.
    Else
        processQBXmlResponse = "Error on CustomerQueryRs"
    End If

End Function

Private Sub importClients()
'Purpose: Process response from QB and add the QB customer information to the CMS DB
Dim requestXML As String
Dim responseXML As String
Dim qbfilename As String

    'The request is built except for the headers: so build these and
    'append the request to them:
    requestXML = getQBXmlRequest
    
    'Store the response from the QB Processor
    responseXML = post(requestXML)

    'Process the response
    processQBXmlResponse (responseXML)
    
    'Debug.Print responseXML
    
End Sub

Public Function post(xmlStream As String) As String
'Purpose:
Dim qbXMLRP As New QBXMLRP2Lib.RequestProcessor2
Dim connType As QBXMLRP2Lib.QBXMLRPConnectionType
    On Error GoTo errHandler
    
    ' Open connection to qbXMLRP COM
    connType = localQBD

    qbXMLRP.OpenConnection2 "", "CMS", connType
        
        
    ' Begin Session
    ' Pass empty string for the data file name to use the currently
    ' open data file.
    Dim ticket  As String
    ticket = qbXMLRP.BeginSession("", QBXMLRP2Lib.qbFileOpenDoNotCare)
        
    ' Send request to QuickBooks
    post = qbXMLRP.ProcessRequest(ticket, xmlStream)
    
    ' End the session
    qbXMLRP.EndSession ticket
    
    ' Close the connection
    qbXMLRP.CloseConnection
    Exit Function
    
errHandler:
    post = ""
End Function

Private Sub Form_Deactivate()
    Me.Hide
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    lblFunction.Caption = "Select The Company File You Wish To Import"
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
