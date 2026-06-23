# Widening Participation dashboard

------------------------------------------------------------------------

## Introduction and context

The purpose of this dashboard is to consolidate existing statistics across the departmental [Participation Measures in Higher Education](https://explore-education-statistics.service.gov.uk/find-statistics/participation-measures-in-higher-education/2023-24) and [Widening Participation in Higher Education](https://explore-education-statistics.service.gov.uk/find-statistics/widening-participation-in-higher-education/2023-24) publications and to provide an easier way for users to self-serve.

### Repository purpose

This repository is for the public external version of the app, deployed via shinapps.io. The app produced by the code in this repo is deployed at [INSERT LINK HERE ONCE DEPLOYED].

### Dashboard contents

The dashboard is split across multiple sections, reflecting the age by which individuals from the same age 15 cohort entered higher education (e.g. by 19, by 25). Within these sections, there are the following tabs:

- **Pupil characteristics** - includes information on participation rates in higher education by user selected options (tariff and characteristics such as sex, FSM eligibility, disadvantage etc.)

- **Pupil characteristics by region and local authority** - includes information on participation rates in higher education by user selected options (tariff and FSM), broken down by either region or local authority

- **Level of study** - includes information on participation rates in higher education by level of study (not broken down by tariff or characteristics)

- **Qualification aim** - includes information on participation rates in higher education by qualification aim i.e. foundation degree, first degree, postgraduate (not broken down by tariff or characteristics)

- **Mode of study** - includes information on participation rates in higher education by mode of study, i.e. full-time, part-time, apprenticeship (not broken down by tariff or characteristics)

------------------------------------------------------------------------

## Requirements

The following requirements are necessary for running the application yourself or contributing to it.

### i. Software requirements (for running locally)

- Installation of R Studio 2026.01.1+403 "Apple Blossom" or higher

- Installation of R 4.5.0 or higher

- Installation of RTools45 or higher

### ii. Programming skills required (for editing or troubleshooting)

- R at an intermediate level (see [DfE R learning resources](https://dfe-analytical-services.github.io/analysts-guide/learning-development/r.html) for further information)

- Particularly [R Shiny](https://shiny.rstudio.com/)

------------------------------------------------------------------------

## How to use

### Running the app locally

1.  Clone or download the repo.

2.  Open the R project in R Studio.

3.  Run `renv::restore()` to install dependencies.

4.  Run `shiny::runApp()` to run the app locally.

### Packages

Package control is handled using renv. As in the steps above, you will need to run `renv::restore()` if this is your first time using the project.

### Tests

Automated tests have been created using shinytest2 that test the app loads and behaves as expected based on user inputs and navigation. Tests should be updated and maintained over time as the app is developed.

GitHub Actions provide CI by running the automated tests and checks for code styling on every pull request into the main branch. The yaml files for these workflows can be found in the .github/workflows folder.

You should run `testthat::test_file("tests/testthat/test-shinytest2.R")` regularly to check that the tests are passing against the code you are working on. If running this code results in any failures, you will need to check the new outputs against the old using `testthat::snapshot_review('shinytest2/')`, and expected outputs should be updated to the new versions as required.

### Deployment

The app is deployed to the Department for Education's shinyapps.io subscription using GitHub actions.

### Navigation

In general all .r files will have a usable outline, so make use of that for navigation if in RStudio: `Ctrl-Shift-O`.

### Code styling

Code styling is automatically applied when you attempt to commit any changes, as the tidy_code function from the dfeshiny package is run. You may see messages when you attempt to commit changes stating that some of your scripts have been styled when tidy_code has been run, and you should check any changes in detail prior to staging, committing and pushing.

------------------------------------------------------------------------

## Contribution and issues

For any contribution, to flag issues or make suggestions please contact [gemma.selby\@education.gov.uk](mailto:gemma.selby@education.gov.uk).

------------------------------------------------------------------------

## Contact

If you have any questions about the dashboard please contact [gemma.selby\@education.gov.uk](mailto:gemma.selby@education.gov.uk).
