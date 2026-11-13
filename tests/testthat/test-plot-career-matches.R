test_that("plot_career_matches returns a ggplot", {
  sample_data = data.frame(
    player_age = c(18, 19, 20),
    age_difference = c(-2, 0, 3),
    result = c("W", "L", "W")
  )

  plot = plot_career_matches(sample_data)

  expect_s3_class(plot, "ggplot")
})

test_that("plot_career_matches rejects invalid data", {
  expect_error(
    plot_career_matches(data.frame(x = 1)),
    "Input must contain"
  )
})