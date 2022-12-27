object Form3: TForm3
  Left = 192
  Top = 114
  Width = 696
  Height = 480
  Caption = 'Level 1'
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
    Left = 316
    Top = 26
    Width = 163
    Height = 16
    Caption = 'Memory of RAID level 1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 40
    Top = 104
    Width = 193
    Height = 161
    BiDiMode = bdLeftToRight
    Caption = 'Recovery Options'
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentBiDiMode = False
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object RadioButton1: TRadioButton
      Left = 32
      Top = 48
      Width = 113
      Height = 17
      Caption = 'Auto Recovery'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 32
      Top = 96
      Width = 129
      Height = 17
      Caption = 'Manual Recovery'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = RadioButton2Click
    end
  end
  object Button1: TButton
    Left = 312
    Top = 264
    Width = 75
    Height = 25
    Caption = '&Store'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 320
    Top = 48
    Width = 153
    Height = 193
    ItemHeight = 13
    TabOrder = 2
  end
  object Button2: TButton
    Left = 400
    Top = 264
    Width = 75
    Height = 25
    Caption = '&Load'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 360
    Top = 312
    Width = 75
    Height = 25
    Caption = '&Delete'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 536
    Top = 320
    Width = 75
    Height = 25
    Caption = '&Recover'
    TabOrder = 5
    Visible = False
    OnClick = Button4Click
  end
  object OpenDialog1: TOpenDialog
    Title = 'Select file to Store in RAID memory'
    Left = 520
    Top = 216
  end
  object SaveDialog1: TSaveDialog
    Title = 'Load from RAID memory and Store in your disk'
    Left = 568
    Top = 216
  end
end
