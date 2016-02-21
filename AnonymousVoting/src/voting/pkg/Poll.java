package voting.pkg;

import java.util.ArrayList;
import java.util.List;

public class Poll {
	protected String subjectID;
	protected List<String> detailsID = new ArrayList<String>();
	protected String pollTitle;
	protected String pollDesc;
	protected String pollStartDate;
	protected String pollEndDate;
	protected String status;
	protected String type;
	protected List<String> option = new ArrayList<String>();
	protected List<String> results = new ArrayList<String>();
	
	public String getSubjectID() {
		return subjectID;
	}
	public void setSubjectID(String subjectID) {
		this.subjectID = subjectID;
	}
	public List<String> getDetailsID() {
		return detailsID;
	}
	public void setDetailsID(List<String> detailsID) {
		this.detailsID = detailsID;
	}
	public String getPollTitle() {
		return pollTitle;
	}
	public void setPollTitle(String pollTitle) {
		this.pollTitle = pollTitle;
	}
	public String getPollDesc() {
		return pollDesc;
	}
	public void setPollDesc(String pollDesc) {
		this.pollDesc = pollDesc;
	}
	public String getPollStartDate() {
		return pollStartDate;
	}
	public void setPollStartDate(String pollStartDate) {
		this.pollStartDate = pollStartDate;
	}
	public String getPollEndDate() {
		return pollEndDate;
	}
	public void setPollEndDate(String pollEndDate) {
		this.pollEndDate = pollEndDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public List<String> getOption() {
		return option;
	}
	public void setOption(List<String> option) {
		this.option = option;
	}
	public List<String> getResults() {
		return results;
	}
	public void setResults(List<String> results) {
		this.results = results;
	}
	
}
