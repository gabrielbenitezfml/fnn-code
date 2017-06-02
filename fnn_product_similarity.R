library(FNN)

#For the Fast Nearest Neighbour(FNN) we will need only the price and the category id

df_table <- products[,4:5]

#Verify if the table was correctly sliced

head(df_table)

#Now Its time to apply the FNN algorith to find the nearest neighbour for each product

model<-get.knn(df_table, k = 5, algorithm = "cover_tree")

#We check if the algorithm is correct by calling one line and see if it matches

model$nn.index[2,]

#The line 2 correspond to the product "Handtowel"
#It has given back 5 indexes: (3:"Washcloth", 1:"Large Towel",11:"Shower Cap",
#9: "Tissues",14: "Pillowcase)
#As we see the algorithm works very well so its time to put it together

#The next step is to merge the data into one table.
#In order to do that we need to create a new table with the neighbours indexes

index_table <- as.data.frame(model$nn.index,colnames(c("n1","n2","n3","n4","n5")))

#After that we just need to replace the index for the productname so we know which
#the name of each closest product

products$neighbour1 <- products$ProductName[index_table$V1]
products$neighbour2 <- products$ProductName[index_table$V2]
products$neighbour3 <- products$ProductName[index_table$V3]
products$neighbour4 <- products$ProductName[index_table$V4]
products$neighbour5 <- products$ProductName[index_table$V5]

#So we finally have the table we were looking for, we just need to simple
#export it as csv and we are done

write.csv(products,"crossseling.csv")
