menu.window_multiplayer = getElementEX(
    menu, 
    anchorNone, 
    XYWH(0, 0, LayoutWidth, LayoutHeight), 
    false, 
    {
        colour1 = BLACKA(150)
    }
);

menu.window_multiplayer.panel = getElementEX(
	menu.window_multiplayer, 
	anchorLTRB,
	XYWH(
		menu.window_multiplayer.width / 2 - 512, 
		menu.window_multiplayer.height / 2 - 384, 
		1024,
		768
	),
	true,
	{
		texture = 'classic/edit/multiplayer_window.png'
	}
);

menu.window_multiplayer.panel.quit = clButton(
    menu.window_multiplayer.panel, 
    46, 
    723, 
    184,
    30, 
    loc(TID_Main_Menu_Back_To_Menu), 
    'showMultiplayerWindow(0);',
    {}
);


menu.window_multiplayer.panel.changeName = clButton(
    menu.window_multiplayer.panel, 
    233, 
    723, 
    184,
    30, 
    loc(TID_Main_Menu_Change_Name), 
    '',
    {}
);

menu.window_multiplayer.panel.createGame = clButton(
    menu.window_multiplayer.panel, 
    420, 
    723, 
    184,
    30, 
    loc(TID_Multi_button_create_server), 
    '',
    {}
);

menu.window_multiplayer.panel.joinGame = clButton(
    menu.window_multiplayer.panel, 
    607, 
    723, 
    184,
    30, 
    loc(TID_Multi_button_join_game), 
    '',
    {}
);

menu.window_multiplayer.panel.setIPAddr = clButton(
    menu.window_multiplayer.panel, 
    794, 
    723, 
    184,
    30, 
    loc(TID_Multi_button_enter_ip), 
    '',
    {}
);

function showMultiplayerWindow(MODE)
	if MODE == 1 then
		showMenuButton(0);
		setVisible(menu.window_multiplayer, true);
	else
		setVisible(menu.window_multiplayer, false);
		showMenuButton(2);
	end;
end;