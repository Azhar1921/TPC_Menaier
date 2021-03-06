﻿namespace Presentacion
{
    partial class Mensaje
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.BtnAceptar = new MetroFramework.Controls.MetroButton();
            this.tileTxt = new MetroFramework.Controls.MetroTile();
            this.SuspendLayout();
            // 
            // BtnAceptar
            // 
            this.BtnAceptar.Anchor = System.Windows.Forms.AnchorStyles.Bottom;
            this.BtnAceptar.Location = new System.Drawing.Point(153, 221);
            this.BtnAceptar.Name = "BtnAceptar";
            this.BtnAceptar.Size = new System.Drawing.Size(75, 23);
            this.BtnAceptar.TabIndex = 0;
            this.BtnAceptar.Text = "Aceptar";
            this.BtnAceptar.Theme = MetroFramework.MetroThemeStyle.Dark;
            this.BtnAceptar.UseSelectable = true;
            this.BtnAceptar.Click += new System.EventHandler(this.BtnAceptar_Click);
            // 
            // tileTxt
            // 
            this.tileTxt.ActiveControl = null;
            this.tileTxt.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tileTxt.Location = new System.Drawing.Point(23, 63);
            this.tileTxt.MinimumSize = new System.Drawing.Size(334, 147);
            this.tileTxt.Name = "tileTxt";
            this.tileTxt.Size = new System.Drawing.Size(334, 147);
            this.tileTxt.TabIndex = 9;
            this.tileTxt.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.tileTxt.TileTextFontSize = MetroFramework.MetroTileTextSize.Small;
            this.tileTxt.UseSelectable = true;
            // 
            // Mensaje
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(380, 260);
            this.Controls.Add(this.tileTxt);
            this.Controls.Add(this.BtnAceptar);
            this.MinimumSize = new System.Drawing.Size(380, 260);
            this.Name = "Mensaje";
            this.Text = "Advertencia";
            this.Theme = MetroFramework.MetroThemeStyle.Dark;
            this.Load += new System.EventHandler(this.Mensaje_Load);
            this.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.Mensaje_KeyPress);
            this.ResumeLayout(false);

        }

        #endregion
        private MetroFramework.Controls.MetroButton BtnAceptar;
        private MetroFramework.Controls.MetroTile tileTxt;
    }
}