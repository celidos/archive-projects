unit dict;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  DictFile1,DictFile2,DictFile3:text;
  Dict1,Dict2:array[1..8000] of string[30];
  i,j:word; flag:boolean;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
AssignFile(DictFile1,'c:\work\backup\erudit\dict\diction.32');
AssignFile(DictFile2,'c:\work\backup\erudit\dict\ќбщеупотр\diction.32');
AssignFile(DictFile3,'c:\work\backup\erudit\dict\ќбщеупотр\dict.032');
Reset(DictFile1);
Reset(DictFile2);
i:=1;
While not EOF(DictFile1) Do begin readln(DictFile1,Dict1[i]); inc(i)end;
i:=1;
While not EOF(DictFile2) Do begin readln(DictFile2,Dict2[i]); inc(i)end;
closefile(DictFile1);
closefile(DictFile2);
Rewrite(DictFile3);

j:=1;
While Dict2[j]<>'' Do begin
      i:=1;
      While Dict1[i]<>'' Do begin
       if copy(Dict2[j],1,pos('=',Dict2[j])-1)=copy(Dict1[i],1,length(copy(Dict2[j],1,pos('=',Dict2[j])-1)))
         Then begin
            if pos('=',Dict1[i])<>0 then
              if pos('О',copy(Dict1[i],pos('=',Dict1[i]),10))=0 Then
                 begin Dict1[i]:=Dict1[i]+'О';
                       inc(i); break end
                                                                Else break

                                    Else
                 begin Dict1[i]:=Dict1[i]+'=О';
                       inc(i); break; end


               end;
       inc(i);
                            end;
inc(j);
                       end;

i:=1; While Dict1[i]<>'' Do
        begin
            if pos('=',Dict1[i])<>0 then
              if pos('О',copy(Dict1[i],pos('=',Dict1[i]),10))<>0 Then begin
                flag:=false;
                j:=1; While Dict2[j]<>'' Do begin
                      if copy(Dict2[j],1,pos('=',Dict2[j])-1)=copy(Dict1[i],1,pos('=',Dict1[i])-1)
                         Then begin flag:=true; break; end;
                      inc(j);
                                            end;
            If not flag Then Dict1[i]:=copy(Dict1[i],1,pos('=',Dict1[i])-1);
                                                                      end;
        inc(i);
          end;
i:=1; While Dict1[i]<>'' Do begin writeln(DictFile3,Dict1[i]); inc(i) end;
closefile(DictFile3);
end;

end.
