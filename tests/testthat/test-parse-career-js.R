test_that("female career JavaScript can be parsed", {
  female_js = paste0(
    'var morematchmx = [["19951030", "Canadian Open", ',
    '"Carpet", "W", "L", "", "", "WC", "Q1", ',
    '"6-1 6-1", "3", "Anne Miller", "149", "7", ',
    '"", "R", "19770119", "", "USA", "0"]];'
  )

  matches = parse_career_js(female_js)

  expect_length(matches, 1)
  expect_equal(matches[[1]][[1]], "19951030")
  expect_equal(matches[[1]][[12]], "Anne Miller")
  expect_equal(matches[[1]][[17]], "19770119")
})

test_that("male career JavaScript can be parsed", {
  male_js = paste0(
    'var morematchmx = [["20010910", "Spain F10", ',
    '"Hard", "S", "L", "", "", "WC", "R32", ',
    '"2-6 7-5 6-2", "3", "Guillermo Platel", ',
    '"731", "", "", "R", "22.264202601"]];'
  )

  matches = parse_career_js(male_js)

  expect_length(matches, 1)
  expect_equal(matches[[1]][[12]], "Guillermo Platel")
  expect_equal(matches[[1]][[17]], "22.264202601")
})

test_that("invalid JavaScript produces an error", {
  expect_error(parse_career_js("invalid data"))
  expect_error(parse_career_js(character(0)))
  expect_error(parse_career_js(123))
})
