theme_pca <- theme_minimal() +
  theme(
    axis.title.x = element_text(hjust = 1, size = 10),
    axis.title.y = element_text(hjust = 1, size = 10, angle = 0))

my_pca <- function(res.pca, ...) {
  lambdas <- res.pca$sdev
  taus <- 100 * lambdas / sum(lambdas)
  zelabels <- sprintf("Dim. %i\n(%0.2f%%)", seq_along(taus), taus)

  dat.pca <- as_tibble(res.pca$x)

  dat.pca %>%
    ggplot(aes(x = PC1, y = PC2)) +
    geom_hline(yintercept = 0, color = "grey") +
    geom_vline(xintercept = 0, color = "grey") +
    geom_point(size = 5) +
    coord_equal() +
    labs(x = zelabels[1], y = zelabels[2]) +
    theme_pca
}




