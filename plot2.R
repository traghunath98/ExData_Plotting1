## The function below reads the data file "household_power_consumption.txt" and plots the second graph - Global Active Power with Time
## for the data within a two day range - 1st Feb 2007 and 2nd Feb 2007.
## The graphs are generated as PNG images and stored as separate files.
## The data file has over 2 million records. The function does the following: a) Reads all the rows (replace "?" character with NA), b) subsets the data frame to get data for the 2 days, c) concatenate the date and time fields to form a datetime field and d) plot the graphs
plot2 <- function() {
    
    # Read all the data into the all_power_data variable. read.csv2 function takes ";" as separator by default
   	all_power_data <- read.csv2(file="household_power_consumption.txt", stringsAsFactors=FALSE, na.strings="?")
   	
   	# Subset the data for 1st Feb 2007 and 2nd Feb 2007 
    sel_power_data <- subset(all_power_data, ((as.Date(Date,"%d/%m/%Y") >= as.Date("01/02/2007","%d/%m/%Y")) & ((as.Date(Date,"%d/%m/%Y") <= as.Date("02/02/2007","%d/%m/%Y")))))

	# Add the date and time field for plotting graphs
	sel_power_data$DateAndTime <- strptime(paste(sel_power_data$Date, sel_power_data$Time, sep=" "),"%d/%m/%Y %T")
	
	# Convert to numeric - Global Active Power
	sel_power_data$Global_active_power <- as.numeric(sel_power_data$Global_active_power)

	# Open the png device - by default its 480 x 480 pixels wide
	png("plot2.png")
	
	# Plot the line plot depicting global active power with time
	plot(sel_power_data$DateAndTime,sel_power_data$Global_active_power, main="", xlab="", ylab="Global Active Power (kilowatts)", type="l")	
	
	dev.off()  	    
}
