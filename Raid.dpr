program Raid;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  Unit5 in 'Unit5.pas' {Form5},
  Unit6 in 'Unit6.pas' {Form6},
  Unit7 in 'Unit7.pas' {Form7},
  Unit8 in 'Unit8.pas',
  Unit9 in 'Unit9.pas',
  Unit10 in 'Unit10.pas',
  Unit11 in 'Unit11.pas',
  Unit12 in 'Unit12.pas',
  Unit13 in 'Unit13.pas',
  Unit14 in 'Unit14.pas' {Form14};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm14, Form14);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
