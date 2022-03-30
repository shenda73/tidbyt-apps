load('render.star', 'render')
load('http.star', 'http')
load('math.star', 'math')
load("cache.star", "cache")
load("encoding/base64.star", "base64")

HASHRATE_CACHE_KEY = 'hash_rate'

pic1 = base64.decode('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')
pic2 = base64.decode('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')

def main():
    hashrate_cached = cache.get(HASHRATE_CACHE_KEY)
    if hashrate_cached != None:
        print("Hit! Displaying cached data.")
        hashrate = hashrate_cached
    else:
        print('fetching data...')
        rep = http.get('https://eth.2miners.com/api/accounts/3GVvE2o5do3jQhiKjdYRT7GdPi14GetWHj')
        if rep.status_code != 200:
            fail("http request failed with status %d", rep.status_code)
            
        hashrate = convert_hashrate(rep.json()["currentHashrate"])
        print('hash rate is %s' % hashrate)
        cache.set(HASHRATE_CACHE_KEY, hashrate, ttl_seconds=20)

    return render.Root(
        delay = 700,
        child = render.Box(
            child = render.Row(
                        expanded=True, # Use as much horizontal space as possible
                        main_align="space_evenly", # Controls horizontal alignment
                        cross_align="center", # Controls vertical alignment
                        children = [
                            render.Animation(
                                children = [
                                    render.Image(src=pic1),
                                    render.Image(src=pic2),
                                ]
                            ),
                            render.Text(
                                content = hashrate,
                                font = "6x13",
                            )
                        ]
                    ),
        ),
    )

def convert_hashrate(raw_hr):
    if raw_hr == 0:
        return "0 MH/s"
    size_name = ("H", "KH", "MH", "GH", "TH", "PH", "EH", "ZH", "YH")
    i = int(math.floor(math.log(raw_hr, 1024)))
    p = math.pow(1024, i)
    s = int(math.round(raw_hr / p))
    return "%s%s" % (s, size_name[i])