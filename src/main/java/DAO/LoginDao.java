/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;


import Model.*;
import java.sql.*;
public class LoginDao {
    
    //my connection object
    public static Connection getConnection()
    {
        Connection conn = null;
        
       try{
           
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AttendanceManagementSystem","root","Ahmadakd003");
            
       }catch(Exception e){
           System.out.println(e.getMessage());
       }
       return conn;
    }
    
    //Student function
    public static Student verifyStudent(Student student)
    {
        Student stud = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String matric = student.getMatric();
        String password = student.getPassword();
        
        try{
            String query = "Select * from Student where matric_number = ? And password = ?";
            con = LoginDao.getConnection();
            
            ps = con.prepareStatement(query);
            ps.setString(1, matric);
            ps.setString(2, password);
            
            rs = ps.executeQuery();
            if(rs.next())
            {
                stud = new Student();
                stud.setId(rs.getInt("student_id"));
                stud.setMatric(rs.getString("matric_number"));
                stud.setName(rs.getString("name"));
            }
            
        }catch(SQLException e){
            e.printStackTrace();
        }finally{
            try{
                //close all connections
                if(con != null) con.close();
                if(ps != null) ps.close();
                if(rs != null) rs.close();
            }catch(SQLException e){
                e.printStackTrace();
            }
        }
        return stud;
    }
    
    
    
    
    //lecturer function
    public static Lecturer verifyLecturer(Lecturer lecturer)
    {
        Lecturer lec = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String email = lecturer.getEmail();
        String password = lecturer.getPassword();
        
        try{
            String query = "Select * from lecturer where email = ? And password = ?";
            con = LoginDao.getConnection();
            
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            
            rs = ps.executeQuery();
            if(rs.next())
            {
                lec = new Lecturer();
                lec.setId(rs.getInt("lecturer_id"));
                lec.setName(rs.getString("name"));
                lec.setEmail(rs.getString("email"));
            }
            
        }catch(SQLException e){
            e.printStackTrace();
        }finally{
            try{
                //close all connections
                if(con != null) con.close();
                if(ps != null) ps.close();
                if(rs != null) rs.close();  
            }catch(SQLException e){
                e.printStackTrace();
            }
        }
        return lec;
    }
    
    
    
        public static int hasPendingRequests(int lecturerId) {
        int count = 0;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String query = "SELECT COUNT(*) AS total FROM leaverequest WHERE lecturer_id = ? AND status = 'Pending'";
            con = LoginDao.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, lecturerId);
            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return count;
    }
}
