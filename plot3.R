plot3<-function(){
  
  ## Reading the text file into a data frame
  ## The text file needs to be in your working directory
  thefile<-"household_power_consumption.txt"
  thedata2<-read.table(thefile,header=TRUE, sep=";",na.strings = "?")
  
  ## Converting the Date column into a date class
  thedata2$Date<-as.Date(thedata2$Date,"%d/%m/%Y")
  
  ## Subsetting the data based on the date values needed
  thedata2<-subset(thedata2,Date=="2007-02-01" | Date=="2007-02-02")
  
  ## Merging the date info with the time info and converting the Time column to one of the R time classes
  thedata2<-within(thedata2, {Time= paste(Date,Time)})
  thedata2$Time<-strptime(thedata2$Time, "%Y-%m-%d %H:%M:%S")
  
  ## Changing the rownames to start from 1 as the subsetting causes rownames to be like the original data
  rownames(thedata2) <- seq(length=nrow(thedata2))
  
  ## Opening png device, creating plot3.png in working directory
  png(file="plot3.png", width = 480, height = 480, units = "px")
  
  ## Creating plot and adding the different points of the variables and sending it all to file
  plot(thedata2$Time,thedata2$Sub_metering_1,xlab="", ylab="Energy sub metering",type="l")
  points(thedata2$Time,thedata2$Sub_metering_2,col="red",type="l")
  points(thedata2$Time,thedata2$Sub_metering_3,col="blue",type="l")
  
  ## Creating a legend
  legend("topright",lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  ## Close the png file device
  dev.off()
  
}
plot3()