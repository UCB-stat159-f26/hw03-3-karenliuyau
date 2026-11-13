#' Get Cleaned Tennis Career Match Data
#'
#' @param player_name Name of the tennis player.
#' @return A data frame containing career match data and age differences.
#' @export
get_career_data = function(player_name) {
  name = normalize_player_name(player_name)

  matches = tryCatch(
    get_player_matches(player_name),
    error = function(e) stop("Player not found. Please check the name.")
  )

  if (length(matches) == 0) {
    stop("No career matches found for this player.")
  }

  birth_date = get_player_birth_date(player_name)

  gender = detect_player_gender(matches)

  data = clean_matches(matches, gender)
  data$player_age = as.numeric(data$match_date - birth_date) / 365.25
  data$age_difference = data$player_age - data$opponent_age

  return(data)
}
