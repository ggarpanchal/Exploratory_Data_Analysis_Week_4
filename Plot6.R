library(dplyr)
library(ggplot2)

# checking both variable is available or not and not then run "Getting_Data_from_Link.R" to get
if(!exists("NEI") && !exists("SCC")){
  source("Getting_Data_from_Link.R")
}

# Create a variable Vehicles_SCC_ID which contain sources ID from motor vehicle sources emissions
Vehicles_SCC_ID <- SCC[grep(pattern = "Vehicles", EI.Sector, ignore.case = T),]$SCC

# Filter NEI dataset firstly with Baltimore city (fips=="24510") or Los Angeles (fips=="06037")  secondly with Vehicles_SCC_ID
# then replace ID with their city names like( "24510" for "Baltimore" ) and summarise sum of total emission after groupin by year & city
Vehicles_Related_Emmisions_for_Baltimore_LA <- NEI %>% 
  filter(SCC %in% Vehicles_SCC_ID) %>%
  filter((fips == "24510") |  (fips=="06037")) %>%
  replace(. , . == "24510", "Baltimore") %>%
  replace(. , . == "06037", "Los Angeles") %>%
  group_by(year, fips) %>%
  summarise(Total_Emissions = sum(Emissions, na.rm = TRUE))

png(filename = "Plot6.png")

# Create line Plot for visulizing Total vehicle sources Emissions per year in Baltimore City & Los Angeles County
temp_plot <- ggplot(Vehicles_Related_Emmisions_for_Baltimore_LA, aes(year, Total_Emissions, group = fips, col = fips))

temp_plot + 
  geom_line() + 
  geom_point( cex= 3 ) + 
  ggtitle(label = expression("PM"[2.5]*" Emissions from motor vehicle sources in Baltimore & LA")) + 
  ylab(label = expression("Total PM"[2.5]*" Emission")) + 
  guides(color=guide_legend("City"))
  
  dev.off()
