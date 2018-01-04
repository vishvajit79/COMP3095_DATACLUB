/* COMP3095 : Assignment 2 - DataClub
 * 
 */
package beans;

public class Employee {
	private String first_name, last_name, email, hire_year, position;
	public Employee(String first_name, String last_name, String email, String hire_year, String position,
			int employee_id) {
		super();
		this.first_name = first_name;
		this.last_name = last_name;
		this.email = email;
		this.hire_year = hire_year;
		this.position = position;
		this.employee_id = employee_id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getHire_year() {
		return hire_year;
	}

	public void setHire_year(String hire_year) {
		this.hire_year = hire_year;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	private int employee_id, deptId;

	public Employee(String first_name, String last_name, int employee_id, int deptId) {
		super();
		this.first_name = first_name;
		this.last_name = last_name;
		this.employee_id = employee_id;
		this.deptId = deptId;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public int getEmployee_id() {
		return employee_id;
	}

	public void setEmployee_id(int employee_id) {
		this.employee_id = employee_id;
	}

	public int getDeptId() {
		return deptId;
	}

	public void setDeptId(int deptId) {
		this.deptId = deptId;
	}
}
