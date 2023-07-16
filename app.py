from flask import Flask, jsonify
import requests

app = Flask(__name__)

@app.route('/weather/washington-dc')
def get_weather_for_washington_dc():
    url = 'https://api.open-meteo.com/v1/forecast?latitude=38.9072&longitude=-77.0369&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m'
    response = requests.get(url)
    data = response.json()
#    temperature = data['temperature']
#    weather_code = data['weathercode']
#    weather = {'temperature': temperature, 'weatherCode': weather_code}
#    return jsonify(weather)
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)
