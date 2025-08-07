-- CREACIÓN DE LA TABLA
CREATE TABLE "denuncias_policiales" (
  "ANIO" INTEGER,
  "MES" INTEGER,
  "DPTO_HECHO_NEW" TEXT,
  "PROV_HECHO" TEXT,
  "DIST_HECHO" TEXT,
  "UBIGEO_HECHO" INTEGER,
  "P_MODALIDADES" TEXT,
  "CANTIDAD" INTEGER
);

-- LECTURA DE LOS DATOS
--.mode csv
--.separator ","
--.import -skip 1 "DATASET_Denuncias_Policiales_Enero 2018 a Junio 2025.csv" "denuncias_policiales" 

----------------------------------------------------------------------------------------------------

-- 1. EXPLORACIÓN INICIAL DE LOS DATOS

-- Resumen general del dataset
SELECT
    COUNT(*) AS "total_registros",
    MIN("ANIO") AS "año_inicio",
    MAX("ANIO") AS "año_fin",
    COUNT(DISTINCT "DPTO_HECHO_NEW") AS "total_departamentos",
    COUNT(DISTINCT "P_MODALIDADES") AS "total_tipos_delitos",
    SUM(CANTIDAD) AS "total_denuncias"
FROM "denuncias_policiales";

-- Top de delitos más frecuentes
SELECT
    "P_MODALIDADES",
    SUM("CANTIDAD") AS "total_denuncias_por_modalidad",
    ROUND(SUM("CANTIDAD") * 100.0 / (SELECT SUM("CANTIDAD") FROM "denuncias_policiales"), 2) as "porcentaje"
FROM "denuncias_policiales"
GROUP BY "P_MODALIDADES"
ORDER BY 2 DESC
LIMIT 5;

-- 2. ANÁLISIS DE TENDENCIAS SEGÚN EL TIEMPO

-- Cantidad de denuncias según el año
SELECT 
  "ANIO",
  SUM("CANTIDAD") as "total_denuncias"
FROM "denuncias_policiales"
GROUP BY "ANIO"
ORDER BY "ANIO";

-- Promedio de denuncias por mes
SELECT
  "MES",
  ROUND(AVG("CANTIDAD"),0) AS "promedio mensual",
  SUM("CANTIDAD") AS "total_por_mes",
  COUNT(*) AS "registros"
FROM "denuncias_policiales"
GROUP BY "MES";

-- 3. ANÁLISIS DE TENDENCIAS SEGÚN EL ESPACIO GEOGRÁFICO

-- Top de departamentos con más denuncias
SELECT
  "DPTO_HECHO_NEW" AS "departamento",
  SUM("CANTIDAD") AS "total_denuncias",
  ROUND(SUM("CANTIDAD") * 100.0 / (SELECT SUM("CANTIDAD") FROM "denuncias_policiales"), 2) as "porcentaje_nacional"
FROM "denuncias_policiales"
GROUP BY 1
ORDER BY 2 DESC;

-- Top de distritos con más denuncias
SELECT
  "DIST_HECHO" AS "distrito",
  SUM("CANTIDAD") AS "total_denuncias",
  ROUND(SUM("CANTIDAD") * 100.0 / (SELECT SUM("CANTIDAD") FROM "denuncias_policiales"), 2) as "porcentaje_nacional"
FROM "denuncias_policiales"
GROUP BY 1
ORDER BY 2 DESC
LIMIT 15;

-- 4. ANÁLISIS DE TENDENCIAS POR TIPOS DE DELITOS

-- Evolución de los delitos más comunes
WITH "delitos_principales" AS (
    SELECT "P_MODALIDADES"
    FROM "denuncias_policiales"
    GROUP BY "P_MODALIDADES"
    ORDER BY SUM("CANTIDAD") DESC
    LIMIT 5
)

SELECT 
    dp."ANIO",
    dp."P_MODALIDADES",
    SUM(dp."CANTIDAD") as "total_anual"
FROM "denuncias_policiales" dp
JOIN "delitos_principales" dt ON dp."P_MODALIDADES" = dt."P_MODALIDADES"
GROUP BY dp."ANIO", dp."P_MODALIDADES"
ORDER BY dp."P_MODALIDADES", dp."ANIO";

-- Meses críticos según delito
WITH "delitos_principales" AS (
    SELECT "P_MODALIDADES"
    FROM "denuncias_policiales"
    GROUP BY "P_MODALIDADES"
    ORDER BY SUM("CANTIDAD") DESC
    LIMIT 5
)
SELECT 
    "P_MODALIDADES",
    "MES",
    SUM("CANTIDAD") as "total",
    RANK() OVER (PARTITION BY P_MODALIDADES ORDER BY SUM(CANTIDAD) DESC) as "ranking_mes"
FROM "denuncias_policiales"
WHERE "P_MODALIDADES" IN (SELECT * FROM "delitos_principales")
GROUP BY "P_MODALIDADES", "MES"
ORDER BY "P_MODALIDADES", "ranking_mes";