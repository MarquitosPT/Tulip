program PongDemo;

uses
  Vcl.Forms,
  Pong.MainForm in 'Pong.MainForm.pas' {MainForm},
  Pong.Types in 'Pong.Types.pas',
  Pong.ControlManager in 'Pong.ControlManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
