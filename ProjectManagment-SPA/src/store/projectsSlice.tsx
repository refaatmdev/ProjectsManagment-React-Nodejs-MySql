import { createSlice, createAsyncThunk, PayloadAction } from "@reduxjs/toolkit";
import axios from "axios";
import { BASE_URL } from "../config";
import { IPaids } from "../_interfaces/paids.interface";
import { IProject, IProjectNotes } from "../_interfaces/project.interface";
import { setProjectsToLocalStorage } from "./services/Projects.services";

const API_URL = `${BASE_URL}/projects`;

interface Iinitvalues {
  isLoading: boolean;
  projects: IProject[];
  project: IProject | null;
  projectNotes: IProjectNotes[];
  projectPaids: IPaids[];
  totalProjects: number;
  projectsDataTable: IProject[];
  error: string;
}

const initalValue: Iinitvalues = {
  isLoading: false,
  projects: [],
  project: null,
  projectNotes: [],
  projectPaids: [],
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
  projectId?: number;
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

export const addProjectQuotation = createAsyncThunk(
  "projects/addProjectQuotation",
  async (args: any, { rejectWithValue, dispatch, signal }) => {
    const { projectId, quotationNotes, quotation, file } = args;
    const quotData = new FormData();
    quotData.append("projectId", projectId);
    quotData.append("quotation", quotation);
    if (file) quotData.append("agreement", file);
    quotData.append("quotationNotes", quotationNotes);
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.post(
        `${API_URL}/quotation/${projectId}`,
        quotData
      );
      if (response.data) dispatch(getProjects({}));
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const updateProjectQuotation = createAsyncThunk(
  "projects/updateQuotation",
  async (args: any, { rejectWithValue, dispatch, signal }) => {
    const { projectId, quotationNotes, quotation, file } = args;
    const quotData = new FormData();
    quotData.append("projectId", projectId);
    quotData.append("quotation", quotation);
    if (file) quotData.append("agreement", file);
    quotData.append("quotationNotes", quotationNotes);
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.put(
        `${API_URL}/updateQuotation/${projectId}`,
        quotData
      );
      if (response.data) dispatch(getProjects({}));
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const deleteQuotation = createAsyncThunk(
  "projects/deleteQuotation",
  async (args: IGetProjectById, { rejectWithValue, dispatch, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const { projectId } = args;
      const response = await axios.delete(`${API_URL}/agreement/${projectId}`);
      if (response.data) return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const getProjectNotes = createAsyncThunk(
  "projects/getProjectNotes",
  async (args: IGetIProject, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    const { projectId } = args;
    try {
      const response = await axios.get(`${API_URL}/notes/${projectId}`, {
        cancelToken: source.token,
      });
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const addProjectNotes = createAsyncThunk(
  "projects/addProjectNotes",
  async (args: IProjectNotes, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    const { projectId } = args;
    try {
      const response = await axios.post(
        `${API_URL}/notes/${projectId}`,
        args
        // {
        //   args,
        //   cancelToken: source.token,
        // }
      );
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);
export const updateProjectNotes = createAsyncThunk(
  "projects/updateProjectNotes",
  async (args: IProjectNotes, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    const { projectId } = args;
    try {
      const response = await axios.put(
        `${API_URL}/notes/${projectId}`,
        args
        // {

        //   cancelToken: source.token,

        // }
      );
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);
export const deleteProjectNotes = createAsyncThunk(
  "projects/deleteProjectNotes",
  async (args: IProjectNotes, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    const { projectId } = args;
    try {
      const response = await axios.delete(
        `${API_URL}/notes/${projectId}/${args.id}`,
        {
          cancelToken: source.token,
        }
      );
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const getProjectPaids = createAsyncThunk(
  "projects/getProjectPaids",
  async (args: IGetIProject, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    const { projectId } = args;
    try {
      const response = await axios.get(`${API_URL}/getPaids/${projectId}`, {
        cancelToken: source.token,
      });
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const addProjectPaids = createAsyncThunk(
  "projects/addProjectPaids",
  async (args: IPaids, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });

    const { paidDate, paid, checkImg, notes, method, projectId } = args;
    const paidsData = new FormData();
    paidsData.append("paidDate", paidDate.toString());
    {
      projectId != undefined &&
        paidsData.append("projectId", projectId.toString());
    }
    {
      paid != null && paidsData.append("paid", paid.toString());
    }
    if (checkImg) paidsData.append("checkImg", checkImg);
    paidsData.append("method", method);
    paidsData.append("notes", notes);
    console.log(paidsData);
    try {
      const response = await axios.post(`${API_URL}/paids/`, paidsData, {
        cancelToken: source.token,
      });
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const updateProjectPaids = createAsyncThunk(
  "projects/updateProjectPaids",
  async (args: IPaids, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });

    const { id, paidDate, paid, checkImg, notes, method, projectId } = args;
    const paidsData = new FormData();
    paidsData.append("paidDate", paidDate.toString());
    {
      projectId != undefined &&
        paidsData.append("projectId", projectId.toString());
    }
    {
      paid != null && paidsData.append("paid", paid.toString());
    }
    if (checkImg) paidsData.append("checkImg", checkImg);
    paidsData.append("method", method);
    paidsData.append("notes", notes);
    console.log(id);
    try {
      const response = await axios.put(`${API_URL}/paid/${id}`, paidsData, {
        cancelToken: source.token,
      });
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const deleteProjectPaid = createAsyncThunk(
  "projects/deleteProjectPaid",
  async (args: IPaids, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    const { id } = args;
    try {
      const response = await axios.delete(`${API_URL}/paidById/${id}`, {
        cancelToken: source.token,
      });
      if (response.data) return id;
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
      })
      .addCase(addProjectQuotation.pending, (state, action) => {
        state.isLoading = true;
      })
      .addCase(
        addProjectQuotation.fulfilled,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;
          return state;
        }
      )
      .addCase(
        addProjectQuotation.rejected,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;
          state.error = action.payload;
        }
      )
      .addCase(updateProjectQuotation.pending, (state, action) => {
        state.isLoading = true;
      })
      .addCase(
        updateProjectQuotation.fulfilled,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;
          return state;
        }
      )
      .addCase(
        updateProjectQuotation.rejected,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;
          state.error = action.payload;
        }
      )
      .addCase(getProjectNotes.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(
        getProjectNotes.fulfilled,
        (state, action: PayloadAction<any>) => {
          state.projectNotes = action.payload.result;
          state.isLoading = false;
        }
      )
      .addCase(
        getProjectNotes.rejected,
        (state, action: PayloadAction<any>) => {
          state.error = action.payload;
          state.isLoading = false;
        }
      )
      .addCase(addProjectNotes.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(
        addProjectNotes.fulfilled,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;

          return state;
        }
      )
      .addCase(
        addProjectNotes.rejected,
        (state, action: PayloadAction<any>) => {
          state.error = action.payload;
          state.isLoading = false;
        }
      )
      .addCase(updateProjectNotes.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(
        updateProjectNotes.fulfilled,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;

          return state;
        }
      )
      .addCase(
        updateProjectNotes.rejected,
        (state, action: PayloadAction<any>) => {
          state.error = action.payload;
          state.isLoading = false;
        }
      )
      .addCase(deleteProjectNotes.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(
        deleteProjectNotes.fulfilled,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;

          return state;
        }
      )
      .addCase(
        deleteProjectNotes.rejected,
        (state, action: PayloadAction<any>) => {
          state.error = action.payload;
          state.isLoading = false;
        }
      )
      .addCase(getProjectPaids.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(
        getProjectPaids.fulfilled,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;

          console.log(action.payload);

          state.projectPaids = action.payload.paids;
        }
      )
      .addCase(
        getProjectPaids.rejected,
        (state, action: PayloadAction<any>) => {
          state.error = action.payload;
          state.isLoading = false;
        }
      )
      .addCase(addProjectPaids.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(
        addProjectPaids.fulfilled,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;
          return state;
        }
      )
      .addCase(
        addProjectPaids.rejected,
        (state, action: PayloadAction<any>) => {
          state.error = action.payload;
          state.isLoading = false;
        }
      )
      .addCase(updateProjectPaids.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(
        updateProjectPaids.fulfilled,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;
          return state;
        }
      )
      .addCase(
        updateProjectPaids.rejected,
        (state, action: PayloadAction<any>) => {
          state.error = action.payload;
          state.isLoading = false;
        }
      )
      .addCase(deleteProjectPaid.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(
        deleteProjectPaid.fulfilled,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;

          state.projectPaids = state.projectPaids.filter(
            (p) => p.id != action.payload
          );
        }
      )
      .addCase(
        deleteProjectPaid.rejected,
        (state, action: PayloadAction<any>) => {
          state.error = action.payload;
          state.isLoading = false;
        }
      );
  },
});

export default projectsSlice.reducer;

// export const {} = employeesSlice.actions;
