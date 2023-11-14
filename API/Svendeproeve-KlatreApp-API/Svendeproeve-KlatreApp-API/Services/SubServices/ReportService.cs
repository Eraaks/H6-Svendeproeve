using Google.Cloud.Firestore;
using Octokit;

namespace Svendeproeve_KlatreApp_API.Services.SubServices
{
    public class ReportService
    {
        private readonly GitHubClient _gitHubClient;
        public ReportService(GitHubClient gitHubClient)
        {
            _gitHubClient = gitHubClient;
            var tokenAuth = new Credentials("");
            _gitHubClient.Credentials = tokenAuth;
        }

        public async Task<Issue> CreateIssue(string title, string description, bool isBug)
        {
            var createIssue = new NewIssue(title);
            createIssue.Assignees.Add("Eraaks");
            createIssue.Assignees.Add("Xcalera");
            createIssue.Body = description;
            if (isBug) createIssue.Labels.Add("bug"); else createIssue.Labels.Add("feedback");
            var issue = await _gitHubClient.Issue.Create("Eraaks", "H6-Svendeproeve-KlatreApp", createIssue);
            return issue;
        }

        public async Task<IReadOnlyList<Issue>> GetIssues()
        {
            var issues = await _gitHubClient.Issue.GetAllForRepository("Eraaks", "H6-Svendeproeve-KlatreApp");
            return issues;
        }
    }
}
