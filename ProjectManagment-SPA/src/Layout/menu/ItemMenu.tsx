import HomeIcon from "@mui/icons-material/Home";
import PrecisionManufacturingIcon from "@mui/icons-material/PrecisionManufacturing";
import HourglassBottomIcon from "@mui/icons-material/HourglassBottom";
import AttachMoneyIcon from "@mui/icons-material/AttachMoney";
import PeopleAltIcon from "@mui/icons-material/PeopleAlt";
import MoneyOffIcon from "@mui/icons-material/MoneyOff";
export const menuItems = [
  { id: 1, label: "דף הבית", icon: HomeIcon, link: "/" },
  {
    id: 2,
    label: "פרוייקטים",
    icon: PrecisionManufacturingIcon,
    link: "/Projects",
  },
  { id: 3, label: "עובדים", icon: PeopleAltIcon, link: "/Employees" },
  {
    id: 4,
    label: "דיווח שעות עבודה",
    icon: HourglassBottomIcon,
    link: "/Reports",
  },

  { id: 5, label: "דוחות שכר", icon: AttachMoneyIcon, link: "/Salaries" },
];
