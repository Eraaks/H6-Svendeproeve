using Microsoft.AspNetCore.Mvc;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Models;
using Svendeproeve_KlatreApp_API.Services;

namespace Svendeproeve_KlatreApp_API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class WeatherForecastController : ControllerBase
    {
        private static readonly string[] Summaries = new[]
        {
        "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        private readonly ILogger<WeatherForecastController> _logger;
        private readonly FirestoreService _fireStoreService;

        public WeatherForecastController(ILogger<WeatherForecastController> logger, FirestoreService firestoreService)
        {
            _logger = logger;
            _fireStoreService = firestoreService;
        }

        [HttpGet(Name = "GetWeatherForecast")]
        public IEnumerable<WeatherForecast> Get()
        {
            return Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                Date = DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
                TemperatureC = Random.Shared.Next(-20, 55),
                Summary = Summaries[Random.Shared.Next(Summaries.Length)]
            })
            .ToArray();
        }

        [HttpPost(Name = "GenerateNewEntryAsync")]
        public async Task GenerateNewEntryAsync()
        {
            await _fireStoreService.AddAsync(new Shoe
            {
                Id = Guid.NewGuid().ToString(),
                Name = "Testing Shoe",
                Brand = "Shoke",
                Price = 123
            });
        }

        [HttpPost("/GenerateNewProfileDataAsync")]
        public async Task GenerateNewProfileDataAsync()
        {
            await _fireStoreService.AddProfile(new ProfileDataDocument
                {
                ID = Guid.NewGuid().ToString(),
                Follows_Me = new List<string>()
                {
                    "Xcalera"
                },
                Friend_Ids = new List<string>()
                {
                    "Xcalera"
                },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                Training_For = "",
                Training_Skill_Level = "",
                User_Email = "Oliver9langgaard@gmail.com",
                Climbing_History = new Climbing_History
                    {
                        ID = Guid.NewGuid().ToString(),
                        Estimated_Grade = "6C",
                        Location = "Beta Boulders South",
                        Total_Points = 670,
                        Send_Collections = new Send_Collection
                            {
                                ID = Guid.NewGuid().ToString(),
                                Area = "AT-AT",
                                Grade = "6C",
                                Points = 667,
                                Tries = 2
                            }
                    },
            });
        }
    }
}