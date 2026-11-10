test_that("match fields are extracted correctly", {
  matches = list(
    c("20200101", "Australian Open"),
    c("20200201", "French Open")
  )

  expect_equal(
    get_match_field(matches, 1),
    c("20200101", "20200201")
  )

  expect_equal(
    get_match_field(matches, 2),
    c("Australian Open", "French Open")
  )
})

test_that("missing match fields return NA", {
  matches = list(
    c("20200101", "Australian Open"),
    c("20200201")
  )

  expect_equal(
    get_match_field(matches, 2),
    c("Australian Open", NA_character_)
  )
})

test_that("invalid field numbers produce errors", {
  matches = list(c("20200101", "Australian Open"))

  expect_error(get_match_field(matches, 0))
  expect_error(get_match_field(matches, -1))
  expect_error(get_match_field(matches, NA_real_))
})
