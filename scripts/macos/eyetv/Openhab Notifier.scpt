property openhab_item_url : "http://10.0.1.205/rest/items/RecordingStatus"
property notification_titles : {"🔴", "⏹️", "✅"}

on run
	tell application "EyeTV"
		set rec to unique ID of item 1 of recordings
	end tell
	my RecordingStarted(rec)
end run

on RecordingStarted(RecordingID)
	my notify(RecordingID, item 1 of notification_titles)
end RecordingStarted

on RecordingDone(RecordingID)
	my notify(RecordingID, item 2 of notification_titles)
end RecordingDone

on ExportDone(RecordingID)
	my notify(RecordingID, item 3 of notification_titles)
end ExportDone

on notify(RecordingID, n_title)
	-- get title and description
	tell application "EyeTV"
		set rec to RecordingID as integer
		set theRec to recording id rec
		set recTitle to title of theRec
		set desc to episode of theRec
	end tell
	
	set n_description to n_title & " " & recTitle & " (" & desc & ")"
	do shell script "curl --header 'Content-Type: text/plain' --request POST --data \"" & n_description & "\" " & openhab_item_url
end notify