property crlf : (ASCII character 13) & (ASCII character 10)

tell application "Things"
	
	set scriptOutput to ""
	set publicTag to make new tag with properties {name:"Public"}
	
	try
		set fh to (open for access "/Users/arc/research/.todo/list.yaml" with write permission)
	on error errmsg number errno
		display dialog "Error (" & errno & ") opening file: " & errmsg
	end try
	
	(* Write the todos to the output file, one per line *)
	repeat with research_project in to dos of area "Research"
		(* Find all todos for that project *)
		
		repeat 1 times
			
			try
				set isProj to project (name of research_project)
			on error errmsg number errno
				write "- " & (name of research_project) & crlf to fh
				exit repeat
				
			end try
			
			write "- " & (name of research_project) & ":" & crlf to fh
			repeat with project_todo in to dos of project (name of research_project)
				write "  - " & (name of project_todo) & crlf to fh
				set tag names of project_todo to "Public"
			end repeat
		end repeat
		
	end repeat
	
	(* Close the output file *)
	close access fh
	set cmd to "cd /Users/arc/research/.todo/ && git add list.yaml && git commit -m 'Updated' && git push"
	do shell script cmd
end tell
