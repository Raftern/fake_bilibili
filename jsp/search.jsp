<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="com.mysql.cj.jdbc.Driver" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLDecoder"%>
    <%
    
        String searchText = request.getParameter("searchText");
        if(searchText!=null){
            searchText=URLDecoder.decode(searchText,"UTF-8");
        }
        
        
   //     String searchText = "转";
        String cmower = String.join("", searchText, "%");
        cmower = String.join("", "%", cmower);
   //     out.println(cmower);
        String [] id = new String[10];
        String [] name=new String[20];
        String [] description =new String[20];
        String [] image = new String[100];
        int zs=0;
        Class.forName("com.mysql.cj.jdbc.Driver");                                          //加载数据库驱动
        String url = "jdbc:MySQL://localhost:3306/lesson?characterEncoding=utf-8"; //指向数据库table1
        String username1 = "root";  //数据库用户名
        String password1 = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username1, password1);  //连接数据库
        if(conn!=null){
            Statement stmt = null;
            ResultSet rs = null;
            String sql ="select * from animation where anim_name like '"+cmower+"' ";  //查询语句
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                  id[zs]=rs.getString("anim_id");
                  name[zs]=rs.getString("anim_name");
                  description[zs]=rs.getString("anim_description");
                  image[zs]=rs.getString("anim_image");
                  zs++;
                  //将数据库表格查询结果输出
            }
        }
    %>

<%
    out.println("[");
    for(int i=0;i<zs;i++){
        out.println("{");
        out.println("\"id\":\""+id[i]+"\"");
        out.println(",\"name\":\""+name[i]+"\"");
        out.println(",\"description\":\""+description[i]+"\"");
        out.println(",\"image\":\""+image[i]+"\"");
        out.println("}");
        if(i!=zs-1){
            out.println(",");
        }
    }
    out.println("]");
%>
