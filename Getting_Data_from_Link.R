library("data.table")

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url = URL, destfile = "data_file.zip")

# unzip downloaded data file 
unzip("data_file.zip")

# Create a variable tibble
NEI <- as.data.table(readRDS(file = "summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS(file = "Source_Classification_Code.rds"))
