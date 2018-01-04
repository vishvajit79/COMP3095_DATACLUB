/* COMP3095 : Assignment 2 - DataClub
 * 
 */
package beans;

public class Attendance {

	private int employeeId;
	private String employeeFname, employeeLname;
	public Attendance(int present) {
		super();
		this.present = present;
	}
	public int getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}
	public String getEmployeeFname() {
		return employeeFname;
	}
	public void setEmployeeFname(String employeeFname) {
		this.employeeFname = employeeFname;
	}
	public String getEmployeeLname() {
		return employeeLname;
	}
	public void setEmployeeLname(String employeeLname) {
		this.employeeLname = employeeLname;
	}
	public int getPresent() {
		return present;
	}
	public void setPresent(int present) {
		this.present = present;
	}
	private int present;
}
