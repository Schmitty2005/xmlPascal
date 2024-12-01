unit LazMidnamer;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ComCtrls, DOM, XMLRead;

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
    OpenDialog1: TOpenDialog;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}


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
  Doc: TXMLDocument;
  //filename : String;

begin

  if OpenDialog1.Execute then
  begin
    if fileExists(OpenDialog1.Filename) then
     ReadXMLFile(Doc, 'midnam/MIDI.midnam');//OpenDialog1.Filename);
  end
else
  ShowMessage('No file selected');

  author := Doc.DocumentElement.FindNode('Author');
  Label2.Caption := author.FirstChild.NodeValue;
  edt_Author.Text := author.FirstChild.NodeValue;

end;

procedure TForm1.GroupBox1Click(Sender: TObject);
begin

end;




end.

