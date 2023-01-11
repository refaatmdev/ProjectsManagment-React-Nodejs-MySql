export interface IProject {
  id?: number;
  projectName: string;
  clientFullName: string;
  clientPhone: string;
  location: string;
  quotation?: number;
  paid?: number;
  unPaid?: number;
  haregem?: number;
  agreement?: any;
  quotationNotes?: string;
  createdAt: string;
  updatedAt?: Date;
}

export interface IProjectNotes {
  id?: number;
  projectId?: number;
  notes: string;
  createdAt: string;
}
