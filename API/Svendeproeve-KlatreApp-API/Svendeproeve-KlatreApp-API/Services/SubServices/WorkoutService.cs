using Google.Cloud.Firestore;
using Grpc.Core;
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

        public async Task<StatusCode> CreateNewWorkout(WorkoutDocument workoutDocument)
        {
            try
            {
                await _firestoreDb.Collection("Workouts").Document(workoutDocument.Name).SetAsync(workoutDocument);
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        public async Task<WorkoutDocument> GetWorkout(string workoutName)
        {
            try
            {
                var document = await _firestoreDb.Collection("Workouts").Document(workoutName).GetSnapshotAsync();
                WorkoutDocument workout = document.ConvertTo<WorkoutDocument>();
                return workout;
            }
            catch (Exception)
            {
                return new WorkoutDocument();
                throw;
            }
        }

        public async Task<List<WorkoutDocument>> GetWorkouts()
        {
            try
            {
                var workoutDocuments = await _firestoreDb.Collection("Workouts").GetSnapshotAsync();
                var workoutData = workoutDocuments.Documents.Select(s => s.ConvertTo<WorkoutDocument>()).ToList();
                return workoutData;
            }
            catch (Exception)
            {
                return new List<WorkoutDocument>();
                throw;
            }
        }

        public async Task<StatusCode> UpdateWorkout(WorkoutDocument newWorkout, string workoutName)
        {
            try
            {
                await _firestoreDb.Collection("Workouts").Document(workoutName).DeleteAsync();
                await _firestoreDb.Collection("Workouts").Document(newWorkout.Name).CreateAsync(newWorkout);
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        public async Task<StatusCode> DeleteWorkout(string workoutName)
        {
            try
            {
                await _firestoreDb.Collection("Workouts").Document(workoutName).DeleteAsync();
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
