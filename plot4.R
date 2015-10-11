plot4<-function(){
  
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
  
  ## Opening png device, creating plot4.png in working directory
  ## I set the background color to transparent since the original images are like that!
  ## You can try saving each plot on the Coursera project page as an image on your computer
  ## and opening it from there to confirm this
  png(file="plot4.png", bg=NA, width = 480, height = 480, units = "px")
  
  ## Setting the stage for a 2 rows by 2 columns space to show 4 plots
  ## mfcol ensures the plots are drawn in the order of column by column
  par(mfcol=c(2,2))
  
  ## Drawing the first plot
  with(thedata2,plot(Time,Global_active_power,xlab="", ylab="Global Active Power (kilowatts)",type="l"))
  
  ## Drawing the second plot adding the different points of the variables
  ## Also creating a legend for this plot and ensuring the legend has no border
  plot(thedata2$Time,thedata2$Sub_metering_1,xlab="", ylab="Energy sub metering",type="l")
  points(thedata2$Time,thedata2$Sub_metering_2,col="red",type="l")
  points(thedata2$Time,thedata2$Sub_metering_3,col="blue",type="l")
  legend("topright",bty="n", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  ## Drawing the third plot
  with(thedata2,plot(Time,Voltage,xlab="datetime", ylab="Voltage",type="l"))
  
  ## Drawing the fourth plot
  with(thedata2,plot(Time,Global_reactive_power,xlab="datetime", ylab="Global_reactive_power",type="l"))
  
  ## Close the png file device
  dev.off()
  
}
plot4()