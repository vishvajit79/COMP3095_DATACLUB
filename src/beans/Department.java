/* COMP3095 : Assignment 2 - DataClub
 * 
 */
package beans;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Department implements Serializable{
	
	private String deptName = null;
	private String deptLocation = null;
	
	public Department(String name, String location) {
			this.setDeptName(name);
			this.setDeptLocation(location);
	}
	
	public String getDeptName() {
		return deptName;
	}
	
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	public String getDeptLocation() {
		return deptLocation;
	}
	
	public void setDeptLocation(String deptLocation) {
		this.deptLocation = deptLocation;
	}
}
