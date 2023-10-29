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

        [HttpGet("/ExerciseController/GetExercises/")]
        public async Task<List<ExerciseDocument>> GetExercises()
        {
            return await _firebaseService.GetExercises();
        }
    }
}
