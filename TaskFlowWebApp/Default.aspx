<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TaskFlowWebApp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="container body-content">
        <section class="row" aria-labelledby="aspnetTitle">
            <h1 id="aspnetTitle">TaskFlow-Web Application</h1>
            <p class="lead">TaskFlow is web based application to manage tasks easily in your daily life.</p>
            
        </section>

        <div class="row">
            <section class="col-md-4" aria-labelledby="gettingStartedTitle">
                <h2 id="gettingStartedTitle">Getting started</h2>
                <p>
                    If you have an account, please click on Log in else sign up.
                </p>
                <p>
                    <a class="btn btn-primary" href="LoginPage.aspx">Log In &raquo;</a>
                    <a class="btn btn-primary" href="Signup.aspx">Sign Up &raquo;</a>
                </p>
            </section>
          <%-- <section class="col-md-4" aria-labelledby="librariesTitle">
                <h2 id="librariesTitle">Get more libraries</h2>
                <p>
                    NuGet is a free Visual Studio extension that makes it easy to add, remove, and update libraries and tools in Visual Studio projects.
                </p>
                <p>
                    <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301949">Learn more &raquo;</a>
                </p>
            </section>
            <section class="col-md-4" aria-labelledby="hostingTitle">
                <h2 id="hostingTitle">Web Hosting</h2>
                <p>
                    You can easily find a web hosting company that offers the right mix of features and price for your applications.
                </p>
                <p>
                    <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301950">Learn more &raquo;</a>
                </p>
            </section>--%>
        </div>
    </main>

</asp:Content>
