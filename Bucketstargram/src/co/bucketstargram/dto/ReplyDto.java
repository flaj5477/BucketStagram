package co.bucketstargram.dto;

public class ReplyDto {
	private String reReplyId;
	private String reMemberId;
	private String reBucketId;
	private String reReplyContents;
	private String reWriteDate;
	public ReplyDto() {
		// TODO Auto-generated constructor stub
	}
	public String getReReplyId() {
		return reReplyId;
	}
	public void setReReplyId(String reReplyId) {
		this.reReplyId = reReplyId;
	}
	public ReplyDto(String reMemberId, String reBucketId, String reReplyContents) {
		super();
		this.reMemberId = reMemberId;
		this.reBucketId = reBucketId;
		this.reReplyContents = reReplyContents;
	}
	public String getReMemberId() {
		return reMemberId;
	}
	public void setReMemberId(String reMemberId) {
		this.reMemberId = reMemberId;
	}
	public String getReBucketId() {
		return reBucketId;
	}
	public void setReBucketId(String reBucketId) {
		this.reBucketId = reBucketId;
	}
	public String getReReplyContents() {
		return reReplyContents;
	}
	public void setReReplyContents(String reReplyContents) {
		this.reReplyContents = reReplyContents;
	}
	public String getReWriteDate() {
		return reWriteDate;
	}
	public void setReWriteDate(String reWriteDate) {
		this.reWriteDate = reWriteDate;
	}
}
