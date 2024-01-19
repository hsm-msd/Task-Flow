using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TaskFlowWebApp
{
    public partial class IncompleteTasks : System.Web.UI.Page
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

            // Redirect to the login page (replace "LoginPage.aspx" with your actual login page)
            Response.Redirect("LoginPage.aspx");
        }

        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// It takes you to the all task page.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>

        protected void GoToAllTask(object sender, EventArgs e)
        {
            Response.Redirect("AllTasks.aspx");
        }

        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// It takes you to the add task page.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GoToAddTask(object sender, EventArgs e)
        {
            Response.Redirect("TaskPage.aspx");
        }

        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// it takes you to the complete task page.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GoToCompleteTask(object sender, EventArgs e)
        {
            Response.Redirect("CompleteTasks.aspx");
        }

        /// <summary>
        /// This method retrieves only incomplete tasks fro the database.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        /// 
        protected DataTable GetIncompleteTasksFromDatabase()
        {
            DataTable dtTasks = new DataTable();

            try
            {
                int user_Id = 1;
                if (Session["UserId"] != null)
                {
                    user_Id = Convert.ToInt32(Session["UserId"]);
                }
                // Assuming you have a connection string in the web.config file with the name "Taskflow"
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Taskflow"].ConnectionString;

                using (MySqlConnection connection = new MySqlConnection(connectionString))
                {
                    connection.Open(); 

                    using (MySqlDataAdapter adapter = new MySqlDataAdapter($"SELECT title, id FROM tasks WHERE userId = {user_Id} AND status = 'incomplete'", connection))
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
        /// It shows only incomplete tasks on the page
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>

        protected void ShowIncompleteTasks (object sender, EventArgs e)
        {
            // Update the task list on the page

            DataTable dtTasks = GetIncompleteTasksFromDatabase();

            if (dtTasks.Rows.Count==0)
            {
                LabelNoTask.Visible=true;
                LabelNoTask.Text = "No tasks found.";
            }
            else
            {
                LabelNoTask.Visible= false;
                //Bind the task list to the GridView
                lvTasks.DataSource = dtTasks;
                lvTasks.DataBind();
            }
            
        }

        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// This method shows task details to the user when user click show task details
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ShowTask_click (object sender, EventArgs e)
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
                // Assuming you have a connection string in the web.config file with the name "Taskflow"
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Taskflow"].ConnectionString;

                using (MySqlDataAdapter adapter = new MySqlDataAdapter($"SELECT title, description, dueDate, status FROM tasks WHERE status = 'incomplete' AND id = {taskId}", connectionString))
                {
                    DataTable dtTasks = new DataTable();
                    adapter.Fill(dtTasks);

                    if (dtTasks.Rows.Count > 0)
                    {
                        Ttitle.Text = dtTasks.Rows[0]["title"].ToString();
                        Tdescription.Text = dtTasks.Rows[0]["description"].ToString();
                        Tduedate.Text = Convert.ToDateTime(dtTasks.Rows[0]["dueDate"]).ToString("MM/dd/yyyy");
                        Tstatus.Text = dtTasks.Rows[0]["status"].ToString();
                    }
                    else
                    {
                        Ttitle.Text = "Currently there are no incomplete tasks.";
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions here
                Response.Write("Error fetching tasks: " + ex.Message);
            }

            ModalPopupExtender2.Show();
        }

        /*-------------------------------------------------------------------------- */
        /// <summary>
        /// It deletes task from list as well as from database.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void deleteTask_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int taskId = Convert.ToInt32(btn.CommandArgument);

            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Taskflow"].ConnectionString;

                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand($"DELETE FROM tasks WHERE id = {taskId}", conn);
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

                // Refresh the ListView to reflect the deletion
                lvTasks.DataBind();
            }
            catch (Exception ex)
            {
                // Handle any exceptions here
                Response.Write("Error deleting task: " + ex.Message);
            }
        }
    }
}