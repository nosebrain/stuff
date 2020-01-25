on ExportDone(RecordingID)
	set delegator to my getDelegator()
	tell delegator to ExportDone(RecordingID)
end ExportDone

on getDelegator()
	tell application "Finder"
		set my_file to "Macintosh HD:Library:Application Support:EyeTV:Scripts:TriggeredScripts:Delegator.scpt"
		set loaded_script to load script file my_file
		return loaded_script
	end tell
end getDelegator

on run
	ExportDone(2)
end run
