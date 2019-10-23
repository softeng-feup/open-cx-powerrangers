CREATE TABLE user (
	user_id INTEGER PRIMARY KEY,
	email VARCHAR NOT NULL,
	password VARCHAR NOT NULL,
	is_private BOOLEAN NOT NULL DEFAULT FALSE,
	is_admin BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE personnal_info (
	name VARCHAR,
	date_of_birth DATE,
	user_id INTEGER REFERENCES user
);

CREATE TABLE personnal_interests (
	user_id INTEGER REFERENCES user,
	hobbie_name VARCHAR 
);

CREATE TABLE conference (
	conference_id INTEGER PRIMARY KEY,
	conference_name VARCHAR,
	conference_description VARCHAR,
	location VARCHAR,
	con_date DATE,
	extern_site VARCHAR
);

CREATE TABLE conference_attendees (
	user_id INTEGER REFERENCES user,
	conference_id INTEGER REFERENCES conference
);

CREATE TABLE conference_topics (
	topic_id INTEGER PRIMARY KEY,
	conference_id INTEGER REFERENCES conference,
	topic_desc VARCHAR
);

CREATE TABLE user_interested_topics (
	user_int_id INTEGER PRIMARY KEY,
	topic_id INTEGER REFERENCES conference_topics,
	user_id INTEGER REFERENCES user
);
