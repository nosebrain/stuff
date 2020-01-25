property openhab_item_url : "http://10.0.1.205/rest/items/RecordingStatus"
property delay_time : 20
property notification_title : "⚡"

on RecordingStarted(RecordingID)
	delay delay_time
	
	tell application "EyeTV"
		set rec to RecordingID as integer
		set theRec to recording id rec
		set current_duration to actual duration of theRec
		
		if current_duration ≤ (delay_time - 10) then
			my notify(RecordingID, notification_title)
		end if
	end tell
end RecordingStarted

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

on run
	tell application "EyeTV"
		set RecordingID to unique ID of item 1 of recordings
	end tell
	my notify(RecordingID, notification_title)
end run
