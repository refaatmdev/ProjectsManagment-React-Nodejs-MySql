import { createSlice, createAsyncThunk, PayloadAction } from "@reduxjs/toolkit";
import { IEmployee } from "../_interfaces/emplyee.interface";
import axios from "axios";
import { BASE_URL } from "../config";
import { IDWage } from "../_interfaces/dailyWage.interface";

const API_URL = `${BASE_URL}/employee`;

interface Iinitvalues {
  isLoading: boolean;
  employees: IEmployee[];
  employee: IEmployee | null;
  activeEmployees: IEmployee[];
  employeeDataTable: IEmployee[];
  totalEmployees: number;
  error: string | null;
}

const initalValue: Iinitvalues = {
  isLoading: false,
  employees: [],
  employee: null,
  activeEmployees: [],
  employeeDataTable: [],
  totalEmployees: 0,
  error: "",
};

type ResponstValues = {
  result: IEmployee[];
  total: number;
};

interface IGetImployee {
  employeePerPage?: number;
  currentPage?: number;
  searchValue?: string;
}

interface IGetImployeeById {
  employeeId?: number;
}
export const getEmployees = createAsyncThunk(
  "employees/getEmployees",
  async (args: IGetImployee, { rejectWithValue, dispatch, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    const { employeePerPage, currentPage, searchValue } = args;
    const queryParams = `?pagesize=${employeePerPage}&page=${currentPage}`;
    try {
      const response = await await axios.post(
        `${API_URL}/getEmployees` + queryParams,
        { searchValue, cancelToken: source.token }
      );
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const getEmployeeById = createAsyncThunk(
  "employees/getEmployeeById",
  async (args: IGetImployeeById, { rejectWithValue, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    const { employeeId } = args;
    try {
      const response = await axios.post(`${API_URL}/getEmployees`, {
        employeeId: employeeId,
        cancelToken: source.token,
      });
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const addEmployeeA = createAsyncThunk(
  "employees/addEmployee",
  async (args: IEmployee, { rejectWithValue, dispatch, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.post(`${API_URL}`, args, {
        cancelToken: source.token,
      });
      if (response.data) dispatch(getEmployees({}));
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const editEmployee = createAsyncThunk(
  "employees/editEmployee",
  async (args: IEmployee, { rejectWithValue, dispatch, signal }) => {
    const { id } = args;
    let employeeId: number = Number(id);
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.put(`${API_URL}/${employeeId}`, args, {
        cancelToken: source.token,
      });
      if (response.data) dispatch(getEmployees({}));
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const deleteEmployee = createAsyncThunk(
  "employees/deleteEmployee",
  async (args: IGetImployeeById, { rejectWithValue, dispatch, signal }) => {
    const { employeeId } = args;

    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      if (!employeeId) throw new Error("Employee Id is required");
      const response = await axios.delete(`${API_URL}/${employeeId}`);
      if (response.data) dispatch(getEmployees({}));
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

export const updateDailyWage = createAsyncThunk(
  "employees/updateDailyWage",
  async (args: IDWage, { rejectWithValue, dispatch, signal }) => {
    const source = axios.CancelToken.source();
    signal.addEventListener("abort", () => {
      source.cancel();
    });
    try {
      const response = await axios.post(`${API_URL}/addDailyWage`, args, {
        cancelToken: source.token,
      });
      if (response.data) dispatch(getEmployees({}));
      return response.data;
    } catch (error: any) {
      return rejectWithValue(error.message);
    }
  }
);

const employeesSlice = createSlice({
  name: "employees",
  initialState: initalValue,
  reducers: {},
  extraReducers: (builder) => {
    builder
      .addCase(getEmployees.pending, (state) => {
        state.isLoading = true;
        state.error = null;
      })
      .addCase(
        getEmployees.fulfilled,
        (state, action: PayloadAction<ResponstValues, string, any>) => {
          state.isLoading = false;
          if (action.meta.arg.employeePerPage) {
            state.employeeDataTable = action.payload.result;
          } else {
            state.employees = action.payload.result;
            state.activeEmployees = action.payload.result.filter(
              (e) => e.isActive === 1
            );
          }
          state.totalEmployees = action.payload.total;
        }
      )
      .addCase(getEmployees.rejected, (state, action: PayloadAction<any>) => {
        state.isLoading = false;
        state.error = action.payload;
      })

      //getEmployeeById
      .addCase(getEmployeeById.pending, (state, action) => {
        state.isLoading = true;
      })
      .addCase(
        getEmployeeById.fulfilled,
        (state, action: PayloadAction<any | ResponstValues>) => {
          state.isLoading = false;
          state.employee = action.payload.result[0];
        }
      )
      .addCase(
        getEmployeeById.rejected,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;
          state.error = action.payload;
        }
      )
      //END - getEmployeeById

      //add employee
      .addCase(addEmployeeA.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(addEmployeeA.fulfilled, (state) => {
        state.isLoading = false;
        return state;
      })
      .addCase(addEmployeeA.rejected, (state, action: PayloadAction<any>) => {
        state.isLoading = false;
        state.error = action.payload;
      })
      // ennd add employee

      // start editEmployeeAction
      .addCase(editEmployee.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(editEmployee.fulfilled, (state) => {
        state.isLoading = false;
        return state;
      })
      .addCase(editEmployee.rejected, (state, action: PayloadAction<any>) => {
        state.isLoading = false;
        state.error = action.payload;
      })
      // end editEmployeeAction

      // start deleteEmployeeAction
      .addCase(deleteEmployee.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(
        deleteEmployee.fulfilled,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;
          // state.employees =
        }
      )
      .addCase(deleteEmployee.rejected, (state, action: PayloadAction<any>) => {
        state.isLoading = false;
        state.error = action.payload;
      })
      // end deleteEmployeeAction

      //updateDailyWage
      .addCase(updateDailyWage.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(updateDailyWage.fulfilled, (state) => {
        state.isLoading = false;
        return state;
      })
      .addCase(
        updateDailyWage.rejected,
        (state, action: PayloadAction<any>) => {
          state.isLoading = false;
          state.error = action.payload;
        }
      );
    //end updateDailyWage
  },
});

export default employeesSlice.reducer;
