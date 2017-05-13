program saveconv;

{$APPTYPE CONSOLE}

uses
SysUtils,WinProcs;


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

     SaveFileTypeNew=record
                        Date:string[10]; { ???? ?????????? }
                        Time:string[20]; { ????? ??????????}
                        Info:string[150]; { ?????????? ? ?????? }
                        Opnt:0..1; { ??? ????????? }
                        Intellect:1..4; { ??? ??????????� }
                        Limits:string[20]; { ??????????? }
                        Themes:string[20]; { ???? }
                        ElaspedGameTime1:string[7]; { ????? ?????? }
                        ElaspedGameTime2:string[7]; { ????? ?????? }
                        StartHour,StartMin,StartSec:word;
                        WorkFieldDimentionX:byte; {?????? ???? ?? ???????????}
                        WorkField:array[0..31,0..31] of WorkFieldTypeNew; { ??????? ???? }
                        PlayersNumber:byte; {?????????? ??????? ? ??????}
                        Players:array[1..8] of PlayersTypeNew; { ?????? }
                        WordList:array[1..200,1..8] of WordListType;
                        Slot7:array[1..8,1..7] of Slot7TypeNew; { ??????? ????? }
                        Move:1..8; { ??? ???? }
                        Help:boolean; { ???? ????????? }
                        Mode:12..14; { ????? ???????? ???????? }
                        LettersCount:0..900;
                        Letters:array[0..899] of record { ????? }
                                                 Left:integer;
                                                 Top:integer;
                                                 Hint:string[25];
                                                 Tag:integer;
                                                 Visible:Boolean;
                                                 Parent:0..8;
                                                 end;
                        ChoiceFieldStatus:boolean; { "?????????" ???? ?????? }
                        //GoButStatus:array[1..2] of boolean; { "?????????" ???????? "????!" }
                        //ChButStatus:array[1..2] of boolean; { "?????????" ???????? "?????!" }
                        //QVButStatus:boolean; { "?????????" ???????? "??????? ??????" }
                        //HpButStatus:boolean; { "?????????" ???????? "?????????" }
                        Reserved3:boolean;
                        Reserved2:boolean;
                        Reserved1:boolean;
                        Reserved4:boolean;
                        HintDelay:0..1000; {????? ?????????}
                        HintLimit:byte; {?????????? ?????????? ?????????}
                        StoreHintLimit:byte; {????? ?????????? ???????? }
                        FloatingForms:array[0..8] of record X,Y:word; Locked:integer; Status:byte; end;
                        Template:string[255];
                        ShapesNumber:byte;
                        SelectShapes:array[0..50] of record
                                     Name:string[30];
                                     Left, Top:word;
                                     Width, Height:word;
                                     Color:integer; Tag:byte;
                                                     end;
                        SelectField:array[0..31,0..31] of 0..3;
                        KeepBonuses:boolean;
                        WorkFieldDimentionY:byte; {?????? ???? ?? ???????????}
                        MainFieldForm: record X,Y:word; end;
                      end;


    SaveFileTypeOld=record
                        Date:string[10]; { ���� ���������� }
                        Time:string[20]; { ����� ����������}
                        Info:string[150]; { ���������� � ������ }
                        Opnt:0..1; { ��� ��������� }
                        Intellect:1..4; { ��� ���������� }
                        Limits:string[20]; { ����������� }
                        Themes:string[20]; { ���� }
                        ElaspedGameTime1:string[7]; { ����� ������ }
                        ElaspedGameTime2:string[7]; { ����� ������ }
                        StartHour,StartMin,StartSec:word;
                        WorkField:array[0..16,0..16] of WorkFieldType; { ������� ���� }
                        Players:array[1..4] of PlayersType; { ������ }
                        WordList:array[1..100,1..4] of WordListType;
                        Slot7:array[1..4,1..7] of Slot7Type; { ������� ����� }
                        Move:1..4; { ��� ���� }
                        Help:boolean; { ���� ��������� }
                        Mode:12..14; { ����� �������� �������� }
                        Letters:array[0..224] of record { ����� }
                                                 Left:integer;
                                                 Top:integer;
                                                 Hint:string[255];
                                                 Tag:integer;
                                                 Visible:Boolean;
                                                 end;
                        ChoiceFieldStatus:boolean; { "���������" ���� ������ }
                        GoButStatus:array[1..2] of boolean; { "���������" �������� "����!" }
                        ChButStatus:array[1..2] of boolean; { "���������" �������� "�����!" }
                        QVButStatus:boolean; { "���������" �������� "������� ������" }
                        HpButStatus:boolean; { "���������" �������� "���������" }
                        Reserved3:boolean; { ���� ������ ���� �� ����� ���� ���������� }
                        Reserved2:boolean; { ���� ������ �� ����� �������� ������ }
                        Reserved1:boolean; { ���� ������ �������� ������ }
                        ShowTerminals:boolean; { ���� ������ ����������� }
                        HintDelay:0..1000; {����� ���������}
                        HintLimit:byte; {���������� ���������� ���������}
                        StoreHintLimit:byte; {����� ���������� �������� }
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

var OldFile:file of SaveFileTypeOld;
    NewFile:file of SaveFileTypeNew;
    OldSave:SaveFileTypeOld;
    NewSave:SaveFileTypeNew;
    OldiniFile:file of IniType;
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



begin
  { TODO -oUser -cConsole Main : Insert code here }
   if FindFirst('save???.*', 0, sr) = 0 Then
     If If sr.size<>88312 Then
repeat
   begin
   AssignFile(OldFile, sr.Name);
   Reset(OldFile);
   try
   try
   Read(OldFile, OldSave);
   NewSave.Date:=OldSave.Date;
   NewSave.Time:=OldSave.Time;
   NewSave.Info:=OldSave.Info;
   NewSave.Opnt:=0;
   NewSave.Intellect:=OldSave.Intellect;
   NewSave.Limits:=OldSave.Limits;
   NewSave.Themes:=OldSave.Themes;
   NewSave.ElaspedGameTime1:=OldSave.ElaspedGameTime1;
   NewSave.ElaspedGameTime2:=OldSave.ElaspedGameTime2;
   NewSave.StartHour:=OldSave.StartHour;
   NewSave.StartMin:=OldSave.StartMin;
   NewSave.StartSec:=OldSave.StartSec;

   NewSave.PlayersNumber:=2;
   for I:=1 to 2 do begin
    NewSave.Players[I].Name:=OldSave.Players[I].Name;
    NewSave.Players[I].Points:=OldSave.Players[I].Points;
    NewSave.Players[I].Changes:=OldSave.Players[I].Changes;
    If pos('1',OldSave.Players[I].Image)=0
     Then NewSave.Players[I].Image:=OldSave.Players[I].Image+'1'
     Else NewSave.Players[I].Image:=OldSave.Players[I].Image;
    NewSave.Players[I].Code:=OldSave.Players[I].Code;
    NewSave.Players[1].PLtype:=0;
    NewSave.Players[2].PLtype:=abs(OldSave.Opnt-1);
                    end;

   For J:=1 To 8 do for I:=1 to 200 do begin
    NewSave.WordList[I,J].Word:='';
    NewSave.WordList[I,J].WBegin:=1;
    NewSave.WordList[I,J].WEnd:=1;
    NewSave.WordList[I,J].Coord:=1;
    NewSave.WordList[I,J].Direction:=1;
                                       end;
   For J:=1 To 4 do for I:=1 to 50 do begin
    NewSave.WordList[I,J].Word:=OldSave.WordList[I,J].Word;
    NewSave.WordList[I,J].WBegin:=OldSave.WordList[I,J].Wbegin;
    NewSave.WordList[I,J].WEnd:=OldSave.WordList[I,J].WEnd;
    NewSave.WordList[I,J].Coord:=OldSave.WordList[I,J].Coord;
    NewSave.WordList[I,J].Direction:=OldSave.WordList[I,J].Direction;
    NewSave.WordList[I,J].Value:=OldSave.WordList[I,J].Value;
                                       end;


   NewSave.LettersCount:=225;
   for I:=0 to 224 do begin
    NewSave.Letters[I].Tag:=OldSave.Letters[I].Tag;
    If NewSave.Letters[I].Tag<=0 Then begin NewSave.Letters[I].Left:=OldSave.Letters[I].Left-172;
                                            NewSave.Letters[I].Top:=OldSave.Letters[I].Top-44;
       If NewSave.Letters[I].Tag=-1 Then begin
          NewSave.Letters[I].Left:=NewSave.Letters[I].Left-19;
          NewSave.Letters[I].Top:=NewSave.Letters[I].Top-19;
                                         end;
                                        end
                                 Else
     case NewSave.Letters[I].Tag of
     1: begin NewSave.Letters[I].Left:=OldSave.Letters[I].Left-3;
              If NewSave.Letters[I].Left=32 Then NewSave.Letters[I].Left:=31;
              NewSave.Letters[I].Top:=OldSave.Letters[I].Top-121; end;
     2: begin NewSave.Letters[I].Left:=OldSave.Letters[I].Left-631; NewSave.Letters[I].Top:=OldSave.Letters[I].Top-121; end;
     end;
    NewSave.Letters[I].Hint:=OldSave.Letters[I].Hint;
    NewSave.Letters[I].Visible:=true;
    If NewSave.Letters[I].Tag>0 Then NewSave.Letters[I].Parent:=NewSave.Letters[I].Tag
                                Else NewSave.Letters[I].Parent:=0;
                      end;

   for I:=1 to 4 do begin
  NewSave.Slot7[i,1].SlotX:=31; NewSave.Slot7[i,1].SlotY:=216;
  NewSave.Slot7[i,2].SlotX:=59; NewSave.Slot7[i,2].SlotY:=216;
  NewSave.Slot7[i,3].SlotX:=87; NewSave.Slot7[i,3].SlotY:=216;
  NewSave.Slot7[i,4].SlotX:=115; NewSave.Slot7[i,4].SlotY:=216;
  NewSave.Slot7[i,5].SlotX:=45; NewSave.Slot7[i,5].SlotY:=244;
  NewSave.Slot7[i,6].SlotX:=73; NewSave.Slot7[i,6].SlotY:=244;
  NewSave.Slot7[i,7].SlotX:=101; NewSave.Slot7[i,7].SlotY:=244;
                    end;

   for I:=1 to 4 do For J:=1 To 7 do begin
    NewSave.Slot7[I,J].Letter:=OldSave.Slot7[I,J].Letter;
    NewSave.Slot7[I,J].Mark:=OldSave.Slot7[I,J].Mark;
    NewSave.Slot7[I,J].Image:=OldSave.Slot7[I,J].Image;
    If NewSave.Slot7[I,J].Image<>-1 Then begin
                    NewSave.Letters[NewSave.Slot7[I,J].Image].Left:=NewSave.Slot7[i,j].SlotX;
                    NewSave.Letters[NewSave.Slot7[I,J].Image].top:=NewSave.Slot7[i,j].SlotY;                    
                                         end;
                                     end;

   NewSave.Move:=OldSave.Move;
   NewSave.Help:=OldSave.Help;
   NewSave.Mode:=OldSave.Mode;


   NewSave.WorkFieldDimentionX:=15;
   NewSave.WorkFieldDimentionY:=15;
   for I:=0 to 16 do For J:=0 To 16 do begin
    NewSave.WorkField[I,J].main:=OldSave.Workfield[I,J].main;
    NewSave.WorkField[I,J].available:=OldSave.Workfield[I,J].available;
    NewSave.WorkField[I,J].hotspot:=OldSave.Workfield[I,J].hotspot;
    NewSave.WorkField[I,J].Image:=OldSave.Workfield[I,J].Image;
    If (NewSave.WorkField[I,J].hotspot<>'')
    and (NewSave.WorkField[I,J].main=' ') Then begin
                                                 NewSave.Letters[NewSave.WorkField[I,J].Image].Parent:=0;
                                                 NewSave.Letters[NewSave.WorkField[I,J].Image].Left:=OldSave.Letters[NewSave.WorkField[I,J].Image].Left-172;
                                                 NewSave.Letters[NewSave.WorkField[I,J].Image].Top:=OldSave.Letters[NewSave.WorkField[I,J].Image].Top-44;
                                               end;
    NewSave.WorkField[I,J].color:=OldSave.Workfield[I,J].color;
    NewSave.WorkField[I,J].forChoice:=OldSave.Workfield[I,J].forChoice;
    NewSave.WorkField[I,J].Checked:=OldSave.Workfield[I,J].Checked;
                                       end;

   NewSave.ChoiceFieldStatus:=OldSave.ChoiceFieldStatus;
   NewSave.HintDelay:=OldSave.HintDelay;
   NewSave.HintLimit:=OldSave.HintLimit;
   NewSave.StoreHintLimit:=NewSave.StoreHintLimit;

 SystemParametersInfo(SPI_GETWORKAREA, 0, @AreaRect, 0);

 NewSave.FloatingForms[0].X:=AreaRect.Right-1036;
 If NewSave.FloatingForms[0].X>AreaRect.Right Then NewSave.FloatingForms[0].X:=0;
 NewSave.FloatingForms[0].Y:=AreaRect.Bottom-400;
 If NewSave.FloatingForms[0].Y>AreaRect.Bottom Then NewSave.FloatingForms[0].Y:=0;
 NewSave.FloatingForms[0].Locked:=0; NewSave.FloatingForms[0].status:=0;
 NewSave.FloatingForms[1].X:=AreaRect.Right-1036;
 If NewSave.FloatingForms[1].X>AreaRect.Right Then NewSave.FloatingForms[1].X:=0;
 NewSave.FloatingForms[1].Y:=AreaRect.Bottom-753;
 If NewSave.FloatingForms[1].Y>AreaRect.Bottom Then NewSave.FloatingForms[1].Y:=0;
 NewSave.FloatingForms[1].Locked:=0; NewSave.FloatingForms[1].status:=0;
 NewSave.FloatingForms[2].X:=AreaRect.Right-411;
 If NewSave.FloatingForms[2].X>AreaRect.Right Then NewSave.FloatingForms[2].X:=0;
 NewSave.FloatingForms[2].Y:=AreaRect.Bottom-753;
 If NewSave.FloatingForms[2].Y>AreaRect.Bottom Then NewSave.FloatingForms[2].Y:=0;
 NewSave.FloatingForms[2].Locked:=0; NewSave.FloatingForms[2].status:=0;

 NewSave.MainFieldForm.X:=0; NewSave.MainFieldForm.Y:=0;

 NewSave.Template:='classic.map';
 NewSave.ShapesNumber:=0;
 NewSave.KeepBonuses:=false;

   AssignFile(NewFile, sr.Name);
   ReWrite(NewFile);
   Write(NewFile, NewSave);
   CloseFile(NewFile);
   finally
   CloseFile(OldFile);
   end;
   except continue end;
   end;
until FindNext(sr)<>0;

if FindFirst('erudit.ini', 0, sr) = 0 Then
 begin
   AssignFile(OldiniFile, sr.Name);
   Reset(OldiniFile);
   try
   Read(OldiniFile, Oldinidata);
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

   AssignFile(NewiniFile, sr.Name);
   ReWrite(NewiniFile);
   Write(NewiniFile, Newinidata);
   CloseFile(NewiniFile);
   finally
   CloseFile(OldiniFile);
   end;
 end;

 if FindFirst('*.ini', 0, sr) = 0 Then
 repeat
   If  sr.Name='erudit.ini' then continue;
   AssignFile(OldPliniFile, sr.Name);
   Reset(OldPliniFile);
   try
   try
   Read(OldPliniFile, OldPlinidata);
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

   AssignFile(NewPliniFile, sr.Name);
   ReWrite(NewPliniFile);
   Write(NewPliniFile, NewPlIniData);
   CloseFile(NewPliniFile);
      finally
   CloseFile(OldPliniFile);
   end;
   except continue end;
  until FindNext(sr)<>0;
                                    end;


halt;
end.
