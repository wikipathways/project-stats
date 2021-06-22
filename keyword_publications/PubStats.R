library(europepmc)
library(dplyr)
library(magrittr)
library(tidyr)

##Search for project
my_project <- readline(prompt="Enter project or tool name to search: ")

##Check number of hits
project_hits <- europepmc::epmc_hits(query=my_project)

if (project_hits > 5000){
  message("There are ", project_hits, " hits. This will take a while to process.")
  proceed <- readline(prompt="Are you sure you want to proceed? (Y/N): ")
  if (tolower(proceed) != 'y')
    invokeRestart("abort")
}

##Update query with limit based on how many are available. Note this will be very slow.
project_search <- europepmc::epmc_search(query=my_project)

##Make subsets
stats <- project_search %>%
  select(c("pmid", "journalTitle", "citedByCount")) %>%
  drop_na()

### papers sorted by citations
citation_count <- stats %>%
  arrange(desc(citedByCount))

### journals sorted by paper counts
journal_count <- stats %>%
  group_by(journalTitle) %>%
  summarise(count = n()) %>%
  arrange(desc(count), journalTitle)

##Write to files
write.csv(citation_count, file="PubsCitationCount.csv", row.names = FALSE)
write.csv(journal_count, file="PubsJournalCount.csv", row.names = FALSE)

