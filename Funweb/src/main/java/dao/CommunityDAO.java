package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.CommunityDTO;

public class CommunityDAO {
	
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

	public int insertCommunity(CommunityDTO dto) {
		int insertCount = 0;
		con = getConnection();

		String sql = "SELECT Max(num) from community";
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			int num = 1;

			if (rs.next()) {
//			num = rs.getInt("MAX(num)");
				num = rs.getInt(1) + 1;

				sql = "INSERT INTO community VALUES (?,?,?,?,?,now(),0)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, dto.getName());
				pstmt.setString(3, dto.getPassword());
				pstmt.setString(4, dto.getSubject());
				pstmt.setString(5, dto.getContent());

				insertCount = pstmt.executeUpdate();

			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}

		return insertCount;

	}

	public ArrayList<CommunityDTO> selectCommunityList(int page, int limit) {
		ArrayList<CommunityDTO> list = null;
		con = getConnection();
		try {
			// 시작행 계산!
			int startRow = (page - 1) * limit;
			String sql = "SELECT * FROM community ORDER BY num DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			rs = pstmt.executeQuery();
			
			list = new ArrayList<CommunityDTO>();
			
			while (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getDate("date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setContent(rs.getString("content"));
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

	public CommunityDTO selectCommunity(int num) {
		CommunityDTO dto = null;
		con = getConnection();
		try {
			String sql = "UPDATE community SET readcount = readcount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

			sql = "SELECT * FROM community WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new CommunityDTO();
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getDate("date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}

		return dto;
	}

	public int deleteCommunity(int num, String password) {
		int deleteCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT password FROM community WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (password.equals(rs.getString("password"))) {

					sql = "DELETE FROM community WHERE num=?";
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
	
	public int updateCommunity(CommunityDTO dto) {
		int updateCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT password FROM community WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(dto.getPassword().equals(rs.getString("password")));
					sql = "UPDATE community SET subject=?, content=? WHERE num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, dto.getSubject());
					pstmt.setString(2, dto.getContent());
					pstmt.setInt(3, dto.getNum());
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
	
	public int getListCount() {
		int listCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT COUNT(*) FROM community";
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
	
	public ArrayList<CommunityDTO> searchCommunityList(int page, int limit, String search, String searchOption) {
		ArrayList<CommunityDTO> list = new ArrayList<CommunityDTO>();
		con = getConnection();
		try {
			// 시작행 계산!
			int startRow = (page - 1) * limit;
			
				if(searchOption.equals("subject") || searchOption.equals("name")) {
					
					String sql = "SELECT * FROM community WHERE " +searchOption+ " LIKE ? ORDER BY num DESC LIMIT ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+search+"%");
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, limit);
					rs = pstmt.executeQuery();
					
				} else {
					
					String sql = "SELECT * FROM community WHERE subject LIKE ? OR name LIKE ? ORDER BY num DESC LIMIT ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+search+"%");
					pstmt.setString(2, "%"+search+"%");
					pstmt.setInt(3, startRow);
					pstmt.setInt(4, limit);
					rs = pstmt.executeQuery();
					
				}
				
			while (rs.next()) {
				CommunityDTO dto = new CommunityDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getDate("date"));
				dto.setReadcount(rs.getInt("readcount"));
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
	
	public int getListSearchCount(String search, String searchOption) {
		int listCount = 0;
		con = getConnection();
		try {
			
			if(searchOption.equals("subject") || searchOption.equals("name")) {
				
				String sql = "SELECT COUNT(*) FROM community WHERE "+searchOption+" LIKE ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");;
				rs = pstmt.executeQuery();
				if(rs.next()) {
					listCount = rs.getInt(1);
					
				}
				
			} else {
				
				String sql = "SELECT COUNT(*) FROM community WHERE subject LIKE ? OR name LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");;
				pstmt.setString(2, "%"+search+"%");;
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
			String sql = "SELECT num FROM community";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) { 
				if(rs.getInt("num") == changeNum) {
					changeNum += 1;
				} else if(rs.getInt("num") != changeNum){
					sql = "UPDATE community SET num = ? WHERE num = ?";
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

}
