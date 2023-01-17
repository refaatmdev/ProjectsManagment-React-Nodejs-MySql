import React, { useEffect } from "react";
import { Link as RouterLink, useNavigate } from "react-router-dom";

// material-ui
import {
  Button,
  Checkbox,
  Divider,
  FormControlLabel,
  FormHelperText,
  Grid,
  Link,
  InputAdornment,
  InputLabel,
  OutlinedInput,
  Stack,
  Typography,
  IconButton,
} from "@mui/material";

// third party
import * as Yup from "yup";
import { Form, Formik, FormikProps } from "formik";

// assets
import { EyeOutlined, EyeInvisibleOutlined } from "@ant-design/icons";
import { login } from "../../store/authSlice";
import { useAppDispatch, useAppSelector } from "../../store/hooks";
import { msg } from "../../store/snackBardSlice";

// interface IProjectNoteActionProps {
//   data?: IProjectNotes;
//   projectId?: number;
//   show: boolean;
//   handelClose: () => void;
// }
interface ILogin {
  email: string;
  password: string;
}

const LoginForm = () => {
  const navigate = useNavigate();
  const dispatch = useAppDispatch();
  const [checked, setChecked] = React.useState(false);
  const [capsWarning, setCapsWarning] = React.useState(false);
  const [showPassword, setShowPassword] = React.useState(false);

  const { isLoading, isLoggedIn, isSuccess, message, isError } = useAppSelector(
    (state) => state.auth
  );
  const initialValues = {
    email: "",
    password: "",
  };

  const validationSchema = Yup.object({
    email: Yup.string().email("אימין לא תקין").max(255).required("אימייל חובה"),
    password: Yup.string().max(255).required("סיסמה חובה"),
  });

  const handleClickShowPassword = () => {
    setShowPassword(!showPassword);
  };

  const handleMouseDownPassword = (event: React.SyntheticEvent) => {
    event.preventDefault();
  };

  const onKeyDown = (keyEvent: any) => {
    if (keyEvent.getModifierState("CapsLock")) {
      setCapsWarning(true);
    } else {
      setCapsWarning(false);
    }
  };

  const handelOnSubmit = (data: ILogin) => {
    if (!data) return;
    console.log(data);
    dispatch(login(data))
      .unwrap()
      .catch((error) => dispatch(msg({ msg: error, type: "error" })));
  };

  useEffect(() => {
    if (isSuccess && isLoggedIn) {
      navigate("/Dashboard");
    }
  }, [isLoggedIn, isSuccess, dispatch, navigate, isError]);

  return (
    <>
      <Formik
        initialValues={initialValues}
        validationSchema={validationSchema}
        onSubmit={handelOnSubmit}
      >
        {({
          errors,
          handleBlur,
          handleChange,
          isSubmitting,
          touched,
          values,
        }: FormikProps<ILogin>) => {
          return (
            <Form>
              <Grid container spacing={3}>
                <Grid item xs={12}>
                  <Stack spacing={1}>
                    <InputLabel htmlFor="email-login">אימייל</InputLabel>
                    <OutlinedInput
                      id="email-login"
                      type="email"
                      value={values.email}
                      name="email"
                      onBlur={handleBlur}
                      onChange={handleChange}
                      placeholder="הכנס את המייל שלך"
                      fullWidth
                      error={Boolean(touched.email && errors.email)}
                    />
                    {touched.email && errors.email && (
                      <FormHelperText
                        error
                        id="standard-weight-helper-text-email-login"
                      >
                        {errors.email}
                      </FormHelperText>
                    )}
                  </Stack>
                </Grid>
                <Grid item xs={12}>
                  <Stack spacing={1}>
                    <InputLabel htmlFor="password-login">סיסמה</InputLabel>
                    <OutlinedInput
                      fullWidth
                      color={capsWarning ? "warning" : "primary"}
                      error={Boolean(touched.password && errors.password)}
                      id="-password-login"
                      type={showPassword ? "text" : "password"}
                      value={values.password}
                      name="password"
                      onBlur={(event: React.FocusEvent<any, Element>) => {
                        setCapsWarning(false);
                        handleBlur(event);
                      }}
                      onKeyDown={onKeyDown}
                      onChange={handleChange}
                      endAdornment={
                        <InputAdornment position="end">
                          <IconButton
                            aria-label="toggle password visibility"
                            onClick={handleClickShowPassword}
                            onMouseDown={handleMouseDownPassword}
                            edge="end"
                            color="secondary"
                          >
                            {showPassword ? (
                              <EyeOutlined />
                            ) : (
                              <EyeInvisibleOutlined />
                            )}
                          </IconButton>
                        </InputAdornment>
                      }
                      placeholder="הכנס סיסמה"
                    />
                    {capsWarning && (
                      <Typography
                        variant="caption"
                        sx={{ color: "warning.main" }}
                        id="warning-helper-text-password-login"
                      >
                        Caps lock פעיל!
                      </Typography>
                    )}
                    {touched.password && errors.password && (
                      <FormHelperText
                        error
                        id="standard-weight-helper-text-password-login"
                      >
                        {errors.password}
                      </FormHelperText>
                    )}
                  </Stack>
                </Grid>
                <Grid item xs={12}>
                  <Button
                    disableElevation
                    disabled={isSubmitting}
                    fullWidth
                    size="large"
                    type="submit"
                    variant="contained"
                    color="primary"
                  >
                    לחץ להתחברות למערכת
                  </Button>
                </Grid>
              </Grid>
            </Form>
          );
        }}
      </Formik>
    </>
  );
};

export default LoginForm;
