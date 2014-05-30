Things on my list

Use the `export.app` AppleScript and put it somewhere like `~/research/export.app`. Then create a folder called `~/research/.todo` and initiate it as a git repository. Use the following cronjob (`crontab -e`):

  0 * * * * open ~/research/export.app >/dev/null 2>&1


