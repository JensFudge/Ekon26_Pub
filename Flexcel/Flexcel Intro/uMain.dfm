object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 243
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object btnCreateFile: TButton
    Left = 32
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Create File'
    TabOrder = 0
    OnClick = btnCreateFileClick
  end
  object btnAddSheet: TButton
    Left = 32
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Add Sheet'
    TabOrder = 1
    OnClick = btnAddSheetClick
  end
  object btnRead: TButton
    Left = 32
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Read'
    TabOrder = 2
    OnClick = btnReadClick
  end
  object btnColumnWidth: TButton
    Left = 144
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Col Width'
    TabOrder = 3
    OnClick = btnColumnWidthClick
  end
  object btnAutofit: TButton
    Left = 144
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Autofit'
    TabOrder = 4
    OnClick = btnAutofitClick
  end
  object btnFormat: TButton
    Left = 144
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Format'
    TabOrder = 5
    OnClick = btnFormatClick
  end
  object btnFreeze: TButton
    Left = 256
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Freeze'
    TabOrder = 6
    OnClick = btnFreezeClick
  end
end
