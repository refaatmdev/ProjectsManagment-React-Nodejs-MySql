// material-ui
import { Theme } from "@mui/material/styles";

// third-party
import { merge } from "lodash";
import Accordion from "./Accordion";
import AccordionDetails from "./AccordionDetails";
import AccordionSummary from "./AccordionSummary";

// project import

import ButtonBase from "./ButtonBase";
import ButtonGroup from "./ButtonGroup";
import CardContent from "./CardContent";
import Dialog from "./Dialog";
import DialogContentText from "./DialogContentText";
import DialogTitle from "./DialogTitle";
import IconButton from "./IconButton";
import InputBase from "./InputBase";
import InputLabel from "./InputLabel";
import LinearProgress from "./LinearProgress";
import Link from "./Link";
import ListItemButton from "./ListItemButton";
import ListItemIcon from "./ListItemIcon";
import LoadingButton from "./LoadingButton";
import Pagination from "./Pagination";
import Tab from "./Tab";
import TableBody from "./TableBody";
import TableCell from "./TableCell";
import TableFooter from "./TableFooter";
import TableHead from "./TableHead";
import TablePagination from "./TablePagination";
import TableRow from "./TableRow";
import Tabs from "./Tabs";
import ToggleButton from "./ToggleButton";
import TreeItem from "./TreeItem";
import Typography from "./Typography";

// ==============================|| OVERRIDES - MAIN ||============================== //

export default function ComponentsOverrides(theme: Theme) {
  return merge(
    Accordion(theme),
    AccordionDetails(theme),
    AccordionSummary(theme),
    ButtonBase(),
    ButtonGroup(),
    CardContent(),
    Dialog(),
    DialogContentText(theme),
    DialogTitle(),
    IconButton(theme),
    InputBase(),
    InputLabel(theme),
    LinearProgress(),
    Link(),
    ListItemButton(theme),
    ListItemIcon(theme),
    LoadingButton(),
    Pagination(),
    Tab(theme),
    TableBody(theme),
    TableCell(theme),
    TableFooter(theme),
    TableHead(theme),
    TablePagination(),
    TableRow(),
    Tabs(),
    ToggleButton(theme),
    TreeItem(),
    Typography()
  );
}
