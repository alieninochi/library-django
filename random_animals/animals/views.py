from django.shortcuts import render
import random

import requests

rand_offset = random.randint(0, 100)
animal = 'cats'
giphy_url = ''.join([
    'https://api.giphy.com/v1/gifs/search?api_key=',
    '1Rx9LhhsLY73Sbx9wf8fkeifnVgNHpCi',
    f"&q={animal}",
    '&limit=50',
    f'&offset={str(rand_offset)}',
    '&rating=G',
    '&lang=en',
])
giphy = requests.get(url=giphy_url)
animals = giphy.json()['data']

# list of cat images
backup_images_cats = [
    "https://media2.giphy.com/media/Xf8D9Qf8OCKnMvNnru/giphy.gif",
    "https://media1.giphy.com/media/B6odR0DhsStfW/giphy.gif",
    "https://media0.giphy.com/media/JfLdIahamXQI0/giphy.gif",
    "https://media4.giphy.com/media/1iu8uG2cjYFZS6wTxv/giphy.gif",
    "https://media1.giphy.com/media/12PA1eI8FBqEBa/giphy.gif",
]

backup_images_parrots = [
    "https://media3.giphy.com/media/PPy2wTXW9BJok/giphy.gif",
    "https://media0.giphy.com/media/fKwpeyXg2rBPa/giphy.gif",
    "https://media2.giphy.com/media/ytHiq4nCEt3Ta/giphy.gif",
    "https://media2.giphy.com/media/DOEzNNMrgLuEM/giphy.gif",
    "https://media0.giphy.com/media/8DMcPUczc3cze/giphy.gif",
]


# Create your views here.
def home(request):
    backup = False
    try:
        randomized_img = random.choice(animals)['images']['original']['url']
    except:
        backup = True
        if animal == "cat":
            randomized_img = random.choice(backup_images_cats)
        else:
            randomized_img = random.choice(backup_images_parrots)

    print(randomized_img)
    return render(request, 'animals/home.html', { 'animal': randomized_img, 'backup': backup })
