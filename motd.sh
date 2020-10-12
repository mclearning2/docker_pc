#!/bin/sh
echo "GENERAL SYSTEM INFORMATION"
/usr/bin/screenfetch
echo
echo "SYSTEM DISK USAGE"
export TERM=xterm; inxi -D
echo
echo "CURRENT WEATHER AT THE LOCATION"
# Show weather information. Change the city name to fit your location
ansiweather -l seoul
