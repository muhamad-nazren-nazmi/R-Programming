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

1. Single Sample T-Test

Hypothesis Testing: 
Null hypothesis: The mean life expectancy in Asia is 55 years (Assumed population mean)
Alternative hypothesis: The mean life expectancy in Africa is NOT 55 years

Observation: Sample data provides a mean life expectancy of 60.1. Is this statistically significant?

One Sample t-test

data:  .
t = 8.4951, df = 395, p-value = 4.077e-16
alternative hypothesis: true mean is not equal to 55
95 percent confidence interval:
 58.89275 61.23705
sample estimates:
mean of x 
  60.0649
  
The p-value is smaller than 5% and hence, the null hypothesis (no difference between two means) is rejected. 
This difference is statistically significant

2. Welch Two Sample t-test

Hypothesis Testing: 
Null hypothesis: The mean life expectancy in Asia and Europe are equal
Alternative hypothesis: The mean life expectancy in Asia and Europe are NOT equal

data:  lifeExp by continent
t = -17.899, df = 565.16, p-value < 2.2e-16
alternative hypothesis: true difference in means between group Asia and group Europe is not equal to 0
95 percent confidence interval:
 -13.13792 -10.53965
sample estimates:
  mean in group Asia mean in group Europe 
            60.06490             71.90369 

The p-value is smaller than 5% and hence, the null hypothesis (no difference between two means) is rejected. 
This difference is statistically significant.

3. Welch Two Sample t-test

Hypothesis Testing: 
Null hypothesis: The mean life expectancy in Malaysia and Singapore are equal
Alternative hypothesis: The mean life expectancy in Malaysia is lesser than in Singapore

data:  lifeExp by country
t = -2.2686, df = 19.964, p-value = 0.01727
alternative hypothesis: true difference in means between group Malaysia and group Singapore is less than 0
95 percent confidence interval:
      -Inf -1.663608
sample estimates:
 mean in group Malaysia mean in group Singapore 
               64.27958                71.22025 

The p-value is small but not smaller than 5% and hence, the null hypothesis (no difference between two means) cannot be rejected. 
Conclusion cannot be drawn and further study is necessary.

4. Paired t-test

Hypothesis Testing: 
Null hypothesis: The mean life expectancy in Asian year 1952 and year 2007 are equal
Alternative hypothesis: The mean life expectancy in Asian year 1952 and year 2007 are NOT equal

data:  paired_table$lifeExp_1952 and paired_table$lifeExp_2007
t = -22.515, df = 32, p-value < 2.2e-16
alternative hypothesis: true mean difference is not equal to 0
95 percent confidence interval:
 -26.62284 -22.20534
sample estimates:
mean difference 
      -24.41409 

The p-value is smaller than 5% and hence, the null hypothesis (no difference between two means) is rejected. 
This difference is statistically significant.
  
