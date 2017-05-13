{v 1.6.x}
unit gameover;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ErrorMes, StdCtrls, Procs, Animate, GIFCtrl, bass, StrUtils,
  TntStdCtrls;

type
  TSplashWindow = class(TForm)
    WinnerName: TTntLabel;
    WinnerNameShadow: TTntLabel;
    LabelWinner: TTntLabel;
    NoWinner: TTntLabel;
    NoWinnerShadow: TTntLabel;
    ButtonOK: TRxGIFAnimator;
    procedure FormActivate(Sender: TObject);
    procedure AnimTimer1Timer(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure AnimTimer2Timer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure t(Sender: TObject);
    procedure AnimTimer3Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{ окно окончания партии }
Procedure ShowGameOverScreen;

var
  SplashWindow: TSplashWindow;
  GameoverWinBackground:TPicture;

implementation

uses PLImages;
var Frame,Frame1,Frame2,Frame4:0..6;
    //AnimFrames:array[1..6] of TPicture;
    WinnerIm,GoIm:TRXGifAnimator;
    WinnerIm1:TImage;


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
{---------------------------------------------------------------}
procedure TSplashWindow.FormActivate(Sender: TObject);
var i:byte; TempBmp:TBitmap; k:word; fname:string[30];
begin
If not Shadow_Form.Visible Then begin
   Shadow_Form.Left:=SplashWindow.Left+7; Shadow_Form.Top:=SplashWindow.Top+7;
   Shadow_Form.Width:=SplashWindow.Width; Shadow_Form.Height:=SplashWindow.Height;
   Shadow_Form.Show; SplashWindow.BringToFront;
                                end;
Frame4:=0;
WinnerNameShadow.Caption:=WinnerName.Caption;
NoWinnerShadow.Caption:=NoWinner.Caption;
If (SplashWindow.Tag>0) and (WinnerIm=nil) Then
    begin
WinnerIm:=TRXGifAnimator.Create(self);
WinnerIm.Parent:=SplashWindow; WinnerIm.AutoSize:=true;
WinnerIm.Left:=20; WinnerIm.Top:=86; WinnerIm.Enabled:=False;
WinnerIm.Transparent:=true;
//If (Players[SplashWindow.Tag]).Image<>'pc1' Then
      try
       For K:=0 to ImageScreen.ScrollBox1.ControlCount-1 Do
            If pos(Players[SplashWindow.Tag].Image, ImageScreen.ScrollBox1.Controls[K].Name)<>0 Then
               begin fname:=(ImageScreen.ScrollBox1.FindComponent(Players[SplashWindow.Tag].Image) as TControl).Hint;
                     LoadSkinnedGIF(WinnerIm.Image,'Animatio\'+copy(fName,1,pos('.',fname)-1)+'go');
                     break;
                 end;
      except
      If RightStr(Players[SplashWindow.Tag].Image,1)<>'A' Then
         If (WinnerIm1=nil) Then begin
           WinnerIm1:=TImage.Create(self);
           WinnerIm1.Parent:=SplashWindow; WinnerIm1.AutoSize:=false;
           WinnerIm1.Width:=119; WinnerIm1.Height:=122;
           WinnerIm1.Left:=20; WinnerIm1.Top:=86; WinnerIm1.Enabled:=False;
           WinnerIm1.Transparent:=true; WinnerIm1.Center:=true;
           WinnerIm1.Picture.Assign((ImageScreen.ScrollBox1.FindComponent(Players[SplashWindow.Tag].Image) as TImage).Picture)
                                end Else
                                                          Else
                                       WinnerIm.Image.Assign((ImageScreen.ScrollBox1.FindComponent(Players[SplashWindow.Tag].Image) as TRXGifAnimator).Image);
      end;
WinnerIm.Loop:=true; WinnerIm.Animate:=true;
    end;
If GoIm=nil Then begin
   GoIm:=TRXGifAnimator.Create(self); GoIm.Parent:=SplashWindow; GoIm.AutoSize:=true;
   GoIm.Left:=15; GoIm.Top:=18; GoIm.Enabled:=False; GoIm.Loop:=false; GoIm.Transparent:=true;
   LoadSkinnedGIF(GoIm.Image,'Animatio\goblur'); GoIm.Animate:=true;
   While GoIm.Animate Do Application.ProcessMessages;
   GoIm.Loop:=true; LoadSkinnedGIF(GoIm.Image,'Animatio\gowave'); GoIm.Animate:=true;
                 end;
Hint:='Showed';
If PlaySounds Then BASS_SamplePlay(GameOverSound)
end;
{---------------------------------------------------------------}
procedure TSplashWindow.AnimTimer1Timer(Sender: TObject);
begin
end;
{---------------------------------------------------------------}
procedure TSplashWindow.ButtonOKClick(Sender: TObject);
var i:byte;
begin
If WinnerIm<>nil Then begin WinnerIm.Animate:=false; WinnerIm.Free; WinnerIm:=nil end;
If GoIm<>nil Then begin GoIm.Animate:=false; GoIm.Free; GoIm:=nil end;
If WinnerIm1<>nil Then begin WinnerIm1.Free; WinnerIm1:=nil end;
ModalResult:=mrNo;
end;
{---------------------------------------------------------------}
{ анимация }
procedure TSplashWindow.AnimTimer2Timer(Sender: TObject);
begin

end;
{---------------------------------------------------------------}
{ нажатие клавиши Esc }
procedure TSplashWindow.FormKeyPress(Sender: TObject; var Key: Char);
begin
If key=#27 Then ButtonOKClick(Sender);
end;


procedure TSplashWindow.t(Sender: TObject);
begin
SplashWindow.Canvas.Draw(0,0,GameOverWinBackground.Graphic);
end;
{---------------------------------------------------------------}
{ анимация слов GAMEOVER }
procedure TSplashWindow.AnimTimer3Timer(Sender: TObject);
begin

end;
{---------------------------------------------------------------}
{ окно окончания партии }
Procedure ShowGameOverScreen;
var DefaultCoord:TPoint;
begin
Screen.Cursor:=crDefault;
{ запоминаем изначальные координаты окна (по сути координаты главного окна)}
DefaultCoord.X:=SplashWindow.Left; DefaultCoord.Y:=SplashWindow.Top;
SplashWindow.Position:=poMainFormCenter;
{ меняем координаты окна замены смещением от изначальных }
//SplashWindow.Left:=DefaultCoord.X+251; SplashWindow.Top:=DefaultCoord.Y+200;
SplashWindow.ShowModal;
Shadow_Form.Hide;
end;

procedure TSplashWindow.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
If playsounds then BASS_SampleStop(GameOverSound);
end;

procedure TSplashWindow.FormPaint(Sender: TObject);
begin
SplashWindow.Canvas.Draw(0,0,GameOverWinBackground.Graphic);
end;

procedure TSplashWindow.FormCreate(Sender: TObject);
var I:byte;
begin
LoadSkinnedGIF(ButtonOK.Image,'ANIMATIO\G_Button'); 
NoWinner.Font.Name:=FontNames[ttfPlayer];
WinnerName.Font.Name:=FontNames[ttfPlayer];
LabelWinner.Font.Name:=FontNames[ttfMess];
If CustomColors Then begin
 LabelWinner.Font.Color:=StrToInt(Colors.Values['GameOverWindowText']);
 WinnerName.Font.Color:=StrToInt(Colors.Values['GameOverWinnerName']);
 NoWinner.Font.Color:=StrToInt(Colors.Values['GameOverWinnerName']);
                     end;
end;

end.






