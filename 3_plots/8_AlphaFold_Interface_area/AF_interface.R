library(ggplot2)
library(dplyr)
library(tidyr)

df_all <- read.csv("AF_interface.csv")

df_all$Structure <- factor(df_all$Structure, 
                           levels = c("AlphaFold", "280 K", "300 K", "320 K"))

# Convert to long format
df_long <- df_all %>%
  pivot_longer(
    cols = c(Interface_Area, Delta_G),
    names_to = "Metric",
    values_to = "Value"
  )

df_long$Metric <- factor(df_long$Metric,
                         levels = c("Interface_Area", "Delta_G"))
metric_labeller <- labeller(
  Metric = c(
    "Interface_Area" = "Interface area (Å²)",
    "Delta_G" = "ΔG (kcal/mol)"
  )
)

# Create faceted bar plot
p_interface <- ggplot(df_long, aes(x = Structure, y = Value, fill = Structure)) +
  geom_col(width = 0.7) +
  facet_wrap(~ Metric, scales = "free_y", nrow = 1, labeller = metric_labeller) +
  scale_fill_manual(
    values = c("AlphaFold" = "gray60",
               "280 K"    = "#1f77b4",
               "300 K"    = "#2ca02c",
               "320 K"    = "#d62728"),
    guide = "none"
  ) +
  geom_text(
    aes(label = ifelse(Metric == "Interface_Area",
                       round(Value, 0),
                       round(Value, 1))),
    vjust = -0.5,
    size = 3.5
  ) +
  labs(x = NULL, y = NULL) +
  theme_bw(base_size = 12) +
  theme(
    strip.text = element_text(face = "bold", size = 11),
    axis.text.x = element_text(angle = 20, hjust = 1),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", hjust = 0.5)
  ) +
  ggtitle("IpgB2-RhoA")

print(p_interface)