package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.ComplainDTO;

public class ComplainDAO {

	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	public Connection getConnection() {

		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/funweb?autoReconnect=true";
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
	public int maxNum() {
		int num = 1;
		con = getConnection();
		try {
			
			String sql = "SELECT Max(num) from complain";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
					num = rs.getInt(1) + 1;
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		}
		return num;
	}
	
	public void updateNums(int num) {
		con = getConnection();
		try {
			String sql = "UPDATE complain SET groupOrd = groupOrd +1, groupLayer = groupLayer + 1 WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		}
		
	}
	
	
	public int insertComplain(ComplainDTO dto) {
		int insertCount = 0;
		int num = maxNum();
		con = getConnection();

		try {
				String sql = "INSERT INTO complain VALUES (?,?,0,0,?,?,?,?,now(),0)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setInt(2, num);
				pstmt.setString(3, dto.getName());
				pstmt.setString(4, dto.getPassword());
				pstmt.setString(5, dto.getSubject());
				pstmt.setString(6, dto.getContent());

				insertCount = pstmt.executeUpdate();
				
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}

		return insertCount;

	}

	public ArrayList<ComplainDTO> selectComplainList(int page, int limit) {
		ArrayList<ComplainDTO> list = new ArrayList<ComplainDTO>();
		con = getConnection();
		try {
			// 시작행 계산!
			int startRow = (page - 1) * limit;
			String sql = "SELECT * FROM complain ORDER BY originNO DESC, groupOrd ASC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ComplainDTO dto = new ComplainDTO();
				dto.setNum(rs.getInt("num"));
				dto.setOriginNO(rs.getInt("originNO"));
				dto.setGroupOrd(rs.getInt("groupOrd"));
				dto.setGroupLayer(rs.getInt("groupLayer"));
				dto.setSubject(rs.getString("subject"));
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getDate("date"));
				dto.setReadCount(rs.getInt("readcount"));
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

	public ComplainDTO selectComplain(int num) {
		ComplainDTO dto = null;
		con = getConnection();
		try {
			String sql = "UPDATE complain SET readcount = readcount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

			sql = "SELECT * FROM complain WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new ComplainDTO();
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getDate("date"));
				dto.setReadCount(rs.getInt("readcount"));
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

	public int deleteComplain(int num, String password) {
		int deleteCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT password FROM complain WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (password.equals(rs.getString("password"))) {

					sql = "DELETE FROM complain WHERE num=?";
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
	
	public int updateComplain(ComplainDTO dto) {
		int updateCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT password FROM complain WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(dto.getPassword().equals(rs.getString("password")));
					sql = "UPDATE complain SET subject=?, content=? WHERE num=?";
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
			String sql = "SELECT COUNT(*) FROM complain";
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
	
	public ArrayList<ComplainDTO> searchComplainList(int page, int limit, String search, String searchOption) {
		ArrayList<ComplainDTO> list = new ArrayList<ComplainDTO>();
		con = getConnection();
		try {
			// 시작행 계산!
			int startRow = (page - 1) * limit;
			
				if(searchOption.equals("subject") || searchOption.equals("name")) {
					
					String sql = "SELECT * FROM complain WHERE " +searchOption+ " LIKE ? ORDER BY num DESC LIMIT ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+search+"%");
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, limit);
					rs = pstmt.executeQuery();
					
				} else {
					
					String sql = "SELECT * FROM complain WHERE subject LIKE ? OR name LIKE ? ORDER BY num DESC LIMIT ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+search+"%");
					pstmt.setString(2, "%"+search+"%");
					pstmt.setInt(3, startRow);
					pstmt.setInt(4, limit);
					rs = pstmt.executeQuery();
					
				}
				
			while (rs.next()) {
				ComplainDTO dto = new ComplainDTO();
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
	
	public int getListSearchCount(String search, String searchOption) {
		int listCount = 0;
		con = getConnection();
		try {
			
			if(searchOption.equals("subject") || searchOption.equals("name")) {
				
				String sql = "SELECT COUNT(*) FROM complain WHERE "+searchOption+" LIKE ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");;
				rs = pstmt.executeQuery();
				if(rs.next()) {
					listCount = rs.getInt(1);
					
				}
				
			} else {
				
				String sql = "SELECT COUNT(*) FROM complain WHERE subject LIKE ? OR name LIKE ?";
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
			String sql = "SELECT num FROM complain";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) { 
				if(rs.getInt("num") == changeNum) {
					changeNum += 1;
				} else if(rs.getInt("num") != changeNum){
					sql = "UPDATE complain SET num = ? WHERE num = ?";
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
	
	public int insertComplainQnA(ComplainDTO dto) {
		int insertQnACount = 0;
		con = getConnection();
		int num = maxNum();
		
		try {
			
			String sql = "INSERT INTO complain VALUES (?,?,?,?,?,?,?,?,now(),0)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setInt(2, dto.getOriginNO());
			pstmt.setInt(3, dto.getGroupOrd());
			pstmt.setInt(4, dto.getGroupLayer());
			pstmt.setString(5, dto.getName());
			pstmt.setString(6, dto.getPassword());
			pstmt.setString(7, dto.getSubject());
			pstmt.setString(8, dto.getContent());
			
			insertQnACount = pstmt.executeUpdate();
			updateNums(num);
			

		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!!");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}

		return insertQnACount;

	}
	
	
	
}
