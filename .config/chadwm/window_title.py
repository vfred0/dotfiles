import subprocess
import os

NO_WINDOW = '0x0'
EMPTY_TITLE = ''
PATH_USR = '/usr/share/applications/'
PATH_USR_LOCAL = '/home/vfred0/.local/share/applications/'

active_window_id = subprocess.check_output(['xprop', '-root', '32x', '\t$0', '_NET_ACTIVE_WINDOW']).decode().split()[1]

def exists(window_id) -> bool:
    return window_id != NO_WINDOW
desktop_entry_name = subprocess.check_output(['xprop', '-id', active_window_id, 'WM_CLASS']).decode().split('"')[1]

desktop_entry_path = PATH_USR + desktop_entry_name + '.desktop'
if not os.path.exists(desktop_entry_path):    
    desktop_entry_path = PATH_USR_LOCAL + desktop_entry_name + '.desktop'    

with open(desktop_entry_path, 'r') as f:    
    for line in f:
        if line.startswith('Name='):
            window_title = line.split('=')[1].strip()
            break    
print(window_title)