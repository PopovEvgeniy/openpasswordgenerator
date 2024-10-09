unit openpasswordgeneratorcode;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit2Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var Form1: TForm1;

implementation

procedure window_setup();
begin
 Application.Title:='OPEN PASSWORD GENERATOR';
 Form1.Caption:='OPEN PASSWORD GENERATOR 0.5.5';
 Form1.BorderStyle:=bsDialog;
 Form1.Font.Name:=Screen.MenuFont.Name;
 Form1.Font.Size:=14;
end;

procedure interface_setup();
begin
 Form1.Button1.Enabled:=True;
 Form1.Button2.Enabled:=False;
 Form1.Button1.ShowHint:=False;
 Form1.Button2.ShowHint:=Form1.Button1.ShowHint;
 Form1.LabeledEdit1.NumbersOnly:=True;
 Form1.LabeledEdit2.Enabled:=False;
 Form1.LabeledEdit1.MaxLength:=2;
 Form1.LabeledEdit1.Text:='8';
 Form1.LabeledEdit2.Text:='';
 Form1.LabeledEdit1.LabelPosition:=lpLeft;
 Form1.LabeledEdit2.LabelPosition:=Form1.LabeledEdit1.LabelPosition;
end;

procedure language_setup();
begin
 Form1.Button1.Caption:='Generate';
 Form1.Button2.Caption:='Copy a password to the clipboard';
 Form1.LabeledEdit1.EditLabel.Caption:='Length';
 Form1.LabeledEdit2.EditLabel.Caption:='Password';
end;

procedure setup();
begin
 window_setup();
 interface_setup();
 language_setup();
end;

function generate_password(const amount:Byte):string;
var index:Byte;
var target:string;
begin
 target:='';
 Randomize();
 for index:=1 to amount do
 begin
  target:=target+chr(Random(94)+33);
 end;
 generate_password:=target;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
 setup();
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 Form1.LabeledEdit2.Text:=generate_password(StrToInt(Form1.LabeledEdit1.Text));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 Form1.LabeledEdit2.SelectAll();
 Form1.LabeledEdit2.CopyToClipboard();
end;

procedure TForm1.LabeledEdit1Change(Sender: TObject);
begin
 Form1.Button1.Enabled:=Form1.LabeledEdit1.Text<>'';
end;

procedure TForm1.LabeledEdit2Change(Sender: TObject);
begin
 Form1.Button2.Enabled:=Form1.LabeledEdit2.Text<>'';
end;

{$R *.lfm}

end.
