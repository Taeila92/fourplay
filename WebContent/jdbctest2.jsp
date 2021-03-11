<html>
<head>
<%@ page errorPage="errorpg.jsp"
import="java.sql.*,
javax.sql.*,
java.io.*,
javax.naming.InitialContext,
javax.naming.Context" %>
</head>
<body>
<h1>JDBC JNDI Resource Test</h1>

<%
InitialContext initCtx = new InitialContext();
DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/kim920125");
Connection conn = ds.getConnection();
Statement stmt = conn.createStatement();
ResultSet rset = stmt.executeQuery("select version();");
while (rset.next()) {
out.println("mysql version=="+rset.getString("version()"));
}
rset.close();
stmt.close();
conn.close();
initCtx.close();
%>
</body>
</html>