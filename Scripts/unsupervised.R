# Instalación de paquetes (si no los tienes)
install.packages(c("tidyverse", "Rtsne", "factoextra", "cluster"))

# Cargar bibliotecas
library(tidyverse)  # Manipulación de datos
library(Rtsne)      # t-SNE
library(factoextra) # Visualización de clusterización
library(cluster)    # Algoritmos de clusterización

# Cargar datos
getwd()
clases <- read.csv("classes.csv", sep = ";", header = FALSE, col.names = c("Muestra", "Clase"))
gene_exp <- read.csv("gene_expression.csv", sep = ";", header = FALSE, col.names = readLines("column_names.txt"), row.names = clases$Muestra)


# Filtrar genes con varianza mínima (ejemplo: eliminar genes constantes)
varianza <- apply(gene_exp, 2, var)
gene_exp <- gene_exp[, varianza > 1e-3]

# Imputar valores NA (utilizamos la media en este caso)
gene_exp[is.na(gene_exp)] <- rowMeans(gene_exp, na.rm = TRUE)

# Escalar los datos
gene_exp_scaled <- scale(gene_exp)


#METODOS NO SUPERVISADOS (PCA, T-SNE Y CLUSTERIZACION)
#PCA Reduccion de dimensionalidad

# 1. Realizar PCA
pca_result <- prcomp(gene_exp_scaled, center = TRUE, scale. = FALSE)
# Extraer la varianza explicada
varianza_explicada <- (pca_result$sdev^2) / sum(pca_result$sdev^2)
varianza_acumulada <- cumsum(varianza_explicada)
# Gráfico de varianza acumulada
var_plot <- data.frame(Componente = 1:length(varianza_acumulada), Varianza = varianza_acumulada)
ggplot(var_plot, aes(x = Componente, y = Varianza)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  labs(title = "Varianza Explicada Acumulada", x = "Componente", y = "Varianza Acumulada") +
  theme_minimal()
# Gráfico de los dos primeros componentes principales
pca_data <- as.data.frame(pca_result$x[, 1:2])
pca_data$Clase <- clases$Clase
ggplot(pca_data, aes(x = PC1, y = PC2, color = Clase)) +
  geom_point(size = 2) +
  labs(title = "PCA: Proyección en 2 Componentes", x = "PC1", y = "PC2", color = "Clase") +
  theme_minimal()


# 2. Realizar t-SNE 
set.seed(123)  # Para reproducibilidad
tsne_result <- Rtsne(gene_exp_scaled, dims = 2, perplexity = 30, verbose = TRUE)

# Convertir a data frame para graficar
tsne_data <- as.data.frame(tsne_result$Y)
colnames(tsne_data) <- c("Dim1", "Dim2")
tsne_data$Clase <- clases$Clase

# Gráfico t-SNE
ggplot(tsne_data, aes(x = Dim1, y = Dim2, color = Clase)) +
  geom_point(size = 2) +
  labs(title = "t-SNE: Proyección en 2D", x = "Dimensión 1", y = "Dimensión 2", color = "Clase") +
  theme_minimal()

# 3. Realizar Clusterizacion
#Realizamos clusterización usando K-means y jerárquica.

# K-means (con 3 clústeres) 
set.seed(123)
kmeans_result <- kmeans(gene_exp_scaled, centers = 3, nstart = 25)
# Gráfico de clusters
fviz_cluster(kmeans_result, data = gene_exp_scaled, stand = FALSE, geom = "point") +
  labs(title = "Clusterización K-means", x = "Dimensión 1", y = "Dimensión 2")


