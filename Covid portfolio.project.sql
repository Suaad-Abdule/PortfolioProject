USE portfolioproject;



-- select the data that will be used;

SELECT location,date,total_cases,new_cases,total_deaths,population
FROM coviddeaths
WHERE continent IS NOT NULL 
ORDER BY 1,2;

-- looking at total cases VS total deaths
-- shows the likelyhood of dying if you contract covid in your country

SELECT location,date,total_cases,total_deaths, (total_deaths/total_cases) *100 AS deathPercentage
FROM coviddeaths
WHERE location = 'norway'
ORDER BY 1,2;

-- Looking at the total caes VS  population
-- shows what percentage of population got covid

SELECT location,date,population, total_cases, (total_cases/population) *100 AS InfectedPopulationPercentage
FROM coviddeaths
WHERE location = 'norway'
ORDER BY 1,2;


-- looking at countries with highest infection rate compared to population 

SELECT location,population, MAX(total_cases) AS highestInfectionCout, MAX((total_cases/population)) *100 AS InfectedPopulationPercentage
FROM coviddeaths
-- WHERE location = 'norway'
GROUP BY location,population
ORDER BY InfectedPopulationPercentage DESC;


-- Showing countries with highest death count per population 

SELECT location, MAX(total_deaths) AS totaldeathcount
FROM coviddeaths
-- WHERE country = 'norway'
GROUP BY location
ORDER BY totaldeathcount DESC;


-- Let's break things down by continent

SELECT continent, MAX(total_deaths) AS totaldeathcount
FROM coviddeaths
-- WHERE country = 'norway'
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY totaldeathcount DESC;

-- OR

SELECT location, MAX(total_deaths) AS totaldeathcount
FROM coviddeaths
-- WHERE country = 'norway'
WHERE location IS NULL 
GROUP BY continent
ORDER BY totaldeathcount DESC;

-- Showing the continents with the highest death count
SELECT continent, MAX(total_deaths) AS totaldeathcount
FROM coviddeaths
-- WHERE country = 'norway'
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY totaldeathcount DESC;


-- GLOBAL NUMBER

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/ SUM(new_cases)*100 AS deathpercentage
FROM coviddeaths
WHERE continent IS NOT NULL 
-- GROUP BY date
ORDER BY 1,2;



SELECT *
FROM covidvaccinations;


-- Joining the two table

SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
FROM coviddeaths AS dea
JOIN covidvaccinations AS vac
ON dea.location = vac.location 
AND dea.date = vac.date
WHERE continent IS NOT NULL
ORDER BY 2,3; 



-- Creating View to store data for later visualizations

CREATE VIEW  pop_VS_vac AS
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
FROM coviddeaths AS dea
JOIN covidvaccinations AS vac
ON dea.location = vac.location 
AND dea.date = vac.date
ORDER BY 2,3; 

SELECT *
FROM pop_VS_vac;



 













