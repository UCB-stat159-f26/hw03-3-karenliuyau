detect_player_gender = function(matches) {
  values = vapply(matches, function(match) {
    if (length(match) < 17) return(NA_character_)
    as.character(match[[17]])
  }, character(1))

  values = values[!is.na(values) & nzchar(values)]

  if (length(values) == 0) {
    stop("Cannot determine player gender from match data.")
  }

  if (mean(grepl("^(19|20)[0-9]{6}$", values)) > 0.5) {
    return("W")
  }

  if (mean(grepl("^[0-9]+\\.[0-9]+$", values)) > 0.5) {
    return("M")
  }

  stop("Cannot determine player gender from match data.")
}
