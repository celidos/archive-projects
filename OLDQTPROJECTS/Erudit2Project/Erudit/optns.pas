{v 1.6.x}

unit Optns;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, Mask, Procs, ExtCtrls, DualList, ToolEdit,
  RXSpin, FileCtrl, CheckLst, StrUtils, BASS, Math, TntStdCtrls,
  TntButtons, TntComCtrls, TntExtCtrls, TntCheckLst, TNTForms;


type
  TOptions = class(TTNTForm)
    OptionsPageControl: TTntPageControl;
    TabSheetCommon: TTntTabSheet;
    ButtonOK: TTntBitBtn;
    ButtonCancel: TTntBitBtn;
    CommonShowPCwords: TTNTCheckBox;
    TabSheetDictionary: TTntTabSheet;
    DictionaryRadioButtonSizeMax: TTntRadioButton;
    DictionaryRadioButtonSizeNormal: TTntRadioButton;
    TabSheetLimits: TTntTabSheet;
    LimitsRadioButtonNoLimits: TTntRadioButton;
    Panel1: TTntPanel;
    LimitsRadioButtonScore100: TTntRadioButton;
    LimitsRadioButtonScore500: TTntRadioButton;
    LimitsRadioButtonScoreUserSelected: TTntRadioButton;
    LimitsRadioButtonScore300: TTntRadioButton;
    LimitsRadioButtonTime1Hour: TTntRadioButton;
    LimitsRadioButtonTime30minutes: TTntRadioButton;
    LimitsRadioButtonTime20minutes: TTntRadioButton;
    LimitsRadioButtonTime10minutes: TTntRadioButton;
    TabSheetMusic: TTntTabSheet;
    MusicGroupBackgroundMusic: TTntCheckBox;
    OP_GBox3: TGroupBox;
    MusicShuffle: TTntCheckBox;
    MusicSoundFX: TTntCheckBox;
    MusicLabelPlaylist: TTntLabel;
    Label12: TTntLabel;
    MusicButtonRemove: TTntSpeedButton;
    MusicButtonRemoveAll: TTntSpeedButton;
    MusicButtonAdd: TTntSpeedButton;
    MusicButtonAddAll: TTntSpeedButton;
    MusicListboxFilesInSelectedFolder: TFileListBox;
    DirectoryEdit: TDirectoryEdit;
    PathList: TListBox;
    MusicListboxSelectedSongs: TListBox;
    ShuffleList: TListBox;
    TabSheetLayout: TTntTabSheet;
    DictionaryLabelSize: TTntLabel;
    DictionaryGroupUseUserDictionary: TTntCheckBox;
    GroupBox1: TTntGroupBox;
    DictionaryRulesRadioButtonConfirmAddNewWord: TTntRadioButton;
    DictionaryRulesRadioButtonAddNewWordWithoutConfirm: TTntRadioButton;
    DictionaryRulesRadioButtonUserCannotAddWords: TTntRadioButton;
    DictionaryRulesConfirmWordExclude: TTntCheckBox;
    TabSheetUserDictionary: TTntTabSheet;
    ListBox1: TListBox;
    Edit1: TTntEdit;
    ListBox2: TListBox;
    UserDictionaryButtonWordAdd: TTntSpeedButton;
    UserDictionaryButtonWordUnAdd: TTntSpeedButton;
    Edit2: TTntEdit;
    UserDictionaryButtonWordExclude: TTntSpeedButton;
    UserDictionaryButtonWordUnExclude: TTntSpeedButton;
    UserDictionaryLabelAddedWords: TTntLabel;
    UserDictionaryLabelExcludedWords: TTntLabel;
    TextboxCustomWordComment: TMemo;
    UserDictionaryLabelComment: TTntLabel;
    BufferList1: TTntListBox;
    BufferList2: TTntListBox;
    DictionaryRadioButtonSizeExtended: TTntRadioButton;
    CommonShowAllUserBestScores: TTntCheckBox;
    TabSheetHint: TTntTabSheet;
    HintLabelSpeedLo: TTntLabel;
    HintLabelSpeedHi: TTntLabel;
    TrackBar1: TTrackBar;
    HintLabelSpeed: TTntLabel;
    HintWaitKeypress: TTntCheckBox;
    TrackBar2: TTrackBar;
    Label6: TTntLabel;
    Label7: TTntLabel;
    Label8: TTntLabel;
    Label9: TTntLabel;
    Label10: TTntLabel;
    HintLabelQuantity: TTntLabel;
    Bevel2: TBevel;
    CommonRulesGroupName: TTntGroupBox;
    CommonRulesCrossword: TTntCheckBox;
    CommonRulesSlashBlankTiles: TTntCheckBox;
    CommonRulesPermitReuseBlankTile: TTntCheckBox;
    Edit3: TEdit;
    DictionaryRulesPCReplayAfterExcludeWord: TTntCheckBox;
    CommonRulesFreeWordPlacement: TTntCheckBox;
    Bevel3: TBevel;
    Bevel4: TBevel;
    TrackBar3: TTrackBar;
    MusicLabelVolume: TTntLabel;
    TrackBar4: TTrackBar;
    CommonRulesAllowRepeatWords: TTntCheckBox;
    CommonAutoGetLetters: TTntCheckBox;
    DictionaryButtonThemes: TTntSpeedButton;
    Panel2: TPanel;
    ThemesTipListBox: TTntCheckListBox;
    DictionaryLabelThemes: TTntLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    LimitsComboboxListMoveTime: TTntComboBox;
    LimitsMoveTime: TTntCheckBox;
    LimitsRadioButtonTime45minutes: TTntRadioButton;
    LayoutRadioButtonFromFile: TTntRadioButton;
    Panel3: TPanel;
    LayoutRadioButtonRandom: TTntRadioButton;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    green_SpinEdit: TRxSpinEdit;
    yel_SpinEdit: TRxSpinEdit;
    Blu_SpinEdit: TRxSpinEdit;
    Red_SpinEdit: TRxSpinEdit;
    Shape5: TShape;
    blak_SpinEdit: TRxSpinEdit;
    ComboBox2: TTntComboBox;
    LayoutLabelSize: TTntLabel;
    DimX_SpinEdit: TRxSpinEdit;
    LayoutRandomCellsLetterX2: TTntLabel;
    LayoutRandomCellsLetterX3: TTntLabel;
    LayoutRandomCellsWordX2: TTntLabel;
    LayoutRandomCellsWordX3: TTntLabel;
    LayoutRandomCellsStart: TTntLabel;
    CommonChiefInRoom: TTntCheckBox;
    PauseOnMinimazed: TTntCheckBox;
    Bevel8: TBevel;
    CommonRulesReusePrizeCells: TTntCheckBox;
    DimY_SpinEdit: TRxSpinEdit;
    OP_Label20: TTntLabel;
    LayoutRandomIsSquareLayout: TTntCheckBox;
    CommonAutoArrangeWindows: TTntCheckBox;
    TabSheetSkin: TTntTabSheet;
    SkinLabelUsed: TTntLabel;
    ComboBox3: TTntComboBox;
    SkinAnimateOnlyActivePlayer: TTntCheckBox;
    Bevel7: TBevel;
    SkinAccentActivePlayer: TTntCheckBox;
    LimitsWordLengthNoLess: TTntCheckBox;
    LimitsComboboxListLetter: TTntComboBox;
    TabSheetLanguages: TTntTabSheet;
    SkinColoredTiles: TTntCheckBox;
    SkinShadows: TTntCheckBox;
    Panel4: TPanel;
    RxSpinEdit6: TRxSpinEdit;
    AlphabetLabelLetterScore: TTntLabel;
    AlphabetLabelLetterQuantity: TTntLabel;
    RxSpinEdit1: TRxSpinEdit;
    OP_Label29: TTntLabel;
    SpeedButton6: TTntSpeedButton;
    Bevel9: TBevel;
    OP_Label30: TTntLabel;
    DictionaryRadioButtonSizeChildren: TTntRadioButton;
    AlphabetButtonDefault: TTntSpeedButton;
    LanguageButtonAlphabet: TTntSpeedButton;
    Bevel10: TBevel;
    LanguageLabelInterfaceLanguage: TTntLabel;
    ComboBox1: TTntComboBox;
    LanguageLabelDictionaryLanguage: TTntLabel;
    ComboBox4: TTntComboBox;
    LanguageLabelExplanatoryLanguage: TTntLabel;
    ComboBox5: TTntComboBox;
    Bevel1: TBevel;
    Bevel11: TBevel;
    DictionaryRulesConfirmAddWordExplanation: TTntCheckBox;
    SkinShowDictionaryPanel: TTntCheckBox;
    MapPreview: TImage;
    Shape6: TShape;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure LimitsRadioButtonNoLimitsClick(Sender: TObject);
    procedure LimitsRadioButtonScore100Click(Sender: TObject);
    procedure LayoutRadioButtonFromFileClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure MusicListboxFilesInSelectedFolderClick(Sender: TObject);
    procedure MusicButtonAddClick(Sender: TObject);
    procedure MusicButtonAddAllClick(Sender: TObject);
    procedure MusicListboxSelectedSongsClick(Sender: TObject);
    procedure MusicButtonRemoveClick(Sender: TObject);
    procedure MusicButtonRemoveAllClick(Sender: TObject);
    procedure MusicGroupBackgroundMusicClick(Sender: TObject);
    procedure DirectoryEditChange(Sender: TObject);
    procedure DictionaryGroupUseUserDictionaryClick(Sender: TObject);
    procedure UserDictionaryButtonWordAddClick(Sender: TObject);
    procedure UserDictionaryButtonWordUnAddClick(Sender: TObject);
    procedure UserDictionaryButtonWordExcludeClick(Sender: TObject);
    procedure UserDictionaryButtonWordUnExcludeClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure TextboxCustomWordCommentExit(Sender: TObject);
    procedure ListBox1Enter(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure CommonRulesPermitReuseBlankTileClick(Sender: TObject);
    procedure Edit3Enter(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure DictionaryButtonThemesClick(Sender: TObject);
    procedure LimitsMoveTimeClick(Sender: TObject);
    procedure LimitsRadioButtonTime10minutesClick(Sender: TObject);
    procedure green_SpinEditEnter(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure DimX_SpinEditChange(Sender: TObject);
    procedure CommonChiefInRoomClick(Sender: TObject);
    procedure DimY_SpinEditChange(Sender: TObject);
    procedure LayoutRandomIsSquareLayoutClick(Sender: TObject);
    procedure LimitsWordLengthNoLessClick(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure RxSpinEdit1TopClick(Sender: TObject);
    procedure RxSpinEdit1BottomClick(Sender: TObject);
    procedure RxSpinEdit6TopClick(Sender: TObject);
    procedure RxSpinEdit6BottomClick(Sender: TObject);
    procedure TabSheetLanguagesShow(Sender: TObject);
    procedure AlphabetButtonDefaultClick(Sender: TObject);
    procedure LanguageButtonAlphabetClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure RxSpinEdit6Change(Sender: TObject);
    procedure RxSpinEdit1Change(Sender: TObject);
    procedure TabSheetLayoutShow(Sender: TObject);
    procedure LayoutRadioButtonRandomClick(Sender: TObject);
  private
    { Private declarations }
    procedure LangButtonClick(Sender: TObject);    
  public
    { Public declarations }
  end;

  String255=string[255];

var
  Options: TOptions;
  SongFile:file of SongFileType;
  NewResolution:boolean;
  MapFiles, ThemeCodes:TStringList;
  dim1,dim2:byte;

implementation


uses Main;
var  CustomAddFile, CustomDelFile:textfile; CustomWord:string;
     CurrentIndex:integer; CurrentListBox:TListBox;
     TempLanguageExpl:string;
     AlphabetEdited:boolean;

procedure SaveWordsWithCommentsToFile; forward;
procedure CreateExplLangButtons; forward;
{$R *.DFM}
{ ------------------------------------------------------------ }
{ считаем количество фишек всего }
function LettersSumm:word;
var I:byte;
begin
  result:=0;
  For I:=0 to AlphCount do
    Result:=Result+LettersQuantity[I];
end;

{ ------------------------------------------------------------ }
{ закрывается окно "НАСТРОЙКИ" }
procedure TOptions.FormClose(Sender: TObject; var Action: TCloseAction);
const Rect: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);
var Song:SongFileType; I,j:byte; AlphFile:textfile; TempStrings:TStringList;
begin
If Tag>0 Then begin TabSheetCommon.TabVisible:=True; TabSheetDictionary.TabVisible:=True;
                    TabSheetLimits.TabVisible:=True; TabSheetMusic.TabVisible:=True; end;
SetCurrentDir(CurrentDir);
ReferenceOn:=not (LanguageExpl='');
If LanguageExpl<>'' Then
   MainScreen.Caption:=GlobalTextStrings.Items.Values['Title']+' 1.6 beta '+GlobalTextStrings.Items.Values['TitleSuffixWithExplanatoryDictionary']
                    Else MainScreen.Caption:=GlobalTextStrings.Items.Values['Title']+' 1.6 beta';
If ModalResult=mrOk Then begin
  Screen.Cursor:=crHourGlass;
   try
   if Edit3.text='0' then Edit3.Text:='O';
   StrToInt(trim(Edit3.Text))
   except
   if LimitsRadioButtonScoreUserSelected.Checked Then begin
      OptionsPageControl.ActivePage:=OptionsPageControl.Pages[3];
      Application.MessageBox(PChar(GlobalTextStrings.Items.Values['OptionsMessageWrongScore']), '',0);
      Screen.Cursor:=crDefault;
      Action:=caNone; exit;
                           end;
   end;
   Theme:='';
   ShowClearedWords:=CommonShowPCwords.Checked;
   ShowColorLetters:=SkinColoredTiles.Checked;
   ShowAdvancedHallFame:=CommonShowAllUserBestScores.Checked;
   ShowShadows:=SkinShadows.Checked;
   PlayBackgroundMusic:=MusicGroupBackgroundMusic.Checked;
   PlayShuffle:=MusicShuffle.Checked;
   PlaySounds:=MusicSoundFX.Checked;
   HintDelay:=TrackBar1.Position;
   HintPushButton:=HintWaitKeypress.Checked;
   CustomDict.Use:=DictionaryGroupUseUserDictionary.Checked;
   CustomDict.WordRequired:=DictionaryRulesRadioButtonUserCannotAddWords.Checked;
   CustomDict.WarnDelete:=DictionaryRulesConfirmWordExclude.Checked;
   CustomDict.WarnAddExplanation:=DictionaryRulesConfirmAddWordExplanation.Checked;
   CrossWord_Mode:=CommonRulesCrossword.Checked;
   FlashStarMarkers:=CommonRulesSlashBlankTiles.Checked;
   TakeStar:=CommonRulesPermitReuseBlankTile.Checked;
   RepeatTurn:=DictionaryRulesPCReplayAfterExcludeWord.Checked;
   AllowSelect:=CommonRulesFreeWordPlacement.Checked;
   AllowWordRepeat:=CommonRulesAllowRepeatWords.Checked;
   LettersAutoSelect:=CommonAutoGetLetters.Checked;
   MinimizeOnEsc:=CommonChiefInRoom.Checked;
   RunMinimized:=not PauseOnMinimazed.Checked;
   KeepBonuses:=CommonRulesReusePrizeCells.Checked;
   AllPlayersOpen:=CommonAutoArrangeWindows.Checked;
   AnimActiveAvatar:=SkinAnimateOnlyActivePlayer.Checked;
   AnimActivePlayer:=SkinAccentActivePlayer.Checked;
   AlwaysShowDictionaryPanel:=SkinShowDictionaryPanel.Checked;
   Skin:=Combobox3.text;
   LimitWordLength:=(LimitsComboboxListLetter.ItemIndex+2)*ord(LimitsWordLengthNoLess.Checked);

   { пишем Юникод файл с алфавитом }
  If AlphabetEdited then begin
   If not Fileexists('dict\'+LanguageDict+'\alphabet.def') and Fileexists('dict\'+LanguageDict+'\alphabet.txt') then CopyFile(PChar('dict\'+LanguageDict+'\alphabet.txt'),PChar('dict\'+LanguageDict+'\alphabet.def'),true);
   TempStrings:=TStringList.Create;
   For I:=0 to AlphCount Do begin
      If I<>AlphCount Then
         TempStrings.Add(chr(LettersCodes[I])+','+IntToStr(LettersValue[I])+','+IntToStr(LettersQuantity[I]))
                      Else
         TempStrings.Add('*,'+IntToStr(LettersValue[I])+','+IntToStr(LettersQuantity[I]));
                             end;
   SaveUnicodeFile('dict\'+LanguageDict+'\alphabet.txt',TempStrings,nil,GetLanguageCodepage(LanguageDict)<>1251,convert);
   TempStrings.Free;
                         end;
   SoundVolume:=TrackBar3.Position;
   MusicVolume:=TrackBar4.Position;
   If TrackBar2.Enabled Then begin
       HintLimit:=(TrackBar2.Position+1)*2+1;
          If TrackBar2.Position=3 Then HintLimit:=10;
       StoreHintLimit:=HintLimit;
                             end;
  If FinishGame Then begin
  WorkFieldDimentionX:=trunc(dimX_Spinedit.Value);
  WorkFieldDimentionY:=trunc(dimY_Spinedit.Value);
  If LayoutRadioButtonFromFile.Checked Then begin
                                     Template:=MapFiles.Strings[ComboBox2.ItemIndex];
                                     WorkFieldDimentionX:=StrToInt(copy(ComboBox2.Text,pos('(',ComboBox2.Text)+1,2));
                                     WorkFieldDimentionY:=StrToInt(copy(ComboBox2.Text,pos('x',ComboBox2.Text)+1,2));
                                 end;
  If LayoutRadioButtonRandom.Checked Then Template:='';
  ColorsCount[Green]:=trunc(green_Spinedit.Value);
  ColorsCount[Yellow]:=trunc(yel_Spinedit.Value);
  ColorsCount[Blue]:=trunc(blu_Spinedit.Value);
  ColorsCount[Red]:=trunc(red_Spinedit.Value);
  ColorsCount[Black]:=trunc(blak_Spinedit.Value);
                     end;
  { пишем темы }
  If ThemeCodes.IndexOfName(LanguageDict)=-1 Then ThemeCodes.Add(LanguageDict+'=');
  ThemeCodes.Values[LanguageDict]:='';
  If ThemesTipListBox.Items.Count<>0 Then
    For I:=0 to ThemesTipListBox.Items.Count-1 Do
      If not ThemesTipListBox.Checked[I] Then ThemeCodes.Values[LanguageDict]:=ThemeCodes.Values[LanguageDict]+ThemesTipListBox.HelpKeyword[I+1];
  If ThemeCodes.IndexOfName('Lim'+LanguageDict)=-1 Then ThemeCodes.Add('Lim'+LanguageDict+'=');
  If DictionaryRadioButtonSizeMax.Checked then ThemeCodes.Values['Lim'+LanguageDict]:='';
  If DictionaryRadioButtonSizeNormal.Checked then ThemeCodes.Values['Lim'+LanguageDict]:=DictSpec[0];
  If DictionaryRadioButtonSizeExtended.Checked then ThemeCodes.Values['Lim'+LanguageDict]:=DictSpec[1];
  If DictionaryRadioButtonSizeChildren.Checked then ThemeCodes.Values['Lim'+LanguageDict]:=DictSpec[6];
  ThemeListForAll:=ThemeCodes.Text;
  ThemeList:=ThemeCodes.Values[LanguageDict];
  Theme:=ThemeCodes.Values['Lim'+LanguageDict];

  If DictionaryRulesRadioButtonAddNewWordWithoutConfirm.Checked then CustomDict.AddWord:=YES;
  If DictionaryRulesRadioButtonConfirmAddNewWord.Checked then CustomDict.AddWord:=ASK;
  If DictionaryRulesRadioButtonUserCannotAddWords.Checked then CustomDict.AddWord:=NO;

  Limit:='';
  If LimitsRadioButtonNoLimits.Checked Then Limit:='';
  If LimitsRadioButtonScore100.Checked Then Limit:='Score-100 ';
  If LimitsRadioButtonScore500.Checked Then Limit:='Score-500 ';
  If LimitsRadioButtonScore300.Checked Then Limit:='Score-300 ';
  If LimitsRadioButtonScoreUserSelected.Checked Then Limit:='Score-'+Edit3.Text+' ';
  If LimitsRadioButtonTime10minutes.Checked Then Limit:='Time-10 ';
  If LimitsRadioButtonTime20minutes.Checked Then Limit:='Time-20 ';
  If LimitsRadioButtonTime30minutes.Checked Then Limit:='Time-30 ';
  If LimitsRadioButtonTime45minutes.Checked Then Limit:='Time-45 ';
  If LimitsRadioButtonTime1Hour.Checked Then Limit:='Time-60 ';
  If LimitsMoveTime.Checked Then Limit:=Limit+' Move-'+copy(LimitsComboboxListMoveTime.Text,1,2);


AssignFile(SongFile,CurrentDir+'\MEDIA\songs.lst'); ReWrite(SongFile);
If MusicListboxSelectedSongs.Items.Count>0 then
For I:=0 to MusicListboxSelectedSongs.Items.Count-1 do begin
Song.Name:=MusicListboxSelectedSongs.Items[i];
Song.Path:=PathList.Items[i];
Write(SongFile,Song);
                           end;
CloseFile(SongFile);

                         end;
ThemeCodes.free; MapFiles.Free;
Screen.Cursor:=crDefault;
end;
{ ------------------------------------------------------------- }
{ загрузка пользовательских словарей }
procedure LoadCustomDictionaries;
 var I,k:word; tempStr,TempStr1:widestring;
begin
{пользовательские словари}
AssignFile(CustomAddFile,CurrentDir+'\dict\'+LanguageDict+'\diction.user.add.txt');
AssignFile(CustomDelFile,CurrentDir+'\dict\'+LanguageDict+'\diction.user.del.txt');
 with Options do
    begin
 ListBox1.Font.Charset:=SetCharset(LanguageDict);
 ListBox1.Items.Clear; BufferList1.Items.Clear;
if fileexists(CurrentDir+'\dict\'+LanguageDict+'\diction.user.add.txt') Then
begin
  LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\diction.user.add.txt',ListBox1.Items,nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
  If ListBox1.Count>0 Then
    For I:=0 to ListBox1.Count-1 Do
    if pos('=', ListBox1.Items[i])<>0 Then begin
                                     BufferList1.Items.Add(copy(ListBox1.Items[i],pos('=',ListBox1.Items[i])+1,255));
                                     ListBox1.Items[I]:=copy(ListBox1.Items[i],1,pos('=',ListBox1.Items[i])-1);
                                     end
                                Else begin
                                     BufferList1.Items.Add('');
                                     end;
end;

 ListBox2.Items.Clear; BufferList2.Items.Clear;
 ListBox2.Font.Charset:=SetCharset(LanguageDict);
if fileexists(CurrentDir+'\dict\'+LanguageDict+'\diction.user.del.txt') Then
begin
  LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\diction.user.del.txt',ListBox2.Items,nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
  If ListBox2.Count>0 Then
    For I:=0 to ListBox2.Count-1 Do
    if pos('=', ListBox2.Items[i])<>0 Then begin
                                     BufferList2.Items.Add(copy(ListBox2.Items[i],pos('=',ListBox2.Items[i])+1,255));
                                     ListBox2.Items[I]:=copy(ListBox2.Items[i],1,pos('=',ListBox2.Items[i])-1);
                                     end
                                Else begin
                                     BufferList2.Items.Add('');
                                     end;
end;
TextboxCustomWordComment.Clear;
  end;
end;
{ ------------------------------------------------------------- }
{ создается окно "НАСТРОЙКИ" }
procedure TOptions.FormActivate(Sender: TObject);
var Song:SongFileType; I:byte; TempFile:textfile; sr,sr1:TSearchRec; TempStr,TempStrX, TempStrY:String;
    sLanguage: string;
begin
    LimitsComboboxListMoveTime.Text:=LimitsComboboxListMoveTime.Items[0];
    CommonShowPCwords.Checked:=ShowClearedWords;
    CommonShowAllUserBestScores.Checked:=ShowAdvancedHallFame;
    SkinShadows.Checked:=ShowShadows;
//    CheckBox2.ChFecked:=FullScreen;
//    NewResolution:=Checkbox2.Checked;
    MusicGroupBackgroundMusic.Checked:=PlayBackgroundMusic;
    MusicSoundFX.Checked:=PlaySounds;
    SkinColoredTiles.Checked:=ShowColorLetters;
    MusicShuffle.Checked:=PlayShuffle;
    TrackBar1.Position:=HintDelay; TrackBar1.Show;
    HintWaitKeypress.Checked:=HintPushButton;
    DictionaryGroupUseUserDictionary.Checked:=CustomDict.Use;
    GroupBox1.Enabled:=CustomDict.Use;
    DictionaryRulesRadioButtonUserCannotAddWords.Checked:=CustomDict.WordRequired;
    DictionaryRulesConfirmWordExclude.Checked:=CustomDict.WarnDelete;
    DictionaryRulesConfirmAddWordExplanation.Checked:=CustomDict.WarnAddExplanation;
    CommonRulesCrossword.Checked:=CrossWord_Mode;
    CommonRulesPermitReuseBlankTile.Checked:=TakeStar;
    CommonRulesSlashBlankTiles.Checked:=FlashStarMarkers;
    CommonRulesSlashBlankTiles.Enabled:=TakeStar;
    DictionaryRulesPCReplayAfterExcludeWord.Checked:=RepeatTurn;
    CommonRulesFreeWordPlacement.Checked:=AllowSelect;
    CommonRulesAllowRepeatWords.Checked:=AllowWordRepeat;
    CommonAutoGetLetters.Checked:=LettersAutoSelect;
    TrackBar3.Position:=SoundVolume;
    TrackBar4.Position:=MusicVolume;
    CommonChiefInRoom.Checked:=MinimizeOnEsc;
    PauseOnMinimazed.Checked:=not RunMinimized;
    PauseOnMinimazed.Enabled:=CommonChiefInRoom.Checked;
    CommonRulesReusePrizeCells.Checked:=KeepBonuses;
    CommonAutoArrangeWindows.Checked:=AllPlayersOpen;
    SkinAnimateOnlyActivePlayer.Checked:=AnimActiveAvatar;
    SkinAccentActivePlayer.Checked:=AnimActivePlayer;
    SkinShowDictionaryPanel.Checked:=AlwaysShowDictionaryPanel;
    LimitsWordLengthNoLess.Checked:=LimitWordLength<>0;
    LimitsComboboxListLetter.Enabled:=LimitsWordLengthNoLess.Checked;
    LimitsComboboxListLetter.ItemIndex:=(LimitWordLength-2)*ord(LimitWordLength<>0);
    If WorkFieldDimentionX=WorkFieldDimentionY Then LayoutRandomIsSquareLayout.Checked:=true Else LayoutRandomIsSquareLayout.Checked:=false;
    dimX_Spinedit.Value:=WorkFieldDimentionX;
    dimY_Spinedit.Value:=WorkFieldDimentionY;

    { настройки языков }
    ComboBox1.HelpKeyword:=''; ComboBox1.Items.Clear;
    If FindFirst(CurrentDir+'\lang\*',faDirectory,sr)=0 Then begin
     repeat
        if (pos(sr.Name,'..')=0) and (sr.Attr and faDirectory<>0)
           Then begin
                   try
                     //GetLocaleInfo(StrToInt(TempStrings.Values[ANSIUpperCase(sr.name)]),LOCALE_SLANGUAGE,sLanguage, 100);
                     sLanguage:=getLanguageName(ANSIUpperCase(sr.Name));
                     ComboBox1.Items.Add(LeftStr(string(sLanguage),pos('(',string(sLanguage))-1+100*ord(pos('(',string(sLanguage))=0)));
                     ComboBox1.HelpKeyword:=ComboBox1.HelpKeyword+sr.Name;
                   except end;
                   If sr.Name=Language Then ComboBox1.Text:=ComboBox1.Items[Combobox1.Items.count-1];
                  end;
      until FindNext(sr)<>0;
                                                            end;
    ComboBox4.HelpKeyword:=''; ComboBox4.Items.Clear;
    If FindFirst(CurrentDir+'\dict\*',faDirectory,sr)=0 Then begin
     repeat
        if (pos(sr.Name,'..')=0) and (sr.Attr and faDirectory<>0)
           Then begin
                   try
                     //GetLocaleInfo(StrToInt(TempStrings.Values[ANSIUpperCase(sr.name)]),LOCALE_SLANGUAGE,sLanguage, 100);
                     sLanguage:=getLanguageName(ANSIUpperCase(sr.Name));
                     ComboBox4.Items.Add(LeftStr(string(sLanguage),pos('(',string(sLanguage))-1+100*ord(pos('(',string(sLanguage))=0)));
                     ComboBox4.HelpKeyword:=ComboBox4.HelpKeyword+sr.Name;
                   except end;
                   If sr.Name=LanguageDict Then ComboBox4.Text:=ComboBox4.Items[Combobox4.Items.count-1];
                  end;
      until FindNext(sr)<>0;
                                                            end;
    ComboBox5.HelpKeyword:=''; ComboBox5.Items.Clear;
    If FindFirst(CurrentDir+'\dict\'+LanguageDict+'\expl\*',faDirectory,sr)=0 Then begin
     repeat
        if (pos(sr.Name,'..')=0) and (sr.Attr and faDirectory<>0)
           Then begin
                   try
                     //GetLocaleInfo(StrToInt(TempStrings.Values[ANSIUpperCase(sr.name)]),LOCALE_SLANGUAGE,sLanguage, 100);
                     sLanguage:=getLanguageName(ANSIUpperCase(sr.Name));
                     ComboBox5.Items.Add(LeftStr(string(sLanguage),pos('(',string(sLanguage))-1+100*ord(pos('(',string(sLanguage))=0)));
                     ComboBox5.HelpKeyword:=ComboBox5.HelpKeyword+sr.Name;
                   except end;
                   If sr.Name=LanguageExpl Then ComboBox5.Text:=ComboBox5.Items[Combobox5.Items.count-1];
                  end;
      until FindNext(sr)<>0;
                                                            end;
    For I:=0 to TabSheetLanguages.ControlCount-1 Do
       (TabSheetLanguages.Controls[i] as TControl).Enabled:=Finishgame or ((TabSheetLanguages.Controls[i] as TControl).name='LanguageButtonAlphabet');
    For I:=0 to Panel4.ControlCount-1 Do
       (Panel4.Controls[i] as TControl).Enabled:=Finishgame;
    AlphabetButtonDefault.Enabled:=finishgame and FileExists('dict\'+LanguageDict+'\alphabet.def');

    { настройки игрового поля }
    Combobox2.Items.Clear;
    if FindFirst(CurrentDir+'\MAPS\*.map',0,sr)=0 Then begin
        MapFiles:=TStringList.Create;
        repeat
        AssignFile(TempFile,CurrentDir+'\MAPS\'+sr.Name);
        Reset(TempFile);
        Readln(TempFile,TempStrX);
        MapFiles.Add(sr.Name);
        ComboBox2.Items.Add(TempStrX);
        Readln(TempFile,TempStrX);
        TempStrY:='x';
        while not EOF(TempFile) do  begin readln(TempFile,TempStr); If TempStr<>'' Then TempStrY:=TempStrY+'x'; end;
        ComboBox2.Items[ComboBox2.Items.Count-1]:=ComboBox2.Items[ComboBox2.Items.Count-1]+' ('+IntToStr(length(TempStrX))+'x'+IntToStr(length(TempStrY))+')';
        CloseFile(TempFile);
        until FindNext(sr)<>0;
        Combobox2.ItemIndex:=MapFiles.IndexOf(Template);
                                          end;
    If (Template='') or (Combobox2.ItemIndex=-1)  Then LayoutRadioButtonRandom.Checked:=true
                                       Else LayoutRadioButtonFromFile.Checked:=true;
    green_Spinedit.Value:=ColorsCount[Green]; green_Spinedit.MaxValue:=(WorkFieldDimentionX*WorkFieldDimentionY) div 5;
    yel_Spinedit.Value:=ColorsCount[Yellow]; yel_Spinedit.MaxValue:=(WorkFieldDimentionX*WorkFieldDimentionY) div 5;
    blu_Spinedit.Value:=ColorsCount[Blue]; blu_Spinedit.MaxValue:=(WorkFieldDimentionX*WorkFieldDimentionY) div 5;
    red_Spinedit.Value:=ColorsCount[Red]; red_Spinedit.MaxValue:=(WorkFieldDimentionX*WorkFieldDimentionY) div 5;
    blak_Spinedit.Value:=ColorsCount[Black]; blak_Spinedit.MaxValue:=(WorkFieldDimentionX*WorkFieldDimentionY) div 5;
    TabSheetLayout.Enabled:=FinishGame;
    For I:=0 to TabSheetLayout.ControlCount-1 Do TabSheetLayout.Controls[I].Enabled:=Finishgame;

    case CustomDict.AddWord of
      NO:  DictionaryRulesRadioButtonUserCannotAddWords.Checked:=True;
      YES: DictionaryRulesRadioButtonAddNewWordWithoutConfirm.Checked:=True;
      ASK: DictionaryRulesRadioButtonConfirmAddNewWord.Checked:=True;
    end;
    For i:=0 to GroupBox1.ControlCount-1 Do
       GroupBox1.Controls[i].Enabled:=CustomDict.Use;
    If Options.Hint='FinishGame' Then
       TrackBar2.Position:=((HintLimit-1) div 2)-1
                                 Else
       TrackBar2.Position:=((StoreHintLimit-1) div 2)-1; TrackBar2.Show;

 { если вызывается из игры удаление.добавление слов, отображаем вторую вкладку, иначе какую требуется}
 If Tag>20 Then begin OptionsPageControl.ActivePage:=OptionsPageControl.Pages[2]; ButtonCancel.Enabled:=false; end
           Else begin OptionsPageControl.ActivePage:=OptionsPageControl.Pages[Tag]; ButtonCancel.Enabled:=true; end;

 { настройки тем }
 ThemeCodes:=TStringList.Create;
 ThemeCodes.Text:=ThemeListForAll;
 If ThemesTipListBox.Items.Count>0 Then
   For I:=0 to ThemesTipListBox.Items.Count-1 Do
     ThemesTipListBox.Checked[I]:=(pos(ThemesTipListBox.HelpKeyword[I+1],ThemeCodes.Values[LanguageDict])=0);

 Theme:=ThemeCodes.Values['Lim'+LanguageDict];
 If Theme='' Then DictionaryRadioButtonSizeMax.Checked:=True
             Else
 If Theme=DictSpec[0] Then DictionaryRadioButtonSizeNormal.Checked:=True
             Else
 If Theme=DictSpec[1] Then DictionaryRadioButtonSizeExtended.Checked:=True
             Else
 If Theme=DictSpec[6] Then DictionaryRadioButtonSizeChildren.Checked:=True;


 { настройки ограничений }
 If not (Options.Hint='FinishGame') Then
  begin LimitsRadioButtonNoLimits.Enabled:=False; LimitsRadioButtonScore100.Enabled:=False;
        LimitsRadioButtonScore500.Enabled:=False; LimitsRadioButtonScoreUserSelected.Enabled:=False;
        LimitsRadioButtonScore300.Enabled:=False; LimitsMoveTime.Enabled:=False;
        LimitsRadioButtonTime1Hour.Enabled:=False; LimitsRadioButtonTime30minutes.Enabled:=False;
        LimitsRadioButtonTime20minutes.Enabled:=False; LimitsRadioButtonTime10minutes.Enabled:=False;
        LimitsRadioButtonTime45minutes.Enabled:=False; HintLabelQuantity.Enabled:=false;
        LimitsComboboxListMoveTime.Enabled:=False; Edit3.Enabled:=false;
        TrackBar2.Enabled:=False;
        Label6.Enabled:=False; Label7.Enabled:=False;
        Label8.Enabled:=False; Label9.Enabled:=False;
        Label10.Enabled:=False;
  end
                   Else
  begin DictionaryRadioButtonSizeMax.Enabled:=True; DictionaryRadioButtonSizeNormal.Enabled:=True;
        LimitsRadioButtonNoLimits.Enabled:=True; Edit3.Enabled:=true;
        LimitsRadioButtonScore100.Enabled:=True;
        LimitsRadioButtonScore500.Enabled:=True; LimitsRadioButtonScoreUserSelected.Enabled:=True;
        LimitsRadioButtonScore300.Enabled:=True; LimitsMoveTime.Enabled:=True;
        LimitsRadioButtonTime1Hour.Enabled:=True; LimitsRadioButtonTime30minutes.Enabled:=True;
        LimitsRadioButtonTime20minutes.Enabled:=True; LimitsRadioButtonTime10minutes.Enabled:=True;
        LimitsRadioButtonTime45minutes.Enabled:=True; HintLabelQuantity.Enabled:=true;
        If LimitsMoveTime.Checked Then LimitsComboboxListMoveTime.Enabled:=True;
        TrackBar2.Enabled:=True;
        Label6.Enabled:=True; Label7.Enabled:=True;
        Label8.Enabled:=True; Label9.Enabled:=True;
        Label10.Enabled:=True;
    end;
 LimitsComboboxListMoveTime.ItemIndex:=0;
 If pos(' Move',Limit)<>0 Then begin
    LimitsMoveTime.Checked:=True;
    LimitsComboboxListMoveTime.Text:=LimitsComboboxListMoveTime.Items[StrToInt(copy(Limit,pos('Move',Limit)+5,1))-1];
    LimitsComboboxListMoveTime.ItemIndex:=StrToInt(copy(Limit,pos('Move',Limit)+5,1))-1;
    end;
 If Limit='' Then LimitsRadioButtonNoLimits.Checked:=True Else
 If pos('Score-100 ',Limit)<>0 Then LimitsRadioButtonScore100.Checked:=True Else
 If pos('Score-500 ',Limit)<>0 Then LimitsRadioButtonScore500.Checked:=True Else
 If pos('Score-300 ',Limit)<>0 Then LimitsRadioButtonScore300.Checked:=True Else
 If pos('Time-10 ',Limit)<>0 Then LimitsRadioButtonTime10minutes.Checked:=True Else
 If pos('Time-20 ',Limit)<>0 Then LimitsRadioButtonTime20minutes.Checked:=True Else
 If pos('Time-30 ',Limit)<>0 Then LimitsRadioButtonTime30minutes.Checked:=True Else
 If pos('Time-45 ',Limit)<>0 Then LimitsRadioButtonTime45minutes.Checked:=True Else
 If pos('Time-60 ',Limit)<>0 Then LimitsRadioButtonTime1Hour.Checked:=True Else
  if pos(' Move',Limit)=0
       Then begin LimitsRadioButtonScoreUserSelected.Checked:=true; Edit3.Text:=copy(Limit,7,4); end;

 { музыкальные настройки }
MusicListboxSelectedSongs.Items.Clear; PathList.Items.Clear; ShuffleList.Items.Clear;
if FileExists(CurrentDir+'\MEDIA\songs.lst') Then begin
AssignFile(SongFile,CurrentDir+'\MEDIA\songs.lst'); Reset(SongFile);
While not EOF(SongFile) do begin
Read(SongFile,Song);
MusicListboxSelectedSongs.Items.Add(Song.Name); PathList.Items.Add(Song.Path);
ShuffleList.Items.Add('!');
                           end;
CloseFile(SongFile);
                                      end;
If (PlaySong<MusicListboxSelectedSongs.Items.Count) and not FinishGame and PlayBackgroundMusic
 Then MusicListboxSelectedSongs.Selected[PlaySong]:=True;
MusicListboxFilesInSelectedFolder.Directory:=DirectoryEdit.Text;
If Not EnableSoundHardware Then begin
   MusicSoundFX.Enabled:=False; MusicSoundFX.Checked:=False;
   MusicGroupBackgroundMusic.Enabled:=False; MusicGroupBackgroundMusic.Checked:=False;
   end;
If MusicGroupBackgroundMusic.Checked=False Then begin
   MusicLabelPlaylist.Enabled:=False; Label12.Enabled:=False;
   MusicListboxSelectedSongs.Enabled:=False; MusicListboxFilesInSelectedFolder.Enabled:=False;
   MusicListboxFilesInSelectedFolder.Font.Color:=clGray;
   MusicButtonAdd.Enabled:=False; MusicButtonAddAll.Enabled:=False;
   MusicButtonRemove.Enabled:=False; MusicButtonRemoveAll.Enabled:=False;
   DirectoryEdit.Enabled:=False; MusicShuffle.Enabled:=False;
                               end
Else begin
   MusicLabelPlaylist.Enabled:=True; Label12.Enabled:=True;
   MusicListboxSelectedSongs.Enabled:=True; MusicListboxFilesInSelectedFolder.Enabled:=True;
   MusicListboxFilesInSelectedFolder.Font.Color:=clBlack;
   MusicButtonAdd.Enabled:=True; MusicButtonAddAll.Enabled:=True;
   MusicButtonRemove.Enabled:=True; MusicButtonRemoveAll.Enabled:=True;
   DirectoryEdit.Enabled:=True; MusicShuffle.Enabled:=True;
     end;
If MusicListboxSelectedSongs.Items.Count=0 Then begin MusicButtonRemove.Enabled:=False; MusicButtonRemoveAll.Enabled:=False end
                       Else begin MusicButtonRemove.Enabled:=True; MusicButtonRemoveAll.Enabled:=True end;
If MusicListboxFilesInSelectedFolder.Items.Count=0 Then begin MusicButtonAdd.Enabled:=False; MusicButtonAddAll.Enabled:=False end
                       Else begin MusicButtonAdd.Enabled:=True; MusicButtonAddAll.Enabled:=True end;


LoadCustomDictionaries;

// если добавляем толкование во время игры
If Options.Tag=22 Then begin
  If LanguageExpl='' Then TempLanguageExpl:=LanguageDict Else TempLanguageExpl:=LanguageExpl;
  Options.UserDictionaryButtonWordAdd.Click;
  CreateExplLangButtons;
  Options.TextboxCustomWordComment.SetFocus;
                      end;
If Options.Tag=23 Then begin
  Options.UserDictionaryButtonWordExclude.Show;
  Options.UserDictionaryButtonWordExclude.Click;
  Options.TextboxCustomWordComment.SetFocus;
                      end;
AlphabetEdited:=false;
end;

{ ------------------------------------------------------------- }
{ выбираем опцию "Без ограничений" }
procedure TOptions.LimitsRadioButtonNoLimitsClick(Sender: TObject);
begin
LimitsComboboxListMoveTime.Enabled:=False;
LimitsRadioButtonScore100.Checked:=False; LimitsRadioButtonTime45minutes.Checked:=False;
LimitsRadioButtonScore500.Checked:=False; LimitsRadioButtonScoreUserSelected.Checked:=False;
LimitsRadioButtonScore300.Checked:=False; LimitsMoveTime.Checked:=False;
LimitsRadioButtonTime1Hour.Checked:=False; LimitsRadioButtonTime30minutes.Checked:=False;
LimitsRadioButtonTime20minutes.Checked:=False; LimitsRadioButtonTime10minutes.Checked:=False;
DictionaryRulesRadioButtonUserCannotAddWords.Checked:=False;
end;
{ ------------------------------------------------------------- }
{ выбираем опцию ограничений }
procedure TOptions.LimitsRadioButtonScore100Click(Sender: TObject);
begin
LimitsRadioButtonNoLimits.Checked:=False;
end;

procedure TOptions.LayoutRadioButtonFromFileClick(Sender: TObject);
begin
{ComboBox1.Enabled:=True;
RadioButton4.Checked:=False;}
If ComboBox2.ItemIndex=-1 Then Combobox2.ItemIndex:=0;
TabSheetLayoutShow(self);
end;
{ ------------------------------------------------------------- }
{ нажимаем клавиши }
procedure TOptions.FormKeyPress(Sender: TObject; var Key: Char);
begin
If key=#27 Then ModalResult:=mrNo;
If key=#13 Then ModalResult:=mrOk;
end;

{ ------------------------------------------------------------- }
{ обработчик кнопок языков }
procedure TOptions.LangButtonClick(Sender: TObject);
begin
SaveWordsWithCommentsToFile;
TempLanguageExpl:=(sender as TSpeedButton).Caption;
Options.TextboxCustomWordComment.Font.Charset:=SetCharset(TempLanguageExpl);
ListBox1Click(ListBox1);
end;

{ ------------------------------------------------------------- }
{ создаем кнопки языков }
procedure CreateExplLangButtons;
var TempSButt,TempSButt1:TSpeedButton; I:byte; sLanguage:string;
var sr:TSearchRec;
begin
  For I:=0 to 10 Do begin Options.FindComponent('Op_LangButton'+IntToStr(I)).Free;
                      end;
 TempSButt1:=nil;
 { создаем кнопки языков }
 If FindFirst(CurrentDir+'\dict\'+LanguageDict+'\expl\*',faDirectory,sr)=0 Then begin
    I:=0;
    repeat
      if (pos(sr.Name,'..')=0) and (sr.Attr and faDirectory<>0)
         Then begin
                  try
                     With TempSButt do begin
                      TempSButt:=TSpeedButton.Create(Options); Parent:=Options.TabSheetUserDictionary;  groupIndex:=2;
                      sLanguage:=getLanguageName(ANSIUpperCase(sr.Name));
                      Caption:=ANSIlowercase(sr.name); Hint:=sLanguage; ShowHint:=true; Flat:=true;
                      Transparent:=true; Font.Color:=clNavy; Font.Style:=[]; Font.Size:=8; Font.Name:='MS San Serif';
                      Name:='Op_LangButton'+IntToStr(I); Cursor:=crHandPoint;
                      OnClick:=Options.LangButtonClick;
                      top:=222; height:=15; width:=40; left:=Options.TabSheetUserDictionary.BoundsRect.Right-18-43*(I+1);
                      //show;
                                       end;
                  except end;
                 If sr.Name=LanguageExpl Then TempSButt1:=TempSButt;
                 inc(I);
                 end;
     until FindNext(sr)<>0;
                                                                                   end;
  If TempSButt1<>nil Then begin TempSButt1.Down:=true; TempLanguageExpl:=TempSButt1.Caption end
                     Else begin
                     I:=0;
                     With TempSButt do begin
                      TempSButt:=TSpeedButton.Create(Options); Parent:=Options.TabSheetUserDictionary;  groupIndex:=2;
                      sLanguage:=getLanguageName(ANSIUpperCase(LanguageDict));
                      Caption:=ANSIlowercase(LanguageDict); Hint:=sLanguage; ShowHint:=true; Flat:=true;
                      Transparent:=true; Font.Color:=clNavy; Font.Style:=[]; Font.Size:=8; Font.Name:='MS San Serif';
                      Name:='Op_LangButton'+IntToStr(I); Cursor:=crHandPoint;
                      OnClick:=Options.LangButtonClick;
                      top:=222; height:=15; width:=40; left:=Options.TabSheetUserDictionary.BoundsRect.Right-18-43*(I+1);
                      Down:=true; //show;
                      TempLanguageExpl:=TempSButt.Caption
                                       end;
                          end;
end;

{----------------------------------------------------------}
procedure TOptions.FormCreate(Sender: TObject);
var sr:TSearchRec;
begin
//CommonShowPCWords.Font.Charset:=EASTEUROPE_CHARSET;
DirectoryEdit.Text:=CurrentDir+'\MEDIA';
If FindFirst(CurrentDir+'\grafix\*',faDirectory,sr)=0 Then begin
   repeat
      if (pos(sr.Name,'..')=0) and (ANSILowerCase(sr.name)<>'players')
         and (sr.Attr and faDirectory<>0) Then ComboBox3.Items.Add(sr.Name);
    until FindNext(sr)<>0;
    //FindClose(0);
                                                                end;
ComboBox3.Text:=Skin;
SetCurrentDir(CurrentDir);
CreateExplLangButtons;
end;

{----------------------------------------------------------}
procedure TOptions.MusicListboxFilesInSelectedFolderClick(Sender: TObject);
begin
MusicButtonAdd.Enabled:=True; MusicButtonAddAll.Enabled:=True;
end;

procedure TOptions.MusicButtonAddClick(Sender: TObject);
var I:byte;
begin
For I:=0 to MusicListboxFilesInSelectedFolder.Items.Count-1 do
If MusicListboxFilesInSelectedFolder.Selected[I] Then
 if MusicListboxSelectedSongs.Items.IndexOf(MusicListboxFilesInSelectedFolder.Items[I])=-1 Then
  begin MusicListboxSelectedSongs.Items.Add(MusicListboxFilesInSelectedFolder.Items[I]);
        PathList.Items.Add(DirectoryEdit.Text+'\');
        ShuffleList.Items.Add(' ');
  end;
MusicButtonRemove.Enabled:=True; MusicButtonRemoveAll.Enabled:=True;
end;

procedure TOptions.MusicButtonAddAllClick(Sender: TObject);
var I:byte;
begin
For I:=0 to MusicListboxFilesInSelectedFolder.Items.Count-1 do
 if MusicListboxSelectedSongs.Items.IndexOf(MusicListboxFilesInSelectedFolder.Items[I])=-1 Then
  begin MusicListboxSelectedSongs.Items.Add(MusicListboxFilesInSelectedFolder.Items[I]);
        PathList.Items.Add(DirectoryEdit.Text+'\');
        ShuffleList.Items.Add(' ');
  end;
MusicButtonRemove.Enabled:=True; MusicButtonRemoveAll.Enabled:=True;
end;

procedure TOptions.MusicListboxSelectedSongsClick(Sender: TObject);
begin
MusicButtonRemove.Enabled:=True; MusicButtonRemoveAll.Enabled:=True;
end;

procedure TOptions.MusicButtonRemoveClick(Sender: TObject);
var I:byte;
begin
I:=0;
While I<=MusicListboxSelectedSongs.Items.Count-1 do begin
If MusicListboxSelectedSongs.Selected[I] Then
   begin MusicListboxSelectedSongs.Items.Delete(I);
         PathList.Items.Delete(I);
         ShuffleList.Items.Delete(I);
         I:=0;
   end;
inc(I);
                 end;
If MusicListboxSelectedSongs.Items.Count=0 Then begin MusicButtonRemove.Enabled:=False; MusicButtonRemoveAll.Enabled:=False end
                       Else begin MusicButtonRemove.Enabled:=True; MusicButtonRemoveAll.Enabled:=True end;
end;

procedure TOptions.MusicButtonRemoveAllClick(Sender: TObject);
begin
MusicListboxSelectedSongs.Items.Clear; PathList.Items.Clear; ShuffleList.Items.Clear;
MusicButtonRemove.Enabled:=False; MusicButtonRemoveAll.Enabled:=False;
end;

procedure TOptions.MusicGroupBackgroundMusicClick(Sender: TObject);
begin
If MusicGroupBackgroundMusic.Checked=False Then begin
   MusicLabelPlaylist.Enabled:=False; Label12.Enabled:=False;
   MusicListboxSelectedSongs.Enabled:=False; MusicListboxFilesInSelectedFolder.Enabled:=False;
   MusicListboxFilesInSelectedFolder.Font.Color:=clGray;
   MusicButtonAdd.Enabled:=False; MusicButtonAddAll.Enabled:=False;
   MusicButtonRemove.Enabled:=False; MusicButtonRemoveAll.Enabled:=False;
   DirectoryEdit.Enabled:=False; MusicShuffle.Enabled:=False;
                               end
Else begin
   MusicLabelPlaylist.Enabled:=True; Label12.Enabled:=True;
   MusicListboxSelectedSongs.Enabled:=True; MusicListboxFilesInSelectedFolder.Enabled:=True;
   MusicListboxFilesInSelectedFolder.Font.Color:=clBlack;
   MusicButtonAdd.Enabled:=True; MusicButtonAddAll.Enabled:=True;
   MusicButtonRemove.Enabled:=True; MusicButtonRemoveAll.Enabled:=True;
   DirectoryEdit.Enabled:=True; MusicShuffle.Enabled:=True;
     end;
end;

procedure TOptions.DirectoryEditChange(Sender: TObject);
begin
MusicListboxFilesInSelectedFolder.Directory:=DirectoryEdit.Text;
If MusicListboxFilesInSelectedFolder.Items.Count=0 Then begin MusicButtonAdd.Enabled:=False; MusicButtonAddAll.Enabled:=False end
                       Else begin MusicButtonAdd.Enabled:=True; MusicButtonAddAll.Enabled:=True end;
end;

procedure TOptions.DictionaryGroupUseUserDictionaryClick(Sender: TObject);
var i:byte;
begin
GroupBox1.Enabled:=DictionaryGroupUseUserDictionary.Checked;
For i:=0 to GroupBox1.ControlCount-1 Do
    GroupBox1.Controls[i].Enabled:=DictionaryGroupUseUserDictionary.Checked;
For i:=0 to GroupBox1.ControlCount-1 Do
    GroupBox1.Controls[i].Enabled:=DictionaryGroupUseUserDictionary.Checked;
end;

procedure TOptions.UserDictionaryButtonWordAddClick(Sender: TObject);
var i:integer; TempStr:string;
begin
If Edit1.Text='' Then exit;
For I:=0 To ListBox1.Count-1 Do
  If Edit1.Text=ListBox1.Items[i] Then begin
     If Options.tag<>22 Then begin
     tempStr:=GlobalTextStrings.Items.Values['OptionsUserDictionaryErrorWordAlreadyInList'];
     If GetLanguageCodepage(Language)<>1251 Then CorrectANSI(TempStr,UTF8encode(GlobalTextStrings.Items.Values['OptionsUserDictionaryErrorWordAlreadyInList']));
     Application.MessageBox(Pchar(TempStr), '',0); exit;
                            end
                       Else begin
     ListBox1.ItemIndex:=I; ListBox1.Selected[I]:=true;
     CurrentIndex:=ListBox1.ItemIndex; ListBox1click(ListBox1);
     ListBox1click(ListBox1);
     ListBox1.SetFocus; exit;
                            end;
                                       end;
For I:=0 To ListBox2.Count-1 Do
  If Edit1.Text=ListBox2.Items[i] Then begin
     tempStr:=GlobalTextStrings.Items.Values['OptionsUserDictionaryCollisionAddingWordAlreadyExcluded'];
     If GetLanguageCodepage(Language)<>1251 Then CorrectANSI(TempStr,UTF8encode(GlobalTextStrings.Items.Values['OptionsUserDictionaryCollisionAddingWordAlreadyExcluded']));
     Application.MessageBox(Pchar(TempStr), '',0); exit;
     //Application.MessageBox(PChar(GlobalTextStrings.Items.Values['OptionsUserDictionaryCollisionAddingWordAlreadyExcluded']), '',0);
     ListBox2.ItemIndex:=I; ListBox2.Selected[I]:=true;
     CurrentIndex:=ListBox2.ItemIndex;
     ListBox2click(ListBox2);
     ListBox2.SetFocus; exit;
                                       end;
TempStr:=Edit1.Text; CorrectANSI(TempStr,utf8encode(Edit1.text));
ListBox1.ClearSelection;
ListBox1.Items.Append(TempStr);
BufferList1.Items.Add('');
TextboxCustomWordComment.Clear;
ListBox1.Selected[ListBox1.Items.IndexOf(TempStr)]:=true;
ListBox1.ItemIndex:=ListBox1.Items.IndexOf(TempStr);
CurrentIndex:=ListBox1.ItemIndex;
CurrentListBox:=ListBox1;
Edit1.Text:='';
{ пишем список слов в юникод файл }
SaveWordsWithCommentsToFile;
{ обновляем список добавленных слов в памяти компьютера }
If DictArray[0]=nil Then DictArray[0]:=TStringList.Create Else DictArray[0].Clear;
LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\diction.user.add.txt', DictArray[0],nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
//CopyDictionary('dict\'+LanguageDict+'\diction.user.add.txt','dict\'+LanguageDict+'\diction.0');
ListBox1.SetFocus; ListBox1.Refresh;
end;

procedure TOptions.UserDictionaryButtonWordUnAddClick(Sender: TObject);
var i:integer; TempStrings:TStringList;
begin
For I:=0 To ListBox1.Count-1 Do BufferList1.selected[i]:=ListBox1.selected[i];
ListBox1.DeleteSelected;
BufferList1.DeleteSelected;
If CurrentIndex>ListBox1.Count-1 Then CurrentIndex:=ListBox1.Count-1;
If ListBox1.Count<>0 Then begin
  ListBox1.ItemIndex:=CurrentIndex; ListBox1click(ListBox1);
  SaveWordsWithCommentsToFile;
  { обновляем список добавленных слов в памяти компьютера }
  If DictArray[0]=nil Then DictArray[0]:=TStringList.Create Else DictArray[0].Clear;
  LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\diction.user.add.txt', DictArray[0],nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
  ListBox1.ItemIndex:=ListBox1.ItemIndex+1;
  ListBox1.Selected[ListBox1.ItemIndex]:=true;
  //ListBox1.ItemIndex:=ListBox1.Items.Count-1;
  CurrentListBox:=ListBox1;
  CurrentIndex:=ListBox1.ItemIndex;
  ListBox1.SetFocus;
                          end
                      Else begin DeleteFile(PChar(CurrentDir+'\dict\'+LanguageDict+'\diction.user.add.txt'));
                                 TextboxCustomWordComment.Clear;
                             end;
LoadDictionaryToMemory(false);                             
end;

procedure TOptions.UserDictionaryButtonWordExcludeClick(Sender: TObject);
var i:integer; TempStr:string;
begin
If Edit2.Text='' Then exit;
For I:=0 To ListBox2.Count-1 Do
  If Edit2.Text=ListBox2.Items[i] Then begin
     If Options.tag<>23 Then begin
     tempStr:=GlobalTextStrings.Items.Values['OptionsUserDictionaryErrorWordAlreadyInList'];
     If GetLanguageCodepage(Language)<>1251 Then CorrectANSI(TempStr,UTF8encode(GlobalTextStrings.Items.Values['OptionsUserDictionaryErrorWordAlreadyInList']));
     Application.MessageBox(Pchar(TempStr), '',0); exit;
     //Application.MessageBox(PChar(GlobalTextStrings.Items.Values['OptionsUserDictionaryErrorWordAlreadyInList']), '',0); exit;
                            end
                       Else begin
     ListBox2.ItemIndex:=I; ListBox2.Selected[I]:=true;
     CurrentIndex:=ListBox2.ItemIndex;
     ListBox2click(ListBox2);
     ListBox2.SetFocus; exit;
                            end;
                                      end;
For I:=0 To ListBox1.Count-1 Do
  If Edit2.Text=ListBox1.Items[i] Then begin
     tempStr:=GlobalTextStrings.Items.Values['OptionsUserDictionaryCollisionExcludingWordAlreadyAdded'];
     If GetLanguageCodepage(Language)<>1251 Then CorrectANSI(TempStr,UTF8encode(GlobalTextStrings.Items.Values['OptionsUserDictionaryCollisionExcludingWordAlreadyAdded']));
     Application.MessageBox(Pchar(TempStr), '',0); exit;
     //Application.MessageBox(PChar(GlobalTextStrings.Items.Values['OptionsUserDictionaryCollisionExcludingWordAlreadyAdded']), 'Замечание',0);
     ListBox1.ItemIndex:=I; ListBox1.Selected[I]:=true;
     CurrentIndex:=ListBox1.ItemIndex;
     ListBox1click(ListBox1);
     ListBox1.SetFocus; exit; end;
TempStr:=Edit2.Text; CorrectANSI(TempStr,utf8encode(Edit2.text));
ListBox2.ClearSelection;
ListBox2.Items.Add(TempStr);
BufferList2.Items.Add('');
TextboxCustomWordComment.Clear;
ListBox2.Selected[ListBox2.Items.IndexOf(TempStr)]:=true;
ListBox2.ItemIndex:=ListBox2.Items.IndexOf(TempStr);
CurrentIndex:=ListBox2.ItemIndex;
CurrentListBox:=ListBox2;
Edit2.Text:='';
{ пишем список слов в юникод файл }
SaveWordsWithCommentsToFile;
{ обновляем список добавленных слов в памяти компьютера }
If DictArray[length(DictArray)-1]=nil Then DictArray[length(DictArray)-1]:=TStringList.Create Else DictArray[length(DictArray)-1].Clear;
LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\diction.user.del.txt', DictArray[length(DictArray)-1],nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
ListBox2.SetFocus;
end;

procedure TOptions.UserDictionaryButtonWordUnExcludeClick(Sender: TObject);
var i:integer; TempStrings:TStringList;
begin
For I:=0 To ListBox2.Count-1 Do BufferList2.selected[i]:=ListBox2.selected[i];
ListBox2.DeleteSelected;
BufferList2.DeleteSelected;
If CurrentIndex>ListBox2.Count-1 Then CurrentIndex:=ListBox2.Count-1;
If ListBox2.Count<>0 Then begin
  ListBox2.ItemIndex:=CurrentIndex; ListBox2click(ListBox2);
  { пишем список слов в юникод файл }
  SaveWordsWithCommentsToFile;
  {обновляем список добавленных слов в памяти компьютера }
  If DictArray[length(DictArray)-1]=nil Then DictArray[length(DictArray)-1]:=TStringList.Create Else DictArray[length(DictArray)-1].Clear;
  LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\diction.user.del.txt', DictArray[length(DictArray)-1],nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
  ListBox2.Selected[ListBox2.Items.Count-1]:=true;
  ListBox2.ItemIndex:=ListBox2.Items.Count-1;
  CurrentListBox:=ListBox2;
  CurrentIndex:=ListBox2.ItemIndex; ListBox2click(ListBox2);
  ListBox2.SetFocus;
                          end
                      Else begin DeleteFile(PChar(CurrentDir+'\dict\'+LanguageDict+'\diction.user.del.txt'));
                                 DeleteFile(PChar(CurrentDir+'\dict\'+LanguageDict+'\diction.xx'));
                                 TextboxCustomWordComment.Clear;
                             end;
LoadDictionaryToMemory(false);                             
end;

procedure TOptions.Edit1Change(Sender: TObject);
var i:byte;
begin
If Edit1.Text='' Then exit;
{For i:=1 To length(Edit1.Text) Do
 if (Edit1.Text[i]<'А') or (Edit1.Text[i]>'я') Then
 begin Edit1.Text:=copy(Edit1.Text,1,length(Edit1.Text)-1);
       exit;
  end;}
end;

procedure TOptions.Edit2Change(Sender: TObject);
var i:byte;
begin
If Edit2.Text='' Then exit;
{For i:=1 To length(Edit2.Text) Do
 if (Edit2.Text[i]<'А') or (Edit2.Text[i]>'я') Then
 begin Edit2.Text:=copy(Edit2.Text,1,length(Edit2.Text)-1);
       exit;
  end;}
end;

procedure TOptions.ListBox1Click(Sender: TObject);
var TempLangStr:string[5]; TempStr:string;
begin
CurrentIndex:=ListBox1.ItemIndex;
TextboxCustomWordComment.Clear;
TempLangStr:=TempLanguageExpl;
If pos('[/',BufferList1.Items[CurrentIndex])=0
   Then If TempLangStr=LanguageDict Then TextboxCustomWordComment.Lines[0]:=BufferList1.Items[CurrentIndex] Else
         Else
      If pos('['+TempLangStr+']',BufferList1.Items[CurrentIndex])<>0  Then begin
       TempStr:=MidStr(BufferList1.Items[CurrentIndex],pos('['+TempLangStr+']',BufferList1.Items[CurrentIndex])+5,pos('[/'+TempLangStr+']',BufferList1.Items[CurrentIndex])-pos('['+TempLangStr+']',BufferList1.Items[CurrentIndex])-5);
       TextboxCustomWordComment.Lines[0]:=TempStr;
                                                                          end;
end;

procedure SaveWordsWithCommentsToFile;
var I:integer; TempStrings:TStringList; TempLangStr:string[5]; TempStr:string;
begin
TempStrings:=TStringList.Create;
TempLangStr:=TempLanguageExpl;
with options do begin
if CurrentListBox=ListBox1 Then
  begin
      If pos('[/',BufferList1.Items[CurrentIndex])=0 Then BufferList1.Items[CurrentIndex]:=''
         Else
      If (pos('['+TempLangStr+']',BufferList1.Items[CurrentIndex])<>0) Then begin
       TempStr:=MidStr(BufferList1.Items[CurrentIndex],pos('['+TempLangStr+']',BufferList1.Items[CurrentIndex]),pos('[/'+TempLangStr+']',BufferList1.Items[CurrentIndex])-pos('['+TempLangStr+']',BufferList1.Items[CurrentIndex])+6);
       BufferList1.Items[CurrentIndex]:=ANSIREplaceText(BufferList1.Items[CurrentIndex],TempStr,'');
                                                                          end;
       If TextboxCustomWordComment.Lines.Text<>'' Then
         BufferList1.Items[CurrentIndex]:=BufferList1.Items[CurrentIndex]+'['+TempLangStr+']'+TextboxCustomWordComment.Lines.Text+'[/'+TempLangStr+']';
                                                    // end;
  For I:=0 to ListBox1.Count-1 Do begin
  if BufferList1.Items[I]<>'' Then begin TempStr:=ListBox1.Items[i]+'='+BufferList1.Items[I];
                                         CorrectANSI(TempStr,ListBox1.Items[i]+'='+BufferList1.Items[I]);
                                         TempStrings.Add(TempStr);
                                   end
                              Else begin TempStr:=ListBox1.Items[i];
                                         CorrectANSI(TempStr,ListBox1.Items[i]);
                                         TempStrings.Add(TempStr);
                                   end;
                                  end;

  SaveUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\diction.user.add.txt',TempStrings,nil,true,convert);
  end
                           Else
  begin
  BufferList2.Items[CurrentIndex]:=TextboxCustomWordComment.Lines.text;
  For I:=0 to ListBox2.Count-1 Do
  if BufferList2.Items[I]<>'' Then TempStrings.Add(ListBox2.Items[i]+'='+BufferList2.Items[I])
                              Else TempStrings.Add(ListBox2.Items[i]);

SaveUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\diction.user.del.txt',TempStrings,nil,GetLanguageCodepage(LanguageDict)<>1251,convert);
  end;
TempStrings.Free;
                  end;
end;

procedure TOptions.TextboxCustomWordCommentExit(Sender: TObject);
begin
TextboxCustomWordComment.Lines.Text:=AnsiReplaceStr(TextboxCustomWordComment.Lines.Text,#$D#$A,' ');
SaveWordsWithCommentsToFile;
{ обновляем список добавленных слов в памяти компьютера }
If DictArray[length(DictArray)-1]=nil Then DictArray[length(DictArray)-1]:=TStringList.Create Else DictArray[length(DictArray)-1].Clear;
LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\diction.user.del.txt', DictArray[length(DictArray)-1],nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
If DictArray[0]=nil Then DictArray[0]:=TStringList.Create Else DictArray[0].Clear;
LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\diction.user.add.txt', DictArray[0],nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
end;

procedure TOptions.ListBox1Enter(Sender: TObject);
begin
If (sender as TListBox).Name='ListBox1' then ListBox2.ClearSelection
                                           else ListBox1.ClearSelection;
CurrentListBox:=(sender as TListBox);
end;

procedure TOptions.ListBox2Click(Sender: TObject);
begin
CurrentIndex:=ListBox2.ItemIndex;
TextboxCustomWordComment.Clear; TextboxCustomWordComment.Lines[0]:=BufferList2.Items[CurrentIndex];
end;

procedure TOptions.CommonRulesPermitReuseBlankTileClick(Sender: TObject);
begin
CommonRulesSlashBlankTiles.Enabled:=CommonRulesPermitReuseBlankTile.Checked;
end;

procedure TOptions.Edit3Enter(Sender: TObject);
begin
LimitsRadioButtonScoreUserSelected.Checked:=true;
end;

procedure TOptions.TrackBar4Change(Sender: TObject);
begin
BASS_ChannelSetAttributes(BgrMusic,0,TrackBar4.Position,-101);
SetMidiVolume(TrackBar4.Position*655+(TrackBar4.Position*655) shl 16);
end;

procedure TOptions.TrackBar3Change(Sender: TObject);
begin
if TrackBar3.Focused Then begin
   BASS_SetVolume(TrackBar3.Position);
   BASS_SamplePlay(ErrorSound);
                          end;
end;

procedure TOptions.DictionaryButtonThemesClick(Sender: TObject);
begin
case DictionaryButtonThemes.Tag of
0:begin
   Panel2.Show;
   DictionaryButtonThemes.Caption:=GlobalTextStrings.Items.Values['NewGameButtonDictionaryConfig'];
   DictionaryButtonThemes.Hint:=GlobalTextStrings.Items.Values['TagButtonDictionaryConfig'];
   DictionaryButtonThemes.Tag:=1;
  end;
1:begin
   Panel2.Hide;
   DictionaryButtonThemes.Caption:=GlobalTextStrings.Items.Values['NewGameButtonDictionaryTheme'];
   DictionaryButtonThemes.Hint:=GlobalTextStrings.Items.Values['TagButtonDictionaryTheme'];
   DictionaryButtonThemes.Tag:=0;
  end;
end;
end;

procedure TOptions.LanguageButtonAlphabetClick(Sender: TObject);
var I,J,K:word; LetterButton:TSpeedButton; TempStrings:TStringList;
begin
case LanguageButtonAlphabet.Tag of
0:begin
   J:=0; k:=0; I:=0;
   While I<= Panel4.ControlCount-1 Do begin
     If LeftStr(Panel4.Controls[i].Name,12)='LetterButton'
        Then Panel4.Controls[i].Free Else inc(i);

                                      end;
   For I:=0 to AlphCount Do begin
    LetterButton:=TSpeedButton.Create(Options.Panel4);
    LetterButton.Parent:=Options.Panel4;
    LetterButton.Font.Charset:=Setcharset(LanguageDict);    
    LetterButton.Font.Name:='Arial';
    LetterButton.Name:='LetterButton'+IntToStr(I+1);
    LetterButton.Width:=22; LetterButton.Height:=22;
    LetterButton.Left:=23+J*25; LetterButton.Top:=5+K*25;
    LetterButton.AllowAllUp:=false; LetterButton.GroupIndex:=1;
    LetterButton.Caption:=chr(LettersCodes[I]);
    LetterButton.Tag:=I;
    LetterButton.Transparent:=true; LetterButton.Spacing:=-15;
    LetterButton.ShowHint:=true; LetterButton.Hint:=GlobalTextStrings.Items.Values['OptionsAlphabetTagLetterScore']+' '+IntToStr(LettersValue[I])+chr(13)+GlobalTextStrings.Items.Values['OptionsAlphabetTagLetterQuantity']+' '+IntToStr(LettersQuantity[I]);
    if LettersQuantity[I]=0 Then LetterButton.Glyph:=MainScreen.DelImage.Picture.Bitmap;
    LetterButton.OnClick:=SpeedButton6Click;
    inc(J); If J>11 Then begin inc(K); j:=0 end;
                            end;
   LetterButton.Font.Size:=12; LetterButton.Caption:='*';
    For I:=0 to Panel4.ControlCount-1 Do
       (Panel4.Controls[i] as TControl).Enabled:=Finishgame;
    AlphabetButtonDefault.Enabled:=finishgame and FileExists(CurrentDir+'\dict\'+LanguageDict+'\alphabet.def');
    (Panel4.FindComponent('LetterButton1') as TSpeedButton).Click;
    (Panel4.FindComponent('LetterButton1') as TSpeedButton).Down:=true;
   Panel4.Show;
   LanguageButtonAlphabet.Caption:=GlobalTextStrings.Items.Values['LanguageButtonLanguageConfig'];
   LanguageButtonAlphabet.Hint:=GlobalTextStrings.Items.Values['TagButtonLanguageConfig'];
   LanguageButtonAlphabet.Tag:=1;
   AlphabetEdited:=false;
  end;
1:begin
   { пишем Юникод файл с алфавитом }
  If AlphabetEdited then begin
   If not Fileexists(CurrentDir+'\dict\'+LanguageDict+'\alphabet.def')
      and Fileexists(CurrentDir+'\dict\'+LanguageDict+'\alphabet.txt') then
          CopyFile(PChar(CurrentDir+'\dict\'+LanguageDict+'\alphabet.txt'),PChar(CurrentDir+'\dict\'+LanguageDict+'\alphabet.def'),true);
   TempStrings:=TStringList.Create;
   For I:=0 to AlphCount Do begin
      If I<>AlphCount Then
         TempStrings.Add(chr(LettersCodes[I])+','+IntToStr(LettersValue[I])+','+IntToStr(LettersQuantity[I]))
                      Else
         TempStrings.Add('*,'+IntToStr(LettersValue[I])+','+IntToStr(LettersQuantity[I]));
                             end;
   SaveUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\alphabet.txt',TempStrings,nil,GetLanguageCodepage(LanguageDict)<>1251,convert);
   TempStrings.Free;
                        end;
   Panel4.Hide;
   LanguageButtonAlphabet.Caption:=GlobalTextStrings.Items.Values['LanguageButtonAlphabetConfig'];
   LanguageButtonAlphabet.Hint:=GlobalTextStrings.Items.Values['TagButtonAlphabetConfig'];
   LanguageButtonAlphabet.Tag:=0;
   AlphabetEdited:=false;
  end;
end;
end;

procedure TOptions.LimitsMoveTimeClick(Sender: TObject);
begin
If LimitsMoveTime.Checked Then begin
  LimitsComboboxListMoveTime.Enabled:=LimitsMoveTime.Checked;
  LimitsRadioButtonNoLimits.Checked:=false; DictionaryRulesRadioButtonUserCannotAddWords.Checked:=false;
  LimitsRadioButtonTime10minutes.Checked:=false;
  LimitsRadioButtonTime30minutes.Checked:=false; LimitsRadioButtonTime1Hour.Checked:=false;
  LimitsRadioButtonTime20minutes.Checked:=false; LimitsRadioButtonTime45minutes.Checked:=false;
                               end;
end;

procedure TOptions.LimitsRadioButtonTime10minutesClick(Sender: TObject);
begin
LimitsMoveTime.Checked:=False;
LimitsComboboxListMoveTime.Enabled:=False;
LimitsRadioButtonNoLimits.Checked:=False;
end;

procedure TOptions.green_SpinEditEnter(Sender: TObject);
begin
LayoutRadioButtonRandom.Checked:=true;
end;


procedure TOptions.ComboBox2Change(Sender: TObject);
begin
LayoutRadioButtonFromFile.Checked:=true;
TabSheetLayoutShow(self);
end;

procedure TOptions.DimX_SpinEditChange(Sender: TObject);
begin
LayoutRadioButtonRandom.Checked:=true;
If LayoutRandomIsSquareLayout.Checked Then
   dimY_Spinedit.Value:=dimX_Spinedit.Value;
end;

procedure TOptions.CommonChiefInRoomClick(Sender: TObject);
begin
PauseOnMinimazed.Enabled:=CommonChiefInRoom.Checked;
end;

procedure TOptions.DimY_SpinEditChange(Sender: TObject);
begin
LayoutRadioButtonRandom.Checked:=true;
If LayoutRandomIsSquareLayout.Checked Then
   dimX_Spinedit.Value:=dimY_Spinedit.Value;
end;

procedure TOptions.LayoutRandomIsSquareLayoutClick(Sender: TObject);
begin
If LayoutRandomIsSquareLayout.Checked Then dimY_Spinedit.Value:=dimX_Spinedit.Value;
end;

procedure TOptions.LimitsWordLengthNoLessClick(Sender: TObject);
begin
LimitsComboboxListLetter.Enabled:=LimitsWordLengthNoLess.Checked;
end;

procedure TOptions.SpeedButton6Click(Sender: TObject);
var I:byte; c:char; TempUTFStr:utf8string;
begin
For I:=0 to Panel4.ControlCount-1 Do
 If Panel4.Controls[i] is TSpeedButton Then begin
                                             (Panel4.Controls[i] as TSpeedButton).Font.Style:=[];
                                             (Panel4.Controls[i] as TSpeedButton).Font.Color:=clBlack;
                                            end;
(sender as TSpeedButton).Font.Style:=[fsBold];
(sender as TSpeedButton).Font.Color:=clBlue;

 if (sender as TSpeedButton).caption[1]<>'*' Then c:=(sender as TSpeedButton).caption[1]
                                             Else c:=chr(FirstAlphCode+AlphCount);
 RXSpinEdit6.Value:=LettersValue[GetLetterNum(c)];
 RXSpinEdit1.Value:=LettersQuantity[GetLetterNum(c)];
 RXSpinEdit6.Tag:=GetLetterNum(c);
 RXSpinEdit1.Tag:=GetLetterNum(c);
 OP_Label29.Caption:=GlobalTextStrings.Items.Values['OptionsAlphabetLetterQuantityPrefix']+' '+IntToStr(LettersSumm)+' ('+IntToStr(trunc(100 * RxSpinEdit1.value / LettersSumm))+'%)';
 TempUTFStr:=ansitoutf8((Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Caption);
 If GetLanguageCodepage(LanguageDict)<>1251 Then CorrectUTFForSave(TempUTFStr,(Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Caption);
 OP_Label30.Caption:=GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutPrefix']+' '+IntToStr(dim1)+'x'+IntToStr(dim2)+' ('+IntToStr(dim1*dim2)+' '+GlobalTextStrings.Items.Values['OptionsAlphabetLayoutCellsQuantitySuffix']+')'+chr(13)
                 +GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutMiddle']+' '''+utf8decode(TempUTFStr)+''' '+GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutSuffix']+' '+IntToStr(trunc(RXSpinEdit1.Value) * trunc(Dim1*dim2) div LettersSumm);
If RXSpinEdit1.Value<>0 Then OP_Label30.Caption:=OP_Label30.Caption+' (±1)';
end;

procedure TOptions.RxSpinEdit1TopClick(Sender: TObject);
var TempUTFStr:utf8string;
begin
LettersQuantity[RxSpinEdit1.Tag]:=trunc(RxSpinEdit1.value);
 OP_Label29.Caption:=GlobalTextStrings.Items.Values['OptionsAlphabetLetterQuantityPrefix']+' '+IntToStr(LettersSumm)+' ('+IntToStr(trunc(100 * RxSpinEdit1.value / LettersSumm))+'%)';
(Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).hint:=GlobalTextStrings.Items.Values['OptionsAlphabetTagLetterScore']+' '+IntToStr(LettersValue[RxSpinEdit6.Tag])+chr(13)+GlobalTextStrings.Items.Values['OptionsAlphabetTagLetterQuantity']+' '+IntToStr(LettersQuantity[RxSpinEdit1.Tag]);
 TempUTFStr:=ansitoutf8((Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Caption);
 If GetLanguageCodepage(LanguageDict)<>1251 Then CorrectUTFForSave(TempUTFStr,(Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Caption);
 TempUTFStr:=ansitoutf8((Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Caption);
 If GetLanguageCodepage(LanguageDict)<>1251 Then CorrectUTFForSave(TempUTFStr,(Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Caption);
 OP_Label30.Caption:=GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutPrefix']+' '+IntToStr(dim1)+'x'+IntToStr(dim2)+' ('+IntToStr(dim1*dim2)+' '+GlobalTextStrings.Items.Values['OptionsAlphabetLayoutCellsQuantitySuffix']+')'+chr(13)
                 +GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutMiddle']+' '''+utf8decode(TempUTFStr)+''' '+GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutSuffix']+' '+IntToStr(trunc(RXSpinEdit1.Value) * trunc(Dim1*dim2) div LettersSumm);
If RXSpinEdit1.Value<>0 Then OP_Label30.Caption:=OP_Label30.Caption+' (±1)';
if LettersQuantity[RxSpinEdit1.Tag]=0 Then
   (Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Glyph:=MainScreen.DelImage.Picture.Bitmap
                                      Else
   (Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Glyph:=nil;
end;

procedure TOptions.RxSpinEdit1BottomClick(Sender: TObject);
var TempUTFStr:utf8string;
begin
LettersQuantity[RxSpinEdit1.Tag]:=trunc(RxSpinEdit1.value);
If LettersSumm=0 Then begin Application.MessageBox(Pchar(GlobalTextStrings.Items.Values['OptionsAlphabetMessageNullAllLetter']),'');
                            LettersQuantity[RxSpinEdit1.Tag]:=1; RxSpinEdit1.Value:=1;
                            exit;
                        end;
 OP_Label29.Caption:=GlobalTextStrings.Items.Values['OptionsAlphabetLetterQuantityPrefix']+' '+IntToStr(LettersSumm)+' ('+IntToStr(trunc(100 * RxSpinEdit1.value / LettersSumm))+'%)';
(Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).hint:=GlobalTextStrings.Items.Values['OptionsAlphabetTagLetterScore']+' '+IntToStr(LettersValue[RxSpinEdit6.Tag])+chr(13)+GlobalTextStrings.Items.Values['OptionsAlphabetTagLetterQuantity']+' '+IntToStr(LettersQuantity[RxSpinEdit1.Tag]);
 TempUTFStr:=ansitoutf8((Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Caption);
 If GetLanguageCodepage(LanguageDict)<>1251 Then CorrectUTFForSave(TempUTFStr,(Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Caption);
 OP_Label30.Caption:=GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutPrefix']+' '+IntToStr(dim1)+'x'+IntToStr(dim2)+' ('+IntToStr(dim1*dim2)+' '+GlobalTextStrings.Items.Values['OptionsAlphabetLayoutCellsQuantitySuffix']+')'+chr(13)
                 +GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutMiddle']+' '''+utf8decode(TempUTFStr)+''' '+GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutSuffix']+' '+IntToStr(trunc(RXSpinEdit1.Value) * trunc(Dim1*dim2) div LettersSumm);
If RXSpinEdit1.Value<>0 Then OP_Label30.Caption:=OP_Label30.Caption+' (±1)';
if LettersQuantity[RxSpinEdit1.Tag]=0 Then
   (Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Glyph:=MainScreen.DelImage.Picture.Bitmap
                                      Else
   (Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Glyph:=nil;
end;

procedure TOptions.RxSpinEdit6TopClick(Sender: TObject);
begin
If RxSpinEdit6.Tag=AlphCount Then begin RxSpinEdit6.Value:=0; exit; end;
LettersValue[RxSpinEdit6.Tag]:=trunc(RxSpinEdit6.value);
(Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).hint:=GlobalTextStrings.Items.Values['OptionsAlphabetTagLetterScore']+' '+IntToStr(LettersValue[RxSpinEdit6.Tag])+chr(13)+GlobalTextStrings.Items.Values['OptionsAlphabetTagLetterQuantity']+' '+IntToStr(LettersQuantity[RxSpinEdit1.Tag]);
end;

procedure TOptions.RxSpinEdit6BottomClick(Sender: TObject);
begin
If RxSpinEdit6.Tag=AlphCount Then exit;
AlphabetEdited:=true;
If RxSpinEdit6.Value=0 Then begin RxSpinEdit6.Value:=1; exit; end;
LettersValue[RxSpinEdit6.Tag]:=trunc(RxSpinEdit6.value);
(Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).hint:=GlobalTextStrings.Items.Values['OptionsAlphabetTagLetterScore']+' '+IntToStr(LettersValue[RxSpinEdit6.Tag])+chr(13)+GlobalTextStrings.Items.Values['OptionsAlphabetTagLetterQuantity']+' '+IntToStr(LettersQuantity[RxSpinEdit1.Tag]);
end;

procedure TOptions.TabSheetLanguagesShow(Sender: TObject);
var TempUTFStr:utf8string;
begin
Panel4.Hide; LanguageButtonAlphabet.Tag:=0;
If LayoutRadioButtonFromFile.Checked Then begin dim1:=StrToInt(copy(ComboBox2.Text,pos('(',ComboBox2.Text)+1,2));
                                    dim2:=StrToInt(copy(ComboBox2.Text,pos('x',ComboBox2.Text)+1,2))
                              end
                         Else begin dim1:=trunc(DimX_SpinEdit.Value);
                                    dim2:=trunc(DimY_SpinEdit.Value);
                              end;
 TempUTFStr:=ansitoutf8((Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Caption);
 If GetLanguageCodepage(LanguageDict)<>1251 Then CorrectUTFForSave(TempUTFStr,(Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Caption);
 OP_Label30.Caption:=GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutPrefix']+' '+IntToStr(dim1)+'x'+IntToStr(dim2)+' ('+IntToStr(dim1*dim2)+' '+GlobalTextStrings.Items.Values['OptionsAlphabetLayoutCellsQuantitySuffix']+')'+chr(13)
                 +GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutMiddle']+' '''+utf8decode(TempUTFStr)+''' '+GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutSuffix']+' '+IntToStr(trunc(RXSpinEdit1.Value) * trunc(Dim1*dim2) div LettersSumm);
If RXSpinEdit1.Value<>0 Then OP_Label30.Caption:=OP_Label30.Caption+' (±1)';
end;

procedure TOptions.AlphabetButtonDefaultClick(Sender: TObject);
var I:byte; TempStrList:TStringList; TempUTFStr:utf8string;
begin
  TempStrList:=TStringList.Create;
  LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\alphabet.def',TempStrList,nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
  FirstAlphCode:=ord(TempStrList.Strings[0][1]);
  For I:=0 to TempStrList.Count-1 Do
    begin LettersValue[I]:=StrToInt(copy(TempStrList.Strings[I],3,pos(',',MidStr(TempStrList.Strings[I],3,10))-1));
          LettersQuantity[I]:=StrToInt(copy(TempStrList.Strings[I],3+pos(',',MidStr(TempStrList.Strings[I],3,10)),10));
          LettersCodes[I]:=ord(TempStrList.Strings[I][1]);
          If I=AlphCount Then LettersCodes[I]:=FirstAlphCode+AlphCount;
      end;
  TempStrList.Free;
 (Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Click;
 OP_Label29.Caption:=GlobalTextStrings.Items.Values['OptionsAlphabetLetterQuantityPrefix']+' '+IntToStr(LettersSumm)+' ('+IntToStr(trunc(100 * RxSpinEdit1.value / LettersSumm))+'%)';
 For I:=0 to Panel4.ControlCount-1 Do
   If Panel4.Controls[i] is TSpeedButton Then begin
                                             (Panel4.Controls[i] as TSpeedButton).Glyph:=nil;
                                             (Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).hint:=GlobalTextStrings.Items.Values['OptionsAlphabetTagLetterScore']+' '+IntToStr(LettersValue[RxSpinEdit6.Tag])+chr(13)+GlobalTextStrings.Items.Values['OptionsAlphabetTagLetterQuantity']+' '+IntToStr(LettersQuantity[RxSpinEdit1.Tag]);
                                            end;
 TempUTFStr:=ansitoutf8((Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Caption);
 If GetLanguageCodepage(LanguageDict)<>1251 Then CorrectUTFForSave(TempUTFStr,(Panel4.FindComponent('LetterButton'+IntToStr(RxSpinEdit1.Tag+1)) as TSpeedButton).Caption);
 OP_Label30.Caption:=GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutPrefix']+' '+IntToStr(dim1)+'x'+IntToStr(dim2)+' ('+IntToStr(dim1*dim2)+' '+GlobalTextStrings.Items.Values['OptionsAlphabetLayoutCellsQuantitySuffix']+')'+chr(13)
                 +GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutMiddle']+' '''+utf8decode(TempUTFStr)+''' '+GlobalTextStrings.Items.Values['OptionsAlphabetComputeForSelectedLayoutSuffix']+' '+IntToStr(trunc(RXSpinEdit1.Value) * trunc(Dim1*dim2) div LettersSumm);
If RXSpinEdit1.Value<>0 Then OP_Label30.Caption:=OP_Label30.Caption+' (±1)';
AlphabetEdited:=true;
end;

{ ------------------------------------------------------------- }
{ смена языка интерфейса }
procedure TOptions.ComboBox1Change(Sender: TObject);
var i,j:byte;
begin
Language:=copy(ComboBox1.HelpKeyword,ComboBox1.ItemIndex*3+1,3);
I:=LimitsComboBoxListMoveTime.ItemIndex; j:=LimitsComboBoxListLetter.ItemIndex;
//LoadUnicodeFile(CurrentDir+'\lang\'+Language+'\strings.txt',GlobalTextStrings,GetLanguageCodepage(Language)<>1251);
MainScreen.LoadGlobalTextStrings(All);
CreateExplLangButtons;
LimitsComboBoxListMoveTime.ItemIndex:=I; LimitsComboBoxListLetter.ItemIndex:=J;
end;

{ ------------------------------------------------------------- }
{ смена игрового языка }
procedure TOptions.ComboBox4Change(Sender: TObject);
var I:word; sr,sr1:TSearchrec; sLanguage: string; TempStrList:TStringList;
begin
 { пишем темы }
 If ThemeCodes.IndexOfName(LanguageDict)=-1 Then ThemeCodes.Add(LanguageDict+'=');
 ThemeCodes.Values[LanguageDict]:='';
 If ThemesTipListBox.Items.Count<>0 Then                                              
    For I:=0 to ThemesTipListBox.Items.Count-1 Do
      If not ThemesTipListBox.Checked[I] Then ThemeCodes.Values[LanguageDict]:=ThemeCodes.Values[LanguageDict]+ThemesTipListBox.HelpKeyword[I+1];
  If ThemeCodes.IndexOfName('Lim'+LanguageDict)=-1 Then ThemeCodes.Add('Lim'+LanguageDict+'=');
  If DictionaryRadioButtonSizeMax.Checked then ThemeCodes.Values['Lim'+LanguageDict]:='';
  If DictionaryRadioButtonSizeNormal.Checked then ThemeCodes.Values['Lim'+LanguageDict]:=DictSpec[0];
  If DictionaryRadioButtonSizeExtended.Checked then ThemeCodes.Values['Lim'+LanguageDict]:=DictSpec[1];
  If DictionaryRadioButtonSizeChildren.Checked then ThemeCodes.Values['Lim'+LanguageDict]:=DictSpec[6];
 ThemeListForAll:=ThemeCodes.Text;

LanguageDict:=copy(ComboBox4.HelpKeyword,ComboBox4.ItemIndex*3+1,3);

{ формируем список словарей толкований в зависимости от языка словаря }
    ComboBox5.HelpKeyword:=''; ComboBox5.Items.Clear; ComboBox5.Text:='';
    LanguageExpl:='';
    If FindFirst(CurrentDir+'\dict\'+LanguageDict+'\expl\*',faDirectory,sr)=0 Then begin
     repeat
        if (pos(sr.Name,'..')=0) and (sr.Attr and faDirectory<>0)
           Then begin
                   try
                     //GetLocaleInfo(StrToInt(TempStrList.Values[ANSIUpperCase(sr.name)]),LOCALE_SLANGUAGE,sLanguage, 100);
                     sLanguage:=getLanguageName(ANSIUpperCase(sr.Name));
                     ComboBox5.Items.Add(LeftStr(string(sLanguage),pos('(',string(sLanguage))-1+100*ord(pos('(',string(sLanguage))=0)));
                     ComboBox5.HelpKeyword:=ComboBox5.HelpKeyword+sr.Name;
                   except end;
                   If sr.Name=LanguageExpl Then begin ComboBox5.Text:=ComboBox5.Items[Combobox5.Items.count-1];
                                                      LanguageExpl:=sr.Name;
                                                  end;
                  end;
      until FindNext(sr)<>0;
   If LanguageExpl='' Then begin LanguageExpl:=copy(ComboBox5.HelpKeyword,1,3);
                                 ComboBox5.ItemIndex:=0;
                           end;
                                                                                    end;

If Combobox5.Items.Count=0 Then LanguageExpl:='';

{определяем флаги ограничения словаря}
If fileexists(CurrentDir+'\dict\'+LanguageDict+'\themes.txt') Then
  begin
   TempStrList:=TStringList.Create;
   LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\themes.txt',TempStrList,nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
   try DictSpec[0]:=TempStrList.Values['DCommom'][1]; except end;
   try DictSpec[1]:=TempStrList.Values['DExtended1'][1]; except end;
   try DictSpec[2]:=TempStrList.Values['DExtended2'][1]; except end;
   try DictSpec[3]:=TempStrList.Values['DExtended3'][1]; except end;
   try DictSpec[4]:=TempStrList.Values['DExtended4'][1]; except end;
   try DictSpec[5]:=TempStrList.Values['DExtended5'][1]; except end;
   try DictSpec[6]:=TempStrList.Values['DChildren'][1]; except end;
   TempStrList.Free;
  end;
 Theme:=ThemeCodes.Values['Lim'+LanguageDict];  
 If Theme='' Then DictionaryRadioButtonSizeMax.Checked:=True
             Else
 If Theme=DictSpec[0] Then DictionaryRadioButtonSizeNormal.Checked:=True
             Else
 If Theme=DictSpec[1] Then DictionaryRadioButtonSizeExtended.Checked:=True
             Else
 If Theme=DictSpec[6] Then DictionaryRadioButtonSizeChildren.Checked:=True;  

 CreateExplLangButtons;
{ загружаем темы, если определены }
mainScreen.LoadGlobalTextStrings(OnlyThemes);
If ThemesTipListBox.Items.Count>0 Then
   For I:=0 to ThemesTipListBox.Items.Count-1 Do
     ThemesTipListBox.Checked[I]:=(pos(ThemesTipListBox.HelpKeyword[I+1],ThemeCodes.Values[LanguageDict])=0);
{ загружаем пользовательские словари в окно наситроек }
LoadCustomDictionaries;
{ загружаем данные алфавита }
LoadAlphabet;
{ загружаем в память словари }
try LoadDictionaryToMemory(true); except end;
MainScreen.ScreenButtonTitleLastPlayer.Caption:=GlobalTextStrings.Items.Values['TitleCaptionCurrentPlayer']+' '+Players[1].Name+chr(13)+GlobalTextStrings.Items.Values['TitleCaptionCurrentDictLanguage']+' '+GetLanguageName(LanguageDict);
end;

{ ------------------------------------------------------------- }
{ смена языка толкований }
procedure TOptions.ComboBox5Change(Sender: TObject);
begin
LanguageExpl:=copy(ComboBox5.HelpKeyword,ComboBox5.ItemIndex*3+1,3);
CreateExplLangButtons;
TabSheetLanguages.Show;
end;

procedure TOptions.RxSpinEdit6Change(Sender: TObject);
begin
AlphabetEdited:=true;
end;

procedure TOptions.RxSpinEdit1Change(Sender: TObject);
begin
AlphabetEdited:=true;
end;

{ показ страницы "Игровое поле" }
procedure TOptions.TabSheetLayoutShow(Sender: TObject);
var TempFile:textfile; TempStr:string;
    TempBitmap:TBitmap; I,J,k:byte;
begin
  TempBitmap:=TBitmap.Create;
  TempBitmap.Canvas.Brush.Color:=clSilver;
  TempBitmap.Height:=1;
 If not LayoutRadioButtonRandom.Checked then
  BEGIN
  AssignFile(TempFile,CurrentDir+'\MAPS\'+MapFiles.Strings[ComboBox2.ItemIndex]);
  Reset(TempFile);
  Readln(TempFile,TempStr);
  I:=1;
  while not EOF(TempFile) Do begin
    Readln(TempFile,TempStr);
    If length(TempStr)=0 Then break;
    TempBitmap.Width:=length(TempStr)*3+2;
    TempBitmap.Height:=TempBitmap.Height+3;
    //TempBitmap.Canvas.Brush.Color:=clBlack; TempBitmap.Canvas.FillRect(rect(0,0,2,2)); break;
    k:=1;
    For J:=1 to length(TempStr) Do begin
                                    case TempStr[j] of
                                    '1': TempBitmap.Canvas.Brush.Color:=clWhite;
                                    '2': TempBitmap.Canvas.Brush.Color:=clLime;
                                    '3': TempBitmap.Canvas.Brush.Color:=clBlue;
                                    '4': TempBitmap.Canvas.Brush.Color:=clYellow;
                                    '5': TempBitmap.Canvas.Brush.Color:=clRed;
                                    '6': TempBitmap.Canvas.Brush.Color:=clBlack;
                                    end;
                                    TempBitmap.Canvas.FillRect(rect(k,I,k+2,I+2));
                                    inc(k,3);
                                    TempBitmap.Canvas.Brush.Color:=clSilver;
                                   end;
    inc(i,3);
                               end;
  TempBitmap.Height:=TempBitmap.Height+1;
  CloseFile(TempFile);
  END
  Else
  BEGIN
  END;
  MapPreview.Width:=TempBitmap.Width; MapPreview.Height:=TempBitmap.Height;
  MapPreview.Picture.Assign(TempBitmap);
  MapPreview.Left:=Shape6.Left+(Shape6.Width div 2 -MapPreview.Width div 2);
  MapPreview.Top:=Shape6.Top+(Shape6.Height div 2 -MapPreview.Height div 2);
  //MapPreview.Height:=TempBitmap.Height*3;
  TempBitmap.Free;
end;

procedure TOptions.LayoutRadioButtonRandomClick(Sender: TObject);
begin
TabSheetLayoutShow(self);
end;

end.







