# Convert Tennis Abstract JavaScript into match records
parse_career_js = function(js_text) {
  if (!is.character(js_text) || length(js_text) == 0)
    stop("The JavaScript data must be text.")

  raw = paste(js_text, collapse = "\n")
  raw = sub("^[\\s\\S]*?var\\s+morematchmx\\s*=\\s*",
            "", raw, perl = TRUE)
  raw = sub(";[\\s\\S]*$", "", raw, perl = TRUE)

  matches = tryCatch(
    jsonlite::fromJSON(raw, simplifyVector = FALSE),
    error = function(e) stop("Could not parse the career match data.")
  )

  if (!is.list(matches) || length(matches) == 0)
    stop("No career matches were found.")

  return(matches)
}