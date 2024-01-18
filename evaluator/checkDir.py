import os
import json
import sys
import re
unknownSelfThreshold=50
unknownOtherThreshold=20
externalThreshold=3
redemptionThreshold=2000
def extractUUID(string):
	return re.search(r'\b[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\b', string).group()

def addList(dictionary, name):
	if name not in dictionary:
		dictionary[name] = []
def addDict(dictionary, name):
	if name not in dictionary:
		dictionary[name] = {}
def addSet(dictionary, name):
	if name not in dictionary:
		dictionary[name] = set()
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
def studentName(root, path):
	dirs1 = os.path.abspath(root).split(os.sep)
	dirs2 = os.path.abspath(path).split(os.sep)
	return dirs2[len(dirs1)]
	
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
						json_objects[name]["name"]=studentName(directory,name)
						#print(f"Loaded JSON from '{file_path}'")
				except Exception as e:
					print(f"Error loading JSON from '{file_path}': {str(e)}")
	
	return json_objects
def processDir(directory):
	json_objects = load_and_augment_json_files(directory)
	#print(json_objects)
	students={}
	creatorUUID={}
	projectUUID={}
	unknownUUIDs={}
	for key in json_objects:
		name=json_objects[key]['name']
		student=json_objects[key]
		addDict(students,name)
		students[name][key]=json_objects[key]
		addSet(creatorUUID,json_objects[key]['CreatorUUID' ])
		addSet(projectUUID,json_objects[key]['ProjectUUID' ])
		creatorUUID[json_objects[key]['CreatorUUID' ]].add(name)
		projectUUID[json_objects[key]['ProjectUUID' ]].add(name)
		#print(json_objects[key]['CreatorUUID' ])
		
	unique=True
	for uuid in creatorUUID:
		if(len(creatorUUID[uuid])>1):
			print(f"Machine UUID ${uuid} is shared by ${creatorUUID[uuid]}")
			unique=False
		else:
			creatorUUID[uuid]=creatorUUID[uuid].pop()
	if unique:
		print("No students used the same machine")
	unique=True
	for uuid in projectUUID:
		if(len(projectUUID[uuid])>1):
			print(f"Project UUID {uuid} is shared by {creatorUUID[uuid]}")
			unique=False
		else:
			projectUUID[uuid]=projectUUID[uuid].pop()
	if unique:
		print("No students directly shared files")
		
	for name in students:
		student=students[name]
		clean=True
		unknownUUIDS=set()
		foundUUIDS=set()
		infections=set()
		definitlyDirty=False
		for file in student:
			safeMachine=not len(creatorUUID[student[file]['CreatorUUID']])>1
			for uuid in student[file]['InstallUUIDStack'] :
				for other in creatorUUID[uuid][0]:
					if name!=other and other not in infections:
						infections.add(other)
						print(f"Student {name} and {other} used file with same creator UUID")
						clean=False
			#check infect IDS
			
			for uuid in student[file]['InfectionStack']:
				if(uuid in creatorUUID):
					
					for other in creatorUUID[uuid]:
						if name!=other and other not in infections:
							infections.add(other)
							print(f"Student {name} is infected by code from {other}'s machine")
							clean=False
				elif(uuid in projectUUID):
					for other in projectUUID[uuid]:
						if name!=other and other not in infections:
							infections.add(other)
							print(f"Student {name} is infected by code from {other}")
							clean=False
				else:
					unknownUUIDS.add(uuid)
					#print(f"Student {name} is infected by unknown UUID {uuid}")
					#clean=False
			definitlyDirty=not clean
			
			editsAfterPaste=0
			for event in student[file]['History']:
				if(event['L']=='T'):
					editsAfterPaste+=1
				elif(event['L']=='P' and 'N' in event):
					#print(event['N'])
					notes=event['N'].split(';')
					#print(notes)
					lineCount=event['E'].count('\n')
					if "internal paste" in notes:
						continue
					elif "paste from project on same machine" in event['N']:
						if("Paste from project with UUID" in event['N'] ):
							for note in notes:
								if "Paste from project with UUID" in note and "fragment" not in note:
									if(safeMachine):
										safeRemove(unknownUUIDS,extractUUID(note))
									else:
										print(f"Student {name} copied code from another project on a machine used by multiple students")
										clean=False
										editsAfterPaste=0
					elif "paste from project with same creator" in event['N']:
						if("Paste from project with UUID" in event['N'] ):
							for note in notes:
								if "Paste from project with UUID" in note and "fragment" not in note:
								
									
									copyUUID=extractUUID(note)
									if(copyUUID in unknownUUIDS or copyUUID in foundUUIDS):
										
										if(safeMachine):
											safeRemove(unknownUUIDS,copyUUID)
											foundUUIDS.add(copyUUID)
											print(f"Student {name} copied {lineCount} lines from an unknown project on their machine" )
											if(lineCount>unknownSelfThreshold):
												clean=False
												editsAfterPaste=0
											#print(event)
										else:
											print(f"Student {name} copied code from an unknown project (uuid {copyUUID}) from a machine used by multiple students")
											addList(unknownUUIDs,copyUUID)
											unknownUUIDs[copyUUID].append(name)
											clean=False
											editsAfterPaste=0
									else:
										#TODO, print student who turned in project
										print(projectUUID[copyUUID])
						#elif:
					elif "Paste from install with UUID" in event['N']:
						#probiably definitly plagerism
						for note in notes:	
							if("Paste from install with UUID" in note and "fragment" not in note):
							
								copyUUID=extractUUID(note)
								if(copyUUID in unknownUUIDS or copyUUID in foundUUIDS):
									print(f"Student {name} copied {lineCount} lines from an unknown machine with uuid {copyUUID})")
									safeRemove(unknownUUIDS,copyUUID)
									foundUUIDS.add(copyUUID)
									if(lineCount>unknownOtherThreshold):
										clean=False
										editsAfterPaste=0
								else:
									#TODO, print student whos machine this is
									#print(event)
									print(creatorUUID[copyUUID])
									clean=False
									editsAfterPaste=0
						#print(event)
					elif "Paste from creator with UUID" in event['N']:
						#probiably definitly plagerism
						for note in notes:	
							if("Paste from creator with UUID" in note and "fragment" not in note):
							
								copyUUID=extractUUID(note)
								if(copyUUID in unknownUUIDS or copyUUID in foundUUIDS):
									print(f"Student {name} copied {lineCount} lines from an unknown machine with uuid {copyUUID})")
									safeRemove(unknownUUIDS,copyUUID)
									foundUUIDS.add(copyUUID)
									if(lineCount>unknownOtherThreshold):
										clean=False
										editsAfterPaste=0
								else:
									#TODO, print student whos machine this is
									#print(event)
									print(creatorUUID[copyUUID])
									clean=False
									editsAfterPaste=0
						#print(event)
					elif event['N']=="Paste from noncoded source":
						
						if(lineCount>externalThreshold and len(event["E"].strip())>8):#we should be able to encode things with 32 characters
							print(f"Student {name} copied {lineCount} lines from an external source")
							#print(str(len(event["E"])))
							clean=False
							editsAfterPaste=0
					elif "fragment" in event['N']:
						pass #not palgerism
					elif event['N']=="Paste too short to track":
						pass #not plagerism
					#print(notes)
						
			if not clean and not definitlyDirty:
				print(f"there were {editsAfterPaste} edits made after the last paste")
			#check linear typing
		if clean:
			print("No plagiarism detected for student "+ name)
			print()
		else:
			print(name+ " likely plagiarized\n")
		#break
		#creatorUUID[
	#infectionMap={}#machine.projectID.infections (other only)
	#for key in json_objects:
	#	#print(json_objects[key]["InfectionStack"])
	#	creatorUUID=json_objects[key]["CreatorUUID"]
	#	addDict(infectionMap,creatorUUID)
	#	addList(infectionMap[creatorUUID],"names")
	#	infectionMap[creatorUUID]["names"].append(json_objects[key]["name"] )
	#	projectUUID=json_objects[key]["ProjectUUID"] 
	#	addDict(infectionMap[creatorUUID],projectUUID)
	#	addList(infectionMap[creatorUUID][projectUUID],"install")
	#	addList(infectionMap[creatorUUID][projectUUID],"names")
	#	infectionMap[creatorUUID][projectUUID]["names"].append(json_objects[key]["name"] )
	#	
	#	addList(infectionMap[creatorUUID][projectUUID],"infect")
	#	infectList=json_objects[key]["InfectionStack"]
	#	safeRemove(infectList,creatorUUID)
	#	safeRemove(infectList,projectUUID)
	#	installList=json_objects[key]["InstallUUIDStack"]
	#	safeRemove(installList,creatorUUID)
	#	safeRemove(installList,projectUUID)
	#	for i in infectList:
	#		infectionMap[creatorUUID][projectUUID]["infect"].append(i)
	#	for i in installList:
	#		infectionMap[creatorUUID][projectUUID]["install"].append(i)
	#for key in json_objects:
	#	#print(json_objects[key]["InfectionStack"])
	#	creatorUUID=json_objects[key]["CreatorUUID"]
	#	projectUUID=json_objects[key]["ProjectUUID"]
	#	for i in infectionMap[creatorUUID][projectUUID]["infect"]:
	#		if(i in infectionMap ):
	#
	#			print (json_objects[key]["name"]+" has install infection from "+ str(infectionMap[i]["names"]))
	#		skey=subKeyIn(infectionMap,i,creatorUUID)
	#		if(not skey is None):
	#			print (json_objects[key]["name"]+" has project infection from "+ str(infectionMap[key][i]["names"]))
	#	for i in infectionMap[creatorUUID][projectUUID]["install"]:
	#		if(i in infectionMap ):
	#			print (json_objects[key]["name"]+" has install install infection from "+ str(infectionMap[i]["names"]))
	#		skey=subKeyIn(infectionMap,i,creatorUUID)
	#		if(not skey is None):
	#			print (json_objects[key]["name"]+" has project install infection from "+ str(infectionMap[key][i]["names"]))
	#print(infectionMap)
if __name__ == "__main__":
	if len(sys.argv) != 2:
		print("Usage: python "+sys.argv[0]+" /path/to/directory")
		sys.exit(1)

	directory = sys.argv[1]
	processDir(directory)
