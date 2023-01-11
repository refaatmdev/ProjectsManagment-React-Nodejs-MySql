export interface IRecord {
  id?: string;
  date: any;
  employeeId: any;
  projectId: any;
  startAt: Date;
  endAt: Date;
  duration?: number;
  payPerDay?: number;
  notes: string;
  projectNotes?: any;
  projectName?: string;
  createdAt?: any;
}
