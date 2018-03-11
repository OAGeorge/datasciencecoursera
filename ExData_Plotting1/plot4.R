# #read in data files skipping all lines except those within the 2 days in question
# powerdata <- read.table("household_power_consumption.txt", header= TRUE, na.strings ="?", sep = ";", skip = grep("1/2/2007", readLines("household_power_consumption.txt")),nrows = 2880)
# 
# ## add headers back to the file and convert the dates and times
# names(powerdata) <-c("Date", "Time", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
# 
# powerdata$Date <- as.Date(powerdata$Date,"%d/%m/%Y")
# 
# X <- as.character(powerdata$Time)
# x <-paste(powerdata$Date, powerdata$Time)
# 
# powerdata$Time <- strptime(x, "%Y-%m-%d %H:%M:%S")

#generate 4 sets of plots to include the plot of sub metering vs time, Global Active Power vs time, Voltage vs time, and Global Reactive power vs time

png(filename="plot4.png")
par(mfcol = c(2,2), mar =c(4,4,2,1))

#plot 1
with(powerdata, plot(Time, Global_active_power, type="l",  ylab = "Global Active Power (kilowatts)", xlab = ""))

#plot2
with(powerdata, plot(Time, Global_active_power, type="n",  ylab = "Energy sub metering", xlab = "", ylim=c(0,40)))

points(powerdata$Time, powerdata$Sub_metering_1, type="l")
points(powerdata$Time, powerdata$Sub_metering_2, type="l", col = "red")
points(powerdata$Time, powerdata$Sub_metering_3, type="l", col ="blue")

legend("topright", lty=c(1,1,1), col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#plot 3
with(powerdata, plot(Time, Voltage, type="l",  ylab = "Voltage)", xlab = "datetime"))

#plot 4

with(powerdata, plot(Time, Global_reactive_power, type="l",  ylab = "Global_reactive_power", xlab = "datetime"))

dev.off()
