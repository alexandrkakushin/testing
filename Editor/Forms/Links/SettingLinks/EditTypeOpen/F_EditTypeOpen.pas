unit F_EditTypeOpen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, U_Test;

type
  TfmEditTypeOpen = class(TForm)
    pTypeOpen: TPanel;
    Label1: TLabel;
    mFiles: TMemo;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    pFiles, psTypeOpen : string;
    bCloseOK : boolean;
  end;

var
  fmEditTypeOpen: TfmEditTypeOpen;
  afEditTypeOpen : TActionForm;

implementation

{$R *.dfm}

procedure TfmEditTypeOpen.btnCancelClick(Sender: TObject);
begin
  afEditTypeOpen:=Cancel;
  Close;
end;

procedure TfmEditTypeOpen.btnOKClick(Sender: TObject);
begin
  bCloseOK:=true;
  pFiles:=mFiles.Text;
  Close;
end;

procedure TfmEditTypeOpen.FormShow(Sender: TObject);
begin
  bCloseOK:=false;
  pTypeOpen.Caption:=psTypeOpen;
  mFiles.Text:=pFiles;
end;

procedure TfmEditTypeOpen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if bCloseOK=false then afEditTypeOpen:=Cancel;
end;

end.
