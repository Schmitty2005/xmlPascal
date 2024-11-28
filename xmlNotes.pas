{$mode delphi}
//*************************************
//
//    A simple program to make a midnam
//    output with flat notes instead of
//    sharps!
//
//     https://jsonformatter.org/xml-viewer
//     https://github.com/Ardour/ardour/blob/master/share/patchfiles/MIDI.midnam
//
//  Set new customDevice Mode in midnam "General MIDI Flat Notes"
//
//     The Unicode character '♭' (U+266D) is the flat sign.
//         Unicode Character “♯” (U+266F)
//    
//*************************************

program xmlNotes;

uses  strings, sysutils;

const
  FLAT = '♭';
  SHARP = '♯';
  HeaderStart = '<NoteNameList Name="General MIDI Drums">';
  HeaderEnd = '</NoteNameList>';

type
   note = array [0..3] of  WideChar;
   scale = array [0..11] of note;
//Example
//  <Note Number="35" Name="Bass Drum 2"/>

var
  octave : Integer;
  counter : Integer;
  output : String;
  Notes : scale = ('C ', 'D♭', 'D ', 'E♭', 'E ', 'F ', 'G♭', 'G ', 'A♭', 'A ', 'B♭', 'B ') ;
  //Notes : scale = ('C ', 'Db', 'D ', 'Eb', 'E ', 'F ', 'Gb', 'G ', 'Ab', 'A ', 'Bb', 'B ') ;
  
begin
  counter := 0;
  octave := -1;
  writeln('    <NoteNameList Name="General MIDI (Flat Notes)">');
  while counter < 128 do 
    begin
      writeln( '      <Note Number="'+IntToStr(counter)+'" Name="' + Notes[counter mod 12]+IntToStr (octave)+'"/>');
      if ((counter mod 12)=0 )and (counter <> 0) then inc(octave);
      inc(counter);
    end;
  writeln('    </NoteNameList>');
end.
