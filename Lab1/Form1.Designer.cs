
namespace Lab1
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.planetView = new System.Windows.Forms.DataGridView();
            this.satelliteView = new System.Windows.Forms.DataGridView();
            this.updateDbButton = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.planetView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.satelliteView)).BeginInit();
            this.SuspendLayout();
            // 
            // planetView
            // 
            this.planetView.BackgroundColor = System.Drawing.Color.Red;
            this.planetView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.planetView.GridColor = System.Drawing.Color.Fuchsia;
            this.planetView.Location = new System.Drawing.Point(55, 74);
            this.planetView.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.planetView.Name = "planetView";
            this.planetView.RowHeadersWidth = 62;
            this.planetView.RowTemplate.Height = 33;
            this.planetView.Size = new System.Drawing.Size(835, 299);
            this.planetView.TabIndex = 0;
            // 
            // satelliteView
            // 
            this.satelliteView.BackgroundColor = System.Drawing.Color.Red;
            this.satelliteView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.satelliteView.GridColor = System.Drawing.Color.Fuchsia;
            this.satelliteView.Location = new System.Drawing.Point(55, 424);
            this.satelliteView.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.satelliteView.Name = "satelliteView";
            this.satelliteView.RowHeadersWidth = 62;
            this.satelliteView.RowTemplate.Height = 33;
            this.satelliteView.Size = new System.Drawing.Size(653, 306);
            this.satelliteView.TabIndex = 1;
            // 
            // updateDbButton
            // 
            this.updateDbButton.BackColor = System.Drawing.Color.Green;
            this.updateDbButton.Font = new System.Drawing.Font("Comic Sans MS", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.updateDbButton.ForeColor = System.Drawing.SystemColors.WindowText;
            this.updateDbButton.Location = new System.Drawing.Point(1065, 355);
            this.updateDbButton.Margin = new System.Windows.Forms.Padding(4, 3, 4, 3);
            this.updateDbButton.Name = "updateDbButton";
            this.updateDbButton.Size = new System.Drawing.Size(276, 66);
            this.updateDbButton.TabIndex = 2;
            this.updateDbButton.Text = "UpdateDatabase";
            this.updateDbButton.UseVisualStyleBackColor = false;
            this.updateDbButton.Click += new System.EventHandler(this.updateDbButton_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Comic Sans MS", 9F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point);
            this.label1.Location = new System.Drawing.Point(55, 395);
            this.label1.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(85, 26);
            this.label1.TabIndex = 3;
            this.label1.Text = "Satellite";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Comic Sans MS", 9F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point);
            this.label2.Location = new System.Drawing.Point(55, 26);
            this.label2.Margin = new System.Windows.Forms.Padding(4, 0, 4, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(64, 26);
            this.label2.TabIndex = 4;
            this.label2.Text = "Planet";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(11F, 26F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.BackColor = System.Drawing.Color.Navy;
            this.ClientSize = new System.Drawing.Size(1408, 737);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.updateDbButton);
            this.Controls.Add(this.satelliteView);
            this.Controls.Add(this.planetView);
            this.Font = new System.Drawing.Font("Comic Sans MS", 9F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point);
            this.ForeColor = System.Drawing.Color.Turquoise;
            this.Name = "Form1";
            this.Text = "AstronomicalObservatory";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.planetView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.satelliteView)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView planetView;
        private System.Windows.Forms.DataGridView satelliteView;
        private System.Windows.Forms.Button updateDbButton;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
    }
}

