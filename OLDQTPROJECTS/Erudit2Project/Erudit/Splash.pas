{v 1.6.x}
unit Splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Procs, MMSystem, MPlayer, StdCtrls;

type
  TSplashScreen = class(TForm)
    Image1: TImage;
    Bevel1: TBevel;
    Shape1: TShape;
    LoadProgressLabel: TLabel;
    Shape2: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SplashScreen: TSplashScreen;


implementation

uses Main;

{$R *.DFM}

procedure TSplashScreen.FormCreate(Sender: TObject);
var hsWindowRegion:Integer; 
begin
  Image1.Picture.LoadFromFile('GRAFIX\classic\E-Logo.bmp');
  hsWindowRegion:=BitmapToRegion(Image1.Picture.Bitmap,clFuchsia);
  SetWindowRgn(Handle, hsWindowRegion, True);
  if WaveOutGetNumDevs=0 then begin EnableSoundHardware:=False; PlaySounds:=False end
                         Else begin EnableSoundHardware:=True; PlaySounds:=True; end;
  Shape1.Width:=0;
end;



procedure TSplashScreen.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
CanClose:=false;
end;

end.

