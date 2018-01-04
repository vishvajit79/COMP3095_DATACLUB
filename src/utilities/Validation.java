/* COMP3095 : Assignment 2
 * This java class is used as a helper validation class
 * 
 */

package utilities;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class Validation {

	// checks duplication of employee in a single group
	public static boolean checkDuplicates(String[] empArray) {

		for (int i = 0; i < empArray.length; i++) {
			for (int j = i + 1; j < empArray.length; j++) {
				if (empArray[i].equals(empArray[j])) {
					return true;
				}
			}
		}
		return false;
	}

	//checks for duplication of section title for a single report template
	public static boolean checkDuplicateSection(String str1, String str2) {
		
		if(str1.equals(str2)) {
			return true;
		}
		return false;
	}
	
	
	//checks for duplication of attendance on a particular date
	public static boolean checkDuplicateAttendnace(String id, String date) {
		try {
			// connect with database
			Connection myCon = DatabaseAccess.connectDataBase();
			Statement query = myCon.createStatement();
			ResultSet myRs = query.executeQuery("select * from `attendance`");

			// checks for valid user name and password
			while (myRs.next()) {
				if (id.equals(myRs.getString("department_id")) && date.equals(myRs.getString("date"))) {
					return true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	//check for whether checkbox is checked or not for a large array
	public static boolean checkboxSelected(int value, int employeeId) {
		try {
			if (value == employeeId) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}