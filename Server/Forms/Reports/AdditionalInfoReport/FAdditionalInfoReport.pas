unit FAdditionalInfoReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, TeeProcs, TeEngine, Chart;

type
  TfmAdditionalInfoReport = class(TForm)
    lstDataReport: TListView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAdditionalInfoReport: TfmAdditionalInfoReport;

implementation

{$R *.dfm}

end.
