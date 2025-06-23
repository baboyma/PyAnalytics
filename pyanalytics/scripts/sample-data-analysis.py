#!/usr/bin/env python

"""
    Project: Data Analysis with Python Pandas and Matplotlib (Advanced)
    Tools: Python, Pandas, Matplotlib
    Goal: Learn how to analyze data, manipulate datasets, and visualize insights through graphs and charts
    Date: 2025-02-10
    Source: https://blog.stackademic.com/data-analysis-with-python-pandas-and-matplotlib-advanced-a9615a3dff6f
"""

# Setup

## install pandas and matplotlib
## poetry add pandas matplotlib

# Libraries

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from skimpy import clean_columns
from utilities import glimpse

# Pandas data structures

## Series

data = [10, 20, 30, 40]
sdata = pd.Series(data)
print(sdata)

## DataFrame - two-dimenstional data structure

data = {
    'Name': ['John', 'Jane', 'Mike'],
    'Age': [23, 25, 30]
}

df = pd.DataFrame(data)
print(df)

# Data Import

url_data = "https://media.geeksforgeeks.org/wp-content/uploads/employees.csv"
data = pd.read_csv(url_data)
glimpse(data)
data = clean_columns(data, replace = {'Bonus %': 'Bonus Perc'})
glimpse(data)
print(data.head())

## Fill missing data
data = data.fillna(0)

## Drop rows with missing data
data = data.dropna()

## Explore data

print(data['gender'])

print(data[data['gender'] == 'Male'])

data = data.sort_values(by='bonus_perc')

print(data)

print(data.groupby('senior_management')['bonus_perc'].mean())

# VIZ

plt.plot(data['bonus_perc'])
plt.title("Bonus Distribution")
plt.xlabel("Index")
plt.ylabel("Bonus")
#plt.show()

data['bonus_perc'].value_counts().plot(kind='bar')
plt.title("Bonus Frequency")
plt.xlabel("Bonus")
plt.ylabel("Frequency")
#plt.show()

data['bonus_perc'].plot(kind='hist', bins = 10)
plt.title("Bonus Distribution")
plt.xlabel("Bonus")
#plt.show()

plt.clf()
plt.close()

# Use Case

## Create Employee Dataset
data = {
    'Employee_ID': range(1001, 1011),
    'Name': ['Alice', 'Bob', 'Charlie', 'David', 'Emma', 'Frank', 'Grace', 'Helen', 'Isaac', 'Julia'],
    'Age': [25, 28, 35, 40, 22, 30, 45, 50, 29, 38],
    'Department': ['HR', 'IT', 'IT', 'Finance', 'HR', 'Finance', 'IT', 'Marketing', 'HR', 'Finance'],
    'Salary': [50000, 70000, 85000, 92000, 48000, 78000, 110000, 65000, 52000, 88000],
    'Experience_Years': [2, 4, 10, 15, 1, 8, 20, 12, 3, 11],
    'Performance_Score': [3.2, 4.5, 4.8, 3.7, 2.9, 4.2, 4.9, 3.8, 3.5, 4.1]
}

## Convert to DataFrame
df = pd.DataFrame(data)

## Display first few rows
print(df.head())

## Convert discrete columns to categorical type
df['Department'] = df['Department'].astype('category')

## Create bins for years of experience
df['Experience_Years'] = pd.cut(df['Experience_Years'],
                                bins = [0, 5, 10, 20],
                                labels = ['Junior', 'Mid', 'Senior'])

## Employees with salaries above 80K
df_hsalary = df[df['Salary'] > 80000]
print(df_hsalary)

## Average salary by department
print(df.groupby('Department')['Salary'].mean())

## Department with the highest performance
print(df.groupby('Department')['Performance_Score'].mean().idxmax())

## Data VIZ


### Bar Plot
plt.figure(figsize=(8, 5))
sns.barplot(x = df['Department'],
            y = df['Salary'],
            estimator = np.mean,
            palette = 'coolwarm')
plt.title('Average Salary by Department')
plt.xlabel('Department', fontsize=12)
plt.ylabel('Average Salary', fontsize=12)
plt.xticks(rotation=45)
#plt.show()

### Scatter Plot

plt.figure(figsize=(8,5))
sns.scatterplot(x=df['Experience_Years'], y=df['Salary'], hue=df['Department'], palette="Dark2", s=100)
plt.title('Salary vs Experience', fontsize=14)
plt.xlabel('Years of Experience', fontsize=12)
plt.ylabel('Salary', fontsize=12)
plt.legend(title="Department", bbox_to_anchor=(1, 1))
plt.show()

### Histogram

plt.figure(figsize=(8,5))
plt.hist(df['Salary'], bins=5, color='blue', alpha=0.7, edgecolor='black')
plt.title('Salary Distribution', fontsize=14)
plt.xlabel('Salary', fontsize=12)
plt.ylabel('Frequency', fontsize=12)
plt.show()

### Box Plot

plt.figure(figsize=(8,5))
sns.boxplot(x=df['Department'], y=df['Salary'], palette="pastel")
plt.title('Salary Distribution by Department', fontsize=14)
plt.xlabel('Department', fontsize=12)
plt.ylabel('Salary', fontsize=12)
plt.xticks(rotation=45)
plt.show()
