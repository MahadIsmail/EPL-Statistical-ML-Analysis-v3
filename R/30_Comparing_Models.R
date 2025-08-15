source("R/00_setup.R")
lin <- readr::read_csv(file.path(DATA_DIR,"predictions_linear_2024_25.csv"), show_col_types = FALSE) %>%
  select(Club, Actual = leaguepos, Linear = Predicted_Position, Linear_Top6_Percent = Top6_Prob)
rf  <- readr::read_csv(file.path(DATA_DIR,"predictions_rf_2024_25.csv"), show_col_types = FALSE) %>%
  select(Club, RF = RF_Pred, RF_Top6_Percent = RF_Top6_Prob)

cmp <- lin %>% inner_join(rf, by="Club") %>%
  mutate(Linear_Resid = Actual - Linear,
         RF_Resid = Actual - RF)

print(knitr::kable(cmp %>% arrange(Linear), digits=1))
cat("\nTotal Absolute Residuals:\n")
cat(sprintf("Linear Model: %.1f\n", sum(abs(cmp$Linear_Resid))))
cat(sprintf("Random Forest: %.1f\n", sum(abs(cmp$RF_Resid))))

long <- cmp %>% select(Club, Actual, Linear, RF) %>%
  pivot_longer(cols=c(Linear,RF), names_to="Model", values_to="Predicted")

p <- ggplot(long, aes(Actual, Predicted, color=Model, shape=Model, label=Club)) +
  geom_point(size=3) + geom_text_repel(size=3) +
  geom_abline(slope=1, intercept=0, linetype="dashed") +
  scale_y_reverse(breaks=1:20) + scale_x_reverse(breaks=1:20) +
  labs(title="2024–25: Predicted vs Actual League Positions",
       subtitle="Linear (MV only) vs RF (No Net Spend)",
       x="Actual Position", y="Predicted Position") + theme_minimal()
ggsave(file.path(FIG_DIR,"compare_linear_vs_rf.png"), p, width=8, height=6, dpi=150)
