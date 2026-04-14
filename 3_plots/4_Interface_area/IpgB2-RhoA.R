library(ggplot2)
library(dplyr)
library(tidyr)

pisa_data <- read.csv("IpgB2-RhoA_interface_data.csv", header = TRUE)

# Set temperature order
pisa_data$Temp <- factor(pisa_data$Temp, levels = c("280", "300", "320"))

# Reshape to long format
pisa_long <- pisa_data %>%
  pivot_longer(cols = c(Interface_Area, deltaG),
               names_to = "Metric", values_to = "Value")

pisa_long$Metric <- factor(pisa_long$Metric,
                           levels = c("Interface_Area", "deltaG"))

temp_colors <- c("280" = "#1f77b4", "300" = "#2ca02c", "320" = "#d62728")

# Plot
p <- ggplot(pisa_long, aes(x = Temp, y = Value, fill = Temp)) +
  geom_col() +
  geom_text(aes(label = round(Value, 1)), vjust = -0.5, size = 3.5) +  # Add value labels
  facet_wrap(~ Metric, scales = "free_y", nrow = 1,
             labeller = labeller(Metric = c("Interface_Area" = "Interface area (Å²)",
                                            "deltaG" = "ΔG (kcal/mol)"))) +
  scale_fill_manual(values = temp_colors) +  # Apply custom colors
  theme_bw()

print(p)