from flask import Flask, request
from word2number import w2n
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

    if len(command.split()) != 4:
        return {"error": "Invalid command"}

    try:
        if " points to " in command:
            a, b = command.split(" points to ")
            points = [int(w2n.word_to_num(a)), b]

        elif " points from " in command:
            a, b = command.split(" points from ")
            points = [-int(w2n.word_to_num(a)), b]
        
        else:
            return {"error": "Invalid command"}
        
    except:
        return {"error": "Invalid number"}

    if points[1] not in ["gryffindor", "hufflepuff", "ravenclaw", "slytherin"]:
        return {"error": "Invalid house"}

    db.modify_points(points[0], points[1])

    return {"message": "Points successfully changed"}