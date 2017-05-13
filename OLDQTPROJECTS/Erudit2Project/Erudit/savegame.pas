{v 1.6.x}
unit savegame;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ErrorMes, Procs, ScktComp, Animate, GIFCtrl, bass,
  RXCtrls,buttons, StrUtils, DateUtils,Math, TNTStdCtrls, SevenZipVCL;

type
  TSaveGameWindow = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ButtonCancel: TRxGIFAnimator;
    TitleText: TTntLabel;
    titleTextShadow: TTntLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonCancelClick(Sender: TObject);
    procedure Slot1Click(Sender: TObject);
    procedure Slot2Click(Sender: TObject);
    procedure Slot3Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Procedure SaveData(Num:byte);
  Procedure LoadData(Num:byte);

var
  SaveGameWindow: TSaveGameWindow;
  SaveWinBackground:TPicture;
  SafeImages:array[1..10] of TBitmap;
  SlotImages:array[1..3,1..4] of TBitmap;
  Frame:1..3;
  _Label,_Label1,_Label2:TTNTLabel;

implementation

uses gameover, Main;

var
  Obj:string[30];
  //TempSave:SaveFileType;
  SafeIm, Slot1Im,Slot2Im,Slot3Im:TRXGifAnimator;

{$R *.DFM}
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

{----------------------------------------------------------}
{ открываем окно сохранения/восстановления }
procedure TSaveGameWindow.FormActivate(Sender: TObject);
var I,J:byte; TempStrList:TStringList;
begin
If not Shadow_Form.Visible Then begin
   Shadow_Form.Left:=SaveGameWindow.Left+7; Shadow_Form.Top:=SaveGameWindow.Top+7;
   Shadow_Form.Width:=SaveGameWindow.Width; Shadow_Form.Height:=SaveGameWindow.Height;
   Shadow_Form.Show; SaveGameWindow.BringToFront;


If SafeIm=nil Then begin
   SafeIm:=TRXGifAnimator.Create(self); SafeIm.Parent:=SaveGameWindow; SafeIm.AutoSize:=true;
   SafeIm.Left:=3; SafeIm.Top:=3; SafeIm.Enabled:=False; SafeIm.Loop:=false; SafeIm.Transparent:=true;
   LoadSkinnedGIF(SafeIm.Image,'ANIMATIO\safe1'); SafeIm.Animate:=false;
                 end;
If Slot1Im=nil Then begin
   Slot1Im:=TRXGifAnimator.Create(SaveGameWindow); Slot1Im.Parent:=SaveGameWindow; Slot1Im.AutoSize:=true;
   Slot1Im.Left:=77; Slot1Im.Top:=54; Slot1Im.Enabled:=False; Slot1Im.Loop:=false; Slot1Im.Transparent:=true;
   Slot1Im.Name:='Slot1Im';
   LoadSkinnedGIF(slot1Im.Image,'ANIMATIO\slslot1'); Slot1Im.Animate:=false;
   Slot1Im.SendToBack;
                 end;
If Slot2Im=nil Then begin
   Slot2Im:=TRXGifAnimator.Create(SaveGameWindow); Slot2Im.Parent:=SaveGameWindow; Slot2Im.AutoSize:=true;
   Slot2Im.Left:=77; Slot2Im.Top:=83; Slot2Im.Enabled:=False; Slot2Im.Loop:=false; Slot2Im.Transparent:=true;
   Slot2Im.Name:='Slot2Im';
   LoadSkinnedGIF(slot2Im.Image,'ANIMATIO\slslot2'); Slot2Im.Animate:=false;
   Slot2Im.SendToBack;
                 end;
If Slot3Im=nil Then begin
   Slot3Im:=TRXGifAnimator.Create(SaveGameWindow); Slot3Im.Parent:=SaveGameWindow; Slot3Im.AutoSize:=true;
   Slot3Im.Left:=77; Slot3Im.Top:=112; Slot3Im.Enabled:=False; Slot3Im.Loop:=false; Slot3Im.Transparent:=true;
   Slot3Im.Name:='Slot3Im';   
   LoadSkinnedGIF(slot3Im.Image,'ANIMATIO\slslot3'); Slot3Im.Animate:=false;
   Slot3Im.SendToBack;
                 end;
SafeIm.SendToBack;

case Tag of
{ save }
1: begin
         TitleText.Caption:=GlobalTextStrings.Items.Values['InGameTagButtonSaveGame']+' • '+Players[1].Name;
         Label1.Show; Label2.Show; Label3.Show;
         For I:=1 to 3 Do begin
         If FileExists(CurrentDir+'\save\save'+IntToStr(Players[1].Code)+'.00'+IntToStr(I))
           Then If ExtractFile(CurrentDir+'\save\save'+IntToStr(Players[1].Code)+'.00'+IntToStr(I))
                Then begin
         TempStrList:=TStringList.Create;
         LoadUnicodeFile(CurrentDir+'\$$$.tmp',TempStrList,nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
         (SaveGameWindow.FindComponent('Label'+IntToStr(I)) as TLabel).Caption:=TempStrList.values['SaveDate']+' '+TempStrList.values['SaveTime'];
         (SaveGameWindow.FindComponent('Label'+IntToStr(I)) as TLabel).Cursor:=crHandPoint;
         (SaveGameWindow.FindComponent('Slot'+IntToStr(I)+'Im') as TRXGifANimator).Cursor:=crHandPoint;
         (SaveGameWindow.FindComponent('Label'+IntToStr(I)) as TLabel).Hint:=ANSIReplaceText(TempStrList.values['Info'],'#',#$D#$A);
         (SaveGameWindow.FindComponent('Label'+IntToStr(I)) as TLabel).Show;
         TempStrList.Free;
                 end
         Else Else begin
                    (SaveGameWindow.FindComponent('Label'+IntToStr(I)) as TLabel).Hint:=GlobalTextStrings.Items.Values['TagEmptySlot'];
                    (SaveGameWindow.FindComponent('Label'+IntToStr(I)) as TLabel).Cursor:=crArrow;
                    (SaveGameWindow.FindComponent('Slot'+IntToStr(I)+'Im') as TRXGifANimator).Cursor:=crArrow;
                   end;
                        end;
         {try
         If FileExists('save'+IntToStr(Players[1].Code)+'.001') Then begin
         AssignFile(SaveGameFile,'save'+IntToStr(Players[1].Code)+'.001');
         try
         Reset(SaveGameFile);  Read(SaveGameFile,TempSave);
         Label1.Caption:=TempSave.Date+'  '+TempSave.Time;
         Label1.Cursor:=crHandPoint; Slot1Im.Cursor:=crHandPoint;
         Label1.Hint:=TempSave.Info;
         finally
         CloseFile(SaveGameFile);
         end;
                                   end
         Else begin
                   Label1.Hint:=GlobalTextStrings.Items.Values['TagEmptySlot'];
                   Label1.Cursor:=crArrow; Slot1Im.Cursor:=crArrow;
                end;
         except end;
         try
         If FileExists('save'+IntToStr(Players[1].Code)+'.002') Then begin
         AssignFile(SaveGameFile,'save'+IntToStr(Players[1].Code)+'.002');
         try
         Reset(SaveGameFile);  Read(SaveGameFile,TempSave);
         Label2.Caption:=TempSave.Date+'  '+TempSave.Time;
         Label2.Hint:=TempSave.Info; Label2.Refresh;
         Label2.Cursor:=crHandPoint; Slot2Im.Cursor:=crHandPoint;
         finally
         CloseFile(SaveGameFile);
         end;
                                   end
         Else begin
                   Label2.Hint:=GlobalTextStrings.Items.Values['TagEmptySlot'];
                   Label2.Cursor:=crArrow; Slot2Im.Cursor:=crArrow;
                end;
         except end;
         try
         If FileExists('save'+IntToStr(Players[1].Code)+'.003') Then begin
         AssignFile(SaveGameFile,'save'+IntToStr(Players[1].Code)+'.003');
         try
         Reset(SaveGameFile);  Read(SaveGameFile,TempSave);
         Label3.Caption:=TempSave.Date+'  '+TempSave.Time;
         Label3.Hint:=TempSave.Info; Label3.Refresh;
         Label3.Cursor:=crHandPoint; Slot3Im.Cursor:=crHandPoint;
         finally
         CloseFile(SaveGameFile);
         end;
                                   end
         Else begin
                   Label3.Hint:=GlobalTextStrings.Items.Values['TagEmptySlot'];
                   Label3.Cursor:=crArrow; Slot3Im.Cursor:=crArrow;
                end;
         except end; }
     end;
{ load }
2: begin
        TitleText.Caption:=GlobalTextStrings.Items.Values['InGameTagButtonLoadGame']+' • '+Players[1].Name;
        SaveGameWindow.FormPaint(Sender);
        For I:=1 to 3 Do begin
         If FileExists(CurrentDir+'\save\save'+IntToStr(Players[1].Code)+'.00'+IntToStr(I))
           Then If ExtractFile(CurrentDir+'\save\save'+IntToStr(Players[1].Code)+'.00'+IntToStr(I))
                  Then begin
         TempStrList:=TStringList.Create;
         LoadUnicodeFile(CurrentDir+'\$$$.tmp',TempStrList,nil,GetLanguageCodepage(LanguageDict)<>1251, convert);
         (SaveGameWindow.FindComponent('Label'+IntToStr(I)) as TLabel).Caption:=TempStrList.values['SaveDate']+' '+TempStrList.values['SaveTime'];
         (SaveGameWindow.FindComponent('Label'+IntToStr(I)) as TLabel).Cursor:=crHandPoint;
         (SaveGameWindow.FindComponent('Slot'+IntToStr(I)+'Im') as TRXGifANimator).Cursor:=crHandPoint;
         (SaveGameWindow.FindComponent('Label'+IntToStr(I)) as TLabel).Hint:=ANSIReplaceText(TempStrList.values['Info'],'#',#$D#$A);
         (SaveGameWindow.FindComponent('Label'+IntToStr(I)) as TLabel).Show;
         TempStrList.Free;
                   end
         Else Else begin
                    (SaveGameWindow.FindComponent('Label'+IntToStr(I)) as TLabel).Hint:=GlobalTextStrings.Items.Values['TagEmptySlot'];
                    (SaveGameWindow.FindComponent('Label'+IntToStr(I)) as TLabel).Cursor:=crArrow;
                    (SaveGameWindow.FindComponent('Slot'+IntToStr(I)+'Im') as TRXGifANimator).Cursor:=crArrow;
                   end;
                        end;
        ButtonCancel.Update;
         {try
         If FileExists('save'+IntToStr(Players[1].Code)+'.001') Then
           begin
         AssignFile(SaveGameFile,'save'+IntToStr(Players[1].Code)+'.001');
         try
         Reset(SaveGameFile);  Read(SaveGameFile,TempSave);
         Label1.Caption:=TempSave.Date+'  '+TempSave.Time;
         Label1.Cursor:=crHandPoint; Slot1Im.Cursor:=crHandPoint;
         Label1.Hint:=TempSave.Info; Label1.Show;
         finally
         CloseFile(SaveGameFile);
         end;
                                   end
         Else begin
                   Label1.Hint:=GlobalTextStrings.Items.Values['TagEmptySlot'];
                   Label1.Cursor:=crArrow; Slot1Im.Cursor:=crArrow;
                end;
         except end;
         try
         If FileExists('save'+IntToStr(Players[1].Code)+'.002') Then begin
         AssignFile(SaveGameFile,'save'+IntToStr(Players[1].Code)+'.002');
         try
         Reset(SaveGameFile);  Read(SaveGameFile,TempSave);
         Label2.Caption:=TempSave.Date+'  '+TempSave.Time;
         Label2.Cursor:=crHandPoint; Slot2Im.Cursor:=crHandPoint;
         Label2.Hint:=TempSave.Info; Label2.Show;
         finally
         CloseFile(SaveGameFile);
         end;
                                   end
         Else begin
                   Label2.Hint:=GlobalTextStrings.Items.Values['TagEmptySlot'];
                   Label2.Cursor:=crArrow; Slot2Im.Cursor:=crArrow;
                end;
         except end;
         try
         If FileExists('save'+IntToStr(Players[1].Code)+'.003') Then begin
         AssignFile(SaveGameFile,'save'+IntToStr(Players[1].Code)+'.003');
         try
         Reset(SaveGameFile);  Read(SaveGameFile,TempSave);
         Label3.Caption:=TempSave.Date+'  '+TempSave.Time;
         Label3.Cursor:=crHandPoint; Slot3Im.Cursor:=crHandPoint;
         Label3.Hint:=TempSave.Info; Label3.Show;
         finally
         CloseFile(SaveGameFile);
         end;
                                   end
         Else begin
                   Label3.Hint:=GlobalTextStrings.Items.Values['TagEmptySlot'];
                   Label3.Cursor:=crArrow; Slot3Im.Cursor:=crArrow;
                end;
         except end;}
     end;
end;
Obj:='SaveGameWindow';
                                    end;
TitleTextShadow.Caption:=TitleText.Caption;
end;
{----------------------------------------------------------}
{ отображаем фоновую картинку }
procedure TSaveGameWindow.FormPaint(Sender: TObject);
begin
SaveGameWindow.Canvas.Draw(0,0,SaveWinBackground.Graphic);
end;
{----------------------------------------------------------}
{ закрываем окно сохранения/восстановления }
procedure TSaveGameWindow.FormClose(Sender: TObject;
  var Action: TCloseAction);
var  I,J:byte;
begin
Label1.Caption:=''; Label2.Caption:=''; Label3.Caption:='';
If SafeIm<>nil Then begin SafeIm.Free; SafeIm:=nil end;
If Slot1Im<>nil Then begin Slot1Im.Free; Slot1Im:=nil end;
If Slot2Im<>nil Then begin Slot2Im.Free; Slot2Im:=nil end;
If Slot3Im<>nil Then begin Slot3Im.Free; Slot3Im:=nil end;
end;
{----------------------------------------------------------}
{ жмуем кнопочку "Х" }
procedure TSaveGameWindow.ButtonCancelClick(Sender: TObject);
begin
Label1.Hide; Label2.Hide; Label3.Hide;
ModalResult:=mrNo;
end;

{----------------------------------------------------------}
{ записываем текстовый сейвфайл }
Procedure SaveTXTData(Num:byte);
var I,J:word; SaveTXTFile:text; TempStr:TStringList; TempS:string;
    Im:TImage;
begin
try
TempStr:=TStringList.Create;
If not DirectoryExists('save') Then CreateDir('save');
TempStr.Add('[Common]');
TempStr.Add('SaveDate='+DateToStr(Today));
TempStr.Add('SaveTime='+TimeToStr(Now));
TempS:=IntToStr(PlayersNumber)+' игрок'+ifthen(PlayersNumber<5,'а. ','ов. ')+'Счет: ';
For I:=1 To PlayersNumber Do TempS:=TempS+IntToStr(Players[I].Points)+' : ';
TempS:=copy(TempS,1,length(TempS)-3)+'#';
TempS:=TempS+'Поле:'+InttoStr(WorkFieldDimentionX)+'x'+InttoStr(WorkFieldDimentionY)+', ';
If Template='' Then TempS:=TempS+'произвольное' Else
               If Template='classic.map' Then TempS:=TempS+'классическое'
                                         Else TempS:=TempS+'шаблон';
TempS:=TempS+'#'+_Label2.Caption+'#'+_Label.Caption+'#'+_Label1.Caption;
TempStr.Add('Info='+ANSIReplaceText(TempS,chr(13),'#'));
TempStr.Add('Opponent='+IntToStr(Opponent));
//TempStr.Add('MoveIs='+IntToStr(MoveIs));
//TempStr.Add('ModeIs='+IntToStr(WhatIDoNow));
TempStr.Add('Intellect='+IntToStr(PCIntellect));
TempStr.Add('PlayFieldDimX='+IntToStr(WorkFieldDimentionX));
TempStr.Add('PlayFieldDimY='+IntToStr(WorkFieldDimentionY));
TempStr.Add('Template='+Template);
if MovesLOg<>nil Then TempS:=MovesLog.Strings[0];
TempStr.Add('PlayField='+TempS);
TempStr.Add('MainFormXY='+IntToStr((Screen.Width-MainScreen.Left)*10000+(Screen.Height-MainScreen.Top)));
TempStr.Add('ControlFormXY='+IntToStr((Screen.Width-RC_Form.Left)*10000+(Screen.Height-RC_Form.Top)));
//TempStr.Add('LettersCount='+IntToStr(WorkFieldDimentionX*WorkFieldDimentionY));
if MovesLOg<>nil Then TempS:=MovesLog.Strings[1];
TempStr.Add('Letters='+TempS);
TempStr.Add('Language='+LanguageDict);
TempStr.Add('LanguageExpl='+LanguageExpl);
//TempStr.Add('HintDelay='+IntToStr(HintDelay));
TempStr.Add('HintLimit='+IntToStr(StoreHintLimit));
//TempStr.Add('HintLeft='+IntToStr(StoreHintLimit));
If Limit<>'' Then TempStr.Add('Limits='+Limit);
//TempStr.Add('Themes='+Theme);
If MoveLimit Then TempStr.Add('MoveTime='+IntToStr(StartMin)+':'+IntToStr(StartSec));
If TimeLimit Then TempStr.Add('LastElaspedTime='+IntToStr(StartMin)+':'+IntToStr(StartSec));
TempStr.Add('KeepBonuses='+IntToStr(ord(KeepBonuses)));
TempStr.Add(chr(13)+'[Players]');
For I:=1 to PlayersNumber Do TempStr.Add('Player'+IntToStr(I)+'='+Players[I].Name+'/'+IntToStr(Players[I].Points*10000+Players[I].Changes)+'/'+IntToStr(Players[I].code)+'/'+IntToStr(Players[I].PLtype)+'/'+Players[I].Image);
TempS:=''; For I:=0 to length(PlayerForms)-1 Do
    TempS:=TempS+IntToStr((Screen.Width-PlayerForms[I].Left)*10000+(Screen.Height-PlayerForms[I].Top))+'/'+ifthen((PlayerForms[I].FindComponent('MinButt'+IntToStr(PlayerForms[I].Tag)) as TSpeedButton).Caption='o','1','0')+'/'+IntToStr(PlayerForms[I].HelpContext)+',';
TempStr.Add('PlayerForms='+TempS);
if MovesLOg<>nil Then begin
  TempStr.Add(chr(13)+'[Moves]');
  If MoveLimit Then MovesLog.Strings[MovesLog.Count-1]:=MovesLog.Strings[MovesLog.Count-1]+'MTIME:'+IntToStr(StartMin)+'/'+IntToStr(StartSec)+',';
  If TimeLimit Then MovesLog.Strings[MovesLog.Count-1]:=MovesLog.Strings[MovesLog.Count-1]+'ETIME:'+IntToStr(StartMin)+'/'+IntToStr(StartSec)+',';
  For I:=1 To WorkFieldDimentionX Do For J:=1 To WorkFieldDimentionY Do
      If (WorkField[I,J].hotspot<>' ') and (WorkField[I,J].main=' ') Then begin
         If pos('PLAYGROUND:',MovesLog.Strings[MovesLog.Count-1])=0 Then MovesLog.Strings[MovesLog.Count-1]:=MovesLog.Strings[MovesLog.Count-1]+'PLAYGROUND:';
         MovesLog.Strings[MovesLog.Count-1]:=MovesLog.Strings[MovesLog.Count-1]+IntToStr(I*1000+J)+'/'+IntToStr(WorkField[I,J].Image)+',';
                                                                           end;
  If isPCMove Then MovesLog.Delete(MovesLog.Count-1);
  For I:=2 to MovesLog.Count-1 Do TempStr.Add(MovesLog.Strings[i]);
  If Helped and (pos('WORDS:',TempStr.Strings[TempStr.Count-1])=0) Then begin
     TempS:=''; For I:=0 to length(HelpedWords)-1 Do TempS:=TempS+HelpedWords[I].Word+'('+IntToStr(HelpedWords[I].Value)+')'+IntToStr(HelpedWords[I].WBegin*100+HelpedWords[I].AltCoord)+ifthen(HelpedWords[I].direction=1,'H','V')+',';
     TempStr.Strings[TempStr.Count-1]:=TempStr.Strings[TempStr.Count-1]+'HELPED:'+TempS;     
                                                                      end;

  If WhatIDoNow=Take Then begin
     TempS:=''; For I:=1 to 7 Do TempS:=TempS+Slot7[MoveIs][I].Letter+'/'+IntToStr(Slot7[MoveIs][I].Image)+',';
     TempStr.Strings[TempStr.Count-1]:=TempStr.Strings[TempStr.Count-1]+'SLOT:'+TempS;
                          end ;
                      end;
If (length(SelectShapes)>0) and (Opponent=Human) Then begin
   TempStr.Add(chr(13)+'[Selections]');
   TempS:=''; j:=0; For I:=0 to length(SelectShapes)-1 Do
    If SelectShapes[I]<>nil Then
     If SelectShapes[I].Visible Then begin
      TempS:=TempS+SelectShapes[I].Name+'/'+IntToStr(SelectShapes[I].Left*10000+SelectShapes[I].Top)+'/'+IntToStr(SelectShapes[I].Pen.Color)+'/'+IntToStr(SelectShapes[I].Width*1000+SelectShapes[I].Height)+'/'+IntToStr(SelectShapes[I].Tag)+',';
      inc(j);
                                   end;
   TempStr.Add('ShapesNum='+IntToStr(j));
   TempStr.Add('Shapes='+TempS);
   TempS:=''; For I:=0 To WorkFieldDimentionX+1 Do For J:=0 To WorkFieldDimentionY+1 Do TempS:=TempS+IntToStr(SelectField[I,J]);
   TempStr.Add('SelectMap='+TempS);
                               end;
   SaveUnicodeFile(CurrentDir+'\$$$.tmp',TempStr,nil, false, convert);
   //SaveUnicodeFile(CurrentDir+'\save\savelast.'+IntToStr(Players[1].Code),TempStr,nil, false, convert)
   //        Else
   //SaveUnicodeFile(CurrentDir+'\save\save'+IntToStr(Players[1].Code)+'.00'+IntToStr(Num),TempStr,nil,false,convert);
 {пакуем сейв в 7zip}
 With MainScreen do begin
 If Num=254 Then
   sevenzip1.SZFileName:=CurrentDir+'\save\savelast.'+IntToStr(Players[1].Code)
            Else
   sevenzip1.SZFileName:=CurrentDir+'\save\save'+IntToStr(Players[1].Code)+'.00'+IntToStr(Num);
 //sevenzip1.VolumeSize:= 0;
 //sevenZip1.LZMACompressStrength:=MAXIMUM;
 //sevenzip1.AddOptions:=[AddStoreOnlyFilename];
 //Sevenzip1.Password:='SIMSIMTOOPEN';
 sevenzip1.Files.Clear;
 sevenzip1.Files.AddString(CurrentDir+'\$$$.tmp');
 I:=Sevenzip1.Add;
                    end;
 Deletefile(Pchar(CurrentDir+'\$$$.tmp'));
TempStr.Free;
except end;
end;
{----------------------------------------------------------}
{ записываем информацию в файл }
Procedure SaveData(Num:byte);
var Year,Month,Day,Hour,Minute:word;
    I,J:word; SD,SM,SH,SMi:string[2]; Im:TImage;
    Ends:array[2..8] of string[2];
begin
ShowLetters;
{пробная запись в текстовый файл}
{If ParamStr(1)='newsave' Then} SaveTXTData(Num);
{If Num=255 Then
  AssignFile(SaveGameFile,'save'+IntToStr(Players[1].Code)+'.err')
Else If Num=254 Then
  AssignFile(SaveGameFile,'savelast.'+IntToStr(Players[1].Code))
           Else
  AssignFile(SaveGameFile,'save'+IntToStr(Players[1].Code)+'.00'+IntToStr(Num));
ReWrite(SaveGameFile);

DecodeDate(Date,Year,Month,Day);
If Day<10 Then SD:='0' Else SD:='';
If Month<10 Then SM:='0' Else SM:='';
Save.Date:=SD+IntToStr(Day)+'-'+SM+IntToStr(Month)+'-'+IntToStr(Year);

DecodeTime(Time,Hour,Minute,Second,MSecond);
If Hour<10 Then SH:='0' Else SH:='';
If Minute<10 Then SMi:='0' Else SMi:='';
Save.Time:=SH+IntToStr(Hour)+':'+SMi+IntToStr(Minute);

Save.Info:=IntToStr(PlayersNumber)+' игрок';
If PlayersNumber<5 Then Save.Info:=Save.Info+'а. ' Else Save.Info:=Save.Info+'ов. ';
Save.Info:=Save.Info+'Счет: ';
For I:=1 To PlayersNumber Do Save.Info:=Save.Info+IntToStr(Players[I].Points)+' : ';
Save.Info:=copy(Save.Info,1,length(Save.Info)-3)+chr(13);
Save.Info:=Save.Info+'Поле:'+InttoStr(WorkFieldDimentionX)+'x'+InttoStr(WorkFieldDimentionY)+', ';
If Template='' Then Save.Info:=Save.Info+'произвольное' Else
               If Template='classic.map' Then Save.Info:=Save.Info+'классическое'
                                         Else Save.Info:=Save.Info+'шаблон';
Save.Info:=Save.Info+chr(13);
Save.Info:=Save.Info+_Label2.Caption+chr(13);
Save.Info:=Save.Info+_Label.Caption+chr(13)+_Label1.Caption;

Save.Opnt:=Opponent;
Save.Intellect:=PCIntellect;
Save.Limits:=Limit;
Save.Themes:=Theme;                          
Save.StartHour:=StartHour; Save.StartMin:=StartMin; Save.StartSec:=StartSec;
Save.LangDict:=LanguageDict;
Save.LangExpl:=LanguageExpl;
Save.LettersCount:=(WorkFieldDimentionX*WorkFieldDimentionY);
For I:=0 To Save.LettersCount-1 Do begin
  Im:=Letters[I];
  Save.Letters[I].Left:=Im.Left; Save.Letters[I].Top:=Im.Top;
  Save.Letters[I].Hint:=Im.Hint; Save.Letters[I].Tag:=Im.Tag;
  Save.Letters[I].Visible:=Im.Visible;
  Save.Letters[I].Parent:=Im.Parent.Tag;
  If (Im.Parent=Application.MainForm) or (Im.Parent=_ChoicePanel) Then Save.Letters[I].Parent:=0;
                   end;
Save.WorkFieldDimentionX:=WorkFieldDimentionX;
Save.WorkFieldDimentionY:=WorkFieldDimentionY;
For I:=0 To WorkFieldDimentionX+1 Do For J:=0 To WorkFieldDimentionY+1 Do Save.WorkField[I,J]:=WorkField[I,J];
Save.PlayersNumber:=PlayersNumber;
For I:=1 To PlayersNumber Do Save.Players[I]:=Players[I];
For I:=1 To 200 Do For J:=1 To PlayersNumber Do Save.WordList[I,J]:=Words[I,J];
For I:=1 To PlayersNumber Do For J:=1 To 7 Do Save.Slot7[I,J]:=Slot7[I,J];
Save.Move:=MoveIs;
Save.Help:=Helped;
Save.Mode:=WhatIDoNow;
Save.HintDelay:=HintDelay;
Save.HintLimit:=HintLimit;
Save.StoreHintLimit:=StoreHintLimit;
Save.MainFieldForm.X:=Application.MainForm.Left; Save.MainFieldForm.Y:=Application.MainForm.Top;
Save.FloatingForms[0].X:=RC_Form.Left; Save.FloatingForms[0].Y:=RC_Form.Top;
For I:=0 to length(PlayerForms)-1 Do begin
  Save.FloatingForms[I+1].X:=PlayerForms[I].Left;
  Save.FloatingForms[I+1].Y:=PlayerForms[I].Top;
  If (PlayerForms[I].FindComponent('MinButt'+IntToStr(PlayerForms[I].Tag)) as TSpeedButton).Caption='o'
   Then Save.FloatingForms[I+1].Status:=1 Else Save.FloatingForms[I+1].Status:=0;
  Save.FloatingForms[I+1].Locked:=PlayerForms[I].HelpContext;
                                     end;
Save.Template:=Template;
If Opponent=Human Then begin
Save.ShapesNumber:=length(SelectShapes);
If length(SelectShapes)>0 Then
   For I:=0 to length(SelectShapes)-1 Do
    begin with Save.SelectShapes[I] Do
         begin If SelectShapes[I]=nil Then continue;
               If SelectShapes[I].Visible Then Name:=SelectShapes[I].Name Else Name:=SelectShapes[I].Name+'inv';
               Color:=SelectShapes[I].Pen.Color;
               Left:=SelectShapes[I].Left; Top:=SelectShapes[I].Top;
               Width:=SelectShapes[I].Width; Height:=SelectShapes[I].Height;
               Tag:=SelectShapes[I].Tag;
           end;
      end;
                          end;
For I:=0 To WorkFieldDimentionX+1 Do For J:=0 To WorkFieldDimentionY+1 Do Save.SelectField[I,J]:=SelectField[I,J];
//Save.KeepBonuses:=KeepBonuses;
Write(SaveGameFile,Save);
CloseFile(SaveGameFile);}
//MainScreen.ScreenButtonTitleContinue.Hint:=Save.Date+' '+Save.Time+chr(13)+Save.Info;
end;
{----------------------------------------------------------}
{ читаем информацию из файла }
Procedure LoadData(Num:byte);
var I,J:byte; Im:TImage;
begin
If Num=254 Then SaveGameWindow.Hint:='254'
           Else
           If not FileExists(CurrentDir+'\save\save'+IntToStr(Players[1].Code)+'.00'+IntToStr(Num)) Then Exit;
end;
{----------------------------------------------------------}
{ щелкаем на слоте записи }
procedure TSaveGameWindow.Slot1Click(Sender: TObject);
var I:byte;
begin
If (Tag=2) and (Label1.Caption='') Then Exit;
Slot2Im.Hide; Slot3Im.Hide;
Label2.Hide; Label3.Hide; Label1.Update;
If Tag=1 Then begin
SaveGameWindow.Enabled:=false;
SaveData(1);
Label1.Hide;
If PlaySounds Then BASS_SamplePlay(SaveSound);
For I:=2 to Slot1Im.Image.Count-1 Do begin Slot1Im.FrameIndex:=I; slot1Im.Update; TimeDelay(20); end;
SafeIm.Animate:=true;
While SafeIm.Animate Do Application.ProcessMessages;
SaveGameWindow.Enabled:=true;
              end
         Else begin
               LoadData(1);
              end;
ModalResult:=mrYes;
SaveGameWindow.Hint:='1';
end;

procedure TSaveGameWindow.Slot2Click(Sender: TObject);
var I:byte;
begin
If (Tag=2) and (Label2.Caption='') Then Exit;
Slot1Im.Hide; Slot3Im.Hide;
Label1.Hide; Label3.Hide; Label1.Update;
If Tag=1 Then begin
SaveGameWindow.Enabled:=false;
SaveData(2);
Label2.Hide;
If PlaySounds Then BASS_SamplePlay(SaveSound);
For I:=2 to Slot2Im.Image.Count-1 Do begin Slot2Im.FrameIndex:=I; slot2Im.Update; TimeDelay(20); end;
SafeIm.Animate:=true;
While SafeIm.Animate Do Application.ProcessMessages;
SaveGameWindow.Enabled:=true;
              end
         Else begin
                 LoadData(2);
              end;
ModalResult:=mrYes;
SaveGameWindow.Hint:='2';
end;

procedure TSaveGameWindow.Slot3Click(Sender: TObject);
var I:byte;
begin
If (Tag=2) and (Label3.Caption='') Then Exit;
Slot1Im.Hide; Slot2Im.Hide;
Label1.Hide; Label2.Hide; Label1.Update;
If Tag=1 Then begin
SaveGameWindow.Enabled:=false;
SaveData(3);
Label3.Hide;
If PlaySounds Then BASS_SamplePlay(SaveSound);
For I:=2 to Slot3Im.Image.Count-1 Do begin Slot3Im.FrameIndex:=I; slot3Im.Update; TimeDelay(20); end;
SafeIm.Animate:=true;
While SafeIm.Animate Do Application.ProcessMessages;
SaveGameWindow.Enabled:=true;
              end
         Else begin
               LoadData(3);
              end;
ModalResult:=mrYes;
SaveGameWindow.Hint:='3';
end;

procedure TSaveGameWindow.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
If (Sender = SaveGameWindow) and (Obj<>'SaveGameWindow') Then begin
   Slot1Im.FrameIndex:=0; Slot2Im.FrameIndex:=0; Slot3Im.FrameIndex:=0;
   Obj:='SaveGameWindow'; Exit;
                                                              end;
If ((Sender = Slot1Im) or (Sender = Label1)) and (Obj<>'Slot1') Then begin
   Slot1Im.FrameIndex:=1; Slot2Im.FrameIndex:=0; Slot3Im.FrameIndex:=0;
   Obj:='Slot1'; Exit;
                                                           end;
If ((Sender = Slot2Im) or (Sender = Label2)) and (Obj<>'Slot2') Then begin
   Slot1Im.FrameIndex:=0; Slot2Im.FrameIndex:=1; Slot3Im.FrameIndex:=0;
   Obj:='Slot2'; Exit;
                                                           end;
If ((Sender = Slot3Im) or (Sender = Label3)) and (Obj<>'Slot3') Then begin
   Slot1Im.FrameIndex:=0; Slot2Im.FrameIndex:=0; Slot3Im.FrameIndex:=1;
   Obj:='Slot3'; Exit;
                                                           end;

end;

procedure TSaveGameWindow.FormCreate(Sender: TObject);
var I:byte;
begin
LoadSkinnedGIF(ButtonCancel.Image,'ANIMATIO\s_button');
TitleText.Font.Color:=StrToInt(ifthen(CustomColors,Colors.Values['SaveGameWindowCap'],IntToStr(clAqua)));
//  If win32Platform<>ver_platform_win32_nt Then begin
     For I:=0 to (Sender as TForm).ControlCount-1 Do begin
        If ((sender as TForm).Controls[i] is TTNTLabel) Then begin
                                                    ((sender as TForm).Controls[i] as TTNTLabel).Font.Name:=FontNames[ttfMess];
                                                             end;
                                                   // ((sender as TForm).Controls[i] as TRXLabel).Font.Charset:=DEFAULT_CHARSET;
        If ((sender as TForm).Controls[i] is TLabel)  Then begin ((sender as TForm).Controls[i] as TLabel).Font.Name:=FontNames[ttfMess];
                                                                 ((sender as TForm).Controls[i] as TLabel).Font.Color:=StrToInt(ifthen(CustomColors,Colors.Values['SaveGameWindowText'],IntToStr(clBlack)));
                                                           end;
                                                   // ((sender as TForm).Controls[i] as TLabel).Font.Charset:=DEFAULT_CHARSET;
                                                     end;
//                                               end;
end;

procedure TSaveGameWindow.FormKeyPress(Sender: TObject; var Key: Char);
begin
If key=#27 Then ButtonCancelClick(Sender);
end;

end.
