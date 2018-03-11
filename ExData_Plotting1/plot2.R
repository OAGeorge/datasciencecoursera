#read in data files skipping all lines except those within the 2 days in question

powerdata <- read.table("household_power_consumption.txt", header= TRUE, na.strings ="?", sep = ";", skip = grep("1/2/2007", readLines("household_power_consumption.txt")),nrows = 2880)

## add headers back to the file and convert the dates and times
 names(powerdata) <-c("Date", "Time", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
 
powerdata$Date <- as.Date(powerdata$Date,"%d/%m/%Y")

X <- as.character(powerdata$Time)
x <-paste(powerdata$Date, powerdata$Time)
 
powerdata$Time <- strptime(x, "%Y-%m-%d %H:%M:%S")


png(filename="plot2.png")

with(powerdata, plot(Time, Global_active_power, type="l",  ylab = "Global Active Power (kilowatts)", xlab = ""))


dev.off()
