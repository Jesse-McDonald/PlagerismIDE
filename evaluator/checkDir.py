import os
import json
import sys
def addList(dictionary, name):
    if name not in dictionary:
        dictionary[name] = []
def addDict(dictionary, name):
    if name not in dictionary:
        dictionary[name] = []
def safeRemove(dictionary,thing):
	if thing in dictionary:
		dictionary.remove(thing)
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
						#print(f"Loaded JSON from '{file_path}'")
				except Exception as e:
					print(f"Error loading JSON from '{file_path}': {str(e)}")

	return json_objects
def processDir(directory):
	json_objects = load_and_augment_json_files(directory)
	#print(json_objects)
	infectionMap={}#machine.projectID.infections (other only)
	for key in json_objects:
		#print(json_objects[key]["InfectionStack"])
		creatorUUID=json_objects[key]["CreatorUUID"]
		addDict(infectionMap,creatorUUID)
		projectUUID=json_objects[key]["CreatorUUID"]
		addDict(infectionMap[creatorUUID],projectUUID)
		addList(infectionMap[creatorUUID][projectUUID],"install")
		addList(infectionMap[creatorUUID][projectUUID],"infect")
		infectList=json_objects[key]["InfectionStack"]
		safeRemove(infectList,creatorUUID)
		remove(infectList,projectUUID)
		installList=json_objects[key]["InstallUUIDStack"]
		safeRemove(installList,creatorUUID)
		safeRemove(installList,projectUUID)
		for i in infectList:
			infectionMap[creatorUUID][projectUUID]["infect"].append(i)
		for i in installList:
			infectionMap[creatorUUID][projectUUID]["install"].append(i)
		print(infectionMap)
if __name__ == "__main__":
	if len(sys.argv) != 2:
		print("Usage: python "+sys.argv[0]+" /path/to/directory")
		sys.exit(1)

	directory = sys.argv[1]
	processDir(directory)
