import { IRecord } from "../_interfaces/record.interface";

export const TimeSheetModal = (records: IRecord[]) => {
  return Object.values(
    records.reduce((recordObj: any, currentRecord: IRecord) => {
      const { id, projectId, projectNotes, projectName } = currentRecord;

      if (!id) return;
      const newRecord = !recordObj[id]
        ? {
            ...currentRecord,
            projectId: [{ projectId, projectName, notes: projectNotes }],
          }
        : {
            ...recordObj[id],
            projectId: [
              ...recordObj[id].projectId,
              { projectId, projectName, notes: projectNotes },
            ],
          };
      delete newRecord.projectName;
      delete newRecord.projectNotes;
      return {
        ...recordObj,
        [id]: newRecord,
      };
    }, {})
  );
};
