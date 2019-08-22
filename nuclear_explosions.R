#nuclear_explosions <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-08-20/nuclear_explosions.csv")
#write.csv(nuclear_explosions,"nuclear_explosions.csv")
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(png)
library(grid)



nuclear_explosions <- readr::read_csv("nuclear_explosions.csv")



nuclear_explosions=as.data.table(nuclear_explosions)


world_map <- map_data("world")
p<-ggplot(world_map, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill="lightgrey", colour = "white")  

img1 <- readPNG("boom.png")
g1 <- rasterGrob(img1, interpolate=TRUE)


for(i in 1:nrow(nuclear_explosions)){
  
  p=p + annotation_custom(g1,ymin = nuclear_explosions$latitude[i]-10,ymax = nuclear_explosions$latitude[i]+10, xmin =nuclear_explosions$longitude[i]-10, xmax =nuclear_explosions$longitude[i]+10)
  
  
}

p + theme(
  panel.background = element_rect(fill = "white"),
  plot.margin = margin(1, 1, 1, 1, "cm"),
  plot.background = element_rect(
    fill = "white",
    colour = "black",
    size = 1
  )
)  
+annotate("text", x=10, y=20, label= "There has been 2051 nuclear explosions in the last 74 years all around the globe") + 
annotate("text", x=8, y=1, label= "TidyTuesday - Twitter: @schmalte04")
#grid.text("There has been 2051 nuclear explosions in the last 74 years all around the globe", x = unit(0.5, "npc"), y = unit(0.17, "npc"))
#grid.text("TidyTuesday - Twitter: @schmalte04", x = unit(0.5, "npc"), y = unit(0.17, "npc"))

ggsave("nuclear_explosions.png",width=8, height=4.5)
