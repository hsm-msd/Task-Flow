using System;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmitTask_Click(object sender, EventArgs e)
        {
        }

        protected void btnAddTask_Click(object sender, EventArgs e)
        {

        }
        protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        {
            // Set the selected date in the txtTaskDate TextBox
            txtTaskDate.Text = Calendar2.SelectedDate.ToString("yyyy-MM-dd");
        }
    }
}

