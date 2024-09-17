import pymongo

class HousePoints:
    def __init__(self, link: str):
        self.link = link
        self.client = pymongo.MongoClient(link)
        self.db = self.client.get_database("giant_hourglasses")
        self.points_table = self.db.get_collection("house_points")
        self.log_table = self.db.get_collection("log_changes")
    
    def modify_points(self, points: int, house: str):
        record = self.points_table.find_one({"_id": "66e9ab5efe4bae29b114a2f3"})
        self.points_table.update_one({"_id": "66e9ab5efe4bae29b114a2f3"}, {"$set": {house: record[house]+points}})
        self.log_table.insert_one({"points": points, "house": house})
        return 0