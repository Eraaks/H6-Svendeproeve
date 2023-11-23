using Grpc.Core;
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

        [HttpPost("/CreateNewWorkout/")]
        public async Task CreateNewWorkout(WorkoutDocument workoutDocument)
        {
            await _firebaseService.CreateNewWorkout(workoutDocument);
        }

        [HttpGet("/GetWorkout/{workoutName}")]
        public async Task<WorkoutDocument> GetWorkout(string workoutName)
        {
            return await _firebaseService.GetWorkout(workoutName);
        }

        [HttpGet("/GetWorkouts/")]
        public async Task<List<WorkoutDocument>> GetWorkouts()
        {
            return await _firebaseService.GetWorkouts();
        }

        [HttpPatch("/UpdateWorkout/{workoutID}")]
        public async Task UpdateWorkout(WorkoutDocument newWorkout, string workoutID)
        {
            await _firebaseService.UpdateWorkout(newWorkout, workoutID);
        }

        [HttpDelete("/DeleteWorkout/{workoutName}")]
        public async Task DeleteWorkout(string workoutName)
        {
            await _firebaseService.DeleteWorkout(workoutName);
        }
    }
}
