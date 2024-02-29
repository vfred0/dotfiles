#!/usr/bin/env python3
from abc import ABC, abstractmethod
import os
import glob
import subprocess

class Wallpaper(ABC):     
    def __init__(self, wallpapers_path, save_file_path):
        self._wallpapers_path = wallpapers_path
        self._save_file_path = save_file_path
        self._current_number_wallpaper = self._get_current_number_wallpaper()
        

    def next(self):            
        self._current_number_wallpaper += 1        
        if self._is_max_wallpaper():
            self._current_number_wallpaper = 1
        self._update_wallpaper()

    def _is_max_wallpaper(self):                
        return self._current_number_wallpaper > self._get_total_wallpapers()

    def _get_total_wallpapers(self):
        return len(glob.glob(f"{self._wallpapers_path}/*"))

    def previous(self):            
        if self._current_number_wallpaper > 1:
            self._current_number_wallpaper -= 1
        else:
            self._current_number_wallpaper = self._get_total_wallpapers()
        self._update_wallpaper()
           
    @abstractmethod
    def _get_current_number_wallpaper(self):            
        pass
                
    @abstractmethod
    def _update_wallpaper(self):
        pass
    