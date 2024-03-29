/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]            = "-*-terminus-medium-r-*-*-12-*-*-*-*-*-*-*";
static const char normbordercolor[] = "#110c0a";
static const char normbgcolor[]     = "#453d31";
static const char normfgcolor[]     = "#a1a8af";
static const char selbordercolor[]  = "#a0a978";
static const char selbgcolor[]      = "#5f7888";
static const char selfgcolor[]      = "#efebe7";
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 8;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

/* tagging */
static const char *tags[] = { "main", "term", "web", "media" };

static const Rule rules[] = {
        /* class      instance    title       tags mask     isfloating   monitor */
        { "URxvt",    NULL,       NULL,       1 << 1,       False,        -1 },
        { "Firefox",  NULL,       NULL,       1 << 2,       False,       -1 },
        { "dwb",      NULL,       NULL,       1 << 2,       False,       -1 },
        { "MPlayer",  NULL,       NULL,       0,            True,        -1 },
        { "feh",      NULL,       NULL,       0,            True,        -1 },
        { "Mcomix",   NULL,       NULL,       0,            True,        -1 },
        { "Gimp",     NULL,       NULL,       1 << 4,       True,        -1 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const Bool resizehints = True; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "TTT",      bstack },
 	{ "===",      bstackhoriz },
};

/* key definitions */
#define MODKEY Mod1Mask  /* ALT */
#define WINKEY Mod4Mask /* SUPER */
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-b", "-i", "-fn", font, "-nb", "#453d31", "-nf", "#a1a8af", "-sb", "#89935d", "-sf", "#485327", NULL };
static const char *termcmd[]  = { "urxvtc", NULL };
static const char *browser[]  = { "firefox", NULL };
static const char *editor[]   = { "geany", NULL };
static const char *ncmpcpp[]  = { "urxvtc", "-title", "ncmpcpp", "-e", "ncmpcpp", NULL };

/* audio playback [mpd] */
static const char *mnext[] = { "mpc", "next", NULL };
static const char *mprev[] = { "mpc", "prev", NULL };
static const char *mpause[] = { "mpc", "pause", NULL };
static const char *mplay[] = { "mpc", "play", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ WINKEY,                       XK_f,      spawn,          {.v = browser } },
    { WINKEY,                       XK_e,      spawn,          {.v = editor } },
	{ WINKEY,                       XK_n,      spawn,          {.v = ncmpcpp } },
	{ WINKEY,                       XK_j,      spawn,          {.v = mnext } },
    { WINKEY,                       XK_k,      spawn,          {.v = mprev } },
    { WINKEY,                       XK_p,      spawn,          {.v = mplay } },
    { WINKEY,                       XK_o,      spawn,          {.v = mpause } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	// layouts
    // NOTE: really need a cycling helper.
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[3]} },
    { MODKEY,                       XK_v,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

