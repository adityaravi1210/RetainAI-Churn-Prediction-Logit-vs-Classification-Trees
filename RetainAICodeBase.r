#Designing Data Products Product Spring 2022  
#Submission by: Group 19 - Akshay Manish Miniyar, Sharvari Holey, Shivani Tuli, Aditya Ravi
#Retain.AI Product Code

#Loading libraries and packages
install.packages("partykit","libcoin","mvtnorm", "grid","aod")
library(Matrix)
library(arules)
library(arulesViz)
library(grid)
library(ggplot2)
library(Performance)

#Importing Banking Dataset for 10,000 customers
churndata<-read.csv("Churn_Modelling.csv")
churndataDF<-data.frame(churndata)
head(churndataDF, n = 10L)

#Analyzing data distribution for variable in data frame
churndataDFsummary<-summary(churndataDF)
churndataDFsummary

#Data Cleaning

#checking for null values
list(NULL) %in% list(churndataDF) 

#Type of variables in data set
str(churndataDF)

#Checking for duplicates
duplicated(churndataDF)

#Separating numeric columns from non-numeric columns
library(dplyr)
numeric <- sapply(churndataDF, is.numeric)
#data columns which are numeric
numericChurnData <- churndataDF[numeric]
numericChurnData
#data columns that are not numeric
nonNumericChurnData <- churndataDF[!numericChurnData]
nonNumericChurnData

#Exploratory Data Analysis (EDA)
#Data visualization
head(churndataDF)

library(ggplot2)

# Gender Visualization
# Gender Visualization
ggplot(data.frame(churndataDF), aes(x=Exited)) +
  geom_bar()

ggplot(data.frame(churndataDF), aes(x=Gender)) +
  geom_bar()

#Customer Geography Visualization
ggplot(data.frame(churndataDF), aes(x=Geography)) +
  geom_bar()

#Customer Age Visualization
ggplot(data.frame(churndataDF), aes(x=Age)) +
  geom_bar()

#Customer Credit Card Visualization
ggplot(data.frame(churndataDF), aes(x=HasCrCard)) +
  geom_bar()

#Customer Credit Score Visualization
ggplot(data.frame(churndataDF), aes(x=CreditScore)) +
  geom_bar()

#Number of Products Visualization
ggplot(data.frame(churndataDF), aes(x=NumOfProducts)) +
  geom_bar()

#Balance vs CustomerID Visualization
BalanceData<-arrange(churndataDF, (Balance))
BalanceData
barplot(height=BalanceData$Balance,names=BalanceData$CustomerId,xlab="CustomerId", ylab="Balance",las=2,cex.names=0.5)

#Credit Score vs CustomerID Visualization
CreditScoreData<-arrange(churndataDF, (CreditScore))
CreditScoreData
barplot(height=CreditScoreData$CreditScore,names=CreditScoreData$CustomerId,xlab="CustomerId", ylab="CreditScoreData",las=2,cex.names=0.5)

#Estimated Salary vs CustomerID Visualization
SalaryData<-arrange(churndataDF, (EstimatedSalary))
SalaryData
barplot(height=SalaryData$EstimatedSalary,names=SalaryData$CustomerId,xlab="CustomerId", ylab="EstimatedSalary",las=2,cex.names=0.5)

#Number of Products vs CustomerID Visualization
ProductsData<-arrange(churndataDF, (NumOfProducts))
ProductsData
barplot(height=ProductsData$NumOfProducts,names=ProductsData$CustomerId,xlab="CustomerId", ylab="NumOfProducts",las=2,cex.names=0.5)

#Cleaning customers with 850 credit score since unusually high & seems like noise
count(churndataDF)
cleanedDF<-filter(churndataDF, CreditScore != "850")
count(cleanedDF)
churndataDF <- cleanedDF

#Customer Credit Score Visualization
ggplot(data.frame(churndataDF), aes(x=CreditScore)) +
  geom_bar()
count(train_data)
count(test_data)

#Model Creation to Predict Churned Customers & Churn Probability
#Converting dummy variable for Gender & Geography to factor into analytics model and merging to main dataset

head(churndataDF, n = 10L)
churndataDF$Gender[churndataDF$Gender=="Male"] <- 1
churndataDF$Gender[churndataDF$Gender=="Female"] <- 0
churndataDF$Gender<-as.numeric(churndataDF$Gender)
churndataDF$FranceDum[churndataDF$Geography=="France"] <- 1
churndataDF$FranceDum[churndataDF$Geography!="France"] <- 0
churndataDF$FranceDum<-as.numeric(churndataDF$FranceDum)
churndataDF$SpainDum[churndataDF$Geography=="Spain"] <- 1
churndataDF$SpainDum[churndataDF$Geography!="Spain"] <- 0
churndataDF$SpainDum<-as.numeric(churndataDF$SpainDum)
churndataDF$GermanyDum[churndataDF$Geography=="Germany"] <- 1
churndataDF$GermanyDum[churndataDF$Geography!="Germany"] <- 0
churndataDF$GermanyDum<-as.numeric(churndataDF$GermanyDum)
length <- 0.8*count(churndataDF)
length <- as.numeric(length)

#Splitting Dataset into training & testing datasets
ind<-sample(1:nrow(churndataDF), length)
train_data<-churndataDF[ind,] # create training set
test_data<-churndataDF[-ind,] # create test set
#Logistic Regression
library(stats)
library(pscl)

#Logit Model 1 Creation
result<-glm(Exited~CreditScore+Gender+Age+Tenure+Balance+NumOfProducts+HasCrCard+IsActiveMember+EstimatedSalary+FranceDum+SpainDum+GermanyDum, family=binomial(link="logit"), data=train_data)
summary(result)
check_collinearity(result) #VIF<5 implies no co-linearity
logLik(result) #log likelihood ratio
print(exp(coef(result))) # Odds of Churn
pR2(result) #R^2 Calculation

#Logit Model 2 Creation
result<-glm(Exited~CreditScore+Gender+Age+Tenure+Balance+NumOfProducts+HasCrCard+IsActiveMember+EstimatedSalary+FranceDum+SpainDum, family=binomial(link="logit"), data=train_data)
summary(result)
check_collinearity(result) #VIF<5 implies no co-linearity
logLik(result) #log likelihood ratio
print(exp(coef(result))) # Odds of Churn
pR2(result) #R^2 Calculation

#Logit Model 3 Creation
result<-glm(Exited~CreditScore+Gender+Age+Tenure+Balance+NumOfProducts+HasCrCard+IsActiveMember+FranceDum+SpainDum, family=binomial(link="logit"), data=train_data)
summary(result)
check_collinearity(result) #VIF<5 implies no co-linearity
logLik(result) #log likelihood ratio
print(exp(coef(result))) # Odds of Churn
pR2(result) #R^2 Calculation

#Logit Model 4 Creation
result<-glm(Exited~CreditScore+Gender+Age+Balance+NumOfProducts+HasCrCard+IsActiveMember+FranceDum+SpainDum, family=binomial(link="logit"), data=train_data)
summary(result)
check_collinearity(result) #VIF<5 implies no co-linearity
logLik(result) #log likelihood ratio
print(exp(coef(result))) # Odds of Churn
pR2(result) #R^2 Calculation


#Logit Model 5 Creation
result<-glm(Exited~CreditScore+Gender+Age+Balance+NumOfProducts+IsActiveMember+FranceDum+SpainDum, family=binomial(link="logit"), data=train_data)
summary(result)
check_collinearity(result) #VIF<5 implies no co-linearity
logLik(result) #log likelihood ratio
print(exp(coef(result))) # Odds of Churn
pR2(result) #R^2 Calculation

#Logit Model 6 Creation
result<-glm(Exited~CreditScore+Gender+Age+Balance+IsActiveMember+FranceDum+SpainDum, family=binomial(link="logit"), data=train_data)
summary(result)
check_collinearity(result) #VIF<5 implies no co-linearity
#wald.test(b = coef(result), Sigma = vcov(result))
logLik(result) #log likelihood ratio
print(exp(coef(result))) # Odds of Churn
pR2(result) #R^2 Calculation
#Predicting with Test dataset
probabilities <- result %>% predict(test_data, type = "response")
head(probabilities)

b0<-coef(result)["(Intercept)"]
b1<-coef(result)["CreditScore"]
b2<-coef(result)["Gender"]
b3<-coef(result)["Age"]
b4<-coef(result)["Balance"]
b5<-coef(result)["IsActiveMember"]
b6<-coef(result)["FranceDum"]
b7<-coef(result)["SpainDum"]

a<-test_data
#Generating log-odds ratio
a$logodds <- (b0 + (b1*test_data$CreditScore) + (b2*test_data$Gender) + (b3* test_data$Age) + (b4* test_data$Balance) + (b5*test_data$IsActiveMember) + (b6 * test_data$FranceDum) + (b7* test_data$SpainDum))
#generating odds
a$odds<-exp(a$logodds)
#Calculating churn probability
a$probability <- (a$odds/(1+a$odds))
a$probability
test_data$probability<-a$probability
write.csv(test_data,"/Users/adityaravi/Downloads/CustomerDatabase.csv", row.names = FALSE)

test_data$Exited<-as.numeric(test_data$Exited)
test_data$Exited<-as.factor(test_data$Exited)

#contrasts(test_data$Exited)

#Predicting Accuracy of Logit Model 6
predicted.churn <- ifelse(probabilities > 0.5, "1", "0")
predicted.churn
head(predicted.churn)
mean(predicted.churn == test_data$Exited) #Churn Predictions made correctly with Logit Model

#Prediction Method 2
#Predicting Accuracy of Our Logit Model
predicted.churn <- ifelse(test_data$probability > 0.5, "1", "0")
mean(predicted.churn == test_data$Exited) #Churn Predictions made correctly with Logit Model

temp<-predicted.churn
temp<-as.factor(temp)
test_data$Exited<-as.factor(test_data$Exited)

#ConfusionMatrix for Logit Model
library(caret)
confusionMatrix(data = temp, reference = test_data$Exited)
typeof(predicted.churn)

temp<-predicted.churn
temp<-as.integer(temp)

#generating AUC Plot for logit model
library(pROC)
auc(test_data$Exited,temp)

#User input to generate a list of customers who are likely to churn
print("This tool provides a list of active customers arranged by their likelihood to churn from your organization.")
print("What proportion of your active customerbase would you like to query based on their churn likelihood?")
a <- readline(prompt="Enter a percentage value from 0 to 100:")
a <- as.integer(a)
a<-(a/100)
ActiveCustomerList<-subset(test_data, test_data$probability<"0.5")   
ActiveCustomerList<-ActiveCustomerList[order(-ActiveCustomerList$probability),]
ChurnedCustomerList<-subset(test_data, test_data$probability>"0.5")   
ChurnedCustomerList<-ChurnedCustomerList[order(-ChurnedCustomerList$probability),]
totalCustomerCount<- count(test_data)
ActiveCustomerCount <- count(ActiveCustomerList)
ChurnedCustomerCount <- count(ChurnedCustomerList)
totalCustomerCount<-as.integer(totalCustomerCount)
ActiveCustomerCount<-as.integer(ActiveCustomerCount)
ChurnedCustomerCount<-as.integer(ChurnedCustomerCount)
ChurnedCustomerPercentage <- (ChurnedCustomerCount/totalCustomerCount)*100
ChurnedCustomerPercentage<-as.integer(ChurnedCustomerPercentage)
print("Customer Metrics-")
sprintf("Total Customers Count: %d",totalCustomerCount)
sprintf("Active Customer Count: %d",ActiveCustomerCount)
sprintf("Churned Customers Count: %d",ChurnedCustomerCount)
sprintf("Churned Customer Percentage: %d percent",ChurnedCustomerPercentage)
write.csv(ActiveCustomerList,"/Users/adityaravi/Downloads/ActiveCustomerList.csv", row.names = FALSE)
write.csv(ChurnedCustomerList,"/Users/adityaravi/Downloads/ChurnedCustomerList.csv", row.names = FALSE)

CustomerCount<-a*count(ActiveCustomerList)
CustomerCount<-as.integer(CustomerCount)
PotentialChurnList <- ActiveCustomerList[1:CustomerCount,]
empty = matrix(ncol = 0, nrow = CustomerCount)
ExportChurnList=data.frame(empty)
ExportChurnList$CustomerId<-PotentialChurnList$CustomerId
ExportChurnList$Surname<-PotentialChurnList$Surname
ExportChurnList$Age<-PotentialChurnList$Age
ExportChurnList$Geography<-PotentialChurnList$Geography
ExportChurnList$Tenure<-PotentialChurnList$Tenure
ExportChurnList$Balance<-PotentialChurnList$Balance
ExportChurnList$NumOfProducts<-PotentialChurnList$NumOfProducts
ExportChurnList$HasCrCard<-PotentialChurnList$HasCrCard
ExportChurnList$IsActiveMember<-PotentialChurnList$IsActiveMember
ExportChurnList$ChurnProbability<-PotentialChurnList$probability
write.csv(ExportChurnList,"/Users/adityaravi/Downloads/PotentialChurnList.csv", row.names = FALSE)
print("Please check your downloads folder for the Active Customers, Exited Customers & Customers likely to churn lists")



#Creating Classification Trees
library(partykit)
library(grid)
library(libcoin)
library(mvtnorm)

test_data$Exited<- as.numeric(test_data$Exited)
train_data$Exited<- as.numeric(train_data$Exited)
test_data$Exited


test_data$Exited[test_data$Exited=="1"] <- 0
test_data$Exited[test_data$Exited=="2"] <- 1
numeric <- sapply(train_data, is.numeric)
train_data <- train_data[numeric]
numeric <- sapply(test_data, is.numeric)
test_data <- test_data[numeric]

#Creating the classification tree model
ctout <- ctree(Exited ~ .,data=train_data) # Recall that the . indicates that R should use all the
plot(ctout)
# variables in the dataset.

#Predicting with CT Model
ctpred <- predict(ctout, data = test_data)
predicted.churn <- ifelse(ctpred > 0.5, "1", "0")
mean(predicted.churn == test_data$Exited)

temp<-predicted.churn
temp<-as.integer(temp)
length(temp)

#generating AUC Plot for CF Model
library(pROC)
auc(test_data$Exited,temp)

#Classification Trees - Random Forest Approach
#Creating the Random Forest Model
cfout <- cforest(Exited ~ .,ntree=20, data=test_data) 
#Testing RF Model
cfpred <- predict(cfout, data = test_data)
predicted.churn <- ifelse(cfpred > 0.5, "1", "0")
mean(predicted.churn == test_data$Exited)
auc(test_data$Exited,temp)

