#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr741_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-03-07 17:22:46), PR版次:0001(2016-03-07 17:29:39)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: acrr741_x01
#+ Description: ...
#+ Creator....: 01533(2014-09-29 14:56:34)
#+ Modifier...: 02003 -SD/PR- 02003
 
{</section>}
 
{<section id="acrr741_x01.global" readonly="Y" >}
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
       date1 LIKE type_t.dat,         #開始日期 
       date2 LIKE type_t.dat          #結束日期
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="acrr741_x01.main" readonly="Y" >}
PUBLIC FUNCTION acrr741_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.dat         #tm.date1  開始日期 
DEFINE  p_arg3 LIKE type_t.dat         #tm.date2  結束日期
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.date1 = p_arg2
   LET tm.date2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "acrr741_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL acrr741_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL acrr741_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL acrr741_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL acrr741_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL acrr741_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr741_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION acrr741_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "deca002.deca_t.deca002,decasite.deca_t.decasite,l_deca020_mmaf008.type_t.chr500,l_rtab001_rtaal003.type_t.chr500,l_decasite_ooefl003.type_t.chr500,l_deca016_rtaxl003.type_t.chr500,l_amount.type_t.num20_6,l_profits.type_t.num20_6,l_num.type_t.num20,l_count.type_t.num5,l_price.type_t.num20_6,l_num1.type_t.num15_3" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="acrr741_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION acrr741_x01_ins_prep()
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
             ?,?,?,?,?,?)"
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
 
{<section id="acrr741_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr741_x01_sel_prep()
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
   LET g_select = " SELECT deca002,decasite,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT deca002,decasite,TRIM(deca020)||'.'||TRIM(mmaf008),TRIM(rtab001)||'.'||TRIM(rtaal003),",
                  "        TRIM(decasite)||'.'||TRIM(ooefl003),TRIM(deca016)||'.'||TRIM(rtaxl003),",
                  "        SUM(deca027),SUM(deca028), SUM(deca022),SUM(deca031),SUM(deca027)/SUM(deca031),",
                  "         SUM(deca022)/SUM(deca031)"
                
   #end add-point
    LET g_from = " FROM deca_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
    LET g_from = g_from," LEFT OUTER JOIN rtab_t ON decasite = rtab002 ",
                  "  AND decaent = rtabent AND EXISTS(SELECT 1 FROM rtak_t WHERE rtakent = rtabent AND rtak001 = rtab001 AND rtak002 = '1' AND rtak003 = 'Y') ",  #add by yangxf 20160224
                  "                     LEFT OUTER JOIN rtaal_t ON rtabent = rtaalent AND rtab001 = rtaal001 AND rtaal002 = '",g_dlang,"'",
                  "                     LEFT OUTER JOIN mmaf_t ON deca020 = mmaf001 ",
                  "                                            AND decaent = mmafent ",   #add by yangxf 20160224 
                  "                     LEFT OUTER JOIN ooefl_t ON decaent = ooeflent AND decasite = ooefl001 AND ooefl002 = '",g_dlang,"'",
                  "                     LEFT OUTER JOIN rtaxl_t ON decaent = rtaxlent AND deca016 = rtaxl001 AND rtaxl002 = '",g_dlang,"'"
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = g_where," AND decaent = ",g_enterprise
   IF NOT cl_null(tm.date1) THEN 
      LET g_where = g_where," AND deca002 >= '",tm.date1,"'"
   END IF 
   IF NOT cl_null(tm.date2) THEN 
      LET g_where = g_where," AND deca002 <= '",tm.date2,"'"
   END IF 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("deca_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql," GROUP BY deca002,decasite,TRIM(deca020)||'.'||TRIM(mmaf008),TRIM(rtab001)||'.'||TRIM(rtaal003),",
                     "        TRIM(decasite)||'.'||TRIM(ooefl003),TRIM(deca016)||'.'||TRIM(rtaxl003)",
                     " ORDER BY deca002,decasite,TRIM(deca020)||'.'||TRIM(mmaf008),TRIM(rtab001)||'.'||TRIM(rtaal003),",
                     "        TRIM(decasite)||'.'||TRIM(ooefl003),TRIM(deca016)||'.'||TRIM(rtaxl003)"
   #end add-point
   PREPARE acrr741_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE acrr741_x01_curs CURSOR FOR acrr741_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr741_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr741_x01_ins_data()
DEFINE sr RECORD 
   deca002 LIKE deca_t.deca002, 
   decasite LIKE deca_t.decasite, 
   l_deca020_mmaf008 LIKE type_t.chr500, 
   l_rtab001_rtaal003 LIKE type_t.chr500, 
   l_decasite_ooefl003 LIKE type_t.chr500, 
   l_deca016_rtaxl003 LIKE type_t.chr500, 
   l_amount LIKE type_t.num20_6, 
   l_profits LIKE type_t.num20_6, 
   l_num LIKE type_t.num20, 
   l_count LIKE type_t.num5, 
   l_price LIKE type_t.num20_6, 
   l_num1 LIKE type_t.num15_3
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH acrr741_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.deca002,sr.decasite,sr.l_deca020_mmaf008,sr.l_rtab001_rtaal003,sr.l_decasite_ooefl003,sr.l_deca016_rtaxl003,sr.l_amount,sr.l_profits,sr.l_num,sr.l_count,sr.l_price,sr.l_num1
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "acrr741_x01_execute"
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
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrr741_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr741_x01_rep_data()
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
 
{<section id="acrr741_x01.other_function" readonly="Y" >}

 
{</section>}
 
