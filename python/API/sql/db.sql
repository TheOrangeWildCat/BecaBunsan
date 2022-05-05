CREATE TABLE IF NOT EXISTS users
(
    id integer NOT NULL,
    name character varying ,
    username character varying ,
    email character varying ,
    address character varying ,
    phone character varying ,
    website character varying ,
    company character varying ,
    CONSTRAINT users_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS todos
(
    userId integer,
    id integer NOT NULL,
    title character varying ,
    completed boolean,
    CONSTRAINT todos_pkey PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS albums
(
    userId integer,
    id integer NOT NULL,
    title character varying ,
    CONSTRAINT albums_pkey PRIMARY KEY (id),
    CONSTRAINT id_user FOREIGN KEY (userId) REFERENCES users (id) 
);

CREATE TABLE IF NOT EXISTS photos
(
    albumId integer,
    id integer NOT NULL,
    title character varying ,
    url character varying ,
    thumbnailUrl character varying ,
    CONSTRAINT photos_pkey PRIMARY KEY (id)
    CONSTRAINT album_id FOREIGN KEY (albumId) REFERENCES albums (id)
);

CREATE TABLE IF NOT EXISTS posts
(
    userId integer,
    id integer NOT NULL,
    title character varying ,
    body character varying ,
    CONSTRAINT posts_pkey PRIMARY KEY (id)
    CONSTRAINT user_id FOREIGN KEY (userId) REFERENCES users (id)
);

CREATE TABLE IF NOT EXISTS comments
(
    postId integer,
    id integer NOT NULL,
    name character varying ,
    email character varying ,
    body character varying ,
    CONSTRAINT comments_pkey PRIMARY KEY (id)
    CONSTRAINT post_id FOREIGN KEY (postId) REFERENCES posts (id)
);