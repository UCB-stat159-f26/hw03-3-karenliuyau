#' Import the .data pronoun
#' @name tennis-package-imports
#' @importFrom rlang .data
NULL

#' Plot tennis matches by player age
#'
#' @param data A data frame returned by data_function().
#' @return A ggplot object.
#' @export
plot_function = function(data) {
  required = c("player_age", "age_difference", "result")
  if (!is.data.frame(data) || !all(required %in% names(data))) {
    stop("Input must contain player_age, age_difference, and result.")
  }
  if (!is.numeric(data$player_age) || !is.numeric(data$age_difference)) {
    stop("Player age and age difference must be numeric.")
  }
  if (!all(stats::na.omit(as.character(data$result)) %in% c("W", "L"))) {
    stop("Results must be W or L.")
  }
  data = data[stats::complete.cases(data[, required]), ]
  if (nrow(data) == 0) stop("No valid matches to plot.")
  data$result = factor(data$result, levels = c("W", "L"))
  p = ggplot2::ggplot(data, ggplot2::aes(
    x = .data$player_age, y = -.data$age_difference, color = .data$result
  ))
  p + tennis_plot_layers() + tennis_plot_style()
}

# Add the scatter plot and legend
tennis_plot_layers = function() {
  list(
    ggplot2::geom_point(size = 1.15, alpha = 0.9),
    ggplot2::geom_hline(yintercept = 0, color = "gray60", linewidth = 0.45),
    ggplot2::scale_color_manual(
      breaks = c("W", "L"),
      values = c("W" = "#40BFE5", "L" = "#96358D"),
      labels = c("Match won", "Match lost"),
      name = NULL
    ),
    ggplot2::scale_x_continuous(position = "top"),
    ggplot2::scale_y_continuous(
      breaks = c(-20, -10, 0, 10, 20),
      labels = c("-20", "-10", "Same age", "+10", "+20 years")
    )
  )
}

# Add labels and graph styling
tennis_plot_style = function() {
  list(
    ggplot2::labs(
      title = "Professional Tennis Matches by Player Age",
      x = "Player age",
      y = "Player age minus opponent age (years)",
      caption = "Source: Tennis Abstract"
    ),
    ggplot2::theme_minimal(base_size = 12),
    ggplot2::theme(
      plot.title = ggplot2::element_text(
        face = "bold", hjust = 0.5, size = 16
      ),
      legend.position = "top",
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(
        color = "gray90", linewidth = 0.35
      ),
      axis.text = ggplot2::element_text(color = "gray55"),
      plot.caption = ggplot2::element_text(
        color = "gray55", size = 8
      )
    )
  )
}
