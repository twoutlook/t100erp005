#該程式未解開Section, 採用最新樣板產出!
{<section id="afat501_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-10-09 14:34:04), PR版次:0005(2016-11-28 11:19:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000034
#+ Filename...: afat501_01
#+ Description: 折畢再提批次產生
#+ Creator....: 06816(2015-10-08 14:45:53)
#+ Modifier...: 06816 -SD/PR- 01531
 
{</section>}
 
{<section id="afat501_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#151023   151023 By albireo    固資開窗增加條件必須有可折抵額及狀態為折畢
#161111-00028#7     2016/11/23 by 02481       标准程式定义采用宣告模式,弃用.*写法
#161104-00048#4     2016/11/22 By 01531       财编等开窗限定faaj038 in (4,7)
#161111-00049#12    2016/11/28 By 01531       二阶段FA问题7~14 调整作业:afat450/afat500/afat501/afat502/afat503/afat504/afat505/afat506
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
PRIVATE type type_g_faaj_m        RECORD
       chk_1 LIKE type_t.chr500, 
   faaj013 LIKE faaj_t.faaj013, 
   faaj012 LIKE faaj_t.faaj012, 
   faah006 LIKE type_t.chr10, 
   faah007 LIKE type_t.chr10, 
   faah003 LIKE type_t.chr20
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_t501_01     STRING
DEFINE g_glaacomp       LIKE glaa_t.glaacomp #161111-00049#12 add
#end add-point
 
DEFINE g_faaj_m        type_g_faaj_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afat501_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION afat501_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_fabgld,p_fabgdocno
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
   DEFINE p_fabgld        LIKE fabg_t.fabgld
   DEFINE p_fabgdocno     LIKE fabg_t.fabgdocno
   #161111-00028#7---modify--begin-----------
   #DEFINE l_fabd          RECORD LIKE fabd_t.*
   DEFINE l_fabd RECORD  #折畢再提單身檔
       fabdent LIKE fabd_t.fabdent, #企業編號
       fabdld LIKE fabd_t.fabdld, #帳套
       fabddocno LIKE fabd_t.fabddocno, #折畢再提單號
       fabdseq LIKE fabd_t.fabdseq, #項次
       fabd000 LIKE fabd_t.fabd000, #卡片編號
       fabd001 LIKE fabd_t.fabd001, #財產編號
       fabd002 LIKE fabd_t.fabd002, #附號
       fabd003 LIKE fabd_t.fabd003, #主要類別
       fabd004 LIKE fabd_t.fabd004, #次要類別
       fabd005 LIKE fabd_t.fabd005, #資產狀態
       fabd006 LIKE fabd_t.fabd006, #折畢再提否
       fabd007 LIKE fabd_t.fabd007, #再提年限（月）
       fabd008 LIKE fabd_t.fabd008, #幣別
       fabd009 LIKE fabd_t.fabd009, #匯率
       fabd010 LIKE fabd_t.fabd010, #折畢殘值
       fabd011 LIKE fabd_t.fabd011, #單據性質
       fabd101 LIKE fabd_t.fabd101, #本位幣二幣別
       fabd102 LIKE fabd_t.fabd102, #本位幣二匯率
       fabd103 LIKE fabd_t.fabd103, #本位幣二折畢殘值
       fabd150 LIKE fabd_t.fabd150, #本位幣三幣別
       fabd151 LIKE fabd_t.fabd151, #本位幣三匯率
       fabd152 LIKE fabd_t.fabd152  #本位幣三折畢殘值
       END RECORD

   #161111-00028#7---modify--end-----------
   DEFINE l_glaa015       LIKE glaa_t.glaa015
   DEFINE l_glaa019       LIKE glaa_t.glaa019
   DEFINE l_glaa018       LIKE glaa_t.glaa018
   DEFINE l_glaa022       LIKE glaa_t.glaa022
   DEFINE l_i             LIKE type_t.num10
   DEFINE r_success       LIKE type_t.chr1
   DEFINE l_sql           STRING

   WHENEVER ERROR CONTINUE
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat501_01 WITH FORM cl_ap_formpath("afa","afat501_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_faaj_m.chk_1,g_faaj_m.faaj013,g_faaj_m.faaj012 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_faaj_m.chk_1 = "Y"
            LET g_faaj_m.faaj013 = ''
            LET g_faaj_m.faaj012 = ''
            CALL cl_set_comp_entry("faaj013,faaj012",FALSE)
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk_1
            #add-point:BEFORE FIELD chk_1 name="input.b.chk_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk_1
            
            #add-point:AFTER FIELD chk_1 name="input.a.chk_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk_1
            #add-point:ON CHANGE chk_1 name="input.g.chk_1"
            IF g_faaj_m.chk_1 = "Y" THEN
               CALL cl_set_comp_entry("faaj013,faaj012",FALSE)
               LET g_faaj_m.faaj013 = ''
               LET g_faaj_m.faaj012 = ''
               CALL cl_set_comp_required('faaj013,faaj012',FALSE)
            ELSE
               CALL cl_set_comp_entry("faaj013,faaj012",TRUE)
               CALL cl_set_comp_required('faaj013,faaj012',TRUE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj013
            #add-point:BEFORE FIELD faaj013 name="input.b.faaj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj013
            
            #add-point:AFTER FIELD faaj013 name="input.a.faaj013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj013
            #add-point:ON CHANGE faaj013 name="input.g.faaj013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faaj012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faaj_m.faaj012,"","","100","1","azz-00080",1) THEN
               NEXT FIELD faaj012
            END IF 
 
 
 
            #add-point:AFTER FIELD faaj012 name="input.a.faaj012"
            IF NOT cl_null(g_faaj_m.faaj012) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faaj012
            #add-point:BEFORE FIELD faaj012 name="input.b.faaj012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faaj012
            #add-point:ON CHANGE faaj012 name="input.g.faaj012"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.chk_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk_1
            #add-point:ON ACTION controlp INFIELD chk_1 name="input.c.chk_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.faaj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj013
            #add-point:ON ACTION controlp INFIELD faaj013 name="input.c.faaj013"
            
            #END add-point
 
 
         #Ctrlp:input.c.faaj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faaj012
            #add-point:ON ACTION controlp INFIELD faaj012 name="input.c.faaj012"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT g_wc_t501_01 ON faah006,faah007,faah003 FROM faah006,faah007,faah003
         ON ACTION controlp INFIELD faah006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			   #161111-00049#12 add s---	   
            LET g_qryparam.where = " faalld = '",p_fabgld,"'"  
            CALL q_faal001_1()             
            #CALL q_faac001()                           #呼叫開窗
            #161111-00049#12 add e---
            DISPLAY g_qryparam.return1 TO faah006
            NEXT FIELD faah006
            
         ON ACTION controlp INFIELD faah007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " faad002 IN (SELECT faal001 FROM faal_t WHERE faalent = ",g_enterprise," AND faalld ='",p_fabgld,"')" #161111-00049#12
            CALL q_faad001()
            DISPLAY g_qryparam.return1 TO faah007
            NEXT FIELD faah007
            
         ON ACTION controlp INFIELD faah003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #albireo 151023-----s
            #LET g_qryparam.where = "(faah015='4' OR faah015='7') ",   #151118-00010#1 151120 by sakura add faah015='7' #161104-00048#4 mark
            #LET g_qryparam.where = "(faaj038='4' OR faaj038='7') ",    #161104-00048#4 add #161111-00049#12 mark
            #                       " AND (faah000,faah001,faah003,faah004) IN (",   #161111-00049#12 mark
             LET g_qryparam.where = "  (faah000,faah001,faah003,faah004) IN (",    #161111-00049#12 add                                 
                                   "                                           SELECT faaj000,faaj037,faaj001,faaj002 FROM faaj_t ",
                                   "                                            WHERE faajent = ",g_enterprise," ",
                                   "                                              AND faaj028 > 0 ",
                                   "                                              AND (faaj038='4' OR faaj038='7') ",#161111-00049#12 add
                                   "                                           )"
            #albireo 151023-----e
            #161111-00049#12 add s---
            SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_fabgld
            LET g_qryparam.where = g_qryparam.where," AND faah032 = '",g_glaacomp,"'"
            #161111-00049#12 add e---
            CALL q_faah003_1()
            DISPLAY g_qryparam.return1 TO faah003
            NEXT FIELD faah003
      END CONSTRUCT             
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
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      CLOSE WINDOW w_afat501_01
      RETURN r_success
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_afat501_01 
   
   #add-point:input段after input name="input.post_input"
   CALL cl_err_collect_init() 
   LET r_success = TRUE
   SELECT MAX(fabdseq) INTO l_i 
     FROM fabd_t
    WHERE fabdent = g_enterprise AND fabdld  = p_fabgld AND fabddocno = p_fabgdocno
   IF cl_null(l_i) THEN LET l_i = 1 END IF
   LET l_sql = "SELECT faahent,faajld,'','',faah001,faah003,faah004,faah006,faah007,",
               #"       faah015,faaj011,faaj013,'',1,faaj012,'','','','','','',", #161104-00048#4 mark
               "       faaj038,faaj011,faaj013,'',1,faaj012,'','','','','','',",  #161104-00048#4 add
               "       faaj028 ",    #借欄位存放未折減額
               "  FROM faah_t,faaj_t ",
               " WHERE faahent = faajent AND faah000 = faaj000 AND faah001 = faaj037 ",
               #"   AND faah003 = faaj001 AND faah004 = faaj002 AND (faah015 = '4' OR faah015 = '7') ",   #151118-00010#1 151120 by sakura add faah015 = '7' #161104-00048#4 mark
               "   AND faah003 = faaj001 AND faah004 = faaj002 AND (faaj038 = '4' OR faaj038 = '7') ",    #161104-00048#4 add
               #albireo 151023-----s
               "   AND faaj028 > 0 ",
               "   AND faahent = ",g_enterprise," ",
               #albireo 151023-----e
               "   AND faaj011 = 'Y' AND faajld = '",p_fabgld,"' AND ",g_wc_t501_01
   
   PREPARE ins_fabd_p FROM l_sql
   DECLARE ins_fabd_c CURSOR FOR ins_fabd_p
   FOREACH ins_fabd_c INTO l_fabd.*
      LET l_count = ''
      SELECT COUNT(*) INTO l_count FROM fabd_t
       WHERE fabdent = l_fabd.fabdent AND fabdld  = l_fabd.fabdld AND fabddocno = l_fabd.fabddocno
         AND fabd000 = l_fabd.fabd000 AND fabd001 = l_fabd.fabd001 AND fabd002 = l_fabd.fabd002
         
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      IF l_count > 0 THEN
         #已存在單身
         CONTINUE FOREACH
      END IF
      
      LET l_fabd.fabddocno = p_fabgdocno
      LET l_fabd.fabdseq   = l_i 
      IF g_faaj_m.chk_1 = 'N' THEN 
         LET l_fabd.fabd007   = g_faaj_m.faaj013
         LET l_fabd.fabd010   = l_fabd.fabd152 * g_faaj_m.faaj012 * 0.01
      END IF
      #單據性質
      SELECT fabg005 INTO l_fabd.fabd011 
        FROM fabg_t
       WHERE fabgent = g_enterprise AND fabgld = l_fabd.fabdld
         AND fabgdocno = p_fabgdocno
      #帳套本位幣與是否啟用本位幣二 三
      SELECT glaa001,                 #本幣
             glaa015,glaa016,glaa018, #本位幣二
             glaa019,glaa020,glaa022  #本位幣三
        INTO l_fabd.fabd008,
             l_glaa015,l_fabd.fabd101,l_glaa018,
             l_glaa019,l_fabd.fabd150,l_glaa022
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = g_fabg_m.fabgld
      
      #本位幣二 幣別、匯率
      IF l_glaa015 = 'Y' THEN      #2:帳套類型           #本幣          #目的幣別         #匯類類型
         CALL s_aooi160_get_exrate('2',p_fabgld,g_today,l_fabd.fabd008,l_fabd.fabd101,0,l_glaa018)
            RETURNING l_fabd.fabd102 
         LET l_fabd.fabd103 =  l_fabd.fabd102 * l_fabd.fabd010  
      ELSE
         LET l_fabd.fabd101 = ''
         LET l_fabd.fabd102 = ''
         LET l_fabd.fabd103 = 0
      END IF
      
      #本位幣三 幣別、匯率
      IF l_glaa019 = 'Y' THEN      #2:帳套類型           #本幣          #目的幣別         #匯類類型
         CALL s_aooi160_get_exrate('2',p_fabgld,g_today,l_fabd.fabd008,l_fabd.fabd150,0,l_glaa022)
            RETURNING l_fabd.fabd151 
         LET l_fabd.fabd152 =  l_fabd.fabd151 * l_fabd.fabd010   
      ELSE
         LET l_fabd.fabd150 = ''
         LET l_fabd.fabd151 = ''
         LET l_fabd.fabd152 = 0
      END IF
      #161111-00028#7---modify--begin-----------      
      #INSERT INTO fabd_t VALUES(l_fabd.*)
      INSERT INTO fabd_t (fabdent,fabdld,fabddocno,fabdseq,fabd000,fabd001,fabd002,fabd003,fabd004,fabd005,fabd006,
                          fabd007,fabd008,fabd009,fabd010,fabd011,fabd101,fabd102,fabd103,fabd150,fabd151,fabd152)
        VALUES(l_fabd.fabdent,l_fabd.fabdld,l_fabd.fabddocno,l_fabd.fabdseq,l_fabd.fabd000,l_fabd.fabd001,l_fabd.fabd002,l_fabd.fabd003,l_fabd.fabd004,l_fabd.fabd005,l_fabd.fabd006,
               l_fabd.fabd007,l_fabd.fabd008,l_fabd.fabd009,l_fabd.fabd010,l_fabd.fabd011,l_fabd.fabd101,l_fabd.fabd102,l_fabd.fabd103,l_fabd.fabd150,l_fabd.fabd151,l_fabd.fabd152)
      #161111-00028#7---modify--end-----------
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins fabd_t"
         LET g_errparam.popup = TRUE
         LET r_success = FALSE
         CALL cl_err()
         RETURN r_success
      END IF
      LET l_i = l_i + 1 
   END FOREACH
   CALL cl_err_collect_show()  
   RETURN r_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afat501_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat501_01.other_function" readonly="Y" >}

 
{</section>}
 
