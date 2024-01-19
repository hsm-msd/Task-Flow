using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace TaskFlowWebApp
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GoToWelcomePage(object sender, EventArgs e)
        {

            // ...
            try 
            {
                // Get user input from the form
                string userEmail = email.Text;
                string userPassword = password.Text;

                //Hash the password same way hashed while sign up, so user can be verified
                using (SHA256 sha256Hash = SHA256.Create())
                {
                    byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(userPassword));
                    StringBuilder builder = new StringBuilder();
                    for (int i = 0; i < bytes.Length; i++)
                    {
                        builder.Append(bytes[i].ToString("x2"));
                    }
                    userPassword = builder.ToString();
                }

                string connectionString = ConfigurationManager.ConnectionStrings["Taskflow"].ConnectionString; // Replace with your actual MySQL connection string

                using (MySqlConnection connection = new MySqlConnection(connectionString))
                {
                    connection.Open();

                    // Check if the user exists in the database
                    string query = "SELECT ID FROM Users WHERE Email = @Email AND Password = @Password";
                    using (MySqlCommand command = new MySqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@email", userEmail);
                        command.Parameters.AddWithValue("@password", userPassword);

                        object result = command.ExecuteScalar();

                        if (result != null)
                        {
                            // User exists, allow login
                            Session["UserID"] = Convert.ToInt32(result);
                            Session["UserEmail"] = userEmail;
                            Response.Redirect("TaskPage.aspx");
                        }
                        else
                            {
                            // User not found, display a message or redirect to the signup page
                            InvalidLogin.Text = "Invalid email or password.";
                               
                            }
                        }
                        connection.Close();
                    
                     } 
                
            }
            catch (Exception ex) 
            { 
                Response.Write("Error: " + ex.Message);
            }
            
        }
    }
}