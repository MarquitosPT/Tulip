unit Pong.ControlManager;

interface

uses
  Vcl.Forms,
  Pong.Types,
  Tulip.UI;

type
  TPongControlManager = class(TAControlManager)
  private
    // Form Menu
    procedure MenuPlayClick(Sender: TObject);
    procedure MenuOptionsClick(Sender: TObject);
    procedure MenuAboutClick(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);

    // Form Options
    procedure OptionsOkClick(Sender: TObject);
    procedure OptionsCancelClick(Sender: TObject);

    // Form Pause
    procedure PauseContinueClick(Sender: TObject);
    procedure PauseOptionsClick(Sender: TObject);
    procedure PauseEndGameClick(Sender: TObject);

    // Form About
    procedure AboutCloseClick(Sender: TObject);
  public
    procedure Initialize();
  end;

implementation

{ TPongControlEngine }

procedure TPongControlManager.AboutCloseClick(Sender: TObject);
begin
  Aform('About').Close;

  // Set focus on first button
  AButton('Menu','Play').SetFocus;
end;

procedure TPongControlManager.Initialize;
begin
  LoadFromArchiveFile('Interface.asgui');

  // Form Menu Events
  AButton('Menu','Play').OnClick := MenuPlayClick;
  AButton('Menu','Options').OnClick := MenuOptionsClick;
  AButton('Menu','About').OnClick := MenuAboutClick;
  AButton('Menu','Exit').OnClick := MenuExitClick;

  // Form Options Events
  AButton('Options','Ok').OnClick := OptionsOkClick;
  AButton('Options','Cancel').OnClick := OptionsCancelClick;

  // Form Pause Events
  AButton('Pause','Continue').OnClick := PauseContinueClick;
  AButton('Pause','Options').OnClick := PauseOptionsClick;
  AButton('Pause','EndGame').OnClick := PauseEndGameClick;

  // Form About Events
  AButton('About','Close').OnClick := AboutCloseClick;

  // Set focus on first button
  AButton('Menu','Play').SetFocus;
end;

procedure TPongControlManager.MenuAboutClick(Sender: TObject);
begin
  AForm('About').Show(true);

  // Set focus on first button
  AButton('About','Close').SetFocus;
end;

procedure TPongControlManager.MenuExitClick(Sender: TObject);
begin
  (Parent as TForm).Close;
end;

procedure TPongControlManager.MenuOptionsClick(Sender: TObject);
begin
  AForm('Options').Show(true);
end;

procedure TPongControlManager.MenuPlayClick(Sender: TObject);
begin
  AForm('Menu').Close;

  GameState := gsPlaying;
end;

procedure TPongControlManager.OptionsCancelClick(Sender: TObject);
begin
  AForm('Options').Close;

  if AForm('Menu').Visible = true then
  begin
    // Set focus on first button
    AButton('Menu','Play').SetFocus;
  end;

  if AForm('Pause').Visible = true then
  begin
    // Set focus on first button
    AButton('Pause','Continue').SetFocus;
  end;
end;

procedure TPongControlManager.OptionsOkClick(Sender: TObject);
begin
  AForm('Options').Close;

  if AForm('Menu').Visible = true then
  begin
    // Set focus on first button
    AButton('Menu','Play').SetFocus;
  end;

  if AForm('Pause').Visible = true then
  begin
    // Set focus on first button
    AButton('Pause','Continue').SetFocus;
  end;
end;

procedure TPongControlManager.PauseContinueClick(Sender: TObject);
begin
  AForm('Pause').Close;

  GameState := gsPlaying;
end;

procedure TPongControlManager.PauseEndGameClick(Sender: TObject);
begin
  AForm('Pause').Close;
  AForm('Menu').Show(True);

  // Set focus on first button
  AButton('Menu','Play').SetFocus;

  GameState := gsMenu;
end;

procedure TPongControlManager.PauseOptionsClick(Sender: TObject);
begin
  AForm('Options').Show(True);
end;

end.
