using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;

namespace Lab1 {
    public partial class Form1 : Form {
        SqlConnection sqlConnection;
        DataSet dataSet;
        SqlDataAdapter dataAdapterParent, dataAdapterChild;
        SqlCommandBuilder commandBuilderParent, commandBuilderChild;
        BindingSource bindingSourceParent, bindingSourceChild;
        string parentName = ConfigurationManager.AppSettings["parentTableName"];
        string childName = ConfigurationManager.AppSettings["childTableName"];
        
        private void label1_Click(object sender, EventArgs e) {

        }

        public Form1() {
            InitializeComponent();
   
        }

        private void Form1_Load(object sender, EventArgs e) {
            label1.Text = childName;
            label2.Text = parentName;
            string connectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
            sqlConnection = new SqlConnection(connectionString);
            dataSet = new DataSet();

            dataAdapterChild = new SqlDataAdapter(
                $"SELECT * FROM {childName}",
                sqlConnection
                );
            dataAdapterParent = new SqlDataAdapter(
                $"SELECT * FROM {parentName}",
                sqlConnection
                );
            commandBuilderParent = new SqlCommandBuilder(dataAdapterParent);
            commandBuilderChild = new SqlCommandBuilder(dataAdapterChild);
            dataAdapterParent.Fill(dataSet, $"{parentName}");
            dataAdapterChild.Fill(dataSet, $"{childName}");

            DataRelation dataRelation = new DataRelation($"FK_{parentName}_{childName}", dataSet.Tables[$"{parentName}"].Columns["ID"], dataSet.Tables[$"{childName}"].Columns[ConfigurationManager.AppSettings["childForeignKey"]]);

            dataSet.Relations.Add(dataRelation);
            bindingSourceParent = new BindingSource();
            bindingSourceParent.DataSource = dataSet;
            bindingSourceParent.DataMember = $"{parentName}";

            bindingSourceChild = new BindingSource();
            bindingSourceChild.DataSource = bindingSourceParent;
            bindingSourceChild.DataMember = $"FK_{parentName}_{childName}";

            planetView.DataSource = bindingSourceParent;
            satelliteView.DataSource = bindingSourceChild;
        }

        private void updateDbButton_Click(object sender, EventArgs e) {
            dataAdapterParent.Update(dataSet, $"{parentName}");
            dataAdapterChild.Update(dataSet, $"{childName}");
        }

    }
}
