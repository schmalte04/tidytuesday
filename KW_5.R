sf_trees <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-28/sf_trees.csv')


sf_trees<-group_by(sf_trees,caretaker) %>% mutate(year=lubridate::year(as.Date(date)))

caretaker_summary<-sf_trees %>%
  group_by(caretaker) %>%
  summarize(Percentage=(n()/nrow(sf_trees))*100)

caretaker_summary<-filter(caretaker_summary,Percentage>quantile(caretaker_summary$Percentage,0.5))

caretaker_summary$caretaker <- factor(caretaker_summary$caretaker, levels = caretaker_summary$caretaker[order(-caretaker_summary$Percentage)])

caretaker_plot<-ggplot(data=caretaker_summary, aes(x=caretaker, y=Percentage, fill=Percentage)) +
  geom_bar(stat="identity")  + theme_minimal() + theme(axis.text.x = element_text(angle = 45, hjust = 1, size=11)) +  scale_fill_gradient(low = "green", high = "darkgreen")


plants_per_year_summary<-sf_trees %>%
  group_by(year) %>%
  summarize(Plants_per_year=(n())) %>% filter(!is.na(year), year!=2020)

tree_background <- readJPEG("tree.jpeg")

plans_per_year<-ggplot(data=plants_per_year_summary ,aes(x=year,y=Plants_per_year))+ ylab("New tress planted per Year") + xlab("Year") +
  labs(x = NULL, y = NULL,
       title = "Tress Planted", 
       subtitle = "in San Francisco")+ 
  theme_minimal() + ggtitle("Number of planted trees per year") + theme(plot.title=element_text(hjust=0, size=14)) +
  annotation_custom(rasterGrob(tree_background, 
                               width = unit(1,"npc"), 
                               height = unit(1,"npc")), 
                    -Inf, Inf, -Inf, Inf)  + geom_point(size = 2) + geom_line() + geom_smooth() + theme(axis.text.x = element_text(size=12)) + theme(plot.title = element_text(vjust = 0, hjust=0)) +
  theme(plot.margin = unit(c(1,1,1,1), "cm"))


ggsave("sanfran.png")


                 