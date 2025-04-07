---
title: "GLMs for modeling count data"
author: "Clark Rushing"
output: 
  rmarkdown::html_vignette:
    keep_md: yes
vignette: >
  %\VignetteIndexEntry{Lab4_glms}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---





In this activity, we will analyze a small data set containing counts of both population size and reproductive success using Poisson and Binomial GLMs.

------------------------------------------------------------------------

**Objectives**

-   Analyze count data using Poisson and Binomial GLMs

-   Gain experience diagnosing Nimble output to check convergence

-   `R` functions used in this exercise:

    -   `system.file()`

------------------------------------------------------------------------

## Data

The data for this activity comes from a long-term project that monitored a population of peregrine falcons nesting in the [French Jura](https://en.wikipedia.org/wiki/Jura_(department)) from 1964 to 2003 [^1].

[^1]: All data and code used in this lab are from Kéry & Schaub *Bayesian Population Analysis Using WinBugs* and can be accessed [here](https://www.vogelwarte.ch/de/projekte/publikationen/bpa/complete-code-and-data-files-of-the-book). Note that the book uses JAGS, so the syntax will be slightly different.

<img src="https://upload.wikimedia.org/wikipedia/commons/7/7b/Peregrine_falcon_%28Australia%29.JPG" width="75%" style="display: block; margin: auto;" />

Load and inspect the data:


``` r
library(WILD8370)
data("falcons")
head(falcons)
```

<table>
 <thead>
  <tr>
   <th style="text-align:right;"> Year </th>
   <th style="text-align:right;"> Pairs </th>
   <th style="text-align:right;"> R.Pairs </th>
   <th style="text-align:right;"> Eyasses </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1964 </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 27 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1965 </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 30 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1966 </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 36 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1967 </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 37 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1968 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 19 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1969 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 10 </td>
  </tr>
</tbody>
</table>



The falcons dataframe has 4 columns:

-   Year: the year (integer).
-   Pairs: the number of adult pairs (integer).
-   R.pairs: the number of reproductive pairs (integer).
-   Eyasses: the number of fledged young (integer).

## Analysis 1: Change in population size

The first model we will fit examines change in the number of adult falcon pairs over time. Plotting the data shows that this change has not been linear:


``` r
ggplot(falcons, aes(x = Year, y = Pairs)) + geom_point() + stat_smooth(se = FALSE)
```

<img src="Lab4_glms_files/figure-html/unnamed-chunk-5-1.png" width="576" style="display: block; margin: auto;" />

After a short decline at the beginning of the study period, the population then increased dramatically before perhaps reaching its carrying capacity.

### Modeling non-linear effects using linear models

How can we model the non-linear change in abundance if, by definition, linear models model linear effects? Using polynomials!

Remember the equation for a curved line with a single peak (or bottom):

<<<<<<< HEAD
$$y = a + b \times x + c \times x^2$$
=======
$\Large y = a + b \times x + c \times x^2$
>>>>>>> ce5d54b074616c65c7754d9e4f0af1acd8908fa4

<img src="Lab4_glms_files/figure-html/unnamed-chunk-6-1.png" width="576" style="display: block; margin: auto;" />

Where $a$ is the maximum (or minimum) value of $y$, $b$ is the value of $x$ where this maximum (or minimum) occurs and $c$ determines whether the peak is a maximum ($c<0$) or a minimum ($c>0$).

We can add more complex shape by adding additional polynomial terms. For example, including a cubic term creates an s-shaped curve:

<<<<<<< HEAD
$$y = a + b \times x + c \times x^2 + d \times x^3$$
=======
$\Large y = a + b \times x + c \times x^2 + d \times x^3$

For instance:
>>>>>>> ce5d54b074616c65c7754d9e4f0af1acd8908fa4

<img src="Lab4_glms_files/figure-html/unnamed-chunk-7-1.png" width="576" style="display: block; margin: auto;" />

Including polynomial terms in the linear predictor on the model gives us enormous flexibility to model non-linear relationships using GLMs.

### Modeling change in falcon counts

To build a model for the falcon data, we need to define the components required in all GLMs (the distribution, link function, and linear predictor). Because these are counts, a natural choice for the distribution is:

$$C_t \sim Poisson(\lambda_t)$$ where $C_t$ is the observed count in year $t$ and $\lambda_t$ is the expected count.

As we learned in lecture, the conventional link function for count data is the log-link:

$$log(\lambda_t) = log(E(\lambda_t))$$

Finally, we need to write the linear predictor. Based on the preliminary visualization of the data, a cubic polynomial might be appropriate to capture the non-linear change over time:

$$log(\lambda_t) = \alpha + \beta_1 \times year_t + \beta_2 \times year^2_t + \beta_3 \times year^3_t$$

### Accessing and viewing the Nimble model

You can copy and paste the following code into your own R script.


``` r
library(nimble)
falcon_mod <- nimbleCode({
  # Priors
  alpha ~ dnorm(0, 0.33)
  beta1 ~ dnorm(0, 0.33)
  beta2 ~ dnorm(0, 0.33)
  beta3 ~ dnorm(0, 0.33)

  # Likelihood
  for (i in 1:n){
    C[i] ~ dpois(lambda[i])
    log(lambda[i]) <- alpha + beta1 * year[i] + beta2 * pow(year[i],2) + beta3 * pow(year[i],3)
  } #end i
})

```

From this file, you can see that we will use relatively non-informative normal priors on each of the regression coefficients.

You can also see that the likelihood statement is very similar to the linear regression model from the last lecture, with a few minor differences. First, because we assume the observed falcon counts come from a Poisson distribution, we use `dpois(lambda[i])` rather than `dnorm(mu[i], tau)`. Also, we have to apply the log-link function to the predicted counts (`log(lambda[i])=...`). Notice that Nimble allows you to model the transformed predicted counts on the left hand side of the linear predictor equation

------------------------------------------------------------------------

**In Lab Questions**

1)  Plot a histogram of random samples from the normal prior used in the model (remember to convert the precision of `0.33` to standard deviation). As you can see, this is not as vague as the normal priors we have used in the past. What is the advantage of using less-vague normal priors?

2)  In the linear regression model we fit in the last lecture, we also had a prior for $\tau$, the (inverse) of the process variance. Why do we not include that parameter in this model?

3)  Creating the `lambda[i]` object is not strictly necessary since it is a deterministic function of year. If you wanted to have fewer lines of code, you could include the linear predictor directly inside of the `dpois()` function instead of `lambda[i]`, though you would need to appropriately transform the linear predictor. What transformation would you use to put the linear predictor on the count scale?

------------------------------------------------------------------------

### Fitting the model

Before fitting the model, we need to prepare the input for Nimble This includes:

-   storing the data as a named list

-   storing constants as a named list

-   creating a function to randomly generate the initial values for each parameter

-   creating a vector with the parameters we want Nimble to monitor

-   set the MCMC settings

We've mentioned several times, it's often a bad idea to include covariate values that are too far from 0. For this reason, we will first scale `year` to $mean=0$ and $sd=1$:


``` r
year <- (falcons$Year - mean(falcons$Year))/sd(falcons$Year)

nimdat <- list(C = falcons$Pairs)

nimconsts <- list(year = year, n = nrow(falcons))

niminits <- function(){list(alpha = rnorm(1), beta1 = rnorm(1), beta2 = rnorm(1), beta3 = rnorm(1))}

params <- c("alpha", "beta1", "beta2", "beta3", "lambda")

nC <- 3 #chains

nI <- 10000 #iterations

nB <- 2500 #burnin

nT <- 1 #thin
```

Now we're ready to run the model. The easiest way to run a Nimble model is to run it in one command:


``` r
falcon_res <- nimbleMCMC(code = falcon_mod,
                     data = nimdat,
                     constants = nimconsts,
                     inits = niminits(),
                     monitors = params,
                     thin = nT,
                     niter = nI,
                     nburnin = nB,
                     nchains = nC,
                     samplesAsCodaMCMC = TRUE
                      )
```



However, sometimes (when you get more advanced), you'll want to be able to customize your Nimble runs a little bit more. It's also much easier to error check your initial values on models that take a very long time to run if you run it step by step. Here's what that would look like with one chain:


``` r
prepnim <- nimbleModel(code = falcon_mod, constants = nimconsts,
                           data = nimdat, inits = niminits(), calculate = T)
prepnim$initializeInfo() #will tell you what is or isn't intialized
prepnim$calculate() #if this is NA or -Inf you know it's gone wrong
mcmcnim <- configureMCMC(prepnim, monitors = params, print = T)
nimMCMC <- buildMCMC(mcmcnim) #actually build the code for those samplers
Cmodel <- compileNimble(prepnim) #compiling the model itself in C++;
Compnim <- compileNimble(nimMCMC, project = prepnim) # compile the samplers next
Compnim$run(niter = nI, nburnin = nB, thin = nT)
falcon_res <- (as.mcmc(as.matrix(Compnim$mvSamples)))
```

View a portion of the results (printing all of the `lambda` values takes up too much room):


``` r
summary(falcon_res[,c('alpha', 'beta1', 'beta2', 'beta3', 'lambda[1]', 'lambda[2]', 'lambda[3]')])$quantiles
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> 2.5% </th>
   <th style="text-align:right;"> 25% </th>
   <th style="text-align:right;"> 50% </th>
   <th style="text-align:right;"> 75% </th>
   <th style="text-align:right;"> 97.5% </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> alpha </td>
   <td style="text-align:right;"> 4.1739 </td>
   <td style="text-align:right;"> 4.2118 </td>
   <td style="text-align:right;"> 4.2306 </td>
   <td style="text-align:right;"> 4.2501 </td>
   <td style="text-align:right;"> 4.2884 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> beta1 </td>
   <td style="text-align:right;"> 1.0238 </td>
   <td style="text-align:right;"> 1.0844 </td>
   <td style="text-align:right;"> 1.1159 </td>
   <td style="text-align:right;"> 1.1452 </td>
   <td style="text-align:right;"> 1.2022 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> beta2 </td>
   <td style="text-align:right;"> -0.0393 </td>
   <td style="text-align:right;"> -0.0082 </td>
   <td style="text-align:right;"> 0.0075 </td>
   <td style="text-align:right;"> 0.0229 </td>
   <td style="text-align:right;"> 0.0527 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> beta3 </td>
   <td style="text-align:right;"> -0.2785 </td>
   <td style="text-align:right;"> -0.2490 </td>
   <td style="text-align:right;"> -0.2335 </td>
   <td style="text-align:right;"> -0.2171 </td>
   <td style="text-align:right;"> -0.1853 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lambda[1] </td>
   <td style="text-align:right;"> 26.6889 </td>
   <td style="text-align:right;"> 30.2211 </td>
   <td style="text-align:right;"> 32.3052 </td>
   <td style="text-align:right;"> 34.4064 </td>
   <td style="text-align:right;"> 38.6127 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lambda[2] </td>
   <td style="text-align:right;"> 25.6956 </td>
   <td style="text-align:right;"> 28.5859 </td>
   <td style="text-align:right;"> 30.2625 </td>
   <td style="text-align:right;"> 31.9602 </td>
   <td style="text-align:right;"> 35.2361 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lambda[3] </td>
   <td style="text-align:right;"> 25.0503 </td>
   <td style="text-align:right;"> 27.4629 </td>
   <td style="text-align:right;"> 28.8161 </td>
   <td style="text-align:right;"> 30.2126 </td>
   <td style="text-align:right;"> 32.8666 </td>
  </tr>
</tbody>
</table>



Note that beta2 appears to cross 0 - there's not much of an effect of year\^2 on lambda.

This seems reasonable, but let's make sure the `Rhat` values are less than 1.1. To do this, we'll use the `gelman.diag()` function from the `coda` package.


``` r
library(coda)
gelman.diag(falcon_res, multivariate = F)$psrf[1:10,] #don't want to print out all 40 lambdas
#>           Point est. Upper C.I.
#> alpha          1.002      1.008
#> beta1          1.004      1.011
#> beta2          1.004      1.012
#> beta3          1.004      1.009
#> lambda[1]      1.003      1.007
#> lambda[2]      1.003      1.006
#> lambda[3]      1.003      1.006
#> lambda[4]      1.002      1.006
#> lambda[5]      1.002      1.006
#> lambda[6]      1.002      1.007
```

All parameters appear to have converged.

As usual, let's check the trace plots to see how they look:


``` r
# View traceplots for alpha, beta1, beta2, and beta3 (not for lambda)
MCMCvis::MCMCtrace(falcon_res[,params[-5],], Rhat = T, pdf = F)
```

<img src="Lab4_glms_files/figure-html/unnamed-chunk-16-1.png" width="576" style="display: block; margin: auto;" /><img src="Lab4_glms_files/figure-html/unnamed-chunk-16-2.png" width="576" style="display: block; margin: auto;" />

By monitoring `lambda` we can also plot the predicted counts along with the observed counts. First, we need to calculate the posterior means and upper/lower bounds of the 95% credible interval and add them to the falcons data frame, then use ggplot to visualize:


``` r
#get the quantiles for just the lambda parameters:
lambdas <- summary(falcon_res[,paste0('lambda[', 1:40, ']')])$quantiles 

falcons <- dplyr::mutate(falcons, lambda = lambdas[,3], 
                                  q2.5 = lambdas[,1], 
                                  q97.5 = lambdas[,5])

ggplot(falcons) + 
  geom_ribbon(aes(x = Year, ymin = q2.5, ymax = q97.5), fill = "grey90") +
  geom_path(aes(x = Year, y = lambda), color = "red") +
  geom_point(aes(x = Year, y = Pairs)) +
  scale_y_continuous("Pairs")+
  theme_bw()
```

<img src="Lab4_glms_files/figure-html/unnamed-chunk-17-1.png" width="576" style="display: block; margin: auto;" />

## Analysis 2: Nest success model

Next, let's use the `falcons` data set to fit another type of GLM - the binomial GLM. Hopefully this exercise will show you that once you're comfortable writing out and coding the GLM components (distribution, link function, and linear predictor), it is extremely easy to fit models with different distributional assumptions.

To estimate reproductive success (i.e., the probability that a pair successfully produces offspring), we will model the number of reproductive pairs (`falcons$R.Pairs`) as a function of the total number of pairs (`falcons$Pairs`).

Because the total number of reproductive pairs cannot exceed the total number of pairs, the counts in `falcons$.RPairs` are bounded to be less than `falcons$Pairs`. In this case, the Poisson distribution is not an appropriate count model. Instead, we will use the binomial distribution:

$$C_t \sim binomial(N_t, p_t)$$

Our goal is to model $p_t$, the probability of nesting successfully in each year. In this case, the log link is not appropriate - $p_t$ is bound between 0 and 1. For probabilities, the logit link is generally the appropriate link function:

$$logit(p_t) = log\bigg(\frac{p_t}{1-p_t}\bigg)$$

Following Kéry & Schaub, we'll model probability as a quadratic function of year:

$$logit(p_t) = \alpha + \beta_1 \times year_t + \beta_2 \times year^2_t$$

As in the last example, you can copy the code here. Note that in Nimble the order for the arguments of a binomial are probability and then size, unlike what we would type in R:


``` r
pairs_mod <- nimbleCode({
  # Priors
  alpha ~ dnorm(0, 0.33)
  beta1 ~ dnorm(0, 0.33)
  beta2 ~ dnorm(0, 0.33)

  # Likelihood
  for (t in 1:nyears){
    C[t] ~ dbinom(p[t], N[t])
    logit(p[t]) <- alpha + beta1 * year[t] + beta2 * pow(year[t],2)
  } #end i
})

```

As before, we prepare the data and run the model:


``` r
#using standardized year from above
nimdat2 <- list(C = falcons$R.Pairs)
nimconsts2 <- list(N = falcons$Pairs, year = year, nyears = nrow(falcons))
niminits2 <- function(){list(alpha = rnorm(1), beta1 = rnorm(1), beta2 = rnorm(1))}

params2 <- c("alpha", "beta1", "beta2", "p")

nC <- 3

nI <- 10000

nB <- 2500

nT <- 1

pairs_res <- nimbleMCMC(code = pairs_mod,
                     data = nimdat2,
                     constants = nimconsts2,
                     inits = niminits2(),
                     monitors = params2,
                     thin = nT,
                     niter = nI,
                     nburnin = nB,
                     nchains = nC,
                     samplesAsCodaMCMC = TRUE
                      )
```




``` r
summary(pairs_res[,c('alpha', 'beta1', 'beta2', 'p[1]', 'p[2]', 'p[3]')])$quantiles
```

<table>
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> 2.5% </th>
   <th style="text-align:right;"> 25% </th>
   <th style="text-align:right;"> 50% </th>
   <th style="text-align:right;"> 75% </th>
   <th style="text-align:right;"> 97.5% </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> alpha </td>
   <td style="text-align:right;"> 0.6699 </td>
   <td style="text-align:right;"> 0.7432 </td>
   <td style="text-align:right;"> 0.7818 </td>
   <td style="text-align:right;"> 0.8188 </td>
   <td style="text-align:right;"> 0.8914 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> beta1 </td>
   <td style="text-align:right;"> -0.0298 </td>
   <td style="text-align:right;"> 0.0279 </td>
   <td style="text-align:right;"> 0.0585 </td>
   <td style="text-align:right;"> 0.0893 </td>
   <td style="text-align:right;"> 0.1469 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> beta2 </td>
   <td style="text-align:right;"> -0.3833 </td>
   <td style="text-align:right;"> -0.3305 </td>
   <td style="text-align:right;"> -0.3026 </td>
   <td style="text-align:right;"> -0.2747 </td>
   <td style="text-align:right;"> -0.2220 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> p[1] </td>
   <td style="text-align:right;"> 0.3893 </td>
   <td style="text-align:right;"> 0.4352 </td>
   <td style="text-align:right;"> 0.4602 </td>
   <td style="text-align:right;"> 0.4854 </td>
   <td style="text-align:right;"> 0.5324 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> p[2] </td>
   <td style="text-align:right;"> 0.4163 </td>
   <td style="text-align:right;"> 0.4591 </td>
   <td style="text-align:right;"> 0.4825 </td>
   <td style="text-align:right;"> 0.5058 </td>
   <td style="text-align:right;"> 0.5489 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> p[3] </td>
   <td style="text-align:right;"> 0.4422 </td>
   <td style="text-align:right;"> 0.4821 </td>
   <td style="text-align:right;"> 0.5037 </td>
   <td style="text-align:right;"> 0.5252 </td>
   <td style="text-align:right;"> 0.5649 </td>
  </tr>
</tbody>
</table>




``` r
# View traceplots for alpha, beta1, and beta2(not for p)
MCMCvis::MCMCtrace(pairs_res[,params2[-4],], pdf = F, Rhat = T)
```

<img src="Lab4_glms_files/figure-html/unnamed-chunk-22-1.png" width="576" style="display: block; margin: auto;" />


``` r

ps <- summary(pairs_res[,paste0('p[', 1:40, ']')])$quantiles 
falcons <- dplyr::mutate(falcons, p = ps[,3], 
                                  q2.5_p = ps[,1], 
                                  q97.5_p = ps[,5])

ggplot(falcons) + 
  geom_ribbon(aes(x = Year, ymin = q2.5_p, ymax = q97.5_p), fill = "grey90") +
  geom_path(aes(x = Year, y = p), color = "red") +
  geom_point(aes(x = Year, y = R.Pairs/Pairs)) +
  scale_y_continuous("Pairs")+
  theme_classic()
```

<img src="Lab4_glms_files/figure-html/unnamed-chunk-23-1.png" width="576" style="display: block; margin: auto;" />

# Homework Questions

Using what you've learned in this lab, write out a model for the expected number of nestlings (Eyasses) per reproducing pair (R.pairs) in each year.

a.  Begin by writing out the mathematical formulation of your model
b.  Write out the Nimble code.
c.  Provide your model with data, constants and initial values
d.  Check your output for convergence
e.  Display a ggplot showing the expected number of nestlings per reproducing pair in each year (with 95% credible interval) vs the raw data. Don't forget a title and axis labels.

It may help to plot the data first to see what type of data you are working with:


``` r
ggplot(falcons, aes(x = Year, y = Eyasses/R.Pairs))+
  geom_line(lwd = 1, lty = 2)+
  geom_point()+
  geom_smooth()+
  theme_bw()
```

<img src="Lab4_glms_files/figure-html/unnamed-chunk-24-1.png" width="576" style="display: block; margin: auto;" />

2.  In our second analysis in lab, we used a binomial GLM to describe the proportion of successful peregrine pairs per year in the French Jura mountains. To see the connections between three important types of GLMs, first use a Poisson GLM to model the number of successful pairs (thus disregarding the fact that the binomial total varies by year), and second, use a normal GLM to do the same. In the same graph, compare the predicted numbers of successful pairs for every year under all three models (binomial, Poisson, and normal GLMs). [This assignment stolen directly from the WinBUGS book, so blame Marc Kéry and Michael Schaub for this one.]

Note: If you find that your normal distribution model predicts extremely low counts, be sure to look at your priors. If selected correctly, you should see all 3 models roughly overlap the raw data.

3. On a 1-10 scale, with 1 being the worst week ever and 10 being the best, how would you rate this week's content? What lingering questions/confusion about the lecture or lab do you still have? 


3.  On a 1-10 scale, with 1 being the worst week ever and 10 being the best, how would you rate this week's content? What lingering questions/confusion about the lecture or lab do you still have?
