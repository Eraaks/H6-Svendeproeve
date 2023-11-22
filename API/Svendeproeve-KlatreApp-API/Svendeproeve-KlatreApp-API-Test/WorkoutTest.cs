using Google.Cloud.Firestore;
using Grpc.Core;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services.SubServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Svendeproeve_KlatreApp_API_Test
{
    public class WorkoutTest
    {
        private FirestoreDb _firestoreDB;
        private readonly WorkoutService _workoutService;

        public WorkoutTest()
        {
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", @"C:\Users\Eraaks\Downloads\h6-svendeproeve-klatreapp-firebase-adminsdk-q7f96-1575848134.json");
            _firestoreDB = FirestoreDb.Create("h6-svendeproeve-klatreapp");
            _workoutService = new WorkoutService(_firestoreDB);
        }

        [Fact]
        public async Task CreateNewWorkout()
        {
            // Arrange
            var workoutName = "Test";
            var workout = new WorkoutDocument()
            {
                Exercise_IDs = new List<string> { "" },
                Name = workoutName,
                Type = "Test"
            };

            // Act
            var result = await _workoutService.CreateNewWorkout(workout);
            await _workoutService.DeleteWorkout(workoutName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task GetWorkout()
        {
            // Arrange
            var workoutName = "Test";
            var workout = new WorkoutDocument()
            {
                Exercise_IDs = new List<string> { "" },
                Name = workoutName,
                Type = "Test"
            };

            // Act
            await _workoutService.CreateNewWorkout(workout);
            var result = await _workoutService.GetWorkout(workoutName);
            await _workoutService.DeleteWorkout(workoutName);

            // Assert
            Assert.Equal(workout.Name, result.Name);
        }

        [Fact]
        public async Task GetWorkouts()
        {
            // Arrange
            List<WorkoutDocument> workouts = new List<WorkoutDocument>();

            // Act
            workouts.AddRange(await _workoutService.GetWorkouts());

            // Assert
            Assert.Equal(1, workouts.Count);
        }

        [Fact]
        public async Task UpdateWorkout()
        {
            // Arrange
            var workoutName = "Test";
            var workout = new WorkoutDocument()
            {
                Exercise_IDs = new List<string> { "" },
                Name = workoutName,
                Type = "Test"
            };

            // Act
            await _workoutService.CreateNewWorkout(workout);
            workout.Name = "Test2";
            var result = await _workoutService.UpdateWorkout(workout, workoutName);
            var newWorkout = await _workoutService.GetWorkout(workout.Name);
            await _workoutService.DeleteWorkout(newWorkout.Name);

            // Assert
            Assert.Equal(StatusCode.OK, result);
            Assert.NotEqual(workoutName, newWorkout.Name);
        }

        [Fact]
        public async Task DeleteWorkout()
        {
            // Arrange
            var workoutName = "Test";
            var workout = new WorkoutDocument()
            {
                Exercise_IDs = new List<string> { "" },
                Name = workoutName,
                Type = "Test"
            };

            // Act
            await _workoutService.CreateNewWorkout(workout);
            var result = await _workoutService.DeleteWorkout(workoutName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }
    }
}
