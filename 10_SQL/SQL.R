#Load Library DBI
library(DBI)
library(RSQLite)

#Establish Your Connection
  con <- dbConnect(RSQLite::SQLite(), "C:/Users/Matthew/Dropbox/Courses Taught/Advanced_R/Github_Projects/STA_6233_Spring2021/Data/examples.db")

#Show Tables in Database
  dbListTables(con)
  
#Show Variables in Database file
  dbListFields(con, "Costs")

#Show Unique Values in a Variable in Database file
  dbGetQuery(con, "
            SELECT DISTINCT
            Orgs
            
            FROM Costs")
  
  dbGetQuery(con, "
            SELECT DISTINCT
            Region
            
            FROM Costs")
  
  dbGetQuery(con, "
            SELECT DISTINCT
            Orgs,
            Region
            
            FROM Costs")
  
#Now Let's Do a Simple Query
  #If we want all the data
  all<-dbGetQuery(con, "
            SELECT * 
            FROM Costs")
  
  #If we want to limit our data
  dbGetQuery(con, "
            SELECT * 
            FROM Costs
            Limit 100;")
  
  #If we want only some variables
  some<-dbGetQuery(con, "
            SELECT 
            Orgs,
            Months,
            Year_ID
              
            FROM Costs
            Limit 100;")
  
  #If we want to only bring back certain values
  some<-dbGetQuery(con, "
            SELECT 
            Orgs,
            Months,
            Year_ID
              
            FROM Costs
              
            WHERE Orgs='Texas Best'
              
            Limit 100;")
  
#Write Tables to Database
  dbGetQuery(con, "CREATE TABLE some AS
             SELECT 
             Orgs,
             Months,
             Year_ID
             
             FROM Costs
             
             WHERE Orgs='Texas Best'")
  
  #See if it wrote correctly
  dbListTables(con)
  dbGetQuery(con, "
            SELECT *
            FROM some")
  
  #Delete It
  dbGetQuery(con, "DROP TABLE some")
  dbListTables(con)
