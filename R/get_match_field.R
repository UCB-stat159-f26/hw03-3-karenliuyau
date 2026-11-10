# Extract a field from each tennis match
get_match_field = function(matches, field_number) {
  if (!is.list(matches) ||
      !is.numeric(field_number) ||
      length(field_number) != 1 ||
      is.na(field_number) ||
      field_number < 1 ||
      field_number != floor(field_number)) {
    stop("Invalid matches or field number.")
  }

  vapply(matches, function(match) {
    if (length(match) < field_number) {
      return(NA_character_)
    }
    as.character(match[[field_number]])
  }, character(1))
}
