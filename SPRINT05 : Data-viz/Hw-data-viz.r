library(tidyverse)
library(ggplot2)
## built in data sets : mpg
head(mpg)
str(mpg)

##find the most fuel-efficient car (suv class) that has engine displacement >= 5 liters
suv_class_mpg <- mpg %>% 
  select(manufacturer,class,cty,model,displ) %>%
  group_by(class=='suv') %>% 
  filter(displ >= 5)

ggplot(suv_class_mpg, aes(x = manufacturer,y = cty, col = model))+
  geom_point(size = 5, alpha = 0.9) +
  theme_minimal() +
  
  labs(title = " The most fuel-efficient car (suv class) ",
       x = " manufacturers",
       y = "city mileage (miles per gallon)" )+
  geom_hline(yintercept= 16, linetype="dashed", color = "red")

### The most fuel-efficient suv car = chevrolet corvette & pontiac grand prix.
