SELECT name,handle,email
FROM users
WHERE enabled = 't' AND image is NULL
ORDER BY name;
