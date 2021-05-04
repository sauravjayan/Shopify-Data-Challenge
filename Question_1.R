library(tidyverse)

# reading in the data
shop <- read_csv("~/2019 Winter Data Science Intern Challenge Data Set - Sheet1.csv")

# a.
# When we take the mean of the order amount column, we can see that it is an unreasonably
# high value. Let us visualize the column to get a better understanding
print(mean(shop$order_amount))

# The histogram shows us that there are few records with order amounts well above $600000
# These records although few, are skewing the average order value
shop %>% ggplot(aes(x=order_amount)) + geom_histogram() + scale_y_log10() 

# When we look at the records with the highest order amounts, we can see that shop 42 and 
# shop 78 is what is causing our problem. The purchases from shop 42 includes orders
# that contained 2000 items causing the large order amount. Whereas the price of a shoe 
# in shop 78 is $25725, causing the large order amount. These outliers need to be dealt 
# with to solve the problem with Average Order Value.
shop <- shop %>% arrange(desc(order_amount)) 
print(shop[1:20,])

# b. The best metric to report for this dataset would be the median. Medians are not 
# affected by outliers and hence is a reliable metric in this case
print(median(shop$order_amount))

# c. 
print(paste0("The Median value of order amount is $",median(shop$order_amount)))


# Additional notes

# Another way to solve this problem would be remove the outliers and then compute
# the average. We will remove those records with order amount greater than $25000
shop_filtered <- shop %>% filter(order_amount < 25000)

# The Average Order Value is now the following
print(mean(shop_filtered$order_amount))

# Histogram of filtered data
shop_filtered %>% ggplot(aes(x=order_amount)) + geom_histogram() + scale_y_log10() 

# The above method is however not reproducible.

# The usual, reproducible way of treating outliers is through z-scores. We will 
# only consider those records that are within 3 standard deviations from the mean
shop <- shop %>% mutate(z_score=(order_amount-mean(order_amount))/sd(order_amount))

shop_z_filtered <- shop %>% filter((z_score < 3)&(z_score > -3))

# The mean now is much better than before but I would argue that median is still
# our best measure in this situation
print(mean(shop_z_filtered$order_amount))
