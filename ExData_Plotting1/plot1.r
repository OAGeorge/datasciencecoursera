#read in data files skipping all lines except those within the 2 days in question

powerdata <- read.table("household_power_consumption.txt", header= TRUE, na.strings ="?", sep = ";", skip = grep("1/2/2007", readLines("household_power_consumption.txt")),nrows = 2880)

# add headers back to the file and convert the dates and times
names(powerdata) <-c("Date", "Time", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

powerdata$Date <- as.Date(powerdata$Date,"%d/%m/%Y")

X <- as.character(powerdata$Time)
x <-paste(powerdata$Date, powerdata$Time)

powerdata$Time <- strptime(x, "%Y-%m-%d %H:%M:%S")

rm("X", "x")
#generate the png of the data
png(filename="plot1.png")

with(powerdata, hist(Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)"))
 
dev.off()
                        