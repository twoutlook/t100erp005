#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq730_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-06-02 10:31:56), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: aglq730_x01
#+ Description: ...
#+ Creator....: 01727(2015-06-01 09:55:21)
#+ Modifier...: 01531 -SD/PR- 00000
 
{</section>}
 
{<section id="aglq730_x01.global" readonly="Y" >}
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
       a1 LIKE type_t.chr20,         #臨時表名稱 
       a2 LIKE type_t.num5,         #hide_flag 
       a3 LIKE type_t.num5          #curr_flag
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_tmp_table     STRING
#end add-point
 
{</section>}
 
{<section id="aglq730_x01.main" readonly="Y" >}
PUBLIC FUNCTION aglq730_x01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr20         #tm.a1  臨時表名稱 
DEFINE  p_arg3 LIKE type_t.num5         #tm.a2  hide_flag 
DEFINE  p_arg4 LIKE type_t.num5         #tm.a3  curr_flag
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
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aglq730_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aglq730_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aglq730_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aglq730_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aglq730_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aglq730_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aglq730_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aglq730_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "glar001.glar_t.glar001,glar001_desc.type_t.chr200,l_amt11.type_t.num20_6,l_amt12.type_t.num20_6,l_amt13.type_t.num20_6,l_amt21.type_t.num20_6,l_amt22.type_t.num20_6,l_amt23.type_t.num20_6,l_amt31.type_t.num20_6,l_amt32.type_t.num20_6,l_amt33.type_t.num20_6,l_amt41.type_t.num20_6,l_amt42.type_t.num20_6,l_amt43.type_t.num20_6,l_amt51.type_t.num20_6,l_amt52.type_t.num20_6,l_amt53.type_t.num20_6,l_amt61.type_t.num20_6,l_amt62.type_t.num20_6,l_amt63.type_t.num20_6,l_amt71.type_t.num20_6,l_amt72.type_t.num20_6,l_amt73.type_t.num20_6,l_amt81.type_t.num20_6,l_amt82.type_t.num20_6,l_amt83.type_t.num20_6,l_amt91.type_t.num20_6,l_amt92.type_t.num20_6,l_amt93.type_t.num20_6,l_amt101.type_t.num20_6,l_amt102.type_t.num20_6,l_amt103.type_t.num20_6,l_amt111.type_t.num20_6,l_amt112.type_t.num20_6,l_amt113.type_t.num20_6,l_amt121.type_t.num20_6,l_amt122.type_t.num20_6,l_amt123.type_t.num20_6,l_amt131.type_t.num20_6,l_amt132.type_t.num20_6,l_amt133.type_t.num20_6,l_amt141.type_t.num20_6,l_amt142.type_t.num20_6,l_amt143.type_t.num20_6,l_amt151.type_t.num20_6,l_amt152.type_t.num20_6,l_amt153.type_t.num20_6,l_amt161.type_t.num20_6,l_amt162.type_t.num20_6,l_amt163.type_t.num20_6,l_amt171.type_t.num20_6,l_amt172.type_t.num20_6,l_amt173.type_t.num20_6,l_amt181.type_t.num20_6,l_amt182.type_t.num20_6,l_amt183.type_t.num20_6,l_amt191.type_t.num20_6,l_amt192.type_t.num20_6,l_amt193.type_t.num20_6,l_amt201.type_t.num20_6,l_amt202.type_t.num20_6,l_amt203.type_t.num20_6,l_amt211.type_t.num20_6,l_amt212.type_t.num20_6,l_amt213.type_t.num20_6,l_amt221.type_t.num20_6,l_amt222.type_t.num20_6,l_amt223.type_t.num20_6,l_amt231.type_t.num20_6,l_amt232.type_t.num20_6,l_amt233.type_t.num20_6,l_amt241.type_t.num20_6,l_amt242.type_t.num20_6,l_amt243.type_t.num20_6,l_amt251.type_t.num20_6,l_amt252.type_t.num20_6,l_amt253.type_t.num20_6,l_amt261.type_t.num20_6,l_amt271.type_t.num20_6,l_amt281.type_t.num20_6,l_amt291.type_t.num20_6,l_amt301.type_t.num20_6,l_amt311.type_t.num20_6,l_amt321.type_t.num20_6,l_amt331.type_t.num20_6,l_amt341.type_t.num20_6,l_amt351.type_t.num20_6,l_amt361.type_t.num20_6,l_amt371.type_t.num20_6,l_amt381.type_t.num20_6,l_amt391.type_t.num20_6,l_amt401.type_t.num20_6,l_amt411.type_t.num20_6,l_amt421.type_t.num20_6,l_amt431.type_t.num20_6,l_amt441.type_t.num20_6,l_amt451.type_t.num20_6,l_amt461.type_t.num20_6,l_amt471.type_t.num20_6,l_amt481.type_t.num20_6,l_amt491.type_t.num20_6,l_amt501.type_t.num20_6,l_amt511.type_t.num20_6,l_amt521.type_t.num20_6,l_amt531.type_t.num20_6,l_amt541.type_t.num20_6,l_amt551.type_t.num20_6,l_amt561.type_t.num20_6,l_amt571.type_t.num20_6,l_amt581.type_t.num20_6,l_amt591.type_t.num20_6,l_amt601.type_t.num20_6,l_amt611.type_t.num20_6,l_amt621.type_t.num20_6,l_amt631.type_t.num20_6,l_amt641.type_t.num20_6,l_amt651.type_t.num20_6,l_amt661.type_t.num20_6,l_amt671.type_t.num20_6,l_amt681.type_t.num20_6,l_amt691.type_t.num20_6,l_amt701.type_t.num20_6,l_amt711.type_t.num20_6,l_amt721.type_t.num20_6,l_amt731.type_t.num20_6,l_amt741.type_t.num20_6,l_amt751.type_t.num20_6,l_amt761.type_t.num20_6,l_amt771.type_t.num20_6,l_amt781.type_t.num20_6,l_amt791.type_t.num20_6,l_amt801.type_t.num20_6,l_amt811.type_t.num20_6,l_amt821.type_t.num20_6,l_amt831.type_t.num20_6,l_amt841.type_t.num20_6,l_amt851.type_t.num20_6,l_amt861.type_t.num20_6,l_amt871.type_t.num20_6,l_amt881.type_t.num20_6,l_amt891.type_t.num20_6,l_amt901.type_t.num20_6,l_amt911.type_t.num20_6,l_amt921.type_t.num20_6,l_amt931.type_t.num20_6,l_amt941.type_t.num20_6,l_amt951.type_t.num20_6,l_amt961.type_t.num20_6,l_amt971.type_t.num20_6,l_amt981.type_t.num20_6,l_amt991.type_t.num20_6,l_amt1001.type_t.num20_6,l_glaald_desc.type_t.chr500,l_glaacomp_desc.type_t.chr500,l_curr.type_t.chr500,l_sdate.type_t.chr500,l_edate.type_t.chr500,l_ctype.type_t.chr500,l_fix_acc.type_t.chr500,l_stype.type_t.chr500,l_glac005.glac_t.glac005,l_stus.type_t.chr500" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aglq730_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aglq730_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
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
         
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="aglq730_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq730_x01_sel_prep()
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
   LET g_select = " SELECT glar001,NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM glar_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("glar_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = " SELECT * FROM ", g_tmp_table CLIPPED#," ORDER BY glar001"
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
   #end add-point
   PREPARE aglq730_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aglq730_x01_curs CURSOR FOR aglq730_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aglq730_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aglq730_x01_ins_data()
DEFINE sr RECORD 
   glar001 LIKE glar_t.glar001, 
   glar001_desc LIKE type_t.chr200, 
   l_amt11 LIKE type_t.num20_6, 
   l_amt12 LIKE type_t.num20_6, 
   l_amt13 LIKE type_t.num20_6, 
   l_amt21 LIKE type_t.num20_6, 
   l_amt22 LIKE type_t.num20_6, 
   l_amt23 LIKE type_t.num20_6, 
   l_amt31 LIKE type_t.num20_6, 
   l_amt32 LIKE type_t.num20_6, 
   l_amt33 LIKE type_t.num20_6, 
   l_amt41 LIKE type_t.num20_6, 
   l_amt42 LIKE type_t.num20_6, 
   l_amt43 LIKE type_t.num20_6, 
   l_amt51 LIKE type_t.num20_6, 
   l_amt52 LIKE type_t.num20_6, 
   l_amt53 LIKE type_t.num20_6, 
   l_amt61 LIKE type_t.num20_6, 
   l_amt62 LIKE type_t.num20_6, 
   l_amt63 LIKE type_t.num20_6, 
   l_amt71 LIKE type_t.num20_6, 
   l_amt72 LIKE type_t.num20_6, 
   l_amt73 LIKE type_t.num20_6, 
   l_amt81 LIKE type_t.num20_6, 
   l_amt82 LIKE type_t.num20_6, 
   l_amt83 LIKE type_t.num20_6, 
   l_amt91 LIKE type_t.num20_6, 
   l_amt92 LIKE type_t.num20_6, 
   l_amt93 LIKE type_t.num20_6, 
   l_amt101 LIKE type_t.num20_6, 
   l_amt102 LIKE type_t.num20_6, 
   l_amt103 LIKE type_t.num20_6, 
   l_amt111 LIKE type_t.num20_6, 
   l_amt112 LIKE type_t.num20_6, 
   l_amt113 LIKE type_t.num20_6, 
   l_amt121 LIKE type_t.num20_6, 
   l_amt122 LIKE type_t.num20_6, 
   l_amt123 LIKE type_t.num20_6, 
   l_amt131 LIKE type_t.num20_6, 
   l_amt132 LIKE type_t.num20_6, 
   l_amt133 LIKE type_t.num20_6, 
   l_amt141 LIKE type_t.num20_6, 
   l_amt142 LIKE type_t.num20_6, 
   l_amt143 LIKE type_t.num20_6, 
   l_amt151 LIKE type_t.num20_6, 
   l_amt152 LIKE type_t.num20_6, 
   l_amt153 LIKE type_t.num20_6, 
   l_amt161 LIKE type_t.num20_6, 
   l_amt162 LIKE type_t.num20_6, 
   l_amt163 LIKE type_t.num20_6, 
   l_amt171 LIKE type_t.num20_6, 
   l_amt172 LIKE type_t.num20_6, 
   l_amt173 LIKE type_t.num20_6, 
   l_amt181 LIKE type_t.num20_6, 
   l_amt182 LIKE type_t.num20_6, 
   l_amt183 LIKE type_t.num20_6, 
   l_amt191 LIKE type_t.num20_6, 
   l_amt192 LIKE type_t.num20_6, 
   l_amt193 LIKE type_t.num20_6, 
   l_amt201 LIKE type_t.num20_6, 
   l_amt202 LIKE type_t.num20_6, 
   l_amt203 LIKE type_t.num20_6, 
   l_amt211 LIKE type_t.num20_6, 
   l_amt212 LIKE type_t.num20_6, 
   l_amt213 LIKE type_t.num20_6, 
   l_amt221 LIKE type_t.num20_6, 
   l_amt222 LIKE type_t.num20_6, 
   l_amt223 LIKE type_t.num20_6, 
   l_amt231 LIKE type_t.num20_6, 
   l_amt232 LIKE type_t.num20_6, 
   l_amt233 LIKE type_t.num20_6, 
   l_amt241 LIKE type_t.num20_6, 
   l_amt242 LIKE type_t.num20_6, 
   l_amt243 LIKE type_t.num20_6, 
   l_amt251 LIKE type_t.num20_6, 
   l_amt252 LIKE type_t.num20_6, 
   l_amt253 LIKE type_t.num20_6, 
   l_amt261 LIKE type_t.num20_6, 
   l_amt262 LIKE type_t.num20_6, 
   l_amt263 LIKE type_t.num20_6, 
   l_amt271 LIKE type_t.num20_6, 
   l_amt272 LIKE type_t.num20_6, 
   l_amt273 LIKE type_t.num20_6, 
   l_amt281 LIKE type_t.num20_6, 
   l_amt282 LIKE type_t.num20_6, 
   l_amt283 LIKE type_t.num20_6, 
   l_amt291 LIKE type_t.num20_6, 
   l_amt292 LIKE type_t.num20_6, 
   l_amt293 LIKE type_t.num20_6, 
   l_amt301 LIKE type_t.num20_6, 
   l_amt302 LIKE type_t.num20_6, 
   l_amt303 LIKE type_t.num20_6, 
   l_amt311 LIKE type_t.num20_6, 
   l_amt312 LIKE type_t.num20_6, 
   l_amt313 LIKE type_t.num20_6, 
   l_amt321 LIKE type_t.num20_6, 
   l_amt322 LIKE type_t.num20_6, 
   l_amt323 LIKE type_t.num20_6, 
   l_amt331 LIKE type_t.num20_6, 
   l_amt332 LIKE type_t.num20_6, 
   l_amt333 LIKE type_t.num20_6, 
   l_amt341 LIKE type_t.num20_6, 
   l_amt342 LIKE type_t.num20_6, 
   l_amt343 LIKE type_t.num20_6, 
   l_amt351 LIKE type_t.num20_6, 
   l_amt352 LIKE type_t.num20_6, 
   l_amt353 LIKE type_t.num20_6, 
   l_amt361 LIKE type_t.num20_6, 
   l_amt362 LIKE type_t.num20_6, 
   l_amt363 LIKE type_t.num20_6, 
   l_amt371 LIKE type_t.num20_6, 
   l_amt372 LIKE type_t.num20_6, 
   l_amt373 LIKE type_t.num20_6, 
   l_amt381 LIKE type_t.num20_6, 
   l_amt382 LIKE type_t.num20_6, 
   l_amt383 LIKE type_t.num20_6, 
   l_amt391 LIKE type_t.num20_6, 
   l_amt392 LIKE type_t.num20_6, 
   l_amt393 LIKE type_t.num20_6, 
   l_amt401 LIKE type_t.num20_6, 
   l_amt402 LIKE type_t.num20_6, 
   l_amt403 LIKE type_t.num20_6, 
   l_amt411 LIKE type_t.num20_6, 
   l_amt412 LIKE type_t.num20_6, 
   l_amt413 LIKE type_t.num20_6, 
   l_amt421 LIKE type_t.num20_6, 
   l_amt422 LIKE type_t.num20_6, 
   l_amt423 LIKE type_t.num20_6, 
   l_amt431 LIKE type_t.num20_6, 
   l_amt432 LIKE type_t.num20_6, 
   l_amt433 LIKE type_t.num20_6, 
   l_amt441 LIKE type_t.num20_6, 
   l_amt442 LIKE type_t.num20_6, 
   l_amt443 LIKE type_t.num20_6, 
   l_amt451 LIKE type_t.num20_6, 
   l_amt452 LIKE type_t.num20_6, 
   l_amt453 LIKE type_t.num20_6, 
   l_amt461 LIKE type_t.num20_6, 
   l_amt462 LIKE type_t.num20_6, 
   l_amt463 LIKE type_t.num20_6, 
   l_amt471 LIKE type_t.num20_6, 
   l_amt472 LIKE type_t.num20_6, 
   l_amt473 LIKE type_t.num20_6, 
   l_amt481 LIKE type_t.num20_6, 
   l_amt482 LIKE type_t.num20_6, 
   l_amt483 LIKE type_t.num20_6, 
   l_amt491 LIKE type_t.num20_6, 
   l_amt492 LIKE type_t.num20_6, 
   l_amt493 LIKE type_t.num20_6, 
   l_amt501 LIKE type_t.num20_6, 
   l_amt502 LIKE type_t.num20_6, 
   l_amt503 LIKE type_t.num20_6, 
   l_amt511 LIKE type_t.num20_6, 
   l_amt512 LIKE type_t.num20_6, 
   l_amt513 LIKE type_t.num20_6, 
   l_amt521 LIKE type_t.num20_6, 
   l_amt522 LIKE type_t.num20_6, 
   l_amt523 LIKE type_t.num20_6, 
   l_amt531 LIKE type_t.num20_6, 
   l_amt532 LIKE type_t.num20_6, 
   l_amt533 LIKE type_t.num20_6, 
   l_amt541 LIKE type_t.num20_6, 
   l_amt542 LIKE type_t.num20_6, 
   l_amt543 LIKE type_t.num20_6, 
   l_amt551 LIKE type_t.num20_6, 
   l_amt552 LIKE type_t.num20_6, 
   l_amt553 LIKE type_t.num20_6, 
   l_amt561 LIKE type_t.num20_6, 
   l_amt562 LIKE type_t.num20_6, 
   l_amt563 LIKE type_t.num20_6, 
   l_amt571 LIKE type_t.num20_6, 
   l_amt572 LIKE type_t.num20_6, 
   l_amt573 LIKE type_t.num26_10, 
   l_amt581 LIKE type_t.num20_6, 
   l_amt582 LIKE type_t.num20_6, 
   l_amt583 LIKE type_t.num20_6, 
   l_amt591 LIKE type_t.num20_6, 
   l_amt592 LIKE type_t.num20_6, 
   l_amt593 LIKE type_t.num20_6, 
   l_amt601 LIKE type_t.num20_6, 
   l_amt602 LIKE type_t.num20_6, 
   l_amt603 LIKE type_t.num20_6, 
   l_amt611 LIKE type_t.num20_6, 
   l_amt612 LIKE type_t.num20_6, 
   l_amt613 LIKE type_t.num20_6, 
   l_amt621 LIKE type_t.num20_6, 
   l_amt622 LIKE type_t.num20_6, 
   l_amt623 LIKE type_t.num20_6, 
   l_amt631 LIKE type_t.num20_6, 
   l_amt632 LIKE type_t.num20_6, 
   l_amt633 LIKE type_t.num20_6, 
   l_amt641 LIKE type_t.num20_6, 
   l_amt642 LIKE type_t.num20_6, 
   l_amt643 LIKE type_t.num20_6, 
   l_amt651 LIKE type_t.num20_6, 
   l_amt652 LIKE type_t.num20_6, 
   l_amt653 LIKE type_t.num20_6, 
   l_amt661 LIKE type_t.num20_6, 
   l_amt662 LIKE type_t.num20_6, 
   l_amt663 LIKE type_t.num20_6, 
   l_amt671 LIKE type_t.num20_6, 
   l_amt672 LIKE type_t.num20_6, 
   l_amt673 LIKE type_t.num20_6, 
   l_amt681 LIKE type_t.num20_6, 
   l_amt682 LIKE type_t.num20_6, 
   l_amt683 LIKE type_t.num20_6, 
   l_amt691 LIKE type_t.num20_6, 
   l_amt692 LIKE type_t.num20_6, 
   l_amt693 LIKE type_t.num20_6, 
   l_amt701 LIKE type_t.num20_6, 
   l_amt702 LIKE type_t.num20_6, 
   l_amt703 LIKE type_t.num20_6, 
   l_amt711 LIKE type_t.num20_6, 
   l_amt712 LIKE type_t.num20_6, 
   l_amt713 LIKE type_t.num20_6, 
   l_amt721 LIKE type_t.num20_6, 
   l_amt722 LIKE type_t.num20_6, 
   l_amt723 LIKE type_t.num20_6, 
   l_amt731 LIKE type_t.num20_6, 
   l_amt732 LIKE type_t.num20_6, 
   l_amt733 LIKE type_t.num20_6, 
   l_amt741 LIKE type_t.num20_6, 
   l_amt742 LIKE type_t.num20_6, 
   l_amt743 LIKE type_t.num20_6, 
   l_amt751 LIKE type_t.num20_6, 
   l_amt752 LIKE type_t.num20_6, 
   l_amt753 LIKE type_t.num20_6, 
   l_amt761 LIKE type_t.num20_6, 
   l_amt762 LIKE type_t.num20_6, 
   l_amt763 LIKE type_t.num20_6, 
   l_amt771 LIKE type_t.num20_6, 
   l_amt772 LIKE type_t.num20_6, 
   l_amt773 LIKE type_t.num20_6, 
   l_amt781 LIKE type_t.num20_6, 
   l_amt782 LIKE type_t.num20_6, 
   l_amt783 LIKE type_t.num20_6, 
   l_amt791 LIKE type_t.num20_6, 
   l_amt792 LIKE type_t.num20_6, 
   l_amt793 LIKE type_t.num20_6, 
   l_amt801 LIKE type_t.num20_6, 
   l_amt802 LIKE type_t.num20_6, 
   l_amt803 LIKE type_t.num20_6, 
   l_amt811 LIKE type_t.num20_6, 
   l_amt812 LIKE type_t.num20_6, 
   l_amt813 LIKE type_t.num20_6, 
   l_amt821 LIKE type_t.num20_6, 
   l_amt822 LIKE type_t.num20_6, 
   l_amt823 LIKE type_t.num20_6, 
   l_amt831 LIKE type_t.num20_6, 
   l_amt832 LIKE type_t.num20_6, 
   l_amt833 LIKE type_t.num20_6, 
   l_amt841 LIKE type_t.num20_6, 
   l_amt842 LIKE type_t.num20_6, 
   l_amt843 LIKE type_t.num20_6, 
   l_amt851 LIKE type_t.num20_6, 
   l_amt852 LIKE type_t.num20_6, 
   l_amt853 LIKE type_t.num20_6, 
   l_amt861 LIKE type_t.num20_6, 
   l_amt862 LIKE type_t.num20_6, 
   l_amt863 LIKE type_t.num20_6, 
   l_amt871 LIKE type_t.num20_6, 
   l_amt872 LIKE type_t.num20_6, 
   l_amt873 LIKE type_t.num20_6, 
   l_amt881 LIKE type_t.num20_6, 
   l_amt882 LIKE type_t.num20_6, 
   l_amt883 LIKE type_t.num20_6, 
   l_amt891 LIKE type_t.num20_6, 
   l_amt892 LIKE type_t.num20_6, 
   l_amt893 LIKE type_t.num20_6, 
   l_amt901 LIKE type_t.num20_6, 
   l_amt902 LIKE type_t.num20_6, 
   l_amt903 LIKE type_t.num20_6, 
   l_amt911 LIKE type_t.num20_6, 
   l_amt912 LIKE type_t.num20_6, 
   l_amt913 LIKE type_t.num20_6, 
   l_amt921 LIKE type_t.num20_6, 
   l_amt922 LIKE type_t.num20_6, 
   l_amt923 LIKE type_t.num20_6, 
   l_amt931 LIKE type_t.num20_6, 
   l_amt932 LIKE type_t.num20_6, 
   l_amt933 LIKE type_t.num20_6, 
   l_amt941 LIKE type_t.num20_6, 
   l_amt942 LIKE type_t.num20_6, 
   l_amt943 LIKE type_t.num20_6, 
   l_amt951 LIKE type_t.num20_6, 
   l_amt952 LIKE type_t.num20_6, 
   l_amt953 LIKE type_t.num20_6, 
   l_amt961 LIKE type_t.num20_6, 
   l_amt962 LIKE type_t.num20_6, 
   l_amt963 LIKE type_t.num20_6, 
   l_amt971 LIKE type_t.num20_6, 
   l_amt972 LIKE type_t.num20_6, 
   l_amt973 LIKE type_t.num20_6, 
   l_amt981 LIKE type_t.num20_6, 
   l_amt982 LIKE type_t.num20_6, 
   l_amt983 LIKE type_t.num20_6, 
   l_amt991 LIKE type_t.num20_6, 
   l_amt992 LIKE type_t.num20_6, 
   l_amt993 LIKE type_t.num20_6, 
   l_amt1001 LIKE type_t.num20_6, 
   l_amt1002 LIKE type_t.num20_6, 
   l_amt1003 LIKE type_t.num20_6, 
   l_glaald_desc LIKE type_t.chr500, 
   l_glaacomp_desc LIKE type_t.chr500, 
   l_curr LIKE type_t.chr500, 
   l_sdate LIKE type_t.chr500, 
   l_edate LIKE type_t.chr500, 
   l_ctype LIKE type_t.chr500, 
   l_fix_acc LIKE type_t.chr500, 
   l_stype LIKE type_t.chr500, 
   l_glac005 LIKE glac_t.glac005, 
   l_stus LIKE type_t.chr500
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_i       LIKE type_t.num5
   DEFINE l_str     STRING
   DEFINE l_str1    STRING
   DEFINE l_str2    STRING
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aglq730_x01_curs INTO sr.*                               
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
       EXECUTE insert_prep USING sr.glar001,sr.glar001_desc,sr.l_amt11,sr.l_amt12,sr.l_amt13,sr.l_amt21,sr.l_amt22,sr.l_amt23,sr.l_amt31,sr.l_amt32,sr.l_amt33,sr.l_amt41,sr.l_amt42,sr.l_amt43,sr.l_amt51,sr.l_amt52,sr.l_amt53,sr.l_amt61,sr.l_amt62,sr.l_amt63,sr.l_amt71,sr.l_amt72,sr.l_amt73,sr.l_amt81,sr.l_amt82,sr.l_amt83,sr.l_amt91,sr.l_amt92,sr.l_amt93,sr.l_amt101,sr.l_amt102,sr.l_amt103,sr.l_amt111,sr.l_amt112,sr.l_amt113,sr.l_amt121,sr.l_amt122,sr.l_amt123,sr.l_amt131,sr.l_amt132,sr.l_amt133,sr.l_amt141,sr.l_amt142,sr.l_amt143,sr.l_amt151,sr.l_amt152,sr.l_amt153,sr.l_amt161,sr.l_amt162,sr.l_amt163,sr.l_amt171,sr.l_amt172,sr.l_amt173,sr.l_amt181,sr.l_amt182,sr.l_amt183,sr.l_amt191,sr.l_amt192,sr.l_amt193,sr.l_amt201,sr.l_amt202,sr.l_amt203,sr.l_amt211,sr.l_amt212,sr.l_amt213,sr.l_amt221,sr.l_amt222,sr.l_amt223,sr.l_amt231,sr.l_amt232,sr.l_amt233,sr.l_amt241,sr.l_amt242,sr.l_amt243,sr.l_amt251,sr.l_amt252,sr.l_amt253,sr.l_amt261,sr.l_amt271,sr.l_amt281,sr.l_amt291,sr.l_amt301,sr.l_amt311,sr.l_amt321,sr.l_amt331,sr.l_amt341,sr.l_amt351,sr.l_amt361,sr.l_amt371,sr.l_amt381,sr.l_amt391,sr.l_amt401,sr.l_amt411,sr.l_amt421,sr.l_amt431,sr.l_amt441,sr.l_amt451,sr.l_amt461,sr.l_amt471,sr.l_amt481,sr.l_amt491,sr.l_amt501,sr.l_amt511,sr.l_amt521,sr.l_amt531,sr.l_amt541,sr.l_amt551,sr.l_amt561,sr.l_amt571,sr.l_amt581,sr.l_amt591,sr.l_amt601,sr.l_amt611,sr.l_amt621,sr.l_amt631,sr.l_amt641,sr.l_amt651,sr.l_amt661,sr.l_amt671,sr.l_amt681,sr.l_amt691,sr.l_amt701,sr.l_amt711,sr.l_amt721,sr.l_amt731,sr.l_amt741,sr.l_amt751,sr.l_amt761,sr.l_amt771,sr.l_amt781,sr.l_amt791,sr.l_amt801,sr.l_amt811,sr.l_amt821,sr.l_amt831,sr.l_amt841,sr.l_amt851,sr.l_amt861,sr.l_amt871,sr.l_amt881,sr.l_amt891,sr.l_amt901,sr.l_amt911,sr.l_amt921,sr.l_amt931,sr.l_amt941,sr.l_amt951,sr.l_amt961,sr.l_amt971,sr.l_amt981,sr.l_amt991,sr.l_amt1001,sr.l_glaald_desc,sr.l_glaacomp_desc,sr.l_curr,sr.l_sdate,sr.l_edate,sr.l_ctype,sr.l_fix_acc,sr.l_stype,sr.l_glac005,sr.l_stus
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aglq730_x01_execute"
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
    LET g_xgrid.visible_column = NULL
    
#由于XG的栏位个数不可以超过150个，故只显示150个栏位，本位币一预留100个，本位币二三只各预留25个

    #核算項顯示列數
    FOR l_i=1 TO tm.a2
        IF l_i=1 THEN
           LET l_str="l_amt",l_i USING '<<<',"1"
           LET l_str1="l_amt",l_i USING '<<<',"2"
           LET l_str2="l_amt",l_i USING '<<<',"3"
        ELSE
           LET l_str=l_str,"|l_amt",l_i USING '<<<',"1"
           IF l_i < 26 THEN  #2015/08/30 add by 02599
           
           LET l_str1=l_str1,"|l_amt",l_i USING '<<<',"2"
           LET l_str2=l_str2,"|l_amt",l_i USING '<<<',"3"
           
           END IF #2015/08/30 add by 02599
        END IF
    END FOR
    
    #只顯示本位幣一
    IF tm.a3='0' THEN
       IF NOT cl_null(g_xgrid.visible_column)THEN       
          LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED ,"|",l_str1,"|",l_str2
       ELSE
          LET g_xgrid.visible_column = l_str1,"|",l_str2
       END IF
    END IF
    #顯示本位幣二
    IF tm.a3='1' THEN
       IF NOT cl_null(g_xgrid.visible_column)THEN       
          LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED ,"|",l_str2
       ELSE
          LET g_xgrid.visible_column = l_str2
       END IF
    END IF
    #顯示本位幣三
    IF tm.a3='2' THEN
       IF NOT cl_null(g_xgrid.visible_column)THEN       
          LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED ,"|",l_str1
       ELSE
          LET g_xgrid.visible_column = l_str1
       END IF
    END IF
    #核算項隱藏列數
    FOR l_i=tm.a2+1 TO 100
#2015/08/30--by--02599--mod--str--
#由于XG的栏位个数不可以超过150个，故只显示150个栏位，本位币一预留100个，本位币二三只各预留25个
#       LET l_str="l_amt",l_i USING '<<<',"1|",
#                 "l_amt",l_i USING '<<<',"2|",
#                 "l_amt",l_i USING '<<<',"3"
       LET l_str="l_amt",l_i USING '<<<',"1"
       IF l_i < 26 THEN
          LET l_str=l_str,"|l_amt",l_i USING '<<<',"2|l_amt",l_i USING '<<<',"3"
       END IF
#2015/08/30--by--02599--mod--end
       IF NOT cl_null(g_xgrid.visible_column)THEN       
          LET g_xgrid.visible_column =g_xgrid.visible_column CLIPPED ,"|",l_str
       ELSE
          LET g_xgrid.visible_column = l_str
       END IF
    END FOR
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq730_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aglq730_x01_rep_data()
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
 
{<section id="aglq730_x01.other_function" readonly="Y" >}

 
{</section>}
 
