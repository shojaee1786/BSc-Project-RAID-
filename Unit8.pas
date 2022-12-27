unit Unit8;

interface

uses
  Classes;

type
  TMyThread = class(TThread)
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

uses unit1,unit2,windows;

{ TMyThread }

/////////////// constructor /////////////////
constructor TMyThread.CreateIt(PriorityLevel: cardinal;si:string;posi:longint);
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
destructor TMyThread.Destroy;
begin
   PostMessage(form1.Handle,wm_ThreadDoneMsg,self.ThreadID,0);
   inherited destroy;
end;
/////////////// WriteToFile ///////////////////
procedure TMyThread.WriteToFile;
var buf:byte;
begin
  inc(form2.flag);
  seek(form2.sf,pos);
  while not(eof(form2.sf)) do
    begin
      seek(form2.sf,pos);
      pos:=pos + 4;
      if not(eof(form2.sf)) then
       begin
        read(form2.sf,buf);
        write(df,chr(buf));
       end;
    end;
  closefile(df);
  if form2.flag=4 then
   closefile(form2.sf);
end;
/////////////// Execute ///////////////////
procedure TMyThread.Execute;
begin
   Synchronize(WriteToFile);
end;
///////////////////////////////////////
end.
