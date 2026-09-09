library(shinytest2)

test_that("{shinytest2} recording: test_01_navigation_bar", {
  app <- AppDriver$new(test_path("../.."),
    variant = platform_variant(), name = "test_01_navigation_bar",
    height = 889, width = 1619, load_timeout = 90000
  )
  app$set_inputs(cookies = character(0), allow_no_input_binding_ = TRUE)
  app$expect_screenshot()
  app$set_inputs(navlistPanel = "HE participation by age 19")
  app$expect_screenshot()
  app$set_inputs(navlistPanel = "HE participation by age 25")
  app$expect_screenshot()
  app$set_inputs(navlistPanel = "Technical notes")
  app$expect_screenshot()
  app$set_inputs(navlistPanel = "a11y_panel")
  app$expect_screenshot()
  app$set_inputs(navlistPanel = "cookies_panel_ui")
  app$expect_screenshot()
  app$set_inputs(navlistPanel = "support_panel_ui")
  app$expect_screenshot()
})


test_that("{shinytest2} recording: test_02_navigation_tabs", {
  app <- AppDriver$new(test_path("../.."),
    variant = platform_variant(), name = "test_02_navigation_tabs",
    height = 889, width = 1619, load_timeout = 90000
  )
  app$set_inputs(cookies = character(0), allow_no_input_binding_ = TRUE)
  app$expect_screenshot()
  app$set_inputs(navlistPanel = "HE participation by age 19")
  app$expect_screenshot()
  app$set_inputs(tabset_19 = "geo")
  app$expect_screenshot()
  app$set_inputs(tabset_geogs_19 = "la")
  app$expect_screenshot()
  app$set_inputs(tabset_19 = "level")
  app$expect_screenshot()
  app$set_inputs(tabset_19 = "qual")
  app$expect_screenshot()
  app$set_inputs(tabset_19 = "mode")
  app$expect_screenshot()
  app$set_inputs(navlistPanel = "HE participation by age 25")
  app$expect_screenshot()
  app$set_inputs(tabset_25 = "geo")
  app$expect_screenshot()
  app$set_inputs(tabset_geogs_25 = "la")
  app$expect_screenshot()
  app$set_inputs(tabset_25 = "level")
  app$expect_screenshot()
  app$set_inputs(tabset_25 = "qual")
  app$expect_screenshot()
  app$set_inputs(tabset_25 = "mode")
  app$expect_screenshot()
})


test_that("{shinytest2} recording: test_03_navigation_dropdowns", {
  app <- AppDriver$new(test_path("../.."),
    variant = platform_variant(), name = "test_03_navigation_dropdowns",
    height = 889, width = 1619, load_timeout = 90000
  )
  app$set_inputs(cookies = character(0), allow_no_input_binding_ = TRUE)
  app$expect_screenshot()
  app$set_inputs(navlistPanel = "HE participation by age 19")
  app$expect_screenshot()
  app$set_inputs(selectCharTabCharacteristicGroup19 = "Free School Meals")
  app$set_inputs(SelectCharTabTariffGroup19 = "High tariff")
  app$expect_screenshot()
  app$set_inputs(tabset_19 = "geo")
  app$expect_screenshot()
  app$set_inputs(selectGeogTabCharacteristicGroup19 = "FSM")
  app$set_inputs(SelectGeogTabTariffGroup19 = "High tariff")
  app$expect_screenshot()
})
