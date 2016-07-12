setwd("C:/Users/JGOGOI/Desktop/R Programs/")
list.files()

#Load Packages
library(dplyr)
library(tidyr)

#read the data from the file
refine <- read.table("refine_original.csv",header = TRUE, sep = "," )

#1: Clean up brand names
refine$company <- tolower(refine$company)

#2: Separate product code and number 
refine <- refine %>% separate(Product.code...number, c("product_code","product_number"), sep= "-")

# add a new list of products and it's product code
list<- list(product_code = c('p','v','x','q'),categories = c('smartphone','TV','Laptop','Tablet'))

# 3: Add product categories: join two table between list and refine

refine <- merge(refine,list, by = "product_code", all = TRUE)

# 4: Add full address for geocoding: Combining the field
refine_Final <- unite_(refine, "Fulladdress",c("country", "city", "address"),sep= ", ")

#check the final data
View(refine_Final)