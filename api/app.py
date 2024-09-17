from flask import Flask, request
from api.records import HousePoints
import os

MONGO_LINK = os.getenv("MONGO_LINK")

app = Flask(__name__)

@app.route("/")
def index():
    return "<marquee direction = 'left'><h1>Welcome to Hogwarts!</h1></marquee>"

@app.route("/change-points", methods = ["POST"])
def add_points():
    data = request.form
    command = data.get("command")
    db = HousePoints(MONGO_LINK)

    try:
        if " points to " in command:
            a, b = command.split(" points to ")
            points = [int(a), b]

        elif " points from " in command:
            a, b = command.split(" points from ")
            points = [-int(a), b]
        
        else:
            return {"error": "Invalid Command"}
        
    except:
        return {"error": "Invalid Command"}

    db.modify_points(points[0], points[1])

    return {"message": "Points successfully changed"}