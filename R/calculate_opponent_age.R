# Calculate opponent age from Tennis Abstract data
calculate_opponent_age = function(match_dates, field17, gender) {
  if (!gender %in% c("W", "M")) {
    stop("Gender must be W or M.")
  }

  if (gender == "M") {
    return(suppressWarnings(as.numeric(field17)))
  }

  opponent_dob = as.Date(field17, format = "%Y%m%d")
  dates = as.character(match_dates)

  match_dates = as.Date(dates, format = "%Y%m%d")
  missing_dates = is.na(match_dates)

  match_dates[missing_dates] = as.Date(
    dates[missing_dates],
    format = "%Y-%m-%d"
  )

  age = as.numeric(match_dates - opponent_dob) / 365.25

  return(age)
}
