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
  OnDestroy = FormDestroy
  TextHeight = 15
  object lblValue: TLabel
    Left = 96
    Top = 104
    Width = 192
    Height = 86
    Caption = '-- -- --'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object btnStart: TButton
    Left = 96
    Top = 48
    Width = 75
    Height = 25
    Caption = 'START'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 213
    Top = 48
    Width = 75
    Height = 25
    Caption = 'STOP'
    TabOrder = 1
    OnClick = btnStopClick
  end
end
