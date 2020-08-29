import java.sql.*;
import java.lang.*;
import java.util.*;

public class lb7 {

    public static void executeQuery6(Statement stat){
        String query = "update warehouse\n" +
                "set w_supplierkey = 'Supplier#000000003'\n" +
                "where w_supplierkey = 'Supplier#000000001'";



        try {
            stat.executeUpdate(query);

            query = "select w_supplierkey from warehouse";

            ResultSet rst  = stat.executeQuery(query);

            while (rst.next()) {
                String W_supp = rst.getString("w_supplierkey");
                System.out.println(W_supp);
            }
        }
        catch(SQLException e){
            System.err.println(e);
        }
    }

    public static void executeQuery5(Statement stat){
        Scanner scanner = new Scanner(System.in);
        System.out.print("Nation: ") ;
        String name = scanner.nextLine();

        String query = "select w_name from warehouse where w_nationkey = '"+ name +"'\n" +
                "group by w_name\n" +
                "order by w_capacity desc";
        try {
            ResultSet rst = stat.executeQuery(query);

            while (rst.next()) {
                String W_name = rst.getString("w_name");
                System.out.println(W_name);
            }
        }
        catch(SQLException e){
            System.err.println(e);
        }
    }

    public static void executeQuery4(Statement stat){

    }

    public static void executeQuery3(Statement stat){
        Scanner scanner = new Scanner(System.in);
        System.out.print("maximumCap: ") ;

        String max = scanner.nextLine();

        String query = "select w_name\n" +
                "from warehouse, nation, region \n" +
                "where r_name = 'Europe' and r_regionkey = n_regionkey and n_nationkey = w_nationkey " +
                " and w_capacity < " + max;

        try {
            ResultSet rst = stat.executeQuery(query);



            while (rst.next()) {
                String w_name = rst.getString("w_name");
                System.out.println(w_name);
            }
        }
        catch(SQLException e){
            System.err.println(e);
        }

    }

    public static void executeQuery2(Statement stat){
        try {
            String query = "select max(w_capacity) as maximum\n" +
                    "from warehouse";
            ResultSet rst = stat.executeQuery(query);

            System.out.println(rst.getString("maximum"));
        }

        catch(SQLException e){
            System.err.println(e);
        }
    }

    public static void executeQuery1(Statement stat){

    }

    public static void setInput(Statement stat){//part3
        try {
            Scanner scanner = new Scanner(System.in);
            System.out.print("Name: ") ;
            String name = scanner.nextLine();

            System.out.print("Supplier: ");
            String supp = scanner.nextLine();

            System.out.print("capacity: ");
            int cap = scanner.nextInt();

            System.out.print("Address: ");
            String adrs1 = scanner.nextLine();//skip
            String adrs = scanner.nextLine();

            System.out.print("Nation: ");
            String nation = scanner.nextLine();

            String query1 = "SELECT COUNT(w_warehousekey) as total FROM warehouse";
            ResultSet rst = stat.executeQuery(query1);

            int count = rst.getInt("total");
            count++;

            String  query = "INSERT INTO warehouse " +
                    " (w_warehousekey, w_name, w_supplierkey, w_capacity, w_address, w_nationkey)"
                    + " values('" + count + "','" + name + "', '" + supp + "', '"  +
                    cap + "', '" + adrs +  "', '" + nation + "')";
            System.out.println(query);
            stat.executeUpdate(query);

        }

        catch (SQLException e){
            System.err.println(e);
        }
    }

    public static void mkTbl(Statement stat){//part 2
        try {
            String query;
            query = "CREATE TABLE warehouse" +
                    "(w_warehousekey decimal(3,0) not null," +
                    "w_name char(25) not null," +
                    "w_supplierkey decimal(2,0) not null," +
                    "w_capacity decimal(6,2) not null," +
                    "w_address varchar(40) not null," +
                    "w_nationkey decimal(2,0) not null)";

            stat.executeUpdate(query);
        }

        catch(SQLException e) {
            System.err.println(e);
        }
    }

    public static void main(String[] args){
        Connection connection = null;
        try {
            connection = DriverManager.getConnection("jdbc:sqlite:/Users/richard/Dropbox/CSE111/lab7/lab7/src/TPCH.db");
            Statement stat = connection.createStatement();
            System.out.println(connection);
            stat.setQueryTimeout(30);
            mkTbl(stat);
            setInput(stat);
            /*executeQuery1(stat);*/
            executeQuery2(stat);
            executeQuery3(stat);
            /*executeQuery4(stat);
            */executeQuery5(stat);
            executeQuery6(stat);

        }
        catch(SQLException e) {
            System.err.println(e);
        }

        finally {
            try {
                if (connection != null)
                    connection.close();
            }
            catch(SQLException e)
            {
                // connection close failed.
                System.err.println(e.getMessage());
            }
        }
    }
}
