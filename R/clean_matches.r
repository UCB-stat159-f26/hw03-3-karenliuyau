clean_matches = function(matches, gender) {
  dates = get_match_field(matches, 1)
  opponents = get_match_field(matches, 12)
  opponent_info = get_match_field(matches, 17)

  opponent_ages = calculate_opponent_age(
    dates, opponent_info, gender
  )

  data.frame(
    match_date = as.Date(dates, format = "%Y%m%d"),
    tournament = get_match_field(matches, 2),
    surface = get_match_field(matches, 3),
    result = get_match_field(matches, 5),
    opponent = opponents,
    opponent_age = opponent_ages,
    stringsAsFactors = FALSE
  )
}
