library(dplyr)

# checking both variable is available or not and not then run "Getting_Data_from_Link.R" to get
if(!exists("NEI") && !exists("SCC")){
  source("Getting_Data_from_Link.R")
}

# Create a variable Emissions_per_year(4 rows and 2 cols ) which contain per year total Emissions 
Emissions_per_year <- NEI %>% 
  group_by(year) %>% # create group in NEI by year
  summarize(Total_Emissions = sum(Emissions, na.rm = TRUE)) 

# Open PNG graphics device for saving a plot
png(filename = "Plot1.png", bg = "transparent")

# Create line Plot for visulizing Total Emissions per year  
with( Emissions_per_year, plot(year, Total_Emissions, type = "l", 
                               xlab = "Year", 
                               ylab = expression("Total PM"[2.5]*" Emission"), 
                               main = expression("Total PM"[2.5]*" Emissions at various years")))

# Mention points in plot
points(Emissions_per_year, col = "red", pch = 19, cex = 2)
dev.off()
