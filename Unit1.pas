unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList, jpeg;

const
  WM_ThreadDoneMsg = WM_User + 8;

type
  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Button1: TButton;
    Label1: TLabel;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit14;

{$R *.dfm}
////////////////////////////////////////////////
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
 case combobox1.ItemIndex of
  0:begin
     image1.Visible:=true ;

     image2.Visible:=false ;
     image3.Visible:=false ;
     image4.Visible:=false ;
     image5.Visible:=false ;
     image6.Visible:=false ;
    end;
  1:begin
     image2.Visible:=true ;

     image1.Visible:=false ;
     image3.Visible:=false ;
     image4.Visible:=false ;
     image5.Visible:=false ;
     image6.Visible:=false ;
    end;
  2:begin
     image3.Visible:=true ;

     image2.Visible:=false ;
     image1.Visible:=false ;
     image4.Visible:=false ;
     image5.Visible:=false ;
     image6.Visible:=false ;
    end;
  3:begin
     image4.Visible:=true ;

     image2.Visible:=false ;
     image3.Visible:=false ;
     image1.Visible:=false ;
     image5.Visible:=false ;
     image6.Visible:=false ;
    end;
  4:begin
     image5.Visible:=true ;

     image2.Visible:=false ;
     image3.Visible:=false ;
     image4.Visible:=false ;
     image1.Visible:=false ;
     image6.Visible:=false ;
    end;
  5:begin
     image6.Visible:=true ;

     image2.Visible:=false ;
     image3.Visible:=false ;
     image4.Visible:=false ;
     image5.Visible:=false ;
     image1.Visible:=false ;
    end;

 end;

end;
////////////////////////////////////////////////
procedure TForm1.Button1Click(Sender: TObject);
begin
 case combobox1.ItemIndex of
  0:begin
      form2.Show;
    end;
  1:begin
      form3.Show;
    end;
  2:begin
      form4.Show;
    end;
  3:begin
      form5.Show;
    end;
  4:begin
      form6.Show;
    end;
  5:begin
      form7.Show;
    end;

 end; //end of case

end;
////////////////////////////////////////////////
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 form14.Close;
end;

end.
