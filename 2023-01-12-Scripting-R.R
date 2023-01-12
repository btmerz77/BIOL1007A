###### Prgramming in R
###### 12 January 2023
###### BTM

# Advantages
  ## intereactive use
  ## graphics, statistics
  ## very active community of contributors
  ## works on multiple platforms

# Disadvantages
  ## lazy evaluation
  ## some packages are poorly documented
  ## some functions are hard to learn (steep learning curve)
  ## some unreliable packages
  ## problems with big data (multiple GBs)

# Let's start with the basics
## Assignment operator: used to assign a new value to a variable

x <- 5 #assign value
print(x) #print/obtain output in console
x #another way fo printing a value

y = 4 #legal but not used except in function arguments
print(y)
y = y + 1.1

y <- y + 1.1 #makes more sense that equal since you are overwriting the value, not making it equal to

#to escape plus loop in console, either press into and add paren or esc


## Variables: used to store information (a container)
z <- 3 # Begin with lower case letter 
plantHeight <- 10 # option "camelCaseFormatting"
plant.height <- 4.2 # avoid periods
plant_height <- 3.3  # optimal "snake_case_formatting"
. <- 5.5 # reserve this for a generic temporary variable (more later), not saved in the enironment because its a temporary variable

## Function: It is a block of code that performs a task. You can use a single short command over and over again, rather than writing it out multiple times.

# you can create your own functions
square <- function(x=NULL){
  x <- x^2
  print(x)
}

square(4)

# or use built-in functions
numbers <- c(3, 4, 10, 2) #type ?c to read about this function
sum(numbers) # ?sum finds the function in help, enter in console



##### Atomics Vectors
# one dimensional (single row)
# data strctures in R programming

### Types
# character strings (usually within quotes)
# integers (whole numbers)
# double (real numbers, decimals)
# both integers and doubles are numeric
# logical (TRUE or FALSE)
# factor (catagorizes, groups variable)

# c function (combine)
z <- c(3.2, 5, 5, 6) 
print(z)
typeof(z) #returns type of variable
class(z) #returns class of varaible
is.numeric(z) #returns TRUE FALSE

# c() always "flattens" to an atomic vector
z <- c(c(3,4),c(5,6)) 
print(z)

# character strings with single or double quotes
z <- c("perch","bass",'trout') 
print(z)
# use both with an internal quote
z <- c("This is only 'one' character string", 'a second')
print(z)
typeof(z)
is.character(z)

# building logicals
# Boolean, not with quotes, all caps
z <- c(TRUE,TRUE,FALSE) 
z <- as.character(z) #foce logical boolean into characters

print(z)
class(z)
typeof(z)
is.logical(z)
is.integer(z)


### Properties
# Type
z <- c(1.1, 1.2, 3, 4.4)
typeof(z) # gives type
is.numeric(z) # is. gives logical
as.character(z) # as. coerces variable
print(z)
typeof(z)

# Length
length(z) # gives number of elements
dim(z) #NULL because vectors are 1 dim

length(y) # throws error if variable does not exist

#Names
z <- runif(5)
# optional attribute not initially assigned
names(z) 
print(z)
# add names later after variable is created
names(z) <- c("chow","pug","beagle","greyhound","akita")
print(z)
# add names when variable is built (with or without quotes)
z2 <- c(gold=3.3, silver=10, lead=2)
print(z2)
# reset names
names(z2) <- NULL
# names can be added for only a few elements
# names do not have to be distinct, but often are
names(z2) <- c("copper","zinc")
print(z2)

# NA values  
# missing data  
z <- c(3.2,3.3,NA) # NA is a missing value
typeof(z)  
mean(z) # won't work because of NA
anyNA(z)  
is.na(z) # logical operator to find missing values
which(is.na(z)) # use which to find NAs


### Subsetting
# vectors are indexed
z <- c(3.1, 9.2, 1.3, 0.4, 7.5)
z[1]
# positive index values
z[c(2,3)]
# negative index values to exclude elements
z[-c(2,3)]
# == to find exact match
z[z==1.3]

# also use which() function to find subscript indicators
which(z<3)

# this works, but is overkill; just use the boolean operator
z[which(z<3)]
z[z<3] #use logical statements withn square breakets to subest by conditions

z <- runif(10) # simple integer sequence
print(z)

z < 0.5 # create logical vector
z[z < 0.5] # use as index call
which(z < 0.5) # use to get indices for logical
z[which(z < 0.5)] 

# also can subset using named vector elements
names(z) <- letters[1:5]
z[c("b","c")]

# subset function
subset(z, z<3)

# randomly sample from a vector
story_vec <- rep(c("A", "Frog", "Jumped", "Here"))
sample(x=story_vec) # with no other params, this reorders the vector
sample(x=story_vec, size=3) # specify a number (sampling without replacement)

# add items 
story_vec <- c(story_vec[1], "Green", story_vec[2:4])
story_vec

# replace items
story_vec[2]<-"Blue"
story_vec


### Vectory function
# Vector function
vec <- vector(mode = "numeric", length = 5)

# rep and seq function
z <- rep(x = 0, times = 100)
z <- rep(x = 1:4, each = 3)

z <- seq(from = 2, to = 4)

seq(from =2, to = 4, by = 0.5)
seq(from=1, to=length(z))

