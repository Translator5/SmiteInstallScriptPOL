Windows-Software Install Script - PlayOnLinux/PlayOnMac
---

This is a mostly automated script for [PlayOnMac/PlayOnLinux] that will install your choosen Game.
To choose a game browse the branches of this repository.

##Required on Linux for [Smite]

"echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope"
or manually
"kernel.yama.ptrace_scope = 0" in /etc/sysctl.d/10-ptrace.conf

["More Information about"]

## Install

* Be sure to have [PlayOnMac/PlayOnLinux] installed.
* From the `Tools` menu choose `Run a Local Script` and select e.g. [`Smite.sh`](./Smite.sh).
* Follow the install instructions.

###### Note: The auto-download is unreliable due to the installer executable/checksum changing occasionally. It is recommended to download the [installer] separately and choose to install via the local option.

## Post-Install

###### Crash on open Shop in [League of Legends]
Navigate to the install directory and configure the game.cfg by adding "x3d_platform=1" below [General].
```
home/user//.PlayOnLinux/wineprefix/LeagueOfLegends/drive_c/Riot Games/League of Legends/Config/game.cfg
```

###### Black-Screen issue in Smite
This issue can be fixed by running the game in windowed or borderless window mode. You can edit the following file to change the settings:

```
~/Documents/My\ Games/Smite/BattleGame/Config/BattleSystemSettings.ini
```

(This is the directory on OS X. Please create an issue if this is different on Linux.)

Look for the `Fullscreen` line and set it false. `Borderless` can also be set to `true` here.

OS X users can use [`Mac Resolution Edit.command`](./Mac%20Resolution%20Edit.command) to edit the file. Launch the game at least once before attempting to run the script.

[PlayOnMac/PlayOnLinux]: https://www.playonlinux.com
[Smite]: http://www.smitegame.com
[League of Legends]: http://euw.leagueoflegends.com
[Pretty TV]: http://schoener-fernsehen.com
[World of Tanks]: http://worldoftanks.com
[installer]: http://hirez.http.internapcdn.net/hirez/InstallSmite.exe
["More Information about"]: https://www.playonlinux.com/en/topic-10534-Regarding_ptrace_scope_fatal_error.html
...
Wine 1.9.10 - 27. May 2016