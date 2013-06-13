<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
  <head>
    <title>Login</title>


  </head>

  <body onload="document.f.j_username.focus();">
    <h1>To access this feature, you need to login</h1>
 
   <c:if test="${not empty param['error']}"> 
		    <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}" /> 
	</c:if> 
 
    <form id="reset-form" action="<%= request.getContextPath() %>/authenticate" method="POST">
	    <form:errors path="*" cssClass="errorblock" element="div" />
      <table>
        <tr><td>User:</td><td><input type='text' name='j_username' value=''/></td></tr>
        <tr><td>Password:</td><td><input type='password' name='j_password' value=''/></td></tr>
        <tr><td colspan='2'><input name="submit" type="submit"></td></tr>
        <tr><td colspan='2'><input name="reset" type="reset"></td></tr>
        
        <a href="<%= request.getContextPath() %>/resetPassword">Reset Password</a>
        <a href="<%= request.getContextPath() %>/newUser">New User</a>
      </table>

    </form>


  </body>
</html>
