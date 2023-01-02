export interface IRecord {
  id?: string;
  date: any;
  employeeId: any;
  projectId: any;
  startAt: Date;
  endAt: Date;
  payPerDay?: number;
  notes: string;
  projectNotes?: any;
  projectName?: string;
  createdAt?: any;
}
