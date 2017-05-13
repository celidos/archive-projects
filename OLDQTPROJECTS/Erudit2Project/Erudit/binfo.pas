unit binfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TBonusInfo = class(TForm)
    procedure FormActivate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BonusInfo: TBonusInfo;

implementation

uses Main, procs;
var background:TPicture;

{$R *.DFM}

procedure TBonusInfo.FormActivate(Sender: TObject);
begin
SendMessage(Application.MainForm.Handle, WM_NCACTIVATE, 1,0);
if Sender<>BonusInfo Then exit;
Background:=TPicture.Create;
LoadSkinnedImage(Background,'bonuswin');
end;

procedure TBonusInfo.FormPaint(Sender: TObject);
begin
BonusInfo.Canvas.Draw(0,0,Background.Graphic);
end;

procedure TBonusInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Background.Free;
end;

end.

