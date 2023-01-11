import React, { ChangeEvent, useEffect, useState } from "react";
import { Field, FieldProps, getIn } from "formik";
import {
  FormControl,
  FormHelperText,
  Stack,
  FormLabel,
  Avatar,
  Box,
  Typography,
  TextField,
} from "@mui/material";
import theme from "../../../../../theme/theme";
import { CameraOutlined } from "@mui/icons-material";
import { BASE_URL } from "../../../../../config";

interface FormControlsProps {
  label: string;
  name: string;
}

const InputFile = ({ label, name }: FormControlsProps) => {
  const [selectedImage, setSelectedImage] = useState<File | undefined>(
    undefined
  );
  useEffect(() => {
    if (selectedImage) {
      setAvatar(URL.createObjectURL(selectedImage));
    }
  }, [selectedImage]);
  const [avatar, setAvatar] = useState<string | undefined>();
  return (
    <Field name={name}>
      {({ field, form, ...extraProps }: FieldProps) => {
        const value = getIn(form.values, name);

        value != null &&
          selectedImage === undefined &&
          setAvatar(BASE_URL + "/" + value);
        const { setFieldValue, setFieldError } = form;
        const error = getIn(form.errors, name);
        const touch = getIn(form.touched, name);
        return (
          <FormControl
            sx={{ mt: 1, mr: "0px" }}
            variant="outlined"
            error={error && touch ? true : false}
          >
            <Stack direction="row" justifyContent="center" sx={{ mt: 3 }}>
              <FormLabel
                htmlFor={name}
                sx={{
                  position: "relative",

                  overflow: "hidden",
                  "&:hover .MuiBox-root": { opacity: 1 },
                  cursor: "pointer",
                }}
              >
                <Avatar
                  alt="Avatar 1"
                  src={avatar}
                  sx={{ width: 170, height: 80, border: "1px dashed" }}
                  variant="square"
                />
                <Box
                  sx={{
                    position: "absolute",
                    top: 0,
                    left: 0,
                    backgroundColor:
                      theme.palette.mode === "dark"
                        ? "rgba(255, 255, 255, .75)"
                        : "rgba(0,0,0,.65)",
                    width: "100%",
                    height: "100%",
                    opacity: 0,
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                  }}
                >
                  <Stack spacing={0.5} alignItems="center">
                    <CameraOutlined
                      style={{
                        color: theme.palette.secondary.lighter,
                        fontSize: "2rem",
                      }}
                    />
                    <Typography sx={{ color: "secondary.lighter" }}>
                      העלאה
                    </Typography>
                  </Stack>
                </Box>
              </FormLabel>
              <TextField
                id={name}
                {...extraProps}
                type="file"
                variant="outlined"
                sx={{ display: "none" }}
                onChange={(e: ChangeEvent<HTMLInputElement>) => {
                  if (e.target.files && e.target.files.length > 0) {
                    var reader = new FileReader();
                    reader.readAsDataURL(e.target.files[0]);

                    reader.onload = () => {
                      if (e.target.files != null) {
                        if (
                          !e.target.files[0].name.match(/.(jpg|jpeg|png|gif)$/i)
                        ) {
                          setFieldError(
                            name,
                            "image should be JPG|JPEG|PNG|GIF"
                          );
                        } else {
                          if (e.target.files[0].size > 3 * 1024 * 1024) {
                            setFieldError(
                              name,
                              "image should not be more than 3mb"
                            );
                          } else {
                            setFieldError(name, undefined);
                            setSelectedImage(e.target.files[0]),
                              setFieldValue(name, e.target.files[0]);
                          }
                        }
                      }
                    };
                  }
                  console.log(error);
                }}
              />
            </Stack>

            <FormHelperText id={name} error>
              {error}
              {typeof error === "string" && touch ? error.toString() : null}
            </FormHelperText>
          </FormControl>
        );
      }}
    </Field>
  );
};

export default InputFile;
