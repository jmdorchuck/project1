
DROP TABLE IF EXISTS Users, Productions, Scripts, Crew, Actors, Producers, 
    Characters, Scenes, Filming_Locations, Locations, Produced_By, Portrays, 
    Feature, Made_Of, Shot_At, Works_On;

DROP TYPE IF EXISTS Specialties;

CREATE TYPE Specialties AS ENUM(
    'Directing',
    'Cinematography',
    'Sound Mixing',
    'Lighting',
    'Gripwork',
    'Script Supervision',
    'Electrician',
    'Costuming',
    'Special Effects',
    'Makeup',
    'Gaffing',
    'Art Directing'
);

CREATE TABLE Users(
            uid int,
            name text,
            phone_num text
                CHECK (phone_num SIMILAR TO '[0-9]{3}-[0-9]{3}-[0-9]{4}'),
            past_cred text,
            email_address text
                CHECK (email_address SIMILAR TO 
                    '[a-zA-Z0-9.]+@[a-zA-Z0-9]+.(com|gov|edu|net|tv|org)'),
            --headshot BLOB,
            conflict_dates timestamp ARRAY,
            PRIMARY KEY(uid)
);

 
CREATE TABLE Crew(
            cid int,
            uid int UNIQUE NOT NULL,
            crew_specialties Specialties[],
            PRIMARY KEY(cid),
            FOREIGN KEY(uid) REFERENCES Users
);
 
CREATE TABLE Actors(
            aid int,
            uid int UNIQUE NOT NULL,
            haircolor text,
            skills text[],
            ethnicity text,
            eye_color text,
            age_range int4range,
            PRIMARY KEY(aid),
            FOREIGN KEY(uid) REFERENCES Users
);
 
CREATE TABLE Producers(
            producer_id int,
            uid int UNIQUE NOT NULL,
            PRIMARY KEY(producer_id),
            FOREIGN KEY(uid) REFERENCES Users
);

CREATE TABLE Scripts(
            script_id int,
            title text,
            page_count int,
            writer text,
            PRIMARY KEY(script_id)
);

CREATE TABLE Productions(
            prod_id int,
            total_budget real,
            prod_title text NOT NULL, -- added for UI purposes
            PRIMARY KEY(prod_id)
);

CREATE TABLE Scenes(
            scene_id int,
            description text,
            special_effects text[],
            props text[],
            stunts text[],
            weather text,
            time_of_day text,
            est_cost float,
            loc_type text,
            PRIMARY KEY(scene_id)
);

CREATE TABLE Characters(
            char_id int,
            char_name text,
            requirements text[],
            age int,
            PRIMARY KEY(char_id)
);

CREATE TABLE Locations(
            loc_id int,
            name text,
            address text,
            description text,
            PRIMARY KEY(loc_id)
);

CREATE TABLE Filming_Locations(
            filming_loc_id int,
            loc_id int REFERENCES Locations,
            scheduling_conf timestamp[],
            rate float,
            PRIMARY KEY(filming_loc_id)
);
            
CREATE TABLE Produced_By(
            prod_id int,
            producer_id int,
            prod_company text,
            PRIMARY KEY(prod_id, producer_id),
            FOREIGN KEY(prod_id) REFERENCES Productions,
            FOREIGN KEY(producer_id) REFERENCES Producers
);
 
CREATE TABLE Portrays(
            aid int,
            char_id int,
            PRIMARY KEY(aid, char_id),
            FOREIGN KEY(aid) REFERENCES Actors,
            FOREIGN KEY(char_id) REFERENCES Characters
);
 
CREATE TABLE Feature(
            script_id int,
            scene_id int,
            char_id int,
            PRIMARY KEY(char_id, scene_id, script_id),
            FOREIGN KEY(scene_id) REFERENCES Scenes,
            FOREIGN KEY(char_id) REFERENCES Characters,
            FOREIGN KEY(script_id) REFERENCES Scripts
);
            
CREATE TABLE Made_Of(
            script_id int,
            prod_id int,
            scene_id int,
            budget real,
            page_num int4range,-- Note that I changed this to a range
            PRIMARY KEY (scene_id, script_id, prod_id),
            FOREIGN KEY (scene_id) REFERENCES Scenes,
            FOREIGN KEY (script_id) REFERENCES Scripts,
            FOREIGN KEY (prod_id) REFERENCES Productions
);
 
 
CREATE TABLE Shot_At(
            scene_id int,
            filming_loc_id int,
            shoot_time time,
            shoot_date timestamp,
            PRIMARY KEY (scene_id, shoot_date), -- Note that I changed the primary key to be shoot date rather than time
            FOREIGN KEY (scene_id) REFERENCES Scenes,
            FOREIGN KEY (filming_loc_id) REFERENCES Filming_Locations
);
 
CREATE TABLE Works_On(
            cid int,
            prod_id int,
            scene_id int,
            role text,
            PRIMARY KEY (scene_id, cid, prod_id),
            FOREIGN KEY (scene_id) REFERENCES Scenes,
            FOREIGN KEY (cid) REFERENCES Crew,
            FOREIGN KEY (prod_id) REFERENCES Productions
);

