using FirebaseAdmin;
using FirebaseAdmin.Auth;
using Google.Cloud.Firestore;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using System.Linq;

namespace Svendeproeve_KlatreApp_API.Services
{
    public class FirestoreService
    {
        private readonly FirestoreDb _firestoreDb;
        private const string _collectionName = "Shoes";
        public FirestoreService(FirestoreDb firestoreDb)
        {
            _firestoreDb = firestoreDb;
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
            var collection = _firestoreDb.Collection("Profile_data").Document(profileData.ID);
            await collection.SetAsync(profileData);
            await AddClimbingHistory(profileData.ID, profileData.Climbing_History);
        }

        private async Task AddClimbingHistory(string profileID, Climbing_History climbing_History)
        {
            var collection = _firestoreDb.Collection("Profile_data").Document(profileID).Collection("Climbing_History").Document(climbing_History.ID);
            await collection.SetAsync(climbing_History);
            if(climbing_History.Send_Collections != null) await AddSendCollections(profileID, climbing_History, climbing_History.Send_Collections);
        }

        private async Task AddSendCollections(string profileID, Climbing_History climbing_History, Send_Collection send_Collections)
        {
            var collection = _firestoreDb.Collection("Profile_data").Document(profileID).Collection("Climbing_History").Document(climbing_History.ID).Collection("Send_Collections").Document(send_Collections.ID);
            await collection.SetAsync(send_Collections);
        }

        public async Task AddAsync(ClimbingCenterDocument climbingCenter, string climbingCenterName)
        {
            var collection = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName);
            await collection.SetAsync(climbingCenter);
            await AddClimbingAreas(climbingCenterName, climbingCenter.Areas);
        }

        private async Task AddClimbingAreas(string climbingCenterName, List<Areas> areas)
        {
            foreach (var area in areas)
            {
                var collection = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(area.Name);
                await collection.AddAsync(area);
            }
        }

        public async Task AddClimbingRoutes(string climbingArea, List<AreaRoutes> areaRoutes, string moderator)
        {
            
        }

        public async Task<bool> CheckIfUserModerator(string userUID)
        {
            var centerDocument = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
            var centerData = centerDocument.Documents.Select(s => s.ConvertTo<ClimbingCenterDocument>()).ToList();
            foreach (var area in centerData)
            {
                if (area.Moderators.Contains(userUID)) return true;
            }

            return false;
        }

        public async Task<string> RequestModeratorCode(string climbingCenterName, string userUID)
        {
            var centerDocument = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
            var centerData = centerDocument.Documents.Select(s => s.ConvertTo<ClimbingCenterDocument>()).ToList();
            foreach (var area in centerData)
            {
                if(area.CenterName == climbingCenterName)
                {
                    if (area.Moderators.Contains(userUID)) return area.Moderator_Code;
                }
            }
            return "";
        }

        public async Task CheckModeratorCodeAndAddToCenter(string moderatorCode, string userUID)
        {
            var centerData = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
            var centerDocuments = centerData.Documents.Select(s => s.ConvertTo<ClimbingCenterDocument>()).ToList();
            foreach (var document in centerDocuments)
            {
                if(moderatorCode == document.Moderator_Code)
                {
                    var centerDocument = _firestoreDb.Collection("Klatrecentre").Document(document.CenterName);
                    var moderators = document.Moderators;
                    moderators.Add(userUID);
                    await centerDocument.UpdateAsync("Moderators", moderators);
                }
            }
        }

        public async Task<bool> CompareSecretValues(string fireBaseSecret)
        {
            var data = await _firestoreDb.Collection("Login Verification").GetSnapshotAsync();
            var snapshotDocumentID = data.Documents[0].Id;
            DocumentSnapshot snapshotDocument = await _firestoreDb.Collection("Login Verification").Document(snapshotDocumentID).GetSnapshotAsync();
            if(snapshotDocument.Exists)
            {
                Dictionary<string, object> keys = snapshotDocument.ToDictionary();
                foreach(KeyValuePair<string, object> k in keys) {
                    if ((string)k.Value == fireBaseSecret) return true;
                }
            }

            return false;
        }
    }
}
