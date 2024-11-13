'''
library(gapminder)
library(ggplot2)
library(patchwork)
'''

View(gapminder)
'''
Excerpt of the Gapminder data on life expectancy, GDP per capita, and population by country
The main data frame gapminder has 1704 rows and 6 variables:

country
factor with 142 levels

continent
factor with 5 levels

year
ranges from 1952 to 2007 in increments of 5 years

lifeExp
life expectancy at birth, in years

pop
population

gdpPercap
GDP per capita (US$, inflation-adjusted)
'''

'''
Single Sample T-Test

Hypothesis Testing: 
Null hypothesis: The mean life expectancy in Asia is 55 years (Assumed population mean)
Alternative hypothesis: The mean life expectancy in Africa is NOT 55 years

Obsevation: Sample data provides a mean life expectancy of 48.9. Is this statistically significant?
'''
View(gapminder)
?ggplot
?geom_vline

mean_asia <- mean()

plot1 <- gapminder %>%
  filter(continent=="Asia") %>%
  ggplot(mapping = aes(x=lifeExp,color=continent,fill=continent)) + 
  geom_density(alpha=0.2) + 
  labs(title="Life Expectancy in Asia from 1952 to 2007",x="Life Expectancy",y="Frequency Percentage") + 
  geom_vline(xintercept=60.1,linetype="dashed",color="Red") + 
  geom_label(aes(x = 60.1, y = 0.03, color=continent), 
             label = "Mean: 60.1", fill = "white") + 
  theme_bw() + theme(legend.position = "none")
plot1

#annotate(x=60.1,y=+Inf,label="Mean = 48.9",vjust=2,geom="label")
one_sided_ttest <- gapminder %>%
  filter(continent=="Asia") %>%
  select(lifeExp) %>%
  t.test(mu=55)

one_sided_ttest
attributes(one_sided_ttest)
one_sided_ttest$p.value

'''
One Sample t-test

data:  .
t = 8.4951, df = 395, p-value = 4.077e-16
alternative hypothesis: true mean is not equal to 55
95 percent confidence interval:
 58.89275 61.23705
sample estimates:
mean of x 
  60.0649
  
very low p-value and hence, the null hypothesis (no difference in means) is rejected. 
This difference is statistically significant
'''

'''
Welch two-sample t-test
- used to test equality of population means between two groups
- does not assume two equal sample sizes or equal variances between groups
- assumes independent observations drawn from normally distributed populations
- robust againts violations of normality when sample size is large
- more general than a pooled t-test but slightly more conservative in its result
Pooled t-test
- add "var.equal=TRUE" in the t.test()
- used to test equality of population means between two groups
- does not assume two equal sample sizes but DOES assume equal variances between groups
- assumes independent observations drawn from normally distributed populations
- robust againts violations of normality when sample size is large
- should only be used if there is specific justification for the assumption of equal variances between groups
Paired t-test
- add "paired=TRUE" in the t.test()
- assumes observations are paired, for instance when subjects are observed before and after treatment. in essence, you only have one variable
- used to test whether the average difference between paired observations could be zero
- assumes equal sample sizes
- assumes independent observations drawn from normally distributed populations
- robust againts violations of normality when sample size is large
- simply considers the difference between corresponding obervations using a single sample t-test
'''

mean_values <- gapminder %>%
  filter(continent %in% c("Asia", "Europe")) %>%
  group_by(continent) %>%
  summarise(mean_lifeExp = mean(lifeExp, na.rm = TRUE))
mean_values

plot2 <- gapminder %>%
  filter(continent %in% c("Asia","Europe")) %>%
  ggplot(mapping = aes(x=lifeExp,color=continent,fill=continent)) + 
  geom_density(alpha=0.2) + 
  labs(title="Life Expectancy in Asia and Europe from 1952 to 2007",x="Life Expectancy",y="Frequency Percentage") + 
  geom_vline(data = mean_values, aes(xintercept = mean_lifeExp, color = continent), linetype = "dashed", size = 1) + 
  geom_label(data = mean_values, aes(x = mean_lifeExp, y = 0.075, label = paste("Mean =", round(mean_lifeExp, 1)), color = continent), fill="white",
  vjust = -1) + theme_bw() + theme(legend.position = "none")
plot2
                                                                                                                                                                                                                                                                                                                                            
gapminder %>%
  filter(continent %in% c("Asia","Europe")) %>%
  t.test(lifeExp ~ continent, data = ., alternative = "two.sided")

country_mean <- gapminder %>%
  filter(country %in% c("Malaysia", "Singapore")) %>%
  group_by(country) %>%
  summarise(country_mu_values = mean(lifeExp, na.rm = TRUE))

gapminder %>%
  filter(country %in% c("Malaysia","Singapore")) %>%
  t.test(lifeExp ~ country, data = ., alternative = "less", conf.level = 0.95)

'''
the p-value is greater than 0.05 and hence, the null hypothesis (no difference between means) cannot full be rejected.
This difference is NOT statistically significant
'''

plot3 <- gapminder %>%
  filter(country %in% c("Malaysia","Singapore")) %>%
  ggplot(mapping = aes(x=lifeExp,color=country,fill=country)) + 
  geom_density(alpha=0.2) + 
  labs(title="Life Expectancy in Malaysia and Singapore from 1952 to 2007",x="Life Expectancy",y="Frequency Percentage") + 
  geom_vline(data = country_mean, aes(xintercept = country_mu_values, color = country), linetype = "dashed", size = 1) + 
  geom_label(data = country_mean, aes(x = country_mu_values, y = 0.045, label = paste("Mean =", round(country_mu_values, 1)), color = country), fill="white",
             vjust = -1) + theme_bw() + theme(legend.position = "none")
plot3

asia_mean <- gapminder %>%
  filter(year %in% c(1952, 2007) & continent=="Asia") %>%
  group_by(year) %>%
  summarise(asia_mu_values = mean(lifeExp, na.rm = TRUE))
asia_mean

plot4 <- gapminder %>%
  filter(year %in% c(1952,2007) & continent=="Asia") %>%
  ggplot(mapping = aes(x=lifeExp,color=factor(year),fill=factor(year))) + 
  geom_density(alpha=0.2) + 
  labs(title="Life Expectancy in Asia in 1952 and in 2007",x="Life Expectancy",y="Frequency Percentage") + 
  geom_vline(data = asia_mean, aes(xintercept = asia_mu_values, color = factor(year)), linetype = "dashed", size = 1) + 
  geom_label(data = asia_mean, aes(x = asia_mu_values, y = 0.02, label = paste("Mean =", round(asia_mu_values, 1)), color = factor(year)), fill="white",
             vjust = -1) + theme_bw() + theme(legend.position = "none")
plot4

paired_table <- gapminder %>%
  filter(continent == "Asia" & year %in% c(1952, 2007)) %>%
  select(-pop, -gdpPercap) %>%
  pivot_wider(
    names_from = year,
    values_from = lifeExp,
    names_prefix = "lifeExp_"
  )

t.test(paired_table$lifeExp_1952, paired_table$lifeExp_2007, paired = TRUE)

'''
Paired t-test

data:  paired_table$lifeExp_1952 and paired_table$lifeExp_2007
t = -22.515, df = 32, p-value < 2.2e-16
alternative hypothesis: true mean difference is not equal to 0
95 percent confidence interval:
 -26.62284 -22.20534
sample estimates:
mean difference 
      -24.41409 
'''
install.packages("gridExtra")
grid.arrange(plot1, plot2, plot3, plot4, nrow = 2, ncol = 2)

par(mfrow = c(1, 1))
'''

