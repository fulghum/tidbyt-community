"""
Applet: GitHub Stargazers
Summary: Display GitHub repo stars
Description: Display the GitHub stargazer count for a repo.
Author: fulghum
"""

load("encoding/base64.star", "base64")
load("encoding/json.star", "json")
load("http.star", "http")
load("humanize.star", "humanize")
load("render.star", "render")
load("schema.star", "schema")
load("cache.star", "cache")

GITHUB_REPO_SEARCH_URL  = "https://api.github.com/search/repositories?q=%s"

GITHUB_ICON = base64.decode("""
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
""")

def get_stargazers_count(org_name, repo_name):
    query_params = "repo:%s/%s" % (org_name, repo_name)
    res_json = send_github_request(GITHUB_REPO_SEARCH_URL, query_params)
    stargazers_count = res_json["items"][0]["stargazers_count"]
    print("stargazers_count: %s " % stargazers_count)
    return stargazers_count

def send_github_request(url, query_params):
    res = http.get(
        url = url % humanize.url_encode(query_params),
    )
    if res.status_code != 200:
        # buildifier: disable=print
        print("GitHub API request failed: %s - %s " % (res.status_code, res.body()))
        return None

    return json.decode(res.body())

def main(config):    
    org_name = config.get("org_name", "dolthub")
    repo_name = config.get("repo_name", "dolt")

    print("Fetching GitHub stargazer count...")
    cache_key = "repo_stargazers_%s/%s" % (org_name, repo_name)
    stargazers_count = cache.get(cache_key)

    if stargazers_count == None:
        stargazers_count = get_stargazers_count(org_name, repo_name)
        cache.set(cache_key, str(stargazers_count), ttl_seconds = 300)

    image_size = 16
    msg = "%s stars" % humanize.comma(stargazers_count)

    display_name = "%s/%s" % (org_name, repo_name)
    username_child = render.Text(
        color = "#00FF00",
        content = display_name,
    )

    if len(display_name) > 12:
        username_child = render.Marquee(
            width = 64,
            child = username_child,
        )

    return render.Root(
        child = render.Box(
            render.Column(
                expanded = True,
                main_align = "space_evenly",
                cross_align = "center",
                children = [
                    render.Row(
                        expanded = True,
                        main_align = "space_evenly" if len(msg) > 5 else "center",
                        cross_align = "center",
                        children = [
                            render.Padding(
                                pad = (1, 1, 1, 1),
                                child = render.Image(GITHUB_ICON, height = image_size, width = image_size),
                            ),
                            render.WrappedText(msg, font = "tb-8" if len(msg) > 7 else "6x13"),
                        ],
                    ),
                    username_child,
                ],
            ),
        ),
    )

def get_schema():
    return schema.Schema(
        version = "1",
        fields = [
            schema.Text(
                id = "org_name",
                name = "Org Name",
                icon = "user",
                desc = "Name of the organization, or account, containing the GitHub repository",
            ),
            schema.Text(
                id = "repo_name",
                name = "Repo Name",
                icon = "user",
                desc = "Name of the GitHub repository for which to display stargazer count",
            ),
        ],
    )