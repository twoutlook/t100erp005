#該程式未解開Section, 採用最新樣板產出!
{<section id="abgq710_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-12-30 13:48:29), PR版次:0001(2016-12-30 16:38:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgq710_x01
#+ Description: ...
#+ Creator....: 05016(2016-12-30 11:41:56)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="abgq710_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING,                  #where condition 
       a1 STRING,                  #xg_tmp1 
       a2 STRING,                  #xg_tmp2 
       a3 STRING                   #visible_str
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
DEFINE g_tmp_table1    STRING
#end add-point
 
{</section>}
 
{<section id="abgq710_x01.main" readonly="Y" >}
PUBLIC FUNCTION abgq710_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  xg_tmp1 
DEFINE  p_arg3 STRING                  #tm.a2  xg_tmp2 
DEFINE  p_arg4 STRING                  #tm.a3  visible_str
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_tmp_table = tm.a1
   LET g_tmp_table1 = tm.a2
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "abgq710_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abgq710_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abgq710_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abgq710_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abgq710_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abgq710_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abgq710_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abgq710_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_bggo002_desc.type_t.chr100,bggo003.bggo_t.bggo003,l_bggo007_desc.type_t.chr100,l_lowersite.type_t.chr1,l_bgaa003.bgaa_t.bgaa003,l_bggo001.type_t.chr100,l_type_desc.type_t.chr100,l_bggostus.type_t.chr100,l_curr.type_t.chr1,bggoseq.bggo_t.bggoseq,l_bggo007_2_desc.type_t.chr100,l_bggo009_desc.type_t.chr100,l_bggo012_desc.type_t.chr100,l_bggo013_desc.type_t.chr100,l_bggo014_desc.type_t.chr100,l_bggo015_desc.type_t.chr30,l_bggo016_desc.type_t.chr100,l_bggo017_desc.type_t.chr100,l_bggo018_desc.type_t.chr100,l_bggo019_desc.type_t.chr100,l_bggo020_desc.type_t.chr100,l_bggo021_desc.type_t.chr100,l_bggo022_desc.type_t.chr100,l_bggo023_desc.type_t.chr100,l_bggo024_desc.type_t.chr100,bggo100.bggo_t.bggo100,l_bggo106.bggo_t.bggo106,l_amt.bggo_t.bggo106,l_bggo039_desc.type_t.chr100,l_bggo040_desc.type_t.chr100" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   LET g_sql = " l_bggoseq.bggo_t.bggoseq,bggo007_desc.type_t.chr100,bggo041_desc.type_t.chr100,bggo042_desc.type_t.chr100,bggo043_desc.type_t.chr100,bggo044_desc.type_t.chr100,bggo012_desc.type_t.chr100,bggo013_desc.type_t.chr100,bggo014_desc.type_t.chr100,bggo015_desc.type_t.chr100,bggo016_desc.type_t.chr100,bggo017_desc.type_t.chr100,bggo018_desc.type_t.chr100,bggo019_desc.type_t.chr100,bggo020_desc.type_t.chr100,bggo021_desc.type_t.chr100,bggo022_desc.type_t.chr100,bggo023_desc.type_t.chr500,bggo024_desc.type_t.chr100, ",
               " l_use1.bggo_t.bggo035,l_accept1.bggo_t.bggo106,l_amt1.type_t.num20_6,l_use2.bggo_t.bggo035,l_accept2.bggo_t.bggo106,l_amt2.type_t.num20_6,l_use3.bggo_t.bggo035,l_accept3.bggo_t.bggo106,l_amt3.type_t.num20_6,l_use4.bggo_t.bggo035,l_accept4.bggo_t.bggo106,l_amt4.type_t.num20_6,l_use5.bggo_t.bggo035,l_accept5.bggo_t.bggo106,l_amt5.type_t.num20_6,l_use6.bggo_t.bggo035,l_accept6.bggo_t.bggo106,l_amt6.type_t.num20_6, ",
               " l_use7.bggo_t.bggo035,l_accept7.bggo_t.bggo106,l_amt7.type_t.num20_6,l_use8.bggo_t.bggo035,l_accept8.bggo_t.bggo106,l_amt8.type_t.num20_6,l_use9.bggo_t.bggo035,l_accept9.bggo_t.bggo106,l_amt9.type_t.num20_6,l_use10.bggo_t.bggo035,l_accept10.bggo_t.bggo106,l_amt10.type_t.num20_6,l_use11.bggo_t.bggo035,l_accept11.bggo_t.bggo106,l_amt11.type_t.num20_6,l_use12.bggo_t.bggo035,l_accept12.bggo_t.bggo106,l_amt12.type_t.num20_6,l_use13.bggo_t.bggo035,l_accept13.bggo_t.bggo106,l_amt13.type_t.num20_6,l_bggoseq2.bggo_t.bggoseq"            
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'            
   END IF
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abgq710_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abgq710_x01_ins_prep()
DEFINE i              INTEGER
DEFINE l_prep_str     STRING
#add-point:ins_prep.define (客製用) name="ins_prep.define_customerization"

#end add-point:ins_prep.define
#add-point:ins_prep.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_prep.define"

#end add-point:ins_prep.define
 
   FOR i = 1 TO g_rep_tmpname.getLength()
      CALL cl_xg_del_data(g_rep_tmpname[i])
      #LET g_sql = g_rep_ins_prep[i]              #透過此lib取得prepare字串 lib精簡
      CASE i
         WHEN 1
         #INSERT INTO PREP
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," VALUES(?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
         PREPARE insert_prep FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep",i
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL cl_xg_drop_tmptable()
            LET g_rep_success = 'N'           
         END IF 
         #add-point:insert_prep段 name="insert_prep"
         WHEN 2
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED,
                     " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, ",  
                     "        ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, ",
                     "        ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?    ) "
         PREPARE insert_prep1 FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep1",i
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL cl_xg_drop_tmptable()
            LET g_rep_success = 'N'           
         END IF 
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="abgq710_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgq710_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"

#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT '',bggo003,'','','','','','','',bggoseq,'','','','','','','','','','','', 
       '','','','',bggo100,'','','',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM bggo_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("bggo_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", g_tmp_table CLIPPED," ORDER BY bggoseq "
   #end add-point
   PREPARE abgq710_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abgq710_x01_curs CURSOR FOR abgq710_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abgq710_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abgq710_x01_ins_data()
DEFINE sr RECORD 
   l_bggo002_desc LIKE type_t.chr100, 
   bggo003 LIKE bggo_t.bggo003, 
   l_bggo007_desc LIKE type_t.chr100, 
   l_lowersite LIKE type_t.chr1, 
   l_bgaa003 LIKE bgaa_t.bgaa003, 
   l_bggo001 LIKE type_t.chr100, 
   l_type_desc LIKE type_t.chr100, 
   l_bggostus LIKE type_t.chr100, 
   l_curr LIKE type_t.chr1, 
   bggoseq LIKE bggo_t.bggoseq, 
   l_bggo007_2_desc LIKE type_t.chr100, 
   l_bggo009_desc LIKE type_t.chr100, 
   l_bggo012_desc LIKE type_t.chr100, 
   l_bggo013_desc LIKE type_t.chr100, 
   l_bggo014_desc LIKE type_t.chr100, 
   l_bggo015_desc LIKE type_t.chr30, 
   l_bggo016_desc LIKE type_t.chr100, 
   l_bggo017_desc LIKE type_t.chr100, 
   l_bggo018_desc LIKE type_t.chr100, 
   l_bggo019_desc LIKE type_t.chr100, 
   l_bggo020_desc LIKE type_t.chr100, 
   l_bggo021_desc LIKE type_t.chr100, 
   l_bggo022_desc LIKE type_t.chr100, 
   l_bggo023_desc LIKE type_t.chr100, 
   l_bggo024_desc LIKE type_t.chr100, 
   bggo100 LIKE bggo_t.bggo100, 
   l_bggo106 LIKE bggo_t.bggo106, 
   l_amt LIKE bggo_t.bggo106, 
   l_bggo039_desc LIKE type_t.chr100, 
   l_bggo040_desc LIKE type_t.chr100
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_sql              STRING
DEFINE sr1                RECORD 
        l_bggoseq      LIKE bggo_t.bggoseq,
        bggo007_desc   LIKE type_t.chr100, 
        bggo041_desc   LIKE type_t.chr100,
        bggo042_desc   LIKE type_t.chr100,
        bggo043_desc   LIKE type_t.chr100,
        bggo044_desc   LIKE type_t.chr100,
        bggo012_desc   LIKE type_t.chr100, 
        bggo013_desc   LIKE type_t.chr100, 
        bggo014_desc   LIKE type_t.chr100,        
        bggo015_desc   LIKE type_t.chr100, 
        bggo016_desc   LIKE type_t.chr100, 
        bggo017_desc   LIKE type_t.chr100, 
        bggo018_desc   LIKE type_t.chr100, 
        bggo019_desc   LIKE type_t.chr100, 
        bggo020_desc   LIKE type_t.chr100, 
        bggo021_desc   LIKE type_t.chr100, 
        bggo022_desc   LIKE bggo_t.bggo022, 
        bggo023_desc   LIKE type_t.chr500, 
        bggo024_desc   LIKE type_t.chr100, 
        l_use1         LIKE bggo_t.bggo035,
        l_accept1      LIKE bggo_t.bggo106, 
        l_amt1         LIKE type_t.num20_6, 
        l_use2         LIKE bggo_t.bggo035,
        l_accept2      LIKE bggo_t.bggo106, 
        l_amt2         LIKE type_t.num20_6, 
        l_use3         LIKE bggo_t.bggo035,
        l_accept3      LIKE bggo_t.bggo106, 
        l_amt3         LIKE type_t.num20_6, 
        l_use4         LIKE bggo_t.bggo035,
        l_accept4      LIKE bggo_t.bggo106, 
        l_amt4         LIKE type_t.num20_6, 
        l_use5         LIKE bggo_t.bggo035,
        l_accept5      LIKE bggo_t.bggo106, 
        l_amt5         LIKE type_t.num20_6, 
        l_use6         LIKE bggo_t.bggo035,
        l_accept6      LIKE bggo_t.bggo106, 
        l_amt6         LIKE type_t.num20_6, 
        l_use7         LIKE bggo_t.bggo035,
        l_accept7      LIKE bggo_t.bggo106, 
        l_amt7         LIKE type_t.num20_6, 
        l_use8         LIKE bggo_t.bggo035,
        l_accept8      LIKE bggo_t.bggo106, 
        l_amt8         LIKE type_t.num20_6, 
        l_use9         LIKE bggo_t.bggo035,
        l_accept9      LIKE bggo_t.bggo106, 
        l_amt9         LIKE type_t.num20_6, 
        l_use10        LIKE bggo_t.bggo035,
        l_accept10     LIKE bggo_t.bggo106, 
        l_amt10        LIKE type_t.num20_6, 
        l_use11        LIKE bggo_t.bggo035,
        l_accept11     LIKE bggo_t.bggo106, 
        l_amt11        LIKE type_t.num20_6, 
        l_use12        LIKE bggo_t.bggo035,
        l_accept12     LIKE bggo_t.bggo106, 
        l_amt12        LIKE type_t.num20_6, 
        l_use13        LIKE bggo_t.bggo035,
        l_accept13     LIKE bggo_t.bggo106, 
        l_amt13        LIKE type_t.num20_6,
        l_bggoseq2    LIKE bggo_t.bggoseq
END RECORD
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_sql = " SELECT * FROM ",g_tmp_table1 CLIPPED," WHERE bggoseq2 = ? ORDER BY bggoseq2,bggoseq "
    PREPARE abgq710_x01_prepare1 FROM l_sql
    DECLARE abgq710_x01_subcurs CURSOR FOR abgq710_x01_prepare1   
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abgq710_x01_curs INTO sr.*                               
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段foreach name="ins_data.foreach"
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_bggo002_desc,sr.bggo003,sr.l_bggo007_desc,sr.l_lowersite,sr.l_bgaa003,sr.l_bggo001,sr.l_type_desc,sr.l_bggostus,sr.l_curr,sr.bggoseq,sr.l_bggo007_2_desc,sr.l_bggo009_desc,sr.l_bggo012_desc,sr.l_bggo013_desc,sr.l_bggo014_desc,sr.l_bggo015_desc,sr.l_bggo016_desc,sr.l_bggo017_desc,sr.l_bggo018_desc,sr.l_bggo019_desc,sr.l_bggo020_desc,sr.l_bggo021_desc,sr.l_bggo022_desc,sr.l_bggo023_desc,sr.l_bggo024_desc,sr.bggo100,sr.l_bggo106,sr.l_amt,sr.l_bggo039_desc,sr.l_bggo040_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abgq710_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       FOREACH abgq710_x01_subcurs USING sr.bggoseq INTO sr1.*  
          IF cl_null(sr1.l_use13) THEN LET sr1.l_use13 = 0 END IF
          IF cl_null(sr1.l_accept13) THEN LET sr1.l_accept13 = 0 END IF
          IF cl_null(sr1.l_amt13) THEN LET sr1.l_amt13 = 0 END IF
          EXECUTE insert_prep1 USING sr1.l_bggoseq,sr1.bggo007_desc,sr1.bggo041_desc,sr1.bggo042_desc,sr1.bggo043_desc,sr1.bggo044_desc,
                                     sr1.bggo012_desc,sr1.bggo013_desc,sr1.bggo014_desc,sr1.bggo015_desc,sr1.bggo016_desc,sr1.bggo017_desc,
                                     sr1.bggo018_desc,sr1.bggo019_desc,sr1.bggo020_desc,sr1.bggo021_desc,sr1.bggo022_desc,sr1.bggo023_desc,
                                     sr1.bggo024_desc,
                                     sr1.l_use1,sr1.l_accept1,sr1.l_amt1,sr1.l_use2,sr1.l_accept2,sr1.l_amt2,     
                                     sr1.l_use3,sr1.l_accept3,sr1.l_amt3,sr1.l_use4,sr1.l_accept4,sr1.l_amt4,     
                                     sr1.l_use5,sr1.l_accept5,sr1.l_amt5,sr1.l_use6,sr1.l_accept6,sr1.l_amt6,     
                                     sr1.l_use7,sr1.l_accept7,sr1.l_amt7,sr1.l_use8,sr1.l_accept8,sr1.l_amt8,     
                                     sr1.l_use9,sr1.l_accept9,sr1.l_amt9,
                                     sr1.l_use10,sr1.l_accept10,sr1.l_amt10,sr1.l_use11,sr1.l_accept11,sr1.l_amt11,
                                     sr1.l_use12,sr1.l_accept12,sr1.l_amt12,sr1.l_use13,sr1.l_accept13,sr1.l_amt13,sr1.l_bggoseq2
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "insert_prep1"
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.popup  = FALSE
             CALL cl_err()       
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF 
       END FOREACH
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    LET g_xgrid.visible_column = tm.a3
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgq710_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abgq710_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="abgq710_x01.other_function" readonly="Y" >}

 
{</section>}
 
