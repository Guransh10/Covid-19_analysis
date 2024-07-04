-- a. Datewise likelihood of dying due to covid- TotalCases vs TotalDeaths in India
--select "Date","New_cases","Total_death"  from "CovidDeaths"
--WHERE "Location" like '%India%'

-- b. Total % of deaths out of entire population- in India
Select (max("Total_death")/avg(cast("Population" as integer))*100) from "CovidDeaths" 
	where "Location" like '%India%'

-- c. Verify b by getting info separately
Select "Total_death", "Population" from "CovidDeaths" where "Location" like '%India%'

-- d. Country with highest death as a % of population
Select "Location", (max("Total_death")/avg(cast("Population" as bigint))*100) as Percentage from "CovidDeaths" 
group by "Location" order by Percentage desc;

-- e. Total no. of Covid +ve cases - In India
Select (max("Total_death")/avg(cast("Population" as bigint))*100) as PercentagePositive from "CovidDeaths" 
where "Location" like '%India%'

-- f. Total no. of Covid +ve cases - In the world
Select "Location", (max("Total_death")/avg(cast("Population" as bigint))*100) as Percentagepositive from "CovidDeaths" 
group by "Location" order by Percentagepositive desc;

-- g. Continent-wise +ve cases
Select "Location", max("Total_cases") as Totalcase from "CovidDeaths" where "Continent" is null 
group by "Location" order by Totalcase desc

-- h. Continent-wise +ve deaths 
Select "Location", max("Total_death") as Totaldeaths from "CovidDeaths" where "Continent" is null 
group by "Location" order by Totaldeaths desc

--i. Daily new cases and hospitalizations vs ICU patients- In India
Select "Date", "New_cases", "Hosp_patients", "Icu_patients" from "CovidDeaths" where "Location" like '%India%'

-- j. Countrywise age >65
Select "CovidDeaths"."Date", "CovidDeaths"."Location" as Country, "CovidVaccinations"."aged_65_older" from "CovidDeaths"
	join "CovidVaccinations" on "CovidDeaths".iso_code = "CovidVaccinations".iso_code
	and "CovidDeaths"."Date" = "CovidVaccinations"."Date" order by Country

-- k. Countrywise total vaccinated people
select "CovidDeaths"."Location" as Country, (max("CovidVaccinations"."people_fully_vaccinated")) as Fully_Vaccinated from "CovidDeaths"
join "CovidVaccinations" on "CovidDeaths".iso_code = "CovidVaccinations".iso_code
	and "CovidDeaths"."Date" = "CovidVaccinations"."Date"
where "CovidDeaths"."Continent" is not null group by Country order by Fully_Vaccinated desc