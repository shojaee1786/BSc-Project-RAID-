unit Unit9;

interface

uses
  Classes;

type
  TThread4 = class(TThread)
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

uses unit1,unit6,windows;
{ TThread4 }

/////////////// constructor /////////////////
constructor TThread4.CreateIt(PriorityLevel: cardinal;si:string;posi:longint);
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
destructor TThread4.Destroy;
begin
   PostMessage(form1.Handle,wm_ThreadDoneMsg,self.ThreadID,0);
   inherited destroy;
end;
/////////////// WriteToFile ///////////////////
procedure TThread4.WriteToFile;
var buf:byte;
begin
  inc(form6.flag_4);
  seek(form6.sf_4,pos);
  while not(eof(form6.sf_4)) do
    begin
      seek(form6.sf_4,pos);
      pos:=pos + 4;
      if not(eof(form6.sf_4)) then
       begin
        read(form6.sf_4,buf);
        write(df,chr(buf));
       end;
    end;
  closefile(df);
  if form6.flag_4 = 4 then
   begin
    closefile(form6.sf_4);
    form6.Create_backup;
   end;
end;
/////////////// Execute ///////////////////
procedure TThread4.Execute;
begin
   Synchronize(WriteToFile);
end;
///////////////////////////////////////

end.
