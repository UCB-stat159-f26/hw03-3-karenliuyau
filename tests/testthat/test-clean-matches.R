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


test_that("clean_matches handles multiple female matches", {
  matches = list(
    c("19951030", "Canadian Open", "Carpet", "W", "L",
      "", "", "WC", "Q1", "6-1 6-1", "3",
      "Anne Miller", "149", "7", "", "R", "19770119"),
    c("19970307", "Indian Wells", "Hard", "W", "L",
      "", "", "WC", "Q1", "6-4 6-0", "3",
      "Alexia Dechaume Balleret", "87", "", "", "R", "19700503"),
    c("19970804", "Manhattan Beach", "Hard", "W", "L",
      "", "", "WC", "Q3", "7-6 4-6 6-3", "3",
      "Magui Serna", "54", "6", "", "L", "19790301")
  )

  result = clean_matches(matches, "W")

  expect_equal(nrow(result), 3)
  expect_equal(result$result, c("L", "L", "L"))
  expect_equal(
    result$opponent,
    c("Anne Miller", "Alexia Dechaume Balleret", "Magui Serna")
  )

  expected_ages = as.numeric(
    as.Date(c("1995-10-30", "1997-03-07", "1997-08-04")) -
    as.Date(c("1977-01-19", "1970-05-03", "1979-03-01"))
  ) / 365.25

  expect_equal(result$opponent_age, expected_ages, tolerance = 0.02)
})


test_that("clean_matches handles multiple male matches", {
  matches = list(
    c("20010910", "Spain F10", "Hard", "S", "L",
      "", "", "WC", "R32", "2-6 7-5 6-2", "3",
      "Guillermo Platel", "731", "", "", "R", "22.264202601"),
    c("20010917", "Seville CH", "Clay", "C", "L",
      "", "", "WC", "R16", "3-6 6-1 6-3", "3",
      "Stefano Galvani", "161", "2", "", "R", "24.2902121834"),
    c("20010917", "Seville CH", "Clay", "C", "W",
      "", "", "WC", "R32", "6-4 6-4", "3",
      "Israel Matos Gil", "751", "", "Q", "U", "18.7597535934")
  )

  result = clean_matches(matches, "M")

  expect_equal(nrow(result), 3)
  expect_equal(result$result, c("L", "L", "W"))
  expect_equal(
    result$opponent,
    c("Guillermo Platel", "Stefano Galvani", "Israel Matos Gil")
  )
  expect_equal(
    result$opponent_age,
    c(22.264202601, 24.2902121834, 18.7597535934),
    tolerance = 0.02
  )
})