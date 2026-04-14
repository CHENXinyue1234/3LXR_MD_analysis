library(dplyr)
library(ggplot2)

read_xvg <- function(file) {
  lines <- readLines(file)
  lines <- lines[!grepl("^[@#]", lines)]
  data <- read.table(text = lines)
  return(data)
}

gyrate_280 <- read_xvg("gyrate_280K.xvg")
gyrate_300 <- read_xvg("gyrate_300K.xvg")
gyrate_320 <- read_xvg("gyrate_320K.xvg")

colnames(gyrate_280) <- c("time_ps", "rg")
colnames(gyrate_300) <- c("time_ps", "rg")
colnames(gyrate_320) <- c("time_ps", "rg")

# Convert time from ps to ns
gyrate_280$time_ns <- gyrate_280$time_ps / 1000
gyrate_300$time_ns <- gyrate_300$time_ps / 1000
gyrate_320$time_ns <- gyrate_320$time_ps / 1000

gyrate_280$Temp <- "280 K"
gyrate_300$Temp <- "300 K"
gyrate_320$Temp <- "320 K"

# Combine into one data frame 
gyrate_all <- bind_rows(
  gyrate_280 %>% select(time_ns, rg, Temp),
  gyrate_300 %>% select(time_ns, rg, Temp),
  gyrate_320 %>% select(time_ns, rg, Temp)
)

# Plot
p <- ggplot(gyrate_all, aes(x = time_ns, y = rg, color = Temp)) +
  geom_line(linewidth = 0.3) +
  labs(
    title = "Radius of Gyration at Different Temperatures",
    x = "Time (ns)",
    y = "Rg (nm)"
  ) +
  scale_color_manual(values = c(
    "280 K" = "#1f77b4",
    "300 K" = "#2ca02c",
    "320 K" = "#d62728"
  )) +
  theme_bw(base_size = 10) +
  theme(
    legend.title = element_blank(),
    legend.position = "top"
  )

print(p)