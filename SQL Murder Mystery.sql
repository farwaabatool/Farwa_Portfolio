-- SQL City Murder Mystery
-- link: https://mystery.knightlab.com/
--crime; a murder in SQL City on Jan.15 2018

SELECT *  FROM crime_scene_report
  where date = 20180115 and city = 'SQL City' and type = 'murder'

-- There were 2 witnesses. 

-- witness 1
select id, name from person 
 where address_street_name = 'Northwestern Dr' 
 order by address_number DESC; -- assuming that highest the number is the last house

-- witness 2 
select id, name from person
 where address_street_name = 'Franklin Ave' 
 and name like 'Annabel%'
 
select transcript from interview where person_id = 14887 or person_id = 16371
-- murderer had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z".
--Only gold members have those bags. The man got into a car with a plate that included "H42W".
-- The killer from my gym was in the gym on January the 9th.


select person.name, person.id
from get_fit_now_member 
join person on get_fit_now_member.person_id = person.id  
where get_fit_now_member.membership_status = 'gold' 
and get_fit_now_member.id like '48Z%' 

SELECT person.name, person.id
FROM drivers_license
join person on person.license_id = drivers_license.id
where person.id = '28819' or person.id = '67318'
AND drivers_license.plate_number like '%H42W%'
--murderer is 'Jeremy Bowers'
--There's a real villian 

select transcript from interview 
where person_id = '67318'

-- who is the real villian?

select name from person
join facebook_event_checkin on person.id = facebook_event_checkin.person_id 
join drivers_license on person.license_id = drivers_license.id
where facebook_event_checkin.event_name = 'SQL Symphony Concert' 
and facebook_event_checkin.date like '201712%' 
and drivers_license.car_make = 'Tesla'
and drivers_license.car_model = 'Model S' 
and drivers_licenseheight between 65 and 67 
and drivers_license.hair_color = 'red' 
and drivers_license.gender='female'
 -- The real villian : Miranda Priestly
 
