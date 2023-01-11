import { red } from "@ant-design/colors";
import {
  Avatar,
  Button,
  Card,
  CardActions,
  CardContent,
  CardContentProps,
  CardHeader,
  CardHeaderProps,
  CardMedia,
  CardProps,
  Divider,
  IconButton,
  Typography,
  useTheme,
} from "@mui/material";
import { CSSProperties } from "@mui/material/styles/createTypography";
import * as React from "react";
import { PropsWithChildren, ReactNode } from "react";

interface Props extends PropsWithChildren {
  border?: boolean;
  boxShadow?: boolean;
  subheader?: ReactNode | string;
  style?: CSSProperties;
  content?: boolean;
  contentSX?: CardContentProps["sx"];
  darkTitle?: boolean;
  mainColor?: string;
  divider?: boolean;
  sx?: CardProps["sx"];
  secondary?: CardHeaderProps["action"];
  shadow?: string;
  elevation?: number;
  title?: ReactNode | string;
  modal?: boolean;
}
const headerSX = {
  p: 2.5,
  "& .MuiCardHeader-action": { m: "0px auto", alignSelf: "center" },
};

function MainCardRef(
  {
    border = true,
    boxShadow,
    children,
    subheader,
    content = true,
    contentSX = {},
    darkTitle,
    divider = true,
    elevation,
    secondary,
    shadow,
    sx = {},
    mainColor,
    title,
    modal = false,
    ...others
  }: Props,
  ref: React.Ref<HTMLDivElement>
) {
  const theme = useTheme();
  boxShadow = theme.palette.mode === "dark" ? boxShadow || true : boxShadow;

  return (
    <Card
      elevation={elevation || 0}
      ref={ref}
      {...others}
      sx={{
        position: "relative",
        border: border ? "1px solid" : "none",
        borderRadius: 1,
        borderColor:
          theme.palette.mode === "dark" ? theme.palette.divider : "#E6EBF1",
        boxShadow:
          boxShadow && (!border || theme.palette.mode === "dark")
            ? shadow
            : "inherit",
        ":hover": {
          boxShadow: boxShadow ? shadow : "inherit",
        },
        ...(modal && {
          position: "absolute" as "absolute",
          top: "50%",
          left: "50%",
          transform: "translate(-50%, -50%)",
          width: { xs: `calc( 100% - 50px)`, sm: "auto" },
          "& .MuiCardContent-root": {
            overflowY: "auto",
            minHeight: "auto",
            maxHeight: `calc(100vh - 200px)`,
          },
        }),
        ...sx,
      }}
    >
      {/* card header and action */}
      {!darkTitle && title && (
        <CardHeader
          style={{
            backgroundColor: mainColor,
            color: mainColor ? "white" : "",
          }}
          sx={headerSX}
          titleTypographyProps={{ variant: "h6" }}
          title={title}
          action={secondary}
          subheader={subheader}
        />
      )}
      {darkTitle && title && (
        <CardHeader
          sx={headerSX}
          title={<Typography variant="h2">{title}</Typography>}
          action={secondary}
        />
      )}

      {/* content & header divider */}
      {title && divider && <Divider />}

      {/* card content */}
      {content && <CardContent sx={contentSX}>{children}</CardContent>}
      {!content && children}
    </Card>
  );
}

export default React.forwardRef(MainCardRef);
