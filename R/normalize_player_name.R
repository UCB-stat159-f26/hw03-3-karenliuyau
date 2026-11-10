# Convert player names to a consistent format
normalize_player_name = function(player_name) {
  if (!is.character(player_name) ||
      length(player_name) != 1 ||
      is.na(player_name) ||
      !nzchar(trimws(player_name))) {
    stop("Please enter a valid player name.")
  }

  player_name = trimws(player_name)
  player_name = gsub("[^[:alpha:] ]", "", player_name)

  if (!nzchar(gsub(" ", "", player_name))) {
    stop("Please enter a valid player name.")
  }

  words = strsplit(player_name, "[[:space:]]+")[[1]]

  if (length(words) > 1) {
    words = paste0(
      toupper(substr(words, 1, 1)),
      tolower(substring(words, 2))
    )
    return(paste0(words, collapse = ""))
  }

  return(player_name)
}
