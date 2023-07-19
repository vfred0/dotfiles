import sys

chapters_file_path = sys.argv[1]
chapters_data = sys.argv[2]

with open(chapters_file_path, "w") as f:
    f.write(chapters_data)