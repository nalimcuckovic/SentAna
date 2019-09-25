using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Calculation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ShowAnalizedDocumets();
        }
    }

    private void ShowAnalizedDocumets()
    {
        SENTEntities ent = new SENTEntities();
        List<TextDocument> list = ent.TextDocuments.ToList();

        if(list.Count > 0)
        {
            dlAnalizedDocumets.DataSource = list;
            dlAnalizedDocumets.DataBind();
        }
        else
        {
            dlAnalizedDocumets.Visible = false;
        }

    }

    protected void btnAnalize_Click(object sender, EventArgs e)
    {
        SENTEntities ent = new SENTEntities();
        List<Lexicon> wordsInLexicon = ent.Lexicons.ToList();
        List<TextDocument> textDocumentList = ent.TextDocuments.ToList();

        string title = tbDocumentTitle.Text;
        string text = tbDocumentText.Text;
        string[] words = text.Split(' ');
        decimal rateDocument = 0;

        if(title.Count() < 3)
        {
            ShowError("WARNING", "You must input title!");
            return;
        }
        else if (text.Count() < 10)
        {
            ShowError("WARNING", "You must input text!");
            return;
        }


        if (textDocumentList.Any(x => x.Title == title))
        {
            ShowError("WARNING", "This title already exists!"); 
            return;
        }
        else if (textDocumentList.Any(x => x.Text == text))
        {
            ShowError("WARNING", "This text already exists!"); 
            return;
        }

        foreach (var word in words)
        {
            foreach(var keyWord in wordsInLexicon)
            {
                if(word == keyWord.Word)
                {
                    rateDocument = rateDocument + (decimal)keyWord.Rate;
                }
            }
        }

        TextDocument newTextDocument = new TextDocument();
        newTextDocument.Text = text;
        newTextDocument.Title = tbDocumentTitle.Text.Trim(); 
        newTextDocument.Rate = rateDocument;

        ent.TextDocuments.Add(newTextDocument);
        ent.SaveChanges();

        ShowError("INFORMATION", "This text has been rated " + rateDocument);

        ShowAnalizedDocumets();
    }

    private void ShowError(string errorTitle, string errorTextBody)
    {
        lblError.Text = errorTextBody;
        lblErrorHeder.Text = errorTitle;
        mpeObavestenje.Show();
    }
}