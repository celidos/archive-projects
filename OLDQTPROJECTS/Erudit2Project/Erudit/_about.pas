unit _about;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, RxGIF, ShellAPI, Procs;

type
  TAbout = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Scarlett_logo: TImage;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Scarlett_logoClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  About: TAbout;
  Background:TBitmap;

implementation

uses Main;

{$R *.DFM}

procedure TAbout.Button1Click(Sender: TObject);
begin
ModalResult:=mrYes;
end;

procedure TAbout.FormCreate(Sender: TObject);
var hsWindowRegion:Integer;
begin
  Background:=TBitmap.Create;
  Background.LoadFromFile('grafix\classic\about.bmp');
  hsWindowRegion:=BitmapToRegion(Background,clFuchsia);
  SetWindowRgn(Handle, hsWindowRegion, True);
end;

procedure TAbout.FormPaint(Sender: TObject);
begin
About.Canvas.Draw(0,0,Background);
end;

procedure TAbout.Scarlett_logoClick(Sender: TObject);
begin
ShellExecute(0, nil,'http://www.scarlett.ru',nil,nil,1);
end;

procedure TAbout.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
If Sender = Scarlett_logo Then Screen.Cursor:=crHandPoint Else Screen.Cursor:=crDefault;
end;

procedure TAbout.FormActivate(Sender: TObject);
begin
  If MainScreen.MenuBgr.Visible Then begin
  MainScreen.MenuBgr.Hide;
  DrawShadows(MainScreen.MenuBgr,MainScreen.MenuBgr.Left-4,MainScreen.MenuBgr.Top+4,512,False);
  DrawShadows(MainScreen.MenuBgr,MainScreen.MenuBgr.Left-3,MainScreen.MenuBgr.Top+3,256,False);

                                     end;
end;

procedure TAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If MainScreen.MenuButton1.Visible Then begin
                                           MainScreen.MenuBgr.Show;
             DrawShadows(MainScreen.MenuBgr,MainScreen.MenuBgr.Left-3,MainScreen.MenuBgr.Top+3,256,True);
             DrawShadows(MainScreen.MenuBgr,MainScreen.MenuBgr.Left-4,MainScreen.MenuBgr.Top+4,512,True);
                                         end;
end;

end.
