# Calculate opponent age from Tennis Abstract data
calculate_opponent_age = function(match_dates, field17, gender) {
  if (!gender %in% c("W", "M")) {
    stop("Gender must be W or M.")
  }

  if (gender == "M") {
    return(suppressWarnings(as.numeric(field17)))
  }

  opponent_dob = as.Date(field17, format = "%Y%m%d")
  match_dates = as.Date(match_dates)

  age = as.numeric(match_dates - opponent_dob) / 365.25

  return(age)
}
