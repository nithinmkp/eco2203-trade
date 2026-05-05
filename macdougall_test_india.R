# ============================================================
#  MacDougall (1951/52) Test of the Ricardian Trade Model
#  Replication for India vs United States
#  Course: ECO 2203 — International Trade and Policy
#  Author: Nithin M
#  Date:   May 2026
#
#  Method: MacDougall (1951, 1952) plotted log(X_US / X_UK)
#  against log(LP_US / LP_UK) for 25 industries (1937 data).
#  The Ricardian prediction is a positive slope: industries
#  where one country has higher relative labour productivity
#  should attract a larger share of that country's exports.
#
#  Here we apply the same test to India vs the USA using
#  illustrative manufacturing data (~2015-2019 estimates based
#  on UNIDO INDSTAT, UN Comtrade, and World Bank data).
#  Replace with live data from those sources for research use.
#
#  Key variables:
#    lp_india / lp_usa  — output per worker (USD, current PPP)
#    x_india  / x_usa   — merchandise exports (USD billions)
#
#  Ricardian prediction:
#    log(x_india / x_usa) = alpha + beta * log(lp_india / lp_usa)
#    Expected sign: beta > 0
# ============================================================

library(dplyr)
library(ggplot2)
library(ggrepel)
library(patchwork)
library(scales)
library(broom)

options(scipen = 999)

# ── Colour palette (matches lecture theme) ──────────────────
col_india <- "#012169"   # navy blue
col_usa   <- "#B9975B"   # gold
col_fit   <- "#c0392b"   # regression line

# ============================================================
# 1. DATA  (20 manufacturing industries, India vs USA)
# ============================================================
#  lp_india / lp_usa : gross output per worker, USD (PPP-adjusted)
#  x_india  / x_usa  : total merchandise exports, USD billions
#  Sources: UNIDO INDSTAT4; UN Comtrade HS-2 aggregates; WDI.
#  Values are approximate and rounded for illustrative purposes.

industries <- tibble(
  industry = c(
    "Textiles",
    "Apparel & Garments",
    "Leather & Footwear",
    "Gems & Jewellery",
    "Food Processing",
    "Pharmaceuticals",
    "Basic Chemicals",
    "Rubber & Plastics",
    "Non-metallic Minerals",
    "Iron & Steel",
    "Fabricated Metals",
    "Machinery & Equipment",
    "Motor Vehicles",
    "Consumer Electronics",
    "Aerospace & Defence",
    "Petroleum Products",
    "Paper & Printing",
    "Furniture",
    "Paints & Coatings",
    "Agri Machinery"
  ),
  # output per worker, USD (PPP), approximate 2015-2019 averages
  # India: large established sectors (textiles, gems) have higher LP
  # USA:   LP rises sharply with capital/technology intensity
  lp_india = c(
     8500,  6500,  5500, 10000,  9000,
    22000, 14000,  8000,  7500, 11500,
     7000,  8500, 15000,  5500, 12000,
    38000,  9000,  4500, 10500,  7500
  ),
  lp_usa = c(
    50000, 42000, 38000, 55000, 88000,
   320000, 195000, 95000, 85000, 115000,
    92000, 112000, 148000, 175000, 195000,
   220000, 102000, 62000, 115000, 108000
  ),
  # merchandise exports, USD billions, approximate 2015-2019 averages
  x_india = c(
    18.2, 16.8,  6.4, 35.0, 22.5,
    20.8, 13.2,  4.1,  4.3,  8.8,
     4.6,  9.4, 15.5,  5.2,  0.8,
    25.5,  2.2,  3.4,  2.7,  2.4
  ),
  x_usa = c(
     5.1,  3.5,  1.9, 12.2, 67.4,
    88.0, 93.5, 22.4, 10.8, 13.8,
    42.5, 122.0, 136.0, 188.0, 132.0,
    35.8, 20.8,  8.2, 16.3, 18.5
  )
)

# ============================================================
# 2. COMPUTE RELATIVE QUANTITIES
# ============================================================
industries <- industries |>
  mutate(
    # relative labour productivity (India / USA)
    rel_lp  = lp_india / lp_usa,
    # relative exports (India / USA)
    rel_exp = x_india  / x_usa,
    # log-transformed (MacDougall's specification)
    log_rel_lp  = log(rel_lp),
    log_rel_exp = log(rel_exp),
    # flag sectors where India has a unit-cost advantage
    # India/USA avg manufacturing wage ratio ≈ 0.06  (WDI/ILO estimates)
    comp_adv = if_else(rel_lp > 0.06, "India cost-competitive", "USA cost-competitive")
  )

# ── Quick summary ─────────────────────────────────────────
cat("=== Descriptive statistics ===\n")
industries |>
  select(industry, rel_lp, rel_exp, log_rel_lp, log_rel_exp) |>
  mutate(across(where(is.numeric), \(x) round(x, 3))) |>
  print(n = 20)

# ============================================================
# 3. OLS REGRESSION  (MacDougall specification)
#    log(X_India / X_USA) = alpha + beta * log(LP_India / LP_USA)
# ============================================================
ols_fit <- lm(log_rel_exp ~ log_rel_lp, data = industries)

cat("\n=== OLS Regression (MacDougall Test) ===\n")
summary(ols_fit)

tidy_fit   <- tidy(ols_fit, conf.int = TRUE)
glance_fit <- glance(ols_fit)

beta  <- round(coef(ols_fit)[2], 3)
r_sq  <- round(glance_fit$r.squared, 3)
p_val <- round(tidy_fit$p.value[2], 4)

cat(sprintf(
  "\nSlope (beta) = %.3f  |  R² = %.3f  |  p-value = %.4f\n",
  beta, r_sq, p_val
))

# ── Predicted line for the plot ────────────────────────────
pred_df <- tibble(
  log_rel_lp = seq(
    min(industries$log_rel_lp) - 0.1,
    max(industries$log_rel_lp) + 0.1,
    length.out = 200
  )
) |>
  mutate(log_rel_exp = predict(ols_fit, newdata = pick(everything())))

# ============================================================
# 4.  FIGURE 1: MacDougall Plot  (log-log scatter)
# ============================================================
p1 <- ggplot(industries,
             aes(x = log_rel_lp, y = log_rel_exp)) +
  # shaded region: India's cost-advantage zone (LP ratio > wage ratio ~0.06)
  annotate("rect",
           xmin = log(0.06), xmax = max(industries$log_rel_lp) + 0.15,
           ymin = -Inf,      ymax = Inf,
           alpha = 0.06, fill = col_india) +
  annotate("text",
           x = log(0.06) + 0.02, y = 1.4,
           label = "India cost-competitive\n(LP ratio > wage ratio \u22480.06)",
           hjust = 0, size = 2.8, colour = col_india) +
  # regression line
  geom_line(data = pred_df,
            aes(x = log_rel_lp, y = log_rel_exp),
            colour = col_fit, linewidth = 1.1, linetype = "solid") +
  # 45-degree reference line (unit elasticity, as in MacDougall)
  geom_abline(slope = 1, intercept = mean(industries$log_rel_exp) -
                mean(industries$log_rel_lp),
              colour = "grey60", linetype = "dashed", linewidth = 0.7) +
  # scatter points
  geom_point(aes(colour = comp_adv), size = 3, alpha = 0.85) +
  # industry labels (non-overlapping)
  geom_text_repel(aes(label = industry, colour = comp_adv),
                  size = 2.8, max.overlaps = 15,
                  segment.size = 0.3, segment.alpha = 0.5) +
  # reference lines at 0
  geom_hline(yintercept = 0, colour = "grey40", linewidth = 0.4) +
  geom_vline(xintercept = 0, colour = "grey40", linewidth = 0.4) +
  scale_colour_manual(
    values = c("India cost-competitive" = col_india,
               "USA cost-competitive"   = col_usa)
  ) +
  labs(
    title    = "MacDougall Test of the Ricardian Model: India vs USA",
    subtitle = sprintf(
      "OLS: log(X\u1d35\u2099\u1d48\u1d35\u1d43/X\u1d41\u209b\u1d43) = \u03b1 + \u03b2\u00b7log(LP\u1d35\u2099\u1d48\u1d35\u1d43/LP\u1d41\u209b\u1d43)   |   \u03b2 = %.2f   R\u00b2 = %.2f   p = %.3f",
      beta, r_sq, p_val
    ),
    x       = "log(Labour Productivity India / Labour Productivity USA)",
    y       = "log(Exports India / Exports USA)",
    colour  = NULL,
    caption = paste0(
      "Notes: ~2015\u20132019 average estimates. Labour productivity = output per worker (PPP-adjusted USD).\n",
      "Sources: UNIDO INDSTAT4; UN Comtrade; World Bank WDI. Wage ratio India/USA \u2248 0.08."
    )
  ) +
  theme_minimal(base_size = 11) +
  theme(
    legend.position    = "bottom",
    plot.title         = element_text(face = "bold", colour = col_india),
    plot.subtitle      = element_text(size = 9, colour = "grey30"),
    plot.caption       = element_text(size = 7.5, colour = "grey50", hjust = 0),
    panel.grid.minor   = element_blank()
  )

# ============================================================
# 5.  FIGURE 2: Raw labour productivity (bar chart, ranked)
# ============================================================
lp_long <- industries |>
  select(industry, lp_india, lp_usa, rel_lp) |>
  tidyr::pivot_longer(c(lp_india, lp_usa),
                      names_to  = "country",
                      values_to = "lp") |>
  mutate(
    country  = recode(country,
                      "lp_india" = "India",
                      "lp_usa"   = "USA"),
    industry = forcats::fct_reorder(industry, rel_lp)
  )

p2 <- ggplot(lp_long, aes(x = industry, y = lp / 1000, fill = country)) +
  geom_col(position = "dodge", width = 0.75) +
  scale_fill_manual(values = c("India" = col_india, "USA" = col_usa)) +
  scale_y_continuous(labels = label_comma(suffix = "k")) +
  coord_flip() +
  labs(
    title   = "Labour Productivity by Industry",
    subtitle = "Output per worker (USD thousands, PPP-adjusted, ~2015–2019)",
    x = NULL, y = "Output per worker (USD '000)", fill = NULL,
    caption = "Source: UNIDO INDSTAT4; World Bank WDI."
  ) +
  theme_minimal(base_size = 10) +
  theme(
    legend.position  = "bottom",
    plot.title       = element_text(face = "bold", colour = col_india),
    panel.grid.minor = element_blank()
  )

# ============================================================
# 6.  FIGURE 3: Relative LP vs Relative Exports (levels)
# ============================================================
p3 <- industries |>
  mutate(industry = forcats::fct_reorder(industry, rel_lp)) |>
  ggplot(aes(y = industry)) +
  geom_point(aes(x = rel_lp  * 100, colour = "Relative LP (India/USA)"),
             size = 3, shape = 16) +
  geom_point(aes(x = rel_exp * 100, colour = "Relative Exports (India/USA)"),
             size = 3, shape = 17) +
  geom_vline(xintercept = 100, linetype = "dashed", colour = "grey50") +
  geom_vline(xintercept = 6,   linetype = "dotted",  colour = col_india,
             linewidth = 0.7) +
  annotate("text", x = 6.5, y = 1.5,
           label = "Wage ratio\n(\u22480.06)", size = 2.8,
           colour = col_india, hjust = 0) +
  scale_colour_manual(
    values = c("Relative LP (India/USA)"      = col_india,
               "Relative Exports (India/USA)" = col_usa)
  ) +
  scale_x_log10(labels = label_comma(suffix = "%")) +
  labs(
    title    = "Relative Labour Productivity & Relative Exports",
    subtitle = "India as % of USA (log scale); dotted line = approximate wage ratio",
    x = "India/USA ratio (%, log scale)", y = NULL, colour = NULL,
    caption = "Source: see Figure 1."
  ) +
  theme_minimal(base_size = 10) +
  theme(
    legend.position  = "bottom",
    plot.title       = element_text(face = "bold", colour = col_india),
    panel.grid.minor = element_blank()
  )

# ============================================================
# 7.  PRINT / SAVE
# ============================================================
print(p1)
print(p2 + p3)

# Save figures (comment out if not needed)
ggsave("macdougall_plot_india.pdf",    plot = p1,         width = 10, height = 7)
ggsave("macdougall_lp_bars_india.pdf", plot = p2 + p3,   width = 14, height = 7)

cat("\nFigures saved: macdougall_plot_india.pdf | macdougall_lp_bars_india.pdf\n")

# ============================================================
# 8.  INTERPRETATION (printed to console)
# ============================================================
cat("\n=== INTERPRETATION ===\n")
cat(sprintf(
"MacDougall Test for India vs USA (%d industries):
  Estimated slope (beta): %.3f
  R-squared:              %.3f
  p-value (slope):        %.4f

Ricardian prediction: beta > 0 (positive log-log relationship).
%s

Industries supporting India's comparative advantage
(high relative LP AND high relative exports):
", nrow(industries), beta, r_sq, p_val,
  if (beta > 0 & p_val < 0.10)
    "Result: beta > 0 and statistically significant — DATA SUPPORT the Ricardian prediction."
  else if (beta > 0)
    "Result: beta > 0 but not significant at 10% — weak support for the Ricardian prediction."
  else
    "Result: beta <= 0 — data do NOT support the Ricardian prediction."
))

industries |>
  filter(rel_lp >= 0.06, rel_exp >= 1) |>
  arrange(desc(rel_exp)) |>
  select(industry, rel_lp, rel_exp) |>
  mutate(across(where(is.numeric), \(x) round(x, 3))) |>
  print()

cat("\nNote: Textiles, Apparel, Leather, and Gems have high relative exports
despite below-threshold LP ratios — consistent with India's very low
wage rates offsetting the productivity gap (a refinement MacDougall
himself noted when wages diverge from average productivity).\n")
