test_that("detect_player_gender identifies women's matches", {
  matches = list(
    c(rep("", 16), "19810926"),
    c(rep("", 16), "19800617")
  )

  expect_equal(detect_player_gender(matches), "W")
})

test_that("detect_player_gender identifies men's matches", {
  matches = list(
    c(rep("", 16), "25.4"),
    c(rep("", 16), "28.7")
  )

  expect_equal(detect_player_gender(matches), "M")
})

test_that("detect_player_gender handles missing opponent information", {
  matches = list(
    c(rep("", 16), NA_character_),
    c(rep("", 16), "")
  )

  expect_error(
    detect_player_gender(matches),
    "Cannot determine player gender"
  )
})

test_that("detect_player_gender handles empty match data", {
  expect_error(
    detect_player_gender(list()),
    "Cannot determine player gender"
  )
})

test_that("detect_player_gender handles invalid opponent information", {
  matches = list(
    c(rep("", 16), "unknown"),
    c(rep("", 16), "invalid")
  )

  expect_error(
    detect_player_gender(matches),
    "Cannot determine player gender"
  )
})
