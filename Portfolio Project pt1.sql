SELECT * 
FROM PortfolioProject.coviddeaths
WHERE continent is not null;

-- Select the data that we will be using
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.coviddeaths;

-- Looking at the Total Cases vs Total Deaths
-- Shows the likelihood of dying if you contract covid in your country 
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject.coviddeaths
WHERE location = 'United States';

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid
SELECT location, date, total_cases, Population, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProject.coviddeaths
WHERE location = 'United States';

-- Looking at Countries with Highest Infection Rate compared to Population 
SELECT location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProject.coviddeaths
GROUP BY location, Population
ORDER BY PercentPopulationInfected DESC;

-- Showing Countries with the Highest Death Count per Population
-- Unsigned is INT in mySQL
SELECT location, MAX(CAST(total_deaths AS UNSIGNED)) as TotalDeathCount
FROM PortfolioProject.coviddeaths
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- Lets break things down by continent
SELECT continent, MAX(CAST(total_deaths AS UNSIGNED)) as TotalDeathCount
FROM PortfolioProject.coviddeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- Showing continents with the highest death count per population
SELECT continent, MAX(CAST(total_deaths AS UNSIGNED)) as TotalDeathCount
FROM PortfolioProject.coviddeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC; 

-- GLOBAL NUMBERS
SELECT date, SUM(new_cases) AS Total_cases, SUM(CAST(new_deaths AS UNSIGNED)) AS Total_Deaths, SUM(CAST(new_deaths AS UNSIGNED))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProject.coviddeaths
WHERE continent is not null
GROUP BY date;

-- JOINING coviddeaths table with covidvaccinations table
SELECT * 
FROM PortfolioProject.coviddeaths dea
JOIN PortfolioProject.covidvaccinations vac
ON dea.location = vac.location 
AND dea.date = vac.date;

-- USE CTE
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) 
as 
(
-- Looking at Total Population vs Vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(vac.new_vaccinations, UNSIGNED)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject.coviddeaths dea
JOIN PortfolioProject.covidvaccinations vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent is not null
-- ORDER BY dea.location, dea.date
)
SELECT *, (RollingPeopleVaccinated/Population)*100 
FROM PopvsVac;

-- Use TEMP Table
USE Portfolio;
-- DROP TABLE IF EXISTS PercentPopulationVaccinated;
CREATE TABLE PercentPopulationVaccinated 
(
Continent CHAR(255),
Location CHAR(255),
Date DATETIME,
Population BIGINT,
New_vaccinations BIGINT,
RollingPeopleVaccinated BIGINT
);
INSERT INTO PercentPopulationVaccinated(Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(vac.new_vaccinations, UNSIGNED)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject.coviddeaths dea
JOIN PortfolioProject.covidvaccinations vac
	ON dea.location = vac.location 
	AND dea.date = vac.date;
    
USE Portfolio;
SELECT *, (RollingPeopleVaccinated/Population)*100 
FROM PercentPopulationVaccinated;

-- Creating View to store data for later visualizations
CREATE VIEW PercentPopulationVaccinated AS 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(vac.new_vaccinations, UNSIGNED)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PortfolioProject.coviddeaths dea
JOIN PortfolioProject.covidvaccinations vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent is not null;




