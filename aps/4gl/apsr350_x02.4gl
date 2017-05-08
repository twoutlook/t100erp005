#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr350_x02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-09-13 14:50:17), PR版次:0001(2016-09-13 14:56:40)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000008
#+ Filename...: apsr350_x02
#+ Description: ...
#+ Creator....: 07024(2016-08-26 14:51:20)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apsr350_x02.global" readonly="Y" >}
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
       no1 LIKE type_t.chr10          #預測編號
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="apsr350_x02.main" readonly="Y" >}
PUBLIC FUNCTION apsr350_x02(p_arg1,p_arg2)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr10         #tm.no1  預測編號
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.no1 = p_arg2
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "apsr350_x02"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL apsr350_x02_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL apsr350_x02_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL apsr350_x02_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL apsr350_x02_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL apsr350_x02_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="apsr350_x02.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION apsr350_x02_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "psia003.psia_t.psia003,pmaal_t_pmaal004.pmaal_t.pmaal004,psia004.psia_t.psia004,ooag_t_ooag011.ooag_t.ooag011,psia005.psia_t.psia005,psib006.psib_t.psib006,x_imaal_t_imaal003.imaal_t.imaal003,x_imaal_t_imaal004.imaal_t.imaal004,psib007.psib_t.psib007,l_psib007_desc.inaml_t.inaml004,psib012.psib_t.psib012,psib013.psib_t.psib013,l_psic009.psic_t.psic009,l_psic010.psic_t.psic010,l_psic011.psic_t.psic011,l_psic012.psic_t.psic012,l_psic013.psic_t.psic013,l_psib011_1.psib_t.psib011,l_psib011_2.psib_t.psib011,l_psib011_3.psib_t.psib011,l_psib011_4.psib_t.psib011,l_psib011_5.psib_t.psib011,l_psib011_6.psib_t.psib011,l_psib011_7.psib_t.psib011,l_psib011_8.psib_t.psib011,l_psib011_9.psib_t.psib011,l_psib011_10.psib_t.psib011,l_psib011_11.psib_t.psib011,l_psib011_12.psib_t.psib011,l_psib011_13.psib_t.psib011,l_psib011_14.psib_t.psib011,l_psib011_15.psib_t.psib011,l_psib011_16.psib_t.psib011,l_psib011_17.psib_t.psib011,l_psib011_18.psib_t.psib011,l_psib011_19.psib_t.psib011,l_psib011_20.psib_t.psib011,l_psib011_21.psib_t.psib011,l_psib011_22.psib_t.psib011,l_psib011_23.psib_t.psib011,l_psib011_24.psib_t.psib011,l_psib011_25.psib_t.psib011,l_psib011_26.psib_t.psib011,l_psib011_27.psib_t.psib011,l_psib011_28.psib_t.psib011,l_psib011_29.psib_t.psib011,l_psib011_30.psib_t.psib011,l_psib011_31.psib_t.psib011,l_psib011_32.psib_t.psib011,l_psib011_33.psib_t.psib011,l_psib011_34.psib_t.psib011,l_psib011_35.psib_t.psib011,l_psib011_36.psib_t.psib011,l_psib011_37.psib_t.psib011,l_psib011_38.psib_t.psib011,l_psib011_39.psib_t.psib011,l_psib011_40.psib_t.psib011,l_psib011_41.psib_t.psib011,l_psib011_42.psib_t.psib011,l_psib011_43.psib_t.psib011,l_psib011_44.psib_t.psib011,l_psib011_45.psib_t.psib011,l_psib011_46.psib_t.psib011,l_psib011_47.psib_t.psib011,l_psib011_48.psib_t.psib011,l_psib011_49.psib_t.psib011,l_psib011_50.psib_t.psib011,l_psib011_51.psib_t.psib011,l_psib011_52.psib_t.psib011,l_psib011_53.psib_t.psib011,l_psib011_54.psib_t.psib011,l_psib011_55.psib_t.psib011,l_psib011_56.psib_t.psib011,l_psib011_57.psib_t.psib011,l_psib011_58.psib_t.psib011,l_psib011_59.psib_t.psib011,l_psib011_60.psib_t.psib011,l_psib011_61.psib_t.psib011,l_psib011_62.psib_t.psib011,l_psib011_63.psib_t.psib011" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="apsr350_x02.ins_prep" readonly="Y" >}
PRIVATE FUNCTION apsr350_x02_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="apsr350_x02.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr350_x02_sel_prep()
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
   LET g_select = " SELECT DISTINCT psia001,psia002,psiasite,psiaent,psia003,",
                  " (SELECT pmaal004 FROM pmaal_t WHERE pmaal001 = psia003 AND pmaalent = psiaent AND pmaal002 = '",g_dlang,"') pmaal004, ",
                  " psia004,(SELECT ooag011 FROM ooag_t WHERE ooag001 = psia004 AND ooagent = psiaent) ooag011, ", 
                  " psia005,x.psib006, ",
                  " (SELECT imaal003 FROM imaal_t WHERE imaal001 = x.psib006 AND imaalent = x.psibent AND imaal002 = '",g_dlang,"') imaal003, ",
                  " (SELECT imaal004 FROM imaal_t WHERE imaal001 = x.psib006 AND imaalent = x.psibent AND imaal002 = '",g_dlang,"') imaal004, ",
                  " x.psib007,(SELECT inaml004 FROM inaml_t WHERE inamlent=x.psibent AND inaml001=x.psib006 AND inaml002=x.psib007 AND inaml003='",g_dlang,"') inaml004, ",
                  " x.psib012,x.psib013,COALESCE(x.psic009,0),COALESCE(x.psic010,0),COALESCE(x.psic011,0),COALESCE(x.psic012,0),COALESCE(x.psic013,0),0,0,",
                  " 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,",  #1-20期
                  " 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,",  #21-30期
                  " 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,",  #41-60期
                  " 0,0,0 " #61-63期
#   #end add-point
#   LET g_select = " SELECT psia001,psia002,psiasite,psiaent,psia003,( SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = psia_t.psia003 AND pmaal_t.pmaalent = psia_t.psiaent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,"),psia004,( SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = psia_t.psia004 AND ooag_t.ooagent = psia_t.psiaent), 
#       psia005,psib006,x.imaal_t_imaal003,x.imaal_t_imaal004,psib007,NULL,psib012,psib013,NULL,NULL, 
#       NULL,NULL,NULL,psib008,psib011,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
#       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
#       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
#       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM psia_t LEFT OUTER JOIN (SELECT psib_t.*,psic009,psic010,psic011,psic012,psic013
                                                 FROM psib_t
                                                 LEFT OUTER JOIN psic_t
                                                   ON psibent = psicent AND psibsite = psicsite AND psib001 = psic001
                                                  AND psib002 = psic002 AND psib003  = psic003  AND psib004 = psic004
                                                  AND psib005 = psic005 AND psib006  = psic006  AND psib007 = psic007
                                                  AND psib013 = psic008) x
                                           ON psiaent = x.psibent AND psiasite = x.psibsite AND psia001 = x.psib001 AND psia002 = x.psib002
                                           AND psia003 = x.psib003 AND psia004 = x.psib004 AND psia005 = x.psib005 "
#   #end add-point
#    LET g_from = " FROM psia_t LEFT OUTER JOIN ( SELECT psib_t.*,( SELECT imaal003 FROM imaal_t WHERE imaal_t.imaal001 = psib_t.psib006 AND imaal_t.imaalent = psib_t.psibent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal003,( SELECT imaal004 FROM imaal_t WHERE imaal_t.imaal001 = psib_t.psib006 AND imaal_t.imaalent = psib_t.psibent AND imaal_t.imaal002 = '" , 
#        g_dlang,"'" ,") imaal_t_imaal004 FROM psib_t ) x  ON psia_t.psiaent = x.psibent AND psia_t.psiasite  
#        = x.psibsite AND psia_t.psia001 = x.psib001 AND psia_t.psia002 = x.psib002 AND psia_t.psia003  
#        = x.psib003 AND psia_t.psia004 = x.psib004 AND psia_t.psia005 = x.psib005"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("psia_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql CLIPPED," ORDER BY psia001,psia002,psia003,psia004,psia005,x.psib006,x.psib007 "
   #DISPLAY "g_sq:",g_sql
   #end add-point
   PREPARE apsr350_x02_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE apsr350_x02_curs CURSOR FOR apsr350_x02_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="apsr350_x02.ins_data" readonly="Y" >}
PRIVATE FUNCTION apsr350_x02_ins_data()
DEFINE sr RECORD 
   psia001 LIKE psia_t.psia001, 
   psia002 LIKE psia_t.psia002, 
   psiasite LIKE psia_t.psiasite, 
   psiaent LIKE psia_t.psiaent, 
   psia003 LIKE psia_t.psia003, 
   pmaal_t_pmaal004 LIKE pmaal_t.pmaal004, 
   psia004 LIKE psia_t.psia004, 
   ooag_t_ooag011 LIKE ooag_t.ooag011, 
   psia005 LIKE psia_t.psia005, 
   psib006 LIKE psib_t.psib006, 
   x_imaal_t_imaal003 LIKE imaal_t.imaal003, 
   x_imaal_t_imaal004 LIKE imaal_t.imaal004, 
   psib007 LIKE psib_t.psib007, 
   l_psib007_desc LIKE inaml_t.inaml004, 
   psib012 LIKE psib_t.psib012, 
   psib013 LIKE psib_t.psib013, 
   l_psic009 LIKE psic_t.psic009, 
   l_psic010 LIKE psic_t.psic010, 
   l_psic011 LIKE psic_t.psic011, 
   l_psic012 LIKE psic_t.psic012, 
   l_psic013 LIKE psic_t.psic013, 
   psib008 LIKE psib_t.psib008, 
   psib011 LIKE psib_t.psib011, 
   l_psib011_1 LIKE psib_t.psib011, 
   l_psib011_2 LIKE psib_t.psib011, 
   l_psib011_3 LIKE psib_t.psib011, 
   l_psib011_4 LIKE psib_t.psib011, 
   l_psib011_5 LIKE psib_t.psib011, 
   l_psib011_6 LIKE psib_t.psib011, 
   l_psib011_7 LIKE psib_t.psib011, 
   l_psib011_8 LIKE psib_t.psib011, 
   l_psib011_9 LIKE psib_t.psib011, 
   l_psib011_10 LIKE psib_t.psib011, 
   l_psib011_11 LIKE psib_t.psib011, 
   l_psib011_12 LIKE psib_t.psib011, 
   l_psib011_13 LIKE psib_t.psib011, 
   l_psib011_14 LIKE psib_t.psib011, 
   l_psib011_15 LIKE psib_t.psib011, 
   l_psib011_16 LIKE psib_t.psib011, 
   l_psib011_17 LIKE psib_t.psib011, 
   l_psib011_18 LIKE psib_t.psib011, 
   l_psib011_19 LIKE psib_t.psib011, 
   l_psib011_20 LIKE psib_t.psib011, 
   l_psib011_21 LIKE psib_t.psib011, 
   l_psib011_22 LIKE psib_t.psib011, 
   l_psib011_23 LIKE psib_t.psib011, 
   l_psib011_24 LIKE psib_t.psib011, 
   l_psib011_25 LIKE psib_t.psib011, 
   l_psib011_26 LIKE psib_t.psib011, 
   l_psib011_27 LIKE psib_t.psib011, 
   l_psib011_28 LIKE psib_t.psib011, 
   l_psib011_29 LIKE psib_t.psib011, 
   l_psib011_30 LIKE psib_t.psib011, 
   l_psib011_31 LIKE psib_t.psib011, 
   l_psib011_32 LIKE psib_t.psib011, 
   l_psib011_33 LIKE psib_t.psib011, 
   l_psib011_34 LIKE psib_t.psib011, 
   l_psib011_35 LIKE psib_t.psib011, 
   l_psib011_36 LIKE psib_t.psib011, 
   l_psib011_37 LIKE psib_t.psib011, 
   l_psib011_38 LIKE psib_t.psib011, 
   l_psib011_39 LIKE psib_t.psib011, 
   l_psib011_40 LIKE psib_t.psib011, 
   l_psib011_41 LIKE psib_t.psib011, 
   l_psib011_42 LIKE psib_t.psib011, 
   l_psib011_43 LIKE psib_t.psib011, 
   l_psib011_44 LIKE psib_t.psib011, 
   l_psib011_45 LIKE psib_t.psib011, 
   l_psib011_46 LIKE psib_t.psib011, 
   l_psib011_47 LIKE psib_t.psib011, 
   l_psib011_48 LIKE psib_t.psib011, 
   l_psib011_49 LIKE psib_t.psib011, 
   l_psib011_50 LIKE psib_t.psib011, 
   l_psib011_51 LIKE psib_t.psib011, 
   l_psib011_52 LIKE psib_t.psib011, 
   l_psib011_53 LIKE psib_t.psib011, 
   l_psib011_54 LIKE psib_t.psib011, 
   l_psib011_55 LIKE psib_t.psib011, 
   l_psib011_56 LIKE psib_t.psib011, 
   l_psib011_57 LIKE psib_t.psib011, 
   l_psib011_58 LIKE psib_t.psib011, 
   l_psib011_59 LIKE psib_t.psib011, 
   l_psib011_60 LIKE psib_t.psib011, 
   l_psib011_61 LIKE psib_t.psib011, 
   l_psib011_62 LIKE psib_t.psib011, 
   l_psib011_63 LIKE psib_t.psib011
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_sql         STRING
DEFINE l_i           LIKE type_t.num5
DEFINE l_ac          LIKE type_t.num5
DEFINE l_psja002     LIKE psja_t.psja002
DEFINE l_psib008     LIKE psib_t.psib008
DEFINE l_psib009     LIKE psib_t.psib009
DEFINE l_psib011     LIKE psib_t.psib011
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #抓取最大的期數
    SELECT psja002+1 INTO l_psja002 FROM psja_t
     WHERE psjaent = g_enterprise
       AND psjasite = g_site
       AND psja001 = tm.no1
       
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH apsr350_x02_curs INTO sr.*                               
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
       #寫入各期的值
       LET l_sql = "SELECT psib008,psib009,COALESCE(psib011,0) FROM psib_t",
                   " WHERE psibent = '",g_enterprise,"'",
                   "   AND psibsite = '",g_site,"'",
                   "   AND psib001 = '",sr.psia001,"'",
                   "    AND psib002 = '",sr.psia002,"'",
                   "    AND psib003 = '",sr.psia003,"'",
                   "    AND psib004 = '",sr.psia004,"'",
                   "    AND psib005 = '",sr.psia005,"'",
                   "    AND psib006 = '",sr.psib006,"'",
                   "    AND psib007 = '",sr.psib007,"'",
                   "  ORDER BY psib008,psib009"
       PREPARE apsr350_x02_pre1 FROM l_sql
       DECLARE apsr350_x02_cs1 CURSOR FOR apsr350_x02_pre1
       FOREACH apsr350_x02_cs1 INTO l_psib008,l_psib009,l_psib011
          IF STATUS THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = 'foreach:'
             LET g_errparam.code   = STATUS
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
          #未展開累積預計採購數量
          IF l_psja002 = l_psib008 THEN
             LET sr.l_psib011_63 = l_psib011
             EXIT FOREACH
          END IF
          #期1~期62
          LET l_ac = l_psib008 + 17
          CASE l_psib008
             WHEN '1'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_1 = l_psib011
             WHEN '2'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_2 = l_psib011
             WHEN '3'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_3 = l_psib011
             WHEN '4'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_4 = l_psib011
             WHEN '5'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_5 = l_psib011
             WHEN '6'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_6 = l_psib011
             WHEN '7'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_7 = l_psib011
             WHEN '8'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_8 = l_psib011
             WHEN '9'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_9 = l_psib011
             WHEN '10'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_10 = l_psib011
             WHEN '11'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_11 = l_psib011
             WHEN '12'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_12 = l_psib011
             WHEN '13'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_13 = l_psib011
             WHEN '14'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_14 = l_psib011
             WHEN '15'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_15 = l_psib011
             WHEN '16'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_16 = l_psib011
             WHEN '17'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_17 = l_psib011
             WHEN '18'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_18 = l_psib011
             WHEN '19'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_19 = l_psib011
             WHEN '20'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_20 = l_psib011
             WHEN '21'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_21 = l_psib011
             WHEN '22'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_22 = l_psib011
             WHEN '23'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_23 = l_psib011
             WHEN '24'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_24 = l_psib011
             WHEN '25'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_25 = l_psib011
             WHEN '26'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_26 = l_psib011
             WHEN '27'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_27 = l_psib011
             WHEN '28'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_28 = l_psib011
             WHEN '29'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_29 = l_psib011
             WHEN '30'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_30 = l_psib011
             WHEN '31'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_31 = l_psib011
             WHEN '32'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_32 = l_psib011
             WHEN '33'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_33 = l_psib011
             WHEN '34'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_34 = l_psib011
             WHEN '35'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_35 = l_psib011
             WHEN '36'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_36 = l_psib011
             WHEN '37'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_37 = l_psib011
             WHEN '38'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_38 = l_psib011
             WHEN '39'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_39 = l_psib011
             WHEN '40'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_40 = l_psib011
             WHEN '41'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_41 = l_psib011
             WHEN '42'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_42 = l_psib011
             WHEN '43'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_43 = l_psib011
             WHEN '44'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_44 = l_psib011
             WHEN '45'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_45 = l_psib011
             WHEN '46'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_46 = l_psib011
             WHEN '47'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_47 = l_psib011
             WHEN '48'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_48 = l_psib011
             WHEN '49'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_49 = l_psib011
             WHEN '50'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_50 = l_psib011
             WHEN '51'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_51 = l_psib011
             WHEN '52'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_52 = l_psib011
             WHEN '53'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_53 = l_psib011
             WHEN '54'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_54 = l_psib011
             WHEN '55'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_55 = l_psib011
             WHEN '56'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_56 = l_psib011
             WHEN '57'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_57 = l_psib011
             WHEN '58'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_58 = l_psib011
             WHEN '59'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_59 = l_psib011
             WHEN '60'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_60 = l_psib011
             WHEN '61'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_61 = l_psib011
             WHEN '62'
                LET g_xg_fieldname[l_ac] = l_psib009
                LET sr.l_psib011_62 = l_psib011
          END CASE
       END FOREACH
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.psia003,sr.pmaal_t_pmaal004,sr.psia004,sr.ooag_t_ooag011,sr.psia005,sr.psib006,sr.x_imaal_t_imaal003,sr.x_imaal_t_imaal004,sr.psib007,sr.l_psib007_desc,sr.psib012,sr.psib013,sr.l_psic009,sr.l_psic010,sr.l_psic011,sr.l_psic012,sr.l_psic013,sr.l_psib011_1,sr.l_psib011_2,sr.l_psib011_3,sr.l_psib011_4,sr.l_psib011_5,sr.l_psib011_6,sr.l_psib011_7,sr.l_psib011_8,sr.l_psib011_9,sr.l_psib011_10,sr.l_psib011_11,sr.l_psib011_12,sr.l_psib011_13,sr.l_psib011_14,sr.l_psib011_15,sr.l_psib011_16,sr.l_psib011_17,sr.l_psib011_18,sr.l_psib011_19,sr.l_psib011_20,sr.l_psib011_21,sr.l_psib011_22,sr.l_psib011_23,sr.l_psib011_24,sr.l_psib011_25,sr.l_psib011_26,sr.l_psib011_27,sr.l_psib011_28,sr.l_psib011_29,sr.l_psib011_30,sr.l_psib011_31,sr.l_psib011_32,sr.l_psib011_33,sr.l_psib011_34,sr.l_psib011_35,sr.l_psib011_36,sr.l_psib011_37,sr.l_psib011_38,sr.l_psib011_39,sr.l_psib011_40,sr.l_psib011_41,sr.l_psib011_42,sr.l_psib011_43,sr.l_psib011_44,sr.l_psib011_45,sr.l_psib011_46,sr.l_psib011_47,sr.l_psib011_48,sr.l_psib011_49,sr.l_psib011_50,sr.l_psib011_51,sr.l_psib011_52,sr.l_psib011_53,sr.l_psib011_54,sr.l_psib011_55,sr.l_psib011_56,sr.l_psib011_57,sr.l_psib011_58,sr.l_psib011_59,sr.l_psib011_60,sr.l_psib011_61,sr.l_psib011_62,sr.l_psib011_63
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "apsr350_x02_execute"
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
    #第N期之後 ~ 62期的都隱藏
    FOR l_i = l_psja002 TO 62 
       IF cl_null(g_xgrid.visible_column) THEN
          LET g_xgrid.visible_column = "l_psib011_"||l_i
       ELSE
          LET g_xgrid.visible_column = g_xgrid.visible_column CLIPPED||"|l_psib011_"||l_i
       END IF
    END FOR
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsr350_x02.rep_data" readonly="Y" >}
PRIVATE FUNCTION apsr350_x02_rep_data()
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
 
{<section id="apsr350_x02.other_function" readonly="Y" >}

 
{</section>}
 
