# RNA-Seq Analysis - Equipo3Lote7

## 📚 Introducción  
Este proyecto grupal tiene como objetivo principal el análisis de secuencias de ARN mediante herramientas bioinformáticas y técnicas de machine learning. A través de la secuenciación de ARN (RNA-Seq), buscamos explorar y comprender los procesos biológicos que regulan la expresión génica, identificando patrones, variantes genéticas y posibles transcripciones novedosas.  

Al integrar estrategias computacionales avanzadas, este análisis proporciona una base para investigar procesos en áreas como la biología molecular y la investigación biomédica, fortaleciendo habilidades clave en genómica y biología computacional.  

---

## 🎯 Objetivos del Proyecto  

### **RNA-Seq Analysis**  

### **Machine Learning en Datos Biológicos**  
1. Implementar técnicas de aprendizaje supervisado y no supervisado con la base de datos.  
2. Explorar métodos como:  
   - **Reducción de dimensionalidad:** PCA y t-SNE.  
   - **Clusterización:** K-means y clustering jerárquico.  
   - **Modelos supervisados:** LDA,RDA y KNN.  
3. Generar visualizaciones comparativas y matrices de confusión.  

---
## 🛠️ Tecnologías Utilizadas  

### **Lenguaje y Entorno**  
- **Lenguaje:** R  
- **Entorno:** RStudio  

### **Bibliotecas de R y Propósitos**  

#### **Manejo y Transformación de Datos**  
- **`readr`:** Lectura de datos desde archivos CSV.  
- **`tidyverse`:** paquetes que permite una manipulación de datos, transformación y limpieza eficiente.  
- **`dplyr`:** Manejo y transformación de dataframes .  

#### **Visualización de Datos**  
- **`ggplot2`:** Creación de gráficos personalizados y visualizaciones.  
- **`patchwork`:** Organización y combinación de múltiples gráficos en uno.  

#### **Métodos no supervisados (Reducción de Dimensionalidad y Clustering)**  
- **`stats`:** Implementación de Análisis de Componentes Principales (**PCA**) para la reducción de dimensionalidad.  
- **`Rtsne`:** Implementación de Algoritmo t-SNE para visualizar datos de alta dimensionalidad en espacios bidimensionales.  
- **`FNN`:** Evaluación de la conservación de vecinos en visualizaciones t-SNE.  
- **`factoextra`:** Implementación de Visualización de métodos de clustering y optimización de parámetros.  
- **`ggdendro`:** Permite crear dendrogramas para representar el clustering jerárquico.  
- **`cluster`:** Herramientas para realizar y evaluar clusterización jerárquica y particional.  

#### **Métodos supervisados**  
- **`caret`:** Desarrollo, entrenamiento y evaluación de modelos predictivos, como knn.  
- **`MASS`:** Implementación de Análisis Discriminante Lineal (**LDA**) para la clasificación supervisada.  
- **`klaR`:** Implementación de Análisis Discriminante Regularizado (**RDA**) para datos con alta correlación.  
- **`gridExtra`:** Organización de múltiples visualizaciones como matrices de confusión en un informe integrado.  

---

### **Propósito y Beneficios de las Herramientas**  
Estas tecnologías trabajan en conjunto para:  
1. Procesar grandes volúmenes de datos genómicos.  
2. Identificar patrones relevantes en la expresión génica.  
3. Construir modelos predictivos robustos para clasificar muestras o predecir condiciones experimentales.  
4. Generar visualizaciones impactantes que respalden las interpretaciones biológicas de los datos.  

### Datos Proporcionados  
1. **Classes:** Clasificación de las muestras.  
2. **Column_names:** Nombres de los genes analizados.  
3. **Gene_expression:** Matriz de expresión génica (genes x muestras).  

---

## 📂 Estructura del Proyecto  

```plaintext
RNA-Seq-Analysis-Equipo-3-lote-7/
├── data/                     # Archivos de los datos crudos y procesados  
├── scripts/                  # Scripts en R para cada uno de los paso del análisis  
│   ├── preprocessing.R       # Limpieza e imputación de datos  
│   ├── unsupervised.R        # Modelos no supervisadosPCA, t-SNE y clusterización  
│   ├── supervised.R          # Modelos supervisados y métricas de evaluación  
│   └── visualization.R       # Gráficos y visualizaciones  
├── results/                  # Resultados procesados e interpretaciones 
│   ├── figures/              # Visualizaciones y gráficos  
│   └── reports/              # Reportes en Markdown o html 
├── README.md                 # Descripción del proyecto de análisis
└── environment.yml           # Dependencias y entorno virtual  
```

---

## 🚀 Pasos Principales  

### 1. **Preparación del Entorno de Trabajo:**  
   - Cargar las bibliotecas necesarias para el análisis, incluyendo manejo de datos, visualización, reducción de dimensionalidad, clustering y modelos predictivos:  
     - **`readr` y `dplyr`:** Para la lectura y transformación de los datos.  
     - **`ggplot2` y `patchwork`:** Para la creación y organización de gráficos.  
   - Configurar el entorno en RStudio para estructurar scripts, datos y resultados.  

### 2. **Procesamiento y Análisis de Datos:**  
   - Realizar el procesamiento inicial de los datos:  
     - Utilizar **`readr`** para cargar datos desde archivos CSV o TXT.  
     - Usar **`dplyr`** para transformar y limpiar los datos, incluyendo la imputación de valores faltantes.  
   - 
### 3. **Métodos no supervisados:**     
   Aplicar métodos de reducción de dimensionalidad:  
     - **`stats`:** Realizar Análisis de Componentes Principales (**PCA**) para explorar patrones globales en los datos.  
     - **`Rtsne`:** Implementar t-SNE para visualizar relaciones locales en los datos de alta dimensionalidad.  
   - Identificar agrupaciones en los datos mediante clustering:  
     - **`factoextra`:** Visualizar los resultados del clustering y optimizar el número de clusters.  
     - **`cluster`:** Aplicar métodos de clusterización jerárquica y particional.  
     - **`ggdendro`:** Crear dendrogramas para representar la estructura jerárquica de los clusters.  

### 4. **Métodos supervisados:**  
   - Desarrollar y evaluar modelos de aprendizaje supervisado:  
     - **`caret`:** Construir modelos como regresión logística, árboles de decisión y SVM.  
     - **`MASS`:** Implementar Análisis Discriminante Lineal (**LDA**) para tareas de clasificación supervisada.  
     - **`klaR`:** Realizar Análisis Discriminante Regularizado (**RDA**) para datos con alta correlación entre variables.  
     - **`gridExtra`:** Organizar múltiples matrices de confusión y métricas como precisión, sensibilidad y score-F1 en gráficas.  

### 5. **Visualización de Resultados:**  
   - Crear visualizaciones impactantes y explicativas:  
     - **`ggplot2`:** Generar gráficos para explorar la distribución de datos, los patrones identificados por PCA y t-SNE, y los resultados de clustering.  
     - **`patchwork`:** Combinar y organizar gráficos para la interpretación.  
   - Visualizar métricas de modelos y resultados de agrupamiento.  

### 6. **Documentación y Reportes:**  
   - Documentar cada paso del análisis en un informe reproducible.  
   - Utilizar gráficos generados con **`ggplot2`** y tablas organizadas con **`gridExtra`**  
   - Presentar una gráfica claro de los métodos y los valores que confirma su fiabilidad y posteriormente un informe con ellos.
---

## Licencia  

Este proyecto está licenciado bajo la **GNU General Public License v3.0**.  
Consulta el archivo [LICENSE](LICENSE) para más detalles.  

```plaintext
## 📜 Licencia  

Este proyecto está licenciado bajo la **GNU General Public License v3.0**. Esto significa que:  
- Puedes usar, modificar y distribuir este software, siempre y cuando mantengas la misma licencia para las versiones derivadas.  
- La libertad de los usuarios está protegida, asegurando acceso al código fuente y a sus modificaciones.  

**Texto completo de la licencia:**  

```plaintext
GNU GENERAL PUBLIC LICENSE
Version 3, 29 June 2007  

Copyright © 2007 Free Software Foundation, Inc.  
<https://fsf.org/>  

Everyone is permitted to copy and distribute verbatim copies  
of this license document, but changing it is not allowed.  

[Texto completo de la licencia disponible en: https://www.gnu.org/licenses/gpl-3.0.txt]
```



