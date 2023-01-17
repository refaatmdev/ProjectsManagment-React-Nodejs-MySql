import { configureStore } from "@reduxjs/toolkit";
import authSlice from "./authSlice";
import employeesSlice from "./employeesSlice";
import projectsSlice from "./projectsSlice";
import recordsSlice from "./recordsSlice";
import snackBardSlice from "./snackBardSlice";
export const store = configureStore({
  reducer: {
    employee: employeesSlice,
    records: recordsSlice,
    projects: projectsSlice,
    snackBardSlice: snackBardSlice,
    auth: authSlice,
  },
});

// Infer the `RootState` and `AppDispatch` types from the store itself
export type RootState = ReturnType<typeof store.getState>;
// Inferred type: {posts: PostsState, comments: CommentsState, users: UsersState}
export type AppDispatch = typeof store.dispatch;
