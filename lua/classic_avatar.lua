AVATARS_DATA = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; -- global array which contains OpenGL id's of AVATARS
AVATARS_COMPONENTS = { };
AVATAR_PARTS = {};

function FROMOW_XICHT_PORTRAIT_PARTS(DATA)
	AVATAR_PARTS = DATA;
end;

OW_XICHT_PORTRAIT_GETPARTS(0);
AVATARS_COMPONENTS.MALE = AVATAR_PARTS;
OW_XICHT_PORTRAIT_GETPARTS(1);
AVATARS_COMPONENTS.FEMALE = AVATAR_PARTS;

function generateAvatar(INDEX, AVATAR, SEX, NATION)
	if NATION < 0 then
		NATION = 0;
	end;
	
	local id = OW_XICHT_PORTRAIT(
		0, 
		SEX,
		NATION,
		true,
		0,
		AVATAR[2],
		AVATAR[3],
		AVATAR[4],
		AVATAR[5],
		AVATAR[6],
		AVATAR[7],
		AVATAR[8],
		AVATAR[9],
		AVATAR[10],
		AVATAR[11],
		0,
		AVATAR[13],
		0
	);

	INDEX = parseInt(INDEX);

	if (AVATARS_DATA[INDEX] > 0) then
		OW_XICHT_PORTRAIT_FREETEXTURE(AVATARS_DATA[INDEX]);
	end;

	AVATARS_DATA[INDEX] = id;

	return id;
end;

function getAvatarID(INDEX)
	return AVATARS_DATA[INDEX];
end;

function setAvatar(SEX, NECK, FACE, CHEEK, EYE, NOSE, MOUTH, EAR, EYEBROW, HAIR, BEARD, GLASSES)
	OW_MULTIROOM_SET_MYAVATAR(SEX,'0;'..NECK..';'..FACE..';'..CHEEK..';'..EYE..';'..NOSE..';'..MOUTH..';'..EAR..';'..EYEBROW..';'..HAIR..';'..BEARD..';0;'..GLASSES..';0;');
end;

function clearAvatarCache()
	if AVATARS_DATA ~= nil then
		for i = 1, #AVATARS_DATA do
			OW_XICHT_PORTRAIT_FREETEXTURE(AVATARS_DATA[i]);
		end;

		AVATARS_DATA = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	end;
end;

function changeAvatarComponent(ID, INDEX)

end;
