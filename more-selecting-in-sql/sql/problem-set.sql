CREATE TABLE flowers (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(32),
  soil_type VARCHAR(32),
  light_level VARCHAR(32),
  season VARCHAR(32)
);

INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('azalea','acidic','full sun','summer');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('rhododendron','acidic','partial shade','spring');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('camellias','acidic','partial shade','winter');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('hydrangea','acidic','full sun','spring');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('iris','alkaline','full sun','spring');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('daylily','alkaline','full sun','summer');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('lavender','alkaline','full sun','summer');
INSERT INTO flowers (name, soil_type, light_level, season)
VALUES('hosta','alkaline','partial shade','summer');

CREATE TABLE students (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(32),
  height_in_cm INT,
  age INT
);

INSERT INTO students (name, height_in_cm, age)
VALUES('Rae Barajas', 175, 25);
INSERT INTO students (name, height_in_cm, age)
VALUES('Zara Hassan', 151, 48);
INSERT INTO students (name, height_in_cm, age)
VALUES('Rhys Weber', 181, 44);
INSERT INTO students (name, height_in_cm, age)
VALUES('Freddie Howell', 196, 44);
INSERT INTO students (name, height_in_cm, age)
VALUES('Lubna Ewing', 192, 23);
INSERT INTO students (name, height_in_cm, age)
VALUES('Tiya Bowman', 172, 52);
INSERT INTO students (name, height_in_cm, age)
VALUES('Elora Ingram', 178, 26);
INSERT INTO students (name, height_in_cm, age)
VALUES('Kareena Rodriquez', 200, 26);
INSERT INTO students (name, height_in_cm, age)
VALUES('Danielius Madden', 155, 40);
INSERT INTO students (name, height_in_cm, age)
VALUES('Pedro Bolton', 174, 50);

CREATE TABLE states (
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(64),
  area_sq_mi FLOAT,
  population INT
);

INSERT INTO states (name, area_sq_mi, population)
VALUES('Alabama',52420.07,4903185);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Alaska',665384.04,731545);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Arizona',113990.30,7278717);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Arkansas',53178.55,3017825);
INSERT INTO states (name, area_sq_mi, population)
VALUES('California',163694.74,39512223);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Colorado',104093.67,5758736);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Connecticut',5543.41,3565287);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Delaware',2488.72,973764);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Florida',65757.70,21477737);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Georgia',59425.15,10617423);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Hawaii',10931.72,1415872);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Idaho',83568.95,1787065);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Illinois',57913.55,12671821);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Indiana',36419.55,6732219);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Iowa',56272.81,3155070);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Kansas',82278.36,2913314);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Kentucky',40407.80,4467673);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Louisiana',52378.13,4648794);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Maine',35379.74,1344212);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Maryland',12405.93,6045680);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Massachusetts',10554.39,6949503);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Michigan',96713.51,9986857);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Minnesota',86935.83,5639632);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Mississippi',48431.78,2976149);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Missouri',69706.99,6137428);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Montana',147039.71,1068778);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Nebraska',77347.81,1934408);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Nevada',110571.82,3080156);
INSERT INTO states (name, area_sq_mi, population)
VALUES('New Hampshire',9349.16,1359711);
INSERT INTO states (name, area_sq_mi, population)
VALUES('New Jersey',8722.58,8882190);
INSERT INTO states (name, area_sq_mi, population)
VALUES('New Mexico',121590.30,2096829);
INSERT INTO states (name, area_sq_mi, population)
VALUES('New York',54554.98,19453561);
INSERT INTO states (name, area_sq_mi, population)
VALUES('North Carolina',53819.16,10488084);
INSERT INTO states (name, area_sq_mi, population)
VALUES('North Dakota',70698.32,762062);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Ohio',44825.58,11689100);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Oklahoma',69898.87,3956971);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Oregon',98378.54,4217737);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Pennsylvania',46054.34,12801989);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Rhode Island',1544.89,1059361);
INSERT INTO states (name, area_sq_mi, population)
VALUES('South Carolina',32020.49,5148714);
INSERT INTO states (name, area_sq_mi, population)
VALUES('South Dakota',77115.68,884659);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Tennessee',42144.25,6833174);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Texas',268596.46,28995881);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Utah',84896.88,3205958);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Vermont',9616.36,623989);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Virginia',42774.93,8535519);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Washington',71297.95,7614893);
INSERT INTO states (name, area_sq_mi, population)
VALUES('West Virginia',24230.04,1792147);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Wisconsin',65496.38,5822434);
INSERT INTO states (name, area_sq_mi, population)
VALUES('Wyoming',97813.01,578759);
