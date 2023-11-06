select * from coviddeaths;

-- 20-03-2020  30-4-2021

-- Global Numbers
select date, sum(new_cases) as 'New Cases', sum(new_deaths) as 'New Death', 
round((sum(new_deaths)/sum(new_cases)) * 100,2) as DeathPercentage
from coviddeaths
group by date
order by 1,2; 
 
select sum(new_cases) as 'New Cases', sum(new_deaths) as 'New Death', 
round((sum(new_deaths)/sum(new_cases)) * 100,2) as DeathPercentage
from coviddeaths
order by 1; 
 
-- Total Cases vs Total Deaths in Percentages by Continent
select continent, round(sum(new_deaths)/sum(new_cases) * 100,2) as 'Total Cases vs Total Deaths' 
from coviddeaths
group by continent;

-- Looking at continents with highest death count
select continent, sum(new_deaths) as 'Highest Death Count' 
from coviddeaths
group by continent
order by 2 desc;


-- Looking at Total Cases vs Total Deaths by countries
select location, date, total_cases, total_deaths, 
round((total_deaths/total_cases) * 100,2) as 'Total Cases vs Total Deaths' from coviddeaths
-- where location = 'india'
order by 2;

-- Looking at Total Cases vs Population by countries
select location, date, total_cases, population, 
(total_cases/population) * 100 as 'Total Cases vs Population' from coviddeaths
-- where location = 'India'
order by 2;

-- Looking at countries with highest infected count
select location, population,  max(total_cases) as 'Highest Infection Count', 
max((total_cases/population) *100) as 'PercentPopulationInfected' from coviddeaths
group by location, population 
order by 3 desc;

-- Looking at countries with highest death count
select location, population,  max(total_deaths) as 'Highest Death Count', 
round(max((total_deaths/population) *100),3) as 'PercentPopulationDied' from coviddeaths
group by location, population 
order by 3 desc;

-- Looking at Total Population vs People Vaccinated 
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations as VaccinatedPeople
from coviddeaths cd 
join covidvaccinations cv on cv.location = cd.location and cv.date = cd.date
-- where location = 'india'
order by 2,3;

-- Looking at Vaccinated People  
select cd.continent, sum(cv.new_vaccinations) as VaccinatedPeople
from coviddeaths cd 
join covidvaccinations cv on cv.location = cd.location and cv.date = cd.date
-- where location = 'india'
group by cd.continent
order by 1;

-- Looking at Total Population vs People Vaccinated (windows func.)
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations as VaccinatedPeople,
sum(cv.new_vaccinations) over(partition by cd.location order by cd.location, cd.date) as CumulativeVaccinatedPeople
from coviddeaths cd 
join covidvaccinations cv on cv.location = cd.location and cv.date = cd.date
-- where location = 'india'
order by 2,3;

-- Looking at Total Population vs People Vaccinated (windows func.)(per using cte)
with perpeovac(Continent, Location, Date, Population, VaccinatedPeople, CumulativeVaccinatedPeople ) as
 (select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations as VaccinatedPeople,
sum(cv.new_vaccinations) over(partition by cd.location order by cd.location, cd.date) as CumulativeVaccinatedPeople
from coviddeaths cd 
join covidvaccinations cv on cv.location = cd.location and cv.date = cd.date
-- where cd.location = 'india'
order by 2,3)

select *, round((CumulativeVaccinatedPeople/population) * 100,2) as PerPopulationVacci from perpeovac;

-- Looking at Total Population vs People Vaccinated in Specific areas
select cd.location, max(cd.population) as Population, sum(cv.new_vaccinations) as VaccinatedPeople
from coviddeaths cd
join covidvaccinations cv on cv.location = cd.location and cv.date = cd.date
where cd.location = 'india'
order by 1;

-- TEMP table
create temporary table PercentPopulationVaccinated
as  
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations as VaccinatedPeople,
sum(cv.new_vaccinations) over(partition by cd.location order by cd.location, cd.date) as CumulativeVaccinatedPeople
from coviddeaths cd 
join covidvaccinations cv on cv.location = cd.location and cv.date = cd.date
-- where cd.location = 'india'
order by 2,3;
select *, round((CumulativeVaccinatedPeople/population) * 100,2) as PerPopulationVacci from PercentPopulationVaccinated;

-- Creating views for later viz.
create view PercentPopulationVaccinated as
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations as VaccinatedPeople,
sum(cv.new_vaccinations) over(partition by cd.location order by cd.location, cd.date) as CumulativeVaccinatedPeople
from coviddeaths cd 
join covidvaccinations cv on cv.location = cd.location and cv.date = cd.date
-- where cd.location = 'india'
order by 2,3;
select *, round((CumulativeVaccinatedPeople/population) * 100,2) as PerPopulationVacci from PercentPopulationVaccinated;




