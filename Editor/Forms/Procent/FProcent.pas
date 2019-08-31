unit FProcent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, U_Test;

type
  TfmProcent = class(TForm)
    gbParametr: TGroupBox;
    Panel1: TPanel;
    Label1: TLabel;
    edt5min: TEdit;
    Label2: TLabel;
    edt5max: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    edt4min: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edt4max: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    edt3min: TEdit;
    Label8: TLabel;
    Label11: TLabel;
    edt3max: TEdit;
    Label12: TLabel;
    Label15: TLabel;
    edt2max: TEdit;
    Label16: TLabel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    
    pResult : TResult;
  end;

var
  fmProcent : TfmProcent;
  afProcent : TActionForm;

implementation

uses FTopics, F_Main_form;

{$R *.dfm}

procedure TfmProcent.btnCancelClick(Sender: TObject);
begin
  //Закрытие окна
  afProcent:=CANCEL;
  Close;
end;

procedure TfmProcent.FormShow(Sender: TObject);
begin
  //Установка значений шкалы оценок
  edt2max.Text:=FloatToStr(pResult[2]);
  edt3min.Text:=FloatToStr(pResult[3]);
  edt3max.Text:=FloatToStr(pResult[4]);
  edt4min.Text:=FloatToStr(pResult[5]);
  edt4max.Text:=FloatToStr(pResult[6]);
  edt5min.Text:=FloatToStr(pResult[7]);
  edt5max.Text:=FloatToStr(pResult[8]);

end;

procedure TfmProcent.btnOkClick(Sender: TObject);
begin
  //Установка значений параметра
  pResult[1]:=0;
  pResult[2]:=StrToFloat(edt2max.Text);
  pResult[3]:=StrToFloat(edt3min.Text);
  pResult[4]:=StrToFloat(edt3max.Text);
  pResult[5]:=StrToFloat(edt4min.Text);
  pResult[6]:=StrToFloat(edt4max.Text);
  pResult[7]:=StrToFloat(edt5min.Text);
  pResult[8]:=StrToFloat(edt5max.Text);

  //Закрытие окна
  Close;
end;



procedure TfmProcent.edtKeyPress(Sender: TObject; var Key: Char);
begin
     if (not (key in ['0'..'9'])) xor (Ord(Key)=8) then key:=#0;
end;

end.
