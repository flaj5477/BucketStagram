package co.bucketstargram.dto;

public class BucketDto {
	private String bucketId = null; // PRIMARY KEY, NOT NULL
	private String bucketMemberId = null; // NOT NULL
	private String bucketTitle = null;// NOT NULL
	private String bucketContents = null;// NOT NULL
	private String bucketType = null;// NOT NULL
	private String bucketCompliation = null;// DEFAULT 'challenging'
	private int bucketLike = 0;
	private String bucketImagePath = null;
	private String bucketTag = null;
	private String bucketWriteDate = null;
	private String bucketLiketYN = null;
	private int bucketReplyCnt = 0;
	private int bucketRowCnt = 0;
	
	public BucketDto() {
		// TODO Auto-generated constructor stub
	}
	public BucketDto(String bucketId, String bucketMemberId, String bucketTitle, String bucketContents,String bucketType) {
		this.bucketId = bucketId;
		this.bucketMemberId = bucketMemberId;
		this.bucketTitle = bucketTitle;
		this.bucketContents = bucketContents;
		this.bucketType = bucketType;
	}
	public String getBucketLiketYN() {
		return bucketLiketYN;
	}
	public void setBucketLiketYN(String bucketLiketYN) {
		this.bucketLiketYN = bucketLiketYN;
	}
	public String getBucketId() {
		return bucketId;
	}
	public void setBucketId(String bucketId) {
		this.bucketId = bucketId;
	}
	public String getBucketMemberId() {
		return bucketMemberId;
	}
	public void setBucketMemberId(String bucketMemberId) {
		this.bucketMemberId = bucketMemberId;
	}
	public String getBucketTitle() {
		return bucketTitle;
	}
	public void setBucketTitle(String bucketTitle) {
		this.bucketTitle = bucketTitle;
	}
	public String getBucketContents() {
		return bucketContents;
	}
	public void setBucketContents(String bucketContents) {
		this.bucketContents = bucketContents;
	}
	public String getBucketType() {
		return bucketType;
	}
	public void setBucketType(String bucketType) {
		this.bucketType = bucketType;
	}
	public String getBucketCompliation() {
		return bucketCompliation;
	}
	public void setBucketCompliation(String bucketCompliation) {
		this.bucketCompliation = bucketCompliation;
	}
	public int getBucketLike() {
		return bucketLike;
	}
	public void setBucketLike(int bucketLike) {
		this.bucketLike = bucketLike;
	}
	public String getBucketImagePath() {
		return bucketImagePath;
	}
	public void setBucketImagePath(String bucketImagePath) {
		this.bucketImagePath = bucketImagePath;
	}
	public String getBucketTag() {
		return bucketTag;
	}
	public void setBucketTag(String bucketTag) {
		this.bucketTag = bucketTag;
	}
	public String getBucketWriteDate() {
		return bucketWriteDate;
	}
	public void setBucketWriteDate(String bucketWriteDate) {
		this.bucketWriteDate = bucketWriteDate;
	}
	public int getBucketReplyCnt() {
		return bucketReplyCnt;
	}
	public void setBucketReplyCnt(int bucketReplyCnt) {
		this.bucketReplyCnt = bucketReplyCnt;
	}
	
	public int getBucketRowCnt() {
		return bucketRowCnt;
	}
	public void setBucketRowCnt(int bucketRowCnt) {
		this.bucketRowCnt = bucketRowCnt;
	}
}
