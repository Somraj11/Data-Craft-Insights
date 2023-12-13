-- Provide Insights to the Marketing Team in Food & Beverage Industry

-- Tables.
SELECT * FROM dim_cities
SELECT * FROM dim_repondents
SELECT * FROM fact_survey_responses

-- Quick overview of the collected data by marketing team.
-- 1. Number of respondents per city
SELECT city, COUNT(Respondent_ID) as Number_of_responses
FROM dim_repondents as a
JOIN dim_cities as b
ON a.City_ID = b.City_ID
GROUP BY City
ORDER BY Number_of_responses DESC;

-- 2. Number of respondents per gender.
SELECT Gender, COUNT(Respondent_ID) as Number_of_responses
FROM dim_repondents
GROUP BY Gender
ORDER BY Number_of_responses DESC;

-- 3. Number of respondents per Age group.
SELECT Age, COUNT(Respondent_ID) as Number_of_responses
FROM dim_repondents
GROUP BY Age
ORDER BY Number_of_responses DESC;

-- 4. Number of responses by gender and age distribution.
SELECT Gender, Age, COUNT(Respondent_ID) as Number_of_responses
FROM dim_repondents
GROUP BY Gender, Age
ORDER BY Age ASC, Number_of_responses DESC;

--Primary Insights (Sample Sections / Questions) Note: These insights can be derived from the survey responses
--1. Demographic Insights (examples)

--a. Who prefers energy drink more? (male/female/non-binary?)
SELECT Gender, Consume_frequency, COUNT(a.Respondent_ID) as Number_of_responses
FROM fact_survey_responses as a
JOIN dim_repondents as b
on a.Respondent_ID = b.Respondent_ID
GROUP BY Gender, Consume_frequency
ORDER BY Consume_frequency ASC , Number_of_responses DESC;

From the output of the above sql query we can say say that energy drink is more famous in male customers.

--b. Which age group prefers energy drinks more?
SELECT  Consume_frequency, Age, COUNT(a.Respondent_ID) as Number_of_responses
FROM fact_survey_responses as a
JOIN dim_repondents as b
on a.Respondent_ID = b.Respondent_ID
GROUP BY Age, Consume_frequency
ORDER BY Consume_frequency ASC , Number_of_responses DESC;


--c. Which type of marketing reaches the most Youth (15-30)?
SELECT  Marketing_channels, Age, COUNT(a.Respondent_ID) as Number_of_responses
FROM fact_survey_responses as a
JOIN dim_repondents as b
on a.Respondent_ID = b.Respondent_ID
WHERE Age IN ('15-18', '19-30')
GROUP BY Age, Marketing_channels
ORDER BY Number_of_responses DESC


--2. Consumer Preferences:
--a. What are the preferred ingredients of energy drinks among respondents?
SELECT ingredients_expected, COUNT(*) as Number_of_responses
FROM fact_survey_responses
GROUP BY ingredients_expected
ORDER BY Number_of_responses DESC;

--b. What packaging preferences do respondents have for energy drinks?
SELECT packaging_preference, COUNT(*) as Number_of_responses
FROM fact_survey_responses
GROUP BY packaging_preference
ORDER BY Number_of_responses DESC;


--3. Competition Analysis:
--a. Who are the current market leaders?
SELECT current_brands, COUNT(*) as Number_of_responses
FROM fact_survey_responses
GROUP BY current_brands
ORDER BY Number_of_responses DESC;

--b. What are the primary reasons consumers prefer those brands over ours?
SELECT Reasons_for_choosing_brands, COUNT(*) as Number_of_responses
FROM fact_survey_responses
GROUP BY Reasons_for_choosing_brands
ORDER BY Number_of_responses DESC;

--4. Marketing Channels and Brand Awareness:
--a. Which marketing channel can be used to reach more customers?
SELECT Marketing_channels, COUNT(*) AS Count
FROM fact_survey_responses
GROUP BY Marketing_channels
ORDER BY Count DESC
LIMIT 1;

--b. How effective are different marketing strategies and channels in reaching our customers?
SELECT Marketing_channels, COUNT(*) AS Count
FROM fact_survey_responses
GROUP BY Marketing_channels
ORDER BY Count DESC;

--5. Brand Penetration:
--a. What do people think about our brand? (overall rating)
SELECT AVG(Brand_perception) AS OverallBrandRating
FROM fact_survey_responses;

--b. Which cities do we need to focus more on?
SELECT dim_cities.City, AVG(fact_survey_responses.Brand_perception) AS AvgBrandRating
FROM dim_cities
JOIN dim_respondents ON dim_cities.City_ID = dim_respondents.City_ID
JOIN fact_survey_responses ON dim_respondents.Respondent_ID = fact_survey_responses.Respondent_ID
GROUP BY dim_cities.City
ORDER BY AvgBrandRating ASC;

--6. Purchase Behavior:
--a. Where do respondents prefer to purchase energy drinks?
SELECT Purchase_location, COUNT(*) AS Count
FROM fact_survey_responses
GROUP BY Purchase_location
ORDER BY Count DESC;

--b. What are the typical consumption situations for energy drinks among respondents?
SELECT Typical_consumption_situations, COUNT(*) AS Count
FROM fact_survey_responses
GROUP BY Typical_consumption_situations
ORDER BY Count DESC;

--c. What factors influence respondents' purchase decisions, such as price range and limited edition packaging?
SELECT Price_range, COUNT(*) AS Count
FROM fact_survey_responses
GROUP BY Price_range
ORDER BY Count DESC;

-- Additionally, for limited edition packaging influence
SELECT Limited_edition_packaging, COUNT(*) AS Count
FROM fact_survey_responses
GROUP BY Limited_edition_packaging
ORDER BY Count DESC;

--7. Product Development
--a. Which area of business should we focus more on our product development --(Branding/taste/availability)
SELECT
    'Branding' AS FocusArea,
    COUNT(*) AS Count
FROM
    fact_survey_responses
WHERE
    Reasons_for_choosing_brands = 'Brand reputation'

UNION ALL

SELECT
    'Taste' AS FocusArea,
    COUNT(*) AS Count
FROM
    fact_survey_responses
WHERE
    Reasons_for_choosing_brands = 'Taste/flavor preference'

UNION ALL

SELECT
    'Availability' AS FocusArea,
    COUNT(*) AS Count
FROM
    fact_survey_responses
WHERE
    Reasons_for_choosing_brands = 'Availability'





















