unit Unit10;

interface

uses
  Classes;

type
  TThread3 = class(TThread)
  private
    { Private declarations }
    pos:longint;
    df:textfile;
    s:string;
    procedure WriteToFile;
  protected
    procedure Execute; override;
  published
    constructor CreateIt(PriorityLevel: cardinal; si:string; posi:longint);
    destructor Destroy; override;
  end;
var
  x:array[1..8] of byte;
implementation

uses unit1,unit5,windows;
{ TThread3 }

/////////////// constructor /////////////////
constructor TThread3.CreateIt(PriorityLevel: cardinal;si:string;posi:longint);
begin
  inherited Create(true);
  Priority := TThreadPriority(PriorityLevel);
  FreeOnTerminate := true;

  pos:=posi;
  s:=si;

  assignfile(df,s);
  rewrite(df);
  append(df);

  Suspended := false;  // Continue the thread
end;
/////////////// destructor /////////////////
destructor TThread3.Destroy;
begin
   PostMessage(form1.Handle,wm_ThreadDoneMsg,self.ThreadID,0);
   inherited destroy;
end;
///////////// AsciiToBin  ////////////////////
procedure AsciiToBin(a:byte);
var i:integer;
begin
 for i:=1 to 8 do
  x[i]:=0;

 i:=1;
 while a<>0 do
  begin
    x[i]:=a mod 2;
    a:=a div 2;
    inc(i);
  end;

end;
/////////////// WriteToFile ///////////////////
procedure TThread3.WriteToFile;
var buf:byte;
    i:integer;
begin
  inc(form5.flag_3);
  seek(form5.sf_3,pos);
  while not(eof(form5.sf_3)) do
    begin
      seek(form5.sf_3,pos);
      pos:=pos + 4;
      if not(eof(form5.sf_3)) then
       begin
        read(form5.sf_3,buf);
        AsciiToBin(Buf);
        for i:=8 downto 1 do
          write(df,x[i]);
       end;
    end;
  closefile(df);
  if form5.flag_3=4 then
   begin
    closefile(form5.sf_3);
    form5.Create_backup;
   end; 
end;
/////////////// Execute ///////////////////
procedure TThread3.Execute;
begin
   Synchronize(WriteToFile);
end;
//////////////////////////////////////////

end.
