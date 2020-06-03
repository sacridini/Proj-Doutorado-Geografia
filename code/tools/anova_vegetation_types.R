(for_omb <- read.csv("~/doutorado/limites_past_vs_for/ombrofila/forest_stats.csv"))
(for_est <- read.csv("~/doutorado/limites_past_vs_for/estacionaria/forest_stats.csv"))

values_omb <- for_omb$median
values_est <- for_est$median
values <- c(values_omb, values_est)


names_omb <- rep("omb", length(values_omb))
names_est <- rep("est", length(values_est))
names <- c(names_omb, names_est) 
df <- data.frame(names, values)
plot(values ~ names, df)
vegtype_anova <- aov(values ~ names, data = df)
summary(vegtype_anova)
