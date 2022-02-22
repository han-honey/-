package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.MemberDTO;

/*
 * 1. 회원가입 MemberDAO 메서드명 : insertMember()
 * 
 */

public class MemberDAO {
	
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

	public int insertMember(MemberDTO dto) {

		Connection con = getConnection();
		int insertCount = 0;
		String sql = "INSERT INTO member VALUES (?,?,?,NOW(),?,?,?,?)";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPassword());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getMobile());
			pstmt.setString(6, dto.getAddress());
			pstmt.setString(7, dto.getPhone());

			insertCount = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		System.out.println(insertCount);
		return insertCount;
	}

	public boolean checkUser(String id, String password) {
		boolean isLoginSuccess = false;

		con = getConnection();
		String sql = "SELECT * FROM member WHERE id=? AND pass=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				isLoginSuccess = true;
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		System.out.println(isLoginSuccess);
		return isLoginSuccess;

	}

	public MemberDTO selectMember(String id) {
		MemberDTO dto = null;

		Connection con = getConnection();

		String sql = "SELECT * FROM member WHERE id=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new MemberDTO();
				dto.setId(id);
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getDate("date"));
				dto.setEmail(rs.getString("email"));
				dto.setMobile(rs.getString("mobile"));
				dto.setAddress(rs.getString("address"));
				dto.setPhone(rs.getString("phone"));
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

	public ArrayList<MemberDTO> selectMemberList() {
		ArrayList<MemberDTO> memberList = new ArrayList<MemberDTO>();

		con = getConnection();

		String sql = "SELECT * FROM member";
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setDate(rs.getDate("date"));
				dto.setEmail(rs.getString("email"));
				dto.setMobile(rs.getString("mobile"));
				dto.setAddress(rs.getString("address"));
				dto.setPhone(rs.getString("phone"));
				memberList.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류!");
			e.printStackTrace();
		}

		return memberList;
	}

	public int updateMemberInfo(MemberDTO dto) {
		int updateCount = 0;
		con = getConnection();

		try {
			String sql = "SELECT pass FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			rs = pstmt.executeQuery();
//			close(pstmt); // 닫으면 안되고 안닫으면 됌
			if (rs.next()) {
				if (dto.getPassword().equals(rs.getString("pass"))) {
					
					sql = "UPDATE member SET name=?, email=?, mobile=?, address=?, phone=? WHERE id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, dto.getName());
					pstmt.setString(2, dto.getEmail());
					pstmt.setString(3, dto.getMobile());
					pstmt.setString(4, dto.getAddress());
					pstmt.setString(5, dto.getPhone());
					pstmt.setString(6, dto.getId());

					updateCount = pstmt.executeUpdate();
				}
			}
		} catch (SQLException e) {
			System.out.println("SQL 문법 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return updateCount;

	}
	
	public boolean checkDupleId(String beforeId) {
		boolean isCheckedCount = false;
		con = getConnection();
		try {
			String sql = "SELECT id FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, beforeId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				isCheckedCount = true;
				}
		} catch (SQLException e) {
			System.out.println("SQL 문법 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return isCheckedCount;
	}
	
	public int deleteMember(String id, String password) {
		int deleteCount = 0;
		con = getConnection();

		try {
			String sql = "SELECT pass FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if (password.equals(rs.getString("pass"))) {
					
					sql = "DELETE FROM member WHERE id = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					deleteCount = pstmt.executeUpdate();
				}
			}
		} catch (SQLException e) {
			System.out.println("SQL 문법 오류!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return deleteCount;

	}

}
















