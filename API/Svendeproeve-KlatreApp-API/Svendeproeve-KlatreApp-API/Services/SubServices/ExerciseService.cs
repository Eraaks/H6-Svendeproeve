using Google.Cloud.Firestore;
using Grpc.Core;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;

namespace Svendeproeve_KlatreApp_API.Services.SubServices
{
    public class ExerciseService
    {
        private readonly FirestoreDb _firestoreDb;

        public ExerciseService(FirestoreDb firestoreDb)
        {
            _firestoreDb = firestoreDb;
        }

        public async Task<StatusCode> CreateNewExercise(ExerciseDocument exerciseDocument)
        {
            try
            {
                var exercise = _firestoreDb.Collection("Exercises").Document(exerciseDocument.Name);
                await exercise.SetAsync(exerciseDocument);
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        public async Task<ExerciseDocument> GetExercise(string exerciseName)
        {
            try
            {
                var exerciseDocument = await _firestoreDb.Collection("Exercises").Document(exerciseName).GetSnapshotAsync();
                var exerciseData = exerciseDocument.ConvertTo<ExerciseDocument>();
      
                return exerciseData;
            }
            catch (Exception)
            {
                return new ExerciseDocument();
                throw;
            }
        }

        public async Task<List<ExerciseDocument>> GetExercises()
        {
            try
            {
                var exerciseDocuments = await _firestoreDb.Collection("Exercises").GetSnapshotAsync();
                var exerciseData = exerciseDocuments.Documents.Select(s => s.ConvertTo<ExerciseDocument>()).ToList();
                return exerciseData;
            }
            catch (Exception)
            {
                return new List<ExerciseDocument>();
                throw;
            }

        }

        public async Task<List<ExerciseDocument>> GetExercisesIncludedIn(string musclegroups)
        {
            try
            {
                var exerciseDocuments = await _firestoreDb.Collection("Exercises").WhereArrayContains("Included_In", musclegroups).GetSnapshotAsync();
                var exerciseData = exerciseDocuments.Documents.Select(e => e.ConvertTo<ExerciseDocument>()).ToList();
                return exerciseData;
            }
            catch (Exception)
            {
                return new List<ExerciseDocument>();
                throw;
            }

        }

        public async Task<StatusCode> UpdateExercise(ExerciseDocument newExercise, string exerciseName)
        {
            try
            {
                await DeleteExercise(exerciseName);
                await CreateNewExercise(newExercise);
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }

        }

        public async Task<StatusCode> DeleteExercise(string exerciseName)
        {
            try
            {
                var exerciseDocument = _firestoreDb.Collection("Exercises").Document(exerciseName);
                await exerciseDocument.DeleteAsync();
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }
    }
}
