from twisted.web import server, resource
from twisted.internet import reactor
import json 
from pymongo import MongoClient
import sys

dbconfig = None

class PeopleResource(resource.Resource):
        isLeaf = True
        
        def render_GET(self, request):
            request.setHeader("content-type", "text/html")
            out = "<html><body>"
            out += "<h1>People in the Database</h1>"
            out += "<table><tr><th>First Name</th><th>Last Name</th></tr>"
            
            global dbconfig
            client = MongoClient(dbconfig['connectionString'])
            db = client['hr']
            people = db.people

            for person in people.find():
                out += "<tr><td>" + str(person['firstname']) + "</td><td>" + str(person['lastname']) + "</td></tr>"

            out += "</table>"    
            out += "</body></html>"
            return out
        

if __name__ == "__main__":

    with open(sys.argv[1]) as config_file:
            dbconfig = json.load(config_file)

    reactor.listenTCP(80, server.Site(PeopleResource()))
    reactor.run()

