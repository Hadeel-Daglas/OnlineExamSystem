package dbconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	private static final String jdbcDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static final String jdbcURL = "jdbc:sqlserver://localhost:1433;instanceName=WIN;databasename=ExamOnlineSystem;integratedSecurity=true";

	public DBConnection() {

	}

	public static Connection getConnection() throws Exception {
		try {
			Class.forName(jdbcDriver);
		} catch (Exception err) {
			err.printStackTrace(System.err);
			System.exit(0);
		}
		Connection databaseConnection = null;
		try {
			databaseConnection = DriverManager.getConnection(jdbcURL);
		}

		catch (SQLException err) {
			err.printStackTrace(System.err);
			System.exit(0);
		}

		return databaseConnection;
	}
}
