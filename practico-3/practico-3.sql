# Lista el nombre de la ciudad, nombre del país, región y forma de gobierno de las 10 ciudades más pobladas del mundo.
SELECT city.Name, country.Name, country.Region, country.GovernmentForm
from city LEFT JOIN country ON city.CountryCode = country.code 
ORDER BY -city.Population LIMIT 10;

# Listar los 10 países con menor población del mundo, junto a sus ciudades capitales
SELECT country.Name, city.Name
FROM country LEFT JOIN city ON country.Capital = city.ID
ORDER BY country.Population LIMIT 10;

# Listar el nombre, continente y todos los lenguajes oficiales de cada país.
SELECT country.Name, country.Continent, countrylanguage.Language
FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
AND countrylanguage.isOfficial = "T";

# Listar el nombre del país y nombre de capital, de los 20 países con mayor superficie del mundo.
SELECT country.Name, city.Name
FROM country LEFT JOIN city ON city.ID = country.CAPITAL
ORDER BY -country.SurfaceArea LIMIT 20;

# Listar las ciudades junto a sus idiomas oficiales (ordenado por la población de la ciudad) y el porcentaje de hablantes del idioma.
SELECT city.Name, countrylanguage.Language, countrylanguage.Percentage
FROM city LEFT JOIN countryLanguage
ON city.CountryCode = countrylanguage.CountryCode AND countrylanguage.isOfficial = "T"
ORDER BY -city.Population;

# Listar los 10 países con mayor población y los 10 países con menor población (que tengan al menos 100 habitantes) en la misma consulta.
(SELECT Name
FROM country WHERE Population > 100
ORDER BY -Population LIMIT 10) UNION
(SELECT Name
FROM country WHERE Population > 100
ORDER BY Population LIMIT 10);

# Listar aquellos países cuyos lenguajes oficiales son el Inglés y el Francés (hint: no debería haber filas duplicadas).
(SELECT country.Name
FROM country JOIN countrylanguage
ON countrylanguage.CountryCode = country.code
WHERE countrylanguage.Language = "English" AND countrylanguage.IsOfficial = "T")
INTERSECT
(SELECT country.Name
FROM country JOIN countrylanguage
ON countrylanguage.CountryCode = country.code
WHERE countrylanguage.Language = "French" AND countrylanguage.IsOfficial = "T");

# Listar aquellos países que tengan hablantes del Inglés pero no del Español en su población.
(SELECT country.Name
FROM country JOIN countrylanguage
ON countrylanguage.CountryCode = country.code
AND countrylanguage.Language = "English")
EXCEPT
(SELECT country.Name
FROM country JOIN countrylanguage
ON countrylanguage.CountryCode = country.code
AND countrylanguage.Language = "Spanish");