#Load Library DBI
library(DBI)
library(RSQLite)

#Establish Your Connection
  con <- dbConnect(RSQLite::SQLite(), "C:/Users/Matthew/Dropbox/Courses Taught/Advanced_R/Github_Projects/STA_6233_Spring2021/Data/examples.db")

#Show Tables in Database
  dbListTables(con)
  
#Show Variables in Database file
  dbListFields(con, "Income")

#Show Unique Values in a Variable in Database file
  dbGetQuery(con, "
            SELECT DISTINCT
            Orgs
            
            FROM Income")
  
  dbGetQuery(con, "
            SELECT DISTINCT
            Region
            
            FROM Income")
  
  dbGetQuery(con, "
            SELECT DISTINCT
            Orgs,
            Region
            
            FROM Income")
  
#### Do a Simple Query ####
  #If we want all the data
  all<-dbGetQuery(con, "
            SELECT * 
            FROM Income")
  
  #If we want to limit our data
  dbGetQuery(con, "
            SELECT * 
            FROM Income
            Limit 100;")
  
  #If we want only some variables
  some<-dbGetQuery(con, "
            SELECT 
            Orgs,
            Months,
            Year_ID
              
            FROM Income
            Limit 100;")
  
  #If we want to only bring back certain values
  some<-dbGetQuery(con, "
            SELECT 
            Orgs,
            Months,
            Year_ID
              
            FROM Income
              
            WHERE Orgs='Texas Best'
              
            Limit 100;")
  
#### Complete a Table Join ####
  # See what we have in our Expenses table?
  # What should we join on?
  # Bring in Expenses column from Expenses table
  
  #Inner Join
  join<- dbGetQuery(con, "
            SELECT
            i.orgs,
            i.Months,
            i.Income,
            e.Expenses,
            e.U_ID
            
            FROM 
            Income i
            
            LEFT JOIN Expenses e
                ON i.U_ID = e.U_ID")
  
  join2<- dbGetQuery(con, "
            SELECT
            i.orgs,
            i.Months,
            i.Income,
            e.Expenses,
            e.U_ID
            
            FROM 
            Expenses e
            
            LEFT JOIN Income i
                ON i.U_ID = e.U_ID")
  #61291
  
#### Write Tables to Database ####
  dbGetQuery(con, "CREATE TABLE some AS
             SELECT 
             Orgs,
             Months,
             Year_ID
             
             FROM Income
             
             WHERE Orgs='Texas Best'")
  
  #See if it wrote correctly
  dbListTables(con)
  dbGetQuery(con, "
            SELECT *
            FROM some")
  
  #Delete It
  dbGetQuery(con, "DROP TABLE some")
  dbListTables(con)
  
#Interactions with R
