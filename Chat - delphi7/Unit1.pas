unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls;

type
  Tchatfal = class(TForm)
    quadro: TMemo;
    status: TMemo;
    c_comandos: TGroupBox;
    c_texto: TEdit;
    host: TEdit;
    apelido: TEdit;
    conectar: TButton;
    servir: TButton;
    Label1: TLabel;
    Label2: TLabel;
    s_cliente: TClientSocket;
    s_server: TServerSocket;
    procedure FormCreate(Sender: TObject);
    procedure c_textoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure conectarClick(Sender: TObject);
    procedure s_clienteConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure s_clienteDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure s_clienteError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure s_clienteRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure servirClick(Sender: TObject);
    procedure s_serverListen(Sender: TObject; Socket: TCustomWinSocket);
    procedure s_serverClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure s_serverClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure s_serverClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  chatfal: Tchatfal;

implementation

{$R *.dfm}

procedure Tchatfal.FormCreate(Sender: TObject);
begin
quadro.text := '';
end;

procedure Tchatfal.c_textoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = vk_return then
begin
s_cliente.socket.sendtext(c_texto.text+'::::' +apelido.text);
c_texto.text := '';
end;
end;

procedure Tchatfal.conectarClick(Sender: TObject);
begin
if s_cliente.active then
begin
s_cliente.active := false;
conectar.caption := 'Conectar';
end
else begin
s_cliente.host := host.text;
s_cliente.active := true;
end;
end;

procedure Tchatfal.s_clienteConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
status.lines.add('cliente ::> conectado a: ' + s_cliente.host);
conectar.Caption := 'Desconectar';
apelido.enabled := false;
s_cliente.socket.sendtext('NICK::::' + apelido.text);
end;

procedure Tchatfal.s_clienteDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
status.lines.add('Cliente ::> desconectado ');
conectar.caption := 'conectar';
apelido.enabled := true;
end;

procedure Tchatfal.s_clienteError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
status.lines.Add('Cliente ::> ERRO ao tentar conectar a: ' + s_cliente.Host);
end;

procedure Tchatfal.s_clienteRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
quadro.Lines.add(socket.receivetext);
end;

procedure Tchatfal.servirClick(Sender: TObject);
begin
if s_server.active = true then
begin
s_server.Active := false;
status.lines.Add('Servidor ::> Servidor Desligado!');
servir.Caption := 'Iniciar Servidor';
s_cliente.active := false;
host.Enabled := true;
conectar.Enabled := true;
end
else begin
s_server.active := true;
servir.Caption := 'Parar Servidor';
host.Enabled := false;
conectar.Enabled := false;
s_cliente.Host := '127.0.0.1';
s_cliente.Active := true;
end;
end;

procedure Tchatfal.s_serverListen(Sender: TObject;
  Socket: TCustomWinSocket);
begin
status.Lines.add('Servidor ::> Servidor Ligado!');
end;

procedure Tchatfal.s_serverClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
status.Lines.add('Servidor ::> Usuario Conectado => '+socket.RemoteAddress);
end;

procedure Tchatfal.s_serverClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
status.Lines.add('Servidor ::> Usuario Desconectado => '+socket.RemoteAddress);
end;

procedure Tchatfal.s_serverClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
  var texto: array[0..1] of string;
  temptexto: string;
  index: integer;
begin
temptexto := socket.receivetext;
texto[0] := copy(temptexto, 1, pos('::::', temptexto) -1);
texto[1] := copy(temptexto, pos('::::', temptexto) + length('::::'), length(temptexto));
if texto[0] = 'NICK' then {Verifica se a mensagem eh de entrada}
begin
with s_server.socket do begin {Se a msg for se entrada avisa a todos os clientes quem entrou}
for index := 0 to activeconnections-1 do begin
connections[index].sendtext(texto[1] + 'entrou na sala:');
end;
end;
end
else begin
with s_server.Socket do begin {Se nao for de entrada, entao eh msg normal, no caso passa para todos a msg}
for index := 0 to activeconnections-1 do begin
connections[index].sendtext('(' +texto[1] +')escreveu:' +texto[0]);
end;
end;
status.Lines.add('Servidor ::> '+texto[1] +'('+socket.RemoteAddress +') escreveu:'+texto[0]);
end;
end;

end.
