using Google.Cloud.Firestore;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Models;

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

        public async Task<List<Shoe>> GetAll()
        {
            var collection = _firestoreDb.Collection(_collectionName);
            var snapshot = await collection.GetSnapshotAsync();

            var shoeDocuments = snapshot.Documents.Select(s => s.ConvertTo<ShoeDocument>()).ToList();
            return shoeDocuments.Select(ConvertDocumentToModel).ToList();
        }
        public async Task AddAsync(Shoe shoe)
        {   
            var collection = _firestoreDb.Collection(_collectionName);
            var shoeDocument = ConvertModelToDocument(shoe);
            await collection.AddAsync(shoeDocument);
        }
        private static Shoe ConvertDocumentToModel(ShoeDocument shoeDocument)
        {
            return new Shoe
            {
                Id = shoeDocument.Id,
                Name = shoeDocument.Name,
                Brand = shoeDocument.Brand,
                Price = decimal.Parse(shoeDocument.Price)
            };
        }
        private static ShoeDocument ConvertModelToDocument(Shoe shoe)
        {
            return new ShoeDocument
            {
                Id = shoe.Id,
                Name = shoe.Name,
                Brand = shoe.Brand,
                Price = shoe.Price.ToString()
            };
        }

        public async Task AddProfile(ProfileDataDocument profileData)
        {
            var collection = _firestoreDb.Collection("Profile_data").Document(profileData.ID);
            await collection.SetAsync(profileData);
            await AddClimbingHistory(profileData.ID, profileData.Climbing_History);
        }

        private async Task AddClimbingHistory(string profileID, Climbing_History climbing_History)
        {
            var collection = _firestoreDb.Collection("Profile_data").Document(profileID).Collection("Climbing_History").Document(climbing_History.ID);
            await collection.SetAsync(climbing_History);
            await AddSendCollections(profileID, climbing_History, climbing_History.Send_Collections);
        }

        private async Task AddSendCollections(string profileID, Climbing_History climbing_History, Send_Collection send_Collections)
        {
            var collection = _firestoreDb.Collection("Profile_data").Document(profileID).Collection("Climbing_History").Document(climbing_History.ID).Collection("Send_Collections").Document(send_Collections.ID);
            await collection.SetAsync(send_Collections);
        }
    }
}
