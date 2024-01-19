<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" MasterPageFile="~/Site.Master" Inherits="TaskFlowWebApp.Signup" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
     <div class="container">
         <br /><br /><br /><br />
         <div style="text-align:center">
             <asp:Label ID="signUp" runat="server" Text="Sign Up" style="font-family:'Bell MT'; font-size:xx-large; text-align:center" ></asp:Label>  
             <br /><br />
             <table style="margin: auto;">
                 <tr>
                     <td><asp:Label ID="namelabel" runat="server" Text="Name: "></asp:Label></td>
                     <td>
                         <asp:TextBox ID="username" runat="server"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="NameRequiredValidator" runat="server"
                             ControlToValidate="username"
                             ErrorMessage="Name is required"
                             Display="Dynamic"
                             ValidationGroup="SignUpGroup"
                             SetFocusOnError="true">
                         </asp:RequiredFieldValidator>
                     </td>
                 </tr>
                 <tr>
                     <td><asp:Label ID="emaillabel" runat="server" Text="Email: "></asp:Label></td>
                     <td>
                         <asp:TextBox ID="useremail" runat="server"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="EmailRequiredValidator" runat="server"
                             ControlToValidate="useremail"
                             ErrorMessage="Email is required"
                             Display="Dynamic"
                             ValidationGroup="SignUpGroup"
                             SetFocusOnError="true">
                         </asp:RequiredFieldValidator>
                         <asp:RegularExpressionValidator ID="EmailValidator" runat="server"
                             ControlToValidate="useremail"
                             ErrorMessage="Invalid email format"
                             ValidationExpression="\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b"
                             Display="Dynamic"
                             ValidationGroup="SignUpGroup"
                             SetFocusOnError="true">
                         </asp:RegularExpressionValidator>
                     </td>
                 </tr>
                 <tr>
                     <td><asp:Label ID="passwordlabel" runat="server" Text="Password: "></asp:Label></td>
                     <td>
                         <asp:TextBox ID="userpassword" TextMode="Password" runat="server"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="PasswordRequiredValidator" runat="server"
                             ControlToValidate="userpassword"
                             ErrorMessage="Password is required"
                             Display="Dynamic"
                             ValidationGroup="SignUpGroup"
                             SetFocusOnError="true">
                         </asp:RequiredFieldValidator>
                          <asp:CustomValidator ID="PasswordValidator" runat="server"
                             ControlToValidate="userpassword"
                             ErrorMessage="Password must contain special characters, numbers, and letters and should not be empty"
                             Display="Dynamic"
                             ValidationGroup="LoginGroup"
                             OnServerValidate="ValidatePassword">
                          </asp:CustomValidator>
                     </td>
                 </tr>
                 <tr>
                     <td><asp:Label ID="confirmPLabel" runat="server" Text="Confirm Password: "></asp:Label></td>
                     <td>
                         <asp:TextBox ID="passwordConfirm" TextMode="Password" runat="server"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="ConfirmPasswordRequiredValidator" runat="server"
                            ControlToValidate="passwordConfirm"
                            ErrorMessage="Confirm Password is required"
                            Display="Dynamic"
                            ValidationGroup="SignUpGroup"
                            SetFocusOnError="true">
                         </asp:RequiredFieldValidator>
                         <asp:CompareValidator ID="PasswordCompareValidator" runat="server"
                             ControlToValidate="passwordConfirm"
                             ControlToCompare="userpassword"
                             ErrorMessage="Passwords do not match"
                             Display="Dynamic"
                             ValidationGroup="SignUpGroup"
                             SetFocusOnError="true">
                         </asp:CompareValidator>
                     </td>
                 </tr>
                 <tr>
                     <td colspan="2" style="text-align:center">
                         <asp:Button ID="CAbtn" runat="server" style="margin-top:10px"  CssClass="btn btn-info" Text="Create an Account" OnClick="CreateAccount_Click" ValidationGroup="SignUpGroup" />
                     </td>
                 </tr>
             </table>
             <asp:Label ID="CreatedAccountMessage" runat="server" Text=""></asp:Label>

             <p style="text-align:center" class="center">Already have an account? <a href="LoginPage.aspx">Login</a></p>
         </div>
     </div>
 </main>
</asp:Content>
