unit F_Setting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IniFiles;

type
  TfmSetting = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    gbAccess: TGroupBox;
    chkAccess: TCheckBox;
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSetting: TfmSetting;

implementation

{$R *.dfm}

procedure TfmSetting.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
