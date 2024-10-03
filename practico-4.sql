# Ejercicio 1
# Listar el nombre de la ciudad y el nombre del país de todas las ciudades
# que pertenezcan a países con una población menor a 10000 habitantes.
select city.Name, country.Name
FROM city JOIN country
ON country.Population < 10000 AND city.CountryCode = country.Code;

# Ejercicio 2
# Listar todas aquellas ciudades cuya población sea mayor que la población promedio entre todas las ciudades.
SELECT Name
FROM city
WHERE Population > (
	SELECT avg(Population) FROM city
    );

# Ejercicio 3
# Listar todas aquellas ciudades no asiáticas cuya población sea igual o mayor a la población total de algún país de Asia.
SELECT city.Name
FROM city JOIN country ON country.Continent != "Asia" AND country.Code = city.CountryCode
WHERE city.Population > (
	SELECT min(Population) FROM country WHERE country.Continent = "Asia"
    );

# Ejercicio 4
# Listar aquellos países junto a sus idiomas no oficiales, que superen 
# en porcentaje de hablantes a cada uno de los idiomas oficiales del país.
SELECT country.Name, cl.Language
FROM country JOIN countrylanguage AS cl ON cl.CountryCode = country.Code
AND cl.IsOfficial = "F"
WHERE cl.Percentage > (
	SELECT max(Percentage)
    FROM countrylanguage WHERE countrylanguage.IsOfficial = "T"
    AND countrylanguage.CountryCode = country.Code
);

# Ejercicio 5 (dos formas)
# Listar (sin duplicados) aquellas regiones que tengan países con una superficie 
# menor a 1000 km2 y exista (en el país) al menos una ciudad con más de 100000 habitantes. 
SELECT DISTINCT country.Region
FROM country INNER JOIN city ON city.CountryCode = country.Code
AND city.Population > 100000 AND country.SurfaceArea < 1000;

SELECT DISTINCT country.Region
FROM country
WHERE country.SurfaceArea < 1000
AND EXISTS (
	SELECT Name FROM city
    WHERE city.CountryCode = country.Code
    AND city.Population > 100000
	);

# Ejercicio 6 con consultas escalares (+ Parte 2)
# Listar el nombre de cada país con la cantidad de habitantes de su ciudad más poblada. 
SELECT country.Name, city.Name AS MostPopulatedCity, city.Population AS CityPopulation
FROM country JOIN city ON country.Code = city.CountryCode
WHERE city.Population = (
	SELECT max(Population)
    FROM city
    WHERE city.CountryCode = country.Code
);

# Ejercicio 6 con agrupaciones (Parte II: No se podría agregar el nombre)
# Listar el nombre de cada país con la cantidad de habitantes de su ciudad más poblada. 
SELECT country.Name, max(city.Population) AS MostPopulatedCity
FROM country JOIN city ON country.Code = city.CountryCode
GROUP BY city.CountryCode;

# Ejercicio 7
# Listar aquellos países y sus lenguajes no oficiales cuyo porcentaje
# de hablantes sea mayor al promedio de hablantes de los lenguajes oficiales.
SELECT country.Name, cl.Language
FROM country JOIN countrylanguage AS cl
ON cl.CountryCode = country.Code AND cl.IsOfficial = "F"
WHERE cl.Percentage > (
	SELECT avg(Percentage)
    FROM countrylanguage AS cl
    WHERE cl.CountryCode = country.Code
);

# Ejercicio 8
# Listar la cantidad de habitantes por continente ordenado en forma descendente.
SELECT continent.Name, sum(country.Population) AS TotalPopulation
FROM continent JOIN country ON country.Continent = continent.Name
GROUP BY continent.Name
ORDER BY -TotalPopulation;

# Ejercicio 9
# Listar el promedio de esperanza de vida (LifeExpectancy) por continente
# con una esperanza de vida entre 40 y 70 años.
SELECT continent.Name, avg(country.LifeExpectancy) AS LifeExpectancy
FROM continent JOIN country ON country.Continent = continent.Name
GROUP BY continent.Name
HAVING LifeExpectancy > 40 AND LifeExpectancy < 70;

# Ejercicio 10
# Listar la cantidad máxima, mínima, promedio y suma de habitantes por continente.
SELECT continent.Name, 
max(country.Population) AS MaxCountryPopulation,
min(country.Population) AS MinCountryPopulation,
avg(country.Population) AS AvgCountryPopulation,
sum(country.Population) AS TotalPopulation
FROM continent JOIN country ON country.Continent = continent.Name
GROUP BY continent.Name;



