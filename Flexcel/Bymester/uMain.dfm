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
  TextHeight = 15
  object btnOpenEntries: TButton
    Left = 32
    Top = 40
    Width = 97
    Height = 25
    Caption = 'Open entries'
    TabOrder = 0
    OnClick = btnOpenEntriesClick
  end
  object btnOpenScoresheet: TButton
    Left = 32
    Top = 80
    Width = 97
    Height = 25
    Caption = 'Open Scoresheet'
    TabOrder = 1
    OnClick = btnOpenScoresheetClick
  end
  object edDate: TEdit
    Left = 64
    Top = 120
    Width = 121
    Height = 23
    TabOrder = 2
    Text = '06-11-2022'
    TextHint = 'Dato'
  end
  object edRoundNo: TEdit
    Left = 64
    Top = 160
    Width = 121
    Height = 23
    TabOrder = 3
    Text = '1'
    TextHint = 'Rundenr'
  end
  object btnMerge: TButton
    Left = 32
    Top = 200
    Width = 97
    Height = 25
    Caption = 'Merge'
    TabOrder = 4
    OnClick = btnMergeClick
  end
  object btnArcherID: TButton
    Left = 280
    Top = 80
    Width = 105
    Height = 25
    Caption = 'Open ArcherID'
    TabOrder = 5
    OnClick = btnArcherIDClick
  end
  object edText1: TEdit
    Left = 304
    Top = 120
    Width = 121
    Height = 23
    TabOrder = 6
    Text = 'Odense Mesterskab'
    TextHint = 'Text1'
  end
  object edText2: TEdit
    Left = 304
    Top = 160
    Width = 121
    Height = 23
    TabOrder = 7
    Text = '06-11-2022'
    TextHint = 'Text2'
  end
  object btnMergeID: TButton
    Left = 280
    Top = 200
    Width = 105
    Height = 25
    Caption = 'Merge ID'
    TabOrder = 8
    OnClick = btnMergeIDClick
  end
  object od: TOpenDialog
    Left = 232
    Top = 48
  end
  object SD: TSaveDialog
    Left = 208
    Top = 152
  end
end
