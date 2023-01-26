##### ggplot
##### 24 January 2023
##### BTM

library(ggplot2)
library(ggthemes)
library(patchwork)
library(dplyr)

# Components of a ggplot layer
  # data (in a data frame)
  # aesthetic mappings (variables are mapped to aesthetics)
  # geom (the geometric used to draw the layer; has specific aesthetics)
  # stat (takes raw data and transforms it for useful plotting)
  # position (adjustment to prevent over-plotting)

# ggplot template
# p1 <- ggplot(data= <DATA>,mapping=aes(<MAPPINGS>) + 
#                <GEOM_FUNCTION>(aes(<MAPPINGS>),
#                                stat=<STAT>,
#                                position=<POSITION>) +
#                <COORDINATE_FUNCTION> +
#                <FACET_FUNCTION>
# print(p1)
# ggsave(plot=p1, filename="MyPlot",width=5,height=3,units="in",device="pdf")



#####
d <- mpg # use built in mpg data frame
str(d)
glimpse(d)

# use qplot for fast plotting while coding
  # basic histogram
qplot(x=d$hwy)
qplot(x=d$hwy,fill=I("green"),color=I("black"))

# basic scatter plot
qplot(x=d$displ,y=d$hwy, geom=c("smooth","point"))
qplot(x=d$displ,y=d$hwy, geom=c("smooth","point"), method = "lm")

# basic boxplot
qplot(x=d$fl, y=d$cty, geom="boxplot", fill = I("forestgreen"))       

# basic barplot (long format)
qplot(x=d$fl,geom="bar",fill=I("forestgreen"))

# bar plot with specified counts or means
x_treatment <- c("Control","Low","High")
y_response <- c(12,2.5,22.9)
qplot(x=x_treatment,y=y_response,geom="col",fill=I(c("red","green","blue")))



##### Themes and Fonts
p1 <- ggplot(data=d, mapping=aes(x=displ,y=cty, color=cyl)) + geom_point()
print(p1)

p1 + theme_bw() # good with grid lines
p1 + theme_classic() # no grid lines
p1 + theme_linedraw() # black frame
p1 + theme_dark() # good for brightly colored points

p1 + theme_base() # mimics base R
p1 + theme_par() # matches current par settings in base

p1 + theme_void() # shows data only
p1 + theme_solarized() # good for web pages
p1 + theme_economist() # many specialized themes
p1 + theme_grey() # ggplots default theme

# Major theme modifications
  # use theme parameters to modify font and font size
p1 + theme_classic(base_size=40,base_family="serif")


# defaults: theme_grey, base_size=16,base_family="Helvetica")
# font families (Mac): Times, Ariel, Monaco, Courier, Helvetica, serif,sans

# use coordinate_flip to invert entire plot
p2 <- ggplot(data=d, aes(x=fl,fill=fl)) + 
  geom_bar()
print(p2)

p2 + coord_flip() + theme_grey(base_size=20,base_family="sans")

# Minor theme modificaiton
p1 <- ggplot(data=d, aes(x=displ,y=cty)) + 
  geom_point(size=7,
             shape=21,
             color="black",
             fill="steelblue") +
  labs(title="My graph title here",
       subtitle="An extended subtitle that will print below the main title",
       x="My x axis label",
       y="My y axis label") +
  xlim(0,4) + ylim(0,20)
print(p1)

library(viridis)
cols <- viridis(7, option ="viridis") #plasma, turbo, viridis
ggplot(data=d, aes(x = class, y = hwy, fill=class)) +
   geom_boxplot() +
   scale_fill_manual(values = cols)

library(patchwork)
p1 + p2 # side by side
p1 / p2 # over the top
