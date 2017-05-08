#該程式未解開Section, 採用最新樣板產出!
{<section id="afat520_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-09-19 16:43:32), PR版次:0004(2016-12-12 18:10:38)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: afat520_01
#+ Description: 資產盤盈虧產生
#+ Creator....: 02114(2015-07-02 21:51:59)
#+ Modifier...: 01531 -SD/PR- 07900
 
{</section>}
 
{<section id="afat520_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160321-00016#26  160324      By Jessy    修正azzi920重複定義之錯誤訊息
#160906-00019#1   2016/09/19  By 01531    畫面中盤虧單別欄位定義調整，對應欄位也一併調整，否則無法一起隱藏
#160926-00003#1   2016/09/26  By 02114    afat512审核时账务单号开窗没有资料，直接录入单别可以审核成功。
#161209-00010#1   2016/12/12  By 07900    盘点单审核产生盘盈亏单后，没关闭单据，然后还可以继续无限次产生盘盈亏单
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
PRIVATE type type_g_fabg_m        RECORD
       fabgld LIKE fabg_t.fabgld, 
   fabgld_desc LIKE type_t.chr80, 
   fabgdocno LIKE fabg_t.fabgdocno, 
   docno_1 LIKE type_t.chr20, 
   fabgdocdt LIKE fabg_t.fabgdocdt
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_fabg_m        type_g_fabg_m
 
   DEFINE g_fabgld_t LIKE fabg_t.fabgld
DEFINE g_fabgdocno_t LIKE fabg_t.fabgdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afat520_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION afat520_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_fabr003,p_comp
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
   DEFINE p_fabr003       LIKE fabr_t.fabr003
   DEFINE p_comp          LIKE fabr_t.fabrcomp
   DEFINE r_success       LIKE type_t.num10
   DEFINE r_errno         LIKE gzze_t.gzze001 
   DEFINE l_glaa024       LIKE glaa_t.glaa024
   DEFINE l_n             LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat520_01 WITH FORM cl_ap_formpath("afa","afat520_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_fabg_m.fabgdocdt = g_today
   SELECT glaald INTO g_fabg_m.fabgld
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = p_comp
      AND glaa014 = 'Y'
   CALL afat520_01_fabgld_desc()
   DISPLAY g_fabg_m.fabgld TO fabgld
   
   #是否有盘盈
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM fabr_t
    WHERE fabrent = g_enterprise
      AND fabr003 = p_fabr003
      AND fabr023 - fabr012 > 0
      
   IF l_n > 0 THEN 
      CALL cl_set_comp_visible('fabgdocno',TRUE)
   ELSE
      CALL cl_set_comp_visible('fabgdocno',FALSE)
   END IF
   
   #是否有盘盈
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM fabr_t
    WHERE fabrent = g_enterprise
      AND fabr003 = p_fabr003
      AND fabr023 - fabr012 < 0
      
   IF l_n > 0 THEN 
      CALL cl_set_comp_visible('docno_1',TRUE) #160906-00019#1 docno-->docno_1
   ELSE
      CALL cl_set_comp_visible('docno_1',FALSE) #160906-00019#1  docno-->docno_1
   END IF
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.docno_1,g_fabg_m.fabgdocdt ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            #161209-00010#1--add--s--
            #清空单据
            LET g_fabg_m.fabgdocno = ''
            LET g_fabg_m.docno_1 = ''
            #161209-00010#1--add--e--
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgld
            
            #add-point:AFTER FIELD fabgld name="input.a.fabgld"
            IF NOT cl_null(g_fabg_m.fabgld) THEN 
               CALL s_fin_ld_chk(g_fabg_m.fabgld,g_user,'Y') RETURNING r_success,r_errno
               IF NOT cl_null(r_errno)THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = r_errno
                  LET g_errparam.extend = g_fabg_m.fabgld
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'agli010'
                  LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                  LET g_errparam.exeprog = 'agli010'
                  #160321-00016#26 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                   
                  LET g_fabg_m.fabgld = ''
                  CALL afat520_01_fabgld_desc()
                  NEXT FIELD fabgld
               END IF
               SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
            END IF 
            CALL afat520_01_fabgld_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgld
            #add-point:BEFORE FIELD fabgld name="input.b.fabgld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgld
            #add-point:ON CHANGE fabgld name="input.g.fabgld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocno
            #add-point:BEFORE FIELD fabgdocno name="input.b.fabgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocno
            
            #add-point:AFTER FIELD fabgdocno name="input.a.fabgdocno"
            IF NOT cl_null(g_fabg_m.fabgdocno) THEN            
               SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
               IF NOT s_aooi200_fin_chk_slip(g_fabg_m.fabgld,l_glaa024,g_fabg_m.fabgdocno,'afat513') THEN
                  LET g_fabg_m.fabgdocno = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgdocno
            #add-point:ON CHANGE fabgdocno name="input.g.fabgdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD docno_1
            #add-point:BEFORE FIELD docno_1 name="input.b.docno_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD docno_1
            
            #add-point:AFTER FIELD docno_1 name="input.a.docno_1"
            #160926-00003#1--add--str--lujh
            IF NOT cl_null(g_fabg_m.docno_1) THEN            
               SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
               IF NOT s_aooi200_fin_chk_slip(g_fabg_m.fabgld,l_glaa024,g_fabg_m.docno_1,'afat514') THEN
                  LET g_fabg_m.docno_1 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #160926-00003#1--add--end--lujh
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE docno_1
            #add-point:ON CHANGE docno_1 name="input.g.docno_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocdt
            #add-point:BEFORE FIELD fabgdocdt name="input.b.fabgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocdt
            
            #add-point:AFTER FIELD fabgdocdt name="input.a.fabgdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgdocdt
            #add-point:ON CHANGE fabgdocdt name="input.g.fabgdocdt"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fabgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgld
            #add-point:ON ACTION controlp INFIELD fabgld name="input.c.fabgld"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabgld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_fabg_m.fabgld = g_qryparam.return1              

            DISPLAY g_fabg_m.fabgld TO fabgld              #

            NEXT FIELD fabgld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocno
            #add-point:ON ACTION controlp INFIELD fabgdocno name="input.c.fabgdocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabgdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = "afat513"

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_fabg_m.fabgdocno = g_qryparam.return1              

            DISPLAY g_fabg_m.fabgdocno TO fabgdocno              #

            NEXT FIELD fabgdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.docno_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD docno_1
            #add-point:ON ACTION controlp INFIELD docno_1 name="input.c.docno_1"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.docno_1             #給予default值

            #給予arg
            #LET g_qryparam.arg1 = "" #s
            #LET g_qryparam.arg2 = "" #s
            #
            #CALL q_ooba002_3()                                #呼叫開窗
            
            #160926-00003#1--add--str--lujh
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = "afat514"

            CALL q_ooba002_1()
            #160926-00003#1--add--end--lujh
 
            LET g_fabg_m.docno_1 = g_qryparam.return1              

            DISPLAY g_fabg_m.docno_1 TO docno_1              #

            NEXT FIELD docno_1                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocdt
            #add-point:ON ACTION controlp INFIELD fabgdocdt name="input.c.fabgdocdt"
            
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
   IF INT_FLAG THEN
      LET g_fabg_m.fabgld = ''
      LET g_fabg_m.fabgdocno = ''
      #LET g_fabg_m.docno = ''   #160905-00037#1 mark
      LET g_fabg_m.docno_1 = ''  #160905-00037#1 add
      LET g_fabg_m.fabgdocdt = ''
      LET INT_FLAG = 0
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_afat520_01 
   
   #add-point:input段after input name="input.post_input"
   #RETURN g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.docno,g_fabg_m.fabgdocdt  #160905-00037#1 mark
   RETURN g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.docno_1,g_fabg_m.fabgdocdt #160905-00037#1 add
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afat520_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat520_01.other_function" readonly="Y" >}
# 帳套說明
PRIVATE FUNCTION afat520_01_fabgld_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabg_m.fabgld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabg_m.fabgld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabg_m.fabgld_desc
END FUNCTION

 
{</section>}
 
