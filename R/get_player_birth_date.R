# Return birth dates for players with known dates
get_known_birth_date = function(player_name) {
  known = c(
    SerenaWilliams = "1981-09-26",
    RafaelNadal = "1986-06-03",
    RogerFederer = "1981-08-08",
    MariaSharapova = "1987-04-19"
  )
  if (!player_name %in% names(known)) return(NULL)
  as.Date(known[[player_name]])
}

# Extract a birth date from Tennis Abstract HTML
extract_birth_date = function(page) {
  line = grep("var dob\\s*=", page, value = TRUE)
  if (length(line) == 0) stop("Player birth date is not available.")
  dob = sub(".*var dob\\s*=\\s*['\"]?([0-9]{8}).*", "\\1", line[1])
  if (!grepl("^[0-9]{8}$", dob)) stop("Invalid player birth date.")
  as.Date(dob, format = "%Y%m%d")
}

# Get a player's birth date
get_player_birth_date = function(player_name) {
  name = normalize_player_name(player_name)
  known_date = get_known_birth_date(name)
  if (!is.null(known_date)) return(known_date)

  url = paste0("https://www.tennisabstract.com/cgi-bin/player.cgi?p=", name)
  page = tryCatch(
    suppressWarnings(readLines(url, warn = FALSE)),
    error = function(e) character(0)
  )
  extract_birth_date(page)
}
