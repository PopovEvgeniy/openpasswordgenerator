unit openpasswordgeneratorcode;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit2Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

procedure window_setup();
procedure interface_setup();
procedure language_setup();
procedure window_resize();
procedure setup();
function get_character():char;
function generate_password(amount:Byte):string;
function check_password_length(target:string):string;
var Form1: TForm1;

implementation

procedure window_setup();
begin
 Application.Title:='OPEN PASSWORD GENERATOR';
 Form1.Caption:='OPEN PASSWORD GENERATOR 0.4.6';
 Form1.BorderStyle:=bsDialog;
 Form1.Font.Name:=Screen.MenuFont.Name;
 Form1.Font.Size:=14;
end;

procedure interface_setup();
begin
Form1.Button1.ShowHint:=False;
Form1.Button1.Enabled:=False;
Form1.Button2.ShowHint:=Form1.Button1.ShowHint;
Form1.Button3.ShowHint:=Form1.Button1.ShowHint;
Form1.Button3.Enabled:=Form1.Button1.Enabled;
Form1.LabeledEdit1.NumbersOnly:=True;
Form1.LabeledEdit1.MaxLength:=3;
Form1.LabeledEdit1.Text:='8';
Form1.LabeledEdit2.Text:='';
Form1.LabeledEdit1.LabelPosition:=lpLeft;
Form1.LabeledEdit2.LabelPosition:=Form1.LabeledEdit1.LabelPosition;
end;

procedure language_setup();
begin
Form1.Button1.Caption:='Generate';
Form1.Button2.Caption:='Clear';
Form1.Button3.Caption:='Copy password to clipboard';
Form1.LabeledEdit1.EditLabel.Caption:='Length';
Form1.LabeledEdit2.EditLabel.Caption:='Password';
end;

procedure window_resize();
begin
Form1.Width:=Screen.DesktopWidth-10;
Form1.LabeledEdit2.Width:=Form1.ClientWidth;
end;

procedure setup();
begin
window_setup();
interface_setup();
language_setup();
window_resize();
Randomize();
end;

function get_character():char;
var code:Byte;
begin
code:=33+Random(94);
if (code>=94) and (code<97) then code:=97;
get_character:=chr(code);
end;

function generate_password(amount:Byte):string;
var index:Byte;
var target:string;
begin
target:='';
for index:=1 to amount do
begin
target:=target+get_character();
end;
generate_password:=target;
end;

function check_password_length(target:string):string;
var password_length:string;
begin
password_length:=target;
if password_length<>'' then
begin
if StrToInt(password_length)>255 then password_length:='8';
end;
check_password_length:=password_length;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
setup();
end;

procedure TForm1.FormResize(Sender: TObject);
begin
window_resize();
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
Form1.LabeledEdit2.Text:=generate_password(StrToInt(Form1.LabeledEdit1.Text));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Form1.LabeledEdit2.Text:='';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Form1.LabeledEdit2.SelectAll();
Form1.LabeledEdit2.CopyToClipboard();
end;

procedure TForm1.LabeledEdit1Change(Sender: TObject);
begin
Form1.LabeledEdit1.Text:=check_password_length(Form1.LabeledEdit1.Text);
Form1.Button1.Enabled:=Form1.LabeledEdit1.Text<>'';
end;

procedure TForm1.LabeledEdit2Change(Sender: TObject);
begin
Form1.Button3.Enabled:=Form1.LabeledEdit2.Text<>'';
end;

{$R *.lfm}

end.
