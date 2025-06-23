import shutil
import os
from pyanalytics.utilities import kownload

if __name__ == "__main__":
    dest_file="data/videogames.csv"

    video_path = kownload(
        #src = "migeruj/videogames-predictive-model",
        src = "gregorut/videogamesales",
        #dest = dest_file,
        force = True)

    shutil.move(src = f"{video_path}/vgsales.csv", dst = dest_file)
