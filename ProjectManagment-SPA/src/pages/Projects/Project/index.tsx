import React, { useEffect } from "react";
import { useParams } from "react-router-dom";
import { useAppDispatch, useAppSelector } from "../../../store/hooks";
import { getProjectById, getProjects } from "../../../store/projectsSlice";
import { msg } from "../../../store/snackBardSlice";

const Project = () => {
  let { id } = useParams();
  const dispatch = useAppDispatch();
  const { project, isLoading } = useAppSelector((state) => state.projects);

  useEffect(() => {
    dispatch(getProjectById({ projectId: Number(id) }))
      .unwrap()
      .catch((error) => {
        dispatch(msg({ msg: error.message, type: "error" }));
      });
  }, [id]);

  return <div>{project && project.projectName}</div>;
};

export default Project;
