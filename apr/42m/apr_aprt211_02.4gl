#該程式未解開Section, 採用最新樣板產出!
{<section id="aprt211_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-03-19 16:02:07), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000165
#+ Filename...: aprt211_02
#+ Description: 商品快速輸入
#+ Creator....: 02482(2014-03-13 16:15:40)
#+ Modifier...: 06137 -SD/PR- 00000
 
{</section>}
 
{<section id="aprt211_02.global" >}
#應用 c01c 樣板自動產生(Version:10)
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
 
DEFINE g_rec_b               LIKE type_t.num10
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_sel_d        RECORD
     sel         LIKE type_t.chr80,
     sel01       LIKE type_t.chr80,
     sel02       LIKE type_t.chr80,
     sel03       LIKE type_t.chr80,
     sel04       LIKE type_t.chr80,
     sel05       LIKE type_t.chr80,
     sel06       LIKE type_t.chr80,
     sel07       LIKE type_t.num20_6
       END RECORD

DEFINE g_sel_d               DYNAMIC ARRAY OF type_g_sel_d
DEFINE g_sel_d_t             type_g_sel_d
DEFINE g_sql                 STRING
DEFINE l_ac                  LIKE type_t.num5 
DEFINE g_detail_cnt          LIKE type_t.num5
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_prdadocno           LIKE prda_t.prdadocno
DEFINE g_prdg002             LIKE prdg_t.prdg002
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="aprt211_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aprt211_02(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   p_prdadocno,p_prdg002
   #end add-point
   )
   #add-point:construct段define name="construct.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   DEFINE p_prdadocno     LIKE prda_t.prdadocno
   DEFINE p_prdg002       LIKE prdg_t.prdg002
   LET g_prdadocno = p_prdadocno
   LET g_prdg002 = p_prdg002
   IF cl_null(g_prdg002) THEN
      LET g_prdg002 = 1
   END IF
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aprt211_02 WITH FORM cl_ap_formpath("apr","aprt211_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON imaa001,imaa009,imaa131,imaa126,imaa127,imaa128,imaa129,imaa132,imaa133, 
          imaa134,imaa135,imaa136,imaa137,imaa138,imaa139,imaa140,imaa141 
      
            #add-point:自定義action name="construct.action"
            
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
            ON ACTION controlp INFIELD imaa001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " rtdxsite = '",g_site,"' AND rtdxstus = 'Y' AND imaastus = 'Y'"
               CALL q_rtdx001_12()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上
               NEXT FIELD imaa001                     #返回原欄位
               
            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " rtaxstus = 'Y'"
               CALL q_rtax001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
               NEXT FIELD imaa009                     #返回原欄位   
            
            ON ACTION controlp INFIELD imaa131
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2001"
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa131  #顯示到畫面上
               NEXT FIELD imaa131                     #返回原欄位
               
            ON ACTION controlp INFIELD imaa126
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2002" #應用分類
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa126  #顯示到畫面上
               NEXT FIELD imaa126                     #返回原欄位   
               
            ON ACTION controlp INFIELD imaa127
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2003" #應用分類
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa127  #顯示到畫面上
               NEXT FIELD imaa127                     #返回原欄位   
               
            ON ACTION controlp INFIELD imaa128
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2004" #應用分類
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa128  #顯示到畫面上
               NEXT FIELD imaa128                     #返回原欄位
            
            ON ACTION controlp INFIELD imaa129   
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2005" #應用分類
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa129  #顯示到畫面上
               NEXT FIELD imaa129                     #返回原欄位
               
            ON ACTION controlp INFIELD imaa132
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2006" #應用分類
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa132  #顯示到畫面上
               NEXT FIELD imaa132                     #返回原欄位
               
               
            ON ACTION controlp INFIELD imaa133
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2007" #應用分類
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa133  #顯示到畫面上
               NEXT FIELD imaa133                     #返回原欄位
            
            ON ACTION controlp INFIELD imaa134
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2008" #應用分類
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa134  #顯示到畫面上
               NEXT FIELD imaa134                     #返回原欄位
               
            ON ACTION controlp INFIELD imaa135
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2009" #應用分類
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa135  #顯示到畫面上
               NEXT FIELD imaa135                     #返回原欄位   
               
            ON ACTION controlp INFIELD imaa136
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2010" #應用分類
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa136  #顯示到畫面上
               NEXT FIELD imaa136                     #返回原欄位  


            ON ACTION controlp INFIELD imaa137
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2011" #應用分類
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa137  #顯示到畫面上
               NEXT FIELD imaa137                     #返回原欄位
               
            ON ACTION controlp INFIELD imaa138
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2012" #應用分類
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa138  #顯示到畫面上
               NEXT FIELD imaa138                     #返回原欄位   
               
            ON ACTION controlp INFIELD imaa139
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2013" #應用分類
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa139  #顯示到畫面上
               NEXT FIELD imaa139                     #返回原欄位 

            ON ACTION controlp INFIELD imaa140
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2014" #應用分類
               CALL q_oocq002()                       #呼叫開窗
               LET g_qryparam.where = " oocqstus = 'Y'"
               DISPLAY g_qryparam.return1 TO imaa140  #顯示到畫面上
               NEXT FIELD imaa140                     #返回原欄位
               
            ON ACTION controlp INFIELD imaa141
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = "2015" #應用分類
               LET g_qryparam.where = " oocqstus = 'Y'"
               CALL q_oocq002()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO imaa141  #顯示到畫面上
               NEXT FIELD imaa141                     #返回原欄位 
               
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
 
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
      
      #end add-point
      
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
 
   #add-point:畫面關閉前 name="construct.before_close"
   IF NOT INT_FLAG THEN
      CALL aprt211_02_b_fill()
      CALL aprt211_02_input()
   END IF
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_aprt211_02 
   
   #add-point:construct段after construct name="construct.post_construct"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt211_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aprt211_02.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 将选取的资料插入促銷規則申請商品範圍資料檔中
# Memo...........:
# Usage..........: CALL aprt211_02_ins()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/18 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt211_02_ins()
DEFINE l_prda001        LIKE prda_t.prda001
DEFINE l_n              LIKE type_t.num5

   CALL s_transaction_begin()
   
   SELECT prda001 INTO l_prda001
     FROM prda_t
    WHERE prdaent = g_enterprise
      AND prdadocno = g_prdadocno
   FOR l_ac = 1 TO g_sel_d.getLength()
      IF g_sel_d[l_ac].sel = 'Y' THEN
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM prdg_t
          WHERE prdgent = g_enterprise
            AND prdgdocno = g_prdadocno 
            AND prdg002 = g_prdg002
            AND prdg003 = '4'
            AND prdg004 = g_sel_d[l_ac].sel01
         IF l_n = 0 THEN   
            INSERT INTO prdg_t(prdgent,prdgunit,prdgsite,prdgdocno,prdg001,prdg002,prdg003,prdg004,prdg005,prdg006,prdg007,prdg010,prdgacti)
                        VALUES(g_enterprise,g_site,g_site,g_prdadocno,l_prda001,g_prdg002,'4',g_sel_d[l_ac].sel01,g_sel_d[l_ac].sel02,g_sel_d[l_ac].sel05,g_sel_d[l_ac].sel07,g_prdg002,'Y')
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = 'ins_prdg'
                LET g_errparam.popup = TRUE
                CALL cl_err()

                CALL s_transaction_end('N','0')
             END IF            
         END IF
      END IF
   END FOR
   CALL s_transaction_end('Y','0')
END FUNCTION
################################################################################
# Descriptions...: 查询结果明细显示
# Memo...........:
# Usage..........: CALL aprt211_02_b_fill()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/18 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt211_02_b_fill()
   LET g_sql = "SELECT UNIQUE 'Y',rtdx001,rtdx002,'','',imaa106,'','' ", #150312-00002#6 Modify-S By Ken 150319 原rtdx033改抓imaa106
               "  FROM rtdx_t,imaa_t",
               " WHERE rtdxent = '",g_enterprise,"'",
               "   AND rtdxsite = '",g_site,"'",
               "   AND rtdxent = imaaent AND rtdx001 = imaa001 AND rtdxstus='Y' AND imaastus='Y'",
               "   AND rtdxsite = '",g_site,"' ",
               "   AND ",g_wc CLIPPED
               
   LET g_sql = g_sql, " ORDER BY rtdx_t.rtdx001"
   
   PREPARE s_sel_pb FROM g_sql
   DECLARE s_sel_curs CURSOR FOR s_sel_pb

   CALL g_sel_d.clear()

   LET g_cnt = l_ac
   LET l_ac = 1

   FOREACH s_sel_curs INTO g_sel_d[l_ac].sel,g_sel_d[l_ac].sel01,g_sel_d[l_ac].sel02,g_sel_d[l_ac].sel03,g_sel_d[l_ac].sel04,
                           g_sel_d[l_ac].sel05,g_sel_d[l_ac].sel06,g_sel_d[l_ac].sel07

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

#      SELECT rtdx002,rtdx033 INTO g_sel_d[l_ac].sel02,g_sel_d[l_ac].sel06
#        FROM rtdx_t
#       WHERE rtdxent = g_enterprise
#         AND rtdxsite = g_site
#         AND rtdx001 = g_sel_d[l_ac].sel01
        
      SELECT oocal003 INTO g_sel_d[l_ac].sel06  
        FROM oocal_t
       WHERE oocalent = g_enterprise
         AND oocal001 = g_sel_d[l_ac].sel05
         AND oocal002 = g_dlang
         
      SELECT imaal003,imaal004 INTO g_sel_d[l_ac].sel03,g_sel_d[l_ac].sel04
        FROM imaal_t
       WHERE imaalent = g_enterprise
         AND imaal001 = g_sel_d[l_ac].sel01
         AND imaal002 = g_dlang
         
      LET g_sel_d[l_ac].sel07 = 0
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   IF l_ac > g_max_rec THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9035
      LET g_errparam.extend = "imaa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF

   CALL g_sel_d.deleteElement(g_sel_d.getLength())


   LET g_detail_cnt = l_ac - 1
   
   LET l_ac = g_cnt
   LET g_cnt = 0

   CLOSE s_sel_curs
   FREE s_sel_pb
   
   
END FUNCTION
################################################################################
# Descriptions...: 查詢結果選擇
# Memo...........:
# Usage..........: CALL aprt211_02_input()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/18 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt211_02_input()
DEFINE  l_n                   LIKE type_t.num5
DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
DEFINE  l_allow_delete        LIKE type_t.num5 
DEFINE  l_cmd                 LIKE type_t.chr1
DEFINE  l_insert              BOOLEAN
DEFINE  l_lock_sw             LIKE type_t.chr1
DEFINE  l_n1                  LIKE type_t.num5 


       INPUT ARRAY g_sel_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         BEFORE INPUT 
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
         
            CALL s_transaction_begin()
            
            LET g_rec_b = g_sel_d.getLength()
            
            IF g_rec_b >= l_ac AND g_sel_d[l_ac].sel01 IS NOT NULL THEN
               LET l_cmd='u'
               LET g_sel_d_t.* = g_sel_d[l_ac].*
            ELSE
               LET l_cmd='a'
            END IF
            
       
         BEFORE FIELD sel
         
         AFTER FIELD sel
            
         ON CHANGE sel
      
         AFTER ROW
           
         AFTER INPUT
         
#         ON ACTION sela
#            FOR l_n1 = 1 TO g_sel_d.getLength()
#               LET g_sel_d[l_n1].sel = 'Y'  
#            END FOR
#            DISPLAY ARRAY g_sel_d TO s_detail1.*
#               BEFORE DISPLAY 
#                  EXIT DISPLAY
#            END DISPLAY
#            
#            
#         ON ACTION seln
#            FOR l_n1 = 1 TO g_sel_d.getLength()
#               LET g_sel_d[l_n1].sel = 'N'  
#            END FOR
#            DISPLAY ARRAY g_sel_d TO s_detail1.*
#               BEFORE DISPLAY 
#                  EXIT DISPLAY
#            END DISPLAY
            
      END INPUT
      IF NOT INT_FLAG THEN
         CALL aprt211_02_ins()
      END IF
END FUNCTION

 
{</section>}
 
