<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication1.WebForm1" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Task Management</title>
    <style type="text/css">
        .modalPopup {
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 10px;
            width: 300px;
        }

        .modalBackground {
            background-color: #000;
            opacity: 0.7;
        }
    </style>
    <script type="text/javascript">
        function ShowAddTaskBox() {
            $find('<%= ModalPopupExtender1.ClientID %>').show();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="ScriptManager1" />
        <div>
            <asp:Button ID="btnAddTask" runat="server" Text="Add Task" OnClientClick="ShowAddTaskBox(); return false;" OnClick="btnAddTask_Click" />
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
                TargetControlID="btnAddTask"
                PopupControlID="pnlAddTask"
                BackgroundCssClass="modalBackground"
                DropShadow="true">
            </ajaxToolkit:ModalPopupExtender>
            <asp:Panel ID="pnlAddTask" runat="server" CssClass="modalPopup" Style="display: none;">
                <asp:Label ID="lblTitle" runat="server" Text="Add Task" CssClass="modalTitle" />
                <br />
                <asp:Label ID="lblTaskTitle" runat="server" Text="Task Title:" />
                <br />
                <asp:TextBox ID="txtTaskTitle" runat="server" CssClass="textbox" />
                <br />
                <asp:Label ID="lblDescription" runat="server" Text="Description:" />
                <br />
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3" CssClass="textbox" />
                <br />
                <asp:Label ID="lblTaskDate" runat="server" Text="Task Date:" />
                <br />
                <asp:TextBox ID="txtTaskDate" runat="server" CssClass="textbox" ReadOnly="true" />
                <asp:Calendar ID="Calendar2" runat="server" AutoPostBack="false" OnSelectionChanged="Calendar2_SelectionChanged"></asp:Calendar>
                <asp:Button ID="btnSubmitTask" runat="server" Text="Add Task" OnClientClick="return btnSubmitTask_Click();" />
                <asp:Button ID="btnCancelTask" runat="server" Text="Cancel" OnClientClick="$find('<%= ModalPopupExtender1.ClientID %>').hide(); return false;" />
            </asp:Panel>
        </div>
    </form>
</body>
</html>

