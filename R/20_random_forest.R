source("R/00_setup.R")
df_2223 <- readr::read_csv(file.path(DATA_DIR,"clubdata_2022_23.csv"), show_col_types = FALSE)
df_2324 <- readr::read_csv(file.path(DATA_DIR,"clubdata_2023_24.csv"), show_col_types = FALSE)
df_2425 <- readr::read_csv(file.path(DATA_DIR,"clubdata_2024_25.csv"), show_col_types = FALSE)

training <- bind_rows(df_2223 %>% mutate(Season="2022_23"),
                      df_2324 %>% mutate(Season="2023_24"))

set.seed(141)
rf_full <- randomForest(leaguepos ~ totalmarketvalm + Grosspygbp + nettspendM,
                        data = training, ntree = 500, importance = TRUE)
imp <- as.data.frame(importance(rf_full, type=1)) %>% tibble::rownames_to_column("Variable") %>% arrange(desc(`%IncMSE`))
print(knitr::kable(imp, digits=2))

rf_nospend <- randomForest(leaguepos ~ totalmarketvalm + Grosspygbp,
                           data = training, ntree = 500, importance = TRUE)

df_2425$RF_Pred <- predict(rf_nospend, df_2425)
rf_rmse <- sqrt(rf_nospend$mse[length(rf_nospend$mse)])
df_2425 <- df_2425 %>%
  mutate(RF_Top4_Prob = round(100 * pnorm(4.5, RF_Pred, rf_rmse)),
         RF_Top6_Prob = round(100 * pnorm(6.5, RF_Pred, rf_rmse)),
         RF_Relegation_Prob = round(100 * pnorm(17.5, RF_Pred, rf_rmse, lower.tail = FALSE)))

p <- ggplot(df_2425, aes(leaguepos, RF_Pred, label=Club)) +
  geom_point() + geom_text_repel(size=3) +
  geom_abline(slope=1, intercept=0, linetype="dashed") +
  scale_y_reverse(breaks=1:20) + scale_x_reverse(breaks=1:20) +
  labs(title="Random Forest (No Net Spend): Predicted vs Actual (2024–25)",
       x="Actual Position", y="Predicted Position (RF)") + theme_minimal()
ggsave(file.path(FIG_DIR,"rf_pred_vs_actual_2024_25.png"), p, width=8, height=6, dpi=150)

readr::write_csv(df_2425, file.path(DATA_DIR,"predictions_rf_2024_25.csv"))
