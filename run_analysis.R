test<-read.csv("C:/Users/ÓêÍ©/Documents/Rfirst/UCI HAR Dataset/test/subject_test.txt")
train<-read.csv("C:/Users/ÓêÍ©/Documents/Rfirst/UCI HAR Dataset/train/subject_train.txt")
# train data
x_train <- read.table(paste(sep = "", "UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(paste(sep = "", "UCI HAR Dataset/train/Y_train.txt"))
s_train <- read.table(paste(sep = "", "UCI HAR Dataset/train/subject_train.txt"))
x_test <- read.table(paste(sep = "", "UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(paste(sep = "", "UCI HAR Dataset/test/Y_test.txt"))
s_test <- read.table(paste(sep = "", "UCI HAR Dataset/test/subject_test.txt"))
mergedx<-merge(x_test,x_train,all=TRUE)
mergedy<-rbind(y_test,y_train)
mergeds<-merge(s_test,s_train,all=TRUE)

#extract min and std
minstd<-mergedx[,c(1:6,41:46,81:86,121:126,161:166,
                   201:202,227:228,240:241,
                   253:254,266:271,345:350,424:429,
                   503:504,516:517,529:530,
                   542:543)]
Testtrainmeanstd<-fread(minstd,n)
actlabel<-read.table(paste(sep = "", "UCI HAR Dataset/activity_labels.txt"))
feature<-read.table(paste(sep = "", "UCI HAR Dataset/features.txt"))
names(minstd)<-feature[c(1:6,41:46,81:86,121:126,161:166,
                             201:202,227:228,240:241,
                             253:254,266:271,345:350,424:429,
                             503:504,516:517,529:530,
                             542:543),2]
mergedy[, 1] <- read.table("UCI HAR Dataset/activity_labels.txt")[mergedy[, 1], 2]
names(mergedy)<-"actlabel"
names(mergeds)<-"Subject"

DataSet <- cbind(minstd, mergedy, mergeds)
tidydata<-aggregate(. ~Subject + actlabel, DataSet, mean)
tidydata<-tidydata[order(tidydata$Subject,tidydata$actlabel),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)