import { IEmployee } from "./emplyee.interface";
export interface IDWage {
    id?:string,
    employeeId: IEmployee | string;
    dailyWage:number,
    startFrom:string,
  }