MULTIPLAYER_ROOM_DATA = {};
MULTIPLAYER_ROOM_MAP_DATA = {};

menu.window_multiplayer_room = getElementEX(
    menu, 
    anchorNone, 
    XYWH(0, 0, LayoutWidth, LayoutHeight), 
    false, 
    {
        colour1 = BLACKA(150)
    }
);

menu.window_multiplayer_room.panel = getElementEX(
	menu.window_multiplayer_room, 
	anchorLTRB,
	XYWH(
		menu.window_multiplayer_room.width / 2 - 512, 
		menu.window_multiplayer_room.height / 2 - 384, 
		1024,
		768
	),
	true,
	{
		texture = 'classic/edit/multiroom/multiplayer_room.png'
	}
);

-- upper panel
menu.window_multiplayer_room.panel.quit = clButton(
    menu.window_multiplayer_room.panel, 
    19, 
    68, 
    150,
    30, 
    loc(TID_Multi_button_Leave_game), 
    'hideMultiplayerGame();',
    {}
);

menu.window_multiplayer_room.panel.changeAvatar = clButton(
    menu.window_multiplayer_room.panel, 
    19, 
    102, 
    150,
    30, 
    loc(TID_Main_Menu_ChangeAvatar),
    '',
    {}
);

menu.window_multiplayer_room.panel.start = clButton(
    menu.window_multiplayer_room.panel, 
    19, 
    136, 
    150,
    30, 
    loc(TID_Multi_button_Start_Game), 
    '',
    {}
);

menu.window_multiplayer_room.panel.mapName = getLabelEX(
    menu.window_multiplayer_room.panel,
    anchorLTRB,
    XYWH(12, 16, 326, 28),
    nil,
    loc(TID_InGame_NoName) .. '-' .. loc(TID_InGame_NoName), -- game name + game type,
    {
    	font_colour = BLACK(),
        nomouseevent = true,
        font_name = BankGotic_14,
        scissor = true,
        wordwrap = false
    }
); 

menu.window_multiplayer_room.panel.mapCount = getLabelEX(
    menu.window_multiplayer_room.panel,
    anchorR,
    XYWH(342, 16, 50, 28),
    nil,
    '12/12',
    {
    	font_colour = BLACK(),
        nomouseevent = true,
        font_name = BankGotic_14,
        scissor = true,
        wordwrap = false,
        text_halign = ALIGN_RIGHT
    }
); 

menu.window_multiplayer_room.panel.playerName = getLabelEX(
    menu.window_multiplayer_room.panel,
    anchorLTRB,
    XYWH(18, 48, 152, 14),
    nil,
    '', -- see showMultiplayerGame()
    {
    	font_colour = BLACK(),
        nomouseevent = true,
        font_name = BankGotic_14,
        scissor = true
    }
); 

menu.window_multiplayer_room.panel.status = getLabelEX(
    menu.window_multiplayer_room.panel,
    anchorLTRB,
    XYWH(12, 168, 372, 28),
    nil,
    '',
    {
    	font_colour = BLACK(),
        nomouseevent = true,
        font_name = BankGotic_14,
        scissor = true,
        wordwrap = true
    }
); 

-- chat
menu.window_multiplayer_room.panel.chat = clTextBoxWithTexture(
    menu.window_multiplayer_room.panel,
    anchorLTRB,
    XYWH(418, 24, 582, 180), 
    '',
    {
        font_colour = BLACK(),
        nomouseevent = true,
        font_name = ADMUI3L,
        padding = {x = 0, y = 0}
        -- added='setTextID(%id, %data);',
    }
);

menu.window_multiplayer_room.panel.chatInput = getEditEX(
    menu.window_multiplayer_room.panel,
    anchorNone,
    XYWH(420, 208, 578, 14),
    BankGotic_14,
    '',
    '',
    {},
    {
        font_colour = BLACK(),
        font_name = Arial_14,
        callback_keypress = 'sendChatMessage(%k);'
    }
);

textBoxTest = clTextBox(nil, anchorLTRB, XYWH(1, 1, 1, 1), 'test', {});

function sendChatMessage(key)
	if key == VK_ENTER then
		OW_MULTI_SENDALLCHATMSG(getText(menu.window_multiplayer_room.panel.chatInput), '#000000'); -- getHexColour(SIDE_COLOURS[Players[MyID].Colour+1]));
		setText(menu.window_multiplayer_room.panel.chatInput, '');
	end;
end;

OW_ROOM_SETUP(menu.window_multiplayer_room.panel.chat.TEXTBOX.ID, textBoxTest.ID, menu.window_multiplayer_room.panel.status.ID);

function FROMOW_MULTIROOM_GET_MAP_INFO_CALLBACK(DATA)
	MULTIPLAYER_ROOM_DATA.TeamDef = Data.TEAMDEF;
	MULTIPLAYER_ROOM_DATA.SideDef = Data.SIDEDEF;
	MULTIPLAYER_ROOM_DATA.MaxPlayers = getMaxMinPlayers(MULTIPLAYER_ROOM_DATA.TeamDef, MULTIPLAYER_ROOM_DATA.SideDef);
end;

function FROMOW_MULTIROOM_TEAMLIST(DATA)
--[[
	 PLAYERCOUNT Integer
	 PLAYERSMYPOS Integer
	 PLAYERS [1..12] of
		  NAME String
		  ALIVE Boolean
		  ISCOMP Boolean
		  NATION Integer
		  TEAM Integer
		  TEAMPOS Integer
		  SIDE Integer
		  COLOUR Integer
		  READY Boolean
		  LOCKED Boolean
		  TEAMREADY Boolean
		  PLID Integer (PLAYER ID)
		  ISSPEC Boolean
		  ISDEDI Boolean
		  AVATAR Array [1..14] of Byte
		  AVATARSEX Byte
		  PING Integer
--]]

	MULTIPLAYER_ROOM_DATA.PlayerCount = DATA.PLAYERCOUNT;
	MULTIPLAYER_ROOM_DATA.PlayerMyPos = DATA.PLAYERSMYPOS;
	MULTIPLAYER_ROOM_DATA.Players = DATA.PLAYERS;

	updatePlayersCount(MULTIPLAYER_ROOM_DATA.PlayerCount, MULTIPLAYER_ROOM_DATA.MaxPlayers);
end;

-- trigger each when map is changed
function FROMOW_MULTIROOM_UPDATE_MAP_NAME(DATA)
	MULTIPLAYER_ROOM_MAP_DATA = DATA;

	setText(menu.window_multiplayer_room.panel.mapName, trim(MULTIPLAYER_ROOM_MAP_DATA.MAPLOC) .. ' - ' .. trim(MULTIPLAYER_ROOM_MAP_DATA.GAMETYPELOC));

	-- get map info data
  	-- OW_MULTIROOM_GET_CURRENT_MAP_INFO();
end;

function FROMOW_MULTIROOM_UPDATE_MAP_SETTINGS(DATA)
	debug('FROMOW_MULTIROOM_UPDATE_MAP_SETTINGS');
end;

function FROMOW_MULTIROOM_UPDATE_MAP_GAMETYPE_LIST(DATA)
	debug('FROMOW_MULTIROOM_UPDATE_MAP_GAMETYPE_LIST');
end;

function FROMOW_MULTIROOM_GET_MAP_GAMETYPES_CALLBACK(DATA)
	debug('FROMOW_MULTIROOM_GET_MAP_GAMETYPES_CALLBACK');
end;

function FROMOW_MULTIROOM_TIMEOUT() -- Called by OW
    hideMultiplayerGame();
end;

function FROMOW_MULTIROOM_CONNSTATUS_NOTJOINED() -- Called by OW
	hideMultiplayerGame()
end;

function FROMOW_MULTIPLAYER_STARTGAME() -- Called by OW
    destroyMultiplayer();
    OW_IRC_DESTROY();
end;

function showMultiplayerGame()
  	IN_LOBBY = false;	
  	setVisible(menu.window_multiplayer, false);
  	setVisible(menu.window_multiplayer_room, true);

  	-- set player nickname
  	setText(menu.window_multiplayer_room.panel.playerName, getPlayerName());
end;

function hideMultiplayerGame()
	if (not IN_LOBBY) then
		OW_ROOM_LEAVE();
	end;

	IN_LOBBY = true;	
  	setVisible(menu.window_multiplayer_room, false);
  	setVisible(menu.window_multiplayer, true);
end;

function updatePlayersCount(currentCount, maxCount)
	local text = currentCount .. '/0';

	if (maxCount) then
		text = currentCount .. '/' .. maxCount;		
	end;

	setText(menu.window_multiplayer_room.panel.mapCount, text);
end;

function getMaxMinPlayers(SideDef, TeamDef)
	local MaxPlayers = 0;
	local MinPlayers = 0;
	local allPositionsCount = 0;

	for i = 1, 8 do
		if SideDef[i].ENABLED then
			allPositionsCount = allPositionsCount + 1;
		end;
	end;

	if not teamGame then
		MaxPlayers = TeamDef[1].SIDESMAX;
	else
		for i = 2, 9 do
			if TeamDef[i].NAME ~= '' then
				if TeamDef[i].SIDESMAX == -1 then
					MaxPlayers = MaxPlayers + TeamDef[i].ASSIGNED_POSITIONS_COUNT;
				else
					if TeamDef[i].SIDESMAX > TeamDef[i].ASSIGNED_POSITIONS_COUNT then
						MaxPlayers = MaxPlayers + TeamDef[i].ASSIGNED_POSITIONS_COUNT;
					else
						MaxPlayers = MaxPlayers + TeamDef[i].SIDESMAX;
					end;
				end;
			end;
		end;
	end;

	if MaxPlayers > allPositionsCount then
		MaxPlayers = allPositionsCount;
	end;

	return MaxPlayers;
end;