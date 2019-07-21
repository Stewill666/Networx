using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Networx
{
    public partial class Contact : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=DESKTOP-UFKN9DG\SQLEXPRESS01;Initial Catalog=Networx_db;Integrated Security=true;");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnDelete.Enabled = false;
                FillGridView();
            }
        }
        public bool checkInputs() // True or False that checks if the box is empty fro Sign In
        {
            bool check = true;

            if (
                string.IsNullOrEmpty(txtName.Text) || // if statement that check if the box has text 
                string.IsNullOrEmpty(txtMobile.Text) ||
                string.IsNullOrEmpty(txtAddress.Text))

            {
                check = false; // defines check as false
            }
            return (check); // returns false
        }

            protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
        protected void btnUP_Click(object sender, EventArgs e)
        {
            if (checkInputs() == true)
            {
                if (sqlCon.State == ConnectionState.Closed)
                    sqlCon.Open();
            
                SqlCommand sqlCmd = new SqlCommand("UPDATE Contact SET Name=@Name,Mobile=@Mobile,Address=@Address WHERE ContactID = @ID", sqlCon);
                sqlCmd.Parameters.AddWithValue("@ID", txtID.InnerText);
                sqlCmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                sqlCmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                sqlCmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                sqlCmd.ExecuteNonQuery();
                sqlCon.Close();
                
                Clear();
                FillGridView();
                lblSuccessMessage.Text = "Updated Successfully";
            } else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Scripts", "<script>alert('Empty Field');</script>");
            }
        }

        public void Clear()
        {
            hfContactID.Value = "";
            txtName.Text = txtMobile.Text = txtAddress.Text = "";
            lblSuccessMessage.Text = lblErrorMessage.Text = "";
            btnSave.Text = "Save";
            btnDelete.Enabled = false;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        
       {
            // Checks for empty fields
            if (checkInputs() == true)
            {
                if (sqlCon.State == ConnectionState.Closed)
                    sqlCon.Open();
               
                    SqlCommand sqlCmd = new SqlCommand("INSERT INTO Contact (Name,Mobile,Address) VALUES (@Name,@Mobile,@Address)", sqlCon);
                    sqlCmd.Parameters.AddWithValue("@ContactID", (hfContactID.Value == "" ? 0 : Convert.ToInt32(hfContactID.Value)));
                    sqlCmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                    sqlCmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                    sqlCmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                    sqlCmd.ExecuteNonQuery();
                    sqlCon.Close();
               
                string contactID = hfContactID.Value;
                    
                Clear();
                FillGridView();
                lblSuccessMessage.Text = "Saved Successfully";
            }
            else

            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Scripts", "<script>alert('Empty Field');</script>");
            }
        }

        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT * FROM Contact", sqlCon);
            
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            gvContact.DataSource = dtbl;
            gvContact.DataBind();

        }

        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int contactID = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT * FROM Contact WHERE ContactID = @ContactID", sqlCon);
            
            sqlDa.SelectCommand.Parameters.AddWithValue("@ContactID", contactID);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            hfContactID.Value = contactID.ToString();
            txtID.InnerText = dtbl.Rows[0]["ContactID"].ToString();
            txtName.Text = dtbl.Rows[0]["Name"].ToString();
            txtMobile.Text = dtbl.Rows[0]["Mobile"].ToString();
            txtAddress.Text = dtbl.Rows[0]["Address"].ToString();
            
            btnDelete.Enabled = true;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
           

            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd = new SqlCommand("DELETE FROM Contact WHERE ContactID = @ContactID ", sqlCon);
            
            sqlCmd.Parameters.AddWithValue("@ContactID", txtID.InnerText);
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            Clear();
            FillGridView();
            lblSuccessMessage.Text = "Deleted Successfully";
        }
    }
}
