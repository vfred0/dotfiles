# use xprop to get the window title only NAME
# title=$(xprop -id $(xprop -root 32x '\t$0' _NET_ACTIVE_WINDOW | cut -f 2) _NET_WM_NAME | cut -d '"' -f 2)
# IFS='-' read -ra ADDR <<< "$title"
# title=${ADDR[-1]}
# echo $title

import subprocess

NO_WINDOW = '0x0'
EMPTY_TITLE = ''

active_window_id = subprocess.check_output(['xprop', '-root', '32x', '\t$0', '_NET_ACTIVE_WINDOW']).decode().split()[1]

def exists(window_id) -> bool:
    return window_id != NO_WINDOW
if exists(active_window_id):
    window_title = subprocess.check_output(['xprop', '-id', active_window_id, '_NET_WM_NAME']).decode().split('"')[1]
    title_parts = window_title.split('-')
    last_part = title_parts[-1].strip()
    print(last_part)

else:
    print(EMPTY_TITLE)
