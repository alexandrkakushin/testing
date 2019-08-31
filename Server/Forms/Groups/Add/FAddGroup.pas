unit FAddGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, U_TestServer;

type
  TfmAddGroup = class(TForm)
    leName: TLabeledEdit;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    bCloseOK : boolean;
  public
    pNameGroup : string;
  end;

var
  fmAddGroup: TfmAddGroup;
  afAddGroup : TActionForm;

implementation

uses FMainForm;

{$R *.dfm}

procedure TfmAddGroup.FormShow(Sender: TObject);
begin
  //Интерфейс
  bCloseOK:=false;
  leName.Text:=pNameGroup;
  leName.SetFocus;
end;

procedure TfmAddGroup.btnOKClick(Sender: TObject);
begin
  //Запись значений
  bCloseOK:=true;
  pNameGroup:=leName.Text;

  //Закрытие
  Close;
end;

procedure TfmAddGroup.btnCancelClick(Sender: TObject);
begin
  afAddGroup:=Cancel;
  Close;
end;

procedure TfmAddGroup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if bCloseOK=false then afAddGroup:=Cancel;
end;

end.
