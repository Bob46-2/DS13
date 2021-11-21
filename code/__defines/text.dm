#define CANCEL	"\[-Cancel-\]"

#define URL_HTTP_WWW	"hypertext"



/*
	Adjective Types
	The rule is that multiple adjectives are always ranked accordingly: opinion, size, age, shape, colour, origin, material, purpose.
*/
#define	ADJECTIVE_TYPE_OPINION	1
#define	ADJECTIVE_TYPE_SIZE	2
#define	ADJECTIVE_TYPE_AGE	3
#define	ADJECTIVE_TYPE_SHAPE	4
#define	ADJECTIVE_TYPE_COLOR	5
#define	ADJECTIVE_TYPE_ORIGIN	6
#define	ADJECTIVE_TYPE_MATERIAL	7
#define	ADJECTIVE_TYPE_PURPOSE	8

/// Removes characters incompatible with file names.
#define SANITIZE_FILENAME(text) (GLOB.filename_forbidden_chars.Replace(text, ""))

/// Prepares a text to be used for maptext. Use this so it doesn't look hideous.
#define MAPTEXT(text) {"<span class='maptext'>[##text]</span>"}

/// Simply removes the < and > characters, and limits the length of the message.
#define STRIP_HTML_SIMPLE(text, limit) (GLOB.angular_brackets.Replace(copytext(text, 1, limit), ""))

/// Macro from Lummox used to get height from a MeasureText proc
#define WXH_TO_HEIGHT(x) text2num(copytext(x, findtextEx(x, "x") + 1))
