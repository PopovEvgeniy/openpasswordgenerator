unit openpasswordgeneratorcode;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Dialogs, ExtCtrls, StdCtrls, Menus, LCLType;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    GenerateButton: TButton;
    CopyButton: TButton;
    CutButton: TButton;
    ClearButton: TButton;
    LengthField: TLabeledEdit;
    PasswordField: TLabeledEdit;
    EmptyMenu: TPopupMenu;
    procedure GenerateButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure LengthFieldChange(Sender: TObject);
    procedure LengthFieldKeyPress(Sender: TObject; var Key: char);
    procedure PasswordFieldChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var MainWindow: TMainWindow;

implementation

procedure window_setup();
begin
 Application.Title:='Open password generator';
 MainWindow.Caption:='Open password generator 0.7';
 MainWindow.BorderStyle:=bsSizeable;
 MainWindow.Font.Name:=Screen.MenuFont.Name;
 MainWindow.Font.Size:=14;
end;

procedure interface_setup();
begin
 MainWindow.GenerateButton.Enabled:=True;
 MainWindow.CopyButton.Enabled:=False;
 MainWindow.CutButton.Enabled:=False;
 MainWindow.ClearButton.Enabled:=False;
 MainWindow.GenerateButton.ShowHint:=True;
 MainWindow.ClearButton.ShowHint:=True;
 MainWindow.CopyButton.ShowHint:=True;
 MainWindow.CutButton.ShowHint:=True;
 MainWindow.PasswordField.Enabled:=False;
 MainWindow.LengthField.MaxLength:=2;
 MainWindow.LengthField.Text:='8';
 MainWindow.PasswordField.Text:='';
 MainWindow.LengthField.LabelPosition:=lpLeft;
 MainWindow.PasswordField.LabelPosition:=lpLeft;
 MainWindow.LengthField.PopupMenu:=MainWindow.EmptyMenu;
end;

procedure language_setup();
begin
 MainWindow.GenerateButton.Caption:='Generate';
 MainWindow.CopyButton.Caption:='Copy';
 MainWindow.CutButton.Caption:='Cut';
 MainWindow.ClearButton.Caption:='Clear';
 MainWindow.GenerateButton.Hint:='Generate a password';
 MainWindow.CopyButton.Hint:='Copy the password to the clipboard';
 MainWindow.CutButton.Hint:='Cut the password to the clipboard';
 MainWindow.ClearButton.Hint:='Clear the password';
 MainWindow.LengthField.EditLabel.Caption:='Length';
 MainWindow.PasswordField.EditLabel.Caption:='Password';
end;

procedure setup();
begin
 window_setup();
 interface_setup();
 language_setup();
end;

procedure restrict_input(var key:char);
begin
 if not (key in ['0'..'9']) then
 begin
  if ord(key)<>VK_BACK then key:=#0;
 end;

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

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 setup();
end;

procedure TMainWindow.FormResize(Sender: TObject);
begin
 MainWindow.PasswordField.Width:=MainWindow.ClientWidth;
 MainWindow.Height:=MainWindow.GenerateButton.Top+MainWindow.GenerateButton.Height+10;
end;

procedure TMainWindow.GenerateButtonClick(Sender: TObject);
begin
 MainWindow.PasswordField.Text:=generate_password(StrToInt(MainWindow.LengthField.Text));
end;

procedure TMainWindow.CopyButtonClick(Sender: TObject);
begin
 MainWindow.PasswordField.SelectAll();
 MainWindow.PasswordField.CopyToClipboard();
end;

procedure TMainWindow.CutButtonClick(Sender: TObject);
begin
 MainWindow.PasswordField.SelectAll();
 MainWindow.PasswordField.CutToClipboard();
end;

procedure TMainWindow.ClearButtonClick(Sender: TObject);
begin
 MainWindow.PasswordField.Text:='';
end;

procedure TMainWindow.LengthFieldChange(Sender: TObject);
begin
 MainWindow.GenerateButton.Enabled:=MainWindow.LengthField.Text<>'';
end;

procedure TMainWindow.LengthFieldKeyPress(Sender: TObject; var Key: char);
begin
 restrict_input(Key);
end;

procedure TMainWindow.PasswordFieldChange(Sender: TObject);
begin
 MainWindow.CopyButton.Enabled:=MainWindow.PasswordField.Text<>'';
 MainWindow.CutButton.Enabled:=MainWindow.CopyButton.Enabled;
 MainWindow.ClearButton.Enabled:=MainWindow.CopyButton.Enabled;
end;

{$R *.lfm}

end.
