<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaskPage.aspx.cs" MasterPageFile="~/Site.Master" Inherits="TaskFlowWebApp.TaskPage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="rcorners2">

        <div id="rcorners3" style="float:left; display:flex; flex-direction: column; align-items: center;" >
             <div id="profilePic" onclick="openFileInput()" style="
               width:100px;
               height:100px;
               border-radius:50%;
               border:2px solid #000;
               background-image: url('logo.jpg');
               background-size: cover;
               background-position: center;
               cursor: pointer;
           "></div>


              <div id="usernameID" style="margin-top:10px;"><asp:Label ID="username" runat="server" Text=""></asp:Label></div>
              <br /><br /><br /><br /><br /><br />

              <div class="parent-container">
               <div >
                <button style='font-size:18px; display:inline-block; color:black' > <i class="fa-solid fa-plus"></i> Add Task </button> 
                <button style='font-size:18px; display:inline-block; color:black' runat="server" onserverclick="GoToAllTask" > <i class="fa-solid fa-house" ></i>  All Tasks </button>              
                <button style='font-size:18px; display:inline-block; color:black' runat="server" onserverclick="GoToCompleteTask"> <i class="fa-solid fa-check"></i>  Complete </button>
                <button style='font-size:18px; display:inline-block; color:black' runat="server" onserverclick="GoToIncompleteTask"> <i class="fa-solid fa-list-ul"></i> Incomplete </button>
                                               
                <br>
                 <br><br><br><br><br>
                <button style='font-size:24px; color:black' runat="server" onserverclick="SignOut">Sign out <i class="fa-solid fa-right-from-bracket"></i></button>
              </div>
            </div>
    
        </div>
        <div id="stylebox">

            <div>

                 <h1 style="font-family:'Bookman Old Style'; margin-bottom:50px">Create Task</h1>
          
                 <%-- Adding Task Process--%>
                 <asp:Button ID="btnAddTask" runat="server" cssClass="btn btn-outline-success" Text="Add Task" OnClientClick="ShowAddTaskBox(); return false;" OnClick="btnAddTask_Click" />
       		      

               <%-- Listview for showing list of task--%>
                <asp:ListView ID="lvTasks" runat="server">
                    <ItemTemplate>
                        <div class="task-item" style="display: flex; align-items: center;">
                            
                            <h4 style="font-family:'Comic Sans MS'; margin-right:10px; margin-bottom:10px; margin-top:10px;">Task: </h4>
                            <h4 style="margin-right: 35px; font-family:'Comic Sans MS'; margin-bottom:10px; margin-top:10px"> <%# Eval("Title") %></h4>
                           <asp:Button ID="showTask" runat="server" cssClass="btn btn-success" Text="Show Task Details" data-bs-toggle="modal" data-bs-target="#myModal" CommandArgument='<%# Eval("id") %>' OnClick="showTask_Click" />              
                   
                        </div>
                    </ItemTemplate>
                </asp:ListView>


                <%--Add Task popup and handler--%>
               <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
                    TargetControlID="btnAddTask"
                    PopupControlID="pnlAddTask"
                    BackgroundCssClass="modalBackground"
                    DropShadow="true">
                </ajaxToolkit:ModalPopupExtender>


                <asp:Panel ID="pnlAddTask" runat="server" BackColor="LightSteelBlue" BorderWidth="10px"   BorderStyle="Inset"  cssClass="modal-xl roundPanel" Style="display: none; min-width:350px">
           
                  <div id="task-popup" class="popup">
                    <div class="popup-content">
                        <h2 style="text-align:center; font-family:Andalus">Add Task</h2>

                        <div style="margin-left:20px; font-family:Andalus; font-size:x-large">
                          <asp:Label ID="taskTitleLabel" For="taskTitle" Text="Title: " runat="server" />
                          <asp:TextBox ID="txtTaskTitle" placeholder="Max character limit is 255." TextMode="MultiLine" runat="server" class="form-control" />          

                          <br /><asp:Label ID="taskDescriptionLabel" For="taskDescription" Text="Description: " runat="server" />
                          <asp:TextBox ID="txtDescription" placeholder="Max character limit is 500." TextMode="MultiLine" runat="server" class="form-control" />
                   

                            <br /><asp:Label ID="taskDateLabel" For="taskDate" Text="Due Date: " runat="server" />
                          <asp:TextBox ID="txtTaskDate" style="margin-bottom:20px" TextMode="date" runat="server" class="form-control" />
                   
                        </div>
                    </div>
                  </div>
                    <div style="text-align-last:center">
                       <asp:Button ID="btnSubmitTask" runat="server" cssClass="btn btn-outline-secondary" Text="Add Task" style="margin-right:20px; margin-bottom:10px" OnClick="btnSubmitTask_Click" />
                       <asp:Button ID="btnCancelTask" runat="server" cssClass="btn btn-outline-danger" Text="Cancel" style="margin-bottom:10px" OnClick="CancelTaskDetails" OnClientClick="$find('<%= ModalPopupExtender1.ClientID %>').hide(); return false;" />
                    </div>
                 </asp:Panel>
            </div>
        </div>

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
    <input type="file" id="fileInput" accept="image/*" style="display: none;" onchange="previewImage(event)" />
            <script>
                function openFileInput() {
                    document.getElementById('fileInput').click();
                }

                function previewImage(event) {
                    const input = event.target;

                    if (input.files && input.files[0]) {
                        const reader = new FileReader();

                        reader.onload = function (e) {
                            const profilePic = document.getElementById('profilePic');
                            profilePic.style.backgroundImage = url('${e.target.result}');
                        };

                        reader.readAsDataURL(input.files[0]);
                    }
                }
            </script>
            
</asp:Content>

