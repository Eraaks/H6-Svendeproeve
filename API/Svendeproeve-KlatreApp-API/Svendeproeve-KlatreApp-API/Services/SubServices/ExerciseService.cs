using Google.Cloud.Firestore;
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

        public async Task CreateNewExercise(ExerciseDocument exerciseDocument)
        {
            var exercise = _firestoreDb.Collection("Exercises").Document(exerciseDocument.Name);
            await exercise.SetAsync(exerciseDocument);
            
        }



        public async Task<ExerciseDocument> GetExercise(string exerciseName)
        {
       
            var exerciseDocument = await _firestoreDb.Collection("Exercises").Document(exerciseName).GetSnapshotAsync();
            var exerciseData = exerciseDocument.ConvertTo<ExerciseDocument>();
      
            return exerciseData;
        }

        public async Task<List<ExerciseDocument>> GetExercises()
        {
            var exerciseDocuments = await _firestoreDb.Collection("Exercises").GetSnapshotAsync();
            var exerciseData = exerciseDocuments.Documents.Select(s => s.ConvertTo<ExerciseDocument>()).ToList();
            foreach(var data in exerciseData)
            {
                var howToData = await _firestoreDb.Collection("Exercises").Document(data.Name).GetSnapshotAsync();
               
            }
            return exerciseData;
        }

        public async Task<List<ExerciseDocument>> GetExercisesIncludedIn(string musclegroups)
        {
            var exerciseDocuments = await _firestoreDb.Collection("Exercises").WhereArrayContains("Included_In", musclegroups).GetSnapshotAsync();
            var exerciseData = exerciseDocuments.Documents.Select(e => e.ConvertTo<ExerciseDocument>()).ToList();
            //foreach (var data in exerciseData)
            //{
            //    var howToData = await _firestoreDb.Collection("Exercises").Document(data.Name).GetSnapshotAsync();
               
            //}
            return exerciseData;
        }

        public async Task UpdateExercise(ExerciseDocument newExercise, string exerciseName)
        {
            await DeleteExercise(exerciseName);
            await CreateNewExercise(newExercise);
        }

        public async Task DeleteExercise(string exerciseName)
        {
            var howToDocument = _firestoreDb.Collection("Exercises").Document(exerciseName).Collection("How_To").Document($"{exerciseName}-HowTo");
            await howToDocument.DeleteAsync();
            var exerciseDocument = _firestoreDb.Collection("Exercises").Document(exerciseName);
            await exerciseDocument.DeleteAsync();
        }





    }
}
