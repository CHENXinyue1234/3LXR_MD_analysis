library(dplyr)
library(ggplot2)

read_xvg <- function(file) {
  lines <- readLines(file)
  lines <- lines[!grepl("^[@#]", lines)]
  data <- read.table(text = lines)
  return(data)
}

rmsd_280 <- read_xvg("rmsd_280_equil.xvg")
rmsd_300 <- read_xvg("rmsd_300_equil.xvg")
rmsd_320 <- read_xvg("rmsd_320_equil.xvg")

colnames(rmsd_280) <- c("time", "rmsd")
colnames(rmsd_300) <- c("time", "rmsd")
colnames(rmsd_320) <- c("time", "rmsd")

rmsd_280$Temp <- "280 K"
rmsd_300$Temp <- "300 K"
rmsd_320$Temp <- "320 K"

# Combine all datasets into one dataframe
rmsd_all <- bind_rows(rmsd_280, rmsd_300, rmsd_320)

# Plot
p <- ggplot(rmsd_all, aes(x = time, y = rmsd, color = Temp)) +
  geom_line(linewidth = 0.3) +
  labs(
    title = "Backbone RMSD at Different Temperatures",
    x = "Time (ns)",
    y = "RMSD (nm)"
  ) +
  scale_color_manual(values = c(
    "280 K" = "#1f77b4",  # blue
    "300 K" = "#2ca02c",  # green
    "320 K" = "#d62728"   # red
  )) +
  theme_bw(base_size = 10) +
  theme(
    legend.title = element_blank(),
    legend.position = "top"
  )

print(p)
