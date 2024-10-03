SELECT city.Name, country.Name, country.Region, country.GovernmentForm
from city LEFT JOIN country ON city.CountryCode = country.code 
ORDER BY -city.Population LIMIT 10;

SELECT country.Name, city.Name
FROM country LEFT JOIN city ON country.Capital = city.ID
ORDER BY country.Population LIMIT 10;

SELECT country.Name, country.Continent, countrylanguage.Language
FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
AND countrylanguage.isOfficial = "T";

SELECT country.Name, city.Name
FROM country LEFT JOIN city ON city.ID = country.CAPITAL
ORDER BY -country.SurfaceArea LIMIT 20;

SELECT city.Name, countrylanguage.Language, countrylanguage.Percentage
FROM city LEFT JOIN countryLanguage
ON city.CountryCode = countrylanguage.CountryCode AND countrylanguage.isOfficial = "T"
ORDER BY -city.Population;

(SELECT Name
FROM country WHERE Population > 100
ORDER BY -Population LIMIT 10) UNION
(SELECT Name
FROM country WHERE Population > 100
ORDER BY Population LIMIT 10);

(SELECT country.Name
FROM country JOIN countrylanguage
ON countrylanguage.CountryCode = country.code
WHERE countrylanguage.Language = "English" AND countrylanguage.IsOfficial = "T")
INTERSECT
(SELECT country.Name
FROM country JOIN countrylanguage
ON countrylanguage.CountryCode = country.code
WHERE countrylanguage.Language = "French" AND countrylanguage.IsOfficial = "T");

(SELECT country.Name
FROM country JOIN countrylanguage
ON countrylanguage.CountryCode = country.code
AND countrylanguage.Language = "English")
EXCEPT
(SELECT country.Name
FROM country JOIN countrylanguage
ON countrylanguage.CountryCode = country.code
AND countrylanguage.Language = "Spanish");