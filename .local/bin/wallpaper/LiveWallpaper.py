#!/usr/bin/env python3
import os
import subprocess
from wallpaper.Wallpaper import Wallpaper

class LiveWallpaper(Wallpaper):     
    def __init__(self):
        super().__init__(os.path.expanduser("~/Images/Wallpapers/Lives"), os.path.expanduser("~/.local/bin/wallpaper/.live-wallpaper-history"))                                
        subprocess.run(["xwallpaper", "--clear"])                        
                   
    def _get_current_number_wallpaper(self):    
        number = 1
        with open(self._save_file_path, "r") as file:
            number = int(file.read())
        return number
                
    def _update_wallpaper(self):
        number_wallpaper_with_zero = str(self._current_number_wallpaper).zfill(2)        
        with open(self._save_file_path, "w") as file:
            file.write(number_wallpaper_with_zero)              
        subprocess.run(["killall", "xwinwrap"])                          
        subprocess.run(["xwinwrap", "-g", "1920x1080", "-un", "-fdt", "-ni", "-b", "-ov", "-nf", "--", "live-mpv", "WID", f"{self._wallpapers_path}/{number_wallpaper_with_zero}"])
        subprocess.run(["notify-send",  f"Changing live wallpaper {self._current_number_wallpaper} of {self._get_total_wallpapers()}"])