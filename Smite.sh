#!/usr/bin/env playonlinux-bash
# A PlayOnLinux/Mac install script for SMITE.
# Date : (2015-08-18)
# Last revision : (2016-08-05 22:22)
# Wine version used : 1.9.15-staging
# Distribution used to test : Linux Mint 18
# Licence : GPLv3
# Author : Rolando Islas, Translator5

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE=".NET Framework 3.5 & Smite"
TITLE1=".NET Framework 3.5"
TITLE2="SMITE"
PREFIX="Smite"
WINEVERSION="1.9.18-staging"

{
POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_message "Before you start the installation, you should download the and the .NET Framework 3.5 installer and the Smite installer. This kind of installation is more understandable!" "REQUISITES"
POL_SetupWindow_presentation "$TITLE1" "https://www.microsoft.com/en-US/download/details.aspx?id=21" "Windows"
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE" "" "Windows Executables (*.exe)|*.exe;*.EXE"
	DOTNET35_INSTALLER="$APP_ANSWER"

POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

if [ "$INSTALL_METHOD" = "LOCAL" ]; then
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE2" "" "Windows Executables (*.exe)|*.exe;*.EXE"
	FULL_INSTALLER="$APP_ANSWER"
else
	POL_System_TmpCreate "$PREFIX"

	DOWNLOAD_URL="http://hirez.http.internapcdn.net/hirez/InstallSmite.exe"
	DOWNLOAD_MD5="9cdc39efb3c26e5d10b023d5a015ff7e"
	DOWNLOAD_FILE="$POL_System_TmpDir/$(basename "$DOWNLOAD_URL")"

	POL_Call POL_Download_retry "$DOWNLOAD_URL" "$DOWNLOAD_FILE" "$DOWNLOAD_MD5" "$TITLE installer"

	SMITE_INSTALLER="$DOWNLOAD_FILE"
fi
}

POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
Set_OS "win7"
if [ "$POL_OS" = "Linux" ]; then
	POL_Call POL_Function_RootCommand "echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope; exit"
fi

{
POL_Call POL_Install_flashplayer
POL_Call POL_Install_corefonts
POL_Call POL_Install_gdiplus
POL_Call POL_Install_directx9
POL_Call POL_Install_d3dx9_43
POL_Call POL_Install_d3dx10
POL_Call POL_Install_d3dx11
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_xact
POL_Call POL_Install_msxml3
POL_Call POL_Install_dotnet20
POL_Call POL_Install_dotnet20sp2
}

POL_Wine_WaitBefore "$TITLE1"
POL_Wine "$DOTNET35_INSTALLER"
POL_Wine_WaitBefore ".Net Framework 4.0"
POL_Call POL_Install_dotnet40
POL_Wine_WaitBefore "$TITLE2"
POL_Wine "$SMITE_INSTALLER"

POL_Call POL_Function_OverrideDLL builtin,native dnsapi

POL_SetupWindow_Close
exit
