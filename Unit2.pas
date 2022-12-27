unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Unit8;

type
  TForm2 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    MyThread1 : TMyThread; // thread number 1
    MyThread2 : TMyThread; // thread number 2
    MyThread3 : TMyThread; // thread number 3
    MyThread4 : TMyThread; // thread number 4
    Thread1Active : boolean;
    Thread2Active : boolean;
    Thread3Active : boolean;
    Thread4Active : boolean;
    procedure CreateThread1;
    procedure CreateThread2;
    procedure CreateThread3;
    procedure CreateThread4;
  public
    { Public declarations }
    pos1,pos2,pos3,pos4:longint;
    s1,s2,s3,s4:string;
    sf:file of byte;
    flag:byte;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
/////////////// Create Thread 1 ////////////////
procedure TForm2.CreateThread1;
begin
   if (MyThread1 = nil) or (Thread1Active = false) then
   begin
     MyThread1 := TMyThread.CreateIt(5,s1,pos1);
     Thread1Active := true;
   end;
end;
/////////////// Create Thread 2 /////////////////
procedure TForm2.CreateThread2;
begin
   if (MyThread2 = nil) or (Thread2Active = false) then
   begin
     MyThread2 := TMyThread.CreateIt(5,s2,pos2);
     Thread2Active := true;
   end;
end;
/////////////// Create Thread 3 ////////////////
procedure TForm2.CreateThread3;
begin
   if (MyThread3 = nil) or (Thread3Active = false) then
   begin
     MyThread3 := TMyThread.CreateIt(5,s3,pos3);
     Thread3Active := true;
   end;
end;
/////////////// Create Thread 4 /////////////////
procedure TForm2.CreateThread4;
begin
   if (MyThread4 = nil) or (Thread4Active = false) then
   begin
     MyThread4 := TMyThread.CreateIt(5,s4,pos4);
     Thread4Active := true;
   end;
end;
/////////// Store file into RAID memory ////////////
procedure TForm2.Button1Click(Sender: TObject);
var f:textfile;
    i,j,l:integer;
    s:string;
begin
 // initialize to zero
 Thread1Active := false;
 Thread2Active := false;
 Thread3Active := false;
 Thread4Active := false;

 flag:=0;
 if opendialog1.Execute then
  begin
   assignfile(sf,opendialog1.FileName);
   reset(sf);
   if filesize(sf)=0 then
     begin
      MessageDlg('This file is empty.', mtInformation,[mbOk], 0);
      exit;
     end;
   form2.Refresh;

   s:='';
   s1:='';
   s2:='';
   s3:='';
   s4:='';

   s:=opendialog1.FileName;
   l:=length(s);
   for i:=l downto 1 do
     if s[i]='\' then
       break;

   for j:=i+1 to l do
      s1:=s1+s[j];

   s:='';
   s:=s1;

   if fileexists('c:\info_level 0.log') then
     begin
       assignfile(f,'c:\info_level 0.log');
       reset(f);
       while not(eof(f)) do
         begin
           readln(f,s1);
           if s=s1 then
            begin
             MessageDlg('This file already exists .', mtInformation,[mbOk], 0);
             closefile(f);
             exit;
            end;
         end;
       closefile(f);
     end;

   s1:='c'+':\'+ s +'_0.txt';
   s2:='d'+':\'+ s +'_0.txt';
   s3:='e'+':\'+ s +'_0.txt';
   s4:='f'+':\'+ s +'_0.txt';

   listbox1.AddItem(s,sender);

   assignfile(f,'c:\info_level 0.log');
   if not fileexists('c:\info_level 0.log') then
     rewrite(f);
   append(f);
   writeln(f,s);
   closefile(f);

   pos1:=0;
   pos2:=1;
   pos3:=2;
   pos4:=3;

   CreateThread1;
   CreateThread2;
   CreateThread3;
   CreateThread4;
  end
 else
   exit;

end;
/////////// Load file from RAID memory ////////////
procedure TForm2.Button2Click(Sender: TObject);
var ext,s:string;
    f3,f7,f8,f9:file of byte;
    f2:textfile;
    i,j,l,pos1,pos2,pos3,pos4:integer;
    a:byte;
    flag:boolean;

begin

 s:='';
 i:=listbox1.ItemIndex;
 if i<>-1 then
   s:=listbox1.Items[i]
 else
   begin
     MessageDlg('File not selected .', mtWarning ,[mbOk], 0);
     exit;
   end;

 s1:='';
 s2:='';
 s3:='';
 s4:='';

 s1:='c'+':\'+ s +'_0.txt';
 s2:='d'+':\'+ s +'_0.txt';
 s3:='e'+':\'+ s +'_0.txt';
 s4:='f'+':\'+ s +'_0.txt';


 l:=length(s);
 for i:=l downto 1 do
   if s[i]='.' then
       break;

 ext:='';
 for j:=i+1 to l do
    ext:=ext+s[j];

 savedialog1.Filter:='*.'+ext;
 savedialog1.FileName:='Default.'+ext;
 flag:=false;
 if savedialog1.Execute then
  begin
   s:=savedialog1.FileName;
   l:=length(s);
   for i:=l downto 1 do
     if s[i]='.' then
        flag:=true;
   if not(flag) then
     savedialog1.FileName:=savedialog1.FileName+'.'+ext;
   assignfile(f2,savedialog1.FileName);
   rewrite(f2);
   append(f2);
  end
 else
   exit;

 form2.Refresh;

 assignfile(f3,s1);
 reset(f3);
 assignfile(f7,s2);
 reset(f7);
 assignfile(f8,s3);
 reset(f8);
 assignfile(f9,s4);
 reset(f9);

 pos1:=0;
 pos2:=0;
 pos3:=0;
 pos4:=0;

 while not(eof(f3)) do
  begin
    seek(f3,pos1);
    read(f3,a);
    write(f2,chr(a));
    inc(pos1);
    ///////////////////////////
    if not(eof(f7)) then
      begin
       seek(f7,pos2);
       read(f7,a);
       write(f2,chr(a));
       inc(pos2);
       ///////////////////////////
       if not(eof(f8)) then
         begin
          seek(f8,pos3);
          read(f8,a);
          write(f2,chr(a));
          inc(pos3);
          ///////////////////////////
          if not(eof(f9)) then
            begin
             seek(f9,pos4);
             read(f9,a);
             write(f2,chr(a));
             inc(pos4);
            end; // end of if f9 or file 4
         end; // end of if f8 or file 3
      end; // end of if f7 or file 2
  end; // end of while f3 or file 1

 closefile(f2);
 closefile(f3);
 closefile(f7);
 closefile(f8);
 closefile(f9);

end;
/////////// Delete file from RAID memory ////////////
procedure TForm2.Button3Click(Sender: TObject);
var i:integer;
    s,s1,s2,s3,s4:string;
    f:file;
    f1:textfile;
    temp:array[1..20] of string;
begin

 i:=listbox1.ItemIndex;
 if i<>-1 then
   s:=listbox1.Items[i]
 else
   begin
     MessageDlg('File not selected .', mtWarning ,[mbOk], 0);
     exit;
   end;

 assignfile(f1,'c:\info_level 0.log');
 reset(f1);
 i:=0;
 while not(eof(f1)) do
  begin
   readln(f1,s1);
   if s<>s1 then
    begin
     inc(i);
     temp[i]:=s1;
    end;
  end;
 if i=0 then
   begin
     closefile(f1);
     assignfile(f1,'c:\info_level 0.log');
     erase(f1);
   end
 else
   begin
     rewrite(f1);
     append(f1);
     while i<>0 do
      begin
       writeln(f1,temp[i]);
       dec(i);
      end;
     closefile(f1);
   end;

 s1:='c'+':\'+ s +'_0.txt';
 s2:='d'+':\'+ s +'_0.txt';
 s3:='e'+':\'+ s +'_0.txt';
 s4:='f'+':\'+ s +'_0.txt';

 if fileexists(s1) then
  begin
   assignfile(f,s1);
   erase(f);
  end;

 if fileexists(s2) then
  begin
   assignfile(f,s2);
   erase(f);
  end;

 if fileexists(s3) then
  begin
   assignfile(f,s3);
   erase(f);
  end;

 if fileexists(s4) then
  begin
   assignfile(f,s4);
   erase(f);
  end;

 listbox1.DeleteSelected;

end;
//////////////// Form Show ///////////////////
procedure TForm2.FormShow(Sender: TObject);
var f:textfile;
    s:string;
begin
 listbox1.Clear;
 if not fileexists('c:\info_level 0.log') then
   exit;
 assignfile(f,'c:\info_level 0.log');
 reset(f);
 while not(eof(f)) do
  begin
   readln(f,s);
   listbox1.AddItem(s,sender);
  end;
 closefile(f);
end;
/////////////////////////////////////////////

end.
