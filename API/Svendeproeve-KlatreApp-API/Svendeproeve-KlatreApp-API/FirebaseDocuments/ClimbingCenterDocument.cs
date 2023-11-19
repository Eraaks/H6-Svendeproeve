using Google.Cloud.Firestore;

namespace Svendeproeve_KlatreApp_API.FirebaseDocuments
{
    [FirestoreData]
    public class ClimbingCenterDocument
    {
        [FirestoreProperty]
        public string CenterName { get; set; }

        [FirestoreProperty]
        public string Description { get; set; }

        [FirestoreProperty]
        public string Location { get; set; }

        [FirestoreProperty]
        public string Moderator_Code { get; set; }

        [FirestoreProperty]
        public List<string> Moderators { get; set; }

        [FirestoreProperty]
        public List<string> AreaNames { get; set; }

        public List<Areas> Areas { get; set; }
    }

    [FirestoreData]
    public class Areas
    {
        [FirestoreProperty]
        public string Name { get; set; }
        [FirestoreProperty]
        public string Description { get; set; }

        public List<AreaRoutes> AreaRoutes { get; set; }
    }

    [FirestoreData]
    public class AreaRoutes
    {
        [FirestoreProperty]
        public string ID { get; set; }

        [FirestoreProperty]
        public string Color { get; set; }

        [FirestoreProperty]
        public string Grade { get; set; }

        [FirestoreProperty]
        public List<string> UsersWhoCompleted { get; set; }

        [FirestoreProperty]
        public List<string> UsersWhoFlashed { get; set; }

        [FirestoreProperty]
        public int Number { get; set; }
    }
}
