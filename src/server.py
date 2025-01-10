from flask import Flask, request, jsonify
from manga_ocr import MangaOcr

import uuid
import os

app = Flask(__name__)
mocr = MangaOcr()

DIR = "/tmp/"

@app.route("/", methods = ["GET", "POST"])
def ocr():
    if request.method == "GET":
        return jsonify({ "status": 200, "message": "Okay!"})

    if not request.files or not request.files.get("file"):
        return jsonify({ "status": 422, "message": "Missing file!" }), 422

    filename = str(uuid.uuid4())
    file = request.files["file"]
    file.save(DIR + filename)

    try:
        text = mocr(DIR + filename)

        try: os.remove(DIR + filename)
        except: print(f"[ERROR] could not remove {filename}")

        return jsonify({
            "status": 200,
            "message": text
        })
    except:
        return jsonify({ "status": 500, "message": "Internal server error!" })

if __name__ == "__main__":
   app.run(
       debug = True,
       host = "0.0.0.0",
       port = 5083
   )
