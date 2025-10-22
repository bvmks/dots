#!/usr/bin/env fish

# Попробуем запустить один из доступных polkit-агентов

if type -q /usr/lib/polkit-kde-authentication-agent-1
    /usr/lib/polkit-kde-authentication-agent-1 &
    exit 0
end

if type -q /usr/libexec/polkit-gnome-authentication-agent-1
    /usr/libexec/polkit-gnome-authentication-agent-1 &
    exit 0
end

if type -q /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
    exit 0
end

echo "No known polkit agent found."

