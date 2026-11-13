
test_that("get_career_data processes female matches", {
  fake_matches = list(
    c("19951030", "Canadian Open", "Carpet", "W", "L",
      "", "", "WC", "Q1", "6-1 6-1", "3",
      "Anne Miller", "149", "7", "", "R", "19770119")
  )

  local_mocked_bindings(
    get_player_matches = function(player_name) fake_matches,
    get_player_birth_date = function(player_name) as.Date("1981-09-26")
  )

  result = get_career_data("Serena Williams")

  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 1)
  expect_equal(ncol(result), 8)

  expect_named(
    result,
    c(
      "match_date",
      "tournament",
      "surface",
      "result",
      "opponent",
      "opponent_age",
      "player_age",
      "age_difference"
    )
  )

  expect_equal(result$result, "L")
  expect_equal(result$opponent, "Anne Miller")

  expected_opponent_age = as.numeric(
    as.Date("1995-10-30") - as.Date("1977-01-19")
  ) / 365.25

  expect_equal(result$opponent_age, expected_opponent_age)

  expected_age = as.numeric(
    as.Date("1995-10-30") - as.Date("1981-09-26")
  ) / 365.25

  expect_equal(result$player_age, expected_age)

  expect_equal(
    result$age_difference,
    result$player_age - result$opponent_age
  )
})

test_that("get_career_data processes male matches", {
  fake_matches = list(
    c("20010910", "Spain F10", "Hard", "S", "L",
      "", "", "WC", "R32", "2-6 7-5 6-2",
      "3", "Guillermo Platel", "731", "", "",
      "R", "22.264202601")
  )

  local_mocked_bindings(
    get_player_matches = function(player_name) fake_matches,
    get_player_birth_date = function(player_name) as.Date("1986-06-03")
  )

  result = get_career_data("Rafael Nadal")

  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 1)
  expect_equal(result$opponent_age, 22.264202601)

  expect_equal(
    result$age_difference,
    result$player_age - result$opponent_age
  )
})

test_that("get_career_data handles missing players", {
  local_mocked_bindings(
    get_player_matches = function(player_name) {
      stop("Player not found.")
    }
  )

  expect_error(
    get_career_data("GastonSanchez"),
    "Player not found"
  )
})

test_that("get_career_data handles empty matches", {
  local_mocked_bindings(
    get_player_matches = function(player_name) list()
  )

  expect_error(
    get_career_data("Serena Williams"),
    "No career matches found"
  )
})
