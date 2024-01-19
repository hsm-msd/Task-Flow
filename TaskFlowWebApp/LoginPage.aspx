<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" MasterPageFile="~/Site.Master" Inherits="TaskFlowWebApp.LoginPage" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

        <main>
        <div class="container">
            <div class="header" style="margin-top:200px; text-align:center;">
     <asp:Label ID="Label3" runat="server"  style="font-family:'Bell MT'; font-size:xx-large;">Login</asp:Label>
            </div><br><br>
            <div style="text-align:center">
                <asp:Label ID="EmailEntry" runat="server" Text="Email:"></asp:Label>
                <asp:TextBox ID="email" runat="server" style="margin-left:25px; margin-bottom:20px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="EmailRequiredValidator" runat="server"
                    ControlToValidate="email"
                    ErrorMessage="Email is required"
                    Display="Dynamic"
                    ValidationGroup="LoginGroup"
                    SetFocusOnError="true">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="EmailValidator" runat="server"
                    ControlToValidate="email"
                    ErrorMessage="Invalid email format"
                    ValidationExpression="\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b"
                    Display="Dynamic"
                    ValidationGroup="LoginGroup"
                    SetFocusOnError="true">
                </asp:RegularExpressionValidator>
            </div>

            <div style="text-align:center">
                <asp:Label ID="Label2" runat="server" Text="Password:" ></asp:Label>
                <asp:TextBox ID="password" textmode="Password" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                    ControlToValidate="password"
                    ErrorMessage="Password is required"
                    Display="Dynamic"
                    ValidationGroup="LoginGroup"
                    SetFocusOnError="true">
</asp:RequiredFieldValidator>
            </div>
                <div style="text-align:center; margin-top:10px" >
                <asp:Label ID="InvalidLogin" runat="server" Text="" class=" alert-warning"></asp:Label>
                </div>
            <div style="text-align:center">
                <asp:Button ID="Button1" runat="server" style="margin-top:20px" CssClass="btn btn-info" Text="Login"  OnClientClick="if (!Page_ClientValidate('LoginGroup')) { return false; }" onclick="GoToWelcomePage" ValidationGroup="LoginGroup" />

            </div>

            <p style="text-align:center">Don't have an account? <a href="Signup.aspx">Sign up</a>.</p>
        </div>
    
    </main>
</asp:Content>
