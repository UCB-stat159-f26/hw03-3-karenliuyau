test_that("female opponent age uses birth date", {
  age = calculate_opponent_age(
    "1995-10-30", "19770119", "W"
  )

  expect_equal(age, 18.78, tolerance = 0.02)
})

test_that("male opponent age uses numeric age", {
  age = calculate_opponent_age(
    "2001-09-10", "22.264202601", "M"
  )

  expect_equal(age, 22.264202601)
})

test_that("missing opponent data returns NA", {
  expect_true(is.na(
    calculate_opponent_age("1995-10-30", "", "W")
  ))

  expect_true(is.na(
    calculate_opponent_age("2001-09-10", "", "M")
  ))
})

test_that("invalid gender produces an error", {
  expect_error(
    calculate_opponent_age("1995-10-30", "19770119", "X")
  )
})
