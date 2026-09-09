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
          heading_text("Technical notes", size = "l", level = 1),
        ),
        column(
          width = 12,
          p(
            "The dashboard provides data on the proportions of each cohort
            turning 15 in a given year that went on to participate in HE by age
            19 or age 25. Data relates to pupils studying in English
            state-funded and special schools at age 15 (with the exception of
            school type which also looks at those studying A levels in
            independent schools)."
          ),
          p(
            "Please note, where no data is presented in charts or tables, this indicates that
            there is no current record of HE participation in that category for
            the cohort of 15-year-olds."
          ),
          p(
            "It is also worth noting that cohorts of 15-year-olds in the period
            2017/18 to 2019/20 who achieved A levels between 2020/21 and 2022/23
            had higher attainment than typical years due to alternative
            processes put in place during the Covid pandemic. This led to more
            students in these cohorts being accepted to HE and in particular to
            high tariff HE."
          ),
          p(
            "Drop-down menus at the top of each dashboard tab allow
            customisation of breakdowns, and descriptions of each breakdown are
            provided in the table below."
          ),
          p(
            "Full information on methodologies and further technical notes are
            available through",
            a(
              href = "https://explore-education-statistics.service.gov.uk/methodology/widening-participation-in-higher-education",
              target = "_blank",
              "Explore Education Statistics (opens in new tab)",
              .noWS = c("after")
            ),
            "."
          ),
          heading_text(
            "Definitions and notes for breakdowns in this dashboard",
            size = "m",
            level = 2
          ),
          reactableOutput("wp_chep_tech_notes"),
        )
      )
    )
  )
}
