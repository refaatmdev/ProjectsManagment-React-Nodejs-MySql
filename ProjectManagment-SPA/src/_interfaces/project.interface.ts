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
  createdAt: string;
  updatedAt?: Date;
}
