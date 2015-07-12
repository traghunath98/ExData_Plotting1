## The function below reads the data file "household_power_consumption.txt" and plots the third graph - Energy Sub metering with Time
## Data within a two day range - 1st Feb 2007 and 2nd Feb 2007 is considered.
## The graphs are generated as PNG images and stored as separate files.
## The data file has over 2 million records. The function does the following: a) Reads all the rows (replace "?" character with NA), b) subsets the data frame to get data for the 2 days, c) concatenate the date and time fields to form a datetime field and d) plot the graphs
plot3 <- function() {
    
    # Read all the data into the all_power_data variable. read.csv2 function takes ";" as separator by default
   	all_power_data <- read.csv2(file="household_power_consumption.txt", stringsAsFactors=FALSE, na.strings="?")
   	
   	# Subset the data for 1st Feb 2007 and 2nd Feb 2007 
    sel_power_data <- subset(all_power_data, ((as.Date(Date,"%d/%m/%Y") >= as.Date("01/02/2007","%d/%m/%Y")) & ((as.Date(Date,"%d/%m/%Y") <= as.Date("02/02/2007","%d/%m/%Y")))))

	# Add the date and time field for plotting graphs
	sel_power_data$DateAndTime <- strptime(paste(sel_power_data$Date, sel_power_data$Time, sep=" "),"%d/%m/%Y %T")
	
	# Convert to numeric - Sub metering related data that is required to be plotted
	sel_power_data$Sub_metering_1 <- as.numeric(sel_power_data$Sub_metering_1)
	sel_power_data$Sub_metering_2 <- as.numeric(sel_power_data$Sub_metering_2)
	sel_power_data$Sub_metering_3 <- as.numeric(sel_power_data$Sub_metering_3)

	# Open the png device - by default its 480 x 480 pixels wide
	png("plot3.png")
	
	# Plot the line graphs depicting energy sub metering
	plot(sel_power_data$DateAndTime,sel_power_data$Sub_metering_1, main="", xlab="", ylab="Energy sub metering", type="l")
	lines(sel_power_data$DateAndTime, sel_power_data$Sub_metering_2, type="l", col="red")	
	lines(sel_power_data$DateAndTime, sel_power_data$Sub_metering_3, type="l", col="blue")
	
	legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"))
		
	dev.off()  	    
}
