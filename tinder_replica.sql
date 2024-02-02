use tinder_replica;
SELECT * FROM users;
SELECT * FROM user_interests;
SELECT * FROM swipes;
SELECT * FROM matches;
SELECT * FROM interests;
----find the user who is the oldest in the 'users' table.---
SELECT name, age,  bio
FROM users
WHERE age = (
		SELECT max(age)
		FROM users
        )
;
---Request the names of all the users who have recieved a right swipe?--
SELECT name, user_id
FROM users
	WHERE user_id IN(SELECT swiped_user_id
	FROM swipes
	WHERE is_like = 1)
    ;
---CODE for the all users who did not recieved right swipe?---
 
SELECT name, user_id
FROM users
	WHERE user_id IN(SELECT swiped_user_id
	FROM swipes
	WHERE is_like = 0)
    ;
---solve question tO return the user_id and name of the oldest user on each plan?---
    SELECT user_id, name, age, plan
FROM users
WHERE (plan, age) IN(
SELECT plan, MAX(age)
    FROM users
    GROUP BY 1
    );
---To return the name and age of users whose age is above the average age of users on their plan.---
SELECT name, age, plan
FROM users u1
WHERE age > (
			SELECT  AVG(age)
            FROM users u2
            WHERE u1.plan = u2.plan );
---Find the names of users who have liked someone who is older than them.----
SELECT name, age
FROM users u1
WHERE EXISTS (
			  SELECT *
              FROM swipes s
              INNER JOIN users u2 ON s.swiped_user_id = u2.user_id
              WHERE s.swiping_user_id = u1.user_id
              AND
              s.is_like = 1 AND u2.age > u1.age);
    
    
    
    
    