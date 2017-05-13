unit Errormes;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Menus, Animate, GIFCtrl;

type
  TErrorWindow = class(TForm)
    ButtonYes: TRxGIFAnimator;
    ButtonNo: TRxGIFAnimator;
    RestoreTimer: TTimer;
    procedure ErrWinButtonClick(Sender: TObject);
    procedure ButtonYesClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ErrorWindow: TErrorWindow;
  ErrorWinBackground:TPicture;
  QuestWinBackground:TPicture;


implementation

uses procs;


{$R *.DFM}
{---------------------------------------------------------------}
{ жмуем кнопочку в окне }
procedure TErrorWindow.ErrWinButtonClick(Sender: TObject);
begin
ModalResult:=mrNo;
end;
{---------------------------------------------------------------}
{ жмуем V-кнопочку в окне }
procedure TErrorWindow.ButtonYesClick(Sender: TObject);
begin
ModalResult:=mrYes;
end;
{---------------------------------------------------------------}
{ форма становится активной }
procedure TErrorWindow.FormActivate(Sender: TObject);
begin
case ErrorWindow.Tag of
1:begin
  ButtonYes.Image:=nil;
  LoadSkinnedGIF(ButtonNo.Image,'ANIMATIO\E_Button');
  end;
2:begin
  LoadSkinnedGIF(ButtonYes.Image,'ANIMATIO\V_Button');
  LoadSkinnedGIF(ButtonNo.Image,'ANIMATIO\X_Button');
  end;
666:begin
          RestoreTimer.Tag:=0; RestoreTimer.Enabled:=true;  ErrorWindow.Visible:=false;
          ErrorWindow.Tag:=667; ErrorWindow.Deactivate;
 end;
667: begin
       ErrorWindow.ModalResult:=mrNo;
     end;
end;

end;
{---------------------------------------------------------------}
{ Выход по Esc }
procedure TErrorWindow.FormKeyPress(Sender: TObject; var Key: Char);
begin
If key=#27 Then ErrWinButtonClick(Sender);
If (key=#13) and (Tag=2) Then ButtonYesClick(Sender);
end;

procedure TErrorWindow.FormPaint(Sender: TObject);
begin
case ErrorWindow.Tag of
1: ErrorWindow.Canvas.Draw(0,0,ErrorWinBackground.Graphic);
2: ErrorWindow.Canvas.Draw(0,0,QuestWinBackground.Graphic);
end;

end;

procedure TErrorWindow.FormCreate(Sender: TObject);
var I:byte;
begin
{  If win32Platform<>ver_platform_win32_nt Then begin
     For I:=0 to (Sender as TForm).ControlCount-1 Do begin
        If ((sender as TForm).Controls[i] is TLabel)  Then      ((sender as TForm).Controls[i] as TLabel).Font.Charset:=DEFAULT_CHARSET;
                                                     end;
                                               end;}
end;

procedure TErrorWindow.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
(ErrorWindow.FindComponent('MessageLabel') as TComponent).Free;
end;

end.
