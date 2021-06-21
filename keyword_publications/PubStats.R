library(europepmc)
library(dplyr)
library(magrittr)
library(tidyr)

##Search for project
##Run once to see how many records there are. Default returned is 100.
project_search <- europepmc::epmc_search(query='<project>')

##Update query with limit based on how many are available. Note this will be very slow.
project_search <- europepmc::epmc_search(query='<project>', limit=21247)

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

