unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Unit11;

type
  TForm7 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
  private
    { Private declarations }
    MyThread1 : TThread5; // thread number 1
    MyThread2 : TThread5; // thread number 2
    MyThread3 : TThread5; // thread number 3
    MyThread4 : TThread5; // thread number 4
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
    pos1_5,pos2_5,pos3_5,pos4_5:longint;
    s1_5,s2_5,s3_5,s4_5:string;
    sf_5:file of byte;
    flag_5:byte;
  end;

var
  Form7: TForm7;
  x:array[1..8] of byte;
implementation

uses Unit8;

{$R *.dfm}
/////////////// Create Thread 1 ////////////////
procedure TForm7.CreateThread1;
begin
   if (MyThread1 = nil) or (Thread1Active = false) then
   begin
     MyThread1 := TThread5.CreateIt(5,s1_5,pos1_5);
     Thread1Active := true;
   end;
end;
/////////////// Create Thread 2 /////////////////
procedure TForm7.CreateThread2;
begin
   if (MyThread2 = nil) or (Thread2Active = false) then
   begin
     MyThread2 := TThread5.CreateIt(5,s2_5,pos2_5);
     Thread2Active := true;
   end;
end;
/////////////// Create Thread 3 ////////////////
procedure TForm7.CreateThread3;
begin
   if (MyThread3 = nil) or (Thread3Active = false) then
   begin
     MyThread3 := TThread5.CreateIt(5,s3_5,pos3_5);
     Thread3Active := true;
   end;
end;
/////////////// Create Thread 4 /////////////////
procedure TForm7.CreateThread4;
begin
   if (MyThread4 = nil) or (Thread4Active = false) then
   begin
     MyThread4 := TThread5.CreateIt(5,s4_5,pos4_5);
     Thread4Active := true;
   end;
end;
/////////////////////////////////////////////
procedure TForm7.Button1Click(Sender: TObject);
var f1:file of byte;
    f,f2,f3,f4,f5,f6:textfile;
    pos:longint;
    i,j,l,select_file:integer;
    s,s1,s2,s3,s4,s5:string;
begin
 if opendialog1.Execute then
  begin
   assignfile(f1,opendialog1.FileName);
   reset(f1);
   if filesize(f1)=0 then
     begin
      MessageDlg('This file is empty.', mtInformation,[mbOk], 0);
      exit;
     end;
   form7.Refresh;
   s:=opendialog1.FileName;
   l:=length(s);
   for i:=l downto 1 do
     if s[i]='\' then
       break;

   for j:=i+1 to l do
      s1:=s1+s[j];

   s:='';
   s:=s1;

   if fileexists('c:\info_level 5.log') then
     begin
       assignfile(f,'c:\info_level 5.log');
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

   s1:='c'+':\'+ s +'_5.txt';
   s2:='d'+':\'+ s +'_5.txt';
   s3:='e'+':\'+ s +'_5.txt';
   s4:='f'+':\'+ s +'_5.txt';
   s5:='g'+':\'+ s +'_5.txt';

   listbox1.AddItem(s,sender);

   assignfile(f,'c:\info_level 5.log');
   if not fileexists('c:\info_level 5.log') then
     rewrite(f);
   append(f);
   writeln(f,s);
   closefile(f);

   assignfile(f2,s1);
   rewrite(f2);
   append(f2);

   assignfile(f3,s2);
   rewrite(f3);
   append(f3);

   assignfile(f4,s3);
   rewrite(f4);
   append(f4);

   assignfile(f5,s4);
   rewrite(f5);
   append(f5);

   assignfile(f6,s5);
   rewrite(f6);
   append(f6);

  end
 else
   exit;

 pos:=0;
 select_file:=0;
 for i:=1 to 5 do
  x[i]:=0;

 while not(eof(f1)) do
  begin
    for i:=1 to 4 do
      if not(eof(f1)) then
        begin
         seek(f1,pos);
         read(f1,x[i]);
         inc(pos);
        end;
    x[5]:=x[1] xor x[2] xor x[3] xor x[4];
    case (select_file mod 5) of
      0:begin
          write(f2,chr(x[1]));
          write(f3,chr(x[2]));
          write(f4,chr(x[3]));
          write(f5,chr(x[4]));
          write(f6,chr(x[5]));
        end;
      1:begin
          write(f2,chr(x[1]));
          write(f3,chr(x[2]));
          write(f4,chr(x[3]));
          write(f5,chr(x[5]));
          write(f6,chr(x[4]));
        end;
      2:begin
          write(f2,chr(x[1]));
          write(f3,chr(x[2]));
          write(f4,chr(x[5]));
          write(f5,chr(x[3]));
          write(f6,chr(x[4]));
        end;
      3:begin
          write(f2,chr(x[1]));
          write(f3,chr(x[5]));
          write(f4,chr(x[2]));
          write(f5,chr(x[3]));
          write(f6,chr(x[4]));
        end;
      4:begin
          write(f2,chr(x[5]));
          write(f3,chr(x[1]));
          write(f4,chr(x[2]));
          write(f5,chr(x[3]));
          write(f6,chr(x[4]));
        end;
    end; // end of case

    for i:=1 to 5 do
      x[i]:=0;

    inc(select_file);
  end; // end of while

 closefile(f1);
 closefile(f2);
 closefile(f3);
 closefile(f4);
 closefile(f5);
 closefile(f6);

end;
/////////////////////////////////////////////
procedure TForm7.Button2Click(Sender: TObject);
var ext,s,s1,s2,s3,s4,s5:string;
    f3,f7,f8,f9,f10:file of byte;
    f2:textfile;
    i,j,l,pos1,pos2,pos3,pos4,pos5,select_file:integer;
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

 s1:='c'+':\'+ s +'_5.txt';
 s2:='d'+':\'+ s +'_5.txt';
 s3:='e'+':\'+ s +'_5.txt';
 s4:='f'+':\'+ s +'_5.txt';
 s5:='g'+':\'+ s +'_5.txt';
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
        for i:=1 to 5 do
          x[i]:=0;

        while not(eof(f3)) do
         begin
          i:=1;
          seek(f3,pos1);
          inc(pos1);
          read(f3,a);
          x[i]:=a;
          inc(i);
          ///////////////////////////
          if not(eof(f7)) then
           begin
            seek(f7,pos2);
            inc(pos2);
            read(f7,a);
            x[i]:=a;
            inc(i);
            ///////////////////////////
            if not(eof(f8)) then
             begin
              seek(f8,pos3);
              inc(pos3);
              read(f8,a);
              x[i]:=a;
              inc(i);
              ///////////////////////////
              if not(eof(f9)) then
                begin
                  seek(f9,pos4);
                  inc(pos4);
                  read(f9,a);
                  x[i]:=a;
                end; // end of if f9 or file 4
             end; // end of if f8 or file 3
           end; // end of if f7 or file 2
          x[5]:=x[1] xor x[2] xor x[3] xor x[4];
          write(f2,chr(x[5]));
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
        reset(f3);
        assignfile(f7,s1);
        reset(f7);
        assignfile(f8,s3);
        reset(f8);
        assignfile(f9,s4);
        reset(f9);

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
          read(f3,a);
          x[i]:=a;
          inc(i);
          ///////////////////////////
          if not(eof(f7)) then
           begin
            seek(f7,pos2);
            inc(pos2);
            read(f7,a);
            x[i]:=a;
            inc(i);
            ///////////////////////////
            if not(eof(f8)) then
             begin
              seek(f8,pos3);
              inc(pos3);
              read(f8,a);
              x[i]:=a;
              inc(i);
              ///////////////////////////
              if not(eof(f9)) then
                begin
                  seek(f9,pos4);
                  inc(pos4);
                  read(f9,a);
                  x[i]:=a;
                end; // end of if f9 or file 4
             end; // end of if f8 or file 3
           end; // end of if f7 or file 2
          x[5]:=x[1] xor x[2] xor x[3] xor x[4];
          write(f2,chr(x[5]));
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
        reset(f3);
        assignfile(f7,s2);
        reset(f7);
        assignfile(f8,s1);
        reset(f8);
        assignfile(f9,s4);
        reset(f9);

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
          read(f3,a);
          x[i]:=a;
          inc(i);
          ///////////////////////////
          if not(eof(f7)) then
           begin
            seek(f7,pos2);
            inc(pos2);
            read(f7,a);
            x[i]:=a;
            inc(i);
            ///////////////////////////
            if not(eof(f8)) then
             begin
              seek(f8,pos3);
              inc(pos3);
              read(f8,a);
              x[i]:=a;
              inc(i);
              ///////////////////////////
              if not(eof(f9)) then
                begin
                  seek(f9,pos4);
                  inc(pos4);
                  read(f9,a);
                  x[i]:=a;
                end; // end of if f9 or file 4
             end; // end of if f8 or file 3
           end; // end of if f7 or file 2
          x[5]:=x[1] xor x[2] xor x[3] xor x[4];
          write(f2,chr(x[5]));
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
        reset(f3);
        assignfile(f7,s2);
        reset(f7);
        assignfile(f8,s3);
        reset(f8);
        assignfile(f9,s1);
        reset(f9);

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
          read(f3,a);
          x[i]:=a;
          inc(i);
          ///////////////////////////
          if not(eof(f7)) then
           begin
            seek(f7,pos2);
            inc(pos2);
            read(f7,a);
            x[i]:=a;
            inc(i);
            ///////////////////////////
            if not(eof(f8)) then
             begin
              seek(f8,pos3);
              inc(pos3);
              read(f8,a);
              x[i]:=a;
              inc(i);
              ///////////////////////////
              if not(eof(f9)) then
                begin
                  seek(f9,pos4);
                  inc(pos4);
                  read(f9,a);
                  x[i]:=a;
                end; // end of if f9 or file 4
             end; // end of if f8 or file 3
           end; // end of if f7 or file 2
          x[5]:=x[1] xor x[2] xor x[3] xor x[4];
          write(f2,chr(x[5]));
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
        for i:=1 to 5 do
          x[i]:=0;

        while not(eof(f3)) do
         begin
          i:=1;
          seek(f3,pos1);
          inc(pos1);
          read(f3,a);
          x[i]:=a;
          inc(i);
          ///////////////////////////
          if not(eof(f7)) then
           begin
            seek(f7,pos2);
            inc(pos2);
            read(f7,a);
            x[i]:=a;
            inc(i);
            ///////////////////////////
            if not(eof(f8)) then
             begin
              seek(f8,pos3);
              inc(pos3);
              read(f8,a);
              x[i]:=a;
              inc(i);
              ///////////////////////////
              if not(eof(f9)) then
                begin
                  seek(f9,pos4);
                  inc(pos4);
                  read(f9,a);
                  x[i]:=a;
                end; // end of if f9 or file 4
             end; // end of if f8 or file 3
           end; // end of if f7 or file 2
          x[5]:=x[1] xor x[2] xor x[3] xor x[4];
          write(f2,chr(x[5]));
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

 form7.Refresh;

 assignfile(f3,s1);
 reset(f3);
 assignfile(f7,s2);
 reset(f7);
 assignfile(f8,s3);
 reset(f8);
 assignfile(f9,s4);
 reset(f9);
 assignfile(f10,s5);
 reset(f10);

 pos1:=0;
 pos2:=0;
 pos3:=0;
 pos4:=0;
 pos5:=0;
 select_file:=0;

 while not(eof(f3)) do
  begin

    if (select_file mod 5 <> 4) then
      begin
       seek(f3,pos1);
       if not(eof(f3)) then
        begin
         read(f3,a);
         write(f2,chr(a));
        end; 
      end;
    inc(pos1);
    ///////////////////////////
    if not(eof(f7)) then
      begin
       if (select_file mod 5 <> 3) then
        begin
         seek(f7,pos2);
         read(f7,a);
         write(f2,chr(a));
        end;
       inc(pos2);
       ///////////////////////////
       if not(eof(f8)) then
         begin
          if (select_file mod 5 <> 2) then
           begin
            seek(f8,pos3);
            read(f8,a);
            write(f2,chr(a));
           end;
           inc(pos3);
          ///////////////////////////
          if not(eof(f9)) then
            begin
             if (select_file mod 5 <> 1) then
              begin
               seek(f9,pos4);
               read(f9,a);
               write(f2,chr(a));
              end;
             inc(pos4);
             ///////////////////////////
             if not(eof(f10)) then
               begin
                if (select_file mod 5 <> 0) then
                 begin
                  seek(f10,pos5);
                  read(f10,a);
                  write(f2,chr(a));
                 end;
                inc(pos5);
               end; // end of if f10 or file 5
            end; // end of if f9 or file 4
         end; // end of if f8 or file 3
      end; // end of if f7 or file 2
   inc(select_file);
  end; // end of while f3 or file 1

 closefile(f2);
 closefile(f3);
 closefile(f7);
 closefile(f8);
 closefile(f9);
 closefile(f10);

end;
/////////////////////////////////////////////
procedure TForm7.Button3Click(Sender: TObject);
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

 assignfile(f1,'c:\info_level 5.log');
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
     assignfile(f1,'c:\info_level 5.log');
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


 s1:='c'+':\'+ s +'_5.txt';
 s2:='d'+':\'+ s +'_5.txt';
 s3:='e'+':\'+ s +'_5.txt';
 s4:='f'+':\'+ s +'_5.txt';
 s5:='g'+':\'+ s +'_5.txt';
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
procedure TForm7.Button4Click(Sender: TObject);
var s,s1,s2,s3,s4,s5:string;
    f3,f7,f8,f9:file of byte;
    f2:textfile;
    i,pos1,pos2,pos3,pos4:integer;
begin
 i:=listbox1.ItemIndex;
 if i<>-1 then
   s:=listbox1.Items[i]
 else
   begin
     MessageDlg('File not selected .', mtWarning ,[mbOk], 0);
     exit;
   end;

 s1:='c'+':\'+ s +'_5.txt';
 s2:='d'+':\'+ s +'_5.txt';
 s3:='e'+':\'+ s +'_5.txt';
 s4:='f'+':\'+ s +'_5.txt';
 s5:='g'+':\'+ s +'_5.txt';
////////////////////////////////////////////
 if not(fileexists(s1)) and (fileexists(s2))
    and (fileexists(s3)) and (fileexists(s4))
    and (fileexists(s5)) then
  begin
   assignfile(f2,s1);
   rewrite(f2);
   append(f2);

   assignfile(f3,s5);
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
   for i:=1 to 5 do
    x[i]:=0;

   while not(eof(f3)) do
    begin
     i:=1;
     seek(f3,pos1);
     inc(pos1);
     read(f3,x[i]);
     inc(i);
     ///////////////////////////
     if not(eof(f7)) then
      begin
       seek(f7,pos2);
       inc(pos2);
       read(f7,x[i]);
       inc(i);
       ///////////////////////////
       if not(eof(f8)) then
        begin
         seek(f8,pos3);
         inc(pos3);
         read(f8,x[i]);
         inc(i);
         ///////////////////////////
         if not(eof(f9)) then
           begin
            seek(f9,pos4);
            inc(pos4);
            read(f9,x[i]);
           end; // end of if f9 or file 4
        end; // end of if f8 or file 3
      end; // end of if f7 or file 2
     x[5]:=x[1] xor x[2] xor x[3] xor x[4];
     write(f2,chr(x[5]));
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
   reset(f3);
   assignfile(f7,s1);
   reset(f7);
   assignfile(f8,s3);
   reset(f8);
   assignfile(f9,s4);
   reset(f9);

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
     read(f3,x[i]);
     inc(i);
     ///////////////////////////
     if not(eof(f7)) then
      begin
       seek(f7,pos2);
       inc(pos2);
       read(f7,x[i]);
       inc(i);
       ///////////////////////////
       if not(eof(f8)) then
        begin
         seek(f8,pos3);
         inc(pos3);
         read(f8,x[i]);
         inc(i);
         ///////////////////////////
         if not(eof(f9)) then
           begin
            seek(f9,pos4);
            inc(pos4);
            read(f9,x[i]);
           end; // end of if f9 or file 4
        end; // end of if f8 or file 3
      end; // end of if f7 or file 2
     x[5]:=x[1] xor x[2] xor x[3] xor x[4];
     write(f2,chr(x[5]));
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
   reset(f3);
   assignfile(f7,s2);
   reset(f7);
   assignfile(f8,s1);
   reset(f8);
   assignfile(f9,s4);
   reset(f9);

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
     read(f3,x[i]);
     inc(i);
     ///////////////////////////
     if not(eof(f7)) then
      begin
       seek(f7,pos2);
       inc(pos2);
       read(f7,x[i]);
       inc(i);
       ///////////////////////////
       if not(eof(f8)) then
        begin
         seek(f8,pos3);
         inc(pos3);
         read(f8,x[i]);
         inc(i);
         ///////////////////////////
         if not(eof(f9)) then
           begin
            seek(f9,pos4);
            inc(pos4);
            read(f9,x[i]);
           end; // end of if f9 or file 4
        end; // end of if f8 or file 3
      end; // end of if f7 or file 2
     x[5]:=x[1] xor x[2] xor x[3] xor x[4];
     write(f2,chr(x[5]));
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
   reset(f3);
   assignfile(f7,s2);
   reset(f7);
   assignfile(f8,s3);
   reset(f8);
   assignfile(f9,s1);
   reset(f9);

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
     read(f3,x[i]);
     inc(i);
     ///////////////////////////
     if not(eof(f7)) then
      begin
       seek(f7,pos2);
       inc(pos2);
       read(f7,x[i]);
       inc(i);
       ///////////////////////////
       if not(eof(f8)) then
        begin
         seek(f8,pos3);
         inc(pos3);
         read(f8,x[i]);
         inc(i);
         ///////////////////////////
         if not(eof(f9)) then
           begin
            seek(f9,pos4);
            inc(pos4);
            read(f9,x[i]);
           end; // end of if f9 or file 4
        end; // end of if f8 or file 3
      end; // end of if f7 or file 2
     x[5]:=x[1] xor x[2] xor x[3] xor x[4];
     write(f2,chr(x[5]));
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
   for i:=1 to 5 do
    x[i]:=0;

   while not(eof(f3)) do
    begin
     i:=1;
     seek(f3,pos1);
     inc(pos1);
     read(f3,x[i]);
     inc(i);
     ///////////////////////////
     if not(eof(f7)) then
      begin
       seek(f7,pos2);
       inc(pos2);
       read(f7,x[i]);
       inc(i);
       ///////////////////////////
       if not(eof(f8)) then
        begin
         seek(f8,pos3);
         inc(pos3);
         read(f8,x[i]);
         inc(i);
         ///////////////////////////
         if not(eof(f9)) then
           begin
            seek(f9,pos4);
            inc(pos4);
            read(f9,x[i]);
           end; // end of if f9 or file 4
        end; // end of if f8 or file 3
      end; // end of if f7 or file 2
     x[5]:=x[1] xor x[2] xor x[3] xor x[4];
     write(f2,chr(x[5]));
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
procedure TForm7.RadioButton2Click(Sender: TObject);
begin
 button4.Visible:=true;
 button4.Top:=336;
 button4.Left:=400;
 button3.Top:=336;
 button3.Left:=312;
end;
//////////////////////////////////////////////////////
procedure TForm7.RadioButton1Click(Sender: TObject);
begin
 button4.Visible:=false;
 button3.Top:=312;
 button3.Left:=360;
end;
//////////////////////////////////////////////////////
procedure TForm7.FormShow(Sender: TObject);
var f:textfile;
    s:string;
begin
 listbox1.Clear;
 if not fileexists('c:\info_level 5.log') then
   exit;
 assignfile(f,'c:\info_level 5.log');
 reset(f);
 while not(eof(f)) do
  begin
   readln(f,s);
   listbox1.AddItem(s,sender);
  end;
 closefile(f);
end;
//////////////////////////////////////////////////////

end.
