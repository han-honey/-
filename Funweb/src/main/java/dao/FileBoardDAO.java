package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.FileBoardDTO;

public class FileBoardDAO {

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
	
	public int insertFileBoard(FileBoardDTO fileBoard) {
		int insertCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT MAX(num) FROM File_Board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int num = 1;
			
			if(rs.next()) {
				num = rs.getInt(1)+1;
				
				sql = "INSERT INTO file_board VALUES(?,?,?,?,?,?,?,now(),0)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, fileBoard.getName());
				pstmt.setString(3, fileBoard.getPassword());
				pstmt.setString(4, fileBoard.getSubject());
				pstmt.setString(5, fileBoard.getContent());
				pstmt.setString(6, fileBoard.getOriginal_file());
				pstmt.setString(7, fileBoard.getFile());
				
				insertCount = pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			System.out.println();
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		return insertCount;
	}
	
	// 게시물 전체 갯수 조회를 위한 getListCount() 메서드 정의
	// => 파라미터 : 없음   리턴타입 : int(listCount)
	public int getListCount() {
		int listCount = 0;
		con = getConnection();
		// 원하는 컴럼의 갯수를 조회하려면 COUNT(컬럼명 또는 *) 함수 사용
		try {
			String sql = "SELECT COUNT(*) FROM file_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				listCount = rs.getInt("COUNT(*)"); // 또는 (1)
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
	
	public int getListSearchCount(String search) {
		int listCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT COUNT(*) FROM file_board WHERE subject LIKE ? ORDER BY num DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
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
	
	public int getListSearchCount(String search, String searchOption) {
		int listCount = 0;
		con = getConnection();
		try {
			
			if(searchOption.equals("subject") || searchOption.equals("name")) {
				
				String sql = "SELECT COUNT(*) FROM file_board WHERE "+searchOption+" LIKE ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");;
				rs = pstmt.executeQuery();
				if(rs.next()) {
					listCount = rs.getInt(1);
					
				}
				
			} else {
				
				String sql = "SELECT COUNT(*) FROM file_board WHERE subject LIKE ? OR name LIKE ?";
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
	
//	public ArrayList<FileBoardDTO> selectFileBoardList() {
//		ArrayList<FileBoardDTO> fileBoardList = null;
//		con = getConnection();
//		try {
//			String sql = "SELECT * FROM file_board ORDER BY num DESC";
//			pstmt = con.prepareStatement(sql);
//			rs = pstmt.executeQuery();
//				fileBoardList = new ArrayList<FileBoardDTO>();
//			while(rs.next()) {
//				FileBoardDTO dto = new FileBoardDTO();
//				dto.setNum(rs.getInt("num"));
//				dto.setName(rs.getString("name"));
//				dto.setSubject(rs.getString("subject"));
////				dto.setContent(rs.getString("content"));
////				dto.setOriginal_file(rs.getString("original_file"));
////				dto.setFile(rs.getString("file"));
//				dto.setDate(rs.getDate("date"));
//				dto.setReadcount(rs.getInt("readcount"));
//				fileBoardList.add(dto);
//			}
//		} catch (SQLException e) {
//			System.out.println("SQL 구문 오류!");
//			e.printStackTrace();
//		} finally {
//			close(rs);
//			close(pstmt);
//			close(con);
//		}
//		
//		return fileBoardList;
//	}
	
	// 게시물 목록 조회를 위한 selectFileBoardList() 메서드 정의 => 페이징 처리 추가
	public ArrayList<FileBoardDTO> selectFileBoardList(int page, int limit) {
		ArrayList<FileBoardDTO> fileBoardList = null;
		con = getConnection();
		try {
			// 현재 페이지에서 조회할 레코드의 첫번째 행번호 계산
			// 1페이지일때 0, 2페이지일 때 10, 3페이지일때 20
			// => (현재페이지번호 - 1) * 페이지 당 게시물 수
			int startRow = (page - 1) * limit;
			
			// LIMIT 절 뒤의 파라미터는 시작 행번호, 레코드 수를 지정
			String sql = "SELECT * FROM file_board ORDER BY num DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			rs = pstmt.executeQuery();
			
			fileBoardList = new ArrayList<FileBoardDTO>();
			
			while(rs.next()) {
				FileBoardDTO dto = new FileBoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
//				dto.setOriginal_file(rs.getString("original_file"));
//				dto.setFile(rs.getString("file"));
				dto.setDate(rs.getDate("date"));
				dto.setReadcount(rs.getInt("readcount"));
				fileBoardList.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return fileBoardList;
	}
	
	public FileBoardDTO selectFileBoard(int num) {
		FileBoardDTO fileBoardDTO = null;
		con = getConnection();
		
		try {
			readcount(num);
			String  sql = "SELECT * FROM file_board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				fileBoardDTO = new FileBoardDTO();
				fileBoardDTO.setName(rs.getString("name"));
				fileBoardDTO.setDate(rs.getDate("date"));
				fileBoardDTO.setReadcount(rs.getInt("readcount"));
				fileBoardDTO.setSubject(rs.getString("subject"));
				fileBoardDTO.setContent(rs.getString("content"));
				fileBoardDTO.setOriginal_file(rs.getString("original_file"));
				fileBoardDTO.setFile(rs.getString("file"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		
		
		
		return fileBoardDTO;
	}
	
	public void readcount(int num) {
		con = getConnection();
		try {
			String sql = "UPDATE file_board SET readcount = readcount + 1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL(readcount) 구문 오류!");
			e.printStackTrace();
		}
				
	}
	
	public int updateFileBoard(FileBoardDTO dto) {
		int updateCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT password FROM file_board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(dto.getPassword().equals(rs.getString("password")));
					sql = "UPDATE file_board SET subject=?, content=?, original_file=?, file=? WHERE num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, dto.getSubject());
					pstmt.setString(2, dto.getContent());
					pstmt.setString(3, dto.getOriginal_file());
					pstmt.setString(4, dto.getFile());
					pstmt.setInt(5, dto.getNum());
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
	
	public int deleteFileBoard(int num, String password) {
		int deleteCount = 0;
		con = getConnection();
		try {
			String sql = "SELECT password FROM file_board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (password.equals(rs.getString("password"))) {

					sql = "DELETE FROM file_board WHERE num=?";
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
	
	// 게시물 목록 조회를 위한 selectFileBoardList() 메서드 정의 => 페이징 처리 추가
	// => 파라미터 : 페이지번호(page), 페이지당 게시물 수(listLimit)
	public ArrayList<FileBoardDTO> searchFileBoardList(int page, int limit, String search, String searchOption){
		ArrayList<FileBoardDTO> list = new ArrayList<FileBoardDTO>();
		con = getConnection();
		
		try {
			
			int startRow = (page - 1) * limit;
			
			if(searchOption.equals("subject") || searchOption.equals("name")) {
				
				String sql = "SELECT * FROM file_board WHERE " + searchOption + " LIKE ? ORDER BY num LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, limit);
				rs = pstmt.executeQuery();
			
			} else {
				
				String sql = "SELECT * FROM file_board WHERE subject LIKE ? or name LIKE ? ORDER BY num LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				pstmt.setString(2, "%"+search+"%");
				pstmt.setInt(3, startRow);
				pstmt.setInt(4, limit);
				rs = pstmt.executeQuery();
			}		
			
			while(rs.next()) {
				FileBoardDTO dto = new FileBoardDTO();
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
	
	public int updateNumber() { // 게시물 삭제시 비어있는 글번호의 수정을 위한 글번호 재정렬을 위한 메서드
		int updateNumberCount = 0;
		int changeNum = 1;
		con = getConnection();
		try {
			String sql = "SELECT num FROM file_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) { 
				if(rs.getInt("num") == changeNum) {
					changeNum += 1;
				} else if(rs.getInt("num") != changeNum){
					sql = "UPDATE file_board SET num = ? WHERE num = ?";
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
