using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ShowLexiconList(0);
        }

    }

    private void ShowLexiconList(int selectedWordType = 0)
    {
        SENTEntities ent = new SENTEntities();
        List<Lexicon> listLexicon = ent.Lexicons.ToList();

        if (selectedWordType == 1)
            listLexicon = ent.Lexicons.Where(x => x.Rate > 0).ToList();
        else if(selectedWordType == 2)
            listLexicon = ent.Lexicons.Where(x => x.Rate < 0).ToList();
        else if (selectedWordType == 3)
            listLexicon = ent.Lexicons.Where(x => x.Rate == 0).ToList();        

        gvLexiconList.DataSource = listLexicon;
        gvLexiconList.DataBind();
    }

    protected void gvLexiconList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        SENTEntities ent = new SENTEntities(); 

        int index = Convert.ToInt32(e.CommandArgument);
        GridViewRow red = ((GridView)e.CommandSource).Rows[index]; 
        string Id = red.Cells[0].Text;
        int lexiconId = Convert.ToInt32(Id);

        Lexicon lexicon = ent.Lexicons.FirstOrDefault(x => x.ID == lexiconId);
        if (lexicon == null)
            return;        

        Session["lexiconID"] = lexicon.ID;

        if (e.CommandName == "EditRow")
        {
            tbWord.Text = lexicon.Word;
            tbRate.Text = lexicon.Rate.ToString();
        }
        if (e.CommandName == "DeleteRow")
        {            
            lblPitanjeBrisi.Text = "Are you sure you want to delete: " + lexicon.Word + "?";
            mpeBrisi.Show();
        }
    }

    protected void gvLexiconList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string Id = e.Row.Cells[0].Text;
            int lexiconId = Convert.ToInt32(Id);
            int positive = CheckPositiveRate(lexiconId);

            if (positive == 1)
                e.Row.Cells[1].ForeColor = System.Drawing.Color.Green;
            else if (positive == 2)
                e.Row.Cells[1].ForeColor = System.Drawing.Color.Red;
            else
                e.Row.Cells[1].ForeColor = System.Drawing.Color.Black;
        }
    }

    private int CheckPositiveRate(int lexiconId)
    {
        SENTEntities ent = new SENTEntities();

        Lexicon lexicon = ent.Lexicons.FirstOrDefault(x => x.ID == lexiconId);
        if (lexicon.Rate > 0)
            return 1;
        else if (lexicon.Rate < 0)
            return 2;
        else
            return 0;

    }     

    protected void rblWords_SelectedIndexChanged(object sender, EventArgs e)
    { 
        if (IsPostBack)
        {
            if (rblWords.SelectedValue == "1")
                ShowLexiconList(1);
            else if (rblWords.SelectedValue == "2")
                ShowLexiconList(2);
            else if (rblWords.SelectedValue == "3")
                ShowLexiconList(3);
            else if (rblWords.SelectedValue == "0")
                ShowLexiconList(0);
        }
    }

    protected void btnYes_Click(object sender, EventArgs e)
    {
        SENTEntities ent = new SENTEntities();

        int lexiconId = (int)Session["lexiconID"];

        Lexicon lexicon = ent.Lexicons.FirstOrDefault(x => x.ID == lexiconId);
        if (lexicon == null)
            return;

        ent.Lexicons.Remove(lexicon);
        ent.SaveChanges();
        ShowLexiconList();

        ShowError("INFORMATION", "You deleted word: " + lexicon.Word + "!");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SENTEntities ent = new SENTEntities();
        string lexiconWord = tbWord.Text;

        bool newLexi = true;

        decimal? rate = Convert.ToDecimal(tbRate.Text);
        if(rate == null)
        {
            lblErrorHeder.Text = "WARNING";
            lblError.Text = "Rate has wrong value!";
            mpeObavestenje.Show();
        }

        Lexicon lexicon = ent.Lexicons.FirstOrDefault(x => x.Word == lexiconWord);

        if (lexicon == null)
            lexicon = new Lexicon();
        else
            newLexi = false;

        lexicon.Word = tbWord.Text;
        lexicon.Rate = rate;

        if (newLexi)        
            ent.Lexicons.Add(lexicon);
        

        ent.SaveChanges();

        tbRate.Text = "";
        tbWord.Text = "";
        ShowLexiconList();

        if (newLexi)
        {
            ShowError("INFORMATION", "You have successfully entered word: "+ lexicon.Word + "!");
        }
        else
        {
            ShowError("INFORMATION", "You have successfully changed word: " + lexicon.Word + "!");
        }
    }

    private void ShowError(string errorTitle, string errorTextBody)
    {
        lblError.Text = errorTextBody;
        lblErrorHeder.Text = errorTitle;
        mpeObavestenje.Show();
    }
}