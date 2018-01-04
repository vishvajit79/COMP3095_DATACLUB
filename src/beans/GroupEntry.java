/* COMP3095 : Assignment 2 - DataClub
 * 
 */
package beans;

public class GroupEntry {

	private int dept_id;
	private String group_name;

	public GroupEntry(int dept_id, String group_name) {
		super();
		this.dept_id = dept_id;
		this.group_name = group_name;
	}

	public int getDeptId() {
		return dept_id;
	}

	public void setDeptId(int dept_id) {
		this.dept_id = dept_id;
	}

	public String getGroup_name() {
		return group_name;
	}

	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}

}
