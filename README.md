# 📊 Análisis de Denuncias Policiales en Perú (2018-2025)

## 🎯 Descripción del Proyecto

Este proyecto presenta un análisis exhaustivo de las denuncias policiales registradas en Perú desde enero 2018 hasta junio 2025. Utilizando SQL como herramienta principal, se exploran patrones temporales, geográficos y por tipo de delito para generar insights valiosos sobre la seguridad ciudadana en el país.

## 📁 Estructura del Proyecto

```
├── DATASET_Denuncias_Policiales_Enero 2018 a Junio 2025.csv    # Dataset original
├── DICCIONARIO_DATOS_Denuncias_Policiales.xlsx                 # Diccionario de datos
├── METADATO_Denuncias_Policiales.docx                          # Metadata del dataset
├── denuncias.db                                                # Base de datos SQLite
├── AnálisisDenuncias.sql                                       # Análisis principal
└── README.md                                                   # Documentación del proyecto
```

## 🗃️ Descripción de los Datos

### **Fuente de Datos**
- **Origen**: [Datos oficiales de denuncias policiales del Perú](https://datosabiertos.gob.pe/dataset/denuncias-policiales-1)
- **Período**: Enero 2018 - Junio 2025
- **Granularidad**: Registros mensuales por ubicación geográfica y tipo de delito

### **Esquema de la Base de Datos**
```sql
CREATE TABLE denuncias_policiales (
  ANIO INTEGER,              -- Año del registro
  MES INTEGER,               -- Mes del registro
  DPTO_HECHO_NEW TEXT,       -- Departamento donde ocurrió el hecho
  PROV_HECHO TEXT,           -- Provincia donde ocurrió el hecho
  DIST_HECHO TEXT,           -- Distrito donde ocurrió el hecho
  UBIGEO_HECHO INTEGER,      -- Código UBIGEO del lugar
  P_MODALIDADES TEXT,        -- Tipo/modalidad del delito
  CANTIDAD INTEGER           -- Cantidad de denuncias registradas
);
```

## 🔍 Análisis Realizados

### **1. Exploración Inicial**
- ✅ Resumen general del dataset
- ✅ Identificación de tipos de delitos más frecuentes
- ✅ Validación de calidad de datos

### **2. Análisis Temporal**
- ✅ Evolución anual de denuncias
- ✅ Patrones estacionales por mes
- ✅ Tendencias de crecimiento/decrecimiento

### **3. Análisis Geográfico**
- ✅ Ranking de departamentos con mayor incidencia
- ✅ Identificación de distritos críticos
- ✅ Distribución porcentual a nivel nacional

### **4. Análisis por Tipo de Delito**
- ✅ Evolución temporal de los 5 delitos principales
- ✅ Identificación de meses críticos por tipo de delito

## 🎯 Principales Hallazgos

### **📊 Resumen General del Dataset**
- **Total de registros analizados**: 321,061 registros
- **Período de cobertura**: 2018-2025 (7+ años de datos)
- **Total de denuncias**: 6,394,092 denuncias registradas
- **Cobertura geográfica**: 26 departamentos del Perú
- **Tipos de delitos**: 7 modalidades principales identificadas

### **🏆 Delitos Más Frecuentes**
1. **"Otros"** - 2,426,824 denuncias (37.95% del total)
2. **"Violencia contra la mujer e integrantes"** - 1,702,609 denuncias (26.63%)
3. **"Hurto"** - 1,279,173 denuncias (20.01%)
4. **"Robo"** - 708,465 denuncias (11.08%)
5. **"Estafa"** - 174,395 denuncias (2.73%)

> **Insight Clave**: Los 3 primeros tipos de delitos concentran el **84.59%** de todas las denuncias registradas.

### **🗺️ Concentración Geográfica**
**Top 5 Departamentos con Mayor Incidencia:**
1. **Lima Metropolitana** - 2,244,457 denuncias (35.1% del total nacional)
2. **Arequipa** - 447,271 denuncias (7.0%)
3. **Lambayeque** - 367,739 denuncias (5.75%)
4. **La Libertad** - 334,293 denuncias (5.23%)
5. **Piura** - 324,218 denuncias (5.07%)

> **Insight Clave**: Lima Metropolitana concentra más de **1 de cada 3 denuncias** a nivel nacional, evidenciando una alta concentración urbana del fenómeno delictivo.

### **📈 Evolución Temporal**
**Tendencias Anuales Destacadas:**
- **2018**: 775,295 denuncias (año base)
- **2019**: 855,547 denuncias (+10.4% vs 2018)
- **2020**: 648,597 denuncias (-24.2% vs 2019) - *Efecto pandemia*
- **2021**: 753,830 denuncias (+16.2% vs 2020) - *Recuperación gradual*
- **2022**: 876,270 denuncias (+16.2% vs 2021)
- **2023**: 1,042,198 denuncias (+18.9% vs 2022) - *Año pico*
- **2024**: 1,008,184 denuncias (-3.3% vs 2023)
- **2025**: 434,171 denuncias (solo 6 meses de datos)

> **Insight Clave**: Se observa una **clara recuperación post-pandemia** con 2023 registrando el mayor número de denuncias históricas.

### **⚠️ Hallazgos Críticos para Política Pública**
1. **Concentración extrema**: El 58% de las denuncias se concentra en solo 5 departamentos
2. **Crecimiento sostenido**: Tendencia al alza desde 2021 hasta 2023
3. **Diversidad delictiva**: Alta prevalencia de violencia de género (26.63% del total)
4. **Impacto COVID-19**: Reducción significativa en 2020 seguida de fuerte recuperación

## 🛠️ Tecnologías Utilizadas

- **Base de Datos**: SQLite
- **Lenguaje**: SQL
- **Técnicas SQL Aplicadas**:
  - Common Table Expressions (CTEs)
  - Window Functions (RANK, OVER, PARTITION BY)
  - Agregaciones complejas
  - Subconsultas correlacionadas
  - Cálculos de porcentajes y rankings

## 📈 Insights Clave para Stakeholders

### **Para Autoridades de Seguridad**
- Identificación de períodos críticos para reforzar patrullaje
- Focalización de recursos en departamentos y distritos prioritarios
- Planificación estratégica basada en patrones estacionales

### **Para Investigadores**
- Datasets limpios y estructurados para análisis adicionales
- Metodología replicable para otros períodos o regiones
- Base sólida para modelos predictivos

### **Consultas Destacadas**
```sql
-- Evolución anual con crecimiento porcentual
SELECT 
  ANIO,
  SUM(CANTIDAD) as total_denuncias,
  LAG(SUM(CANTIDAD)) OVER (ORDER BY ANIO) as año_anterior,
  ROUND(((SUM(CANTIDAD) - LAG(SUM(CANTIDAD)) OVER (ORDER BY ANIO)) * 100.0 / 
         LAG(SUM(CANTIDAD)) OVER (ORDER BY ANIO)), 2) as crecimiento_porcentual
FROM denuncias_policiales
GROUP BY ANIO;

-- Top departamentos con concentración de delitos
SELECT
  DPTO_HECHO_NEW as departamento,
  SUM(CANTIDAD) as total_denuncias,
  ROUND(SUM(CANTIDAD) * 100.0 / (SELECT SUM(CANTIDAD) FROM denuncias_policiales), 2) as porcentaje_nacional
FROM denuncias_policiales
GROUP BY DPTO_HECHO_NEW
ORDER BY total_denuncias DESC;
```

## 📊 Métricas del Proyecto

- **Registros analizados**: 321,061 registros únicos
- **Denuncias totales**: 6,394,092 denuncias procesadas
- **Período temporal**: 7+ años de datos históricos (2018-2025)
- **Cobertura geográfica**: 26 departamentos del Perú
- **Tipos de delitos**: 7 modalidades principales analizadas
- **Consultas SQL**: 15+ análisis especializados implementados
- **Procesamiento**: 100% de datos validados y limpios

## 👨‍💻 Autor

**Angel Cerdán**
- 📧 Email: [angelcerdan1@hotmail.com]
- 💼 LinkedIn: [Angel Cerdán](https://www.linkedin.com/in/angel-cerd%C3%A1n-2a1091319/)

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [SECURITY.md](SECURITY.md) para detalles.

---

### 🏆 Skills Demostradas en este Proyecto

- ✅ **Análisis de Datos**: Exploración y limpieza de datasets grandes
- ✅ **SQL Avanzado**: CTEs, Window Functions, subconsultas complejas
- ✅ **Pensamiento Analítico**: Identificación de patrones y tendencias
- ✅ **Visualización de Datos**: Presentación clara de resultados
- ✅ **Documentación**: README completo y código bien comentado
- ✅ **Gestión de Proyectos**: Estructura organizada y reproducible

*Proyecto desarrollado como parte del portafolio profesional para demostrar competencias en análisis de datos y SQL.*
