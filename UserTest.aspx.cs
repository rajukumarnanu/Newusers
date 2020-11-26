using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace TESTUSERS.users
{
    public partial class UserTest : System.Web.UI.Page
    {

        public string Tdata = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string PostData(int id, string userid, string uname, string email)
        {
            String Msg_sms = "OK";

            try
            {

                //string url = "https://jsonplaceholder.typicode.com/users/";

                HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://jsonplaceholder.typicode.com/users/");
                string data = "id=" + id + "&name=" + uname + "&username=" + uname + "&email=" + email;

                JavaScriptSerializer json = new JavaScriptSerializer();
                string response = string.Empty;
                JObject jsonResponse = new JObject();

                request.ContentLength = data.Length;
                request.SendChunked = true;
                request.Method = "POST";
                request.UseDefaultCredentials = true;
                request.Accept = "application/json";

                using (var streamWriter = new StreamWriter(request.GetRequestStream()))
                {
                    string JsonData = new JavaScriptSerializer().Serialize(new
                    {
                        requestMsg = data
                    });


                    streamWriter.Write(JsonData);
                    streamWriter.Flush();
                    streamWriter.Close();

                }


            }
            catch (Exception ex)
            {
                return ex.Message;
            }

            return Msg_sms;

        }



        [WebMethod]
        public static string GetData(int id)
        {

            String Msg_sms = "OK";
            try
            {

                HttpWebRequest WebReq = (HttpWebRequest)WebRequest.Create(string.Format("https://jsonplaceholder.typicode.com/users/" + id));

                WebReq.Method = "GET";

                HttpWebResponse WebResp = (HttpWebResponse)WebReq.GetResponse();

                Console.WriteLine(WebResp.StatusCode);
                Console.WriteLine(WebResp.Server);

                string jsonString;
                using (Stream stream = WebResp.GetResponseStream())   //modified from your code since the using statement disposes the stream automatically when done
                {
                    StreamReader reader = new StreamReader(stream, System.Text.Encoding.UTF8);
                    jsonString = reader.ReadToEnd();
                }

                // List<Item> items = JsonConvert.DeserializeObject<List<Item>>(jsonString);

                // Console.WriteLine(items.Count);

                Msg_sms = jsonString;
            }
            catch (Exception ex)
            {
                Msg_sms = ex.Message;
            }

            return Msg_sms;
        }


        [WebMethod]
        public static string GetAllData()
        {

            String Msg_sms = "OK";
            try
            {

                HttpWebRequest WebReq = (HttpWebRequest)WebRequest.Create(string.Format("https://jsonplaceholder.typicode.com/users/"));

                WebReq.Method = "GET";

                HttpWebResponse WebResp = (HttpWebResponse)WebReq.GetResponse();

                Console.WriteLine(WebResp.StatusCode);
                Console.WriteLine(WebResp.Server);

                string jsonString;
                using (Stream stream = WebResp.GetResponseStream())   //modified from your code since the using statement disposes the stream automatically when done
                {
                    StreamReader reader = new StreamReader(stream, System.Text.Encoding.UTF8);
                    jsonString = reader.ReadToEnd();
                }

                // List<Item> items = JsonConvert.DeserializeObject<List<Item>>(jsonString);

                // Console.WriteLine(items.Count);

                Msg_sms = jsonString;
            }
            catch (Exception ex)
            {
                Msg_sms = ex.Message;
            }

            return Msg_sms;

        }

    }
     

}