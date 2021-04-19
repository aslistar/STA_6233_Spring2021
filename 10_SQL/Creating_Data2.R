library(dplyr)

#Set size of dataset
size_cost<-20000

Years_c<-sample(c(2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019), size_cost, replace=T)
Months_c<-sample(c("January", "February", "March", "April", "May", "June", "July",
                 "August", "September", "October", "November", "December"), size_cost, replace=T)
Orgs_c<-sample(c("Tri West", "Tri South", "Texas Best", "Helping Here", "Silver and Black Give Back",
               "Mike's Tots", "Purple Cross"), size_cost, replace=T)
Region_c<-sample(c("South", "West", "North", "East"), size_cost, replace=T)
Cost_c<-sample(100:100000, size_cost, replace=T)

Costs<-data.frame(Orgs=character(), Months=character(), Region=character(), 
              Years=numeric(), Cost=numeric())
  Costs<-Costs[1:size_cost,]
  Costs$Orgs<-Orgs_c
  Costs$Months<-Months_c
  Costs$Region<-Region_c
  Costs$Years<-Years_c
  Costs$Cost<-Cost_c
  Costs$Group_ID <- Costs %>% group_indices(Orgs)
  Costs$Month_ID <- Costs %>% group_indices(Months)
  Costs$Region_ID <- Costs %>% group_indices(Region)
  Costs$Year_ID <- Costs %>% group_indices(Years)
  Costs$U_ID <- paste0(Costs$Group_ID, Costs$Month_ID, Costs$Year_ID, Costs$Region_ID)

saveRDS(Costs, "C:/Users/Matthew/Dropbox/Courses Taught/Advanced_R/Github_Projects/STA_6233_Spring2021/Data/Costs.RData")

#Now Create Expenditure Data that is identical for org/month/region/year combination
size_exp<-table(duplicated(Costs$U_ID))[1]

Years_e<-sample(c(2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019), size_exp, replace=T)
Months_e<-sample(c("January", "February", "March", "April", "May", "June", "July",
                   "August", "September", "October", "November", "December"), size_exp, replace=T)
Orgs_e<-sample(c("Tri West", "Tri South", "Texas Best", "Helping Here", "Silver and Black Give Back",
                 "Mike's Tots", "Purple Cross"), size_exp, replace=T)
Region_e<-sample(c("South", "West", "North", "East"), size_exp, replace=T)
Cost_e<-sample(100:100000, size_exp, replace=T)

Expenses<-data.frame(Orgs=character(), Months=character(), Region=character(), 
                     Years=numeric(), Expenses=numeric())
  Expenses<-Expenses[1:size_exp,]
  Expenses$Orgs<-Orgs_e
  Expenses$Months<-Months_e
  Expenses$Region<-Region_e
  Expenses$Years<-Years_e
  Expenses$Cost<-Cost_e
  Expenses$Group_ID <- Expenses %>% group_indices(Orgs)
  Expenses$Month_ID <- Expenses %>% group_indices(Months)
  Expenses$Region_ID <-Expenses %>% group_indices(Region)
  Expenses$Year_ID <- Expenses %>% group_indices(Years)
  Expenses$U_ID <- paste0(Expenses$Group_ID, Expenses$Month_ID, Expenses$Year_ID, Expenses$Region_ID)

saveRDS(Expenses, "C:/Users/Matthew/Dropbox/Courses Taught/Advanced_R/Github_Projects/STA_6233_Spring2021/Data/Expenses.RData")

#Save To Database for SQL Examples
  conn <- dbConnect(SQLite(),'C:/Users/Matthew/Dropbox/Courses Taught/Advanced_R/Github_Projects/STA_6233_Spring2021/Data/examples.db')
  dbWriteTable(conn, "Costs", Costs)
  dbWriteTable(conn, "Expenses", Expenses)
