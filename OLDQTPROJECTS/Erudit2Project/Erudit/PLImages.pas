{v 1.6.x}
unit PLImages;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Animate, GIFCtrl, StdCtrls, ComCtrls, ShellCtrls, procs, Jpeg, pngimage98,
  TntStdCtrls, StrUtils;

type
  TImageScreen = class(TForm)
    LabelChooseAvatar: TTntLabel;
    ButtonCancel: TRxGIFAnimator;
    Shape1: TShape;
    ScrollBox1: TScrollBox;
    Shape2: TShape;
    Shape3: TShape;
    procedure Image1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private                                                                 
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImageScreen: TImageScreen;
  Shadow:TShape; Border:TShape;
  PlayerIm:TImage; PlayerImAnim:TRXGIFAnimator;
implementation

{$R *.DFM}

procedure TImageScreen.Image1Click(Sender: TObject);
begin
ImageScreen.Hint:=(Sender as TControl).Name;
ImageScreen.ModalResult:=mrOk;
end;

procedure TImageScreen.FormKeyPress(Sender: TObject; var Key: Char);
begin
If key=#27 Then begin
                ImageScreen.ModalResult:=mrNo;
                end;;
end;

procedure TImageScreen.FormCreate(Sender: TObject);
var F,D:TSearchRec; I,J:word; Path:string; FoundFile:file;
begin
LoadSkinnedGIF(ButtonCancel.Image,'ANIMATIO\S_Button');
ImageScreen.Color:=StrToInt(ifthen(CustomColors,Colors.Values['NewGameSelectPlayerWindow'],IntToStr($00EDA87E)));
Shape2.brush.Color:=StrToInt(ifthen(CustomColors,Colors.Values['NewGameSelectPlayerWindowCap'],IntToStr($00FF5151)));
Shape3.brush.Color:=StrToInt(ifthen(CustomColors,Colors.Values['NewGameSelectPlayerWindowBorder'],IntToStr($00FF8080)));
LabelChooseAvatar.Font.Color:=StrToInt(ifthen(CustomColors,Colors.Values['NewGameSelectPlayerWindowtext'],IntToStr(clWhite)));

I:=0; J:=0;
path:='';
FindFirst('GRAFIX\PLAYERS\*',faDirectory, D);
repeat
if (d.Name='.') Then continue;
if d.Name='..' Then Path:='' Else
    If not (D.attr and faDirectory=0) Then path:='\'+D.Name Else continue;
if FindFirst('GRAFIX\PLAYERS'+Path+'\*.*',0, F)=0 Then
   repeat
     If (pos('.bmp',F.name)=0) and (pos('.jpg',F.name)=0) and(pos('.png',F.name)=0) and (pos('.gif',F.name)=0)
         Then else begin
     Shadow:=TShape.Create(ScrollBox1);
     Shadow.Parent:=ScrollBox1;
     Border:=TShape.Create(ScrollBox1);
     Border.Parent:=ScrollBox1;
     Shadow.Width:=110; Shadow.Height:=110;
     Border.Width:=115; Border.Height:=115;
     Shadow.Brush.Color:=StrToInt(ifthen(CustomColors,Colors.Values['NewGameSelectPlayerShadow'],IntToStr($00B3531A)));
     Shadow.Pen.Style:=psClear;
     Border.Brush.Color:=StrToInt(ifthen(CustomColors,Colors.Values['NewGameSelectPlayerBgr'],IntToStr(clBlue)));
     Border.Pen.Color:=StrToInt(ifthen(CustomColors,Colors.Values['NewGameSelectPlayerBorder'],IntToStr($002FB1C4)));
     Border.Pen.Style:=psSolid;
     If (pos('.bmp',F.name)<>0) or (pos('.jpg',F.name)<>0) or (pos('.png',F.name)<>0) Then begin
        PlayerIm:=TImage.Create(ScrollBox1);
        PlayerIm.Parent:=ScrollBox1;
        PlayerIm.Width:=110; PlayerIm.Height:=110;
        PlayerIm.Left:=8+120*I;
        PlayerIm.Top:=8+125*J;
        Shadow.Left:=PlayerIm.Left-5; Shadow.Top:=PlayerIm.Top+7;
        Border.Left:=PlayerIm.Left-2; Border.Top:=PlayerIm.Top-2;
        PlayerIm.Center:=true;
        PlayerIm.Picture.LoadFromFile('GRAFIX\PLAYERS\'+Path+'\'+F.Name);
        If F.FindData.cAlternateFileName[0]=#0 Then
           //PlayerIm.Hint:=PlayerIm.Hint+copy(F.Name,1,pos('.bmp',lowercase(F.Name))-1)
             PlayerIm.Hint:=F.Name
                                                 Else
           //PlayerIm.Hint:=copy(F.FindData.cAlternateFileName,1,pos('.bmp',lowercase(F.FindData.cAlternateFileName))-1);
             PlayerIm.Hint:=F.FindData.cAlternateFileName;
        PlayerIm.ShowHint:=true;
        PlayerIm.Cursor:=crHandPoint;
        PlayerIm.OnClick:=Image1Click;
        PlayerIm.Name:='Im'+IntToStr(J*10+I);
        If ANSILowerCase(F.name)='pc1.bmp' then PlayerIm.Name:='pc0';
                               end;
     If (pos('.gif',F.name)<>0) Then begin
        PlayerImAnim:=TRXGifAnimator.Create(ScrollBox1);
        PlayerImAnim.Parent:=ScrollBox1; PlayerImAnim.AutoSize:=false;
        PlayerImAnim.Width:=110; PlayerImAnim.Height:=110;
        PlayerImAnim.Left:=8+120*I; PlayerImAnim.Top:=8+125*J;
        Shadow.Left:=PlayerImAnim.Left-5; Shadow.Top:=PlayerImAnim.Top+7;
        Border.Left:=PlayerImAnim.Left-2; Border.Top:=PlayerImAnim.Top-2;
        PlayerImAnim.Center:=true;
        PlayerImAnim.Image.LoadFromFile('GRAFIX\PLAYERS\'+Path+'\'+F.Name);
        If F.FindData.cAlternateFileName[0]=#0 Then
           //PlayerIm.Hint:=PlayerIm.Hint+copy(F.Name,1,pos('.bmp',lowercase(F.Name))-1)
             PlayerImAnim.Hint:=F.Name
                                                 Else
           //PlayerIm.Hint:=copy(F.FindData.cAlternateFileName,1,pos('.bmp',lowercase(F.FindData.cAlternateFileName))-1);
             PlayerImAnim.Hint:=F.FindData.cAlternateFileName;
        PlayerImAnim.ShowHint:=true;
        PlayerImAnim.Cursor:=crHandPoint;
        PlayerImAnim.OnClick:=Image1Click;
        PlayerImAnim.Loop:=true; PlayerImAnim.Animate:=true;
        PlayerImAnim.Name:='Im'+IntToStr(J*10+I)+'A';
                               end;
     inc(I); If I>2 Then begin I:=0; inc(J); end;
                    end;
   until FindNext(F)<>0;
   //path:='\'+D.Name;
 until (FindNext(D)<>0)  and ((Path='\'+D.Name) or (D.attr and faDirectory=0));
 FindClose(F);  FindClose(D);
end;

procedure TImageScreen.ButtonCancelClick(Sender: TObject);
begin
ImageScreen.ModalResult:=mrNo;
end;

procedure TImageScreen.FormShow(Sender: TObject);
var I:word;
begin
For I:=0 to ScrollBox1.ControlCount-1 Do ScrollBox1.Controls[i].Repaint;
end;

end.

