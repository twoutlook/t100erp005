#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt370_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2013-12-02 00:00:00), PR版次:0004(2016-11-29 13:34:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000275
#+ Filename...: aglt370_02
#+ Description: 單身科目產生
#+ Creator....: 02114(2013-11-13 11:38:42)
#+ Modifier...: 02114 -SD/PR- 02481
 
{</section>}
 
{<section id="aglt370_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#161128-00061#1   2016/11/29  by 02481  标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_glan_m        RECORD
       chose LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glandocno     LIKE glan_t.glandocno
DEFINE g_glanld        LIKE glan_t.glanld
DEFINE g_sql           STRING 
#161128-00061#1----modify------begin-----------
#DEFINE g_glan   RECORD   LIKE glan_t.* 
DEFINE g_glan RECORD  #分攤金額來源檔
       glanent LIKE glan_t.glanent, #企業編號
       glanownid LIKE glan_t.glanownid, #資料所有者
       glanowndp LIKE glan_t.glanowndp, #資料所屬部門
       glancrtid LIKE glan_t.glancrtid, #資料建立者
       glancrtdp LIKE glan_t.glancrtdp, #資料建立部門
       glancrtdt LIKE glan_t.glancrtdt, #資料創建日
       glanmodid LIKE glan_t.glanmodid, #資料修改者
       glanmoddt LIKE glan_t.glanmoddt, #最近修改日
       glancnfid LIKE glan_t.glancnfid, #資料確認者
       glancnfdt LIKE glan_t.glancnfdt, #資料確認日
       glanpstid LIKE glan_t.glanpstid, #資料過帳者
       glanpstdt LIKE glan_t.glanpstdt, #資料過帳日
       glanstus LIKE glan_t.glanstus, #狀態碼
       glanld LIKE glan_t.glanld, #帳套(套)編號
       glandocno LIKE glan_t.glandocno, #分攤編號
       glanseq LIKE glan_t.glanseq, #項次
       glan001 LIKE glan_t.glan001, #科目編號
       glan002 LIKE glan_t.glan002, #分攤百分比
       glan003 LIKE glan_t.glan003, #營運據點
       glan004 LIKE glan_t.glan004, #部門
       glan005 LIKE glan_t.glan005, #利潤/成本中心
       glan006 LIKE glan_t.glan006, #區域
       glan007 LIKE glan_t.glan007, #收付款客商
       glan008 LIKE glan_t.glan008, #帳款客商
       glan009 LIKE glan_t.glan009, #客群
       glan010 LIKE glan_t.glan010, #產品類別
       glan011 LIKE glan_t.glan011, #人員
       glan012 LIKE glan_t.glan012, #no use
       glan013 LIKE glan_t.glan013, #專案編號
       glan014 LIKE glan_t.glan014, #WBS
       glan015 LIKE glan_t.glan015, #餘額來源
       glan016 LIKE glan_t.glan016, #餘額性質
       glan017 LIKE glan_t.glan017, #來源性質
       glan018 LIKE glan_t.glan018, #餘額來源年度
       glan019 LIKE glan_t.glan019, #餘額來源期別
       glan051 LIKE glan_t.glan051, #經營方式
       glan052 LIKE glan_t.glan052, #渠道
       glan053 LIKE glan_t.glan053  #品牌
       END RECORD

#161128-00061#1----modify------end-----------
DEFINE g_str             LIKE type_t.chr10
#end add-point
 
DEFINE g_glan_m        type_g_glan_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglt370_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aglt370_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_glandocno,p_glanld,p_str
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
   DEFINE p_glandocno     LIKE glan_t.glandocno
   DEFINE p_glanld        LIKE glan_t.glanld
   DEFINE p_str           LIKE type_t.chr10
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aglt370_02 WITH FORM cl_ap_formpath("agl","aglt370_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_glandocno = p_glandocno
   LET g_glanld = p_glanld
   LET g_glan_m.chose = 'Y'
   LET g_str = p_str
   LET INT_FLAG = FALSE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glan_m.chose ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chose
            #add-point:BEFORE FIELD chose name="input.b.chose"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chose
            
            #add-point:AFTER FIELD chose name="input.a.chose"
            IF NOT cl_null(g_glan_m.chose) THEN 
               IF g_glan_m.chose NOT MATCHES '[Yy]' AND g_glan_m.chose NOT MATCHES '[Nn]' THEN
                  DISPLAY '' TO chose
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00144'
                  LET g_errparam.extend = g_glan_m.chose
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glan_m.chose = ''
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chose
            #add-point:ON CHANGE chose name="input.g.chose"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.chose
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chose
            #add-point:ON ACTION controlp INFIELD chose name="input.c.chose"
            
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
   CLOSE WINDOW w_aglt370_02 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      LET g_success = 'N'
      RETURN g_success
   END IF
   
   IF g_glan_m.chose = 'Y' THEN 
      CALL aglt370_02_glam_ins()
      LET g_success = 'Y'
   ELSE
      LET g_success = 'N' 
   END IF 
   RETURN g_success 
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglt370_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aglt370_02.other_function" readonly="Y" >}
# 插入常用分攤傳票單身檔
PRIVATE FUNCTION aglt370_02_glam_ins()
   DEFINE l_glandocno     LIKE glan_t.glandocno
   DEFINE l_glanld        LIKE glan_t.glanld
   DEFINE l_glan001       LIKE glan_t.glan001
   DEFINE l_ac            LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_glam003       LIKE glam_t.glam003
   DEFINE l_glam004       LIKE glam_t.glam004
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp
   DEFINE l_glamseq       LIKE glam_t.glamseq
   
   SELECT glaacomp INTO l_glaacomp
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glanld
      
   SELECT COUNT(*) INTO l_n
     FROM glan_t,glam_t
    WHERE glanent = glament
      AND glandocno = glamdocno
      AND glanld = glamld
      AND glan001 = glam002
      AND glanent = g_enterprise
      AND glandocno = g_glandocno
      AND glanld = g_glanld
      
   IF l_n > 0 THEN 
      IF cl_ask_confirm('agl-00196') THEN
         DELETE FROM glam_t 
          WHERE glament = g_enterprise
            AND glamdocno = g_glandocno
            AND glamld = g_glanld
            AND glam002 IN (SELECT glan001
                              FROM glan_t,glam_t
                             WHERE glanent = glament
                               AND glandocno = glamdocno
                               AND glanld = glamld
                               AND glan001 = glam002
                               AND glanent = g_enterprise
                               AND glandocno = g_glandocno
                               AND glanld = g_glanld)
          #161128-00061#1----modify------begin-----------                     
          #LET g_sql = " SELECT * FROM glan_t", 
          LET g_sql = " SELECT glanent,glanownid,glanowndp,glancrtid,glancrtdp,glancrtdt,glanmodid,glanmoddt,",
                      "glancnfid,glancnfdt,glanpstid,glanpstdt,glanstus,glanld,glandocno,glanseq,glan001,",
                      "glan002,glan003,glan004,glan005,glan006,glan007,glan008,glan009,glan010,glan011,",
                      "glan012,glan013,glan014,glan015,glan016,glan017,glan018,glan019,glan051,glan052,glan053 FROM glan_t", 
          #161128-00061#1----modify------end-----------
                      "  WHERE glanent = '",g_enterprise,"'",
                      "    AND glandocno = '",g_glandocno,"'",
                      "    AND glanld = '",g_glanld,"'"
      ELSE
         #161128-00061#1----modify------begin-----------                     
          #LET g_sql = " SELECT * FROM glan_t", 
          LET g_sql = " SELECT glanent,glanownid,glanowndp,glancrtid,glancrtdp,glancrtdt,glanmodid,glanmoddt,",
                      "glancnfid,glancnfdt,glanpstid,glanpstdt,glanstus,glanld,glandocno,glanseq,glan001,",
                      "glan002,glan003,glan004,glan005,glan006,glan007,glan008,glan009,glan010,glan011,",
                      "glan012,glan013,glan014,glan015,glan016,glan017,glan018,glan019,glan051,glan052,glan053 FROM glan_t", 
          #161128-00061#1----modify------end-----------
                      "  WHERE glanent = '",g_enterprise,"'",
                      "    AND glandocno = '",g_glandocno,"'",
                      "    AND glanld = '",g_glanld,"'",
                      "    AND glan001 NOT IN (SELECT glan001 ",
                      "                          FROM glan_t,glam_t ",
                      "                         WHERE glanent = glament ",
                      "                           AND glandocno = glamdocno ",
                      "                           AND glanld = glamld ",
                      "                           AND glan001 = glam002 ",
                      "                           AND glanent = '",g_enterprise,"'",
                      "                           AND glandocno = '",g_glandocno,"'",
                      "                           AND glanld = '",g_glanld,"')"
      END IF 
   ELSE
      #161128-00061#1----modify------begin-----------                     
          #LET g_sql = " SELECT * FROM glan_t", 
          LET g_sql = " SELECT glanent,glanownid,glanowndp,glancrtid,glancrtdp,glancrtdt,glanmodid,glanmoddt,",
                      "glancnfid,glancnfdt,glanpstid,glanpstdt,glanstus,glanld,glandocno,glanseq,glan001,",
                      "glan002,glan003,glan004,glan005,glan006,glan007,glan008,glan009,glan010,glan011,",
                      "glan012,glan013,glan014,glan015,glan016,glan017,glan018,glan019,glan051,glan052,glan053 FROM glan_t", 
          #161128-00061#1----modify------end-----------
                      "  WHERE glanent = '",g_enterprise,"'",
                      "    AND glandocno = '",g_glandocno,"'",
                      "    AND glanld = '",g_glanld,"'"
   END IF
   
   #LET g_sql = " SELECT * FROM glan_t", 
   #            "  WHERE glanent = '",g_enterprise,"'",
   #            "    AND glandocno = '",g_glandocno,"'",
   #            "    AND glanld = '",g_glanld,"'"
   PREPARE aglt370_02_pb FROM g_sql
   DECLARE aglt370_02_cs CURSOR FOR aglt370_02_pb
   
   SELECT MAX(glamseq)+1 INTO l_glamseq 
     FROM glam_t
    WHERE glament = g_enterprise
      AND glamdocno = g_glandocno
      AND glamld = g_glanld
   IF cl_null(l_glamseq) THEN 
      LET l_glamseq = 1
   END IF 
   
   LET l_ac = l_glamseq
   FOREACH aglt370_02_cs INTO g_glan.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      IF g_str = 'aglt380' THEN 
         LET l_glam003 = ''
         LET l_glam004 = ''
      ELSE
         LET l_glam003 = 0
         LET l_glam004 = 0
      END IF
      
      INSERT INTO glam_t(glament,glamcomp,glamdocno,glamld,glamseq,glam002,glam003,glam004,
                         glam007,glam008,glam009,glam010,glam011,glam012,
                         glam013,glam014,glam015,glam017,glam018,glam051,glam052,glam053)
        VALUES(g_enterprise,l_glaacomp,g_glan.glandocno,g_glan.glanld,l_ac,g_glan.glan001,l_glam003,l_glam004,
               g_glan.glan003,g_glan.glan004,g_glan.glan005,g_glan.glan006,g_glan.glan007,
               g_glan.glan008,g_glan.glan009,g_glan.glan010,g_glan.glan011,
               g_glan.glan013,g_glan.glan014,g_glan.glan051,g_glan.glan052,g_glan.glan053)
      IF SQLCA.SQLcode  THEN
         LET g_success = 'N'
      ELSE
         LET g_success = 'Y'
      END IF
      LET l_ac = l_ac + 1
   END FOREACH 
  
   IF g_success = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "glam_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      CALL s_transaction_end('N','0') 
   ELSE
      CALL s_transaction_end('Y','0')
      ERROR "INSERT O.K"
   END IF
END FUNCTION

 
{</section>}
 
