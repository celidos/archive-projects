{v 1.6.x}
program Erudit2;

{%ToDo 'Erudit2.todo'}

uses
  Forms,
  _about in '_about.pas' {About},
  Errormes in 'ErrorMes.pas' {ErrorWindow},
  gameover in 'gameover.pas' {SplashWindow},
  hallfm in 'hallfm.pas' {HallFame},
  PLImages in 'PLImages.pas' {ImageScreen},
  Main in 'Main.pas' {MainScreen},
  newgame in 'newgame.pas' {NewGameWindow},
  Optns in 'optns.pas' {Options},
  Procs in 'Procs.pas',
  Routines in 'Routines.pas',
  savegame in 'savegame.pas' {SaveGameWindow},
  Splash in 'Splash.pas' {SplashScreen},
  Strwnd in 'Strwnd.pas' {StarWindow},
  VirtOpp in 'Virtopp.pas',
  hh_funcs in 'hh_funcs.pas',
  binfo in 'binfo.pas' {BonusInfo},
  SevenZipVCL in 'SevenZipVCL.pas';

{$R *.RES}

begin
  Application.Initialize;
  SplashScreen := TSplashScreen.Create(Application);
  try    SplashScreen.Show;
         SplashScreen.refresh;
  Application.Title := '������ �� 1.6 beta';
  Application.CreateForm(TMainScreen, MainScreen);
  Application.CreateForm(TStarWindow, StarWindow);
  Application.CreateForm(TErrorWindow, ErrorWindow);
  Application.CreateForm(TOptions, Options);
  Application.CreateForm(TNewGameWindow, NewGameWindow);
  Application.CreateForm(TSaveGameWindow, SaveGameWindow);
  Application.CreateForm(TAbout, About);
  Application.CreateForm(THallFame, HallFame);
  Application.CreateForm(TImageScreen, ImageScreen);
  Application.CreateForm(TSplashWindow, SplashWindow);
  Application.CreateForm(TBonusInfo, BonusInfo);
  MainScreen.LoadGlobalTextStrings(All);
  except {Make sure the splash screen gets released}   Halt;
  end;
    MainScreen.Show; Application.Run;
end.
