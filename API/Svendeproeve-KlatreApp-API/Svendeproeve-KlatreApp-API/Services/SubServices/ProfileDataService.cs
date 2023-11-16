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

        private async Task AddClimbingHistory(string profileID, List<Climbing_History> climbing_History)
        {
            var klatreCentre = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
            var klatreData = klatreCentre.Documents.Select(k => k.ConvertTo<ClimbingCenterDocument>()).ToList();
            foreach (var document in klatreData)
            {
                var collection = _firestoreDb.Collection("Profile_data").Document(profileID).Collection("Climbing_History").Document(document.CenterName);
                foreach(var history in climbing_History)
                {
                    await collection.SetAsync(history);
                    if (history.Send_Collections != null) await AddSendCollections(profileID, document.CenterName, history.Send_Collections);
                }
            }
        }

        private async Task AddSendCollections(string profileID, string historyID, List<Send_Collection> send_Collections)
        {
            foreach(var sendCollection in send_Collections)
            {
                var collection = _firestoreDb.Collection("Profile_data").Document(profileID).Collection("Climbing_History").Document(historyID).Collection("Send_Collections").Document(sendCollection.ID);
                await collection.SetAsync(sendCollection);
            }
        }

        public async Task<ProfileDataDocument?> GetProfileData(string userUID)
        {
            var document = await _firestoreDb.Collection("Profile_data").Document(userUID).GetSnapshotAsync();
            if(document.Exists == false) return null;

            var profileData = document.ConvertTo<ProfileDataDocument>();
            List<Climbing_History> climbing_History = new List<Climbing_History>();
            var climbingHistoryDocument = await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").GetSnapshotAsync();
            var climbingHistoryData = climbingHistoryDocument.Documents.Select(h => h.ConvertTo<Climbing_History>()).ToList();
            foreach(var data in climbingHistoryData)
            {
                List<Send_Collection> send_Collections = new List<Send_Collection>();
                var sendDocument = await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(data.Location).Collection("Send_Collections").GetSnapshotAsync();
                var sendData = sendDocument.Documents.Select(s => s.ConvertTo<Send_Collection>()).ToList();
                send_Collections.AddRange(sendData);
                data.Send_Collections = send_Collections;
            }

            climbing_History.AddRange(climbingHistoryData);
            profileData.Climbing_History = climbing_History;
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

        public async Task UpdateFollow(string userUID, string userToFollowUserUID)
        {
            var profileDocument = await _firestoreDb.Collection("Profile_data").Document(userUID).GetSnapshotAsync();
            var profileData = profileDocument.ConvertTo<ProfileDataDocument>();
            profileData.Friend_Ids.Add(userToFollowUserUID);
            await _firestoreDb.Collection("Profile_data").Document(userUID).UpdateAsync("Friend_Ids", profileData.Friend_Ids);

            var userToFollowDocument = await _firestoreDb.Collection("Profile_data").Document(userToFollowUserUID).GetSnapshotAsync();
            var userToFollowData = userToFollowDocument.ConvertTo<ProfileDataDocument>();
            userToFollowData.Follows_Me.Add(userUID);
            await _firestoreDb.Collection("Profile_data").Document(userToFollowUserUID).UpdateAsync("Follows_Me", userToFollowData.Follows_Me);
        }

        public async Task RemoveFollow(string userUID, string userToFollowUserUID)
        {
            var profileDocument = await _firestoreDb.Collection("Profile_data").Document(userUID).GetSnapshotAsync();
            var profileData = profileDocument.ConvertTo<ProfileDataDocument>();
            profileData.Friend_Ids.Remove(userToFollowUserUID);
            await _firestoreDb.Collection("Profile_data").Document(userUID).UpdateAsync("Friend_Ids", profileData.Friend_Ids);

            var userToFollowDocument = await _firestoreDb.Collection("Profile_data").Document(userToFollowUserUID).GetSnapshotAsync();
            var userToFollowData = userToFollowDocument.ConvertTo<ProfileDataDocument>();
            userToFollowData.Follows_Me.Remove(userUID);
            await _firestoreDb.Collection("Profile_data").Document(userToFollowUserUID).UpdateAsync("Follows_Me", userToFollowData.Follows_Me);
        }

        public async Task<List<string>> GetFollowList(string userUID)
        {
            var profileDocument = await _firestoreDb.Collection("Profile_data").Document(userUID).GetSnapshotAsync();
            var profileData = profileDocument.ConvertTo<ProfileDataDocument>();
            return profileData.Friend_Ids;
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
                    UserUID = profile.ID,
                    Rank = 0,
                    Name = profile.User_Email,
                    Center_Name = Regex.Replace(climbingCenter, "([a-z])([A-Z])", "$1 $2"),
                    Grade = historyData.Estimated_Grade,
                    Score = historyData.Total_Points
                });
            }

            climbingScores = climbingScores.OrderBy(p => p.Score).ToList();

            for (int i = 0; i < climbingScores.Count; i++)
            {
                climbingScores[i].Rank = i + 1;
            }

            return climbingScores;
        }
    }
}
