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

namespace Lab1 {
    public partial class Form1 : Form {
        SqlConnection sqlConnection;
        DataSet dataSet;
        SqlDataAdapter dataAdapterPlanets, dataAdapterSatellites;
        SqlCommandBuilder commandBuilderPlanets, commandBuilderSatellites;
        BindingSource bindingSourcePlanets, bindingSourceSatellites;

        private void label1_Click(object sender, EventArgs e) {

        }

        public Form1() {
            InitializeComponent();
   
        }

        private void Form1_Load(object sender, EventArgs e) {
            sqlConnection = new SqlConnection();
            sqlConnection.ConnectionString = "Data Source = DESKTOP-8OGHCDV\\SQLEXPRESS; "
                + "Initial Catalog = AstronomicalObservatory; Integrated Security = SSPI";
            dataSet = new DataSet();
            dataAdapterSatellites = new SqlDataAdapter("SELECT * FROM Satellite", sqlConnection);
            dataAdapterPlanets = new SqlDataAdapter("SELECT * FROM Planet", sqlConnection);
            commandBuilderPlanets = new SqlCommandBuilder(dataAdapterPlanets);
            commandBuilderSatellites = new SqlCommandBuilder(dataAdapterSatellites);
            dataAdapterPlanets.Fill(dataSet, "Planet");
            dataAdapterSatellites.Fill(dataSet, "Satellite");

            DataRelation dataRelation = new DataRelation("FK_Planet_Satellite", dataSet.Tables["Planet"].Columns["ID"], dataSet.Tables["Satellite"].Columns["PlanetID"]);

            dataSet.Relations.Add(dataRelation);
            bindingSourcePlanets = new BindingSource();
            bindingSourcePlanets.DataSource = dataSet;
            bindingSourcePlanets.DataMember = "Planet";

            bindingSourceSatellites = new BindingSource();
            bindingSourceSatellites.DataSource = bindingSourcePlanets;
            bindingSourceSatellites.DataMember = "FK_Planet_Satellite";

            planetView.DataSource = bindingSourcePlanets;
            satelliteView.DataSource = bindingSourceSatellites;
        }

        private void updateDbButton_Click(object sender, EventArgs e) {
            dataAdapterPlanets.Update(dataSet, "Planet");
            dataAdapterSatellites.Update(dataSet, "Satellite");
        }

    }
}
