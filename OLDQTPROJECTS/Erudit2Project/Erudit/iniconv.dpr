program iniconv;

{$APPTYPE CONSOLE}

uses
SysUtils,WinProcs,Classes;


type
     WorkFieldType= record
	     main:char; { ??????? ???? }
	     available:boolean; { ???? "?????????????" ??????}
	     hotspot:char; { "???-????" ????????}
	     color:byte; {???? ??????}
	     forChoice:char; { ???? ???? ?????? }
             Image:-1..224; { ????? ????? ? ?????? }
             Checked:boolean; { ???? ????????????? ?????? ?????}
                     end;
     WorkFieldTypeNew= record
	     main:char; { ??????? ???? }
	     available:boolean; { ???? "?????????????" ??????}
	     hotspot:char; { "???-????" ????????}
	     color:byte; {???? ??????}
	     forChoice:char; { ???? ???? ?????? }
             Image:-1..900; { ????? ????? ? ?????? }
             Checked:boolean; { ???? ????????????? ?????? ?????}
                       end;
     Slot7Type=record
		Letter:char; { ????? ? ?????? ????? }
		SlotX:word; { ?????????? ? ?????? ????? }
		SlotY:word; { ?????????? Y ?????? ????? }
		Mark:boolean; { ??????? ?? ?????? }
                Image:-1..224; { ????? ????? ? ?????? }
               end;

     Slot7TypeNew=record
		Letter:char; { ????? ? ?????? ????? }
		SlotX:word; { ?????????? ? ?????? ????? }
		SlotY:word; { ?????????? Y ?????? ????? }
		Mark:boolean; { ??????? ?? ?????? }
                Image:-1..900; { ????? ????? ? ?????? }
               end;

     PlayersType=record
                      Name:string[9];
                      Points:word;
                      Changes:byte;
                      Image:string[8];
                      Code:byte;
                    end;

     PlayersTypeNew=record
                      Name:string[9];
                      Points:word;
                      Changes:byte;
                      Image:string[8];
                      Code:byte;
                      PLtype:0..2;
                    end;

     WordListType=record
                      Word:string[15];
                      WBegin,WEnd:1..15;
                      Coord:1..15;
                      Direction:1..2;
                      Value:byte;
                   end;

     WordListTypeNew=record
                      Word:string[15];
                      WBegin,WEnd:1..30;
                      Coord:1..30;
                      Direction:1..2;
                      Value:byte;
                   end;

     HallFameType=record
                      Name:string[15];
                      Points:string[3];
                      Code:string[8];
                  end;
     TCustomDict=record
                      Use:boolean;
                      AddWord:0..2;
                      WordRequired:boolean;
                      WarnMissing:boolean;
                      WarnDelete:boolean;
                   end;

     PlayerIniType= record
                Opponent:0..2;
                Player1:PlayersType;
                Player2:PlayersType;
                Intell:1..4;
                Limit:string[20];
                Themes:string[15];
                ThemeList:string[15];
                ShowLetters:boolean;
                ShowColorLetters:boolean;
                CrosswordMode:boolean;
                HintDelay:0..1000;
                HintLimit:byte;
                PlayBackgroundMusic:boolean;
                PlayShuffle:boolean;
                PlaySounds:boolean;
                HintPushButton:boolean;
                CustomDict:TCustomDict;
                FlashStarMarkers:boolean;
                TakeStar:boolean;
                RepeatTurn:boolean;
                AllowSelection:boolean;
                AllowWordRepeat:boolean;
                LettersAutoSelect:boolean;
              end;

     IniType= record
                Opponent:0..2;
                Player1:PlayersType;
                Player2:PlayersType;
                Intell:1..4;
                Limit:string[20];
                Themes:string[15];
                ThemeList:string[15];
                BackgroundImage:string[255];
                ShowLetters:boolean;
                ShowColorLetters:boolean;
                Shadows:boolean;
                ShowAdvancedHallFame:boolean;
                FullScreen:boolean;
                CrosswordMode:boolean;
                HintDelay:0..1000;
                HintLimit:byte;
                PlayBackgroundMusic:boolean;
                PlayShuffle:boolean;
                PlaySounds:boolean;
                Members:array[1..20] of PlayersType;
                HallFame:array[1..7] of HallFameType;
                HintPushButton:boolean;
                CustomDict:TCustomDict;
                FlashStarMarkers:boolean;
                TakeStar:boolean;
                RepeatTurn:boolean;
                AllowSelection:boolean;
                AllowWordRepeat:boolean;
                SoundVolume,MusicVolume:0..100;
                LettersAutoSelect:boolean;
              end;

     IniTypeNew= record
                Opponent:0..2;
                compatible1:PlayersType;
                compatible2:PlayersType;
                Intell:1..4;
                Limit:string[20];
                Themes:string[15];
                ThemeList:string[15];
                Template:string[255];
                ShowLetters:boolean;
                ShowColorLetters:boolean;
                Shadows:boolean;
                ShowAdvancedHallFame:boolean;
                MinimizeOnEsc:boolean;
                CrosswordMode:boolean;
                HintDelay:0..1000;
                HintLimit:byte;
                PlayBackgroundMusic:boolean;
                PlayShuffle:boolean;
                PlaySounds:boolean;
                Members:array[1..20] of PlayersTypenew;
                HallFame:array[1..7] of HallFameType;
                HintPushButton:boolean;
                CustomDict:TCustomDict;
                FlashStarMarkers:boolean;
                TakeStar:boolean;
                RepeatTurn:boolean;
                AllowSelection:boolean;
                AllowWordRepeat:boolean;
                SoundVolume,MusicVolume:0..100;
                LettersAutoSelect:boolean;
                ColorsCount:array[2..6] of byte;
                WorkFieldDimentionX:byte;
                PlayersNumber:byte;
                Players:array[1..10] of PlayersTypeNew;
                RunMinimized:boolean;
                KeepBonuses:boolean;
                WorkFieldDimentionY:byte;
                AllPlayersOpen:boolean;
                AnimActiveAvatar:boolean;
                AnimActivePlayer:boolean;
                Skin:string[50];
                LimitWordLength:byte;
              end;

     PlayerIniTypeNew= record
                Opponent:0..2;
                compatible1:PlayersType;
                compatible2:PlayersType;
                Intell:1..4;
                Limit:string[20];
                Themes:string[15];
                ThemeList:string[15];
                Template:string[255];
                ShowLetters:boolean;
                ShowColorLetters:boolean;
                CrosswordMode:boolean;
                HintDelay:0..1000;
                HintLimit:byte;
                PlayBackgroundMusic:boolean;
                PlayShuffle:boolean;
                PlaySounds:boolean;
                HintPushButton:boolean;
                CustomDict:TCustomDict;
                FlashStarMarkers:boolean;
                TakeStar:boolean;
                RepeatTurn:boolean;
                AllowSelection:boolean;
                AllowWordRepeat:boolean;
                LettersAutoSelect:boolean;
                ColorsCount:array[2..6] of byte;
                WorkFieldDimentionX:byte;
                PlayersNumber:byte;
                Players:array[1..10] of PlayersTypeNew;
                MinimizeOnEsc:boolean;
                RunMinimized:boolean;
                KeepBonuses:boolean;
                WorkFieldDimentionY:byte;
                AllPlayersOpen:boolean;
              end;
     THallFameArray=array[1..8] of HallFameType;

var OldiniFile:file of IniType;
    NewiniFile:file of IniTypeNew;
    OldIniData:iniType;
    NewIniData:IniTypeNew;
    OldPliniFile:file of PlayerIniType;
    NewPliniFile:file of PlayerIniTypeNew;
    OldPlIniData:PlayeriniType;
    NewPlIniData:PlayerIniTypeNew;
    sr:TSearchRec;
    I,J:byte;
    AreaRect : TRect;
    ColorsCount:array[2..6] of word=(24,16,8,8,1);
    TempStr:TStringList;
    HallfameArray:THallFameArray;
    HallFameFile:file of THallFameArray;

const
      OppArr:array[0..3] of string[6]=('Human','PC','Net','');
      AddWrd:array[0..3] of string[6]=('No','Yes','Ask','');
      Colors:array[2..6] of string[6]=('Green','Blue','Yellow','Red','Black');

{---------------------------------------------------------------}
{ ���������� ����� ������ �� TStrings }
procedure SaveUnicodeFile(const filename: string; strings: TStrings);
var I,j:byte; //WStr:array[0..255] of WideChar; MBuffer:TMemoryStream;
              f:text; c:char;
begin
   //MBuffer:=TMemoryStream.Create;
   //I:=$FF; MBuffer.Write(I,sizeof(I)); I:=$FE; MBuffer.Write(I,sizeof(I));
   Assign(f,filename);
   rewrite(f);
   If Strings.Count<>0 Then begin
    c:=chr($EF); Write(f,c); c:=chr($BB); Write(f,c); c:=chr($BF); Write(f,c);
    For I:=0 to strings.Count-1 Do begin
      //StringToWideChar(Strings.Strings[i],WStr,length(Strings.Strings[i])+1);
      //for j:=0 to length(Strings.Strings[i])-1 do MBuffer.Write(Wstr[j],sizeof(Wstr[j]));
      //J:=13; MBuffer.Write(J,sizeof(J)); J:=0; MBuffer.Write(J,sizeof(J));
      //J:=$0A; MBuffer.Write(J,sizeof(J));  J:=0; MBuffer.Write(J,sizeof(J));
       Writeln(f,ANSItoUTF8(strings.Strings[i]));
                                   end;
                            end;
   closeFile(f);
   //MBuffer.SaveToFile(filename); mBuffer.Free;
end;



begin
  { TODO -oUser -cConsole Main : Insert code here }

if FindFirst('erudit.ini', 0, sr) = 0 Then
 If sr.size<1000 Then Else
 begin
   If sr.size>1300 Then begin AssignFile(NewiniFile, sr.Name);
                              Reset(NewiniFile);
                              try
                              try
                               Read(NewiniFile, Newinidata);
                              except
                               NewIniData.AnimActiveAvatar:=true;
                               NewIniData.AnimActivePlayer:=true;
                               NewIniData.Skin:='classic';
                               NewIniData.LimitWordLength:=0;
                              end;
                              finally CloseFile(NewIniFile); end;
                          end
                   Else begin { ������ ���
                                ��������� ������� 1.4.x � 1.5.x}
                              AssignFile(OldiniFile, sr.Name);
                              Reset(OldiniFile);
                              try
                              Read(OldiniFile, Oldinidata);
                              finally CloseFile(OldIniFile); end;                              
                              NewiniData.Opponent:=0;
                              NewiniData.compatible1:=OldIniData.Player1;
                              NewiniData.compatible2:=OldIniData.Player2;
                              NewiniData.Intell:=OldIniData.Intell;
                              NewiniData.Limit:=OldIniData.Limit;
                              NewiniData.Themes:=OldIniData.Themes;
                              NewiniData.ThemeList:=OldIniData.ThemeList;
                              NewiniData.Template:='classic.map';
                              NewiniData.ShowLetters:=OldIniData.ShowLetters;
                              NewiniData.ShowColorLetters:=OldIniData.ShowColorLetters;
                              NewiniData.Shadows:=OldIniData.Shadows;
                              NewiniData.ShowAdvancedHallFame:=OldIniData.ShowAdvancedHallFame;
                              NewiniData.MinimizeOnEsc:=false;
                              NewiniData.CrosswordMode:=OldIniData.CrosswordMode;
                              NewiniData.HintDelay:=OldIniData.HintDelay;
                              NewiniData.HintLimit:=OldIniData.HintLimit;
                              NewiniData.PlayBackgroundMusic:=OldIniData.PlayBackgroundMusic;
                              NewiniData.PlayShuffle:=OldIniData.PlayShuffle;
                              NewiniData.PlaySounds:=OldIniData.PlaySounds;
                                For I:=1 to 20 do begin
                                  NewiniData.Members[i].Name:=OldIniData.Members[i].Name;
                                  NewiniData.Members[i].Points:=OldIniData.Members[i].Points;
                                  NewiniData.Members[i].Changes:=OldIniData.Members[i].Changes;
                                  NewiniData.Members[i].Image:=OldIniData.Members[i].Image;
                                  NewiniData.Members[i].Code:=OldIniData.Members[i].Code;
                                  NewiniData.Members[i].PLtype:=0;
                                 end;
                              For I:=1 to 7 do NewiniData.HallFame[i]:=OldIniData.Hallfame[i];
                              NewiniData.HintPushButton:=OldIniData.HintPushButton;
                              NewiniData.CustomDict:=OldIniData.CustomDict;
                              NewiniData.FlashStarMarkers:=OldIniData.FlashStarMarkers;
                              NewiniData.TakeStar:=OldIniData.TakeStar;
                              NewiniData.RepeatTurn:=OldIniData.RepeatTurn;
                              NewiniData.AllowSelection:=OldIniData.AllowSelection;
                              NewiniData.AllowWordRepeat:=OldIniData.AllowWordRepeat;
                              NewiniData.SoundVolume:=OldIniData.SoundVolume;
                              NewiniData.MusicVolume:=OldIniData.MusicVolume;
                              NewiniData.LettersAutoSelect:=OldIniData.LettersAutoSelect;
                              NewIniData.AllPlayersOpen:=true;
                              for I:=2 to 6 Do NewiniData.ColorsCount[i]:=ColorsCount[i];
                              NewiniData.WorkFieldDimentionX:=15;
                              NewiniData.WorkFieldDimentionY:=15;
                              NewiniData.PlayersNumber:=2;
                              NewiniData.RunMinimized:=false;
                              NewiniData.KeepBonuses:=false;
                              NewiniData.Players[1].Name:=OldIniData.Player1.Name;
                              NewiniData.Players[1].Points:=OldIniData.Player1.Points;
                              NewiniData.Players[1].Changes:=OldIniData.Player1.Changes;
                              NewiniData.Players[1].Image:=OldIniData.Player1.Image;
                              NewiniData.Players[1].Code:=OldIniData.Player1.Code;
                              NewiniData.Players[1].PLtype:=0;
                              NewiniData.Players[2].Name:=OldIniData.Player2.Name;
                              NewiniData.Players[2].Points:=OldIniData.Player2.Points;
                              NewiniData.Players[2].Changes:=OldIniData.Player2.Changes;
                              NewiniData.Players[2].Image:=OldIniData.Player2.Image;
                              NewiniData.Players[2].Code:=OldIniData.Player2.Code;
                              NewiniData.Players[2].PLtype:=abs(OldiniData.Opponent-1);
                              NewIniData.AnimActiveAvatar:=true;
                              NewIniData.AnimActivePlayer:=true;
                              NewIniData.Skin:='classic';
                              NewIniData.LimitWordLength:=0;
                           end;


{ ���������� ������� ��������� � ���� ������������� }
TempStr:=TStringList.Create;
TempStr.Add('[Last Player]');
TempStr.Add('Player1='+NewiniData.Players[1].Name);
TempStr.Add(chr(13)+'[Options Common]');
TempStr.Add('ShowAdvancedHallFame='+IntToStr(ord(NewiniData.ShowAdvancedHallFame)));
TempStr.Add(chr(13)+'[Options Appearance]');
TempStr.Add('Skin='+NewiniData.Skin);
TempStr.Add('ShowShadows='+IntToStr(ord(NewiniData.Shadows)));
TempStr.Add(chr(13)+'[Members]');
I:=1;
While NewIniData.Members[i-1].Name<>'' Do begin
      TempStr.Add('Member'+inttostr(I)+'='+NewIniData.Members[i-1].Name+'/'+NewIniData.Members[i-1].Image+'/'+OppArr[NewIniData.Members[i-1].pltype]+'/'+IntToStr(NewIniData.Members[i-1].code));
      inc(i);
                               end;
SaveUnicodeFile('erudit.ini',tempStr);

For I:=1 to 7 do HallfameArray[I]:=NewIniData.HallFame[i];
AssignFile(HallFameFile,'hallfame.dat');
{ ���������� hallfame-���� }
Rewrite(HallFameFile); Write(HallFameFile,HallFameArray); CloseFile(HallFameFile);
TempStr.Free;
end;

 if FindFirst('*.ini', 0, sr) = 0 Then
 repeat
   If  sr.Name='erudit.ini' then continue;
 If sr.size>1000 Then else BEGIN
   If sr.size>600 Then begin AssignFile(NewPliniFile, sr.Name);
                              Reset(NewPliniFile);
                              try
                               Read(NewPliniFile, NewPlinidata);
                              finally CloseFile(NewPlIniFile); end;
                          end
                   Else begin { ������ ���
                                ��������� ������� 1.4.x � 1.5.x}
                              AssignFile(OldPliniFile, sr.Name);
                              try
                              Reset(OldPliniFile);
                              finally CloseFile(OldPlIniFile); end;
                              NewPlIniData.Opponent:=0;
                              NewPlIniData.compatible1:=OldPlIniData.Player1;
                              NewPlIniData.compatible2:=OldPlIniData.Player2;
                              NewPlIniData.Intell:=OldPlIniData.Intell;
                              NewPlIniData.Limit:=OldPlIniData.Limit;
                              NewPlIniData.Themes:=OldPlIniData.Themes;
                              NewPlIniData.ThemeList:=OldPlIniData.ThemeList;
                              NewPlIniData.Template:='classic.map';
                              NewPlIniData.ShowLetters:=OldPlIniData.ShowLetters;
                              NewPlIniData.ShowColorLetters:=OldPlIniData.ShowColorLetters;
                              NewPlIniData.MinimizeOnEsc:=false;
                              NewPlIniData.CrosswordMode:=OldPlIniData.CrosswordMode;
                              NewPlIniData.HintDelay:=OldPlIniData.HintDelay;
                              NewPlIniData.HintLimit:=OldPlIniData.HintLimit;
                              NewPlIniData.PlayBackgroundMusic:=OldPlIniData.PlayBackgroundMusic;
                              NewPlIniData.PlayShuffle:=OldPlIniData.PlayShuffle;
                              NewPlIniData.PlaySounds:=OldPlIniData.PlaySounds;
                              NewPlIniData.HintPushButton:=OldPlIniData.HintPushButton;
                              NewPlIniData.CustomDict:=OldPlIniData.CustomDict;
                              NewPlIniData.FlashStarMarkers:=OldPlIniData.FlashStarMarkers;
                              NewPlIniData.TakeStar:=OldPlIniData.TakeStar;
                              NewPlIniData.RepeatTurn:=OldPlIniData.RepeatTurn;
                              NewPlIniData.AllowSelection:=OldPlIniData.AllowSelection;
                              NewPlIniData.AllowWordRepeat:=OldPlIniData.AllowWordRepeat;
                              NewPlIniData.LettersAutoSelect:=OldPlIniData.LettersAutoSelect;
                              NewPlIniData.LettersAutoSelect:=OldPlIniData.LettersAutoSelect;
                              NewPlIniData.AllPlayersOpen:=true;
                              for I:=2 to 6 Do NewPlIniData.ColorsCount[i]:=ColorsCount[i];
                              NewPlIniData.WorkFieldDimentionX:=15;
                              NewPlIniData.WorkFieldDimentionY:=15;
                              NewPlIniData.PlayersNumber:=2;
                              NewPlIniData.RunMinimized:=false;
                              NewPlIniData.KeepBonuses:=false;
                              NewPlIniData.Players[1].Name:=OldPlIniData.Player1.Name;
                              NewPlIniData.Players[1].Points:=OldPlIniData.Player1.Points;
                              NewPlIniData.Players[1].Changes:=OldPlIniData.Player1.Changes;
                              NewPlIniData.Players[1].Image:=OldPlIniData.Player1.Image;
                              NewPlIniData.Players[1].Code:=OldPlIniData.Player1.Code;
                              NewPlIniData.Players[1].PLtype:=0;
                              NewPlIniData.Players[2].Name:=OldPlIniData.Player2.Name;
                              NewPlIniData.Players[2].Points:=OldPlIniData.Player2.Points;
                              NewPlIniData.Players[2].Changes:=OldPlIniData.Player2.Changes;
                              NewPlIniData.Players[2].Image:=OldPlIniData.Player2.Image;
                              NewPlIniData.Players[2].Code:=OldPlIniData.Player2.Code;
                              NewPlIniData.Players[2].PLtype:=abs(OldPlIniData.Opponent-1);
                          end;

TempStr:=TStringList.Create;
TempStr.Add('[Last Game]');
TempStr.Add('LastOpponent='+OppArr[NewPlIniData.Opponent]);
If NewPlIniData.Intell=0 then NewPlIniData.Intell:=NewIniData.Intell;
TempStr.Add('LastIntellect='+IntToStr(NewPlIniData.Intell));
TempStr.Add('LastLimits='+NewPlIniData.Limit);
TempStr.Add('LastWordLengthLimit='+IntToStr(NewIniData.LimitWordLength));
TempStr.Add('LastPlayersNumber='+IntToStr(NewPlIniData.PlayersNumber));
TempStr.Add(chr(13)+'[Last Players]');
For I:=1 to NewPlIniData.PlayersNumber Do begin
      If NewPlIniData.Players[I].Name='' Then NewPlIniData.Players[I]:=NewIniData.Players[I];
      TempStr.Add('Player'+inttostr(I)+'='+NewPlIniData.Players[i].Name+'/'+NewPlIniData.Players[i].Image+'/'+OppArr[NewPlIniData.Players[i].pltype]+'/'+IntToStr(NewPlIniData.Players[i].code));
                                          end;
TempStr.Add(chr(13)+'[Options Common]');
TempStr.Add('ShowPCWords='+IntToStr(ord(NewPlIniData.ShowLetters)));
TempStr.Add('CrossWordMode='+IntToStr(ord(NewPlIniData.CrossWordMode)));
TempStr.Add('SelectWordMode='+IntToStr(ord(NewPlIniData.AllowSelection)));
TempStr.Add('ExchangeStars='+IntToStr(ord(NewPlIniData.TakeStar)));
TempStr.Add('FlashStarMarkers='+IntToStr(ord(NewPlIniData.FlashStarMarkers)));
TempStr.Add('AllowWordRepeat='+IntToStr(ord(NewPlIniData.AllowWordRepeat)));
TempStr.Add('KeepBonuses='+IntToStr(ord(NewPlIniData.KeepBonuses)));
TempStr.Add('LettersAutoSelect='+IntToStr(ord(NewPlIniData.LettersAutoSelect)));
TempStr.Add('MinimizeOnEsc='+IntToStr(ord(NewPlIniData.MinimizeOnEsc)));
TempStr.Add('AutoSpreadPlayers='+IntToStr(ord(NewPlIniData.AllPlayersOpen)));
TempStr.Add(chr(13)+'[Options Appearance]');
TempStr.Add('ShowColorLetters='+IntToStr(ord(NewPlIniData.ShowColorLetters)));
TempStr.Add('AnimActiveAvatarOnly='+IntToStr(ord(NewIniData.AnimActiveAvatar)));
TempStr.Add('AnimHighlightActivePlayer='+IntToStr(ord(NewIniData.AnimActivePlayer)));
TempStr.Add(chr(13)+'[Options Hint]');
TempStr.Add('HintDelay='+IntToStr(NewPlIniData.HintDelay));
TempStr.Add('HintCount='+IntToStr(NewPlIniData.HintLimit));
TempStr.Add('HintPushButton='+IntToStr(ord(NewPlIniData.HintPushButton)));
TempStr.Add(chr(13)+'[Options Sound]');
TempStr.Add('PlaySounds='+IntToStr(ord(NewPlIniData.PlaySounds)));
TempStr.Add('PlayBackgroundMusic='+IntToStr(ord(NewPlIniData.PlayBackgroundMusic)));
TempStr.Add('PlayShuffle='+IntToStr(ord(NewPlIniData.PlayShuffle)));
TempStr.Add('SoundVolume='+IntToStr(NewIniData.SoundVolume));
TempStr.Add('MusicVolume='+IntToStr(NewIniData.MusicVolume));
TempStr.Add(chr(13)+'[Options Dictionary]');
If NewIniData.Themes='�' Then NewIniData.Themes:='�';
If NewIniData.Themes='�' Then NewIniData.Themes:='�';
TempStr.Add('DictionaryLimits='+'Limrus='+NewIniData.Themes+'/'+'rus='+NewIniData.ThemeList+'/');
TempStr.Add('UseCustomDictionary='+IntToStr(ord(NewPlIniData.CustomDict.Use)));
TempStr.Add('AddCustomWord='+AddWrd[NewPlIniData.CustomDict.AddWord]);
TempStr.Add('WordRequiredAlways='+IntToStr(ord(NewPlIniData.CustomDict.WordRequired)));
TempStr.Add('AskToExcludeWord='+IntToStr(ord(NewPlIniData.CustomDict.WarnDelete)));
TempStr.Add('AskToAddExplanation=1');
TempStr.Add('UndoPCMove='+IntToStr(ord(NewPlIniData.RepeatTurn)));
TempStr.Add(chr(13)+'[Options Template]');
TempStr.Add('LastTemplate='+NewPlIniData.Template);
TempStr.Add('PlayFieldDimX='+IntToStr(NewPlIniData.WorkFieldDimentionX));
TempStr.Add('PlayFieldDimY='+IntToStr(NewPlIniData.WorkFieldDimentionY));
For I:=2 to 6 Do TempStr.Add(Colors[I]+'='+IntToStr(NewPlIniData.ColorsCount[I]));
TempStr.Add(chr(13)+'[Options Language]');
TempStr.Add('InterfaceLang=rus');
TempStr.Add('DictionaryLang=rus');
TempStr.Add('ExplanatoryLang=rus');

SaveUnicodeFile(sr.name,tempStr);
TempStr.Free;
                           END;
  until FindNext(sr)<>0;


halt;
end.
