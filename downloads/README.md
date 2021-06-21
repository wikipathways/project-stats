# Release Downloads

This directory contains scripts to generate plots and summary reports
for release downloads.
 

## Requirements

 * Python 3.6+
 * numpy
 * matplotlib

## Release download stats

This section describes the steps to generate statistics and figures
for release downloads via GitHub. 

### Step 1 Download JSON file from github

Either via browser or command line download contents of this link
to a file: https://api.github.com/repos/<org>/<repo>/releases

```bash
    curl https://api.github.com/repos/<org>/<repo>/releases > `date +%m_%d_%Y`_releases.json 
```

### Step 2 Generate Report

Open a terminal with required [Python](https://python.org) and packages installed as noted
in the requirements section and run the following command:

```Bash
./download_stats.py `date +%m_%d_%Y`_releases.json ./download_report -vvv
```

**NOTE:** Be sure to use an updated file from Step 1 since the report uses today's
          date in the calculations.

The above command will parse the file passed and generate files under
`./download_report` directory.

### Step 3 Review results
 
 A summary of downloads per version will be output to standard out and 
 two `svg` files will be written to the output directory specified on the command
 line (`./download_report` if above command was invoked)
 
 * `downloads_by_platform.svg`

   Plot that shows a breakdown of downloads by platform. 
     
 * `downloads_byday.svg` 
   
    Plot that shows breakdown of downloads per day by version. 
