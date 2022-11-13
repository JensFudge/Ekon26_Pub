object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object btnDateTime: TButton
    Left = 40
    Top = 40
    Width = 169
    Height = 25
    Caption = 'DateTime Delphi 11'
    TabOrder = 0
    OnClick = btnDateTimeClick
  end
  object mmoDates: TMemo
    Left = 40
    Top = 71
    Width = 169
    Height = 178
    TabOrder = 1
  end
  object btnArcher: TButton
    Left = 232
    Top = 40
    Width = 185
    Height = 25
    Caption = 'Archer'
    TabOrder = 2
    OnClick = btnArcherClick
  end
  object mmoArcher: TMemo
    Left = 232
    Top = 71
    Width = 185
    Height = 178
    TabOrder = 3
  end
end
