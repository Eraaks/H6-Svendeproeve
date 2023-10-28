using Google.Cloud.Firestore;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;

namespace Svendeproeve_KlatreApp_API.Services.SubServices
{
    public class WorkoutService
    {
        private readonly FirestoreDb _firestoreDb;

        public WorkoutService(FirestoreDb firestoreDb)
        {
            _firestoreDb = firestoreDb;
        }

        public async Task CreateNewWorkout(WorkoutDocument workoutDocument)
        {
            await _firestoreDb.Collection("Workouts").AddAsync(workoutDocument);
        }

        public async Task<List<WorkoutDocument>> GetWorkouts()
        {
            var workoutDocuments = await _firestoreDb.Collection("Workouts").GetSnapshotAsync();
            var workoutData = workoutDocuments.Documents.Select(s => s.ConvertTo<WorkoutDocument>()).ToList();
            return workoutData;
        }
    }
}
