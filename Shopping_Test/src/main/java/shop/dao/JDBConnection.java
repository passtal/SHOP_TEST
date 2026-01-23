package shop.dao;

import java.io.FileReader;
import java.io.Reader;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;

public class JDBConnection {
	
	public Connection con;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs;
	
	public JDBConnection() {
		try {
			ClassLoader classLoader = JDBConnection.class.getClassLoader();
			
			// 1. 경로 가져오기 (여기서 공백이 %20으로 나올 수 있음)
	        String path = classLoader.getResource("").getPath();
	        
	        // [수정] 2. 가져온 경로를 UTF-8로 해석해서 %20을 다시 공백으로 변환
	        String projectRootPath = URLDecoder.decode(path, "UTF-8");
	        
	        // 3. 기존 코드 그대로 유지 (FileReader 사용)
			Reader reader = new FileReader(projectRootPath + "/db.properties");
			Properties properties = new Properties();
			properties.load(reader);
			
			String driver = properties.getProperty("driver");
			String url = properties.getProperty("url");
			String id = properties.getProperty("id");
			String pw = properties.getProperty("pw");
			
			Class.forName(driver);		 
			
			con = DriverManager.getConnection(url, id, pw);
			
			System.out.println("DB 연결 성공");
		} catch (Exception e) {
			System.err.println("DB 연결 실패");
			e.printStackTrace();
		}
	}
}