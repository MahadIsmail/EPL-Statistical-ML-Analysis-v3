source("R/00_setup.R")
df_2223 <- readr::read_csv(file.path(DATA_DIR,"clubdata_2022_23.csv"), show_col_types = FALSE)
df_2324 <- readr::read_csv(file.path(DATA_DIR,"clubdata_2023_24.csv"), show_col_types = FALSE)
df_2425 <- readr::read_csv(file.path(DATA_DIR,"clubdata_2024_25.csv"), show_col_types = FALSE)

training <- bind_rows(df_2223 %>% mutate(Season="2022_23"),
                      df_2324 %>% mutate(Season="2023_24"))

full_model <- lm(leaguepos ~ totalmarketvalm + nettspendM + Grosspygbp, data = training)
print(summary(full_model)); print(car::vif(full_model))

lm_model <- lm(leaguepos ~ totalmarketvalm, data = training)
print(summary(lm_model))
linear_rmse <- sqrt(mean(residuals(lm_model)^2))

df_2425$Predicted_Position <- predict(lm_model, df_2425)
df_2425 <- df_2425 %>%
  mutate(Top6_Prob = round(100 * pnorm(6.5, Predicted_Position, linear_rmse)),
         Top4_Prob = round(100 * pnorm(4.5, Predicted_Position, linear_rmse)),
         Relegation_Prob = round(100 * pnorm(17.5, Predicted_Position, linear_rmse, lower.tail = FALSE)))

print(knitr::kable(df_2425 %>% select(Club, leaguepos, Predicted_Position, Top6_Prob) %>% arrange(Predicted_Position),
                   digits = 1, col.names = c("Club","Actual","Linear Pred","Top6%")))

p <- ggplot(df_2425, aes(leaguepos, Predicted_Position, label=Club)) +
  geom_point() + geom_text_repel(size=3) +
  geom_abline(slope=1, intercept=0, linetype="dashed") +
  scale_y_reverse(breaks=1:20) + scale_x_reverse(breaks=1:20) +
  labs(title="Linear Regression: Predicted vs Actual (2024–25)",
       x="Actual Position", y="Predicted Position") + theme_minimal()
ggsave(file.path(FIG_DIR,"linear_pred_vs_actual_2024_25.png"), p, width=8, height=6, dpi=150)

readr::write_csv(df_2425, file.path(DATA_DIR,"predictions_linear_2024_25.csv"))
