#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr171_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-06-30 02:43:47), PR版次:0004(2016-06-30 02:46:53)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000069
#+ Filename...: axmr171_x01
#+ Description: ...
#+ Creator....: 02748(2014-08-29 16:27:59)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="axmr171_x01.global" readonly="Y" >}
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
 
{<section id="axmr171_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr171_x01(p_arg1)
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
   LET g_rep_code = "axmr171_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr171_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr171_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr171_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr171_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr171_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr171_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr171_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmic001.xmic_t.xmic001,xmic002.xmic_t.xmic002,xmic003.xmic_t.xmic003,xmic007.xmic_t.xmic007,xmic006.xmic_t.xmic006,xmic004.xmic_t.xmic004,xmic005.xmic_t.xmic005,xmid007.xmid_t.xmid007,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,xmid008.xmid_t.xmid008,l_imaa009.imaa_t.imaa009,l_rtaxl003.rtaxl_t.rtaxl003,xmid010.xmid_t.xmid010,l_xmid010_desc.oocql_t.oocql004,xmid009.xmid_t.xmid009,l_xmid009_desc.pmaal_t.pmaal004,xmid014.xmid_t.xmid014,xmid011.xmid_t.xmid011,xmid015.xmid_t.xmid015,xmid016.xmid_t.xmid016,xmid018.xmid_t.xmid018,xmid019.xmid_t.xmid019,xmid020.xmid_t.xmid020,l_imaa127.type_t.chr30,l_imaa127_desc.type_t.chr50,l_imaa127desc.type_t.chr80" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr171_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr171_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axmr171_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr171_x01_sel_prep()
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
   #151113-00022#7 20151119 s983961--ADD(S)
   LET g_select = " SELECT xmic001,xmic002,xmic003,xmic007,xmic006,xmic004,xmic005,
       x.xmid007,x.imaal003,x.imaal004,
       x.xmid008,x.imaa009,x.rtaxl003,
       x.xmid010,x.a1_oocql004,
       x.xmid009,x.pmaal004,
       x.xmid014,x.xmid011,x.xmid015,x.xmid016,x.xmid018,x.xmid019,
       x.xmid020,x.imaa127,x.a2_oocql004,
       CASE WHEN x.a2_oocql004 IS NULL THEN x.a2_oocql004 ELSE trim(x.imaa127)||'.'||trim(x.a2_oocql004) END" 
   #151113-00022#8 20151119 s983961--ADD(E)     
#   #end add-point
#   LET g_select = " SELECT xmic001,xmic002,xmic003,xmic007,xmic006,xmic004,xmic005,xmid007,'','',xmid008, 
#       '','',xmid010,'',xmid009,'',xmid014,xmid011,xmid015,xmid016,xmid018,xmid019,xmid020,'','',''" 
#
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #151113-00022#7 20151119 s983961--ADD(S)
   LET g_from =#" FROM  xmic_t  LEFT OUTER JOIN ( SELECT xmid_t.*,imaal003,imaal004,imaa009,rtaxl003,a1.oocql004 a1_oocql004,pmaal004,imaa127,a2.oocql004 a2_oocql004 ",   #160621-00003#6 160629 by lori mark
                " FROM  xmic_t  LEFT OUTER JOIN ( SELECT xmid_t.*,imaal003,imaal004,imaa009,rtaxl003,a1.oojdl003 a1_oocql004,pmaal004,imaa127,a2.oocql004 a2_oocql004 ",   #160621-00003#6 160629 by lori add
                "                                   FROM xmid_t  ",
                "                                   LEFT OUTER JOIN imaal_t  ON imaalent = xmident AND imaal001 = xmid007 AND imaal002 = '",g_dlang,"' ",  
                "                                   LEFT OUTER JOIN imaa_t  ON imaaent = xmident AND imaa001 = xmid007  ",
                "                                   LEFT OUTER JOIN rtaxl_t ON rtaxlent = xmident AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"' ",
               #160621-00003#6 160629 by lori mark and add---(S)
               #"                                   LEFT OUTER JOIN oocql_t a1 ON a1.oocqlent = xmident AND a1.oocql001 = '275' AND a1.oocql002 = xmid010 AND a1.oocql003 = '",g_dlang,"' ",                
                "                                   LEFT OUTER JOIN oojdl_t a1 ON a1.oojdlent = xmident AND a1.oojdl001 = xmid010 AND a1.oojdl002 = '",g_dlang,"' ",                
               #160621-00003#6 160629 by lori mark and add---(E) 
                "                                   LEFT OUTER JOIN pmaal_t ON pmaalent = xmident AND pmaal001 = xmid009 AND pmaal002 = '",g_dlang,"' ",
                "                                   LEFT OUTER JOIN oocql_t a2 ON a2.oocqlent = xmident AND a2.oocql001 = '2003' AND a2.oocql002 = imaa127 AND a2.oocql003 = '",g_dlang,"' ",  
                "                               ) x ON xmic_t.xmicent = x.xmident AND xmic_t.xmic001 = x.xmid001 AND xmic_t.xmic002 = x.xmid002 AND xmic_t.xmic003 = x.xmid003 AND xmic_t.xmic004 = x.xmid004 AND xmic_t.xmic005 = x.xmid005 AND xmic_t.xmic006 = x.xmid006 "                 
                #"               LEFT OUTER JOIN imaa_t ON imaaent = xmident AND imaa001 = xmid007 "        
    #151113-00022#8 20151119 s983961--ADD(E)                 
#   #end add-point
#    LET g_from = " FROM  xmic_t  LEFT OUTER JOIN ( SELECT xmid_t.* FROM xmid_t  ) x  ON xmic_t.xmicent  
#        = x.xmident AND xmic_t.xmic001 = x.xmid001 AND xmic_t.xmic002 = x.xmid002 AND xmic_t.xmic003  
#        = x.xmid003 AND xmic_t.xmic004 = x.xmid004 AND xmic_t.xmic005 = x.xmid005 AND xmic_t.xmic006  
#        = x.xmid006"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   #LET g_from = g_from, " LEFT OUTER JOIN imaa_t ON imaaent = xmident AND imaa001 = xmid007 "  #151113-00022#8 效能調整 s983961--mark
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmic_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axmr171_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr171_x01_curs CURSOR FOR axmr171_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr171_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr171_x01_ins_data()
DEFINE sr RECORD 
   xmic001 LIKE xmic_t.xmic001, 
   xmic002 LIKE xmic_t.xmic002, 
   xmic003 LIKE xmic_t.xmic003, 
   xmic007 LIKE xmic_t.xmic007, 
   xmic006 LIKE xmic_t.xmic006, 
   xmic004 LIKE xmic_t.xmic004, 
   xmic005 LIKE xmic_t.xmic005, 
   xmid007 LIKE xmid_t.xmid007, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   xmid008 LIKE xmid_t.xmid008, 
   l_imaa009 LIKE imaa_t.imaa009, 
   l_rtaxl003 LIKE rtaxl_t.rtaxl003, 
   xmid010 LIKE xmid_t.xmid010, 
   l_xmid010_desc LIKE oocql_t.oocql004, 
   xmid009 LIKE xmid_t.xmid009, 
   l_xmid009_desc LIKE pmaal_t.pmaal004, 
   xmid014 LIKE xmid_t.xmid014, 
   xmid011 LIKE xmid_t.xmid011, 
   xmid015 LIKE xmid_t.xmid015, 
   xmid016 LIKE xmid_t.xmid016, 
   xmid018 LIKE xmid_t.xmid018, 
   xmid019 LIKE xmid_t.xmid019, 
   xmid020 LIKE xmid_t.xmid020, 
   l_imaa127 LIKE type_t.chr30, 
   l_imaa127_desc LIKE type_t.chr50, 
   l_imaa127desc LIKE type_t.chr80
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr171_x01_curs INTO sr.*                               
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
       #151113-00022#8 效能調整 s983961--mark(s)
       #CALL s_desc_get_item_desc(sr.xmid007)RETURNING sr.l_imaal003,sr.l_imaal004
       
       #SELECT imaa009 INTO sr.l_imaa009
       #  FROM imaa_t
       # WHERE imaaent = g_enterprise
       #   AND imaa001 = sr.xmid007
       
       #SELECT rtaxl003 INTO sr.l_rtaxl003
       #  FROM rtaxl_t
       # WHERE rtaxlent = g_enterprise
       #   AND rtaxl001 = sr.l_imaa009
       #   AND rtaxl002 = g_dlang
           
       #SELECT oocql004 INTO sr.l_xmid010_desc
       #  FROM oocql_t
       # WHERE oocqlent = g_enterprise
       #   AND oocql001 = '275'
       #   AND oocql002 = sr.xmid010
       #   AND oocql003 = g_dlang
          
       #SELECT pmaal004 INTO sr.l_xmid009_desc
       #  FROM pmaal_t
       # WHERE pmaalent = g_enterprise
       #   AND pmaal001 = sr.xmid009
       #   AND pmaal002 = g_dlang
       ##系列    20150819 by dorislai add   (S)
       #   #用料號抓取系列
       #SELECT imaa127 INTO sr.l_imaa127 FROM imaa_t
       # WHERE imaa001 = sr.xmid007
       #   AND imaaent = g_enterprise
       #   #抓取系列說明
       #CALL s_desc_get_acc_desc('2003',sr.l_imaa127)  RETURNING sr.l_imaa127_desc   
       #IF NOT cl_null(sr.l_imaa127_desc) THEN
       #   LET sr.l_imaa127desc = sr.l_imaa127,'.',sr.l_imaa127_desc 
       #ELSE
       #   LET sr.l_imaa127desc = ''
       #END IF
       #        20150819 by dorislai add   (E)
       #151113-00022#8 效能調整 s983961--mark(s)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xmic001,sr.xmic002,sr.xmic003,sr.xmic007,sr.xmic006,sr.xmic004,sr.xmic005,sr.xmid007,sr.l_imaal003,sr.l_imaal004,sr.xmid008,sr.l_imaa009,sr.l_rtaxl003,sr.xmid010,sr.l_xmid010_desc,sr.xmid009,sr.l_xmid009_desc,sr.xmid014,sr.xmid011,sr.xmid015,sr.xmid016,sr.xmid018,sr.xmid019,sr.xmid020,sr.l_imaa127,sr.l_imaa127_desc,sr.l_imaa127desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr171_x01_execute"
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
 
{<section id="axmr171_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr171_x01_rep_data()
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
 
{<section id="axmr171_x01.other_function" readonly="Y" >}

 
{</section>}
 
