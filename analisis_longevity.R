# =====================================================
# RELACION ENTRE MASA CORPORAL Y LONGEVIDAD
# =====================================================

# -----------------------------------------------------
# Cargar paquetes
# -----------------------------------------------------

library(tidyverse)
library(lme4)
library(lmerTest)
library(ggplot2)

# -----------------------------------------------------
# Cargar datos
# -----------------------------------------------------

datos <- read.table(
  "data/final_data.txt",
  header = TRUE
)

# -----------------------------------------------------
# Explorar dataset
# -----------------------------------------------------

str(datos)

colnames(datos)

dput(colnames(datos))

names(datos)

head(datos)

# -----------------------------------------------------
# Limpieza de datos
# -----------------------------------------------------

datos <- datos %>%
  filter(
    !is.na(AdultMass),
    !is.na(MaxLife),
    !is.na(class),
    !is.na(order),
    !is.na(family)
  )

# -----------------------------------------------------
# Transformacion logaritmica
# -----------------------------------------------------

datos$log_AdultMass <- log10(datos$LAdultMass)

datos$log_MaxLife <- log10(datos$LMaxLife)

# -----------------------------------------------------
# Modelo lineal mixto jerarquico
# -----------------------------------------------------

modelo <- lmer(
  LMaxLife ~ LAdultMass +
    (1 | Class/Order/Family),
  data = datos
)

# -----------------------------------------------------
# Resumen del modelo
# -----------------------------------------------------

summary(modelo)

# -----------------------------------------------------
# Efectos fijos
# -----------------------------------------------------

fixef(modelo)

# -----------------------------------------------------
# Grafica general de regresion
# -----------------------------------------------------

grafica <- ggplot(
  datos,
  aes(
    x = LAdultMass,
    y = LMaxLife,
    color = Class
  )
) +
  
  geom_point(
    alpha = 0.4,
    size = 1.5
  ) +
  
  geom_smooth(
    method = "lm",
    se = FALSE,
    linewidth = 1.2
  ) +
  
  theme_minimal() +
  
  labs(
    title = "Relationship between body mass and longevity in vertebrates",
    x = "Log10 body mass (g)",
    y = "Log10 maximum longevity (years)",
    color = "Taxonomic class"
  )

grafica

# -----------------------------------------------------
# Obtener grupos taxonomicos
# -----------------------------------------------------

grupos <- unique(datos$Class)

# -----------------------------------------------------
# Crear regresiones independientes por grupo
# -----------------------------------------------------

for (g in grupos) {
  
  datos_grupo <- subset(datos, Class == g)
  
  grafica <- ggplot(
    datos_grupo,
    aes(
      x = LAdultMass,
      y = LMaxLife
    )
  ) +
    
    geom_point(
      alpha = 0.4,
      size = 1.5
    ) +
    
    geom_smooth(
      method = "lm",
      se = FALSE,
      color = "blue",
      linewidth = 1
    ) +
    
    theme_minimal() +
    
    labs(
      title = paste(
        "-",
        g
      ),
      x = "Log10 Adult body mass",
      y = "Log10 Maximum longevity"
    )
  
  print(grafica)
  
  ggsave(
    filename = paste0(
      "figures/",
      g,
      "_regression.png"
    ),
    plot = grafica,
    width = 8,
    height = 6
  )
}

# -----------------------------------------------------
# Guardar figura general
# -----------------------------------------------------

ggsave(
  filename = "figures/figura1.png",
  plot = grafica,
  width = 8,
  height = 6
)

# -----------------------------------------------------
# Informacion de la sesion
# -----------------------------------------------------

sessionInfo()
```
