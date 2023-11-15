using Google.Cloud.Firestore;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using System.Text.RegularExpressions;

namespace Svendeproeve_KlatreApp_API.Services.SubServices
{
    public class ProfileDataService
    {
        private readonly FirestoreDb _firestoreDb;
        public ProfileDataService(FirestoreDb firestoreDb)
        {
            _firestoreDb = firestoreDb;
        }

        public async Task AddProfileData(ProfileDataDocument profileData)
        {
            var collection = _firestoreDb.Collection("Profile_data").Document(profileData.ID);
            await collection.SetAsync(profileData);
            await AddClimbingHistory(profileData.ID, profileData.Climbing_History);
        }

        private async Task AddClimbingHistory(string profileID, Climbing_History climbing_History)
        {
            var klatreCentre = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
            var klatreData = klatreCentre.Documents.Select(k => k.ConvertTo<ClimbingCenterDocument>()).ToList();
            foreach (var document in klatreData)
            {
                var collection = _firestoreDb.Collection("Profile_data").Document(profileID).Collection("Climbing_History").Document(document.CenterName);
                await collection.SetAsync(climbing_History);
                if (climbing_History.Send_Collections != null) await AddSendCollections(profileID, climbing_History, document.CenterName, climbing_History.Send_Collections);
            }
        }

        private async Task AddSendCollections(string profileID, Climbing_History climbing_History, string historyID, Send_Collection send_Collections)
        {
            var collection = _firestoreDb.Collection("Profile_data").Document(profileID).Collection("Climbing_History").Document(historyID).Collection("Send_Collections").Document(send_Collections.ID);
            await collection.SetAsync(send_Collections);
        }

        public async Task<ProfileDataDocument> GetProfileData(string userUID)
        {
            var document = await _firestoreDb.Collection("Profile_data").Document(userUID).GetSnapshotAsync();
            var profileData = document.ConvertTo<ProfileDataDocument>();
            return profileData;
        }

        public async Task UpdateProfileData(ProfileDataDocument newProfile, string userUID)
        {
            await DeleteProfileData(userUID);
            await AddProfileData(newProfile);
        }

        public async Task DeleteProfileData(string userUID)
        {
            var sendCollections = await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(userUID).Collection("Send_Collections").GetSnapshotAsync();
            var sendCollectionsData = sendCollections.Documents.Select(s => s.ConvertTo<Send_Collection>()).ToList();
            foreach (var item in sendCollectionsData)
            {
                await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(userUID).Collection("Send_Collections").Document(item.ID).DeleteAsync();
            }
            await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(userUID).DeleteAsync();
            await _firestoreDb.Collection("Profile_data").Document(userUID).DeleteAsync();
        }

        public async Task<List<ClimbingScoreDocument>> GetClimbingScores(string climbingCenter)
        {
            List<ClimbingScoreDocument> climbingScores = new List<ClimbingScoreDocument>();
            var profileDocuments = await _firestoreDb.Collection("Profile_data").GetSnapshotAsync();
            var profileData = profileDocuments.Documents.Select(p => p.ConvertTo<ProfileDataDocument>()).ToList();
            foreach(var profile in profileData)
            {
                var historyDocuments = await _firestoreDb.Collection("Profile_data").Document(profile.ID).Collection("Climbing_History").Document(climbingCenter).GetSnapshotAsync();
                var historyData = historyDocuments.ConvertTo<Climbing_History>();
                climbingScores.Add(new ClimbingScoreDocument
                {
                    Name = profile.User_Email,
                    Center_Name = Regex.Replace(climbingCenter, "([a-z])([A-Z])", "$1 $2"),
                    Grade = historyData.Estimated_Grade,
                    Score = historyData.Total_Points
                });
            }

            return climbingScores;
        }

        //public async Task UpdateClimbingScore(string climbingCenter, bool isCompleted, bool isFlashed, string userUID)
        //{
        //    await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").
        //}
    }
}
