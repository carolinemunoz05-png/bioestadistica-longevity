# Relación entre masa corporal y longevidad en vertebrados: una 
replicación reproducible mediante modelos lineales mixtos

## Descripción del proyecto

Este repositorio contiene una replicación parcial de análisis 
estadísticos aplicados al estudio de la relación entre masa corporal 
y longevidad máxima en vertebrados. El análisis fue desarrollado 
utilizando R y RMarkdown a partir de datos abiertos descargados 
desde Dryad.

El proyecto evalúa patrones de escalamiento biológico entre 
diferentes grupos taxonómicos mediante transformaciones logarítmicas, 
modelos lineales mixtos y regresiones independientes por clase 
taxonómica.

---

## Artículo de referencia

Kuparinen, A., Yeung, E., & Hutchings, J. A. (2023). 
*Correlation between body size and longevity: New analysis and data covering six taxonomic classes of vertebrates*. Acta Oecologica, 119, 103917.

---

## Objetivos del análisis

El análisis incluye:

- Limpieza y exploración del dataset.
- Transformación logarítmica de variables biológicas.
- Ajuste de modelos lineales mixtos jerárquicos.
- Evaluación de la relación entre masa corporal y longevidad.
- Construcción de regresiones independientes por grupo taxonómico.

---

## Clases taxonómicas analizadas

El dataset incluye especies pertenecientes a seis clases taxonómicas de vertebrados:

- Amphibia
- Reptilia
- Aves
- Mammalia
- Chondrichthyes
- Teleostei

---

## Estructura del repositorio

```text
bioestadistica-longevity/
│
├── data/
│   └── final_data.txt
│
├── analisis_longevity.R
│
└── README.md
```

---

## Descarga del dataset

El dataset utilizado se encuentra disponible públicamente en Dryad:

https://datadryad.org/dataset/doi:10.5061/dryad.kwh70rz72

### Pasos para descargar los datos

1. Abrir el enlace del repositorio Dryad.
2. Desplazarse hasta la sección de archivos del dataset.
3. Descargar el archivo de datos `final_data.txt`.
4. Guardar el archivo descargado dentro de la carpeta:

```text
data/
```

5. Verificar que el nombre del archivo coincida con el utilizado en el script de R.

---

## Variables principales

| Variable | Descripción |
|---|---|
| `AdultMass` | Masa corporal |
| `MaxLife` | Longevidad máxima |
| `LAdultMass` | Log10 de masa corporal |
| `LMaxLife` | Log10 de longevidad máxima |
| `Class` | Clase taxonómica |
| `Order` | Orden taxonómico |
| `Family` | Familia taxonómica |

---

## Paquetes utilizados en R

```r
library(tidyverse)
library(lme4)
library(lmerTest)
library(ggplot2)
```

---

## Modelo estadístico

Se ajustó un modelo lineal mixto utilizando la longevidad máxima transformada logarítmicamente como variable respuesta y la masa corporal transformada como efecto fijo.

El modelo incluyó efectos aleatorios jerárquicos asociados a clase, orden y familia taxonómica:

```r
modelo <- lmer(
  LMaxLife ~ LAdultMass +
    (1 | Class/Order/Family),
  data = datos
)
```

---

## Ejecución del análisis

1. Descargar el dataset desde Dryad.
2. Guardar el archivo `.txt` dentro de la carpeta `data/`.
3. Abrir `analisis_longevity.R` en RStudio.
4. Ejecutar el script completo.

---

## Reproducibilidad

El análisis fue desarrollado utilizando herramientas reproducibles en R con el objetivo de garantizar transparencia y replicabilidad computacional.

---

## Referencias

Kuparinen, A., Yeung, E., & Hutchings, J. A. (2023). *Correlation between body size and longevity: New analysis and data covering six taxonomic classes of vertebrates*. Acta Oecologica, 119, 103917.

Wickham, H. et al. (2019). *Welcome to the tidyverse*. Journal of Open Source Software, 4(43), 1686.

Bates, D., Mächler, M., Bolker, B., & Walker, S. (2015). *Fitting Linear Mixed-Effects Models Using lme4*. Journal of Statistical Software, 67(1), 1–48.

---

## Autor

Caroline Muñoz Padilla
