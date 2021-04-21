// Jameson Colbert, Data Mgmt, PS6, 21 April 2021
// Dr. Adam Okulicz-Kozaryn

/* 
My research into COVID in the Mid-Atlantic primarily looks into the possible
correlations between COVID cases (and deaths) with race, population, and poverty.

I find that the strongest correlation between Covid cases and deaths is population,
and particularly population density (although pop density merge is giving me some
new trouble, trouble which I had not had in previous problem sets). However,
there is some correlation with race, more so than poverty. I have found areas with
both high population as well as high proportions of black people tend to see
the highest covid numbers.

For PS6, I have corrected the issue with 1:1 merging, which I am very pleased with. I have also better organized
the dofile, such as separating data into "chapters" such as cleaning, merging, 
and graphing/analysis.

However, new problems have emerged with PS6, namely that of pop density and unemp
merges being practically incomplete, with many counties only merging some new data
and seemingly losing other data.
*/

/* Introducing and cleaning up data, much of this process from ps5 was centered
around cleaning up lots of data that didn't serve me for the final project*/

clear
cd C:\Users\jhc157

insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv //NYTimes Github data, names 
keep if state == "Pennsylvania" | state == "New Jersey" | state == "New York"
gen county2 = county + state
drop state county
rename county2 county
collapse cases deaths, by (county)
replace county = subinstr(county, "Pennsylvania",", Pennsylvania", .)
replace county = subinstr(county, "New Jersey",", New Jersey", .)
replace county = subinstr(county, "New York",", New York", .)
l
save NJ_PA_NY_CovidCasesAndDeathsByCounty.dta, replace 

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/co-est2019-alldata.csv //Census data
keep if stname == "New Jersey" | stname == "Pennsylvania" | stname == "New York"
gen county2 = ctyname + stname
drop stname ctyname
drop county
rename county2 county
keep county* popestimate2019*
replace county = subinstr(county, "Pennsylvania",", Pennsylvania", .)
replace county = subinstr(county, "New Jersey",", New Jersey", .)
replace county = subinstr(county, "New York",", New York", .)
l
save NJ_PA_NY_CensusPop2019B.dta, replace
// data sourced from US Census

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/Raw-data/main/ACSST5Y2019.S1701_data_with_overlays_2021-03-02T224230.csv
drop v1
rename v2 county
replace county = subinstr(county,"County, New Jersey",", New Jersey",.)
replace county = subinstr(county," , New Jersey",", New Jersey",.)

rename v125 belowpov
rename v247 percBelowpov
keep county* belowpov* percBelowpov*
l
save NJPoverty2019.dta, replace
// NJ poverty data. data sourced from US Census

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/Raw-data/main/2020%20County%20Health%20Rankings%20New%20Jersey%20Data%20-%20v1_0%20-%20RAW_B.csv
rename v3 county
rename v2 state
gen county2 = county + state
drop state county
rename county2 county
replace county = subinstr(county,"New Jersey",", New Jersey",.)

rename v136 uninsPerc

keep county* uninsPerc*
replace county = "" if county == "CountyState"
replace uninsPerc = "" if uninsPerc == "% Uninsured" 
replace uninsPerc = "" if uninsPerc == "11"
save NJUninsuredPercent.dta, replace
// Rates of uninsured persons. data sourced from https://www.countyhealthrankings.org/app/new-jersey/2020/overview

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/Raw-data/main/Unemployment-RAW.csv
keep if v2 == "NJ" | v2 == "PA" | v2 == "NY" //v2 being the state abbreviation
rename v3 county
drop v1 v2
replace county = subinstr(county, "County, PA",", Pennsylvania", .)
replace county = subinstr(county, "County, NJ",", New Jersey", .)
replace county = subinstr(county, "County, NY",", New York", .)
replace county = subinstr(county," , New Jersey",", New Jersey",.)
replace county = subinstr(county," , Pennsylvania",", Pennyslvania",.)
replace county = subinstr(county," , New York",", New York",.)

rename v86 unempRate2019
keep county* unempRate2019*
l
save NJ_PA_NY_Unemployment2019.dta, replace 
// data on unemployment. data sourced from https://www.ers.usda.gov/data-products/county-level-data-sets/download-data/ 

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/Raw-data/main/NJ_PA_NY_Pop2019_Census.csv //Census data
drop v1
rename v2 county
rename v3 population
keep county population

replace county = subinstr(county, " County, New Jersey",", New Jersey", .)
replace county = subinstr(county, " County, New York",", New York", .)
replace county = subinstr(county, " County, Pennsylvania",", Pennsylvania", .)
l

save NJ_PA_NY_Pop2019census.dta, replace

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/Raw-data/main/NJ_PA_NY_Poverty2019census.csv //Census data
drop v1
rename v2 county
rename v125 Popbelowpov
rename v247 Percbelowpov
keep county Popbelowpov Percbelowpov

replace county = subinstr(county, " County, New Jersey",", New Jersey", .)
replace county = subinstr(county, " County, New York",", New York", .)
replace county = subinstr(county, " County, Pennsylvania",", Pennsylvania", .)
l
save NJ_PA_NY_Poverty2019census.dta, replace

clear
insheet using https://raw.githubusercontent.com/camillol/cs424p3/master/data/Population-Density%20By%20County.csv //pop density by Github user camillol
keep if geodisplaylabel == "Pennsylvania" | geodisplaylabel == "New Jersey" | geodisplaylabel == "New York"
rename gct_stubdisplaylabel county
gen county2 = county + geodisplaylabel
drop county
rename county2 county
replace county = subinstr(county, "CountyNew Jersey",", New Jersey", .)
replace county = subinstr(county, "CountyNew York",", New York", .)
replace county = subinstr(county, "CountyPennsylvania",", Pennsylvania", .)
replace county = subinstr(county," , New Jersey",", New Jersey",.)
replace county = subinstr(county," , Pennsylvania",", Pennyslvania",.)
replace county = subinstr(county," , New York",", New York",.)

rename densitypersquaremileoflandarea popdensitysqmi
keep county popdensitysqmi
save NJ_PA_NY_PopDensity.dta, replace

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/Raw-data/main/ACSDT5Y2019.B02001_data_with_overlays_2021-04-07T164844.csv
drop v1
rename v2 county
replace county = subinstr(county, " County, New Jersey",", New Jersey", .)
replace county = subinstr(county, " County, New York",", New York", .)
replace county = subinstr(county, " County, Pennsylvania",", Pennsylvania", .)
rename v5 white
rename v7 black
rename v9 indigenous
rename v11 asian
keep county* white* black* indigenous* asian*

save NJ_PA_NY_race.dta, replace

// Merging

clear
use NJ_PA_NY_CovidCasesAndDeathsByCounty.dta, clear // master
desc
merge 1:1 county using NJ_PA_NY_Pop2019census.dta //merge 1
drop _merge
save NJ_PA_NY_CovidAndPop.dta, replace

clear
use NJ_PA_NY_Poverty2019census.dta
merge 1:1 county using NJ_PA_NY_CovidAndPop.dta
l
drop _merge
save NJ_PA_NY_CovidPopPoverty.dta, replace

clear
use NJ_PA_NY_CovidPopPoverty.dta
merge 1:1 county using NJ_PA_NY_race.dta
l
drop _merge
save NJ_PA_NY_CovidPopRace.dta, replace

/* Two merges below giving me lots of issues, lots of unmatches, will have to
look further into this */

clear
use NJ_PA_NY_Unemployment2019.dta
merge 1:1 county using NJ_PA_NY_CovidPopRace.dta
l
save NJ_PA_NY_CovidPopRaceUnempETC.dta

clear
use NJ_PA_NY_PopDensity.dta
merge 1:1 county using NJ_PA_NY_CovidPopRace.dta
drop _merge
save NJ_PA_NY_CovidPopPovertyDensity.dta, replace 

//Graphing using NJ_PA_NY_CovidPopRace//

/* as written above, it seems the strongest correlation is that of population, but
from literature and recent news, it is worth exploring race as a factor in covid
severity, which I attempt to do. I use a selection of urban and suburban counties
in Pennsylvania and New Jersey. */

clear
use NJ_PA_NY_CovidPopRace.dta
destring black, gen(black2) force
destring population, gen(population2) force
keep if county == "Allegheny, Pennsylvania" | county == "Philadelphia, Pennsylvania" | county == "Montgomery, Pennsylvania" 
graph hbar cases black2 population2, over(county)
scatter cases black2, mlabel(county)
scatter cases population2, mlabel(county)

use NJ_PA_NY_CovidPopRace.dta
destring black, gen(black2) force
destring white, gen(white2) force
destring population, gen(population2) force
keep if county == "Allegheny, Pennsylvania" | county == "Philadelphia, Pennsylvania" | county == "Montgomery, Pennsylvania" | county == "Essex, New Jersey" | county == "Mercer, New Jersey"
scatter white2 deaths, mlabel(county)
scatter black2 deaths, mlabel(county)

/* I still have to reconfigure the data in order to most accurately analyze race
and mortality risk, as I don't believe I'm quite "there" yet to analyze it fully.
In other words, more data, perhaps on racial percentages rather than raw numbers,
may be needed */

use NJ_PA_NY_CovidPopRace.dta
destring Percbelowpov, gen(povperc2) force
destring Popbelowpov, gen(pov) force
keep if county == "Allegheny, Pennsylvania" | county == "Philadelphia, Pennsylvania" | county == "Montgomery, Pennsylvania" | county == "Essex, New Jersey" | county == "Mercer, New Jersey"
scatter cases pov, mlabel(county)
scatter cases povperc2, mlabel(county)
scatter deaths pov, mlabel(county)
scatter deaths povperc2, mlabel(county)
