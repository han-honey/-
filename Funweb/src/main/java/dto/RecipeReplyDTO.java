package dto;

import java.sql.Date;

public class RecipeReplyDTO {
	int num;
	int root_num;
	String id;
	String recipe_reply;
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
	public String getRecipe_reply() {
		return recipe_reply;
	}
	public void setRecipe_reply(String recipe_reply) {
		this.recipe_reply = recipe_reply;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
}
