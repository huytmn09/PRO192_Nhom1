/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ATM;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;  
import java.util.Scanner;


class DConection{
    
     public static Connection getConnection(String DB_URL, String USER_NAME, String PASSWORD){
     
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/BIG_Assignment", "root", "");
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        
        return con;
    }

}

class login{
    private static final String DB_URL = "jdbc:mysql://localhost:3306/BIG_Assignment";
    private static final String USER_NAME = "root";
    private static final String PASSWORD = "";
    
    public login() {
    }
    
    public static int loginUser() throws SQLException,NullPointerException,ClassNotFoundException{
        Connection conn = DConection.getConnection(DB_URL, USER_NAME, PASSWORD);
        Statement stmt = conn.createStatement();
        int status = 0;
        ResultSet rs = stmt.executeQuery("SELECT /*users.id, card_id,pin,contact_number,gender,address,users.name,role_id*/ *from users join user_role on users.id= user_id");
        // show data
        rs.next();
        Scanner input = new Scanner(System.in);
        System.out.println("Enter CARD ID:");
        int CardID = input.nextInt();
        System.out.println("Enter PIN:");
        int Pin = input.nextInt();
        if (CardID == rs.getInt(2) && Pin == rs.getInt(3)) {
            status = rs.getInt(8);
        }
        return status;
    }

}

/**
 *
 * @author DELL
 */
public class ATM{

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        //login user1 = new login();
        boolean check=false;
        do{
        try {
                System.out.println("Card ID or Pin Incorrect !!");
            switch (login.loginUser()) {
                case 1:
                    System.out.println("Admin login successfully!");
                    break;
                case 2:
                    System.out.println("User login !!");
                    break;
                case 3:
                    System.out.println("Exit.");
                    break;
                default:
                    System.out.println("Card ID or PIN incorrect !!");
                    System.out.println("");
                    check=true;
                    break;
            }
        } catch (SQLException | NullPointerException | ClassNotFoundException ex) {
            System.out.println("Can't connect database.");
        }
        }while(check);
    }   
}
