unit openpasswordgeneratorcode;

{
 This sofware was made by Popov Evgeniy Alekseyevich.
 It is distributed under the GNU GENERAL PUBLIC LICENSE (Version 2 or higher).
}

{$mode objfpc}
{$H+}

interface

uses quickpasswordgenerator, Classes, SysUtils, Forms, Controls, Dialogs, ExtCtrls, StdCtrls, Menus;

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
    procedure PasswordFieldChange(Sender: TObject);
    procedure LengthFieldChange(Sender: TObject);
  private
    procedure window_setup();
    procedure interface_setup();
    procedure language_setup();
    procedure setup();
  public
    { public declarations }
  end; 

var MainWindow: TMainWindow;

implementation

procedure TMainWindow.window_setup();
begin
 Application.Title:='Open password generator';
 Self.Caption:='Open password generator 0.7.8';
 Self.BorderStyle:=bsSizeable;
 Self.Font.Name:=Screen.MenuFont.Name;
 Self.Font.Size:=14;
end;

procedure TMainWindow.interface_setup();
begin
 Self.GenerateButton.Enabled:=True;
 Self.CopyButton.Enabled:=False;
 Self.CutButton.Enabled:=False;
 Self.ClearButton.Enabled:=False;
 Self.GenerateButton.ShowHint:=True;
 Self.ClearButton.ShowHint:=True;
 Self.CopyButton.ShowHint:=True;
 Self.CutButton.ShowHint:=True;
 Self.PasswordField.Enabled:=False;
 Self.LengthField.NumbersOnly:=True;
 Self.LengthField.MaxLength:=2;
 Self.LengthField.Text:='8';
 Self.PasswordField.Text:='';
 Self.LengthField.LabelPosition:=lpLeft;
 Self.PasswordField.LabelPosition:=lpLeft;
 Self.LengthField.PopupMenu:=Self.EmptyMenu;
end;

procedure TMainWindow.language_setup();
begin
 Self.GenerateButton.Caption:='Generate';
 Self.CopyButton.Caption:='Copy';
 Self.CutButton.Caption:='Cut';
 Self.ClearButton.Caption:='Clear';
 Self.GenerateButton.Hint:='Generate a password';
 Self.CopyButton.Hint:='Copy the password to the clipboard';
 Self.CutButton.Hint:='Cut the password to the clipboard';
 Self.ClearButton.Hint:='Clear the password';
 Self.LengthField.EditLabel.Caption:='Length';
 Self.PasswordField.EditLabel.Caption:='Password';
end;

procedure TMainWindow.setup();
begin
 Self.window_setup();
 Self.interface_setup();
 Self.language_setup();
end;

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 Self.setup();
end;

procedure TMainWindow.FormResize(Sender: TObject);
begin
 Self.PasswordField.Width:=Self.ClientWidth;
 Self.Height:=Self.GenerateButton.Top+Self.GenerateButton.Height+10;
end;

procedure TMainWindow.GenerateButtonClick(Sender: TObject);
begin
 Self.PasswordField.Text:=generate_password(StrToInt(Self.LengthField.Text));
end;

procedure TMainWindow.CopyButtonClick(Sender: TObject);
begin
 Self.PasswordField.SelectAll();
 Self.PasswordField.CopyToClipboard();
end;

procedure TMainWindow.CutButtonClick(Sender: TObject);
begin
 Self.PasswordField.SelectAll();
 Self.PasswordField.CutToClipboard();
end;

procedure TMainWindow.ClearButtonClick(Sender: TObject);
begin
 Self.PasswordField.Clear();
end;

procedure TMainWindow.PasswordFieldChange(Sender: TObject);
begin
 Self.CopyButton.Enabled:=Self.PasswordField.Text<>'';
 Self.CutButton.Enabled:=Self.CopyButton.Enabled;
 Self.ClearButton.Enabled:=Self.CopyButton.Enabled;
end;

procedure TMainWindow.LengthFieldChange(Sender: TObject);
begin
 Self.GenerateButton.Enabled:=Self.LengthField.Text<>'';
 if Self.GenerateButton.Enabled then
 begin
  if StrToIntDef(Self.LengthField.Text,0)<=0 then Self.LengthField.Clear();
 end;

end;

{$R *.lfm}

end.
