unit xmlMidnam;


{$mode ObjFPC}{$H+}

interface


uses
  Classes, SysUtils, DOM, XMLRead;

procedure readTestMidnam;


implementation

var
  model: TDOMNode;
  Doc: TXMLDocument;

procedure readTestMidnam ;
begin
  try
    // Read in xml file from disk
    ReadXMLFile(Doc, 'midnam/MIDI.midnam');
    // Retrieve the "password" node
    model       := Doc.DocumentElement.FindNode('Author');
    // Write out value of the selected node
    writeln.(model.NodeValue); // will be midnam author blank
    // The text of the node is actually a separate child node
    WriteLn(model.FirstChild.NodeValue); // correctly prints "abc"
    // alternatively
    WriteLn(model.TextContent);
  finally
    // finally, free the document
    Doc.Free;
  end;

end;

end.

