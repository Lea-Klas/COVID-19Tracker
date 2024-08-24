/* 
COVID-19 Analysis
- Some basic queries to get familiar with the Covid Dataset
*/


/* First, we want to compute some total numbers for the whole world, continents and countries
These numbers include:
- cases (Covid-19 infections) 
- deaths
- vaccine doses
- people partly vaccinated 
- people fully vaccinated 
- people not vaccinated

Info: As we are dealing with a cumulative dataset, we need to use the aggregate function MAX to compute the total values
*/

-- Let's compute these numbers...

-- WORLDWIDE
SELECT 
	MAX(total_cases) AS total_cases,
    MAX(total_deaths) AS total_deaths,
    MAX(total_vaccinations) as total_vaccine_doses,
	MAX(people_vaccinated) AS total_partly_vaccinated,
    MAX(people_fully_vaccinated) AS total_fully_vaccinated,  
    Max(population) - MAX(people_vaccinated) AS total_not_vaccinated
FROM covid_data
WHERE location = 'World'
GROUP BY location;

-- CONTINENTS
/*
We noticed that some entries have a continet name in the location field but NULL in the continent field. 
However, the correct values for the continets are stored in those entries where the location is the continent name and 
where the continent field is NULL.
*/
SELECT DISTINCT location 
FROM covid_data
WHERE continent IS NULL;

SELECT location,
	MAX(total_cases) AS total_cases,
    MAX(total_deaths) AS total_deaths,
    MAX(total_vaccinations) as total_vaccine_doses,
    MAX(people_vaccinated) AS total_partly_vaccinated,
    MAX(people_fully_vaccinated) AS total_fully_vaccinated,
    Max(population) - MAX(people_vaccinated) AS total_not_vaccinated
FROM covid_data
WHERE continent IS NULL
AND location IN ('Africa', 'Asia', 'Europe', 'North America', 'South America', 'Oceania')
GROUP BY location
ORDER BY 1;

-- COUNTRIES
SELECT location,
	MAX(total_cases) AS total_cases,
    MAX(total_deaths) AS total_deaths,
    MAX(total_vaccinations) as total_vaccine_doses,
    MAX(people_vaccinated) AS total_partly_vaccinated,
    MAX(people_fully_vaccinated) AS total_fully_vaccinated,
    Max(population) - MAX(people_vaccinated) AS total_not_vaccinated
FROM covid_data
WHERE continent IS NOT NULL
GROUP BY location;

/* Compute some percentages for the whole world, continents and countries
These numbers include:
- cases (Covid-19 infections) per population
- deaths per population
- people fully vaccinated per population
- people partly vaccinated per population
- people not vaccinated per population
- case fatality rate (CFR) = proportion of people who were diagnosed with Covid-19 and died of it
*/

-- WORLDWIDE
SELECT 
	(MAX(total_cases) / MAX(population)) * 100 AS pct_cases,
    (MAX(total_deaths) / MAX(population)) * 100 AS pct_deaths,
    (MAX(people_fully_vaccinated) / MAX(population)) * 100 AS pct_fully_vaccinated,
    (MAX(people_vaccinated) / MAX(population)) * 100 AS pct_partly_vaccinated,
    ((MAX(population) - MAX(people_vaccinated)) / MAX(population)) * 100 AS pct_not_vaccinated,
    (MAX(total_deaths) / MAX(total_cases)) * 100 AS case_fatality_rate
FROM covid_data
WHERE location = 'World'
GROUP BY location;

-- CONTINENTS
SELECT location,
	(MAX(total_cases) / MAX(population)) * 100 AS pct_cases,
    (MAX(total_deaths) / MAX(population)) * 100 AS pct_deaths,
    (MAX(people_fully_vaccinated) / MAX(population)) * 100 AS pct_fully_vaccinated,
    (MAX(people_vaccinated) / MAX(population)) * 100 AS pct_partly_vaccinated,
    ((MAX(population) - MAX(people_vaccinated)) / MAX(population)) * 100 AS pct_not_vaccinated,
    (MAX(total_deaths) / MAX(total_cases)) * 100 AS case_fatality_rate
FROM covid_data
WHERE continent IS NULL
AND location IN ('Africa', 'Asia', 'Europe', 'North America', 'South America', 'Oceania')
GROUP BY location
ORDER BY 1;

-- COUNTRIES
SELECT location,
	(MAX(total_cases) / MAX(population)) * 100 AS pct_cases,
    (MAX(total_deaths) / MAX(population)) * 100 AS pct_deaths,
    (MAX(people_fully_vaccinated) / MAX(population)) * 100 AS pct_fully_vaccinated,
    (MAX(people_vaccinated) / MAX(population)) * 100 AS pct_partly_vaccinated,
    ((MAX(population) - MAX(people_vaccinated)) / MAX(population)) * 100 AS pct_not_vaccinated,
    (MAX(total_deaths) / MAX(total_cases)) * 100 AS case_fatality_rate
FROM covid_data
WHERE continent IS NOT NULL
GROUP BY location;


/* TIME ANALYSIS
Now we want to capture the development of certain numbers over time
These numbers include:
- cases (Covid-19 infections) 
- deaths
- vaccine doses
- people partly vaccinated 
- people fully vaccinated 
*/

-- WORLDWIDE
SELECT `date`, total_cases, total_deaths, total_vaccinations, people_vaccinated, people_fully_vaccinated
FROM covid_data
WHERE location = 'World';

-- CONTINENT 
SELECT location, `date`, total_cases, total_deaths, total_vaccinations, people_vaccinated, people_fully_vaccinated
FROM covid_data
WHERE continent IS NULL
AND location IN ('Africa', 'Asia', 'Europe', 'North America', 'South America', 'Oceania');

-- COUNTRY
SELECT location, `date`, total_cases, total_deaths, total_vaccinations, people_vaccinated, people_fully_vaccinated
FROM covid_data
WHERE continent IS NOT NULL;