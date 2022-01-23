CREATE TYPE correct_ans AS ENUM('a0', 'a1', 'a2', 'a3');
CREATE TABLE IF NOT EXISTS questions (
    id serial PRIMARY KEY,
    full_statement varchar NOT NULL,
    a0 varchar NOT NULL,
    a1 varchar NOT NULL,
    a2 varchar NOT NULL,
    a3 varchar NOT NULL,
    correct correct_ans NOT NULL, 
    domain varchar DEFAULT 'general'
);

CREATE TABLE IF NOT EXISTS roles (
    id serial PRIMARY KEY,
    value varchar NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS users (
    id serial PRIMARY KEY,
    username varchar NOT NULL UNIQUE,
    mail varchar DEFAULT 'x',
    password varchar NOT NULL,
    mail_confirmed boolean DEFAULT TRUE,
    role_id integer DEFAULT 1 REFERENCES roles(id),
    score integer DEFAULT 0,
    flags_score integer DEFAULT 0
);

CREATE TABLE IF NOT EXISTS flagged_questions (
    question_id integer REFERENCES questions(id),
    user_id integer REFERENCES users(id),
    PRIMARY KEY (question_id, user_id) 
);

INSERT INTO roles (value) VALUES ('USER'), ('MANAGER'), ('ADMIN');
-- admin pass123
INSERT INTO users (username, password, role_id, mail_confirmed) VALUES ('admin', '$2a$10$bVRYyXyfGBWbhT0fDYCJWenRqkaKFgT2WJZTj/RJZM9vi6p8NjwvW', 3, TRUE); 

CREATE EXTENSION tsm_system_rows;
