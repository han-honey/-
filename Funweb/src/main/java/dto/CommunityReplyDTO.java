package dto;

import java.sql.Date;

public class CommunityReplyDTO {
	int num, root_num;
	String id, community_reply;
	Date date;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	
	public int getRoot_num() {
		return root_num;
	}
	public void setRoot_num(int root_num) {
		this.root_num = root_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCommunity_reply() {
		return community_reply;
	}
	public void setCommunity_reply(String community_reply) {
		this.community_reply = community_reply;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	

}
