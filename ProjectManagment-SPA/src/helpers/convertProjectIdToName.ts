import { IDayWorked } from "../components/Employees/EmployeeTimeSheetDataTable";
import { getProjectsFromLocalStorage } from "../store/services/Projects.services";
import { IProject } from "../_interfaces/project.interface";
export default function getProjectsName(projectId: IDayWorked) {
  // console.log(projectId);
  let setProjectNames: any = "";
  // const projects = getProjectsFromLocalStorage();
  if (projectId === null || "" || undefined) return (setProjectNames = "חופש");
  // let spliteProjectId = projectId.split(",");
  // if (spliteProjectId.length < 0) return (setProjectNames = "חופש");
  Array.isArray(projectId)
    ? projectId.map((p: any, index: number) => {
        // const projectName = projects.filter((project: any) => {
        //   return project.id == p;
        // });
        projectId.length > 1 && index !== projectId.length - 1
          ? (setProjectNames +=
              (p.projectName != undefined ? p.projectName : " ") + " » ")
          : (setProjectNames += p.projectName);
      })
    : (setProjectNames = projectId.projectName);
  return setProjectNames;
}
