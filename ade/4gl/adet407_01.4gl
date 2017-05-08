#該程式未解開Section, 採用最新樣板產出!
{<section id="adet407_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-07-01 10:16:13), PR版次:0002(2014-07-02 10:25:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000107
#+ Filename...: adet407_01
#+ Description: 營業款保全對帳匯入檔案
#+ Creator....: 04226(2014-06-30 14:19:23)
#+ Modifier...: 04226 -SD/PR- 04226
 
{</section>}
 
{<section id="adet407_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_deax_m        RECORD
       deaxdocno LIKE deax_t.deaxdocno, 
   deax003 LIKE deax_t.deax003, 
   path LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_deax002       LIKE deax_t.deax002
DEFINE g_deaxsite      LIKE deax_t.deaxsite

 type type_g_dean_d        RECORD
   deanseq   LIKE dean_t.deanseq,     #項次
   deansite  LIKE dean_t.deansite,    #營運據點
   dean001   LIKE dean_t.dean001,     #營業日期
   dean002   LIKE dean_t.dean002,     #款別分類
   dean003   LIKE dean_t.dean003,     #款別編號
   dean004   LIKE dean_t.dean004,     #卡券種編號
   dean005   LIKE dean_t.dean005,     #券面額編號
   dean006   LIKE dean_t.dean006,     #幣別
   dean007   LIKE dean_t.dean007,     #存繳數量
   dean008   LIKE dean_t.dean008,     #存繳金額
   dean009   LIKE dean_t.dean009      #支票號碼
             END RECORD
DEFINE g_dean_d        type_g_dean_d
#end add-point
 
DEFINE g_deax_m        type_g_deax_m
 
   DEFINE g_deaxdocno_t LIKE deax_t.deaxdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="adet407_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION adet407_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_deaxdocno
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_deaxdocno     LIKE deax_t.deaxdocno
   DEFINE l_sql           STRING
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_adet407_01 WITH FORM cl_ap_formpath("ade","adet407_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_deax_m.deaxdocno = p_deaxdocno
   LET g_deax002 = ''
   LET g_deaxsite = ''
   SELECT deaxsite,deax002,deax003
     INTO g_deaxsite,g_deax002,g_deax_m.deax003
     FROM deax_t
    WHERE deaxent = g_enterprise
      AND deaxdocno = p_deaxdocno
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_deax_m.deaxdocno,g_deax_m.deax003,g_deax_m.path ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_deax_m.path = ''
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaxdocno
            #add-point:BEFORE FIELD deaxdocno name="input.b.deaxdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaxdocno
            
            #add-point:AFTER FIELD deaxdocno name="input.a.deaxdocno"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaxdocno
            #add-point:ON CHANGE deaxdocno name="input.g.deaxdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deax003
            #add-point:BEFORE FIELD deax003 name="input.b.deax003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deax003
            
            #add-point:AFTER FIELD deax003 name="input.a.deax003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deax003
            #add-point:ON CHANGE deax003 name="input.g.deax003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD path
            #add-point:BEFORE FIELD path name="input.b.path"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD path
            
            #add-point:AFTER FIELD path name="input.a.path"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE path
            #add-point:ON CHANGE path name="input.g.path"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.deaxdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaxdocno
            #add-point:ON ACTION controlp INFIELD deaxdocno name="input.c.deaxdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.deax003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deax003
            #add-point:ON ACTION controlp INFIELD deax003 name="input.c.deax003"
            
            #END add-point
 
 
         #Ctrlp:input.c.path
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD path
            #add-point:ON ACTION controlp INFIELD path name="input.c.path"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
 
   #add-point:畫面關閉前 name="input.before_close"
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_adet407_01 
   
   #add-point:input段after input name="input.post_input"
   CALL adet407_01_create_tmp_teable()
   #按下確認後
   IF NOT INT_FLAG THEN
      #單頭 deax_t
      LET l_sql = " SELECT *", 
                  " FROM deax_t",
                  " WHERE deaxent= ? AND deaxdocno=? FOR UPDATE"
      
      LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
      LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
      DECLARE adet407_01_cl CURSOR FROM l_sql         # LOCK CURSOR
      #匯入 deau_t
      LET l_sql = " SELECT *", 
                  "   FROM deau_t",
                  "  WHERE deauent= ? AND deaudocno=? FOR UPDATE"
      
      LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
      LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
      DECLARE adet407_01_bcl CURSOR FROM l_sql        # LOCK CURSOR
      #差異 deav_t
      LET l_sql = " SELECT *", 
                  "   FROM deav_t",
                  "  WHERE deavent= ? AND deavdocno=? FOR UPDATE"
      
      LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
      LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
      DECLARE adet407_01_bcl2 CURSOR FROM l_sql       # LOCK CURSOR
      
      
      CALL s_transaction_begin()
      #Lock Cursor
      IF NOT adet407_01_lock_cursor() THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #比對單身資料 新增單身資料
      IF adet407_01_ins_detail() THEN
         CALL s_transaction_end('Y','0')
      ELSE
         CALL s_transaction_end('N','0')
      END IF
      
      #刪除暫存檔
      DROP TABLE adet407_01_dean
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg("deaxdocno",g_deax_m.deaxdocno,'DROP TABLE adet407_01_dean',SQLCA.sqlcode,1)
      END IF
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adet407_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="adet407_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立table
# Memo...........:
# Usage..........: CALL adet407_01_create_tmp_teable()
#                  RETURNING 回传参数
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/06/30 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adet407_01_create_tmp_teable()

   WHENEVER ERROR CONTINUE
   DROP TABLE adet407_01_dean
   CREATE TEMP TABLE adet407_01_dean(
      deandocno     LIKE dean_t.deandocno, #單據編號
      deanseq       LIKE dean_t.deanseq,   #項次
      deansite      LIKE dean_t.deansite,  #營運據點
      dean001       LIKE dean_t.dean001,   #營業日期
      dean002       LIKE dean_t.dean002,   #款別分類
      dean003       LIKE dean_t.dean003,   #款別編號
      dean004       LIKE dean_t.dean004,   #卡券種編號
      dean005       LIKE dean_t.dean005,   #券面額編號
      dean006       LIKE dean_t.dean006,   #幣別
      dean007       LIKE dean_t.dean007,   #存繳數量
      dean008       LIKE dean_t.dean008,   #存繳金額
      dean009       LIKE dean_t.dean009)   #支票號碼
      
END FUNCTION

################################################################################
# Descriptions...: 比對單身資料 新增單身資料
# Memo...........:
# Usage..........: CALL adet407_01_ins_detail()
#                :    RETURNING r_success
# Input parameter: 無
# Return code....: r_success     True/False
# Date & Author..: 2014/06/30 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adet407_01_ins_detail()
DEFINE r_success      LIKE type_t.num5
DEFINE l_sql          STRING
DEFINE l_seq          LIKE type_t.num5
DEFINE l_deav         RECORD
       deavent        LIKE deav_t.deavent,    #企業編號
       deavsite       LIKE deav_t.deavsite,   #營運據點
       deavunit       LIKE deav_t.deavunit,   #應用組織
       deavdocno      LIKE deav_t.deavdocno,  #單據編號
       deavdocdt      LIKE deav_t.deavdocdt,  #營業日期
       deavseq        LIKE deav_t.deavseq,    #項次
       deav001        LIKE deav_t.deav001,    #款別分類
       deav002        LIKE deav_t.deav002,    #款別編號
       deav003        LIKE deav_t.deav003,    #卡券種編號
       deav004        LIKE deav_t.deav004,    #券面額編號
       deav005        LIKE deav_t.deav005,    #幣別
       deav006        LIKE deav_t.deav006,    #代收數量
       deav007        LIKE deav_t.deav007,    #代收金額
       deav008        LIKE deav_t.deav008,    #支票號碼
       deav009        LIKE deav_t.deav009,    #備註
       deav010        LIKE deav_t.deav010,    #存繳單號
       deav011        LIKE deav_t.deav011,    #存繳數量
       deav012        LIKE deav_t.deav012,    #存繳金額
       deav013        LIKE deav_t.deav013,    #差異金額
       deav014        LIKE deav_t.deav014,    #是否處理
       deav015        LIKE deav_t.deav015,    #處理方式
       deav016        LIKE deav_t.deav016     #處理備註
                      END RECORD

   LET r_success = TRUE
   WHENEVER ERROR CONTINUE
   
   #刪除匯入資料與差異資料
   IF NOT adet407_01_del_detail() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
  
   #匯入資料
   
   #把存繳單號的資料存放到temp table
   IF NOT adet407_01_ins_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #匯入資料 與 temp table裡存繳單的彙整資料
   #以匯入資料為主
   LET l_sql = "SELECT deausite,deaudocdt,deau001,deau002,deau003,",
               "       deau004,deau005,deau006,COALESCE(deau007,0),deau008,",
               "       deau009,deandocno,COALESCE(dean007,0),dean008",
               "  FROM deau_t",
               "  LEFT OUTER JOIN adet407_01_dean",
               "    ON deausite = deansite AND deaudocdt = dean001",
               "   AND deau001 = dean002 AND deau002 = dean003",
               "   AND COALESCE(deau003,' ') = COALESCE(dean004,' ')",
               "   AND COALESCE(deau004,' ') = COALESCE(dean005,' ')",
               "   AND COALESCE(deau005,' ') = COALESCE(dean006,' ')",
               "   AND COALESCE(deau008,' ') = COALESCE(dean009,' ')",
               " WHERE deauent = ",g_enterprise,
               "   AND deaudocno = '",g_deax_m.deaxdocno,"'",
               " ORDER BY deaudocdt,deau001,deau002"
   PREPARE adet407_01_pre1 FROM l_sql
   DECLARE adet407_01_curs1 CURSOR FOR adet407_01_pre1
   
   INITIALIZE l_deav.* TO NULL
   LET l_seq = 1
   FOREACH adet407_01_curs1 INTO l_deav.deavsite,l_deav.deavdocdt,l_deav.deav001,l_deav.deav002,
                                 l_deav.deav003, l_deav.deav004,  l_deav.deav005,l_deav.deav006,
                                 l_deav.deav007, l_deav.deav008,  l_deav.deav009,l_deav.deav010,
                                 l_deav.deav011,l_deav.deav012
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg("deaxdocno",g_deax_m.deaxdocno,'Foreach adet407_01_curs1',SQLCA.sqlcode,1)
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      LET l_deav.deavent   = g_enterprise         #企業編號
      LET l_deav.deavsite  = g_deaxsite           #營運據點
      LET l_deav.deavunit  = g_deaxsite           #應用組織
      LET l_deav.deavdocno = g_deax_m.deaxdocno   #單據編號
      LET l_deav.deavseq   = l_seq                #項次
      IF cl_null(l_deav.deav010) THEN             #差異金額
         LET l_deav.deav013   = 0 - l_deav.deav007
      ELSE
         LET l_deav.deav013   = l_deav.deav012 - l_deav.deav007
      END IF
      LET l_deav.deav014   = 'N'                  #是否處理
      LET l_deav.deav015   = NULL                 #處理方式
      LET l_deav.deav016   = NULL                 #處理備註
      
      IF cl_null(l_deav.deav010) THEN
         LET l_deav.deav011 = NULL
      END IF
      
      INSERT INTO deav_t
            (deavent,deavsite,deavunit,deavdocno,deavdocdt,
             deavseq,deav001,deav002,deav003,deav004,
             deav005,deav006,deav007,deav008,deav009,
             deav010,deav011,deav012,deav013,deav014,
             deav015,deav016)
            VALUES(l_deav.deavent,l_deav.deavsite,l_deav.deavunit,l_deav.deavdocno,l_deav.deavdocdt,
                   l_deav.deavseq,l_deav.deav001, l_deav.deav002, l_deav.deav003,  l_deav.deav004,
                   l_deav.deav005,l_deav.deav006, l_deav.deav007, l_deav.deav008,  l_deav.deav009,
                   l_deav.deav010,l_deav.deav011, l_deav.deav012, l_deav.deav013,  l_deav.deav014,
                   l_deav.deav015,l_deav.deav016)
                   
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg("deaxdocno",g_deax_m.deaxdocno,'INSERT INTO deav_t',SQLCA.sqlcode,1)
         LET r_success = FALSE
      END IF
      
      LET l_seq = l_seq + 1
      INITIALIZE l_deav.* TO NULL
      
   END FOREACH
   
   #temp table裡存繳單的彙整資料 與 匯入資料
   #不存在匯入資料的存繳單的彙整資料
   LET l_sql = "SELECT deansite,dean001,dean002,dean003,dean004,",
               "       dean005,dean006,deandocno,dean007,dean008",
               "  FROM adet407_01_dean",
               " WHERE NOT EXISTS (SELECT * FROM deau_t",
               "                    WHERE deausite = deansite AND deaudocdt = dean001",
               "                      AND deau001 = dean002 AND deau002 = dean003",
               "                      AND COALESCE(deau003,' ') = COALESCE(dean004,' ')",
               "                      AND COALESCE(deau004,' ') = COALESCE(dean005,' ')",
               "                      AND COALESCE(deau005,' ') = COALESCE(dean006,' ')",
               "                      AND COALESCE(deau008,' ') = COALESCE(dean009,' ')",
               "                      AND deauent = ",g_enterprise,
               "                      AND deaudocno = '",g_deax_m.deaxdocno,"')"
               
   PREPARE adet407_01_pre2 FROM l_sql
   DECLARE adet407_01_curs2 CURSOR FOR adet407_01_pre2
   
   INITIALIZE l_deav.* TO NULL
   FOREACH adet407_01_curs2 INTO l_deav.deavsite,l_deav.deavdocdt,l_deav.deav001,l_deav.deav002,
                                 l_deav.deav003, l_deav.deav004,  l_deav.deav005,l_deav.deav010,
                                 l_deav.deav011, l_deav.deav012
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg("deaxdocno",g_deax_m.deaxdocno,'Foreach adet407_01_curs1',SQLCA.sqlcode,1)
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      LET l_deav.deavent   = g_enterprise                      #企業編號
      LET l_deav.deavsite  = g_deaxsite                        #營運據點
      LET l_deav.deavunit  = g_deaxsite                        #應用組織
      LET l_deav.deavdocno = g_deax_m.deaxdocno                #單據編號
      LET l_deav.deavseq   = l_seq                             #項次
      LET l_deav.deav013   = l_deav.deav012                    #差異金額
      LET l_deav.deav014   = 'N'                               #是否處理
      LET l_deav.deav015   = NULL                              #處理方式
      LET l_deav.deav016   = NULL                              #處理備註
      
      INSERT INTO deav_t
            (deavent,deavsite,deavunit,deavdocno,deavdocdt,
             deavseq,deav001,deav002,deav003,deav004,
             deav005,deav006,deav007,deav008,deav009,
             deav010,deav011,deav012,deav013,deav014,
             deav015,deav016)
            VALUES(l_deav.deavent,l_deav.deavsite,l_deav.deavunit,l_deav.deavdocno,l_deav.deavdocdt,
                   l_deav.deavseq,l_deav.deav001, l_deav.deav002, l_deav.deav003,  l_deav.deav004,
                   l_deav.deav005,l_deav.deav006, l_deav.deav007, l_deav.deav008,  l_deav.deav009,
                   l_deav.deav010,l_deav.deav011, l_deav.deav012, l_deav.deav013,  l_deav.deav014,
                   l_deav.deav015,l_deav.deav016)
                   
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg("deaxdocno",g_deax_m.deaxdocno,'INSERT INTO deav_t',SQLCA.sqlcode,1)
         LET r_success = FALSE
      END IF
      
      LET l_seq = l_seq + 1
      INITIALIZE l_deav.* TO NULL
      
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 把存繳單號的資料存放到temp table
# Memo...........:
# Usage..........: CALL adet407_01_ins_temp()
#                :    RETURNING r_success
# Input parameter: 無
# Return code....: r_success     True/False
# Date & Author..: 2014/06/30 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adet407_01_ins_temp()
DEFINE r_success      LIKE type_t.num5
DEFINE l_sql          STRING
DEFINE l_seq          LIKE type_t.num5
DEFINE l_ac           LIKE type_t.num5

   LET r_success = TRUE
   
   LET l_sql = "SELECT DISTINCT deansite,dean001,dean002,dean003,dean004,",
               "                dean005,dean006,dean009,SUM(dean007),COALESCE(SUM(dean008),0)",
               "  FROM dean_t",
               " WHERE deanent = ",g_enterprise,
               "   AND deandocno = '",g_deax002,"'",
               " GROUP BY deansite,dean001,dean002,dean003,dean004,dean005,dean006,dean009",
               " ORDER BY deansite,dean001,dean002,dean003"
   PREPARE adet407_01_pre FROM l_sql
   DECLARE adet407_01_curs CURSOR FOR adet407_01_pre
   
   LET l_seq = 1
   INITIALIZE g_dean_d.* TO NULL
   FOREACH adet407_01_curs INTO g_dean_d.deansite,g_dean_d.dean001,
                                g_dean_d.dean002, g_dean_d.dean003,
                                g_dean_d.dean004, g_dean_d.dean005,
                                g_dean_d.dean006, g_dean_d.dean009,
                                g_dean_d.dean007, g_dean_d.dean008
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg("deaxdocno",g_deax_m.deaxdocno,'Foreach adet407_01_curs',SQLCA.sqlcode,1)
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      INSERT INTO adet407_01_dean
            (deandocno,deanseq,deansite,dean001,dean002,
             dean003,  dean004,dean005, dean006,dean007,
             dean008,  dean009)
            VALUES(g_deax002,l_seq,g_dean_d.deansite,g_dean_d.dean001,
                   g_dean_d.dean002,g_dean_d.dean003,g_dean_d.dean004,
                   g_dean_d.dean005,g_dean_d.dean006,g_dean_d.dean007,
                   g_dean_d.dean008,g_dean_d.dean009)
                   
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg("deaxdocno",g_deax_m.deaxdocno,'INSERT INTO adet407_tmp',SQLCA.sqlcode,1)
         LET r_success = FALSE
      END IF
      
      LET l_seq = l_seq + 1
   
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除單身匯入資料與差異資料
# Memo...........:
# Usage..........: CALL adet407_01_del_detail()
#                :    RETURNING r_success
# Input parameter: 無
# Return code....: r_success     True/False
# Date & Author..: 2014/07/01 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adet407_01_del_detail()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   #匯入資料
#   DELETE FROM deau_t
#    WHERE deauent = g_enterprise
#      AND deaudocno = g_deax_m.deaxdocno
#   IF SQLCA.sqlcode THEN
#      CALL cl_errmsg("deaxdocno",g_deax_m.deaxdocno,'Delete deau_t',SQLCA.sqlcode,1)
#      LET r_success = FALSE
#   END IF
   
   #差異資料
   DELETE FROM deav_t
    WHERE deavent = g_enterprise
      AND deavdocno = g_deax_m.deaxdocno
   IF SQLCA.sqlcode THEN
      CALL cl_errmsg("deaxdocno",g_deax_m.deaxdocno,'Delete deav_t',SQLCA.sqlcode,1)
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單身進行lock_cursor
# Memo...........:
# Usage..........: CALL adet407_01_lock_cursor()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2014/07/01 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adet407_01_lock_cursor()
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   #單頭 deau_t
   OPEN adet407_01_cl USING g_enterprise,g_deax_m.deaxdocno
   IF SQLCA.sqlcode THEN
      CALL cl_errmsg("deaxdocno",g_deax_m.deaxdocno,'adet407_01_cl',SQLCA.sqlcode,1)
      LET r_success = FALSE
   END IF
   #匯入 deau_t
   OPEN adet407_01_bcl USING g_enterprise,g_deax_m.deaxdocno
   IF SQLCA.sqlcode THEN
      CALL cl_errmsg("deaxdocno",g_deax_m.deaxdocno,'adet407_01_bcl',SQLCA.sqlcode,1)
      LET r_success = FALSE
   END IF
   #差異 deav_t
   OPEN adet407_01_bcl2 USING g_enterprise,g_deax_m.deaxdocno
   IF SQLCA.sqlcode THEN
      CALL cl_errmsg("deaxdocno",g_deax_m.deaxdocno,'adet407_01_bc2',SQLCA.sqlcode,1)
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
