object Options: TOptions
  Left = 596
  Top = 273
  HelpContext = 1
  BorderIcons = []
  BorderStyle = bsSingle
  ClientHeight = 438
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = OEM_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormActivate
  DesignSize = (
    404
    438)
  PixelsPerInch = 96
  TextHeight = 14
  object OptionsPageControl: TTntPageControl
    Left = 9
    Top = 17
    Width = 388
    Height = 384
    ActivePage = TabSheetCommon
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = OEM_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabIndex = 0
    TabOrder = 1
    object TabSheetCommon: TTntTabSheet
      Font.Charset = OEM_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      DesignSize = (
        380
        354)
      object Bevel8: TBevel
        Left = 155
        Top = 76
        Width = 38
        Height = 3
        Visible = False
      end
      object CommonChiefInRoom: TTntCheckBox
        Left = 16
        Top = 69
        Width = 140
        Height = 18
        TabStop = False
        BiDiMode = bdLeftToRight
        Color = clBtnFace
        Ctl3D = True
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = CommonChiefInRoomClick
      end
      object CommonShowPCwords: TTntCheckBox
        Left = 16
        Top = 8
        Width = 347
        Height = 19
        TabStop = False
        BiDiMode = bdLeftToRight
        Color = clBtnFace
        Ctl3D = True
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object CommonShowAllUserBestScores: TTntCheckBox
        Left = 16
        Top = 28
        Width = 347
        Height = 18
        TabStop = False
        BiDiMode = bdLeftToRight
        Color = clBtnFace
        Ctl3D = True
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object CommonRulesGroupName: TTntGroupBox
        Left = 9
        Top = 172
        Width = 365
        Height = 151
        Anchors = [akLeft, akTop, akRight]
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        object Bevel3: TBevel
          Left = 28
          Top = 50
          Width = 30
          Height = 2
        end
        object Bevel4: TBevel
          Left = 27
          Top = 40
          Width = 2
          Height = 11
        end
        object CommonRulesCrossword: TTntCheckBox
          Left = 20
          Top = 64
          Width = 279
          Height = 17
          TabStop = False
          Color = clBtnFace
          Ctl3D = True
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object CommonRulesSlashBlankTiles: TTntCheckBox
          Left = 62
          Top = 40
          Width = 266
          Height = 18
          TabStop = False
          Color = clBtnFace
          Ctl3D = True
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object CommonRulesPermitReuseBlankTile: TTntCheckBox
          Left = 20
          Top = 22
          Width = 308
          Height = 17
          TabStop = False
          Color = clBtnFace
          Ctl3D = True
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = CommonRulesPermitReuseBlankTileClick
        end
        object CommonRulesFreeWordPlacement: TTntCheckBox
          Left = 20
          Top = 84
          Width = 308
          Height = 17
          TabStop = False
          Color = clBtnFace
          Ctl3D = True
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = CommonRulesPermitReuseBlankTileClick
        end
        object CommonRulesAllowRepeatWords: TTntCheckBox
          Left = 20
          Top = 104
          Width = 308
          Height = 18
          TabStop = False
          Color = clBtnFace
          Ctl3D = True
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = CommonRulesPermitReuseBlankTileClick
        end
        object CommonRulesReusePrizeCells: TTntCheckBox
          Left = 20
          Top = 124
          Width = 214
          Height = 17
          TabStop = False
          Color = clBtnFace
          Ctl3D = True
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = CommonRulesPermitReuseBlankTileClick
        end
      end
      object CommonAutoGetLetters: TTntCheckBox
        Left = 16
        Top = 48
        Width = 347
        Height = 19
        TabStop = False
        BiDiMode = bdLeftToRight
        Color = clBtnFace
        Ctl3D = True
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object PauseOnMinimazed: TTntCheckBox
        Left = 198
        Top = 68
        Width = 140
        Height = 18
        TabStop = False
        Color = clBtnFace
        Ctl3D = True
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        Visible = False
      end
      object CommonAutoArrangeWindows: TTntCheckBox
        Left = 16
        Top = 89
        Width = 226
        Height = 19
        TabStop = False
        BiDiMode = bdLeftToRight
        Color = clBtnFace
        Ctl3D = True
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = CommonChiefInRoomClick
      end
    end
    object TabSheetDictionary: TTntTabSheet
      object DictionaryLabelSize: TTntLabel
        Left = 17
        Top = 52
        Width = 3
        Height = 15
      end
      object DictionaryButtonThemes: TTntSpeedButton
        Left = 215
        Top = 11
        Width = 157
        Height = 23
        AllowAllUp = True
        ParentShowHint = False
        ShowHint = True
        OnClick = DictionaryButtonThemesClick
      end
      object Bevel6: TBevel
        Left = 9
        Top = 42
        Width = 364
        Height = 2
      end
      object GroupBox1: TTntGroupBox
        Left = 9
        Top = 169
        Width = 363
        Height = 139
        Enabled = False
        TabOrder = 3
        object DictionaryRulesRadioButtonConfirmAddNewWord: TTntRadioButton
          Left = 32
          Top = 43
          Width = 266
          Height = 18
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object DictionaryRulesRadioButtonAddNewWordWithoutConfirm: TTntRadioButton
          Left = 32
          Top = 62
          Width = 266
          Height = 19
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object DictionaryRulesRadioButtonUserCannotAddWords: TTntRadioButton
          Left = 32
          Top = 25
          Width = 239
          Height = 15
          Checked = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          TabStop = True
        end
        object DictionaryRulesConfirmWordExclude: TTntCheckBox
          Left = 33
          Top = 93
          Width = 273
          Height = 15
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 3
        end
        object DictionaryRulesPCReplayAfterExcludeWord: TTntCheckBox
          Left = 33
          Top = 112
          Width = 317
          Height = 15
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 4
        end
      end
      object DictionaryRadioButtonSizeMax: TTntRadioButton
        Left = 18
        Top = 134
        Width = 354
        Height = 18
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object DictionaryRadioButtonSizeNormal: TTntRadioButton
        Left = 18
        Top = 95
        Width = 197
        Height = 18
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object DictionaryGroupUseUserDictionary: TTntCheckBox
        Left = 18
        Top = 165
        Width = 259
        Height = 18
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 2
        OnClick = DictionaryGroupUseUserDictionaryClick
      end
      object DictionaryRadioButtonSizeExtended: TTntRadioButton
        Left = 18
        Top = 114
        Width = 190
        Height = 18
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object DictionaryRadioButtonSizeChildren: TTntRadioButton
        Left = 18
        Top = 75
        Width = 354
        Height = 19
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object DictionaryRulesConfirmAddWordExplanation: TTntCheckBox
        Left = 22
        Top = 312
        Width = 272
        Height = 15
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 7
      end
      object Panel2: TPanel
        Left = 9
        Top = 42
        Width = 363
        Height = 285
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 5
        Visible = False
        object DictionaryLabelThemes: TTntLabel
          Left = 6
          Top = 5
          Width = 3
          Height = 15
        end
        object Bevel5: TBevel
          Left = 5
          Top = 24
          Width = 354
          Height = 2
        end
        object ThemesTipListBox: TTntCheckListBox
          Left = 5
          Top = 30
          Width = 353
          Height = 249
          AutoComplete = False
          BevelInner = bvNone
          BevelOuter = bvNone
          BevelKind = bkFlat
          BorderStyle = bsNone
          ItemHeight = 16
          ParentShowHint = False
          ShowHint = True
          Style = lbOwnerDrawFixed
          TabOrder = 0
        end
      end
    end
    object TabSheetUserDictionary: TTntTabSheet
      ImageIndex = 5
      object UserDictionaryButtonWordAdd: TTntSpeedButton
        Left = 129
        Top = 34
        Width = 25
        Height = 24
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000130B0000130B000000010000000100002184290039B5
          520063A563006BAD840094DE8C00FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00050505050505
          0505050505050505050505050505050503000003050505050505050505050505
          0204010005050505050505050505050502040100050505050505050505050505
          0204010005050505050505050505050502040100050505050505050300000000
          0004010000000000030505020101010101010101010101010005050204040404
          0404010404040404000505030202020202040100000000000305050505050505
          0204010005050505050505050505050502040100050505050505050505050505
          0204010005050505050505050505050502040100050505050505050505050505
          0302020305050505050505050505050505050505050505050505}
        ParentShowHint = False
        ShowHint = True
        OnClick = UserDictionaryButtonWordAddClick
      end
      object UserDictionaryButtonWordUnAdd: TTntSpeedButton
        Left = 157
        Top = 34
        Width = 25
        Height = 24
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000220B0000220B000000010000000100000031DE000031
          E7000031EF000031F700FF00FF000031FF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00040404040404
          0404040404040404000004000004040404040404040404000004040000000404
          0404040404040000040404000000000404040404040000040404040402000000
          0404040400000404040404040404000000040000000404040404040404040400
          0101010004040404040404040404040401010204040404040404040404040400
          0201020304040404040404040404030201040403030404040404040404050203
          0404040405030404040404040303050404040404040303040404040303030404
          0404040404040403040403030304040404040404040404040404030304040404
          0404040404040404040404040404040404040404040404040404}
        ParentShowHint = False
        ShowHint = True
        OnClick = UserDictionaryButtonWordUnAddClick
      end
      object UserDictionaryButtonWordExclude: TTntSpeedButton
        Left = 310
        Top = 34
        Width = 25
        Height = 24
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000130B0000130B000000010000000100002184290039B5
          520063A563006BAD840094DE8C00FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00050505050505
          0505050505050505050505050505050503000003050505050505050505050505
          0204010005050505050505050505050502040100050505050505050505050505
          0204010005050505050505050505050502040100050505050505050300000000
          0004010000000000030505020101010101010101010101010005050204040404
          0404010404040404000505030202020202040100000000000305050505050505
          0204010005050505050505050505050502040100050505050505050505050505
          0204010005050505050505050505050502040100050505050505050505050505
          0302020305050505050505050505050505050505050505050505}
        ParentShowHint = False
        ShowHint = True
        OnClick = UserDictionaryButtonWordExcludeClick
      end
      object UserDictionaryButtonWordUnExclude: TTntSpeedButton
        Left = 338
        Top = 34
        Width = 25
        Height = 24
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000220B0000220B000000010000000100000031DE000031
          E7000031EF000031F700FF00FF000031FF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00040404040404
          0404040404040404000004000004040404040404040404000004040000000404
          0404040404040000040404000000000404040404040000040404040402000000
          0404040400000404040404040404000000040000000404040404040404040400
          0101010004040404040404040404040401010204040404040404040404040400
          0201020304040404040404040404030201040403030404040404040404050203
          0404040405030404040404040303050404040404040303040404040303030404
          0404040404040403040403030304040404040404040404040404030304040404
          0404040404040404040404040404040404040404040404040404}
        ParentShowHint = False
        ShowHint = True
        OnClick = UserDictionaryButtonWordUnExcludeClick
      end
      object UserDictionaryLabelAddedWords: TTntLabel
        Left = 17
        Top = 9
        Width = 3
        Height = 15
      end
      object UserDictionaryLabelExcludedWords: TTntLabel
        Left = 198
        Top = 9
        Width = 3
        Height = 15
      end
      object UserDictionaryLabelComment: TTntLabel
        Left = 17
        Top = 222
        Width = 3
        Height = 15
      end
      object ListBox1: TListBox
        Left = 17
        Top = 60
        Width = 165
        Height = 150
        Style = lbOwnerDrawFixed
        BiDiMode = bdLeftToRight
        Color = clWhite
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        MultiSelect = True
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnClick = ListBox1Click
        OnEnter = ListBox1Enter
      end
      object Edit1: TTntEdit
        Left = 17
        Top = 34
        Width = 105
        Height = 23
        CharCase = ecUpperCase
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = Edit1Change
      end
      object ListBox2: TListBox
        Left = 198
        Top = 60
        Width = 165
        Height = 150
        Style = lbOwnerDrawFixed
        BiDiMode = bdLeftToRight
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        MultiSelect = True
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        OnClick = ListBox2Click
        OnEnter = ListBox1Enter
      end
      object Edit2: TTntEdit
        Left = 198
        Top = 34
        Width = 105
        Height = 23
        CharCase = ecUpperCase
        TabOrder = 3
        OnChange = Edit2Change
      end
      object TextboxCustomWordComment: TMemo
        Left = 17
        Top = 240
        Width = 346
        Height = 80
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        WantReturns = False
        OnExit = TextboxCustomWordCommentExit
      end
      object BufferList1: TTntListBox
        Left = 17
        Top = 224
        Width = 165
        Height = 10
        ItemHeight = 15
        MultiSelect = True
        TabOrder = 5
        Visible = False
      end
      object BufferList2: TTntListBox
        Left = 198
        Top = 224
        Width = 165
        Height = 10
        ItemHeight = 15
        MultiSelect = True
        TabOrder = 6
        Visible = False
      end
    end
    object TabSheetLimits: TTntTabSheet
      object LimitsRadioButtonNoLimits: TTntRadioButton
        Left = 12
        Top = 23
        Width = 134
        Height = 18
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = LimitsRadioButtonNoLimitsClick
      end
      object Panel1: TTntPanel
        Left = 9
        Top = 48
        Width = 365
        Height = 151
        BevelInner = bvLowered
        Ctl3D = True
        Locked = True
        ParentCtl3D = False
        TabOrder = 1
        object LimitsRadioButtonScore100: TTntRadioButton
          Left = 26
          Top = 16
          Width = 108
          Height = 18
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = LimitsRadioButtonScore100Click
        end
        object LimitsRadioButtonScore500: TTntRadioButton
          Left = 26
          Top = 76
          Width = 108
          Height = 19
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = LimitsRadioButtonScore100Click
        end
        object LimitsRadioButtonScoreUserSelected: TTntRadioButton
          Left = 26
          Top = 108
          Width = 139
          Height = 18
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = LimitsRadioButtonScore100Click
        end
        object LimitsRadioButtonScore300: TTntRadioButton
          Left = 26
          Top = 46
          Width = 108
          Height = 19
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = LimitsRadioButtonScore100Click
        end
        object LimitsRadioButtonTime1Hour: TTntRadioButton
          Left = 193
          Top = 120
          Width = 107
          Height = 18
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = LimitsRadioButtonTime10minutesClick
        end
        object LimitsRadioButtonTime30minutes: TTntRadioButton
          Left = 193
          Top = 70
          Width = 107
          Height = 18
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = LimitsRadioButtonTime10minutesClick
        end
        object LimitsRadioButtonTime20minutes: TTntRadioButton
          Left = 193
          Top = 43
          Width = 107
          Height = 18
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnClick = LimitsRadioButtonTime10minutesClick
        end
        object LimitsRadioButtonTime10minutes: TTntRadioButton
          Left = 193
          Top = 15
          Width = 107
          Height = 18
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = LimitsRadioButtonTime10minutesClick
        end
        object Edit3: TEdit
          Left = 73
          Top = 103
          Width = 43
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 8
          OnEnter = Edit3Enter
        end
        object LimitsRadioButtonTime45minutes: TTntRadioButton
          Left = 193
          Top = 95
          Width = 107
          Height = 18
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnClick = LimitsRadioButtonTime10minutesClick
        end
      end
      object LimitsComboboxListMoveTime: TTntComboBox
        Left = 155
        Top = 212
        Width = 120
        Height = 23
        Style = csDropDownList
        DropDownCount = 5
        ItemHeight = 15
        TabOrder = 2
      end
      object LimitsMoveTime: TTntCheckBox
        Left = 17
        Top = 215
        Width = 131
        Height = 19
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = LimitsMoveTimeClick
      end
      object LimitsWordLengthNoLess: TTntCheckBox
        Left = 16
        Top = 242
        Width = 198
        Height = 19
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = LimitsWordLengthNoLessClick
      end
      object LimitsComboboxListLetter: TTntComboBox
        Left = 211
        Top = 239
        Width = 116
        Height = 23
        Style = csDropDownList
        DropDownCount = 5
        ItemHeight = 15
        TabOrder = 5
      end
    end
    object TabSheetMusic: TTntTabSheet
      object MusicLabelVolume: TTntLabel
        Left = 6
        Top = 276
        Width = 340
        Height = 14
        AutoSize = False
        Color = clBtnFace
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object OP_GBox3: TGroupBox
        Left = 3
        Top = 38
        Width = 373
        Height = 227
        TabOrder = 1
        object MusicLabelPlaylist: TTntLabel
          Left = 9
          Top = 25
          Width = 156
          Height = 17
          AutoSize = False
        end
        object Label12: TTntLabel
          Left = 209
          Top = 25
          Width = 156
          Height = 17
          AutoSize = False
          Caption = 'MP3, OGG, MIDI '
        end
        object MusicButtonRemove: TTntSpeedButton
          Left = 174
          Top = 108
          Width = 26
          Height = 26
          Caption = '>'
          ParentShowHint = False
          ShowHint = True
          OnClick = MusicButtonRemoveClick
        end
        object MusicButtonRemoveAll: TTntSpeedButton
          Left = 174
          Top = 137
          Width = 26
          Height = 26
          Caption = '>>'
          ParentShowHint = False
          ShowHint = True
          OnClick = MusicButtonRemoveAllClick
        end
        object MusicButtonAdd: TTntSpeedButton
          Left = 174
          Top = 45
          Width = 26
          Height = 26
          Caption = '<'
          ParentShowHint = False
          ShowHint = True
          OnClick = MusicButtonAddClick
        end
        object MusicButtonAddAll: TTntSpeedButton
          Left = 174
          Top = 74
          Width = 26
          Height = 26
          Caption = '<<'
          ParentShowHint = False
          ShowHint = True
          OnClick = MusicButtonAddAllClick
        end
        object MusicListboxSelectedSongs: TListBox
          Left = 9
          Top = 42
          Width = 155
          Height = 157
          ItemHeight = 15
          MultiSelect = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = MusicListboxSelectedSongsClick
        end
        object MusicListboxFilesInSelectedFolder: TFileListBox
          Left = 209
          Top = 43
          Width = 152
          Height = 130
          Color = clWhite
          Ctl3D = True
          ItemHeight = 14
          Mask = '*.mid;*.mp3;*.ogg;'
          MultiSelect = True
          ParentCtl3D = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = MusicListboxFilesInSelectedFolderClick
          OnDblClick = MusicButtonAddClick
        end
        object DirectoryEdit: TDirectoryEdit
          Left = 210
          Top = 182
          Width = 152
          Height = 23
          DialogKind = dkWin32
          DialogText = #1042#1099#1073#1086#1088' '#1087#1072#1087#1082#1080' '#1089' '#1084#1091#1079#1099#1082#1086#1081
          InitialDir = 'media'
          CharCase = ecUpperCase
          ClickKey = 0
          Ctl3D = True
          DirectInput = False
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          NumGlyphs = 1
          ButtonWidth = 23
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 2
          Text = 'MEDIA'
          OnChange = DirectoryEditChange
        end
        object PathList: TListBox
          Left = 118
          Top = 205
          Width = 16
          Height = 15
          ItemHeight = 15
          MultiSelect = True
          TabOrder = 3
          Visible = False
        end
        object ShuffleList: TListBox
          Left = 145
          Top = 206
          Width = 15
          Height = 15
          ItemHeight = 15
          MultiSelect = True
          TabOrder = 4
          Visible = False
        end
      end
      object MusicGroupBackgroundMusic: TTntCheckBox
        Left = 18
        Top = 33
        Width = 86
        Height = 19
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 0
        OnClick = MusicGroupBackgroundMusicClick
      end
      object MusicShuffle: TTntCheckBox
        Left = 16
        Top = 240
        Width = 107
        Height = 18
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object MusicSoundFX: TTntCheckBox
        Left = 18
        Top = 12
        Width = 179
        Height = 18
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 3
      end
      object TrackBar3: TTrackBar
        Left = 129
        Top = 275
        Width = 94
        Height = 23
        Max = 100
        Orientation = trHorizontal
        Frequency = 1
        Position = 0
        SelEnd = 0
        SelStart = 0
        TabOrder = 4
        ThumbLength = 14
        TickMarks = tmBottomRight
        TickStyle = tsManual
        OnChange = TrackBar3Change
      end
      object TrackBar4: TTrackBar
        Left = 283
        Top = 275
        Width = 94
        Height = 23
        Max = 100
        Orientation = trHorizontal
        ParentShowHint = False
        Frequency = 1
        Position = 0
        SelEnd = 0
        SelStart = 0
        ShowHint = False
        TabOrder = 5
        ThumbLength = 14
        TickMarks = tmBottomRight
        TickStyle = tsManual
        OnChange = TrackBar4Change
      end
    end
    object TabSheetLayout: TTntTabSheet
      Enabled = False
      ImageIndex = 4
      OnShow = TabSheetLayoutShow
      object Shape6: TShape
        Left = 8
        Top = 219
        Width = 367
        Height = 108
        Brush.Color = 12500670
        Pen.Style = psClear
      end
      object MapPreview: TImage
        Left = 144
        Top = 231
        Width = 105
        Height = 105
        AutoSize = True
        Center = True
      end
      object LayoutRadioButtonFromFile: TTntRadioButton
        Left = 20
        Top = 24
        Width = 188
        Height = 18
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = LayoutRadioButtonFromFileClick
      end
      object Panel3: TPanel
        Left = 9
        Top = 61
        Width = 365
        Height = 155
        BevelInner = bvLowered
        Ctl3D = True
        Locked = True
        ParentCtl3D = False
        TabOrder = 1
        object Shape1: TShape
          Left = 26
          Top = 64
          Width = 15
          Height = 15
          Brush.Color = clLime
        end
        object Shape2: TShape
          Left = 26
          Top = 106
          Width = 15
          Height = 15
          Brush.Color = clYellow
        end
        object Shape3: TShape
          Left = 138
          Top = 64
          Width = 15
          Height = 15
          Brush.Color = clBlue
        end
        object Shape4: TShape
          Left = 138
          Top = 106
          Width = 15
          Height = 15
          Brush.Color = clRed
        end
        object Shape5: TShape
          Left = 248
          Top = 64
          Width = 15
          Height = 15
          Brush.Color = clBlack
          Pen.Color = clBlue
        end
        object LayoutLabelSize: TTntLabel
          Left = 24
          Top = 25
          Width = 169
          Height = 14
          AutoSize = False
          Color = clBtnFace
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object LayoutRandomCellsLetterX2: TTntLabel
          Left = 24
          Top = 83
          Width = 75
          Height = 14
          AutoSize = False
          Color = clBtnFace
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object LayoutRandomCellsLetterX3: TTntLabel
          Left = 24
          Top = 123
          Width = 75
          Height = 14
          AutoSize = False
          Color = clBtnFace
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object LayoutRandomCellsWordX2: TTntLabel
          Left = 136
          Top = 83
          Width = 75
          Height = 14
          AutoSize = False
          Color = clBtnFace
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object LayoutRandomCellsWordX3: TTntLabel
          Left = 136
          Top = 123
          Width = 75
          Height = 14
          AutoSize = False
          Color = clBtnFace
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object LayoutRandomCellsStart: TTntLabel
          Left = 246
          Top = 83
          Width = 101
          Height = 14
          AutoSize = False
          Color = clBtnFace
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object OP_Label20: TTntLabel
          Left = 201
          Top = 26
          Width = 11
          Height = 14
          AutoSize = False
          Caption = #1093
          Color = clBtnFace
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          Caption_UTF7 = '+BEU'
        end
        object green_SpinEdit: TRxSpinEdit
          Left = 53
          Top = 61
          Width = 46
          Height = 21
          MaxValue = 1000
          AutoSize = False
          TabOrder = 0
          OnEnter = green_SpinEditEnter
        end
        object yel_SpinEdit: TRxSpinEdit
          Left = 53
          Top = 103
          Width = 46
          Height = 21
          MaxValue = 1000
          AutoSize = False
          TabOrder = 1
          OnEnter = green_SpinEditEnter
        end
        object Blu_SpinEdit: TRxSpinEdit
          Left = 167
          Top = 61
          Width = 46
          Height = 21
          MaxValue = 1000
          AutoSize = False
          TabOrder = 2
          OnEnter = green_SpinEditEnter
        end
        object Red_SpinEdit: TRxSpinEdit
          Left = 167
          Top = 103
          Width = 46
          Height = 21
          MaxValue = 1000
          AutoSize = False
          TabOrder = 3
          OnEnter = green_SpinEditEnter
        end
        object blak_SpinEdit: TRxSpinEdit
          Left = 277
          Top = 61
          Width = 46
          Height = 21
          MaxValue = 1000
          MinValue = 1
          Value = 4
          AutoSize = False
          TabOrder = 4
          OnEnter = green_SpinEditEnter
        end
        object DimX_SpinEdit: TRxSpinEdit
          Left = 157
          Top = 23
          Width = 41
          Height = 20
          MaxValue = 30
          MinValue = 15
          Value = 15
          AutoSize = False
          TabOrder = 5
          OnChange = DimX_SpinEditChange
        end
        object DimY_SpinEdit: TRxSpinEdit
          Left = 213
          Top = 23
          Width = 41
          Height = 20
          MaxValue = 30
          MinValue = 15
          Value = 15
          AutoSize = False
          TabOrder = 6
          OnChange = DimY_SpinEditChange
        end
        object LayoutRandomIsSquareLayout: TTntCheckBox
          Left = 264
          Top = 25
          Width = 88
          Height = 18
          Checked = True
          State = cbChecked
          TabOrder = 7
          OnClick = LayoutRandomIsSquareLayoutClick
        end
      end
      object LayoutRadioButtonRandom: TTntRadioButton
        Left = 20
        Top = 54
        Width = 188
        Height = 18
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = LayoutRadioButtonRandomClick
      end
      object ComboBox2: TTntComboBox
        Left = 206
        Top = 22
        Width = 163
        Height = 23
        Style = csDropDownList
        DropDownCount = 5
        ItemHeight = 15
        TabOrder = 3
        OnChange = ComboBox2Change
      end
    end
    object TabSheetHint: TTntTabSheet
      ImageIndex = 6
      object HintLabelSpeedLo: TTntLabel
        Left = 297
        Top = 143
        Width = 55
        Height = 14
        Alignment = taCenter
        AutoSize = False
      end
      object HintLabelSpeedHi: TTntLabel
        Left = 226
        Top = 144
        Width = 41
        Height = 14
        Alignment = taCenter
        AutoSize = False
      end
      object HintLabelSpeed: TTntLabel
        Left = 13
        Top = 123
        Width = 214
        Height = 14
        AutoSize = False
        Color = clBtnFace
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object Label6: TTntLabel
        Left = 171
        Top = 48
        Width = 27
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = '3'
        ParentShowHint = False
        ShowHint = False
      end
      object Label7: TTntLabel
        Left = 212
        Top = 48
        Width = 27
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = '5'
        ParentShowHint = False
        ShowHint = False
      end
      object Label8: TTntLabel
        Left = 253
        Top = 48
        Width = 27
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = '7'
        ParentShowHint = False
        ShowHint = False
      end
      object Label9: TTntLabel
        Left = 295
        Top = 48
        Width = 27
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = '10'
        ParentShowHint = False
        ShowHint = False
      end
      object Label10: TTntLabel
        Left = 345
        Top = 50
        Width = 7
        Height = 15
        Alignment = taCenter
        Caption = '~'
        ParentShowHint = False
        ShowHint = False
      end
      object HintLabelQuantity: TTntLabel
        Left = 13
        Top = 29
        Width = 169
        Height = 14
        AutoSize = False
        Color = clBtnFace
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object Bevel2: TBevel
        Left = 15
        Top = 79
        Width = 353
        Height = 2
      end
      object TrackBar1: TTrackBar
        Left = 240
        Top = 123
        Width = 94
        Height = 23
        Max = 1000
        Orientation = trHorizontal
        ParentShowHint = False
        Frequency = 1
        Position = 0
        SelEnd = 0
        SelStart = 0
        ShowHint = False
        TabOrder = 0
        ThumbLength = 14
        TickMarks = tmBottomRight
        TickStyle = tsManual
      end
      object HintWaitKeypress: TTntCheckBox
        Left = 13
        Top = 89
        Width = 341
        Height = 19
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 1
      end
      object TrackBar2: TTrackBar
        Left = 174
        Top = 26
        Width = 185
        Height = 21
        Ctl3D = True
        Max = 4
        Orientation = trHorizontal
        ParentCtl3D = False
        ParentShowHint = False
        PageSize = 1
        Frequency = 1
        Position = 2
        SelEnd = 0
        SelStart = 0
        ShowHint = True
        TabOrder = 2
        ThumbLength = 14
        TickMarks = tmBottomRight
        TickStyle = tsAuto
      end
    end
    object TabSheetSkin: TTntTabSheet
      ImageIndex = 7
      object SkinLabelUsed: TTntLabel
        Left = 19
        Top = 20
        Width = 135
        Height = 14
        AutoSize = False
        Color = clBtnFace
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object Bevel7: TBevel
        Left = 14
        Top = 51
        Width = 353
        Height = 2
      end
      object ComboBox3: TTntComboBox
        Left = 179
        Top = 17
        Width = 175
        Height = 23
        DropDownCount = 5
        ItemHeight = 15
        TabOrder = 0
        OnChange = ComboBox2Change
      end
      object SkinAnimateOnlyActivePlayer: TTntCheckBox
        Left = 18
        Top = 85
        Width = 250
        Height = 18
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 1
      end
      object SkinAccentActivePlayer: TTntCheckBox
        Left = 18
        Top = 62
        Width = 267
        Height = 19
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 2
      end
      object SkinColoredTiles: TTntCheckBox
        Left = 18
        Top = 130
        Width = 215
        Height = 19
        TabStop = False
        Color = clBtnFace
        Ctl3D = True
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object SkinShadows: TTntCheckBox
        Left = 18
        Top = 108
        Width = 333
        Height = 18
        TabStop = False
        Color = clBtnFace
        Ctl3D = True
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object SkinShowDictionaryPanel: TTntCheckBox
        Left = 18
        Top = 153
        Width = 225
        Height = 18
        TabStop = False
        Color = clBtnFace
        Ctl3D = True
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
      end
    end
    object TabSheetLanguages: TTntTabSheet
      ImageIndex = 8
      OnShow = TabSheetLanguagesShow
      object Bevel1: TBevel
        Left = 45
        Top = 115
        Width = 2
        Height = 15
      end
      object Bevel11: TBevel
        Left = 46
        Top = 129
        Width = 132
        Height = 2
      end
      object LanguageButtonAlphabet: TTntSpeedButton
        Left = 215
        Top = 11
        Width = 157
        Height = 23
        AllowAllUp = True
        ParentShowHint = False
        ShowHint = True
        OnClick = LanguageButtonAlphabetClick
      end
      object Bevel10: TBevel
        Left = 16
        Top = 44
        Width = 356
        Height = 2
      end
      object LanguageLabelInterfaceLanguage: TTntLabel
        Left = 19
        Top = 62
        Width = 197
        Height = 14
        AutoSize = False
        Color = clBtnFace
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object LanguageLabelDictionaryLanguage: TTntLabel
        Left = 19
        Top = 93
        Width = 197
        Height = 14
        AutoSize = False
        Color = clBtnFace
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object LanguageLabelExplanatoryLanguage: TTntLabel
        Left = 207
        Top = 123
        Width = 3
        Height = 15
        Alignment = taRightJustify
        Color = clBtnFace
        Font.Charset = OEM_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object ComboBox1: TTntComboBox
        Left = 226
        Top = 58
        Width = 143
        Height = 23
        DropDownCount = 5
        ItemHeight = 15
        TabOrder = 1
        OnChange = ComboBox1Change
      end
      object ComboBox4: TTntComboBox
        Left = 226
        Top = 88
        Width = 143
        Height = 23
        AutoComplete = False
        DropDownCount = 5
        ItemHeight = 15
        TabOrder = 2
        OnChange = ComboBox4Change
      end
      object ComboBox5: TTntComboBox
        Left = 225
        Top = 118
        Width = 143
        Height = 23
        DropDownCount = 5
        ItemHeight = 15
        TabOrder = 3
        OnChange = ComboBox5Change
      end
      object Panel4: TPanel
        Left = 10
        Top = 48
        Width = 365
        Height = 259
        BevelOuter = bvNone
        Ctl3D = True
        Locked = True
        ParentCtl3D = False
        TabOrder = 0
        Visible = False
        object AlphabetLabelLetterScore: TTntLabel
          Left = 16
          Top = 120
          Width = 107
          Height = 14
          AutoSize = False
          Color = clBtnFace
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object AlphabetLabelLetterQuantity: TTntLabel
          Left = 15
          Top = 145
          Width = 167
          Height = 14
          AutoSize = False
          Color = clBtnFace
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object OP_Label29: TTntLabel
          Left = 233
          Top = 146
          Width = 118
          Height = 14
          AutoSize = False
          Color = clBtnFace
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object SpeedButton6: TTntSpeedButton
          Left = 325
          Top = 127
          Width = 24
          Height = 24
          AllowAllUp = True
          Caption = #1040
          Flat = True
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Spacing = -20
          Visible = False
          OnClick = SpeedButton6Click
          Caption_UTF7 = '+BBA'
        end
        object Bevel9: TBevel
          Left = 14
          Top = 169
          Width = 331
          Height = 2
        end
        object OP_Label30: TTntLabel
          Left = 15
          Top = 178
          Width = 331
          Height = 38
          AutoSize = False
          Color = clBtnFace
          Font.Charset = OEM_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object AlphabetButtonDefault: TTntSpeedButton
          Left = 262
          Top = 229
          Width = 99
          Height = 25
          AllowAllUp = True
          ParentShowHint = False
          ShowHint = True
          OnClick = AlphabetButtonDefaultClick
        end
        object RxSpinEdit6: TRxSpinEdit
          Left = 118
          Top = 118
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 20
          Value = 15
          AutoSize = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          OnBottomClick = RxSpinEdit6BottomClick
          OnTopClick = RxSpinEdit6TopClick
          OnChange = RxSpinEdit6Change
        end
        object RxSpinEdit1: TRxSpinEdit
          Left = 183
          Top = 143
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          Value = 15
          AutoSize = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 1
          OnBottomClick = RxSpinEdit1BottomClick
          OnTopClick = RxSpinEdit1TopClick
          OnChange = RxSpinEdit1Change
        end
      end
    end
  end
  object ButtonOK: TTntBitBtn
    Left = 218
    Top = 405
    Width = 82
    Height = 26
    Anchors = [akLeft, akBottom]
    ModalResult = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object ButtonCancel: TTntBitBtn
    Left = 314
    Top = 405
    Width = 83
    Height = 26
    Anchors = [akLeft, akBottom]
    ModalResult = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
end
