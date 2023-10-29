using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services;

namespace Svendeproeve_KlatreApp_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WorkoutController : ControllerBase
    {
        private readonly FirebaseService _firebaseService;

        public WorkoutController(FirebaseService firebaseService)
        {
            _firebaseService = firebaseService;
        }

        [HttpPost("/WorkoutController/CreateNewWorkout/")]
        public async Task CreateNewWorkout(WorkoutDocument workout)
        {
            await _firebaseService.CreateNewWorkout(workout);
        }

        [HttpGet("/WorkoutController/GetWorkouts/")]
        public async Task<List<WorkoutDocument>> GetWorkouts()
        {
            return await _firebaseService.GetWorkouts();
        }
    }
}
