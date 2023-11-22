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
    public class ExercisesTest
    {
        private FirestoreDb _firestoreDB;
        private readonly ExerciseService _exercisesService;

        public ExercisesTest()
        {
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", @"C:\Users\Eraaks\Downloads\h6-svendeproeve-klatreapp-firebase-adminsdk-q7f96-1575848134.json");
            _firestoreDB = FirestoreDb.Create("h6-svendeproeve-klatreapp");
            _exercisesService = new ExerciseService(_firestoreDB);
        }

        [Fact]
        public async Task CreateNewExercise()
        {
            // Arrange
            var exercise = new ExerciseDocument()
            {
                Name = "Test",
                Description = "Test",
                Asset_Location = "https://i.imgur.com/i69ryhA.png",
                Benefits = "Arms",
                Howto_Location = "https://fitnessprogramer.com/wp-content/uploads/2021/06/Barbell-Reverse-Wrist-Curl.gif",
                Included_In = new List<string>()
                {
                    "Arms"
                },
                Musclegroup_Location = "https://i.imgur.com/i69ryhA.png",
                Overall_Target = "Arms",
                Primary_Activation = new List<string>()
                {
                    "Arms"
                },
                Reps = 0,
                Secondary_Activation = new List<string>()
                {
                    "Arms"
                },
                Sets = 0
            };

            // Act
            var result = await _exercisesService.CreateNewExercise(exercise);
            await _exercisesService.DeleteExercise(exercise.Name);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task GetExercise()
        {
            // Arrange
            var exercise = new ExerciseDocument()
            {
                Name = "Test",
                Description = "Test",
                Asset_Location = "https://i.imgur.com/i69ryhA.png",
                Benefits = "Arms",
                Howto_Location = "https://fitnessprogramer.com/wp-content/uploads/2021/06/Barbell-Reverse-Wrist-Curl.gif",
                Included_In = new List<string>()
                {
                    "Arms"
                },
                Musclegroup_Location = "https://i.imgur.com/i69ryhA.png",
                Overall_Target = "Arms",
                Primary_Activation = new List<string>()
                {
                    "Arms"
                },
                Reps = 0,
                Secondary_Activation = new List<string>()
                {
                    "Arms"
                },
                Sets = 0
            };

            // Act
            await _exercisesService.CreateNewExercise(exercise);
            var result = await _exercisesService.GetExercise(exercise.Name);
            await _exercisesService.DeleteExercise(exercise.Name);

            // Assert
            Assert.Equal(exercise.Name, result.Name);
        }

        [Fact]
        public async Task GetExercises()
        {
            // Arrange
            List<ExerciseDocument> exercises = new List<ExerciseDocument>();

            // Act
            exercises.AddRange(await _exercisesService.GetExercises());

            // Arrange
            Assert.Equal(5, exercises.Count);
        }

        [Fact]
        public async Task GetExercisesIncludedIn()
        {
            // Arrange
            List<ExerciseDocument> exercises = new List<ExerciseDocument>();

            // Act
            exercises.AddRange(await _exercisesService.GetExercisesIncludedIn("Arms"));

            // Assert
            Assert.Equal(2, exercises.Count);
        }

        [Fact]
        public async Task UpdateExercise()
        {
            // Arrange
            var exerciseName = "Test";
            var exercise = new ExerciseDocument()
            {
                Name = exerciseName,
                Description = "Test",
                Asset_Location = "https://i.imgur.com/i69ryhA.png",
                Benefits = "Arms",
                Howto_Location = "https://fitnessprogramer.com/wp-content/uploads/2021/06/Barbell-Reverse-Wrist-Curl.gif",
                Included_In = new List<string>()
                {
                    "Arms"
                },
                Musclegroup_Location = "https://i.imgur.com/i69ryhA.png",
                Overall_Target = "Arms",
                Primary_Activation = new List<string>()
                {
                    "Arms"
                },
                Reps = 0,
                Secondary_Activation = new List<string>()
                {
                    "Arms"
                },
                Sets = 0
            };

            // Act
            await _exercisesService.CreateNewExercise(exercise);
            exercise.Name = "Test2";
            var result = await _exercisesService.UpdateExercise(exercise, exerciseName);
            var newExercise = await _exercisesService.GetExercise(exercise.Name);
            await _exercisesService.DeleteExercise(exercise.Name);

            // Assert
            Assert.Equal(StatusCode.OK, result);
            Assert.NotEqual(exercise, newExercise);
        }

        [Fact]
        public async Task DeleteExercise()
        {
            // Arrange
            var exercise = new ExerciseDocument()
            {
                Name = "Test",
                Description = "Test",
                Asset_Location = "https://i.imgur.com/i69ryhA.png",
                Benefits = "Arms",
                Howto_Location = "https://fitnessprogramer.com/wp-content/uploads/2021/06/Barbell-Reverse-Wrist-Curl.gif",
                Included_In = new List<string>()
                {
                    "Arms"
                },
                Musclegroup_Location = "https://i.imgur.com/i69ryhA.png",
                Overall_Target = "Arms",
                Primary_Activation = new List<string>()
                {
                    "Arms"
                },
                Reps = 0,
                Secondary_Activation = new List<string>()
                {
                    "Arms"
                },
                Sets = 0
            };

            // Act
            await _exercisesService.CreateNewExercise(exercise);
            var result = await _exercisesService.DeleteExercise(exercise.Name);

            // Asssert
            Assert.Equal(StatusCode.OK, result);
        }
    }
}
