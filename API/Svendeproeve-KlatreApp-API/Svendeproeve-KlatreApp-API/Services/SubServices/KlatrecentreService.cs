using Google.Cloud.Firestore;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using System.Text.RegularExpressions;

namespace Svendeproeve_KlatreApp_API.Services.SubServices
{
    public class KlatrecentreService
    {
        private readonly FirestoreDb _firestoreDb;
        public KlatrecentreService(FirestoreDb firestoreDb)
        {
            _firestoreDb = firestoreDb;
        }

        public async Task AddClimbingCenter(ClimbingCenterDocument climbingCenter, string climbingCenterName)
        {
            int number = 0;
            foreach(var area in climbingCenter.Areas)
            {
                foreach(var route in area.AreaRoutes)
                {
                    route.ID = Guid.NewGuid().ToString();
                    route.Number = number++;
                    route.AssignedArea = area.Name;
                }
            }
            var collection = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName);
            await collection.SetAsync(climbingCenter);
            await AddClimbingAreas(climbingCenterName, climbingCenter.Areas);
        }

        private async Task AddClimbingAreas(string climbingCenterName, List<Areas> areas)
        {
            List<string> areaNames = new List<string>();
            foreach (var area in areas)
            {
                areaNames.Add(area.Name);
                var collection = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(area.Name).Document(area.Name);
                await collection.SetAsync(area);
                await AddClimbingRoutes(climbingCenterName, area.Name, area.AreaRoutes, "", true);
            }

            await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).UpdateAsync("AreaNames", areaNames);
        }

        public async Task AddAreaToClimbingCenter(string climbingCenterName, Areas area)
        {
            var centerData = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(area.Name).Document(area.Name);
            await centerData.SetAsync(area);
        }

        public async Task AddClimbingRoutes(string climbingCenterName, string climbingArea, List<AreaRoutes> areaRoutes, string changerUserUID, bool systemChanger)
        {
            var centerDocument = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
            var centerData = centerDocument.Documents.Select(s => s.ConvertTo<ClimbingCenterDocument>()).ToList();
            foreach (var center in centerData)
            {
                if (center.CenterName == climbingCenterName)
                {
                    if (center.Moderators.Contains(changerUserUID) || systemChanger)
                    {
                        foreach (var area in areaRoutes)
                        {
                            var routesCollection = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").Document(area.ID);
                            await routesCollection.SetAsync(area);
                        }
                    }
                }
            }
        }

        public async Task<List<ClimbingCenterDocument>> GetClimbingCentre()
        {
            var centerDocument = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
            var centerData = centerDocument.Documents.Select(s => s.ConvertTo<ClimbingCenterDocument>()).ToList();
            foreach (var center in centerData)
            {
                List<Areas> area = new List<Areas>();
                if (center.AreaNames != null)
                {
                    foreach (var areaName in center.AreaNames)
                    {
                        List<AreaRoutes> areaRoutes = new List<AreaRoutes>();
                        var areaDocument = await _firestoreDb.Collection("Klatrecentre").Document(center.CenterName).Collection(areaName).GetSnapshotAsync();
                        var areaData = areaDocument.Select(a => a.ConvertTo<Areas>()).ToList();

                        foreach (var areas in areaData)
                        {
                            var routesDocument = await _firestoreDb.Collection("Klatrecentre").Document(center.CenterName).Collection(areaName).Document(areaName).Collection("Routes").GetSnapshotAsync();
                            var routesData = routesDocument.Select(r => r.ConvertTo<AreaRoutes>()).ToList();
                            if (routesData.Count != 0)
                            {
                                areaRoutes.AddRange(routesData);
                                areas.AreaRoutes = areaRoutes;
                            }
                        }

                        area.AddRange(areaData);
                    }
                }

                center.Areas = area;
                center.CenterName = Regex.Replace(center.CenterName, "([a-z])([A-Z])", "$1 $2");
            }

            return centerData;
        }

        public async Task<List<string>> GetClimbingCentreNames()
        {
            var centerDocuments = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
            var centerData = centerDocuments.Documents.Select(c => c.ConvertTo<ClimbingCenterDocument>()).ToList();
            List<string> names = new List<string>();
            foreach (var c in centerData)
            {
                names.Add(c.CenterName);
            }

            return names;
        }

        public async Task DeleteClimbingRoute(string climbingCenterName, string climbingArea, string problemId, string changerUserUID)
        {
            var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).GetSnapshotAsync();
            var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();

            if (centerData.Moderators.Contains(changerUserUID))
            {
                var routeData = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").Document(problemId);
                await routeData.DeleteAsync();
            }
            
        }

        public async Task DeleteClimbingArea(string climbingCenterName, string climbingArea, string changerUserUID)
        {
            var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).GetSnapshotAsync();
            var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();

            if (centerData.Moderators.Contains(changerUserUID))
            {
                var routeData = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").GetSnapshotAsync();

                foreach (var routes in routeData.Documents)
                {
                    await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").Document(routes.Id).DeleteAsync();
                }

                await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).DeleteAsync();
            }
            
        }
        

        public async Task UpdateClimbingRoutes(AreaRoutes areaRoutes, string climbingCenterName, string climbingArea, string problemId, string changerUserUID)
        {
            var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).GetSnapshotAsync();
            var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();

            if (centerData.Moderators.Contains(changerUserUID))
            {
                    var routeData = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").Document(problemId);
                    await routeData.DeleteAsync();
                    routeData = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").Document(problemId);
                    await routeData.CreateAsync(areaRoutes);

            }
                
            
        }
        public async Task UpdateClimbingArea(string climbingCenterName, string climbingArea, string fieldToChange, string newValue, string changerUserUID)
        {
            var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).GetSnapshotAsync();
            var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();

            if (centerData.Moderators.Contains(changerUserUID))
            {
                await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).UpdateAsync("Name", newValue);

            }           

        }
        public async Task<ClimbingCenterDocument> GetSelectedClimbingCenter(string climbingCenterName)
        {
            var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).GetSnapshotAsync();
            var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();

           
                List<Areas> area = new List<Areas>();

                if (centerData.AreaNames != null)
                {
                    foreach (var areaName in centerData.AreaNames)
                    {
                        List<AreaRoutes> areaRoutes = new List<AreaRoutes>();
                        var areaDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(areaName).GetSnapshotAsync();
                        var areaData = areaDocument.Select(a => a.ConvertTo<Areas>()).ToList();

                        foreach (var areas in areaData)
                        {
                            var routesDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(areaName).Document(areaName).Collection("Routes").GetSnapshotAsync();
                            var routesData = routesDocument.Select(r => r.ConvertTo<AreaRoutes>()).ToList();
                            if (routesData.Count != 0)
                            {
                                areaRoutes.AddRange(routesData);
                                areas.AreaRoutes = areaRoutes;
                            }
                        }

                        area.AddRange(areaData);
                    }
                }

                centerData.Areas = area;
                centerData.CenterName = Regex.Replace(centerData.CenterName, "([a-z])([A-Z])", "$1 $2");

            return centerData;
        }

        public async Task<List<Areas>> GetCenterRoutes(string centerName)
        {
            var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(centerName).GetSnapshotAsync();
            var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();
            List<Areas> area = new List<Areas>();
            if (centerData.AreaNames != null)
            {
                foreach (var areaName in centerData.AreaNames)
                {
                    List<AreaRoutes> areaRoutes = new List<AreaRoutes>();
                    var areaDocument = await _firestoreDb.Collection("Klatrecentre").Document(centerData.CenterName).Collection(areaName).GetSnapshotAsync();
                    var areaData = areaDocument.Select(a => a.ConvertTo<Areas>()).ToList();

                    foreach (var areas in areaData)
                    {
                        var routesDocument = await _firestoreDb.Collection("Klatrecentre").Document(centerData.CenterName).Collection(areaName).Document(areaName).Collection("Routes").GetSnapshotAsync();
                        var routesData = routesDocument.Select(r => r.ConvertTo<AreaRoutes>()).ToList();
                        if (routesData.Count != 0)
                        {
                            areaRoutes.AddRange(routesData);
                            foreach(var route in areaRoutes)
                            {
                                switch(route.Color)
                                {
                                    case "Black":
                                        route.Color = "255, 0, 0, 0";
                                        break;

                                    case "Red":
                                        route.Color = "255, 255, 0, 0";
                                        break;

                                    case "Orange":
                                        route.Color = "255, 255, 145, 0";
                                        break;

                                    case "Blue":
                                        route.Color = "255, 0, 68, 255";
                                        break;

                                    case "Yellow":
                                        route.Color = "255, 255, 251, 0";
                                        break;

                                    case "Green":
                                        route.Color = "255, 0, 255, 0";
                                        break;

                                    case "Light Blue":
                                        route.Color = "255, 0, 225, 255";
                                        break;
                                }
                            }
                            areas.AreaRoutes = areaRoutes;
                        }
                    }

                    area.AddRange(areaData);
                }
            }

            return area;
        }

        public async Task UpdateRouteCompleters(List<AreaRoutes> routes, string climbingCenterName, string userUID)
        {
            foreach(var route in routes)
            {
                var routeDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(route.AssignedArea).Document(route.AssignedArea).Collection("Routes").Document(route.ID).GetSnapshotAsync();
                var routeData = routeDocument.ConvertTo<AreaRoutes>();

                if(route.UsersWhoFlashed.Contains(userUID))
                {
                    if(!routeData.UsersWhoFlashed.Contains(userUID)) routeData.UsersWhoFlashed.Add(userUID);
                    if (routeData.UsersWhoFlashed.Contains("string")) routeData.UsersWhoFlashed.Remove("string");
                    await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(route.AssignedArea).Document(route.AssignedArea).Collection("Routes").Document(route.ID).UpdateAsync("UsersWhoFlashed", routeData.UsersWhoFlashed);
                }
                else
                {
                    if (!routeData.UsersWhoCompleted.Contains(userUID)) routeData.UsersWhoCompleted.Add(userUID);
                    if (routeData.UsersWhoCompleted.Contains("string")) routeData.UsersWhoCompleted.Remove("string");
                    await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(route.AssignedArea).Document(route.AssignedArea).Collection("Routes").Document(route.ID).UpdateAsync("UsersWhoCompleted", routeData.UsersWhoCompleted);
                }
            }
        }   
    }
}
