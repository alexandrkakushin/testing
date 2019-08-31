program Settings_client;

uses
  Forms,
  F_main in 'Forms\Settings_Client\Main\F_main.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Настройки "Тест-Клиент"';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
