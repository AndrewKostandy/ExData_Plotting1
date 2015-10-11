plot1<-function(){
  
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
  
  ## Opening png device, creating plot1.png in working directory
  ## I set the background color to transparent since the original images are like that!
  ## You can try saving each plot on the Coursera project page as an image on your computer
  ## and opening it from there to confirm this
  png(file="plot1.png", bg=NA, width = 480, height = 480, units = "px")
  
  ## Creating histogram and sending it to file
  hist(thedata2$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency")
  
  ## Close the png file device
  dev.off()
}
plot1()

