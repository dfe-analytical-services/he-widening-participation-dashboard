# -----------------------------------------------------------------------------
# This is the ui file. It is used to call elements created in the server file
# into the app, and define where they are placed, and define any user inputs.
#
# -----------------------------------------------------------------------------
ui <- function(input, output, session) {
  bslib::page_fluid(
    # use_tota11y(),
    # Set application metadata ------------------------------------------------
    tags$head(HTML("<title>Widening Participation dashboard</title>")),
    tags$head(tags$link(rel = "shortcut icon", href = "dfefavicon.png")),
    use_shiny_title(),
    useShinyjs(),
    tags$html(lang = "en"),
    # Add meta description for search engines
    meta() %>%
      meta_general(
        application_name = "Widening Participation dashboard",
        description = "Widening Participation dashboard",
        robots = "index,follow",
        generator = "R-Shiny",
        subject = "stats development",
        rating = "General",
        referrer = "no-referrer"
      ),

    # Custom disconnect function ----------------------------------------------
    # Variables used here are set in the global.R file
    dfeshiny::custom_disconnect_message(
      links = sites_list,
      publication_name = parent_pub_name,
      publication_link = parent_publication
    ),

    # Load javascript dependencies --------------------------------------------
    shinyjs::useShinyjs(),

    # Cookies -----------------------------------------------------------------
    # Setting up cookie consent based on a cookie recording the consent:
    dfeshiny::dfe_cookies_script(),
    dfeshiny::cookies_banner_ui(
      name = "Widening Participation dashboard"
    ),

    # Skip_to_main -------------------------------------------------------------
    # Add a 'Skip to main content' link for keyboard users to bypass navigation.
    # It stays hidden unless focussed via tabbing.
    shinyGovstyle::skip_to_main(),

    # Google analytics --------------------------------------------------------
    tags$head(includeHTML(("google-analytics.html"))),

    # Custom CSS --------------------------------------------------------------
    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "dfe_shiny_gov_style.css"
      )
    ),

    # Header ------------------------------------------------------------------
    shinyGovstyle::full_width_overrides(),
    shinyGovstyle::header(
      org_name = "Department for Education",
      service_name = "Widening Participation dashboard"
    ),

    # Beta banner -------------------------------------------------------------
    shinyGovstyle::banner(
      "beta banner",
      "Beta",
      "This dashboard is in beta phase and we are still reviewing performance and reliability."
    ),

    # Nav panels --------------------------------------------------------------
    shiny::navlistPanel(
      "",
      id = "navlistPanel",
      widths = c(2, 8),
      well = FALSE,
      # Content for these panels is defined in the R/ui_panels/ folder
      user_guide_panel(),
      entry_by_19_panel(),
      entry_by_25_panel(),
      tech_notes_panel(),
      shiny::tabPanel(
        value = "a11y_panel",
        "Accessibility",
        dfeshiny::a11y_panel(
          dashboard_title = site_title,
          dashboard_url = site_primary,
          date_tested = "4th March 2026",
          date_prepared = "4th March 2026",
          date_reviewed = "4th March 2026",
          issues_contact = "explore.statistics@education.gov.uk",
          non_accessible_components = c(
            "Charts have non-accessible components for keyboard users.",
            "Regional and local authority maps have non-accessible components for keyboard users.",
            "Some decorative images are not appropriately labelled with alternative text or descriptions as of yet."
          ),
          specific_issues = c(
            "Keyboard navigation through the interactive charts is currently limited, however each chart is accompanied by a keyboard accessible table.",
            "Keyboard navigation through the interactive regional and local authortiy maps is currently limited, however each map is accompanied by a keyboard accessible and searchable table.",
            "An image in the header banner containing a link is not appropriately labelled for screen text, and is missing link text and alternative text."
          )
        )
      ),
      shiny::tabPanel(
        value = "cookies_panel_ui",
        "Cookies",
        cookies_panel_ui(google_analytics_key = google_analytics_key)
      ),
      shiny::tabPanel(
        value = "support_panel_ui",
        "Support and feedback",
        support_panel(
          team_email = "he.statistics@education.gov.uk",
          repo_name = "https://dfe-gov-uk.visualstudio.com/official-statistics-production/_git/wp_chep_dashboard",
          form_url = "https://forms.office.com/Pages/ResponsePage.aspx?id=yXfS-grGoU2187O4s0qC-U4ie_t5E21MlsudeT67Fb5UQTQyUkw3UlQyOUlaMzdUSFpRMzYwNjRGWC4u",
          publication_slug = "widening-participation-in-higher-education"
        )
      )
    ),

    # Footer ------------------------------------------------------------------
    shinyGovstyle::footer(
      full = TRUE,
      links = c(
        "Accessibility statement",
        "Use of cookies",
        "Support and feedback",
        "Privacy notice"
      )
    )
  )
}
