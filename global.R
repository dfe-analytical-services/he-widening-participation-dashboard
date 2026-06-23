# -----------------------------------------------------------------------------
# This is the global file.
#
# This is used to store functions, library calls, source files etc.
#
# Moving these out of the server file and into here improves performance as the
# global file is run only once when the app launches and stays consistent
# across users whereas the server and UI files are constantly interacting and
# responsive to user input.
#
# Library calls ---------------------------------------------------------------

# Stop any package loading from producing a message
shhh <- suppressPackageStartupMessages

# Packages for ODBC connection to SQL
shhh(library(RODBC))
shhh(library(odbc))
shhh(library(DBI))

# Core shiny and R packages
shhh(library(shiny))
shhh(library(bslib))
shhh(library(rstudioapi))

# Custom packages
shhh(library(dfeR))
shhh(library(dfeshiny))
shhh(library(shinyGovstyle))

# Creating charts and tables
shhh(library(ggplot2))
shhh(library(DT))
shhh(library(sf))
shhh(library(leaflet))
shhh(library(htmltools))
shhh(library(reactable))
shhh(library(svglite))
shhh(library(afcharts))
shhh(library(ggrepel))
shhh(library(showtext))
shhh(library(openxlsx))
shhh(library(plotly))

# Data and string manipulation
shhh(library(dplyr))
shhh(library(stringr))
shhh(library(ggiraph))
shhh(library(tidyr))
shhh(library(janitor))

# Shiny extensions
shhh(library(shinyjs))
shhh(library(tools))
shhh(library(shinytitle))
shhh(library(xfun))
shhh(library(metathis))
shhh(library(shinyalert))

# Accessibility testing
shhh(library(shinya11y))

# Dependencies needed for testing or CI but not for the app -------------------

# Including them here keeps them in renv but avoids the app needlessly loading
# them, saving on load time.
if (FALSE) {
  shhh(library(shinytest2))
  shhh(library(chromote))
  shhh(library(testthat))
}

# Source scripts --------------------------------------------------------------

# Source any scripts that are needed to process data before being passed to the server script such as
# reading in data or setting up any functions

# Source script for loading in data
source("R/read_data.R")

# LINES 83 AND 84 MUST BE UPDATED
# databricks = TRUE for private app only, published = TRUE for public app on publication, leave read_chep_nongeog() empty when using dummy data
chep_nongeog_output <- read_chep_nongeog()
chep_geog_output <- read_chep_geog()

char_outputs <- create_characteristic_outputs(chep_nongeog_output)
los_outputs <- create_los_outputs(chep_nongeog_output)
mos_outputs <- create_mos_outputs(chep_nongeog_output)
qaim_outputs <- create_qaim_outputs(chep_nongeog_output)
geog_outputs <- create_geog_outputs(chep_geog_output)

# Characteristics
chep_characteristic_output <- char_outputs$characteristic_output
chep_characteristics_output_19 <- char_outputs$characteristic_output_19
chep_characteristics_output_25 <- char_outputs$characteristic_output_25

# Level of study
chep_los_output <- los_outputs$los_output
chep_los_output_19 <- los_outputs$los_output_19
chep_los_output_25 <- los_outputs$los_output_25

# Mode of study
chep_mos_output <- mos_outputs$mos_output
chep_mos_output_19 <- mos_outputs$mos_output_19
chep_mos_output_25 <- mos_outputs$mos_output_25

# Qualification aim
chep_qaim_output <- qaim_outputs$qaim_output
chep_qaim_output_19 <- qaim_outputs$qaim_output_19
chep_qaim_output_25 <- qaim_outputs$qaim_output_25

# Geographic breakdown
chep_geog_output <- geog_outputs$geog_output
chep_geographic_output_19 <- geog_outputs$geog_output_19
chep_geographic_output_25 <- geog_outputs$geog_output_25

# Source custom functions script
source("R/helper_functions.R")

# Source all files in the ui_panels folder
lapply(list.files("R/ui_panels/", full.names = TRUE), source)

# Set global variables --------------------------------------------------------

site_title <- "Department for Education (DfE) Widening Participation dashboard"
parent_pub_name <- "Widening participation in higher education"
parent_publication <- "https://explore-education-statistics.service.gov.uk/find-statistics/widening-participation-in-higher-education"

# Set the URLs that the site will be published to
site_primary <- "https://department-for-education.shinyapps.io/he-widening-participation-dashboard/"

# Combine URLs into list for disconnect function
# We can add further mirrors where necessary. Each one can generally handle
# about 2,500 users simultaneously
sites_list <- c(site_primary)

# Set the key for Google Analytics tracking
google_analytics_key <- "Z967JJVQQX" # We will need to get a proper google analytics key for the production dashboard, this is a placeholder from the template

# End of global variables -----------------------------------------------------

# Enable bookmarking so that input choices are shown in the url ---------------
enableBookmarking("url")

# Fonts for charts ------------------------------------------------------------
font_add("dejavu", "www/fonts/DejaVuSans.ttf")
register_font(
  "dejavu",
  plain = "www/fonts/DejaVuSans.ttf",
  bold = "www/fonts/DejaVuSans-Bold.ttf",
  italic = "www/fonts/DejaVuSans-Oblique.ttf",
  bolditalic = "www/fonts/DejaVuSans-BoldOblique.ttf"
)
showtext_auto()

# Extract lists for use in drop downs across characteristic tabs --------------

# List of characteristic groups
choices_char_tab_characteristic_group <- unique(chep_characteristic_output$characteristic_group) %>% sort()

# List of tariff groups
choices_char_tab_tariff_group <- unique(chep_characteristic_output$tariff_group)

# Extract lists for use in drop downs on geographic tabs ----------------------

# List of characteristics
choices_geog_tab_characteristic <- unique(chep_geog_output$characteristic) %>% sort()

# List of tariff groups
choices_geog_tab_tariff_group <- unique(chep_geog_output$tariff_group)

# Read in technical notes -----------------------------------------------------
wp_chep_tech_notes_csv <- read.csv("wp_chep_technical_notes.csv")
