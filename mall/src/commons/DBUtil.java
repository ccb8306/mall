package commons;
import java.sql.*;

public class DBUtil {
	// db����
	public Connection getConnection()throws Exception{	
		String driver = "org.mariadb.jdbc.Driver";
		String dbid = "root";
		String dbpw = "java1004";
		String dbaddr = "jdbc:mariadb://ahmo.kro.kr:3306/mall";
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(dbaddr,dbid,dbpw);	
		return conn;
	}
	
}
