unit Unit12;

interface

uses
  Classes;

type
  TThread1 = class(TThread)
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
    destructor  Destroy; override;
  end;

implementation

uses unit1,unit3,windows;

{ TThread1 }
/////////////// constructor /////////////////
constructor TThread1.CreateIt(PriorityLevel: cardinal;si:string;posi:longint);
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
destructor TThread1.Destroy;
begin
   PostMessage(form1.Handle,wm_ThreadDoneMsg,self.ThreadID,0);
   inherited destroy;
end;
/////////////// WriteToFile ///////////////////
procedure TThread1.WriteToFile;
var buf:byte;
begin
  inc(form3.flag_1);
  seek(form3.sf_1,pos);
  while not(eof(form3.sf_1)) do
    begin
      seek(form3.sf_1,pos);
      pos:=pos + 3;
      if not(eof(form3.sf_1)) then
       begin
        read(form3.sf_1,buf);
        write(df,chr(buf));
       end;
    end;
  closefile(df);
  if form3.flag_1 = 6 then
   closefile(form3.sf_1);
end;
/////////////// Execute ///////////////////
procedure TThread1.Execute;
begin
  { Place thread code here }
  Synchronize(WriteToFile);
end;
///////////////////////////////////////
end.
 