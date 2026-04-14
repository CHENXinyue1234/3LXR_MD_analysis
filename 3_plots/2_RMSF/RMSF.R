library(dplyr)
library(ggplot2)

read_xvg <- function(file) {
  lines <- readLines(file)
  lines <- lines[!grepl("^[@#]", lines)]
  data <- read.table(text = lines)
  return(data)
}

rmsf_280 <- read_xvg("rmsf_ca_280K.xvg")
rmsf_300 <- read_xvg("rmsf_ca_300K.xvg")
rmsf_320 <- read_xvg("rmsf_ca_320K.xvg")

colnames(rmsf_280) <- c("Residue", "RMSF")
colnames(rmsf_300) <- c("Residue", "RMSF")
colnames(rmsf_320) <- c("Residue", "RMSF")

rmsf_280$Temp <- "280 K"
rmsf_300$Temp <- "300 K"
rmsf_320$Temp <- "320 K"

rmsf_all <- bind_rows(rmsf_280, rmsf_300, rmsf_320)

# Plot
p <- ggplot(rmsf_all, aes(x = Residue, y = RMSF, color = Temp)) +
  geom_line(linewidth = 0.3) +  
  labs(
    title = "RMSF of Protein Residues at Different Temperatures",
    x = "Residue Number",
    y = "RMSF (nm)"
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