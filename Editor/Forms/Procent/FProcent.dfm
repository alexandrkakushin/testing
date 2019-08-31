object fmProcent: TfmProcent
  Left = 933
  Top = 467
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1088#1080#1090#1077#1088#1080#1080' '#1074#1099#1089#1090#1072#1074#1083#1077#1085#1080#1103' '#1086#1094#1077#1085#1086#1082
  ClientHeight = 258
  ClientWidth = 338
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbParametr: TGroupBox
    Left = 8
    Top = 8
    Width = 321
    Height = 201
    Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1077' '#1082#1088#1080#1090#1077#1088#1080#1080
    TabOrder = 0
    object Label1: TLabel
      Left = 56
      Top = 40
      Width = 13
      Height = 13
      Caption = #1054#1090
    end
    object Label2: TLabel
      Left = 192
      Top = 40
      Width = 15
      Height = 13
      Caption = #1044#1086
    end
    object Label9: TLabel
      Left = 152
      Top = 40
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label10: TLabel
      Left = 288
      Top = 40
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label3: TLabel
      Left = 56
      Top = 80
      Width = 13
      Height = 13
      Caption = #1054#1090
    end
    object Label4: TLabel
      Left = 152
      Top = 80
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label5: TLabel
      Left = 192
      Top = 80
      Width = 15
      Height = 13
      Caption = #1044#1086
    end
    object Label6: TLabel
      Left = 288
      Top = 80
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label7: TLabel
      Left = 56
      Top = 120
      Width = 13
      Height = 13
      Caption = #1054#1090
    end
    object Label8: TLabel
      Left = 152
      Top = 120
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label11: TLabel
      Left = 192
      Top = 120
      Width = 15
      Height = 13
      Caption = #1044#1086
    end
    object Label12: TLabel
      Left = 288
      Top = 120
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Label15: TLabel
      Left = 56
      Top = 160
      Width = 15
      Height = 13
      Caption = #1044#1086
    end
    object Label16: TLabel
      Left = 152
      Top = 160
      Width = 8
      Height = 13
      Caption = '%'
    end
    object Panel1: TPanel
      Left = 16
      Top = 32
      Width = 33
      Height = 33
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = '5'
      TabOrder = 0
    end
    object edt5min: TEdit
      Left = 80
      Top = 36
      Width = 65
      Height = 21
      BevelKind = bkFlat
      TabOrder = 1
      OnKeyPress = edtKeyPress
    end
    object edt5max: TEdit
      Left = 216
      Top = 36
      Width = 65
      Height = 21
      BevelKind = bkFlat
      TabOrder = 2
      OnKeyPress = edtKeyPress
    end
    object Panel2: TPanel
      Left = 16
      Top = 72
      Width = 33
      Height = 33
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = '4'
      TabOrder = 3
    end
    object Panel3: TPanel
      Left = 16
      Top = 112
      Width = 33
      Height = 33
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = '3'
      TabOrder = 4
    end
    object Panel4: TPanel
      Left = 16
      Top = 152
      Width = 33
      Height = 33
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = '2'
      TabOrder = 5
    end
    object edt4min: TEdit
      Left = 80
      Top = 76
      Width = 65
      Height = 21
      BevelKind = bkFlat
      TabOrder = 6
      OnKeyPress = edtKeyPress
    end
    object edt4max: TEdit
      Left = 216
      Top = 76
      Width = 65
      Height = 21
      BevelKind = bkFlat
      TabOrder = 7
      OnKeyPress = edtKeyPress
    end
    object edt3min: TEdit
      Left = 80
      Top = 116
      Width = 65
      Height = 21
      BevelKind = bkFlat
      TabOrder = 8
      OnKeyPress = edtKeyPress
    end
    object edt3max: TEdit
      Left = 216
      Top = 116
      Width = 65
      Height = 21
      BevelKind = bkFlat
      TabOrder = 9
      OnKeyPress = edtKeyPress
    end
    object edt2max: TEdit
      Left = 80
      Top = 156
      Width = 65
      Height = 21
      BevelKind = bkFlat
      TabOrder = 10
      OnKeyPress = edtKeyPress
    end
  end
  object btnOk: TBitBtn
    Left = 128
    Top = 224
    Width = 89
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TBitBtn
    Left = 232
    Top = 224
    Width = 91
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
