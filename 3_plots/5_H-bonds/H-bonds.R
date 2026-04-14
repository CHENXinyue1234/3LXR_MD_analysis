library(ggplot2)

# Load hydrogen bond data
df_hb <- read.table("hbond_summary.csv", header = TRUE)

# Plot H-bonds vs temperature
p_hb <- ggplot(df_hb, aes(x = Temperature, y = H_bonds, color = Interaction)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 3) +
  # Label each point
  geom_text(aes(label = H_bonds),
            vjust = -1, size = 3.5) +
  # Axes and labels
  labs(
    x = "Temperature (K)",
    y = "Number of H-bonds",
    color = "Interaction"
  ) +
  scale_x_continuous(breaks = c(280, 300, 320), limits = c(270, 330)) +
  scale_y_continuous(
    limits = c(0, 20),
    expand = expansion(mult = c(0, 0.05))
  ) +
  scale_color_manual(values = c(
    "RhoA-IpgB2" = "firebrick",
    "RhoA-GDP" = "#1f77b4"
  )) +
  theme_bw(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", hjust = 0.5),
    legend.position = "none"
  ) 

print(p_hb)