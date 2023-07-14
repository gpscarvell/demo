import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@SpringBootApplication
public class WeatherMicroserviceApplication {

    public static void main(String[] args) {
        SpringApplication.run(WeatherMicroserviceApplication.class, args);
    }
}

@RestController
class WeatherController {
    private final RestTemplate restTemplate;

    public WeatherController(RestTemplateBuilder restTemplateBuilder) {
        this.restTemplate = restTemplateBuilder.build();
    }

    @GetMapping("/weather")
    public String getWeather() {
        String apiUrl = "https://api.open-meteo.com/v1/forecast?latitude=38.9072&longitude=-77.0369&current_weather=true";
        WeatherData weatherData = restTemplate.getForObject(apiUrl, WeatherData.class);
        return "Current weather in Washington, DC: " + weatherData.getCurrentWeather().getTemperature() + "°C";
    }
}

class WeatherData {
    private CurrentWeatherData current_weather;

    public CurrentWeatherData getCurrentWeather() {
        return current_weather;
    }

    public void setCurrentWeather(CurrentWeatherData current_weather) {
        this.current_weather = current_weather;
    }
}

class CurrentWeatherData {
    private float temperature;

    public float getTemperature() {
        return temperature;
    }

    public void setTemperature(float temperature) {
        this.temperature = temperature;
    }
}

