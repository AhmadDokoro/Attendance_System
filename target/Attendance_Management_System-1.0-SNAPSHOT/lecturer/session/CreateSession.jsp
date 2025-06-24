<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.*" %>

<%
    Lecturer lecturer = (Lecturer) session.getAttribute("lecturer");
    if (lecturer == null) {
        response.sendRedirect("../Login.jsp");
        return;
    }

    List<Group> courseGroups = (List<Group>) request.getAttribute("courseGroups"); // set from servlet
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create New Session</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f5f7fa;
            padding: 40px;
            margin: 0;
        }

        .form-container {
            background: #eae9e9;
            max-width: 700px;
            margin: auto;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        h2 {
            color: #0034de;
            text-align: center;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        select {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 1rem;
        }

        .submit-btn {
            background: linear-gradient(135deg, #0034de, #006eff);
            color: white;
            padding: 14px;
            border: none;
            border-radius: 10px;
            width: 100%;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s ease;
        }
        input{
            width: 96%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 1rem;
        }

        .submit-btn:hover {
            background: linear-gradient(135deg, #002bb5, #0055dd);
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Create a New Class Session</h2>
    <form method="post" action="${pageContext.request.contextPath}/SaveSession">

        <!-- Combined Course + Group Dropdown -->
        <label for="group_id">Select Course & Group</label>
        <select id="group_id" name="group_id" required style="width: 100%; padding: 12px; font-size: 1rem; border-radius: 8px; margin-bottom: 20px;">
            
            <option disabled selected>-- Select Course & Group --</option>
            <% if (courseGroups != null) {
                for (Group g : courseGroups) { %>
                    <option value="<%= g.getGroupId() %>,<%= g.getCourseCode() %>">
                        <%= g.getCourseCode() %> - <%= g.getCourseName() %> (Group <%= g.getGroupName() %>)
                    </option>
            <%  }} %>
        </select>


        <!-- Location -->
        <label for="location">Class Location</label>
        <input type="text" id="location" name="location" placeholder="class location" required />

        <!-- Program Type -->
        <label for="program_type">Program Type</label>
        <select id="program_type" name="program_type" required>
            <option disabled selected>-- Select Type --</option>
            <option value="Class">Class</option>
            <option value="Lab">Lab</option>
            <option value="Field Study">Field Study</option>
        </select>

        <!-- Duration -->
        <label for="duration">Duration (Hours)</label>
        <select id="duration" name="duration" required>
            <option disabled selected>-- Select Duration --</option>
            <% for (int i = 1; i <= 5; i++) { %>
                <option value="<%= i %>"><%= i %> Hour<%= (i > 1) ? "s" : "" %></option>
            <% } %>
        </select>
        <button type="submit" class="submit-btn">Create</button>
    </form>
</div>

</body>
</html>
