unit F_Protocol;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart, ComCtrls,
  Buttons;

type
  TfmProtocol = class(TForm)
    lblGroup: TLabel;
    lblFIO: TLabel;
    lblSubject: TLabel;
    lblTopic: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    gbDetail: TGroupBox;
    lstDetail: TListView;
    btnOK: TBitBtn;
    procedure btnOKClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmProtocol: TfmProtocol;

implementation

uses F_Main;

{$R *.dfm}


procedure TfmProtocol.btnOKClick(Sender: TObject);
begin
  Application.Terminate;

  Close;
end;

end.
