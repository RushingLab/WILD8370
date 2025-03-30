---
title: "Lab10: Discrete Survival Models"
output: 
  rmarkdown::html_vignette:
    keep_md: yes
vignette: >
  %\VignetteIndexEntry{Lab10_CJS}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---





In this exercise, we'll look at how our estimates might change when we fit data with imperfect detection to both a known-fate and a CJS model. In this case, we'll be using a CJS model to estimate 'apparent infection rate' rather than survival to demonstrate how these models can be used for more than just live/dead tracking of animals. 

## The Data Set

Today's lab will work with data we saw in class - frog and toad capture recapture information from a published study on chytrid fungus. 
 
Here's the citation:
Russell, R.E., Halstead, B.J., Fisher, R.N., Muths, E.L., Adams, M.J., and Hossack, B.R., 2019, Amphibian capture mark-recapture: U.S. Geological Survey data release, https://doi.org/10.5066/P9LNLEDF.

In lecture we looked at how we might model apparent survival using these data, but completely ignore the infection status of animals. Now, let's see if we can model apparent infection - the joint probability that an animal survives and becomes infected with chytrid. We will assume once an animal gets the disease it is positive for the rest of its life. 

## Known-fate Style 

It is often tempting to ignore detection probability when modeling capture mark recapture data. However, doing so will often give you biased information about the parameter of interest. 

If we were to fit a very simple known fate model to our data, it might look something like this:


``` r
KnownFrogs <- nimbleCode({
for(i in 1:nind){
  eta ~ dbeta(1, 1)
  for(t in (first_live[i]+1):last_live[i]){
    z[i,t] ~ dbern(eta)
  }
}
})
```

In this case eta ($\eta$) is not survival but rather the probability of getting the disease, conditional on surviving. We will not estimate survival directly. If the animal is infected, $z = 0$ and we stop monitoring the animal in our study. 

Let's organize the data to fit this simple model. We'll use the boreal toad (*Anaxyrus boreas*) in Montana for this example. As in lecture, we will only concern ourselves with the yearly level, not the capture-date level. Thus, if an animal ever tested positive during a given year, we will mark it as positive for the entire year. 


``` r
data("WyomingFrogs")
Rpret <- subset(frog_caps, frog_caps$Species == 'A.boreas' & frog_caps$Project == "MT")
Rpret$Bd <- ifelse(Rpret$Bd.presence == 'negative', 1, ifelse(Rpret$Bd.presence == 'positive', 0, NA) )
head(Rpret)
#> # A tibble: 6 × 7
#>   Ind.ID     Survey.Date Project Species  Sex    Bd.presence    Bd
#>   <chr>      <chr>       <chr>   <chr>    <chr>  <chr>       <dbl>
#> 1 4523227821 5/25/04     MT      A.boreas male   <NA>           NA
#> 2 4523246834 5/29/05     MT      A.boreas female negative        1
#> 3 4523251062 5/29/05     MT      A.boreas female negative        1
#> 4 4523273232 5/23/06     MT      A.boreas <NA>   <NA>           NA
#> 5 4523331768 5/18/07     MT      A.boreas male   positive        0
#> 6 4524255931 5/23/06     MT      A.boreas male   <NA>           NA
```




## Homework

1. Using the same idea as above, fit both a known-fate style model and CJS model to the infection status of *Rana muscosa* (Mountain yellow-legged frog) in California. Model infection probability as a fixed effect of year in both models. Graph the infection probability estimates for all years from both model outputs using ggplot. How do the estimates compare?  


2. Using only the capture records for *Rana draytonii*, write a CJS model that models capture probability as a function of both sex and a random effect of year. Make a ggplot showing detection probability across time, with different colors for the different sexes.

3. Fix someone's bad code

4.  On a 1-10 scale, with 1 being the worst week ever and 10 being the best, how would you rate this week's content? What lingering questions/confusion about the lecture or lab do you still have?
