##### Vectors, Matrices, Data Frames, and Lists
##### 17 January 2023
##### BTM


#### Entering the Tidyverse

### What is the tidyverse
  # an opinionated collection of R packages which share philosophy, grammar (how the code is structured), and data structure.

### Dyplr package
  # a new(er) package that provides a set of tools for manipulating data sets in R specifically written to be fast!
  # has individual functions that correspond to the most common operations
  # makes it easier for you to figure out what to do with your data

## Core verbs/functions
  filter()
  arrange()
  select()
  summarize() # or group_by()
  mutate()
    
  ### whenever you want to use a package, you have to load it into your library using this code
    library(tidyverse)
    
  ### Let's use a built-in data set
    data(starwars)
    class(starwars)

## What is a tibble
  glimpse(starwars) #more effective than str() in this case   
  head(starwars) #looks a little different since it's a tibble (mentions dimensions and also states variable type)
  
## Cleaning up our data
  # complete.cases is not part of dplyr, but it is very useful!
  # dataClean <- starwars[complete.cases(starwars),] # removes all rows with NA values 
  
  # to get complete cases for just certain columns 
  starwarsClean <-starwars[complete.cases(starwars[,1:10]),]
  
  
  # Check for NAs
  is.na(starwarsClean[1,1]) #useful for only a few observations since it returns a list of True/False
  anyNA(starwarsClean)
  anyNA(starwars[,1:10]) # compared to our original dataset
  
  # What does our data look like now?
  glimpse(starwarsClean) # the list columns are still there but no NAs in columns 1-10
  head(starwarsClean)
  
## Filter
  ### uses >, >=, <, <=,!=, == (not just one!) for comparisons   
  ### Logical operators: & | !
  
  # filter automatically excludes NAs, have to ask for them specifically 
  
  filter(starwarsClean, gender == "masculine" & height < 180) # you can also use commas in place of &   
  
  filter(starwars, gender == "masculine", height <180, height > 100) # can add multiple conditions for the same variable
  
## The %in% operator
  # The %in% ???matching??? operator can be used to identify if an element (e.g., a number) belongs to a vector or data frame
  # Using the %in% operator you can compare vectors of different lengths to see if elements of one vector match at least one element in another. The length of output will be equal to the length of the vector being compared (the first one). This is not possible when utilizing the == operator.
  
  ## Simple example
  # Sequences of Letters:
  a <- LETTERS[1:10]
  length(a)
  
  # Second seq of letters
  b <- LETTERS[4:10]
  length(b)
  
  # output depends on first vector
  a %in% b
  b %in% a
  
  ### using %in% to subset
  filter(starwars, eye_color %in% c("blue", "brown")) # we can use %in% for a few conditions, similar to ==
  
## arrange: Reorder rows
  arrange(starwarsClean, by = height) #default is ascending order   
  
  arrange(starwarsClean, by = desc(height)) #we can use desc() to change that
  
  arrange(starwarsClean, height, desc(mass)) # each additional column used to break ties with the preceding column
  
  starwars1<- arrange(starwars, height) # missing values are at the end; note we haven't been assigning anything to a variable, just printing (until now) 
  tail(starwars1)

  
  
## select(): Choose variables by their names
  ## All of these do the same thing (subset)
  starwarsClean[1:10,] # using base R
  select(starwarsClean, 1:10) # you can use numbers to subset
  select(starwarsClean, name:species) # you can use variables names too
  select(starwarsClean, -(films:starships)) # you can subset everything except particular variables
  
  ## Rearrange columns
  select(starwarsClean, name, gender, species, everything()) # using the everything() helper function is useful if you have a few variables to move to the beginning
  select(starwarsClean, contains("color")) ## other helpers include: ends_with, starts_with, matches (reg ex), num_range
  
  ## Renaming columns
  select(starwars, haircolor = hair_color) # select can rename but only keeps specified variable; actual name of the column comes after stating new name
  rename(starwarsClean,  haircolor = hair_color) # keeps all the variables

  
  
  
## mutate(): Create new variables with functions of existing variables
  
  # Let's create a new column that is a height divided by mass
  mutate(starwarsClean, ratio = height/mass) # note we use arithmetic operators 
  
  starwars_lbs <- mutate(starwarsClean, mass_lbs=mass*2.2) # now let's convert kg to lbs
  head(starwars_lbs) # mass_lbs is now the last variable of the tibble
  
  select(starwars_lbs, 1:3, mass_lbs, everything()) # we can bring it to the beginning using select
  
  # If we only wanted the new variable
  transmute(starwarsClean, mass_lbs=mass*2.2) # just keep the new variable
  
  transmute(starwarsClean, mass, mass_lbs=mass*2.2) # you can mention variables you want to keep in the new dataset
  

## summarize() and group_by(): Collapse many values down to a single summary
  summarize(starwarsClean, meanHeight = mean(height)) # gives summary statistics for entire tibble
  
  # working with NAs
  summarize(starwars, meanHeight = mean(height)) # does not calculate mean if NAs are present
  summarize(starwars, meanHeight = mean(height, na.rm=TRUE), TotalNumber = n()) # n() is a useful function in determining sample size
  summarize(starwarsClean, meanHeight = mean(height), number = n() ) #na.rm not necessary since we are working with a clean dataset
  
  # use group_by for maximum usefulness
  starwarsGenders<- group_by(starwars, gender)
  head(starwarsGenders) # now we see the groups mentioned at the top of the tibble
  summarize(starwarsGenders, meanHeight = mean(height, na.rm = TRUE), number = n() ) # now we can compare height and sample size between groups


  
  
  
# What is piping?
  # uses the forward piping operator %>%
  # used to emphasize a sequence of actions
  # it lets you pass an intermediate result onto the next function (it takes the output of one statement and makes it the input of the next statement)
  # avoid when you need to manipulate more than one object at a time or there are meaningful intermediate objects
  # formatting: should always have a space before it and usually followed by a new line (usually automatic indent)
  
starwarsClean %>%
  group_by(gender) %>%
  summarize(meanHeight = mean(height, na.rm=T), number=n()) 
# so much cleaner! 

## case_when() is useful for multiple ifelse statements
starwarsClean %>%
  mutate(sp = case_when(species == "Human" ~ "Human", TRUE ~ "Non-Human")) %>%
  select(name, sp, everything())

starwarsClean %>%
  group_by(films) %>%
  mutate(
    sp = case_when(species == "Human" ~ "Human", TRUE ~ "Non-Human"),
    status = case_when(str_detect(films, "A New Hope") ~ "OG", TRUE ~ "Later")) %>%
  select(name,sp, status, everything()) %>%
  arrange(status) %>%
  {starwarsOGstatus <<- .}

tail(starwarsOGstatus)


## long to wide format and vice-versa
glimpse(starwarsClean)

# make data set wider
wideSW <- starwarsClean %>% 
  select(name,sex, height) %>%
  pivot_wider(names_from = sex, values_from = height, values_fill = NA)
wideSW

## make data set longer
glimpse(wideSW)
wideSW %>%
  pivot_longer(cols= male:female,
               names_to = "sex",
               values_to= "height",
               values_drop_na = T)

# one last example
starwars %>%
  select(name, homeworld) %>%
  group_by(homeworld) %>%
  mutate(rn = row_number()) %>%
  ungroup() %>%
  pivot_wider(names_from = homeworld, values_from = name) %>%
  select(-rn)
  

      
      
      
      
      
      
      
      
      
      
      
      
      
