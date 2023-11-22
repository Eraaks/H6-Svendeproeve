﻿using Google.Cloud.Firestore;
using Grpc.Core;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services.SubServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Svendeproeve_KlatreApp_API_Test
{
    public class KlatrecentreTest
    {
        private FirestoreDb _firestoreDB;
        private readonly KlatrecentreService _klatreCenterService;

        public KlatrecentreTest()
        {
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", @"C:\Users\Eraaks\Downloads\h6-svendeproeve-klatreapp-firebase-adminsdk-q7f96-1575848134.json");
            _firestoreDB = FirestoreDb.Create("h6-svendeproeve-klatreapp");
            _klatreCenterService = new KlatrecentreService(_firestoreDB);
        }

        [Fact]
        public async Task AddClimbingCenter()
        {
            // Arrange
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            var result = await _klatreCenterService.AddClimbingCenter(center, climbingCenterName);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task DeleteClimbingCenter()
        {
            // Arrange
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, climbingCenterName);
            var result = await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task AddAreaToClimbingCenter()
        {
            // Arrange
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            var newArea = new List<Areas>()
            {
                new Areas()
                {
                    Name = "New Area2",
                    Description = "New Area2",
                    AreaRoutes = new List<AreaRoutes>()
                            {
                                new AreaRoutes()
                                {
                                    ID = "",
                                    Color = "Black",
                                    Grade = "6C",
                                    UsersWhoCompleted = new List<string>() { "string" },
                                    UsersWhoFlashed = new List<string>() { "string" },
                                    Number = 0,
                                    AssignedArea = "",
                                }
                            }
                }

            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, climbingCenterName);
            var result = await _klatreCenterService.AddClimbingAreas(climbingCenterName, newArea);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task AddClimbingRoutes()
        {
            // Arrange
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            var areaRoutes = new List<AreaRoutes>()
            {
                  new AreaRoutes()
                  {
                      ID = "",
                      Color = "Blue",
                      Grade = "6B",
                      UsersWhoCompleted = new List<string>() { "string" },
                      UsersWhoFlashed = new List<string>() { "string" },
                      Number = 0,
                      AssignedArea = "",
                  },
                  new AreaRoutes()
                  {
                      ID = "",
                      Color = "Red",
                      Grade = "6C+",
                      UsersWhoCompleted = new List<string>() { "string" },
                      UsersWhoFlashed = new List<string>() { "string" },
                      Number = 0,
                      AssignedArea = "",
                  },
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, climbingCenterName);
            var result = await _klatreCenterService.AddClimbingRoutes(climbingCenterName, "Test", areaRoutes, "", true, true);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task GetClimbingCentre()
        {
            // Arrange
            var result = new List<ClimbingCenterDocument>();

            // Act
            result.AddRange(await _klatreCenterService.GetClimbingCentre());

            // Assert
            Assert.Equal(3, result.Count);
        }

        [Fact]
        public async Task GetClimbingCentreNames()
        {
            // Arrange
            var result = new List<string>();

            // Act
            result.AddRange(await _klatreCenterService.GetClimbingCentreNames());

            // Assert
            Assert.Equal(3, result.Count);
        }

        [Fact]
        public async Task DeleteClimbingRoute()
        {
            // Arrange
            StatusCode result;
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, climbingCenterName);
            var centerData = await _klatreCenterService.GetSelectedClimbingCenter(climbingCenterName);
            var problemID = centerData.Areas.FirstOrDefault(a => a.Name == "Test").AreaRoutes.First().ID;
            result = await _klatreCenterService.DeleteClimbingRoute(climbingCenterName, "Test", problemID, "", true);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task DeleteClimbingArea()
        {
            // Arrange
            StatusCode result;
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    },
                    new Areas()
                    {
                        Name = "Test2",
                        Description = "Test2",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, climbingCenterName);
            result = await _klatreCenterService.DeleteClimbingArea(climbingCenterName, "Test2", "", true);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task UpdateClimbingRoutes()
        {
            // Arrange
            StatusCode result;
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };
            var newAreaRoute = new AreaRoutes()
            {
                ID = "",
                Color = "Yellow",
                Grade = "6A",
                UsersWhoCompleted = new List<string>() { "string" },
                UsersWhoFlashed = new List<string>() { "string" },
                Number = 0,
                AssignedArea = "",
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, climbingCenterName);
            var centerData = await _klatreCenterService.GetSelectedClimbingCenter(climbingCenterName);
            var problem = centerData.Areas.FirstOrDefault(a => a.Name == "Test").AreaRoutes.First();
            newAreaRoute.ID = problem.ID;
            newAreaRoute.Number = problem.Number;
            newAreaRoute.AssignedArea = problem.AssignedArea;
            result = await _klatreCenterService.UpdateClimbingRoutes(newAreaRoute, climbingCenterName, newAreaRoute.AssignedArea, newAreaRoute.ID, "", true);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task UpdateClimbingArea()
        {
            // Arrange
            StatusCode result;
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, climbingCenterName);
            result = await _klatreCenterService.UpdateClimbingArea(climbingCenterName, "Test", "Test2", "", true);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task GetSelectedClimbingCenter()
        {
            // Arrange
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, climbingCenterName);
            var result = await _klatreCenterService.GetSelectedClimbingCenter(climbingCenterName);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(climbingCenterName, result.CenterName.Replace(" ", ""));
        }

        [Fact]
        public async Task GetCenterRoutes()
        {
            // Arrange
            List<Areas> areas = new List<Areas>();
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, climbingCenterName);
            areas.AddRange(await _klatreCenterService.GetCenterRoutes(climbingCenterName));
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(1, areas.FirstOrDefault().AreaRoutes.Count);
        }

        [Fact]
        public async Task UpdateRouteCompleters()
        {
            // Arrange
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            },
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Blue",
                                Grade = "6B+",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, climbingCenterName);
            var routes = await _klatreCenterService.GetSelectedClimbingCenter(climbingCenterName);
            var route = routes.Areas.FirstOrDefault().AreaRoutes.FirstOrDefault();
            route.UsersWhoCompleted.Add("Tester");
            List<AreaRoutes> areaRoutes = new List<AreaRoutes>
            {
                route
            };
            var result = await _klatreCenterService.UpdateRouteCompleters(areaRoutes, climbingCenterName, "Tester");
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }
    }
}
