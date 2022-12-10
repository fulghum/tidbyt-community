"""
Applet: DoltHub Graph
Summary: Graph a DoltHub query
Description: Displays a customizable query from a DoltHub database.
Author: fulghum
"""

load("render.star", "render")
load("schema.star", "schema")

def main(config):
    return render.Root(
        child = render.Box(height = 1, width = 1),
    )

def get_schema():
    return schema.Schema(
        version = "1",
        fields = [],
    )