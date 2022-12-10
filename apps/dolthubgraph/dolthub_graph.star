"""
Applet: DoltHub Graph
Summary: Graph a DoltHub query
Description: Displays a customizable query from a DoltHub database.
Author: fulghum
"""

load("render.star", "render")
load("schema.star", "schema")

def main(config):
    # NEXT STEPS: 
    #  1. Write SQL query for exact data size 
    #  2. Send GET request to DoltHub API
    #  3. Plug data into plot 

    return render.Root(
        child = render.Plot(
            data = [
                (0, 3.35),
                (1, 2.15),
                (2, 2.37),
                (3, -0.31),
                (4, -3.53),
                (5, 1.31),
                (6, -1.3),
                (7, 4.60),
                (8, 3.33),
                (9, 5.92),
            ],
            width = 64,
            height = 32,
            color = "#0f0",
            color_inverted = "#f00",
            x_lim = (0, 9),
            y_lim = (-5, 7),
            fill = True,
            ),
    )

def get_schema():
    return schema.Schema(
        version = "1",
        fields = [],
    )