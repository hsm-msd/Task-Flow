


using Google.Protobuf.WellKnownTypes;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Imaging;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TaskFlowWebApp
{
    public partial class TaskPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Use the connection string from web.config
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Taskflow"].ConnectionString;
            string userEmail = Session["UserEmail"].ToString();

            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                connection.Open();

                // Query to get the username
                string query = "SELECT username FROM users WHERE email = @email"; // replace with your condition
                using (MySqlCommand command = new MySqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@email", userEmail); // replace "useremail" with the actual user's email

                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            username.Text = reader["username"].ToString();
                        }
                    }
                }
            }
        
            //Restrict date to be todays onwards
            if (!IsPostBack)
            {
                txtTaskDate.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }


        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// Takes you to the Complete task page 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GoToCompletePage(object sender, EventArgs e)
        {
            Response.Redirect("CompleteTask.aspx");
        }

        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// Signs you out of application
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void SignOut(object sender, EventArgs e)
        {
            // Clear the UserEmail session
            Session["UserEmail"] = null;

            // Redirect to the login page 
            Response.Redirect("LoginPage.aspx");
        }

        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// Takes the user entered details for task and saves it to the database.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSubmitTask_Click(object sender, EventArgs e)
        {
            try
            {
                int userId = 1;
                if (Session["UserId"]!= null) 
                {
                    userId = Convert.ToInt32(Session["UserId"]);
                }
                
                // Read texts from details fields
                string taskTitle = txtTaskTitle.Text;
                string taskDescription = txtDescription.Text;
                DateTime dueDate = DateTime.Parse(txtTaskDate.Text); 


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

                    // Insert task details into the database
                    string query = "INSERT INTO tasks (title, description, dueDate, userId) VALUES (@title, @description, @dueDate, @userId)";
                    using (MySqlCommand command = new MySqlCommand(query, connection))
                    {
                        
                        command.Parameters.AddWithValue("@title", taskTitle);
                        command.Parameters.AddWithValue("@description", taskDescription);
                        command.Parameters.AddWithValue("@dueDate", dueDate);
                        command.Parameters.AddWithValue("@userId", userId);

                        command.ExecuteNonQuery();



                        // Update the task list on the page

                        DataTable dtTasks = GetLastThreeTasksFromDatabase();

                        //Bind the task list to the GridView
                        lvTasks.DataSource = dtTasks;
                        lvTasks.DataBind();

                        taskTitle = string.Empty;
                        taskDescription = string.Empty;

                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }

        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// This method takes last three task from database and shows it to the user.
        /// </summary>
        /// <returns></returns>
        protected DataTable GetLastThreeTasksFromDatabase()
        {
            DataTable dtTasks = new DataTable();

            try
            {
                int user_Id = 1;
                if (Session["UserId"] != null)
                {
                    user_Id = Convert.ToInt32(Session["UserId"]);
                }

                // Connection string from wen config
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Taskflow"].ConnectionString;

                using (MySqlConnection connection = new MySqlConnection(connectionString))
                {
                    connection.Open();

                    using (MySqlDataAdapter adapter = new MySqlDataAdapter($"SELECT title, id FROM tasks WHERE userId = {user_Id} ORDER BY createdAt DESC LIMIT 3", connection))
                    {
                        adapter.Fill(dtTasks);
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions here
                Response.Write("Error fetching tasks: " + ex.Message);
            }

            return dtTasks;
        }

        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// This method shows task details to the user when user click show task details
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void showTask_Click(object sender, EventArgs e)
        {
            IsButtonClicked.Value = "true";
            
           
            Button btn = (Button)sender;
            int taskId = Convert.ToInt32(btn.CommandArgument);
            
            try
            {
                int user_Id = 1;
                if (Session["UserId"] != null)
                {
                    user_Id = Convert.ToInt32(Session["UserId"]);
                }

                //use coneection string from web config
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Taskflow"].ConnectionString;

                using (MySqlDataAdapter adapter = new MySqlDataAdapter($"SELECT title, description, dueDate, status FROM tasks WHERE id = {taskId}", connectionString))
                {
                    DataTable dtTasks = new DataTable();
                    adapter.Fill(dtTasks);

                    if (dtTasks.Rows.Count > 0)
                    {
                        Ttitle.Text = dtTasks.Rows[0]["title"].ToString();
                        Tdescription.Text = dtTasks.Rows[0]["description"].ToString();
                        Tduedate.Text =Convert.ToDateTime(dtTasks.Rows[0]["dueDate"]).ToString("MM/dd/yyyy");
                        Tstatus.Text= dtTasks.Rows[0]["status"].ToString();
                    }
                    else
                    {
                        Ttitle.Text = "No tasks found for this user.";
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions here
                Response.Write("Error fetching tasks: " + ex.Message);
            }
            pnlAddTask.Style.Add("border-radius", "10px");
            ModalPopupExtender2.Show(); //Show the popup for task details

        }

        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// It clears out task details field if user enter details and choose cancel button to go back.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void CancelTaskDetails (object sender, EventArgs e)
        {
            txtDescription.Text = string.Empty;
            txtTaskDate.Text = string.Empty;
            txtTaskTitle.Text = string.Empty;
        }

        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// It takes to the all task page.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GoToAllTask(object sender, EventArgs e )
        {
            Response.Redirect("AllTasks.aspx");
        }

        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// It takes you to the incomplete task page.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GoToIncompleteTask(object sender, EventArgs e)
        {
            Response.Redirect("Incompletetasks.aspx");
        }

        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// It takes you to the complete task page.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GoToCompleteTask(object sender, EventArgs e)
        {
            Response.Redirect("CompleteTasks.aspx");
        }


        protected void btnAddTask_Click(object sender, EventArgs e)
        {
        }
        
    }
}

