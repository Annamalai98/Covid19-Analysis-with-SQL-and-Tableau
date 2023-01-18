USE Covid_SQL_Project
/*
Covid 19 Data Exploration 
*/
Select Location, date, total_cases, new_cases, total_deaths, population
From CovidDeaths
Where continent is not null 
order by 1,2

-- Looking at total cases vs total deaths 

Select Location, date, total_cases, total_deaths, (total_cases/total_deaths)/100 as DeathPercentage
From dbo.CovidDeaths
Where continent is not null 
order by 1,2

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From CovidDeaths
Where continent is not null 
order by 1,2

-- Top 10 Countries with Highest Infection Rate compared to Population

select top 10 Location, population, max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDeaths
Where continent is not null 
Group by Location, Population
order by PercentPopulationInfected desc

-- Countries with Highest Death Count per Population
 
 select location,max(cast(total_deaths as int)) as TotalDeathCount
 From CovidDeaths
 Where continent is not null 
 Group by Location
 order by TotalDeathCount

 -- Showing contintents with the highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From CovidDeaths
where continent is not null 
Group By date
order by 1,2

-- Using Join

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From CovidDeaths dea
Join CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3


