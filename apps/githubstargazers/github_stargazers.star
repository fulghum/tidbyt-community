"""
Applet: GitHub Stargazers
Summary: Display GitHub repo stars
Description: Display the GitHub stargazer count for a repo.
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