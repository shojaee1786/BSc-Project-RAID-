unit Unit14;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg;

type
  TForm14 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    i,j:integer;
    s1,s2:string;
  public
    { Public declarations }
  end;

var
  Form14: TForm14;

implementation

uses Unit1;

{$R *.dfm}
////////////////////////////////////////////////
procedure TForm14.Timer1Timer(Sender: TObject);
var ch1,ch2:char;
begin
 if i<=length(s1) then
  begin
   ch1:=s1[i];
   Label1.Caption:=Label1.Caption+ch1;
   inc(i);
  end;

 if (i>length(s1)) and (j<=length(s2)) then
  begin
   ch2:=s2[j];
   Label2.Caption:=Label2.Caption+ch2;
   inc(j);
  end;

 if (i>length(s1)) and (j>length(s2)) then
   begin
     timer1.Enabled:=false;
     form14.Visible:=false;
     form1.show;
   end;
end;
////////////////////////////////////////////////
procedure TForm14.FormShow(Sender: TObject);
begin
 s1:='RAID Simulation with ';
 s2:='multithread programming           ';
 i:=1;
 j:=1;
end;
////////////////////////////////////////////////
end.
