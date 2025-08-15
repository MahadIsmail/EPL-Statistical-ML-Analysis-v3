source("R/00_setup.R")
load_season <- function(f) readr::read_csv(file.path(DATA_DIR,f), show_col_types = FALSE)

plot_wage_pos <- function(df, season_label) {
  m <- lm(leaguepos ~ Grosspygbp, data = df)
  print(summary(m))
  p <- ggplot(df, aes(Grosspygbp, leaguepos, label = Club)) +
    geom_point() + geom_smooth(method="lm", se=TRUE) +
    geom_text_repel(size=3, max.overlaps=100) +
    scale_y_reverse(breaks=1:20) +
    labs(title=paste("Premier League", season_label, ": Wage Bill vs League Position"),
         x="Gross Annual Wage Bill (GBP)", y="Final League Position (1=Champion)") +
    theme_minimal()
  ggsave(file.path(FIG_DIR, paste0("wage_vs_pos_", gsub("[/ ]","_",season_label), ".png")),
         p, width=8, height=6, dpi=150)
  invisible(m)
}

df_2425 <- load_season("clubdata_2024_25.csv")
df_2324 <- load_season("clubdata_2023_24.csv")
df_2223 <- load_season("clubdata_2022_23.csv")

plot_wage_pos(df_2223, "2022–23")
plot_wage_pos(df_2324, "2023–24")
plot_wage_pos(df_2425, "2024–25")
