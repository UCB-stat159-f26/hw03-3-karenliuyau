#' Get Cleaned Tennis Career Match Data
#'
#' @param player_name Name of the tennis player.
#' @return A data frame containing career match data and age differences.
#' @export
data_function = function(player_name) {
  name = normalize_player_name(player_name)

  birth_dates = c(
    SerenaWilliams = "1981-09-26",
    VenusWilliams = "1980-06-17",
    RafaelNadal = "1986-06-03"
  )

  if (!name %in% names(birth_dates)) {
    stop("Player birth date is not available yet.")
  }

  gender = if (name %in% c("SerenaWilliams", "VenusWilliams")) "W" else "M"

  matches = tryCatch(
    get_player_matches(player_name),
    error = function(e) stop("Could not find matches for this player.")
  )

  if (length(matches) == 0) stop("No career matches found for this player.")

  data = clean_matches(matches, gender)
  birth_date = as.Date(birth_dates[[name]])
  data$player_age = as.numeric(data$match_date - birth_date) / 365.25
  data$age_difference = data$player_age - data$opponent_age

  return(data)
}
