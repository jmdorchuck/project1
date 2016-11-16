#!/usr/bin/env python2.7

"""
Columbia W4111 Intro to databases
Example webserver

To run locally

    python server.py

Go to http://localhost:8111 in your browser


A debugger such as "pdb" may be helpful for debugging.
Read about it online.
"""

import os
from datetime import datetime, time, date
from sqlalchemy import *
from sqlalchemy.pool import NullPool
from flask import Flask, abort, request, render_template, g, redirect, Response, make_response, url_for, session, escape
from psycopg2.extras import Range, NumericRange

from operator import itemgetter

tmpl_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')
sttc_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'static')

app = Flask(__name__, template_folder=tmpl_dir, static_folder=sttc_dir)


#
# The following uses the postgresql test.db -- you can use this for debugging purposes
# However for the project you will need to connect to your Part 2 database in order to use the
# data
#
# XXX: The URI should be in the format of: 
#
#     postgresql://USER:PASSWORD@<IP_OF_POSTGRE_SQL_SERVER>/postgres
#
# For example, if you had username ewu2493, password foobar, then the following line would be:
#
#     DATABASEURI = "postgresql://ewu2493:foobar@<IP_OF_POSTGRE_SQL_SERVER>/postgres"
#
# Swap out the URI below with the URI for the database created in part 2
# Anurag's Database:
# DATABASEURI = "postgresql://arc2183:e7wtm@104.196.175.120/postgres"

# Tyrus' Database:
DATABASEURI = "postgresql://thc2125:ejv8d@104.196.175.120/postgres"


#
# This line creates a database engine that knows how to connect to the URI above
#
engine = create_engine(DATABASEURI, echo=True)


#
# START SQLITE SETUP CODE
#
# after these statements run, you should see a file test.db in your webserver/ directory
# this is a sqlite database that you can query like psql typing in the shell command line:
# 
#     sqlite3 test.db
#
# The following sqlite3 commands may be useful:
# 
#     .tables               -- will list the tables in the database
#     .schema <tablename>   -- print CREATE TABLE statement for table
# 
# The setup code should be deleted once you switch to using the Part 2 postgresql database
#
#engine.execute("""DROP TABLE IF EXISTS test;""")
#engine.execute("""CREATE TABLE IF NOT EXISTS test (
#  id serial,
#  name text
#);""")
#engine.execute("""INSERT INTO test(name) VALUES ('grace hopper'), ('alan turing'), ('ada lovelace');""")
#
# END SQLITE SETUP CODE
#



@app.before_request
def before_request():
  """
  This function is run at the beginning of every web request 
  (every time you enter an address in the web browser).
  We use it to setup a database connection that can be used throughout the request

  The variable g is globally accessible
  """
  try:
    g.conn = engine.connect()
  except:
    print "uh oh, problem connecting to database"
    import traceback; traceback.print_exc()
    g.conn = None

@app.teardown_request
def teardown_request(exception):
  """
  At the end of the web request, this makes sure to close the database connection.
  If you don't the database could run out of memory!
  """
  try:
    g.conn.close()
  except Exception as e:
    pass

user_types = {'crew':'cid','actors':'aid','producers':'pid'}


#
# @app.route is a decorator around index() that means:
#   run index() whenever the user tries to access the "/" path using a GET request
#
# If you wanted the user to go to e.g., localhost:8111/foobar/ with POST or GET then you could use
#
#       @app.route("/foobar/", methods=["POST", "GET"])
#
# PROTIP: (the trailing / in the path is important)
# 
# see for routing: http://flask.pocoo.org/docs/0.10/quickstart/#routing
# see for decorators: http://simeonfranklin.com/blog/2012/jul/1/python-decorators-in-12-steps/
#
@app.route('/')
def index():
  """
  request is a special object that Flask provides to access web request information:

  request.method:   "GET" or "POST"
  request.form:     if the browser submitted a form, this contains the data in the form
  request.args:     dictionary of URL arguments e.g., {a:1, b:2} for http://localhost?a=1&b=2

  See its API: http://flask.pocoo.org/docs/0.10/api/#incoming-request-data
  """

  # DEBUG: this is debugging code to see what request looks like
  print request.args


  #
  # example of a database query
  #
  #cursor = g.conn.execute("SELECT name FROM test")
  #names = []
  #for result in cursor:
  #  names.append(result['name'])  # can also be accessed using result[0]
  #cursor.close()

  #
  # Flask uses Jinja templates, which is an extension to HTML where you can
  # pass data to a template and dynamically generate HTML based on the data
  # (you can think of it as simple PHP)
  # documentation: https://realpython.com/blog/python/primer-on-jinja-templating/
  #
  # You can see an example template in templates/index.html
  #
  # context are the variables that are passed to the template.
  # for example, "data" key in the context variable defined below will be 
  # accessible as a variable in index.html:
  #
  #     # will print: [u'grace hopper', u'alan turing', u'ada lovelace']
  #     <div>{{data}}</div>
  #     
  #     # creates a <div> tag for each element in data
  #     # will print: 
  #     #
  #     #   <div>grace hopper</div>
  #     #   <div>alan turing</div>
  #     #   <div>ada lovelace</div>
  #     #
  #     {% for n in data %}
  #     <div>{{n}}</div>
  #     {% endfor %}
  #
  #context = dict(data = names)


  #
  # render_template looks in the templates/ folder for files.
  # for example, the below file reads template/index.html
  #
  #return render_template("index.html", **context)
  return render_template("index.html")


#
# This is an example of a different path.  You can see it at
# 
#     localhost:8111/another
#
# notice that the functio name is another() rather than index()
# the functions for each app.route needs to have different names
#
@app.route('/another')
def another():
  return render_template("anotherfile.html")


# Example of adding new data to the database
# @app.route('/add', methods=['POST'])
# def add():
#  name = request.form['name']
#  print name
#  cmd = 'INSERT INTO test(name) VALUES (:name1), (:name2)';
#  g.conn.execute(text(cmd), name1 = name, name2 = name);
#  return redirect('/')

# Define our error function.
def errorpage(message=None, redo_link="/index", action="try again"):
  if message==None:
    return render_template("error.html", redo_link="/addproduction", action="add your production")
  else:
    return render_template("error.html",redo_link=redo_link, action=action, message=message)

# Set the array limit for array inputs
array_limit=50

@app.route('/login')
def login():
  return render_template("login.html")  

@app.route('/login_2_site', methods=['POST'])
def login_2_site():
  uid = request.form['uid']
  count = g.conn.execute("SELECT COUNT(uid) FROM Users WHERE uid=%s",(uid,)).rowcount
  
  if count == 1:
    cursor = g.conn.execute("SELECT name FROM Users WHERE uid=%s",(uid,))
    name = cursor.first()['name']
    resp = make_response(redirect('/'))
    resp.set_cookie('uid',uid)
    resp.set_cookie('name',name)
    cursor.close()
    return resp

@app.route('/register')
def register():
#  cursor = g.conn.execute("SELECT name,password FROM Users")
  return render_template("register.html", types=user_types.keys())  

@app.route('/register_4_site', methods=['POST'])
def register_4_site():

  # Gather the form variables
  name = request.form['name']

  phone_num = request.form['phone_num1']+'-'+request.form['phone_num2']+'-'+request.form['phone_num3']
  if len(phone_num) != 12:
    return render_template("registration-error.html")
  past_cred_raw = request.form['past_cred'] 
  past_cred = past_cred_raw if past_cred_raw != 'None' else 'null' 
  email_address = request.form['email_address']
  if (name != None and phone_num != None and email_address != None):
    # First, we need to generate the next available uid.
    cursor = g.conn.execute("SELECT MAX(uid) AS uid FROM Users")
    new_uid = int(cursor.fetchone()['uid'])+1
    cursor.close()

    # Try to insert the user into the Users table
    try:
      select_cmd = "SELECT uid FROM Users where uid=:u"
      cursor = g.conn.execute(text(select_cmd), u=new_uid)
      if cursor.rowcount==0:
        insert_cmd = "INSERT INTO Users VALUES (:u, :n, :p, :c, :e)"
        g.conn.execute(text(insert_cmd), u=new_uid, n=name, p=phone_num, c=past_cred, e=email_address)
      cursor.close
    except:
      return render_template("registration-error.html")

    # Try to insert the user into the Crew, Actors, and Producers tables respectively.
    # I need to come back to this-the previous code was ugly as sin. 
    return render_template("registered.html",name=name)  

  else:
    return render_template("registration-error.html")

@app.route('/addscript')
def addscript():
  return render_template("addscript.html")  

@app.route('/addscript_2_db', methods=['POST'])
def addscript_2_db():
  # Gather the form variables
  try:
    title = request.form['title']
    writer = request.form['writer']
    page_count = int(request.form['page_count'])
  except:
    return errorpage(message="There appears to be a problem with your inserted values.")

  # Find the last added script id then generate the next script id
  cursor = g.conn.execute("SELECT MAX(script_id) AS sid FROM Scripts")
  try:
    new_sid = int(cursor.fetchone()['sid'])+1
  except: 
    new_sid = 0
  cursor.close()
 
  try:
    select_cmd = "SELECT script_id FROM Scripts WHERE script_id=:s"
    cursor = g.conn.execute(text(select_cmd), s=new_sid)
    if cursor.rowcount==0:
      insert_cmd = "INSERT INTO Scripts VALUES (:i, :t, :p, :w)"
      g.conn.execute(text(insert_cmd), i=new_sid, t=title, p=page_count, w=writer)
    cursor.close
  except:
    return errorpage(redo_link="/addscript", action="add your script")

  return render_template("success.html", action="adding your script")

@app.route('/addcharacter')
def addcharacter():
  return render_template("addcharacter.html")  

@app.route('/addcharacter_2_db', methods=['POST'])
def addcharacter_2_db():
  # Define error links and actions
  redo_link = "/addcharacter"
  action = "add your character"
  
  # Gather the form variables
  try:
    name = request.form['name']
    age = int(request.form['age'])
    if len(request.form.getlist('requirements[]')) > array_limit: 
      raise Exception()
    requirements = filter(None, request.form.getlist('requirements[]'))
  except:
    return errorpage(message="There appears to be a problem with your inserted values.",redo_link=redo_link, action=action )

  # Find the last added character id then generate the next character id
  cursor = g.conn.execute("SELECT MAX(char_id) AS cid FROM Characters")

  try: 
    new_cid = int(cursor.fetchone()['cid'])+1
  except:
    new_cid = 0
  cursor.close()


  try:
    g.conn.execute(text('INSERT INTO Characters VALUES (:i, :n, :r, :a)'), i=new_cid, n=name, r=requirements, a=age)

  except:
    return errorpage(redo_link=redo_link, action=action)

  return render_template("success.html", action="adding your character")

@app.route('/addproduction')
def addproduction():
  
  cursor = g.conn.execute("SELECT P.producer_id,U.name FROM Producers AS P, Users as U WHERE P.uid=U.uid")
  producer_list = []
  for producer in cursor:
    producer_list.append(producer)
  cursor.close()
  if len(producer_list)>0:
    return render_template("addproduction.html", producerlist=producer_list)
  else:
    return errorpage(message="Please add a producer before trying to add a "
                             "production")

@app.route('/addproduction_2_db', methods=['POST'])
def addproduction_2_db():

  # First gather the form data
  try:
    production_company = request.form['production_company']  
    producers = request.form.getlist('producers') 
    producer_ids = map(lambda p: int((p.split(' - '))[0]), producers)
    budget = float(request.form['budget'])

  except:
    return errorpage() 
  # Determine the new production id.

  cursor = g.conn.execute("SELECT MAX(prod_id) AS pid FROM Productions")
  try:
    new_pid = int(cursor.fetchone()['pid'])+1
  except:
    new_pid = 0
  cursor.close()

  # Now, we add the production to the production table  
  try: 
    g.conn.execute(text('INSERT INTO Productions VALUES (:p, :b)'), p=new_pid, b=budget)
  except:
    return errorpage(message="There was a problem with the values you are trying to add.") 

  # Now, we add the producer/production relationship to the "Produced by" table
  try: 
    for producers in producer_ids:
      select_cmd = ("SELECT prod_id, producer_id FROM Produced_By "
                    "WHERE prod_id=:p AND producer_id=:r")
      cursor = g.conn.execute(text(select_cmd), p=new_pid, r=producers)
      if cursor.rowcount == 0:
        insert_cmd = "INSERT INTO Produced_by VALUES (:p, :r, :c)"
      g.conn.execute(text(insert_cmd), p=new_pid, r=producers, c=production_company)
  except:
    # If we fail, we have to delete any existing records of the production
    g.conn.execute(text('DELETE FROM Produced_by WHERE prod_id=:p'), p=new_pid)
    g.conn.execute(text('DELETE FROM Productions WHERE prod_id=:p'), p=new_pid)
    return errorpage() 


  return render_template("success.html", action="adding your production")

@app.route('/productionselect')
def productionselect():
  cursor = g.conn.execute(text("SELECT prod_id,prod_title FROM Productions"))
  production_list = []
  for production in cursor:
    production_list.append(production)
  cursor.close()
  return render_template("productionselect.html",productionlist = production_list)

@app.route('/selectproduction_2_edit', methods=['POST'])
def selectproduction_2_edit():
  # Determine which production they want to edit
  try: 
    production = request.form['prod2edit'] 
    prod_id = int((production.split(' - '))[0])
    query = ("SELECT S.scene_id, S.description, M.page_num "
            "FROM Scenes AS S, Made_Of AS M "
            "WHERE S.scene_id=M.scene_id AND S.scene_id IN (SELECT scene_id "
                                  "FROM Made_Of "
                                  "WHERE prod_id=:p)")
    cursor = g.conn.execute(text(query),p=prod_id)
    scene_list = []
    for scene in cursor:
      scene_list.append(scene)
    cursor.close()
    print scene_list
    scene_list.sort(key=itemgetter(2)) 
    print scene_list

  except:
    return render_template("error.html", redo_link="/productionselect", action="select another production")

  return render_template("productionconsole.html", scenelist=scene_list, production=prod_id)

@app.route('/addscene')
def addscene():
  # Determine the production to which you are adding a scene
  prod_id=int(request.args.get('production')) 
 
  # Provide a list of scripts.
  cursor = g.conn.execute("SELECT script_id,title FROM Scripts")
  script_list = []
  for script in cursor:
    script_list.append(script)
  cursor.close()


  # Provide a list of characters.
  cursor = g.conn.execute(text("SELECT char_id,char_name FROM Characters"))
  character_list = []
  for character in cursor:
    character_list.append(character)
  cursor.close()


  try:
    cursor = g.conn.execute(text("SELECT prod_title FROM Productions WHERE prod_id=:p"),p=prod_id)
    title = cursor.fetchone()['prod_title']
    return render_template("addscene.html",prod_id=prod_id, prod_title=title, 
                            scripts=script_list, characters=character_list) 
  except:
    return errorpage()
   
@app.route('/addscene_2_db', methods=['POST'])
def addscene_2_db():

  # Gather the form variables
  try:
    prod_id = int(request.form['production'])
    script = int((request.form['script'].split(' - '))[0])
    first_page = int(request.form['lower_page']) 
    second_page = int(request.form['upper_page']) 
    page_range = (NumericRange(lower=first_page,upper=second_page)
                  if first_page<second_page 
                  else NumericRange(lower=second_page,upper=first_page))
    description = request.form['description']

    # Make sure the lists of arrays are not larger than the limit
    if (len(request.form.getlist('sfx[]')) > array_limit or 
        len(request.form.getlist('props[]')) > array_limit or 
        len(request.form.getlist('stunts[]')) > array_limit):
      raise Exception()
    else:
      sfx = filter(None, request.form.getlist('sfx[]')) # Remove any empty strings from the SFX array
      props = filter(None, request.form.getlist('props[]')) # Remove any empty strings from the SFX array
      stunts = filter(None, request.form.getlist('stunts[]')) # Remove any empty strings from the SFX array
    weather = request.form['weather']
    time_of_day = request.form['tod']
    location = request.form['location']
    cost = float(request.form['cost'])
    budget = float(request.form['budget'])
    characters = request.form.getlist('characters')
    character_ids = map(lambda c: int((c.split(' - '))[0]), characters)
  except:
    return errorpage(message="There was a problem with your input",
                     redo_link="/productionselect", 
                     action="add your scene again")

  # Determine the new scene id.

  cursor = g.conn.execute(text("SELECT MAX(scene_id) AS sid FROM Scenes"))
  try:
    new_sid = int(cursor.fetchone()['sid'])+1
  except:
    new_sid = 0
  cursor.close()

  try:
    # Add to the Scenes Table
    insert_scenes_cmd = ("INSERT INTO Scenes "
                        "VALUES(:s, :d, :f, :p, :t, :w, :o, :c, :l)")
    g.conn.execute(text(insert_scenes_cmd),s=new_sid,d=description,f=sfx, 
                                           p=props, t=stunts, w=weather, 
                                           o=time_of_day, c=cost, l=location)
   
    # Add to the "Scripts and Productions are Made_Of Scenes" Table
    insert_made_of_cmd = "INSERT INTO Made_of VALUES(:c, :p, :s, :b, :r)"
    g.conn.execute(text(insert_made_of_cmd), c=script, p=prod_id, s=new_sid, 
                                             b=budget, r=page_range)

    # Add to the "Scenes Feature Characters" Table
    for cid in character_ids:
      insert_feature_cmd = "INSERT INTO Feature VALUES(:c, :s, :r)"
      g.conn.execute(text(insert_feature_cmd), c=script, s=new_sid, r=cid)

  except:
    return errorpage(message="There was a problem with the database",
                     redo_link="/addscene?production="+str(prod_id), 
                     action="add your scene again")

   
  return render_template("success.html", action="adding your scene")
  
@app.route('/managescene')
def managescene():
  redo_link = "/productionselect"
  action = "select your production again"
  
  # Gather the variables
  try:
    prod_id = int(request.args.get('production'))
    scene_id = int(request.args.get('scene'))
 
  except:
    return errorpage(redo_link=redo_link, action=action, 
              message="Missing production or scene.")

  try:
    # Create a list of possible actors
    cursor = g.conn.execute(text("SELECT Actors.aid,Users.name "
                           "FROM Actors, Users "
                           "WHERE Actors.uid=Users.uid"))
    actor_list = []
    for actor in cursor:
      actor_list.append(actor)
    cursor.close()

    # Create a list of roles
    cursor = g.conn.execute(text("SELECT char_id,char_name "
                                 "FROM Characters "
                                 "WHERE char_id IN (SELECT char_id "
                                 "FROM Feature "
                                 "WHERE scene_id=:s)"),
                              s=scene_id) 

    character_list = []
    for character in cursor:
      character_list.append(character)
    cursor.close()
   

    # Create a list of possible crew 
    cursor = g.conn.execute(text("SELECT Crew.cid,Users.name "
                                 "FROM Crew, Users "
                                 "WHERE Crew.uid=Users.uid"))
    crew_list = []
    for crew in cursor:
      crew_list.append(crew)
    cursor.close()

    # Create a list of possible filming locations 
    cursor = g.conn.execute(text("SELECT F.filming_loc_id, L.name, L.description "
                                 "FROM Filming_Locations as F, Locations as L "
                                 "WHERE F.loc_id=L.loc_id"))
    location_list = []
    for location in cursor:
      location_list.append(location)
    cursor.close()


  except:
    return errorpage(redo_link=redo_link, action=action, message="There is an error with the database.")

  return render_template("managescene.html", production=prod_id, scene=scene_id,
                                             characters=character_list,
                                             actors=actor_list,
                                             crew=crew_list,
                                             locations=location_list)


@app.route('/managescene_n_db', methods=['POST'])
def managescene_n_db():
  # Define error strings
  redo_link = "/productionselect"
  action = "select your production again"
  # Gather the variables




  try:
    # Portrays Variables
    # scene_id from above
    scene_id = int(request.form['scene'])
    actors = request.form.getlist('actors')
    actor_ids = map(lambda a: int((a.split(' - '))[0]), actors)
    characters = request.form.getlist('characters')
    char_ids = map(lambda c: int(c), characters)
    prod_id = int(request.form['production'])


    # Works_On Variables
    crew_size = int(request.form['crewsize'])    
    crew_ids_roles_raw = []
    for i in range(crew_size):
      print 'crew'+str(i)
      crew_ids_roles_raw.append(request.form.getlist('crew'+str(i)))
    crew_ids_roles = map(lambda c: [(c[0].split(' - '))[0],(c[0].split(' - '))[1],c[1]], crew_ids_roles_raw)
    print crew_ids_roles


  except:
    return errorpage(redo_link=redo_link, action=action)

  try:
    # Shot_At Variables
    # scene_id from above
    filming_loc_id =  int((request.form['location']).split(' - ')[0])
    shoot_time = (datetime.strptime(request.form['shoot_time'], "%H:%M")).time()
    shoot_date = (datetime.strptime(request.form['shoot_date'], "%m/%d/%Y")).date()

  except: 
    return errorpage(message="Please use the following input for dates: "
                             "mm/dd/yyyy"
                             "and the following for times (using 24-hour conventions):"
                             "hh:mm",
                             redo_link=redo_link, action=action)


  # Insert the Portrays data in the database
  try:
    if len(char_ids) != len(actor_ids):
      raise Exception

    select_portrays_test="SELECT aid, char_id FROM portrays WHERE aid=:a AND char_id=:c"
    insert_portrays_cmd="INSERT INTO Portrays VALUES(:a, :c)"

    for ac,ch in zip(actor_ids,char_ids):
      cursor = g.conn.execute(text(select_portrays_test),
                                   a=ac,c=ch) 
      if cursor.rowcount==0:
        g.conn.execute(text(insert_portrays_cmd),a=ac, c=ch) 
      cursor.close()

  except:
    return errorpage(message="There was a problem adding actor roles into the database.")

  # Insert the Works_On data in the database
  try:
    select_works_on_test=("SELECT cid, prod_id, scene_id FROM Works_On "
                         "WHERE cid=:c AND prod_id=:p AND scene_id=:s")
    insert_works_on_cmd="INSERT INTO Works_On VALUES(:c, :p, :s, :r)"
    for c in crew_ids_roles:
      print c
      cursor = g.conn.execute(text(select_works_on_test), c=c[0], 
                              p=prod_id, s=scene_id,) 
      if cursor.rowcount==0:
        g.conn.execute(text(insert_works_on_cmd),c=c[0], 
                                                 p=prod_id, s=scene_id, 
                                                 r=c[2]) 

      cursor.close()

  except:
    return errorpage(message="There was a problem adding crew roles into the database.")


  # Insert the Shot_At data in the database
  try:
    select_shot_at_test=("SELECT scene_id, shoot_date FROM Shot_At "
                         "WHERE scene_id=:s AND shoot_date=:d")
    insert_works_on_cmd="INSERT INTO Shot_At VALUES(:s, :l, :t, :d)"
    cursor = g.conn.execute(text(select_shot_at_test), s=scene_id, d=shoot_date) 
    if cursor.rowcount==0:
      g.conn.execute(text(insert_works_on_cmd), s=scene_id, l=filming_loc_id,
                                                t=shoot_time, d=shoot_date)

      cursor.close()

  except:
    return errorpage(message="There was a problem adding time and location data into the database.")


  return render_template("success.html", action="managing your scene")

@app.route('/findtalent')
def findtalent():
  try:
    select_actor_cmd = ("SELECT U.name,A.Haircolor, A.skills, A.eye_color, A.age_Range "
                        "FROM Actors as A, Users as U "
                        "WHERE A.uid=U.uid")

    cursor = g.conn.execute(text(select_actor_cmd))
    actor_list=[]
    for actor in cursor:
      actor_list.append(actor)
    cursor.close()

    return render_template("findtalent.html", actors=actor_list)

  except:
    return errorpage()

if __name__ == "__main__":
  import click

  @click.command()
  @click.option('--debug', is_flag=True)
  @click.option('--threaded', is_flag=True)
  @click.argument('HOST', default='0.0.0.0')
  @click.argument('PORT', default=8111, type=int)
  def run(debug, threaded, host, port):
    """
    This function handles command line parameters.
    Run the server using

        python server.py

    Show the help text using

        python server.py --help

    """

    HOST, PORT = host, port
    print "running on %s:%d" % (HOST, PORT)
    app.run(host=HOST, port=PORT, debug=debug, threaded=threaded)


  run()
