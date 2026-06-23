# -----------------------------------------------------------------------------
# Script where we provide functions to read in the data file(s).
#
# IMPORTANT: Data files pushed to GitHub repositories are immediately public.
# You should not be pushing unpublished data to the repository prior to your
# publication date. You should use dummy data or already-published data during
# development of your dashboard.
#
# In order to help prevent unpublished data being accidentally published, the
# template will not let you make a commit if there are unidentified csv, xlsx,
# tex or pdf files contained in your repository. To make a commit, you will need
# to either add the file to .gitignore or add an entry for the file into
# datafiles_log.csv.
# -----------------------------------------------------------------------------

# Set up connection to Databricks  ------------------------------------------
con <- dbConnect(databricks(),
  httpPath = Sys.getenv("DATABRICKS_SQL_WAREHOUSE_ID"),
  catalog = "catalog_40_copper_he_widening_participation",
  useNativeQuery = FALSE
)


# Characteristics tabs  -------------------------------------------------------

# Read in the data from the output table in databricks (catalog_40_copper_he_widening_participation.chep_wp.CHEP_yyyy_dash_input_nongeog)
# Note, the code for this is in the SQL folder (CHEP dashboard data - clean copy creating databricks tables) but should be run in Databricks prior to updating the dashboard

# Lines 30 and 31 should be commented out if using mock data, line 32 should be commented out if using proper data
# chep_nongeog_db_query <- paste0("SELECT * FROM catalog_40_copper_he_widening_participation.chep_wp.CHEP_2026_dash_input_nongeog")
# chep_nongeog_output <- dbGetQuery(con, chep_nongeog_db_query)
chep_nongeog_output <- read.csv("SQL/chep_2026_dash_input_nongeog_mock.csv")
chep_nongeog_output$time_period <- as.numeric(chep_nongeog_output$time_period)
chep_nongeog_output <- chep_nongeog_output %>% arrange(time_period, characteristic_group, characteristic)

# Filter to remove high tariff breakdowns for level of study, mode of study and qualification aim and unknown/unclassified characteristics
chep_nongeog_output <- chep_nongeog_output %>%
  filter(!(tariff_group == "High tariff" & characteristic_group %in% c("Level of Study", "Mode of Study", "Qualification Aim"))) %>%
  filter(!(characteristic == "Unknown" & characteristic_group %in% c("POLAR", "Ethnic Group", "Sex"))) %>%
  filter(!(characteristic == "Unclassified" & characteristic_group == "First Language")) %>%
  mutate(time_label = paste0(substr(time_period, 1, 4), "/", substr(time_period, 5, 6)))


# filter to characteristic output for tab 1
chep_characteristic_output <- chep_nongeog_output %>% filter(!characteristic_group %in% c("Level of Study", "Mode of Study", "Qualification Aim"))

# filter the initial characteristic output into ages to include on separate tabs
chep_characteristics_output_19 <- chep_characteristic_output %>% filter(entry_age == "By Age 19")
chep_characteristics_output_25 <- chep_characteristic_output %>% filter(entry_age == "By Age 25")

# filter to level of study output for tab
chep_los_output <- chep_nongeog_output %>%
  filter(
    characteristic_group == "Level of Study"
  ) %>%
  mutate(characteristic = recode(
    characteristic,
    "9. Unknown" = "Unknown"
  ))

# filter the initial characteristic output into ages to include on separate tabs
chep_los_output_19 <- chep_los_output %>% filter(entry_age == "By Age 19")
chep_los_output_25 <- chep_los_output %>% filter(entry_age == "By Age 25")

# filter to mode of study output for tab3
chep_mos_output <- chep_nongeog_output %>% filter(
  characteristic_group == "Mode of Study"
)

# filter the initial characteristic output into ages to include on separate tabs
chep_mos_output_19 <- chep_mos_output %>% filter(entry_age == "By Age 19")
chep_mos_output_25 <- chep_mos_output %>% filter(entry_age == "By Age 25")

# filter to qualification aim output for tab4
chep_qaim_output <- chep_nongeog_output %>%
  filter(
    characteristic_group == "Qualification Aim"
  ) %>%
  mutate(characteristic = recode(
    characteristic,
    "0. Apprenticeship" = "Apprenticeship",
    "1. Postgraduate Research" = "Postgraduate Research",
    "2. Postgraduate Taught" = "Postgraduate Taught",
    "3. First Degree" = "First Degree",
    "4. Foundation Degree" = "Foundation Degree",
    "5. HNC/HND" = "HNC/HND",
    "6. Other Undergraduate Qualifications" = "Other Undergraduate Qualifications"
  ))

# filter the initial characteristic output into ages to include on separate tabs
chep_qaim_output_19 <- chep_qaim_output %>% filter(entry_age == "By Age 19")
chep_qaim_output_25 <- chep_qaim_output %>% filter(entry_age == "By Age 25")


# Geographic tab  -------------------------------------------------------------

# Read in the data from the output table in databricks (catalog_40_copper_he_widening_participation.chep_wp.CHEP_yyyy_dash_input_geog)
# Note, the code for this is in the SQL folder (CHEP dashboard data - clean copy creating databricks tables) but should be run in Databricks prior to updating the dashboard

# Lines 101 and 102 should be commented out if using mock data, line 103 should be commented out if using proper data
# chep_geog_query <- paste0("SELECT * FROM catalog_40_copper_he_widening_participation.chep_wp.CHEP_2026_dash_input_geog")
# chep_geog_output <- dbGetQuery(con, chep_geog_query)
chep_geog_output <- read.csv("SQL/chep_2026_dash_input_geog_mock.csv")
chep_geog_output$time_period <- as.numeric(chep_geog_output$time_period)
chep_geog_output <- chep_geog_output %>%
  arrange(time_period, characteristic_group, characteristic) %>%
  mutate(new_la_code = gsub("\\s+", "", new_la_code)) %>% # RESOLVES ANY WHITESPACE ISSUES
  mutate(characteristic = recode(
    characteristic,
    "All Other Pupils" = "Non-FSM",
    "Free School Meals" = "FSM"
  ))


# filter the initial geographic output into ages to include on separate tabs
chep_geographic_output_19 <- chep_geog_output %>% filter(entry_age == "By Age 19")
chep_geographic_output_25 <- chep_geog_output %>% filter(entry_age == "By Age 25")

# Read in mapshape data -------------------------------------------------------

# Local authority
read_la_data <- function(file) {
  df_la <- sf::read_sf(file) %>%
    sf::st_transform(4326)
  return(df_la)
}

# GEOJSON FILE RELATING TO 2019 from https://www.data.gov.uk/dataset/1563437b-8ae1-4a76-9f51-2ecd8cda7273/counties-and-unitary-authorities-april-2019-boundaries-ew-bgc1
df_la_geo_2019 <- read_la_data(file = "geogs/Apr_2019_Counties_Unitary_Authorities_EW_BGC.geojson") %>% clean_names()

# GEOJSON FILE RELATING TO 2011 from https://www.data.gov.uk/dataset/fe74170a-ddb2-435a-bfaf-017fd412b880/counties-and-unitary-authorities-december-2018-boundaries-ew-bgc1
df_la_geo_2018 <- read_la_data(file = "geogs/Dec_2018_Counties_Unitary_Authorities_EW_BGC.geojson") %>% clean_names()

# GEOJSON FILE RELATING TO 2011 from https://www.data.gov.uk/dataset/3f9d463b-31ea-4894-aa5d-082ea17cb14c/counties-and-unitary-authorities-december-2011-boundaries-ew-bgc1
df_la_geo_2011 <- read_la_data(file = "geogs/Dec_2011_Counties_Unitary_Authorities_EW_BGC.geojson") %>% clean_names()

# Region
read_reg_data <- function(file) {
  df_reg <- sf::read_sf(file) %>%
    sf::st_transform(4326)
  return(df_reg)
}

# GEOJSON FILE RELATING TO 2019 from https://www.data.gov.uk/dataset/ed9815d6-2a00-4c95-9c80-8abaaa145678/regions-december-2019-boundaries-en-bgc1
df_reg_geo_2019 <- read_reg_data(file = "geogs/Dec_2019_Regions_EN_BGC.geojson") %>% clean_names()
