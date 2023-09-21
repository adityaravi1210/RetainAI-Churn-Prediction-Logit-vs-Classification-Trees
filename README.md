# Retain.AI Customer Churn Prediction

This repository contains an R project focused on analyzing and predicting customer churn in a banking dataset. The primary aim is not only to understand the factors influencing customers to leave (or churn) but also to predict potential churn using advanced statistical methods. This assists banks in proactively addressing potential churn risks.

## Project Objectives

1. **Data Understanding and Cleaning**:
    - Analyze the banking dataset containing information about 10,000 customers.
    - Understand data distribution, data types, and perform necessary data cleaning.

2. **Exploratory Data Analysis (EDA)**:
    - Gain insights into the dataset through thorough EDA.
    - Visualize key metrics to provide a comprehensive view of factors affecting churn.

3. **Predictive Analysis**:
    - Employ statistical models like logistic regression, classification trees, and random forests to predict customer churn.
    - Provide banks with lists of active customers and those at risk of churning, enabling them to take preventive measures.

## Dataset

The dataset, `Churn_Modelling.csv`, consists of the following attributes:
- `RowNumber`: Unique identifier for each row.
- `CustomerId`: Unique identifier for each customer.
- `Surname`: Customer's surname.
- `CreditScore`: Customer's credit score.
- `Geography`: Customer's country of residence.
- `Gender`: Customer's gender.
- `Age`: Customer's age.
- `Tenure`: Number of years customer has been with the bank.
- `Balance`: Customer's account balance.
- `NumOfProducts`: Number of bank products/services customer has.
- `HasCrCard`: Whether the customer has a credit card (1 for Yes, 0 for No).
- `IsActiveMember`: Customer's active membership status (1 for Yes, 0 for No).
- `EstimatedSalary`: Customer's estimated salary.
- `Exited`: Whether the customer exited the bank (1 for Yes, 0 for No).

## Libraries Used

- `Matrix`
- `arules`
- `arulesViz`
- `grid`
- `ggplot2`
- `Performance`
- `dplyr`
- `partykit`
- `libcoin`
- `mvtnorm`
- `aod`

## Statistical Methods

In addition to descriptive statistics and visualization techniques, the project leverages the following predictive modeling techniques:

- **Logistic Regression**: A statistical method for analyzing datasets where the outcome is binary. In this project, it is used to predict the likelihood of a customer churning.
  
- **Classification Trees (Decision Trees)**: Non-parametric supervised learning methods used for classification. It breaks down the dataset into subsets while incrementally developing associated decision trees.
  
- **Random Forest**: An ensemble learning method for classification. It operates by constructing multiple decision trees during training and outputs the class that is the mode of the classes of individual trees.

## How to Run

1. Ensure you have R installed on your machine.
2. Clone this repository.
3. Open the `RetainAICodeBase.r` file in your preferred R environment.
4. Run the script to view the analysis and visualizations.

## Contributors

- Akshay Manish Miniyar
- Sharvari Holey
- Shivani Tuli
- Aditya Ravi

---

Feel free to contribute, raise issues, or provide feedback. Your contributions are always welcome!
