{v 1.6.x}
unit newgame;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Errormes, Menus, Optns, Animate, GIFCtrl, bass, procs,
  RXCtrls, ComCtrls, RXSpin, StrUtils, TntStdCtrls, TntComCtrls;

type
  TNewGameWindow = class(TForm)
    ButtonSelectDifficulty: TImage;
    ButtonSelectDictionary: TImage;
    ButtonSelectLimits: TImage;
    LabelDifficulty: TTntLabel;
    LabelDictionary: TTntLabel;
    LabelLimits: TTntLabel;
    Shape9: TShape;
    LabelLayout: TTntLabel;
    Shape6: TShape;
    ButtonOK: TRxGIFAnimator;
    ButtonClose: TRxGIFAnimator;
    RxLabel1: TTntLabel;
    ButtonSelectLayout: TImage;
    RxLabel4: TTntLabel;
    RxLabel3: TTntLabel;
    RxLabel2: TTntLabel;
    LabelPlayersQty: TTntLabel;
    RxLabel5: TTntLabel;
    UpDown1: TUpDown;
    TabControl1: TTntTabControl;
    TagPlayerImage: TImage;
    LabelPlayerList: TTntComboBox;
    LabelPagePlayer: TTntRadioButton;
    LabelPagePC: TTntRadioButton;
    LabelPageNetwork: TTntRadioButton;
    RxLabel6: TTntLabel;
    LabelLanguage: TTntLabel;
    RxLabel7: TTntLabel;
    Shape7: TShape;
    Shape5: TShape;
    Shape1: TShape;
    Shape2: TShape;
    ButtonSelectLanguage: TImage;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonSelectDifficultyClick(Sender: TObject);
    procedure ButtonSelectDictionaryClick(Sender: TObject);
    procedure ButtonSelectLimitsClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure TagPlayerImageClick(Sender: TObject);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LabelPlayerListChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonSelectLayoutClick(Sender: TObject);
    procedure UpDown1ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure TabControl1DrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure TabControl1Change(Sender: TObject);
    procedure LabelPagePCClick(Sender: TObject);
    procedure LabelPagePlayerMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LabelPlayerListCloseUp(Sender: TObject);
    procedure TabControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure LabelPlayerListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure ButtonSelectLanguageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  { обработка имен игроков }
  Procedure AddPlayersNames;

var
  NewGameWindow: TNewGameWindow;
  Frame1,Frame2,Frame3,Frame4:byte;
  MainMenuUpdate:TMenu;
  LoadItemUpdate:TMenuItem;
  Dropped:boolean;


implementation

uses PlImages, Main;

var
  background:TPicture; TabColor,TabColorSel:TColor;

{$R *.DFM}
{---------------------------------------------------------------}
{ открытие окна "НОВАЯ ПАРТИЯ" }
procedure TNewGameWindow.FormActivate(Sender: TObject);
var I,k:byte; p:HSAMPLE; TempFile:textfile; TempStrX,TempStrY:String; HFont,Res:integer;
    {TempSave:SaveFileType;} TempS:pwidechar;
begin
Dropped:=true;
{ заполняем список игроков }
If LabelPlayerList.Items[0]='' Then
For I:=0 To 19 Do
 If Members[i].Name<>'' Then
    LabelPlayerList.Items.Add(Members[i].Name)
                           Else break;
LabelPlayerList.Text:=Players[1].Name;

TabControl1.Tabs.Clear;
For I:=1 to PlayersNumber Do begin
  TabControl1.Tabs.Add(ANSILowerCase(Players[I].Name));
                             end;
  LabelPagePC.Visible:=false;
  LabelPagePlayer.Checked:=true; LabelPlayerList.Enabled:=true;
  RxLabel6.Caption:=InttoStr(TabControl1.TabIndex+1);
  RXLabel5.Caption:=IntToStr(PlayersNumber);
  UpDown1.OnChangingEx:=nil;
  UpDown1.Position:=PlayersNumber;
  UpDown1.OnChangingEx:=UpDown1ChangingEx;
  try
  If RightStr(Players[1].Image,1)<>'A' Then TagPlayerImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent(Players[1].Image) as TImage).Picture)
                                       Else TagPlayerImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent(Players[1].Image) as TRXGIFAnimator).Image);
  except  TagPlayerImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent('Im0') as TImage).Picture);
          Players[1].Image:='Im0';
  end;
  LabelPlayerList.ItemIndex:=LabelPlayerList.Items.IndexOf(Players[1].Name);


  { заполняем информационные строки }
If Template<>'' Then begin AssignFile(TempFile,'MAPS\'+Template);
                           try
                           Reset(TempFile); readln(TempFile,TempStrX); RXLabel1.Caption:=TempStrX;
                           readln(TempFile,TempStrX);
                           TempStrY:='x'; while not EOF(TempFile) do begin readln(TempFile); TempStrY:=TempStrY+'x'; end;
                           RXLabel1.Caption:=WIDEUPPERCASE(RXLabel1.Caption+' ('+IntToStr(length(TempStrX))+'x'+IntToStr(length(TempStrY))+')');
                           WorkFieldDimentionX:=length(TempStrX); WorkFieldDimentionY:=length(TempStrY);
                           except
                           RXLabel1.Caption:=GlobalTExtStrings.Items.Values['NewGameLayoutRandom']+'. '+IntToStr(WorkFieldDimentionX)+'x'+IntToStr(WorkFieldDimentionY);
                           Template:='';
                           end;
                       end
                Else RXLabel1.Caption:=GlobalTextStrings.Items.Values['NewGameLayoutRandom']+'. '+IntToStr(WorkFieldDimentionX)+'x'+IntToStr(WorkFieldDimentionY);


                        case PCIntellect of
                         Low:RXLabel2.Caption:=GlobalTextStrings.Items.Values['NewGameIntellectLow'];
                         Middle:RXLabel2.Caption:=GlobalTextStrings.Items.Values['NewGameIntellectNormal'];
                         High://begin TempS:=pwidechar(GlobalTextStrings.Items.strings[2]);
                              //      For k:=0 to length(TempS) do (RXLabel2 as TTNTLabel).Caption:=RXLabel2.Caption+Temps[k];
                              RXLabel2.Caption:=GlobalTextStrings.Items.Values['NewGameIntellectHigh'];
                               // end;
                        end;
                        ButtonSelectDifficulty.Show;

If Theme='' Then RxLabel3.Caption:=GlobalTextStrings.Items.Values['NewGameDicttionaryMax']
             Else
If Theme=DictSpec[0] Then RxLabel3.Caption:=GlobalTextStrings.Items.Values['NewGameDicttionaryNormal']
                     Else
If Theme=DictSpec[6] Then RxLabel3.Caption:=GlobalTextStrings.Items.Values['NewGameDicttionaryChildren']
                     Else RxLabel3.Caption:=GlobalTextStrings.Items.Values['NewGameDicttionaryExtended'];

RXLabel4.Caption:='';
If Limit='' Then RXLabel4.Caption:=GlobalTextStrings.Items.Values['NewGameLimitsNo'];
If pos('Score-',Limit)<>0 Then RXLabel4.Caption:=AnsiReplaceStr(GlobalTextStrings.Items.Values['NewGameLimitsScore'],'%s',trim(copy(Limit,7,4)))+chr(13);
If pos('Time-',Limit)<>0 Then RXLabel4.Caption:=AnsiReplaceStr(GlobalTextStrings.Items.Values['NewGameLimitsGameTime'],'%s',trim(copy(Limit,6,2)))+chr(13);
If pos(' Move-',Limit)<>0 Then begin
   RXLabel4.Caption:=RXLabel4.Caption+ANSIUPPERCASE(Options.LimitsComboboxListMoveTime.Items[StrToInt(Trim(RightStr(Limit,2)))-1])+' '+GlobalTextStrings.Items.Values['NewGameLimitsSuffixMoveTime'];
                               end;
RXLabel7.Caption:=ANSIUpperCase(GetLanguageName(LanguageDict));
If FileExists('MEDIA\NewGame.mp3') and PlaySounds Then
BASS_SamplePlay(NewGameSound);
If not Shadow_Form.Visible then begin
   Shadow_Form.Left:=NewGameWindow.Left+7; Shadow_Form.Top:=NewGameWindow.Top+7;
   Shadow_Form.Width:=NewGameWindow.Width; Shadow_Form.Height:=NewGameWindow.Height;
   Shadow_form.Show; NewGameWindow.BringToFront;
                             end;
ShowTitleMenu;
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
                         end;
end;
{---------------------------------------------------------------}
{ жмуем кнопочку V }
procedure TNewGameWindow.ButtonOKClick(Sender: TObject);
var I:byte;
begin
If Trim(LabelPlayerList.text)='' Then begin exit; end;
AddPlayersNames;
ModalResult:=mrYes;
end;
{---------------------------------------------------------------}
{ жмуем кнопочку X }
procedure TNewGameWindow.ButtonCloseClick(Sender: TObject);
begin
ModalResult:=mrNo;
end;
{---------------------------------------------------------------}
{ закрытие окна "НОВАЯ ПАРТИЯ" }
procedure TNewGameWindow.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Background.Free;
//Confetti.Free;
end;
{---------------------------------------------------------------}
{ жмуем клавишу ESC }
procedure TNewGameWindow.FormKeyPress(Sender: TObject; var Key: Char);
begin
If key=#27 Then ButtonCloseClick(Sender);
If key=#13 Then ButtonOKClick(Sender);
end;
{---------------------------------------------------------------}
{ изменяем содержимое информац. строк }
Procedure ChangeStrings;
begin
If Template<>'' Then begin NewGameWindow.RXLabel1.Caption:=ANSIUPPERCASE(Options.Combobox2.Text);
                       end
                Else NewGameWindow.RXLabel1.Caption:=GlobalTextStrings.Items.Values['NewGameLayoutRandom']+'. '+IntToStr(WorkFieldDimentionX)+'x'+IntToStr(WorkFieldDimentionY);
With NewGameWindow do begin
If Theme='' Then RxLabel3.Caption:=GlobalTextStrings.Items.Values['NewGameDicttionaryMax']
             Else
If Theme=DictSpec[0] Then RxLabel3.Caption:=GlobalTextStrings.Items.Values['NewGameDicttionaryNormal']
                     Else
If Theme=DictSpec[6] Then RxLabel3.Caption:=GlobalTextStrings.Items.Values['NewGameDicttionaryChildren']
             Else RxLabel3.Caption:=GlobalTextStrings.Items.Values['NewGameDicttionaryExtended'];

RXLabel4.Caption:='';
If Limit='' Then RXLabel4.Caption:=GlobalTextStrings.Items.Values['NewGameLimitsNo'];
If pos('Score-',Limit)<>0 Then RXLabel4.Caption:=AnsiReplaceStr(GlobalTextStrings.Items.Values['NewGameLimitsScore'],'%s',trim(copy(Limit,7,4)))+chr(13);
If pos('Time-',Limit)<>0 Then RXLabel4.Caption:=AnsiReplaceStr(GlobalTextStrings.Items.Values['NewGameLimitsGameTime'],'%s',trim(copy(Limit,6,2)))+chr(13);
If (pos(' Move-',Limit)<>0) Then begin
   RXLabel4.Caption:=RXLabel4.Caption+ANSIUPPERCASE(Options.LimitsComboboxListMoveTime.Items[StrToInt(Trim(RightStr(Limit,2)))-1])+' '+GlobalTextStrings.Items.Values['NewGameLimitsSuffixMoveTime'];
                               end;
RXLabel7.Caption:=ANSIUpperCase(GetLanguageName(LanguageDict));                               
                       end;
end;
{---------------------------------------------------------------}
{ Жмуем кнопку "ИЗМЕНИТЬ ИНТЕЛЛЕКТ ПАРТИИ" }
procedure TNewGameWindow.ButtonSelectDifficultyClick(Sender: TObject);
begin
LoadSkinnedImage(ButtonSelectDifficulty.Picture,'edit_op2'); ButtonSelectDifficulty.Refresh;
TimeDelay(300);
LoadSkinnedImage(ButtonSelectDifficulty.Picture,'edit_opt'); ButtonSelectDifficulty.Refresh;
if PCIntellect<3 Then inc(PCIntellect) Else PCIntellect:=1;
case PCIntellect of
 Low:RXLabel2.Caption:=GlobalTextStrings.Items.Values['NewGameIntellectLow'];
 Middle:RXLabel2.Caption:=GlobalTextStrings.Items.Values['NewGameIntellectNormal'];
 High:RXLabel2.Caption:=GlobalTextStrings.Items.Values['NewGameIntellectHigh'];
end;
end;
{---------------------------------------------------------------}
{ Жмуем кнопочку "ИЗМЕНИТЬ ТЕМАТИКУ ПАРТИИ" }
procedure TNewGameWindow.ButtonSelectDictionaryClick(Sender: TObject);
begin
LoadSkinnedImage(ButtonSelectDictionary.Picture,'edit_op2'); ButtonSelectDictionary.Refresh;
TimeDelay(300);
LoadSkinnedImage(ButtonSelectDictionary.Picture,'edit_opt'); ButtonSelectDictionary.Refresh;
Options.Hint:='FinishGame'; Options.Tag:=1;
Options.ShowModal;
ChangeStrings;
end;
{---------------------------------------------------------------}
{ Жмуем кнопочку "ИЗМЕНИТЬ ОГРАНИЧЕНИЯ НА ПАРТИЮ" }
procedure TNewGameWindow.ButtonSelectLimitsClick(Sender: TObject);
begin
LoadSkinnedImage(ButtonSelectLimits.Picture,'edit_op2');ButtonSelectLimits.Refresh;
TimeDelay(300);
LoadSkinnedImage(ButtonSelectLimits.Picture,'edit_opt'); ButtonSelectLimits.Refresh;
Options.Hint:='FinishGame'; Options.Tag:=3;
Options.ShowModal;
ChangeStrings;
end;

{---------------------------------------------------------------}
{ Жмуем кнопочку "ИЗМЕНИТЬ ЯЗЫК ПАРТИИ" }
procedure TNewGameWindow.ButtonSelectLanguageClick(Sender: TObject);
begin
LoadSkinnedImage(ButtonSelectLanguage.Picture,'edit_op2');ButtonSelectLanguage.Refresh;
TimeDelay(300);
LoadSkinnedImage(ButtonSelectLanguage.Picture,'edit_opt'); ButtonSelectLanguage.Refresh;
Options.Hint:='FinishGame'; Options.Tag:=8;
Options.ShowModal;
ChangeStrings;
end;

{---------------------------------------------------------------}
{ обработка имен игроков }
Procedure AddPlayersNames;
var I:byte; Flag:boolean;
begin
 With NewGameWindow do begin
 LabelPlayerList.Text:=ANSIUpperCase(LabelPlayerList.Text);
// PlayerList2.Text:=ANSIUpperCase(PlayerList2.Text);
 { добавление имени игрока в список игроков }
 Flag:=False;
 If (LabelPlayerList.Text='КОМПЬЮТЕР') Then Flag:=true
  Else
 For I:=0 To 19 Do begin
   If LabelPlayerList.Text=LabelPlayerList.Items[I] Then Flag:=True;
                   end;
 If not Flag
   Then
          For I:=0 To 19 Do If Members[I].Name='' Then begin
                                                       Members[I].Name:=LabelPlayerList.Text;
                                                       If Members[I].Name='ИГРОК' Then Members[I].Code:=0
                                                                                  Else Members[I].Code:=100+I;
                                                       Members[I].Image:=TagPlayerImage.HelpKeyword;
                                                       Players[TabControl1.TabIndex+1]:=Members[I];
                                                       LabelPlayerList.Items.Add(LabelPlayerList.Text);
                                                       LoadItemUpdate:=TMenuItem.Create(MainMenuUpdate);
                                                       LoadItemUpdate.Caption:=Members[I].Name[1]+ANSILowerCase(copy(Members[I].Name,2,10))+'...';
                                                       LoadItemUpdate.Name:='Load'+IntToStr(I);
                                                       MainMenuUpdate.Items[0].Items[3].Add(LoadItemUpdate);
                                                       MainMenuUpdate.Items[0].Items[3].Enabled:=True;
                                                       Dropped:=true;
                                                       break;
                                                       end;

                       end;
end;


procedure TNewGameWindow.FormPaint(Sender: TObject);
begin
NewGameWindow.Canvas.Draw(0,0,Background.Graphic);
end;
{---------------------------------------------------------------}
{ щелчок на левом имидже}
procedure TNewGameWindow.TagPlayerImageClick(Sender: TObject);
begin
{Shadow1.Hide; Shadow1.Update;
TimeDelay(200);
Shadow1.Show; Shadow1.Update;}
{  подготавливаем координаты окна выбора имиджей }
ImageScreen.Left:=NewGameWindow.Left-220; ImageScreen.Top:=NewGameWindow.Top+180;
ImageScreen.ShowModal;
If ImageScreen.ModalResult=mrOk Then begin
                 TagPlayerImage.HelpKeyword:=ImageScreen.Hint;
                 If LabelPlayerList.ItemIndex>-1 Then
                 Members[LabelPlayerList.ItemIndex].Image:=TagPlayerImage.HelpKeyword;
                 If RightStr(TagPlayerImage.HelpKeyword,1)<>'A' Then
                    TagPlayerImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent(TagPlayerImage.HelpKeyword) as TImage).Picture)
                                                           Else
                    TagPlayerImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent(TagPlayerImage.HelpKeyword) as TRXGIFAnimator).Image);
                 Players[TabControl1.TabIndex+1].Image:=TagPlayerImage.HelpKeyword;
                                     end;
end;

{---------------------------------------------------------------}
{ проведение мышкой над правым имиджем}
procedure TNewGameWindow.Image2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
If Opponent=PC Then TagPlayerImage.ShowHint:=False
               Else TagPlayerImage.ShowHint:=True;
end;
{---------------------------------------------------------------}
{ щелчок на ПОДменю "ВОССТАНОВИТЬ ПАРТИЮ"}
procedure LoadItemClick(Sender: TObject);
begin
end;

procedure TNewGameWindow.LabelPlayerListChange(Sender: TObject);
var I:byte; Flag:boolean;
begin
Flag:=False;
If Dropped Then begin
If TabControl1.TabIndex=0 Then saveini(Players[1].Name);
For I:=0 To LabelPlayerList.Items.Count-1 Do
   If (LabelPlayerList.Items[I]=LabelPlayerList.Text) and (LabelPlayerList.Text<>'') Then begin
      TagPlayerImage.HelpKeyword:=Members[I].Image;
      Player1Bitmap:=TagPlayerImage.Picture;
      TagPlayerImage.Update; Flag:=True;
      LabelPlayerList.ItemIndex:=LabelPlayerList.Items.IndexOf(LabelPlayerList.text);
      Players[TabControl1.TabIndex+1]:=Members[I];
      try
      If RightStr(TagPlayerImage.HelpKeyword,1)<>'A' Then TagPlayerImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent(TagPlayerImage.HelpKeyword) as TImage).Picture)
                                             Else TagPlayerImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent(TagPlayerImage.HelpKeyword) as TRXGIFAnimator).Image);
      except  TagPlayerImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent('Im0') as TImage).Picture);
              Players[1].Image:='Im0';
      end;
       TabControl1.Tabs[TabControl1.TabIndex]:=ANSILowerCase(Players[TabControl1.TabIndex+1].Name);
      If TabControl1.TabIndex=0 Then
        If LoadIni(Members[I].Name) Then begin
           { загружаем данные алфавита }
           LoadAlphabet;
           LoadDictionaryToMemory(true);
           NewGameWindow.FormActivate(NewGameWindow);
                                         end;
      break;
                                                 end;
               end;
If Not Flag Then begin
      If LabelPlayerList.Text<>'КОМПЬЮТЕР' Then begin
                     TagPlayerImage.HelpKeyword:='Im0';
                     TagPlayerImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent('Im0') as TImage).Picture);
                     Players[TabControl1.TabIndex+1].PLtype:=Human;
                     Players[TabControl1.TabIndex+1].Image:=TagPlayerImage.HelpKeyword;
                                            end
                                       else begin
                    If RightStr(Players[TabControl1.TabIndex+1].Image,1)<>'A' Then TagPlayerImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent(Players[TabControl1.TabIndex+1].Image) as TImage).Picture)
                                                                              Else TagPlayerImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent(Players[TabControl1.TabIndex+1].Image) as TRXGIFAnimator).Image);
                                            end;
      Players[TabControl1.TabIndex+1].Name:=LabelPlayerList.text;
      TabControl1.Tabs[TabControl1.TabIndex]:=ANSILowerCase(LabelPlayerList.text);
                 end;
end;

procedure TNewGameWindow.FormShow(Sender: TObject);
begin
Background:=TPicture.Create;
LoadSkinnedImage(Background,'newgame');
TagPlayerImage.Picture:=Player1Bitmap;
//Image2.Picture:=Player2Bitmap;
TagPlayerImage.HelpKeyword:=Players[1].Image;
LoadSkinnedGIF(ButtonOK.Image,'ANIMATIO\V_Button');
LoadSkinnedGIF(ButtonClose.Image,'ANIMATIO\X_Button');
end;

{---------------------------------------------------------------}
{ Жмуем кнопочку "ВЫБРАТЬ ПОЛЕ" }
procedure TNewGameWindow.ButtonSelectLayoutClick(Sender: TObject);
begin
LoadSkinnedImage(ButtonSelectLayout.Picture,'edit_op2'); ButtonSelectLayout.Update;
TimeDelay(300);
LoadSkinnedImage(ButtonSelectLayout.Picture,'edit_opt'); ButtonSelectLayout.Update;
Options.Tag:=5;
Options.ShowModal;
ChangeStrings;
end;


procedure TNewGameWindow.UpDown1ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
 UpDown1.Brush.Color:=clRed;
 If (NewValue>8) or (NewValue<2) Then AllowChange:=false;
 case Direction of
 updUp: begin
        RXLabel5.Caption:=IntToStr(StrToInt(RXLabel5.Caption)+1);
        TabControl1.Tabs.Add(WideLowerCase(GlobalTextStrings.Items.Values['DefaultNamePlayer']));
        inc(PlayersNumber);
        setlength(Players,PlayersNumber+1); setlength(Words,201,PlayersNumber+1);
        Players[PlayersNumber].Name:=GlobalTextStrings.Items.Values['DefaultNamePlayer']; Players[PlayersNumber].PLtype:=Human;
        Players[PlayersNumber].Image:='Im0';
        end;
 updDown: begin
           RXLabel5.Caption:=IntToStr(StrToInt(RXLabel5.Caption)-1);
           TabControl1.Tabs.Delete(TabControl1.Tabs.Count-1);
           dec(PlayersNumber);
           setlength(Players,PlayersNumber+1);
           setlength(Words,201,PlayersNumber+1);
          end;
 end;
end;

procedure TNewGameWindow.TabControl1DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
  var myrect:TRect;
begin
myrect.Left:=0; myrect.Top:=0;
myrect.Right:=Control.Width;  myrect.Bottom:=Control.Height;
//TabControl1.Canvas.CopyRect(Rect(0,0,TabControl1.Width,TabControl1.Height),Background.Canvas,Rect(TabControl1.Left,TabControl1.Top,TabControl1.BoundsRect.Right,TabControl1.BoundsRect.Bottom));
Control.Canvas.Brush.Color:=TabColorSel;
Control.Canvas.FrameRect(myRect);
If TabIndex=(Control as TTNTTabControl).TabIndex Then begin Control.Canvas.Brush.Color:=TabColorSel; Control.Canvas.Rectangle(Rect); end
                                              Else begin Control.Canvas.Brush.Color:=TabColor; Control.Canvas.Rectangle(Rect); end;
//Control.Brush.Style
Control.Canvas.TextOut(Rect.Left+3,Rect.Top+1,TabControl1.Tabs[TabIndex]);
end;

procedure TNewGameWindow.TabControl1Change(Sender: TObject);
begin
If TabControl1.TabIndex=0 Then LabelPagePC.hide Else LabelPagePC.Show;
case Players[TabControl1.Tabindex+1].PLtype of
   0:begin LabelPagePlayer.Checked:=true; LabelPlayerList.Enabled:=true; TagPlayerImage.Enabled:=true; end;
   1:begin LabelPagePC.Checked:=true; LabelPlayerList.Enabled:=false; TagPlayerImage.Enabled:=true; end;
   2:LabelPageNetwork.Checked:=true;
end;
LabelPlayerList.text:=Players[TabControl1.TabIndex+1].Name;
RxLabel6.Caption:=InttoStr(TabControl1.TabIndex+1);
If Players[TabControl1.Tabindex+1].PLtype<>PC Then LabelPlayerListChange(LabelPlayerList);
end;

procedure TNewGameWindow.LabelPagePCClick(Sender: TObject);
begin
LabelPagePC.Checked:=true; LabelPlayerList.Enabled:=false; TagPlayerImage.Enabled:=true;
LabelPlayerList.Text:=GlobalTextStrings.Items.Values['DefaultNamePC']; Players[TabControl1.TabIndex+1].Name:=LabelPlayerList.Text;
TabControl1.Tabs[TabControl1.TabIndex]:=ANSILowerCase(GlobalTextStrings.Items.Values['DefaultNamePC']);
Players[TabControl1.TabIndex+1].PLtype:=PC;
Players[TabControl1.TabIndex+1].Image:='pc0';
TagPlayerImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent('pc0') as TImage).Picture);
LabelPlayerListChange(LabelPlayerList);
end;

procedure TNewGameWindow.LabelPagePlayerMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
If Players[TabControl1.TabIndex+1].PLtype=Human Then exit;;
LabelPagePlayer.Checked:=true; LabelPlayerList.Enabled:=true; TagPlayerImage.Enabled:=true;
LabelPlayerList.Text:=GlobalTextStrings.Items.Values['DefaultNamePlayer']; Players[TabControl1.TabIndex+1].Name:=LabelPlayerList.Text;
Players[TabControl1.TabIndex+1].PLtype:=Human;
TagPlayerImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent('Im0') as TImage).Picture);
LabelPlayerListChange(LabelPlayerList);
end;

procedure TNewGameWindow.LabelPlayerListCloseUp(Sender: TObject);
begin
//If LabelPlayerList.Text<>Players[TabControl1.TabIndex+1].Name Then Dropped:=true Else Dropped:=False;
end;

procedure TNewGameWindow.TabControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
If Trim(LabelPlayerList.text)='' Then begin AllowChange:=false; exit; end;
AddPlayersNames;
end;

procedure TNewGameWindow.LabelPlayerListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
Dropped:=False;
end;

procedure TNewGameWindow.FormCreate(Sender: TObject);
var I:byte;
begin
//RXLabel1.Font.Name:=FontNames[ttfMess]; //RXLabel2.Font.Name:=FontNames[ttfMess];
//RXLabel3.Font.Name:=FontNames[ttfMess]; RXLabel4.Font.Name:=FontNames[ttfMess];
//RXLabel5.Font.Name:=FontNames[ttfMess]; RXLabel6.Font.Name:=FontNames[ttfPlayer];
//LabelPlayerList.Font.Name:=FontNames[ttfPlayer];
TabColor:=clNavy; TabColorSel:=$00BB764D;
LabelLanguage.Caption:=GlobalTextStrings.Items.Values['TitleCaptionCurrentDictLanguage'];
If CustomColors Then begin
  NewGameWindow.Color:=StrToInt(Colors.Values['NewGameBackground']);
  For I :=0 to NewGameWindow.ControlCount-1 Do begin
        If NewGameWindow.Controls[i] is TTNTLabel Then begin
           If (NewGameWindow.Controls[i] as TTNTLabel).Font.Color=clYellow Then
               (NewGameWindow.Controls[i] as TTNTLabel).Font.color:=StrToInt(Colors.Values['NewGameWindowLabel']);
           If (NewGameWindow.Controls[i] as TTNTLabel).Font.Color=clWhite Then
               (NewGameWindow.Controls[i] as TTNTLabel).Font.color:=StrToInt(Colors.Values['NewGameWindowString']);
                                                       end;
        If NewGameWindow.Controls[i] is TShape Then
           If (NewGameWindow.Controls[i] as TShape).Pen.Color=clAqua Then
              (NewGameWindow.Controls[i] as TShape).Pen.Color:=StrToInt(Colors.Values['NewGameDivider']);
                                                   end;
  For I :=0 to NewGameWindow.TabControl1.ControlCount-1 Do begin
        If NewGameWindow.TabControl1.Controls[i] is TTNTRadioButton Then
           (NewGameWindow.TabControl1.Controls[i] as TTNTRadioButton).Font.color:=StrToInt(Colors.Values['NewGamePlayerMode']);
                                                           end;
  LabelPlayerList.Font.Color:=StrToInt(Colors.Values['NewGamePlayerName']);
  LabelPlayerList.Color:=StrToInt(Colors.Values['NewGamePlayerNameBgr']);
  RXLabel6.Font.Color:=StrToInt(Colors.Values['NewGamePlayerNumber']);
  TabControl1.Font.Color:=StrToInt(Colors.Values['NewGameTabColor']);
  TabColor:=StrToInt(Colors.Values['NewGameTabBgr']);
  TabColorSel:=StrToInt(Colors.Values['NewGameTabBgrSelected']);
                                                    end;
end;


end.



