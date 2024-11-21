#DROP TABLE city; DROP TABLE countrylanguage; DROP TABLE country; DROP TABLE Continent;

CREATE TABLE IF NOT EXISTS country (
	Code varchar(50) PRIMARY KEY,
    Name varchar(50),
    Continent varchar(25),
    Region varchar(50),
    SurfaceArea integer,
    IndepYear integer,
    Population integer,
    LifeExpectancy integer,
    GNP integer,
    GNPOld integer,
    LocalName varchar(50),
    GovernmentForm varchar(50),
    HeadOfState varchar(50),
    Capital integer,
    Code2 varchar(30)
);
    
CREATE TABLE IF NOT EXISTS city (
	ID integer PRIMARY KEY,
    Name varchar(50),
    CountryCode varchar(50),
    FOREIGN KEY (CountryCode) REFERENCES country(Code),
	District varchar(50),
    Population integer
);

CREATE TABLE IF NOT EXISTS countrylanguage (
	CountryCode varchar(50),
    Language varchar(50),
    PRIMARY KEY (CountryCode, Language),
    FOREIGN KEY (CountryCode) REFERENCES country(code),
    IsOfficial varchar(5),
    Percentage integer
);

CREATE TABLE IF NOT EXISTS Continent (
	Name varchar(20) PRIMARY KEY,
    AreaKm2 integer,
    EarthPercentage float,
    MostPopulatedCity varchar(50)
);
/*
INSERT INTO Continent VALUES ("Africa", 30370000, 20.4, "Cairo, Egypt");
INSERT INTO Continent VALUES ("Asia", 44579000, 29.5, "Mumbai, India");
INSERT INTO Continent VALUES ("Europe", 10180000, 6.8, "Istanbul, Turquia");
INSERT INTO Continent VALUES ("North America", 24709000, 16.5, "Ciudad de México, Mexico");
INSERT INTO Continent VALUES ("Oceania", 8600000, 5.9, "Sydney, Australia");
INSERT INTO Continent VALUES ("South America", 17840000, 12.0, "São Paulo, Brazil");
INSERT INTO Continent VALUES ("Antarctica", 14000000, 9.2, "McMurdo Staion");
*/

# ALTER TABLE country ADD FOREIGN KEY (Continent) REFERENCES Continent(Name);

# SELECT Name,Region FROM country ORDER BY Name, Region;

# SELECT Name, Population FROM city ORDER BY -Population LIMIT 10;

# SELECT Name, Region, SurfaceArea, GovernmentForm FROM country ORDER BY SurfaceArea LIMIT 10;

# SELECT Name FROM country WHERE country.GovernmentForm NOT LIKE "Dependent%"

# SELECT Language, Percentage FROM countrylanguage WHERE IsOfficial="T";
