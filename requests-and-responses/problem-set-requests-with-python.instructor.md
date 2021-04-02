# Instructor: Problem Set: Requests with Python

This isn't autograded for these reasons:

1. Seven Wonders has been tricky in the past, and this is supposed to take one evening. The current format allows students to rely on single requests in Python and/or Postman if they need to and then asks them to challenge themselves
1. I didn't put in the work of making a custom snippet that installs `requests`
1. I haven't written in how to do unit testing with API calls (mocking calls)

Here's the answer I got formatted:

```python
{
   "Great Wall of China":{
      "latitude":"40.3587621",
      "longitude":"116.0136394"
   },
   "Petra":{
      "latitude":"30.3273975",
      "longitude":"35.4464006"
   },
   "Colosseum":{
      "latitude":"41.8910091",
      "longitude":"12.4920748"
   },
   "Chichen Itza":{
      "latitude":"20.68285195",
      "longitude":"-88.5687196355205"
   },
   "Machu Picchu":{
      "latitude":"-13.16441865",
      "longitude":"-72.5447639743184"
   },
   "Taj Mahal":{
      "latitude":"27.1750123",
      "longitude":"78.0420968366132"
   },
   "Christ the Redeemer":{
      "latitude":"-22.9519173",
      "longitude":"-43.210495"
   }
}
```

And the solution I had

```python
import requests


def get_lat_lon(locations):
    PATH = "https://us1.locationiq.com/v1/search.php"
    LOCATIONIQ_API_KEY = "pk.faf2e66100f4dafc47888bcec6a8368a"
    coordinates = {}
    for location in locations:
        query_params = {
            "key": LOCATIONIQ_API_KEY,
            "q": location,
            "format": "json"
        }
        response = requests.get(PATH, params=query_params)
        body = response.json()[0]
        location_coords = {
            "latitude": body["lat"],
            "longitude": body["lon"]
        }
        coordinates[location] = location_coords
    return coordinates


wonders = ["Great Wall of China", "Petra", "Colosseum",
           "Chichen Itza", "Machu Picchu", "Taj Mahal", "Christ the Redeemer"]

print(get_lat_lon(wonders))
```
