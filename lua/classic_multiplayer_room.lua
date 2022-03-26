MULTIPLAYER_ROOM_ACTIVE = false;
MULTIPLAYER_ROOM_DATA = {};
MULTIPLAYER_ROOM_MAP_DATA = {};
MULTIPLAYER_ROOM_ACTIVE_PAGE = 1;
MULTIPLAYER_ROOM_IS_HOST = false;
MULTIPLAYER_ROOM_IS_DEDI = false;
MULTIPLAYER_ROOM_MY_TEAM = 0;
MULTIPLAYER_ROOM_MY_PLID = 0;

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
    XYWH(12, 16, 326, 29),
    nil,
    loc(TID_InGame_NoName) .. '-' .. loc(TID_InGame_NoName), -- game name + game type,
    {
    	font_colour = BLACK(),
        nomouseevent = true,
        font_name = ADMUI3L,
        scissor = true,
        wordwrap = false
    }
); 

menu.window_multiplayer_room.panel.mapCount = getLabelEX(
    menu.window_multiplayer_room.panel,
    anchorR,
    XYWH(342, 16, 50, 29),
    nil,
    '12/12',
    {
    	font_colour = BLACK(),
        nomouseevent = true,
        font_name = ADMUI3L,
        scissor = true,
        wordwrap = false,
        text_halign = ALIGN_RIGHT
    }
); 

menu.window_multiplayer_room.panel.playerName = getLabelEX(
    menu.window_multiplayer_room.panel,
    anchorLTRB,
    XYWH(18, 48, 150, 14),
    nil,
    '', -- see showMultiplayerGame()
    {
    	font_colour = BLACK(),
        nomouseevent = true,
        font_name = ADMUI3L,
        scissor = true
    }
); 

menu.window_multiplayer_room.panel.status = getLabelEX(
    menu.window_multiplayer_room.panel,
    anchorLTRB,
    XYWH(14, 174, 370, 60),
    nil,
    '',
    {
    	font_colour = BLACK(),
        nomouseevent = true,
        font_name = ADMUI3L,
        scissor = true,
        wordwrap = true,
        text_halign = ALIGN_TOP,	
        text_valign = ALIGN_LEFT,
    }
); 

-- chat
menu.window_multiplayer_room.panel.chat = clTextBoxWithTexture(
    menu.window_multiplayer_room.panel,
    anchorLTRB,
    XYWH(412, 24, 596, 178), 
    '',
    {
        font_colour = BLACK(),
        nomouseevent = true,
        font_name = ADMUI3L,
        padding = {
        	x = 4,
        	y = 0
        }
        -- added='setTextID(%id, %data);',
    }
);

menu.window_multiplayer_room.panel.chatInput = getEditEX(
    menu.window_multiplayer_room.panel,
    anchorNone,
    XYWH(420, 208, 578, 14),
    ADMUI3L,
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

-- lower panel
menu.window_multiplayer_room.panel.page1Button = getElementEX(
	menu.window_multiplayer_room.panel, 
	anchorLTRB,
	XYWH(
		7, 
		243,
		60,
		26
	),
	true,
	{
		texture = 'classic/edit/multiroom/zalozka-players-on.png',
		callback_mousedown = 'multiRoomChangePage(1);'
	}
);

menu.window_multiplayer_room.panel.page2Button = getElementEX(
	menu.window_multiplayer_room.panel, 
	anchorLTRB,
	XYWH(
		67, 
		243,
		60,
		26
	),
	true,
	{
		texture = 'classic/edit/multiroom/zalozka-options-off.png',
		callback_mousedown = 'multiRoomChangePage(2);'
	}
);

menu.window_multiplayer_room.panel.page3Button = getElementEX(
	menu.window_multiplayer_room.panel, 
	anchorLTRB,
	XYWH(
		127, 
		243,
		60,
		26
	),
	true,
	{
		texture = 'classic/edit/multiroom/zalozka-map-off.png',
		callback_mousedown = 'multiRoomChangePage(3);'
	}
);

menu.window_multiplayer_room.panel.page4Button = getElementEX(
	menu.window_multiplayer_room.panel, 
	anchorLTRB,
	XYWH(
		187, 
		243,
		60,
		26
	),
	true,
	{
		texture = 'classic/edit/multiroom/zalozka-servers-off.png',
		callback_mousedown = 'multiRoomChangePage(4);'
	}
);

-- players page
menu.window_multiplayer_room.panel.page1 = getElementEX(
	menu.window_multiplayer_room.panel, 
	anchorLTRB,
	XYWH(
		7, 
		266,
		1011,
		490
	),
	true,
	{
		texture = 'classic/edit/multiroom/page.png'
	}
);

menu.window_multiplayer_room.panel.page1.playerSlots = getElementEX(
	menu.window_multiplayer_room.panel.page1, 
	anchorLTRB,
	XYWH(
		8, 
		8,
		750,
		470
	),
	true,
	{
		colour1 = WHITEA()
	}
);

-- check init player slots

menu.window_multiplayer_room.panel.page1.playerListDescription = getLabelEX(
	menu.window_multiplayer_room.panel.page1,
    anchorT, 
    XYWH(778, 9, 240, 12),
    nil, 
    loc(846), -- player list
    {
		nomouseevent = true,
        font_colour = WHITE(),
        font_name = BankGotic_14,
        wordwrap = true,
        text_halign = ALIGN_LEFT,
        text_valign = ALIGN_TOP,
        scissor = true
 	}
);

menu.window_multiplayer_room.panel.page1.playerListKick = clButton(
    menu.window_multiplayer_room.panel.page1,
    804, 
    338, 
    156,
    30, 
    loc(498), -- kick player
    'kickPlayer();',
    {}
);

menu.window_multiplayer_room.panel.page1.playerList = clListBox(
	menu.window_multiplayer_room.panel.page1, 
	XYWH(778, 24, 224, 312), 
	{}, 
	1, 
	'', 
	{}
);

-- game settings page
menu.window_multiplayer_room.panel.page2 = getElementEX(
	menu.window_multiplayer_room.panel, 
	anchorLTRB,
	XYWH(
		7, 
		266,
		1011,
		490
	),
	false,
	{
		texture = 'classic/edit/multiroom/page.png'
	}
);

-- map page
menu.window_multiplayer_room.panel.page3 = getElementEX(
	menu.window_multiplayer_room.panel, 
	anchorLTRB,
	XYWH(
		7, 
		266,
		1011,
		490
	),
	false,
	{
		texture = 'classic/edit/multiroom/page.png'
	}
);

-- other servers page
menu.window_multiplayer_room.panel.page4 = getElementEX(
	menu.window_multiplayer_room.panel, 
	anchorLTRB,
	XYWH(
		7, 
		266,
		1011,
		490
	),
	false,
	{
		texture = 'classic/edit/multiroom/page.png'
	}
);

-- events
OW_ROOM_SETUP(menu.window_multiplayer_room.panel.chat.TEXTBOX.ID, textBoxTest.ID, menu.window_multiplayer_room.panel.status.ID);

function FROMOW_MULTIROOM_GET_MAP_INFO_CALLBACK(DATA)
--[[
DATA Breakdown
    MULTIMAP Breakdown
        GAMETYPE      Integer
        DESCRIPTION      WideString
        RULES      WideString
        RANDOMNATIONS      Boolean
        ADDCOMPBUTTON     Boolean
        CANSPEC       Boolean
        MAPPARAMCOUNT     Integer
        RESTRICTTECH       Boolean
        RESTRICTBUILDINGS       Boolean

        MAPPARAMS [1..MAPPARAMCOUNT] of
            COUNT     Integer
            VALUE      default
            ITEMS of
                NAMES [1..COUNT] of WideString
                HINTS [1..COUNT] of WideString
            HINTS [1..2] of WideString

    TEAMDEF[1..9] of            1 isn't team
        NAME    String                without name isn't avalible         1 hasn't name
        SIDESMIN    Integer
        SIDESMAX    Integer
        ASSIGNED_POSITIONS[1..8] of Boolean
        ASSIGNED_POSITIONS_COUNT    Integer

    SIDEDEF[1..8] of
        NAME    String
        ENABLED    Boolean
        NATIONS of
            AR    Boolean
            US    Boolean
            RU    Boolean 
--]]

	MULTIPLAYER_ROOM_DATA.MULTIMAP = DATA.MULTIMAP;
	MULTIPLAYER_ROOM_DATA.SIDEDEF = DATA.SIDEDEF;
	MULTIPLAYER_ROOM_DATA.TEAMDEF = DATA.TEAMDEF;
	MULTIPLAYER_ROOM_DATA.TeamGame = getTeamGame(DATA.TEAMDEF);
	MULTIPLAYER_ROOM_DATA.MaxPlayers = getPlayersCount(DATA.TEAMDEF, DATA.SIDEDEF, MULTIPLAYER_ROOM_DATA.TeamGame);
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

	updateHostVisibilitySettings();
	updatePlayersCount(MULTIPLAYER_ROOM_DATA.PlayerCount, MULTIPLAYER_ROOM_DATA.MaxPlayers);
	updatePlayersOnServer(MULTIPLAYER_ROOM_DATA.Players);

	refreshPlayerView();
end;

-- trigger each when map is changed
function FROMOW_MULTIROOM_UPDATE_MAP_NAME(DATA)
	MULTIPLAYER_ROOM_MAP_DATA = DATA;

	setText(menu.window_multiplayer_room.panel.mapName, trim(MULTIPLAYER_ROOM_MAP_DATA.MAPLOC) .. ' - ' .. trim(MULTIPLAYER_ROOM_MAP_DATA.GAMETYPELOC));

	-- get map info data
  	OW_MULTIROOM_GET_CURRENT_MAP_INFO();
end;

function FROMOW_MULTIROOM_UPDATE_MAP_SETTINGS(DATA)
	--debug('FROMOW_MULTIROOM_UPDATE_MAP_SETTINGS');
end;

function FROMOW_MULTIROOM_UPDATE_MAP_GAMETYPE_LIST(DATA)
	--debug('FROMOW_MULTIROOM_UPDATE_MAP_GAMETYPE_LIST');
end;

function FROMOW_MULTIROOM_GET_MAP_GAMETYPES_CALLBACK(DATA)
	--debug('FROMOW_MULTIROOM_GET_MAP_GAMETYPES_CALLBACK');
end;

function FROMOW_MULTIROOM_TIMEOUT() -- Called by OW
    hideMultiplayerGame();
end;

function FROMOW_MULTI_PINGED(DATA)

end;

function FROMOW_MULTIROOM_CONSTATUS_UPDATE(DATA)

end;

function FROMOW_SGUI_RESTART() -- Called just before SGUI is restarted
	-- MULTIROOM_FREEAVATARS();
end;

function FROMOW_MULTIROOM_CONNSTATUS_NOTJOINED() -- Called by OW
	hideMultiplayerGame();
end;

function FROMOW_MULTIPLAYER_STARTGAME() -- Called by OW
    destroyMultiplayer();
    OW_IRC_DESTROY();
end;

function FROMOW_XICHT_PORTRAIT_PARTS(DATA)

end;


-- main functions
function showMultiplayerGame()
  	IN_LOBBY = false;	
  	MULTIPLAYER_ROOM_ACTIVE = true;
  	MULTIPLAYER_ROOM_IS_HOST = getvalue(OWV_IAMSERVER);
	MULTIPLAYER_ROOM_IS_DEDI = getvalue(OWV_IAMDEDIHOST);

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
	MULTIPLAYER_ROOM_ACTIVE = false;
  	setVisible(menu.window_multiplayer_room, false);
  	setVisible(menu.window_multiplayer, true);

  	MULTIPLAYER_ROOM_MY_TEAM = 0;
  	MULTIPLAYER_ROOM_IS_HOST = false;
  	MULTIPLAYER_ROOM_IS_DEDI = false;
  	MULTIPLAYER_ROOM_DATA = {};
  	MULTIPLAYER_ROOM_MAP_DATA = {};

  	sgui_deletechildren(menu.window_multiplayer_room.panel.page1.playerSlots.ID);
  	clearAvatarCache();
end;

function sendChatMessage(key)
	if key == VK_ENTER then
		OW_MULTI_SENDALLCHATMSG(getText(menu.window_multiplayer_room.panel.chatInput), '#000000'); -- getHexColour(SIDE_COLOURS[Players[MyID].Colour+1]));
		setText(menu.window_multiplayer_room.panel.chatInput, '');
		return;
	end;

	if key == VK_ESC then
		setText(menu.window_multiplayer_room.panel.chatInput, '');
		return;
	end;
end;

function multiRoomChangePage(page)
	local textures = {
		'zalozka-players-',
		'zalozka-options-',
		'zalozka-map-',
		'zalozka-servers-'
	};

	local pages = {
		{
			button = menu.window_multiplayer_room.panel.page1Button.ID,
			page = menu.window_multiplayer_room.panel.page1.ID
		},
		{
			button = menu.window_multiplayer_room.panel.page2Button.ID,
			page = menu.window_multiplayer_room.panel.page2.ID
		},
		{
			button = menu.window_multiplayer_room.panel.page3Button.ID,
			page = menu.window_multiplayer_room.panel.page3.ID
		},
		{
			button = menu.window_multiplayer_room.panel.page4Button.ID,
			page = menu.window_multiplayer_room.panel.page4.ID
		},
	};

	local basePath = 'classic/edit/multiroom/';

	setTextureID(pages[MULTIPLAYER_ROOM_ACTIVE_PAGE].button, basePath .. textures[MULTIPLAYER_ROOM_ACTIVE_PAGE] .. 'off');
	setTextureID(pages[page].button, basePath .. textures[page] .. 'on');
	setVisible({ID=pages[MULTIPLAYER_ROOM_ACTIVE_PAGE].page}, false);
	setVisible({ID=pages[page].page}, true);

	MULTIPLAYER_ROOM_ACTIVE_PAGE = page;
end;

function setMultiplayerOption(PARENT, OPTION, INDEX)
	getLabelEX(
	    PARENT,
	    anchorT, 
	    XYWH(
	    	10 + (((INDEX - 1) % 3) * 240),
	    	6 + (math.floor((INDEX - 1) / 3) * 60),
	    	240,
	    	14
	    ), 
	    nil,
	    OPTION.name,
	    {
	        font_colour = WHITE(),
            nomouseevent = true,
            font_name = BankGotic_14
	    }
	);
	
	clComboBox(
	    PARENT,
	    10 + (((INDEX - 1) % 3) * 240),
	    24 + (math.floor((INDEX - 1) / 3) * 60),
	    OPTION.list,
	    OPTION.default + 1,
	    'changeMultiplayerOption(' .. OPTION.id .. ', "INDEX")',
	    {
	        
	    }
	);

	-- set default value
	changeMultiplayerOption(OPTION.id, OPTION.default + 1);
end;

function changeMultiplayerOption(ID, INDEX)
	-- todo
end;

function selectPlayerOnPlayerList(INDEX)
	clSetListSelectedItem(menu.window_multiplayer_room.panel.page1.playerList.ID, INDEX);
end;

function kickPlayer()
	if (not MULTIPLAYER_ROOM_IS_HOST) then
		return;
	end;

	local index = clGetListSelectedIndex(menu.window_multiplayer_room.panel.page1.playerList.ID);
	local player = MULTIPLAYER_ROOM_DATA.Players[index].PLID;

	if (index == 1 or player == nil or player == 0) then
		return;
	end;

	OW_MULTIROOM_HOST_KICKPLAYER(player);
end;

function updateHostVisibilitySettings()
	-- hide/show kick player button if player is host
	setVisible(menu.window_multiplayer_room.panel.page1.playerListKick, MULTIPLAYER_ROOM_IS_HOST);
end;

--[[	 
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
function updatePlayersOnServer(players)
	local playersList = {};

	for i = 1, table.getn(players) do
		playersList = addToArray(playersList, players[i].NAME .. ' (' .. players[i].PLID .. ')');
	end;

	clSetListItems(menu.window_multiplayer_room.panel.page1.playerList, playersList, 0, 'selectPlayerOnPlayerList(INDEX);', {});
end;

function updatePlayersCount(currentCount, maxCount)
	local text = currentCount .. '/0';

	if (maxCount) then
		text = currentCount .. '/' .. maxCount;		
	end;

	setText(menu.window_multiplayer_room.panel.mapCount, text);
end;

function getPlayersCount(teamDef, sideDef, teamGame)
	local maxPlayers = 0;
	local allPositionsCount = 0;

	for i = 1, 8 do
		if sideDef[i].ENABLED then
			allPositionsCount = allPositionsCount + 1;
		end;
	end;

	if (not teamGame) then
		maxPlayers = teamDef[1].SIDESMAX;
	else
		for i = 2, 9 do
			if teamDef[i].NAME ~= '' then
				if teamDef[i].SIDESMAX == -1 then
					maxPlayers = maxPlayers + teamDef[i].ASSIGNED_POSITIONS_COUNT;
				else
					if teamDef[i].SIDESMAX > teamDef[i].ASSIGNED_POSITIONS_COUNT then
						maxPlayers = maxPlayers + teamDef[i].ASSIGNED_POSITIONS_COUNT;
					else
						maxPlayers = maxPlayers + teamDef[i].SIDESMAX;
					end;
				end;
			end;
		end;
	end;

	if maxPlayers > allPositionsCount then
		maxPlayers = allPositionsCount;
	end;

	return maxPlayers;
end;

function getTeamGame(teamDef)
	for i = 2, 9 do
		if teamDef[i].NAME ~= '' then
			return true;
		end;
	end;

	return false;
end;

-- generate SGUI slots for players
function refreshPlayerView()
	sgui_deletechildren(menu.window_multiplayer_room.panel.page1.playerSlots.ID);

	local teamPlayers  = { {}, {}, {}, {}, {}, {}, {}, {}, {}, {} }; -- array which storage data which player is in which team
	local playerMerged = { {}, {}, {}, {}, {}, {}, {}, {}, {}, {} }; -- array which contain merged players
	local playerSlots  = { {}, {}, {}, {}, {}, {}, {}, {}, {}, {} }; -- array which storage player slots id's

	if (#MULTIPLAYER_ROOM_DATA.Players > 0) then
		-- get my plid
		MULTIPLAYER_ROOM_MY_PLID = MULTIPLAYER_ROOM_DATA.Players[MULTIPLAYER_ROOM_DATA.PlayerMyPos + 1].PLID;

		for i = 1, #MULTIPLAYER_ROOM_DATA.Players do
			MULTIPLAYER_ROOM_DATA.Players[i].AVATAR_COMPONENT = generateAvatar(i, MULTIPLAYER_ROOM_DATA.Players[i].AVATAR, MULTIPLAYER_ROOM_DATA.Players[i].AVATARSEX, MULTIPLAYER_ROOM_DATA.Players[i].NATION);

			if (MULTIPLAYER_ROOM_DATA.Players[i].TEAM > 0) then
				teamPlayers[MULTIPLAYER_ROOM_DATA.Players[i].TEAM] = addToArray(teamPlayers[MULTIPLAYER_ROOM_DATA.Players[i].TEAM], i);
				playerMerged[MULTIPLAYER_ROOM_DATA.Players[i].TEAMPOS + 1] = addToArray(playerMerged[MULTIPLAYER_ROOM_DATA.Players[i].TEAMPOS + 1], MULTIPLAYER_ROOM_DATA.Players[i].PLID);
			end;
		end;
	end;

	if (MULTIPLAYER_ROOM_DATA.TEAMDEF == nil) then
		return;
	end;

	local posY = 0; -- start Y pos for elements

	-- generate team names
	for i = 2, 9 do
		if (MULTIPLAYER_ROOM_DATA.TEAMDEF[i].NAME ~= '') then
			teamLabel = getLabelEX(
			    menu.window_multiplayer_room.panel.page1.playerSlots, 
			    anchorT, 
			    XYWH(10, posY, menu.window_multiplayer_room.panel.page1.playerSlots.width - 10, 18), 
			    Tahoma_18B, 
			    MULTIPLAYER_ROOM_DATA.TEAMDEF[i].NAME,
			    {
			        wordwrap = true,
			        text_halign = ALIGN_MIDDLE,
			        text_valign = ALIGN_TOP,
			        font_colour = RGB(231, 222, 214),
			        shadowtext = true
			    }
			);

			posY = posY + 26;

			if (i == MULTIPLAYER_ROOM_MY_TEAM) then
				teamBtn = clButton(
				    menu.window_multiplayer_room.panel.page1.playerSlots, 
				    304, 
				    posY, 
				    150,
				    18, 
				    loc(825), -- leave
				    'leaveTeam();',
				    {
				    	texture = 'classic/edit/menu_button_small_l.png',
				    	texture2 = 'classic/edit/menu_button_small_c.png',
				    	texture3 = 'classic/edit/menu_button_small_r.png'
				    }
				);
			else
				teamBtn = clButton(
				    menu.window_multiplayer_room.panel.page1.playerSlots, 
				    304, 
				    posY, 
				    150,
				    18, 
				    loc(839), -- join
				    'joinToTeam(' .. i .. ', -1);',
				    {
				    	texture = 'classic/edit/menu_button_small_l.png',
				    	texture2 = 'classic/edit/menu_button_small_c.png',
				    	texture3 = 'classic/edit/menu_button_small_r.png'
				    }
				);
			end;

			if (#teamPlayers[i] > 0) then
				for p = 1, #teamPlayers[i] do				
					local playerData = MULTIPLAYER_ROOM_DATA.Players[teamPlayers[i][p]];
					local isMySlot = MULTIPLAYER_ROOM_MY_PLID == playerData.PLID;
					local isMerged = isMerged(playerData.PLID, playerData.TEAM, playerData.TEAMPOS, playerMerged[playerData.TEAMPOS + 1]);
					local slotExists = #playerSlots[i] >= playerData.TEAMPOS + 1;

					-- clDebug(playerSlots[i]);

					if (slotExists and isMerged) then
						local id = parseInt(playerSlots[i][playerData.TEAMPOS + 1]);

						if (id ~= nil) then
							setTextID(id, getTextID(id) .. ' + ' .. playerData.NAME);
						end;
					else
						posY = posY + 28;

						local slot = getElementEX(
							menu.window_multiplayer_room.panel.page1.playerSlots, 
							anchorLTRB,
							XYWH(
								2,
								posY, 
								750,
								24
							),
							true,
							{
								texture = 'classic/edit/multiroom/player_slot.png'
							}
						);

						local texture = 'notready';

						if (playerData.PLID == 1 and playerData.READY == true) then
							texture = 'server';
						elseif (playerData.READY == true) then
							texture = 'ready';
						end;

						local slotPlayerStatus = getElementEX(
							slot, 
							anchorLTRB,
							XYWH(
								4,
								2, 
								20,
								20
							),
							true,
							{
								texture = 'classic/edit/special/' .. texture .. '.png'
							}
						);

						local slotPlayerAvatar = getElementEX(
							slot, 
							anchorLTRB,
							XYWH(
								28,
								2, 
								20,
								20
							),
							true,
							{
								texture = 'Avatars/unknow.png'
							}
						);

						if (playerData.AVATAR_COMPONENT) then
							SGUI_settextureid(slotPlayerAvatar.ID, playerData.AVATAR_COMPONENT, 80, 100, 80, 100);
						end;

						local slotPlayerName = getLabelEX(
							slot,
						    anchorT, 
						    XYWH(50, 4, 260, 14),
						    nil, 
						    playerData.NAME, 
						    {
								nomouseevent = true,
						        font_colour = WHITE(),
						        font_name = BankGotic_14,
						        wordwrap = false,
						        text_halign = ALIGN_TOP,
						        text_valign = ALIGN_LEFT,
						        scissor = true
						 	}
						);

						playerSlots[i] = addToArray(playerSlots[i], slotPlayerName.ID);

						if (isMySlot and not isMerged) then
							local slotPlayerLock = clCheckbox(
							    slot,
							    659,
							    4,
							    'changeLockStatus(' .. boolToStr(not playerData.LOCKED) .. ');',
							    {
							        checked = playerData.LOCKED,
							        hint = loc(829)
							    }
							);

							local slotPlayerLockLabel = getLabelEX(
							    slot,
							    anchorLT,
							    XYWH(678, 4, 160, 16),
							    BankGotic_14, 
							    loc(828),
							    {
							        font_colour = RGB(0, 0, 0),
							        shadowtext = false,
							        nomouseevent = true,
							        text_halign = ALIGN_LEFT,
							        text_valign = ALIGN_TOP,
							        wordwrap = false,
							        scissor = true
							    }
							);
						else
							if (isMerged) then
								local leavePlayer = clButton(
								    slot, 
								    660, 
								    3, 
								    84,
								    18, 
								    loc(844), -- separate
								    'joinToTeam(' .. i .. ', -1);',
								    {
								    	texture = 'classic/edit/menu_button_small_l.png',
								    	texture2 = 'classic/edit/menu_button_small_c.png',
								    	texture3 = 'classic/edit/menu_button_small_r.png'
								    }
								);
							else
								local joinToPlayer = clButton(
								    slot, 
								    660, 
								    3, 
								    84,
								    18, 
								    loc(839), -- join
								    'joinToTeam(' .. i .. ', ' .. playerData.TEAMPOS .. ');',
								    {
								    	texture = 'classic/edit/menu_button_small_l.png',
								    	texture2 = 'classic/edit/menu_button_small_c.png',
								    	texture3 = 'classic/edit/menu_button_small_r.png'
								    }
								);
							end;
						end;
					end;
				end;
			end;

			posY = posY + 38;
		end;
	end;
end;

function isMerged(plid, team, teamPos, mergedPlayers)
	if (#mergedPlayers < 2) then
		return false;
	end;

	for i = 1, #mergedPlayers do
		local player = getPlayerByPLID(mergedPlayers[i]);

		if (mergedPlayers[i] ~= plid and team == player.TEAM and teamPos == player.TEAMPOS) then
			return true;
		end;
	end;

	return false;
end;

function getPlayerByPLID(plid)
	if (#MULTIPLAYER_ROOM_DATA.Players == 0) then
		return {};
	end;

	for i = 1, #MULTIPLAYER_ROOM_DATA.Players do
		if (MULTIPLAYER_ROOM_DATA.Players[i].PLID == plid) then
			return MULTIPLAYER_ROOM_DATA.Players[i];
		end;
	end;
end;

function changeLockStatus(isLocked)
	OW_MULTIROOM_SET_MYLOCKED(isLocked);
end;

-- join to team
function joinToTeam(teamID, teamPos)
	OW_MULTIROOM_SET_MYTEAMANDPOS(teamID, teamPos);
	OW_MULTIROOM_SET_MYISSPEC(false);
	MULTIPLAYER_ROOM_MY_TEAM = teamID;
end;

function leaveTeam()
	OW_MULTIROOM_SET_MYTEAMANDPOS(0, -1);
	OW_MULTIROOM_SET_MYISSPEC(false);
	resetPlayerData(true);
	MULTIPLAYER_ROOM_MY_TEAM = 0;
end;

-- reset player data
-- resetColour : bool
function resetPlayerData(resetColour)
	if resetColour == true then
		OW_MULTIROOM_SET_MYCOLOUR(0);
	end;

	OW_MULTIROOM_SET_MYSIDE(0);
	OW_MULTIROOM_SET_MYNATION(0);
end;