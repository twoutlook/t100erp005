#該程式未解開Section, 採用最新樣板產出!
{<section id="abgq920_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-12-22 17:44:19), PR版次:0001(2016-12-22 19:09:21)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgq920_x01
#+ Description: ...
#+ Creator....: 06821(2016-12-21 17:53:50)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="abgq920_x01.global" readonly="Y" >}
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
       a1 STRING,                  #abgq920_x01_tmp 
       a2 STRING,                  #abgq920_x01_tmp1 
       a3 STRING                   #xgrid_visible
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
 
{<section id="abgq920_x01.main" readonly="Y" >}
PUBLIC FUNCTION abgq920_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.a1  abgq920_x01_tmp 
DEFINE  p_arg3 STRING                  #tm.a2  abgq920_x01_tmp1 
DEFINE  p_arg4 STRING                  #tm.a3  xgrid_visible
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
   LET g_rep_code = "abgq920_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL abgq920_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL abgq920_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL abgq920_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL abgq920_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL abgq920_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="abgq920_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION abgq920_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_bgie001_desc.type_t.chr100,bgie002.bgie_t.bgie002,l_bgie003_desc.type_t.chr100,l_lowersite.type_t.chr1,l_bgie033_desc.type_t.chr100,l_bgap004_desc.type_t.chr100,l_bgaa003.type_t.chr100,l_curr_desc.type_t.chr100,l_periods_desc.type_t.chr100,bgieseq.bgie_t.bgieseq,l_bgie0032_desc.type_t.chr100,l_bgie004_desc.type_t.chr100,l_bgie007_desc.type_t.chr100,l_bgie008_desc.type_t.chr100,l_bgie009_desc.type_t.chr100,l_bgie010_desc.type_t.chr100,l_bgie011_desc.type_t.chr100,l_bgie012_desc.type_t.chr100,l_bgie013_desc.type_t.chr100,l_bgie014_desc.type_t.chr100,l_bgie015_desc.type_t.chr100,l_bgie016_desc.type_t.chr100,l_bgie017_desc.type_t.chr100,l_bgie018_desc.type_t.chr100,l_bgie019_desc.type_t.chr100,bgie100.bgie_t.bgie100,l_begin_amt.type_t.num20_6,l_bgie103_d.type_t.num20_6,l_bgie103_c.type_t.num20_6,l_sum.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   LET g_sql = "l_bgieseq2.bgie_t.bgieseq,l_bgieseq.bgie_t.bgieseq,l_bgie003_2_desc.type_t.chr100,l_begin_amt1.type_t.num20_6,l_amt_1.type_t.num20_6,l_amt_2.type_t.num20_6,l_amt_3.type_t.num20_6,l_amt_4.type_t.num20_6,l_amt_5.type_t.num20_6,l_amt_6.type_t.num20_6,l_amt_7.type_t.num20_6,l_amt_8.type_t.num20_6,l_amt_9.type_t.num20_6,l_amt_10.type_t.num20_6,l_amt_11.type_t.num20_6,l_amt_12.type_t.num20_6,l_amt_13.type_t.num20_6,l_amt_14.type_t.num20_6,l_amt_sum.type_t.num20_6"
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'            
   END IF
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="abgq920_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION abgq920_x01_ins_prep()
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
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED," VALUES(?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="abgq920_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgq920_x01_sel_prep()
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
   LET g_select = " SELECT bgieent,'',bgie002,'','','','','','','',bgieseq,'','','','','','','','','', 
       '','','','','','',bgie100,'','','',''"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM bgie_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("bgie_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", g_tmp_table CLIPPED," ORDER BY bgieseq "
   #end add-point
   PREPARE abgq920_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE abgq920_x01_curs CURSOR FOR abgq920_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="abgq920_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION abgq920_x01_ins_data()
DEFINE sr RECORD 
   bgieent LIKE bgie_t.bgieent, 
   l_bgie001_desc LIKE type_t.chr100, 
   bgie002 LIKE bgie_t.bgie002, 
   l_bgie003_desc LIKE type_t.chr100, 
   l_lowersite LIKE type_t.chr1, 
   l_bgie033_desc LIKE type_t.chr100, 
   l_bgap004_desc LIKE type_t.chr100, 
   l_bgaa003 LIKE type_t.chr100, 
   l_curr_desc LIKE type_t.chr100, 
   l_periods_desc LIKE type_t.chr100, 
   bgieseq LIKE bgie_t.bgieseq, 
   l_bgie0032_desc LIKE type_t.chr100, 
   l_bgie004_desc LIKE type_t.chr100, 
   l_bgie007_desc LIKE type_t.chr100, 
   l_bgie008_desc LIKE type_t.chr100, 
   l_bgie009_desc LIKE type_t.chr100, 
   l_bgie010_desc LIKE type_t.chr100, 
   l_bgie011_desc LIKE type_t.chr100, 
   l_bgie012_desc LIKE type_t.chr100, 
   l_bgie013_desc LIKE type_t.chr100, 
   l_bgie014_desc LIKE type_t.chr100, 
   l_bgie015_desc LIKE type_t.chr100, 
   l_bgie016_desc LIKE type_t.chr100, 
   l_bgie017_desc LIKE type_t.chr100, 
   l_bgie018_desc LIKE type_t.chr100, 
   l_bgie019_desc LIKE type_t.chr100, 
   bgie100 LIKE bgie_t.bgie100, 
   l_begin_amt LIKE type_t.num20_6, 
   l_bgie103_d LIKE type_t.num20_6, 
   l_bgie103_c LIKE type_t.num20_6, 
   l_sum LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_sql              STRING
DEFINE sr1                RECORD 
         l_bgieseq2       LIKE bgie_t.bgieseq, #連接第一單身
         l_bgieseq        LIKE bgie_t.bgieseq, 
         l_bgie003_2_desc LIKE type_t.chr100, 
         l_begin_amt1     LIKE type_t.num20_6,
         l_amt_1          LIKE type_t.num20_6, 
         l_amt_2          LIKE type_t.num20_6, 
         l_amt_3          LIKE type_t.num20_6, 
         l_amt_4          LIKE type_t.num20_6, 
         l_amt_5          LIKE type_t.num20_6, 
         l_amt_6          LIKE type_t.num20_6, 
         l_amt_7          LIKE type_t.num20_6, 
         l_amt_8          LIKE type_t.num20_6, 
         l_amt_9          LIKE type_t.num20_6, 
         l_amt_10         LIKE type_t.num20_6, 
         l_amt_11         LIKE type_t.num20_6, 
         l_amt_12         LIKE type_t.num20_6, 
         l_amt_13         LIKE type_t.num20_6, 
         l_amt_14         LIKE type_t.num20_6, 
         l_amt_sum        LIKE type_t.num20_6
                          END RECORD
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_sql = " SELECT * FROM ",g_tmp_table1 CLIPPED," WHERE l_bgieseq2 = ? ORDER BY l_bgieseq2,l_bgieseq "
    PREPARE abgq920_x01_prepare1 FROM l_sql
    DECLARE abgq920_x01_subcurs CURSOR FOR abgq920_x01_prepare1    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH abgq920_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.l_bgie001_desc,sr.bgie002,sr.l_bgie003_desc,sr.l_lowersite,sr.l_bgie033_desc,sr.l_bgap004_desc,sr.l_bgaa003,sr.l_curr_desc,sr.l_periods_desc,sr.bgieseq,sr.l_bgie0032_desc,sr.l_bgie004_desc,sr.l_bgie007_desc,sr.l_bgie008_desc,sr.l_bgie009_desc,sr.l_bgie010_desc,sr.l_bgie011_desc,sr.l_bgie012_desc,sr.l_bgie013_desc,sr.l_bgie014_desc,sr.l_bgie015_desc,sr.l_bgie016_desc,sr.l_bgie017_desc,sr.l_bgie018_desc,sr.l_bgie019_desc,sr.bgie100,sr.l_begin_amt,sr.l_bgie103_d,sr.l_bgie103_c,sr.l_sum
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "abgq920_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       FOREACH abgq920_x01_subcurs USING sr.bgieseq INTO sr1.* 
 
          EXECUTE insert_prep1 USING sr1.l_bgieseq2,sr1.l_bgieseq,sr1.l_bgie003_2_desc,sr1.l_begin_amt1,
                                     sr1.l_amt_1,sr1.l_amt_2,sr1.l_amt_3,sr1.l_amt_4, 
                                     sr1.l_amt_5,sr1.l_amt_6,sr1.l_amt_7,sr1.l_amt_8,
                                     sr1.l_amt_9,sr1.l_amt_10,sr1.l_amt_11,sr1.l_amt_12,
                                     sr1.l_amt_13,sr1.l_amt_14,sr1.l_amt_sum                                                           
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
 
{<section id="abgq920_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION abgq920_x01_rep_data()
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
 
{<section id="abgq920_x01.other_function" readonly="Y" >}

 
{</section>}
 
