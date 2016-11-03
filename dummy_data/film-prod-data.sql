-- Empty all the existing tables
TRUNCATE Users, Productions, Scripts, Crew, Actors, Producers,Characters, 
    Scenes, Filming_Locations, Locations, Produced_By, Portrays, Feature, 
    Made_Of, Shot_At, Works_On;

-- Insert dummy data into Users
INSERT INTO Users VALUES (1, 'Mr. Movie Phone', '555-555-5555', 'Moviephone (VO)',
    'MrMviFone@gmail.com',  ARRAY ['2016-11-18', '2016-11-19', 
    '2016-11-20']::date[]); 
INSERT INTO Users VALUES (2, 'Johnny Depp', '555-963-5756', 
    'Pirates of the Caribbean, Edward Scissorhands, Cry Baby',
    'jdepp@gmail.com',  ARRAY ['2016-11-18', '2016-11-19', 
    '2016-11-20']::date[]); 
INSERT INTO Users VALUES (3, 'Robby Benson', '212-858-0918', 
    'Running Brave, Friends, Our Town, Ellen, Caroline in the City, Sabrina the Teenage Witch',
    'rbenson@gmail.com',  ARRAY ['2016-11-18', '2016-11-19', 
    '2016-11-20']::date[]); 
INSERT INTO Users VALUES (4, 'Noob Actor', '818-934-8321', '',
    'breakingin@gmail.com',  ARRAY []::date[]); 
INSERT INTO Users VALUES (5, 'Robert Gonyo', '646-745-2835', 'Radio COTE, Decadent Acts',
    'robert.gonyo@gmail.com',  ARRAY []::date[]); 
INSERT INTO Users VALUES (6, 'Sarah Pencheff', '917-842-4132', 'Space Qats, Vignettes for the Apocalypse, The Vampire Lesbians of Sodom',
    'spench@gmail.com',  ARRAY ['2016-12-15','2016-12-20','2016-12-21','2017-02-15']::date[]); 
INSERT INTO Users VALUES (7, 'Tyrant Rex', '646-706-1476', 'Too many to name',
    'thc2125@columbia.edu',  ARRAY []::date[]); 
INSERT INTO Users VALUES (8, 'Brick Dilette', '834-878-9123', '',
    'brickdirects@hotmail.com',  ARRAY []::date[]); 
INSERT INTO Users VALUES (9, 'Tommy Crewman', '224-834-2354', '',
    'tommy383193@aol.com',  ARRAY []::date[]); 
INSERT INTO Users VALUES (10, 'Charlii.com', '243-293-9562', '',
    'charlii@charlii.com',  ARRAY ['2016-11-18', '2016-11-19', 
    '2016-11-20','2016-12-15','2016-12-20','2016-12-21','2017-02-14','2017-02-15','2017-02-28']::date[]); 
INSERT INTO Users VALUES (11, 'Paulie Producer', '845-998-8146', '',
    'paulie@roadhouseproductions.tv',  ARRAY []::date[]); 
INSERT INTO Users VALUES (12, 'Paulina Producer', '845-998-8146', '',
    'paulina@roadhouseproductions.tv',  ARRAY ['2016-12-22','2016-12-23','2016-12-24','2016-12-25','2017-01-01','2017-01-02','2017-02-14']::date[]); 
INSERT INTO Users VALUES (13, 'Seanvolio Dudemanbro', '334-363-3125', '',
    'deke@nyrf.org',  ARRAY ['2016-12-22','2016-12-23','2016-12-24','2016-12-25']::date[]); 
INSERT INTO Users VALUES (14, 'Gregory Gaffer', '453-495-2394', '',
    'gaffman@iatse.org',  ARRAY []::date[]); 
INSERT INTO Users VALUES (15, 'Suzie Scriptsupe', '783-123-1111', 'The Sun Is Not Enough, In Praise of Shadows, The Boy King',
    'ss7@nyu.edu',  ARRAY []::date[]); 
INSERT INTO Users VALUES (16, 'Carmine Camron', '583-222-1293', 'The Sun Is Not Enough, Supers, Space Qats',
    'ccameras@yahoo.com',  ARRAY ['2016-10-22','2016-11-08']::date[]); 
INSERT INTO Users VALUES (17, 'Bruce Vozman', '229-913-5211', 'The Sun Is Not Enough, Yu-Gi-Oh, The Giver',
    'thevoice899@geocities.com',  ARRAY ['2016-10-31','2016-11-21']::date[]); 
INSERT INTO Users VALUES (18, 'Lenny Lightinstatz', '284-244-2911', 'The Sun Is Not Enough, Collegivity, Chud 2',
    'ireallywanttoact@gmail.com',  ARRAY ['2016-10-31','2016-11-21']::date[]); 
INSERT INTO Users VALUES (19, 'Kee Grip', '919-922-9234', 'Principals',
    'hiremenow000@gmail.com',  ARRAY ['2017-03-25','2017-03-31']::date[]); 
INSERT INTO Users VALUES (20, 'Johnny Fitz', '212-333-3934', 'The Trail of Ontario, Prep School Blues, The Demon Lady',
    'JonnyFitzYou912@gmail.com',  ARRAY []::date[]); 

-- Insert dummy data into Crew
INSERT INTO Crew VALUES (1, 3, ARRAY ['Directing','Cinematography','Lighting']::Specialties[]);
INSERT INTO Crew VALUES (2, 4, NULL);
INSERT INTO Crew VALUES (3, 5, ARRAY ['Directing','Art Directing','Sound Mixing']::Specialties[]);
INSERT INTO Crew VALUES (4, 6, ARRAY ['Special Effects', 'Costuming', 'Makeup']::Specialties[]);
INSERT INTO Crew VALUES (5, 7, ARRAY ['Directing', 'Sound Mixing', 'Lighting', 'Cinematography']::Specialties[]);
INSERT INTO Crew VALUES (6, 8, ARRAY ['Directing']::Specialties[]);
INSERT INTO Crew VALUES (7, 9, ARRAY ['Gaffing']::Specialties[]);
INSERT INTO Crew VALUES (8, 13, ARRAY ['Gripwork']::Specialties[]);
INSERT INTO Crew VALUES (9, 14, ARRAY ['Gripwork', 'Gaffing', 'Electrician']::Specialties[]);
INSERT INTO Crew VALUES (10, 15, ARRAY ['Script Supervision']::Specialties[]);

-- Insert dummy data into Actors

INSERT INTO Actors VALUES (1, 1, 'Brown', ARRAY['Swordfighting', 'Voiceover', 
    'German Accent'], 'Caucasian', 'Brown', '[45, 60]');
INSERT INTO Actors VALUES (2, 2, 'Brown', ARRAY['Swordfighting, Unarmed Combat', 
    'Voiceover', 'Irish Accent'], 'Caucasian', 'Brown', '[35, 55]');
INSERT INTO Actors VALUES (3, 3, 'Salt and Pepper', ARRAY['Singing', 
    'Voiceover'], 'Caucasian', 'Brown', '[45, 60]');
INSERT INTO Actors VALUES (4, 4, 'Blonde', ARRAY['Ballet'], 'Caucasian', 'Brown', '[15, 21]');
INSERT INTO Actors VALUES (5, 5, 'Brown', ARRAY['Voiceover'], 'Caucasian', 
    'Brown', '[28, 37]');
INSERT INTO Actors VALUES (6, 6, 'Green', ARRAY['Ballet', 'Tap Dancing', 
    'Voiceover', 'Singing'], 'Caucasian', 'Green', '[27, 35]');
INSERT INTO Actors VALUES (7, 7, 'Blue', ARRAY['Voiceover', 'Singing', 
    'Unarmed Combat', 'Swordfighting'], 'Caucasian', 'Brown', '[25, 35]');
INSERT INTO Actors VALUES (8, 10, 'Black', ARRAY['Driving'], 'African American', 'Brown', '[30, 35]');
INSERT INTO Actors VALUES (9, 17, 'Bald', ARRAY['Voiceover'],
    'Caucasian', 'Brown', '[38, 55]');
INSERT INTO Actors VALUES (10, 18, '', ARRAY['Bodybuilding'], 'Caucasian', 
    'Blue', '[35, 45]');

-- Insert dummy data into Producers

INSERT INTO Producers VALUES (1, 3);
INSERT INTO Producers VALUES (2, 5);
INSERT INTO Producers VALUES (3, 7);
INSERT INTO Producers VALUES (4, 10);
INSERT INTO Producers VALUES (5, 11);
INSERT INTO Producers VALUES (6, 12);
INSERT INTO Producers VALUES (7, 17);
INSERT INTO Producers VALUES (8, 18);
INSERT INTO Producers VALUES (9, 20);
INSERT INTO Producers VALUES (10, 2);

-- Insert dummy data into Scripts
INSERT INTO Scripts VALUES (1, 'Heaven', 12, 'Tyrant Rex');
INSERT INTO Scripts VALUES (2, 'Board Game Night', 12, 'Tyrant Rex');
INSERT INTO Scripts VALUES (3, 'Star Power', 12, 'Tyrant Rex');
INSERT INTO Scripts VALUES (4, 'Finn''s Notes', 12, 'Sean Murray');
INSERT INTO Scripts VALUES (5, 'Star Trek 12', 8, 'Sean Von Gorman');
INSERT INTO Scripts VALUES (6, 'I Put a Spell on You', 5, 'Isaac Brody');
INSERT INTO Scripts VALUES (7, 'Jack and Larsen', 7, 'Chris Conner');
INSERT INTO Scripts VALUES (8, 'Viktor', 6, 'Brandt Wrightsman');
INSERT INTO Scripts VALUES (9, 'The Pregnancy of Angela Freak', 100, 'Brian Griffin');
INSERT INTO Scripts VALUES (10, 'Hurricane William', 10, 'Randy Grossman');
INSERT INTO Scripts VALUES (11, 'My Last Day', 24, 'Greg Wilcox');
INSERT INTO Scripts VALUES (12, 'The Lost Years', 16, 'Jim Metcalf');
INSERT INTO Scripts VALUES (13, 'Who''s There?', 18, 'Joe DiSeek');
INSERT INTO Scripts VALUES (14, 'Autumn Snow', 6, 'Klima Change');
INSERT INTO Scripts VALUES (15, 'Lulu''s Tutu', 16, 'Jim Metcalf');

-- Insert dummy data into Productions
INSERT INTO Productions VALUES (1, 1000);
INSERT INTO Productions VALUES (2, 500);
INSERT INTO Productions VALUES (3, 15000);
INSERT INTO Productions VALUES (4, 800);
INSERT INTO Productions VALUES (5, 11000);
INSERT INTO Productions VALUES (6, 3875);
INSERT INTO Productions VALUES (7, 109000);
INSERT INTO Productions VALUES (8, 15600);
INSERT INTO Productions VALUES (9, 600);
INSERT INTO Productions VALUES (10, 700);

-- Insert dummy data into Scenes
INSERT INTO Scenes VALUES (1, 'David and Emily go to see the mysterious Solon''s comet, but its appearance causes a change in Emily and a nearby bum.', ARRAY['bright flash of light'], ARRAY['telescope', 'magazine', 'blanket', 'bottle'], ARRAY['David pushes bum to the ground'],'chilly', 'night', 300, 'A park'); --Heaven Scene 1

INSERT INTO Scenes VALUES (2, 'David comes home to find Emily''s condition has not improved, and their cat Hancock is caught in the crossfire.', ARRAY['fake blood'], ARRAY['cat', 'butcher knife', 'coffee mug', 'tea kettle', 'newspaper articles'], ARRAY['David tries to restrain Emily', 'Emily comes at David with the butcher knife'],'indoors', 'evening', 500, 'a messy apartment'); --Heaven Scene 2

INSERT INTO Scenes VALUES (3, 'David goes to the institution housing Emily and talks to her doctor. He discovers the comet has affected more than her', ARRAY[]::text[], ARRAY['billy club'], ARRAY['Bum attacks David', 'Orderly hits the bum with a billy club'],'indoors', 'evening', 800, 'the hallway of a mental institution'); --Heaven Scene 3
INSERT INTO Scenes VALUES (4, 'David goes to visit Emily, but their bittersweet reunion is cut short by the return of the comet', ARRAY['comets falling', 'insitution shaking and being destroyed by the falling comets', 'explosion rocking the sky'], ARRAY[]::text[], ARRAY[]::text[],'indoors', 'evening', 750, 'a padded cell in a mental institution'); --Heaven Scene 4
INSERT INTO Scenes VALUES (5, 'Emily walks amidst the rubble of the institution, embracing the bum as the world falls to chaos', ARRAY['comets falling'], ARRAY[]::text[], ARRAY['Bum kicks David''s corpse'],'calm', 'evening', 1000, 'the ruins of the mental institution'); --Heaven Scene 5
INSERT INTO Scenes VALUES(6, 'Ana walks into Steven''s classroom, but their meeting is cut short by Jasper', ARRAY[]::text[], ARRAY['scissors', 'crayons', 'paper cutouts', 'stapler'], ARRAY[]::text[], 'indoors', 'late afternoon', 300, 'elementary school classroom');
INSERT INTO Scenes VALUES(7, 'Jasper threatens Steven in the hallway', ARRAY[]::text[], ARRAY[]::text[], ARRAY['Jasper pushes Steven against a locker'], 'indoors', 'late afternoon', 300, 'elementary school hallway with lockers');
INSERT INTO Scenes VALUES(8, 'Jasper creepily hits on Ana as Finn watches', ARRAY[]::text[], ARRAY['student drawings','Finn''s first note'], ARRAY['Ana falls off a desk and Jasper catches her'], 'indoors', 'late afternoon', 300, 'elementary school classroom');
INSERT INTO Scenes VALUES(9, 'Brighid and Finn have an argument on the roof', ARRAY['Finn snaps his fingers and disappears'], ARRAY[]::text[], ARRAY['roof scene'], 'chilly', 'night', 300, 'elementary school classroom');
INSERT INTO Scenes VALUES(10, 'Finn surprises Steven in his apartment', ARRAY[]::text[], ARRAY['magazine with Finn on the cover', 'filled grocery bags', 'keys', 'cell phone', 'eggs'], ARRAY['Steven knocks himself out opening the door and collapses'], 'indoors', 'night', 250, 'Steven''s Apartment');

-- Insert dummy data into Characters

INSERT INTO Characters Values(1,'David',ARRAY['squirelly', 'bookish'], 28);
INSERT INTO Characters Values(2,'Emily',ARRAY['bubbly', 'energetic', 'fun'], 26);
INSERT INTO Characters Values(3,'Bum',ARRAY['scraggly', 'rough', 'unarmed combat'], 45);
INSERT INTO Characters Values(4,'Doctor Bonderman',ARRAY['cold', 'mature', 'professional'], 40);
INSERT INTO Characters Values(5,'Orderly',ARRAY['bodybuilding', 'bald', 'big'], 35);
INSERT INTO Characters Values(6,'Steven',ARRAY['frail', 'clumsy', 'warm', 'comedic timing'], 25);
INSERT INTO Characters Values(7,'Ana',ARRAY['warm', 'tough', 'sarcastic'], 25);
INSERT INTO Characters Values(8,'Jasper',ARRAY['sleazy', 'caucasian'], 32);
INSERT INTO Characters Values(9,'Finn',ARRAY['short', 'bald', 'caucasian', 'irish accent', 'comedic timing'], 42);
INSERT INTO Characters Values(10,'Brighid',ARRAY['flighty', 'wise'], 32);

-- Insert dummy data into "Locations"

INSERT INTO Locations VALUES (1, 'The Bamford 4C', '333 East 56th Street Apt. 4c New York, NY 11104', 'Luxury apartment in New York City with doorman, modern furnishings, and plenty of light.');
INSERT INTO Locations VALUES (2, 'The Belmont', '320 East 46th Street Apt. 6S New York, NY 10019', 'Luxury apartment in New York City featuring exposed brick and lots of space. No elevator.');
INSERT INTO Locations VALUES (3, 'Riverside Park', 'Riverside Dr. To Hudson River, W. 72 ST.TO St Clair Pl. New York, NY', 'Scenic park in Riverside open to film shoots.');
INSERT INTO Locations VALUES (4, 'Ocean Hill Playground', 'Dean St., Bergen St. Bet. Rockaway AVE.AND Hopkinson Ave. Brooklyn, NY', 'Playground for kids and the whole family.');
INSERT INTO Locations VALUES (5, '57 West 57th', '57 W. 57th St. New York, NY 10012', 'Standard office space for monthly or weekly rent.');
INSERT INTO Locations VALUES (6, '1325 Avenue of the Americas', '1325 Avenue of the Americas New York, NY 10014', 'Beautiful luxury offices with a doorman and elevator.');
INSERT INTO Locations VALUES (7, 'P.S. 153', '1750 AMSTERDAM AVENUE, Manhattan, NY 10031', 'Manhattan public elementary school open to film shoots.');
INSERT INTO Locations VALUES (8, 'P.S. 173', '306 FORT WASHINGTON AVENUE, Manhattan, NY 10033', 'Fort Washington Public School-shoot your next project here!');
INSERT INTO Locations VALUES (9, 'The Bristol', '300 East 56th St., Manhattan, NY 10003', 'Luxury apartment building with rooftop access for shoots. Insurance required.');
INSERT INTO Locations VALUES (10, '5982 Skillman Ave.', '300 East 56th St., Woodside, NY 11104', 'Simple brownstone. No elevator. Insurance required.');
INSERT INTO Locations VALUES (11, 'Mt. Sinai Beth Israel', 'First Avenue at 16th Street, New York, NY', 'Hospital for filming');


-- Insert dummy data into Filming_Locations
INSERT INTO Filming_Locations VALUES (1, 1, ARRAY[]::date[], 5000);
INSERT INTO Filming_Locations VALUES (2, 2, ARRAY['2016-10-31', '2016-12-22']::date[], 8000);
INSERT INTO Filming_Locations VALUES (3, 10, ARRAY['2016-11-15', '2016-11-16', '2016-11-17']::date[], 10000);
INSERT INTO Filming_Locations VALUES (4, 7, ARRAY['2017-01-22', '2017-01-31', '2017-03-21']::date[], 15000);
INSERT INTO Filming_Locations VALUES (5, 6, ARRAY['2017-01-22', '2017-01-31', '2017-03-21']::date[], 15000);
INSERT INTO Filming_Locations VALUES (6, 8, ARRAY[]::date[], 800);
INSERT INTO Filming_Locations VALUES (7, 3, ARRAY['2017-04-01']::date[], 1800);
INSERT INTO Filming_Locations VALUES (8, 4, ARRAY[]::date[], 0);
INSERT INTO Filming_Locations VALUES (9, 5, ARRAY['2016-12-31', '2017-01-01', '2017-01-02']::date[], 20000);
INSERT INTO Filming_Locations VALUES (10, 9, ARRAY[]::date[], 1000);
INSERT INTO Filming_Locations VALUES (11, 11, ARRAY[]::date[], 50000);


-- Insert dummy data into Produced_By
INSERT INTO Produced_By VALUES (1, 1, 'Beast Productions');
INSERT INTO Produced_By VALUES (2, 1, 'Beast Productions');
INSERT INTO Produced_By VALUES (3, 2, 'Co-op Theatre East');
INSERT INTO Produced_By VALUES (4, 3, 'Collectivitis');
INSERT INTO Produced_By VALUES (5, 3, 'Radio Cote / Aquamercury Creations');
INSERT INTO Produced_By VALUES (5, 2, 'Radio Cote / Aquamercury Creations');
INSERT INTO Produced_By VALUES (8, 5, 'P Squared Films');
INSERT INTO Produced_By VALUES (8, 6, 'P Squared Films');
INSERT INTO Produced_By VALUES (7, 7, 'The Voice Features');
INSERT INTO Produced_By VALUES (7, 3, 'The Voice Features');

-- Insert Dummy Data into Portrays
INSERT INTO Portrays VALUES (5, 1); --David
INSERT INTO Portrays VALUES (2, 2); --Emily
INSERT INTO Portrays VALUES (3, 3); --Bum
INSERT INTO Portrays VALUES (1, 4); --Dr. Bonderman
INSERT INTO Portrays VALUES (10, 5); --Orderly
INSERT INTO Portrays VALUES (4, 6); --Steven
INSERT INTO Portrays VALUES (8, 7); --Ana
INSERT INTO Portrays VALUES (7, 8); --Jasper
INSERT INTO Portrays VALUES (1, 9); --Finn
INSERT INTO Portrays VALUES (6, 10); --Brighid

-- Insert dummy data into Feature 
INSERT INTO Feature VALUES (1, 1, 1);
INSERT INTO Feature VALUES (1, 1, 2);
INSERT INTO Feature VALUES (1, 1, 3);
INSERT INTO Feature VALUES (1, 2, 1);
INSERT INTO Feature VALUES (1, 2, 2);
INSERT INTO Feature VALUES (1, 3, 1);
INSERT INTO Feature VALUES (1, 3, 4);
INSERT INTO Feature VALUES (1, 3, 3);
INSERT INTO Feature VALUES (1, 3, 5);
INSERT INTO Feature VALUES (4, 1, 6);

--Insert Dummy values into Made_Of
INSERT INTO Made_Of VALUES (4, 4, 6, NULL, '[1,3]');
INSERT INTO Made_Of VALUES (4, 4, 7, NULL, '[3,4]');
INSERT INTO Made_Of VALUES (4, 4, 8, NULL, '[4,4]');
INSERT INTO Made_Of VALUES (4, 4, 9, NULL, '[5,6]');
INSERT INTO Made_Of VALUES (4, 4, 10, NULL, '[6,7]');
INSERT INTO Made_Of VALUES (1, 5, 1, NULL, '[1,2]');
INSERT INTO Made_Of VALUES (1, 5, 2, NULL, '[2,4]');
INSERT INTO Made_Of VALUES (1, 5, 3, NULL, '[4,6]');
INSERT INTO Made_Of VALUES (1, 5, 4, NULL, '[6,8]');
INSERT INTO Made_Of VALUES (1, 5, 5, NULL, '[8,8]');



-- Insert Dummy Values into Shot_At
INSERT INTO Shot_At VALUES (1, 3, '21:00', '2016-09-23');
INSERT INTO Shot_At VALUES (2, 5, '17:00', '2016-09-22');
INSERT INTO Shot_At VALUES (3, 11, '05:00', '2016-09-24');
INSERT INTO Shot_At VALUES (4, 11, '17:00', '2016-09-24');
INSERT INTO Shot_At VALUES (5, 4, '23:00', '2016-09-28');
INSERT INTO Shot_At VALUES (6, 8, '16:00', '2016-07-05');
INSERT INTO Shot_At VALUES (7, 8, '18:00', '2016-07-05');
INSERT INTO Shot_At VALUES (8, 7, '16:00', '2016-07-08');
INSERT INTO Shot_At VALUES (9, 9, '23:00', '2016-07-08');
INSERT INTO Shot_At VALUES (10, 9, '03:00', '2016-07-09');

-- Insert dummy data into Works_On
INSERT INTO Works_On VALUES (5, 4, 6, 'Director, Gaffer, Cinematographer');
INSERT INTO Works_On VALUES (4, 4, 6, 'Makeup, Costuming');
INSERT INTO Works_On VALUES (5, 4, 7, 'Director, Gaffer, Cinematographer');
INSERT INTO Works_On VALUES (5, 4, 8, 'Director, Gaffer, Cinematographer');
INSERT INTO Works_On VALUES (5, 4, 9, 'Director, Gaffer, Cinematographer');
INSERT INTO Works_On VALUES (5, 4, 10, 'Director, Gaffer, Cinematographer');
INSERT INTO Works_On VALUES (3, 1, 1, 'Director, Sound Mixer');
INSERT INTO Works_On VALUES (5, 1, 1, 'Cinematographer');
INSERT INTO Works_On VALUES (5, 1, 2, 'Cinematographer');
INSERT INTO Works_On VALUES (3, 1, 2, 'Director, Sound Mixer');
INSERT INTO Works_On VALUES (5, 1, 3, 'Cinematographer');
INSERT INTO Works_On VALUES (3, 1, 3, 'Director, Sound Mixer');


