import { createSlice, createAsyncThunk, PayloadAction } from "@reduxjs/toolkit";
import { IEmployee } from "../_interfaces/emplyee.interface";
import axios from "axios";
import { BASE_URL } from "../config";
import { IRecord } from "../_interfaces/record.interface";
import { msg } from "./snackBardSlice";
import { TimeSheetModal } from "../helpers/TimeSheetModal";
import dayjs from "dayjs";
import { IMafrea } from "../_interfaces/mafrea.interfac";

const API_URL = `${BASE_URL}/timesSheet`;

export interface IProjectDataTable extends IRecord {
  dailyWage?: number;
  projectNotes: string;
  firstName: string;
  lastName: string;
}

interface Iinitvalues {
  isLoadingRecords: boolean;
  records: IRecord[];
  record?: any;
  projectRecordsDataTable: IProjectDataTable[];
  mafreaot: IMafrea[];
  isLoadingMafreaot: boolean;
  totalRecords: number;
  salaries: [];
  employeeSalaries: [];
  totalSalaries: number;
  isLoadingSalaries: boolean;
  error: string;
}

const initalValue: Iinitvalues = {
  isLoadingRecords: false,
  records: [],
  record: undefined,
  projectRecordsDataTable: [],
  mafreaot: [],
  isLoadingMafreaot: false,
  salaries: [],
  employeeSalaries: [],
  totalSalaries: 0,
  isLoadingSalaries: false,
  totalRecords: 0,
  error: "",
};

type ResponstValues = {
  result: IEmployee[];
  total: number;
};

interface IGetRecords {
  recordsPerPage?: number;
  currentPage?: number;
  month?: string;
  employeeId?: number;
}

export const getAllRecords = createAsyncThunk(
  "records/getAllRecords",
  async (args: IGetRecords, { rejectWithValue, dispatch, signal }) => {
    const {
      recordsPerPage = 31,
      currentPage = 1,
      employeeId,
      month = dayjs().format("YYYY-MM-DD"),
    } = args;
    const queryParams = `?currentMonth=${month}&pagesize=${recordsPerPage}&page=${currentPage}&employeeId=${employeeId}`;
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.get(`${API_URL}/react` + queryParams, {
        cancelToken: source.token,
      });
      return response.data;
    } catch (error: any) {
      dispatch(msg({ msg: error.message }));
      return rejectWithValue(error.message);
    }
  }
);

export const addRecord = createAsyncThunk(
  "records/addRecord",
  async (args: any, { rejectWithValue, signal, dispatch }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const respons = await axios.post(`${API_URL}/addRecords/`, args);
      if (respons.data) return respons.data;
    } catch (error: any) {
      dispatch(msg({ msg: error.message }));
      return rejectWithValue(error.message);
    }
  }
);

export const updateRecord = createAsyncThunk(
  "records/updateRecord",
  async (args: any, { rejectWithValue, signal, dispatch }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const respons = await axios.put(`${API_URL}/editRecord/`, args);
      if (respons.data) return dispatch(getAllRecords({}));
    } catch (error: any) {
      dispatch(msg({ msg: error.message }));
      return rejectWithValue(error.message);
    }
  }
);

export const deleteRecord = createAsyncThunk(
  "records/deleteRecord",
  async (args: any, { rejectWithValue, signal, dispatch }) => {
    const { recordId } = args;
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const respons = await axios.delete(`${API_URL}/deleteRecord/${recordId}`);
      if (respons.data) return respons.data;
    } catch (error: any) {
      dispatch(msg({ msg: error.message }));
      return rejectWithValue(error.message);
    }
  }
);

export const getMafreaot = createAsyncThunk(
  "records/getMafreaot",
  async (args: IGetRecords, { rejectWithValue, dispatch, signal }) => {
    const {
      recordsPerPage = 31,
      currentPage = 1,
      employeeId,
      month = dayjs().format("YYYY-MM-DD"),
    } = args;
    const queryParams = `?currentMonth=${month}&pagesize=${recordsPerPage}&page=${currentPage}&employeeId=${employeeId}`;
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.get(`${API_URL}/mafreaot` + queryParams, {
        cancelToken: source.token,
      });
      return response.data;
    } catch (error: any) {
      dispatch(msg({ msg: error.message }));
      return rejectWithValue(error.message);
    }
  }
);

export const addMafrea = createAsyncThunk(
  "records/addMafrea",
  async (args: any, { rejectWithValue, signal, dispatch }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const respons = await axios.post(`${API_URL}/addMafrea/`, args);
      if (respons.data) return respons.data;
    } catch (error: any) {
      // dispatch(msg({ msg: error.message }));
      return rejectWithValue(error.message);
    }
  }
);

export const updateMafrea = createAsyncThunk(
  "records/updateMafrea",
  async (args: any, { rejectWithValue, signal, dispatch }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const respons = await axios.put(`${API_URL}/editMafrea`, args);
      if (respons.data) return dispatch(getMafreaot({}));
    } catch (error: any) {
      dispatch(msg({ msg: error.message }));
      return rejectWithValue(error.message);
    }
  }
);

export const deleteMafrea = createAsyncThunk(
  "records/deleteMafrea",
  async (args: any, { rejectWithValue, signal, dispatch }) => {
    const { mafreaId } = args;
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const respons = await axios.delete(`${API_URL}/deleteMafrea/${mafreaId}`);
      if (respons.data) return mafreaId;
    } catch (error: any) {
      dispatch(msg({ msg: error.message }));
      return rejectWithValue(error.message);
    }
  }
);

export const getAllSalaries = createAsyncThunk(
  "records/getAllSalaries",
  async (_, { rejectWithValue, dispatch, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.get(`${API_URL}/get/allSalaries`, {
        cancelToken: source.token,
      });
      return response.data;
    } catch (error: any) {
      dispatch(msg({ msg: error.message }));
      return rejectWithValue(error.message);
    }
  }
);

export const getSalaryByMonth = createAsyncThunk(
  "records/getSalaryByMonth",
  async (args: IGetRecords, { rejectWithValue, dispatch, signal }) => {
    const { month = dayjs().format("YYYY-MM-DD") } = args;
    const queryParams = `?currentMonth=${month}`;
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.get(
        `${API_URL}/getlast/Salary` + queryParams,
        {
          cancelToken: source.token,
        }
      );
      return response.data;
    } catch (error: any) {
      dispatch(msg({ msg: error.message }));
      return rejectWithValue(error.message);
    }
  }
);

export const getRecordsByProject = createAsyncThunk(
  "records/getRecordsByProject",
  async (args: any, { rejectWithValue, dispatch, signal }) => {
    const { recordsPerPage = 31, currentPage = 1, projectId } = args;
    const queryParams = `?pagesize=${recordsPerPage}&page=${currentPage}`;
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.get(
        `${API_URL}/${projectId}` + queryParams,
        {
          cancelToken: source.token,
        }
      );
      return response.data;
    } catch (error: any) {
      dispatch(msg({ msg: error.message }));
      return rejectWithValue(error.message);
    }
  }
);

export const calculateSalary = createAsyncThunk(
  "records/calculateSalary",
  async (args: any, { rejectWithValue, signal, dispatch }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const respons = await axios.post(`${API_URL}/calculateSalary/`, {
        currentMonth: args,
      });
      if (respons.data) return respons.data;
    } catch (error: any) {
      // dispatch(msg({ msg: error.message }));
      return rejectWithValue(error.message);
    }
  }
);
const recordsSlice = createSlice({
  name: "records",
  initialState: initalValue,
  reducers: {
    getEmployeeRecords: (state, action: PayloadAction<any>) => {
      state.record = action.payload;
    },
  },
  extraReducers: (builder) => {
    builder
      .addCase(getAllRecords.pending, (state, action) => {
        state.isLoadingRecords = true;
      })
      .addCase(
        getAllRecords.fulfilled,
        (state, action: PayloadAction<any | ResponstValues>) => {
          state.isLoadingRecords = false;
          const mergRecords: any = TimeSheetModal(action.payload.result);
          state.records = mergRecords;
          state.totalRecords = action.payload.total;
        }
      )
      .addCase(getAllRecords.rejected, (state, action: PayloadAction<any>) => {
        state.isLoadingRecords = false;
      })
      .addCase(addRecord.pending, (state, action) => {
        state.isLoadingRecords = true;
      })
      .addCase(
        addRecord.fulfilled,
        (state, action: PayloadAction<any | ResponstValues>) => {
          state.isLoadingRecords = false;
          return state;
        }
      )
      .addCase(addRecord.rejected, (state, action: PayloadAction<any>) => {
        state.isLoadingRecords = false;
      })
      .addCase(updateRecord.pending, (state, action) => {
        state.isLoadingRecords = true;
      })
      .addCase(
        updateRecord.fulfilled,
        (state, action: PayloadAction<any | ResponstValues>) => {
          state.isLoadingRecords = false;
          return state;
        }
      )
      .addCase(updateRecord.rejected, (state, action: PayloadAction<any>) => {
        state.isLoadingRecords = false;
      })
      .addCase(deleteRecord.pending, (state, action) => {
        state.isLoadingRecords = true;
      })
      .addCase(
        deleteRecord.fulfilled,
        (state, action: PayloadAction<any | ResponstValues>) => {
          state.isLoadingRecords = false;
          return state;
        }
      )
      .addCase(deleteRecord.rejected, (state, action: PayloadAction<any>) => {
        state.isLoadingRecords = false;
      })
      .addCase(addMafrea.pending, (state, action) => {
        state.isLoadingRecords = true;
      })
      .addCase(addMafrea.fulfilled, (state) => {
        state.isLoadingRecords = false;
        return state;
      })
      .addCase(addMafrea.rejected, (state, action: PayloadAction<any>) => {
        state.isLoadingRecords = false;
      })
      .addCase(getMafreaot.pending, (state, action) => {
        state.isLoadingMafreaot = true;
      })
      .addCase(
        getMafreaot.fulfilled,
        (state, action: PayloadAction<any | ResponstValues>) => {
          state.isLoadingMafreaot = false;
          state.mafreaot = action.payload.result;
        }
      )
      .addCase(getMafreaot.rejected, (state, action: PayloadAction<any>) => {
        state.isLoadingMafreaot = false;
      })
      .addCase(updateMafrea.pending, (state, action) => {
        state.isLoadingMafreaot = true;
      })
      .addCase(
        updateMafrea.fulfilled,
        (state, action: PayloadAction<any | ResponstValues>) => {
          state.isLoadingMafreaot = false;
          return state;
        }
      )
      .addCase(updateMafrea.rejected, (state, action: PayloadAction<any>) => {
        state.isLoadingMafreaot = false;
      })
      .addCase(deleteMafrea.pending, (state, action) => {
        state.isLoadingMafreaot = true;
      })
      .addCase(
        deleteMafrea.fulfilled,
        (state, action: PayloadAction<any | ResponstValues>) => {
          state.isLoadingMafreaot = false;
          state.mafreaot = state.mafreaot.filter(
            (el) => el.id != action.payload
          );
        }
      )
      .addCase(deleteMafrea.rejected, (state, action: PayloadAction<any>) => {
        state.isLoadingMafreaot = false;
      })
      .addCase(getAllSalaries.pending, (state, action) => {
        state.isLoadingSalaries = true;
      })
      .addCase(
        getAllSalaries.fulfilled,
        (state, action: PayloadAction<any | ResponstValues>) => {
          state.isLoadingSalaries = false;
          state.salaries = action.payload.result2;
        }
      )
      .addCase(getAllSalaries.rejected, (state, action: PayloadAction<any>) => {
        state.isLoadingSalaries = false;
      })
      .addCase(getSalaryByMonth.pending, (state, action) => {
        state.isLoadingSalaries = true;
      })
      .addCase(
        getSalaryByMonth.fulfilled,
        (state, action: PayloadAction<any | ResponstValues>) => {
          state.isLoadingSalaries = false;
          state.employeeSalaries = action.payload.result;
        }
      )
      .addCase(
        getSalaryByMonth.rejected,
        (state, action: PayloadAction<any>) => {
          state.isLoadingSalaries = false;
        }
      )
      .addCase(calculateSalary.pending, (state, action) => {
        state.isLoadingSalaries = true;
      })
      .addCase(
        calculateSalary.fulfilled,
        (state, action: PayloadAction<any | ResponstValues>) => {
          state.isLoadingSalaries = false;
          return state;
        }
      )
      .addCase(
        calculateSalary.rejected,
        (state, action: PayloadAction<any>) => {
          state.isLoadingSalaries = false;
        }
      )

      .addCase(getRecordsByProject.pending, (state, action) => {
        state.isLoadingRecords = true;
      })
      .addCase(
        getRecordsByProject.fulfilled,
        (state, action: PayloadAction<any | ResponstValues>) => {
          state.isLoadingRecords = false;
          state.projectRecordsDataTable = action.payload;
        }
      )
      .addCase(
        getRecordsByProject.rejected,
        (state, action: PayloadAction<any>) => {
          state.isLoadingRecords = false;
        }
      );
  },
});
export const { getEmployeeRecords } = recordsSlice.actions;

export default recordsSlice.reducer;
