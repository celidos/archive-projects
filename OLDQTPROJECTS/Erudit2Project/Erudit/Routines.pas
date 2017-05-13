{v 1.6.x}
Unit Routines;


INTERFACE
Uses
SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls, RXGif, GIFCtrl,
Forms, Dialogs, ExtCtrls, Menus, StdCtrls, Procs, VirtOpp, bass, strWnd, Math, StrUtils;


{ проверка новых слов игрока }
Procedure CheckPlayersWord(Pl:byte; var FinishGame:boolean);
{ процесс замены букв }
Procedure ChangeLetters(Opp:byte; var FinishGame:boolean);


IMPLEMENTATION
{---------------------------------------------------------------}
{ анализ слов игрока }  { TODO : CheckPlayerWord }
Procedure CheckPlayersWord(Pl:byte;var FinishGame:boolean);
const Horiz=1; Vert=2;
var MasX,MasY:byte; WBegin,WEnd:byte; FirstLetter:char;
    W,E,C,D:byte;
    DictWord:string[35]; FindInDict:boolean; FindWord,FullSet:boolean;
    FindTheme:boolean; ThemeMark:string[20];
    I,J,K:word; Message,Message1:String; MessX,MessY:word;
    NotLinkedWordsPresent:boolean; StepFlag:boolean;
    NotLinkedWord:string[15];
    NotLinkedWB,NotLinkedWE,NotLinkedDir,NotLinkedCoord:byte;
    RPW, AddWordNow:boolean;
    CurrentColorState:array[1..30,1..30] of byte;
    NewWords:array[1..15] of record
			     Word:ShortString;
			     Coord,WBegin,Wend:byte;
			     Direction:byte;
			       end;
    WordPoints:word; NoShapes:boolean; SelNum:byte; NoHotspots:boolean;
    TempStrList:TStrings;
begin
  FindWord:=False;
 If (Words[1,1].Word='') and (Words[1,2].Word='') and (Words[1,3].Word='') and (Words[1,4].Word='')
 and  (Words[1,5].Word='') and (Words[1,6].Word='') and (Words[1,7].Word='') and (Words[1,8].Word='') Then
     FirstWord:=True Else FirstWord:=False;
  For I:=1 To 15 Do NewWords[I].Word:='';
  For I:=1 To 3 Do begin Stars[I,1]:=0; Stars[I,2]:=0; end;
  { замоминаем расположение звездочек  и помечаем все хот-споты дл€ проверки пересек. слов }
  I:=1; For MasX:=1 To WorkFieldDimentionX Do For MasY:=1 To WorkFieldDimentionY Do begin
        If WorkField[MasX,MasY].HotSpot=chr(FirstAlphCode+AlphCount) Then begin
                                        WorkField[MasX,MasY].HotSpot:='*';
                                        Stars[I,1]:=MasX; Stars[I,2]:=MasY;
                                        inc(I);
                                                   end;
        If (WorkField[MasX,MasY].HotSpot<>' ') and (WorkField[MasX,MasY].Image=-1) Then
                                        WorkField[MasX,MasY].hotspot:=' ';
        If (WorkField[MasX,MasY].HotSpot<>' ') and (WorkField[MasX,MasY].main=' ') Then begin
                                        WorkField[MasX,MasY].Checked:=True;
                                                   end;
                                            end;
  NoShapes:=true; setlength(SelectedWords,0);
  { запоминаем выделенные слова }
  If Length(SelectShapes)>0 Then
    for I:=0 To length(SelectShapes)-1 do
      If SelectShapes[I]<>nil Then
       If SelectShapes[I].Visible Then begin
                                        NoHotSpots:=true;
                                        SelectShapes[I].Hint:='';
                                        setlength(SelectedWords,length(SelectedWords)+1);
                                        k:=length(SelectedWords)-1;
                                        SelectedWords[k].Direction:=SelectShapes[I].Tag;
                                        SelectedWords[k].Passed:=false;
                                        SelectedWords[k].Linked:=true;
                                        SelectedWords[k].Tested:=0;
                                        case SelectShapes[I].Tag of
                                          1: begin SelectedWords[k].WBegin:=(SelectShapes[I].BoundsRect.Left+19) div 28;
                                                   SelectedWords[k].WEnd:=(SelectShapes[I].BoundsRect.Right+19) div 28-1;
                                                   SelectedWords[k].Coord:=(SelectShapes[I].BoundsRect.Top+19) div 28;
                                                   For J:=SelectedWords[k].WBegin to SelectedWords[k].WEnd do begin
                                                      If WorkField[J,SelectedWords[k].Coord].HotSpot<>' ' Then begin
                                                         SelectedWords[k].Word:=SelectedWords[k].Word+WorkField[J,SelectedWords[k].Coord].HotSpot;
                                                         If (WorkField[J,SelectedWords[k].Coord].HotSpot='*')
                                                         and (SelectField[J,SelectedWords[k].Coord]=3) Then
                                                             begin SelectedWords[k].Stars[length(SelectedWords[k].Word)].StX:=J; SelectedWords[k].Stars[length(SelectedWords[k].Word)].StY:=SelectedWords[k].Coord;  end
                                                                                                               end
                                                                                                          Else
                                                         SelectedWords[k].Word:=SelectedWords[k].Word+WorkField[J,SelectedWords[k].Coord].main;
                                                      If WorkField[J,SelectedWords[k].Coord].main=' ' Then NoHotSpots:=false;
                                                                                                              end
                                              end;
                                          2: begin SelectedWords[k].WBegin:=(SelectShapes[I].BoundsRect.Top+19) div 28;
                                                   SelectedWords[k].WEnd:=(SelectShapes[I].BoundsRect.Bottom+19) div 28-1;
                                                   SelectedWords[k].Coord:=(SelectShapes[I].BoundsRect.Left+19) div 28;
                                                   For J:=SelectedWords[k].WBegin to SelectedWords[k].WEnd do begin
                                                      If WorkField[SelectedWords[k].Coord,J].HotSpot<>' ' Then begin
                                                         SelectedWords[k].Word:=SelectedWords[k].Word+WorkField[SelectedWords[k].Coord,J].HotSpot;
                                                         If (WorkField[SelectedWords[k].Coord,J].HotSpot='*')
                                                         and (SelectField[SelectedWords[k].Coord,J]=3) Then
                                                             begin SelectedWords[k].Stars[length(SelectedWords[k].Word)].StX:=SelectedWords[k].Coord; SelectedWords[k].Stars[length(SelectedWords[k].Word)].StY:=J;  end
                                                                                                               end
                                                                                                          Else
                                                         SelectedWords[k].Word:=SelectedWords[k].Word+WorkField[SelectedWords[k].Coord,J].main;
                                                      If WorkField[SelectedWords[k].Coord,J].main=' ' Then NoHotSpots:=false;
                                                                                                          end;
                                              end;
                                        end;
      If NoHotSpots Then begin setlength(SelectedWords,length(SelectedWords)-1);
                           end Else NoShapes:=false;
                                      end;

  { начинаем крутить цикл пока не найдем все пересекающиес€ слова }
  repeat
  NotLinkedWordsPresent:=False; StepFlag:=false;
  NewWord:=''; WBegin:=1; WEnd:=1;
  If not noShapes Then For I:=0 to length(SelectedWords)-1 Do If not SelectedWords[I].Linked Then SelectedWords[I].Linked:=true;
  MasY:=1; While MasY<= WorkFieldDimentionY Do begin
    MasX:=1; While MasX<=WorkFieldDimentionX Do begin
    RPW:=False;
        If ((WorkField[MasX,MasY].HotSpot<>' ') and (WorkField[MasX,MasY].main=' ')
        {and WorkField[MasX,MasY].Checked} and (SelectField[MasX,MasY]=0))
        or not noShapes Then
      begin
        try
       	NewWord:=LocateNewWord(MasX,MasY,Horiz,WBegin,WEnd,Flag3,noShapes,SelNum);
        except end;

       	If NewWord='' Then begin inc(MasX); continue end
                      Else FindWord:=True;
        If not noShapes Then
            begin MasX:=SelectedWords[SelNum].WBegin; MasY:=SelectedWords[SelNum].Coord;
                  If SelectedWords[SelNum].Tested=20 Then begin
                    MasY:=WorkFieldDimentionY+1;
                    NotLinkedWordsPresent:=true; StepFlag:=false; break; end;
              end;

         { проверка наличи€ на поле  звездочек }
	 If Not CheckStarPresent(WBegin,WEnd,MasY,Horiz,SelNum,noShapes) Then begin
            RestoreStars;                                                                   
            Exit;
                                                              end
                                                          Else If not noShapes Then begin
                                                                If pos('*',SelectedWords[SelNum].Word)>0 Then
                                                                   For I:=1 to length(StarWindow.HelpKeyword) do
                                                                     SelectedWords[SelNum].Word[pos('*',SelectedWords[SelNum].Word)]:=string(StarWindow.HelpKeyword[i])[1];
                                                                     //SelectedWords[SelNum].Word[pos('*',SelectedWords[SelNum].Word)]:=ConvString(StarWindow.HelpKeyword[i],ASCII)[1];
                                                                NewWord:=SelectedWords[SelNum].Word;
                                                                                    end;

         { проверка на одну букву }
         If length(NewWord)=1 Then begin
	    If MasX>WorkFieldDimentionX div 2 Then MessX:=Application.MainForm.Left+(MasX+1)*28-325 Else MessX:=Application.MainForm.Left+MasX*28-7;
            If MasY>WorkFieldDimentionY div 2 Then MessY:=Application.MainForm.Top+MasY*28-142+47 Else MessY:=Application.MainForm.Top+MasY*28+70;
            FlashWord(On_m,WBegin,WEnd,MasY,Horiz);
            If PlaySounds Then BASS_SamplePlay(ErrorSound);
            Announce(MessX,MessY,GlobalTextStrings.Items.Values['InGameMessageGoNolessOneLetter']);
            FlashWord(Off_m,WBegin,WEnd,MasY,Horiz);
            RestoreStars;
            Exit;
                                   end;

         { проверка на наличие слова в словаре }
         FirstLetter:=NewWord[1]; FindInDict:=False; FindTheme:=False;
         If (FirstLetter='*') Then continue;
           try
         TempStrList:=DictArray[GetLetterNum(FirstLetter)+1];
         If tempStrList<>nil Then
          If tempStrList.Count>0 Then
             If (TempStrList.IndexOfName(NewWord)<>-1)
             or (TempStrList.IndexOf(NewWord)<>-1) Then begin FindInDict:=True; end;
           except
                  FindInDict:=false;
              end;


        { проверка на наличие слова в пользовательском словаре }
	    If MasX>WorkFieldDimentionX div 2 Then MessX:=Application.MainForm.Left+(MasX+1)*28-325 Else MessX:=Application.MainForm.Left+MasX*28-7;
            If MasY>WorkFieldDimentionY div 2 Then MessY:=Application.MainForm.Top+MasY*28-142+47 Else MessY:=Application.MainForm.Top+MasY*28+70;
         If CustomDict.Use Then begin
            FlashWord(On_m,WBegin,WEnd,MasY,Horiz);
            AddWordNow:=CheckCustomDictionary(FindInDict,MessX,MessY);
            FlashWord(Off_m,WBegin,WEnd,MasY,Horiz);
            If not AddWordNow Then Else FindInDict:=True;
                                end;
//       If not CustomDict.Use {or CustomDict.WordRequired} Then
            If Not FindInDict Then begin
            FlashWord(On_m,WBegin,WEnd,MasY,Horiz);
            If PlaySounds Then BASS_SamplePlay(ErrorSound);
            Announce(MessX,MessY,GlobalTextStrings.Items.Values['InGameMessageGoUnknownWord']);
            FlashWord(Off_m,WBegin,WEnd,MasY,Horiz);
            RestoreStars;
            Exit;
                                   end;

        { провер€ем слово на пересечение }
        If Not IsCrossWord(MasY,WBegin,WEnd,FirstWord,Horiz) Then begin
	    If MasX>WorkFieldDimentionX div 2 Then MessX:=Application.MainForm.Left+(MasX+1)*28-325 Else MessX:=Application.MainForm.Left+MasX*28-7;
            If MasY>WorkFieldDimentionY div 2 Then MessY:=Application.MainForm.Top+MasY*28-142+47 Else MessY:=Application.MainForm.Top+MasY*28+70;
          NotLinkedWord:=NewWord; NotLinkedDir:=Horiz; NotLinkedCoord:=MasY;
          NotLinkedWB:=WBegin; NotLinkedWE:=WEnd;
          NotLinkedWordsPresent:=True; MasX:=WEnd+1;
          If not noshapes then SelectedWords[SelNum].Linked:=false;
          Continue;
                                                                end;

         { проверка на ограничение по количеству букв }
         If length(NewWord)<=LimitWordLength Then begin
	    If MasX>WorkFieldDimentionX div 2 Then MessX:=Application.MainForm.Left+(MasX+1)*28-325 Else MessX:=Application.MainForm.Left+MasX*28-7;
            If MasY>WorkFieldDimentionY div 2 Then MessY:=Application.MainForm.Top+MasY*28-142+47 Else MessY:=Application.MainForm.Top+MasY*28+70;
            FlashWord(On_m,WBegin,WEnd,MasY,Horiz);
            If PlaySounds Then BASS_SamplePlay(ErrorSound);
            Announce(MessX,MessY,GlobalTextStrings.Items.Values['InGameMessageGoShortWord']);
            FlashWord(Off_m,WBegin,WEnd,MasY,Horiz);
            RestoreStars;
            Exit;
                                   end;

       { проверка слова на повтор€емость }
       If RepeatedWord(NewWord,W,E,C,D) Then begin
	    If MasX>WorkFieldDimentionX div 2 Then MessX:=Application.MainForm.Left+18+10 Else MessX:=Application.MainForm.BoundsRect.Right-350;
            If MasY>WorkFieldDimentionY div 2 Then MessY:=Application.MainForm.Top+75 Else MessY:=Application.MainForm.BoundsRect.Bottom-160;
            FlashWord(On_m,WBegin,WEnd,MasY,Horiz);
            FlashWord(On_m,W,E,C,D);
            If PlaySounds Then BASS_SamplePlay(ErrorSound);
            Announce(MessX,MessY,GlobalTextStrings.Items.Values['InGameMessageGoRepeatWord']);
            FlashWord(Off_m,WBegin,WEnd,MasY,Horiz);
            FlashWord(Off_m,W,E,C,D);
	  RestoreStars;
          Exit;
                                     end;

       { проверка на выставление двух одинаковых слов }
         For I:=1 To 15 Do
          If NewWord=NewWords[I].Word Then
             If (NewWords[I].WBegin=WBegin) and (NewWords[I].Coord=MasY) and (NewWords[I].Direction=Horiz) Then
             begin  If AllowWordRepeat then break;
                    RPW:=True; break; end
             Else begin
            If AllowWordRepeat Then begin
	    If MasX>WorkFieldDimentionX div 2 Then MessX:=Application.MainForm.Left+18+10 Else MessX:=Application.MainForm.BoundsRect.Right-350;
            If MasY>WorkFieldDimentionY div 2 Then MessY:=Application.MainForm.Top+75 Else MessY:=Application.MainForm.BoundsRect.Bottom-160;
              FlashWord(On_m,WBegin,WEnd,MasY,Horiz);
              FlashWord(On_m,NewWords[I].WBegin,NewWords[I].WEnd,NewWords[I].Coord,NewWords[I].Direction);
              If PlaySounds Then BASS_SamplePlay(ErrorSound);
              Announce(MessX,MessY,GlobalTextStrings.Items.Values['InGameMessageGoTheSameWord']);
              FlashWord(Off_m,NewWords[I].WBegin,NewWords[I].WEnd,NewWords[I].Coord,NewWords[I].Direction);
              FlashWord(Off_m,WBegin,WEnd,MasY,Horiz);
              RestoreStars;
              Exit;
                                     end
                                    {Else break;}
                   end;
          If AllowWordRepeat and (I<16) Then begin MasX:=WEnd+1; continue; end;
          If RPW Then begin RPW:=False; MasX:=WEnd+1; continue; end;

      { запоминание слова }
      For I:=1 To 15 Do
        If (NewWords[I].Word='') Then begin
                          NewWords[I].Word:=NewWord;
                          NewWords[I].Coord:=MasY;
                          NewWords[I].WBegin:=WBegin;
                          NewWords[I].WEnd:=WEnd;
                          NewWords[I].Direction:=Horiz;
                          break;
                                       end;
      For I:=WBegin to WEnd Do begin
             WorkField[I,MasY].checked:=False;
                               end;
      If not noShapes Then begin
       SelectedWords[SelNum].Passed:=true;
        For I:=0 to length(SelectedWords)-1 Do if not SelectedWords[I].Passed Then break;
        If I=length(SelectedWords) Then begin NoShapes:=true; MasX:=1; MasY:=1; StepFlag:=true; NotLinkedWordsPresent:=true; continue end;
                           end;
      StepFlag:=True;
      If noShapes Then MasX:=WEnd+1;
      end Else inc(MasX); end; inc(MasY); end;

  MasX:=1; While MasX<=WorkFieldDimentionX Do begin
    MasY:=1; While MasY<=WorkFieldDimentionY Do begin
    RPW:=False;
    If ((WorkField[MasX,MasY].HotSpot<>' ') and (WorkField[MasX,MasY].main=' ')
       {and WorkField[MasX,MasY].Checked} and (SelectField[MasX,MasY]=0))
       or not noShapes Then
      begin
        try
        NewWord:=LocateNewWord(MasX,MasY,Vertic,WBegin,WEnd,Flag3,NoShapes,SelNum);
        except end;
        If NewWord='' Then begin inc(MasY); continue end
                      Else FindWord:=True;
        If not noShapes Then begin
                MasY:=SelectedWords[SelNum].WBegin; MasX:=SelectedWords[SelNum].Coord;
                  If SelectedWords[SelNum].Tested=20 Then begin
                    MasX:=WorkFieldDimentionX+1;
                    NotLinkedWordsPresent:=true; StepFlag:=false; break; end;
                             end;

        If Not CheckStarPresent(WBegin,WEnd,MasX,Vertic,SelNum,noShapes) Then begin
            RestoreStars;
            Exit;
                                                              end
                                                       Else If not noShapes Then begin
                                                                If pos('*',SelectedWords[SelNum].Word)>0 Then
                                                                   For I:=1 to length(StarWindow.HelpKeyword) do
                                                                     SelectedWords[SelNum].Word[pos('*',SelectedWords[SelNum].Word)]:=string(StarWindow.HelpKeyword[i])[1];
                                                                     //SelectedWords[SelNum].Word[pos('*',SelectedWords[SelNum].Word)]:=ConvString(StarWindow.HelpKeyword[i],ASCII)[1];
                                                                NewWord:=SelectedWords[SelNum].Word;
                                                                                 end;

         { провер€ем наличие слова в —ловаре }
         FirstLetter:=NewWord[1]; FindInDict:=False; FindTheme:=False;
         If (FirstLetter='*') Then continue;
           try
         TempStrList:=DictArray[GetLetterNum(FirstLetter)+1];
         If tempStrList<>nil Then
          If tempStrList.Count>0 Then
             If (TempStrList.IndexOfName(NewWord)<>-1)
             or (TempStrList.IndexOf(NewWord)<>-1)  Then begin FindInDict:=True; end;
           except
                  FindInDict:=false;
              end;

        { проверка на наличие слова в пользовательском словаре }
	    If MasX>WorkFieldDimentionX div 2 Then MessX:=Application.MainForm.Left+(MasX)*28-335 Else MessX:=Application.MainForm.Left+(MasX+1)*28;
            If MasY>WorkFieldDimentionY div 2 Then MessY:=Application.MainForm.Top+(MasY+1)*28-142+47 Else MessY:=Application.MainForm.Top+MasY*28+70;
            If CustomDict.Use Then begin
               FlashWord(On_m,WBegin,WEnd,MasX,Vertic);
               AddWordNow:=CheckCustomDictionary(FindInDict,MessX,MessY);
               FlashWord(Off_m,WBegin,WEnd,MasX,Vertic);
               If not AddWordNow Then Else FindInDict:=True;
                                   end;
//         If not CustomDict.Use or CustomDict.WordRequired Then
            If Not FindInDict Then begin
            FlashWord(On_m,WBegin,WEnd,MasX,Vertic);
            If PlaySounds Then BASS_SamplePlay(ErrorSound);
            Announce(MessX,MessY,GlobalTextStrings.Items.Values['InGameMessageGoUnknownWord']);
            FlashWord(Off_m,WBegin,WEnd,MasX,Vertic);
            RestoreStars;
            Exit;
                                   end;

       { провер€ем слово на пересечение }
       If Not IsCrossWord(MasX,WBegin,WEnd,FirstWord,Vertic) Then begin
	    If MasX>WorkFieldDimentionX div 2 Then MessX:=Application.MainForm.Left+(MasX)*28-335 Else MessX:=Application.MainForm.Left+(MasX+1)*28;
            If MasY>WorkFieldDimentionY div 2 Then MessY:=Application.MainForm.Top+(MasY+1)*28-142+47 Else MessY:=Application.MainForm.Top+MasY*28+70;
          NotLinkedWord:=NewWord; NotLinkedDir:=Vertic; NotLinkedCoord:=MasX;
          NotLinkedWB:=WBegin; NotLinkedWE:=WEnd;
          NotLinkedWordsPresent:=True; MasY:=WEnd+1;
          If not noshapes then SelectedWords[SelNum].Linked:=false;
          Continue;
                                                                 end;

         { проверка на ограничение по количеству букв }
         If length(NewWord)<=LimitWordLength Then begin
	    If MasX>WorkFieldDimentionX div 2 Then MessX:=Application.MainForm.Left+(MasX)*28-335 Else MessX:=Application.MainForm.Left+(MasX+1)*28;
            If MasY>WorkFieldDimentionY div 2 Then MessY:=Application.MainForm.Top+(MasY+1)*28-142+47 Else MessY:=Application.MainForm.Top+MasY*28+70;
            FlashWord(On_m,WBegin,WEnd,MasX,Vertic);
            If PlaySounds Then BASS_SamplePlay(ErrorSound);
            Announce(MessX,MessY,GlobalTextStrings.Items.Values['InGameMessageGoShortWord']);
            FlashWord(Off_m,WBegin,WEnd,MasX,Vertic);
            RestoreStars;
            Exit;
                                   end;

       { проверка на повторение слова }
       If RepeatedWord(NewWord,W,E,C,D) Then begin
	    If MasX>WorkFieldDimentionX div 2 Then MessX:=Application.MainForm.Left+18+10 Else MessX:=Application.MainForm.BoundsRect.Right-350;
            If MasY>WorkFieldDimentionY div 2 Then MessY:=Application.MainForm.Top+75 Else MessY:=Application.MainForm.BoundsRect.Bottom-160;
            FlashWord(On_m,WBegin,WEnd,MasX,Vertic);
            FlashWord(On_m,W,E,C,D);
            If PlaySounds Then BASS_SamplePlay(ErrorSound);
            Announce(MessX,MessY,GlobalTextStrings.Items.Values['InGameMessageGoRepeatWord']);
            FlashWord(Off_m,W,E,C,D);
            FlashWord(Off_m,WBegin,WEnd,MasX,Vertic);
          RestoreStars;
          Exit;
                                             end;

       { проверка на выставление двух одинаковых слов }
        For I:=1 To 15 Do
            If NewWord=NewWords[I].Word Then
             If (NewWords[I].WBegin=WBegin) and (NewWords[I].Coord=MasX) and (NewWords[I].Direction=Vertic) Then
             begin If AllowWordRepeat then break;
                   RPW:=True; break; end
             Else begin
            If not AllowWordRepeat Then begin
	    If MasX>WorkFieldDimentionX div 2 Then MessX:=Application.MainForm.Left+18+10 Else MessX:=Application.MainForm.BoundsRect.Right-350;
            If MasY>WorkFieldDimentionY div 2 Then MessY:=Application.MainForm.Top+75 Else MessY:=Application.MainForm.BoundsRect.Bottom-160;
              FlashWord(On_m,WBegin,WEnd,MasX,Vertic);
              FlashWord(On_m,NewWords[I].WBegin,NewWords[I].WEnd,NewWords[I].Coord,NewWords[I].Direction);
              If PlaySounds Then BASS_SamplePlay(ErrorSound);
              Announce(MessX,MessY,GlobalTextStrings.Items.Values['InGameMessageGoTheSameWord']);
              FlashWord(Off_m,NewWords[I].WBegin,NewWords[I].WEnd,NewWords[I].Coord,NewWords[I].Direction);
              FlashWord(Off_m,WBegin,WEnd,MasX,Vertic);
              RestoreStars;
              Exit;
                                   end
                                      {Else break;}

                   end;
          If AllowWordRepeat and (I<16) Then begin MasY:=WEnd+1; continue; end;
          If RPW Then begin RPW:=False; MasY:=WEnd+1; continue; end;



      For I:=1 To 15 Do If NewWords[I].Word='' Then begin
                          NewWords[I].Word:=NewWord;
			  NewWords[I].Coord:=MasX;
                          NewWords[I].WBegin:=WBegin;
                          NewWords[I].WEnd:=WEnd;
			  NewWords[I].Direction:=Vertic;
                          break;
                                                   end;
      For I:=WBegin to WEnd Do begin
             WorkField[MasX,I].checked:=False;
                               end;
      If not noShapes Then begin
       SelectedWords[SelNum].Passed:=true;
        For I:=0 to length(SelectedWords)-1 Do if not SelectedWords[I].Passed Then break;
        If I=length(SelectedWords) Then begin NoShapes:=true; MasX:=WorkFieldDimentionX+1; MasY:=WorkFieldDimentionY+1; StepFlag:=true; NotLinkedWordsPresent:=true; continue; end;
                           end;
      StepFlag:=True;
      If noShapes Then MasY:=WEnd+1;
      end Else inc(MasY); end; inc(MasX) end;
{!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}
      Until not NotLinkedWordsPresent or not StepFlag;

      { очищаем маркировку в слое маркировки }
      For MasX:=1 To WorkFieldDimentionX Do For MasY:=1 To WorkFieldDimentionY Do
        WorkField[MasX,MasY].Checked:=False;

      { если не найдено ни одно слово, то выход }
      If Not FindWord Then begin
            If PlaySounds Then BASS_SamplePlay(ErrorSound);
               If Preview Then Announce(0,0,GlobalTextStrings.Items.Values['InGameMessageCalculateNoWords'])
                     Else Announce(0,0,GlobalTextStrings.Items.Values['InGameMessageGoNoWords']);
                          Preview:=False; Exit;
			   end;
       { если найдено непересекающеес€ слово, то выход }
      If NotLinkedWordsPresent Then begin
          PressGo:=False;
          FlashWord(On_m,NotLinkedWB,NotLinkedWE,NotLinkedCoord,NotLinkedDir);
          If PlaySounds Then BASS_SamplePlay(ErrorSound);
          If FirstWord Then
          Announce(MessX,MessY,GlobalTextStrings.Items.Values['InGameMessageGoNeedUseStartCell'])
                       Else
          Announce(MessX,MessY,GlobalTextStrings.Items.Values['InGameMessageGoNoCrossWord']);
          FlashWord(Off_m,NotLinkedWB,NotLinkedWE,NotLinkedCoord,NotLinkedDir);
          RestoreStars;
          exit;
                           end;
       { запоминаем состо€ние призовых €чеек }
       For I:=1 To WorkFieldDimentionX Do For J:=1 To WorkFieldDimentionY Do
          CurrentColorState[I,J]:=WorkField[I,J].Color;

      { проверка на пользование подсказкой дл€ вычитани€ бонуса }
      For I:=1 To 15 Do begin
      If NewWords[I].Word='' Then begin
           If Preview Then begin
                 { выключаем таймер на ход }
                 If MoveLimit Then
                   begin {SystemTime.Font.Color:=clGray; SystemTime.Update;
                         ElaspedTime.Font.Color:=clGray; ElaspedTime.Update;}
                  _MoveTimer.Enabled:=False; end;
                 TimeEffect(1,I); RestoreStars;
                 { восстанавливаем состо€ни призовых €чеек }
                 For J:=1 To WorkFieldDimentionX Do For K:=1 To WorkFieldDimentionY Do
                   WorkField[J,K].Color:=CurrentColorState[J,K];
                { включаем таймер на ход }
                If MoveLimit Then begin
                    {If MoveIs=1 Then begin
                         SystemTime.Font.Color:=clLime; SystemTime.Update; end
                    Else If MoveIs=2 Then begin
                         ElaspedTime.Font.Color:=clFuchsia; ElaspedTime.Update; end;}
                  _MoveTimer.Enabled:=True; end;
                 Exit;
                            end;
           break;
                                  end;

        Helped:=False;
        If (length(HelpedWords)>0) Then begin
           For J:=0 To length(HelpedWords)-1 Do begin
               If (NewWords[I].Word=HelpedWords[J].Word)
                and (((NewWords[I].WBegin=HelpedWords[J].WBegin)
                 and (NewWords[I].Coord=HelpedWords[J].AltCoord)
                  and (NewWords[I].Direction=HelpedWords[J].Direction)) or FirstWord)
                Then begin Helped:=True; break end;
                                                       end;
           end;

      FirstWord:=False;           

        { если это предварительный анализ, то вот...}
        If Preview Then begin
           Prevalue[I].Caption:='+'+IntToStr(CountPoints(Pl,NewWords[I].Coord,NewWords[I].WBegin,NewWords[I].WEnd,NewWords[I].Direction));
           If NewWords[I].Direction=Horiz Then begin
           Prevalue[I].Left:=(NewWords[I].WBegin-1)*28+28;
           Prevalue[I].Top:=(NewWords[I].Coord-1)*28+15;
                                               end
                                          Else begin
           Prevalue[I].Top:=(NewWords[I].WBegin-1)*28+28;
           Prevalue[I].Left:=(NewWords[I].Coord)*28;
                                               end;
           If Helped Then begin
                            Prevalue[I].Font.Color:=clRed;
                            Prevalue[I].Color:=clMaroon;
                          end
                     Else begin
                            Prevalue[I].Font.Color:=clWhite;
                            Prevalue[I].Color:=clBlue;
                          end;
           Prevalue[I].Enabled:=True;
           Prevalue[I].Visible:=True; Prevalue[I].BringToFront;
           Prevalue[I].Update;

           continue;
                        end;

        { регистрируем ход }
        _MoveTimer.Enabled:=False;
        {If MoveLimit Then begin SystemTime.Font.Color:=clGray;
                                ElaspedTime.Font.Color:=clGray; end;}
        CopyToMainField(NewWords[I].Coord,NewWords[I].WBegin,NewWords[I].WEnd,NewWords[I].Direction);
        WordPoints:=0;
        WordPoints:=CountPoints(Pl,NewWords[I].Coord,NewWords[I].WBegin,NewWords[I].WEnd,NewWords[I].Direction);
        RegisterWord(Pl,NewWords[I].Word,NewWords[I].WBegin,NewWords[I].WEnd,NewWords[I].Coord,NewWords[I].Direction, WordPoints);
        If Not GameLoading Then begin
           If pos('PLAYGROUND:',MovesLog.Strings[MovesLog.Count-1])<>0 Then MovesLog.Strings[MovesLog.Count-1]:=copy(MovesLog.Strings[MovesLog.Count-1],1,pos('PLAYGROUND:',MovesLog.Strings[MovesLog.Count-1])-1);
           If pos('WORDS:',MovesLog.Strings[MovesLog.Count-1])=0 Then begin
                 If TimeLimit Then MovesLog.Strings[MovesLog.Count-1]:=MovesLog.Strings[MovesLog.Count-1]+'ETIME:'+IntToStr(StartMin)+'/'+IntToStr(StartSec)+',';
                 MovesLog.Strings[MovesLog.Count-1]:=MovesLog.Strings[MovesLog.Count-1]+'WORDS:';
                                                                      end;
           MovesLog.Strings[MovesLog.Count-1]:=MovesLog.Strings[MovesLog.Count-1]+NewWords[I].Word+'('+IntToStr(WordPoints)+')'+IntToStr(NewWords[I].WBegin*10000+NewWords[I].Wend*100+NewWords[I].Coord)+ifthen(NewWords[I].direction=1,'H','V')+ifthen(Helped,'X','')+',';
                                 end;
        Players[Pl].Changes:=0;
                       end;
       { начисл€ем очки }
        FullSet:=True;
        For I:=1 to 7 Do
          If Slot7[Pl,I].Letter<>' ' Then begin FullSet:=False; break; end;
        If FullSet Then begin
                           If PlaySounds Then BASS_SamplePlay(Bonus2Sound);
                           ShowMainMessage(0,0,GlobalTextStrings.Items.Values['InGameMessageAllLettersUsedBonus'],$004080FF,'',clRed);
                           TimeDelay(2000);
                           IncScore(Pl,15);
                           If not gameLoading Then
                              MovesLog.Strings[MovesLog.Count-1]:=MovesLog.Strings[MovesLog.Count-1]+'FULLSETBONUS'+',';
                           TimeDelay(700);
                        end;
    {  For MasX:=1 To WorkFieldDimention Do For MasY:=1 To WorkFieldDimention Do
        If WorkField[MasX,MasY].main=' ' Then WorkField[MasX,MasY].available:=True;}
      { а†ббв†ҐЂп•ђ еЃв-бѓЃвл }
      SetHotSpots;
      { ѓаЃҐ•а™† ≠† Ѓ£а†≠®з•≠®п Ґ ®£а• }
      CheckLimits(FinishGame);
      PressGo:=True;
      If not Fullset Then begin
        MovesLog.Strings[MovesLog.Count-1]:=MovesLog.Strings[MovesLog.Count-1]+'(USED:';
        For I:=1 to 7 Do If Slot7[Pl,I].Letter=' ' Then MovesLog.Strings[MovesLog.Count-1]:=MovesLog.Strings[MovesLog.Count-1]+IntToStr(I);
        MovesLog.Strings[MovesLog.Count-1]:=MovesLog.Strings[MovesLog.Count-1]+'),';
                          end;
end;

{---------------------------------------------------------------}
{ процесс замены букв }
Procedure ChangeLetters(Opp:byte; var FinishGame:boolean);
var masX,masY:byte; I,J:byte; ActiveIm:TImage; TempAnim:TRXGIFAnimator;
begin
If FinishGame Then Exit;
TempAnim:=TRXGifAnimator.Create(nil);
LoadSkinnedGIF(TempAnim.Image,'ANIMATIO\explosio');
If PlaySounds and (Opp=1) Then BASS_SamplePlay(change1Sound);
If PlaySounds and (Opp>1) Then BASS_SamplePlay(change2Sound);
   For I:=1 To TempAnim.Image.Count Do begin
                   For J:=1 To 7 Do
                     If (Slot7[Opp,J].Mark) and (Slot7[Opp,J].Image<>-1) Then
                                              begin
                         ActiveIm:=Letters[Slot7[Opp,J].Image];
                         ActiveIm.Transparent:=true;
                         ActiveIm.Picture.Assign(TempAnim.Image.Frames[I-1].Bitmap);
                         ActiveIm.Repaint;
                                               end;
                   TimeDelay(35);
                     end;
                 inc(Players[Opp].Changes);
                 { перенос буквы из слота в произвольную €чейку пол€ выбора }
                 For I:=1 To 7 Do
                  If Slot7[Opp,I].Mark and (Slot7[Opp,I].Image<>-1)  Then begin
				    Slot7[Opp,I].Mark:=False;
                                    ActiveIm:=Letters[Slot7[Opp,I].Image];
                                    ActiveIm.Transparent:=false;
                                    ChoiceEmptyXY(MasX,MasY);
                                    If LettersLeft>7 Then
                                       WorkField[MasX,MasY].ForChoice:=Slot7[Opp,I].Letter
                                                     Else begin
                                       WorkField[MasX,MasY].ForChoice:=chr(LettersCodes[random(AlphCount+1)]);
                                       ActiveIm.Hint:=WorkField[MasX,MasY].ForChoice;
                                                          end;
                                    inc(LettersLeft);
                                    ActiveIm.Parent:=_ChoicePanel;
                                    ActiveIm.Left:=28*(MasX-1); ActiveIm.Top:=28*(MasY-1);
                                    ActiveIm.Tag:=-1; ActiveIm.Picture:=Images[2,AlphCount+1];
                                    //ActiveIm.Visible:=False;
                                    ActiveIm.Update;
                                    Slot7[Opp,I].Letter:=' '; Slot7[Opp,I].Image:=-1;
                                    ActiveIm:=nil;
                                                           end;
TempAnim.Free;
end;

END.
