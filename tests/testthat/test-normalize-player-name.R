test_that("player names are normalized correctly", {
  expect_equal(
    normalize_player_name("serena williams"),
    "SerenaWilliams"
  )
  expect_equal(
    normalize_player_name("Serena Williams"),
    "SerenaWilliams"
  )
  expect_equal(
    normalize_player_name("SerenaWilliams"),
    "SerenaWilliams"
  )
  expect_equal(
    normalize_player_name("Rafael Nadal"),
    "RafaelNadal"
  )
})

test_that("invalid names produce an error", {
  expect_error(normalize_player_name(""))
  expect_error(normalize_player_name(NA_character_))
  expect_error(normalize_player_name(123))
})
