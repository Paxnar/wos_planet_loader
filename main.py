from flask import Flask, request
import json
from PIL import Image, ImageDraw
from requests import post
app = Flask(__name__)

# создаем словарь, в котором ключ — название города,
# а значение — массив, где перечислены id картинок,
# которые мы записали в прошлом пункте.


@app.route('/', methods=['POST', 'GET'])
def main():
    planets = []

    if request.method == 'POST':
        '''data = []
        print(request.get_data(as_text=True))
        data.append(request.get_data(as_text=True).split('@'))'''
        print(request.get_data(as_text=True))
        datawegot = json.loads(request.get_data(as_text=True))
        print(datawegot)
        datareal = []
        for i in datawegot:
            datareal.append(json.loads(i))
        print(datareal)
        planets = datareal

        im = Image.new("RGB", (750, 750))
        drawer = ImageDraw.Draw(im)
        drawer.rectangle(((0, 0), (750, 750)), (0, 0, 0))
        for planet in planets:
            color = '#' + planet['Color']
            coord = planet['Name'].split()[2].split('-')
            coord[-1] = coord[-1].replace(')', '')
            if coord[0] == '(':
                coord[1] = '-' + coord[1]
                coord.remove(coord[0])
            if '(' in coord[0]:
                coord[0] = coord[0].replace('(', '')
            if coord[1] == '':
                coord[-1] = '-' + coord[-1]
                coord.remove(coord[1])
            coord = (int(coord[0], 16), int(coord[1], 16))
            planet_middle = (750 / 25 * (12 + coord[0]), 750 / 25 * (12 - coord[1]))
            drawer.ellipse((
                (planet_middle[0] - 30, planet_middle[1] - 30),
                (planet_middle[0] + 30, planet_middle[1] + 30)),
                color)
        im.show()

    return ''


if __name__ == '__main__':
    app.run()
