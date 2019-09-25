<%@ Page Title="Calculation page" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Calculation.aspx.cs" Inherits="Calculation" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %> 



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <br /> 
    <br />
    Tab Calculation omogućava unos dokumenta i izračunavanje njegove ukupne sentiment ocene.  <br /> 
    Unos dokumenta se izvšava na dva načina: unosom teksta u odgovarajuće polje ili upload-om. Dokument je .txt datoteka.
     
   
     <br />
     <br />
        <asp:UpdatePanel ID="UP2" runat="server" UpdateMode="Conditional">
        <ContentTemplate>

           <table>
               <tr>
                   <td>
                       <asp:Label ID="Label1" runat="server" Text="Document title"></asp:Label> 
                      
                     <br />
                       <asp:TextBox ID="tbDocumentTitle" runat="server" MaxLength="150" Width="600px" Height="35px" 
                           Font-Bold="true" Font-Size="15" Placeholder="(max. 150 characters)" /> 
                        <br /> <br />
                   </td>
               </tr>
               <tr>
                   <td>
                       <asp:Label ID="Label2" runat="server" Text="Document text"></asp:Label>
                        
                      <br />
                       <asp:TextBox ID="tbDocumentText" runat="server" MaxLength="50000" Width="600px" Height="350px" 
                           Font-Bold="true" Font-Size="15" TextMode="MultiLine" Placeholder="(max. 50,000 characters)" /> 
                   </td>
               </tr>
           </table>

            <br />
            <br />
            <br />

            <asp:Button ID="btnAnalize" runat="server" Text="Analize" Width="200px" Height="41px" BorderColor="#ffffcc" 
                BorderWidth="2" BackColor="#006600" ForeColor="#ffffff" Font-Bold="True" Font-Size="15pt" OnClick="btnAnalize_Click"/>
             <br />
            <br />
            <br />
            <asp:DataList ID="dlAnalizedDocumets" runat="server" Width="629px">
                <HeaderTemplate>
                     <table>
                        <tr>
                            <td style="width:80%;">
                                <asp:Label ID="htTitle" runat="server" Text="TITLE" Font-Bold="true" />
                            </td>
                            <td></td>
                              <td style="width:20%;">
                                <asp:Label ID="htRate" runat="server" Text="RATE" Font-Bold="true" />
                            </td>
                        </tr>
                    </table>
                </HeaderTemplate>

                <ItemTemplate>
                    <table>
                        <tr>
                             <td style="width:80%;">
                                <asp:Label ID="itTitle" runat="server" Text='<%# Eval("Title") %>' Font-Bold="true" />
                            </td>
                            <td></td>
                             <td style="width:20%;">
                                <asp:Label ID="itRate" runat="server" Text='<%# Eval("Rate") %>' Font-Bold="true" ForeColor="#ffff99" />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>          



             <asp:Button ID="Button1" runat="server" Width="1px" Height="1px" BorderWidth="0" BorderColor="#06067f" Enabled="false" />

  <asp:ModalPopupExtender ID="mpeObavestenje" runat="server" PopupControlID="pnlPUObavestenje" BehaviorID="MPE1" 
         TargetControlID="Button1" CancelControlID="btnOK"  BackgroundCssClass="modalBackground" ClientIDMode="Static" />


        <asp:Panel ID="pnlPUObavestenje" runat="server" CssClass="modalPopupConfirm" Style="display: none" ClientIDMode="Static" >
                <div class="header" style="background-color:#06067f;">
                    <asp:Label ID="lblErrorHeder" runat="server" Text="INFORMATION" />
                </div> 

                  <div class="body" style="text-align:center; padding-left:10px; padding-right:10px;">  <br />
                        <asp:Label ID="lblError" runat="server" ForeColor="Red" Text=""></asp:Label>    <br />
                   </div>

                <div class="footerPU" align="center">  
                 <br />  

                     <asp:Button ID="btnOK" runat="server" Text="OK" Height="35px" 
                        Width="125px" BackColor="#06067f"
                    ForeColor="White" BorderColor="Black" Font-Bold="true" Visible="true"/>
                      <br />
                     <br />

                </div>
          </asp:Panel>

             </ContentTemplate>
            </asp:UpdatePanel>

    
</asp:Content>

