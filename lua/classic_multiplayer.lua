-- constants & variables
BOX_IRC = 0;
BOX_SERVER = 1;

-- structure
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

menu.window_multiplayer.panel.IRC = clTextBoxWithTexture(
    menu.window_multiplayer.panel,
    anchorLTRB,
    XYWH(8, 18, 756, 435), 
    '',
    {
    	texture = 'classic/edit/textbox_irc.png',
        font_colour = BLACK(),
        nomouseevent = true,
        font_name = ADMUI3L,
    }
);

menu.window_multiplayer.panel.IRC2 = clTextBoxWithTexture(
    menu.window_multiplayer.panel,
    anchorLTRB,
    XYWH(1, 1, 1, 1), 
    '',
    {
    	visible = false,
    }
);

menu.window_multiplayer.panel.IRC.Users = clListBoxCustom(
	menu.window_multiplayer.panel, 
	XYWH(774, 18, 242, 435), 
	{
		added = 'clListBoxCustomItemNew(' .. BOX_IRC .. ', %id, %rowid, %index, %data);',
		updated = 'clListBoxCustomItemUpdate(' .. BOX_IRC .. ', %rowid, %index, %data);',
		selected = 'clListBoxCustomItemSelected(%rowid);',
		unselected = 'clListBoxCustomItemUnselected(%rowid);',
	},
	{
		texture = 'classic/edit/listbox_users.png'
	}
);

menu.window_multiplayer.panel.IRC2.Users = clListBoxCustom(
	menu.window_multiplayer.panel, 
	XYWH(1, 1, 1, 1), 
	{},
	{
		visible = false
	}
);

menu.window_multiplayer.panel.IRC.messageInput = getEditEX(
    menu.window_multiplayer.panel,
    anchorNone,
    XYWH(14, 460, 900, 14),
    BankGotic_14,
    '',
    '',
    {},
    {
        font_colour = BLACK(),
        font_name = Arial_14,
        callback_keypress = 'watchIRCMessage(%id, %k);'
    }
);

menu.window_multiplayer.panel.IRC.sendButton = clButton(
    menu.window_multiplayer.panel, 
    930, 
    457, 
    88,
    27, 
    loc(TID_InGame_Chat_Send), 
    'sendIRCMessage(' .. menu.window_multiplayer.panel.IRC.messageInput.ID .. ');',
    {
    	texture = 'classic/edit/menu_button_send_l.png',
    	texture2 = 'classic/edit/menu_button_send_c.png',
    	texture3 = 'classic/edit/menu_button_send_r.png'
    }
);

-- server list
menu.window_multiplayer.panel.serverList = clListBoxCustom(
	menu.window_multiplayer.panel, 
	XYWH(8, 504, 764, 215), 
	{
		added = 'clListBoxCustomServerItemNew(' .. BOX_SERVER .. ', %id, %rowid, %index, %data);',
		updated = 'clListBoxCustomItemServerUpdate(' .. BOX_SERVER .. ', %rowid, %index, %data);',
		selected = 'clListBoxCustomItemServerSelected(%rowid);',
		unselected = 'clListBoxCustomItemServerUnselected(%rowid);',
	},
	{
		texture = 'classic/edit/msservers_listbox.png'
	}
);

-- bottom buttons
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
    'ShowDialog(menu.window_multiplayer.createServer)',
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
    'clOpenPrompt(menu.window_multiplayer.enterIP.ID, nil)',
    {}
);

menu.window_multiplayer.createServer = clCreateServerDialog(dialog.back, 'createMultiplayerGame()', '');
menu.window_multiplayer.enterIP = clEnterIPDialog('joinToServer(1, 0)');
menu.window_multiplayer.enterPassword = clPrompt('joinToServer(0, 0)', {});
--setY(menu.window_multiplayer.enterPassword.prompt, getY(menu.window_multiplayer.enterPassword.prompt) + 5); --to make it obvious it is a second popup

-- handlers
function FROMOW_MULTIPLAYER_JOINFAILED(MESSAGE, STATUS)
    -- debug(STATUS);
end;

function FROMOW_MULTIPLAYER_DOJOINROOM(ADDRESS, PASSWORD)
	showMultiplayerWindow(1);

    if OW_ROOM_JOIN(ADDRESS, PASSWORD, false) then
        showMultiplayerGame();
    end;
end;

function FROMOW_MULTIPLAYER_HOSTGAME()
	showMultiplayerWindow(1);
end;

function FROMOW_MULTIPLAYER_OPEN()
	showMultiplayerWindow(1);
end;

function FROMOW_MULTIPLAYER_STARTGAME()
    IN_LOBBY = false;
    OW_IRC_DESTROY();
end;

function FROMOW_MULTIPLAYER_MODCHANGE()
	showMultiplayerWindow(0);
end;

----- functions -----
function showMultiplayerGame() -- TODO
  	IN_LOBBY = false;	
	debug('MultiplayerRoom');
	--setVisible(menu.window_multiplayer,false);
	--setVisible(Multi_Room,true);
	--multiroom_show();
end;

function createMultiplayerGame()
	local passwdText = '';

	if (getEnabled(menu.window_multiplayer.createServer.USE_PASSWD)) then
		passwdText = getText(menu.window_multiplayer.createServer.PASSWD);
	end;

	--ShowDialog(dialog.loadingMap);

	if OW_ROOM_CREATE(getText(menu.window_multiplayer.createServer.SERVER), passwdText) then
		showMultiplayerGame();
	end;

	--HideDialog(dialog.loadingMap);
end;

-- 0: without IP
-- 1: with IP
function joinToServer(MODE, ROOM_ID)
	clClosePrompt(menu.window_multiplayer.enterPassword.ID);
	clClosePrompt(menu.window_multiplayer.enterIP.ID);

	local password = getText(menu.window_multiplayer.enterPassword.prompt.input);

	if (parseInt(MODE) == 0) then
		if OW_ROOM_JOIN(ROOM_ID, password, false) then
            showMultiplayerGame();
        end;
	else
		local ip = getText(menu.window_multiplayer.enterIP.prompt.input);

		-- if 3rd param is true then error dialog is not display
		if OW_ROOM_JOIN_IP(ip, password, false) then --TODO: add password support
			showMultiplayerGame();
		end;
	end;
end;

-- watch message input IRC
function watchIRCMessage(INPUT_ID, KEY)
	if (KEY == VK_ESC) then
		setText({ID = INPUT_ID}, '');
		clearFocus();
	end;

	if (KEY == VK_ENTER) then
		sendIRCMessage(INPUT_ID);
	end;
end;

function getIRCActiveChannel()
	if (getIndex(menu.window_multiplayer.panel.IRC.Users.LIST) > 0) then
		return CUSTOM_LISTBOX_LIST[BOX_IRC][getIndex(menu.window_multiplayer.panel.IRC.Users.LIST)].name;
	end;

	return '';
end;

-- send message to IRC from current text input
function sendIRCMessage(INPUT_ID)
	local text = getText({ID = INPUT_ID});

	if (strlen(text) == 0) then
		return;
	end;

	OW_IRC_SENDTEXT(text, getIRCActiveChannel());
	setText({ID = INPUT_ID}, '');
end;

-- init multiplayer when user join to lobby
function initMultiplayer()
	OW_IRC_CREATE();
    OW_MULTI_ENABLE(true);
    IN_LOBBY = true;
end;

-- destroy multiplayer instance when user left lobby
function destroyMultiplayer()
    IN_LOBBY = false;
	OW_IRC_DESTROY();
	OW_MULTI_ENABLE(false);
end;

function showMultiplayerWindow(MODE)
	if MODE == 1 then
		showMenuButton(0);
		setVisible(menu.window_multiplayer, true);
		initMultiplayer();
	else
		destroyMultiplayer();
		setVisible(menu.window_multiplayer, false);
		showMenuButton(2);
	end;
end;

-- function which put text data intro controls. Should be replaced by something else
OW_IRC_BOXES(
	menu.window_multiplayer.panel.IRC.TEXTBOX.ID, 
	menu.window_multiplayer.panel.IRC.Users.LIST.ID,
	menu.window_multiplayer.panel.IRC2.TEXTBOX.ID, 
	menu.window_multiplayer.panel.IRC2.Users.LIST.ID
);

-- function which get server list data
OW_UI_SET_LOBBY_SERVERLISTBOX(menu.window_multiplayer.panel.serverList.LIST.ID);