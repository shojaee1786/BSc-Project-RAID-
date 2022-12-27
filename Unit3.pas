unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Unit12;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    MyThread1 : TThread1; // thread number 1
    MyThread2 : TThread1; // thread number 2
    MyThread3 : TThread1; // thread number 3
    MyThread4 : TThread1; // thread number 4
    MyThread5 : TThread1; // thread number 5
    MyThread6 : TThread1; // thread number 6
    Thread1Active : boolean;
    Thread2Active : boolean;
    Thread3Active : boolean;
    Thread4Active : boolean;
    Thread5Active : boolean;
    Thread6Active : boolean;
    procedure CreateThread1;
    procedure CreateThread2;
    procedure CreateThread3;
    procedure CreateThread4;
    procedure CreateThread5;
    procedure CreateThread6;
  public
    { Public declarations }
    pos1_1,pos2_1,pos3_1:longint;
    pos4_1,pos5_1,pos6_1:longint;
    s1_1,s2_1,s3_1:string;
    s4_1,s5_1,s6_1:string;
    sf_1:file of byte;
    flag_1:byte;
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
/////////////// Create Thread 1 ////////////////
procedure TForm3.CreateThread1;
begin
   if (MyThread1 = nil) or (Thread1Active = false) then
   begin
     MyThread1 := TThread1.CreateIt(5,s1_1,pos1_1);
     Thread1Active := true;
   end;
end;
/////////////// Create Thread 2 /////////////////
procedure TForm3.CreateThread2;
begin
   if (MyThread2 = nil) or (Thread2Active = false) then
   begin
     MyThread2 := TThread1.CreateIt(5,s2_1,pos2_1);
     Thread2Active := true;
   end;
end;
/////////////// Create Thread 3 ////////////////
procedure TForm3.CreateThread3;
begin
   if (MyThread3 = nil) or (Thread3Active = false) then
   begin
     MyThread3 := TThread1.CreateIt(5,s3_1,pos3_1);
     Thread3Active := true;
   end;
end;
/////////////// Create Thread 4 /////////////////
procedure TForm3.CreateThread4;
begin
   if (MyThread4 = nil) or (Thread4Active = false) then
   begin
     MyThread4 := TThread1.CreateIt(5,s4_1,pos4_1);
     Thread4Active := true;
   end;
end;
/////////////// Create Thread 5 ////////////////
procedure TForm3.CreateThread5;
begin
   if (MyThread5 = nil) or (Thread5Active = false) then
   begin
     MyThread5 := TThread1.CreateIt(5,s5_1,pos5_1);
     Thread5Active := true;
   end;
end;
/////////////// Create Thread 6 /////////////////
procedure TForm3.CreateThread6;
begin
   if (MyThread6 = nil) or (Thread6Active = false) then
   begin
     MyThread6 := TThread1.CreateIt(5,s6_1,pos6_1);
     Thread6Active := true;
   end;
end;
/////////// Store file into RAID memory ////////////
procedure TForm3.Button1Click(Sender: TObject);
var f:textfile;
    i,j,l:integer;
    s,s1:string;
begin
 // initialize to zero
 Thread1Active := false;
 Thread2Active := false;
 Thread3Active := false;
 Thread4Active := false;
 Thread5Active := false;
 Thread6Active := false;

 flag_1:=0;
 if opendialog1.Execute then
  begin
   assignfile(sf_1,opendialog1.FileName);
   reset(sf_1);
   if filesize(sf_1)=0 then
     begin
      MessageDlg('This file is empty.', mtInformation,[mbOk], 0);
      exit;
     end;
   form3.Refresh;

   s:='';
   s1:='';

   s:=opendialog1.FileName;
   l:=length(s);
   for i:=l downto 1 do
     if s[i]='\' then
       break;

   for j:=i+1 to l do
      s1:=s1+s[j];

   s:='';
   s:=s1;

   if fileexists('c:\info_level 1.log') then
     begin
       assignfile(f,'c:\info_level 1.log');
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

   s1_1:='c'+':\'+ s +'_1.txt';
   s2_1:='d'+':\'+ s +'_1.txt';
   s3_1:='e'+':\'+ s +'_1.txt';
   s4_1:='f'+':\'+ s +'_1.txt';
   s5_1:='g'+':\'+ s +'_1.txt';
   s6_1:='h'+':\'+ s +'_1.txt';

   listbox1.AddItem(s,sender);

   assignfile(f,'c:\info_level 1.log');
   if not fileexists('c:\info_level 1.log') then
     rewrite(f);
   append(f);
   writeln(f,s);
   closefile(f);

   pos1_1:=0;
   pos2_1:=1;
   pos3_1:=2;
   pos4_1:=0;
   pos5_1:=1;
   pos6_1:=2;

   CreateThread1;
   CreateThread2;
   CreateThread3;
   CreateThread4;
   CreateThread5;
   CreateThread6;

  end
 else
   exit;

end;
/////////// Load file from RAID memory ////////////
procedure TForm3.Button2Click(Sender: TObject);
var ext,s,s1,s2,s3,s4,s5,s6:string;
    f3,f7,f8:file of byte;
    f2:textfile;
    pos,pos1,pos2,pos3:longint;
    i,j,l:integer;
    a:byte;
    flag:boolean;

begin

 i:=listbox1.ItemIndex;
 if i<>-1 then
   s:=listbox1.Items[i]
 else
   begin
     MessageDlg('File not selected .', mtWarning ,[mbOk], 0);
     exit;
   end;

 s1:='c'+':\'+ s +'_1.txt';
 s2:='d'+':\'+ s +'_1.txt';
 s3:='e'+':\'+ s +'_1.txt';
 s4:='f'+':\'+ s +'_1.txt';
 s5:='g'+':\'+ s +'_1.txt';
 s6:='h'+':\'+ s +'_1.txt';
 flag:=false;
////////////////////////////////////////////
if    not(fileexists(s1)) or not(fileexists(s2))
   or not(fileexists(s3)) or not(fileexists(s4))
   or not(fileexists(s5)) or not(fileexists(s6)) then
    begin

      if radiobutton2.Checked then
        begin
          MessageDlg('You can''t Load this file from RAID memory , Because disk is failure .', mtInformation ,[mbOk], 0);
          exit;
        end;

      if not(fileexists(s1)) and (fileexists(s4)) then
       begin
        flag:=true;
        assignfile(f2,s1);
        rewrite(f2);
        append(f2);

        assignfile(f3,s4);
        reset(f3);
        pos:=0;
        while not(eof(f3)) do
         begin
           seek(f3,pos);
           inc(pos);
           read(f3,a);
           write(f2,chr(a));
         end;

        closefile(f2);
        closefile(f3);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s2)) and (fileexists(s5)) then
       begin
        flag:=true;
        assignfile(f2,s2);
        rewrite(f2);
        append(f2);

        assignfile(f3,s5);
        reset(f3);
        pos:=0;
        while not(eof(f3)) do
         begin
           seek(f3,pos);
           inc(pos);
           read(f3,a);
           write(f2,chr(a));
         end;

        closefile(f2);
        closefile(f3);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s3)) and (fileexists(s6)) then
       begin
        flag:=true;
        assignfile(f2,s3);
        rewrite(f2);
        append(f2);

        assignfile(f3,s6);
        reset(f3);
        pos:=0;
        while not(eof(f3)) do
         begin
           seek(f3,pos);
           inc(pos);
           read(f3,a);
           write(f2,chr(a));
         end;

        closefile(f2);
        closefile(f3);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s4)) and (fileexists(s1)) then
       begin
        flag:=true;
        assignfile(f2,s4);
        rewrite(f2);
        append(f2);
        assignfile(f3,s1);
        reset(f3);
        pos:=0;
        while not(eof(f3)) do
         begin
           seek(f3,pos);
           inc(pos);
           read(f3,a);
           write(f2,chr(a));
         end;

        closefile(f2);
        closefile(f3);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s5)) and (fileexists(s2)) then
       begin
        flag:=true;
        assignfile(f2,s5);
        rewrite(f2);
        append(f2);
        assignfile(f3,s2);
        reset(f3);
        pos:=0;
        while not(eof(f3)) do
         begin
           seek(f3,pos);
           inc(pos);
           read(f3,a);
           write(f2,chr(a));
         end;

        closefile(f2);
        closefile(f3);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s6)) and (fileexists(s3)) then
       begin
        flag:=true;
        assignfile(f2,s6);
        rewrite(f2);
        append(f2);
        assignfile(f3,s3);
        reset(f3);
        pos:=0;
        while not(eof(f3)) do
         begin
           seek(f3,pos);
           inc(pos);
           read(f3,a);
           write(f2,chr(a));
         end;

        closefile(f2);
        closefile(f3);
       end; // end of if
 /////////////////////////////////////////
     if not(flag) then
       begin
         MessageDlg('Data disk and Back up disk has been failed , So all data loses .', mtWarning ,[mbOk], 0);
         exit;
       end;
end; // end of if


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

 form3.Refresh;

 assignfile(f3,s1);
 reset(f3);
 assignfile(f7,s2);
 reset(f7);
 assignfile(f8,s3);
 reset(f8);

 pos1:=0;
 pos2:=0;
 pos3:=0;

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
         end; // end of if f8 or file 3
      end; // end of if f7 or file 2
  end; // end of while f3 or file 1

 closefile(f2);
 closefile(f3);
 closefile(f7);
 closefile(f8);

end;
/////////// Delete file from RAID memory ////////////
procedure TForm3.Button3Click(Sender: TObject);
var i:integer;
    s,s1,s2,s3,s4,s5,s6:string;
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

 assignfile(f1,'c:\info_level 1.log');
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
     assignfile(f1,'c:\info_level 1.log');
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

 s1:='c'+':\'+ s +'_1.txt';
 s2:='d'+':\'+ s +'_1.txt';
 s3:='e'+':\'+ s +'_1.txt';
 s4:='f'+':\'+ s +'_1.txt';
 s5:='g'+':\'+ s +'_1.txt';
 s6:='h'+':\'+ s +'_1.txt';

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

 if fileexists(s5) then
  begin
   assignfile(f,s5);
   erase(f);
  end;

 if fileexists(s6) then
  begin
   assignfile(f,s6);
   erase(f);
  end;

 listbox1.DeleteSelected;

end;
//////////////// Form Show ///////////////////
procedure TForm3.FormShow(Sender: TObject);
var f:textfile;
    s:string;
begin
 listbox1.Clear;
 if not fileexists('c:\info_level 1.log') then
   exit;
 assignfile(f,'c:\info_level 1.log');
 reset(f);
 while not(eof(f)) do
  begin
   readln(f,s);
   listbox1.AddItem(s,sender);
  end;
 closefile(f);
end;
////////////////////////////////////////////
procedure TForm3.RadioButton1Click(Sender: TObject);
begin
 button4.Visible:=false;
 button3.Top:=312;
 button3.Left:=360;
end;
////////////////////////////////////////////
procedure TForm3.RadioButton2Click(Sender: TObject);
begin
 button4.Visible:=true;
 button4.Top:=336;
 button4.Left:=400;
 button3.Top:=336;
 button3.Left:=312;
end;
////////////////////////////////////////////
procedure TForm3.Button4Click(Sender: TObject);
var  f2:textfile;
     f3:file of byte;
     i:integer;
     a:byte;
     pos:longint;
     s:string;
     s1,s2,s3,s4,s5,s6:string;
begin
 i:=listbox1.ItemIndex;
 if i<>-1 then
   s:=listbox1.Items[i]
 else
   begin
     MessageDlg('File not selected .', mtWarning ,[mbOk], 0);
     exit;
   end;

 s1:='c'+':\'+ s +'_1.txt';
 s2:='d'+':\'+ s +'_1.txt';
 s3:='e'+':\'+ s +'_1.txt';
 s4:='f'+':\'+ s +'_1.txt';
 s5:='g'+':\'+ s +'_1.txt';
 s6:='h'+':\'+ s +'_1.txt';
////////////////////////////////////////////
if     (fileexists(s1)) and (fileexists(s2))
   and (fileexists(s3)) and (fileexists(s4))
   and (fileexists(s5)) and (fileexists(s6)) then
    begin
     MessageDlg('All disks is healthy .', mtInformation ,[mbOk], 0);
     exit;
    end;

      if not(fileexists(s1)) and (fileexists(s4)) then
       begin
        assignfile(f2,s1);
        rewrite(f2);
        append(f2);

        assignfile(f3,s4);
        reset(f3);
        pos:=0;
        while not(eof(f3)) do
         begin
           seek(f3,pos);
           inc(pos);
           read(f3,a);
           write(f2,chr(a));
         end;

        closefile(f2);
        closefile(f3);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s2)) and (fileexists(s5)) then
       begin
        assignfile(f2,s2);
        rewrite(f2);
        append(f2);

        assignfile(f3,s5);
        reset(f3);
        pos:=0;
        while not(eof(f3)) do
         begin
           seek(f3,pos);
           inc(pos);
           read(f3,a);
           write(f2,chr(a));
         end;

        closefile(f2);
        closefile(f3);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s3)) and (fileexists(s6)) then
       begin
        assignfile(f2,s3);
        rewrite(f2);
        append(f2);

        assignfile(f3,s6);
        reset(f3);
        pos:=0;
        while not(eof(f3)) do
         begin
           seek(f3,pos);
           inc(pos);
           read(f3,a);
           write(f2,chr(a));
         end;

        closefile(f2);
        closefile(f3);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s4)) and (fileexists(s1)) then
       begin
        assignfile(f2,s4);
        rewrite(f2);
        append(f2);
        assignfile(f3,s1);
        reset(f3);
        pos:=0;
        while not(eof(f3)) do
         begin
           seek(f3,pos);
           inc(pos);
           read(f3,a);
           write(f2,chr(a));
         end;

        closefile(f2);
        closefile(f3);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s5)) and (fileexists(s2)) then
       begin
        assignfile(f2,s5);
        rewrite(f2);
        append(f2);
        assignfile(f3,s2);
        reset(f3);
        pos:=0;
        while not(eof(f3)) do
         begin
           seek(f3,pos);
           inc(pos);
           read(f3,a);
           write(f2,chr(a));
         end;

        closefile(f2);
        closefile(f3);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s6)) and (fileexists(s3)) then
       begin
        assignfile(f2,s6);
        rewrite(f2);
        append(f2);
        assignfile(f3,s3);
        reset(f3);
        pos:=0;
        while not(eof(f3)) do
         begin
           seek(f3,pos);
           inc(pos);
           read(f3,a);
           write(f2,chr(a));
         end;

        closefile(f2);
        closefile(f3);
       end; // end of if
 /////////////////////////////////////////
if    not(fileexists(s1)) or not(fileexists(s2))
   or not(fileexists(s3)) or not(fileexists(s4))
   or not(fileexists(s5)) or not(fileexists(s6)) then
    begin
         MessageDlg('Data disk and Back up disk has been failed , So all data loses .', mtWarning ,[mbOk], 0);
         exit;
    end;

end;
////////////////////////////////////////////
end.
