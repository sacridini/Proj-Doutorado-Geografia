(for_omb <- read.csv("~/doutorado/limites_past_vs_for/ombrofila/forest_stats.csv"))
(for_est <- read.csv("~/doutorado/limites_past_vs_for/estacionaria/forest_stats.csv"))

(past_omb <- read.csv("~/doutorado/limites_past_vs_for/ombrofila/pasture_stats.csv"))
(past_est <- read.csv("~/doutorado/limites_past_vs_for/estacionaria/pasture_stats.csv"))

values_omb_for <- for_omb$median
values_est_for <- for_est$median
values_for <- c(values_omb_for, values_est_for)

values_omb_past <- past_omb$median
values_est_past <- past_est$median
values_past <- c(values_omb_past, values_est_past)

values <- c(values_for, values_past)

names_omb <- rep("omb", length(values_omb_for))
names_est <- rep("est", length(values_est_for))
names <- c(names_omb, names_est) 
df <- data.frame(names, values)
plot(values ~ names, df, xlab = "Vegetation Type", ylab = "NDVI Values")
vegtype_anova <- aov(values ~ names, data = df)
summary(vegtype_anova)

new_df <- data.frame(vegtype = names,
                     forest = values_for,
                     pasture = values_past)
ggplot(new_df, aes(x = forest, y = pasture)) + 
  geom_point() + 
  theme_bw() + 
  geom_smooth()
