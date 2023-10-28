using Google.Cloud.Firestore;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;

namespace Svendeproeve_KlatreApp_API.Services.SubServices
{
    public class ExcerciseService
    {
        private readonly FirestoreDb _firestoreDb;

        public ExcerciseService(FirestoreDb firestoreDb)
        {
            _firestoreDb = firestoreDb;
        }

        public async Task CreateNewExercise(ExerciseDocument excerciseDocument)
        {
            await _firestoreDb.Collection("Exercises").AddAsync(excerciseDocument);
        }

        public async Task<List<ExerciseDocument>> GetExercises()
        {
            var exerciseDocuments = await _firestoreDb.Collection("Exercises").GetSnapshotAsync();
            var exerciseData = exerciseDocuments.Documents.Select(s => s.ConvertTo<ExerciseDocument>()).ToList();
            return exerciseData;
        }
    }
}
