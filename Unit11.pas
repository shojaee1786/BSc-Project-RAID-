unit Unit11;

interface

uses
  Classes;

type
  TThread5 = class(TThread)
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

implementation

uses unit1,unit7,windows;

{ TThread5 }
/////////////// constructor /////////////////
constructor TThread5.CreateIt(PriorityLevel: cardinal;si:string;posi:longint);
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
destructor TThread5.Destroy;
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
procedure TThread5.WriteToFile;
var buf:byte;
    i:integer;
begin
  inc(form7.flag_5);
  seek(form7.sf_5,pos);
  while not(eof(form7.sf_5)) do
    begin
      seek(form7.sf_5,pos);
      pos:=pos + 4;
      if not(eof(form7.sf_5)) then
       begin
        read(form7.sf_5,buf);
        AsciiToBin(Buf);
        for i:=8 downto 1 do
          write(df,x[i]);
       end;
    end;
  closefile(df);
  if form7.flag_5=4 then
   closefile(form7.sf_5);
end;
/////////////// Execute ///////////////////
procedure TThread5.Execute;
begin
   Synchronize(WriteToFile);
end;
//////////////////////////////////////////

end.
