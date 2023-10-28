using FirebaseAdmin;
using FirebaseAdmin.Auth;
using Google.Cloud.Firestore;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services.SubServices;
using System.Linq;

namespace Svendeproeve_KlatreApp_API.Services
{
    public class FirebaseService
    {
        private readonly ProfileDataService _profileDataService;
        private readonly KlatrecentreService _klatrecentreService;
        private readonly ModeratorService _moderatorService;
        private readonly LoginVerificationService _loginVerificationService;
        private readonly GripsService _gripsService;
        private readonly ExcerciseService _excerciseService;
        private readonly WorkoutService _workoutService;
        public FirebaseService(ProfileDataService profileDataService, 
            KlatrecentreService klatrecentreService, 
            ModeratorService moderatorService, 
            LoginVerificationService loginVerificationService, 
            GripsService gripsService,
            ExcerciseService excerciseService,
            WorkoutService workoutService)
        {
            _profileDataService = profileDataService;
            _klatrecentreService = klatrecentreService;
            _moderatorService = moderatorService;
            _loginVerificationService = loginVerificationService;
            _gripsService = gripsService;
            _excerciseService = excerciseService;
            _workoutService = workoutService;
        }

        //public async Task<List<Shoe>> GetAll()
        //{
        //    var collection = _firestoreDb.Collection(_collectionName);
        //    var snapshot = await collection.GetSnapshotAsync();

        //    var shoeDocuments = snapshot.Documents.Select(s => s.ConvertTo<ShoeDocument>()).ToList();
        //    return shoeDocuments.Select(ConvertDocumentToModel).ToList();
        //}
        //public async Task AddAsync(Shoe shoe)
        //{   
        //    var collection = _firestoreDb.Collection(_collectionName);
        //    var shoeDocument = ConvertModelToDocument(shoe);
        //    await collection.AddAsync(shoeDocument);
        //}
        //private static Shoe ConvertDocumentToModel(ShoeDocument shoeDocument)
        //{
        //    return new Shoe
        //    {
        //        Id = shoeDocument.Id,
        //        Name = shoeDocument.Name,
        //        Brand = shoeDocument.Brand,
        //        Price = decimal.Parse(shoeDocument.Price)
        //    };
        //}
        //private static ShoeDocument ConvertModelToDocument(Shoe shoe)
        //{
        //    return new ShoeDocument
        //    {
        //        Id = shoe.Id,
        //        Name = shoe.Name,
        //        Brand = shoe.Brand,
        //        Price = shoe.Price.ToString()
        //    };
        //}
        public async Task AddAsync(ProfileDataDocument profileData)
        {
            await _profileDataService.AddAsync(profileData);
        }

        public async Task AddAsync(ClimbingCenterDocument climbingCenter, string climbingCenterName)
        {
            await _klatrecentreService.AddAsync(climbingCenter, climbingCenterName);
        }

        public async Task<bool> CheckIfUserModerator(string userUID)
        {
            return await _moderatorService.CheckIfUserModerator(userUID);
        }

        public async Task<string> RequestModeratorCode(string climbingCenterName, string userUID)
        {
            return await _moderatorService.RequestModeratorCode(climbingCenterName, userUID);
        }

        public async Task CheckModeratorCodeAndAddToCenter(string moderatorCode, string userUID)
        {
            await _moderatorService.CheckModeratorCodeAndAddToCenter(moderatorCode, userUID);
        }

        public async Task<bool> CompareSecretValues(string fireBaseSecret)
        {
            return await _loginVerificationService.CompareSecretValues(fireBaseSecret);
        }

        public async Task CreateNewGripsCollection(GripsDocument gripsService)
        {
            await _gripsService.CreateNewGripsCollection(gripsService);
        }

        public async Task<List<GripsDocument>> GetGrips()
        {
            return await _gripsService.GetGrips();
        }

        public async Task CreateNewExercise(ExerciseDocument excerciseDocument)
        {
            await _excerciseService.CreateNewExercise(excerciseDocument);
        }

        public async Task<List<ExerciseDocument>> GetExercises()
        {
            return await _excerciseService.GetExercises();
        }

        public async Task CreateNewWorkout(WorkoutDocument workoutDocument)
        {
            await _workoutService.CreateNewWorkout(workoutDocument);
        }

        public async Task<List<WorkoutDocument>> GetWorkouts()
        {
            return await _workoutService.GetWorkouts();
        }
    }
}
