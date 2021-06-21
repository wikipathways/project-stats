# PMID Publication Stats

This directory contains a script to analyze a predefined set of publications.

## Requirements

 * Python 3.6+
 * requests
 * pandas
 * tqdm
 * matplotlib

### Step 1 Prepare publication list

Create or update a file called pmids.txt with a line-delimited set of PMIDs

### Step 2 Generate Report

Open a terminal with required [Python](https://python.org) packages noted
in the requirements section and run the following command:

```Bash
./publication_stats.py pmids.txt ./report --email <YOUR EMAIL> --name <YOUR PROJECT> -vvv
```

The above command will download needed data from ncbi and generate the reports. The data
is stored under `./report` directory.


### Step 3 Review results

Here is a description of the results

 * `data/`
 
   * This directory is a cached store of medline and citation results from
     ncbi Web API requests. The cache speeds up invocation if script is re-run.

 * `summary.txt`

   * Denotes number of citations referencing papers in pmids.txt and some other info
   
 * `summary_report.csv` 
   
    * CSV file containing information about publications from input.

 * `unique_set_of_cited_publication.medline` 
   
    * A unique set of publications that cite the publications from pmids.txt in medline format. Subsequent documentation refers to this file as 'unique medline file.'

 * `cited_publications_country_of_origin.csv`

    * CSV containing counts of country of origin for publications citing papers in input. This is calculated using the 'unique medline file'

 * `cited_publications_grants.csv`

    * CSV containing counts of grants for publications citing papers in input. Logic has been added to merge grants down since each grant line in a paper can vary and contains grant ids etc. This is calculated using the 'unique medline file'

 * `cited_publications_journal.csv`

    * CSV containing counts of journals for publications citing papers in pmids.txt. This is calculated using the 'unique medline file'`
    
 * `cited_publications_per_year.csv`
 
    * CSV containing counts of publications published each year for publications citing papers in pmids.txt. This is calculated using the 'unique medline file'
          
 * `cited_publications_per_year.svg`

    * Bar chart show cited publications per year for publications that cited papers in pmids.txt. Derived from 'cited_publications_per_year.csv'
          
 * `top_cited_publications_journal.svg`
    
    * Bar chart figure using top 15 publication venues for publications that cited papers in pmids. Derived from 'cited_publications_journal.csv' 
    
* `top_cited_publications_grants.svg`
        
    * Bar chart figure using top 15 grant funding agencies for publications that cited papers in pmids.txt. Derived from 'cited_publications_grants.csv'
