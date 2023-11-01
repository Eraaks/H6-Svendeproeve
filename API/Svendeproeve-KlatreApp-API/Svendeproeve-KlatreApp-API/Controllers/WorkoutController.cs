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

        [HttpGet("/WorkoutController/GetWorkout/{workoutID}")]
        public async Task<WorkoutDocument> GetWorkout(string workoutID)
        {
            return await _firebaseService.GetWorkout(workoutID);
        }

        [HttpGet("/WorkoutController/GetWorkouts/")]
        public async Task<List<WorkoutDocument>> GetWorkouts()
        {
            return await _firebaseService.GetWorkouts();
        }

        [HttpPatch("/WorkoutController/UpdateWorkout/{workoutID}")]
        public async Task UpdateWorkout(WorkoutDocument newWorkout, string workoutID)
        {
            await _firebaseService.UpdateWorkout(newWorkout, workoutID);
        }

        [HttpDelete("/WorkoutController/DeleteWorkout/{workoutID}")]
        public async Task DeleteWorkout(string workoutID)
        {
            await _firebaseService.DeleteWorkout(workoutID);
        }
    }
}
