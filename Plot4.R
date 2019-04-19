library(dplyr)
library(ggplot2)

# checking both variable is available or not and not then run "Getting_Data_from_Link.R" to get
if(!exists("NEI") && !exists("SCC")){
  source("Getting_Data_from_Link.R")
}

# Create a vector Coal_SCC_ID which contain sources ID from coal combustion-related sources
Coal_SCC_ID <- SCC[grep(pattern = "coal", EI.Sector, ignore.case = T),]$SCC

# filter NEI dataset with Coal_SCC_ID for grab only
Coal_Combustion_Related_Emmisions_Per_Year <- NEI %>% 
                                                filter(SCC %in% Coal_SCC_ID) %>%
                                                group_by(year) %>%
                                                summarise(Total_Emissions = sum(Emissions, na.rm = TRUE))
png(filename = "Plot4.png")

# Create line Plot for visulizing Total Emissions by type of source per year for Baltimore City   
temp_plot <- ggplot(Coal_Combustion_Related_Emmisions_Per_Year, aes(year, Total_Emissions))

temp_plot + 
  geom_line() + 
  geom_point(col = "red",cex = 3) +
  ggtitle(label = expression("PM"[2.5]*"Coal Combustion Related Emissions by type at various years")) + 
  ylab(label = expression("Total PM"[2.5]*" Emission"))

dev.off()
