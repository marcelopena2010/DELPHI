object chatfal: Tchatfal
  Left = 192
  Top = 124
  Width = 696
  Height = 480
  Caption = 'ChatFal'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 32
    Width = 39
    Height = 13
    Caption = 'Servidor'
  end
  object Label2: TLabel
    Left = 48
    Top = 56
    Width = 35
    Height = 13
    Caption = 'Apelido'
  end
  object quadro: TMemo
    Left = 250
    Top = 8
    Width = 305
    Height = 80
    Lines.Strings = (
      'quadro')
    TabOrder = 0
  end
  object status: TMemo
    Left = 250
    Top = 88
    Width = 305
    Height = 80
    Lines.Strings = (
      'status')
    TabOrder = 1
  end
  object c_comandos: TGroupBox
    Left = 248
    Top = 184
    Width = 185
    Height = 105
    Caption = 'C_Comandos'
    TabOrder = 2
  end
  object c_texto: TEdit
    Left = 264
    Top = 208
    Width = 121
    Height = 21
    TabOrder = 3
    OnKeyDown = c_textoKeyDown
  end
  object host: TEdit
    Left = 88
    Top = 32
    Width = 153
    Height = 21
    TabOrder = 4
  end
  object apelido: TEdit
    Left = 88
    Top = 56
    Width = 153
    Height = 21
    TabOrder = 5
  end
  object conectar: TButton
    Left = 88
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Conectar'
    TabOrder = 6
    OnClick = conectarClick
  end
  object servir: TButton
    Left = 168
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Servir'
    TabOrder = 7
    OnClick = servirClick
  end
  object s_cliente: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 666
    OnConnect = s_clienteConnect
    OnDisconnect = s_clienteDisconnect
    OnRead = s_clienteRead
    OnError = s_clienteError
    Left = 592
    Top = 24
  end
  object s_server: TServerSocket
    Active = False
    Port = 666
    ServerType = stNonBlocking
    OnListen = s_serverListen
    OnClientConnect = s_serverClientConnect
    OnClientDisconnect = s_serverClientDisconnect
    OnClientRead = s_serverClientRead
    Left = 592
    Top = 64
  end
end
