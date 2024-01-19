using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TaskFlowWebApp
{
    public partial class Signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateAccount_Click(object sender, EventArgs e)
        {

            try
            {
                string userName = username.Text;
                string userEmail = useremail.Text;
                string userPassword = userpassword.Text;

                //ensure user do not use same email for registration.
                if (IsEmailRegistered(userEmail))
                {
                    // Display error message
                    CreatedAccountMessage.Text = "This email is already registered. Please use a different email.";
                    return;
                }

                //Hash the password before saving
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

                // Use the connection string from web.config
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Taskflow"].ConnectionString;

                using (MySqlConnection connection = new MySqlConnection(connectionString))
                {
                    connection.Open();
                    
                    // Test query
                    string testQuery = "SELECT 1";
                    using (MySqlCommand testCommand = new MySqlCommand(testQuery, connection))
                    {
                        testCommand.ExecuteScalar();
                    }

                    // Insert user details into the database
                    string query = "INSERT INTO users (username, email, password) VALUES (@username, @email, @password)";
                    using (MySqlCommand command = new MySqlCommand(query, connection))
                    {
                        
                        command.Parameters.AddWithValue("@username", userName);
                        command.Parameters.AddWithValue("@email", userEmail);
                        command.Parameters.AddWithValue("@password", userPassword);

                        command.ExecuteNonQuery();
                    }               
                }
                CreatedAccountMessage.Text = "Your account has been created. Use the log in link below to log in.";
            }
            catch (Exception ex)
            {
                Response.Write("error: "+ ex.Message);
            }
            
        }

        protected void ValidatePassword(object source, ServerValidateEventArgs args)
        {
            // Custom password validation logic
            string password = args.Value;

            // Your password validation logic goes here
            // Example: Password must contain special characters, numbers, and letters and should not be empty
            bool isValid = !string.IsNullOrWhiteSpace(password) && Regex.IsMatch(password, @"^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&*!])[A-Za-z\d@#$%^&*!]{8,}$");

            args.IsValid = isValid;
        }

        //check if email already registered
        protected bool IsEmailRegistered(string userEmail)
        {
            // Use the connection string from web.config
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Taskflow"].ConnectionString;

            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                connection.Open();

                // Check if email already exists
                string checkEmailQuery = "SELECT COUNT(*) FROM users WHERE email = @email";
                using (MySqlCommand checkEmailCommand = new MySqlCommand(checkEmailQuery, connection))
                {
                    checkEmailCommand.Parameters.AddWithValue("@email", userEmail);
                    var count = Convert.ToInt32(checkEmailCommand.ExecuteScalar());
                    if (count > 0)
                    {
                        // Email already exists
                        return true;
                    }
                }
            }
            // Email does not exist
            return false;
        }
    }
}