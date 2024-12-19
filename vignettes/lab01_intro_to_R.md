---
title: "Lab 0: Introduction to R"
subtitle: "WILD8370: Bayesian Models for Conservation Science"
author: "Spring 2025"
output: 
  rmarkdown::html_vignette:
    keep_md: yes
vignette: >
  %\VignetteIndexEntry{lab00_Intro_to_R}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---



This should all be review, but here's some refresher information to keep in the back of your mind.

# What is `R`?

`R` is a free, open-source programming language and software environment for statistical computing, bioinformatics, visualization and general computing.  

It is based on an ever-expanding set of analytical packages that perform specific analytical, plotting, and other programming tasks. 

# Why `R`?

`R` is free(!), runs on pretty much every operating system, and has a huge user base.  

`R` is far from the only programming language for working with data, but it is the most widely used language in the fields of ecology, evolution, and wildlife sciences. If you plan to pursue a career in any of these fields, proficiency in `R`is quickly becoming a prerequisite for many jobs.  

Even if you don't pursue a career in one of these fields, the ability to manipulate, analyze, and visualize data (otherwise known as *data science*) is an extremely marketable skill in many professions right now.  

# Additional resources and where to get help

We will go over the basics of using `R` during lab sessions but there are many good online resources for learning `R` and getting help. A few of my favorites (from which some of this material is developed) include: 

- Tom Edward's online [Learning R](http://learnr.usu.edu/) course

- John Fieberg's online [Statistics for Ecologists](https://fw8051statistics4ecologists.netlify.app/) book

- [Data Analysis and Visualization in R for Ecologists](https://datacarpentry.org/R-ecology-lesson/)

Of course, if you encounter error messages you don't understand or need help figuring out how to accomplish something in `R`, google is your best friend (even the most experienced `R` users use google on a daily basis). The key to finding answers on google is asking the right questions. Because we will not spend much time on this topic in lab, please refer to these links for advice on formulating `R`-related questions:

- [How to ask for R help](https://blog.revolutionanalytics.com/2014/01/how-to-ask-for-r-help.html)

- [Seeking help](https://datacarpentry.org/R-ecology-lesson/00-before-we-start.html#seeking_help) from *Data Analysis and Visualization in R for Ecologists* 

# Using `R`- the very basics 

## The RStudio interface and panes

Although users can work directly in `R`, most choose to use RStudio which is the IDE (Integrated Development Environment) for `R`. To use RStudio, you must first have `R` installed.

After opening RStudio, you will see 3 panes^[The location of these panes on the screen can be adjusted by clicking `View` --> `Panes` --> `Pane Layout`].

  1. Console: The console will appear on the left side of your screen. You can type code directly into the console (also known as the command line) and it will be executed immediately. The console is also where output will be shown from tasks that you have executed in `R`. 
  
  2. Environment pane: The environment pane will appear in the top right of your screen. Here, you can see objects that you have created in `R` as well as the values of those objects and how `R` interprets them (more on this later). The environment pane also includes a few other tabs but we will not require their use in this class.
  
  3. Plot pane: The plot pane will appear in the bottom right of your screen. As you might imagine, this is where graphics will be displayed that you have created in `R`. This pane also includes several other useful tabs including the Files tab (which allows you to navigate and manage files), the Packages tab (where you can install and manage additional `R` packages), and the Help tab where you can search `R` documentation pages.

## Using `R` as a calculator

As a statistical programming tool, one thing R is very good at is doing math. So as a starting point, let's treat `R` like a fancy calculator.  

We interact with this calculator by typing numbers and operators (+, -, *, /) into the `Console` window.  

Let's try it - in the bottom left window (the Console), write the `R`code required to add two plus two and then press enter:


``` r
2+2
```

When you run the code, you should see the answer printed below the window. Play with your code a bit - try changing the number and the operators and then run the code again.  

## Creating objects

We can run `R` like a calculator by typing equations directly into the console and then printing the answer. But usually we don't want to just do a calculation and see the answer. Instead, we assign *values* to *objects*. That object is then saved in `R`'s memory which allows us to use that object later in our analysis. 

This might seem a bit confusing if you are new to programming so let's try it. The following code creates an *object* called `x` and *assigns* it a value of `3`: 


``` r
x <- 3
```

The operator `<-`^[In most scenarios, the use of the `<-` operator and `=` will produce equivalent results. However, there are some instances where `=` has a different meaning in `R` and this difference will not always be obvious to the user. To avoid issues with this, it is best to use the `<-` operator when assigning values to objects.] ^[Because `R` is an object based language, the assignment arrow is one of the most common operators that you will type. Although you can choose to literally type the less than sign and dash to create the assignment operator, some people find it more convenient to set up a keyboard shortcut. To do this, click `Tools` --> `Modify keyboard shortcuts` and search in the `Filter` box for the assignment operator. Keyboard shortcuts can be used for a variety of tasks in `R`.] is how we do assignments in `R`. Whatever is to the left of `<-` is the object's name and whatever is to the right is the value. As we will see later, objects can be much more complex than simply a number but for now, we'll keep it simple. 


You try it - change the code to create an object called `new.x`. Instead of assigning `new.x` a number, give it a calculation, for example `25/5`. What do you think the value of `new.x` is?


## Naming objects

It's a good idea to give objects names that tell you something about what the object represents. Names can be as long as you want them to be but should not have spaces (also remember long names require more typing so brevity is a good rule of thumb). Names can contain both numbers and letters but cannot begin with a number. `R` is also case-sensitive so, for example, `Apple` is **not** the same as `apple`. When creating object names, it is also a good idea to avoid words which show up in `R` as functions. While `R` is generally smart enough to distinguish between you attempting to create an object vs use a function, avoiding this practice will save you headache when interpreting your code (especially code that you have not looked at in a while).

## Working with objects

In the exercise above, you may have noticed that after running the code, `R` did not print anything. That is because we simply told `R` to create the object (in the top right window, if you click on the `Environment` tab, you should see `x` and `new.x`). Now that it is stored in `R`'s memory, we can do a lot of things with it. For one, we can print it to see the value. To do that, we simply type the name of the object and run the code^[This method works well to see object values but it requires an additional line of code. Another method available that allows you to see the value of an object directly after creating it is to surround the assignment with parentheses. For example, the line of code `(x <- 3)` will not only create the object `x` and assign it a value of 3, but it will also display the value without having to retype the object name.]:


``` r
new.x <- 25/5
new.x
#> [1] 5
```

We can also use objects to create new objects. *What do you think the following code does?*


``` r
x <- 3
y <- x*4
```

After running it, print the new object `y` to see its value. Were you right?

 ***

# R scripts

The console is useful for doing simple tasks but as our analyses become more complicated, the console is not very efficient. What if you need to go back and change a line of code? What if you want to show your code to someone else to get help?

Instead of using the console, most of our work will be done using scripts (the source editor pane). Scripts are special files that allow us to write, save, and run many lines of code. Scripts can be saved so you can work on them later or send them to collaborators.  

To create a script, click `File -> New File -> R Script`. This new file should show up in a new window. 

## Commenting your code

`R` will ignore any code that follows a `#`. This is *very* useful for making your code more readable for both yourself and others. Use comments to remind yourself what a newly created object is, to explain what a line of code does, to leave yourself a reminder for later, etc. For example, in the previous code, it might be a good idea to use comments to define what each object represents:


``` r
n1 <- 44     # Number of individuals captured on first occasion

n2 <- 32     # Number of individuals captured on second occasion
  
m2 <- 15     # Number of previously marked individuals captured on second occasion
```

Notice that when you run this code, `R` ignores the comments. 

## The working directory

Now that you have created a new `R` script, you need to be able to save this file somewhere on your computer. To do this, we can set up a working directory. In addition to providing a place to save your script, setting up the working directory also tells `R` where you would like to put files that come from your data management and analyses (e.g. spreadsheets or graphics) as well as where to find source data that you plan to use for this particular project.

There are two methods that exist to set up a working directory within `R`.

  1. You can choose to set up a working directory by clicking `Session` --> `Set working directory` --> `Choose directory` and navigating to the folder where you would like to store the files. If you have opened an `R` script and are unsure where the current working directory is located, you can run `getwd()` to see the current working directory.
  
  2. You can set the working directory directly in the `R` script using the `setwd()` function. For example, to set my working directory in a folder called `Lab_1` on my desktop, I would run the following line of code: `C:/Users/mab46065/Desktop/Lab_1`. Notice that although your computer will probably create the folder pathway using the backslash (`\`), `R` will require forward slashes (`/`) instead. Also, if you are using a Mac, you will omit `c:` from the directory name.

***

# R data object types

Up to this point, we have only briefly talked about creating objects in `R`. Here, we will discuss different object types in `R`. It is important to know what types of objects (e.g. vectors, lists, matrices, factors, data frames, arrays) you are working with because `R` will interpret them differently and different object types will be required to perform certain tasks. We will learn about each of those data structures as we encounter them in lab exercises. 

## Vectors

### Integer class

So far, we have only been working with objects that store a single number. However, often it is more convenient to store a string of numbers as a single object. In `R`, these strings are called *vectors* and they are usually created by enclosing the string between `c(` and `)`:


``` r
x <- c(3,5,2,5)
x
#> [1] 3 5 2 5
```

You can also create sequences of consecutive numbers in a few different ways:


``` r
x <- 1:10
x
#>  [1]  1  2  3  4  5  6  7  8  9 10

x2 <- seq(from = 1, to = 10, by = 1)
x2
#>  [1]  1  2  3  4  5  6  7  8  9 10
```


The `seq()` function is very flexible and useful so if you are not familiar with it, be sure to look at the help page to better understand how to use it.

Another useful function for creating vectors is `rep()`, which repeats values of a vector:


``` r
rep(x2, times = 2)
#>  [1]  1  2  3  4  5  6  7  8  9 10  1  2  3  4  5  6  7  8  9 10
```

or:


``` r
rep(x2, each = 2)
#>  [1]  1  1  2  2  3  3  4  4  5  5  6  6  7  7  8  8  9  9 10 10
```

Be sure you notice the difference between using the `times` argument vs the `each` argument!

The function `class()` indicates the class (the type of element) of an object:


``` r
class(x)
#> [1] "integer"
```


### Character class

A vector can also contain characters (though you cannot mix numbers and characters in the same vector!):


``` r
occasions <- c("Occasion1", "Occasion2", "Occasion3")
occasions
#> [1] "Occasion1" "Occasion2" "Occasion3"
```


``` r
class(occasions)
#> [1] "character"
```

The quotes around “Occasion1”, “Occasion2”, and "Occasion3" are critical. Without the quotes, `R` will assume there are objects called `Occasion1`, `Occasion2` and `Occasion3`. As these objects don’t exist in `R`’s memory, there will be an error message.  

Vectors can be any length (including 1. In fact, the numeric objects we've been working with are just vectors with length 1). The function `length()` tells you how long a vector is:


``` r
length(x)
#> [1] 10
```



What is the class of a vector with both numeric and characters entries? Hint:


``` r
mixed <- c(1, 2, "3", "4")
```

You can also use the `c()` function to add other elements to your vector:


``` r
y <- c(x, 4,8,3)
```

### Factor class

Another class of vectors are referred to as factors. Factors are similar to character vectors in that `R` is interpreting them as text strings and you cannot perform math on them. The difference, however, is that `R` sees factors as grouping variables. Each category within the factor is referred to as a 'level'^[Note the use of `as.factor()` to convert what looks like an integer vector into a factor. Functions such as `as.factor()`, `as.character()`, and `as.numeric()` are useful to coerce vectors into different object classes.].


``` r
Species <- as.factor(c(1,3,4,2,3,3,4,1,1,1))
Species
#>  [1] 1 3 4 2 3 3 4 1 1 1
#> Levels: 1 2 3 4
class(Species)
#> [1] "factor"
```


### Vectorized arithmetic

One of the most useful properties of vectors in `R` is that we can use them to simplify basic arithmetic operations that need to be done on multiple observations. For example, consider the following data on wing chord (a measure of wing length) and body mass of Swainson's thrushes (*Catharus ustulatus*):


<div class="figure" style="text-align: c">
<img src="https://upload.wikimedia.org/wikipedia/commons/1/1e/Swainson%27s_Thrush_0777vv.jpg" alt="Swainson's Thrush. Image courtesy of VJAnderson via Wikicommons" width="50%" />
<p class="caption">Swainson's Thrush. Image courtesy of VJAnderson via Wikicommons</p>
</div>

<table>
 <thead>
  <tr>
   <th style="text-align:center;"> Individual </th>
   <th style="text-align:center;"> Mass (g) </th>
   <th style="text-align:center;"> Wing chord (mm) </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 36.2 </td>
   <td style="text-align:center;"> 95.1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 34.6 </td>
   <td style="text-align:center;"> 88.4 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 31.0 </td>
   <td style="text-align:center;"> 97.9 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 31.8 </td>
   <td style="text-align:center;"> 96.8 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 29.4 </td>
   <td style="text-align:center;"> 92.3 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 32.0 </td>
   <td style="text-align:center;"> 90.6 </td>
  </tr>
</tbody>
</table>



Perhaps we want to derive the body condition of each individual based on these measures. One common metric of body condition used by ornithologists is $\frac{mass}{size}$, where wing chord is used as a proxy for body size. We *could* calculate body condition for each individual:


``` r
cond1 <- 36.2/95.1 # Body condition of the first individual

cond2 <- 34.6/88.4 # Body condition of the second individual
```

But that is time consuming and error prone. Luckily, `R` will *vectorize* basic arithmetic:


``` r
mass <- c(36.2, 34.6, 31.0, 31.8, 29.4, 32.0)
wing <- c(95.1, 88.4, 97.9, 96.8, 92.3, 90.6)

cond <- mass/wing
cond
#> [1] 0.3807 0.3914 0.3166 0.3285 0.3185 0.3532
```

As you can see, when we divide one vector by another, `R` divides the first element of the first vector by the first element of the second vector, etc. and returns a vector. Vectorized arithmetic works well when the vectors that we are using are of the same length. What would happen though if you were to perform arithmetic on vectors that were of different lengths? Try running the following code and seeing what `R` is doing with these vectors. 


``` r
a <- c(1,10,100,1000)
b <- c(1,2,3,4,5)
c <- a/b
c
#> [1]   1.00   5.00  33.33 250.00   0.20

x <- c(1,10,100,1000, 10000)
y <- c(1,2,3,4)
z <- x/y
z
#> [1]     1.00     5.00    33.33   250.00 10000.00
```

Notice how the way that `R` recycles a vector depends on which is longer.

### Indexing vectors

Often you will need to work with just a subset of a vector. For example, maybe you have a vector of plant biomass measured along transects but you only need the first and third observations.


``` r
y <- c(2, 4, 8, 4, 25)
y[c(1,3)]
#> [1] 2 8
```

Notice that to index certain elements of the vector `y`, we use square brackets. Inside those brackets, we provided *an integer vector*, where each integer refers to the position of elements in the first vector. The indexing vector can be any length (including 1). 

We can also index vectors using *a logical vector*. A logical vector is a special type of object that contains values of `TRUE` or `FALSE`. When using a logical vector for indexing, the logical vector indicates which elements to keep (`TRUE`) or remove (`FALSE`) from the original vector. For this reason, the indexing vector must be same length as the focal vector; i.e., `length(a) == length(v)`


``` r
# Logical vector (which elements of y are greater than 4?)
y > 4
#> [1] FALSE FALSE  TRUE FALSE  TRUE
```


``` r
# Indexing using a logical vector (keep elements 3 and 5)
y[y > 4]
#> [1]  8 25
```

We can also use indexing to remove elements from a vector:


``` r
# Remove the second element
y[-2]
#> [1]  2  8  4 25
```

or to rearrange the order of a vector


``` r
y[c(5,4,3,2,1)]
#> [1] 25  4  8  4  2
```

***

## Functions

The power of `R` is most apparent in the large number of built-in functions that are available for users.  

Functions are small bits of code that perform a specific task. Most functions accept one or more inputs called arguments and return a value or a new object.  

Let's say we have the following data on the number of ticks recorded on 5 dogs:

<table>
 <thead>
  <tr>
   <th style="text-align:center;"> Individual </th>
   <th style="text-align:center;"> Ticks </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 7 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 150 </td>
  </tr>
</tbody>
</table>




What is the total number of ticks recorded in the study? For that, we can use the built-in `sum()` function:


``` r
ticks <- c(4,7,2,3,150)

sum(ticks)
#> [1] 166
```

What is the mean number of ticks per dog?


``` r
mean(ticks)
#> [1] 33.2
```

And the variance?


``` r
var(ticks)
#> [1] 4267
```


### Arguments

Every function takes a different set of arguments and in many cases you will need to look up what those arguments are. The best way to get help for a specific function is to type a question mark followed by the function name, which will bring up a help page in the bottom right panel. For example, the `round` function rounds a number to a specified number of decimal places. This is a useful function when we don't want to print a really large number of digits:


``` r
?round
```

So we see `round` takes an argument called `x`, which is the number we want to round, and the number of `digits` we want to round to. If you provide the arguments in the exact same order as they are defined you don’t have to name them. For example, :


``` r
y <- mean(ticks)
y
#> [1] 33.2

round(y, 0)
#> [1] 33
```

If you do name the arguments, you can switch their order:


``` r
round(digits = 0, x = y)
#> [1] 33
```

Although you don't have to name arguments, it’s a good idea to get in the habit of naming them. This will make your code easier to read, will help avoid mistakes that can occur when you don't put the arguments in the correct order, and makes it easier to trouble shoot code that doesn't do what you expect it to do. 

***

## Matrices

Matrices are similar to vectors but have two dimensions. The first dimension shows the number of rows in the matrix and the second shows the number of columns. Here, we have combined multiple vectors to create a matrix. Notice that the vectors will need to be the same length.


``` r
Site <- c(1,2,3,4,5)
Species <- c('Alasmidonta varicosa',
             'Alasmidonta varicosa',
             'Alasmidonta varicosa', 
             'Lasmigona decorata', 
             'Lasmigona decorata')
Year <- c(rep(2023,5))
mymatrix <- cbind(Site, Species, Year)
mymatrix
#>      Site Species                Year  
#> [1,] "1"  "Alasmidonta varicosa" "2023"
#> [2,] "2"  "Alasmidonta varicosa" "2023"
#> [3,] "3"  "Alasmidonta varicosa" "2023"
#> [4,] "4"  "Lasmigona decorata"   "2023"
#> [5,] "5"  "Lasmigona decorata"   "2023"
```

Notice that because matrices can only contain one data class, all of the numeric vectors have been coerced to be characters. While matrices have many uses in `R`, this is one drawback which will lead us directly to our next object type.

***

## Data frames

Although useful for many applications, vectors and matrices are limited in their ability to store multiple types of data (numeric and character).  

This is where data frames become useful. Perhaps the most common type of data object you will use in `R` is the data frame. Data frames are tabular objects (rows and columns) similar in structure to spreadsheets (think Excel or GoogleSheets). In effect, data frames store multiple vectors - each column of the data frame is a vector. The advantage they have over matrices is that each column can be a different class (numeric, character, etc.) but all values within a column must be the same class. Just as the first row of an Excel spreadsheet can be a list of column names, each column in a data frame has a name that (hopefully) provides information about what the values in that column represent.  

To see how data frames work, let's load a data frame called `jayData` that comes with the `FANR6750` package. 


### An aside about packages

One of `R`'s primary strengths is the large number of *packages* available to users. Packages are units of shareable code and data that have been created by other `R` users. We have already seen the built-in functions that `R` comes with. Packages allow users to share lots and lots of other functions that serve specific purposes. Packages also allow users to share [data sets](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html). There are packages for cleaning data, visualizing data, making maps, fitting specialized models, and basically anything else you can think of. 

Accessing the code in a package first requires installing the package. This only needs to be done once per computer and is usually done using the `install.packages()` function:


``` r
install.packages("devtools")
```

Note that the name of the package (in this case `devtools`) must be in quotation marks. Packages installed using `install.packages()` are stored in a centralized repository called CRAN (Comprehensive R Archive Network). Once `devtools` (or any package) is installed on your computer, you do not need to re-run the `install.packages()` function unless you re-install/update `R` or need to update the package to a newer version. 

Installing a package does not automatically make the functions from that package available in a given `R` session. To tell `R` where the functions come from, you must *load* the package using the `library()` function^[For the purposes of this class, using `library()` or using `require()` will produce equivalent results. These two functions, however, are designed for different purposes. While `library()` is designed to be a stand alone function which loads packages, `require()` is designed to be nested within a larger function statement. If the package you are attempting to load is not installed, `library()` will produce an error message immediately, while `require()` will not. As a result, using `library()` will make it easier for you to diagnose where in your script the error is coming from.]:


``` r
library(devtools)
```

Unlike `install.packages()`, `library()` must be re-run each time you open `R`. Most people include a few calls to `library()` at the beginning of each script so that all packages needed to run the code are loaded at the beginning of the script. 

Occasionally, some packages are stored in other places (e.g., github). These packages can be installed using different functions. For example, I created a package for this course that contains small data sets we will use in labs throughout the semester. The package is stored on github and can be installed by running:


``` r
install_github("RushingLab/WILD8370")
```

Note that the `install_github()` function is from the `devtools` package so you need to run `library(devtools)` before you install the package. Make sure you install the `FANR6750` package now so you have access to the data sets. 

***

### Back to dataframes


Note - As discussed above, if you want to access function or data sets that come with packages, you first need to *load* the package in your current working environment. To do that, use the `library()` function, with the unquoted package name as the argument. Once loaded, all of the package's functions are available to use. 

Alternatively, you can access functions from a given package without loading the package using `package.name::function.name()`. For example, if you want to use the `filter()` function from the `dplyr` package, you could type `dplyr::filter()`. Although less commonly used, this method has a few advantages:

1) Sometimes different packages have functions with the same names. `R` will default to using the function from the package that was loaded last. For example, the `raster` package also has a function called `filter()` so if you load `dplyr` first (using `library() `and then `raster`, `R` will default to using `raster`'s `filter()` function, which could cause problems. 

2) If you share your code with others, the `::` method makes it clear which packages are being use for which functions. That additional clarity is often helpful and is the reason I will often use `::` in this course.

***

To get a quick idea of what information this data frame contains, we can use the `head()` and `tail()` functions, which will print the first and last 6 rows of the data frame:


``` r
library(WILD8370)
data("jaydata") # the data() function loads data sets the come with packages

head(jaydata)
#>        x       y elevation forest chaparral habitat seeds jays
#> 1 258637 3764124       423   0.00      0.02     Oak   Med   34
#> 2 261937 3769224       506   0.10      0.45     Oak   Med   38
#> 3 246337 3764124       859   0.00      0.26     Oak  High   40
#> 4 239437 3763524      1508   0.02      0.03    Pine   Med   43
#> 5 239437 3767724       483   0.26      0.37     Oak   Med   36
#> 6 236437 3769524       830   0.00      0.01     Oak   Low   39

tail(jaydata)
#>          x       y elevation forest chaparral habitat seeds jays
#> 95  258937 3767124       804   0.19      0.68     Oak   Med   40
#> 96  259837 3768024       210   0.00      0.00     Oak   Low   33
#> 97  249337 3769524       467   0.70      0.09    Pine   Med   36
#> 98  262237 3767424      1318   0.02      0.23     Oak   Med   44
#> 99  261937 3770124       354   0.00      0.05    Bare   Low   33
#> 100 247837 3769524       686   0.10      0.32     Oak   Med   40
```

We can see that `jaydata` contains eight columns: `x`, `y`, `elevation`, `forest`, `chaparral`, `habitat`, `seeds`, and `jays`. We'll learn more about what each of these columns represents later in the semester, though just like functions, many data sets have help pages also and you can access those help pages using `?jaydata`. 
Several other useful functions for investigating the structure of data frames are `str()` and `summary()`


``` r

str(jaydata)
#> 'data.frame':	100 obs. of  8 variables:
#>  $ x        : num  258637 261937 246337 239437 239437 ...
#>  $ y        : num  3764124 3769224 3764124 3763524 3767724 ...
#>  $ elevation: int  423 506 859 1508 483 830 457 304 834 164 ...
#>  $ forest   : num  0 0.1 0 0.02 0.26 0 0.02 0 0.54 0 ...
#>  $ chaparral: num  0.02 0.45 0.26 0.03 0.37 0.01 0.22 0.09 0.21 0.11 ...
#>  $ habitat  : chr  "Oak" "Oak" "Oak" "Pine" ...
#>  $ seeds    : chr  "Med" "Med" "High" "Med" ...
#>  $ jays     : int  34 38 40 43 36 39 38 35 41 33 ...

summary(jaydata)
#>        x                y             elevation        forest      
#>  Min.   :230737   Min.   :3761424   Min.   :  12   Min.   :0.0000  
#>  1st Qu.:238762   1st Qu.:3765324   1st Qu.: 365   1st Qu.:0.0000  
#>  Median :245587   Median :3766824   Median : 548   Median :0.0000  
#>  Mean   :246949   Mean   :3767130   Mean   : 659   Mean   :0.0553  
#>  3rd Qu.:254662   3rd Qu.:3768699   3rd Qu.: 929   3rd Qu.:0.0300  
#>  Max.   :266137   Max.   :3773724   Max.   :1537   Max.   :0.7000  
#>    chaparral       habitat             seeds                jays     
#>  Min.   :0.000   Length:100         Length:100         Min.   :30.0  
#>  1st Qu.:0.080   Class :character   Class :character   1st Qu.:36.0  
#>  Median :0.210   Mode  :character   Mode  :character   Median :38.0  
#>  Mean   :0.241                                         Mean   :38.6  
#>  3rd Qu.:0.370                                         3rd Qu.:41.0  
#>  Max.   :0.850                                         Max.   :48.0
```

`str()` tells us about the structure of the data frame, for example `x` and `y`  are numeric columns and `habitat` contains character strings. `summary()` provides some simple summary statistics for each variable. 

Another useful function is `nrow()`, which tells us now many rows are in the data frame (similar to `length()` for vectors):


``` r
nrow(jaydata)
#> [1] 100
```

### Subsetting data frames

As you will see shortly, one of the most common tasks when working with data frames is creating new objects from *parts* of the full data frame. This task involves subsetting the data frame - selecting specific rows and columns. There are **many** ways of subsetting data frames in `R`, too many to discuss so we will only learn about a few. 

#### Selecting columns

First, we may want to select a subset of all of the columns in a big data frame. Data frames are essentially tables, which means we can reference both rows and columns by their number: `data.frame[row#, column#]`. The row and column numbers have to put inside of square brackets following the name of the data frame object. The row number always comes first and the column number second. If you want to select all rows of a specific column, you just leave the `row#` blank. For example, if we wanted a vector containing the number of jays at each survey location:


``` r
jaydata[,8]
#>   [1] 34 38 40 43 36 39 38 35 41 33 34 37 37 38 42 43 39 37 38 40 37 35 37 44 45
#>  [26] 37 36 34 48 43 39 41 45 38 35 38 39 38 41 38 36 43 38 36 33 41 38 30 39 36
#>  [51] 39 36 34 30 38 37 44 36 36 40 44 48 37 41 42 30 41 39 43 30 42 42 41 38 36
#>  [76] 37 33 44 38 35 45 41 35 38 37 45 33 42 34 45 40 42 40 44 40 33 36 44 33 40
```


We can also select columns using `data.frame$column` (where `data.frame` is the name of the data frame object and `column` is the name of the column). For example,


``` r
jaydata$jays
#>   [1] 34 38 40 43 36 39 38 35 41 33 34 37 37 38 42 43 39 37 38 40 37 35 37 44 45
#>  [26] 37 36 34 48 43 39 41 45 38 35 38 39 38 41 38 36 43 38 36 33 41 38 30 39 36
#>  [51] 39 36 34 30 38 37 44 36 36 40 44 48 37 41 42 30 41 39 43 30 42 42 41 38 36
#>  [76] 37 33 44 38 35 45 41 35 38 37 45 33 42 34 45 40 42 40 44 40 33 36 44 33 40
```

Notice that if you hit `tab` after you type the `$`, RStudio will bring up all of the columns and you can use the up or down buttons to find the one you want. 

Sometimes you may want to select more than one column. One way to do that is by indexing using the column names^[You may begin to notice that as we stack functions inside of eachother, it becomes difficult to keep track of matching parentheses and brackets. Newer versions of `R` have resolved this problem using a handy tool. Click `Code` --> `Rainbow parentheses` to make color matched parentheses and brackets for easier code reading.]:


``` r
head(jaydata[, c('x', 'y', 'jays')])
#>        x       y jays
#> 1 258637 3764124   34
#> 2 261937 3769224   38
#> 3 246337 3764124   40
#> 4 239437 3763524   43
#> 5 239437 3767724   36
#> 6 236437 3769524   39
```

You can also use select to remove columns:


``` r
head(subset(jaydata, select= -c(seeds)))
#>        x       y elevation forest chaparral habitat jays
#> 1 258637 3764124       423   0.00      0.02     Oak   34
#> 2 261937 3769224       506   0.10      0.45     Oak   38
#> 3 246337 3764124       859   0.00      0.26     Oak   40
#> 4 239437 3763524      1508   0.02      0.03    Pine   43
#> 5 239437 3767724       483   0.26      0.37     Oak   36
#> 6 236437 3769524       830   0.00      0.01     Oak   39
```


***

#### Filtering rows

To select specific rows, we can use the `row#` method we learned above, this time leaving the columns blank:


``` r
jaydata[1,]
#>        x       y elevation forest chaparral habitat seeds jays
#> 1 258637 3764124       423      0      0.02     Oak   Med   34
```

If we want more than one row, we just put in a vector with all of the rows we want:


``` r
jaydata[1:2,]
#>        x       y elevation forest chaparral habitat seeds jays
#> 1 258637 3764124       423    0.0      0.02     Oak   Med   34
#> 2 261937 3769224       506    0.1      0.45     Oak   Med   38

jaydata[c(1,30),]
#>         x       y elevation forest chaparral habitat seeds jays
#> 1  258637 3764124       423      0      0.02     Oak   Med   34
#> 30 259537 3765924      1419      0      0.07    Pine   Med   43
```

Note that we can use the square brackets to also subset vectors, in which case we don't need the comma as long as you tell `R` which column you want first:


``` r
jaydata$jays[1]
#> [1] 34
```

Sometimes, we may not know the specific row number(s) we want but we do know the value of one of the columns we want to keep. We can do this in `R` by indexing using logical subsetting. For example, if we want just surveys that were conducted in oak habitat, we use:


``` r
head(jaydata[jaydata$habitat == "Oak",])
#>        x       y elevation forest chaparral habitat seeds jays
#> 1 258637 3764124       423   0.00      0.02     Oak   Med   34
#> 2 261937 3769224       506   0.10      0.45     Oak   Med   38
#> 3 246337 3764124       859   0.00      0.26     Oak  High   40
#> 5 239437 3767724       483   0.26      0.37     Oak   Med   36
#> 6 236437 3769524       830   0.00      0.01     Oak   Low   39
#> 7 263737 3766524       457   0.02      0.22     Oak   Med   38
```

Notice the need for two equals signs (`==`) when telling `R` we want the row where `habitat` equals `Oak`. We could also select multiple rows using operators like greater than, less than, etc. 


``` r
head(jaydata[jaydata$elevation > 1000,])
#>         x       y elevation forest chaparral habitat seeds jays
#> 4  239437 3763524      1508   0.02      0.03    Pine   Med   43
#> 24 261637 3768324      1276   0.02      0.36     Oak  High   44
#> 25 248737 3766524      1024   0.03      0.41    Pine   Low   45
#> 29 255937 3765024      1400   0.02      0.45     Oak  High   48
#> 30 259537 3765924      1419   0.00      0.07    Pine   Med   43
#> 32 245737 3762924      1004   0.02      0.32     Oak   Low   41
```

or a slightly more complicated example:


``` r
head(jaydata[jaydata$elevation < 1000 & jaydata$habitat == "Oak",])
#>        x       y elevation forest chaparral habitat seeds jays
#> 1 258637 3764124       423   0.00      0.02     Oak   Med   34
#> 2 261937 3769224       506   0.10      0.45     Oak   Med   38
#> 3 246337 3764124       859   0.00      0.26     Oak  High   40
#> 5 239437 3767724       483   0.26      0.37     Oak   Med   36
#> 6 236437 3769524       830   0.00      0.01     Oak   Low   39
#> 7 263737 3766524       457   0.02      0.22     Oak   Med   38
```
