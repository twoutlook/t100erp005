#該程式已解開Section, 不再透過樣板產出!
{<section id="abxt400_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-10-30 17:54:49), PR版次:0001(2016-11-17 16:59:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000003
#+ Filename...: abxt400_02
#+ Description: 出貨單產生放行單身
#+ Creator....: 02294(2016-10-30 17:48:17)
#+ Modifier...: 02294 -SD/PR- 02294
 
{</section>}
 
{<section id="abxt400_02.global" >}
#應用 t01 樣板自動產生(Version:75) 
#add-point:填寫註解說明
#Memos
#end add-point
#add-point:填寫註解說明

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_xmdk_m        RECORD
       xmdkdocno LIKE xmdk_t.xmdkdocno, 
   xmdkdocdt LIKE xmdk_t.xmdkdocdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xmdl_d        RECORD
   xmdl087 LIKE type_t.chr1, 
   xmdldocno LIKE type_t.chr500, 
   xmdlseq LIKE xmdl_t.xmdlseq, 
   xmdl008 LIKE xmdl_t.xmdl008, 
   xmdl008_desc LIKE type_t.chr500, 
   xmdl008_desc_1 LIKE type_t.chr500, 
   xmdl041 LIKE xmdl_t.xmdl041, 
   xmdl021 LIKE xmdl_t.xmdl021, 
   xmdl021_desc LIKE type_t.chr500, 
   xmdl022 LIKE xmdl_t.xmdl022, 
   xmdl060 LIKE xmdl_t.xmdl060
       END RECORD
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_bxea019             LIKE bxea_t.bxea019
DEFINE g_bxeadocno           LIKE bxea_t.bxeadocno
DEFINE g_bxea005             LIKE bxea_t.bxea005
DEFINE g_success             LIKE type_t.num5
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xmdk_m          type_g_xmdk_m
DEFINE g_xmdk_m_t        type_g_xmdk_m
DEFINE g_xmdk_m_o        type_g_xmdk_m
 
 
DEFINE g_xmdl_d          DYNAMIC ARRAY OF type_g_xmdl_d
DEFINE g_xmdl_d_t        type_g_xmdl_d
DEFINE g_xmdl_d_o        type_g_xmdl_d
 
DEFINE g_wc                  STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abxt400_02.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION abxt400_02(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_bxeadocno
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"

   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_bxeadocno  LIKE bxea_t.bxeadocno
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 

 
   LET g_bxeadocno = p_bxeadocno
   SELECT bxea019,bxea005 INTO g_bxea019,g_bxea005 FROM bxea_t WHERE bxeaent = g_enterprise AND bxeadocno = g_bxeadocno
   LET g_success = TRUE
  
   DELETE FROM abxt400_02_tmp1
 

 
   #畫面開啟 (identifier)
   OPEN WINDOW w_abxt400_02 WITH FORM cl_ap_formpath("abx","abxt400_02")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL cl_set_combo_scc('xmdl060','4083') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #進入選單 Menu (="N")
   CALL abxt400_02_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_abxt400_02
 
   #add-point:離開前 name="main.exit"
   LET INT_FLAG = FALSE
   RETURN g_success
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abxt400_02.init" >}

 

 

 

 
{</section>}
 
{<section id="abxt400_02.ui_dialog" >}

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.browser_fill" >}

 

 

 

 

 

 

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.ui_headershow" >}

 

 

 
{</section>}
 
{<section id="abxt400_02.ui_detailshow" >}

 

 

 

 
{</section>}
 
{<section id="abxt400_02.ui_browser_refresh" >}

 

 

 

 
{</section>}
 
{<section id="abxt400_02.construct" >}

 

 

 

 

 


 

 

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.query" >}

 

 

 

 
{</section>}
 
{<section id="abxt400_02.fetch" >}

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.insert" >}

 

 

 

 

 

 

 

 

 
 
{</section>}
 
{<section id="abxt400_02.modify" >}

 

 

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.input" >}

 

 

 

 

 

 

 

 
 
{</section>}
 
{<section id="abxt400_02.input.head" >}

 

 

 

 

 

 

 

 

 
 
{</section>}
 
{<section id="abxt400_02.input.body" >}
 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.input.other" >}

 

 

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.show" >}

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.detail_show" >}

 

 

 

 
{</section>}
 
{<section id="abxt400_02.reproduce" >}

  

 

 

 

 

 
 
{</section>}
 
{<section id="abxt400_02.detail_reproduce" >}

 

 

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.delete" >}

 

 

 

 

 

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.b_fill" >}

 

 

 

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.delete_b" >}

 

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.insert_b" >}

 

 

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.update_b" >}

 

 

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.key_update_b" >}

 

 

 
 
{</section>}
 
{<section id="abxt400_02.key_delete_b" >}

 

 

 
 
{</section>}
 
{<section id="abxt400_02.lock_b" >}

 

 

 

 
{</section>}
 
{<section id="abxt400_02.unlock_b" >}

 

 

 

 
{</section>}
 
{<section id="abxt400_02.set_entry" >}

 

 

 

 

 
 
{</section>}
 
{<section id="abxt400_02.set_no_entry" >}

 

 

 

 

 
 
{</section>}
 
{<section id="abxt400_02.set_entry_b" >}

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.set_no_entry_b" >}

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.set_act_visible" >}

 

 

 
 
{</section>}
 
{<section id="abxt400_02.set_act_no_visible" >}

 

 

 
{</section>}
 
{<section id="abxt400_02.set_act_visible_b" >}

 

 

 
 
{</section>}
 
{<section id="abxt400_02.set_act_no_visible_b" >}

 

 

 
{</section>}
 
{<section id="abxt400_02.default_search" >}

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.state_change" >}
   
 
{</section>}
 
{<section id="abxt400_02.idx_chk" >}

 

 

 

 
{</section>}
 
{<section id="abxt400_02.b_fill2" >}

 

 

 

 
 
{</section>}
 
{<section id="abxt400_02.fill_chk" >}

 

 

 

 

 
{</section>}
 
{<section id="abxt400_02.status_show" >}

 

 

 
{</section>}
 
{<section id="abxt400_02.mask_functions" >}
 
{</section>}
 
{<section id="abxt400_02.signature" >}
   
 
{</section>}
 
{<section id="abxt400_02.set_pk_array" >}

 

 

 

 
{</section>}
 
{<section id="abxt400_02.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="abxt400_02.msgcentre_notify" >}

 

 

 

 
 
{</section>}
 
{<section id="abxt400_02.action_chk" >}

 

 

 
{</section>}
 
{<section id="abxt400_02.other_function" readonly="Y" >}

PRIVATE FUNCTION abxt400_02_ui_dialog()


   CLEAR FORM
   CALL g_xmdl_d.clear()

   INITIALIZE g_wc TO NULL
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xmdkdocno,xmdkdocdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"

            #end add-point 
            
         #公用欄位開窗相關處理
         
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.xmdkdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkdocno
            #add-point:ON ACTION controlp INFIELD xmdkdocno name="construct.c.xmdkdocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xmdksite = '",g_site,"' AND xmdk000 IN ( '1','2','3') AND xmdkstus IN ('Y','S') AND (xmdl060 <> '3' OR xmdl060 is null) "
            CALL q_xmdkdocno_16()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdkdocno  #顯示到畫面上

      END CONSTRUCT
      
      INPUT ARRAY g_xmdl_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         BEFORE INPUT
            CALL abxt400_02_b_fill()
            LET g_rec_b = g_xmdl_d.getLength()
            
         BEFORE ROW
            LET l_ac = ARR_CURR()
            
         ON CHANGE xmdl087
            UPDATE abxt400_02_tmp1 SET xmdl087 = g_xmdl_d[l_ac].xmdl087 
              WHERE xmdldocno = g_xmdl_d[l_ac].xmdldocno AND xmdlseq = g_xmdl_d[l_ac].xmdlseq
              
         ON ACTION accept
            CALL abxt400_02_gen_bxeb()
            ACCEPT DIALOG
           
         ON ACTION cancel
            LET INT_FLAG = TRUE 
            EXIT DIALOG     

      END INPUT
      
      ON ACTION ok
         CALL abxt400_02_gen_tmp()
         CALL abxt400_02_b_fill()

      
 
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
      
   
END FUNCTION

#建立临时表
PUBLIC FUNCTION abxt400_02_create_temp_table()

   CREATE TEMP TABLE abxt400_02_tmp1
   (
   xmdl087    VARCHAR(1),   #标记是否勾选
   xmdldocno  VARCHAR(20), 
   xmdlseq    DECIMAL(10,0),
   xmdl008    VARCHAR(40), 
   xmdl041    VARCHAR(1), 
   xmdl021    VARCHAR(10),
   xmdl022    DECIMAL(20,6),
   xmdl060    VARCHAR(10)
   );
   
END FUNCTION

#删除临时表
PUBLIC FUNCTION abxt400_02_drop_temp_table()

   DROP TABLE abxt400_02_tmp1
   
END FUNCTION

#建立临时表资料
PRIVATE FUNCTION abxt400_02_gen_tmp()
DEFINE l_xmdldocno   LIKE xmdl_t.xmdldocno
DEFINE l_xmdlseq     LIKE xmdl_t.xmdlseq
DEFINE l_xmdl008     LIKE xmdl_t.xmdl008
DEFINE l_iman012     LIKE iman_t.iman012
DEFINE l_xmdl021     LIKE xmdl_t.xmdl021
DEFINE l_xmdl022     LIKE xmdl_t.xmdl022
DEFINE l_xmdl060     LIKE xmdl_t.xmdl060
DEFINE l_bxeb004_1   LIKE bxeb_t.bxeb004
DEFINE l_bxeb005_1   LIKE bxeb_t.bxeb005
DEFINE l_n           LIKE type_t.num10
DEFINE l_sql         STRING
DEFINE l_success     LIKE type_t.num5

   #單頭的「單身僅存保稅品否」有勾選時，料號若不為保稅品，則顯示錯誤
    IF g_bxea019 = 'Y' THEN
       LET l_sql = " SELECT xmdldocno,xmdlseq,xmdl008,iman012,xmdl021,xmdl022,xmdl060 FROM xmdk_t,xmdl_t,iman_t ",
                   "    WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno ",
                   "     AND xmdlent = imanent AND xmdl008 = iman001 AND imansite = '",g_site,"' AND iman012 ='Y' ",
                   "     AND xmdk000 IN ( '1','2','3') AND xmdkstus IN ('Y','S') AND (xmdl060 <> '3' OR xmdl060 is null) ", 
                   "     AND xmdlent = ",g_enterprise, " AND ",g_wc
    ELSE
       LET l_sql = " SELECT xmdldocno,xmdlseq,xmdl008,iman012,xmdl021,xmdl022,xmdl060 FROM xmdk_t,xmdl_t ",
                   "       LEFT JOIN iman_t ON imanent = xmdlent AND imansite = '",g_site,"' AND iman001 = xmdl008 ",
                   "    WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno ",
                   "     AND xmdk000 IN ( '1','2','3') AND xmdkstus IN ('Y','S') AND (xmdl060 <> '3' OR xmdl060 is null) ", 
                   "     AND xmdlent = ",g_enterprise, " AND ",g_wc
    END IF
    PREPARE abxt400_02_ins_tmp_pre FROM l_sql
    DECLARE abxt400_02_ins_tmp_cs CURSOR FOR abxt400_02_ins_tmp_pre
    
    LET l_sql = " SELECT bxeb004,SUM(bxeb005) FROM bxeb_t,bxea_t ",
               "  WHERE bxeaent = bxebent AND bxeadocno = bxebdocno ",
               "    AND bxebent = ",g_enterprise," AND bxeb001 = ? AND bxeb002 = ? ",
               "    AND bxebdocno <> '",g_bxeadocno,"' ",
               "    AND bxeastus <> 'X' ",
               " GROUP BY bxeb004 "

   PREPARE bxeb_pre2 FROM l_sql
   DECLARE bxeb_cs2 CURSOR FOR bxeb_pre2
    
    FOREACH abxt400_02_ins_tmp_cs INTO l_xmdldocno,l_xmdlseq,l_xmdl008,l_iman012,l_xmdl021,l_xmdl022,l_xmdl060
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
       
       FOREACH bxeb_cs2 USING l_xmdldocno,l_xmdlseq INTO l_bxeb004_1,l_bxeb005_1
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
             LET g_errparam.code   = SQLCA.sqlcode 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             EXIT FOREACH
          END IF
          
          IF l_bxeb004_1 <> l_xmdl021 THEN
             CALL s_aooi250_convert_qty(l_xmdl008,l_bxeb004_1,l_xmdl021,l_bxeb005_1)
                RETURNING l_success,l_bxeb005_1
          END IF
          IF cl_null(l_bxeb005_1) THEN
             LET l_bxeb005_1 = 0
          END IF
          LET l_xmdl022 =  l_xmdl022 - l_bxeb005_1
       END FOREACH

       IF l_xmdl022 = 0 THEN
          CONTINUE FOREACH
       END IF

       SELECT COUNT(xmdldocno) INTO l_n FROM abxt400_02_tmp1 WHERE xmdldocno = l_xmdldocno AND xmdlseq = l_xmdlseq
       IF l_n = 0 OR cl_null(l_n) THEN
         INSERT INTO abxt400_02_tmp1
                    (xmdl087,xmdldocno,xmdlseq,xmdl008,xmdl041,xmdl021,xmdl022,xmdl060) 
              VALUES('N',l_xmdldocno,l_xmdlseq,l_xmdl008,l_iman012,l_xmdl021,l_xmdl022,l_xmdl060)
       END IF
       
    END FOREACH
    
END FUNCTION

#写入单身资料
PRIVATE FUNCTION abxt400_02_gen_bxeb()
DEFINE l_n         LIKE type_t.num5
DEFINE l_sql       STRING
DEFINE l_bxeb001   LIKE bxeb_t.bxeb001
DEFINE l_bxeb002   LIKE bxeb_t.bxeb002
DEFINE l_bxeb003   LIKE bxeb_t.bxeb003
DEFINE l_bxeb004   LIKE bxeb_t.bxeb004
DEFINE l_bxeb005   LIKE bxeb_t.bxeb005
DEFINE l_bxeb006   LIKE bxeb_t.bxeb006
DEFINE l_bxeb007   LIKE bxeb_t.bxeb007
DEFINE l_bxeb008   LIKE bxeb_t.bxeb008
DEFINE l_bxeb009   LIKE bxeb_t.bxeb009
DEFINE l_iman012   LIKE iman_t.iman012
DEFINE l_bxebseq   LIKE bxeb_t.bxebseq
DEFINE l_xmdldocno LIKE xmdl_t.xmdldocno
DEFINE l_xmdlseq   LIKE xmdl_t.xmdlseq

   SELECT COUNT(xmdldocno) INTO l_n FROM abxt400_02_tmp1 WHERE xmdl087 = 'Y'
   IF l_n = 0 OR cl_null(l_n) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'apm-00481'
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      LET g_success = FALSE
      RETURN 
   END IF
   
   LET l_sql = " SELECT xmdldocno,xmdlseq FROM abxt400_02_tmp1 WHERE xmdl087 = 'Y' "
   PREPARE bxeb_ins_pre FROM l_sql
   DECLARE bxeb_ins_cs CURSOR FOR bxeb_ins_pre
   
   FOREACH bxeb_ins_cs INTO l_xmdldocno,l_xmdlseq
      IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
         
       CALL s_abxt400_get_bxeb(g_bxeadocno,g_bxea005,'',l_xmdldocno,l_xmdlseq) 
          RETURNING l_bxeb003,l_bxeb004,l_bxeb005,l_bxeb006,l_bxeb007,l_bxeb008,l_bxeb009,l_iman012
       IF l_bxeb005 = 0 THEN
          CONTINUE FOREACH
       END IF
       #項次加1
       SELECT MAX(bxebseq)+1 INTO l_bxebseq FROM bxeb_t
         WHERE bxebent = g_enterprise AND bxebdocno = g_bxeadocno
       IF cl_null(l_bxebseq) OR l_bxebseq = 0 THEN
          LET l_bxebseq = 1
       END IF
       
       LET l_bxeb001 = l_xmdldocno
       LET l_bxeb002 = l_xmdlseq
       
       INSERT INTO bxeb_t
                  (bxebent,bxebdocno,bxebseq,bxebsite,bxeb001,bxeb002,
                   bxeb003,bxeb004,bxeb005,bxeb006,bxeb007,bxeb008,bxeb009) 
            VALUES(g_enterprise,g_bxeadocno,l_bxebseq,g_site,
                   l_bxeb001,l_bxeb002,l_bxeb003,l_bxeb004,l_bxeb005, 
                   l_bxeb006,l_bxeb007,l_bxeb008,l_bxeb009)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bxeb_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         LET g_success = FALSE
         RETURN 
      END IF
      
   END FOREACH
   
END FUNCTION

PRIVATE FUNCTION abxt400_02_b_fill()
DEFINE l_sql       STRING

   LET l_sql = " SELECT xmdl087, xmdldocno,xmdlseq,xmdl008,xmdl041,xmdl021,xmdl022,xmdl060 ,t1.imaal003 , t3.imaal004,",
               "   t2.oocal003 FROM abxt400_02_tmp1 ",   
               " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=xmdl008 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t1.imaalent="||g_enterprise||" AND t3.imaal001=xmdl008 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=xmdl021 AND t2.oocal002='"||g_dlang||"' ",
               " ORDER BY xmdldocno,xmdlseq"
   PREPARE abxt400_02_pb FROM l_sql
   DECLARE b_fill_cs CURSOR FOR abxt400_02_pb
   
   LET g_cnt = l_ac
   LET l_ac= 1
   
   FOREACH b_fill_cs INTO g_xmdl_d[l_ac].xmdl087,g_xmdl_d[l_ac].xmdldocno,g_xmdl_d[l_ac].xmdlseq,g_xmdl_d[l_ac].xmdl008, 
       g_xmdl_d[l_ac].xmdl041,g_xmdl_d[l_ac].xmdl021,g_xmdl_d[l_ac].xmdl022,g_xmdl_d[l_ac].xmdl060, 
       g_xmdl_d[l_ac].xmdl008_desc,g_xmdl_d[l_ac].xmdl008_desc_1,g_xmdl_d[l_ac].xmdl021_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
     
      #add-point:b_fill段資料填充 name="b_fill.fill"
    
      #end add-point
   
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
   END FOREACH
   
   CALL g_xmdl_d.deleteElement(g_xmdl_d.getLength())
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
END FUNCTION

 
{</section>}
 
