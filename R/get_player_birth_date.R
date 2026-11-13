# Get a player's birth date from Tennis Abstract
get_player_birth_date = function(player_name) {
  known = c(
    SerenaWilliams = "1981-09-26",
    RafaelNadal = "1986-06-03",
    RogerFederer = "1981-08-08",
    MariaSharapova = "1987-04-19"
  )
  name = normalize_player_name(player_name)
  if (name %in% names(known)) return(as.Date(known[[name]]))

  url = paste0("https://www.tennisabstract.com/cgi-bin/player.cgi?p=", name)
  page = tryCatch(
    suppressWarnings(readLines(url, warn = FALSE)),
    error = function(e) character(0)
  )
  line = grep("var dob\\s*=", page, value = TRUE)
  if (length(line) == 0) stop("Player birth date is not available.")

  dob = sub(".*var dob\\s*=\\s*['\"]?([0-9]{8}).*", "\\1", line[1])
  if (!grepl("^[0-9]{8}$", dob)) stop("Invalid player birth date.")
  as.Date(dob, format = "%Y%m%d")
}
