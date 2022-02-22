package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.RecipeDTO;

public class RecipeDAO {

	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	public Connection getConnection() {

		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/funweb";
		String user = "root";
		String password = "1234";

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return con;

	}

	public void close(Connection con) {
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void close(PreparedStatement pstmt) {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void close(ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public RecipeDTO seleteRecipe() {
		RecipeDTO recipe = null;
		int listCount = 0;
		con = getConnection();

		try {
			String sql = "SELECT COUNT(*) FROM recipe";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				listCount = rs.getInt(1);
				int rNum = (int) (Math.random() * listCount + 1);
				sql = "SELECT * FROM recipe WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rNum);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					recipe = new RecipeDTO();
					recipe.setNum(rs.getInt("num"));
					recipe.setSubject(rs.getString("subject"));
					recipe.setCulture(rs.getString("culture"));
				}
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}

		return recipe;
	}
	
	public ArrayList<RecipeDTO> selectRecipeList(int pageNum, int listLimit, String culture){
		ArrayList<RecipeDTO> list = new ArrayList<RecipeDTO>();
		con = getConnection();
		try {
			int startRow = (pageNum - 1) * listLimit;
			String sql = "SELECT * FROM recipe WHERE culture=? ORDER BY num DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, culture);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				RecipeDTO dto = new RecipeDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setDate(rs.getDate("date"));
				dto.setReadCount(rs.getInt("readCount"));
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return list;
		
	}
	
	public int insertRecipe(RecipeDTO recipeDTO) {
		int insertRecipeCount = 0;
		con = getConnection();
		try {
			int num = 1;
			String sql = "SELECT MAX(num) FROM recipe";
			pstmt= con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1)+1;
				sql = "INSERT INTO recipe VALUES (?,?,?,?,?,now(),0,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, recipeDTO.getName());
				pstmt.setString(3, recipeDTO.getPassword());
				pstmt.setString(4, recipeDTO.getSubject());
				pstmt.setString(5, recipeDTO.getContent());
				pstmt.setString(6, recipeDTO.getCulture());
				insertRecipeCount = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return insertRecipeCount;
	}
	
	public RecipeDTO selectRecipe(int num) {
		RecipeDTO recipeDTO = null;
		con = getConnection();
		try {
			String sql = "SELECT * FROM recipe WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				recipeDTO = new RecipeDTO();
				recipeDTO.setName(rs.getString("name"));
				recipeDTO.setSubject(rs.getString("subject"));
				recipeDTO.setContent(rs.getString("content"));
				recipeDTO.setReadCount(rs.getInt("readcount"));
				recipeDTO.setDate(rs.getDate("date"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return recipeDTO;
	}
	
	public void addReadCount(int num) {
		con = getConnection();
		try {
			String sql = "SELECT readcount FROM recipe WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sql = "UPDATE recipe SET readcount = readcount+1 WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
	}
	
	public int updateRecipe(RecipeDTO recipeDTO) {
		int updateCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT password FROM recipe WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, recipeDTO.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(recipeDTO.getPassword().equals(rs.getString("password")));
					sql = "UPDATE recipe SET subject=?, content=? WHERE num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, recipeDTO.getSubject());
					pstmt.setString(2, recipeDTO.getContent());
					pstmt.setInt(3, recipeDTO.getNum());
					updateCount = pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return updateCount;
	}
	
	public int getListCount(String culture) { // 한 카테고리의 게시물 리스트 출력시
		int listCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT COUNT(*) FROM recipe WHERE culture=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, culture);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return listCount;
		
	}
	
	public int getListCount() { // recipe 테이블의 전체 게시물 리스트 출력시
		int listCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT COUNT(*) FROM recipe";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return listCount;
		
	}
	
	public int deleteRecipe(int num, String password) {
		int deleteCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT password FROM recipe WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (password.equals(rs.getString("password"))) {

					sql = "DELETE FROM recipe WHERE num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					deleteCount = pstmt.executeUpdate();
				}
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}

		return deleteCount;
	}
	
	public ArrayList<RecipeDTO> searchRecipeList(int page, int limit, String search, String searchOption, String culture) {
		ArrayList<RecipeDTO> list = new ArrayList<RecipeDTO>();
		con = getConnection();
		try {

			int startRow = (page - 1) * limit;
			
				if(searchOption.equals("subject") || searchOption.equals("name")) {
					
					String sql = "SELECT * FROM (SELECT * FROM recipe WHERE " +searchOption+ " LIKE ?)a WHERE culture = ? ORDER BY num DESC LIMIT ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+search+"%");
					pstmt.setString(2, culture);
					pstmt.setInt(3, startRow);
					pstmt.setInt(4, limit);
					rs = pstmt.executeQuery();
					
				} else {
					
					String sql = "SELECT * FROM (SELECT * FROM recipe WHERE name LIKE ? OR subject LIKE ?)a WHERE culture = ? ORDER BY num DESC LIMIT ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+search+"%");
					pstmt.setString(2, "%"+search+"%");
					pstmt.setString(3, culture);
					pstmt.setInt(4, startRow);
					pstmt.setInt(5, limit);
					rs = pstmt.executeQuery();
					
				}
				
			while (rs.next()) {
				RecipeDTO dto = new RecipeDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getDate("date"));
				dto.setReadCount(rs.getInt("readcount"));
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}

		return list;
	}
	
	public int getListSearchCount(String search, String searchOption, String culture) {
		int listCount = 0;
		con = getConnection();
		try {
			
			if(searchOption.equals("subject") || searchOption.equals("name")) {
				String sql = "SELECT COUNT(*) FROM recipe WHERE "+searchOption+" LIKE ? AND culture=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setString(2, culture);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					listCount = rs.getInt(1);
					
				}
				
			} else {
				
				String sql = "SELECT COUNT(*) FROM(SELECT * FROM recipe WHERE name LIKE ? OR subject like ?)a WHERE culture = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");;
				pstmt.setString(2, "%"+search+"%");;
				pstmt.setString(3, culture);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					listCount = rs.getInt(1);
				}
				
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return listCount;
		
	}
	
	public int updateNumber() { // 게시물 삭제시 비어있는 글번호의 수정을 위한 글번호 재정렬을 위한 메서드
		int updateNumberCount = 0;
		int changeNum = 1;
		con = getConnection();
		try {
			String sql = "SELECT num FROM recipe";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) { 
				if(rs.getInt("num") == changeNum) {
					changeNum += 1;
				} else if(rs.getInt("num") != changeNum){
					sql = "UPDATE recipe SET num = ? WHERE num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, changeNum);
					pstmt.setInt(2, rs.getInt("num"));
					pstmt.executeUpdate();
					updateNumberCount += 1;
					changeNum += 1;
				}
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		
		return updateNumberCount;
	}
	
	public ArrayList<RecipeDTO> mostViewedRecipes(int start, int limit) {
		con = getConnection();
		RecipeDTO recipedto = null;
		ArrayList<RecipeDTO> list = new ArrayList<RecipeDTO>();
		try {
			String sql = "SELECT * FROM recipe ORDER BY readcount DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, limit);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				recipedto = new RecipeDTO();
				recipedto.setNum(rs.getInt("num"));
				recipedto.setName(rs.getString("name"));
				recipedto.setReadCount(rs.getInt("readcount"));
				recipedto.setCulture(rs.getString("culture"));
				recipedto.setSubject(rs.getString("subject"));
				recipedto.setDate(rs.getDate("date"));
				list.add(recipedto);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		System.out.println(list.size());
		return list;
	}
	

}
