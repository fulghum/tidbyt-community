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

#  1. Write SQL query for exact data size 
DOLTHUB_QUERY = "SELECT date, installs_30d FROM `homebrew_metrics` ORDER BY `date` desc LIMIT 7;"
# TODO: extract query and urlencoding
DOLTHUB_URL = "https://www.dolthub.com/api/v1alpha1/jfulghum/test/main?q=SELECT+date%2C+installs_30d%0AFROM+%60homebrew_metrics%60%0AORDER+BY+%60date%60+desc+%0ALIMIT+7%3B%0A"


def send_dolthub_request(): #url, query_params, config):
    #api_key = secret.decrypt(ENCRYPTED_GITHUB_API_KEY) or config.get("dev_api_key")

    #headers = {}
    #if api_key == None:
    #    print("warning: no api_key available; sending request without authentication")
    #else:
    #    headers = {
    #        "Authorization": "token %s" % api_key,
    #    }

    res = http.get(
        url = DOLTHUB_URL,
        # TODO:
        #url = url % humanize.url_encode(query_params),
        #headers = headers,
    )
    if res.status_code != 200:
        print("DoltHub API request failed: %s - %s " % (res.status_code, res.body()))
        return None

    return json.decode(res.body())

def main(config):

    # NEXT STEPS: 
    #  2. Send GET request to DoltHub API
    response = send_dolthub_request()
    rows = response["rows"]

    #  3. Plug data into plot 
    return render.Root(
        child = render.Plot(
            data = [
                (0, float(rows[6]["installs_30d"])),
                (1, float(rows[5]["installs_30d"])),
                (2, float(rows[4]["installs_30d"])),
                (3, float(rows[3]["installs_30d"])),
                (4, float(rows[2]["installs_30d"])),
                (5, float(rows[1]["installs_30d"])),
                (6, float(rows[0]["installs_30d"])),
#                (7, rows[0]["installs_30d"]),
#                (8, rows[0]["installs_30d"]),
#                (9, rows[0]["installs_30d"]),
            ],
            width = 64,
            height = 32,
            color = "#0f0",
            color_inverted = "#f00",
            x_lim = (0, 6), # TODO: 
            y_lim = (700, 1200), # TODO: 
            fill = True,
            ),
    )

def get_schema():
    return schema.Schema(
        version = "1",
        fields = [],
    )