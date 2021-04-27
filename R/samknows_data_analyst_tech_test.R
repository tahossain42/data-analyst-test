##
## Samknows Data Analyst Tech Test
##

## Please add your solution code for the following questions. Throughout, the main things being assessed are:
##   Design        e.g. variable names, having a logical flow and process
##   Data quality  e.g. paying attention to outliers, missing data etc.
##   Explanations  e.g. justifying a certain approach

## 1 - Load any relevant packages for reshaping data, joining, visualization, and handling datetimes
##

####################### PUT YOUR SOLUTION CODE TO PART 1 HERE #################################

## 2 - Data Import and Cleaning
##
##   download_speed_measurements.csv - contains the results of download speed tests for some of our volunteers
##      person_id: identifier for each person in our dataset
##      time_of_measurement: when the test was run (in UTC)
##      measured_download_speed_in_Mbps: what downstream speed was measured
##      did_test_complete_successfully: TRUE if the test completed successfully, FALSE if the test encountered a problem
##
##   upload_speed_measurements.csv - contains the results of upload speed tests for some of our volunteers
##      person_id: identifier for each person in our dataset
##      time_of_measurement: when the test was run (in UTC)
##      measured_download_speed_in_Mbps: what downstream speed was measured
##      did_test_complete_successfully: TRUE if the test completed successfully, FALSE if the test encountered a problem
##
##   details_for_each_person.csv - gives some background information on some of our volunteers:
##     person_id: identifier for each person in our dataset
##     city: the city where the person's connection is located
##     type_of_broadband_connection: either
##       * ADSL (slow; download speed < 25 Mbps, upload speed almost always < 1 Mbps)
##       * VDSL aka fibre to the cabinet (download speed generally less than 100 Mbps, upload speed generally < 20 Mbps)
##       * Fibre aka fibre to the premises (speeds can be very fast; up to 1000 Mbps)
##     name_of_isp: the name of the Internet Service Provider which the person is buying their line from (these are made up names!)
##
## a) Please import each of these files and combine them into a single table which:
##      has the structure: person_id, country, city, type_of_broadband_connection, name_of_isp, average_download_speed, average_upload_speed
##      has 1 line per person (i.e. calculate a single average download and upload speed for each person)
##      only contains people in the cities 'Samsville' and 'Databury'
##      only contains download and upload measurements which have run successfully (i.e. put a filter on did_test_complete_successfully)
##      only contains tests from the month of January 2021 (i.e. put a filter on time_of_measurement)
##
## b) Please make justifications for which people you are going to include in your final dataset and why.
##    
##    Like any dataset, this one has problems; for example:
##      There are people in different countries
##      There are people who have download data but no upload data (i.e. missing data)
##      There are people with average speeds which are either too high or too for low type_of_broadband_connection (i.e. mislabeled data)
##      There are people who have OK data overall, but some of individual tests fall outside of parameters
##    Don't address all of these problems, but in your solution, have a look into any potential data quality issues and flag them up.
##
## c) (optional)
##    An academic has made a suggestion for a way to measure download speed which is better than using the simple average. The metric
##    being proposed is:
##      Calculate the average download speed each day, and take the 60th percentile.
##      The value of this metric tells you that 'on at least 60% of days, average download speed will be at least x.'
##    Calculate this metric for each person in the dataset and add it into your table from (b)

####################### PUT YOUR SOLUTION CODE TO PART 2 HERE #################################

## 3 - Data summarization and presentation
##
## a) Now that you have a table which gives the average download and upload speed for each person, make a couple of summary tables
##    which illustrate the differences in download and upload speed between ISPs for each connection type.
##    
##    Remember that there are two ISPs (Fibrelicious and Useus) with customers in two cities (Samsville and Databury) with three
##    different types of connection (ADSL, VDSL, and Fast Fibre).
##
##    If possible, make a couple of brief comments to summarize the findings.
##
## b) Make a visualization of the distribution of average download speeds by ISP by city by connection type, which is designed so
##    that a technically-aware stakeholder can read the graph and see the differences between ISP on each package in each city.
##
##    Answer the question: If I am a consumer living in Databury and I have a VDSL/Fibre to the Cabinet connection, am I going to
##    get a better speed from Fibrelicious or from Useus? How much better?
##
## c) (optional)
##    Look at the differences in download speed by ISP at different times of the day or days of the week (for example, at what times
##    of day are download speeds highest and lowest?) - you will need to look at raw test data, not the averages calculated in (1b).

####################### PUT YOUR SOLUTION CODE TO PART 3 HERE #################################