# technical notes panel
tech_notes_panel <- function() {
  tabPanel(
    title = "Technical notes",
    value = "technical_notes",
    gov_main_layout(
      gov_row(
        column(
          width = 12,
          id = "main_col",
          h1("Technical notes"),
        ),
        column(
          width = 12,
          p(
            "The dashboard provides data on the proportions of each cohort turning 15 in a given year
            that went on to participate in HE by age 19 or age 25. Data relates to pupils studying in English
            state-funded and special schools at age 15 (with the exception of school type which also
            looks at those studying A levels in independent schools). Drop-down menus at the top of each
            dashboard tab allow customisation of breakdowns, and descriptions of each breakdown are
            provided in the table below."
          ),
          p(
            "Full information on methodologies and further technical notes are available through",
            a(
              href = "https://explore-education-statistics.service.gov.uk/methodology/widening-participation-in-higher-education",
              target = "_blank",
              "Explore Education Statistics (opens in new tab)",
              .noWS = c("after")
            ),
            "."
          ),
          h2("Definitions and notes for breakdowns in this dashboard"),
          reactableOutput("wp_chep_tech_notes"),
        )
      )
    )
  )
}
