rm(list=ls())
library("choroplethr")
library("choroplethrMaps")

#the input file must have two columns called "region" and "value". 
#the columns are comma-separated. 
#the region id comes from the file "county_names.csv", this can be used to get the county id from it's name and state
data=read.table("values_by_count_data.csv",header=TRUE,sep=',')


#plot for the full country 
p1=county_choropleth(data,
                  num_colors=1,
                  title  = "US 2012 County Population Estimates", 
                  legend = "Population")
print(p1)

#overlay on a google map -- need to exclude Hawaii and Alaska 
p2=county_choropleth(data,
                    num_colors=1,
                    title  = "US 2012 County Population Estimates", 
                    legend = "Population",
                    state_zoom=c("california"),
                    reference_map=TRUE)
print(p2)

#experiment with colors -- this splits the data into 9 quantiles
p3=county_choropleth(data,
                     num_colors=9,
                     title  = "US 2012 County Population Estimates", 
                     legend = "Population")
print(p3)


#focus on specifici counties only
# show the population of the 5 counties (boroughs) that make up New York City
library(dplyr)
nyc_county_names = c("kings", "bronx", "new york", "queens", "richmond")
nyc_county_fips = county.regions %>%
  filter(state.name == "new york" & county.name %in% nyc_county_names) %>%
  select(region)
p4=county_choropleth(data, 
                  title        = "Population of Counties in New York City",
                  legend       = "Population",
                  num_colors   = 1,
                  county_zoom = nyc_county_fips$region)
print(p4)
