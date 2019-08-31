unit FSelectResult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, U_TestServer, ComCtrls, StdCtrls, Buttons;

type
  TfmSelectResult = class(TForm)
    gbSelectResult: TGroupBox;
    lstResults: TListView;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lstResultsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);

    procedure EnableOK (bValue : boolean);
  private
    { Private declarations }
    bCloseOK : boolean;
  public
    { Public declarations }
    liSelected : TListItem;
  end;

var
  fmSelectResult : TfmSelectResult;
  afSelectResult : TActionForm;

implementation

{$R *.dfm}

procedure TfmSelectResult.btnCancelClick(Sender: TObject);
begin
  afSelectResult:=CANCEL;
  Close;
end;

procedure TfmSelectResult.btnOKClick(Sender: TObject);
begin
  bCloseOK:=true;
  liSelected:=lstResults.Selected;
  Close;
end;

procedure TfmSelectResult.FormShow(Sender: TObject);
begin
  EnableOK(false);
  bCloseOK:=false;
end;

procedure TfmSelectResult.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if bCloseOK=false then afSelectResult:=CANCEL;
end;

procedure TfmSelectResult.lstResultsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  EnableOK(Selected);

end;

procedure TfmSelectResult.EnableOK(bValue: boolean);
begin
  btnOK.Enabled:=bValue;
end;

end.
