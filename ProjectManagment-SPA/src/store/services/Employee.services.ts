import { BASE_URL } from "../../config";
import axios from "axios";
import { IEmployee } from "../../_interfaces/emplyee.interface";

const API_URL = `${BASE_URL}/employee`;

async function getEmployees() {
  // const { data } = await axios.post(`${API_URL}/login`, userDetails);
  return null;
}

async function editEployee(employeeDetials: IEmployee, employeeId: number) {
  const { data } = await axios.put(`${API_URL}/${employeeId}`, employeeDetials);
  return data.result;
}

export { getEmployees, editEployee };
