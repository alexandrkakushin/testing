unit FDataReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, U_TestServer, ImgList, ExtCtrls;

type
  TfmDataReports = class(TForm)
    gbDataReports: TGroupBox;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    tvDataReports: TTreeView;
    Images: TImageList;
    procedure EnableOK (bValue : boolean);
    procedure tvDataReportsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    bCloseOK : boolean;
  public
    { Public declarations }
    pTypeReport : TTypeReport;
  end;

var
  fmDataReports: TfmDataReports;
  afDataReports : TActionForm;

implementation

{$R *.dfm}

{ TfmDataReports }

procedure TfmDataReports.EnableOK(bValue: boolean);
begin
  btnOK.Enabled:=bValue;
end;

procedure TfmDataReports.tvDataReportsClick(Sender: TObject);
begin
  case tvDataReports.Selected.Level of
    2,3 : EnableOK(true)
  else
    EnableOK(false)
  end;
end;

procedure TfmDataReports.FormShow(Sender: TObject);
begin
  EnableOK(false);
  bCloseOK:=false;
end;

procedure TfmDataReports.btnOKClick(Sender: TObject);
begin
  bCloseOK:=true;
  Close;
end;

procedure TfmDataReports.btnCancelClick(Sender: TObject);
begin
  afDataReports:=Cancel;
  Close;
end;

procedure TfmDataReports.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if bCloseOK=false then afDataReports:=Cancel;
end;

end.
