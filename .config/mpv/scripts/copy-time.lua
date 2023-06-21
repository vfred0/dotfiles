local utils = require 'mp.utils'

local function set_clipboard(text)
  command = string.format("echo -n %s | xclip -selection clipboard", text)
  mp.commandv("run", "/bin/bash", "-c",  command)
end

local function show_rofi()
  -- show rofi prompt and return the user input
  local cmd = [[
    rofi -dmenu -p "Chapter description" 
  ]]
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()
  return result
    
end


local function header(filename)
  local file = io.open(filename, "r")
  if file == nil then
    local file = io.open(filename, "w")
    file:write("<Chapters>\n<EditionEntry>\n")
    file:close()
  end
end


local function append_chapter(filename, time, description)

  local file = io.open(filename, "a")
  file:write("<ChapterAtom>\n")
  file:write("  <ChapterTimeStart>" .. time .. "</ChapterTimeStart>\n")
  file:write("  <ChapterDisplay>\n")
  file:write("    <ChapterString>" .. description .. "</ChapterString>\n")
  file:write("  </ChapterDisplay>\n")
  file:write("</ChapterAtom>\n")  
  file:close()
end

-- local function continuing_append_chapters()
--    show_rofi("Add more chapters?")

--    -- show rofi with selection of yes or no
  
--   local cm
    



-- end

function copy_time()
  local time_pos = mp.get_property_number("time-pos")
  local time_hours = math.floor(time_pos / 3600)
  local time_minutes = math.floor((time_pos % 3600) / 60)
  local time_seconds = math.floor(time_pos % 60)
  local time_ms = math.floor((time_pos - math.floor(time_pos)) * 1000)
  local time = string.format("%02d:%02d:%02d.%03d", time_hours, time_minutes, time_seconds, time_ms)
  set_clipboard(time)    
  
  mp.set_property("pause", "yes")
    
  local description = show_rofi()   


  if description then
    local video_path = mp.get_property("path")
    local _, foldername = utils.split_path(utils.getcwd())    
    local chapter_filename = utils.join_path(utils.getcwd(), video_path .."_chapters.xml")
    -- save in list descrip


    -- header(chapter_filename)
    -- append_chapter(chapter_filename, time, description)
    
    -- if not  

    mp.osd_message(string.format("%s - %s - %s", time, description, chapter_filename))
  else
    mp.osd_message("Chapter description not saved.")
  end  
      
  mp.set_property("pause", "no") 
end

mp.add_key_binding("Ctrl+Alt+c", "copy_time", copy_time)
