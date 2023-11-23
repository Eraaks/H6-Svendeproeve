using Google.Cloud.Firestore;

namespace Svendeproeve_KlatreApp_API.FirebaseDocuments
{
    [FirestoreData]
    public class ProfileDataDocument
    {
        [FirestoreDocumentId]
        public string ID { get; set; }
        [FirestoreProperty]
        public List<string>? Follows_Me { get; set; }
        [FirestoreProperty]
        public List<string>? Friend_Ids { get; set; }
        [FirestoreProperty]
        public List<string>? Saved_Exercises { get; set; }
        [FirestoreProperty]
        public List<string>? Saved_Workouts { get; set; }
        [FirestoreProperty]
        public string Username { get; set; }
        [FirestoreProperty]
        public string Selected_Gym { get; set; }
        public List<Climbing_History> Climbing_History { get; set; }
    }

    [FirestoreData]
    public class Climbing_History
    {
        [FirestoreProperty]
        public string ID { get; set; }
        [FirestoreProperty]
        public string Estimated_Grade { get; set; }
        [FirestoreProperty]
        public string Location { get; set; }
        [FirestoreProperty]
        public int Total_Points { get; set; }
        public List<Send_Collection>? Send_Collections { get; set; }
    }

    [FirestoreData]
    public class Send_Collection
    {
        [FirestoreDocumentId] 
        public string ID { get; set; }
        [FirestoreProperty]
        public string Area { get; set;}
        [FirestoreProperty]
        public string Grade { get; set; }
        [FirestoreProperty]
        public int Points { get; set; }
        [FirestoreProperty]
        public int Tries { get; set; }
        [FirestoreProperty]
        public long SendDate { get; set; }
    }
}
