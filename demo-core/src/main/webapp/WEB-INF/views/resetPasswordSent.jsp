<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
  <head>
    <title>Password reset</title>

    <script type="text/javascript" src="https://www.google.com/jsapi?key=ABQIAAAAiRnI39gW-hIxUgL_OQLmCRQGCTt7unRE4iokDwBRaJeSOI8HVRQyQwsLBUscU1XFztbkTP0Wvt0_qA"></script>
<script type="text/javascript">
google.load("jquery", "1.7.1");
    google.load("jqueryui", "1.8");
</script>

  </head>

  <body>
  	Password reset link has been sent. Check your mail. 
  	<a href="<%= request.getContextPath() %>/login">Login</a>;
						 
   </body>
</html>
