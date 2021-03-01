
#Insert Your Number Here
your_num<-35

set.seed(134)
s<-sample(1:37, 37, replace=F)
pos<-match(your_num, s)
if(pos>1 & pos<37){
  feedback_nums<-c(s[pos+1], s[pos-1])
}else if(pos==1){
  feedback_nums<-c(s[pos+1], s[length(s)])
}else if(pos==37){
  feedback_nums<-c(s[length(pos)], s[pos-1])
}
 
print(paste0("You will provide feeback for projects ", feedback_nums[1], " and ", feedback_nums[2]))
