library(tidyverse)
library(lubridate)

set.seed(6644027)

choose_offset <- function(test_frequency) {
  timestamp <- now()
  possible_offsets <- as.integer(seq.POSIXt(timestamp, timestamp + as.period(test_frequency), by = "sec") - timestamp)
  sample(possible_offsets, 1)
}

simulate_speed_test_data <- function(maximum_speed, start_date, end_date = start_date + 1, test_frequency = "1 hour", standard_deviation_pct = 0.1, peak_drop_pct = 0.1, fail_rate = 0, missing_rate = 0) {
  
  test_timestamps <- seq.POSIXt(as.POSIXlt(start_date), as.POSIXlt(end_date), by = test_frequency)
  n_tests <- length(test_timestamps)
  offset <- choose_offset(test_frequency)
  adjusted_test_timestamps <- test_timestamps + offset + rpois(n_tests, 1)
  
  tibble(time_of_measurement = adjusted_test_timestamps) %>%
    mutate(
      measured_speed_in_Mbps = pmax(0, maximum_speed * (1 - rexp(n_tests, sqrt(1 / standard_deviation_pct)))),
      did_test_complete_successfully = rbernoulli(n_tests, 1 - fail_rate)
    ) %>%
    mutate(measured_speed_in_Mbps = if_else(!did_test_complete_successfully, NA_real_, measured_speed_in_Mbps)) %>%
    mutate(measured_speed_in_Mbps = if_else(hour(time_of_measurement) %in% 18:22, measured_speed_in_Mbps * (1 - peak_drop_pct), measured_speed_in_Mbps)) %>%
    sample_frac(1 - missing_rate)
  
}

make_person_ids <- function(n) {
  sample(10000:99999, n, replace = FALSE)
}

simulation_parameters <- tribble(
  ~city, ~type_of_broadband_connection, ~name_of_isp, ~maximum_download_speed, ~maximum_upload_speed, ~standard_deviation_pct, ~fail_rate, ~missing_rate, ~peak_drop_pct, ~n_people,
  "Samsville", "ADSL", "Fibrelicious",  17, 1, 0.3, 0.4, 0.2, 0.05, 20,
  "Samsville", "ADSL", "Useus",         22, 1.05, 0.1, 0.2, 0.15, 0.3, 22,
  "Samsville", "VDSL", "Fibrelicious",  76, 20, 0.3, 0.4, 0.2, 0.2, 31,
  "Samsville", "VDSL", "Useus",         76, 20, 0.5, 0.1, 0.2, 0.1, 24,
  "Samsville", "Fibre", "Fibrelicious", 300, 100, 0.05, 0.02, 0.3, 0.05, 15,
  "Samsville", "Fibre", "Useus",        250, 100, 0.05, 0.02, 0.35, 0.05, 35,
  "Databury", "ADSL", "Fibrelicious",   17, 1.05, 0.3, 0.4, 0.2, 0.05, 21,
  "Databury", "ADSL", "Useus",          22, 1.05, 0.1, 0.2, 0.15, 0.2, 16,
  "Databury", "VDSL", "Fibrelicious",   38, 10, 0.3, 0.4, 0.2, 0.1, 27,
  "Databury", "VDSL", "Useus",          38, 10, 0.5, 0.1, 0.2, 0.1, 27,
  "Databury", "Fibre", "Fibrelicious",  300, 100, 0.05, 0.02, 0.3, 0.4, 21,
  "Databury", "Fibre", "Useus",         250, 100, 0.05, 0.02, 0.35, 0.3, 32
)

simulated_data <- simulation_parameters %>%
  mutate(list_column = map(n_people, ~1:.)) %>%
  unnest_longer(list_column) %>%
  mutate(person_id = make_person_ids(n())) %>%
  select(person_id, names(.), -c(n_people, list_column)) %>%
  mutate(
    simulated_download_tests = pmap(
      list(maximum_download_speed, standard_deviation_pct, fail_rate, missing_rate, peak_drop_pct),
      ~simulate_speed_test_data(
        ..1,
        start_date = ymd("2021-01-01"),
        end_date = ymd("2021-02-06"),
        standard_deviation_pct = ..2,
        fail_rate = ..3,
        missing_rate = ..4,
        peak_drop_pct = ..5
      )
    ),
    simulated_upload_tests = pmap(
      list(maximum_upload_speed, standard_deviation_pct, fail_rate, missing_rate, peak_drop_pct),
      ~simulate_speed_test_data(
        ..1,
        start_date = ymd("2021-01-01"),
        end_date = ymd("2021-01-31"),
        standard_deviation_pct = ..2,
        fail_rate = ..3,
        missing_rate = ..4,
        peak_drop_pct = ..5
      )
    )
  )

simulated_person_details <- simulated_data %>%
  select(person_id, city, type_of_broadband_connection, name_of_isp)

simulated_download_tests <- simulated_data %>%
  select(person_id, simulated_download_tests) %>%
  unnest_legacy(simulated_download_tests) %>%
  rename(measured_download_speed_in_Mbps = measured_speed_in_Mbps)

simulated_upload_tests <- simulated_data %>%
  select(person_id, simulated_upload_tests) %>%
  unnest_legacy(simulated_upload_tests) %>%
  rename(measured_upload_speed_in_Mbps = measured_speed_in_Mbps)

## ----------------- export

write_csv(simulated_person_details, "data/details_for_each_person.csv", na = "")
write_csv(simulated_download_tests, "data/download_speed_measurements.csv", na = "")
write_csv(simulated_upload_tests, "data/upload_speed_measurements.csv", na = "")
