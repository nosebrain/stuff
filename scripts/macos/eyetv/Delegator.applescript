property extension_list : {"scpt"}
property folder_name : "Macintosh HD:Library:Application Support:EyeTV:Scripts:TriggeredScripts:scripts"

on getAllScripts()
	tell application "Finder"
		set script_folder to folder folder_name
		set all_scripts to every file in script_folder whose name extension is in (the extension_list as alias list)
	end tell
	
	set m_scripts to {}
	repeat with m_script in all_scripts
		set loaded_script to load script file (m_script as text)
		set m_scripts to m_scripts & loaded_script
	end repeat
	
	return m_scripts
end getAllScripts


on ScheduleCreated(programID)
	set all_scripts to getAllScripts()
	repeat with m_script in all_scripts
		try
			tell m_script to ScheduleCreated(programID)
		on error
			-- TODO
		end try
	end repeat
end ScheduleCreated

on RecordingDone(recordingID)
	set all_scripts to getAllScripts()
	repeat with m_script in all_scripts
		try
			tell m_script to RecordingDone(recordingID)
		on error
			-- TODO
		end try
	end repeat
end RecordingDone

on ExportDone(recordingID)
	set all_scripts to getAllScripts()
	repeat with m_script in all_scripts
		try
			tell m_script to ExportDone(recordingID)
		on error
			-- TODO
		end try
	end repeat
end ExportDone

on RecordingStarted(recordingID)
	set all_scripts to getAllScripts()
	repeat with m_script in all_scripts
		try
			tell m_script to RecordingStarted(recordingID)
		on error
			-- TODO
		end try
	end repeat
end RecordingStarted

on RecordingDeleted(recordingID)
	set all_scripts to getAllScripts()
	repeat with m_script in all_scripts
		try
			tell m_script to RecordingDeleted(recordingID)
		on error
			-- TODO
		end try
	end repeat
end RecordingDeleted
