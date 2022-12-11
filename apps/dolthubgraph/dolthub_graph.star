"""
Applet: DoltHub Graph
Summary: Graph a DoltHub query
Description: Displays a customizable query from a DoltHub database.
Author: fulghum
"""

#load("cache.star", "cache")
#load("encoding/base64.star", "base64")
load("encoding/json.star", "json")
load("http.star", "http")
load("humanize.star", "humanize")
load("render.star", "render")
load("schema.star", "schema")
#load("secret.star", "secret")

# https://www.dolthub.com/repositories/jfulghum/test/query/main?active=Tables&q=SELECT+date%2C+installs_30d%0AFROM+%60homebrew_metrics%60%0AORDER+BY+%60date%60+desc+%0ALIMIT+7%3B%0A
DOLTHUB_SQL_QUERY = "SELECT date, installs_30d FROM `homebrew_metrics` ORDER BY `date` desc LIMIT 30;"

DOLTHUB_URL = "https://www.dolthub.com/api/v1alpha1/jfulghum/test/main?q=%s"


def send_dolthub_request(query): 
    res = http.get(
        url = DOLTHUB_URL % humanize.url_encode(query),
    )
    if res.status_code != 200:
        print("DoltHub API request failed: %s - %s " % (res.status_code, res.body()))
        return None

    return json.decode(res.body())

def extract_data_points(rows):
    data = []
    i = 0
    maxy = float(rows[0]["installs_30d"])
    miny = maxy
    for row in rows:
        value = float(row["installs_30d"])
        if value > maxy:
            maxy = value
        if value < miny:
            miny = value            
        data.append((i, value))
        i = i+1

    minx = 0
    maxx = i-1
    print("maxy: ", maxy)
    print("miny: ", miny)
    print("maxx: ", maxx)
    print("minx: ", minx)
    return data, minx, maxx, miny, maxy

def main(config):
    response = send_dolthub_request(DOLTHUB_SQL_QUERY)
    rows = response["rows"]    
    data, minx, maxx, miny, maxy = extract_data_points(rows)

    return render.Root(
        child = render.Column(
            children=[
                render.Marquee(
                    width=64,
                    child=render.Text("Dolt Homebrew Downloads - last 30 days"),
                    offset_start=5,
                    offset_end=32,
                ),
                render.Plot(
                    data = data,
                    width = 64,
                    height = 25, # TODO: ???
                    color = "#0f0",
                    color_inverted = "#f00",
                    x_lim = (minx, maxx),
                    y_lim = (miny-200, maxy+200),
                    fill = True,
                ),
            ],
        )
    )

def get_schema():
    return schema.Schema(
        version = "1",
        fields = [],
    )