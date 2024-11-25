#JAYAPRAKASH KUMAR- Customer Personality Analysis-  Independent personal project
cat("\014") # clears console
rm(list = ls()) # clears global environment
try(dev.off(dev.list()["RStudioGD"]), silent = TRUE) # clears plots
try(p_unload(p_loaded(), character.only = TRUE), silent = TRUE) # clears packages
options(scipen = 100) # disables scientific notion for entire R session

library(pacman)
p_load(tidyverse)

#Loading the data set as "customers"
customers <- read.csv("marketing_campaigns.csv")
names(customers) 
count(customers)

#Cleaning column names
p_load(janitor)
customers <-clean_names(customers)

#Removing unnecessary columns
customers <- customers %>% select(-dt_customer, -mnt_fruits, -mnt_sweet_products, -num_deals_purchases, -num_catalog_purchases, -num_web_visits_month, -accepted_cmp3, -accepted_cmp4, -accepted_cmp5, -accepted_cmp1, -accepted_cmp2, -complain, -z_cost_contact, -z_revenue, -response)

#Renaming columns 
library(dplyr)
customers <- customers %>% rename(total_wines_cost = mnt_wines, total_gold_cost = mnt_gold_prods) 
names(customers)

#Managing NAs - removing NA values
customers <- na.omit(customers)

#Creating new column
class(customers$year_birth) #Integer
customers <- customers %>% mutate(age = as.integer(format(Sys.Date(), "%Y")) - year_birth)

#Merging two columns into one and removing those two columns
customers <- customers %>% mutate(total_children = kidhome + teenhome) %>% select(-kidhome, -teenhome)
customers <- customers %>% mutate(total_meat_cost = mnt_meat_products + mnt_fish_products) %>%  select(-mnt_meat_products, -mnt_fish_products)

#Reorganizing data 
customers <- customers %>% select(id, year_birth, age, education, marital_status, total_children, income, recency, total_wines_cost, total_meat_cost, total_gold_cost, num_web_purchases, num_store_purchases)
names(customers)

#Getting a summary of the statistics for customers data frame
summary(customers)
glimpse(customers)

customers <- filter(customers, income <=120000)

#Plotting a histogram to find the distribution of Income
ggplot(customers, aes(x = income))+
  labs(title = "Income Distribution", x = "Income", y = "Frequency")+
  geom_histogram(binwidth = 10000,
                 fill = "green",
                 color = "blue")

#Plotting a box plot to find the distribution for Gold purchase
library(ggthemes)
ggplot(customers, aes(x = total_gold_cost))+
  labs(title = "Gold Purchase Distribution", x = "Gold Purchased Worth", y = "Frequency")+
  geom_boxplot(fill = "magenta")+
  theme_economist()

#Finding the marital statuses available in the data set
marital_status = unique(customers$marital_status)
marital_status

#Putting the irrelevant marital categories into place than deleting it as that data is important for the analysis
customers <- customers %>%
  mutate(marital_status = recode(marital_status, "YOLO" = "Single", "Alone" = "Single", "Absurd" = "Together"))

#Web purchase descriptive statistics
web_purchase_stats <- customers %>%
  summarize(
    mean_web_purchases = mean(num_web_purchases),
    median_web_purchases = median(num_web_purchases),
    min_web_purchases = min(num_web_purchases),
    max_web_purchases = max(num_web_purchases)
  )
#Query 1
#Correlation between Income and Web purchases -  Positive trend found - Increase the UI and the promo campaigning on web
ggplot(customers, aes(x = income, y = num_web_purchases)) +
  geom_point() +
  geom_smooth(method = "lm", color = "blue") +
  labs(title = "Number of Web Purchases vs. Income", x = "Income", y = "Number of Web Purchases")

#Query 2
#Correlation between Education and Web purchases - Graduation - most purchases, - moderate, - least
ggplot(customers, aes(x = education, y = num_web_purchases)) +
  geom_bar(stat = "identity", aes(fill = education)) +
  labs(title = "Number of Web Purchases vs. Education", x = "Education", y = "Number of Web Purchases")

#Query 3
income_stats <- customers %>%
  summarize(
    Mean_Income = mean(income),
    Median_Income = median(income),
    Std_Dev_Income = sd(income)
  )
#Custom column for total_spending
customers <- customers %>% mutate(total_spending = total_wines_cost + total_meat_cost + total_gold_cost)

#A scatter plot was created to explore the relationship between education and income.
#The color of each data point indicates the spending level
ggplot(customers, aes(x = education, y = income, color = total_spending)) +
  geom_point() +
  labs(title = "Relationship Between Education, Income, and Spending", x = "Education", y = "Income") +
  scale_color_gradient(low = "blue", high = "red")

#Eliminating abnormalities in the data. 
customers <-  customers %>% filter(age <= 100)

#Query 4
#Aggregating data to calculate total gold cost per marital group and age
agg_data <- customers %>%
  group_by(marital_status, age) %>%
  summarise(Total_Gold_Cost = sum(total_gold_cost))

#Plotting a bubble chart between Marital status and Age groups and Gold purchase 
#Result - steady purchase seen in Together, Single, Married from ages 25 years - 80 years
ggplot(customers, aes(x = age, y = marital_status, size = total_gold_cost, color = marital_status)) +
  geom_point() +
  labs(title = "Bubble Chart of Total Gold Cost by Marital Group and Age", x = "Age", y = "Marital Group") +
  scale_size_continuous(name = "Gold purchase", range = c(5, 15)) +
  scale_color_manual(name = "Marital Status", values = c("Married" = "blue", "Single" = "green", "Divorced" = "yellow", "Together"= "red", "Widow" = "violet" )) +
  theme_minimal()
