unit Unit13;

interface

uses
  Classes;

type
  TThread2 = class(TThread)
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

uses unit1,unit4,windows;

{ TThread2 }
/////////////// constructor /////////////////
constructor TThread2.CreateIt(PriorityLevel: cardinal;si:string;posi:longint);
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
destructor TThread2.Destroy;
begin
   PostMessage(form1.Handle,wm_ThreadDoneMsg,self.ThreadID,0);
   inherited destroy;
end;
/////////////// WriteToFile ///////////////////
procedure TThread2.WriteToFile;
var buf:byte;
begin
  inc(form4.flag_2);
  seek(form4.sf_2,pos);
  while not(eof(form4.sf_2)) do
    begin
      seek(form4.sf_2,pos);
      pos:=pos + 4;
      if not(eof(form4.sf_2)) then
       begin
        read(form4.sf_2,buf);
        write(df,chr(buf));
       end;
    end;
  closefile(df);
  if form4.flag_2 = 4 then
   begin
    closefile(form4.sf_2);
    form4.Create_backup;
   end;

end;
/////////////// Execute ///////////////////
procedure TThread2.Execute;
begin
  { Place thread code here }
   Synchronize(WriteToFile);
end;
//////////////////////////////////////////

end.
 