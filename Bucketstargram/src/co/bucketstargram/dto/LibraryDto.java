package co.bucketstargram.dto;

import java.util.ArrayList;

public class LibraryDto {
	private String libId = null;
	private String libTitle = null;
	private String libContents = null;
	private String libType = null;
	private String libImagePath = null;
	private int libLike = 0;
	private ArrayList<String> libLikeMembList = null;
	private String libWriteDate = null;
	
	public LibraryDto() {
		super();
	}
	
	
	public ArrayList<String> getLibLikeMembList() {
		return libLikeMembList;
	}


	public void addLibLikeMembList(String likeMemb) {
		this.libLikeMembList.add(likeMemb);
	}
	
	public String getLibId() {
		return libId;
	}
	public void setLibId(String libId) {
		this.libId = libId;
	}
	public String getLibTitle() {
		return libTitle;
	}
	public void setLibTitle(String libTitle) {
		this.libTitle = libTitle;
	}
	public String getLibContents() {
		return libContents;
	}
	public void setLibContents(String libContents) {
		this.libContents = libContents;
	}
	public String getLibType() {
		return libType;
	}
	public void setLibType(String libType) {
		this.libType = libType;
	}
	public String getLibImagePath() {
		return libImagePath;
	}
	public void setLibImagePath(String libImagePath) {
		this.libImagePath = libImagePath;
	}
	public int getLibLike() {
		return libLike;
	}
	public void setLibLike(int libLike) {
		this.libLike = libLike;
	}
	public String getLibWriteDate() {
		return libWriteDate;
	}
	public void setLibWriteDate(String libWriteDate) {
		this.libWriteDate = libWriteDate;
	}
}
