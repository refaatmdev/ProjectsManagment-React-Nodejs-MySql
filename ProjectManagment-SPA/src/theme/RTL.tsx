import React,{PropsWithChildren, ReactNode} from "react";
import { CacheProvider } from "@emotion/react";
import rtlPlugin from "stylis-plugin-rtl";

import createCache from "@emotion/cache";
import { prefixer } from "stylis";
import CssBaseline from "@mui/material/CssBaseline";

const cacheRtl = createCache({
  key: "muirtl",
  stylisPlugins: [prefixer, rtlPlugin],
});

interface RTLProps extends PropsWithChildren{
  // children: ReactNode;
}

export function RTL(props: RTLProps) {
  return (
    <CacheProvider value={cacheRtl}>
      <CssBaseline />
      {props.children}
    </CacheProvider>
  );
}
