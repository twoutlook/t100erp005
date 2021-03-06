#該程式未解開Section, 採用最新樣板產出!
{<section id="aimi150_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-09-23 16:07:05), PR版次:0006(2016-12-07 11:07:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000253
#+ Filename...: aimi150_01
#+ Description: 產品分類批次產生
#+ Creator....: 01258(2013-08-16 10:39:43)
#+ Modifier...: 02294 -SD/PR- 06978
 
{</section>}
 
{<section id="aimi150_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160728-00011#1 2016/07/28 By 06948 增加以企業據點ENT為SQL條件
#160914-00032#1 2016/09/23 By lixiang 產品分類批次產生時，原先抓imaa009，現在改抓aimi010做批次產生
#161206-00033#1 2016/12/07 By ywtsai  產生產品分類資料時增加判斷為營運據點的據點才產生
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="aimi150_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}
{</Module define>}
#end add-point
 
{</section>}
 
{<section id="aimi150_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
PRIVATE type type_g_ooef_m        RECORD
       ooef001 LIKE ooef_t.ooef001, 
       #imaa009 LIKE type_t.chr80,   #160914-00032#1
       rtax001 LIKE type_t.chr80,    #160914-00032#1
       imda003 LIKE type_t.chr80, 
       imda004 LIKE imda_t.imda004,
       imda005 LIKE imda_t.imda005
       END RECORD
DEFINE g_ooef_m        type_g_ooef_m
DEFINE g_ooef001_t     LIKE ooef_t.ooef001    #Key值備份
DEFINE l_wc            STRING
DEFINE l_wc1           STRING
DEFINE l_success       LIKE type_t.chr1
DEFINE l_sql           STRING
#end add-point
 
{</section>}
 
{<section id="aimi150_01.other_dialog" >}

 
{</section>}
 
{<section id="aimi150_01.other_function" readonly="Y" >}
#整批新增
PRIVATE FUNCTION aimi150_01_ins()
DEFINE l_time          LIKE imda_t.imdacrtdt
DEFINE l_imda001       LIKE imda_t.imda001
DEFINE l_imda002       LIKE imda_t.imda002
DEFINE l_rtaxl003      LIKE rtaxl_t.rtaxl003
DEFINE g_show_msg      DYNAMIC ARRAY OF RECORD    #程式變數(Program Variables)
       imda001         LIKE imda_t.imda001,   #營運據點
       imda002         LIKE imda_t.imda002,   #產品分類
       rtaxl003        LIKE rtaxl_t.rtaxl003, #產品分類說明
       imda004         LIKE imda_t.imda004,   #補給策略
       imda005         LIKE imda_t.imda005,   #BOM引入
       imda003         LIKE imda_t.imda003    #引入方式
                       END RECORD
DEFINE l_msg           STRING
DEFINE l_msg2          STRING
DEFINE ls_gaq03        STRING
DEFINE g_i             LIKE type_t.num10                      
                       
                       
   LET l_success = 'Y' 
   CALL s_transaction_begin()
 
   CALL aimi150_01_ins_tmp()
   
   LET l_time = cl_get_current()  
   
   LET l_sql = "  MERGE INTO imda_t",
               #160914-00032#1---s
               #"  USING(SELECT DISTINCT ooef001,imaa009,ooefent  ",
               #"          FROM ooef_t,imaa_t ",
               #"         WHERE imaa009 IS NOT NULL AND imaaent = ",g_enterprise," AND ooefent = ",g_enterprise," ",
               "  USING(SELECT DISTINCT ooef001,rtax001,ooefent  ",
               "          FROM ooef_t,rtax_t ",
               "         WHERE rtax001 IS NOT NULL AND rtaxent = ",g_enterprise," AND ooefent = ",g_enterprise," ",
               #160914-00032#1----e
               "           AND ooef201 = 'Y' ",                           #161206-00033#1 add
               "           AND ",l_wc CLIPPED, " AND ", l_wc1 CLIPPED,")",
               #"     ON(ooefent = imdaent AND ooef001 = imda001 AND imaa009 = imda002 AND imdaent = ",g_enterprise,") ",  #160914-00032#1
               "     ON(ooefent = imdaent AND ooef001 = imda001 AND rtax001 = imda002 AND imdaent = ",g_enterprise,") ",  #160914-00032#1
               "   WHEN MATCHED THEN ",
               " UPDATE SET imdastus='Y' , imda003='",g_ooef_m.imda003,"' , imda004='",g_ooef_m.imda004,"',imda005='",g_ooef_m.imda005,"',",
               " imdamodid='",g_user,"',imdamoddt=TIMESTAMP '",l_time,"' ",
               "   WHEN NOT MATCHED THEN ",
               " INSERT(imdaent,imda001,imda002,imdastus,imda003,imda004,imda005,imdaownid,imdaowndp,imdacrtid,imdacrtdt,imdacrtdp,imdamodid,imdamoddt)",
               #" VALUES('",g_enterprise,"',ooef001,imaa009,'Y','",g_ooef_m.imda003,"','",g_ooef_m.imda004,"','",g_ooef_m.imda005,"','",g_user,"','",g_dept,"','",g_user,"',TIMESTAMP '",l_time,"','",g_dept,"','",g_user,"',TIMESTAMP '",l_time,"')"  #160914-00032#1
               " VALUES('",g_enterprise,"',ooef001,rtax001,'Y','",g_ooef_m.imda003,"','",g_ooef_m.imda004,"','",g_ooef_m.imda005,"','",g_user,"','",g_dept,"','",g_user,"',TIMESTAMP '",l_time,"','",g_dept,"','",g_user,"',TIMESTAMP '",l_time,"')"  #160914-00032#1
   PREPARE ins_imda_pre FROM l_sql
   EXECUTE ins_imda_pre
   IF SQLCA.sqlcode THEN
      LET l_success = 'N'
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aim-00102'
      LET g_errparam.extend = 'ins imda_t:'
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   LET g_i = 1
   LET l_sql = "SELECT DISTINCT imda001,imda002 ",
               "  FROM imda_t a ",
               " WHERE NOT EXISTS (SELECT 1 FROM imda_tmp b ",
               "                    WHERE a.imdaent = b.imdaent ",
               "                      AND a.imda001 = b.imda001 ",
               "                      AND a.imda002 = b.imda002 )"
              ,"   AND a.imdaent = '",g_enterprise,"' "    #160728-00011#1 add
   PREPARE aimi150_01_sel_pre FROM l_sql
   DECLARE aimi150_01_sel_cs CURSOR FOR aimi150_01_sel_pre
   FOREACH aimi150_01_sel_cs INTO l_imda001,l_imda002
      LET g_show_msg[g_i].imda001=l_imda001
      LET g_show_msg[g_i].imda002=l_imda002
      SELECT rtaxl003 INTO l_rtaxl003
        FROM rtaxl_t
       WHERE rtaxl001 = l_imda002
         AND rtaxl002 = g_dlang
         AND rtaxlent = g_enterprise
      LET g_show_msg[g_i].rtaxl003=l_rtaxl003
      LET g_show_msg[g_i].imda003=g_ooef_m.imda003
      LET g_show_msg[g_i].imda004=g_ooef_m.imda004
      LET g_show_msg[g_i].imda005=g_ooef_m.imda005
      LET g_i = g_i + 1
   END FOREACH
   IF l_success = 'N' THEN
      CALL s_transaction_end('N','0')
   ELSE
      LET ls_gaq03 = cl_get_feldname("imda001",g_dlang)
      LET l_msg2 = ls_gaq03 CLIPPED
      
      LET ls_gaq03 = cl_get_feldname("imda002",g_dlang)
      LET l_msg2 = l_msg2.trim(),"|",ls_gaq03 CLIPPED
      
      LET ls_gaq03 = cl_get_feldname("rtaxl003",g_dlang)
      LET l_msg2 = l_msg2.trim(),"|",ls_gaq03 CLIPPED
      
      LET ls_gaq03 = cl_get_feldname("imda004",g_dlang)
      LET l_msg2 = l_msg2.trim(),"|",ls_gaq03 CLIPPED
      
      LET ls_gaq03 = cl_get_feldname("imda005",g_dlang)
      LET l_msg2 = l_msg2.trim(),"|",ls_gaq03 CLIPPED
      
      LET ls_gaq03 = cl_get_feldname("imda003",g_dlang)
      LET l_msg2 = l_msg2.trim(),"|",ls_gaq03 CLIPPED
      
      LET l_msg = cl_getmsg("aim-00122",g_lang)
      CALL cl_show_array(base.TypeInfo.create(g_show_msg),l_msg,l_msg2)
   
      CALL s_transaction_end('Y','0')
   END IF
END FUNCTION
#填充臨時表資料
PRIVATE FUNCTION aimi150_01_ins_tmp()
   LET l_sql = "INSERT INTO imda_tmp(imdaent,imda001,imda002)",
               "SELECT imdaent,imda001,imda002 ",
               "  FROM imda_t ",
               "  WHERE imdaent = '",g_enterprise,"' "
   PREPARE ins_imda_tmp_pre FROM l_sql
   EXECUTE ins_imda_tmp_pre
   IF SQLCA.sqlcode THEN
      LET l_success = 'N'
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aim-00102'
      LET g_errparam.extend = 'ins imda_tmp:'
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   
END FUNCTION
#+ 資料輸入
PUBLIC FUNCTION aimi150_01()
 
   WHENEVER ERROR CALL cl_err_msg_log
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aimi150_01 WITH FORM cl_ap_formpath("aim","aimi150_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   CLEAR FORM
   CALL cl_set_combo_scc("imda003",1102)
   CALL cl_set_combo_scc("imda004",2022)
   CALL aimi150_01_crt_tmp()
   LET g_ooef_m.imda005 = 'N'
   LET g_ooef_m.imda003 = '1'
   LET g_ooef_m.imda004 = '1'
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_ooef_m.imda003,g_ooef_m.imda004,g_ooef_m.imda005 ATTRIBUTE(WITHOUT DEFAULTS)
         AFTER FIELD imda003
            
         AFTER FIELD imda004
            IF g_ooef_m.imda004 = '2' OR g_ooef_m.imda004 = '3' THEN
               LET g_ooef_m.imda005 = 'Y'
            END IF
          
         ON CHANGE imda004
            IF g_ooef_m.imda004 = '2' OR g_ooef_m.imda004 = '3' THEN
               LET g_ooef_m.imda005 = 'Y'
            END IF
            
         AFTER FIELD imda005
         
         AFTER INPUT

      END INPUT
    
      CONSTRUCT BY NAME l_wc ON ooef001
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            
         ON ACTION controlp INFIELD ooef001
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooefstus = 'Y' AND ooef201 = 'Y' "
            CALL q_ooef001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooef001  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD ooef001                     #返回原欄位
            
      END CONSTRUCT  

      #CONSTRUCT BY NAME l_wc1 ON imaa009  #160914-00032#1
      CONSTRUCT BY NAME l_wc1 ON rtax001  #160914-00032#1
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            
         #ON ACTION controlp INFIELD imaa009  #160914-00032#1
         ON ACTION controlp INFIELD rtax001  #160914-00032#1
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtaxstus = 'Y' "
            CALL q_rtax001_1()                       #呼叫開窗
            #DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上   #160914-00032#1
            DISPLAY g_qryparam.return1 TO rtax001  #顯示到畫面上   #160914-00032#1
            LET g_qryparam.where = ""
            #NEXT FIELD imaa009                     #返回原欄位    #160914-00032#1
            NEXT FIELD rtax001                     #返回原欄位    #160914-00032#1
   
      END CONSTRUCT    
    
      #公用action
      ON ACTION accept
         LET INT_FLAG = FALSE
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
   IF NOT INT_FLAG THEN
      CALL aimi150_01_ins()
   END IF
   DROP TABLE imda_tmp
   #畫面關閉
   CLOSE WINDOW w_aimi150_01
END FUNCTION
#創建臨時表
PRIVATE FUNCTION aimi150_01_crt_tmp()
   
   CREATE TEMP TABLE imda_tmp
   (
       imdaent       INT,
       imda001       VARCHAR(10),
       imda002       VARCHAR(10)
   );
   
END FUNCTION

 
{</section>}
 
