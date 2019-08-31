program Test_Client;

uses
  Forms,
  F_Main in 'Forms\Client\Main\F_Main.pas' {fmMain},
  F_Questions in 'Forms\Client\Questions\F_Questions.pas' {fmQuestions},
  U_TestClient in 'Units\U_TestClient.pas',
  F_Browser in 'Forms\Client\Links\Browser\F_Browser.pas' {fmLinkBrowser},
  F_SoundVideo in 'Forms\Client\Links\SoundVideo\F_SoundVideo.pas' {fmLinkSoundVideo},
  F_Picture in 'Forms\Client\Links\Picture\F_Picture.pas' {fmLinkPicture},
  F_Protocol in 'Forms\Client\Protocol\F_Protocol.pas' {fmProtocol};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Тест-клиент';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
