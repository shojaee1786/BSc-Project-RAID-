object Form2: TForm2
  Left = 192
  Top = 114
  Width = 696
  Height = 480
  Caption = 'Level 0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 252
    Top = 57
    Width = 163
    Height = 16
    Caption = 'Memory of RAID level 0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 248
    Top = 296
    Width = 75
    Height = 25
    Caption = '&Store'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 256
    Top = 80
    Width = 153
    Height = 193
    ItemHeight = 13
    TabOrder = 3
  end
  object Button2: TButton
    Left = 336
    Top = 296
    Width = 75
    Height = 25
    Caption = '&Load'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 288
    Top = 336
    Width = 75
    Height = 25
    Caption = '&Delete'
    TabOrder = 2
    OnClick = Button3Click
  end
  object OpenDialog1: TOpenDialog
    Title = 'Select file to Store in RAID memory'
    Left = 512
    Top = 248
  end
  object SaveDialog1: TSaveDialog
    Title = 'Load from RAID memory and Store in your disk'
    Left = 560
    Top = 248
  end
end
