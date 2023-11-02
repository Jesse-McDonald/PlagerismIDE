import os
import json
import sys
def addList(dictionary, name):
    if name not in dictionary:
        dictionary[name] = []
def addDict(dictionary, name):
    if name not in dictionary:
        dictionary[name] = {}
def safeRemove(dictionary,thing):
	if thing in dictionary:
		dictionary.remove(thing)
def subKeyIn(dictionary,subkey,exclude=None):
	for key in dictionary:
		if key==exclude:
			pass
		if(subkey in dictionary[key]):
			return key
		else:
			return None
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
						json_objects[name]["name"]=os.path.basename(os.path.dirname(name))
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
		addList(infectionMap[creatorUUID],"names")
		infectionMap[creatorUUID]["names"].append(json_objects[key]["name"] )
		projectUUID=json_objects[key]["ProjectUUID"] 
		addDict(infectionMap[creatorUUID],projectUUID)
		addList(infectionMap[creatorUUID][projectUUID],"install")
		addList(infectionMap[creatorUUID][projectUUID],"names")
		infectionMap[creatorUUID][projectUUID]["names"].append(json_objects[key]["name"] )
		
		addList(infectionMap[creatorUUID][projectUUID],"infect")
		infectList=json_objects[key]["InfectionStack"]
		safeRemove(infectList,creatorUUID)
		safeRemove(infectList,projectUUID)
		installList=json_objects[key]["InstallUUIDStack"]
		safeRemove(installList,creatorUUID)
		safeRemove(installList,projectUUID)
		for i in infectList:
			infectionMap[creatorUUID][projectUUID]["infect"].append(i)
		for i in installList:
			infectionMap[creatorUUID][projectUUID]["install"].append(i)
	for key in json_objects:
		#print(json_objects[key]["InfectionStack"])
		creatorUUID=json_objects[key]["CreatorUUID"]
		projectUUID=json_objects[key]["ProjectUUID"]
		for i in infectionMap[creatorUUID][projectUUID]["infect"]:
			if(i in infectionMap ):

				print (json_objects[key]["name"]+" has install infection from "+ str(infectionMap[i]["names"]))
			skey=subKeyIn(infectionMap,i,creatorUUID)
			if(not skey is None):
				print (json_objects[key]["name"]+" has project infection from "+ str(infectionMap[key][i]["names"]))
		for i in infectionMap[creatorUUID][projectUUID]["install"]:
			if(i in infectionMap ):
				print (json_objects[key]["name"]+" has install install infection from "+ str(infectionMap[i]["names"]))
			skey=subKeyIn(infectionMap,i,creatorUUID)
			if(not skey is None):
				print (json_objects[key]["name"]+" has project install infection from "+ str(infectionMap[key][i]["names"]))
	#print(infectionMap)
if __name__ == "__main__":
	if len(sys.argv) != 2:
		print("Usage: python "+sys.argv[0]+" /path/to/directory")
		sys.exit(1)

	directory = sys.argv[1]
	processDir(directory)
