using System;
using System.IO;
using System.Net;
using HtmlAgilityPack;

class Program
{
    static void Main()
    {
        string websiteUrl = "https://iitmcloud.tropmet.res.in/index.php/s/H7TtGF6qkngnZD3?path=%2F20231220%2F00"; // Replace with the actual URL of your website
        DownloadTextFilesFromWebsite(websiteUrl);

        Console.WriteLine("Download process completed.");
    }

    static void DownloadTextFilesFromWebsite(string websiteUrl)
    {
        using (WebClient client = new WebClient())
        {
            string htmlContent = client.DownloadString(websiteUrl);

            HtmlDocument doc = new HtmlDocument();
            doc.LoadHtml(htmlContent);

            // Replace this XPath expression based on your website structure
            string xpathExpression = "//tr[@data-type='file' and contains(@data-file, '.txt')]/td[@class='filename']/a[@class='name']";
            HtmlNodeCollection fileNodes = doc.DocumentNode.SelectNodes(xpathExpression);

            if (fileNodes != null)
            {
                foreach (HtmlNode fileNode in fileNodes)
                {
                    string fileUrl = fileNode.GetAttributeValue("href", "");

                    // Download the file
                    DownloadFile(fileUrl);
                }
            }
        }
    }

    static void DownloadFile(string fileUrl)
    {
        using (WebClient client = new WebClient())
        {
            // Extract filename from the URL
            string fileName = Path.GetFileName(fileUrl);

            // Replace with the desired download directory
            string savePath = Path.Combine("DownloadedFiles", fileName);

            Console.WriteLine($"Downloading {fileName}...");

            // Create the DownloadedFiles directory if it doesn't exist
            Directory.CreateDirectory("DownloadedFiles");

            client.DownloadFile(fileUrl, savePath);

            Console.WriteLine($"{fileName} downloaded successfully.");
        }
    }
}
