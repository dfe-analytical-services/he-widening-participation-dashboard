user_guide_panel <- function() {
  tabPanel(
    "User guide",
    gov_main_layout(
      gov_row(
        column(
          12,
          h1("Widening Participation dashboard"),
          h2("Introduction and context"),
          p(
            "This dashboard accompanies the ",
            a(
              href = "https://explore-education-statistics.service.gov.uk/find-statistics/widening-participation-in-higher-education/",
              "Widening Participation (WP)"
            ),
            "statistics release on Explore Education Statistics. This is the first release in the Department for Education’s ",
            a(
              href = "https://explore-education-statistics.service.gov.uk/find-statistics/widening-participation-in-higher-education/",
              "WP"
            ),
            " series to incorporate statistics formerly published in the ",
            a(
              href = "https://explore-education-statistics.service.gov.uk/find-statistics/participation-measures-in-higher-education/",
              "Participation Measures in Higher Education (CHEP)"
            ),
            " series."
          ),
          p(
            "The historic ",
            a(
              href = "https://explore-education-statistics.service.gov.uk/find-statistics/widening-participation-in-higher-education/",
              "WP"
            ),
            " and ",
            a(
              href = "https://explore-education-statistics.service.gov.uk/find-statistics/participation-measures-in-higher-education/",
              "CHEP"
            ),
            " statistics releases both measured higher education participation by various breakdowns and characteristics,
            tracking proportions of cohorts entering higher education (HE) by a given age. This is
            referred to as the progression rate in the WP publication and entry percentage in the CHEP publication.
            Historically, the WP publication presented a HE progression rate which measured the proportion of
            pupils in English state-funded schools and special schools at age 15 who went on to enter HE by age 19.
            CHEP presented three key entry percentages, measuring the proportion of pupils in English state-funded
            schools and special schools at age 15 who went on to enter HE by age 20, 25 or 30, and also included
            entry percentages by individual year of age. This dashboard focusses on participation rates for those who went on to
            enter HE by age 19 or 25, however underlying data for entry by age 20 and 30 (plus individual year of age)
            is available on",
            a(
              href = "https://explore-education-statistics.service.gov.uk/find-statistics/widening-participation-in-higher-education/",
              "Explore Education Statistics."
            ),
            " As in the previous WP and CHEP
            publications, data in this dashboard relates to pupils studying in English state-funded and special schools
            at age 15 (with the exception of school type which also looks at those studying in independent schools)."
          ),
          h2("Using the dashboard"),
          p("The dashboard is designed to be an interactive tool, updating charts and tables based on the inputs
            selected by the user to show breakdowns of interest. The dashboard has tabs to show HE participation rates relating
            to the ages, and tabs beneath each of these for themes of interest:"),
          tags$ul(
            tags$li("Pupil characteristics – includes a chart and table showing participation rate in HE by the age selected,
           broken down by options selected by the user (tariff and characteristic group such as FSM or sex).
           Allows comparisons between the individual characteristics within the group."),
            tags$li("Pupil characteristics by region and local authority – includes a map and table showing participation rate in HE for the most
           recent cohort by the age selected, broken down by user-selected options (tariff and FSM). Tabs allow switching between
           region and local authority breakdowns."),
            tags$li("Level of study – includes a chart and table showing participation rate in HE by the age selected,
           broken down by level of study."),
            tags$li("Qualification aim – includes a chart and table showing participation rate in HE by the age selected,
           broken down by qualification aim."),
            tags$li("Mode of study – includes a chart and table showing participation rate in HE by the age selected,
           broken down by mode of study.")
          ),
          p("Tables throughout the dashboard can be sorted by clicking on the column headings. Hovering above charts will display labels,
            and you can zoom into sections of charts by clicking and dragging over an area of interst. It is also possible to look at one series
            in a chart in isolation by clicking the series in the legend."),
          h2("Guidance sources"),
          p(
            "Full information on methodology and further technical notes are available in the ",
            a(
              href = "https://explore-education-statistics.service.gov.uk/find-statistics/widening-participation-in-higher-education/",
              "WP"
            ),
            " statistics release page on Explore Education Statistics. If you have questions about the dashboard or data within it, please
            contact us at",
            a(
              href = "mailto:he.statistics@education.gov.uk",
              "he.statistics@education.gov.uk."
            )
          ),
          h2("Feedback"),
          p(
            "This is the first iteration of the dashboard and we invite users to provide feedback to shape further development for
            future iterations. Further information on how to provide feedback and raise issues can be found at ",
            actionLink("link_to_feedback_tab", "Support and feedback.")
          )
        )
      )
    )
  )
}
