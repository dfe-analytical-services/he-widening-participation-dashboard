entry_by_19_panel <- function() {
  tabPanel(
    "HE participation by age 19",
    gov_main_layout(
      gov_row(
        column(
          width = 12,
          id = "main_col",
          heading_text("Widening Participation dashboard", size = "l", level = 1),
        ),
        # Tabset for individual tabs ------------------------------------------
        column(
          width = 12,
          tabsetPanel(
            id = "tabset_19",
            # Characteristics tab ---------------------------------------------
            tabPanel(
              title = "Pupil characteristics",
              value = "char",
              div(
                class = "well",
                layout_column_wrap(
                  p("This panel shows the proportion of each cohort turning 15 in a given year
                    that went on to participate in HE by age 19. Use the dropdowns below to select the
                    desired characteristic and tariff group breakdowns, and the download button
                    for a csv of the underlying data.")
                ),
                layout_column_wrap(
                  height = "auto",
                  width = 0.5,
                  fill = FALSE,
                  selectizeInput(
                    "selectCharTabCharacteristicGroup19",
                    "Select a characteristic group:",
                    choices = choices_char_tab_characteristic_group,
                    selected = "Total",
                    multiple = FALSE
                  ),
                  selectizeInput(
                    "SelectCharTabTariffGroup19",
                    "Select a tariff group:",
                    choices = choices_char_tab_tariff_group,
                    selected = "Total",
                    multiple = FALSE
                  )
                ),
                layout_column_wrap(
                  height = "auto",
                  width = 1,
                  shinyGovstyle::download_button(
                    "download_chars_data_19",
                    "Download underlying characteristics data",
                    file_size = "0.6 MB"
                  )
                )
              ),
              uiOutput("characteristic_chart_title_19"),
              bslib::layout_columns(
                div(
                  style = "display: flex; flex-direction: column; gap: 1rem;",
                  plotlyOutput("characteristic_timeseries_19_plot", height = "750px")
                )
              ),
              uiOutput("footnotes19"),
              details(
                inputId = "char_ts_19_tbl",
                label = "View chart as table",
                help_text = (
                  HTML(paste0(
                    reactableOutput("characteristic_timeseries_19_table")
                  ))
                )
              )
            ),
            # Geographic tab --------------------------------------------------
            tabPanel(
              title = "Pupil characteristics by region and local authority",
              value = "geo",
              div(
                class = "well",
                layout_column_wrap(
                  p("This panel shows the proportion of the most recent cohort that went on to participate in
                HE by age 19 by the most recent academic year. Figures are broken down by region
                and local authority. You can use the dropdowns below to select between FSM,
                non-FSM and all students, in addition to selecting the desired tariff group
                breakdown. Use the download button for a csv of the underlying data.")
                ),
                layout_column_wrap(
                  width = 0.5,
                  selectizeInput(
                    "selectGeogTabCharacteristicGroup19",
                    "Select a characteristic:",
                    choices = choices_geog_tab_characteristic,
                    selected = "Total",
                    multiple = FALSE
                  ),
                  selectizeInput(
                    "SelectGeogTabTariffGroup19",
                    "Select a tariff group:",
                    choices = choices_geog_tab_tariff_group,
                    selected = "Total",
                    multiple = FALSE
                  )
                ),
                layout_column_wrap(
                  width = 1,
                  shinyGovstyle::download_button(
                    "download_geog_data_19",
                    "Download underlying geographic data",
                    file_size = "0.7 MB"
                  )
                )
              ),
              uiOutput("geographic_title_19"),
              tabsetPanel(
                id = "tabset_geogs_19",
                # Region tab within geographic tab ----------------------------
                tabPanel(
                  title = "Region",
                  value = "reg",
                  bslib::layout_columns(
                    col_widths = c(6, 6),
                    gap = "1rem",
                    div(
                      reactableOutput("region_19_table", height = "750px")
                    ),
                    div(
                      leafletOutput("reg_19_map", height = "750px")
                    )
                  )
                ),
                # LA tab within geographic tab --------------------------------
                tabPanel(
                  title = "Local authority",
                  value = "la",
                  bslib::layout_columns(
                    col_widths = c(6, 6),
                    gap = "1rem",
                    div(
                      reactableOutput("la_19_table", height = "750px")
                    ),
                    div(
                      leafletOutput("la_19_map", height = "750px")
                    )
                  )
                )
              )
            ),
            # Level of study tab ----------------------------------------------
            tabPanel(
              title = "Level of study",
              value = "level",
              div(
                class = "well",
                layout_column_wrap(
                  p("This panel shows the proportion of each cohort turning 15 in a given year
                    that went on to participate in HE by age 19. Figures are broken down by the level of study.
                    Use the download button below for a csv of the underlying data.")
                ),
                layout_column_wrap(
                  width = 1,
                  shinyGovstyle::download_button(
                    "download_los_data_19",
                    "Download underlying characteristics data",
                    file_size = "0.6 MB"
                  )
                )
              ),
              heading_text("Participation rates in higher education by age 19 broken down by level of study", size = "m", level = 2),
              bslib::layout_columns(
                div(
                  style = "display: flex; flex-direction: column; gap: 1rem;",
                  plotlyOutput("los_timeseries_19_plot", height = "750px")
                )
              ),
              h3("Footnotes"),
              p("1. These figures refer to the first time a pupil participates in HE level study.
                A pupil may return to HE level study in a future academic year and participate in
                a different qualification aim, level or mode of study compared to their original
                qualification."),
              p("2. Only the years relating to the 15-year-old cohorts from 2004/05 onwards, for
                which we have complete and consistent breakdowns, have been published.
                See the methodology note for more information."),
              details(
                inputId = "los_ts_19_tbl",
                label = "View chart as table",
                help_text = (
                  HTML(paste0(
                    reactableOutput("los_timeseries_19_table")
                  ))
                )
              )
            ),
            # Qualification aim tab -------------------------------------------
            tabPanel(
              title = "Qualification aim",
              value = "qual",
              div(
                class = "well",
                layout_column_wrap(
                  p("This panel shows the proportion of each cohort turning 15 in a given year
                    that went on to participate in HE by age 19. Figures are broken down by the qualification
                    aim. Use the download button below for a csv of the underlying data.")
                ),
                layout_column_wrap(
                  width = 1,
                  shinyGovstyle::download_button(
                    "download_qaim_data_19",
                    "Download underlying characteristics data",
                    file_size = "0.6 MB"
                  )
                )
              ),
              heading_text("Participation rates in higher education by age 19 broken down by qualification aim", size = "m", level = 2),
              bslib::layout_columns(
                div(
                  style = "display: flex; flex-direction: column; gap: 1rem;",
                  plotlyOutput("qaim_timeseries_19_plot", height = "750px")
                )
              ),
              h3("Footnotes"),
              p("1. These figures refer to the first time a pupil participates in HE level study.
                A pupil may return to HE level study in a future academic year and participate in
                a different qualification aim, level or mode of study compared to their original
                qualification."),
              p("2. Figures for apprenticeships are presented separately."),
              details(
                inputId = "qaim_ts_19_tbl",
                label = "View chart as table",
                help_text = (
                  HTML(paste0(
                    reactableOutput("qaim_timeseries_19_table")
                  ))
                )
              )
            ),
            # Mode of study tab -----------------------------------------------
            tabPanel(
              title = "Mode of study",
              value = "mode",
              div(
                class = "well",
                layout_column_wrap(
                  p("This panel shows the proportion of each cohort turning 15 in a given year
                    that went on to participate in HE by age 19. Figures are broken down by the mode of study.
                    Use the download button below for a csv of the underlying data.")
                ),
                layout_column_wrap(
                  width = 1,
                  shinyGovstyle::download_button(
                    "download_mos_data_19",
                    "Download underlying characteristics data",
                    file_size = "0.6 MB"
                  )
                )
              ),
              heading_text("Participation rates in higher education by age 19 broken down by mode of study", size = "m", level = 2),
              bslib::layout_columns(
                div(
                  style = "display: flex; flex-direction: column; gap: 1rem;",
                  plotlyOutput("mos_timeseries_19_plot", height = "750px")
                )
              ),
              h3("Footnotes"),
              p("1. These figures refer to the first time a pupil participates in HE level study.
                A pupil may return to HE level study in a future academic year and participate in
                a different qualification aim, level or mode of study compared to their original
                qualification."),
              p("2. Figures for apprenticeships are presented separately."),
              details(
                inputId = "mos_ts_19_tbl",
                label = "View chart as table",
                help_text = (
                  HTML(paste0(
                    reactableOutput("mos_timeseries_19_table")
                  ))
                )
              )
            )
          )
        )
      )
    )
  )
}
