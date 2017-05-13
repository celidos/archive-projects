{v 1.6.x}
Unit Procs;

INTERFACE
Uses
SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls, RXGif, StrUtils,
Forms, Dialogs, ExtCtrls, Menus, StdCtrls, StrWnd, ErrorMes, MPlayer, MMSystem, bass, binfo, RXCtrls, Math, TNTstdCtrls,
TNTClasses, SevenZipVCL;

Type ShortString=string[16];

     UndoData=record
              Avail:array[1..30,1..30] of boolean;
              Colors:array[1..30,1..30] of byte;
              HotSpots:array[1..30,1..30] of char;
              Slot7Mark:array[1..7] of boolean;
              Points:word;
              LastWordsCount:byte;
              end;

     WorkFieldType= record
	     main:char; { главный слой }
	     available:boolean; { флаг "заполненности" ячейки}
	     hotspot:char; { "хот-спот" привязка}
	     color:byte; {цвет ячейки}
	     forChoice:char; { слой поля выбора }
             Image:-1..900; { номер фишки в ячейке }
             Checked:boolean; { флаг качественного нового слова}
                     end;
     Slot7Type=record
		Letter:char; { буква в ячейке слота }
		SlotX:word; { координата Х ячейки слота }
		SlotY:word; { координата Y ячейки слота }
		Mark:boolean; { отметка на замену }
                Image:-1..900; { номер фишки в ячейке }
               end;
     TCustomDict=record
                      Use:boolean;
                      AddWord:0..2;
                      WordRequired:boolean;
                      //WarnMissing:boolean;
                      WarnDelete:boolean;
                      WarnAddExplanation:boolean;
                   end;
     PlayersType=record
                      Name:string[9];
                      Points:word;
                      Changes:byte;
                      Image:string[8];
                      Code:byte;
                      PLtype:0..2;
                    end;
     HallFameType=record
                      Name:string[15];
                      Points:string[3];
                      Code:string[8];
                  end;
     THallFameArray=array[1..8] of HallFameType;
     WordListType=record
                      Word:string[15];
                      WBegin,WEnd:1..30;
                      Coord:1..30;
                      Direction:1..2;
                      Value:byte;
                   end;

     SongFileType=record
                      Name:string[250];
                      Path:string[250];
                   end;
     ClearedWordsType=record
                       Word:string[15];
                       WBegin:byte;
                       AltCoord:byte;
                       Direction:1..2;
                       Value:byte;
                      end;
  (*   SaveFileType=record
                        Date:string[10]; { дата сохранения }
                        Time:string[20]; { время сохранения}
                        Info:string[150]; { информация о партии }
                        Opnt:0..1; { код оппонента }
                        Intellect:1..4; { код интеллекта  }
                        Limits:string[20]; { ограничения }
                        Themes:string[20]; { темы }
                        LangDict:string[7]; { время партии }
                        LangExpl:string[7]; { время партии }
                        StartHour,StartMin,StartSec:word;
                        WorkFieldDimentionX:byte; {размер поля по горизонтали}
                        WorkField:array[0..31,0..31] of WorkFieldType; { игровое поле }
                        PlayersNumber:byte; {количество игроков в партии}
                        Players:array[1..8] of PlayersType; { игроки }
                        WordList:array[1..200,1..8] of WordListType;
                        Slot7:array[1..8,1..7] of Slot7Type; { игровые слоты }
                        Move:1..8; { код хода }
                        Help:boolean; { флаг подсказки }
                        Mode:12..14; { режим текущего действия }
                        LettersCount:0..900;
                        Letters:array[0..899] of record { буквы }
                                                 Left:integer;
                                                 Top:integer;
                                                 Hint:string[25];
                                                 Tag:integer;
                                                 Visible:Boolean;
                                                 Parent:0..8;
                                                 end;
                        ChoiceFieldStatus:boolean; { "видимость" поля выбора }
                        Reserved3:boolean;
                        Reserved2:boolean;
                        Reserved1:boolean;
                        Reserved4:boolean;
                        HintDelay:0..1000; {пауза подсказки}
                        HintLimit:byte; {оставшееся количество подсказок}
                        StoreHintLimit:byte; {общее количество подсазок }
                        FloatingForms:array[0..8] of record X,Y:word; Locked:integer; Status:byte; end;
                        Template:string[255];
                        ShapesNumber:byte;
                        SelectShapes:array[0..50] of record
                                     Name:string[30];
                                     Left, Top:word;
                                     Width, Height:word;
                                     Color:TColor; Tag:byte;
                                                     end;
                        SelectField:array[0..31,0..31] of 0..3;
                        KeepBonuses:boolean;
                        WorkFieldDimentionY:byte; {размер поля по горизонтали}
                        MainFieldForm: record X,Y:word; end;
                      end; *)
    TLettersArray=array[0..50] of word;


const
     On_m=0; Off_m=1;  { включение/выключение режима выбора букв }
     Move=1; Help=2; { режим хода компьютера}
     Human=0; PC=1; Network=2; { код оппонента }
     Low=1; Middle=2; High=3; Genius=4; { код интеллекта }
     Horiz=1; Vertic=2; { коды направления просмотра слов на игровом поле }
     Play=12; Take=13; Helping=14; { режим текущего действия }
     //Player1=1; Player2=2; Player3=3; Player4=4; { коды игроков }
     No=0; Yes=1; Ask=2; {коды режима редактирования словаря во время хода}
     //ASCII=0; ANSI=1; {коды конвертации}
     White=1; Green=2; Blue=3; Yellow=4; Red=5; Black=6; Selected=10; { коды цветных призовых ячеек }
     ttfMess=0; ttfPlayer=1; ttfDigi=2; ttfSplash=4; {коды шрифтов}
     All=0; OnlyThemes=1; {код загрузки strings.txt}
     Convert=true; NoConvert=false;
     SpecSymbols:array[1..3,1..54] of word=((196,214,220,223,193,268,270,201,282,205,327,211,344,352,356,218,366,221,381,336,368,209,256,274,290,298,310,315,325,362,260,280,278,302,370,262,321,323,346,379,197,194,199,200,202,198,203,206,207,212,338,217,219,376),
                                            (196,214,220,223,193,200,207,201,204,205,210,211,216,138,141,218,217,221,142,213,219,209,194,199,204,206,205,207,210,219,192,198,203,193,216,198,163,209,140,175,197,194,199,200,202,198,203,206,207,212,200,217,219,159),
                                            (252,252,252,252,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,250,252,257,257,257,257,257,257,257,257,257,257,257,257,257,250,250,250,250,250,252,252,252,252,252,252,252,252,252,252,252,252,252,252));
Var
    LettersValue:TLettersArray=(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
    LettersQuantity:TLettersArray=(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
    LettersCodes:TLettersArray;

    {ФОРМЫ}
    Pl_Form, I_Form, Ex_Form, Lens_Form:TForm;
    PlayerForms:array of TForm;
    Shadow_Form:TForm;


    {УКАЗАТЕЛИ}
    ScoreLabel:TLabel; { вспомогательная метка-счет }
    _ElaspedTimer,_MoveTimer:TTimer;
    _Marker1, _Marker2:TImage; { вспомогательные маркеры }
    _MediaPlayer:TMediaPlayer;
    _Player1Image, _Player2Image:TImage;
    _MessageTimer:TTimer;
    _ChoicePanel:TPanel;
    LastLetters:TList; { список объектов-букв в последний ход компьютера}
    BufferStringList:TTNTStringList;

    {ФАЙЛЫ}
    PickedWordsFile:file of ShortString; { файл первичного отбора }
    ClearedWordsFile: file of ClearedWordsType; { файл вторичного отбора }
    AddedWordsFile:file of ShortString; { файл наращенных слов }
    //IniFile:file of IniType; { файл инициализации }
    HallFameFile:file of THallFameArray; { файл рекордсменов }
    //SaveGameFile:file of SaveFileType; { файл записи }

    {ФЛАГИ}
    AboutLog:boolean; { флаг окна о программе }
    AllowSelect:boolean; { флаг выделения части слов }
    AllowWordRepeat:boolean; { флаг разрешения повторов слов }
    AllPlayersOpen:boolean; {флаг сохранения всех игроков открытыми }
    AlwaysShowDictionaryPanel:boolean; { флаг постоянного показа панели словаря }
    AnimActiveAvatar:boolean; {флаг анимации только активного аватара}
    AnimActivePlayer:boolean; {флаг дополнительной анимации текущего игрока}
    ApplicationMinimized:boolean; {флаг миимизированного приложения }
    CrossWord_Mode:boolean; {флаг режима кроссворда}
    CustomColors:boolean; { флаг измененных цветов оформления }
    DemoMode: boolean; { режим демки }
    EnableSoundHardware:boolean; { флаг установленного звукового оборудования }
    End_Of_Program:boolean; { флаг конца программы }
    FinishGame:boolean; { флаг окончания партии }
    FirstWord:boolean; { флаг первого слова }
    Flag3:boolean; { флаг восстановления индекса "3" в выделениях}
    FlashStarMarkers:boolean; {флаг мигания маркеров на буквах-звездочках}
    GameLoading:boolean; { флаг загруженной игры }
    Helped:boolean; { флаг получения подсказки }
    HintPushButton:boolean; { флаг ожидания нажатия клавиши при подсказке }
    isPCMove:boolean; { флаг хода компьютера }
    KeepBonuses:boolean; {флаг сохранения призовых ячеек}
    LettersAutoSelect:boolean; { флаг автовыбора букв }
    MinimizeOnEsc:boolean; {флаг сворачивания по ESC}
    MinimizeWindows:boolean; {флаг, надо ли сворачивать окошки}
    MovePass:boolean; { флаг на необходимость перехода хода}
    MoveLimit:boolean; { флаг ограничения на ход }
    PCChangedLetters:boolean; { флаг, что копм поменял буквы }
    PlayBackgroundMusic:boolean; { флаг проигрывания музыки }
    PlaySounds:boolean; { флаг воспроизведения звуков }
    PlayShuffle:boolean; { флаг воспроизведения вразброс }
    PressGo:boolean; { флаг нажатия кнопки ХОЖУ!}
    PressChange:boolean; { флаг нажатия кнопки МЕНЯЮ! }
    Preview:boolean; { флаг предварительного анализа хода }
    ProceedHelp:boolean; {флаг продолжения помощи после клавиши}
    QuickLoad:boolean; { флаг быстрой загрузки по кнопке "Продолжить" }
    ReferenceOn:boolean; { флаг подключения толкового словаря }
    RepeatTurn:boolean; { флаг повтора хода }
    RunMinimized:boolean; {флаг продолжения партии в свернутом состоянии }
    ShowAdvancedHallFame:boolean; { флаг показа промежуточных лучших результатов }
    ShowClearedWords:boolean; { флаг показа слов во время хода компьютера }
    ShowColorLetters:boolean; { флаг отображения цветных фишек }
    ShowExplanatoryPanel:boolean; { флаг показа панели словаря }
    ShowShadows:boolean; { флаг вывода сложных теней }
    ShowHintMarkers:boolean; { флаг показа маркеров помощи }
    ShowTerminals:boolean; { флаг показа информации о партии }
    StartLetterSelectionCompleted:boolean; { флаг окончания начального выбора букв игроками }
    StopHelp:Boolean; { флаг принудительного останова помощи }
    TakeStar:boolean; {флаг режима замены звездочек c игрового поля}
    TimeLimit:boolean; { флаг ограничения по времени }
    TransferLetterOn:boolean; {флаг начала переноса буквы}


    AlphCount:byte; { кол-во букв в текущем алфавите }
    ClearedWord:ClearedWordsType; { слово, прошедшее вторичный отбор }
    CurrentDir:string; { имя текущего каталога }
    DictionaryFile:Text; { файл словаря }
    ElaspedGameTime:string[6]; { прошедшее время игры }
    FirstAlphCode:word; { код первой буквы алфавита }
    HintDelay:0..1000; { задержка при подсказке }
    HintLimit:byte; { количество подсказок на партию }
    Hour, Minute, Second, MSecond:word;{ переменные времени }
    //IniData:IniType; { данные, записываемые в общий ini-файл }
    //IniDataPlayer:PlayerIniType; { данные, записываемые в именной инифайл }
    Language:string; {аббревиатура языка по ISO 639 для интерфейса}
    LanguageDict:string; {аббревиатура языка по ISO 639 для словаря}
    LanguageExpl:string; {аббревиатура языка по ISO 639 для словаря толкований}
    LanguageCodepage:word; { кодовая страница текущего игрового языка }
    LastLoadedTime:string; // gjckt
    LastMainMEssage:1..10;
    LensSize:word; {размер лупы}
    LettersAvl:string[22]; { строка букв, доступных в текущем ходе }
    LettersLeft:word; { количество букв, оставшихся на поле выбора }
    Limit:string[20]; {  ограничение на игру }
    LimitWordLength:byte; {флаг ограничения длины слова}
    MessageForms:array[1..10] of TForm;
    MoveIs:1..4; { код номера хода }
    NewWord:string[15]; { новое составленное слово }
    OldHour, OldMinute, OldSecond, OldMSecond: word; { переменные времени }
    Opponent:Human..PC; { переменная оппонента }
    PCIntellect:1..4; { переменная интеллекта }
    PCMoveNumber:1..3; {номер хода компа}
    PlaySong:byte; { номер текущей исполняемой песни }
    PlayersNumber:0..7; { количество игроков в игре }
    PlayerImageDir:string;
    Prevalue:array [1..15] of TLabel; { метки предварительных ценностей слов }
    RC_Form:TForm; {окно с кнопками управления }
    RestGameTime:string[6]; { оставшееся время игры }
    //Save:SaveFileType; { запись в файл записи }
    Skin:string[50]; { название текущего скина (папки)}
    SoundVolume, MusicVolume: 0..100; { громкости }
    StartHour,StartMin,StartSec:Word;
    StoreHintLimit:byte; { вспомогательная переменная для кол-ва подсказок }
    TempCursor:TCursor; { переменная для запоминания текущего курсора}
    Template:string[255]; {шаблон поля }
    Theme:string[20]; { словарь игры }
    ThemeList:string[15]; { список ограничений по темам для текущего языка }
    ThemeListForAll:string; { список всех тем для всех языков (сохраняется в ини--файл) }
    Undo:UndoData; { данные, необходимые для отката хода }
    WhatIDoNow:12..14; { текущее действие (ход, замена, выбор букв) }
    Winner:1..10; { номер игрока-победителя }
    WorkFieldDimentionX,WorkFieldDimentionY:byte; {размерность игрового поля}


  {СЛОВАРЬ}
  CustomDict:TCustomDict; {запись использования пользовательского словаря}


  {ГРАФИКА}
  Images:array[1..3,1..50] of TPicture;
  ActiveLetter:TImage;
  GFX_Elem:TList;
  Player1Bitmap:TPicture;
  ScoreDisplay:TImage; { вспомогательный дисплей счета }
  HintBut:TImage; { вспомогательная кнопочка-подсказка }
  DeskTopBitmap:TBitmap; { временный битмап экрана для ЛУПЫ}
  DeskTopDC:HDC; {временных контекст экрана для ЛУПЫ}
  Colors:TStringList; {цвета элементов}

  {ЗВУК}
  NewGameSound, HallFameSound, GameOverSound,
  ScoreLimitSound, Bonus1Sound, Bonus2Sound,
  Change1Sound, Change2Sound, ChangeMoveSound,
  ErrorSound, GoodScore1Sound, GoodScore2Sound,
  GoodScore3Sound, Hint1Sound, Hint2Sound,
  Hint3Sound, IsWord1Sound, IsWord2Sound,
  IsWord3Sound, NotAvailableSound, NoWordsSound,
  SaveSound, Score1Sound, Score2Sound,
  TimeOutSound, YourMove1Sound, YourMove2Sound,
  YourMove3Sound, BgrMusic:HSAMPLE;
  IsPlaying:HChannel;

  {МАССИВЫ}
   { игровое многослойное поле }
   WorkField:array of array of WorkFieldType;
  { семибуквенный слот }
   Slot7:array of array of Slot7Type;
   Slot7Buffer:array[1..7] of Slot7Type;
  { список рекордсменов }
   HallFameArray:THallFameArray;
   { игроки }
   Players:array of PlayersType;
   { выложенные слова }
   Words:array of array of WordListType;
   { звездочки на поле по двум направлениям }
   Stars:array[1..7,1..2] of byte;
   { список членов клуба }
   Members:array[0..19] of PlayersType;
   { выделенные ячейки }
   SelectField:array of array of 0..3;
   { рамочки выделения }
   SelectShapes:array of TShape; Sh:TShape;
   { отобранные слова }
   ClearedWords:array of ClearedWordsType;
   {массив подсказанных слов}    
   HelpedWords:array of clearedwordstype;
   {количество призовых ячеек}
   ColorsCount:array[2..6] of word=(24,16,8,8,1);
   { список с фишками }
   Letters:array [0..899] of TImage;
   { список с именами шрифтов }
   FontNames:array [0..4] of string[30];
   { все строки программы - грузятся из юникод-файла }
   GlobalTextStrings:TTNTListBox;
   {архив с метками ограничения словарей}
   DictSpec:array[0..6] of char;
   { массив словаря }
   DictArray:array[0..50] of TstringList;
   { выделенные слова }
   SelectedWords:array of record
			     Word:ShortString;
			     Coord,WBegin,Wend:byte;
			     Direction:byte; Passed:boolean;
                             Linked:boolean; Tested:byte;
                             Stars:array[1..7] of record StX,StY:word; end;
			       end;
   {лог ходов }
   MovesLog:TStringList;


{ определение максимального элемента массива игроков }
Function GetWinner:byte;

{ процедура переноса фишки с одного места на другое }
 procedure TransferLetter(Opp:byte; Form1,Form2:TForm; X1,Y1,X2,Y2:word);

{ окно сообщения }
Procedure Announce(MessX,MessY:word; Contents:widestring);

{ окно вопроса }
Function Question(MessX,MessY:word; Contents:widestring):boolean;

{проверка слотов на пустые ячейки}
Function CheckSlots(player:byte):byte;

{ вывод главного  сообщения вверху экрана }
Procedure ShowMainMessage(MessX, MessY:word; GetMessage:string; Color:TColor; HelpMessage:string; Color1:TColor);

{ временные эффекты (мигание меток в режиме "БЫСТРЫЙ ВЗГЛЯД" и т.д.)}
Procedure TimeEffect(Mode:byte; AddParam:Byte);


{ обнаружение нового слова  }
Function LocateNewWord(MasX,MasY, Direction:byte; var WBegin,WEnd:byte; var Flag_3,NoShapes:boolean; var SelNum:byte):ShortString;

{ проверка слова на пересечение  }
Function IsCrossWord(Coord,WBegin,WEnd:byte; FirstWord:boolean; Direction:byte):boolean;

{ регистрация нового выставленного слова }
Procedure RegisterWord(Player:byte; Word:ShortString; WBegin,WEnd,Coord,Direction:byte; Value:byte);

{ копирование новых слов на главное игровое поле }
Procedure CopyToMainField(Coord,WBegin,WEnd,Direction:byte);

{ проверка на повторяющееся слово }
Function RepeatedWord(NewWord:ShortString;var WBegin,WEnd,Coord,Direction:byte):boolean;

{ расстановка точек привязки или хот-спотов }
Procedure SetHotSpots;

{ насчитывание очков на удачный ход }
Function CountPoints(Pl:byte; Coord,WBegin,WEnd:Word; Direction:byte):word;

{ поиск пустых ячеек для замены букв }
Procedure ChoiceEmptyXY(var x,y:byte);

{ eувеличение счета на терминале }
Procedure IncScore(Pl:byte; Value:integer);

{ обнаружение звездочек на игровом поле }
Function CheckStarPresent(WBegin,WEnd,Coord,Dimention:byte;SelNum:byte;noShapes:boolean):boolean;

{ восстановление звездочек при отмене хода }
Procedure RestoreStars;

{ организация задержки }
Procedure TimeDelay(Value:word);

{ проверка возможности поставить слово из набранных букв }
Function CheckMatching(WBegin,WEnd,Coord,Direction:byte):boolean;

{ проверка ограничений }
Procedure CheckLimits(var FinishGame:boolean);

{ конвертация строки из формата ASCII в ANSI }
Function ConvString(Str:string; Mode:byte):string;

{ мигание слова }
Procedure FlashWord(Mode:byte;WBegin,WEnd,Coord,Dimention:byte);

{ скрыть буквы на игровом поле }
Procedure HideLetters;

{ показать буквы на игровом поле }
Procedure ShowLetters;

{ считывание текущей midi-громкости }
function GetMidiVolume: DWord;

{ установка midi-громкости }
procedure SetMIDIVolume(const AVolume: DWord);

function BitmapToRegion(Bitmap: TBitmap; TransColor: TColor): HRGN;

{ обработка пользовательского словаря}
Function CheckCustomDictionary(var FindInDict:boolean; MessX,MessY:word):boolean;

{ копирование пользовательского словаря в буфер}
//procedure CopyDictionary(SName,DName:string);

{ сохранение именного инифайла }
function SaveIni(PlayerName:string):boolean;

{ загрузка именного инифайла }
function LoadIni(PlayerName:string):boolean;

{ загрузка "шкурных" файлов }
function LoadSkinnedImage(Pic:TPicture;fname:string):string;

{ загрузка "шкурных" анимаций }
procedure LoadSkinnedGIF(Pic:TGIFImage;fname:string);

{ загрузка файла Юникод в TStrings }
procedure LoadUnicodeFile(const filename: string; strings: TStrings; UnicodeList:TTNTListBox; correct:boolean; convert:boolean);

{ сохранение файла Юникод из TStrings }
procedure SaveUnicodeFile(const filename: string; strings: TStrings; TempList:TTNTListBox; correct:boolean; convert:boolean);

{ грузим словарь в память и разбиваем на куски }
procedure LoadDictionaryToMemory(All:boolean);

{ грузим алфавит текущего игрового языка }
procedure LoadAlphabet;

{ получение языка по аббревиатуре }
Function GetLanguageName(TempLang:string):string;

{ получение кодовой страницы языка }
Function GetLanguageCodepage(TempLang:string):word;

{ получение номера буквы в массиве букв по коду символа }
function GetLetterNum(TempChar:Char):integer;

{ получение номера буквы в массиве букв по коду символа }
function SetCharset(TempLanguage:string):TFontCharset;

{ корректировка строки на предмет всяких умлаутов }
procedure CorrectANSI(var TempS:string; TempUTF:utf8string);

{ корректировка строки UTF для возврата всяких умлаутов }
procedure CorrectUTFForSave(var TempUTF:utf8string; TempS:string);

{ замена подстроки в уникод-строке }
function WideReplaceText(TempWStr:widestring; StrToRepl:widestring; StrForRepl:string):widestring;

{ распаковка файла из 7zip архива }
function ExtractFile(Fname:string):boolean;

IMPLEMENTATION

uses Optns, main;

{---------------------------------------------------------------}
{ распаковка файла из 7zip архива }
function ExtractFile(Fname:string):boolean;
var I:integer; ms:TMemoryStream; C1:array[1..2] of char;
begin
 Result:=true;
 ms:=TMemoryStream.Create;
 ms.LoadFromFile(FName); ms.Seek(0,soFromBeginning);
 ms.Read(C1[1],sizeof(char)); ms.Read(C1[2],sizeof(char));
 ms.Free;
 If c1[1]+c1[2]<>'7z' Then begin Result:=false; exit; end;
 With MainScreen Do begin
  sevenzip1.SZFileName:=FName;
  //Sevenzip1.Password:='SIMSIMTOOPEN';
  Sevenzip1.ExtrBaseDir:=CurrentDir;
  Sevenzip1.Files.Clear;
  //sevenZip1.LZMACompressStrength:=MAXIMUM;
  //sevenzip1.List;
  //sevenzip1.ExtractOptions := sevenzip1.ExtractOptions + [ExtractOverwrite]+[ExtractNoPath];
  I:=sevenzip1.GetIndexByFilename('$$$.tmp');
  I:=sevenzip1.Extract;
  //If not Fileexists(CurrentDir+'\$$$.tmp') Then I:=-1;
                    end;
 If I<>0 Then Result:=false;
end;

{---------------------------------------------------------------}
{ замена подстроки в уникод-строке }
function WideReplaceText(TempWStr:widestring; StrToRepl:widestring; StrForRepl:string):widestring;
var TempUTFStr:utf8string; TempStr,tempStr1:widestring; k:word;
begin
   TempUTFStr:=ansitoutf8(StrForRepl);
   If GetLanguageCodepage(LanguageDict)<>1251 Then CorrectUTFForSave(TempUTFStr,StrForRepl);
   TempStr1:=TempWStr;
   For k:=1 to pos(StrToRepl,TempStr1)-1 do TempStr:=tempStr+TempStr1[k];
   TempStr:=TempStr+UTF8Decode(TempUTFStr);
   For k:=k+2 to length(TempStr1) do TempStr:=tempStr+TempStr1[k];
   Result:=TempStr;
end;

{---------------------------------------------------------------}
{ получение номера буквы в массиве букв по коду символа }
function SetCharset(TempLanguage:string):TFontCharset;
begin
   case GetLanguageCodepage(TempLanguage) of
        1251:Result:=RUSSIAN_CHARSET;
        1250,1252:Result:=EASTEUROPE_CHARSET;
        1257:Result:=BALTIC_CHARSET;
        else Result:=EASTEUROPE_CHARSET;
    end;
end;

{---------------------------------------------------------------}
{ получение номера буквы в массиве букв по коду символа }
function GetLetterNum(TempChar:Char):integer;
 var I:integer;
 begin
  Result:=-1;
  If TempChar=chr(FirstAlphCode+AlphCount) Then begin result:=AlphCount; exit; end;
   For I:=0 to AlphCount-1 Do
     If LettersCodes[I]=ord(TempChar) Then begin
        result:=I; exit;
                                           end;
 end;
{---------------------------------------------------------------}
{ получение языка по аббревиатуре }
Function GetLanguageName(TempLang:string):string;
var TempStrings:TStringList;  sLanguage: array [0..100] of char;
begin
  TempStrings:=TStringList.create;
  loadUnicodeFile(CurrentDir+'\lang\locales.txt',TempStrings,nil,false, convert);
  GetLocaleInfo(StrToInt(TempStrings.Values[ANSIUpperCase(Templang)]),LOCALE_SLANGUAGE,sLanguage, 100);
  Result:=LeftStr(string(sLanguage),pos('(',string(sLanguage))-1+100*ord(pos('(',string(sLanguage))=0));
  TempStrings.Free;
end;

{---------------------------------------------------------------}
{ получение кодовой страницы языка }
Function GetLanguageCodepage(TempLang:string):word;
var TempStrings:TStringList;  ANSICodepage:array [0..5] of char;
begin
  If TempLang='' Then exit;
  TempStrings:=TStringList.create;
  loadUnicodeFile(CurrentDir+'\lang\locales.txt',TempStrings,nil,false, convert);
  GetLocaleInfo(StrToInt(TempStrings.Values[ANSIUpperCase(Templang)]),LOCALE_IDEFAULTANSICODEPAGE,ANSICodepage, 100);
  Result:=StrToInt(string(ANSICodepage));
  TempStrings.Free;
end;

{---------------------------------------------------------------}
{ грузим алфавит текущего игрового языка }
procedure LoadAlphabet;
var TempStrList:TStringList; I:word;
begin
If FileExists(CurrentDir+'\dict\'+LanguageDict+'\alphabet.txt') Then begin
   TempStrList:=TStringList.Create;
   LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\alphabet.txt',TempStrList,nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
   FirstAlphCode:=ord(TempStrList.Strings[0][1]);
   AlphCount:=TempStrList.Count-1;
   For I:=0 to TempStrList.Count-1 Do
     begin LettersValue[I]:=StrToInt(Trim(copy(TempStrList.Strings[I],3,pos(',',MidStr(TempStrList.Strings[I],3,10))-1)));
           LettersQuantity[I]:=StrToInt(Trim(copy(TempStrList.Strings[I],3+pos(',',MidStr(TempStrList.Strings[I],3,10)),10)));
           LettersCodes[I]:=ord(TempStrList.Strings[I][1]);
           If I=AlphCount Then LettersCodes[I]:=FirstAlphCode+AlphCount;
       end;
   For I:=AlphCount+1 to 50 Do begin LettersValue[I]:=0; LettersQuantity[I]:=0; end;
   TempStrList.Free;

                                                                    end
                                                         Else
  Application.MessageBox(PChar(GlobalTextStrings.Items.Values['LoadMessageAlphabetFileNotFound']), '');
end;
{---------------------------------------------------------------}
{ грузим словарь в память и разбиваем на куски }
procedure LoadDictionaryToMemory(All:boolean);
var I:word; tempStrList:TStringList; FirstLetter:char; Index:byte; TempPos:byte;
    TempStr:string;
begin
If ALL Then begin
  TempStrList:=TStringList.Create;
  try
   For I:=0 to 39 Do begin
                       freeAndnil(DictArray[I]);
                                                   end;
  LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\dictionary.txt',TempStrList,nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
  FirstLetter:=#0;
  If TempStrList.Count>0 Then
   For I:=0 to TempStrList.Count-1 Do begin
     If ANSIUpperCase(TempStrList.Strings[i])[1]<>FirstLetter Then begin
                                   FirstLetter:=ANSIUpperCase(TempStrList.Strings[i])[1];
                                   Index:=GetLetterNum(FirstLetter)+1;
                                   DictArray[Index]:=TStringList.create;
                                   DictArray[Index].Duplicates:=dupAccept;
                                                    end;
     If TempStrList.Strings[i]<>'' Then begin
                                      TempPos:=Ifthen(pos('=',TempStrList.Strings[i])<>0,pos('=',TempStrList.Strings[i])-1,length(TempStrList.Strings[i]));
                                      TempStr:=ANSIReplaceText(TempStrList.Strings[i],LeftStr(TempStrList.Strings[i],TempPos),ANSIUpperCase(LeftStr(TempStrList.Strings[i],TempPos)));
                                      DictArray[Index].Add(TempStr);
                                        end;
                                   end;
  except end;
  TempStrList.free;
            end;
   { загружаем пользовательские добавленные слова }
   freeAndnil(DictArray[0]);
   If fileexists(CurrentDir+'\dict\'+LanguageDict+'\diction.user.add.txt') Then
      begin
       DictArray[0]:=TStringList.create;
       LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\diction.user.add.txt',DictArray[0],nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
      end;
   { загружаем пользовательские удаленные слова }
   freeAndnil(DictArray[length(DictArray)-1]);
   If fileexists(CurrentDir+'\dict\'+LanguageDict+'\diction.user.del.txt') Then
      begin
       DictArray[length(DictArray)-1]:=TStringList.create;
       LoadUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\diction.user.del.txt',DictArray[length(DictArray)-1],nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
      end;
end;
{---------------------------------------------------------------}
{ загрузка файла Юникод в TStrings }

  procedure CorrectANSI(var TempS:string; TempUTF:utf8string);
    var I,J,k:integer; wc:cardinal; c:byte; tempStr:widestring; TempWCode:word;
   begin
      J:=1;
      For I:=1 to length(TempS) do begin
       If tempS[i]<>TempUTF[j] then begin
          wc := Cardinal(TempUTF[j]);
          Inc(j);
          if (wc and $80) <> 0 then begin  //$80 = 128 = 10000000 } проверка на код > 127
              wc := wc and $3F;            //$3F = 63 = 111111 }  отделяем от первого байта последние 5 цифр
              if (wc and $20) <> 0 then  begin  //$20 = 32 = 100000 }
                c := Byte(TempUTF[j]);
                if (c and $C0) <> $80 then Exit; //$C0 = 192 = 11000000 }    // malformed trail byte or out of range char
                wc := (wc shl 6) or (c and $3F);
                                         end;
           c := Byte(TempUTF[j]);
           if (c and $C0) <> $80 then Exit;       // malformed trail byte
             TempWCode:=(wc shl 6) or (c and $3F);
             For k:=1 to length(SpecSymbols[1]) Do
               If SpecSymbols[1,k]=TempWCode Then
                    begin TempS[i]:=chr(SpecSymbols[2,k]); break; end
                                             Else
               If SpecSymbols[1,k]=word(WideUppercase(widechar(TempWCode))[1]) Then
                    begin TempS[i] := ANSILowercase(string(chr(SpecSymbols[2,k])))[1]; break; end;
                                                   end;
                                   end;
        inc(j);
                                   end;
   end;

procedure LoadUnicodeFile(const filename: string; strings: TStrings; UnicodeList:TTNTListBox; correct:boolean; convert:boolean);

  procedure SwapWideChars(p: PWideChar);
  begin
    while p^ <> #0000 do
    begin p^ := WideChar(Swap(Word(p^))); Inc(p); end;
  end;

var
  ms: TMemoryStream; wc: WideChar; pWc: PWideChar;
  utf8str:utf8string; f:text; c:char; p: PWideChar; TempStr:ansistring; widestr:widestring;
begin
  If not FileExists(filename) Then exit;
  try
 if Convert Then begin
   strings.Clear;
   AssignFile(f,filename);
   Reset(f); Read(f,c); Read(f,c); Read(f,c);
   While not EOF(f) Do begin
   readln(f,utf8str);
         TempStr:=utf8toansi(utf8str);
         If correct Then CorrectANSI(TempStr,utf8str);
         strings.add(TempStr);
         //MainScreen.UnicodeListBox.Items.add(utf8str);
                      end;
   CloseFile(f)
                 end
                   else begin
       (* ms := TMemoryStream.Create;
        ms.LoadFromFile(filename); ms.Seek(0, soFromend);
        wc := #000000; ms.Write(wc, sizeof(wc));
        pwC := ms.Memory;
        if pWc^ = #$FEFF then {normal byte order mark}
                       Inc(pWc)
                           else if pWc^ = #$FFFE then
                            begin {byte order is big-endian}
                               SwapWideChars(pWc); Inc(pWc);
                               inc(pwc);
                            end
                      else ; {no byte order mark}
        //TempUStr:=TTNTStrings.create; *)
        //UnicodeList.Items.text:=pWc;
        UnicodeList.Items.LoadFromFile(filename);
        //strings.Text := WideChartoString(pWc);
        //ms.free; pWC:=nil;
        //strings.add(widestring(utf8str));
                        end;

  finally
  end;
end;

{---------------------------------------------------------------}
{ сохранение файла Юникод из TStrings }

  procedure CorrectUTFForSave(var TempUTF:utf8string; TempS:string);
    var I,J,k:integer; wc:cardinal; c:byte; TempCode:word;
   begin
      J:=1;
      For I:=1 to length(TempS) do begin
       If tempS[i]<>TempUTF[j] then begin
          TempCode:=ord(tempS[i]);
          For k:=1 to length(SpecSymbols[2]) Do
             If (SpecSymbols[2,k]=TempCode) and (GetLanguageCodepage(LanguageDict)=1000+SpecSymbols[3,k])
                Then begin
                         TempCode:=SpecSymbols[1,k];
                         TempUTF[j] := Char($C0 or (TempCode shr 6));
                         TempUTF[j+1] := Char($80 or (TempCode and $3F));
                         inc(j,2);
                         break; end;
                                   end Else inc(j);

                                   end;
   end;

procedure SaveUnicodeFile(const filename: string; strings: TStrings; TempList:TTNTListBox; correct:boolean; convert:boolean);
var I,j:byte; //WStr:array[0..255] of WideChar; MBuffer:TMemoryStream;
              f:text; c:char; TempStr:utf8string;

begin
   //MBuffer:=TMemoryStream.Create;
   //I:=$FF; MBuffer.Write(I,sizeof(I)); I:=$FE; MBuffer.Write(I,sizeof(I));
  If Convert Then begin
   Assign(f,filename);
   rewrite(f);
   If Strings.Count<>0 Then begin
    c:=chr($EF); Write(f,c); c:=chr($BB); Write(f,c); c:=chr($BF); Write(f,c);
    For I:=0 to strings.Count-1 Do begin
       TempStr:=ANSItoUTF8(strings.Strings[i]);
       If correct Then CorrectUTFForSave(TempStr,strings.Strings[i]);
       Writeln(f,tempStr);
                                   end;
                            end;
   closeFile(f);
               end
            Else begin
   TempList.Items.SaveToFile(filename);
                 end;
   //MBuffer.SaveToFile(filename); mBuffer.Free;
end;

{---------------------------------------------------------------}
{ загрузка "шкурных" файлов }
function LoadSkinnedImage(Pic:TPicture;fname:string):string;
var srf:TSearchRec;
begin
 If FindFirst('GRAFIX\'+Skin+'\'+fname+'.*',0,srf)=0
     Then begin Pic.LoadFromFile('GRAFIX\'+Skin+'\'+fname+RightStr(srf.Name,4)); Result:=RightStr(srf.Name,3); end
     Else begin FindFirst('GRAFIX\classic\'+fname+'.*',0,srf);
                Pic.LoadFromFile('GRAFIX\classic\'+srf.name); Result:='bmp';
            end;
  //Pic.Bitmap.Assign(Pic);

  //FindClose(srf);
end;
{---------------------------------------------------------------}
{ загрузка "шкурных" анимаций }
procedure LoadSkinnedGIF(Pic:TGIFImage;fname:string);
var srf:TSearchRec;
begin
 If FindFirst(CurrentDir+'\GRAFIX\'+Skin+'\'+fname+'.gif',0,srf)=0
     Then Pic.LoadFromFile(CurrentDir+'\GRAFIX\'+Skin+'\'+fname+'.gif')
     Else Pic.LoadFromFile(CurrentDir+'\GRAFIX\classic\'+fname+'.gif');
  //FindClose(srf);
end;

{---------------------------------------------------------------}
{ сохранение именного инифайла }
function SaveIni(PlayerName:string):boolean;
const
      OppArr:array[0..3] of string[6]=('Human','PC','Net','');
      AddWrd:array[0..3] of string[6]=('No','Yes','Ask','');
      Colors:array[2..6] of string[6]=('Green','Blue','Yellow','Red','Black');
var I:byte; TempStr:TStringList;
begin
TempStr:=TStringList.Create;
TempStr.Add('[Last Game]');
TempStr.Add('LastOpponent='+OppArr[Opponent]);
TempStr.Add('LastIntellect='+IntToStr(PCIntellect));
TempStr.Add('LastLimits='+Limit);
TempStr.Add('LastWordLengthLimit='+IntToStr(LimitWordLength));
TempStr.Add('LastPlayersNumber='+IntToStr(PlayersNumber));
TempStr.Add(chr(13)+'[Last Players]');
For I:=1 to PlayersNumber Do TempStr.Add('Player'+inttostr(I)+'='+Players[i].Name+'/'+Players[i].Image+'/'+OppArr[Players[i].pltype]+'/'+IntToStr(Players[i].code));
TempStr.Add(chr(13)+'[Options Common]');
TempStr.Add('ShowPCWords='+IntToStr(ord(ShowClearedWords)));
TempStr.Add('CrossWordMode='+IntToStr(ord(CrossWord_Mode)));
TempStr.Add('SelectWordMode='+IntToStr(ord(AllowSelect)));
TempStr.Add('ExchangeStars='+IntToStr(ord(TakeStar)));
TempStr.Add('FlashStarMarkers='+IntToStr(ord(FlashStarMarkers)));
TempStr.Add('AllowWordRepeat='+IntToStr(ord(AllowWordRepeat)));
TempStr.Add('KeepBonuses='+IntToStr(ord(KeepBonuses)));
TempStr.Add('LettersAutoSelect='+IntToStr(ord(LettersAutoSelect)));
TempStr.Add('MinimizeOnEsc='+IntToStr(ord(MinimizeOnEsc)));
TempStr.Add('AutoSpreadPlayers='+IntToStr(ord(AllPlayersOpen)));
TempStr.Add(chr(13)+'[Options Appearance]');
TempStr.Add('ShowColorLetters='+IntToStr(ord(ShowColorLetters)));
TempStr.Add('AnimActiveAvatarOnly='+IntToStr(ord(AnimActiveAvatar)));
TempStr.Add('AnimHighlightActivePlayer='+IntToStr(ord(AnimActivePlayer)));
TempStr.Add('AlwaysShowDictionaryPanel='+IntToStr(ord(AlwaysShowDictionaryPanel)));
TempStr.Add('LensSize='+IntToStr(LensSize));
TempStr.Add(chr(13)+'[Options Hint]');
TempStr.Add('HintDelay='+IntToStr(HintDelay));
TempStr.Add('HintCount='+IntToStr(StoreHintLimit));
TempStr.Add('HintPushButton='+IntToStr(ord(HintPushButton)));
TempStr.Add(chr(13)+'[Options Sound]');
TempStr.Add('PlaySounds='+IntToStr(ord(PlaySounds)));
TempStr.Add('PlayBackgroundMusic='+IntToStr(ord(PlayBackgroundMusic)));
TempStr.Add('PlayShuffle='+IntToStr(ord(PlayShuffle)));
TempStr.Add('SoundVolume='+IntToStr(SoundVolume));
TempStr.Add('MusicVolume='+IntToStr(MusicVolume));
TempStr.Add(chr(13)+'[Options Dictionary]');
TempStr.Add('DictionaryLimits='+ANSIReplaceText(ThemeListForAll,#$D#$A,'/'));
TempStr.Add('UseCustomDictionary='+IntToStr(ord(CustomDict.Use)));
TempStr.Add('AddCustomWord='+AddWrd[CustomDict.AddWord]);
TempStr.Add('WordRequiredAlways='+IntToStr(ord(CustomDict.WordRequired)));
TempStr.Add('AskToExcludeWord='+IntToStr(ord(CustomDict.WarnDelete)));
TempStr.Add('AskToAddExplanation='+IntToStr(ord(CustomDict.WarnAddExplanation)));
TempStr.Add('UndoPCMove='+IntToStr(ord(RepeatTurn)));
TempStr.Add(chr(13)+'[Options Template]');
TempStr.Add('LastTemplate='+Template);
TempStr.Add('PlayFieldDimX='+IntToStr(WorkFieldDimentionX));
TempStr.Add('PlayFieldDimY='+IntToStr(WorkFieldDimentionY));
For I:=2 to 6 Do TempStr.Add(Colors[I]+'='+IntToStr(ColorsCount[I]));
TempStr.Add(chr(13)+'[Options Language]');
TempStr.Add('InterfaceLang='+Language);
TempStr.Add('DictionaryLang='+LanguageDict);
TempStr.Add('ExplanatoryLang='+LanguageExpl);
SaveUnicodeFile(CurrentDir+'\'+ANSILowerCase(PlayerName)+'.ini',tempStr,nil,false,convert);
TempStr.Free;
SaveIni:=true;
end;
{---------------------------------------------------------------}
{ загрузка именного инифайла }
function LoadIni(PlayerName:string):boolean;
var  I:byte; TempStr:TStringList; TempStrList:TStringList; TempS:string;
begin
If not FileExists(ANSILowerCase(CurrentDir+'\'+PlayerName+'.ini')) Then begin LoadIni:=false; exit; end;
TempStr:=TStringList.Create;
LoadUnicodeFile(CurrentDir+'\'+PlayerName+'.ini',TempStr,nil,GetLanguageCodepage(Language)<>1251, convert);
TempS:=TempStr.Values['LastOpponent'];
Opponent:=ord(LeftStr(TempS,pos('/',TempS)-1)='PC')+ord(LeftStr(TempS,pos('/',TempS)-1)='Human')*0+ord(LeftStr(TempS,pos('/',TempS)-1)='Net')*2;
PCIntellect:=StrToInt(TempStr.Values['LastIntellect']);
Limit:=TempStr.Values['LastLimits'];
LimitWordLength:=StrToint(TempStr.Values['LastWordLengthLimit']);
PlayersNumber:=StrToInt(TempStr.Values['LastPlayersNumber']);
Players:=nil;
setlength(Players,PlayersNumber+1); setlength(Words,201,PlayersNumber+1); 
I:=1;
While tempStr.Values['Player'+IntToStr(i)]<>'' Do begin
      TempS:=TempStr.Values['Player'+IntToStr(i)];
      Players[i].Name:=LeftStr(TempS,pos('/',TempS)-1); delete(TempS,1,pos('/',TempS));
      Players[i].Image:=LeftStr(TempS,pos('/',TempS)-1); delete(TempS,1,pos('/',TempS));
      Players[i].pltype:=ord(LeftStr(TempS,pos('/',TempS)-1)='PC')+ord(LeftStr(TempS,pos('/',TempS)-1)='Human')*0+ord(LeftStr(TempS,pos('/',TempS)-1)='Net')*2;
      delete(TempS,1,pos('/',TempS));
      Players[i].code:=StrToInt(TempS);
      inc(i);
                                                  end;

ShowClearedWords:=(TempStr.Values['ShowPCWords']='1');
CrossWord_Mode:=(TempStr.Values['CrossWordMode']='1');
AllowSelect:=(TempStr.Values['SelectWordMode']='1');
TakeStar:=(TempStr.Values['ExchangeStars']='1');
FlashStarMarkers:=(TempStr.Values['FlashStarMarkers']='1');
AllowWordRepeat:=(TempStr.Values['AllowWordRepeat']='1');
KeepBonuses:=(TempStr.Values['KeepBonuses']='1');
LettersAutoSelect:=(TempStr.Values['LettersAutoSelect']='1');
MinimizeOnEsc:=(TempStr.Values['MinimizeOnEsc']='1');
AllPlayersOpen:=(TempStr.Values['AutoSpreadPlayers']='1');
ShowColorLetters:=(TempStr.Values['ShowColorLetters']='1');
AnimActiveAvatar:=(TempStr.Values['AnimActiveAvatarOnly']='1');
AnimActivePlayer:=(TempStr.Values['AnimHighlightActivePlayer']='1');
AlwaysShowDictionaryPanel:=(TempStr.Values['AlwaysShowDictionaryPanel']='1');
LensSize:=StrToInt(ifthen(TempStr.Values['LensSize']<>'',TempStr.Values['LensSize'],'120'));
HintDelay:=StrToInt(TempStr.Values['HintDelay']);
HintLimit:=StrToInt(TempStr.Values['HintCount']);
HintPushButton:=(TempStr.Values['HintPushButton']='1');
PlaySounds:=(TempStr.Values['PlaySounds']='1');
PlayBackgroundMusic:=(TempStr.Values['PlayBackgroundMusic']='1');
PlayShuffle:=(TempStr.Values['PlayShuffle']='1');
SoundVolume:=StrToInt(TempStr.Values['SoundVolume']);
MusicVolume:=StrToInt(TempStr.Values['MusicVolume']);
CustomDict.Use:=(TempStr.Values['UseCustomDictionary']='1');
TempS:=TempStr.Values['AddCustomWord'];
CustomDict.AddWord:=ord(TempS='Yes')+ord(TempS='No')*0+ord(TempS='Ask')*2;
CustomDict.WordRequired:=(TempStr.Values['WordRequiredAlways']='1');
CustomDict.WarnDelete:=(TempStr.Values['AskToExlcudeWord']='1');
CustomDict.WarnAddExplanation:=(TempStr.Values['AskToAddExplanation']='1');
RepeatTurn:=(TempStr.Values['UndoPCMove']='1');
Template:=TempStr.Values['LastTemplate'];
WorkFieldDimentionX:=StrToInt(TempStr.Values['PlayFieldDimX']);
WorkFieldDimentionY:=StrToInt(TempStr.Values['PlayFieldDimY']);
ColorsCount[2]:=StrToInt(TempStr.Values['Green']); ColorsCount[3]:=StrToInt(TempStr.Values['Blue']);
ColorsCount[4]:=StrToInt(TempStr.Values['Yellow']); ColorsCount[5]:=StrToInt(TempStr.Values['Red']);
ColorsCount[6]:=StrToInt(TempStr.Values['Black']);
Language:=TempStr.Values['InterfaceLang'];
LanguageDict:=TempStr.Values['DictionaryLang'];
LanguageExpl:=TempStr.Values['ExplanatoryLang'];
ThemeListForAll:=ANSIReplaceText(TempStr.Values['DictionaryLimits'],'/',#$D#$A);
   TempStrList:=TStringList.create; TempStrList.Text:=ThemeListForAll;
   Theme:=TempStrList.Values['Lim'+LanguageDict];
   ThemeList:=TempStrList.Values[LanguageDict];
   TempStrList.free;
TempStr.Free;
LoadIni:=true;
end;

{---------------------------------------------------------------}
{ обработка пользовательского словаря}
Function CheckCustomDictionary(var FindInDict:boolean; MessX,MessY:word):boolean;
var DictWord:string[35]; AddWordNow:boolean; TempStr,TempStr1:widestring; TempUTFStr:utf8string; TempStrings:TStringList; I:word;
    k:byte;
begin
         AddWordNow:=False;
            { проверяеем удаленные слова пользователя }
            TempStrings:=DictArray[length(DictArray)-1];
            If TempStrings<>nil Then
              If TempStrings.count>0 Then
                 If (TempStrings.IndexOfname(NewWord)<>-1)
                 or (TempStrings.IndexOf(NewWord)<>-1) Then begin FindInDict:=false; Result:=False; end;
              { проверяеем добавленные слова пользователя }
             TempStrings:=DictArray[0];
             If TempStrings<>nil Then
               If TempStrings.count>0 Then
                   If (TempStrings.IndexOfname(NewWord)<>-1)
                   or (TempStrings.IndexOf(NewWord)<>-1) Then FindInDict:=True;

        { добавлeние слова в пользовательский словарь }
         If CustomDict.Use and not FindInDict
            Then
          begin
            if CustomDict.AddWord=No Then AddWordNow:=false Else AddWordNow:=true;
               if CustomDict.AddWord=Ask Then begin
               TempStr:=WideReplaceText(GlobalTextStrings.Items.Values['InGameQuestionAddWordToDictionary'],'%s',NewWord);
               AddWordNow:=Question(MessX,MessY,TempStr);
                                              end;
               if AddWordNow Then
                  If CustomDict.AddWord=Yes Then begin
                      If DictArray[0]=nil Then DictArray[0]:=TStringList.Create;
                      DictArray[0].Add(NewWord);
                      SaveUnicodeFile(CurrentDir+'\dict\'+LanguageDict+'\diction.user.add.txt',DictArray[0],nil,getLanguageCodepage(LanguageDict)<>1251,convert);
                                                 end
                                            Else begin
                  Options.Tag:=22; Options.Edit1.Text:=NewWord;
                  Options.ShowModal;
                                                 end
                             Else If PlaySounds Then BASS_SamplePlay(ErrorSound);
          end;
            Result:=AddWordNow;

end;
{---------------------------------------------------------------}
{ определение максимального элемента массива игроков }
Function GetWinner:byte;
var I,J,_Winner:byte;
begin
  _Winner:=1; J:=0;
  For I:=2 to length(Players)-1 Do begin
     If Players[I].Points>Players[_Winner].Points Then _Winner:=I;
     If Players[I].Points=Players[I-1].Points Then inc(J);
                                 end;
  If J=I-2 Then _Winner:=0;
  GetWinner:=_Winner;
end;
{---------------------------------------------------------------}
{ процедура переноса фишки с одного места на другое }
 procedure TransferLetter(Opp:byte; Form1,Form2:TForm; X1,Y1,X2,Y2:word);
  var I,X,Y:word; XPix,YPix,Id:integer; Im:TImage; ScreenCoord:TPoint; TransferForm:TForm;
  begin
//While MainScreen.ExplCBox.Focused Do Application.ProcessMessages;
   For I:=0 To WorkFieldDimentionX*WorkFieldDimentionY-1 Do begin
   Im:=Letters[i]; If (Im.Left=X1) and (Im.Top=Y1) and ((Im.Tag<>-1) and (Im.Parent=Form1)
    { or (Im.HelpContext=1)}) Then begin
                              ActiveLetter:=Im; ActiveLetter.BringToFront; break;
                                                                             end;
                     end;

 ScreenCoord.X:=X1; Screencoord.Y:=Y1;
 ClientToScreen(Form1.Handle,ScreenCoord);
 Id:=ScreenCoord.X; XPix:=ScreenCoord.X; YPix:=ScreenCoord.Y;

 ScreenCoord.X:=X2; Screencoord.Y:=Y2;
 ClientToScreen(Form2.Handle,ScreenCoord);
 X2:=ScreenCoord.X; Y2:=ScreenCoord.Y;

 TransferForm:=TForm.Create(Application);
 TransferForm.FormStyle:=fsStayOnTop; TransferForm.BorderStyle:=bsNone; TransferForm.AutoSize:=true;
 TransferForm.Left:=Id; TransferForm.Top:=YPix;
 ActiveLetter.Parent:=TransferForm; ActiveLetter.Left:=0; ActiveLetter.Top:=0; ActiveLetter.Show;
 TransferForm.OnActivate:=bonusInfo.OnActivate; TransferForm.Enabled:=false;
 If not ApplicationMinimized and not GameLoading Then TransferForm.Show;
 Application.MainForm.SetFocus;

 MainScreen.Enabled:=false;
 CASE Id>X2 of
 True:
 While (Id > X2) Do begin
 X:=Id;
 Y:=((Id*(Y2-YPix)-XPix*Y2+YPix*X2)div(X2-XPix));
 TransferForm.Left:=X; TransferForm.Top:=Y; TransferForm.Update;
 Dec(Id,25);
 TimeDelay(8);
                                   end;
 False:
 While Id < X2 Do begin
 X:=Id;
 Y:=((Id*(Y2-YPix)-XPix*Y2+YPix*X2)div(X2-XPix));
 TransferForm.Left:=X; TransferForm.Top:=Y; TransferForm.Update;
 inc(Id,25);
 TimeDelay(8);
                                   end;
 END;
 MainScreen.Enabled:=true; 
 ActiveLetter.Hide;
 ActiveLetter.Parent:=Form2;
 ScreenToClient(Form2.Handle,ScreenCoord);
 X2:=ScreenCoord.X; Y2:=ScreenCoord.Y;
 ActiveLetter.Left:=X2;
 ActiveLetter.Top:=Y2;
 {If not GameLoading then} ActiveLetter.Show;
 Form2.Update;
 ActiveLetter:=nil;
 Application.MainForm.Update;
{ ShowCurrentTime; }
TransferForm.Release;
  end;
{---------------------------------------------------------------}
{ организация задержки }
Procedure TimeDelay(Value:word);
var H,M,S,SStart,MS:word; Temp:word;
begin
 DecodeTime(Time,H,M,SStart,Ms); Temp:=SStart*1000+Ms+Value;
 S:=SStart;
 While S*1000+Ms<=Temp Do begin
    DecodeTime(Time,H,M,S,Ms); If S<SStart Then inc(S,60);
    Application.ProcessMessages;
    If StopHelp Then Exit;
    If FinishGame Then Exit;
                         end;
end;
{---------------------------------------------------------------}
{ окно сообщения }
Procedure Announce(MessX,MessY:word; Contents:widestring);
var DefaultCoord:TPoint; MessageLabel:TTNTLabel;
begin
 Screen.Cursor:=crDefault;
 If not Preview and not Helped AND not FinishGame and not DemoMode
   Then 
 { запоминаем изначальные координаты окна (по сути координаты главного окна)}
 DefaultCoord.X:=ErrorWindow.Left; DefaultCoord.Y:=ErrorWindow.Top;
 { меняем координаты окна замены смещением от изначальных }
 If (MessX=0) and (MessY=0) Then begin
    ErrorWindow.Position:=poMainFormCenter; Shadow_Form.Position:=poMainFormCenter; end
 Else begin
     ErrorWindow.Left:={DefaultCoord.X+}MessX; ErrorWindow.Top:={DefaultCoord.Y+}MessY;
     Shadow_Form.Left:=MessX; Shadow_Form.Top:=MessY;
      end;
 MessageLabel:=TTNTLabel.Create(ErrorWindow); MessageLabel.Parent:=ErrorWindow;
 MessageLabel.Transparent:=true; MessageLabel.AutoSize:=false;
 MessageLabel.Font.Style:=[fsBold]; MessageLabel.Font.Name:=FontNames[ttfMess];
 MessageLabel.Font.Color:=StrToInt(ifthen(CustomColors,Colors.Values['InGameMessage'],IntToStr($005959FF)));
 MessageLabel.Font.Size:=11; MessageLabel.Font.Charset:=DEFAULT_CHARSET;
 MessageLabel.Caption:=Contents; MessageLabel.WordWrap:=true; MessageLabel.Alignment:=taCenter;
 MessageLabel.Left:=10; MessageLabel.Top:=18; MessageLabel.Width:=300; MessageLabel.Height:=88;
 //MessageLabel.Layout:=tlCenter;
 //MessageLabel.ShadowColor:=clBlack; MessageLabel.ShadowSize:=1; MessageLabel.ShadowPos:=spLeftBottom;
 MessageLabel.Name:='MessageLabel';
 MessageLabel.SendToBack;
 If not ApplicationMinimized Then ErrorWindow.Tag:=1 Else ErrorWindow.Tag:=666;
 //ErrorWindow.X_Button.Hint:='Убрать замечание!';
 ErrorWindow.ButtonYes.Visible:=False;
 Shadow_Form.Width:=ErrorWindow.Width; Shadow_Form.Height:=ErrorWindow.Height;
 If not ApplicationMinimized Then Shadow_Form.Show;
 Shadow_Form.Left:=Shadow_Form.Left+7; Shadow_Form.Top:=Shadow_Form.Top+7;
 { отображаем окно модальным}
 ErrorWindow.ShowModal;
 If not FinishGame and not DemoMode Then
 ErrorWindow.Left:=DefaultCoord.X; ErrorWindow.Top:=DefaultCoord.Y;
 Shadow_Form.Hide;
end;
{---------------------------------------------------------------}
{ окно вопроса }
Function Question(MessX,MessY:word; Contents:widestring):boolean;
var DefaultCoord:TPoint; MessageLabel:TTNTLabel;
begin
 Screen.Cursor:=crDefault;
 { запоминаем изначальные координаты окна (по сути координаты главного окна)}
 DefaultCoord.X:=ErrorWindow.Left; DefaultCoord.Y:=ErrorWindow.Top;
 { меняем координаты окна замены смещением от изначальных }
 If (MessX=0) and (MessY=0) Then begin
    ErrorWindow.Position:=poMainFormCenter; Shadow_Form.Position:=poMainFormCenter; end
 Else begin
     ErrorWindow.Left:={DefaultCoord.X+}MessX; ErrorWindow.Top:={DefaultCoord.Y+}MessY;
     Shadow_Form.Left:=MessX; Shadow_Form.Top:=MessY;
      end;
 MessageLabel:=TTNTLabel.Create(ErrorWindow); MessageLabel.Parent:=ErrorWindow;
 MessageLabel.Transparent:=true; MessageLabel.AutoSize:=false; MessageLabel.Font.Charset:=DEFAULT_CHARSET;
 MessageLabel.Font.Style:=[fsBold]; MessageLabel.Font.Name:=FontNames[ttfMess];
 MessageLabel.Font.Color:=StrToInt(ifthen(CustomColors,Colors.Values['InGameQuestion'],IntToStr(clWhite)));;
 MessageLabel.Font.Size:=11;
 MessageLabel.Caption:=Contents; MessageLabel.WordWrap:=true; MessageLabel.Alignment:=taCenter;
 //MessageLabel.Layout:=tlCenter;
 MessageLabel.Left:=10; MessageLabel.Top:=18; MessageLabel.Width:=300; MessageLabel.Height:=88;
 //MessageLabel.ShadowColor:=clBlack; MessageLabel.ShadowSize:=1; MessageLabel.ShadowPos:=spLeftBottom;
 MessageLabel.Name:='MessageLabel'; //MessageLabel.Font.Charset:=Setcharset(Language);
 MessageLabel.SendToBack;
 ErrorWindow.Tag:=2;
 //ErrorWindow.X_Button.Hint:='Пожалуй, нет!';
 ErrorWindow.ButtonYes.Visible:=True;
 Shadow_Form.Width:=ErrorWindow.Width; Shadow_Form.Height:=ErrorWindow.Height;
 Shadow_Form.Show;
 Shadow_Form.Left:=Shadow_Form.Left+7; Shadow_Form.Top:=Shadow_Form.Top+7;
 { отображаем окно модальным}
 ErrorWindow.ShowModal;
 If ErrorWindow. ModalResult=mrYes Then Question:=True Else Question:=False;
 ErrorWindow.Left:=DefaultCoord.X; ErrorWindow.Top:=DefaultCoord.Y;
 Shadow_Form.Hide;
end;
{---------------------------------------------------------------}
{проверка слотов на пустые ячейки}
Function CheckSlots(player:byte):byte;
var I:byte; SlotsAvailable:byte;
begin
  If length(Slot7)=0 Then exit;
  SlotsAvailable:=0;
  For I:=1 To 7 Do If Slot7[player,I].Letter=' ' Then inc(SlotsAvailable);
  CheckSlots:=SlotsAvailable;
end;
{---------------------------------------------------------------}
{ вывод сообщения о счете }
Procedure ShowMainMessage(MessX, MessY:word; GetMessage:string; Color:TColor; HelpMessage:string; Color1:TColor);
var PLLabel:TRXLabel; I:byte;
begin
    If Preview or GameLoading Then exit;
    If (HelpMessage<>'') and (Color1=clRed) and (MessageForms[LastMainMessage]<>nil) Then begin
      (MessageForms[LastMainMessage].FindComponent('MesLabel2') as TRXLabel).Font.Color:=Color1;
      (MessageForms[LastMainMessage].FindComponent('MesLabel2') as TRXLabel).Caption:=HelpMessage;
                                                 end
                                            Else begin
    For I:=1 to 10 Do If MessageForms[I]=nil Then break;
    MessageForms[I]:=TForm.Create(Application);
    MessageForms[I].FormStyle:=fsStayOnTop;
    MessageForms[I].BorderStyle:=bsNone;
    MessageForms[I].AutoSize:=true;
    MessageForms[I].TransparentColor:=true;
    MessageForms[I].TransparentColorValue:=clGray;
    MessageForms[I].Color:=clGray;
    MessageForms[I].OnActivate:=BonusInfo.OnActivate;
    MessageForms[I].Enabled:=false;
    PlLabel:=TRxLabel.Create(MessageForms[I]);
    PlLabel.Parent:=MessageForms[I]; PlLabel.AutoSize:=true;
    PlLabel.Transparent:=true;
    PlLabel.Font.Name:=FontNames[ttfSplash];
    PlLabel.Font.Charset:=DEFAULT_CHARSET;
    PlLabel.Font.Size:=18; PlLabel.Font.Style:=[fsBold];
    PlLabel.Font.Color:=clTeal; PlLabel.ShadowColor:=clBlack; PLLabel.ShadowPos:=spLeftBottom;
    PlLabel.ShadowSize:=2;
    PLlabel.Alignment:=taLeftJustify; PlLabel.Top:=0; PlLabel.Left:=0;
    PlLabel.Name:='MesLabel1';
    PlLabel:=TRxLabel.Create(MessageForms[I]); PlLabel.Parent:=MessageForms[I];
    PlLabel.AutoSize:=true; PlLabel.Transparent:=true;
    PlLabel.Font.Name:='MS Sans Serif';
    If win32Platform<>ver_platform_win32_nt Then PlLabel.Font.Charset:=RUSSIAN_CHARSET Else PlLabel.Font.Charset:=DEFAULT_CHARSET;
    PlLabel.Font.Size:=9; PlLabel.Font.Style:=[fsBold]; PLLabel.Color:=clNavy;
    PlLabel.Font.Color:=Color1; PlLabel.ShadowColor:=clBlack; PLLabel.ShadowPos:=spLeftBottom;
    PLlabel.Alignment:=taLeftJustify; PlLabel.Top:=25; PlLabel.Left:=0;
    PlLabel.Name:='MesLabel2';
    (MessageForms[I].FindComponent('MesLabel1') as TRXLabel).Caption:=GetMessage;
    (MessageForms[I].FindComponent('MesLabel1') as TRXLabel).Font.Color:=Color;
    (MessageForms[I].FindComponent('MesLabel2') as TRXLabel).Caption:=HelpMessage;
    If (MessX=0) and (MessY=0) Then
    MessageForms[I].Position:=poMainFormCenter
                               Else begin
    MessageForms[I].Left:=MessX; MessageForms[I].Top:=MessY;
                                    end;
    _MessageTimer.Enabled:=true;
    If not ApplicationMinimized Then MessageForms[I].Show;
    LastMainMessage:=I;
                                          end;
end;
{---------------------------------------------------------------}
{ временные эффекты (мигание меток в режиме "БЫСТРЫЙ ВЗГЛЯД" и т.д.)}
Procedure TimeEffect(Mode:byte; AddParam:byte);
var I,J:byte;
begin
Screen.Cursor:=crHourGlass;
case Mode of
 1: begin
   For I:=1 To 3+2*AddParam Do begin
      For J:=1 To 15 Do begin
        If Prevalue[J].Enabled Then Prevalue[J].Visible:=not Prevalue[J].Visible;
           Prevalue[J].Update;
                       end;

      TimeDelay(400);
      If FinishGame Then Exit;
                    end;
   For I:=1 To 15 Do Prevalue[I].Enabled:=False;
    end;
end;
end;
{---------------------------------------------------------------}
{ показ текущего времени и прочих временных приколов}
Procedure ShowCurrentTime;
var SHour,SMinute,SSec:string[2];
begin
 DecodeTime(Time,Hour,Minute,Second,MSecond);

 If not MoveLimit Then begin
 { меняем время во время хода компьютера }
 If (Hour=OldHour) and (Minute=OldMinute) Then Else begin
 If Hour<10 Then SHour:='0'+IntToStr(Hour) Else SHour:=IntToStr(Hour);
 If Minute<10 Then SMinute:='0'+IntToStr(Minute) Else SMinute:=IntToStr(Minute);
 //SystemTime.Caption:=SHour+' .'+SMinute;
 //SystemTime.Repaint;
                                                    end;
                       end;
 { меняем прошедшее время во время хода компьютера }
 If Second<>OldSecond then begin
 { продолжительность }
 If Not TimeLimit and not MoveLimit  Then begin
 _ElaspedTimer.Tag:= _ElaspedTimer.Tag+1;
 If _ElaspedTimer.Tag=60 Then begin
     inc(StartMin);
     If (StartMin mod 60)=0 then begin
         inc(StartHour); StartMIn:=0;
                                 end;
     If StartHour<10 Then SHour:='0'+IntToStr(StartHour) Else SHour:=IntToStr(StartHour);
     If StartMin<10 Then SMinute:='0'+IntToStr(StartMin) Else SMinute:=IntToStr(StartMin);
      //ElaspedTime.Caption:=SHour+' .'+SMinute;
     _ElaspedTimer.Tag:=0; //ElaspedTime.Repaint;
                             end;
                        end
 { отсчет времени }
 Else
   If Not MoveLimit Then
      begin
   dec(StartSec);
   If StartMin<10 Then SMinute:='0'+IntToStr(StartMin) Else SMinute:=IntToStr(StartMin);
   If StartSec<10 Then SSec:='0'+IntToStr(StartSec) Else SSec:=IntToStr(StartSec);
   //ElaspedTime.Caption:=SMinute+' .'+SSec; ElaspedTime.Repaint;
   //If StartMin=0 Then ElaspedTime.Font.Color:=clRed;
   If StartSec=0 Then begin
    If (StartMin=0) Then begin
             _ElaspedTimer.Enabled:=False;
             FinishGame:=True; Exit;
                        end;
    StartSec:=60; dec(StartMin);
                      end;
      end;
  { отсчет времени хода}
  If MoveLimit and _MoveTimer.Enabled Then
      begin
   If StartSec>0 Then dec(StartSec);
   If StartMin<10 Then SMinute:='0'+IntToStr(StartMin) Else SMinute:=IntToStr(StartMin);
   If StartSec<10 Then SSec:='0'+IntToStr(StartSec) Else SSec:=IntToStr(StartSec);
   case _MoveTimer.Tag of
   1: begin
       {SystemTime.Caption:=SMinute+' .'+SSec;
       //SystemTime.Repaint;
       If (StartSec=20) and (StartMin=0) Then SystemTime.Font.Color:=clRed;}
      end;
   2: begin
       {ElaspedTime.Caption:=SMinute+' .'+SSec;
       ElaspedTime.Repaint;}
       //If (StartSec=20) and (StartMin=0) Then ElaspedTime.Font.Color:=clRed;
      end;
   3:;
   4:;
   end;
   If (StartSec=0) Then begin
        If StartMin=0 Then begin MovePass:=True; exit; end;
        StartSec:=60; If StartMin>0 Then dec(StartMin);
                        end;
      end;
                           end;
 OldHour:=Hour; OldMinute:=Minute; OldSecond:=Second;
end;

{---------------------------------------------------------------}
{ обнаружение нового слова } { TODO : LocateNewWord }
Function LocateNewWord(MasX,MasY, Direction:byte; var WBegin,WEnd:byte; var Flag_3,NoShapes:boolean; var SelNum:byte):ShortString;
var TempWord:ShortString; SelectionFlag:0..2; i,j,k:byte; TempX,TempY:byte; isShape:boolean;
    ShapeIndex:-1..1000; isHotSpots:boolean;
begin
  TempWord:=''; isHotSpots:=false;
  {If SelectField[MasX,MasY]=3 Then
  begin  SelectField[MasX,MasY]:=Direction; Flag_3:=true; end;
  SelectionFlag:=SelectField[MasX,MasY];}
  { проверка на одну букву }
  If noShapes Then
  If ((WorkField[MasX,MasY+1].HotSpot=' ') and (WorkField[MasX,MasY+1].main=' ') or (SelectField[MasX,MasY+1]<>0))
  and ((WorkField[MasX,MasY-1].HotSpot=' ') and (WorkField[MasX,MasY-1].main=' ') or (SelectField[MasX,MasY-1]<>0))
  and ((WorkField[MasX+1,MasY].HotSpot=' ') and (WorkField[MasX+1,MasY].main=' ') or (SelectField[MasX+1,MasY]<>0))
  and ((WorkField[MasX-1,MasY].HotSpot=' ') and (WorkField[MasX-1,MasY].main=' ')  or (SelectField[MasX-1,MasY]<>0))
  Then begin LocateNewWord:=WorkField[MasX,MasY].HotSpot;
             case Direction of
              Horiz: begin WBegin:=MasX; WEnd:=MasX; exit; end;
              Vertic:begin WBegin:=MasY; WEnd:=MasY; exit; end;
             end;
             end;

  //if (SelectionFlag<>0) and (SelectionFlag<>Direction) Then begin LocateNewWord:=''; exit; end; 
  If not NoShapes Then begin
    For I:=0 to length(SelectedWords)-1 Do
     If not SelectedWords[I].Passed
        and (SelectedWords[I].Direction=Direction) and (SelectedWords[I].Linked)
          Then begin LocateNewWord:=SelectedWords[I].Word;
                     WBegin:=SelectedWords[I].WBegin; WEnd:=SelectedWords[I].Wend;
                     SelNum:=I; inc(SelectedWords[I].Tested);
                     break;
                 end;
     If I=length(SelectedWords) Then LocateNewWord:='';
     exit;
                       end
                  ELSE
  { определение слова }
  case Direction of
    Horiz:begin
           //ShapeIndex:=-1;
           { определяем начало слова }
           repeat
                If MasX>0 Then dec(MasX); //If MasX<1 Then break;
                //If (WorkField[MasX,MasY].HotSpot<>' ') and (WorkField[MasX,MasY].main=' ') Then  isHotSpots:=true;
                { проверка на примыкающие выделения }
               { If AllowSelect and (length(SelectShapes)<>0) Then begin
                isShape:=false;
                for I:=0 To length(SelectShapes)-1 do begin
                  TempX:=(SelectShapes[I].BoundsRect.Left+19) div 28;
                  TempY:=(SelectShapes[I].BoundsRect.Top+19) div 28;
                  if (MasX+1=TempX) and (MasY=TempY) and (SelectShapes[I].Width>26)
                      and SelectShapes[I].Visible //and (SelectShapes[I].Hint<>'x')
                      Then begin isShape:=true; ShapeIndex:=I;
                                 If SelectShapes[I].Hint<>'x' Then break;
                             end;
                  TempX:=(SelectShapes[I].BoundsRect.right+19) div 28;
                  TempY:=(SelectShapes[I].BoundsRect.bottom+19) div 28;
                  if (MasX=TempX) and (MasY=TempY) and (SelectShapes[I].Width>26)
                      and SelectShapes[I].Visible and (SelectionFlag=0)
                      Then begin isShape:=true; If SelectShapes[I].Hint<>'x' Then  break; end;
                                                   end;
                if isShape Then break;
                                                                  end;}
           Until ((WorkField[MasX,MasY].HotSpot=' ') and (WorkField[MasX,MasY].main=' ')) or (SelectField[MasX,MasY]<>0) ;
           inc(MasX); WBegin:=MasX;
           { определяем конец слова }
           While ((WorkField[MasX,MasY].HotSpot<>' ') or (WorkField[MasX,MasY].main<>' ')) and (SelectField[MasX,MasY]=0)
            Do begin
                If WorkField[MasX,MasY].HotSpot<>' ' Then
                   TempWord:=TempWord+WorkField[MasX,MasY].HotSpot Else
                   TempWord:=TempWord+WorkField[MasX,MasY].main;

                If (WorkField[MasX,MasY].HotSpot<>' ') and (WorkField[MasX,MasY].main=' ') Then  isHotSpots:=true;
                inc(MasX);
                { проверка на примыкающие выделения }
               { If AllowSelect and (length(SelectShapes)<>0) Then begin
                isShape:=false;
                for I:=0 To length(SelectShapes)-1 do begin
                  If ShapeIndex>-1 Then begin
                    TempX:=(SelectShapes[ShapeIndex].BoundsRect.right) div 28;
                    TempY:=(SelectShapes[ShapeIndex].BoundsRect.bottom) div 28;
                    if (MasX-1=TempX) and (MasY=TempY) and SelectShapes[ShapeIndex].Visible
                     Then begin isShape:=true; SelectShapes[ShapeIndex].Hint:='x'; break; end;
                                        end;
                  TempX:=(SelectShapes[I].BoundsRect.left+19) div 28;
                  TempY:=(SelectShapes[I].BoundsRect.top+19) div 28;
                  if (MasX=TempX) and (MasY=TempY) and (SelectShapes[I].Width>26)
                     and SelectShapes[I].Visible
                     Then begin
                       If SelectionFlag=0 Then begin isShape:=true; break; end;
                       If (ShapeIndex>-1) and (SelectShapes[I].Hint<>'x') Then
                          begin WBegin:=MasX; SelectShapes[ShapeIndex].Hint:='';
                                Change_Shape:=true;
                                WorkField[MasX,MasY].available:=false;
                                ShapeIndex:=I; TempWord:=''; end;
                          end;
                                         end;
                if isShape Then break;
                                    end;  }
                //If MasX>15 Then break;
            end;
           dec(MasX); WEnd:=MasX;
           If Length(TempWord)<2 Then LocateNewWord:=''
                                 Else LocateNewWord:=TempWord;
           //If not isHotSpots Then LocateNewWord:='';
          end;
   Vertic:begin
           //ShapeIndex:=-1;
           { определяем начало слова }
           repeat
                //If (WorkField[MasX,MasY].HotSpot<>' ') and (WorkField[MasX,MasY].main=' ') Then  isHotSpots:=true;
                If MasY>0 Then dec(MasY); //If MasX<1 Then break;
                { проверка на примыкающие выделения }
               { If AllowSelect and (length(SelectShapes)<>0) Then begin
                isShape:=false;
                for I:=0 To length(SelectShapes)-1 do begin
                  TempX:=(SelectShapes[I].BoundsRect.Left+19) div 28;
                  TempY:=(SelectShapes[I].BoundsRect.Top+19) div 28;
                  if (MasX=TempX) and (MasY+1=TempY) and (SelectShapes[I].Height>26)
                      and SelectShapes[I].Visible //and (SelectShapes[I].Hint<>'x')
                      Then begin isShape:=true; ShapeIndex:=I;
                                 If SelectShapes[I].Hint<>'x' Then break;
                             end;
                  TempX:=(SelectShapes[I].BoundsRect.right+19) div 28;
                  TempY:=(SelectShapes[I].BoundsRect.bottom+19) div 28;
                  if (MasX=TempX) and (MasY=TempY) and (SelectShapes[I].Height>26)
                      and SelectShapes[I].Visible and (SelectionFlag=0)
                      Then begin isShape:=true; If SelectShapes[I].Hint<>'x' Then  break; end;
                                                   end;
                if isShape Then break;
                                    end;}
           Until ((WorkField[MasX,MasY].HotSpot=' ') and (WorkField[MasX,MasY].main=' ')) or (SelectField[MasX,MasY]<>0) ;
           inc(MasY); WBegin:=MasY;
           { определяем конец слова }
           While ((WorkField[MasX,MasY].HotSpot<>' ') or (WorkField[MasX,MasY].main<>' ')) and (SelectField[MasX,MasY]=0)
           do begin
                If WorkField[MasX,MasY].HotSpot<>' ' Then
                   TempWord:=TempWord+WorkField[MasX,MasY].HotSpot Else
                   TempWord:=TempWord+WorkField[MasX,MasY].main;
                //If (WorkField[MasX,MasY].HotSpot<>' ') and (WorkField[MasX,MasY].main=' ') Then  isHotSpots:=true;
                inc(MasY);
                { проверка на примыкающие выделения }
              {  If AllowSelect and (length(SelectShapes)<>0) Then begin
                isShape:=false;
                for I:=0 To length(SelectShapes)-1 do begin
                  If ShapeIndex>-1 Then begin
                    TempX:=(SelectShapes[ShapeIndex].BoundsRect.right) div 28;
                    TempY:=(SelectShapes[ShapeIndex].BoundsRect.bottom) div 28;
                    if (MasX=TempX) and (MasY-1=TempY) and SelectShapes[ShapeIndex].Visible
                     and (SelectShapes[I].Hint<>'x')
                     Then begin MasY:=TempY; isShape:=true; SelectShapes[ShapeIndex].Hint:='x'; break; end;
                                        end;

                  TempX:=(SelectShapes[I].BoundsRect.left+19) div 28;
                  TempY:=(SelectShapes[I].BoundsRect.top+19) div 28;
                  if (MasX=TempX) and (MasY=TempY) and (SelectShapes[I].Height>26)
                     and SelectShapes[I].Visible
                     Then begin
                       If SelectionFlag=0 Then begin isShape:=true; break; end;
                       If (ShapeIndex>-1) and (SelectShapes[I].Hint<>'x') Then
                          begin WBegin:=MasY; SelectShapes[ShapeIndex].Hint:='';
                                Change_Shape:=true;
                                WorkField[MasX,MasY].available:=false;
                                ShapeIndex:=I; TempWord:=''; end;
                          end;
                                         end;
                if isShape Then break;
                                    end;}
                //If MasX>15 Then break;
            end;
           dec(MasY); WEnd:=MasY;
           If Length(TempWord)<2 Then LocateNewWord:=''
                                 Else LocateNewWord:=TempWord;
          // If not isHotSpots Then LocateNewWord:='';
          end;
   end;
end;
{---------------------------------------------------------------}
{ проверка слов на пересечение }    {
TODO : Is CrossWord }
Function IsCrossWord(Coord,WBegin,WEnd:byte; FirstWord:boolean; Direction:byte):boolean;
var I:byte; isHotSpots:boolean;
begin
 IsCrossWord:=False;
 case Direction of
  Horiz:begin
        For I:=WBegin To WEnd Do begin
        If WorkField[I,Coord].color=Black Then IsCrossWord:=True;
        If (WorkField[I,Coord].main<>' ') or not (WorkField[I,Coord].checked) Then IsCrossWord:=True;
                          end;
         end;
 Vertic:begin
        For I:=WBegin To WEnd Do begin
        { Ґб«Ё б«®ў® ЇҐаў®Ґ, в® Їа®ўҐапҐвбп ­ е®¦¤Ґ­ЁҐ ­  зҐа­®© пзҐ©ЄҐ }
        If WorkField[Coord,I].color=Black Then IsCrossWord:=True;
        If (WorkField[Coord,I].main<>' ') or not (WorkField[Coord,I].checked) Then IsCrossWord:=True;
                          end;
        end;
  end; { case }
end;
{---------------------------------------------------------------}
{ регистрация нового выставленного слова }
Procedure RegisterWord(Player:byte; Word:ShortString; WBegin,WEnd,Coord,Direction:byte; Value:byte);
var I,II:byte; Im:TControl;
begin
 FirstWord:=false;
 For II:=1 To 200 Do If Words[II,Player].Word='' Then
      begin Words[II,Player].Word:=Word;
            Words[II,Player].WBegin:=WBegin; Words[II,Player].WEnd:=WEnd;
            Words[II,Player].Coord:=Coord; Words[II,Player].Direction:=Direction;
            Words[II,Player].Value:=Value;
            break;
      end;
 For I:=0 to PlayerForms[MoveIs-1].ControlCount-1 Do
   If PlayerForms[MoveIs-1].Controls[I].Name='Pl'+IntToStr(MoveIs)+'Im' Then Im:=PlayerForms[MoveIs-1].Controls[I] as TControl;
   If Length(Im.Hint)=0  Then Im.Hint:={GlobalTextStrings.Items.Values['InGameTagPlayerWordsList']+chr(13)+}'----------------------------------';
    Im.Hint:=Im.Hint+chr(13)+Words[II,Player].Word+'  (+'+IntToStr(Words[II,Player].Value)+')';
end;
{---------------------------------------------------------------}
{ копирование новых слов на главное игровое поле }
Procedure CopyToMainField(Coord,WBegin,WEnd,Direction:byte);
var I:byte; Im,Im1:TImage;
begin
  if AllowSelect and not GameLoading then begin
      setlength(SelectShapes, length(SelectShapes)+1);
      SelectShapes[length(SelectShapes)-1]:=TShape.Create(nil);
      Sh:=SelectShapes[length(SelectShapes)-1];
      sh.Name:='selectshape'+intToStr(length(SelectShapes));
      Sh.Shape:=stRoundRect; sh.Brush.Style:=bsClear; Sh.ParentShowHint:=false;
      sh.Pen.style:=psSolid; sh.Pen.Width:=3;
      case Direction of
      Horiz: begin sh.Pen.Color:=StrToInt(ifthen(CustomColors,Colors.Values['InGameHorizSelection'],IntToStr(clRed)));
                   Im:=Letters[WorkField[WBegin,Coord].Image]; Im1:=Letters[WorkField[WEnd,Coord].Image]; end;
      Vertic:  begin sh.Pen.Color:=StrToInt(ifthen(CustomColors,Colors.Values['InGameVertSelection'],IntToStr($000080FF)));
                     Im:=Letters[WorkField[Coord,WBegin].Image]; Im1:=Letters[WorkField[Coord,WEnd].Image]; end;
                   end;
      Sh.SetBounds(Im.Left-1,Im.Top-1,Im1.Left-Im.Left+26, Im1.Top-Im.Top+26);
      sh.Parent:=Application.MainForm; Sh.Hint:='x'; sh.enabled:=false;
      sh.show;
                      end;
  For I:=WBegin To WEnd Do
     case Direction of
     Horiz:begin
           Im:=Letters[WorkField[I,Coord].Image];
           Im.HelpKeyword:='new';
           Im.Tag:=-2;
           IF WorkField[I,Coord].Main=' ' Then begin
               WorkField[I,Coord].Main:=WorkField[I,Coord].HotSpot;
               WorkField[I,Coord].Available:=False;
           { вращиваем фишку в игровое поле на веки вечные }
                Im.Hint:=Im.Hint+IntToStr(MoveIs);
                Im.Enabled:=True;
                Im.HelpKeyword:='new';
                LastLetters.Add(Letters[WorkField[I,Coord].Image]);
                If Not ShowColorLetters Then
                  Im.Picture:=Images[2,GetLetterNum(WorkField[I,Coord].Main)+1]
                                        Else
                   case MoveIs mod 2 of
                   1: Im.Picture:=Images[2,GetLetterNum(WorkField[I,Coord].Main)+1];
                   0: Im.Picture:=Images[3,GetLetterNum(WorkField[I,Coord].Main)+1];
                   end;
                { рисуем значок звездочки для замены}
                if (Im.HelpContext=1) Then begin
                Im.Hint:=Im.Hint+chr(FirstAlphCode+AlphCount);
                If TakeStar Then
                with Im do
                  begin  Canvas.Font.Color := clWhite;
                         Canvas.Font.Style := [fsBold];
                         Canvas.Font.Size := 13;
                         Canvas.Brush.Color:=clBlack;
                         Canvas.Brush.Style:=bsClear;
                         Canvas.TextOut(14, 2, '*');
                    end;                                                               
                                           end;
                 { рисуем ободок пирзовой ячейки}
                If KeepBonuses Then
                 If WorkField[I,Coord].color>1 Then begin
                  Im.Canvas.Brush.Style:=bsSolid; Im.Canvas.Pen.Style:=psClear;
                  case WorkField[I,Coord].color of
                   2: Im.Canvas.Brush.Color:=$0200ffA8;
                   3: Im.Canvas.Brush.Color:=$02ffff00;
                   4: Im.Canvas.brush.Color:={ $0200ffE6;}clYellow;
                   5: Im.Canvas.brush.Color:=$020000FF;
                  end;
                  If WorkField[I,Coord].color<6 Then Im.Canvas.Polygon([point(1,1),Point(1,8), Point(8,1)]);
                                                     end;
                                                end;
           {запрещаем перекрестные ячейки, если надо}
           if Crossword_Mode Then begin
             If (WorkField[I-1,Coord-1].Main=' ')
             and (WorkField[I,Coord-1].Main=' ')
             and (WorkField[I+1,Coord-1].Main=' ') Then Else
                                   WorkField[I,Coord-1].Available:=False;
             If (WorkField[I-1,Coord+1].Main=' ')
             and (WorkField[I,Coord+1].Main=' ')
             and (WorkField[I+1,Coord+1].Main=' ') Then Else
                                   WorkField[I,Coord+1].Available:=False;
                                   end;
           end;
    Vertic:begin
           Im:=Letters[WorkField[Coord,I].Image];
           Im.HelpKeyword:='new';
           Im.Tag:=-2;
           IF WorkField[Coord,I].Main=' ' Then begin
                WorkField[Coord,I].Main:=WorkField[Coord,I].HotSpot;
                WorkField[Coord,I].Available:=False;
              { вращиваем фишку в игровое поле на веки вечные }
                Im.Hint:=Im.Hint+IntToStr(MoveIs);
                Im.Enabled:=True;
                Im.HelpKeyword:='new';
                LastLetters.Add(Letters[WorkField[Coord,I].Image]);
                If Not ShowColorLetters Then
                   Im.Picture:=Images[2,GetLetterNum(WorkField[Coord,I].Main)+1]
                                        Else
                case MoveIs mod 2 of
                1: Im.Picture:=Images[2,GetLetterNum(WorkField[Coord,I].Main)+1];
                0: Im.Picture:=Images[3,GetLetterNum(WorkField[Coord,I].Main)+1];
                end;
                if (Im.HelpContext=1) Then begin
                Im.Hint:=Im.Hint+chr(FirstAlphCode+AlphCount);
                If TakeStar Then
                with Im do
                  begin  Canvas.Font.Color := clWhite;
                         Canvas.Font.Style := [fsBold];
                         Canvas.Font.Size := 13;
                         Canvas.Brush.Color:=clBlack;
                         Canvas.Brush.Style:=bsClear;
                         Canvas.TextOut(14, 2, '*');
                end;
                                         end;
                 { рисуем ободок пирзовой ячейки}
                If KeepBonuses Then
                 If WorkField[Coord,I].color>1 Then begin
                  Im.Canvas.Brush.Style:=bsSolid;  Im.Canvas.Pen.Style:=psClear;
                  case WorkField[Coord,I].color of
                   2: Im.Canvas.Brush.Color:=$0200ffA8;
                   3: Im.Canvas.Brush.Color:=$02ffff00;
                   4: Im.Canvas.brush.Color:={ $0200ffE6;}clYellow;
                   5: Im.Canvas.brush.Color:=$020000FF;
                  end;
                  If WorkField[Coord,I].color<6 Then Im.Canvas.Polygon([point(1,2),Point(1,8), Point(8,1)]);
                                                     end;
                                               end;
           if Crossword_Mode Then begin
             If (WorkField[Coord-1,I-1].Main=' ')
             and (WorkField[Coord-1,I].Main=' ')
             and (WorkField[Coord-1,I+1].Main=' ') Then Else
                                   WorkField[Coord-1,I].Available:=False;
             If (WorkField[Coord+1,I-1].Main=' ')
             and (WorkField[Coord+1,I].Main=' ')
             and (WorkField[Coord+1,I+1].Main=' ') Then Else
                                   WorkField[Coord+1,I].Available:=False;
                                  end;
           end;
   end;
end;

{---------------------------------------------------------------}
{ проверка на повторяющееся слово } { TODO : RepeatedWord }
Function RepeatedWord(NewWord:ShortString;var WBegin,WEnd,Coord,Direction:byte):boolean;
var I,J:byte; isRepeat:boolean;
begin
 RepeatedWord:=False;
 IsRepeat:=false;
 For J:=1 To PlayersNumber Do begin
      For I:=1 to 200 Do begin
         If not AllowWordRepeat and (NewWord=Words[I,J].Word) Then begin IsRepeat:=true; break; end;
         If AllowWordRepeat and (NewWord=Words[I,J].Word) and (Wbegin=Words[I,J].WBegin)
            and (Coord=Words[I,J].Coord) and (Direction=Words[I,J].Direction) Then
             begin; IsRepeat:=true; break; end;
                         end;
         If IsRepeat Then break;
                              end;    
         If IsRepeat
            Then begin
                    RepeatedWord:=True;
                    WBegin:=Words[I,J].WBegin;
                    WEnd:=Words[I,J].WEnd;
                    Coord:=Words[I,J].Coord;
                    Direction:=Words[I,J].Direction;
                                         end;
end;
{---------------------------------------------------------------}
{ расстановка хот-спотов}
Procedure SetHotSpots;
var I,J:byte;
begin
If AllowSelect Then exit;
  For J:=1 To WorkFieldDimentionY Do
   For I:=1 To WorkFieldDimentionX Do
      If WorkField[I,J].HotSpot<>' ' Then begin
           If (WorkField[I,J+1].Available=False)
           and (WorkField[I,J-1].Available=False)
           and (WorkField[I+1,J].Available=False)
           and (WorkField[I-1,J].Available=False) Then
                                 WorkField[I,J].HotSpot:=' ';
                                           end;
end;
{---------------------------------------------------------------}
{ проверка органичений }
Procedure CheckLimits(var FinishGame:boolean);
var Border:word; I:byte;
begin
  Border:=StrToIntDef(Trim(copy(Limit,pos('-',Limit)+1,4)),0);
    If Copy(Limit,1,pos('-',Limit)-1)='Score' Then
    For I:=1 To PlayersNumber Do
       If Players[I].Points>=Border Then begin
             FinishGame:=True; Exit;
                                         end;
end;
{---------------------------------------------------------------}
{ мигание счета при достижении ограничения по счету  }
Procedure FlashLimitScore;
var I:byte;
begin
  If PlaySounds Then BASS_SamplePlay(ScoreLimitSound);

    ScoreLabel.Font.Color:=clYellow;
    For I:= 1 To 24 Do begin
      ScoreLabel.Visible:=not ScoreLabel.Visible;
      ScoreLabel.Update;
      TimeDelay(50);
                      end;
    ScoreLabel.Font.Color:=clWhite;
end;
{---------------------------------------------------------------}
{ увеличение счета игрока  }
Procedure IncScore(Pl:byte; Value:integer);
var I:word;
begin
     case Pl of
         1,3,5,7,9:begin inc(Players[Pl].Points,Value);
                      LoadSkinnedImage(ScoreDisplay.Picture,'ScrG2');
                      ScoreDisplay.Repaint;
                      If Value>0 Then ScoreLabel.Font.Color:=clWhite Else ScoreLabel.Font.Color:=clBlack;
                      If PlaySounds Then BASS_SamplePlay(Score2Sound);
                      For I:=Players[Pl].Points-Value To Players[Pl].Points Do begin
                          ScoreLabel.Caption:=IntToStr(I); ScoreLabel.Repaint;
                          If (copy(Limit,1,pos('-',Limit)-1)='Score')
                          and (IntToStr(I)=Trim(copy(Limit,pos('-',Limit)+1,4)))
                          Then FlashLimitScore;
                          TimeDelay(10);
                                                                  end;
                      ScoreLabel.Font.Color:=StrToInt(ifthen(CustomColors,Colors.Values['InGamePlayerColor1'],IntToStr(clLime)));
                      LoadSkinnedImage(ScoreDisplay.Picture,'ScrG1');
                      ScoreDisplay.Repaint;
                      TimeDelay(500);
                end;
         2,4,6,8:begin inc(Players[Pl].Points,Value);
                      LoadSkinnedImage(ScoreDisplay.Picture,'ScrM2');
                      ScoreDisplay.Refresh;
                      If Value>0 Then ScoreLabel.Font.Color:=clWhite Else ScoreLabel.Font.Color:=clBlack;
                      If PlaySounds Then BASS_SamplePlay(Score1Sound);
                      i:=Players[Pl].Points-Value;
                          repeat
                          i:=i+(Value div abs(Value));
                          ScoreLabel.Caption:=IntToStr(I); ScoreLabel.Repaint;
                          If (copy(Limit,1,pos('-',Limit)-1)='Score')
                          and (IntToStr(I)=Trim(copy(Limit,pos('-',Limit)+1,4)))
                          Then FlashLimitScore;
                          TimeDelay(10);
                          until I=Players[Pl].Points;
                      ScoreLabel.Font.Color:=StrToInt(ifthen(CustomColors,Colors.Values['InGamePlayerColor2'],InttoStr(clFuchsia)));
                      LoadSkinnedImage(ScoreDisplay.Picture,'ScrM1');
                      ScoreDisplay.Refresh;
                      TimeDelay(500);
                end;
        end;
end;
{---------------------------------------------------------------}
{ насчитывание очков за удачный ход }
Function CountPoints(Pl:byte; Coord,WBegin,WEnd:Word; Direction:byte):word;
var I:integer; J:integer; LetterPoints:byte; WordPoints:word;
    DoubleWord,TripleWord:boolean; Multy:byte; Temp:byte; Im:TImage;
    WordLength:byte;
begin
  WordPoints:=0; DoubleWord:=False; TripleWord:=False; Multy:=0;
  WordLength:=WEnd-WBegin+1;
  Case Direction of
  Horiz:begin
        For I:=WBegin To WEnd Do begin
              If WorkField[I,Coord].main=' ' Then
              LetterPoints:=LettersValue[GetLetterNum(WorkField[I,Coord].HotSpot)]
              Else
              LetterPoints:=LettersValue[GetLetterNum(WorkField[I,Coord].main)];
              { учет призовых клеток }
              case WorkField[I,Coord].Color of
               Green: begin inc(LetterPoints,LetterPoints);
                            If not KeepBonuses Then WorkField[I,Coord].Color:=White;
                            ShowMainMessage(Application.MainForm.Left+(I-1)*28+25, Application.MainForm.Top+Coord*28+25, '',clLime,'x2',clLime);
                        end;
               Blue:begin If not TripleWord Then DoubleWord:=True;
                          inc(Multy,2);
                          If not KeepBonuses Then WorkField[I,Coord].Color:=White;
                      end;
               Yellow:begin inc(LetterPoints,LetterPoints*2);
                            If not KeepBonuses Then WorkField[I,Coord].Color:=White;
                            ShowMainMessage(Application.MainForm.Left+(I-1)*28+25, Application.MainForm.Top+Coord*28+25, '',clYellow,'x3',clYellow);
                        end;
               Red:begin TripleWord:=True; inc(Multy,3);
                         DoubleWord:=false;
                         If not KeepBonuses Then WorkField[I,Coord].Color:=White; end;
               Black:begin WorkField[I,Coord].Color:=White; end;
              end;
           { увеличение ценности слова на ценность буквы }
           inc(WordPoints,LetterPoints);
                                 end;
        { сообщение об очках }
        If Not Preview and not GameLoading Then begin
        If not DoubleWord and not Tripleword then
          ShowMainMessage(Application.MainForm.Left+(WBegin-1)*28+25, Application.MainForm.Top+Coord*28+25, '+'+IntToStr(WordPoints),clWhite,'',clRed);
        If WordPoints<=10 Then begin
                      If PlaySounds Then BASS_SamplePlay(GoodScore1Sound);
                               end
        Else if WordPoints<=20 Then begin
                      If PlaySounds Then BASS_SamplePlay(GoodScore2Sound);
                               end
        Else if WordPoints<=40 Then begin
                      If PlaySounds Then BASS_SamplePlay(GoodScore3Sound);
                                    end
        Else if WordPoints>40 Then If PlaySounds Then BASS_SamplePlay(GoodScore3Sound);
                             end;
       { мигание правильного слова  }
       If Not Preview and not GameLoading Then
        For Temp:= 1 To 16 Do begin
          Application.ProcessMessages;
          For J:=WBegin To WEnd Do
           For I:=0 To (WorkFieldDimentionX*WorkFieldDimentionY)-1 Do Begin
           Im:=Letters[i]; If (Im.Left=28*(J-1)+19) and (Im.Top=28*(Coord-1)+19) and (Im.Tag<>-1)
                                    then  begin
                                      Im.Visible:=Not Im.Visible; Im.UpDate;
                                                       end;
                              end;
           TimeDelay(50);
                              end;
        end;
 Vertic:begin
        For I:=WBegin To WEnd Do begin
              If WorkField[Coord,I].main=' ' Then
              LetterPoints:=LettersValue[GetLetterNum(WorkField[Coord,I].HotSpot)]
              Else
              LetterPoints:=LettersValue[GetLetterNum(WorkField[Coord,I].main)];
              { учет призовых клеток }
              case WorkField[Coord,I].Color of
               Green: begin inc(LetterPoints,LetterPoints);
                      If not KeepBonuses Then WorkField[Coord,I].Color:=White;
                      ShowMainMessage(Application.MainForm.Left+(Coord-1)*28+25, Application.MainForm.Top+(I)*28+25, '',clLime,'x2',clLime);
                        end;
               Blue:begin If not TripleWord Then DoubleWord:=True;
                          inc(Multy,2);
                          If not KeepBonuses Then WorkField[Coord,I].Color:=White; end;
               Yellow:begin inc(LetterPoints,LetterPoints*2);
                       If not KeepBonuses Then WorkField[Coord,I].Color:=White;
                      ShowMainMessage(Application.MainForm.Left+(Coord-1)*28+25, Application.MainForm.Top+(I)*28+25, '',clYellow,'x3',clYellow);
                        end;
               Red:begin TripleWord:=True; inc(Multy,3);
                         DoubleWord:=false;
                         If not KeepBonuses Then WorkField[Coord,I].Color:=White; end;
               Black:begin WorkField[I,Coord].Color:=White; end;
              end;
           { увеличение ценности слова на ценность буквы }
           inc(WordPoints,LetterPoints);
                                 end;
        { сообщение об очках }
        If Not Preview and not GameLoading Then begin
        If not DoubleWord and not Tripleword then
           ShowMainMessage(Application.MainForm.Left+(Coord-1)*28+25, Application.MainForm.Top+(WBegin+1)*28+25, '+'+IntToStr(WordPoints),clWhite,'',0);
        If WordPoints<=10 Then begin
                      If PlaySounds Then BASS_SamplePlay(GoodScore1Sound);
                               end
        Else if WordPoints<=20 Then begin
                      If PlaySounds Then BASS_SamplePlay(GoodScore2Sound);
                               end
        Else if WordPoints<=40 Then begin
                      If PlaySounds Then BASS_SamplePlay(GoodScore3Sound);
                                    end
        Else if WordPoints>40 Then If PlaySounds Then BASS_SamplePlay(GoodScore3Sound);
                            end;
        { мигание правильного слова  }
        If Not Preview and not GameLoading Then
        For Temp:= 1 To 16 Do begin
          Application.ProcessMessages;
          For J:=WBegin To WEnd Do
           For I:=0 To (WorkFieldDimentionX*WorkFieldDimentionY)-1 Do Begin
           Im:=Letters[i]; If (Im.Left=28*(Coord-1)+19) and (Im.Top=28*(J-1)+19) and (Im.Tag<>-1)
                                    then  begin
                                      Im.Visible:=Not Im.Visible; Im.UpDate;
                                                       end;
                              end;
           TimeDelay(50);

        end;                   end;
  end; {case}
        { гзҐв Єа б­®© Ё бЁ­Ґ© пзҐҐЄ }
        If DoubleWord Then begin
                           //If Not Preview Then begin
                           If PlaySounds Then BASS_SamplePlay(bonus1Sound);
                           If Direction=Horiz Then ShowMainMessage(Application.MainForm.Left+(WBegin-1)*28+25, Application.MainForm.Top+Coord*28+25, '+'+IntToStr(WordPoints)+'x'+IntToStr(Multy),clAqua,'',clRed)
                                              Else ShowMainMessage(Application.MainForm.Left+(Coord-2)*28+25, Application.MainForm.Top+(Wbegin+2)*28+25, '+'+IntToStr(WordPoints)+'x'+IntToStr(Multy),clAqua,'',clRed);
                           TimeDelay(700); //end;
                           WordPoints:=WordPoints*Multy;
                           end;
        If TripleWord Then begin
                           //If Not Preview Then begin
                           If PlaySounds Then BASS_SamplePlay(bonus1Sound);
                           If Direction=Horiz Then ShowMainMessage(Application.MainForm.Left+(WBegin-1)*28+25, Application.MainForm.Top+Coord*28+25, '+'+IntToStr(WordPoints)+'x'+IntToStr(Multy),clRed,'',clRed)
                                              Else ShowMainMessage(Application.MainForm.Left+(Coord-2)*28+25, Application.MainForm.Top+(Wbegin+2)*28+25, '+'+IntToStr(WordPoints)+'x'+IntToStr(Multy),clRed,'',clRed);
                           TimeDelay(700); //end;
                           WordPoints:=WordPoints*Multy;
                           end;
        If WordLength>7 then begin
                           If Not Preview Then begin
                      If PlaySounds Then BASS_SamplePlay(bonus2Sound);
                           ShowMainMessage(0,0, GlobalTextStrings.Items.Values['InGameMessageLongWordBonus']+'   +'+IntToStr(WordLength),$004080FF,'',clRed);
                           TimeDelay(2000); end;
                           WordPoints:=WordPoints+WordLength;
                           //MovesLog.Strings[MovesLog.Count-1]:=MovesLog.Strings[MovesLog.Count-1]+'(LONGWORDBONUS)';
                             end;
       If Helped Then begin
                           case StoreHintLimit of
                           11:begin
                                  ShowMainMessage(0,0,'',0,GlobalTextStrings.Items.Values['InGameMessageScoreWithHintPenalty']+'  -'+IntToStr(WordPoints div 2),clRed);
                                  WordPoints:=WordPoints-(WordPoints div 2);
                              end;
                           8,9,10:begin
                                 ShowMainMessage(0,0,'',0,GlobalTextStrings.Items.Values['InGameMessageScoreWithHintPenalty']+' -'+IntToStr((WordPoints div 2)+1),clRed);
                                 WordPoints:=WordPoints-((WordPoints div 2)+1);
                              end;
                           6,7:begin
                                 ShowMainMessage(0,0,'',0,GlobalTextStrings.Items.Values['InGameMessageScoreWithHintPenalty']+' -'+IntToStr(abs((WordPoints div 3)+1)),clRed);
                                 WordPoints:=WordPoints-((WordPoints div 3)+1);
                              end;
                           4,5:begin
                                ShowMainMessage(0,0,'',0,GlobalTextStrings.Items.Values['InGameMessageScoreWithHintPenalty']+' -'+IntToStr(abs((WordPoints div 5)+1)),clRed);
                                WordPoints:=WordPoints-((WordPoints div 5)+1);
                             end;
                           1,2,3:begin
                                ShowMainMessage(0,0,'',0,GlobalTextStrings.Items.Values['InGameMessageScoreWithHintPenalty']+' -'+IntToStr(abs((WordPoints div 8)+1)),clRed);
                                WordPoints:=WordPoints-((WordPoints div 8)+1);
                             end;
                           end;
                           If Not Preview Then begin
                           If random(100)<33 Then
                          If PlaySounds Then BASS_SamplePlay(hint1Sound)
                                             Else Else
                           If random(100)<66 Then
                          If PlaySounds Then BASS_SamplePlay(hint2Sound)
                                             Else Else
                           If random(100)<99 Then
                           If PlaySounds Then BASS_SamplePlay(hint3Sound);
                           TimeDelay(1000);
                                                end;
                          end;
       CountPoints:=WordPoints;
       { если предвар. просмотр, то не увеличиваем счет }
       If Preview Then
         begin exit; end
                  Else
                     IncScore(MoveIs,WordPoints);
  { добавляем счет к списку слов игрока}
{  Case MoveIs of
    1: begin
          _Player1Image.Hint:=_Player1Image.Hint+'    (+'+IntToStr(WordPoints)+')';
       end;
    2: begin
          _Player2Image.Hint:=_Player2Image.Hint+'    (+'+IntToStr(WordPoints)+')';
         end;
    end;}

end;
{---------------------------------------------------------------}
{ поиск пустых ячеек при замене букв }
{  }
Procedure ChoiceEmptyXY(var x,y:byte);
var TempX,TempY:byte;
begin
   repeat
     TempX:=random(WorkFieldDimentionX)+1; TempY:=random(WorkFieldDimentionY)+1
   Until WorkField[TempX,TempY].ForChoice=' ';
   X:=TempX; Y:=TempY;
end;
{---------------------------------------------------------------}
{ восстановление звездочек при отмене хода }
Procedure RestoreStars;
var MASB:byte; MasX,MasY:byte; Im:TImage;
begin
 For MASB:=1 To 3 Do
   If Stars[MASB,1]<>0 Then begin
                        WorkField[Stars[MASB,1],Stars[MASB,2]].HotSpot:=chr(FirstAlphCode+AlphCount);
                        If WorkField[Stars[MASB,1],Stars[MASB,2]].Image>-1 Then
                        Im:=Letters[WorkField[Stars[MASB,1],Stars[MASB,2]].Image];
                        Im.Hint:=chr(FirstAlphCode+AlphCount);
                        Im.Picture:=Images[1,AlphCount+1];
                         end;
For MasX:=1 To WorkFieldDimentionX Do For MasY:=1 To WorkFieldDimentionY Do
    If (WorkField[MasX,MasY].HotSpot<>' ') and (WorkField[MasX,MasY].main=' ') Then begin
       WorkField[MasX,MasY].available:=True;
                                              end;
end;
{---------------------------------------------------------------}
{ вызов окна замены звездочки }
Function StarMatchWindow(WinX,WinY:word;FlashX,FlashY:byte):boolean;
var DefaultCoord:TPoint;
begin
 Screen.Cursor:=crDefault;
 { запоминаем изначальные координаты окна (по сути координаты главного окна)}
 //DefaultCoord.X:=StarWindow.Left; DefaultCoord.Y:=StarWindow.Top;
 { меняем координаты окна замены смещением от изначальных }
 StarWindow.Left:=WinX; StarWindow.Top:=WinY;
 Shadow_Form.Left:=StarWindow.Left+7; Shadow_Form.Top:=StarWindow.Top+7;
 Shadow_Form.Width:=StarWindow.Width; Shadow_Form.Height:=StarWindow.Height;
 { отображаем окно модальным}
 If MoveLimit Then _MoveTimer.Enabled:=False;
 Shadow_Form.Show;
 StarWindow.ShowModal;
 Shadow_Form.Hide;
 If MoveLimit Then _MoveTimer.Enabled:=True;
 { проверяем результат замены }
 If StarWindow.ModalResult=mrYes Then begin
                 WorkField[FlashX,FlashY].HotSpot:=chr(StarWindow.Tag);
                 StarMatchWindow:=True;
                                      end
                                 Else StarMatchWindow:=False;
{ восстанавливаем изначальные координаты окна}
StarWindow.Left:=DefaultCoord.X; StarWindow.Top:=DefaultCoord.Y;
end;

{---------------------------------------------------------------}
{ обнаружение звездочек на игровом поле }
Function CheckStarPresent(WBegin,WEnd,Coord,Dimention:byte;SelNum:byte;noShapes:boolean):boolean;
var I,j,k:byte; WinX,WinY:word; Im:TImage;
begin
   CheckStarPresent:=true; StarWindow.HelpKeyword:='';
   case Dimention of
    Horiz:begin
           For I:=WBegin To WEnd Do
            if WorkField[I,Coord].HotSpot='*' Then begin
                  { помещаем флаг мигания звездочки }
                  Im:=Letters[WorkField[I,Coord].Image];
                  Im.Tag:=666;
                 { вычисляем координаты окна замены звездочки}
                 If I>WorkFieldDimentionX div 2 Then WinX:=Application.MainForm.Left+(I+1)*28-213 Else WinX:=Application.MainForm.Left+I*28-7;
                 If Coord>WorkFieldDimentionY div 2 Then WinY:=Application.MainForm.Top+Coord*28-230+47 Else WinY:=Application.MainForm.Top+Coord*28+70;
                 If Not StarMatchWindow(WinX,WinY,I,Coord) Then begin
                    Im.Visible:=True; Im.Tag:=MoveIs;
                    CheckStarPresent:=False; PressGo:=False; exit;
                    end;
                 Im.Picture:=Images[1,GetLetterNum(WorkField[I,Coord].HotSpot)+1];
                 Im.Hint:=WorkField[I,Coord].HotSpot;
                 Im.Visible:=True; Im.Tag:=MoveIs;
                 NewWord[I-Wbegin+1]:=WorkField[I,Coord].HotSpot;
                 If not NoShapes Then begin
                    SelectedWords[SelNum].Word[I-Wbegin+1]:=WorkField[I,Coord].HotSpot;
                    If SelectField[I,Coord]=3 Then begin
                       For J:=0 to length(SelectedWords)-1 Do
                        If j<>Selnum Then For k:=1 to 7 Do
                                           If (SelectedWords[J].Stars[k].StX=I) and (SelectedWords[J].Stars[k].StY=Coord)
                                              Then SelectedWords[J].Word[Coord-SelectedWords[j].Wbegin+1]:=WorkField[I,Coord].HotSpot;
                                                   end;
                                      end;
                                                   end;
          end;
   Vertic:begin
           For I:=WBegin To WEnd Do
            if WorkField[Coord,I].HotSpot='*' Then begin
                  { помещаем флаг мигания звездочки }
                  Im:=Letters[WorkField[Coord,I].Image];
                  Im.Tag:=666;
                 { вычисляем координаты окна замены звездочки}
                 If Coord>WorkFieldDimentionX div 2 Then WinX:=Application.MainForm.Left+Coord*28-220 Else WinX:=Application.MainForm.Left+(Coord+1)*28;
                 If I>WorkFieldDimentionY div 2 Then WinY:=Application.MainForm.Top+I*28-153 Else WinY:=Application.MainForm.Top+(I+1)*28+10;
                 If Not StarMatchWindow(WinX,WinY,Coord,I) Then begin
                    Im.Visible:=True; Im.Tag:=MoveIs;
                    CheckStarPresent:=False; PressGo:=False; exit;
                    end;
                 Im.Picture:=Images[1,GetLetterNum(WorkField[Coord,I].HotSpot)+1];
                 Im.Hint:=WorkField[Coord,I].HotSpot;
                 Im.Visible:=True; Im.Tag:=MoveIs;
                 NewWord[I-Wbegin+1]:=WorkField[Coord,I].HotSpot;
                 If not NoShapes Then begin
                 SelectedWords[SelNum].Word[I-Wbegin+1]:=WorkField[Coord,I].HotSpot;
                 If SelectField[Coord,I]=3 Then begin
                    For J:=0 to length(SelectedWords)-1 Do
                     If j<>Selnum Then For k:=1 to 7 Do
                                        If (SelectedWords[J].Stars[k].StX=Coord) and (SelectedWords[J].Stars[k].StY=I)
                                           Then SelectedWords[J].Word[I-SelectedWords[j].Wbegin+1]:=WorkField[Coord,I].HotSpot;
                                                end;
                                      end;          
                                                   end;
          end;
   end {case};
end;

{---------------------------------------------------------------}
{ проверка возможности поставить слово в соответствии с имеющимися буквами }
Function CheckMatching(WBegin,WEnd,Coord,Direction:byte):boolean;
var I,J:byte; isChecked:boolean;
begin
  CheckMatching:=True; LettersAvl:=''; isChecked:=false;
  For I:=1 To 7 Do If Slot7Buffer[I].Image<>-1 Then LettersAvl:=LettersAvl+Slot7Buffer[I].Letter;
  For I:=WBegin To WEnd Do begin
   case Direction of
   Horiz: If WorkField[I,Coord].Main=' ' Then begin
              isChecked:=true;
              If WorkField[I,Coord].Available=False Then begin CheckMatching:=False; Exit; end;
              If pos(WorkField[I,Coord].HotSpot,LettersAvl)<>0 Then begin
                     Delete(LettersAvl,pos(WorkField[I,Coord].HotSpot,LettersAvl),1);
                     For J:=1 to 7 do
                       if (Slot7Buffer[J].Letter=WorkField[I,Coord].HotSpot)
                         Then begin Slot7Buffer[J].Letter:=' '; break; end;
                                                                    end
                                          Else
              If pos(chr(FirstAlphCode+AlphCount),LettersAvl)<>0 Then begin
                     Delete(LettersAvl,pos(chr(FirstAlphCode+AlphCount),LettersAvl),1);
                     For J:=1 to 7 do
                       if (Slot7Buffer[J].Letter=chr(FirstAlphCode+AlphCount))
                         Then begin Slot7Buffer[J].Letter:=' '; break; end;
                                             end
                                        Else begin
                                             CheckMatching:=False; Exit;
                                             end;

          end;
  Vertic: If WorkField[Coord,I].Main=' ' Then begin
             isChecked:=true;
             If WorkField[Coord,I].Available=False Then begin CheckMatching:=False; Exit; end;
             If pos(WorkField[Coord,I].HotSpot,LettersAvl)<>0 Then begin
                     Delete(LettersAvl,pos(WorkField[Coord,I].HotSpot,LettersAvl),1);
                     For J:=1 to 7 do
                       if (Slot7Buffer[J].Letter=WorkField[Coord,I].HotSpot)
                         Then begin Slot7Buffer[J].Letter:=' '; break; end;
                                                                   end
                                          Else
              If pos(chr(FirstAlphCode+AlphCount),LettersAvl)<>0 Then begin
                     Delete(LettersAvl,pos(chr(FirstAlphCode+AlphCount),LettersAvl),1);
                     For J:=1 to 7 do
                       if (Slot7Buffer[J].Letter=chr(FirstAlphCode+AlphCount)) then
                         begin Slot7Buffer[J].Letter:=' '; break; end;
                                             end
                                          Else  begin
                                                CheckMatching:=False; Exit;
                                                end;
          end;
   end;
                            end;
   If not isChecked Then CheckMatching:=false;
end;
{---------------------------------------------------------------}
{ конвертация строки из формата ASCII в ANSI }
Function ConvString(Str:string; Mode:byte):string;
var masb:byte; Temp:string;
 begin
  Temp:='';
  For masb:=1 To Length(Str) Do begin
    If Str[masb]<>'*' Then begin
                     case mode of
                     0: Temp:=Temp+chr(ord(Str[masb])-64);
                     1: Temp:=Temp+chr(ord(Str[masb])+64);
                     end;
                        end
                    Else Temp:=Temp+'*';

                             end;
  ConvString:=Temp;
 end;
{---------------------------------------------------------------}
{ эффект мигания слов при неправильном ходе }
Procedure FlashWord(Mode:byte;WBegin,WEnd,Coord,Dimention:byte);
var Im:TImage; I:byte;
begin
case Mode of
  On_m: case Dimention of
         Horiz: For I:=WBegin to WEnd Do begin
                   Im:=Letters[WorkField[I,Coord].Image]; Im.Tag:=Im.Tag+666;
                                         end;
         Vertic: For I:=WBegin to WEnd Do begin
                   Im:=Letters[WorkField[Coord,I].Image]; Im.Tag:=Im.Tag+666;
                                         end;
        end;
 Off_m: case Dimention of
         Horiz: For I:=WBegin to WEnd Do begin
                   If WorkField[I,Coord].Image>-1 Then begin
                   Im:=Letters[WorkField[I,Coord].Image]; Im.Tag:=Im.Tag-666;
                   Im.Visible:=True;
                                                       end;

                                         end;
         Vertic: For I:=WBegin to WEnd Do begin
                   If WorkField[Coord,I].Image>-1 Then begin
                   Im:=Letters[WorkField[Coord,I].Image]; Im.Tag:=Im.Tag-666;
                   Im.Visible:=True;
                                                       end;
                                         end;
        end;
end;

end;
{-------------------------------------------------}
{ скрыть буквы на игровом поле }
Procedure HideLetters;
var TempX,TempY:byte; Im:TImage;
begin
  For TempY:=1 to WorkFieldDimentionY Do For TempX:=1 to WorkFieldDimentionX Do
    If (WorkField[TempX,TempY].Image>-1)and (WhatIDoNow<>Take) Then
       begin
       Im:=Letters[WorkField[TempX,TempY].Image];
       Im.Hide;
       end;
end;
{-------------------------------------------------}
{ показать буквы на игровом поле }
Procedure ShowLetters;
var TempX,TempY:byte; Im:TImage;
begin
  For TempY:=1 to WorkFieldDimentionY Do For TempX:=1 to WorkFieldDimentionX Do
    If (WorkField[TempX,TempY].Image>-1) and (WhatIDoNow<>Take) Then
       begin
       Im:=Letters[WorkField[TempX,TempY].Image];
       Im.Show;
       end;
end;
{-------------------------------------------------}
{ считывание текущей midi-громкости }
function GetMidiVolume: DWord;
var Woc : TMidiOutCaps;    Volume : DWord;
begin
  result:=0;  if MidiOutGetDevCaps(MIDI_MAPPER, @Woc, sizeof(Woc)) =
       MMSYSERR_NOERROR then begin
    if Woc.dwSupport and MIDICAPS_VOLUME = MIDICAPS_VOLUME then begin
      MidiOutGetVolume(MIDI_MAPPER, @Volume);
      Result := Volume;
                                                                end;
                             end;
end;
{-------------------------------------------------}
{ установка midi-громкости }
procedure SetMIDIVolume(const AVolume: DWord);
var Woc : TMidiOutCaps;
begin
  if MidiOutGetDevCaps(MIDI_MAPPER, @Woc, sizeof(Woc)) =
       MMSYSERR_NOERROR then begin
    if Woc.dwSupport and MIDICAPS_VOLUME = MIDICAPS_VOLUME then
      MidiOutSetVolume(MIDI_MAPPER, AVolume);
                             end;
end;                                                        
{-------------------------------------------------}
{ создание региона из битмапа }
function BitmapToRegion(Bitmap: TBitmap; TransColor: TColor): HRGN;
var
X, Y: Integer;
XStart: Integer;
begin
Result := 0;
with Bitmap do
for Y := 0 to Height - 1 do
begin
X := 0;
while X < Width do
begin
// Пропускаем прозрачные точки
while (X < Width) and (Canvas.Pixels[X, Y] = TransColor) do
Inc(X);
if X >= Width then
Break;
XStart := X;
// Пропускаем непрозрачные точки
while (X < Width) and (Canvas.Pixels[X, Y]<>TransColor) do
Inc(X);
// Создаём новый прямоугольный регион и добавляем его к
// региону всей картинки
if Result = 0 then
Result := CreateRectRgn(XStart, Y, X, Y + 1)
else
CombineRgn(Result, Result,
CreateRectRgn(XStart, Y, X, Y + 1), RGN_OR);
end;
end;
end;

END.
