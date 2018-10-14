property app_name : "EyeTV"
property api_key : ""
property delay_time : 20

on RecordingStarted(RecordingID)
	delay delay_time
	
	tell application "EyeTV"
		set rec to RecordingID as integer
		set theRec to recording id rec
		set current_duration to actual duration of theRec
		
		if current_duration ≤ (delay_time - 10) then
			my notify(RecordingID, "Hardware defect")
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
	
	set n_description to recTitle & " - " & desc
	do shell script "curl --data 'apikey=" & api_key & "&application=" & app_name & "&event=" & my urlencode(n_title) & "&description=" & my urlencode(n_description) & "&priority=2' https://api.prowlapp.com/publicapi/add"
end notify

on run
	tell application "EyeTV"
		set RecordingID to unique ID of item 1 of recordings
	end tell
	my notify(RecordingID, "Hardware defect")
end run

on urlencode(TheTextToEncode)
	return do shell script "/usr/bin/python -c 'import sys, urllib; print urllib.quote(sys.argv[1])' " & quoted form of TheTextToEncode
end urlencode