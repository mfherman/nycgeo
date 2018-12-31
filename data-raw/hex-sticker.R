library(hexSticker)
library(nycgeo)
library(ggplot2)

puma_plot <- nyc_boundaries("puma", add_acs_data = TRUE) %>%
  ggplot() +
  geom_sf(aes(fill = med_age_est), lwd = 0.1) +
  scale_fill_viridis_c(option = "magma") +
  theme_void() +
  theme(
    panel.grid = element_line(color = "transparent"),
    legend.position = "none"
    )

sticker(
  puma_plot,
  package = "nycgeo",
  p_family = "source-sans",
  p_size = 8,
  p_y = 0.5,
  h_fill = "#ACBFBF",
  h_color = "#F9B693",
  s_x = 1,
  s_y = 1.18,
  s_width = 2,
  s_height = 1.25,
  filename = "man/figures/logo.png",
  url = "nycgeo.mattherman.info",
  u_family = "incons",
  u_color = "#454D4D",
  u_size = 1.3,
  u_x = 0.35,
  u_y = 1.55
  )


sticker(
  puma_plot,
  package = "nycgeo",
  p_family = "source-sans",
  p_size = 8,
  p_y = 0.5,
  h_fill = "#ACBFBF",
  h_color = "#F9B693",
  s_x = 1,
  s_y = 1.18,
  s_width = 2,
  s_height = 1.25,
  filename = "man/figures/logo-hi.png",
  url = "nycgeo.mattherman.info",
  u_family = "incons",
  u_color = "#454D4D",
  u_size = 1.3,
  u_x = 0.35,
  u_y = 1.55,
  dpi = 600
)


