<%@ Page Title="Lexicon page" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %> 



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br /> 
    <br />
    Tab Lexicon omogućava pregled leksikona, unos novih reči i njihovih sentiment ocena, brisanje i editovanje postojećih. 
    Reči sa pozitivnom konotacijom obojiti zelenom bojom, a reči sa negativnom konotacijom obojiti crvenom bojom. 
    Pomoću filtera se može sužavati skup na samo pozitivne ili samo negativne reči.  
    <br /> 
     <br />
     <br />
        <asp:UpdatePanel ID="UP2" runat="server" UpdateMode="Conditional">
        <ContentTemplate>


    <asp:RadioButtonList ID="rblWords" runat="server" Font-Bold="true" Font-Size="14" AutoPostBack="true" RepeatDirection="Horizontal"
         OnSelectedIndexChanged="rblWords_SelectedIndexChanged" Width="368px"  >
        <asp:ListItem Value="0" Text="all" />
        <asp:ListItem Value="1" Text="positive" />
        <asp:ListItem Value="2" Text="negative" />
        <asp:ListItem Value="3" Text="neutral" />        
    </asp:RadioButtonList>
    <br />
    <br />
      <table style="background-color:#c2051f; width:700px;">
             <tr>
                 <td style="text-align:center; vertical-align:middle; padding-top:5px;">
                     <asp:Label ID="Label1" runat="server" Text="ID" Font-Bold="true" Width="70" Height="26" />
                 </td>
                 <td></td>
                 <td style="text-align:center; vertical-align:middle; padding-top:5px;">
                     <asp:Label ID="Label2" runat="server" Text="WORD" Font-Bold="true" Width="200" Height="26" /> 

                 </td>
                  <td></td>
                 <td style="text-align:center; vertical-align:middle; padding-top:5px;">
                     <asp:Label ID="Label3" runat="server" Text="RATE" Font-Bold="true" Width="120" Height="26" />

                 </td>
                 <td></td>
                 <td style="text-align:center; vertical-align:middle; padding-top:5px;">
                     <asp:Label ID="Label4" runat="server" Text="EDIT" Font-Bold="true" Width="120" Height="26" />
                 </td>
                 <td></td>
                 <td style="text-align:center; vertical-align:middle; padding-top:5px;">
                     <asp:Label ID="Label5" runat="server" Text="DELETE" Font-Bold="true" Width="140" Height="26" />

                 </td>
                 <td></td>

             </tr>
         </table>
     <div class="skrol">
 <asp:GridView  ID="gvLexiconList" runat="server" AutoGenerateColumns="False" Font-Size="12px"
        BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" 
        CellPadding="4" CellSpacing="2" ForeColor="Black" Height="316px" ShowHeader="false"
         Width="699px" OnRowCommand="gvLexiconList_RowCommand" OnRowDataBound="gvLexiconList_RowDataBound">
  <Columns>

        <asp:BoundField DataField="ID" HeaderText="ID">
               <HeaderStyle HorizontalAlign="Center" Width="90px" />     
            <ItemStyle HorizontalAlign="Center" Font-Bold="true" Font-Size="14" />
        </asp:BoundField>      
      
       <asp:BoundField DataField="Word" HeaderText="WORD">
            <HeaderStyle Width="300px" />
            <ItemStyle HorizontalAlign="Left" Font-Bold="true" Font-Size="13"  />
      </asp:BoundField>

      <asp:BoundField DataField="Rate" HeaderText="RATE">
      <HeaderStyle Width="120px" />
       <ItemStyle HorizontalAlign="Center" Font-Bold="true" Font-Size="14"  />
      </asp:BoundField>
       
       <asp:ButtonField HeaderText="EDIT" Text="Edit" CommandName="EditRow">
       <HeaderStyle HorizontalAlign="Center" Width="120px" />
       <ItemStyle HorizontalAlign="Center" ForeColor="Blue" Font-Size="13" />
       </asp:ButtonField>

        <asp:ButtonField HeaderText="DELETE" Text="Delete" CommandName="DeleteRow">
            <HeaderStyle HorizontalAlign="Center" Width="120px" />
            <ItemStyle HorizontalAlign="Center" ForeColor="Blue" Font-Size="13" />
       </asp:ButtonField> 
       </Columns>

       <FooterStyle BackColor="#CCCCCC" />
       <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" Font-Size="12pt" />
       <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
       <RowStyle BackColor="White" />
       <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
       <SortedAscendingCellStyle BackColor="#F1F1F1" />
       <SortedAscendingHeaderStyle BackColor="Gray" />
       <SortedDescendingCellStyle BackColor="#CAC9C9" />
       <SortedDescendingHeaderStyle BackColor="#383838" />
       </asp:GridView>       
       </div>

      <br />
     <br />
    <table>
        <tr>
            <td>
                <asp:Label ID="Label6" runat="server" Text="Word" Font-Bold="true" Font-Size="15" />
            </td>
            <td></td>
            <td>
                <asp:TextBox ID="tbWord" runat="server" Width="271px" Height="30px" MaxLength="50" />
            </td>
              <td></td>
             <td>
                <asp:Label ID="Label7" runat="server" Text="Rate" Font-Bold="true" Font-Size="15" />
            </td>
            <td></td>
            <td>
                <asp:TextBox ID="tbRate" runat="server" Width="116px" Height="30px" MaxLength="5" />
            </td>
              <td></td>
            <td>
                <asp:Button ID="btnSave" runat="server" Text="Save" Width="200" Height="36" BorderColor="#ffffff" BackColor="#0000ff" ForeColor="#ffffff"
                    Font-Bold="true" Font-Size="14" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
    <br />
     <br />

             <asp:Button ID="Button1" runat="server" Width="1px" Height="1px" BorderWidth="0" BorderColor="#06067f" Enabled="false" />

  <asp:ModalPopupExtender ID="mpeObavestenje" runat="server" PopupControlID="pnlPUObavestenje" BehaviorID="MPE1" 
         TargetControlID="Button1" CancelControlID="btnOK"  BackgroundCssClass="modalBackground" ClientIDMode="Static" />


        <asp:Panel ID="pnlPUObavestenje" runat="server" CssClass="modalPopupConfirm" Style="display: none" ClientIDMode="Static" >
                <div class="header" style="background-color:#06067f;">
                    <asp:Label ID="lblErrorHeder" runat="server" Text="INFORMATION"></asp:Label>
                </div> 

                  <div class="body" style="text-align:center; padding-left:10px; padding-right:10px;">
               <br />
                  <asp:Label ID="lblError" runat="server" ForeColor="Red" Text=""></asp:Label>
                      <br /> 
                      
                   </div>

                <div class="footerPU" align="center">  
                 <br />  

                     <asp:Button ID="btnOK" runat="server" Text="OK" Height="35px" 
                        Width="125px" BackColor="#06067f"
                    ForeColor="White" BorderColor="Black" Font-Bold=true Visible="true"/>
                      <br />
                     <br />

                </div>
          </asp:Panel>


     <asp:Button ID="Button2" runat="server" Width="1px" Height="1px" BorderWidth="0" BorderColor="#06067f" Enabled="false" /> 
           

  <asp:ModalPopupExtender ID="mpeBrisi" runat="server" PopupControlID="pnlBrisi" BehaviorID="MPE2" 
         TargetControlID="Button2" CancelControlID="btnNe"  BackgroundCssClass="modalBackground" ClientIDMode="Static" />


        <asp:Panel ID="pnlBrisi" runat="server" CssClass="modalPopupConfirm" Style="display: none" ClientIDMode="Static" >
                <div class="header" style="background-color:#06067f;">
                    <asp:Label ID="Label8" runat="server" Text="WARNING"></asp:Label>
                </div> 

                  <div class="body" style="text-align:center; padding-left:10px; padding-right:10px;">
               <br />
                  <asp:Label ID="lblPitanjeBrisi" runat="server" ForeColor="Red" Text="Are you sure?" Visible="true" />
                      <br /> 
                      
                   </div>

                <div class="footerPU" align="center">  
                 <br />  

      <asp:Button ID="btnYes" runat="server" Text="Yes" Height="35px" Width="125px" BackColor="#06067f"
            ForeColor="White" BorderColor="Black" Font-Bold="true" Visible="true" onclick="btnYes_Click"  />

                    <asp:Button ID="btnNe" runat="server" Text="No" Height="35px" Width="125px" BackColor="White"
            ForeColor="#06067f" BorderColor="Black" Font-Bold="true" Visible="true"/>
                      <br />
                     <br />

                </div>
          </asp:Panel>
            </ContentTemplate>
            </asp:UpdatePanel>

   


      <br />
     <br />

      <br />
     <br />

    
</asp:Content>

