### ---- Confusion Matrix (unsupervised) ----
plot_confusion_matrix <- function(conf_matrix, title) {
  cm <- as.data.frame(conf_matrix$table)
  ggplot(cm, aes(Prediction, Reference, fill = Freq)) +
    geom_tile(color = "black") +
    geom_text(aes(label = Freq), color = "black", size = 4) +
    scale_fill_gradient(low = "white", high = "mediumpurple") +
    labs(title = title, x = "Predicción", y = "Referencia") +
    theme_minimal()
}

plot.lda <- plot_confusion_matrix(confusion.lda, "Matriz de confusion LDA")
plot.rda <- plot_confusion_matrix(confusion.rda, "Matriz de confusion RDA")
plot.knn <- plot_confusion_matrix(confusion.knn, "Matriz de confusion k-NN")

lista_plots <- list(plot.lda, plot.rda, plot.knn)
conjunto <- wrap_plots(lista_plots, ncol = 3, nrow = 1, axis_titles = "collect", legend = "collect")
conjunto

### ---- Metrics (Unsupervised) ----
lista_confusion <- list(confusion.lda, confusion.rda, confusion.knn)
lista_metodos <- c("LDA", "RDA", "k-NN")
metricas_evaluacion <- data.frame(Método = lista_metodos, Exactitud = numeric(3), Precisión = numeric(3), Sensibilidad = numeric(3), Especificidad = numeric(3), F1score = numeric(3))

calculos_metricas <- function(confusion_matrix) { #Creamos una función para calcular las medias de los valores. 
  accuracy <- as.numeric(confusion_matrix$overall["Accuracy"])
  sensibility <- as.numeric(mean(confusion_matrix$byClass[, "Sensitivity"]))
  specificity <- as.numeric(mean(confusion_matrix$byClass[, "Specificity"]))
  precision <- as.numeric(mean(confusion_matrix$byClass[, "Pos Pred Value"])) #La precisión es el pos pred value
  f1_score <- as.numeric(2*(precision*sensibility)/(precision + sensibility)) #Es necesario calcular la F1 score que depende de la prec y sensi
  list( #Creamos una lista con los resultados generados
    accuracy = accuracy, 
    sensibility = sensibility,
    specificity = specificity,
    precision = precision,
    f1_score = f1_score
  )
}

for (i in 1:3) { #1:3 porque hemos utilizado 3 métodos diferentes
  matriz <- lista_confusion[[i]]
  resultado <- calculos_metricas(matriz)
  metricas_evaluacion[i, "Exactitud"] <- resultado$accuracy #Añadimos los valores de las métricas al dataframe. 
  metricas_evaluacion[i, "Precisión"] <- resultado$precision
  metricas_evaluacion[i, "Sensibilidad"] <- resultado$sensibility
  metricas_evaluacion[i, "Especificidad"] <- resultado$specificity
  metricas_evaluacion[i, "F1score"] <- resultado$f1_score
}

metricas_largo <- pivot_longer(metricas_evaluacion, cols = -Método, names_to = "Métrica", values_to = "Valor") #Pasamos el df de wide a long.

ggplot(metricas_largo, aes(x = Métrica, y = Valor, fill = Método)) + #Graficamos el df generado
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(
    aes(label = round(Valor, 3)), 
    position = position_dodge(width = 0.8),
    vjust = -0.3, 
    size = 3) +
  scale_fill_brewer(palette = "Set3") +
  labs(
    title = "Comparación de las métricas de cada uno de los métodos",
    x = "Métrica",
    y = "Valor"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
