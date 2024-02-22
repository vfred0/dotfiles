import os
import re


class Renaming: 
    def __init__(self):
        self.__total_wallpapers = self.__get_total_wallpapers()
        print(self.__total_wallpapers)
        self.__rename_wallpapers()
    
    def __get_total_wallpapers(self):        
        return len(os.listdir(os.getcwd()))    

    def __extract_number(self, filename):
        match = re.search(r'\d+', filename)
        return int(match.group()) if match else None

    def __rename_wallpapers(self):
        files = os.listdir(os.getcwd())
        jpg_files = [f for f in files if f.endswith('.jpg')]
        jpg_files.sort(key = lambda x: self.__extract_number(x))
        

        for i, filename in enumerate(jpg_files, start=1):
            print(f"File: {filename}")            
            new_name = f'{str(i).zfill(2)}.jpg'                         
            os.rename(filename, new_name)
                         
            
Renaming()