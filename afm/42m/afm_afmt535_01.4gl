#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt535_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-05-29 16:25:52), PR版次:0004(2017-01-11 19:23:44)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000047
#+ Filename...: afmt535_01
#+ Description: 產生帳務資料
#+ Creator....: 03538(2015-05-22 09:31:53)
#+ Modifier...: 03538 -SD/PR- 08729
 
{</section>}
 
{<section id="afmt535_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#151027     15/10/27 By 03538       jiangtian:利息轉本金為Y,代表是afmt580產生的投資購買單,因此帳務單是在afmt585做
#160705-00042#11   2016/07/15 By sakura   查詢程式段q_ooba002_1開窗，呼叫開窗前的g_qryparam.arg若是要傳入程式代號，要改傳入g_prog
#161006-00005#13   2016/10/19 By 08732    組織類型與職能開窗調整
#161104-00046#21   2017/01/09 By 08729    單別預設值;資料依照單別user dept權限過濾單號
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
PRIVATE type type_g_fmml_m        RECORD
       fmml001 LIKE fmml_t.fmml001, 
   fmml003 LIKE fmml_t.fmml003, 
   fmmldocno LIKE fmml_t.fmmldocno, 
   fmmldocdt LIKE fmml_t.fmmldocdt
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_t535_01     STRING
DEFINE g_glaa003        LIKE glaa_t.glaa003
DEFINE g_glaa024        LIKE glaa_t.glaa024
DEFINE g_glaacomp       LIKE glaa_t.glaacomp
DEFINE g_fmml005        LIKE fmml_t.fmml005
DEFINE g_fmml006        LIKE fmml_t.fmml006
DEFINE g_wc_fmml001     STRING
DEFINE g_wc_fmml003     STRING   #帳套範圍
DEFINE g_user_slip_wc   STRING              #161104-00046#21 add

#end add-point
 
DEFINE g_fmml_m        type_g_fmml_m
 
   DEFINE g_fmmldocno_t LIKE fmml_t.fmmldocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afmt535_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION afmt535_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_fmmldocno,p_type
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
   DEFINE p_fmmldocno   LIKE fmml_t.fmmldocno
   DEFINE p_type        LIKE type_t.chr1
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_docno       LIKE fmml_t.fmmldocno
   DEFINE l_array       DYNAMIC ARRAY OF RECORD
                        chr  LIKE type_t.chr1000,
                        dat  LIKE type_t.dat
                        END RECORD  
   DEFINE l_glaa        RECORD
                        glaacomp        LIKE glaa_t.glaacomp,
                        glaa024         LIKE glaa_t.glaa024,
                        glaa026         LIKE glaa_t.glaa026
                        END RECORD
   DEFINE l_strdat      LIKE type_t.dat                        
   DEFINE l_enddat      LIKE type_t.dat         
   DEFINE l_flag1       LIKE type_t.num5   #161104-00046#21
   WHENEVER ERROR CONTINUE
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afmt535_01 WITH FORM cl_ap_formpath("afm","afmt535_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_comp_visible('group_1',TRUE)
   IF p_type = '2' THEN
      CALL cl_set_comp_visible('group_1',FALSE)
   END IF
   LET r_success = TRUE   
   IF NOT cl_null(p_fmmldocno) THEN
      SELECT fmml001,fmml003,fmmldocdt
        INTO g_fmml_m.fmml001,g_fmml_m.fmml003,g_fmml_m.fmmldocdt
        FROM fmml_t
       WHERE fmmlent =g_enterprise AND fmmldocno = p_fmmldocno
       
      CALL s_ld_sel_glaa(g_fmml_m.fmml003,'glaa003|glaa024|glaacomp') 
        RETURNING g_sub_success,g_glaa003,g_glaa024,g_glaacomp       
      #取得年月
      CALL s_fin_date_get_period_value(g_glaa003,g_fmml_m.fmml003,g_fmml_m.fmmldocdt)
         RETURNING g_sub_success,g_fmml005,g_fmml006
      #取得日期
      CALL s_fin_date_get_period_range(g_glaa003,g_fmml005,g_fmml006)
         RETURNING l_strdat,l_enddat          
      
      CALL s_fin_account_center_sons_query('3',g_fmml_m.fmml001,g_fmml_m.fmmldocdt,'1')  
      CALL s_fin_account_center_sons_str() RETURNING g_wc_fmml001
      CALL s_fin_get_wc_str(g_wc_fmml001) RETURNING g_wc_fmml001
      CALL s_fin_account_center_ld_str() RETURNING g_wc_fmml003
      CALL s_fin_get_wc_str(g_wc_fmml003) RETURNING g_wc_fmml003 

   ELSE
      #帳務組織/帳套/法人預設
      LET g_fmml_m.fmmldocdt = g_today
      CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,g_fmml_m.fmml001,
                                                      g_fmml_m.fmml003,g_glaacomp 
      CALL s_ld_sel_glaa(g_fmml_m.fmml003,'glaa003|glaa024|glaacomp') 
            RETURNING g_sub_success,g_glaa003,g_glaa024,g_glaacomp
      #取得年月
      CALL s_fin_date_get_period_value(g_glaa003,g_fmml_m.fmml003,g_fmml_m.fmmldocdt)
         RETURNING g_sub_success,g_fmml005,g_fmml006
      #取得日期
      CALL s_fin_date_get_period_range(g_glaa003,g_fmml005,g_fmml006)
         RETURNING l_strdat,l_enddat               
      LET g_fmml_m.fmmldocno = ''                                                        
   END IF       
   #161104-00046#21 --s add
   #建立與單頭array相同的temptable
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#21 --e add 
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_fmml_m.fmml001,g_fmml_m.fmml003,g_fmml_m.fmmldocno,g_fmml_m.fmmldocdt ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmml001
            #add-point:BEFORE FIELD fmml001 name="input.b.fmml001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmml001
            
            #add-point:AFTER FIELD fmml001 name="input.a.fmml001"
            IF NOT cl_null(g_fmml_m.fmml001) THEN           
               CALL s_fin_account_center_with_ld_chk(g_fmml_m.fmml001,g_fmml_m.fmml003,g_user,'3','N','',g_fmml_m.fmmldocdt) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fmml_m.fmml001 = ''
                  LET g_fmml_m.fmml003  = ''
                  DISPLAY BY NAME g_fmml_m.fmml001
                  NEXT FIELD CURRENT
               END IF
            END IF               
            CALL s_fin_account_center_sons_query('3',g_fmml_m.fmml001,g_fmml_m.fmmldocdt,'1')  
            CALL s_fin_account_center_sons_str() RETURNING g_wc_fmml001
            CALL s_fin_get_wc_str(g_wc_fmml001) RETURNING g_wc_fmml001
            CALL s_fin_account_center_ld_str() RETURNING g_wc_fmml003
            CALL s_fin_get_wc_str(g_wc_fmml003) RETURNING g_wc_fmml003
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmml001
            #add-point:ON CHANGE fmml001 name="input.g.fmml001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmml003
            #add-point:BEFORE FIELD fmml003 name="input.b.fmml003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmml003
            
            #add-point:AFTER FIELD fmml003 name="input.a.fmml003"
            IF NOT cl_null(g_fmml_m.fmml003) THEN 
               CALL s_fin_account_center_with_ld_chk(g_fmml_m.fmml001,g_fmml_m.fmml003,g_user,'3','N',g_wc_fmml003,g_fmml_m.fmmldocdt) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fmml_m.fmml003 = ''
                  NEXT FIELD CURRENT       
               END IF
            END IF
            CALL s_ld_sel_glaa(g_fmml_m.fmml003,'glaa003|glaa024|glaacomp')
               RETURNING g_sub_success,g_glaa003,g_glaa024,g_glaacomp
            #取得年月
            CALL s_fin_date_get_period_value(g_glaa003,g_fmml_m.fmml003,g_fmml_m.fmmldocdt)
               RETURNING g_sub_success,g_fmml005,g_fmml006
            #取得日期
            CALL s_fin_date_get_period_range(g_glaa003,g_fmml005,g_fmml006)
               RETURNING l_strdat,l_enddat            
     
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmml003
            #add-point:ON CHANGE fmml003 name="input.g.fmml003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmldocno
            #add-point:BEFORE FIELD fmmldocno name="input.b.fmmldocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmldocno
            
            #add-point:AFTER FIELD fmmldocno name="input.a.fmmldocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_fmml_m.fmmldocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fmml_m.fmmldocno != g_fmmldocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmml_t WHERE "||"fmmlent = '" ||g_enterprise|| "' AND "||"fmmldocno = '"||g_fmml_m.fmmldocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_fmml_m.fmmldocno) THEN
               IF NOT s_aooi200_fin_chk_docno(g_fmml_m.fmml003,'','',g_fmml_m.fmmldocno,g_fmml_m.fmmldocdt,g_prog) THEN
                  LET g_fmml_m.fmmldocno = ''
                  NEXT FIELD CURRENT
               END IF
               #161104-00046#21 --s add
               CALL s_control_chk_doc('1',g_fmml_m.fmmldocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag1
               IF g_sub_success AND l_flag1 THEN             
               ELSE
                  LET g_fmml_m.fmmldocno = g_fmmldocno_t
                  NEXT FIELD CURRENT                
               END IF
               #161104-00046#21 --e add
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmldocno
            #add-point:ON CHANGE fmmldocno name="input.g.fmmldocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmldocdt
            #add-point:BEFORE FIELD fmmldocdt name="input.b.fmmldocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmldocdt
            
            #add-point:AFTER FIELD fmmldocdt name="input.a.fmmldocdt"
            #取得年月
            CALL s_fin_date_get_period_value(g_glaa003,g_fmml_m.fmml003,g_fmml_m.fmmldocdt)
               RETURNING g_sub_success,g_fmml005,g_fmml006
            #取得日期
            CALL s_fin_date_get_period_range(g_glaa003,g_fmml005,g_fmml006)
               RETURNING l_strdat,l_enddat                  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmldocdt
            #add-point:ON CHANGE fmmldocdt name="input.g.fmmldocdt"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmml001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmml001
            #add-point:ON ACTION controlp INFIELD fmml001 name="input.c.fmml001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmml_m.fmml001       #給予default值
            #LET g_qryparam.where = " ooef204 = 'Y' "   #161006-00005#13   mark 
            #CALL q_ooef001()     #161006-00005#13   mark                    
            CALL q_ooef001_46()   #161006-00005#13   add
            LET g_fmml_m.fmml001 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY BY NAME g_fmml_m.fmml001
            NEXT FIELD fmml001
            #END add-point
 
 
         #Ctrlp:input.c.fmml003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmml003
            #add-point:ON ACTION controlp INFIELD fmml003 name="input.c.fmml003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmml_m.fmml003
            LET g_qryparam.where = "  glaald IN ",g_wc_fmml003
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            CALL q_authorised_ld()
            LET g_fmml_m.fmml003 = g_qryparam.return1
            DISPLAY BY NAME g_fmml_m.fmml003
            NEXT FIELD fmml003
            #END add-point
 
 
         #Ctrlp:input.c.fmmldocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmldocno
            #add-point:ON ACTION controlp INFIELD fmmldocno name="input.c.fmmldocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmml_m.fmmldocno
            LET g_qryparam.arg1 = g_glaa024
            #LET g_qryparam.arg2 = 'afmt535'   #160705-00042#11 160715 by sakura mark
            LET g_qryparam.arg2 = g_prog       #160705-00042#11 160715 by sakura add
            #161104-00046#21 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc 
            END IF
            #161104-00046#21 --e add
            CALL q_ooba002_1()
            LET g_fmml_m.fmmldocno = g_qryparam.return1
            DISPLAY BY NAME g_fmml_m.fmmldocno
            NEXT FIELD fmmldocno
            #END add-point
 
 
         #Ctrlp:input.c.fmmldocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmldocdt
            #add-point:ON ACTION controlp INFIELD fmmldocdt name="input.c.fmmldocdt"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT g_wc_t535_01 ON fmmjsite,fmmjdocno
           FROM fmmjsite,fmmjdocno
          
         ON ACTION controlp INFIELD fmmjsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where    = " ooef017 = '",g_glaacomp,"' AND ooef001 IN ",g_wc_fmml001
            #                         " AND ooef206='Y' "   #161006-00005#13   mark
            #CALL q_ooef001()   #161006-00005#13   mark
            CALL q_ooef001_33()   #161006-000005#13   add
            DISPLAY g_qryparam.return1 TO fmmjsite
            NEXT FIELD fmmjsite 
         
          ON ACTION controlp INFIELD fmmjdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE          
            LET g_qryparam.where    = "     fmmjsite IN ",g_wc_fmml001,
                                      " AND fmmjstus = 'Y' ",
                                      " AND fmmj023 <> 'Y' ",   #151027
                                      " AND fmmjdocdt BETWEEN '",l_strdat,"' AND '",g_fmml_m.fmmldocdt,"' ",
                                      #151110--s
                                      " AND NOT EXISTS ",
                                      "( ",
                                      "       SELECT 1 FROM fmml_t,fmmm_t ",
                                      "        WHERE fmmlent = fmmment AND fmmldocno = fmmm001 ",
                                      "          AND fmmjent = fmmlent AND fmmjdocno = fmmm003 ",
                                      "          AND fmmlstus <> 'X' ",
                                      ") "                                     
                                      #151110--e
            CALL q_fmmjdocno()                              
            DISPLAY g_qryparam.return1 TO fmmjdocno
            NEXT FIELD fmmjdocno                         

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
   CALL cl_set_comp_visible('group_1',TRUE)
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_afmt535_01 
   
   #add-point:input段after input name="input.post_input"
   CALL cl_err_collect_init()
   IF INT_FLAG THEN
      LET r_success= FALSE
      LET INT_FLAG = 0
   ELSE
      IF cl_null(p_fmmldocno)THEN
         #產生單頭+單身
         #p_array
         CALL l_array.clear()
         #取得會計參照表號    
         CALL s_ld_sel_glaa(g_fmml_m.fmml003,'glaa003|glaa024|glaacomp') 
         RETURNING g_sub_success,g_glaa003,g_glaa024,g_glaacomp
         #取得年月
         CALL s_fin_date_get_period_value(g_glaa003,g_fmml_m.fmml003,g_fmml_m.fmmldocdt)
            RETURNING g_sub_success,g_fmml005,g_fmml006
         #取得日期
         CALL s_fin_date_get_period_range(g_glaa003,g_fmml005,g_fmml006)
            RETURNING l_strdat,l_enddat               
         LET l_array[1].chr = g_fmml_m.fmml001    #帳務中心
         LET l_array[2].chr = g_fmml_m.fmml003    #帳別
         LET l_array[3].chr = g_fmml_m.fmmldocno  #單別
         LET l_array[4].chr = g_fmml005           #年度
         LET l_array[5].chr = g_fmml006           #期別
         LET l_array[6].dat = g_fmml_m.fmmldocdt  #日期     
         LET g_wc_t535_01 = g_wc_t535_01 CLIPPED, 
                            " AND fmmjsite IN ",g_wc_fmml001,
                            " AND fmmjdocdt BETWEEN '",l_strdat,"' AND '",g_fmml_m.fmmldocdt,"' "         
         CALL s_afmt535_ins_fmml(l_array,g_wc_t535_01)RETURNING g_sub_success,r_docno 
      ELSE
          #產生單身
          #l_array 
          #1.fmmldocno 帳務單單號
          #2.fmml001   帳務中心
          #3.fmml003   帳套
          #4.gmml004   歸屬法人
          #5.fmml004   日期
          #6.fmml005   年度
          #7.fmml006   期別
          CALL l_array.clear()
          SELECT fmmldocno,fmml001,fmml003,fmml004,fmmldocdt,
                 fmml005,fmml006 
            INTO l_array[1].chr,l_array[2].chr,l_array[3].chr,l_array[4].chr,l_array[5].dat,
                 l_array[6].chr,l_array[7].chr
            FROM fmml_t
           WHERE fmmlent = g_enterprise
             AND fmmldocno = p_fmmldocno
          LET g_wc_t535_01 = g_wc_t535_01 CLIPPED, 
                             " AND fmmjsite IN ",g_wc_fmml001,
                             " AND fmmjdocdt BETWEEN '",l_strdat,"' AND '",g_fmml_m.fmmldocdt,"' "   
          CALL s_afmt535_ins_fmmm(l_array,g_wc_t535_01,'2')RETURNING g_sub_success
          LET r_docno = p_fmmldocno          
      END IF
      IF NOT g_sub_success THEN
         LET r_success = FALSE        
      END IF
  
   END IF
   CALL cl_err_collect_show()
   
   RETURN r_success,r_docno 
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afmt535_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afmt535_01.other_function" readonly="Y" >}

 
{</section>}
 
