{v 1.6.x}
unit hallfm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Animate, DualList, RXCtrls, Procs, ErrorMes, GIFCtrl,StrUtils,
  TntStdCtrls;

type
  THallFame = class(TForm)
    LeaderImage: TImage;
    LeaderName: TRxLabel;
    Star1: TAnimatedImage;
    Star2: TAnimatedImage;
    Star3: TAnimatedImage;
    Star4: TAnimatedImage;
    Star5: TAnimatedImage;
    Star6: TAnimatedImage;
    Star7: TAnimatedImage;
    Star8: TAnimatedImage;
    Star20: TAnimatedImage;
    Star10: TAnimatedImage;
    Star11: TAnimatedImage;
    Star12: TAnimatedImage;
    Star13: TAnimatedImage;
    Star14: TAnimatedImage;
    Star15: TAnimatedImage;
    Star16: TAnimatedImage;
    Star17: TAnimatedImage;
    Star18: TAnimatedImage;
    Star19: TAnimatedImage;
    Star21: TAnimatedImage;
    Star22: TAnimatedImage;
    Star23: TAnimatedImage;
    Star24: TAnimatedImage;
    Star25: TAnimatedImage;
    HallList: TRxLabel;
    HallNumber: TRxLabel;
    HallPoints: TRxLabel;
    LabelNoWinner: TTntLabel;
    SelectBar: TShape;
    AnimTimer2: TTimer;
    ButtonOK: TRxGIFAnimator;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HallFame: THallFame;
  HallFameWinBackground:TPicture;

implementation

uses PlImages;

var
  StarFlash:TBitmap;
  LeaderAnim:TRXGifAnimator;

{$R *.DFM}
{---------------------------------------------------------------}
{ ÓÚÍ˚ÚËÂ ÓÍÌ‡ "À”◊ÿ»≈ –≈«”À‹“¿“€" }
procedure THallFame.FormActivate(Sender: TObject);
var I:byte; pref:string[1];
begin
If not Shadow_Form.Visible Then begin
   Shadow_Form.Left:=HallFame.Left+7; Shadow_Form.Top:=HallFame.Top+7;
   Shadow_Form.Width:=HallFame.Width; Shadow_Form.Height:=HallFame.Height;
   Shadow_Form.Show; HallFame.BringToFront;
                                end;
AnimTimer2.Enabled:=True;
If HallFame.Tag>1 Then begin
   SelectBar.Top:=240+(Tag-2)*24;
   SelectBar.Visible:=True;
                       end;
HallList.Caption:=''; HallPoints.Caption:=''; HallNumber.Caption:='';
{ Á‡ÔÓÎÌˇÂÏ ÒÔËÒÓÍ }
LeaderImage.Picture:=nil;
If HallFameArray[1].Points<>'0' Then begin
    LabelNoWinner.Hide;
    pref:='';
    if HallFameArray[1].Code[1]<>'' Then pref:=HallFameArray[1].Code[1];
     LeaderName.Caption:=HallFameArray[1].Name+chr(13)+pref+HallFameArray[1].Points;
     If HallFameArray[1].Name=' ŒÃœ‹ﬁ“≈–' Then
        LeaderImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent('pc0') as TImage).Picture)
                                       Else
     For i:=0 to 19 Do
     if HallFameArray[1].Name=Members[I].Name Then begin
        try
        If RightStr(Members[I].Image,1)<>'A' Then LeaderImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent(Members[I].Image) as TImage).Picture)
                                             Else begin
                                If LeaderAnim=nil Then begin
                                  LeaderAnim:=TRXGifAnimator.Create(HallFame);
                                  LeaderAnim.Parent:=HallFame; LeaderAnim.AutoSize:=false;
                                  LeaderAnim.Width:=99; LeaderAnim.Height:=110;
                                  LeaderAnim.Left:=120; LeaderAnim.Top:=27; LeaderAnim.Center:=true;
                                  LeaderAnim.Image.Assign((ImageScreen.ScrollBox1.FindComponent(Members[I].Image) as TRXGIFAnimator).Image);
                                  LeaderAnim.Transparent:=true;
                                  LeaderAnim.Loop:=true; LeaderAnim.Animate:=true;
                                                        end;
                                                  end
         except  LeaderImage.Picture.Assign((ImageScreen.ScrollBox1.FindComponent('Im0') as TImage).Picture);
         end;
        break
                                                   end;

                                    end
                                Else LabelNoWinner.Show;
I:=2;
While (HallFameArray[I].Points<>'0') and (I<8)  Do begin
        if HallFameArray[I].Code[1]<>'' Then pref:=HallFameArray[I].Code[1] Else pref:='';
        HallList.Caption:=HallList.Caption+HallFameArray[I].Name+chr(13);
        HallPoints.Caption:=HallPoints.Caption+pref+HallFameArray[I].Points+chr(13);
        HallNumber.Caption:=HallNumber.Caption+IntToStr(I)+chr(13);
        inc(I);
                     end;                                                 

end;
{---------------------------------------------------------------}
{ Á‡Í˚ÚËÂ ÓÍÌ‡ "À”◊ÿ»≈ –≈«”À‹“¿“€" }
procedure THallFame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
SelectBar.Visible:=False;
StarFlash.Free;
AnimTimer2.Enabled:=False;
Tag:=0;
end;

procedure THallFame.FormPaint(Sender: TObject);
begin
HallFame.Canvas.Draw(0,0,HallFameWinBackground.Graphic);
end;

procedure THallFame.ButtonOKClick(Sender: TObject);
begin
If LeaderAnim<>nil Then begin LeaderAnim.Free; LeaderAnim:=nil; end;
ModalResult:=mrOk;
end;

procedure THallFame.FormKeyPress(Sender: TObject; var Key: Char);
begin
If key=#27 Then ButtonOKClick(Sender);
If key=#13 Then ButtonOKClick(Sender);

end;

procedure THallFame.Timer1Timer(Sender: TObject);
begin
If HallFame.Tag>1 Then SelectBar.Visible:=not SelectBar.Visible;
end;

procedure THallFame.FormShow(Sender: TObject);
begin
StarFlash:=TBitmap.Create;
StarFlash.LoadFromFile('GRAFIX\classic\starflsh.bmp');
Star1.Glyph:=StarFlash; Star1.NumGlyphs:=45;
Star2.Glyph:=StarFlash; Star2.NumGlyphs:=150;
Star3.Glyph:=StarFlash; Star3.NumGlyphs:=100;
Star4.Glyph:=StarFlash; Star4.NumGlyphs:=60;
Star5.Glyph:=StarFlash; Star5.NumGlyphs:=120;
Star6.Glyph:=StarFlash; Star6.NumGlyphs:=80;
Star7.Glyph:=StarFlash; Star7.NumGlyphs:=150;
Star8.Glyph:=StarFlash; Star8.NumGlyphs:=90;
Star10.Glyph:=StarFlash; Star10.NumGlyphs:=50;
Star11.Glyph:=StarFlash; Star11.NumGlyphs:=110;
Star12.Glyph:=StarFlash; Star12.NumGlyphs:=70;
Star13.Glyph:=StarFlash; Star13.NumGlyphs:=47;
Star14.Glyph:=StarFlash; Star14.NumGlyphs:=100;
Star15.Glyph:=StarFlash; Star15.NumGlyphs:=140;
Star16.Glyph:=StarFlash; Star16.NumGlyphs:=60;
Star17.Glyph:=StarFlash; Star17.NumGlyphs:=90;
Star18.Glyph:=StarFlash; Star18.NumGlyphs:=145;
Star19.Glyph:=StarFlash; Star19.NumGlyphs:=55;
Star20.Glyph:=StarFlash; Star20.NumGlyphs:=80;
Star21.Glyph:=StarFlash; Star21.NumGlyphs:=120;
Star22.Glyph:=StarFlash; Star22.NumGlyphs:=45;
Star23.Glyph:=StarFlash; Star23.NumGlyphs:=60;
Star24.Glyph:=StarFlash; Star24.NumGlyphs:=100;
Star25.Glyph:=StarFlash; Star25.NumGlyphs:=150;
end;

procedure THallFame.FormCreate(Sender: TObject);
var I:byte;
begin
LoadSkinnedGIF(ButtonOK.Image, 'ANIMATIO\S_Button');
     For I:=0 to (Sender as TForm).ControlCount-1 Do begin
        If ((sender as TForm).Controls[i] is TRXLabel) Then ((sender as TForm).Controls[i] as TRXLabel).Font.Name:=FontNames[ttfPlayer];
        If ((sender as TForm).Controls[i] is TTNTLabel)  Then ((sender as TForm).Controls[i] as TTNTLabel).Font.Name:=FontNames[ttfPlayer];
                                                     end;
If CustomColors Then begin
 LabelNoWinner.Font.Color:=StrToInt(Colors.Values['HallFameText']);
 LeaderName.Font.Color:=StrToInt(Colors.Values['HallFameText']);
 HallList.Font.Color:=StrToInt(Colors.Values['HallFameText']);
 HallPoints.Font.Color:=StrToInt(Colors.Values['HallFamePoints']);
 SelectBar.Brush.Color:=StrToInt(Colors.Values['HallFameHighlight']);
                     end;
end;

end.
