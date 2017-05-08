#該程式未解開Section, 採用最新樣板產出!
{<section id="aslr508_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-11-21 16:55:06), PR版次:0001(2016-11-21 09:21:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aslr508_x01
#+ Description: ...
#+ Creator....: 06814(2016-11-18 16:07:11)
#+ Modifier...: 06814 -SD/PR- 06814
 
{</section>}
 
{<section id="aslr508_x01.global" readonly="Y" >}
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
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aslr508_x01.main" readonly="Y" >}
PUBLIC FUNCTION aslr508_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aslr508_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aslr508_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aslr508_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aslr508_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aslr508_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aslr508_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aslr508_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aslr508_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "rtiaent.rtia_t.rtiaent,gzoul003.gzoul_t.gzoul003,rtiasite.rtia_t.rtiasite,ooefl_t_ooefl003.ooefl_t.ooefl003,imaa_t_imaa154.imaa_t.imaa154,l_range.type_t.chr500,rtib_t_rtib012.rtib_t.rtib012,rtib_t_rtib021.rtib_t.rtib021,l_money.type_t.num20" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aslr508_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aslr508_x01_ins_prep()
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
 
{<section id="aslr508_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aslr508_x01_sel_prep()
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
   LET g_select = " SELECT rtiaent ,(SELECT gzoul003 ",
                  "                    FROM gzoul_t ",
                  "                   WHERE gzoul001 = rtiaent ",
                  "                     AND gzoul002 = '",g_dlang,"') rtiaent_desc, ",
                  "        rtiasite,(SELECT ooefl003 ",
                  "                    FROM ooefl_t ",
                  "                   WHERE ooeflent = rtiaent ",
                  "                     AND ooefl001 = rtiasite ",
                  "                     AND ooefl002 = '",g_dlang,"') rtiasite_desc, ",
                  "        imaa154,",
                  #折扣段
                  "CASE ",
                  "    WHEN (COALESCE(rtib008,0)= 0 ) OR (COALESCE(rtib010,0) >= COALESCE(rtib008,0)) THEN '100%'       ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0    AND (COALESCE(rtib010,0)/rtib008) <0.05 THEN '0%-4%'   ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.05 AND (COALESCE(rtib010,0)/rtib008) <0.10 THEN '5%-9%'   ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.10 AND (COALESCE(rtib010,0)/rtib008) <0.15 THEN '10%-14%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.15 AND (COALESCE(rtib010,0)/rtib008) <0.20 THEN '15%-19%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.20 AND (COALESCE(rtib010,0)/rtib008) <0.25 THEN '20%-24%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.25 AND (COALESCE(rtib010,0)/rtib008) <0.30 THEN '25%-29%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.30 AND (COALESCE(rtib010,0)/rtib008) <0.35 THEN '30%-34%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.35 AND (COALESCE(rtib010,0)/rtib008) <0.40 THEN '35%-39%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.40 AND (COALESCE(rtib010,0)/rtib008) <0.45 THEN '40%-44%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.45 AND (COALESCE(rtib010,0)/rtib008) <0.50 THEN '45%-49%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.50 AND (COALESCE(rtib010,0)/rtib008) <0.55 THEN '50%-54%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.55 AND (COALESCE(rtib010,0)/rtib008) <0.60 THEN '55%-59%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.60 AND (COALESCE(rtib010,0)/rtib008) <0.65 THEN '60%-64%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.65 AND (COALESCE(rtib010,0)/rtib008) <0.70 THEN '65%-69%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.70 AND (COALESCE(rtib010,0)/rtib008) <0.75 THEN '70%-74%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.75 AND (COALESCE(rtib010,0)/rtib008) <0.80 THEN '75%-79%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.80 AND (COALESCE(rtib010,0)/rtib008) <0.85 THEN '80%-84%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.85 AND (COALESCE(rtib010,0)/rtib008) <0.90 THEN '85%-89%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.90 AND (COALESCE(rtib010,0)/rtib008) <0.95 THEN '90%-94%' ",
                  "    WHEN (COALESCE(rtib010,0)/rtib008) >=0.95 AND (COALESCE(rtib010,0)/rtib008) <1.00 THEN '95%-99%' ", 
                  " END, ",
                  #       销售数量：(数量rtib012) ,营业金额:(销售金额rtib021) ,营业吊牌金额：（数量rtib012*标准售价rtib008）   
                  "        COALESCE(rtib012,0) , COALESCE(rtib021,0), COALESCE(rtib012,0)*COALESCE(rtib008,0) "
#   #end add-point
#   LET g_select = " SELECT rtiaent,gzoul003,rtiasite,ooefl_t.ooefl003,imaa_t.imaa154,NULL,rtib_t.rtib012, 
#       rtib_t.rtib021,0"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM rtia_t LEFT JOIN rtib_t ON rtiaent = rtibent AND rtiadocno = rtibdocno ",
                "             LEFT JOIN imaa_t ON imaaent = rtibent AND imaa001 = rtib004 " 
#   #end add-point
#    LET g_from = " FROM rtia_t,gzoul_t,ooefl_t,rtib_t,imaa_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE " ,tm.wc ," AND rtiaent = ",g_enterprise
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("rtia_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   DISPLAY "g_sql:",g_sql
   #end add-point
   PREPARE aslr508_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aslr508_x01_curs CURSOR FOR aslr508_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aslr508_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aslr508_x01_ins_data()
DEFINE sr RECORD 
   rtiaent LIKE rtia_t.rtiaent, 
   gzoul003 LIKE gzoul_t.gzoul003, 
   rtiasite LIKE rtia_t.rtiasite, 
   ooefl_t_ooefl003 LIKE ooefl_t.ooefl003, 
   imaa_t_imaa154 LIKE imaa_t.imaa154, 
   l_range LIKE type_t.chr500, 
   rtib_t_rtib012 LIKE rtib_t.rtib012, 
   rtib_t_rtib021 LIKE rtib_t.rtib021, 
   l_money LIKE type_t.num20
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aslr508_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.rtiaent,sr.gzoul003,sr.rtiasite,sr.ooefl_t_ooefl003,sr.imaa_t_imaa154,sr.l_range,sr.rtib_t_rtib012,sr.rtib_t_rtib021,sr.l_money
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aslr508_x01_execute"
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
 
{<section id="aslr508_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aslr508_x01_rep_data()
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
 
{<section id="aslr508_x01.other_function" readonly="Y" >}

 
{</section>}
 
