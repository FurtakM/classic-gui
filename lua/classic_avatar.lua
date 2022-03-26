AVATARS_DATA = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; -- global array which contains OpenGL id's of AVATARS

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

function clearAvatarCache()
	if AVATARS_DATA ~= nil then
		for i = 1, #AVATARS_DATA do
			OW_XICHT_PORTRAIT_FREETEXTURE(AVATARS_DATA[i]);
		end;

		AVATARS_DATA = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	end;
end;