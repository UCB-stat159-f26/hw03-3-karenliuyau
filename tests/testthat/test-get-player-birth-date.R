test_that("get_known_birth_date returns known dates", {
  expect_equal(
    get_known_birth_date("SerenaWilliams"),
    as.Date("1981-09-26")
  )

  expect_equal(
    get_known_birth_date("RafaelNadal"),
    as.Date("1986-06-03")
  )

  expect_equal(
    get_known_birth_date("RogerFederer"),
    as.Date("1981-08-08")
  )

  expect_equal(
    get_known_birth_date("MariaSharapova"),
    as.Date("1987-04-19")
  )

  expect_null(get_known_birth_date("UnknownPlayer"))
})

test_that("extract_birth_date reads valid HTML", {
  page = c(
    "<html>",
    "var dob = '19800617';",
    "</html>"
  )

  expect_equal(
    extract_birth_date(page),
    as.Date("1980-06-17")
  )
})

test_that("extract_birth_date handles missing dates", {
  page = c("<html>", "No birth date here", "</html>")

  expect_error(
    extract_birth_date(page),
    "Player birth date is not available"
  )
})

test_that("extract_birth_date handles invalid dates", {
  page = "var dob = 'unknown';"

  expect_error(
    extract_birth_date(page),
    "Invalid player birth date"
  )
})
