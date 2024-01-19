<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="TaskFlowWebApp.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title" class="container body-content">
        <%-- %><h2 id="title"><%: Title %>.</h2> --%>
        <h3><br />Contact Us.</h3>
        <address>
            <br /><br />123 Sesame Street<br />
            Cambridge, ON N19 4L9<br />
            <abbr title="Phone">P:</abbr>
            519-420-0000
        </address>

        <address>
            <strong>Support:</strong>   <a href="mailto:Support@TaskFlow.com">Support@TaskFlow.com</a><br />
            <strong>Marketing:</strong> <a href="mailto:Marketing@TaskFlow.com">Marketing@TaskFlow.com</a>
        </address>
        <br /><br /><br />
        
        <br /><br /><br /><br /><br /><br />
    </main>
</asp:Content>
