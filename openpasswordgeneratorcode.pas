unit openpasswordgeneratorcode;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Dialogs, ExtCtrls, LCLType,StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: char);
    procedure LabeledEdit2Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

procedure window_setup();
procedure interface_setup();
procedure window_resize();
procedure setup();
procedure restrict_input(var key:char);
function check_input(input:string):Boolean;
function get_character():char;
function generate_password(length:Word):string;
procedure check_password_length();
var Form1: TForm1;

implementation

procedure window_setup();
begin
 Application.Title:='OPEN PASSWORD GENERATOR';
 Form1.Caption:='OPEN PASSWORD GENERATOR 0.3.7';
 Form1.Font.Name:=Screen.MenuFont.Name;
 Form1.Font.Size:=14;
 Form1.Top:=0;
 Form1.Left:=Form1.Top;
end;

procedure interface_setup();
begin
Form1.Button1.ShowHint:=False;
Form1.Button1.Enabled:=False;
Form1.Button2.ShowHint:=Form1.Button1.ShowHint;
Form1.Button3.ShowHint:=Form1.Button1.ShowHint;
Form1.Button4.ShowHint:=Form1.Button1.ShowHint;
Form1.Button3.Enabled:=Form1.Button1.Enabled;
Form1.LabeledEdit1.MaxLength:=3;
Form1.LabeledEdit1.Text:='';
Form1.LabeledEdit2.Text:=Form1.LabeledEdit1.Text;
Form1.LabeledEdit1.LabelPosition:=lpLeft;
Form1.LabeledEdit2.LabelPosition:=Form1.LabeledEdit1.LabelPosition;
Form1.Button1.Caption:='Generate';
Form1.Button2.Caption:='Clear';
Form1.Button3.Caption:='Copy password to clipboard';
Form1.Button4.Caption:='About Open password generator';
Form1.LabeledEdit1.EditLabel.Caption:='Length';
Form1.LabeledEdit2.EditLabel.Caption:='Password';
end;

procedure window_resize();
begin
Form1.Width:=Screen.DesktopWidth;
Form1.Height:=Form1.Button1.Top+Form1.Button2.Height+10;
Form1.LabeledEdit2.Width:=Form1.ClientWidth;
end;

procedure setup();
begin
window_setup();
interface_setup();
window_resize();
Randomize();
end;

procedure restrict_input(var key:char);
begin
if (ord(key)<ord('0')) or (ord(key)>ord('9')) then
begin
if ord(key)<>VK_BACK then
begin
key:=#0;
end;

end;

end;

function check_input(input:string):Boolean;
var target:Boolean;
begin
target:=True;
if input='' then
begin
target:=False;
end;
check_input:=target;
end;

function get_character():char;
var code:Byte;
begin
code:=33+Random(94);
if (code>=94) and (code<97) then code:=97;
get_character:=chr(code);
end;

function generate_password(length:Word):string;
var index:Word;
var target:string;
begin
target:='';
for index:=1 to length do
begin
target:=target+get_character();
end;
generate_password:=target;
end;

procedure check_password_length();
begin
if (Form1.LabeledEdit1.Text<>'') and (StrToInt(Form1.LabeledEdit1.Text)>255) then
begin
ShowMessage('Maximum password length is 255');
Form1.LabeledEdit1.Text:='';
end;

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
var length:Word;
begin
length:=StrToInt(Form1.LabeledEdit1.Text);
Form1.LabeledEdit2.Text:=generate_password(length);
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

procedure TForm1.Button4Click(Sender: TObject);
begin
ShowMessage('Open password generator. Version 0.3.7. Created by Popov Evgeniy Alekseyevich. This program distributed under GNU GENERAL PUBLIC LICENSE');
end;

procedure TForm1.LabeledEdit1Change(Sender: TObject);
begin
check_password_length();
Form1.Button1.Enabled:=check_input(Form1.LabeledEdit1.Text);
end;

procedure TForm1.LabeledEdit1KeyPress(Sender: TObject; var Key: char);
begin
restrict_input(Key);
end;

procedure TForm1.LabeledEdit2Change(Sender: TObject);
begin
Form1.Button3.Enabled:=check_input(Form1.LabeledEdit2.Text);
end;

{$R *.lfm}

end.
