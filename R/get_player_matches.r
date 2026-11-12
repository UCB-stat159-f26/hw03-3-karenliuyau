#' Get a tennis player's career matches
#' @param player_name Name of the tennis player
#' @return A data frame of career matches
#' @export
get_player_matches = function(player_name) {
    player = normalize_player_name(player_name)

    for (gender in c("W", "M")) {
        url = paste0(
            "https://www.tennisabstract.com/",
            if (gender == "W") "jsmatches/" else "charting/meta.csv"
        )
        if (gender == "W") {
            url = paste0(url, player, "Career.js")
        } else {
            url = paste0(
                "https://www.tennisabstract.com/jsmatches/",
                player, "Career.js"
            )
        }

        js = tryCatch(
            readLines(url, warn = FALSE),
            error = function(e) NULL
        )
        if (!is.null(js)) break
    }

    if (is.null(js)) {
        stop("Player not found. Please check the name.")
    }

    matches = parse_career_js(js)
    return(matches)
}
