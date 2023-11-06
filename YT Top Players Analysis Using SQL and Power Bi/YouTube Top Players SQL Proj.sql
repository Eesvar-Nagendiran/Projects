create database ProjectPortfolio;

/* LOOKING AT MAXIIMUM UPLOADS MADE BY YOUTUBER */
SELECT YOUTUBER, uploads FROM globalytstats
WHERE uploads = (SELECT MAX(uploads) FROM GLOBALYTSTATS);

/* LOOKING AT TOP 5 UPLOADS */
SELECT YOUTUBER, UPLOADS FROM GLOBALYTSTATS
ORDER BY UPLOADS DESC LIMIT 5;


/* Top Continent in the YouTube Space  */
SELECT -- country,
  CASE
    WHEN country IN (
      -- List of Asian countries
      'Afghanistan', 'Armenia', 'Azerbaijan', 'Bahrain', 'Bangladesh', 'Bhutan',
      'Brunei', 'Cambodia', 'China', 'Cyprus', 'Georgia', 'India', 'Indonesia',
      'Iran', 'Iraq', 'Israel', 'Japan', 'Jordan', 'Kazakhstan', 'Kuwait',
      'Kyrgyzstan', 'Laos', 'Lebanon', 'Malaysia', 'Maldives', 'Mongolia', 'Myanmar',
      'Nepal', 'North Korea', 'Oman', 'Pakistan', 'Palestine', 'Philippines', 'Qatar',
      'Saudi Arabia', 'Singapore', 'South Korea', 'Sri Lanka', 'Syria', 'Tajikistan',
      'Thailand', 'Timor-Leste', 'Turkmenistan', 'United Arab Emirates', 'Uzbekistan',
      'Vietnam', 'Yemen') THEN 'Asia'
     WHEN country IN(
       -- List of African countries
      'Algeria', 'Angola', 'Benin', 'Botswana', 'Burkina Faso', 'Burundi', 'Cabo Verde',
      'Cameroon', 'Central African Republic', 'Chad', 'Comoros', 'Congo', 'Djibouti',
      'Egypt', 'Equatorial Guinea', 'Eritrea', 'Eswatini', 'Ethiopia', 'Gabon', 'Gambia',
      'Ghana', 'Guinea', 'Guinea-Bissau', 'Ivory Coast', 'Kenya', 'Lesotho', 'Liberia',
      'Libya', 'Madagascar', 'Malawi', 'Mali', 'Mauritania', 'Mauritius', 'Morocco',
      'Mozambique', 'Namibia', 'Niger', 'Nigeria', 'Rwanda', 'Sao Tome and Principe',
      'Senegal', 'Seychelles', 'Sierra Leone', 'Somalia', 'South Africa', 'South Sudan',
      'Sudan', 'Tanzania', 'Togo', 'Tunisia', 'Uganda', 'Zambia', 'Zimbabwe') then 'Africa'
    WHEN country IN (
       -- List of European countries
      'Albania', 'Latvia', 'Andorra', 'Liechtenstein', 'Armenia', 'Lithuania',
      'Austria', 'Luxembourg', 'Azerbaijan', 'Malta', 'Belarus', 'Moldova',
      'Belgium', 'Monaco', 'Bosnia and Herzegovina', 'Montenegro', 'Bulgaria',
      'Netherlands', 'Croatia', 'Norway', 'Cyprus', 'Poland', 'Czech Republic',
      'Portugal', 'Denmark', 'Romania', 'Estonia', 'Russia', 'Finland',
      'San Marino', 'Former Yugoslav Republic of Macedonia', 'Serbia', 'France',
      'Slovakia', 'Georgia', 'Slovenia', 'Germany', 'Spain', 'Greece', 'Sweden',
      'Hungary', 'Iceland', 'Switzerland', 'Ireland', 'Turkey', 'Italy', 'Ukraine',
      'Kosovo', 'United Kingdom') THEN 'Europe'
    when country in(
      -- List of South American countries
      'Argentina', 'Bolivia', 'Brazil', 'Chile', 'Colombia', 'Ecuador', 'Guyana',
      'Paraguay', 'Peru', 'Suriname', 'Uruguay', 'Venezuela') then 'South America'
    when country in(
      -- List of North American countries
       'Cuba', 'El Salvador', 'Barbados', 'Mexico', 'Canada', 'United States') then 'North America'
    when country in(
      -- List of Australian countries
      'Australia', 'Fiji', 'Papua New Guinea', 'Solomon Islands', 'Vanuatu', 
      'Samoa', 'Tonga', 'Kiribati', 'Tuvalu', 'Nauru', 'Marshall Islands', 
      'Palau', 'Micronesia', 'New Zealand') then 'Australia'
    end as Continent, sum(subscribers) as 'Total Subscribers', sum(uploads) as Uploads,
    sum(`video views`) as 'Total Views',round(sum(highest_yearly_earnings),0) as 'Total Earnings' ,
    count(Youtuber) as 'Total Youtubers'
    from globalytstats
    group by Continent
    order by 5;
  
  
/* Percentage of pay per continent */    

with pct_pay as 
(SELECT -- country,
  CASE
    WHEN country IN (
      -- List of Asian countries
      'Afghanistan', 'Armenia', 'Azerbaijan', 'Bahrain', 'Bangladesh', 'Bhutan',
      'Brunei', 'Cambodia', 'China', 'Cyprus', 'Georgia', 'India', 'Indonesia',
      'Iran', 'Iraq', 'Israel', 'Japan', 'Jordan', 'Kazakhstan', 'Kuwait',
      'Kyrgyzstan', 'Laos', 'Lebanon', 'Malaysia', 'Maldives', 'Mongolia', 'Myanmar',
      'Nepal', 'North Korea', 'Oman', 'Pakistan', 'Palestine', 'Philippines', 'Qatar',
      'Saudi Arabia', 'Singapore', 'South Korea', 'Sri Lanka', 'Syria', 'Tajikistan',
      'Thailand', 'Timor-Leste', 'Turkmenistan', 'United Arab Emirates', 'Uzbekistan',
      'Vietnam', 'Yemen') THEN 'Asia'
     WHEN country IN(
       -- List of African countries
      'Algeria', 'Angola', 'Benin', 'Botswana', 'Burkina Faso', 'Burundi', 'Cabo Verde',
      'Cameroon', 'Central African Republic', 'Chad', 'Comoros', 'Congo', 'Djibouti',
      'Egypt', 'Equatorial Guinea', 'Eritrea', 'Eswatini', 'Ethiopia', 'Gabon', 'Gambia',
      'Ghana', 'Guinea', 'Guinea-Bissau', 'Ivory Coast', 'Kenya', 'Lesotho', 'Liberia',
      'Libya', 'Madagascar', 'Malawi', 'Mali', 'Mauritania', 'Mauritius', 'Morocco',
      'Mozambique', 'Namibia', 'Niger', 'Nigeria', 'Rwanda', 'Sao Tome and Principe',
      'Senegal', 'Seychelles', 'Sierra Leone', 'Somalia', 'South Africa', 'South Sudan',
      'Sudan', 'Tanzania', 'Togo', 'Tunisia', 'Uganda', 'Zambia', 'Zimbabwe') then 'Africa'
    WHEN country IN (
       -- List of European countries
      'Albania', 'Latvia', 'Andorra', 'Liechtenstein', 'Armenia', 'Lithuania',
      'Austria', 'Luxembourg', 'Azerbaijan', 'Malta', 'Belarus', 'Moldova',
      'Belgium', 'Monaco', 'Bosnia and Herzegovina', 'Montenegro', 'Bulgaria',
      'Netherlands', 'Croatia', 'Norway', 'Cyprus', 'Poland', 'Czech Republic',
      'Portugal', 'Denmark', 'Romania', 'Estonia', 'Russia', 'Finland',
      'San Marino', 'Former Yugoslav Republic of Macedonia', 'Serbia', 'France',
      'Slovakia', 'Georgia', 'Slovenia', 'Germany', 'Spain', 'Greece', 'Sweden',
      'Hungary', 'Iceland', 'Switzerland', 'Ireland', 'Turkey', 'Italy', 'Ukraine',
      'Kosovo', 'United Kingdom') THEN 'Europe'
    when country in(
      -- List of South American countries
      'Argentina', 'Bolivia', 'Brazil', 'Chile', 'Colombia', 'Ecuador', 'Guyana',
      'Paraguay', 'Peru', 'Suriname', 'Uruguay', 'Venezuela') then 'South America'
    when country in(
      -- List of North American countries
       'Cuba', 'El Salvador', 'Barbados', 'Mexico', 'Canada', 'United States') then 'North America'
    when country in(
      -- List of Australian countries
      'Australia', 'Fiji', 'Papua New Guinea', 'Solomon Islands', 'Vanuatu', 
      'Samoa', 'Tonga', 'Kiribati', 'Tuvalu', 'Nauru', 'Marshall Islands', 
      'Palau', 'Micronesia', 'New Zealand') then 'Australia'
    end as Continent ,round(sum(highest_yearly_earnings),0) as 'Total Earnings' 
    from globalytstats
    group by Continent
    order by 1 
    )
 
select 
sum(`Total Earnings`) as 'Total Earning',
round(sum(case when Continent = 'Asia' then `Total Earnings` else 0 end)/ sum(`Total Earnings`) * 100,2) as 'Percent of Asia Earned',
round(sum(case when Continent = 'Africa' then `Total Earnings` else 0 end)/ sum(`Total Earnings`) * 100,2) as 'Percent of Africa Earned',
round(sum(case when Continent = 'Australia' then `Total Earnings` else 0 end)/ sum(`Total Earnings`) * 100,2) as 'Percent of Australia Earned',
round(sum(case when Continent = 'Europe' then `Total Earnings` else 0 end)/ sum(`Total Earnings`) * 100,2) as 'Percent of Europe Earned',
round(sum(case when Continent = 'North America' then `Total Earnings` else 0 end)/ sum(`Total Earnings`) * 100,2) as 'Percent of North America Earned',
round(sum(case when Continent = 'South America' then `Total Earnings` else 0 end)/ sum(`Total Earnings`) * 100,2) as 'Percent of South America Earned'
from pct_pay;


/* Top 8 countries percent per pay */
with country_per as(
select country, round(sum(highest_yearly_earnings),0) as 'Total Earnings' from globalytstats
group by 1
order by 2 desc )

select 
sum(`Total Earnings`) as 'Total Earnings',
round(sum(case when country = 'United States' then `Total Earnings` else 0 end)/sum(`Total Earnings`) * 100,2)  as 'Percent of US Earned',
round(sum(case when country = 'India' then `Total Earnings` else 0 end)/sum(`Total Earnings`) * 100,2)  as 'Percent of India Earned',
round(sum(case when country = 'Brazil' then `Total Earnings` else 0 end)/sum(`Total Earnings`) * 100,2)  as 'Percent of Brazil Earned',
round(sum(case when country = 'South Korea' then `Total Earnings` else 0 end)/sum(`Total Earnings`) * 100,2)  as 'Percent of South Korea Earned',
round(sum(case when country = 'United Kingdom' then `Total Earnings` else 0 end)/sum(`Total Earnings`) * 100,2)  as 'Percent of UK Earned',
round(sum(case when country = 'Pakistan' then `Total Earnings` else 0 end)/sum(`Total Earnings`) * 100,2)  as 'Percent of Pakistan Earned',
round(sum(case when country = 'Argentina' then `Total Earnings` else 0 end)/sum(`Total Earnings`) * 100,2)  as 'Percent of Argentina Earned',
round(sum(case when country = 'Russia' then `Total Earnings` else 0 end)/sum(`Total Earnings`) * 100,2)  as 'Percent of Russia Earned'

 from country_per;


/* Top 8 channels types, sum views */

select channel_type, sum(`video views`) as 'Total Views' from globalytstats
group by 1
order by 2 desc limit 8;

