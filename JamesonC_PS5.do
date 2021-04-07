// Jameson Colbert, Data Mgmt, PS5, 7 April 2021
// Dr. Adam Okulicz-Kozaryn

/* 
For PS5, I have experimented with macros, loops, and nested loops. I still have
to fix the NYC issue by finding mean cases and deaths for each borough. I also
wish to incorporate more data. For PS5 I have added race. Still need to fix the issue
with 1:1 merges not working properly.
*/

cd C:\Users\jhc157

clear
insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv //NYTimes COVID Data
keep if state == "New Jersey"
replace county = "Atlantic County" if county == "Atlantic"
replace county = "Bergen County" if county == "Bergen"
replace county = "Burlington County" if county == "Burlington"
replace county = "Camden County" if county == "Camden"
replace county = "Cape May County" if county == "Cape May"
replace county = "Cumberland County" if county == "Cumberland"
replace county = "Essex County" if county == "Essex"
replace county = "Gloucester County" if county == "Gloucester"
replace county = "Hudson County" if county == "Hudson"
replace county = "Hunterdon County" if county == "Hunterdon"
replace county = "Mercer County" if county == "Mercer"
replace county = "Middlesex County" if county == "Middlesex"
replace county = "Monmouth County" if county == "Monmouth"
replace county = "Morris County" if county == "Morris"
replace county = "Ocean County" if county == "Ocean"
replace county = "Passaic County" if county == "Passaic"
replace county = "Salem County" if county == "Salem"
replace county = "Somerset County" if county == "Somerset"
replace county = "Sussex County" if county == "Sussex"
replace county = "Union County" if county == "Union"
replace county = "Warren County" if county == "Warren"

save NJCovidCasesAndDeathsByCountyC.dta, replace /*without collapsing cases and deaths,
to be used in a secondary merge using 1:m / m:1 */

collapse cases deaths, by(county)
l
save NJCovidCasesAndDeathsByCountyB.dta, replace //with collapsing
// data sourced from the NYTimes Github

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/co-est2019-alldata.csv //Census data
keep if stname == "New Jersey"
keep ctyname* popestimate2019*
rename ctyname county
l
save NJCensusPop2019B.dta, replace
// data sourced from US Census

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/Raw-data/main/ACSST5Y2019.S1701_data_with_overlays_2021-03-02T224230.csv
drop v1
rename v2 county

replace county = "Atlantic County" if county == "Atlantic County, New Jersey"
replace county = "Bergen County" if county == "Bergen County, New Jersey"
replace county = "Burlington County" if county == "Burlington County, New Jersey"
replace county = "Camden County" if county == "Camden County, New Jersey"
replace county = "Cape May County" if county == "Cape May County, New Jersey"
replace county = "Cumberland County" if county == "Cumberland County, New Jersey"
replace county = "Essex County" if county == "Essex County, New Jersey"
replace county = "Gloucester County" if county == "Gloucester County, New Jersey"
replace county = "Hudson County" if county == "Hudson County, New Jersey"
replace county = "Hunterdon County" if county == "Hunterdon County, New Jersey"
replace county = "Mercer County" if county == "Mercer County, New Jersey"
replace county = "Middlesex County" if county == "Middlesex County, New Jersey"
replace county = "Monmouth County" if county == "Monmouth County, New Jersey"
replace county = "Morris County" if county == "Morris County, New Jersey"
replace county = "Ocean County" if county == "Ocean County, New Jersey"
replace county = "Passaic County" if county == "Passaic County, New Jersey"
replace county = "Salem County" if county == "Salem County, New Jersey"
replace county = "Somerset County" if county == "Somerset County, New Jersey"
replace county = "Sussex County" if county == "Sussex County, New Jersey"
replace county = "Union County" if county == "Union County, New Jersey"
replace county = "Warren County" if county == "Warren County, New Jersey"

rename v125 belowpov
rename v247 percBelowpov
keep county* belowpov* percBelowpov*
l
save NJPoverty2019.dta, replace
// NJ poverty data. data sourced from US Census

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/Raw-data/main/2020%20County%20Health%20Rankings%20New%20Jersey%20Data%20-%20v1_0%20-%20RAW_B.csv
rename v3 county
replace county = "Atlantic County" if county == "Atlantic"
replace county = "Bergen County" if county == "Bergen"
replace county = "Burlington County" if county == "Burlington"
replace county = "Camden County" if county == "Camden"
replace county = "Cape May County" if county == "Cape May"
replace county = "Cumberland County" if county == "Cumberland"
replace county = "Essex County" if county == "Essex"
replace county = "Gloucester County" if county == "Gloucester"
replace county = "Hudson County" if county == "Hudson"
replace county = "Hunterdon County" if county == "Hunterdon"
replace county = "Mercer County" if county == "Mercer"
replace county = "Middlesex County" if county == "Middlesex"
replace county = "Monmouth County" if county == "Monmouth"
replace county = "Morris County" if county == "Morris"
replace county = "Ocean County" if county == "Ocean"
replace county = "Passaic County" if county == "Passaic"
replace county = "Salem County" if county == "Salem"
replace county = "Somerset County" if county == "Somerset"
replace county = "Sussex County" if county == "Sussex"
replace county = "Union County" if county == "Union"
replace county = "Warren County" if county == "Warren"

rename v136 uninsPerc
replace county = "" if county == "County"
replace uninsPerc = "" if uninsPerc == "% Uninsured" 
replace uninsPerc = "" if uninsPerc == "11"

keep county* uninsPerc*
save NJUninsuredPercent.dta, replace
// Rates of uninsured persons. data sourced from https://www.countyhealthrankings.org/app/new-jersey/2020/overview

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/DataMng/main/NJActiveContamSites2020.csv
save NJContamSites.dta, replace 
// Data on contaminated sites in NJ by county. data sourced from https://www.state.nj.us/dep/srp/kcsnj/ 

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/Raw-data/main/Unemployment-RAW.csv
keep if v2 == "NJ" //v2 being the state abbreviation
rename v3 county

replace county = "Atlantic County" if county == "Atlantic County, NJ"
replace county = "Bergen County" if county == "Bergen County, NJ"
replace county = "Burlington County" if county == "Burlington County, NJ"
replace county = "Camden County" if county == "Camden County, NJ"
replace county = "Cape May County" if county == "Cape May County, NJ"
replace county = "Cumberland County" if county == "Cumberland County, NJ"
replace county = "Essex County" if county == "Essex County, NJ"
replace county = "Gloucester County" if county == "Gloucester County, NJ"
replace county = "Hudson County" if county == "Hudson County, NJ"
replace county = "Hunterdon County" if county == "Hunterdon County, NJ"
replace county = "Mercer County" if county == "Mercer County, NJ"
replace county = "Middlesex County" if county == "Middlesex County, NJ"
replace county = "Monmouth County" if county == "Monmouth County, NJ"
replace county = "Morris County" if county == "Morris County, NJ"
replace county = "Ocean County" if county == "Ocean County, NJ"
replace county = "Passaic County" if county == "Passaic County, NJ"
replace county = "Salem County" if county == "Salem County, NJ"
replace county = "Somerset County" if county == "Somerset County, NJ"
replace county = "Sussex County" if county == "Sussex County, NJ"
replace county = "Union County" if county == "Union County, NJ"
replace county = "Warren County" if county == "Warren County, NJ"

rename v86 unempRate2019
keep county* unempRate2019*
l
save NJUnemployment2019.dta, replace 
// data on unemployment. data sourced from https://www.ers.usda.gov/data-products/county-level-data-sets/download-data/ 

// Primary Merges

clear
use NJCensusPop2019B.dta, clear // master
desc
merge 1:1 county using NJCovidCasesAndDeathsByCountyB.dta //merge 1
drop _merge
merge 1:1 county using NJPoverty2019.dta //merge 2
drop _merge
merge 1:m county using NJUninsuredPercent.dta //merge 3
drop _merge
merge m:1 county using NJUnemployment2019 //merge 4
drop _merge
merge m:1 county using NJContamSites.dta  //merge 5
/* for some reason, the three final merges required them to be changed to 1:m/m:1, not sure why*/
tab _merge
tab county
desc _merge

replace county = "" if county == "Geographic Area Name" 
replace county = "" if county == "NAME"
replace belowpov = "" if belowpov == "Estimate!!Below poverty level!!Population for whom poverty status is determined"
replace percBelowpov = "" if percBelowpov == "Estimate!!Percent below poverty level!!Population for whom poverty status is determined"
replace belowpov = "" if belowpov == "S1701_C02_001E"
replace percBelowpov = "" if percBelowpov == "S1701_C03_001E"
l

/* Secondary merges: Merging with Covid Data sans collapse, so as to use 1:m / m:1. Somewhat
redundant now since my primary merges now contain 1:m/m:1 merges, although
I'm not sure that's the way it should be. */

clear
use NJCensusPop2019B.dta, clear // master
desc
merge 1:m county using NJCovidCasesAndDeathsByCountyC.dta 
l

drop _merge
merge m:1 county using NJPoverty2019.dta
drop _merge
merge m:1 county using NJUninsuredPercent.dta
drop _merge
merge m:1 county using NJUnemployment2019
drop _merge
merge m:1 county using NJContamSites.dta 
tab _merge
tab county
desc _merge

replace county = "" if county == "Geographic Area Name" 
replace county = "" if county == "NAME"
replace belowpov = "" if belowpov == "Estimate!!Below poverty level!!Population for whom poverty status is determined"
replace percBelowpov = "" if percBelowpov == "Estimate!!Percent below poverty level!!Population for whom poverty status is determined"
replace belowpov = "" if belowpov == "S1701_C02_001E"
replace percBelowpov = "" if percBelowpov == "S1701_C03_001E"
l

/* Reshape */ 

clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/Raw-data/main/grunfeld.csv
// data sourced from http://people.stern.nyu.edu/wgreene/Econometrics/PanelDataSets.htm
save firms.dta
use firms.dta
l 
/*
I = Investment; F = Real Value of the Firm; C = Real Value of the Firm's Capital Stock 
*/
sample 25
reshape wide firm, i(c)  j(year)
reshape wide i f c, i(year) j(firm)

//PS4
cd C:\Users\jhc157

clear
insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv //NYTimes Github data
keep if state == "Pennsylvania" 
gen county2 = county + state
drop state county
rename county2 county
collapse cases deaths, by (county)
replace county = subinstr(county, "Pennsylvania",", Pennsylvania", .)
l
save PA_CovidCasesAndDeathsByCounty.dta, replace

clear
insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv
keep if state == "New Jersey" 
gen county2 = county + state
drop state county
rename county2 county
collapse cases deaths, by (county)
replace county = subinstr(county, "New Jersey",", New Jersey", .)
l
save NJ_CovidCasesAndDeathsByCounty.dta, replace

clear
insheet using https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv
keep if state == "New York" 
gen county2 = county + state
drop state county
rename county2 county
collapse cases deaths, by (county)
replace county = subinstr(county, "New York",", New York", .)
l
save NY_CovidCasesAndDeathsByCounty.dta, replace

clear
use NY_CovidCasesAndDeathsByCounty.dta, clear // Merging COVID data
desc
merge 1:1 county using PA_CovidCasesAndDeathsByCounty.dta 
drop _merge
merge 1:1 county using NJ_CovidCasesAndDeathsByCounty.dta
l
drop _merge

save NJ_PA_NY_CovidCasesAndDeathsByCounty.dta, replace 

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

/*Merging COVID data with Population and Poverty*/

clear
use NJ_PA_NY_CovidCasesAndDeathsByCounty.dta, clear // master
desc
merge 1:1 county using NJ_PA_NY_Pop2019census.dta //merge 1
drop _merge
save NJ_PA_NY_CovidAndPop.dta, replace

clear
use NJ_PA_NY_Poverty2019census.dta
merge 1:1 county using NJ_PA_NY_CovidAndPop.dta
replace county = subinstr(county, "NAME","", .)
replace county = subinstr(county, "Geographic Area Name","", .)
replace Popbelowpov = subinstr(Popbelowpov, "S1701_C02_001E","", .)
replace Popbelowpov = subinstr(Popbelowpov, "Estimate!!Below poverty level!!Population for whom poverty status is determined","", .)
replace Percbelowpov = subinstr(Percbelowpov, "S1701_C03_001E","", .) 
replace Percbelowpov = subinstr(Percbelowpov, "Estimate!!Percent below poverty level!!Population for whom poverty status is determined","", .) 
l
drop _merge
save NJ_PA_NY_CovidPopPoverty.dta, replace

*Graphs*
clear
use NJ_PA_NY_CovidPopPoverty.dta
graph hbar cases, over(county) /*illegible*/

keep if county == "Philadelphia, Pennsylvania" | county == "Allegheny, Pennsylvania" | county == "Monroe, New York" | county == "Erie, New York" 
graph hbar cases, over(county) 

/*Merging with Population Density*/

clear
insheet using https://raw.githubusercontent.com/camillol/cs424p3/master/data/Population-Density%20By%20County.csv //pop density by Github user camillol
keep if geodisplaylabel == "Pennsylvania"
rename gct_stubdisplaylabel county
replace county = subinstr(county, " County",", Pennsylvania", .)
rename densitypersquaremileoflandarea popdensitysqmi
keep county popdensitysqmi
save PA_PopDensity.dta, replace

clear
insheet using https://raw.githubusercontent.com/camillol/cs424p3/master/data/Population-Density%20By%20County.csv 
keep if geodisplaylabel == "New Jersey"
rename gct_stubdisplaylabel county
replace county = subinstr(county, " County",", New Jersey", .)
rename densitypersquaremileoflandarea popdensitysqmi
keep county popdensitysqmi
save NJ_PopDensity.dta, replace

clear
insheet using https://raw.githubusercontent.com/camillol/cs424p3/master/data/Population-Density%20By%20County.csv 
keep if geodisplaylabel == "New York"
rename gct_stubdisplaylabel county
replace county = subinstr(county, " County",", New York", .)
rename densitypersquaremileoflandarea popdensitysqmi
keep county popdensitysqmi
save NY_PopDensity.dta, replace

/* Merging this data*/

use PA_PopDensity.dta
merge 1:1 county using NJ_PopDensity.dta
drop _merge
merge 1:1 county using NY_PopDensity.dta
drop _merge
save NJ_PA_NY_PopDensity.dta
l

clear
use NJ_PA_NY_PopDensity.dta
merge 1:m county using NJ_PA_NY_CovidPopPoverty.dta
drop _merge
save NJ_PA_NY_CovidPopPovertyDensity.dta, replace 

// macro and loop attempts

use NJ_PA_NY_CovidPopPovertyDensity.dta, clear

local continuous cases deaths
tab1 `continuous' 

local continuousB popdensitysqmi population
tab1 `continuousB'

local continuousC continuous continuousB
tab1 `continuousC' //not working

foreach cvar in cases deaths {
tab `cvar'
}

foreach pvar in population popdensitysqmi {
tab `pvar'
}

/* nested loop attempt*/

foreach cvar  in "cases" "deaths" {
  foreach pvar in "population" "popdensitysqmi" {
    di "this is cases deaths pop and popdens"
  }
}

/*graphs again*/ //use two letter codes
clear
use NJ_PA_NY_CovidPopPovertyDensity.dta
keep if county == "Philadelphia, Pennsylvania" | county == "Allegheny, Pennsylvania" | county == "Monroe, New York" | county == "Erie, New York" | county == "Hudson, New Jersey" | county == "Salem, New Jersey" | county == "Delaware, Pennsylvania" | county == "Tioga, Pennsylvania"
graph hbar cases popdensitysqmi, over(county) /*I see a correlation!*/

scatter cases popdensitysqmi, mlabel(county) /* high density counties usually have more cases, but let's do a random sample*/

clear
use NJ_PA_NY_CovidPopPovertyDensity.dta
sample 10
scatter cases popdensitysqmi, mlabel(county) 
graph hbar cases popdensitysqmi, over(county)

clear
use NJ_PA_NY_CovidPopPovertyDensity.dta
keep if county == "Philadelphia, Pennsylvania" | county == "Allegheny, Pennsylvania" | county == "Monroe, New York" | county == "Erie, New York" | county == "Hudson, New Jersey" | county == "Salem, New Jersey" | county == "Delaware, Pennsylvania" | county == "Tioga, Pennsylvania"
destring Percbelowpov, gen(PercbelowpovB)
graph hbar cases PercbelowpovB, over(county)

/* Adding Race */
clear
insheet using https://raw.githubusercontent.com/jamesonrutgers/Raw-data/main/ACSDT5Y2019.B02001_data_with_overlays_2021-04-07T164844.csv
drop v1
rename v2 county
drop v3
drop v4 v6 v8 v10 v11 v12 v13 v14 v15 v16 v18 v19 v20 v21 v22
drop v6 v8 v10 v12 v13 v14 v15 v16 v17 v18 v19 v20 v21 v22
rename v5 white
rename v7 black
rename v9 indigenous
rename v11 asian
replace county = subinstr(county, " County, New Jersey",", New Jersey", .)
replace county = subinstr(county, " County, New York",", New York", .)
replace county = subinstr(county, " County, Pennsylvania",", Pennsylvania", .)
save NJ_PA_NY_race.dta, replace

/* Merge */
use NJ_PA_NY_CovidPopPovertyDensity.dta
merge m:1 county using NJ_PA_NY_race.dta
l
save NJ_PA_NY_CovidPopRace.dta, replace


/*graphs*/

use NJ_PA_NY_CovidPopRace.dta
drop _merge v17
drop if county == ", New York City, New York"

destring black, gen(black2) force
destring white, gen(white2) force

keep if county == "Philadelphia, Pennsylvania" | county == "Allegheny, Pennsylvania" | county == "Monroe, New York" | county == "Erie, New York" | county == "Hudson, New Jersey" | county == "Salem, New Jersey" | county == "Delaware, Pennsylvania" | county == "Tioga, Pennsylvania"
graph hbar cases black2 white2, over(county)
graph hbar cases popdensitysqmi, over(county)

// trying to fix New York City issue, for PS6
//perc of population with covid to compare perc of impoverished; perc compare with perc
//compare covid over time, line graphs, can use with original NYTimes dataset
