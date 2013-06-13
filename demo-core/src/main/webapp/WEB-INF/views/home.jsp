<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
</head>
 
<body>
<div id="header">
<H2>
    Hello
</H2>
</div>
 
You can go here too if you'd have something : <a href="<%= request.getContextPath() %>/foo">Foo</a>
</body>

</html>  