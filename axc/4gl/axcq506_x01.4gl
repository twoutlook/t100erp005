#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq506_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-05-20 17:14:15), PR版次:0004(2016-05-20 18:17:43)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: axcq506_x01
#+ Description: 杂项入库成本报表作业
#+ Creator....: 03297(2015-04-02 14:00:54)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="axcq506_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160321-00036#1  2016/04/27  By  dorislai xcck282a~xcck282h(本期異動單價-材料~製費五)，隨著Q類單頭的"展開/隱藏成本要素明細"而顯示或隱藏
#160520-00004#2  2016/05/20  By  dorislai 效能改善，mark掉FOREACH裡面的程式
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
       wc STRING,                  #qbe 
       tmp STRING,                  #tmptable 
       show LIKE type_t.chr1          #成本要素顯隱
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_range LIKE type_t.chr1  #成本域
DEFINE g_spec  LIKE type_t.chr1  #特性
#end add-point
 
{</section>}
 
{<section id="axcq506_x01.main" readonly="Y" >}
PUBLIC FUNCTION axcq506_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  qbe 
DEFINE  p_arg2 STRING                  #tm.tmp  tmptable 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.show  成本要素顯隱
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.tmp = p_arg2
   LET tm.show = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_range   #采用成本域否
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_spec  #采用特性否
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axcq506_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axcq506_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axcq506_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axcq506_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axcq506_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axcq506_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq506_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axcq506_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "imag011.type_t.chr10,imag011_desc.type_t.chr500,xcck002.xcck_t.xcck002,xcck002_desc.type_t.chr500,xcck025.xcck_t.xcck025,xcck025_desc.type_t.chr500,xcck021.xcck_t.xcck021,xcck021_desc.type_t.chr500,xcck006.xcck_t.xcck006,inba008.type_t.chr500,xcck007.xcck_t.xcck007,xcck008.xcck_t.xcck008,xcck009.xcck_t.xcck009,xcck013.xcck_t.xcck013,xcck010.xcck_t.xcck010,xcck010_desc.type_t.chr500,xcck010_desc_1.type_t.chr500,xcck011.xcck_t.xcck011,xcck015.xcck_t.xcck015,xcck015_desc.type_t.chr500,xcck017.xcck_t.xcck017,xcck044.xcck_t.xcck044,xcck044_desc.type_t.chr500,xcck040.xcck_t.xcck040,xcck040_desc.type_t.chr500,xcck042.xcck_t.xcck042,xcck201.xcck_t.xcck201,xcck282.xcck_t.xcck282,xcck282a.xcck_t.xcck282a,xcck282b.xcck_t.xcck282b,xcck282c.xcck_t.xcck282c,xcck282d.xcck_t.xcck282d,xcck282e.xcck_t.xcck282e,xcck282f.xcck_t.xcck282f,xcck282g.xcck_t.xcck282g,xcck282h.xcck_t.xcck282h,xcck202a.xcck_t.xcck202a,xcck202b.xcck_t.xcck202b,xcck202c.xcck_t.xcck202c,xcck202d.xcck_t.xcck202d,xcck202e.xcck_t.xcck202e,xcck202f.xcck_t.xcck202f,xcck202g.xcck_t.xcck202g,xcck202h.xcck_t.xcck202h,xcck202.xcck_t.xcck202,xcckcomp_desc.type_t.chr500,l_xcck004_e.type_t.chr100,l_xcck005_e.type_t.chr100,xcck003_desc.type_t.chr500,xcckld_desc.type_t.chr500,xcck001_desc.type_t.chr500,mainkey.type_t.chr500,l_sort.type_t.num5" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axcq506_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axcq506_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?)"
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
         
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="axcq506_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq506_x01_sel_prep()
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
   LET g_select =" SELECT * "
#   #end add-point
#   LET g_select = " SELECT NULL,NULL,xcck002,NULL,xcck025,NULL,xcck021,NULL,xcck006,NULL,xcck007,xcck008, 
#       xcck009,xcck013,xcck010,NULL,NULL,xcck011,xcck015,NULL,xcck017,xcck044,NULL,xcck040,NULL,xcck042, 
#       xcck201,xcck282,xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck202a, 
#       xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h,xcck202,xcckcomp,NULL,xcck004, 
#       xcck005,NULL,NULL,xcck003,NULL,xcckld,NULL,xcck001,NULL,xcckent,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from =" FROM ",tm.tmp
#   #end add-point
#    LET g_from = " FROM xcck_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xcck_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED ," ORDER BY l_count"
   #end add-point
   PREPARE axcq506_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axcq506_x01_curs CURSOR FOR axcq506_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axcq506_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axcq506_x01_ins_data()
DEFINE sr RECORD 
   imag011 LIKE type_t.chr10, 
   imag011_desc LIKE type_t.chr500, 
   xcck002 LIKE xcck_t.xcck002, 
   xcck002_desc LIKE type_t.chr500, 
   xcck025 LIKE xcck_t.xcck025, 
   xcck025_desc LIKE type_t.chr500, 
   xcck021 LIKE xcck_t.xcck021, 
   xcck021_desc LIKE type_t.chr500, 
   xcck006 LIKE xcck_t.xcck006, 
   inba008 LIKE type_t.chr500, 
   xcck007 LIKE xcck_t.xcck007, 
   xcck008 LIKE xcck_t.xcck008, 
   xcck009 LIKE xcck_t.xcck009, 
   xcck013 LIKE xcck_t.xcck013, 
   xcck010 LIKE xcck_t.xcck010, 
   xcck010_desc LIKE type_t.chr500, 
   xcck010_desc_1 LIKE type_t.chr500, 
   xcck011 LIKE xcck_t.xcck011, 
   xcck015 LIKE xcck_t.xcck015, 
   xcck015_desc LIKE type_t.chr500, 
   xcck017 LIKE xcck_t.xcck017, 
   xcck044 LIKE xcck_t.xcck044, 
   xcck044_desc LIKE type_t.chr500, 
   xcck040 LIKE xcck_t.xcck040, 
   xcck040_desc LIKE type_t.chr500, 
   xcck042 LIKE xcck_t.xcck042, 
   xcck201 LIKE xcck_t.xcck201, 
   xcck282 LIKE xcck_t.xcck282, 
   xcck282a LIKE xcck_t.xcck282a, 
   xcck282b LIKE xcck_t.xcck282b, 
   xcck282c LIKE xcck_t.xcck282c, 
   xcck282d LIKE xcck_t.xcck282d, 
   xcck282e LIKE xcck_t.xcck282e, 
   xcck282f LIKE xcck_t.xcck282f, 
   xcck282g LIKE xcck_t.xcck282g, 
   xcck282h LIKE xcck_t.xcck282h, 
   xcck202a LIKE xcck_t.xcck202a, 
   xcck202b LIKE xcck_t.xcck202b, 
   xcck202c LIKE xcck_t.xcck202c, 
   xcck202d LIKE xcck_t.xcck202d, 
   xcck202e LIKE xcck_t.xcck202e, 
   xcck202f LIKE xcck_t.xcck202f, 
   xcck202g LIKE xcck_t.xcck202g, 
   xcck202h LIKE xcck_t.xcck202h, 
   xcck202 LIKE xcck_t.xcck202, 
   xcckcomp LIKE xcck_t.xcckcomp, 
   xcckcomp_desc LIKE type_t.chr500, 
   xcck004 LIKE xcck_t.xcck004, 
   xcck005 LIKE xcck_t.xcck005, 
   l_xcck004_e LIKE type_t.chr100, 
   l_xcck005_e LIKE type_t.chr100, 
   xcck003 LIKE xcck_t.xcck003, 
   xcck003_desc LIKE type_t.chr500, 
   xcckld LIKE xcck_t.xcckld, 
   xcckld_desc LIKE type_t.chr500, 
   xcck001 LIKE xcck_t.xcck001, 
   xcck001_desc LIKE type_t.chr500, 
   xcckent LIKE xcck_t.xcckent, 
   mainkey LIKE type_t.chr500, 
   l_sort LIKE type_t.num5
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_glaa001        LIKE glaa_t.glaa001  #使用币别
DEFINE l_glaa016        LIKE glaa_t.glaa016  #本位幣二
DEFINE l_glaa020        LIKE glaa_t.glaa020  #本位幣三
DEFINE l_currency_desc  LIKE type_t.chr100
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axcq506_x01_curs INTO sr.*                               
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
       #160520-00004#2-mark-(S)
#       IF NOT cl_null(sr.xcckcomp_desc) THEN
#         LET sr.xcckcomp_desc = sr.xcckcomp,"(",sr.xcckcomp_desc CLIPPED,")"
#       ELSE
#         LET sr.xcckcomp_desc = sr.xcckcomp
#       END IF
#       
#       IF NOT cl_null(sr.xcckld_desc) THEN
#         LET sr.xcckld_desc = sr.xcckld,"(",sr.xcckld_desc CLIPPED,")"
#       ELSE
#         LET sr.xcckld_desc = sr.xcckld
#       END IF
#       
#       IF NOT cl_null(sr.xcck003_desc) THEN
#         LET sr.xcck003_desc = sr.xcck003,"(",sr.xcck003_desc CLIPPED,")"
#       ELSE
#         LET sr.xcck003_desc = sr.xcck003
#       END IF
#
#       
#      #本位顺序说明
#       SELECT gzcbl004 INTO sr.xcck001_desc FROM gzcbl_t WHERE  gzcbl001='8914' AND gzcbl002=sr.xcck001 AND gzcbl003=g_dlang  
#       LET sr.xcck001_desc=sr.xcck001,".",sr.xcck001_desc CLIPPED
#       
#       SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
#         FROM glaa_t
#         WHERE glaaent = g_enterprise
#         AND glaald  = sr.xcckld
#       CASE sr.xcck001
#          WHEN '1'
#             CALL s_desc_get_currency_desc(l_glaa001) RETURNING l_currency_desc
#          WHEN '2'
#             CALL s_desc_get_currency_desc(l_glaa016) RETURNING l_currency_desc
#          WHEN '3'
#             CALL s_desc_get_currency_desc(l_glaa020) RETURNING l_currency_desc
#       END CASE
#       IF NOT cl_null(l_currency_desc) THEN
#          LET sr.xcck001_desc=sr.xcck001_desc,'(',l_currency_desc,')'
#       END IF
       #160520-00004#2-mark-(E)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.imag011,sr.imag011_desc,sr.xcck002,sr.xcck002_desc,sr.xcck025,sr.xcck025_desc,sr.xcck021,sr.xcck021_desc,sr.xcck006,sr.inba008,sr.xcck007,sr.xcck008,sr.xcck009,sr.xcck013,sr.xcck010,sr.xcck010_desc,sr.xcck010_desc_1,sr.xcck011,sr.xcck015,sr.xcck015_desc,sr.xcck017,sr.xcck044,sr.xcck044_desc,sr.xcck040,sr.xcck040_desc,sr.xcck042,sr.xcck201,sr.xcck282,sr.xcck282a,sr.xcck282b,sr.xcck282c,sr.xcck282d,sr.xcck282e,sr.xcck282f,sr.xcck282g,sr.xcck282h,sr.xcck202a,sr.xcck202b,sr.xcck202c,sr.xcck202d,sr.xcck202e,sr.xcck202f,sr.xcck202g,sr.xcck202h,sr.xcck202,sr.xcckcomp_desc,sr.l_xcck004_e,sr.l_xcck005_e,sr.xcck003_desc,sr.xcckld_desc,sr.xcck001_desc,sr.mainkey,sr.l_sort
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axcq506_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    #160321-00036#1-add-(S)
    #隱藏成本要素的那些欄位
    IF tm.show = 'N' THEN
       LET g_xgrid.visible_column = "xcck282a|xcck282b|xcck282c|xcck282d|xcck282e|xcck282f|xcck282g|xcck282h"
    END IF
    #160321-00036#1-add-(E)
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq506_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axcq506_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    #动态隐藏 成本域 或 特性
    IF g_range = 'N' THEN
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcck002|xcck002_desc"
    END IF
    IF g_spec ='N' THEN
       LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED,"|xcck011"
    END IF 
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="axcq506_x01.other_function" readonly="Y" >}

 
{</section>}
 