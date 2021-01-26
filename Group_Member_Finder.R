#### Run This Code to Find Your Group Members
#Bring in student list
  stu<-read.csv("https://raw.githubusercontent.com/mattdemography/STA_6233_Spring2021/main/Data/abc123_list.csv", header=F)

#Insert Your Number Here
  your_num<-6
  
  set.seed(134)
  s<-sample(1:33, 33, replace=F)
  teams<-as.data.frame(s)
  teams$rownum<-as.numeric(rownames(teams))
  teams$GroupNum<-ifelse(teams$rownum<=4, 1, ifelse(teams$rownum<=8 & teams$rownum>4, 2, 
    ifelse(teams$rownum<=12 & teams$rownum>8, 3, ifelse(teams$rownum<=16 & teams$rownum>12, 4, 
    ifelse(teams$rownum<=20 & teams$rownum>16, 5, ifelse(teams$rownum<=24 & teams$rownum>20, 6,
    ifelse(teams$rownum<=28 & teams$rownum>24, 7, 8)))))))

#Merge with Student abc123 Data
  teams<-merge(teams, stu, by.x="s", by.y="V1")

#Find Your Teammates
  your_group<-subset(teams, teams$s==your_num)
  your_group<-as.numeric(your_group[3])
  team_sub<-subset(teams, teams$GroupNum==your_group) #Creating Subset of just your teammates
  team_sub<-subset(team_sub, team_sub$s!=your_num)
  
  for(i in 1:nrow(team_sub)){
    print(paste0("Your group number is ", your_group," and your teammates' e-mails are ",
                 team_sub[i,4], "@my.utsa.edu"))  
  }
  