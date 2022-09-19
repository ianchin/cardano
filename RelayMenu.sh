#!/usr/bin/env bash

### Colors ##
ESC=$(printf '\033') RESET="${ESC}[0m" BLACK="${ESC}[30m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"

### Color Functions ##
greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }
fn_bye() { exit 0; }
fn_fail() { echo "Wrong option." exit 1; }


mainmenu() {
    echo -ne "
$(magentaprint 'MAIN MENU')
$(greenprint '1)') MAINTENANCE
$(greenprint '2)') DASHBOARD
$(greenprint '3)') CARDANO NODE SERVICE LOG
$(greenprint '4)') CONNECT CORE NODE
$(greenprint '5)') RECALCULATE EPOCH
$(redprint '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        /mnt/shared/script/Maintenance.sh
        clear
        echo "Latest Cardano Node Version: $(curl -s https://api.github.com/repos/input-output-hk/cardano-node/releases/latest | jq -r .tag_name)"
        echo "Currently Installed Cardano Node version: $(cardano-node --version)"
        ~/RelayMenu.sh
        ;;
    2)
        ~/cardano/gLiveView.sh
        ;;
    3)
        journalctl --unit=cardano-node --follow
        ;;
    4)
        /mnt/shared/script/ConnectCoreNode.sh
        ;;
    5)
        /mnt/shared/script/NextEpochSlot.sh
        ;;
    0)
        fn_bye
        ;;
    *)
        fn_fail
        ;;
    esac
}

mainmenu