import { IdataTable } from "../pages/Employees/Employee";

export const getTotalOfDuration = (record: IdataTable[]) => {
  return record
    .map((t) => t.duration)
    .reduce((acc, value) => acc + Number(value), 0);
};

export const getTotalOfPayPerDay = (record: IdataTable[]) => {
  return record
    .map((t) => t.payPerDay)
    .reduce((acc, value) => acc + Number(value), 0);
};
