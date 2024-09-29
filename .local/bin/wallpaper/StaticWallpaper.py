import os
import subprocess
from wallpaper.Wallpaper import Wallpaper

class StaticWallpaper(Wallpaper):
    def __init__(self):
        super().__init__(os.path.expanduser("~/Images/Wallpapers/Statics"), os.path.expanduser("~/.xinitrc"))        
        self.__command_to_apply_wallpaper = "xwallpaper --zoom"          
        subprocess.run(["killall", "mpv"])      
    
    def _get_current_number_wallpaper(self):        
        with open(self._save_file_path, "r") as file:
            for line in file.readlines():
                if line.startswith("xwallpaper --zoom"):
                    return int(line.split("/")[-1].split(".")[0])            
        return 1
    
    def _update_wallpaper(self):
        number_wallpaper_with_zero = str(self._current_number_wallpaper).zfill(2)
        wallpaper_path = f"{self._wallpapers_path}/{number_wallpaper_with_zero}.jpg"
        
        with open(self._save_file_path, "r") as file:
            lines = file.readlines()

        with open(self._save_file_path, "w") as file:
            for line in lines:
                if line.startswith(self.__command_to_apply_wallpaper):
                    file.write(f"{self.__command_to_apply_wallpaper} {wallpaper_path}\n")                    
                else:
                    file.write(line)                                    
        subprocess.run(["notify-send",  "-i", wallpaper_path, f"Changing wallpaper {self._current_number_wallpaper} of {self._get_total_wallpapers()}"])
        subprocess.run(["xwallpaper", "--zoom", wallpaper_path])