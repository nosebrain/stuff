property app_name : "Mac Mini - EyeTV"
property api_key : "YOUR API Key"
property notification_titles : {"Recording started", "Recording done", "Exporting done"}

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
	
	set n_description to recTitle & " - " & desc
	do shell script "curl --data 'apikey=" & api_key & "&application=" & app_name & "&event=" & my urlencode(n_title) & "&description=" & my urlencode(n_description) & "' https://api.prowlapp.com/publicapi/add"
end notify

on run
	tell application "EyeTV"
		set rec to unique ID of item 1 of recordings
	end tell
	my RecordingStarted(rec)
end run

on urlencode(TheTextToEncode)
	return do shell script "/usr/bin/python -c 'import sys, urllib; print urllib.quote(sys.argv[1])' " & quoted form of TheTextToEncode
end urlencode