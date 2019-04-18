library(dplyr)
library(ggplot2)

# checking both variable is available or not and not then run "Getting_Data_from_Link.R" to get
if(!exists("NEI") && !exists("SCC")){
  source("Getting_Data_from_Link.R")
}

# Create a variable Emissions_per_year(4 rows and 2 cols ) which contain per year total Emissions 
Emissions_per_year_for_Baltimore <- NEI %>% 
  filter(fips == "24510") %>%
  group_by(year, type) %>% # create group in NEI by year
  summarize(Total_Emissions = sum(Emissions, na.rm = TRUE)) 

# Open PNG graphics device for saving a plot
png(filename = "Plot3.png")

# Create line Plot for visulizing Total Emissions by type of source per year for Baltimore City   
temp_plot <- ggplot(Emissions_per_year_for_Baltimore, aes(year, Total_Emissions, group = type, col = type))

temp_plot + 
  geom_line() + 
  geom_point() + 
  ggtitle(label = expression("PM"[2.5]*" Emissions by type at various years for Baltimore City")) + 
  ylab(label = expression("Total PM"[2.5]*" Emission in Baltimore City")) + 
  guides(color=guide_legend("Type of Source"))

dev.off()
