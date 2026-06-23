# -----------------------------------------------------------------------------
# This is the server file.
#
# It is used to create interactive elements like tables, charts and text for
# the app.
#
# These are created here but called in the UI file (and in this case, as part
# of the panels in the R folder). Filtering is based on inputs from
# selectizeInput commands in the panel scripts (which form dropdowns)
#
# -----------------------------------------------------------------------------

server <- function(input, output, session) {
  # Bookmarking ---------------------------------------------------------------
  # This section stores any input choices in the url
  setBookmarkExclude(c(
    "cookies",
    "tabBenchmark_rows_current", "tabBenchmark_rows_all",
    "tabBenchmark_columns_selected", "tabBenchmark_cell_clicked",
    "tabBenchmark_cells_selected", "tabBenchmark_search",
    "tabBenchmark_rows_selected", "tabBenchmark_row_last_clicked",
    "tabBenchmark_state",
    "plotly_relayout-A",
    "plotly_click-A", "plotly_hover-A", "plotly_afterplot-A",
    ".clientValue-default-plotlyCrosstalkOpts"
  ))

  observe({
    # Trigger this observer every time an input changes
    reactiveValuesToList(input)
    session$doBookmark()
  })

  onBookmarked(function(url) {
    updateQueryString(url)
  })


  # Cookies logic -------------------------------------------------------------
  output$cookies_status <- dfeshiny::cookies_banner_server(
    input_cookies = shiny::reactive(input$cookies),
    parent_session = session,
    google_analytics_key = google_analytics_key
  )

  dfeshiny::cookies_panel_server(
    input_cookies = shiny::reactive(input$cookies),
    google_analytics_key = google_analytics_key
  )


  # Set up characteristics datasets with timeseries data ----------------------
  # Entry by 19 - characteristics breakdown
  characteristic_reactive_timeseries_19 <- reactive({
    chep_characteristics_output_19 %>% filter(
      characteristic_group == input$selectCharTabCharacteristicGroup19,
      tariff_group == input$SelectCharTabTariffGroup19
    )
  })

  # Entry by 25 - characteristics breakdown
  characteristic_reactive_timeseries_25 <- reactive({
    chep_characteristics_output_25 %>% filter(
      characteristic_group == input$selectCharTabCharacteristicGroup25,
      tariff_group == input$SelectCharTabTariffGroup25
    )
  })


  # Set up level of study datasets with timeseries data -----------------------
  # Entry by 19 - level of study breakdown
  los_reactive_timeseries_19 <- reactive({
    chep_los_output_19
  })

  # Entry by 25 - level of study breakdown
  los_reactive_timeseries_25 <- reactive({
    chep_los_output_25
  })


  # Set up mode of study datasets with timeseries data ------------------------
  # Entry by 19 - level of study breakdown
  mos_reactive_timeseries_19 <- reactive({
    chep_mos_output_19
  })

  # Entry by 25 - level of study breakdown
  mos_reactive_timeseries_25 <- reactive({
    chep_mos_output_25
  })


  # Set up qualification aim datasets with timeseries data --------------------
  # Entry by 19 - level of study breakdown
  qaim_reactive_timeseries_19 <- reactive({
    chep_qaim_output_19
  })

  # Entry by 25 - level of study breakdown
  qaim_reactive_timeseries_25 <- reactive({
    chep_qaim_output_25
  })


  # Set up geographic datasets ------------------------------------------------
  # Entry by 19 - geographic breakdown
  geographic_reactive_19 <- reactive({
    chep_geographic_output_19 %>% filter(
      characteristic == input$selectGeogTabCharacteristicGroup19,
      tariff_group == input$SelectGeogTabTariffGroup19
    )
  })

  # Entry by 25 - geographic breakdown
  geographic_reactive_25 <- reactive({
    chep_geographic_output_25 %>% filter(
      characteristic == input$selectGeogTabCharacteristicGroup25,
      tariff_group == input$SelectGeogTabTariffGroup25
    )
  })


  # Set up footnotes reactive to the characteristics selected -----------------
  # Footnotes for by 19 tab
  footnotes_reactive_19 <- reactive({
    wp_chep_tech_notes_csv %>% filter(
      Breakdown == input$selectCharTabCharacteristicGroup19
    )
  })

  # Footnotes for by 25 tab
  footnotes_reactive_25 <- reactive({
    wp_chep_tech_notes_csv %>% filter(
      Breakdown == input$selectCharTabCharacteristicGroup25
    )
  })


  # Set up characteristics titles ---------------------------------------------
  characteristic_title(output, "characteristic_chart_title_19", reactive(input$selectCharTabCharacteristicGroup19), reactive(input$SelectCharTabTariffGroup19), 19)
  characteristic_title(output, "characteristic_chart_title_25", reactive(input$selectCharTabCharacteristicGroup25), reactive(input$SelectCharTabTariffGroup25), 25)


  # Set up characteristics charts ---------------------------------------------
  # Line chart for participation rate over time by selected characteristic
  characteristic_colors <- c(
    "Female" = "#12436D",
    "Male" = "#F46A25",
    "Free School Meals" = "#12436D",
    "Disadvantaged" = "#12436D",
    "Looked after continuously for 12 months or more" = "#12436D",
    "Children in Need" = "#12436D",
    "Care Leaver" = "#12436D",
    "All Other Pupils" = "#F46A25",
    "Q1 - Most Disadvantaged" = "#c6dbef",
    "Q2" = "#9ecae1",
    "Q3" = "#6baed6",
    "Q4" = "#3182bd",
    "Q5 - Most Advantaged" = "#08519c",
    "Asian / Asian British" = "#12436D",
    "Black / African / Caribbean / Black British" = "#F46A25",
    "Mixed / Multiple ethnic groups" = "#801650",
    "Other ethnic group" = "#2073BC",
    "White" = "#28A197",
    "SEN support / SEN without an EHC plan" = "#801650",
    "Education, health and care plan" = "#12436D",
    "No SEN provision" = "#F46A25",
    "English" = "#F46A25",
    "Other than English" = "#12436D",
    "Independent" = "#F46A25",
    "Other State" = "#12436D",
    "Selective State" = "#801650",
    "Total" = "#000000"
  )

  # Use characteristic_plot function from helper functions to create charts
  characteristic_plot(characteristic_reactive_timeseries_19, output, "characteristic_timeseries_19_plot", characteristic_colors)
  characteristic_plot(characteristic_reactive_timeseries_25, output, "characteristic_timeseries_25_plot", characteristic_colors)


  # Set up level of study charts ----------------------------------------------
  # Line chart for participation rate over time by selected characteristic
  los_colors <- c(
    "Level 8" = "#2073BC",
    "Level 7" = "#28A197",
    "Level 6" = "#12436D",
    "Level 5" = "#F46A25",
    "Level 4" = "#801650",
    "Unknown" = "#BFBFBF"
  )

  # Use characteristic_plot function from helper functions to create charts
  characteristic_bars(los_reactive_timeseries_19, output, "los_timeseries_19_plot", los_colors)
  characteristic_bars(los_reactive_timeseries_25, output, "los_timeseries_25_plot", los_colors)


  # Set up mode of study charts -----------------------------------------------
  # Line chart for participation rate over time by selected characteristic
  mos_colors <- c(
    "Full-time" = "#12436D",
    "Part-time" = "#F46A25",
    "Apprenticeship" = "#28A197"
  )

  # Use characteristic_plot function from helper functions to create charts
  characteristic_bars(mos_reactive_timeseries_19, output, "mos_timeseries_19_plot", mos_colors)
  characteristic_bars(mos_reactive_timeseries_25, output, "mos_timeseries_25_plot", mos_colors)


  # Set up qualification aim charts -------------------------------------------
  # Line chart for participation rate over time by selected characteristic
  qaim_colors <- c(
    "Apprenticeship" = "#BFBFBF",
    "Postgraduate Research" = "#2073BC",
    "Postgraduate Taught" = "#6BACE6",
    "First Degree" = "#12436D",
    "Foundation Degree" = "#F46A25",
    "HNC/HND" = "#801650",
    "Other Undergraduate Qualifications" = "#28A197"
  )

  # Use characteristic_plot function from helper functions to create charts
  characteristic_bars(qaim_reactive_timeseries_19, output, "qaim_timeseries_19_plot", qaim_colors)
  characteristic_bars(qaim_reactive_timeseries_25, output, "qaim_timeseries_25_plot", qaim_colors)


  # Set up characteristics tables ---------------------------------------------
  characteristic_table(characteristic_reactive_timeseries_19, output, "characteristic_timeseries_19_table")
  characteristic_table(characteristic_reactive_timeseries_25, output, "characteristic_timeseries_25_table")


  # Set up level of study tables ----------------------------------------------
  characteristic_table(los_reactive_timeseries_19, output, "los_timeseries_19_table")
  characteristic_table(los_reactive_timeseries_25, output, "los_timeseries_25_table")


  # Set up mode of study tables -----------------------------------------------
  characteristic_table(mos_reactive_timeseries_19, output, "mos_timeseries_19_table")
  characteristic_table(mos_reactive_timeseries_25, output, "mos_timeseries_25_table")


  # Set up qualification aim tables -------------------------------------------
  characteristic_table(qaim_reactive_timeseries_19, output, "qaim_timeseries_19_table")
  characteristic_table(qaim_reactive_timeseries_25, output, "qaim_timeseries_25_table")


  # Set up geographic titles --------------------------------------------------
  geographic_title(output, "geographic_title_19", reactive(input$selectGeogTabCharacteristicGroup19), reactive(input$SelectGeogTabTariffGroup19), 19)
  geographic_title(output, "geographic_title_25", reactive(input$selectGeogTabCharacteristicGroup25), reactive(input$SelectGeogTabTariffGroup25), 25)


  # Set up geographic tables - region table -----------------------------------
  region_table(geographic_reactive_19, output, "region_19_table")
  region_table(geographic_reactive_25, output, "region_25_table")


  # Set up geographic tables - local authority table --------------------------
  la_table(geographic_reactive_19, output, "la_19_table")
  la_table(geographic_reactive_25, output, "la_25_table")


  # Set up geographic chart - region leaflet map ------------------------------
  regional_geographic_plot(chep_geographic_output_19, input, "selectGeogTabCharacteristicGroup19", "SelectGeogTabTariffGroup19", output, "reg_19_map", df_reg_geo_2019, "rgn19cd")
  regional_geographic_plot(chep_geographic_output_25, input, "selectGeogTabCharacteristicGroup25", "SelectGeogTabTariffGroup25", output, "reg_25_map", df_reg_geo_2019, "rgn19cd")


  # Set up geographic chart - local authority leaflet map ---------------------
  la_geographic_plot(chep_geographic_output_19, input, "selectGeogTabCharacteristicGroup19", "SelectGeogTabTariffGroup19", output, "la_19_map", df_la_geo_2019, "ctyua19cd")
  la_geographic_plot(chep_geographic_output_25, input, "selectGeogTabCharacteristicGroup25", "SelectGeogTabTariffGroup25", output, "la_25_map", df_la_geo_2018, "ctyua18cd")


  # Download the underlying data button (one required for each tab given how the interactivity works) --------------------------------------
  # Characteristics data
  download_prep(output, "download_chars_data_19", "wp_characteristics_dashboard_underlying_data.csv", chep_nongeog_output)
  download_prep(output, "download_chars_data_25", "wp_characteristics_dashboard_underlying_data.csv", chep_nongeog_output)

  # Level of study data - same as characteristics data
  download_prep(output, "download_los_data_19", "wp_characteristics_dashboard_underlying_data.csv", chep_nongeog_output)
  download_prep(output, "download_los_data_25", "wp_characteristics_dashboard_underlying_data.csv", chep_nongeog_output)

  # Mode of study data - same as characteristics data
  download_prep(output, "download_mos_data_19", "wp_characteristics_dashboard_underlying_data.csv", chep_nongeog_output)
  download_prep(output, "download_mos_data_25", "wp_characteristics_dashboard_underlying_data.csv", chep_nongeog_output)

  # Qualification aim data - same as characteristics data
  download_prep(output, "download_qaim_data_19", "wp_characteristics_dashboard_underlying_data.csv", chep_nongeog_output)
  download_prep(output, "download_qaim_data_25", "wp_characteristics_dashboard_underlying_data.csv", chep_nongeog_output)

  # Geography data
  download_prep(output, "download_geog_data_19", "wp_geography_dashboard_underlying_data.csv", chep_geog_output)
  download_prep(output, "download_geog_data_25", "wp_geography_dashboard_underlying_data.csv", chep_geog_output)


  # Set up notes table --------------------------------------------------------
  output$wp_chep_tech_notes <- renderReactable({
    reactable(
      wp_chep_tech_notes_csv,
      defaultPageSize = 5,
      searchable = TRUE,
      filterable = FALSE,
      columns = list(
        Breakdown = colDef(minWidth = 200),
        Values = colDef(minWidth = 200),
        Notes = colDef(
          html = TRUE,
          minWidth = 400
        ),
        Description = colDef(
          html = TRUE,
          minWidth = 400
        )
      )
    )
  })

  # Render footnote text depending on selections ------------------------------
  # Entry by 19
  output$footnotes19 <- renderUI({
    df <- footnotes_reactive_19()

    if (nrow(df) == 0) {
      return(NULL)
    }

    if (all(is.na(df$Notes) | trimws(df$Notes) == "")) {
      return(NULL)
    }

    HTML(paste0(
      "<h3>Footnotes</h3>",
      paste(footnotes_reactive_19()$Notes, collapse = "<br><br>"),
      "<br><br>"
    ))
  })

  # Entry by 25
  output$footnotes25 <- renderUI({
    df <- footnotes_reactive_25()

    if (nrow(df) == 0) {
      return(NULL)
    }

    if (all(is.na(df$Notes) | trimws(df$Notes) == "")) {
      return(NULL)
    }

    HTML(paste0(
      "<h3>Footnotes</h3>",
      paste(footnotes_reactive_25()$Notes, collapse = "<br><br>"),
      "<br><br>"
    ))
  })


  # navigation link within text -----------------------------------------------
  observeEvent(input$nav_link, {
    shiny::updateTabsetPanel(session, "navlistPanel", selected = input$nav_link)
  })

  # Link in the user guide panel to the feedback panel ------------------------
  observeEvent(input$link_to_feedback_tab, {
    updateTabsetPanel(session, "navlistPanel", selected = "support_panel_ui")
  })

  # footer links --------------------------------------------------------------
  shiny::observeEvent(input$accessibility_statement, {
    shiny::updateTabsetPanel(session, "navlistPanel", selected = "a11y_panel")
  })

  shiny::observeEvent(input$use_of_cookies, {
    shiny::updateTabsetPanel(session, "navlistPanel", selected = "cookies_panel_ui")
  })

  shiny::observeEvent(input$support_and_feedback, {
    shiny::updateTabsetPanel(session, "navlistPanel", selected = "support_panel_ui")
  })

  shiny::observeEvent(input$privacy_notice, {
    showModal(modalDialog(
      external_link("https://www.gov.uk/government/organisations/department-for-education/about/personal-information-charter", # nolint
        "Privacy notice",
        add_warning = FALSE
      ),
      easyClose = TRUE,
      footer = NULL
    ))

    # JavaScript to auto-click the link and close the modal
    shinyjs::runjs("
      setTimeout(function() {
        var link = document.querySelector('.modal a');
        if (link) {
          link.click();
          setTimeout(function() {
            $('.modal').modal('hide');
          }, 20); // Extra delay to avoid any race conditions
        }
      }, 400);
    ")
  })


  # Stop app ------------------------------------------------------------------
  session$onSessionEnded(function() {
    stopApp()
  })
}
