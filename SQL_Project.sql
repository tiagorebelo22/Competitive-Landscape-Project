/* Average of Overall Score, Overall, Curriculum and Job Support, for each school */

SELECT coding_schools.schools.school,
		ROUND(AVG(comments.overallScore),2) AS "Average Score",
		ROUND(AVG(comments.overall),2) AS "Overall Score", 
		ROUND(AVG(comments.curriculum),2) AS "Curriculum Score",
		ROUND(AVG(comments.jobSupport),2) AS "Job Support Score", 
        COUNT(*) AS "Number of Reviews"
FROM coding_schools.comments
INNER JOIN coding_schools.schools
ON comments.school_id = schools.school_id
GROUP BY school
ORDER BY AVG(comments.overallScore) DESC;

/* Average of Overall Score in the Top 5, by year*/

SELECT 	school,graduatingYear, ROUND(AVG(comments.overallScore),2) AS average
FROM coding_schools.comments
INNER JOIN coding_schools.schools
ON comments.school_id = schools.school_id
WHERE school in ('product-gym','le-wagon','shecodes','ironhack','software-development-academy') AND graduatingYear IS NOT NULL
GROUP BY graduatingYear, school
ORDER BY graduatingYear ASC;

/* (NOT USED) Average of Overall Score, Overall, Curriculum and Job Support, for each course */

SELECT coding_schools.comments.program,
        ROUND(AVG(comments.overallScore),2) AS "Score Average",
        ROUND(AVG(comments.overall),2) AS Overall, 
        ROUND(AVG(comments.curriculum),2) AS Curriculum,
        ROUND(AVG(comments.jobSupport),2) AS "Job Support", 
        COUNT(*) AS "Number of Reviews"
FROM coding_schools.comments
INNER JOIN coding_schools.schools
ON comments.school_id = schools.school_id
GROUP BY program
ORDER BY AVG(comments.overallScore) DESC;

/* Count of graduated per year */

SELECT 	graduatingYear, COUNT(*) AS "Number of graduates"
FROM coding_schools.comments
WHERE graduatingYear IS NOT NULL
GROUP BY graduatingYear
ORDER BY graduatingYear ASC;

/* Count of graduated per year in the top 5*/

SELECT 	graduatingYear, school, COUNT(*) AS "Number of graduates"
FROM coding_schools.comments
INNER JOIN coding_schools.schools
ON comments.school_id = schools.school_id
WHERE school in ('product-gym','le-wagon','shecodes','ironhack','software-development-academy') AND graduatingYear IS NOT NULL
GROUP BY graduatingYear, school
ORDER BY graduatingYear ASC;


/* Count of countries per school */

SELECT  school, COUNT(DISTINCT locations.country_name) AS "Number of Countries"
FROM coding_schools.locations
INNER JOIN coding_schools.schools
ON locations.school_id = schools.school_id
GROUP BY school;

/* Count of countries per school in the top 5*/

SELECT  school, COUNT(DISTINCT locations.country_name) AS "Number of Countries"
FROM coding_schools.locations
INNER JOIN coding_schools.schools
ON locations.school_id = schools.school_id
WHERE school in ('product-gym','le-wagon','shecodes','ironhack','software-development-academy')
GROUP BY school;

/* Schools with online courses */

SELECT  school, COUNT(*) AS "Online?"
FROM coding_schools.locations
INNER JOIN coding_schools.schools
ON locations.school_id = schools.school_id
WHERE description = 'Online'
GROUP BY school;

/* Number courses per school */

SELECT school, COUNT(*) AS "Number of Courses"
FROM coding_schools.courses
INNER JOIN coding_schools.schools
ON courses.school_id = schools.school_id
GROUP BY coding_schools.schools.school
ORDER BY COUNT(*) DESC;

/* Number courses per top 5 */

SELECT school, COUNT(*) AS "Number of Courses"
FROM coding_schools.courses
INNER JOIN coding_schools.schools
ON courses.school_id = schools.school_id
WHERE school in ('product-gym','le-wagon','shecodes','ironhack','software-development-academy')
GROUP BY coding_schools.schools.school
ORDER BY COUNT(*) DESC;

/* Courses of the top 5 */

SELECT coding_schools.schools.school, GROUP_CONCAT(courses) AS "Courses"
FROM coding_schools.courses
INNER JOIN coding_schools.schools
ON coding_schools.courses.school_id = coding_schools.schools.school_id
WHERE school in ('product-gym','le-wagon','shecodes','ironhack','software-development-academy')
GROUP BY coding_schools.schools.school
ORDER BY COUNT(*) DESC;