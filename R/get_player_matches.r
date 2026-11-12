#' Get a tennis player's career matches
#' @param player_name Name of the tennis player.
#' @return A list of career match records.
get_player_matches = function(player_name) {
  player = normalize_player_name(player_name)

  url = paste0(
    "https://www.tennisabstract.com/jsmatches/",
    player, "Career.js"
  )

  js = tryCatch(
    suppressWarnings(readLines(url, warn = FALSE)),
    error = function(e) NULL
  )

  if (is.null(js) || length(js) == 0) {
    stop("Player not found. Please check the name.")
  }

  parse_career_js(js)
}
