unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Unit10;

type
  TForm5 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Button4: TButton;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Create_backup;
  private
    { Private declarations }
    MyThread1 : TThread3; // thread number 1
    MyThread2 : TThread3; // thread number 2
    MyThread3 : TThread3; // thread number 3
    MyThread4 : TThread3; // thread number 4
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
    pos1_3,pos2_3,pos3_3,pos4_3:longint;
    s1_3,s2_3,s3_3,s4_3:string;
    sf_3:file of byte;
    flag_3:byte;
  end;

var
  Form5: TForm5;
  x:array[1..8] of byte;
  s:string;
implementation

//uses Unit8;

{$R *.dfm}
/////////////// Create Thread 1 ////////////////
procedure TForm5.CreateThread1;
begin
   if (MyThread1 = nil) or (Thread1Active = false) then
   begin
     MyThread1 := TThread3.CreateIt(5,s1_3,pos1_3);
     Thread1Active := true;
   end;
end;
/////////////// Create Thread 2 /////////////////
procedure TForm5.CreateThread2;
begin
   if (MyThread2 = nil) or (Thread2Active = false) then
   begin
     MyThread2 := TThread3.CreateIt(5,s2_3,pos2_3);
     Thread2Active := true;
   end;
end;
/////////////// Create Thread 3 ////////////////
procedure TForm5.CreateThread3;
begin
   if (MyThread3 = nil) or (Thread3Active = false) then
   begin
     MyThread3 := TThread3.CreateIt(5,s3_3,pos3_3);
     Thread3Active := true;
   end;
end;
/////////////// Create Thread 4 /////////////////
procedure TForm5.CreateThread4;
begin
   if (MyThread4 = nil) or (Thread4Active = false) then
   begin
     MyThread4 := TThread3.CreateIt(5,s4_3,pos4_3);
     Thread4Active := true;
   end;
end;
/////////////////////////////////////////////
function MyPower(a,b:longint):longint;
var i:integer;
    num:longint;
begin
 num:=1;

 for i:=1 to b do
   num:=num * a;

 MyPower:=num;
end;
/////////////////////////////////////////////
procedure TForm5.Button1Click(Sender: TObject);
var f:textfile;
    i,j,l:integer;
    s1:string;
begin
 // initialize to zero
 Thread1Active := false;
 Thread2Active := false;
 Thread3Active := false;
 Thread4Active := false;

 flag_3:=0;
 if opendialog1.Execute then
  begin
   assignfile(sf_3,opendialog1.FileName);
   reset(sf_3);
   if filesize(sf_3)=0 then
     begin
      MessageDlg('This file is empty.', mtInformation,[mbOk], 0);
      exit;
     end;
   form5.Refresh;

   s:='';
   s1:='';
   s1_3:='';
   s2_3:='';
   s3_3:='';
   s4_3:='';

   s:=opendialog1.FileName;
   l:=length(s);
   for i:=l downto 1 do
     if s[i]='\' then
       break;

   for j:=i+1 to l do
      s1:=s1+s[j];

   s:='';
   s:=s1;

   if fileexists('c:\info_level 3.log') then
     begin
       assignfile(f,'c:\info_level 3.log');
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

   s1_3:='c'+':\'+ s +'_3.txt';
   s2_3:='d'+':\'+ s +'_3.txt';
   s3_3:='e'+':\'+ s +'_3.txt';
   s4_3:='f'+':\'+ s +'_3.txt';

   listbox1.AddItem(s,sender);

   assignfile(f,'c:\info_level 3.log');
   if not fileexists('c:\info_level 3.log') then
     rewrite(f);
   append(f);
   writeln(f,s);
   closefile(f);

   pos1_3:=0;
   pos2_3:=1;
   pos3_3:=2;
   pos4_3:=3;

   CreateThread1;
   CreateThread2;
   CreateThread3;
   CreateThread4;

  end
 else
   exit;

end;
/////////////////////////////////////////////
procedure TForm5.Create_Backup;
var s1,s2,s3,s4,s5:string;
    f2:textfile;
    f3,f7,f8,f9:file;
    buf:char;
    i:integer;
    pos1,pos2,pos3,pos4:longint;

begin

 s1:='c'+':\'+ s +'_3.txt';
 s2:='d'+':\'+ s +'_3.txt';
 s3:='e'+':\'+ s +'_3.txt';
 s4:='f'+':\'+ s +'_3.txt';
 s5:='g'+':\'+ s +'_3.txt';

 assignfile(f2,s5);
 rewrite(f2);
 append(f2);

 assignfile(f3,s1);
 reset(f3,1);
 assignfile(f7,s2);
 reset(f7,1);
 assignfile(f8,s3);
 reset(f8,1);
 assignfile(f9,s4);
 reset(f9,1);

 pos1:=0;
 pos2:=0;
 pos3:=0;
 pos4:=0;
 for i:=1 to 5 do
   x[i]:=0;

 while not(eof(f3)) do
  begin
   i:=1;
   seek(f3,pos1);
   inc(pos1);
   blockread(f3,buf,1);
   x[i]:=strtoint(buf);
   inc(i);
   ///////////////////////////
   if not(eof(f7)) then
     begin
      seek(f7,pos2);
      inc(pos2);
      blockread(f7,buf,1);
      x[i]:=strtoint(buf);
      inc(i);
      ///////////////////////////
      if not(eof(f8)) then
       begin
        seek(f8,pos3);
        inc(pos3);
        blockread(f8,buf,1);
        x[i]:=strtoint(buf);
        inc(i);
        ///////////////////////////
        if not(eof(f9)) then
          begin
           seek(f9,pos4);
           inc(pos4);
           blockread(f9,buf,1);
           x[i]:=strtoint(buf);
          end; // end of if f9 or file 4
       end; // end of if f8 or file 3
     end; // end of if f7 or file 2
    x[5]:=x[1] xor x[2] xor x[3] xor x[4];
    write(f2,x[5]);
  end; // end of while f3 or file 1

 closefile(f2);
 closefile(f3);
 closefile(f7);
 closefile(f8);
 closefile(f9);
end;
/////////////////////////////////////////////
procedure TForm5.Button2Click(Sender: TObject);
var ext,s,s1,s2,s3,s4,s5:string;
    f3,f7,f8,f9:file;
    f2:textfile;
    i,j,l,k,k1,k2,k3,pos1,pos2,pos3,pos4:integer;
    buf:char;
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

 s1:='c'+':\'+ s +'_3.txt';
 s2:='d'+':\'+ s +'_3.txt';
 s3:='e'+':\'+ s +'_3.txt';
 s4:='f'+':\'+ s +'_3.txt';
 s5:='g'+':\'+ s +'_3.txt';
 flag:=false;
////////////////////////////////////////////
if not(fileexists(s1)) or not(fileexists(s2))
   or not(fileexists(s3)) or not(fileexists(s4))
   or not(fileexists(s5)) then
    begin

      if radiobutton2.Checked then
        begin
          MessageDlg('You can''t Load this file from RAID memory , Because disk is failure .', mtInformation ,[mbOk], 0);
          exit;
        end;

      if not(fileexists(s1)) and (fileexists(s2))
      and (fileexists(s3)) and (fileexists(s4))
      and (fileexists(s5)) then
       begin
        flag:=true;
        assignfile(f2,s1);
        rewrite(f2);
        append(f2);

        assignfile(f3,s5);
        reset(f3,1);
        assignfile(f7,s2);
        reset(f7,1);
        assignfile(f8,s3);
        reset(f8,1);
        assignfile(f9,s4);
        reset(f9,1);

        pos1:=0;
        pos2:=0;
        pos3:=0;
        pos4:=0;
        for i:=1 to 5 do
          x[i]:=0;

        while not(eof(f3)) do
         begin
          i:=1;
          seek(f3,pos1);
          inc(pos1);
          blockread(f3,buf,1);
          x[i]:=strtoint(buf);
          inc(i);
          ///////////////////////////
          if not(eof(f7)) then
           begin
            seek(f7,pos2);
            inc(pos2);
            blockread(f7,buf,1);
            x[i]:=strtoint(buf);
            inc(i);
            ///////////////////////////
            if not(eof(f8)) then
             begin
              seek(f8,pos3);
              inc(pos3);
              blockread(f8,buf,1);
              x[i]:=strtoint(buf);
              inc(i);
              ///////////////////////////
              if not(eof(f9)) then
                begin
                  seek(f9,pos4);
                  inc(pos4);
                  blockread(f9,buf,1);
                  x[i]:=strtoint(buf);
                end; // end of if f9 or file 4
             end; // end of if f8 or file 3
           end; // end of if f7 or file 2
          x[5]:=x[1] xor x[2] xor x[3] xor x[4];
          write(f2,x[5]);
         end; // end of while f3 or file 1

        closefile(f2);
        closefile(f3);
        closefile(f7);
        closefile(f8);
        closefile(f9);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s2)) and (fileexists(s1))
      and (fileexists(s3)) and (fileexists(s4))
      and (fileexists(s5)) then
       begin
        flag:=true;
        assignfile(f2,s2);
        rewrite(f2);
        append(f2);

        assignfile(f3,s5);
        reset(f3,1);
        assignfile(f7,s1);
        reset(f7,1);
        assignfile(f8,s3);
        reset(f8,1);
        assignfile(f9,s4);
        reset(f9,1);

        pos1:=0;
        pos2:=0;
        pos3:=0;
        pos4:=0;
        for i:=1 to 5 do
          x[i]:=0;

        while not(eof(f3)) do
         begin
          i:=1;
          seek(f3,pos1);
          inc(pos1);
          blockread(f3,buf,1);
          x[i]:=strtoint(buf);
          inc(i);
          ///////////////////////////
          if not(eof(f7)) then
           begin
            seek(f7,pos2);
            inc(pos2);
            blockread(f7,buf,1);
            x[i]:=strtoint(buf);
            inc(i);
            ///////////////////////////
            if not(eof(f8)) then
             begin
              seek(f8,pos3);
              inc(pos3);
              blockread(f8,buf,1);
              x[i]:=strtoint(buf);
              inc(i);
              ///////////////////////////
              if not(eof(f9)) then
                begin
                  seek(f9,pos4);
                  inc(pos4);
                  blockread(f9,buf,1);
                  x[i]:=strtoint(buf);
                end; // end of if f9 or file 4
             end; // end of if f8 or file 3
           end; // end of if f7 or file 2
          x[5]:=x[1] xor x[2] xor x[3] xor x[4];
          write(f2,x[5]);
         end; // end of while f3 or file 1

        closefile(f2);
        closefile(f3);
        closefile(f7);
        closefile(f8);
        closefile(f9);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s3)) and (fileexists(s2))
      and (fileexists(s1)) and (fileexists(s4))
      and (fileexists(s5)) then
       begin
        flag:=true;
        assignfile(f2,s3);
        rewrite(f2);
        append(f2);

        assignfile(f3,s5);
        reset(f3,1);
        assignfile(f7,s2);
        reset(f7,1);
        assignfile(f8,s1);
        reset(f8,1);
        assignfile(f9,s4);
        reset(f9,1);

        pos1:=0;
        pos2:=0;
        pos3:=0;
        pos4:=0;
        for i:=1 to 5 do
          x[i]:=0;

        while not(eof(f3)) do
         begin
          i:=1;
          seek(f3,pos1);
          inc(pos1);
          blockread(f3,buf,1);
          x[i]:=strtoint(buf);
          inc(i);
          ///////////////////////////
          if not(eof(f7)) then
           begin
            seek(f7,pos2);
            inc(pos2);
            blockread(f7,buf,1);
            x[i]:=strtoint(buf);
            inc(i);
            ///////////////////////////
            if not(eof(f8)) then
             begin
              seek(f8,pos3);
              inc(pos3);
              blockread(f8,buf,1);
              x[i]:=strtoint(buf);
              inc(i);
              ///////////////////////////
              if not(eof(f9)) then
                begin
                  seek(f9,pos4);
                  inc(pos4);
                  blockread(f9,buf,1);
                  x[i]:=strtoint(buf);
                end; // end of if f9 or file 4
             end; // end of if f8 or file 3
           end; // end of if f7 or file 2
          x[5]:=x[1] xor x[2] xor x[3] xor x[4];
          write(f2,x[5]);
         end; // end of while f3 or file 1

        closefile(f2);
        closefile(f3);
        closefile(f7);
        closefile(f8);
        closefile(f9);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s4)) and (fileexists(s2))
      and (fileexists(s3)) and (fileexists(s1))
      and (fileexists(s5)) then
       begin
        flag:=true;
        assignfile(f2,s4);
        rewrite(f2);
        append(f2);

        assignfile(f3,s5);
        reset(f3,1);
        assignfile(f7,s2);
        reset(f7,1);
        assignfile(f8,s3);
        reset(f8,1);
        assignfile(f9,s1);
        reset(f9,1);

        pos1:=0;
        pos2:=0;
        pos3:=0;
        pos4:=0;
        for i:=1 to 5 do
          x[i]:=0;

        while not(eof(f3)) do
         begin
          i:=1;
          seek(f3,pos1);
          inc(pos1);
          blockread(f3,buf,1);
          x[i]:=strtoint(buf);
          inc(i);
          ///////////////////////////
          if not(eof(f7)) then
           begin
            seek(f7,pos2);
            inc(pos2);
            blockread(f7,buf,1);
            x[i]:=strtoint(buf);
            inc(i);
            ///////////////////////////
            if not(eof(f8)) then
             begin
              seek(f8,pos3);
              inc(pos3);
              blockread(f8,buf,1);
              x[i]:=strtoint(buf);
              inc(i);
              ///////////////////////////
              if not(eof(f9)) then
                begin
                  seek(f9,pos4);
                  inc(pos4);
                  blockread(f9,buf,1);
                  x[i]:=strtoint(buf);
                end; // end of if f9 or file 4
             end; // end of if f8 or file 3
           end; // end of if f7 or file 2
          x[5]:=x[1] xor x[2] xor x[3] xor x[4];
          write(f2,x[5]);
         end; // end of while f3 or file 1

        closefile(f2);
        closefile(f3);
        closefile(f7);
        closefile(f8);
        closefile(f9);
       end; // end of if
 /////////////////////////////////////////
      if not(fileexists(s5)) and (fileexists(s2))
      and (fileexists(s3)) and (fileexists(s4))
      and (fileexists(s1)) then
       begin
        flag:=true;
        assignfile(f2,s5);
        rewrite(f2);
        append(f2);

        assignfile(f3,s1);
        reset(f3,1);
        assignfile(f7,s2);
        reset(f7,1);
        assignfile(f8,s3);
        reset(f8,1);
        assignfile(f9,s4);
        reset(f9,1);

        pos1:=0;
        pos2:=0;
        pos3:=0;
        pos4:=0;
        for i:=1 to 5 do
          x[i]:=0;

        while not(eof(f3)) do
         begin
          i:=1;
          seek(f3,pos1);
          inc(pos1);
          blockread(f3,buf,1);
          x[i]:=strtoint(buf);
          inc(i);
          ///////////////////////////
          if not(eof(f7)) then
           begin
            seek(f7,pos2);
            inc(pos2);
            blockread(f7,buf,1);
            x[i]:=strtoint(buf);
            inc(i);
            ///////////////////////////
            if not(eof(f8)) then
             begin
              seek(f8,pos3);
              inc(pos3);
              blockread(f8,buf,1);
              x[i]:=strtoint(buf);
              inc(i);
              ///////////////////////////
              if not(eof(f9)) then
                begin
                  seek(f9,pos4);
                  inc(pos4);
                  blockread(f9,buf,1);
                  x[i]:=strtoint(buf);
                end; // end of if f9 or file 4
             end; // end of if f8 or file 3
           end; // end of if f7 or file 2
          x[5]:=x[1] xor x[2] xor x[3] xor x[4];
          write(f2,x[5]);
         end; // end of while f3 or file 1

        closefile(f2);
        closefile(f3);
        closefile(f7);
        closefile(f8);
        closefile(f9);
       end; // end of if
 /////////////////////////////////////////
     if not(flag) then
       begin
         MessageDlg('Two or more disks has been failed , So all data loses .', mtWarning ,[mbOk], 0);
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

 form5.Refresh;

 assignfile(f3,s1);
 reset(f3,1);
 assignfile(f7,s2);
 reset(f7,1);
 assignfile(f8,s3);
 reset(f8,1);
 assignfile(f9,s4);
 reset(f9,1);

 k:=0;
 k1:=0;
 k2:=0;
 k3:=0;

 while not(eof(f3)) do
  begin

   j:=8;
   for i:=0 to 7 do
    begin
     seek(f3,i+8*k);
     blockread(f3,buf,1);
     x[j]:=strtoint(buf);
     dec(j);
    end;

   ///////////////////////////
   a:=0;
   for i:=1 to 8 do
    a:=a + x[i]* MyPower(2,(i-1));

   write(f2,chr(a));
   inc(k);

   if not(eof(f7)) then
     begin

      j:=8;
      for i:=0 to 7 do
       begin
        seek(f7,i+8*k1);
        blockread(f7,buf,1);
        x[j]:=strtoint(buf);
        dec(j);
       end;

      ///////////////////////////
      a:=0;
      for i:=1 to 8 do
       a:=a + x[i]* MyPower(2,(i-1));

      write(f2,chr(a));
      inc(k1);

      if not(eof(f8)) then
       begin

         j:=8;
         for i:=0 to 7 do
           begin
            seek(f8,i+8*k2);
            blockread(f8,buf,1);
            x[j]:=strtoint(buf);
            dec(j);
           end;

         ///////////////////////////
         a:=0;
         for i:=1 to 8 do
           a:=a + x[i]* MyPower(2,(i-1));

         write(f2,chr(a));
         inc(k2);

         if not(eof(f9)) then
          begin

           j:=8;
           for i:=0 to 7 do
             begin
              seek(f9,i+8*k3);
              blockread(f9,buf,1);
              x[j]:=strtoint(buf);
              dec(j);
             end;

           ///////////////////////////
           a:=0;
           for i:=1 to 8 do
             a:=a + x[i]* MyPower(2,(i-1));

           write(f2,chr(a));
           inc(k3);

          end; // end of if f9 or 5

       end; // end of if f8 or 4

     end; // end of if f7 or 3

  end; // end of while f3 or 2

 closefile(f2);
 closefile(f3);
 closefile(f7);
 closefile(f8);
 closefile(f9);

end;
/////////////////////////////////////////////
procedure TForm5.Button3Click(Sender: TObject);
var i:integer;
    s,s1,s2,s3,s4,s5:string;
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

 assignfile(f1,'c:\info_level 3.log');
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
     assignfile(f1,'c:\info_level 3.log');
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


 s1:='c'+':\'+ s +'_3.txt';
 s2:='d'+':\'+ s +'_3.txt';
 s3:='e'+':\'+ s +'_3.txt';
 s4:='f'+':\'+ s +'_3.txt';
 s5:='g'+':\'+ s +'_3.txt';
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

 listbox1.DeleteSelected;

end;
///////////////////////////////////////////////////////
procedure TForm5.Button4Click(Sender: TObject);
var s,s1,s2,s3,s4,s5:string;
    f3,f7,f8,f9:file;
    f2:textfile;
    i,pos1,pos2,pos3,pos4:integer;
    buf:char;

begin
 i:=listbox1.ItemIndex;
 if i<>-1 then
   s:=listbox1.Items[i]
 else
   begin
     MessageDlg('File not selected .', mtWarning ,[mbOk], 0);
     exit;
   end;

 s1:='c'+':\'+ s +'_3.txt';
 s2:='d'+':\'+ s +'_3.txt';
 s3:='e'+':\'+ s +'_3.txt';
 s4:='f'+':\'+ s +'_3.txt';
 s5:='g'+':\'+ s +'_3.txt';
////////////////////////////////////////////
 if not(fileexists(s1)) and (fileexists(s2))
    and (fileexists(s3)) and (fileexists(s4))
    and (fileexists(s5)) then
  begin
   assignfile(f2,s1);
   rewrite(f2);
   append(f2);

   assignfile(f3,s5);
   reset(f3,1);
   assignfile(f7,s2);
   reset(f7,1);
   assignfile(f8,s3);
   reset(f8,1);
   assignfile(f9,s4);
   reset(f9,1);

   pos1:=0;
   pos2:=0;
   pos3:=0;
   pos4:=0;
   for i:=1 to 5 do
    x[i]:=0;

   while not(eof(f3)) do
    begin
     i:=1;
     seek(f3,pos1);
     inc(pos1);
     blockread(f3,buf,1);
     x[i]:=strtoint(buf);
     inc(i);
     ///////////////////////////
     if not(eof(f7)) then
      begin
       seek(f7,pos2);
       inc(pos2);
       blockread(f7,buf,1);
       x[i]:=strtoint(buf);
       inc(i);
       ///////////////////////////
       if not(eof(f8)) then
        begin
         seek(f8,pos3);
         inc(pos3);
         blockread(f8,buf,1);
         x[i]:=strtoint(buf);
         inc(i);
         ///////////////////////////
         if not(eof(f9)) then
           begin
            seek(f9,pos4);
            inc(pos4);
            blockread(f9,buf,1);
            x[i]:=strtoint(buf);
           end; // end of if f9 or file 4
        end; // end of if f8 or file 3
      end; // end of if f7 or file 2
     x[5]:=x[1] xor x[2] xor x[3] xor x[4];
     write(f2,x[5]);
   end; // end of while f3 or file 1

   closefile(f2);
   closefile(f3);
   closefile(f7);
   closefile(f8);
   closefile(f9);
   exit;
  end; // end of if
 /////////////////////////////////////////
 if not(fileexists(s2)) and (fileexists(s1))
    and (fileexists(s3)) and (fileexists(s4))
    and (fileexists(s5)) then
  begin
   assignfile(f2,s2);
   rewrite(f2);
   append(f2);

   assignfile(f3,s5);
   reset(f3,1);
   assignfile(f7,s1);
   reset(f7,1);
   assignfile(f8,s3);
   reset(f8,1);
   assignfile(f9,s4);
   reset(f9,1);

   pos1:=0;
   pos2:=0;
   pos3:=0;
   pos4:=0;
   for i:=1 to 5 do
    x[i]:=0;

   while not(eof(f3)) do
    begin
     i:=1;
     seek(f3,pos1);
     inc(pos1);
     blockread(f3,buf,1);
     x[i]:=strtoint(buf);
     inc(i);
     ///////////////////////////
     if not(eof(f7)) then
      begin
       seek(f7,pos2);
       inc(pos2);
       blockread(f7,buf,1);
       x[i]:=strtoint(buf);
       inc(i);
       ///////////////////////////
       if not(eof(f8)) then
        begin
         seek(f8,pos3);
         inc(pos3);
         blockread(f8,buf,1);
         x[i]:=strtoint(buf);
         inc(i);
         ///////////////////////////
         if not(eof(f9)) then
           begin
            seek(f9,pos4);
            inc(pos4);
            blockread(f9,buf,1);
            x[i]:=strtoint(buf);
           end; // end of if f9 or file 4
        end; // end of if f8 or file 3
      end; // end of if f7 or file 2
     x[5]:=x[1] xor x[2] xor x[3] xor x[4];
     write(f2,x[5]);
   end; // end of while f3 or file 1

   closefile(f2);
   closefile(f3);
   closefile(f7);
   closefile(f8);
   closefile(f9);
   exit;
  end; // end of if
 /////////////////////////////////////////
 if not(fileexists(s3)) and (fileexists(s2))
    and (fileexists(s1)) and (fileexists(s4))
    and (fileexists(s5)) then
  begin
   assignfile(f2,s3);
   rewrite(f2);
   append(f2);

   assignfile(f3,s5);
   reset(f3,1);
   assignfile(f7,s2);
   reset(f7,1);
   assignfile(f8,s1);
   reset(f8,1);
   assignfile(f9,s4);
   reset(f9,1);

   pos1:=0;
   pos2:=0;
   pos3:=0;
   pos4:=0;
   for i:=1 to 5 do
    x[i]:=0;

   while not(eof(f3)) do
    begin
     i:=1;
     seek(f3,pos1);
     inc(pos1);
     blockread(f3,buf,1);
     x[i]:=strtoint(buf);
     inc(i);
     ///////////////////////////
     if not(eof(f7)) then
      begin
       seek(f7,pos2);
       inc(pos2);
       blockread(f7,buf,1);
       x[i]:=strtoint(buf);
       inc(i);
       ///////////////////////////
       if not(eof(f8)) then
        begin
         seek(f8,pos3);
         inc(pos3);
         blockread(f8,buf,1);
         x[i]:=strtoint(buf);
         inc(i);
         ///////////////////////////
         if not(eof(f9)) then
           begin
            seek(f9,pos4);
            inc(pos4);
            blockread(f9,buf,1);
            x[i]:=strtoint(buf);
           end; // end of if f9 or file 4
        end; // end of if f8 or file 3
      end; // end of if f7 or file 2
     x[5]:=x[1] xor x[2] xor x[3] xor x[4];
     write(f2,x[5]);
   end; // end of while f3 or file 1

   closefile(f2);
   closefile(f3);
   closefile(f7);
   closefile(f8);
   closefile(f9);
   exit;
  end; // end of if
 /////////////////////////////////////////
 if not(fileexists(s4)) and (fileexists(s2))
    and (fileexists(s3)) and (fileexists(s1))
    and (fileexists(s5)) then
  begin
   assignfile(f2,s4);
   rewrite(f2);
   append(f2);

   assignfile(f3,s5);
   reset(f3,1);
   assignfile(f7,s2);
   reset(f7,1);
   assignfile(f8,s3);
   reset(f8,1);
   assignfile(f9,s1);
   reset(f9,1);

   pos1:=0;
   pos2:=0;
   pos3:=0;
   pos4:=0;
   for i:=1 to 5 do
    x[i]:=0;

   while not(eof(f3)) do
    begin
     i:=1;
     seek(f3,pos1);
     inc(pos1);
     blockread(f3,buf,1);
     x[i]:=strtoint(buf);
     inc(i);
     ///////////////////////////
     if not(eof(f7)) then
      begin
       seek(f7,pos2);
       inc(pos2);
       blockread(f7,buf,1);
       x[i]:=strtoint(buf);
       inc(i);
       ///////////////////////////
       if not(eof(f8)) then
        begin
         seek(f8,pos3);
         inc(pos3);
         blockread(f8,buf,1);
         x[i]:=strtoint(buf);
         inc(i);
         ///////////////////////////
         if not(eof(f9)) then
           begin
            seek(f9,pos4);
            inc(pos4);
            blockread(f9,buf,1);
            x[i]:=strtoint(buf);
           end; // end of if f9 or file 4
        end; // end of if f8 or file 3
      end; // end of if f7 or file 2
     x[5]:=x[1] xor x[2] xor x[3] xor x[4];
     write(f2,x[5]);
   end; // end of while f3 or file 1

   closefile(f2);
   closefile(f3);
   closefile(f7);
   closefile(f8);
   closefile(f9);
   exit;
  end; // end of if
 /////////////////////////////////////////
 if not(fileexists(s5)) and (fileexists(s2))
    and (fileexists(s3)) and (fileexists(s4))
    and (fileexists(s1)) then
  begin
   assignfile(f2,s5);
   rewrite(f2);
   append(f2);

   assignfile(f3,s1);
   reset(f3,1);
   assignfile(f7,s2);
   reset(f7,1);
   assignfile(f8,s3);
   reset(f8,1);
   assignfile(f9,s4);
   reset(f9,1);

   pos1:=0;
   pos2:=0;
   pos3:=0;
   pos4:=0;
   for i:=1 to 5 do
    x[i]:=0;

   while not(eof(f3)) do
    begin
     i:=1;
     seek(f3,pos1);
     inc(pos1);
     blockread(f3,buf,1);
     x[i]:=strtoint(buf);
     inc(i);
     ///////////////////////////
     if not(eof(f7)) then
      begin
       seek(f7,pos2);
       inc(pos2);
       blockread(f7,buf,1);
       x[i]:=strtoint(buf);
       inc(i);
       ///////////////////////////
       if not(eof(f8)) then
        begin
         seek(f8,pos3);
         inc(pos3);
         blockread(f8,buf,1);
         x[i]:=strtoint(buf);
         inc(i);
         ///////////////////////////
         if not(eof(f9)) then
           begin
            seek(f9,pos4);
            inc(pos4);
            blockread(f9,buf,1);
            x[i]:=strtoint(buf);
           end; // end of if f9 or file 4
        end; // end of if f8 or file 3
      end; // end of if f7 or file 2
     x[5]:=x[1] xor x[2] xor x[3] xor x[4];
     write(f2,x[5]);
   end; // end of while f3 or file 1

   closefile(f2);
   closefile(f3);
   closefile(f7);
   closefile(f8);
   closefile(f9);
   exit;
  end; // end of if
 /////////////////////////////////////////
 if not(fileexists(s1)) or not(fileexists(s2))
    or not(fileexists(s3)) or not(fileexists(s4))
    or not(fileexists(s5)) then
   begin
     MessageDlg('Two or more disks has been failed , So all data loses .', mtWarning ,[mbOk], 0);
     exit;
   end
 else
   begin
     MessageDlg('All disks is healthy .', mtInformation ,[mbOk], 0);
     exit;
   end;

end;
//////////////////////////////////////////////////////
procedure TForm5.RadioButton2Click(Sender: TObject);
begin
 button4.Visible:=true;
 button4.Top:=336;
 button4.Left:=400;
 button3.Top:=336;
 button3.Left:=312;
end;
//////////////////////////////////////////////////////
procedure TForm5.RadioButton1Click(Sender: TObject);
begin
 button4.Visible:=false;
 button3.Top:=312;
 button3.Left:=360;
end;
//////////////////////////////////////////////////////
procedure TForm5.FormShow(Sender: TObject);
var f:textfile;
    s:string;
begin
 listbox1.Clear;
 if not fileexists('c:\info_level 3.log') then
   exit;
 assignfile(f,'c:\info_level 3.log');
 reset(f);
 while not(eof(f)) do
  begin
   readln(f,s);
   listbox1.AddItem(s,sender);
  end;
 closefile(f);
end;

end.
