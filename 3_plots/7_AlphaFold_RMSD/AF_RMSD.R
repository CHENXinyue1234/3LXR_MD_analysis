library(ggplot2)

df_rmsd <- read.csv("AF_RMSD.csv")

p_rmsd <- ggplot(df_rmsd, aes(x = Temperature, y = RMSD)) +
  geom_line(color = "firebrick", linewidth = 1.2) +
  geom_point(color = "firebrick", size = 3) +
  geom_text(aes(label = sprintf("%.3f", RMSD)),
            vjust = -1, size = 3.5, color = "firebrick") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray50", alpha = 0.6) +
  labs(x = "Temperature (K)", y = expression("RMSD to AlphaFold (" * ring(A) * ")")) +
  scale_x_continuous(breaks = c(280, 300, 320), limits = c(270, 330)) +
  scale_y_continuous(limits = c(0, 2.3), expand = expansion(mult = c(0, 0.05))) +
  theme_bw(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", hjust = 0.5)
  ) 

print(p_rmsd)