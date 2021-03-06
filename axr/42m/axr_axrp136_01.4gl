#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp136_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-05-12 10:15:44), PR版次:0001(2016-05-12 15:36:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: axrp136_01
#+ Description: 代收銀帳務
#+ Creator....: 02114(2016-05-12 10:14:18)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="axrp136_01.global" >}
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
PRIVATE type type_g_xrca_m        RECORD
       deaf026 LIKE deaf_t.deaf026, 
   deaf026_desc LIKE type_t.chr80, 
   xrcald LIKE xrca_t.xrcald, 
   xrcald_desc LIKE type_t.chr80, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcadocno_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_xrca_m        type_g_xrca_m
 
   DEFINE g_xrcald_t LIKE xrca_t.xrcald
DEFINE g_xrcadocno_t LIKE xrca_t.xrcadocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrp136_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axrp136_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_deaf026
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
   DEFINE p_deaf026       LIKE deaf_t.deaf026
   DEFINE l_comp          LIKE ooef_t.ooef017  
   DEFINE l_n             LIKE type_t.num5   
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_glaa024       LIKE glaa_t.glaa024
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axrp136_01 WITH FORM cl_ap_formpath("axr","axrp136_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_xrca_m.deaf026 = p_deaf026
   SELECT ooef017 INTO l_comp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_deaf026

   SELECT glaald,glaa024 INTO g_xrca_m.xrcald,l_glaa024
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = l_comp
      AND glaa014 = 'Y'
   CALL s_desc_get_department_desc(g_xrca_m.deaf026) RETURNING g_xrca_m.deaf026_desc
   CALL axrp136_01_show_def()
   DISPLAY g_xrca_m.deaf026_desc TO deaf026_desc
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xrca_m.deaf026,g_xrca_m.xrcald,g_xrca_m.xrcadocno ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deaf026
            
            #add-point:AFTER FIELD deaf026 name="input.a.deaf026"
       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deaf026
            #add-point:BEFORE FIELD deaf026 name="input.b.deaf026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deaf026
            #add-point:ON CHANGE deaf026 name="input.g.deaf026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcald
            
            #add-point:AFTER FIELD xrcald name="input.a.xrcald"
            IF NOT cl_null(g_xrca_m.xrcald) THEN 
               SELECT COUNT(*) INTO l_n
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaacomp = l_comp
                  AND glaald = g_xrca_m.xrcald
                 
               IF l_n = 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'axr-01009'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD xrcald
               END IF
               
               LET g_errno = ''
               CALL s_fin_ld_chk(g_xrca_m.xrcald,g_user,'Y') RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  RETURN
                  NEXT FIELD xrcald
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcald
            #add-point:BEFORE FIELD xrcald name="input.b.xrcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcald
            #add-point:ON CHANGE xrcald name="input.g.xrcald"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcadocno
            
            #add-point:AFTER FIELD xrcadocno name="input.a.xrcadocno"
            IF NOT cl_null(g_xrca_m.xrcadocno) THEN
               IF NOT s_aooi200_fin_chk_slip(g_xrca_m.xrcald,l_glaa024,g_xrca_m.xrcadocno,'axrt350') THEN
                  LET g_xrca_m.xrcadocno = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcadocno
            #add-point:BEFORE FIELD xrcadocno name="input.b.xrcadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcadocno
            #add-point:ON CHANGE xrcadocno name="input.g.xrcadocno"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.deaf026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deaf026
            #add-point:ON ACTION controlp INFIELD deaf026 name="input.c.deaf026"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcald
            #add-point:ON ACTION controlp INFIELD xrcald name="input.c.xrcald"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrca_m.xrcald             #給予default值
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp = '",l_comp,"'"
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
 
            CALL q_authorised_ld()                                #呼叫開窗
 
            LET g_xrca_m.xrcald = g_qryparam.return1              

            DISPLAY g_xrca_m.xrcald TO xrcald              #

            NEXT FIELD xrcald                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcadocno
            #add-point:ON ACTION controlp INFIELD xrcadocno name="input.c.xrcadocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xrca_m.xrcadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = 'axrt350'
 
            CALL q_ooba002_1()                                #呼叫開窗
 
            LET g_xrca_m.xrcadocno = g_qryparam.return1              

            DISPLAY g_xrca_m.xrcadocno TO xrcadocno              #

            NEXT FIELD xrcadocno                          #返回原欄位



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
      LET INT_FLAG = 0
      RETURN '',''
   END IF
   
   RETURN g_xrca_m.xrcald,g_xrca_m.xrcadocno
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_axrp136_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrp136_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axrp136_01.other_function" readonly="Y" >}
# 說明欄位帶值
PRIVATE FUNCTION axrp136_01_show_def()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrca_m.xrcald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrca_m.xrcald_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xrca_m.xrcald_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrca_m.xrcadocno
   CALL ap_ref_array2(g_ref_fields,"SELECT oobxl003 FROM oobxl_t WHERE oobxlent='"||g_enterprise||"' AND oobxl001=? AND oobxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrca_m.xrcadocno_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xrca_m.xrcadocno_desc
END FUNCTION

 
{</section>}
 
