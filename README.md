# SamKnows Data Analyst Technical Test
Thanks for your application. Here's a short technical test before your interview.

We don't want you to spend any more than an hour on this. If you don't finish everything (especially the 'optional' parts) in time, then just send back what you have been able to do with commentary on how you would approach the remainder.

If you've stumbled across this repository and you haven't applied for a job at SamKnows:

1. Check http://samknows.com/ to see whether we have any open Data Analyst/Scientist positions.
2. Even if there aren't any jobs currently listed, do this test and send it to us anyway; we're always looking for talented and interested people.

## File Structure

* `.gitignore` and `README.md` - git/GitHub files
* `.data-analyst-test.RProj` - RStudio files; not essential unless you use RStudio
* `data/`
    * `details_for_each_person.csv` - gives some background information on some measurement devices:
        - *person_id*: identifier for each person in our dataset
        - *city*: the city where the person's connection is located
        - *type_of_broadband_connection*: either
          - ADSL (slow; download speed < 25 Mbps, upload speed almost always < 1 Mbps)
          - VDSL aka fibre to the cabinet (download speed generally less than 100 Mbps, upload speed generally < 20 Mbps)
          - Fibre aka fibre to the premises (speeds can be very fast; up to 1000 Mbps)
        - *name_of_isp*: the name of the Internet Service Provider which the person is buying their line from (these are made up names!)
    * `download_speed_measurements.csv` - contains the results of download speed tests from some measurement devices:
        - *person_id*: identifier for a measurement device
        - *time_of_measurement*: when the test was run (in UTC)
        - *measured_download_speed_in_Mbps*: what downstream speed was measured
        - *did_test_complete_successfully*: TRUE if the test completed successfully, FALSE if the test encountered a problem
    * `upload_speed_measurements.csv` - contains the results of download speed tests from some measurement devices:
        - *person_id*: identifier for a measurement device
        - *time_of_measurement*: when the test was run (in UTC)
        - *measured_upload_speed_in_Mbps*: what uptream speed was measured
        - *did_test_complete_successfully*: TRUE if the test completed successfully, FALSE if the test encountered a problem
* `R/`
    * `simulate_test_data.R` - used to generate the files in `data/`
    * `samknows_data_analyst_tech_test.R` - R script where you will put your code
* `output/` - empty folder for you to put e.g. summary tables, data visualizations, R Markdown documents into

## Instructions

Using GitHub:

1. Fork this repository (as a private repository under your GitHub account).
2. Make your changes to `R/samknows_data_analyst_tech_test.R`.
3. Have your R script write any outputs to the `output/` folder.
4. Commit and push all changes to your private repository.
5. Add `sk-gabe` and `kmetey` to your private repository.

Not using GitHub:

1. Download this respository (Code -> Download ZIP).
2. Make your changes to `R/samknows_data_analyst_tech_test.R`.
3. Have your R script write any outputs to the `output/` folder.
4. Send a zipped copy of the whole thing back to your contact person at SamKnows.

Use either the git/GitHub route or the zip/email route; whichever is faster for you.