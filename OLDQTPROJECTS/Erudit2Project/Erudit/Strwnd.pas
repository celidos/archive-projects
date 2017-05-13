{v 1.6.x}
unit Strwnd;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, ErrorMes, Animate, GIFCtrl, RXCtrls,StrUtils;

type
  TStarWindow = class(TForm)
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    ButtonClose: TRxGIFAnimator;
    Label27: TLabel;
    procedure Label1Click(Sender: TObject);
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SWBackGroundMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure StarWindowButtonClick(Sender: TObject);
    procedure StarAnimTimerTimer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StarWindow: TStarWindow;
  StarWinBackground:TPicture;
  TempLabel:TLabel; Frame:1..3;

implementation

uses procs;

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
{щелчок мыши на букве }
procedure TStarWindow.Label1Click(Sender: TObject);
var I:byte;
begin
For I:= 22 DownTo 1 Do begin TempLabel.Font.Size:=I; TempLabel.Repaint; end;
TempLabel.Font.Color:=StrToInt(ifthen(CustomColors,Colors.Values['StarWindowLetter'],IntToStr(clRed)));
TempLabel.Font.Size:=18;
//TempLabel.Left:=TempLabel.Left+5; TempLabel.Top:=TempLabel.Top+5;
StarWindow.Tag:=ord((Sender as TLabel).Caption[1]);
StarWindow.HelpKeyword:=StarWindow.HelpKeyword+(Sender as TLabel).Caption[1];
ModalResult:=mrYes;
end;
{---------------------------------------------------------------}
{ наведение курсора мыши на букву }
procedure TStarWindow.Label1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
If (Sender as TLabel)<>TempLabel Then begin;
If TempLabel<>nil Then begin
                           TempLabel.Font.Color:=StrToInt(ifthen(CustomColors,Colors.Values['StarWindowLetter'],IntToStr(clRed)));
//                         TempLabel.Font.Size:=18;
//                         TempLabel.Left:=TempLabel.Left+5; TempLabel.Top:=TempLabel.Top+5;
                       end;
TempLabel:=(Sender as TLabel);
(Sender as TLabel).BringToFront;
(Sender as TLabel).Font.Color:=StrToInt(ifthen(CustomColors,Colors.Values['StarWindowLetterOver'],IntToStr(clPurple)));
TempLabel.Hint:=TempLabel.Caption;
//(Sender as TLabel).Font.Size:=26;
//(Sender as TLabel).Left:=(Sender as TLabel).Left-5;
//(Sender as TLabel).Top:=(Sender as TLabel).Top-5;
                                      end;
end;
{---------------------------------------------------------------}
{ закрытие окна замены звездочки}
procedure TStarWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
TempLabel:=nil;
end;
{---------------------------------------------------------------}
{ курсор мыши вне букв для замены }
procedure TStarWindow.SWBackGroundMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
If TempLabel<>nil Then begin
TempLabel.Left:=TempLabel.Left+5; TempLabel.Top:=TempLabel.Top+5;
TempLabel.Font.Color:=StrToInt(ifthen(CustomColors,Colors.Values['StarWindowLetter'],IntToStr(clRed)));
TempLabel.Font.Size:=18; TempLabel:=nil;
                       end;
end;
{---------------------------------------------------------------}
{ показ окна замены звездочки }
procedure TStarWindow.FormShow(Sender: TObject);
begin
TempLabel:=TLabel.Create(Self);
end;
{---------------------------------------------------------------}
{ щелчок на кнопке "Отмена" }
procedure TStarWindow.StarWindowButtonClick(Sender: TObject);
begin
ModalResult:=mrNo;
end;
{---------------------------------------------------------------}
{ анимация кнопочки }
procedure TStarWindow.StarAnimTimerTimer(Sender: TObject);
begin
end;
{---------------------------------------------------------------}
{ жмуем клавиши на клавиатуре }
procedure TStarWindow.FormKeyPress(Sender: TObject; var Key: Char);
begin
If key=#27 Then StarWindowButtonClick(Sender);
end;

procedure TStarWindow.FormPaint(Sender: TObject);
begin
StarWindow.Canvas.Draw(0,0,StarWinBackground.Graphic);
end;

procedure TStarWindow.FormCreate(Sender: TObject);
var I:byte; Valuelabel:TRXLabel;
begin
try
LoadSkinnedGIF(StarWindow.ButtonClose.Image,'ANIMATIO\Z_button');
except end;
For I:=0 to (Sender as TForm).ControlCount-1 Do begin
   If ((sender as TForm).Controls[i] is TLabel)  Then begin
                      ((sender as TForm).Controls[i] as TLabel).Font.Name:=FontNames[ttfMess];
                      ((sender as TForm).Controls[i] as TLabel).Font.Color:=StrToInt(ifthen(CustomColors,Colors.Values['StarWindowLetter'],IntToStr(clRed)));
                                                      end;
                                                end;
For I:=0 to 31 Do
  If I<AlphCount Then begin (StarWindow.FindComponent('Label'+IntToStr(I+1)) as TLabel).Caption:=chr(LettersCodes[I]);
                            (StarWindow.FindComponent('Label'+IntToStr(I+1)) as TLabel).Font.Name:=FontNames[ttfMess];
                            (StarWindow.FindComponent('Label'+IntToStr(I+1)) as TLabel).Font.Charset:=SetCharset(LanguageDict);
                            (StarWindow.FindComponent('Label'+IntToStr(I+1)) as TLabel).Parent:=StarWindow;
                            If StarWindow.FindComponent('VLabel'+IntToStr(I))=nil Then begin
                                ValueLabel:=TRXLabel.Create(StarWindow);
                                                                                       end
                                                                                   Else
                                ValueLabel:=(StarWindow.FindComponent('VLabel'+IntToStr(I)) as tRXLabel);
                            ValueLabel.Parent:=StarWindow;
                            ValueLabel.Font.Name:='Arial'; ValueLabel.Font.Color:=StrToInt(ifthen(CustomColors,Colors.Values['StarWindowLetterValue'],IntToStr(clNavy)));
                            ValueLabel.Font.Size:=8; ValueLabel.Transparent:=true; ValueLabel.Font.Style:=[fsBold];
                            ValueLabel.Left:=(StarWindow.FindComponent('Label'+IntToStr(I+1)) as TLabel).BoundsRect.Right-4;
                            ValueLabel.Top:=(StarWindow.FindComponent('Label'+IntToStr(I+1)) as TLabel).BoundsRect.Bottom-16;
                            ValueLabel.Caption:=IntToStr(LettersValue[I]);
                            ValueLabel.Name:='VLabel'+IntToStr(I);
                        end
                 Else begin (StarWindow.FindComponent('Label'+IntToStr(I+1)) as TLabel).Parent:=nil;
                            If StarWindow.FindComponent('VLabel'+IntToStr(I))<>nil Then
                               (StarWindow.FindComponent('VLabel'+IntToStr(I)) as TRXLabel).Parent:=nil;
                        end;
end;

end.
