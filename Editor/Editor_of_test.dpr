program Editor_of_test;

uses
  Forms,
  F_Main_form in 'F_Main_form.pas' {fmMain},
  U_Test in 'Units\U_Test.pas',
  FTopics in 'Forms\Topics\FTopics.pas' {fmTopics},
  FProcent in 'Forms\Procent\FProcent.pas' {fmProcent},
  FTeacher in 'Forms\Teacher\FTeacher.pas' {fmTeacher},
  FTime in 'Forms\Time\FTime.pas' {fmTime},
  FAdditilonalInfo in 'Forms\AdditionalInfo\FAdditilonalInfo.pas' {fmAdditionalInfo},
  FAddTopics in 'Forms\Topics\Add\FAddTopics.pas' {fmAddTopics},
  F_About in 'Forms\About\F_About.pas' {fmAbout},
  FRenameTopic in 'Forms\Topics\Rename\FRenameTopic.pas' {fmRenameTopic},
  FListDeveloper in 'Forms\ListDeveloper\FListDeveloper.pas' {fmListDeveloper},
  FEnterPassword in 'Forms\Password\EnterPassword\FEnterPassword.pas' {fmEnterPassword},
  fAddEditPassword in 'Forms\Password\AddEditPassword\fAddEditPassword.pas' {fmAddEditPassword},
  F_Question in 'Forms\Question\F_Question.pas' {fmQuestion},
  F_Picture in 'Forms\Links\Picture\F_Picture.pas' {fmLinkPicture},
  F_SoundVideo in 'Forms\Links\SoundVideo\F_SoundVideo.pas' {fmLinkSoundVideo},
  F_Browser in 'Forms\Links\Browser\F_Browser.pas' {fmLinkBrowser},
  F_AddEditAnswerSelect in 'Forms\Question\AnswerSelect\AddEdit\F_AddEditAnswerSelect.pas' {fmAddEditAnswerSelect},
  F_AllEditAnswerSelect in 'Forms\Question\AnswerSelect\AllEdit\F_AllEditAnswerSelect.pas' {fmAllEditAnswerSelect},
  F_MoveQuestion in 'Forms\Question\F_MoveQuestion.pas' {fmMoveQuestion},
  F_Links in 'Forms\Links\SettingLinks\F_Links.pas' {fmLinks},
  F_AddEditFilter in 'Forms\Links\SettingLinks\AddEditFilter\F_AddEditFilter.pas' {fmAddEditFilter},
  F_EditTypeOpen in 'Forms\Links\SettingLinks\EditTypeOpen\F_EditTypeOpen.pas' {fmEditTypeOpen},
  FRenameTest in 'Forms\RenameTest\FRenameTest.pas' {fmRenameTest};

{$R *.res}


begin
  Application.Initialize;
  Application.Title := 'Редактор тестов';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmTopics, fmTopics);
  Application.Run;

end.
