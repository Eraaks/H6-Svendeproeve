using Google.Cloud.Firestore;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;

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
            var collection = _firestoreDb.Collection("Profile_data").Document(profileID).Collection("Climbing_History").Document(climbing_History.ID);
            await collection.SetAsync(climbing_History);
            if (climbing_History.Send_Collections != null) await AddSendCollections(profileID, climbing_History, climbing_History.Send_Collections);
        }

        private async Task AddSendCollections(string profileID, Climbing_History climbing_History, Send_Collection send_Collections)
        {
            var collection = _firestoreDb.Collection("Profile_data").Document(profileID).Collection("Climbing_History").Document(climbing_History.ID).Collection("Send_Collections").Document(send_Collections.ID);
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
            var profileDocument = await _firestoreDb.Collection("Profile_data").Document(userUID).GetSnapshotAsync();
            var profileData = profileDocument.ConvertTo<ProfileDataDocument>();
            var climbingHistoryDocument = await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(userUID).GetSnapshotAsync();
            var climbingHistoryData = climbingHistoryDocument.ConvertTo<Climbing_History>();
            var sendCollections = await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(userUID).Collection("Send_Collections").GetSnapshotAsync();
            var sendCollectionsData = sendCollections.Documents.Select(s => s.ConvertTo<Send_Collection>()).ToList();
            foreach (var item in sendCollectionsData)
            {
                await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(userUID).Collection("Send_Collections").Document(item.ID).DeleteAsync();
            }
            await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(userUID).DeleteAsync();
            await _firestoreDb.Collection("Profile_data").Document(userUID).DeleteAsync();
        }
    }
}
