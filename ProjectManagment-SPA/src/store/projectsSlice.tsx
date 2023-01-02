import { createSlice, createAsyncThunk, PayloadAction } from "@reduxjs/toolkit";
import axios from "axios";
import { BASE_URL } from "../config";
import { IProject } from "../_interfaces/project.interface";
import { setProjectsToLocalStorage } from "./services/Projects.services";

const API_URL = `${BASE_URL}/projects`;

interface Iinitvalues {
  isLoading: boolean;
  projects: IProject[];
  project: IProject | null;
  totalProjects: number;
  projectsDataTable: IProject[];
  error: string;
}

const initalValue: Iinitvalues = {
  isLoading: false,
  projects: [],
  project: null,
  totalProjects: 0,
  projectsDataTable: [],
  error: "",
};

type ResponstValues = {
  result: IProject[];
  total: number;
};

interface IGetIProject {
  projectsPerPage?: number;
  currentPage?: number;
  searchValue?: string;
}

interface IGetProjectById {
  projectId?: number;
}
export const getProjects = createAsyncThunk(
  "projects/getProjects",
  async (args: IGetIProject, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    const { projectsPerPage, currentPage, searchValue } = args;
    const queryParams = `?pagesize=${projectsPerPage}&page=${currentPage}`;
    try {
      const response = await axios.post(
        `${API_URL}/getProjects` + queryParams,
        { searchValue, cancelToken: source.token }
      );
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const addNewProject = createAsyncThunk(
  "projects/addNewProject",
  async (args: IProject, { rejectWithValue, dispatch, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.post(`${API_URL}`, args);
      if (response.data) dispatch(getProjects({}));
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const updateProject = createAsyncThunk(
  "projects/updateProject",
  async (args: IProject, { rejectWithValue, dispatch, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const { id, ...values } = args;
      const response = await axios.put(`${API_URL}/${args.id}`, values);
      if (response.data) dispatch(getProjects({}));
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const deleteProject = createAsyncThunk(
  "projects/deleteProject",
  async (args: IGetProjectById, { rejectWithValue, dispatch, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const { projectId } = args;
      const response = await axios.delete(`${API_URL}/${projectId}`);
      if (response.data) dispatch(getProjects({}));
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const getProjectById = createAsyncThunk(
  "projects/getProjectById",
  async (args: IGetProjectById, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const { projectId } = args;
      const response = await axios.get(`${API_URL}/${projectId}`);
      if (response.data) return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

const projectsSlice = createSlice({
  name: "projects",
  initialState: initalValue,
  reducers: {},
  extraReducers: (builder) => {
    builder
      .addCase(getProjects.pending, (state, action) => {
        state.isLoading = true;
      })
      .addCase(
        getProjects.fulfilled,
        (state, action: PayloadAction<ResponstValues, string, any>) => {
          state.isLoading = false;
          action.meta.arg.projectsPerPage
            ? (state.projectsDataTable = action.payload.result)
            : ((state.projects = action.payload.result),
              setProjectsToLocalStorage(action.payload.result));
          state.totalProjects = action.payload.total;
        }
      )
      .addCase(getProjects.rejected, (state, action: PayloadAction<any>) => {
        state.isLoading = false;
      })

      // add project
      .addCase(addNewProject.pending, (state, action) => {
        state.isLoading = true;
      })
      .addCase(addNewProject.fulfilled, (state, action: PayloadAction<any>) => {
        state.isLoading = false;
        return state;
      })
      .addCase(addNewProject.rejected, (state, action: PayloadAction<any>) => {
        state.isLoading = false;
        state.error = action.payload;
      })

      //Update Project
      .addCase(updateProject.pending, (state, action) => {
        state.isLoading = true;
      })
      .addCase(updateProject.fulfilled, (state, action: PayloadAction<any>) => {
        state.isLoading = false;
        return state;
      })
      .addCase(updateProject.rejected, (state, action: PayloadAction<any>) => {
        state.isLoading = false;
        state.error = action.payload;
      })
      //get poroject by id
      .addCase(getProjectById.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(
        getProjectById.fulfilled,
        (state, action: PayloadAction<any>) => {
          state.project = action.payload;
          state.isLoading = false;
        }
      )
      .addCase(getProjectById.rejected, (state, action: PayloadAction<any>) => {
        state.error = action.payload;
        state.isLoading = false;
      });
  },
});

export default projectsSlice.reducer;

// export const {} = employeesSlice.actions;
