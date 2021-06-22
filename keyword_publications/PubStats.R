library(europepmc)
library(dplyr)
library(magrittr)
library(tidyr)

##Search for project
my_project <- readline(prompt="Enter project or tool name to search: ")

##Check number of hits
approx_num_records <- europepmc::epmc_hits(query=my_project)
num_records_found <-europepmc::epmc_search(query=my_project, limit=1)

threshold <- 5000
if (approx_num_records > threshold){
  message("There are over ",threshold," hits. This may take a while to process.")

num_records <- as.integer(readline(prompt="Enter the number of records to be returned: "))
} else {
  num_records <- threshold
}

##Update query with limit based on how many are available. Note this may be very slow.
project_search <- europepmc::epmc_search(query=my_project, limit=num_records)

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

