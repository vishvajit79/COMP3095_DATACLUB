/* COMP3095 : Assignment 2 - DataClub
 * 
 */
package beans;

import java.io.Serializable;

public class Report implements Serializable {
	
	private String reportTemplate, reportTitle, dateCreated, department;
	private String[] sections = new String[3];
	private String[] comments = new String[3];
	private String[][][] secDetail = new String[3][5][3];
	
	
	public String getReportTemplate() {
		return reportTemplate;
	}
	public void setReportTemplate(String reportTemplate) {
		this.reportTemplate = reportTemplate;
	}
	public String getReportTitle() {
		return reportTitle;
	}
	public void setReportTitle(String reportTitle) {
		this.reportTitle = reportTitle;
	}
	public String getDateCreated() {
		return dateCreated;
	}
	public void setDateCreated(String dateCreated) {
		this.dateCreated = dateCreated;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String[] getSections() {
		return sections;
	}
	public void setSections(String[] sections) {
		this.sections = sections;
	}
	public String[] getComments() {
		return comments;
	}
	public void setComments(String[] comments) {
		this.comments = comments;
	}
	public String[][][] getSecDetail() {
		return secDetail;
	}
	public void setSecDetail(String[][][] secDetail) {
		this.secDetail = secDetail;
	}
	
	
}
