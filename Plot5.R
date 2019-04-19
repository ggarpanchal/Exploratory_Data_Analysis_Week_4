library(dplyr)
library(ggplot2)

# checking both variable is available or not and not then run "Getting_Data_from_Link.R" to get
if(!exists("NEI") && !exists("SCC")){
  source("Getting_Data_from_Link.R")
}

# Create a variable Vehicles_SCC_ID which contain sources ID from motor vehicle sources emissions
Vehicles_SCC_ID <- SCC[grep(pattern = "Vehicles", EI.Sector, ignore.case = T),]$SCC

# Filter NEI dataset first with Baltimore city (fips=="24510") then second woth Vehicles_SCC_ID
# for fatch only motor vehicle sources emissions in baltimore city 
Vehicles_Related_Emmisions_for_Baltimore_per_year <- NEI %>% 
  filter(fips=="24510") %>%
  filter(SCC %in% Vehicles_SCC_ID) %>%
  group_by(year) %>%
  summarise(Total_Emissions = sum(Emissions, na.rm = TRUE))

png(filename = "Plot5.png")

# Create line Plot for visulizing Total vehicle sources Emissions per year for Baltimore City   
temp_plot <- ggplot(Vehicles_Related_Emmisions_for_Baltimore_per_year, aes(year, Total_Emissions))

temp_plot + 
  geom_line() + 
  geom_point(col = "red",cex = 3) +
  ggtitle(label = expression("PM"[2.5]*"Vehicles Related Emmisions for Baltimore City")) + 
  ylab(label = expression("Total PM"[2.5]*" Emission"))

dev.off()
