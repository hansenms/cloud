from pymongo import MongoClient
import sys

def setup_database(conString):
    client = MongoClient(conString)
    db = client['hr']
    people = db.people
    people.insert_one({"lastname": "Gates", "firstname": "William", "email":"bill@gates.com"})
    people.insert_one({"lastname": "Jobs", "firstname": "Steve", "email":"steve@jobs.com"})
    
if __name__ == "__main__":
    connectionString = sys.argv[1]
    setup_database(connectionString)
