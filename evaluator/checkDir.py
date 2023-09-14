import os
import json
import sys

def load_and_augment_json_files(directory, parent_dir=None):
	json_objects = {}

	# Check if the provided directory exists
	if not os.path.exists(directory):
		print(f"Error: Directory '{directory}' does not exist.")
		return json_objects

	# Iterate through all files and subdirectories in the directory
	for root, _, files in os.walk(directory):
		for filename in files:
			file_path = os.path.join(root, filename)

			# Check if the file is a JSON file
			if filename.endswith('.json') and os.path.isfile(file_path):
				try:
					with open(file_path, 'r') as json_file:
						data = json.load(json_file)
						name = os.path.realpath(file_path)
						json_objects[name]=data
						print(f"Loaded JSON from '{file_path}'")
				except Exception as e:
					print(f"Error loading JSON from '{file_path}': {str(e)}")

	return json_objects

if __name__ == "__main__":
	if len(sys.argv) != 2:
		print("Usage: python "+sys.argv[0]+" /path/to/directory")
		sys.exit(1)

	directory = sys.argv[1]
	json_objects = load_and_augment_json_files(directory)
	print(json_objects)
	# Now you have a list of JSON objects in json_objects
	# Each JSON object has a "name" field indicating the directory it was in.
	# You can work with these objects as needed.
