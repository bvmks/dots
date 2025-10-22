#!/usr/bin/env fish

# Завершаем процессы портала
killall xdg-desktop-portal xdg-desktop-portal-hyprland

# Ждём 1 секунду
sleep 1

# Перезапускаем порталы
# ⚠ Убедись, что пути верны для твоей системы!
/usr/lib/xdg-desktop-portal-hyprland &
sleep 1
/usr/lib/xdg-desktop-portal &

