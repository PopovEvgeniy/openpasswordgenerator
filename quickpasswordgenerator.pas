unit quickpasswordgenerator;

{
 This password generation unit was made by Popov Evgeniy Alekseyevich.
 It is distributed under the GNU GENERAL PUBLIC LICENSE (Version 2 or higher).
}

{$IFDEF FPC}
 {$mode objfpc}
{$ENDIF}
{$H+}

interface

function generate_password(const amount:Byte):string;

implementation

function generate_password(const amount:Byte):string;
var index:Byte;
var target:string;
begin
 target:='';
 for index:=1 to amount do
 begin
  target:=target+chr(Random(94)+33);
 end;
 generate_password:=target;
end;

Initialization
 Randomize();
end.

end.
