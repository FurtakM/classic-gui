# Original War Classic GUI

![classic](https://github.com/user-attachments/assets/9fd668f1-e75b-4339-9e14-0da9824b9b42)

Classic GUI for Original War is a lua version of well known interface from 2001 with a few new features, such as:
- Skirmish window
- Achievements window
- Mods list window
- Multiplayer lobby & game room windows

## Installation
Classic GUI is a part of vanilla game since 3.0.9.288 patch. Still, you can download and use it as a base for your interface. 
Files are located inside patch3.owp (ClassicMenu directory) - use Pakview.exe to unzip the archive. As alternative, you can download the files from this repository.

Put all classic_....lua files into %YOUR_MOD%/lua.
Create mod.lua file (if not exist) and put it into %YOUR_MOD%/lua as well.
Open mod.lua and put this line at the top:
```sh
include('classic_init');

// your code
```
Save changes and enjoy.

## License

MIT

**Feel free to use it in your mod.**
