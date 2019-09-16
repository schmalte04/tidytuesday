library(dplyr)
library(ggplot2)


park_visits <- read.csv("~/workspace/tidytuesday/nationalparks/park_visits.csv", row.names=1)
gas_price <- read.csv("~/workspace/tidytuesday/nationalparks/gas_price.csv", row.names=1)
state_pop<- read.csv("~/workspace/tidytuesday/nationalparks/state_pop.csv", row.names=1)


state_pop<- state_pop %>% filter(year==2015)

state_data<-group_by(park_visits,state) %>% filter(year==2015)

state_data <-state_data %>% summarise(
  visitors = sum(visitors)
) %>% filter(!is.na(visitors))

state_data<-left_join(state_pop, state_data) %>% mutate(vps=visitors/pop)


ggplot(data=state_data, aes(x=state, y=vps)) +
  geom_bar(stat="identity")


