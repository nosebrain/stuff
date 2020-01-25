on RecordingDone(RecordingID)
	set delegator to my getDelegator()
	tell delegator to RecordingDone(RecordingID)
end RecordingDone

on getDelegator()
	tell application "Finder"
		set my_file to "Macintosh HD:Library:Application Support:EyeTV:Scripts:TriggeredScripts:Delegator.scpt"
		set loaded_script to load script file my_file
		return loaded_script
	end tell
end getDelegator
