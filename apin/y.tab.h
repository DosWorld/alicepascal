
typedef union  {
	nodep	treeval;		/* maybe need tree and list types? */
	char	*strval;
	int	intval;
} YYSTYPE;
extern YYSTYPE yylval;
# define YAND 257
# define YARRAY 258
# define YBEGIN 259
# define YCASE 260
# define YSTTYPE 261
# define YSHL 262
# define YSHR 263
# define YXOR 264
# define YCONST 265
# define YDIV 266
# define YDO 267
# define YDOTDOT 268
# define YTO 269
# define YELSE 270
# define YEND 271
# define YFILE 272
# define YFOR 273
# define YPROCEDURE 274
# define YGOTO 275
# define YIF 276
# define YIN 277
# define YLABEL 278
# define YMOD 279
# define YNOT 280
# define YOF 281
# define YOR 282
# define YPACKED 283
# define YNIL 284
# define YFUNCTION 285
# define YPROG 286
# define YRECORD 287
# define YREPEAT 288
# define YSET 289
# define YTHEN 290
# define YDOWNTO 291
# define YTYPE 292
# define YUNTIL 293
# define YVAR 294
# define YWHILE 295
# define YWITH 296
# define YCHAR 297
# define YCOLEQUALS 298
# define YPTR 299
# define YILLCH 300
# define YOTHERWISE 301
# define YHIDE 302
# define YHIDEEND 303
# define YABSOLUTE 304
# define YEXTERNAL 305
# define YINLINE 306
# define YOVERLAY 307
# define YCLASS_DECL 308
# define YCLASS_CONST 309
# define YCLASS_TYPE 310
# define YCLASS_VAR 311
# define YCLASS_FIELD 312
# define YCLASS_VARIANT 313
# define YCLASS_STAT 314
# define YCLASS_CASE 315
# define YID 316
# define YINT 317
# define YNUMB 318
# define YSTRING 319
# define YC_ROOT 320
# define YC_COMMENT 321
# define YC_LABEL 322
# define YC_PROC_ID 323
# define YC_FUN_ID 324
# define YC_PROGRAM 325
# define YC_DECLARATIONS 326
# define YC_LABDECL 327
# define YC_CONDECL 328
# define YC_TYPE_DECL 329
# define YC_VAR_DECL 330
# define YC_CONSTANT 331
# define YC_TYPE 332
# define YC_TYPEID 333
# define YC_SIM_TYPE 334
# define YC_ST_TYPE 335
# define YC_FIELD 336
# define YC_FORMAL 337
# define YC_STATEMENT 338
# define YC_CASE 339
# define YC_OUTPUT_EXPRESSION 340
# define YC_VAR 341
# define YC_EXP 342
# define YC_DECL_ID 343
# define YC_HIDECL_ID 344
# define YC_VARIANT 345
# define YC_FLD_NAME 346
# define YC_OCONSTANT 347
# define YC_PNAME 348
# define YC_BLCOMMENT 349
# define YREVEAL 350
# define UNARYSIGN 351
