import { IProject } from "./project.interface";

export interface IPaids {
  id?: number;
  paidDate: string;
  projectId: IProject;
  paid: number | null;
  checkImg?: any;
  method: string;
  notes: string;
  createdAt?: any;
}
