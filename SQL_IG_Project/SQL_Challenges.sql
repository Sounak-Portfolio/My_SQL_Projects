-- Challenge 1
-- Find the 5 oldest users.
select * from users
order by created_at 
limit 5;

-- Challenge 2
-- What day of the week do most users register on ? / Most popular registration date.
 select 
		dayname(created_at) as days,
        count(username) as no_of_users
from users
group by days
order by no_of_users desc
limit 3;

-- Challenge 3
-- Identify inactive users(find the user who never posted a photo).
select username,image_url from users
left join photos on users.id=photos.user_id
where image_url is null;

-- Challenge 4
-- Identify most popular photos and user who created it
select 
		username,
        photos.id,
        photos.image_url,
        count(*) as total
from photos
inner join likes  
	on likes.photo_id=photos.id
inner join users
	on users.id=photos.user_id
group by photos.id
order by total desc
limit 1;

-- Challenge 5
-- Calculate average no of photos per user.
select username,(photos.id)/sum(users.id) as average_photos
from photos
	inner join users
	on users.id=photos.user_id
group by username
order by average_photos desc;
-- select
-- (select count(*) from photos)/(select count(*) from users) as avg

-- Challenge 6
-- Five most popular hashtags.
select tags.tag_name,
	   count(*) as total
from photo_tags
join tags
	on photo_tags.tag_id=tags.id
group by tags.id
order by total desc
limit 5;

-- Challenge 7
-- Finding bots - users who have liked every single photo
SELECT username, 
       COUNT(*) AS num_likes
FROM users 
INNER JOIN likes ON users.id = likes.user_id 
GROUP BY likes.user_id 
HAVING num_likes IN (
  SELECT COUNT(*) 
  FROM photos
)

-- ---------------------------------------------------------------------------- THE END --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------       