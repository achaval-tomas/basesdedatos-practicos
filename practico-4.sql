# Ejercicio 1
select city.Name, country.Name
FROM city JOIN country
ON country.Population < 10000 AND city.CountryCode = country.Code;

# Ejercicio 2
SELECT Name
FROM city
WHERE Population > (
	SELECT avg(Population) FROM city
    );

# Ejercicio 3
SELECT city.Name
FROM city JOIN country ON country.Continent != "Asia" AND country.Code = city.CountryCode
WHERE city.Population > (
	SELECT min(Population) FROM country WHERE country.Continent = "Asia"
    );

# Ejercicio 4
SELECT country.Name, cl.Language
FROM country JOIN countrylanguage AS cl ON cl.CountryCode = country.Code
AND cl.IsOfficial = "F"
WHERE cl.Percentage > (
	SELECT max(Percentage)
    FROM countrylanguage WHERE countrylanguage.IsOfficial = "T"
    AND countrylanguage.CountryCode = country.Code
);

# Dos formas para el ejercicio 5
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
SELECT country.Name, city.Name AS MostPopulatedCity, city.Population AS CityPopulation
FROM country JOIN city ON country.Code = city.CountryCode
WHERE city.Population = (
	SELECT max(Population)
    FROM city
    WHERE city.CountryCode = country.Code
);

# Ejercicio 6 con agrupaciones (Parte II: No se podría agregar el nombre)
SELECT country.Name, max(city.Population) AS MostPopulatedCity
FROM country JOIN city ON country.Code = city.CountryCode
GROUP BY city.CountryCode;

# Ejercicio 7
SELECT country.Name, cl.Language
FROM country JOIN countrylanguage AS cl
ON cl.CountryCode = country.Code AND cl.IsOfficial = "F"
WHERE cl.Percentage > (
	SELECT avg(Percentage)
    FROM countrylanguage AS cl
    WHERE cl.CountryCode = country.Code
);

# Ejercicio 8
SELECT continent.Name, sum(country.Population) AS TotalPopulation
FROM continent JOIN country ON country.Continent = continent.Name
GROUP BY continent.Name
ORDER BY -TotalPopulation;

# Ejercicio 9
SELECT continent.Name, avg(country.LifeExpectancy) AS LifeExpectancy
FROM continent JOIN country ON country.Continent = continent.Name
GROUP BY continent.Name
HAVING LifeExpectancy > 40 AND LifeExpectancy < 70;

# Ejercicio 10
SELECT continent.Name, 
max(country.Population) AS MaxCountryPopulation,
min(country.Population) AS MinCountryPopulation,
avg(country.Population) AS AvgCountryPopulation,
sum(country.Population) AS TotalPopulation
FROM continent JOIN country ON country.Continent = continent.Name
GROUP BY continent.Name;



