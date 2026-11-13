test_that("clean_matches processes female match data", {
  female_matches = list(
    c("19951030", "Canadian Open", "Carpet", "W", "L",
      "", "", "WC", "Q1", "6-1 6-1", "3",
      "Anne Miller", "149", "7", "", "R",
      "19770119", "", "USA")
  )

  result = clean_matches(female_matches, "W")

  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 1)
  expect_equal(result$match_date, as.Date("1995-10-30"))
  expect_equal(result$tournament, "Canadian Open")
  expect_equal(result$surface, "Carpet")
  expect_equal(result$result, "L")
  expect_equal(result$opponent, "Anne Miller")
  expect_equal(
    result$opponent_age,
    as.numeric(as.Date("1995-10-30") -
               as.Date("1977-01-19")) / 365.25,
    tolerance = 0.02
  )
})

test_that("clean_matches processes male match data", {
  male_matches = list(
    c("20010910", "Spain F10", "Hard", "S", "L",
      "", "", "WC", "R32", "2-6 7-5 6-2",
      "3", "Guillermo Platel", "731", "", "",
      "R", "22.264202601", "", "ESP")
  )

  result = clean_matches(male_matches, "M")

  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 1)
  expect_equal(result$match_date, as.Date("2001-09-10"))
  expect_equal(result$tournament, "Spain F10")
  expect_equal(result$surface, "Hard")
  expect_equal(result$result, "L")
  expect_equal(result$opponent, "Guillermo Platel")
  expect_equal(
    result$opponent_age,
    22.264202601,
    tolerance = 0.02
  )
})
