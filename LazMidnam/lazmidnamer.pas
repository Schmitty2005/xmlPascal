unit LazMidnamer;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ComCtrls,  laz2_DOM, laz2_XMLRead;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    edt_manufacturer: TEdit;
    edt_Author: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbl_Author: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    OpenDialog1: TOpenDialog;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}


//From :  https://wiki.freepascal.org/XML_Tutorial#Populating_a_TreeView_with_XML

procedure XML2Tree(XMLDoc:TXMLDocument; TreeView:TTreeView);

  // Local function that outputs all node attributes as a string
  function GetNodeAttributesAsString(pNode: TDOMNode):string;
  var i: integer;
  begin
    Result:='';
    if pNode.HasAttributes then
      for i := 0 to pNode.Attributes.Length -1 do
        with pNode.Attributes[i] do
          Result := Result + format(' %s="%s"', [NodeName, NodeValue]);

    // Remove leading and trailing spaces
    Result:=Trim(Result);
  end;

  // Recursive function to process a node and all its child nodes

  procedure ParseXML(Node:TDOMNode; TreeNode: TTreeNode);
  begin
    // Exit procedure if no more nodes to process
    if Node = nil then Exit;

    // Add node to TreeView
    TreeNode := TreeView.Items.AddChild(TreeNode,
                                          Trim(Node.NodeName+' '+
                                           GetNodeAttributesAsString(Node)+
                                           Node.NodeValue)
                                        );

    // Process all child nodes
    Node := Node.FirstChild;
    while Node <> Nil do
    begin
      ParseXML(Node, TreeNode);
      Node := Node.NextSibling;
    end;
  end;

begin
  TreeView.Items.Clear;
  ParseXML(XMLDoc.DocumentElement,nil);
end;



procedure readTestMidnam ;
var
  model: TDOMNode;
  Doc: TXMLDocument;

begin
  try
    // Read in xml file from disk
    ReadXMLFile(Doc, 'midnam/MIDI.midnam');
    // Retrieve the "password" node
    model       := Doc.DocumentElement.FindNode('Author');
    // Write out value of the selected node
    writeln(model.NodeValue); // will be midnam author blank
    // The text of the node is actually a separate child node
    WriteLn(model.FirstChild.NodeValue); // correctly prints "abc"
    // alternatively
    WriteLn(model.TextContent);

    Form1.Label2.Caption := 'HELLO!';
  finally
    // finally, free the document
    Doc.Free;
  end;

end;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  readTestMidnam();
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  author: TDOMNode;
  manufacturer : TDOMNode;
  Doc: TXMLDocument;
  //filename : String;

begin

  if OpenDialog1.Execute then
  begin
    if fileExists(OpenDialog1.Filename) then
    begin
      //ShowMessage(OpenDialog1.Filename);
     ReadXMLFile(Doc, OpenDialog1.Filename);
     XML2Tree (Doc, TreeView1);

    end;
  end
else
  ShowMessage('No file selected');



  author := Doc.DocumentElement.FindNode('Author');
  Label2.Caption := author.FirstChild.NodeValue;
  manufacturer := Doc.DocumentElement.FindNode('MasterDeviceNames');
  edt_manufacturer.Text := manufacturer.FirstChild.NodeValue;;
  edt_Author.Text := author.FirstChild.NodeValue;
  Doc.free;

end;

procedure TForm1.GroupBox1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin

end;




end.

