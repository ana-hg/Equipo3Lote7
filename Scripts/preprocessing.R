## ---- Libraries ----
library(readr) #Read data
library(tidyverse) #Dataframes
library(dplyr) #Dataframes and pipes
library(patchwork)
library(caret) #Predictive models


# ---- Data and preprocessing ----
#Data
clases <- read.csv("classes.csv", sep = ";", header = FALSE, col.names = c("Muestra","Clase"))
gene_exp <- read.csv("gene_expression.csv", sep = ";", header = FALSE, col.names = readLines("column_names.txt"), row.names = clases[,1])

#Delete columns that are = 0
suma <- colSums(gene_exp)
cero <- names(suma[suma == 0])
datos <- gene_exp[ , !(names(gene_exp) %in% cero)]

#Impute NAs
if (any(is.na(datos))){
  impute_na <- function(x) replace(x, is.na(x), median(x, na.rm = TRUE)) #we use the median
  datos <- datos %>% mutate(across(where(is.numeric), impute_na))
}

#Bind columns
datos.num <- sapply(datos, as.numeric) #numeric transformation 
datos.raw <- cbind(clases["Clase"], datos.num)
datos.raw$Clase <- as.factor(datos.raw$Clase)

# ---- Data division for supervised analysis ----
set.seed(1995)
training.samples <- datos.raw$Clase %>% createDataPartition(p = 0.8, list = FALSE) #training data (80%) and test data (20%)
training.clase <- datos.raw[training.samples,]
testing.clase <- datos.raw[-training.samples,]

#Data scaling (training)
numerical_columns <- training.clase[, sapply(training.clase, is.numeric)] #Seleccionamos las columnas que presentan variables numéricas
scaled_data <- scale(numerical_columns) #Escalado
training.clase <- cbind(scaled_data, Clase = training.clase$Clase) #Unimos las columnas numéricas a la columna "Clase"
training.clase <- as.data.frame(training.clase) #Transformamos los datos seleccionados en dataframes

#Data scaling (testing)
numerical_columns <- testing.clase[, sapply(testing.clase, is.numeric)] #Seleccionamos las columnas que presentan variables numéricas
scaled_data <- scale(numerical_columns) #Escalado
testing.clase <- cbind(Clase = testing.clase$Clase, scaled_data) #Unimos las columnas numéricas a la columna "Clase"
testing.clase <- as.data.frame(testing.clase) #Transformamos los datos seleccionados en dataframes

#Formula creation
genes <- colnames(training.clase[1:30]) #gene names
formula.clase <- as.formula(paste("Clase ~", paste(genes, collapse = "+")))
training.clase$Clase <- as.factor(training.clase$Clase) #class as factor
testing.clase$Clase <- as.factor(testing.clase$Clase) #class as factor
