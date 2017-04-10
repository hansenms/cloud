from twisted.web import server, resource
from twisted.internet import reactor
import json 
import pyodbc
import sys

dbconfig = None

class PeopleResource(resource.Resource):
        isLeaf = True
        
        def render_GET(self, request):
            request.setHeader("content-type", "text/html")
            out = "<html><body>"
            out += "<h1>People in the Database</h1>"
            out += "<table><tr><th>ID</th><th>First Name</th><th>Last Name</th></tr>"
            
            global dbconfig 
            server = dbconfig["sqlserver"] 
            database = dbconfig["db"]
            username = dbconfig["dbuser"]
            password = dbconfig["dbpasswd"]
            driver= '{ODBC Driver 13 for SQL Server}'
            cnxn = pyodbc.connect('DRIVER='+driver+';PORT=1433;SERVER='+server+';PORT=1443;DATABASE='+database+';UID='+username+';PWD='+ password)
            cursor = cnxn.cursor()
            cursor.execute("SELECT ID, FirstName, LastName FROM dbo.People")
            row = cursor.fetchone()
            while row:
                out += "<tr><td>" + str(row[0]) + "</td><td>" + str(row[1]) + "</td><td>" + str(row[2]) + "</td></tr>"
                row = cursor.fetchone()

            out += "</table>"    
            out += "</body></html>"
            return out
        

if __name__ == "__main__":

    with open(sys.argv[1]) as config_file:
            dbconfig = json.load(config_file)

    reactor.listenTCP(80, server.Site(PeopleResource()))
    reactor.run()
                                        


