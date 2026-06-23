# -----------------------------------------------------------------------------
# This is the helper file, filled with lots of helpful functions!
#
# It is commonly used as an R script to store custom functions used through the
# app to keep the rest of the app code easier to read.
# -----------------------------------------------------------------------------

# This first section includes functions included in the template, although
# I haven't used them throughout the app (but they could be useful in future)

# Value box function ----------------------------------------------------------
# fontsize: can be small, medium or large
value_box <- function(value, subtitle, icon = NULL,
                      color = "blue", width = 4,
                      href = NULL, fontsize = "medium") {
  validate_color(color)
  if (!is.null(icon)) tagAssert(icon, type = "i")

  box_content <- div(
    class = paste0("small-box bg-", color),
    div(
      class = "inner",
      p(value, id = paste0("vboxhead-", fontsize)),
      p(subtitle, id = paste0("vboxdetail-", fontsize))
    ),
    if (!is.null(icon)) div(class = "icon-large", icon)
  )

  if (!is.null(href)) {
    box_content <- a(href = href, box_content)
  }

  div(
    class = if (!is.null(width)) paste0("col-sm-", width),
    box_content
  )
}

# Valid colours for value box -------------------------------------------------
valid_colors <- c("blue", "dark-blue", "green", "orange", "purple", "white")

# Validate that only valid colours are used -----------------------------------
validate_color <- function(color) {
  if (color %in% valid_colors) {
    return(TRUE)
  }

  stop(
    "Invalid color: ", color, ". Valid colors are: ",
    paste(valid_colors, collapse = ", "), "."
  )
}

# GSS colours -----------------------------------------------------------------
# Current GSS colours for use in charts. These are taken from the current
# guidance here:
# https://analysisfunction.civilservice.gov.uk/policy-store/data-visualisation-colours-in-charts/
# Note the advice on trying to keep to a maximum of 4 series in a single plot
# AF colours package guidance here: https://best-practice-and-impact.github.io/afcolours/
suppressMessages(
  gss_colour_pallette <- afcolours::af_colours("categorical", colour_format = "hex", n = 4)
)

#' Create a Tabset Panel with Optional Tabs
#'
#' This function generates a `tabsetPanel` containing up to three tabs: "Chart",
#' "Table", and "Download".
#' Only non-NULL inputs will result in corresponding tabs being displayed.
create_output_tabs <- function(
  id,
  chart_output,
  table_output = NULL,
  download_output = NULL
) {
  tabs <- Filter(Negate(is.null), list(
    if (!is.null(chart_output)) tabPanel("Chart", chart_output),
    if (!is.null(table_output)) {
      tabPanel(
        "Table",
        div(style = "margin-top: 20px;", table_output)
      )
    },
    if (!is.null(download_output)) {
      tabPanel(
        "Download",
        div(style = "margin-top: 40px;", download_output)
      )
    }
  ))

  do.call(tabsetPanel, c(list(id = paste0("main_tabs_", id)), tabs))
}

#' Standardise internal links -------------------------------------------------
#'
#' This function generates a link to an internal tabPanel (target_link),
#' with the link text specified in "link_text"
#' The following is required in the server.R script
#'
#'   # navigation link within text --------------------------------------------
#' observeEvent(input$nav_link, {
#'   shiny::updateTabsetPanel(session, "navlistPanel", selected = input$nav_link)
#' })
#'
#' The target location could be changed to a different UI element by
#' changing the "navlistPanel" element of the server code

in_line_nav_link <- function(link_text, target_link) {
  HTML(paste0(
    "<a href='#' onclick=\"Shiny.setInputValue('nav_link', '",
    target_link,
    "', {priority: 'event'});\">",
    link_text,
    "</a>"
  ))
}

# Expandable dropdown function-------------------------------------------------
expandable <- function(inputId, label, contents) {
  govDetails <- shiny::tags$details(
    class = "govuk-details", id = inputId,
    shiny::tags$summary(
      class = "govuk-details__summary",
      shiny::tags$span(
        class = "govuk-details__summary-text",
        label
      )
    ),
    shiny::tags$div(contents)
  )
}


# This section includes functions which I've developed specifically for
# our dashboard, in terms of charting and tabling

# Function for characteristic titles ------------------------------------------
# Reactive chart title - used for characteristic tab only
characteristic_title <- function(output, output_name, char_group_react, tariff_react, age) {
  output[[output_name]] <- renderUI({
    char_group <- char_group_react()
    tariff_grp <- tariff_react()

    tariff_txt <- if (tariff_grp == "High tariff") " high tariff" else ""

    status_groups <- c("Care Leavers", "Children in Need", "Disadvantage", "Looked After Children")
    eligibility_groups <- c("Free School Meals")
    quintile_groups <- c("POLAR")

    suffix <- if (char_group %in% status_groups) {
      " status"
    } else if (char_group %in% eligibility_groups) {
      " eligibility"
    } else if (char_group %in% quintile_groups) {
      " quintile"
    } else {
      ""
    }

    display_group <- if (char_group == "POLAR") char_group else tolower(char_group)

    breakdown_txt <- if (tolower(char_group) != "total") {
      paste0(" broken down by ", display_group, suffix)
    } else {
      ""
    }

    HTML(
      paste0(
        "<h2>Participation rates in", tariff_txt,
        " higher education by age ", age,
        breakdown_txt,
        "</h2>"
      )
    )
  })
}

# Function for characteristic charts ------------------------------------------
# Line chart - used for tabs based on school census derived characteristics
characteristic_plot <- function(reactive_input, output, output_name, colors_list) {
  output[[output_name]] <- renderPlotly({
    df <- reactive_input()

    # Convert time to character if needed
    df$time_period <- as.character(df$time_period)

    df_ordered <- df %>%
      group_by(characteristic) %>%
      summarise(latest_value = entry_rate[time_period == max(time_period)]) %>%
      arrange(desc(latest_value))

    ordered_levels <- df_ordered$characteristic

    df <- df %>%
      mutate(characteristic = factor(characteristic, levels = ordered_levels))

    p <- plot_ly(
      df,
      x = ~time_period,
      y = ~entry_rate,
      type = "scatter",
      color = ~characteristic,
      colors = colors_list,
      hovertemplate = "%{y:.1f}%",
      mode = "lines+markers"
    ) %>%
      layout(
        xaxis = list(title = "Year aged 15", zeroline = TRUE, tickmode = "array", tickvals = df$time_period, ticktext = df$time_label),
        yaxis = list(title = "Participation rate (%)", zeroline = TRUE, rangemode = "tozero"),
        hovermode = "x unified",
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.3
        ),
        margin = list(t = 80),
        font = t
      )

    p
  })
}

# Bar chart - used for tabs based on HESA derived characteristics
characteristic_bars <- function(reactive_input, output, output_name, colors_list) {
  output[[output_name]] <- renderPlotly({
    df <- reactive_input() %>%
      group_by(time_period) %>%
      arrange(desc(entry_rate), .by_group = TRUE) %>%
      mutate(characteristic = factor(characteristic, levels = unique(characteristic)))

    df$time_period <- as.character(df$time_period)

    p <- plot_ly(
      df,
      x = ~time_period,
      y = ~entry_rate,
      type = "bar",
      color = ~characteristic,
      colors = colors_list,
      hovertemplate = "%{y:.1f}%"
    ) %>%
      layout(
        barmode = "stack",
        xaxis = list(title = "Year aged 15", zeroline = TRUE, tickmode = "array", tickvals = df$time_period, ticktext = df$time_label),
        yaxis = list(title = "Participation rate (%)", zeroline = TRUE, rangemode = "tozero"),
        hovermode = "x unified",
        legend = list(orientation = "h", x = 0.5, xanchor = "center", y = -0.3),
        margin = list(t = 80),
        font = t
      )

    p
  })
}

# Function for characteristic tables ------------------------------------------
# Used for tabs based on school census and HESA derived characteristics
characteristic_table <- function(reactive_input, output, output_name) {
  output[[output_name]] <- renderReactable({
    df <- reactive_input() %>%
      rename(`Year aged 15` = time_label) %>%
      select(`Year aged 15`, characteristic, entry_rate) %>%
      mutate(entry_rate = round(entry_rate, digits = 1)) %>%
      pivot_wider(names_from = characteristic, values_from = entry_rate) %>%
      arrange(desc(`Year aged 15`))

    num_cols <- names(df)[sapply(df, is.numeric)]
    num_cols <- setdiff(num_cols, "Year aged 15")

    dynamic_cols <- setNames(
      lapply(num_cols, function(col) {
        colDef(format = colFormat(digits = 1))
      }),
      num_cols
    )

    reactable(
      df,
      defaultPageSize = 20,
      searchable = FALSE,
      filterable = FALSE,
      columns = dynamic_cols,
      defaultColDef = colDef(
        headerClass = "wrap-header bar-sort-header",
        style = JS("
          function(rowInfo, column, state) {
            let style = { textAlign: 'left' };

            for (let i = 0; i < state.sorted.length; i++) {
              if (state.sorted[i].id === column.id) {
                style.background = 'rgba(0, 0, 0, 0.03)';
              }
            }

            return style;
          }
        ")
      )
    )
  })
}

# Function for geographic tab titles ------------------------------------------
# Reactive chart title - used for geographic tab only
geographic_title <- function(output, output_name, char_react, tariff_react, age) {
  output[[output_name]] <- renderUI({
    char <- char_react()
    tariff_grp <- tariff_react()

    char_txt <- if (char == "Non-FSM") "non-FSM" else char
    tariff_txt <- if (tariff_grp == "High tariff") " high tariff" else ""

    breakdown_txt <- if (tolower(char) != "total") {
      paste0(" for ", char_txt, " eligible pupils")
    } else {
      ""
    }

    HTML(
      paste0(
        "<h2>Participation rates in", tariff_txt,
        " higher education by age ", age,
        breakdown_txt,
        "</h2>"
      )
    )
  })
}

# Function for geographic tables ----------------------------------------------
# Used for tabs based on region
region_table <- function(reactive_input, output, output_name) {
  output[[output_name]] <- renderReactable({
    region_order <- c(
      "North East",
      "North West",
      "Yorkshire and The Humber",
      "East Midlands",
      "West Midlands",
      "East of England",
      "London",
      "South East",
      "South West"
    )

    df <- reactive_input() %>%
      filter(geographic_level != "Local authority") %>%
      mutate(region_name = factor(region_name, levels = region_order)) %>%
      arrange(region_name) %>%
      select(geographic_level, region_name, entry_rate) %>%
      mutate(entry_rate = round(entry_rate, 1)) %>%
      rename(
        `Participation rate (%)` = entry_rate,
        `Region name` = region_name,
        `Geographic level` = geographic_level
      )

    reactable(
      df,
      defaultPageSize = 15,
      searchable = TRUE,
      filterable = FALSE,
      columns = list(
        `Participation rate (%)` = colDef(format = colFormat(digits = 1))
      ),
      defaultColDef = colDef(
        headerClass = "wrap-header bar-sort-header",
        style = JS("
          function(rowInfo, column, state) {
            let style = { textAlign: 'left' };

            for (let i = 0; i < state.sorted.length; i++) {
              if (state.sorted[i].id === column.id) {
                style.background = 'rgba(0, 0, 0, 0.03)';
              }
            }

            return style;
          }
        ")
      )
    )
  })
}

# Used for tabs based on region
la_table <- function(reactive_input, output, output_name) {
  output[[output_name]] <- renderReactable({
    region_order <- c(
      "North East",
      "North West",
      "Yorkshire and The Humber",
      "East Midlands",
      "West Midlands",
      "East of England",
      "London",
      "South East",
      "South West"
    )

    df <- reactive_input() %>%
      filter(geographic_level == "Local authority") %>%
      mutate(region_name = factor(region_name, levels = region_order)) %>%
      arrange(region_name, la_name) %>%
      select(region_name, la_name, entry_rate) %>%
      mutate(entry_rate = round(entry_rate, 1)) %>%
      rename(
        `Participation rate (%)` = entry_rate,
        `Region name` = region_name,
        `Local authority name` = la_name
      )

    reactable(
      df,
      defaultPageSize = 15,
      searchable = TRUE,
      filterable = FALSE,
      columns = list(
        `Participation rate (%)` = colDef(format = colFormat(digits = 1))
      ),
      defaultColDef = colDef(
        headerClass = "wrap-header bar-sort-header",
        style = JS("
          function(rowInfo, column, state) {
            let style = { textAlign: 'left' };

            for (let i = 0; i < state.sorted.length; i++) {
              if (state.sorted[i].id === column.id) {
                style.background = 'rgba(0, 0, 0, 0.03)';
              }
            }

            return style;
          }
        ")
      )
    )
  })
}

# Function for geographic region leaflet maps ---------------------------------
# Used for tabs based on region
ees_blues <- c(
  "#D0D9E2",
  "#A0B4C5",
  "#718EA7",
  "#41698A",
  "#12436D"
)

regional_geographic_plot <- function(initial_input, input, characteristic_filter, tariff_filter, output, output_name, geo_json_file, reg_code_column) {
  reg_code_sym <- rlang::sym(reg_code_column)

  joined_mapdata <- geo_json_file %>%
    dplyr::select(!!reg_code_sym, geometry) %>%
    inner_join(initial_input, by = setNames("region_code", reg_code_column)) %>%
    rowwise() %>%
    mutate(
      lab = HTML(sprintf(
        "<div style='font-size:12px; line-height:1.3;'>
        <b>%s</b><br/>
        Participation rate<br/>
        %.1f%%
        </div>",
        region_name,
        entry_rate
      ))
    )

  reg_reactive_map_dataset <- reactive({
    joined_mapdata %>%
      dplyr::filter(
        characteristic == input[[characteristic_filter]],
        tariff_group == input[[tariff_filter]],
        geographic_level == "Regional"
      ) %>%
      dplyr::select(
        region_name,
        entry_rate,
        geometry,
        lab
      )
  })

  reg_reactive_map_pal <- reactive({
    quantile_num <- 5
    probs <- seq(0, 1, length.out = quantile_num + 1)
    bins <- quantile(reg_reactive_map_dataset()$entry_rate, probs, na.rm = TRUE, names = FALSE)
    bins <- unique(bins)

    pal <- colorBin(ees_blues, bins = bins)

    return(pal)
  })

  reg_reactive_map_labels <- reactive({
    quantile_num <- 5
    probs <- seq(0, 1, length.out = quantile_num + 1)
    bins <- quantile(reg_reactive_map_dataset()$entry_rate, probs, na.rm = TRUE, names = FALSE)
    bins <- unique(bins)

    pal <- colorBin(ees_blues, bins = bins)

    bins_dset <- as.data.frame(bins) %>%
      mutate(lower_lim = lag(bins, 1)) %>%
      dplyr::filter(!is.na(lower_lim)) %>%
      mutate(label = sprintf("%.1f - %.1f", lower_lim, bins)) %>%
      rowwise() %>%
      mutate(colour = pal(lower_lim))

    return(bins_dset)
  })

  reg_reactive_map_to_display <- reactive({
    leaflet(reg_reactive_map_dataset()) %>%
      addProviderTiles(providers$CartoDB.PositronNoLabels) %>%
      setView(lng = -3.95, lat = 53, zoom = 5.5) %>%
      addPolygons(
        color = "black",
        fillColor = ~ reg_reactive_map_pal()(entry_rate),
        fillOpacity = 0.75,
        stroke = TRUE,
        weight = 0.4,
        opacity = 1.0,
        label = ~lab
      ) %>%
      addLegend(
        colors = paste0(
          reg_reactive_map_labels()$colour,
          "; width: 15px; height: 15px; border:1px solid black; border-radius: square"
        ),
        labels = paste0(reg_reactive_map_labels()$label),
        title = "Participation rate (%)",
        opacity = 1
      )
  })


  # Map rendering
  output[[output_name]] <- renderLeaflet({
    reg_reactive_map_to_display()
  })
}

# Function for geographic local authority leaflet maps ------------------------
# Used for tabs based on LA (IF USING OLD GEOJSON FILE)
la_geographic_plot <- function(initial_input, input, characteristic_filter, tariff_filter, output, output_name, geo_json_file, la_code_column) {
  la_code_sym <- rlang::sym(la_code_column)

  joined_mapdata <- geo_json_file %>%
    dplyr::select(!!la_code_sym, geometry) %>%
    inner_join(initial_input, by = setNames("new_la_code", la_code_column)) %>%
    rowwise() %>%
    mutate(
      lab = HTML(sprintf(
        "<div style='font-size:12px; line-height:1.3;'>
        <b>%s</b><br/>
        Participation rate<br/>
        %.1f%%
        </div>",
        la_name,
        entry_rate
      ))
    )

  la_reactive_map_dataset <- reactive({
    joined_mapdata %>%
      dplyr::filter(
        characteristic == input[[characteristic_filter]],
        tariff_group == input[[tariff_filter]],
        geographic_level == "Local authority"
      ) %>%
      dplyr::select(
        la_name,
        entry_rate,
        geometry,
        lab
      )
  })

  la_reactive_map_pal <- reactive({
    quantile_num <- 5
    probs <- seq(0, 1, length.out = quantile_num + 1)
    bins <- quantile(la_reactive_map_dataset()$entry_rate, probs, na.rm = TRUE, names = FALSE)
    bins <- unique(bins)

    pal <- colorBin(ees_blues, bins = bins)

    return(pal)
  })

  la_reactive_map_labels <- reactive({
    quantile_num <- 5
    probs <- seq(0, 1, length.out = quantile_num + 1)
    bins <- quantile(la_reactive_map_dataset()$entry_rate, probs, na.rm = TRUE, names = FALSE)
    bins <- unique(bins)

    pal <- colorBin(ees_blues, bins = bins)

    bins_dset <- as.data.frame(bins) %>%
      mutate(lower_lim = lag(bins, 1)) %>%
      dplyr::filter(!is.na(lower_lim)) %>%
      mutate(label = sprintf("%.1f - %.1f", lower_lim, bins)) %>%
      rowwise() %>%
      mutate(colour = pal(lower_lim))

    return(bins_dset)
  })

  la_reactive_map_to_display <- reactive({
    leaflet(la_reactive_map_dataset()) %>%
      addProviderTiles(providers$CartoDB.PositronNoLabels) %>%
      setView(lng = -3.95, lat = 53, zoom = 5.5) %>%
      addPolygons(
        color = "black",
        fillColor = ~ la_reactive_map_pal()(entry_rate),
        fillOpacity = 0.75,
        stroke = TRUE,
        weight = 0.4,
        opacity = 1.0,
        label = ~lab
      ) %>%
      addLegend(
        colors = paste0(
          la_reactive_map_labels()$colour,
          "; width: 15px; height: 15px; border:1px solid black; border-radius: square"
        ),
        labels = paste0(la_reactive_map_labels()$label),
        title = "Participation rate (%)",
        opacity = 1
      )
  })


  # Map rendering
  output[[output_name]] <- renderLeaflet({
    la_reactive_map_to_display()
  })
}

# Function for download csv prep ----------------------------------------------
download_prep <- function(output, output_name, csv_filename, download_df) {
  output[[output_name]] <- downloadHandler(
    filename = csv_filename,
    content = function(file) {
      write.csv(download_df, file, row.names = FALSE)
    }
  )
}
