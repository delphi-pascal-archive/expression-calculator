unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFMain = class(TForm)
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    Label1: TLabel;
    E_Expression: TEdit;
    L_erreur: TLabel;
    Button1: TButton;
    E_Resultat: TEdit;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FMain: TFMain;

implementation

uses expression;

{$R *.dfm}

procedure TFMain.FormCreate(Sender: TObject);
begin
  FMain.E_Expression.Text:='(10+2*3)-5*sin(60)';
  Fmain.E_Resultat.Text:='';
  FMain.L_erreur.Visible:=false;
end;

procedure TFMain.Button1Click(Sender: TObject);
var
  reel: real;
  erreur: integer;
begin
  Fmain.E_Resultat.Text:='';
  FMain.L_erreur.Visible:=false;
  eval(FMain.E_Expression.Text,reel,erreur);
  if erreur<>0 then
     begin
       FMain.L_erreur.Visible:=True;
       exit;
     end;
  Fmain.E_Resultat.Text:=floattostr(reel);
end;

end.
