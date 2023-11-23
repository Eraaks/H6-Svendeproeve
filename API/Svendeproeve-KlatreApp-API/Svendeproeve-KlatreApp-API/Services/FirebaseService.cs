using FirebaseAdmin;
using FirebaseAdmin.Auth;
using Google.Cloud.Firestore;
using Grpc.Core;
using Octokit;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services.SubServices;
using System.Collections.Generic;
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
        private readonly ExerciseService _exerciseService;
        private readonly WorkoutService _workoutService;
        private readonly ReportService _reportService;
        public FirebaseService(ProfileDataService profileDataService,
            KlatrecentreService klatrecentreService,
            ModeratorService moderatorService,
            LoginVerificationService loginVerificationService,
            GripsService gripsService,
            ExerciseService exerciseService,
            WorkoutService workoutService,
            ReportService reportService)
        {
            _profileDataService = profileDataService;
            _klatrecentreService = klatrecentreService;
            _moderatorService = moderatorService;
            _loginVerificationService = loginVerificationService;
            _gripsService = gripsService;
            _exerciseService = exerciseService;
            _workoutService = workoutService;
            _reportService = reportService;
        }

        public async Task<StatusCode> AddProfileData(ProfileDataDocument profileData)
        {
            return await _profileDataService.AddProfileData(profileData);
        }

        public async Task<ProfileDataDocument?> GetProfileData(string userUID)
        {
            return await _profileDataService.GetProfileData(userUID);
        }

        public async Task DeleteProfileData(string userUID)
        {
            await _profileDataService.DeleteProfileData(userUID);
        }

        public async Task UpdateProfileData(ProfileDataDocument newProfile, string userUID)
        {
            await _profileDataService.UpdateProfileData(newProfile, userUID);
        }

        public async Task UpdateFollow(string userUID, string userToFollowUserUID)
        {
            await _profileDataService.UpdateFollow(userUID, userToFollowUserUID);
        }

        public async Task RemoveFollow(string userUID, string userToFollowUserUID)
        {
            await _profileDataService.RemoveFollow(userUID, userToFollowUserUID);
        }

        public async Task<List<string>> GetFollowList(string userUID)
        {
            return await _profileDataService.GetFollowList(userUID);
        }

        public async Task<List<ClimbingScoreDocument>> GetClimbingScores(string climbingCenter)
        {
            return await _profileDataService.GetClimbingScores(climbingCenter);
        }

        public async Task SubmitUserClimb(List<AreaRoutes> routes, string userUID, string climbingCenterName)
        {
            await _profileDataService.SubmitUserClimb(routes, userUID, climbingCenterName);
        }

        public async Task UpdateSelectedGym(string userUID, string newSelectedGym)
        {
            await _profileDataService.UpdateSelectedGym(userUID, newSelectedGym);
        }

        public async Task AddClimbingCenter(ClimbingCenterDocument climbingCenter, string changerUserUID, string climbingCenterName)
        {
            await _klatrecentreService.AddClimbingCenter(climbingCenter, changerUserUID,climbingCenterName);
        }

        public async Task AddClimbingAreas(string climbingCenterName, string changerUserUID, List<Areas> areas)
        {
            await _klatrecentreService.AddClimbingAreas(climbingCenterName, changerUserUID, areas);
        }

        public async Task AddClimbingRoutes(string climbingCenterName, string climbingArea, List<AreaRoutes> areaRoutes, string changerUserUID, bool systemChanger, bool routesDirectly)
        {
            await _klatrecentreService.AddClimbingRoutes(climbingCenterName, climbingArea, areaRoutes, changerUserUID, systemChanger, routesDirectly);
        }

        public async Task<List<ClimbingCenterDocument>> GetClimbingCentre()
        {
            return await _klatrecentreService.GetClimbingCentre();
        }

        public async Task<List<string>> GetClimbingCentreNames()
        {
            return await _klatrecentreService.GetClimbingCentreNames();
        }

        public async Task<List<Areas>> GetCenterRoutes(string centerName)
        {
            return await _klatrecentreService.GetCenterRoutes(centerName);
        }

        public async Task UpdateRouteCompleters(List<AreaRoutes> routes, string climbingCenterName, string userUID)
        {
            await _klatrecentreService.UpdateRouteCompleters(routes, climbingCenterName, userUID);
        }

        public async Task<bool> CheckIfUserModerator(string userUID)
        {
            return await _moderatorService.CheckIfUserModerator(userUID);
        }

        public async Task<bool> CheckIfUserModeratorForCenter(string userUID, string climbingCenterName)
        {
            return await _moderatorService.CheckIfUserModeratorForCenter(userUID, climbingCenterName);
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

        public async Task<GripsDocument> GetGrip(string gripName)
        {
            return await _gripsService.GetGrip(gripName);
        }

        public async Task<List<GripsDocument>> GetGrips()
        {
            return await _gripsService.GetGrips();
        }

        public async Task UpdateGrip(string gripName, string fieldToChange, string newValue)
        {
            await _gripsService.UpdateGrip(gripName, fieldToChange, newValue);
        }

        public async Task DeleteGrip(string gripName)
        {
            await _gripsService.DeleteGrip(gripName);
        }

        public async Task CreateNewExercise(ExerciseDocument excerciseDocument)
        {
            await _exerciseService.CreateNewExercise(excerciseDocument);
        }

        public async Task<ExerciseDocument> GetExercise(string exerciseName)
        {
            return await _exerciseService.GetExercise(exerciseName);
        }

        public async Task<List<ExerciseDocument>> GetExercises()
        {
            return await _exerciseService.GetExercises();
        }

        public async Task<List<ExerciseDocument>> GetExercisesIncludedIn(string musclegroups)
        {
            return await _exerciseService.GetExercisesIncludedIn(musclegroups);
        }

        public async Task UpdateExercise(ExerciseDocument newExercise, string exerciseName)
        {
            await _exerciseService.UpdateExercise(newExercise, exerciseName);
        }

        public async Task DeleteExercise(string exerciseName)
        {
            await _exerciseService.DeleteExercise(exerciseName);
        }


        public async Task CreateNewWorkout(WorkoutDocument workoutDocument)
        {
            await _workoutService.CreateNewWorkout(workoutDocument);
        }

        public async Task<WorkoutDocument> GetWorkout(string workoutName)
        {
            return await _workoutService.GetWorkout(workoutName);
        }

        public async Task<List<WorkoutDocument>> GetWorkouts()
        {
            return await _workoutService.GetWorkouts();
        }

        public async Task UpdateWorkout(WorkoutDocument newWorkout, string workoutID)
        {
            await _workoutService.UpdateWorkout(newWorkout, workoutID);
        }

        public async Task DeleteWorkout(string workoutName)
        {
            await _workoutService.DeleteWorkout(workoutName);
        }

        public async Task<Issue> CreateIssue(string title, string description, bool isBug)
        {
            return await _reportService.CreateIssue(title, description, isBug);
        }

        public async Task<IReadOnlyList<Issue>> GetIssues()
        {
            return await _reportService.GetIssues();
        }

        public async Task DeleteClimbingRoute(string centerName, string areaName, string problemId, string changerUserUID, bool systemChanger)
        {
            await _klatrecentreService.DeleteClimbingRoute(centerName, areaName, problemId, changerUserUID, systemChanger);
        }
        public async Task DeleteClimbingArea(string centerName, string areaName, string changerUserUID, bool systemChanger)
        {
            await _klatrecentreService.DeleteClimbingArea(centerName, areaName , changerUserUID, systemChanger);
        }

        public async Task DeleteClimbingCenter(string climbingCenterName)
        {
            await _klatrecentreService.DeleteClimbingCenter(climbingCenterName);
        }

        public async Task UpdateClimbingRoutes(AreaRoutes areaRoutes, string climbingCenterName, string climbingArea, string changerUserUID, bool systemChanger)
        {
            await _klatrecentreService.UpdateClimbingRoutes(areaRoutes, climbingCenterName, climbingArea, changerUserUID, systemChanger);
        }

        public async Task UpdateClimbingArea(string centerName, string climbingArea, string newValue, string changerUserUID, bool systemChanger)
        {
            await _klatrecentreService.UpdateClimbingArea(centerName, climbingArea, newValue, changerUserUID, systemChanger);
        }

        public async Task<ClimbingCenterDocument> GetSelectedClimbingCenter(string climbingCenterName)
        {
            return await _klatrecentreService.GetSelectedClimbingCenter(climbingCenterName);
        }

  

    }
}
