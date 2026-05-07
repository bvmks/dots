#! /bin/sh

rofi_cmd() {
	rofi -dmenu \
		 -theme ~/.config/rofi/powermenu.rasi
}

chosen=$(printf "LOCK\nSLEEP\nPOWEROFF\nREBOOT\nEXIT" | rofi_cmd)

case "$chosen" in
	"LOCK") betterlockscreen -l ;;
	"SLEEP") systemctl suspend;;
	"POWEROFF") poweroff ;;
	"REBOOT") reboot ;;
	"EXIT") i3-msg exit ;;
esac
