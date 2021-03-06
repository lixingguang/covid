## Visualizing Global Map of cases confirmed, deaths and recovered across the globe ##

# data source (Johns Hopkins CSSE)
# https://www.kaggle.com/imdevskp/corona-virus-report/data#
# https://github.com/CSSEGISandData/COVID-19


# libraries and setup
getwd()
setwd("/Users/paulapivat/Desktop")
library(tidyverse)
library(rgdal)    # download as geospatial, then change to data frame, then plot in ggplot2, is faster
library(broom)   # required to turn geospatial data into dataframe, so we can read into ggplot2 (this is called “fortify”) 
library(patchwork)  # to organize multiple chart into one view

### Open and Plot Shapefiles in R ###

# geospatial data - must use plot()
my_spdf <- readOGR(dsn = paste0(getwd(), "/temp_covid/world_shape_file/"), layer = "TM_WORLD_BORDERS_SIMPL-0.3", verbose = FALSE)
par(mar = c(0,0,0,0))
plot(my_spdf, col="#f2f2f2", bg="skyblue", lwd=0.25, border=0)

# data frame - plotting with ggplot2 instead
spdf_fortified <- tidy(my_spdf, region = "NAME")

# plot
# faster than maps or map_data
ggplot() + geom_polygon(data = spdf_fortified, aes(x = long, y = lat, group = group), fill = "#69b3a2", color = "white") + theme_void()  


### Download Data Set into local environment ###

# Confirmed, Death, Recovered from 1/22/20 - 3/8/20 (Jan 22 - March 8)
# NUMBERS ARE CUMMULATIVE
covid_df <- read_csv("/Users/paulapivat/Desktop/temp_covid/covid_19_clean_complete.csv")

df <- covid_df

# match “id” from spdf_fortified with df
# setting up data frame to be joined 

df[,'id'] <- NA

# change id one-by-one (manual process)
# Note: categories that did not match: df$`Country/Region` == Others, North Macedonia, Vatican City and Republic of Ireland

# Mainland China —> china
df$id <- if_else(df$`Country/Region`=="Mainland China", df$id <- "China", NULL)

# note: using ifelse() base function to conditionally change, but leave everything else as is

df$id = ifelse(df$`Country/Region`=="US", "United States", df$id)    # change ‘US’ to ‘United States’ while leaving everything else untouched
df$id = ifelse(df$`Country/Region`=="South Korea", "Korea, Republic of", df$id)    # “South Korea” to “Korea, Republic of” 
df$id = ifelse(df$`Country/Region`=="Thailand", "Thailand", df$id)      #Thailand remains same
df$id = ifelse(df$`Country/Region`=="Japan", "Japan", df$id)              #Japan remains same
df$id = ifelse(df$`Country/Region`=="Taiwan", "Taiwan", df$id)
df$id = ifelse(df$`Country/Region`=="Macau", "Macau", df$id)
df$id = ifelse(df$`Country/Region`=="Hong Kong", "Hong Kong", df$id)
df$id = ifelse(df$`Country/Region`=="Singapore", "Singapore", df$id)
df$id = ifelse(df$`Country/Region`=="Vietnam", "Viet Nam", df$id)
df$id = ifelse(df$`Country/Region`=="France", "France", df$id)
df$id = ifelse(df$`Country/Region`=="Nepal", "Nepal", df$id)
df$id = ifelse(df$`Country/Region`=="Malaysia", "Malaysia", df$id)
df$id = ifelse(df$`Country/Region`=="Canada", "Canada", df$id)
df$id = ifelse(df$`Country/Region`=="Australia", "Australia", df$id)
df$id = ifelse(df$`Country/Region`=="Cambodia", "Cambodia", df$id)
df$id = ifelse(df$`Country/Region`=="Sri Lanka", "Sri Lanka", df$id)
df$id = ifelse(df$`Country/Region`=="Germany", "Germany", df$id)
df$id = ifelse(df$`Country/Region`=="Finland", "Finland", df$id)
df$id = ifelse(df$`Country/Region`=="United Arab Emirates", "United Arab Emirates", df$id)
df$id = ifelse(df$`Country/Region`=="Philippines", "Philippines", df$id)
df$id = ifelse(df$`Country/Region`=="India", "India", df$id)

df$id = ifelse(df$`Country/Region`=="Italy", "Italy", df$id)
df$id = ifelse(df$`Country/Region`=="UK", "United Kingdom", df$id)
df$id = ifelse(df$`Country/Region`=="Russia", "Russia", df$id)
df$id = ifelse(df$`Country/Region`=="Sweden", "Sweden", df$id)
df$id = ifelse(df$`Country/Region`=="Spain", "Spain", df$id)
df$id = ifelse(df$`Country/Region`=="Belgium", "Belgium", df$id)
df$id = ifelse(df$`Country/Region`=="Egypt", "Egypt", df$id)

df$id = ifelse(df$`Country/Region`=="Iran", "Iran (Islamic Republic of)", df$id)
df$id = ifelse(df$`Country/Region`=="Lebanon", "Lebanon", df$id)
df$id = ifelse(df$`Country/Region`=="Iraq", "Iraq", df$id)
df$id = ifelse(df$`Country/Region`=="Oman", "Oman", df$id)
df$id = ifelse(df$`Country/Region`=="Afghanistan", "Afghanistan", df$id)
df$id = ifelse(df$`Country/Region`=="Bahrain", "Bahrain", df$id)
df$id = ifelse(df$`Country/Region`=="Kuwait", "Kuwait", df$id)
df$id = ifelse(df$`Country/Region`=="Algeria", "Algeria", df$id)
df$id = ifelse(df$`Country/Region`=="Croatia", "Croatia", df$id)
df$id = ifelse(df$`Country/Region`=="Switzerland", "Switzerland", df$id)
df$id = ifelse(df$`Country/Region`=="Austria", "Austria", df$id)
df$id = ifelse(df$`Country/Region`=="Israel", "Israel", df$id)
df$id = ifelse(df$`Country/Region`=="Pakistan", "Pakistan", df$id)

df$id = ifelse(df$`Country/Region`=="Brazil", "Brazil", df$id)
df$id = ifelse(df$`Country/Region`=="Georgia", "Georgia", df$id)
df$id = ifelse(df$`Country/Region`=="Greece", "Greece", df$id)
df$id = ifelse(df$`Country/Region`=="Norway", "Norway", df$id)
df$id = ifelse(df$`Country/Region`=="Romania", "Romania", df$id)
df$id = ifelse(df$`Country/Region`=="Denmark", "Denmark", df$id)
df$id = ifelse(df$`Country/Region`=="Estonia", "Estonia", df$id) 
df$id = ifelse(df$`Country/Region`=="Netherlands", "Netherlands", df$id)
df$id = ifelse(df$`Country/Region`=="San Marino", "San Marino", df$id)
df$id = ifelse(df$`Country/Region`=="Belarus", "Belarus", df$id)
df$id = ifelse(df$`Country/Region`=="Iceland", "Iceland", df$id)
df$id = ifelse(df$`Country/Region`=="Lithuania", "Lithuania", df$id)
df$id = ifelse(df$`Country/Region`=="Mexico", "Mexico", df$id)

df$id = ifelse(df$`Country/Region`=="New Zealand", "New Zealand", df$id)
df$id = ifelse(df$`Country/Region`=="Nigeria", "Nigeria", df$id)
df$id = ifelse(df$`Country/Region`=="Ireland", "Ireland", df$id)
df$id = ifelse(df$`Country/Region`=="Luxembourg", "Luxembourg", df$id)
df$id = ifelse(df$`Country/Region`=="Monaco", "Monaco", df$id)
df$id = ifelse(df$`Country/Region`=="Qatar", "Qatar", df$id)
df$id = ifelse(df$`Country/Region`=="Ecuador", "Ecuador", df$id)
df$id = ifelse(df$`Country/Region`=="Azerbaijan", "Azerbaijan", df$id)
df$id = ifelse(df$`Country/Region`=="Czech Republic", "Czech Republic", df$id)
df$id = ifelse(df$`Country/Region`=="Armenia", "Armenia", df$id)
df$id = ifelse(df$`Country/Region`=="Dominican Republic", "Dominican Republic", df$id)
df$id = ifelse(df$`Country/Region`=="Indonesia", "Indonesia", df$id)
df$id = ifelse(df$`Country/Region`=="Portugal", "Portugal", df$id)
df$id = ifelse(df$`Country/Region`=="Andorra", "Andorra", df$id)
df$id = ifelse(df$`Country/Region`=="Latvia", "Latvia", df$id)
df$id = ifelse(df$`Country/Region`=="Morocco", "Morocco", df$id)
df$id = ifelse(df$`Country/Region`=="Saudi Arabia", "Saudi Arabia", df$id)
df$id = ifelse(df$`Country/Region`=="Senegal", "Senegal", df$id)
df$id = ifelse(df$`Country/Region`=="Argentina", "Argentina", df$id)

df$id = ifelse(df$`Country/Region`=="Chile", "Chile", df$id)
df$id = ifelse(df$`Country/Region`=="Jordan", "Jordan", df$id)
df$id = ifelse(df$`Country/Region`=="Ukraine", "Ukraine", df$id)
df$id = ifelse(df$`Country/Region`=="Saint Barthelemy", "Saint Barthelemy", df$id)
df$id = ifelse(df$`Country/Region`=="Hungary", "Hungary", df$id)
df$id = ifelse(df$`Country/Region`=="Faroe Islands", "Faroe Islands", df$id)
df$id = ifelse(df$`Country/Region`=="Gibraltar", "Gibraltar", df$id)
df$id = ifelse(df$`Country/Region`=="Liechtenstein", "Liechtenstein", df$id)
df$id = ifelse(df$`Country/Region`=="Poland", "Poland", df$id)
df$id = ifelse(df$`Country/Region`=="Tunisia", "Tunisia", df$id)
df$id = ifelse(df$`Country/Region`=="Palestine", "Palestine", df$id)
df$id = ifelse(df$`Country/Region`=="Bosnia and Herzegovina", "Bosnia and Herzegovina", df$id)
df$id = ifelse(df$`Country/Region`=="Slovenia", "Slovenia", df$id)
df$id = ifelse(df$`Country/Region`=="South Africa", "South Africa", df$id)
df$id = ifelse(df$`Country/Region`=="Bhutan", "Bhutan", df$id)

df$id = ifelse(df$`Country/Region`=="Cameroon", "Cameroon", df$id)
df$id = ifelse(df$`Country/Region`=="Colombia", "Colombia", df$id)
df$id = ifelse(df$`Country/Region`=="Costa Rica", "Costa Rica", df$id)
df$id = ifelse(df$`Country/Region`=="Peru", "Peru", df$id)
df$id = ifelse(df$`Country/Region`=="Serbia", "Serbia", df$id)
df$id = ifelse(df$`Country/Region`=="Slovakia", "Slovakia", df$id)
df$id = ifelse(df$`Country/Region`=="Togo", "Togo", df$id)
df$id = ifelse(df$`Country/Region`=="French Guiana", "French Guiana", df$id)
df$id = ifelse(df$`Country/Region`=="Malta", "Malta", df$id)
df$id = ifelse(df$`Country/Region`=="Martinique", "Martinique", df$id)
df$id = ifelse(df$`Country/Region`=="Bulgaria", "Bulgaria", df$id)
df$id = ifelse(df$`Country/Region`=="Maldives", "Maldives", df$id)
df$id = ifelse(df$`Country/Region`=="Bangladesh", "Bangladesh", df$id)
df$id = ifelse(df$`Country/Region`=="Moldova", "Republic of Moldova", df$id)
df$id = ifelse(df$`Country/Region`=="Paraguay", "Paraguay", df$id)

# Note: categories that did not match: df$`Country/Region` == Others (Diamond Princess Cruise Ship), North Macedonia, Vatican City and Republic of Ireland
# save special cases to their own data frames

diamond_princess <- df %>% filter(df$`Country/Region`=="Others")
north_macedonia <- df %>% filter(df$`Country/Region`=="North Macedonia")
vatican_city <- df %>% filter(df$`Country/Region`=="Vatican City")
republic_ireland <- df %>% filter(df$`Country/Region`=="Republic of Ireland")

# Delete all rows where id is NA
df2 <- df  # assign to new data frame

# delete Others (Diamond Princess cruise ship), North Macedonia, Vatican City and Republic of Ireland from df2
df2 <- df2[!df2$`Country/Region`=="Others",]
df2 <- df2[!df2$`Country/Region`=="North Macedonia",]
df2 <- df2[!df2$`Country/Region`=="Vatican City",]
df2 <- df2[!df2$`Country/Region`=="Republic of Ireland",]

# prepare to join; create new data frame with selected variables: id, confirmed, deaths, recovered, date
df3 <- df2 %>% select(id, Date, Confirmed, Deaths, Recovered)

# assign backup for spatial data frame
spdf_fortified2 <- spdf_fortified

# join df3 and spdf_fortified2
spdf_fortified2 <- spdf_fortified2 %>% inner_join(df3, by = "id")

#######--------- Plots ----------#########

### Choropleth Maps ###

# no distinction in color
ggplot(data = spdf_fortified2) 
+ geom_polygon(aes(x = long, y = lat, fill = spdf_fortified2$Confirmed, group = group), color = "black") 
+ scale_fill_gradient2(low = "#69b3a2", mid = "white", high = "#0571B0", midpoint = 100000, space = "Lab", na.value = "grey50", guide = "colourbar", aesthetics = "fill") 
+ theme_classic()

# filter on per date basis
jan_22 <- spdf_fortified2 %>% filter(Date=="1/22/20")
jan_23 <- spdf_fortified2 %>% filter(Date=="1/23/20")
jan_24 <- spdf_fortified2 %>% filter(Date=="1/24/20")
jan_25 <- spdf_fortified2 %>% filter(Date=="1/25/20")
jan_26 <- spdf_fortified2 %>% filter(Date=="1/26/20")
jan_27 <- spdf_fortified2 %>% filter(Date=="1/27/20")
jan_28 <- spdf_fortified2 %>% filter(Date=="1/28/20")
jan_29 <- spdf_fortified2 %>% filter(Date=="1/29/20")
jan_30 <- spdf_fortified2 %>% filter(Date=="1/30/20")
jan_31 <- spdf_fortified2 %>% filter(Date=="1/31/20")
feb_1 <- spdf_fortified2 %>% filter(Date=="2/1/20")
feb_2 <- spdf_fortified2 %>% filter(Date=="2/2/20")

march_7 <- spdf_fortified2 %>% filter(Date=="3/7/20")


# filter to one date - March 7th - some distinction in color
# log transformation due to scale differences
ggplot(data = march_7) 
+ geom_polygon(aes(x = long, y = lat, fill = march_7$Confirmed, group = group), color = "black") 
+ scale_fill_gradient(trans = "log10") 
+ theme_classic()

# March 7th - better distinction in color
ggplot(data = march_7) 
+ geom_polygon(aes(x = long, y = lat, fill = march_7$Confirmed, group = group), color = "black") 
+ scale_fill_gradientn(colours = rev(rainbow(7)), breaks = c(2, 4, 10, 100, 1000, 10000, 50000), trans = "log10") 
+ theme_classic()

# March 7th - scale_fill_viridis_c(option = "plasma", trans = "log10") - best color scheme
ggplot(data = march_7) 
+ geom_polygon(aes(x = long, y = lat, fill = march_7$Confirmed, group = group), color = "black") 
+ scale_fill_viridis_c(option = "plasma", trans = "log10") 
+ theme_classic()

# scale_fill_distiller(palette = "Spectral", trans = "log") also good option
# log vs log10
ggplot(data = march_7) 
+ geom_polygon(aes(x = long, y = lat, fill = march_7$Confirmed, group = group), color = "black") 
+ scale_fill_distiller(palette = "Spectral", trans = "log") 
+ theme_classic()

###### ----- STATIC BUBBLE MAP ----- ######

# geospatial data - must use plot()
my_spdf <- readOGR(dsn = paste0(getwd(), "/temp_covid/world_shape_file/"), layer = "TM_WORLD_BORDERS_SIMPL-0.3", verbose = FALSE)
par(mar = c(0,0,0,0))
plot(my_spdf, col="#f2f2f2", bg="skyblue", lwd=0.25, border=0)

# data frame - plotting with ggplot2 instead
spdf_fortified <- tidy(my_spdf, region = "NAME")

# overlap John Hopkins Data points onto geospatial data

# Confirmed
# note: emphasize scale 
# breaks for color scale shows doubling rate
mybreaks <- c(20, 40, 80, 160, 320, 640, 1280, 2560, 5120, 10240, 20480, 40960)

map <- ggplot() 
+ geom_polygon(data = spdf_fortified, aes(x = long, y = lat, group = group), fill = "#DCDCDC", color = "white") 
+ theme_void() 
+ geom_point(data = df, aes(x=Long, y=Lat, size=Confirmed, color=Confirmed)) 
+ scale_size_continuous(range = c(1,12), breaks = mybreaks) 
+ scale_color_viridis_c(option = "magma", trans = "log", breaks=mybreaks) 
+ scale_alpha_continuous(range = c(0.1, .9), breaks = mybreaks, trans = "log") 
+ guides(colour = guide_legend()) 
+ labs(title = "Confirmed COVID-19 cases around the World", subtitle = "as of March 8th, 2020")


# recovered - Doesn't make sense on a map
ggplot() 
+ geom_polygon(data = spdf_fortified, aes(x = long, y = lat, group = group), fill = "#DCDCDC", color = "white") 
+ theme_void() 
+ geom_point(data = df, aes(x=Long, y=Lat, size=Recovered, color=Recovered), colour = "#33FFFF", alpha = .5) 
+ scale_size_continuous(range = c(1,12), breaks = c(0, 20000, 40000, 60000))

# recovered (viridis color palette) - Doesn't make sense on a map
ggplot() 
+ geom_polygon(data = spdf_fortified, aes(x = long, y = lat, group = group), fill = "whitesmoke", color = "white") 
+ theme_void() 
+ geom_point(data = df, aes(x=Long, y=Lat, size=Recovered, color=Recovered)) 
+ scale_size_continuous(range = c(1,12)) 
+ scale_color_viridis_c(trans = "log")

#### Basic Bar Plot #####

total_country <- df 
%>% group_by(id) 
%>% summarize(Confirmed = sum(Confirmed), Deaths = sum(Deaths), Recovered = sum(Recovered))

# scale issues (China), cummulative
ggplot(total_country, aes(x=reorder(id, Confirmed), y=Confirmed)) 
+ geom_bar(stat = "identity") 
+ coord_flip()


##### ------ Calculating Rate Doubling in Days ------- ######


# first, change Date format in df from character to date format
df$Date <- as.Date(df$Date, format = "%m/%d/%y")

# select only columns of interest
# NOTE: multiple rows per date is problematic (ie country may have many provinces)
rate_df <- df %>% select(id, Date, Confirmed, Deaths, Recovered)


# shape data so one date per observation (row) 
# zoom out from province to country level
rate_double <- rate_df %>%
+ group_by(id, Date) %>%
+ summarize(Confirmed = sum(Confirmed), Deaths = sum(Deaths), Recovered = sum(Recovered))

# Our World in Data calculates growth
# which countries have at least 20 cases (n = 40 countries)

# Australia, Austria, Bahrain, Belgium, Canada, China, Czech Republic, Denmark, Egypt, 
# Finland, France, Germany, Greece, Hong Kong, Iceland, India, Iran, Iraq, Israel
# Italy, Japan, S. Korea,  Kuwait, Lebanon, Malaysia, Netherlands, Norway, Palestine
# Portugal, San Marino, Singapore, Spain, Sweden, Switzerland, Taiwan, Thailand, 
# United Arab Emirates, United Kingdom, United States and Viet Nam
View(rate_double %>% filter(Confirmed > 20) %>% summarise(n_distinct(id)))

# How many days till it doubled (from 20 -> ~ 40)?

# Australia (12), Austria (3), Bahrain (5), Belgium (2), Canada (5), China (3), Czech Republic (1, 19->31), Denmark (3, 10 -> 23), Egypt (3, 15->49), 
# Finland (4, 12->23), France (3), Germany (3), Greece (3), Hong Kong (7), Iceland (3), India (3, 5->28), Iran (2), Iraq (5), Israel (3)
# Italy (2), Japan (3), S. Korea (15),  Kuwait (6), Lebanon (-), Malaysia (19), Netherlands (2), Norway (2), Palestine (-)
# Portugal (2, 13->30), San Marino, Singapore (6), Spain (3), Sweden (3), Switzerland (3), Taiwan (18), Thailand (33), 
# United Arab Emirates (8), United Kingdom (4), United States (9) and Viet Nam (-)
View(rate_double %>% filter(Confirmed > 20))

# How many many times did it double (20 -> 40 -> 80 is two times)

# Australia (1), Austria (2), Bahrain (2), Belgium (2), Canada (1), China (6), Czech Republic, Denmark, Egypt, 
# Finland, France (4), Germany (4), Greece, Hong Kong (2), Iceland (1), India, Iran (7), Iraq (1), Israel (1)
# Italy (6), Japan (4), S. Korea (8),  Kuwait (1), Lebanon, Malaysia (3), Netherlands (3), Norway (2), Palestine
# Portugal, San Marino, Singapore (2), Spain (3), Sweden (3), Switzerland (3), Taiwan (1), Thailand (1), 
# United Arab Emirates (1), United Kingdom (2), United States (3) and Viet Nam
View(rate_double %>% filter(Confirmed > 20))

# time it took for number of confirmed cases to double
# e.g., Confirmed cases have doubled in teh last 4 days 

# Visualizing how exponential growth happens within any country, basic bar chart (use date as x-axis)
# Italy
rate_double %>%
+ filter(id=="Italy") %>%
+ ggplot(aes(x=Date, y=Confirmed)) + geom_bar(stat = "identity")

# Japan
rate_double %>% 
filter(id=="Japan") %>% 
ggplot(aes(x=Date, y=Confirmed)) + geom_bar(stat = "identity")

# Korea
rate_double %>% 
filter(id=="Korea, Republic of") %>% 
ggplot(aes(x=Date, y=Confirmed)) + geom_bar(stat = "identity")

# Spain
rate_double %>% filter(id=="Spain") %>% ggplot(aes(x=Date, y=Confirmed)) + geom_bar(stat = "identity")

# Sweden
rate_double %>% filter(id=="Sweden") %>% ggplot(aes(x=Date, y=Confirmed)) + geom_bar(stat = "identity")


#### ----- Stacked Bar Chart (Confirmed, Deaths, Recovered) ----- #####
# Note: only countries with at least 20 cases and growing exponentially

# Tidy Gather first
rate_double_stack <- rate_double %>%
+ gather(`Confirmed`, `Deaths`, `Recovered`, key = "Status", value = "People")

# Italy - stacked
Italy <- rate_double_stack %>% 
filter(id=="Italy") %>% 
ggplot(aes(x=Date, y=People, fill = Status)) 
+ geom_bar(position = "stack", stat = "identity") 
+ theme_classic() 
+ scale_fill_manual(values = c("#f03b20", "black", "#fecc5c")) 
+ labs(title = "COVID-19 Growth: Italy", subtitle = "Jan 22 - Mar 08")

# China - stacked
China <- rate_double_stack %>% 
filter(id=="China") %>% 
ggplot(aes(x=Date, y=People, fill = Status)) 
+ geom_bar(position = "stack", stat = "identity") 
+ theme_classic() 
+ scale_fill_manual(values = c("#f03b20", "black", "#fecc5c")) 
+ labs(title = "COVID-19 Growth: China", subtitle = "Jan 22 - Mar 08")


# Thailand - stacked
Thailand <- rate_double_stack %>% 
filter(id=="Thailand") %>% 
ggplot(aes(x=Date, y=People, fill = Status)) 
+ geom_bar(position = "stack", stat = "identity") 
+ theme_classic() 
+ scale_fill_manual(values = c("#f03b20", "black", "#fecc5c")) 
+ labs(title = "COVID-19 Growth: Thailand", subtitle = "Jan 22 - Mar 08")


# Germany - stacked 
Germany <- rate_double_stack %>% 
filter(id=="Germany") %>% 
ggplot(aes(x=Date, y=People, fill = Status)) 
+ geom_bar(position = "stack", stat = "identity") 
+ theme_classic() 
+ scale_fill_manual(values = c("#f03b20", "black", "#fecc5c")) 
+ labs(title = "COVID-19 Growth: Germany", subtitle = "Jan 22 - Mar 08")


# S.Korea - stacked
South_Korea <- rate_double_stack %>% 
filter(id=="Korea, Republic of") %>% 
ggplot(aes(x=Date, y=People, fill = Status)) 
+ geom_bar(position = "stack", stat = "identity") 
+ theme_classic() 
+ scale_fill_manual(values = c("#f03b20", "black", "#fecc5c")) 
+ labs(title = "COVID-19 Growth: South Korea", subtitle = "Jan 22 - Mar 08")

# Taiwan - stacked
rate_double_stack %>% filter(id=="Taiwan") %>% ggplot(aes(x=Date, y=People, fill = Status)) + geom_bar(position = "stack", stat = "identity")

# Japan - stacked
Japan <- rate_double_stack %>% 
filter(id=="Japan") %>% 
ggplot(aes(x=Date, y=People, fill = Status)) 
+ geom_bar(position = "stack", stat = "identity") 
+ theme_classic() 
+ scale_fill_manual(values = c("#f03b20", "black", "#fecc5c")) 
+ labs(title = "COVID-19 Growth: Japan", subtitle = "Jan 22 - Mar 08")

# France - stacked
France <- rate_double_stack %>% 
filter(id=="France") %>% 
ggplot(aes(x=Date, y=People, fill = Status)) 
+ geom_bar(position = "stack", stat = "identity") 
+ theme_classic() 
+ scale_fill_manual(values = c("#f03b20", "black", "#fecc5c")) 
+ labs(title = "COVID-19 Growth: France", subtitle = "Jan 22 - Mar 08")

# United States
United_States <- rate_double_stack %>% 
filter(id=="United States") %>% 
ggplot(aes(x=Date, y=People, fill = Status)) 
+ geom_bar(position = "stack", stat = "identity") 
+ theme_classic() 
+ scale_fill_manual(values = c("#f03b20", "black", "#fecc5c")) 
+ labs(title = "COVID-19 Growth: United States", subtitle = "Jan 22 - Mar 08")

# United Kingdom
United_Kingdom <- rate_double_stack %>% 
filter(id=="United Kingdom") %>% 
ggplot(aes(x=Date, y=People, fill = Status)) 
+ geom_bar(position = "stack", stat = "identity") 
+ theme_classic() 
+ scale_fill_manual(values = c("#f03b20", "black", "#fecc5c")) 
+ labs(title = "COVID-19 Growth: United Kingdom", subtitle = "Jan 22 - Mar 08")

# Canada
Canada <- rate_double_stack %>% 
filter(id=="Canada") %>% 
ggplot(aes(x=Date, y=People, fill = Status)) 
+ geom_bar(position = "stack", stat = "identity") 
+ theme_classic() 
+ scale_fill_manual(values = c("#f03b20", "black", "#fecc5c")) 
+ labs(title = "COVID-19 Growth: Canada", subtitle = "Jan 22 - Mar 08")



## Patchwork of Stacked Bar Charts ##
library(patchwork)

((France + Germany) / (Italy + South_Korea))




####### ------ MAP ANIMATION ------- ##########
library(gganimate)
install.packages("gifski")
install.packages("png")


mybreaks <- c(20, 40, 80, 160, 320, 640, 1280, 2560, 5120, 10240, 20480, 40960)

map_animate <- ggplot() 
+ geom_polygon(data = spdf_fortified, aes(x = long, y = lat, group = group), fill = "#DCDCDC", color = "white") 
+ theme_void() 
+ geom_point(data = df, aes(x=Long, y=Lat, size=Confirmed, color=Confirmed)) 
+ scale_size_continuous(range = c(1,12), breaks = mybreaks) 
+ scale_color_viridis_c(option = "magma", trans = "log", breaks=mybreaks) 
+ scale_alpha_continuous(range = c(0.1, .9), breaks = mybreaks, trans = "log") 
+ guides(colour = guide_legend()) 
# gganimate
+ labs(title = "Confirmed COVID-19 cases around the World", subtitle = "Date: {frame_time}") 
+ transition_time(df$Date) 
+ ease_aes("linear")

