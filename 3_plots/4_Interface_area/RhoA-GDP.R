library(ggplot2)
library(dplyr)
library(tidyr)

pisa_gdp_data <- read.csv("RhoA-GDP_interface_data.csv")

pisa_gdp_data$Temp <- factor(pisa_gdp_data$Temp, levels = c("280", "300", "320"))

pisa_gdp_long <- pisa_gdp_data %>%
  pivot_longer(
    cols = c(Interface_Area, DeltaG),
    names_to = "Metric",
    values_to = "Value"
  ) %>%
  mutate(label = sprintf("%.1f", Value))

pisa_gdp_long$Metric <- factor(pisa_gdp_long$Metric,
                               levels = c("Interface_Area", "DeltaG"))

# Plot
p <- ggplot(pisa_gdp_long, aes(x = Temp, y = Value, fill = Temp)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = label, vjust = ifelse(Value > 0, -0.5, 1.5)), size = 3) +
  facet_wrap(~ Metric, scales = "free_y", nrow = 1,
             labeller = labeller(Metric = c(
               "Interface_Area" = "Interface area (Å²)",
               "DeltaG" = "ΔG (kcal/mol)"
             ))) +
  scale_fill_manual(values = c("280" = "#1f77b4", "300" = "#2ca02c", "320" = "#d62728")) +
  labs(x = "Temperature (K)", y = NULL) +
  theme_bw(base_size = 10) +
  theme(legend.position = "none",
        strip.background = element_rect(fill = "white"),
        strip.text = element_text(face = "plain"))

print(p)