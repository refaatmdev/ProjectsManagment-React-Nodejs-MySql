import { IEmployee } from "./emplyee.interface";
import { IProject } from "./project.interface";

export interface IPaids {
    id?:string,
    paidDate: string;
    projectId: IProject;
    paid:number;
    checkImg?:any;
    method:string;
    notes: string;
    createdAt?: any;
  }