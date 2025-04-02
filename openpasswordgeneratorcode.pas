unit openpasswordgeneratorcode;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Dialogs, ExtCtrls, StdCtrls;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    GenerateButton: TButton;
    CopyButton: TButton;
    LengthField: TLabeledEdit;
    PasswordField: TLabeledEdit;
    procedure GenerateButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LengthFieldChange(Sender: TObject);
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
 MainWindow.Caption:='Open password generator 0.5.7';
 MainWindow.BorderStyle:=bsDialog;
 MainWindow.Font.Name:=Screen.MenuFont.Name;
 MainWindow.Font.Size:=14;
end;

procedure interface_setup();
begin
 MainWindow.GenerateButton.Enabled:=True;
 MainWindow.CopyButton.Enabled:=False;
 MainWindow.GenerateButton.ShowHint:=False;
 MainWindow.CopyButton.ShowHint:=MainWindow.GenerateButton.ShowHint;
 MainWindow.LengthField.NumbersOnly:=True;
 MainWindow.PasswordField.Enabled:=False;
 MainWindow.LengthField.MaxLength:=2;
 MainWindow.LengthField.Text:='8';
 MainWindow.PasswordField.Text:='';
 MainWindow.LengthField.LabelPosition:=lpLeft;
 MainWindow.PasswordField.LabelPosition:=MainWindow.LengthField.LabelPosition;
end;

procedure language_setup();
begin
 MainWindow.GenerateButton.Caption:='Generate';
 MainWindow.CopyButton.Caption:='Copy a password to the clipboard';
 MainWindow.LengthField.EditLabel.Caption:='Length';
 MainWindow.PasswordField.EditLabel.Caption:='Password';
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

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 setup();
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

procedure TMainWindow.LengthFieldChange(Sender: TObject);
begin
 MainWindow.GenerateButton.Enabled:=MainWindow.LengthField.Text<>'';
end;

procedure TMainWindow.PasswordFieldChange(Sender: TObject);
begin
 MainWindow.CopyButton.Enabled:=MainWindow.PasswordField.Text<>'';
end;

{$R *.lfm}

end.
