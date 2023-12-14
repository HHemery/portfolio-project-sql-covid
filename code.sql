SELECT *
FROM covidschema.coviddeaths
order by 3,4;

#SELECT *
#FROM covidschema.covidvaccinations
#order by 3,4
Select location,date,total_cases,new_cases,total_deaths,population
FROM covidschema.coviddeaths
order by location,date;


#looking at total cases vs total death

Select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS 'pourcentage de mort'
FROM covidschema.coviddeaths
WHERE location like '%france%'
order by location,date;


#looking at total cases vs population

Select location,date,population,total_cases,(total_cases/population)*100 AS 'pourcentage de personnes infectées'
FROM covidschema.coviddeaths
WHERE location like '%france%'
order by location,date;


#looking at countries with highest infection rate compared to the population

Select Location,Population,MAX(total_cases),MAX((total_cases/population))*100 AS 'pourcentage de personnes infectées'
FROM covidschema.coviddeaths
GROUP BY location,population
ORDER BY 4 DESC ;


#showing countries with highest death count per population

Select Location,MAX(cast(total_deaths as int )) as 'total de morts'
FROM covidschema.coviddeaths
where continent is not null
GROUP BY location
ORDER BY `total de morts` DESC ;


#LETS BREAK THINGS DOWN BY CONTINENT

Select continent,MAX(cast(total_deaths as int )) as 'total de morts'
FROM covidschema.coviddeaths
where continent is not null
GROUP BY continent
ORDER BY `total de morts` DESC ;


#global numbers

Select SUM(new_cases) as total_cases,SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/sum(new_cases)*100 as deathPourcentage
FROM covidschema.coviddeaths
#WHERE location like '%france%'
WHERE continent is not null
#group by date
order by  total_cases;


#looking at total population vs Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (partition by dea.location)
FROM covidschema.coviddeaths dea
join covidschema.covidvaccinations vac
    on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null





