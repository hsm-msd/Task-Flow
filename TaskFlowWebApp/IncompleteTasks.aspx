<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IncompleteTasks.aspx.cs" MasterPageFile="~/Site.Master" Inherits="TaskFlowWebApp.IncompleteTasks" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="rcorners2">

        <div id="rcorners3" style="float:left; display:flex; flex-direction: column; align-items: center;" >
             <div id="profilePic" style="
                  width:100px;
                  height:100px;
                  border-radius:50%;
                  border:0px solid #000;
                  background-image: url('logo.jpg');
                  background-size: cover;
                  background-position: center;
              "></div>
            <div id="usernameID" style="margin-top:10px;"><asp:Label ID="username" runat="server" Text=""></asp:Label></div>
            <br /><br /><br /><br /><br /><br />
            <div class="parent-container">
             <div >
                <button style='font-size:18px; display:inline-block; color:black' runat="server" onserverclick="GoToAddTask"> <i class="fa-solid fa-plus"></i>  Add task </button>
                <button style='font-size:18px; display:inline-block; color:black' runat="server" onserverclick="GoToAllTask"> <i class="fa-solid fa-house" ></i>  All Tasks </button>              
                <button style='font-size:18px; display:inline-block; color:black' runat="server" onserverclick="GoToCompleteTask"> <i class="fa-solid fa-check"></i>  Complete </button>
                <button style='font-size:18px; display:inline-block; color:black' > <i class="fa-solid fa-list-ul"></i> Incomplete </button>
                 
                              
                <br>
                 <br><br><br><br><br>
                <button style='font-size:24px; color:black' runat="server" onserverclick="SignOut">Sign out <i class="fa-solid fa-right-from-bracket"></i></button>
            </div>
            </div>
    
        </div>

        <div id="stylebox">
            <h1 style="font-family:'Bookman Old Style'; " >Incomplete Tasks</h1><br />
            <asp:Button ID="Button1" runat="server" Text="Click me to see Incomplete tasks" OnClick="ShowIncompleteTasks" class="btn btn-info" style="margin-bottom:10px;" />
               <asp:ListView ID="lvTasks" runat="server">
                    <ItemTemplate >
                       
                        <div class="task-item container mt-3" style="display: flex; align-items: center;" >
                            
                                    <h4 style="font-family:'Comic Sans MS'; margin-right:10px; margin-bottom:10px; margin-top:10px;">Task: </h4>
                                    <h4 style="margin-right: 35px; font-family:'Comic Sans MS'; margin-bottom:10px; margin-top:10px"> <%# Eval("Title") %></h4>
                                     
                                   
                                <asp:Button ID="showTask" runat="server" Text="Show Task Details" data-bs-toggle="modal" data-bs-target="#myModal"
                                       CommandArgument='<%# Eval("id") %>' OnClick="ShowTask_click" class="btn btn-secondary"/>              
                                    <asp:Button ID="deleteTask" runat="server" Text="Delete Task" OnClientClick="return confirm('Are you sure you want to delete this task?');"
                                     CommandArgument='<%# Eval("id") %>' OnClick="deleteTask_Click" class="btn btn-danger" style="margin-left:10px" />
                              
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            <div >
              <br/><asp:Label ID="LabelNoTask" style="font-family:Impact; font-size:x-large" runat="server" Text=""></asp:Label>
             </div>
         
            <div>
       
                 <asp:HiddenField ID="IsButtonClicked" runat="server" />
                     <%-- Handle Show Task popup --%>
                <asp:Button ID="dummyButton" runat="server" style="display: none;" />
                <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender2" runat="server"
                    TargetControlID="dummyButton"
                    PopupControlID="taskDetail"
                    BackgroundCssClass="modalBackground"
                    DropShadow="true">
                </ajaxToolkit:ModalPopupExtender>-

                <asp:Panel ID="taskDetail" runat="server"  BackColor="LightSteelBlue"  BorderStyle="Ridge"  cssClass="modal-sm" Style="display: none; min-width:300px">
                    <div cssClass="modal " >
                      <div cssClass="modal-dialog" >
                          <div cssClass="modal-content">
                              <div cssClass="modal-header">
                                  <h3 style="font-family:'Bell MT'">Title</h3>
                                    <asp:Label ID="Ttitle" runat="server" CssClass="modal-header" Text=""></asp:Label><br />
          
                              </div>
                              <div cssClass="modal-body">
                                  <h3 style="font-family:'Bell MT'; margin-top:10px">Description</h3>
                                    <asp:Label ID="Tdescription" runat="server" Text=""></asp:Label><br />
                                  <h3 style="font-family:'Bell MT'; margin-top:20px">Due Date</h3>
                                    <asp:Label ID="Tduedate" runat="server" Text=""></asp:Label><br />
                                  <h3 style="font-family:'Bell MT'; margin-top:10px">Status</h3>
                                    <asp:Label ID="Tstatus" runat="server" Text=""></asp:Label><br />
                               </div>
                              <div cssClass="modal-footer" style="text-align:right; margin-right:20px; ">
                                    <asp:Button ID="goBack" runat="server" cssClass="btn btn-outline-danger" style="font-size:larger;" Text="Close" OnClientClick="$find('<%= ModalPopupExtender2.ClientID %>').hide(); return false" />
                              </div>
                           </div>
                      </div>
                    </div>
                </asp:Panel>
        
        
            </div>
        </div>
    </div>
            
</asp:Content>