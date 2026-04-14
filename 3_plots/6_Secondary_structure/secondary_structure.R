library(ggplot2)
library(dplyr)

parse_dssp <- function(f) {
  temp <- sub("_nohd\\.dssp$", "", basename(f))
  lines <- readLines(f, warn = FALSE)
  start <- grep("^  #  RESIDUE", lines)[1]
  if (is.na(start)) stop("No data found")
  codes <- substr(lines[(start+1):length(lines)], 17, 17)
  codes <- codes[!grepl("!\\*", codes) & nchar(codes) == 1]
  
  total <- length(codes)
  helix <- sum(codes %in% c("H","G","I"))
  sheet <- sum(codes == "E")
  
  data.frame(Temperature = temp, 
             Structure = c("Helix","Sheet","Coil"),
             Percentage = c(helix, sheet, total-helix-sheet) / total * 100)
}

# Read and combine all files
files <- c("280K_nohd.dssp","300K_nohd.dssp","320K_nohd.dssp")
dssp_data <- do.call(rbind, lapply(files, parse_dssp))


dssp_data <- dssp_data %>%
  mutate(Temperature = factor(Temperature, c("280K","300K","320K"))) %>%
  group_by(Temperature) %>%
  arrange(desc(Structure)) %>%
  mutate(cumulative = cumsum(Percentage),
         midpoint = cumulative - Percentage/2,
         label = paste0(round(Percentage,1), "%")) %>%
  ungroup()

# Plot
ggplot(dssp_data, aes(x = "", y = Percentage, fill = Structure)) +
  geom_col(width = 1, color = "white") +
  geom_text(aes(y = midpoint, label = label), size = 3.5) +
  facet_wrap(~ Temperature) +
  coord_polar(theta = "y") +
  scale_fill_manual(values = c("#E6CBA0","#C7C7E2","#BFD8B8")) +
  theme_void() +
  theme(strip.text = element_text(size = 12, face = "bold"),
        legend.title = element_blank(),
        legend.text = element_text(size = 9),
        legend.position = "right")