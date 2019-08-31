program Test_server;

uses
  Forms,
  FMainForm in 'Forms\Main\FMainForm.pas' {fmMain},
  U_TestServer in 'Units\U_TestServer.pas',
  FAddGroup in 'Forms\Groups\Add\FAddGroup.pas' {fmAddGroup},
  FRenameGroup in 'Forms\Groups\Rename\FRenameGroup.pas' {fmRenameGroup},
  F_About in 'Forms\About\F_About.pas' {fmAbout},
  FAddEditStudent in 'Forms\Students\AddEdit\FAddEditStudent.pas' {fmAddEditStudent},
  FMoveStudent in 'Forms\Students\Move\FMoveStudent.pas' {fmMoveStudent},
  FDataReports in 'Forms\Reports\DataReports\FDataReports.pas' {fmDataReports},
  FReport in 'Forms\Reports\Report\FReport.pas' {fmReport},
  FSelectResult in 'Forms\Reports\SelectResult\FSelectResult.pas' {fmSelectResult},
  FAdditionalInfoReport in 'Forms\Reports\AdditionalInfoReport\FAdditionalInfoReport.pas' {fmAdditionalInfoReport},
  FManagerTest in 'Forms\ManagerTest\FManagerTest.pas' {fmManagerTest},
  F_Folder in 'Forms\ManagerTest\Folder\F_Folder.pas' {fmFolder},
  F_Testing in 'Forms\Testing\F_Testing.pas' {fmTesting},
  F_Setting in 'Forms\Setting\F_Setting.pas' {fmSetting};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Тест-сервер';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmSetting, fmSetting);
  Application.Run;
end.
