from flask import Flask, request
import json
from bson import json_util
from bson.objectid import ObjectId
import pymongo

app = Flask(__name__)
client = pymongo.MongoClient()
db = client['konachan']

def toJson(data):
    return json.dumps(data, default=json_util.default)

@app.route('/kona/',methods=['GET'])
def findkona():
    if request.method == 'GET':
        lim = int(request.args.get('limit',100))
        off = int(request.args.get('offset'),0)
        results = db['kona'].find().skip(off).limit(lim)
        json_results = []
        for result in results:
            json_results.append(result)
        return toJson(json_results)
if __name__ == '__main__':
    app.run(debug=True)



