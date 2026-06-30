user_guide_panel <- function() {
  tabPanel(
    "User guide",
    gov_main_layout(
      gov_row(
        column(
          12,
          heading_text("Widening Participation dashboard", size = "l", level = 1),
          heading_text("Introduction and context", size = "m", level = 2),
          p(
            "This dashboard accompanies the ",
            a(
              href = "https://explore-education-statistics.service.gov.uk/find-statistics/widening-participation-in-higher-education/",
              target = "_blank",
              "Widening Participation (WP) (opens in new tab)"
            ),
            "statistics release on Explore Education Statistics.",
          ),
          p(
            "This is the first release in the Department for Education’s ",
            a(
              href = "https://explore-education-statistics.service.gov.uk/find-statistics/widening-participation-in-higher-education/",
              target = "_blank",
              "WP (opens in new tab)"
            ),
            " series to incorporate statistics formerly published in the ",
            a(
              href = "https://explore-education-statistics.service.gov.uk/find-statistics/participation-measures-in-higher-education/",
              target = "_blank",
              "Participation Measures in Higher Education (CHEP) (opens in new tab)"
            ),
            " series."
          ),
          p(
            "The release presents annual statistics on widening participation in
            higher education (HE) among pupils who attended English state-funded
            and special schools, broken down by pupil and study characteristics."
          ),
          p(
            "Participation rates relate to
            pupils who were aged 15 at the start of the academic year and who
            progressed to UK Higher Education Providers and English Further
            Education Colleges."
          ),
          p(
            "This dashboard focuses on participation rates for those who went on
            to enter HE by age 19 or 25, however underlying data for entry by
            age 18, 20 and 30 (plus individual year of age) is available on",
            a(
              href = "https://explore-education-statistics.service.gov.uk/find-statistics/widening-participation-in-higher-education/",
              target = "_blank",
              "Explore Education Statistics (opens in new tab)."
            ),
            " Data in this dashboard relates to pupils studying in English
            state-funded and special schools at age 15 (with the exception of
            school type which also looks at those studying in independent
            schools)."
          ),
          heading_text("Using the dashboard", size = "m", level = 2),
          p("The dashboard is designed to be an interactive tool, updating
            charts and tables based on the inputs selected by the user to show
            breakdowns of interest. The dashboard has tabs to show HE
            participation rates relating to the ages, and tabs beneath each of
            these for themes of interest:"),
          tags$ul(
            tags$li("Pupil characteristics – includes a chart and table showing
                    participation rate in HE by the age selected, broken down by
                    options selected by the user (tariff and characteristic
                    group such as FSM or sex). Allows comparisons between the
                    individual characteristics within the group."),
            tags$li("Pupil characteristics by region and local authority –
                    includes a map and table showing participation rate in HE
                    for the most recent cohort by the age selected, broken down
                    by user-selected options (tariff and FSM). Tabs allow switching
                    between region and local authority breakdowns."),
            tags$li("Level of study – includes a chart and table showing
                    participation rate in HE by the age selected, broken down by
                    level of study."),
            tags$li("Qualification aim – includes a chart and table showing
                    participation rate in HE by the age selected, broken down by
                    qualification aim."),
            tags$li("Mode of study – includes a chart and table showing
                    participation rate in HE by the age selected, broken down by
                    mode of study.")
          ),
          p("Where no data is presented, this indicates that there is no current
            record of HE participation in that category for the cohort of
            15-year-olds."),
          p("Tables throughout the dashboard can be sorted by clicking on the
            column headings. Hovering above charts will display labels, and you
            can zoom into sections of charts by clicking and dragging over an
            area of interest. It is also possible to focus on one or several
            series presented in the chart by clicking the series in the legend."),
          heading_text("Guidance sources", size = "m", level = 2),
          p(
            "Technical notes and definitions are available in the ",
            actionLink("link_to_tech_notes_tab", "technical notes"),
            " tab and full details of the methodology are available on ",
            a(
              href = "https://explore-education-statistics.service.gov.uk/methodology/widening-participation-in-higher-education",
              target = "_blank",
              "Explore Education Statistics (opens in new tab)."
            ),
            "If you have questions about the dashboard or data within it, please
            contact us at",
            a(
              href = "mailto:he.statistics@education.gov.uk",
              "he.statistics@education.gov.uk."
            )
          ),
          heading_text("Feedback", size = "m", level = 2),
          p(
            "This is the first iteration of the dashboard and we invite users to
            provide feedback to shape further development for future iterations.
            Further information on how to provide feedback and raise issues can
            be found at ",
            actionLink("link_to_feedback_tab", "Support and feedback.")
          )
        )
      )
    )
  )
}
