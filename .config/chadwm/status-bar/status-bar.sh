#!/bin/dash
. ~/.config/chadwm/status-bar/themes/catppuccin

get_without_decimal(){
  value=$1
  result=${value%.*}
  echo $result  
}

cpu() {  
  # get %Cpu(s) value
  # cpuValue=$(top -bn1 | awk '/Cpu/ { print $2}') 
  # value=$(top -bn1 | awk '/Cpu/ { print $2}')	      
  # echo "CPU Usage: "]"%"
  # echo "CPU Usage: "$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]"%"
  #value=$((100 - $(vmstat 1 2 | tail -1 | awk '{print $15}')))
  value=$(sar -u 1 1 | tail -n 1 | awk '{print 100 - $NF}')

  show "CPU" "$value"
}

# gpu() {
#   value=$(cat /sys/class/drm/card0/device/gpu_busy_percent)   
#   # value=$(amdgpu_top -J | jq '.GRBM."Graphics Pipe".value')     
#   show "GPU:" "$value"
# }

chipset_temperture() {
  value=$(sensors | awk '/Tctl:/ { print $2 }' | cut -c2- | sed 's/°C//')

  # value=$(sensors | awk '/Tctl:/ { print $2 }' | cut -c2- | sed 's/°C//')

  show "CHITEM" "$(get_without_decimal $value)°C"
}

vram() {
  value=$(cat /sys/class/drm/card1/device/mem_info_vram_used)    
  value=$(($value*100))
  total=$(cat /sys/class/drm/card1/device/mem_info_vram_total)
  value=$(($value/$total))
  show "VRAM" "$value"
}

temperature(){
  value=$(sensors | grep 'edge:' | awk '{ print $2 }' 2>/dev/null | sed 's/+//')
  show "CPUTEM" "$(get_without_decimal $value)°C"
}

pkg_updates() {
  value=$(checkupdates 2>/dev/null | wc -l)
  show "PKGs" "$value"
}

memory_ram() {    
  percentage=$(free | awk '/^Mem/ { printf "%.2f", $3/$2 * 100 }')       
  show "RAM" "$(get_without_decimal $percentage)"
}

clock() {
  date=$(date +"%a, %B %d %H:%M")
  show "DATE" "$date"
}

show() {
  printf "^c$red^^b$black^ $1"
  printf "^c$white^^b$black^ $2"
  # printf "$1"
  # printf "$2"
}

volume() {
  value=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
  show "VOL" "$value"
}

while true; do  
  sleep 0.2 && xsetroot -name "$(pkg_updates) $(temperature) $(chipset_temperture) $(cpu)% $(vram)% $(memory_ram)% $(volume)% $(clock) " 
done
