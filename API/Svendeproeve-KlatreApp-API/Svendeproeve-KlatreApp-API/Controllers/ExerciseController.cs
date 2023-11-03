using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services;

namespace Svendeproeve_KlatreApp_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ExerciseController : ControllerBase
    {
        private readonly FirebaseService _firebaseService;

        public ExerciseController(FirebaseService firebaseService)
        {
            _firebaseService = firebaseService;
        }

        [HttpPost("/ExerciseController/CreateNewExercise/")]
        public async Task CreateNewExercise(ExerciseDocument exerciseDocument)
        {
            await _firebaseService.CreateNewExercise(exerciseDocument);
        }

        [HttpGet("/ExerciseController/GetExercise/{exerciseName}")]
        public async Task<ExerciseDocument> GetExercise(string exerciseName)
        {
            return await _firebaseService.GetExercise(exerciseName);
        }

        [HttpGet("/ExerciseController/GetExercises/")]
        public async Task<List<ExerciseDocument>> GetExercises()
        {
            return await _firebaseService.GetExercises();
        }

        [HttpGet("/ExerciseController/GetExercisesIncludedIn/{musclegroups}")]
        public async Task<List<ExerciseDocument>> GetExercisesIncludedIn(string musclegroups)
        {
            return await _firebaseService.GetExercisesIncludedIn(musclegroups);
        }

        [HttpPatch("/ExerciseController/UpdateExercise/{exerciseName}")]
        public async Task UpdateExercise(ExerciseDocument newExercise, string exerciseName)
        {
            await _firebaseService.UpdateExercise(newExercise, exerciseName);
        }

        [HttpDelete("/ExerciseController/DeleteExercise/{exerciseName}")]
        public async Task DeleteExercise(string exerciseName)
        {
            await _firebaseService.DeleteExercise(exerciseName);
        }
    }
}
