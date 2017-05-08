#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt430_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-11-21 14:35:33), PR版次:0002(2016-12-30 09:58:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgt430_01
#+ Description: 整批產生-以銷定產
#+ Creator....: 02114(2016-11-21 14:33:23)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="abgt430_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#161129-00019#1   2016/12/02  By 02114    增加最後一期生產提前量的處理
#161225-00005#2   2016/12/30  By 02114    增加當期銷售預算量欄位 bgbg017
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
PRIVATE type type_g_bgdg_m        RECORD
       edit_1 LIKE type_t.chr500, 
   bgdg001 LIKE bgdg_t.bgdg001, 
   bgdg001_desc LIKE type_t.chr80, 
   bgdg002 LIKE bgdg_t.bgdg002, 
   bgdg003 LIKE bgdg_t.bgdg003, 
   bgdg003_desc LIKE type_t.chr80, 
   d LIKE type_t.chr500, 
   a LIKE type_t.chr500, 
   b LIKE type_t.chr500, 
   qty LIKE type_t.chr500, 
   c LIKE type_t.chr500, 
   e LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_bgdg_m        type_g_bgdg_m
 
   DEFINE g_bgdg001_t LIKE bgdg_t.bgdg001
DEFINE g_bgdg002_t LIKE bgdg_t.bgdg002
DEFINE g_bgdg003_t LIKE bgdg_t.bgdg003
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgt430_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgt430_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   
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
   DEFINE l_site_str      STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.chr1
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgt430_01 WITH FORM cl_ap_formpath("abg","abgt430_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL s_fin_create_account_center_tmp()
   LET l_site_str = ''
   LET g_bgdg_m.a = '1'
   LET g_bgdg_m.b = '1'
   LET g_bgdg_m.c = 'Y'
   LET g_bgdg_m.d = 'Y'
   LET g_bgdg_m.e = '1'
   LET g_bgdg_m.qty = ''
   CALL abgt430_01_comp_entry("qty",FALSE)
   LET g_errshow = 1
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_bgdg_m.bgdg001,g_bgdg_m.bgdg002,g_bgdg_m.bgdg003,g_bgdg_m.d,g_bgdg_m.a,g_bgdg_m.b, 
          g_bgdg_m.qty,g_bgdg_m.c,g_bgdg_m.e ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdg001
            
            #add-point:AFTER FIELD bgdg001 name="input.a.bgdg001"
            IF NOT cl_null(g_bgdg_m.bgdg001) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bgdg_m.bgdg001

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_bgaa001") THEN
                  #檢查成功時後續處理
                  IF NOT cl_null(g_bgdg_m.bgdg002) AND NOT cl_null(g_bgdg_m.bgdg003) THEN 
                     CALL abgt430_01_bgdg001_bgdg002_bgsg003_chk(g_bgdg_m.bgdg001,g_bgdg_m.bgdg002,g_bgdg_m.bgdg003)
                     IF NOT cl_null(g_errno) THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_bgdg_m.bgdg001 CLIPPED,"+" CLIPPED,g_bgdg_m.bgdg002,"+" CLIPPED,g_bgdg_m.bgdg003
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgdg_m.bgdg001 = ''
                        CALL abgt430_01_bgdg001_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_bgdg_m.bgdg001 = ''
                  CALL abgt430_01_bgdg001_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL abgt430_01_bgdg001_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdg001
            #add-point:BEFORE FIELD bgdg001 name="input.b.bgdg001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgdg001
            #add-point:ON CHANGE bgdg001 name="input.g.bgdg001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdg002
            #add-point:BEFORE FIELD bgdg002 name="input.b.bgdg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdg002
            
            #add-point:AFTER FIELD bgdg002 name="input.a.bgdg002"
            IF NOT cl_null(g_bgdg_m.bgdg003) AND NOT cl_null(g_bgdg_m.bgdg002) AND NOT cl_null(g_bgdg_m.bgdg003) THEN 
               CALL abgt430_01_bgdg001_bgdg002_bgsg003_chk(g_bgdg_m.bgdg001,g_bgdg_m.bgdg002,g_bgdg_m.bgdg003)
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_bgdg_m.bgdg001 CLIPPED,"+" CLIPPED,g_bgdg_m.bgdg002,"+" CLIPPED,g_bgdg_m.bgdg003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgdg_m.bgdg002 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgdg002
            #add-point:ON CHANGE bgdg002 name="input.g.bgdg002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgdg003
            
            #add-point:AFTER FIELD bgdg003 name="input.a.bgdg003"
            IF NOT cl_null(g_bgdg_m.bgdg003) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bgdg_m.bgdg003
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_24") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL s_abg2_get_budget_site(g_bgdg_m.bgdg001,'',g_user,'02') RETURNING l_site_str
                  IF cl_null(l_site_str) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00248'
                     LET g_errparam.extend = g_bgdg_m.bgdg003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgdg_m.bgdg003 = ''
                     CALL s_desc_get_department_desc(g_bgdg_m.bgdg003) RETURNING g_bgdg_m.bgdg003_desc
                     DISPLAY BY NAME g_bgdg_m.bgdg003_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢查預算組織是否在abgi090中可操作的組織中
                  IF s_chr_get_index_of(l_site_str,g_bgdg_m.bgdg003,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00247'
                     LET g_errparam.extend = g_bgdg_m.bgdg003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgdg_m.bgdg003 = ''
                     CALL s_desc_get_department_desc(g_bgdg_m.bgdg003) RETURNING g_bgdg_m.bgdg003_desc
                     DISPLAY BY NAME g_bgdg_m.bgdg003_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_bgdg_m.bgdg001) AND NOT cl_null(g_bgdg_m.bgdg002) THEN 
                     CALL abgt430_01_bgdg001_bgdg002_bgsg003_chk(g_bgdg_m.bgdg001,g_bgdg_m.bgdg002,g_bgdg_m.bgdg003)
                     IF NOT cl_null(g_errno) THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_bgdg_m.bgdg001 CLIPPED,"+" CLIPPED,g_bgdg_m.bgdg002,"+" CLIPPED,g_bgdg_m.bgdg003
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgdg_m.bgdg003 = ''
                        CALL s_desc_get_department_desc(g_bgdg_m.bgdg003) RETURNING g_bgdg_m.bgdg003_desc
                        DISPLAY BY NAME g_bgdg_m.bgdg003_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_bgdg_m.bgdg003 = ''
                  CALL s_desc_get_department_desc(g_bgdg_m.bgdg003) RETURNING g_bgdg_m.bgdg003_desc
                  DISPLAY BY NAME g_bgdg_m.bgdg003_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_bgdg_m.bgdg003) RETURNING g_bgdg_m.bgdg003_desc
            DISPLAY BY NAME g_bgdg_m.bgdg003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgdg003
            #add-point:BEFORE FIELD bgdg003 name="input.b.bgdg003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgdg003
            #add-point:ON CHANGE bgdg003 name="input.g.bgdg003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD d
            #add-point:BEFORE FIELD d name="input.b.d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD d
            
            #add-point:AFTER FIELD d name="input.a.d"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE d
            #add-point:ON CHANGE d name="input.g.d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="input.b.a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="input.a.a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE a
            #add-point:ON CHANGE a name="input.g.a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b
            #add-point:BEFORE FIELD b name="input.b.b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b
            
            #add-point:AFTER FIELD b name="input.a.b"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b
            #add-point:ON CHANGE b name="input.g.b"
            IF g_bgdg_m.b = '1' THEN 
               LET g_bgdg_m.qty = ''
               CALL abgt430_01_comp_entry("qty",FALSE)
            ELSE
               CALL abgt430_01_comp_entry("qty",TRUE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qty
            #add-point:BEFORE FIELD qty name="input.b.qty"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qty
            
            #add-point:AFTER FIELD qty name="input.a.qty"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qty
            #add-point:ON CHANGE qty name="input.g.qty"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD c
            #add-point:BEFORE FIELD c name="input.b.c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD c
            
            #add-point:AFTER FIELD c name="input.a.c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE c
            #add-point:ON CHANGE c name="input.g.c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD e
            #add-point:BEFORE FIELD e name="input.b.e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD e
            
            #add-point:AFTER FIELD e name="input.a.e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE e
            #add-point:ON CHANGE e name="input.g.e"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgdg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdg001
            #add-point:ON ACTION controlp INFIELD bgdg001 name="input.c.bgdg001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgdg_m.bgdg001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgaa001()                                #呼叫開窗
          
            LET g_bgdg_m.bgdg001 = g_qryparam.return1              
            CALL abgt430_01_bgdg001_desc()
            DISPLAY g_bgdg_m.bgdg001 TO bgdg001              #

            NEXT FIELD bgdg001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgdg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdg002
            #add-point:ON ACTION controlp INFIELD bgdg002 name="input.c.bgdg002"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgdg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgdg003
            #add-point:ON ACTION controlp INFIELD bgdg003 name="input.c.bgdg003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgdg_m.bgdg003             #給予default值
            
            #檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_bgdg_m.bgdg001,'',g_user,'02') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            IF NOT cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = g_qryparam.where,
                                      " AND ooef001 IN ",l_site_str
            ELSE
               LET g_qryparam.where = " ooef001 IN ",l_site_str
            END IF
            
            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooef001_77()                                #呼叫開窗
 
            LET g_bgdg_m.bgdg003 = g_qryparam.return1              
            CALL s_desc_get_department_desc(g_bgdg_m.bgdg001) RETURNING g_bgdg_m.bgdg001_desc
            DISPLAY g_bgdg_m.bgdg001_desc TO bgdg001_desc
            DISPLAY g_bgdg_m.bgdg003 TO bgdg003              #

            NEXT FIELD bgdg003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD d
            #add-point:ON ACTION controlp INFIELD d name="input.c.d"
            
            #END add-point
 
 
         #Ctrlp:input.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="input.c.a"
            
            #END add-point
 
 
         #Ctrlp:input.c.b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b
            #add-point:ON ACTION controlp INFIELD b name="input.c.b"
            
            #END add-point
 
 
         #Ctrlp:input.c.qty
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qty
            #add-point:ON ACTION controlp INFIELD qty name="input.c.qty"
            
            #END add-point
 
 
         #Ctrlp:input.c.c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD c
            #add-point:ON ACTION controlp INFIELD c name="input.c.c"
            
            #END add-point
 
 
         #Ctrlp:input.c.e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD e
            #add-point:ON ACTION controlp INFIELD e name="input.c.e"
            
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
   CLOSE WINDOW w_abgt430_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN '','',''
   END IF
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   CALL abgt430_01_ins() RETURNING l_success,l_flag

   IF l_success = TRUE THEN 
      IF l_flag = 'N' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.code   = 'axc-00530' 
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()    
         RETURN '','',''         
      ELSE
         CALL s_transaction_end('Y','1')
         CALL cl_err_collect_show()
         RETURN g_bgdg_m.bgdg001,g_bgdg_m.bgdg002,g_bgdg_m.bgdg003
      END IF
   ELSE
      CALL s_transaction_end('N','1')
      CALL cl_err_collect_show()
      RETURN '','',''
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgt430_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgt430_01.other_function" readonly="Y" >}
# 预算编号说明
PRIVATE FUNCTION abgt430_01_bgdg001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bgdg_m.bgdg001
   CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent="||g_enterprise||" AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bgdg_m.bgdg001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_bgdg_m.bgdg001_desc
END FUNCTION
# 预存已审核资料否检查
PRIVATE FUNCTION abgt430_01_bgdg001_bgdg002_bgsg003_chk(p_bgdg001,p_bgdg002,p_bgdg003)
   DEFINE p_bgdg001        LIKE bgdg_t.bgdg001
   DEFINE p_bgdg002        LIKE bgdg_t.bgdg002
   DEFINE p_bgdg003        LIKE bgdg_t.bgdg003
   DEFINE l_n              LIKE type_t.num5
   
   LET g_errno = ''
   
   SELECT COUNT(1) INTO l_n
     FROM bgdg_t
    WHERE bgdgent = g_enterprise
      AND bgdg001 = g_bgdg_m.bgdg001
      AND bgdg002 = g_bgdg_m.bgdg002
      AND bgdg003 = g_bgdg_m.bgdg003
      AND bgdgstus IN ('Y','FC')
   
   IF l_n > 0 THEN 
      LET g_errno = 'abg-00254'
   END IF
   
END FUNCTION
# 動態設定元件開啟與關閉
PRIVATE FUNCTION abgt430_01_comp_entry(ps_fields,pi_entry)
   DEFINE ps_fields STRING,
          pi_entry  LIKE type_t.num5           
   DEFINE lst_fields base.StringTokenizer,
          ls_field_name STRING
   DEFINE lwin_curr     ui.Window
   DEFINE lnode_win     om.DomNode,
          llst_items    om.NodeList,
          li_i          LIKE type_t.num5,        
          lnode_item    om.DomNode,
          ls_item_name  STRING
 
   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN  
      RETURN
   END IF
 
   IF (ps_fields IS NULL) THEN
      RETURN
   END IF
 
   LET ps_fields = ps_fields.toLowerCase()
 
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
 
   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
 
   LET llst_items = lnode_win.selectByPath("//Form//*")
 
   WHILE lst_fields.hasMoreTokens()
     LET ls_field_name = lst_fields.nextToken()
     LET ls_field_name = ls_field_name.trim()
 
     IF (ls_field_name.getLength() > 0) THEN
        FOR li_i = 1 TO llst_items.getLength()
            LET lnode_item = llst_items.item(li_i)
            LET ls_item_name = lnode_item.getAttribute("colName")
 
            IF (ls_item_name IS NULL) THEN
               LET ls_item_name = lnode_item.getAttribute("name")
 
               IF (ls_item_name IS NULL) THEN
                  CONTINUE FOR
               END IF
            END IF
 
            LET ls_item_name = ls_item_name.trim()
 
            IF (ls_item_name.equals(ls_field_name)) THEN
               IF (pi_entry) THEN
                  CALL lnode_item.setAttribute("noEntry", "0")
                  CALL lnode_item.setAttribute("active", "1")
               ELSE
                  CALL lnode_item.setAttribute("noEntry", "1")
                  CALL lnode_item.setAttribute("active", "0")
               END IF
 
               EXIT FOR
            END IF
        END FOR
     END IF
   END WHILE
END FUNCTION
# 产生bgdg资料
PRIVATE FUNCTION abgt430_01_ins()
   DEFINE l_sql           STRING
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_bgaa002       LIKE bgaa_t.bgaa002
   DEFINE l_bgaa003       LIKE bgaa_t.bgaa003
   DEFINE l_bgac004       LIKE bgac_t.bgac004
   DEFINE l_bgcj009       LIKE bgcj_t.bgcj009
   DEFINE l_bgcj045       LIKE bgcj_t.bgcj045
   DEFINE l_bgcj045_n     LIKE bgcj_t.bgcj045
   DEFINE l_bgcj045_y     LIKE bgcj_t.bgcj045
   DEFINE l_bgea028       LIKE bgea_t.bgea028
   DEFINE l_bgea029       LIKE bgea_t.bgea029
   DEFINE l_bgdg016_o     LIKE bgdg_t.bgdg016
   DEFINE l_bgdg011_t     LIKE bgdg_t.bgdg011
   DEFINE l_bgdg          RECORD  #期別生產數量預測檔
                          bgdgent           LIKE bgdg_t.bgdgent,   #企業編號
                          bgdgownid         LIKE bgdg_t.bgdgownid, #資料所有者
                          bgdgowndp         LIKE bgdg_t.bgdgowndp, #資料所屬部門
                          bgdgcrtid         LIKE bgdg_t.bgdgcrtid, #資料建立者
                          bgdgcrtdp         LIKE bgdg_t.bgdgcrtdp, #資料建立部門
                          bgdgcrtdt         LIKE bgdg_t.bgdgcrtdt, #資料創建日
                          bgdgmodid         LIKE bgdg_t.bgdgmodid, #資料修改者
                          bgdgmoddt         LIKE bgdg_t.bgdgmoddt, #最近修改日
                          bgdgstus          LIKE bgdg_t.bgdgstus,  #狀態碼
                          bgdg001           LIKE bgdg_t.bgdg001,   #預算編號
                          bgdg002           LIKE bgdg_t.bgdg002,   #預算版本
                          bgdg003           LIKE bgdg_t.bgdg003,   #預算組織
                          bgdg004           LIKE bgdg_t.bgdg004,   #預算期別
                          bgdg005           LIKE bgdg_t.bgdg005,   #預算料號
                          bgdg006           LIKE bgdg_t.bgdg006,   #產量來源
                          bgdg007           LIKE bgdg_t.bgdg007,   #生產單位
                          bgdg008           LIKE bgdg_t.bgdg008,   #期初庫存
                          bgdg009           LIKE bgdg_t.bgdg009,   #當期銷售當期成產量
                          bgdg010           LIKE bgdg_t.bgdg010,   #生產提前量
                          bgdg011           LIKE bgdg_t.bgdg011,   #參考生產數量
                          bgdg012           LIKE bgdg_t.bgdg012,   #本層調整生產數量
                          bgdg013           LIKE bgdg_t.bgdg013,   #上層調整生產數量
                          bgdg014           LIKE bgdg_t.bgdg014,   #下層調整生產數量
                          bgdg015           LIKE bgdg_t.bgdg015,   #核准生產數量
                          bgdg016           LIKE bgdg_t.bgdg016,   #期末庫存量
                          bgdg017           LIKE bgdg_t.bgdg017,   #当期销售预算量       #161225-00005#2 add lujh
                          bgdgud001         LIKE bgdg_t.bgdgud001, #自定義欄位(文字)001
                          bgdgud002         LIKE bgdg_t.bgdgud002, #自定義欄位(文字)002
                          bgdgud003         LIKE bgdg_t.bgdgud003, #自定義欄位(文字)003
                          bgdgud004         LIKE bgdg_t.bgdgud004, #自定義欄位(文字)004
                          bgdgud005         LIKE bgdg_t.bgdgud005, #自定義欄位(文字)005
                          bgdgud006         LIKE bgdg_t.bgdgud006, #自定義欄位(文字)006
                          bgdgud007         LIKE bgdg_t.bgdgud007, #自定義欄位(文字)007
                          bgdgud008         LIKE bgdg_t.bgdgud008, #自定義欄位(文字)008
                          bgdgud009         LIKE bgdg_t.bgdgud009, #自定義欄位(文字)009
                          bgdgud010         LIKE bgdg_t.bgdgud010, #自定義欄位(文字)010
                          bgdgud011         LIKE bgdg_t.bgdgud011, #自定義欄位(數字)011
                          bgdgud012         LIKE bgdg_t.bgdgud012, #自定義欄位(數字)012
                          bgdgud013         LIKE bgdg_t.bgdgud013, #自定義欄位(數字)013
                          bgdgud014         LIKE bgdg_t.bgdgud014, #自定義欄位(數字)014
                          bgdgud015         LIKE bgdg_t.bgdgud015, #自定義欄位(數字)015
                          bgdgud016         LIKE bgdg_t.bgdgud016, #自定義欄位(數字)016
                          bgdgud017         LIKE bgdg_t.bgdgud017, #自定義欄位(數字)017
                          bgdgud018         LIKE bgdg_t.bgdgud018, #自定義欄位(數字)018
                          bgdgud019         LIKE bgdg_t.bgdgud019, #自定義欄位(數字)019
                          bgdgud020         LIKE bgdg_t.bgdgud020, #自定義欄位(數字)020
                          bgdgud021         LIKE bgdg_t.bgdgud021, #自定義欄位(日期時間)021
                          bgdgud022         LIKE bgdg_t.bgdgud022, #自定義欄位(日期時間)022
                          bgdgud023         LIKE bgdg_t.bgdgud023, #自定義欄位(日期時間)023
                          bgdgud024         LIKE bgdg_t.bgdgud024, #自定義欄位(日期時間)024
                          bgdgud025         LIKE bgdg_t.bgdgud025, #自定義欄位(日期時間)025
                          bgdgud026         LIKE bgdg_t.bgdgud026, #自定義欄位(日期時間)026
                          bgdgud027         LIKE bgdg_t.bgdgud027, #自定義欄位(日期時間)027
                          bgdgud028         LIKE bgdg_t.bgdgud028, #自定義欄位(日期時間)028
                          bgdgud029         LIKE bgdg_t.bgdgud029, #自定義欄位(日期時間)029
                          bgdgud030         LIKE bgdg_t.bgdgud030  #自定義欄位(日期時間)030
                          END RECORD
   DEFINE l_success       LIKE type_t.num5
   DEFINE r_flag          LIKE type_t.chr1
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET l_success = TRUE
   LET r_flag = 'N'
   
   #最大期别
   CALL s_abgt340_sel_bgaa(g_bgdg_m.bgdg001) RETURNING l_bgaa002,l_bgaa003,l_bgac004
   
   LET l_sql = "SELECT DISTINCT bgcj009 ",
               "  FROM bgcj_t ",
               " WHERE bgcjent = ",g_enterprise,
               "   AND bgcj001 = '20' ",
               "   AND bgcj002 = '",g_bgdg_m.bgdg001,"'",
               "   AND bgcj003 = '",g_bgdg_m.bgdg002,"'",
               "   AND bgcj007 = '",g_bgdg_m.bgdg003,"'",
               "   AND bgcjstus = 'FC' "
   PREPARE abgt430_01_ins_pre FROM l_sql
   DECLARE abgt430_01_ins_cs CURSOR FOR abgt430_01_ins_pre
   
   FOREACH abgt430_01_ins_cs INTO l_bgcj009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgt430_01_ins_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
      END IF
      
      LET l_bgdg011_t = 0
      FOR l_i = 1 TO l_bgac004
         #已存在资料检查
         LET l_n = 0
         SELECT COUNT(1) INTO l_n
           FROM bgdg_t
          WHERE bgdgent = g_enterprise
            AND bgdg001 = g_bgdg_m.bgdg001
            AND bgdg002 = g_bgdg_m.bgdg002
            AND bgdg003 = g_bgdg_m.bgdg003
            AND bgdg004 = l_i
            AND bgdg005 = l_bgcj009
            
         IF l_n > 0 THEN 
            IF g_bgdg_m.d = 'Y' THEN 
               DELETE FROM bgdg_t
                WHERE bgdgent = g_enterprise
                  AND bgdg001 = g_bgdg_m.bgdg001
                  AND bgdg002 = g_bgdg_m.bgdg002
                  AND bgdg003 = g_bgdg_m.bgdg003
                  AND bgdg004 = l_i
                  AND bgdg005 = l_bgcj009 
            ELSE
               CONTINUE FOR
            END IF
         END IF
      
         #第一期期初库存(A)到abgt420抓
         IF l_i = 1 THEN 
            LET l_bgdg.bgdg008 = 0
            SELECT bgde007 INTO l_bgdg.bgdg008
              FROM bgde_t
             WHERE bgdeent = g_enterprise
               AND bgde001 = g_bgdg_m.bgdg001
               AND bgde002 = g_bgdg_m.bgdg003
               AND bgde004 = l_bgcj009
            IF cl_null(l_bgdg.bgdg008) THEN 
               LET l_bgdg.bgdg008 = 0
            END IF
         ELSE
            #从第二期开始,期初库存给上期的期末库存
            LET l_bgdg.bgdg008 = l_bgdg016_o
         END IF
         
         #无条件进位
         LET l_bgdg.bgdg008 = s_num_round('4',l_bgdg.bgdg008,0)
         
         #安全存量/生产提前比率
         LET l_bgea028 = ''     LET l_bgea029 = ''
         SELECT bgea028,bgea029 INTO l_bgea028,l_bgea029
           FROM bgea_t
          WHERE bgeaent = g_enterprise
            AND bgea001 = g_bgdg_m.bgdg001
            AND bgea002 = g_bgdg_m.bgdg003
            AND bgea003 = l_bgcj009
            
         IF cl_null(l_bgea028) THEN LET l_bgea028 = 0 END IF
         IF cl_null(l_bgea029) THEN LET l_bgea029 = 0 END IF

         #期末库存量(B)bgdg016
         #等于期初库存量
         IF g_bgdg_m.b = '1' THEN 
            LET l_bgdg.bgdg016 = l_bgdg.bgdg008
         END IF
         
         #指定库存量
         IF g_bgdg_m.b = '2' THEN 
            LET l_bgdg.bgdg016 = g_bgdg_m.qty
         END IF
         
         #考虑安全存量
         IF g_bgdg_m.c = 'Y' THEN    
            IF l_bgdg.bgdg016 < l_bgea028 THEN 
               LET l_bgdg.bgdg016 = l_bgea028
            END IF
         END IF
         
         #无条件进位
         LET l_bgdg.bgdg016 = s_num_round('4',l_bgdg.bgdg016,0)
         
         #當期銷售當期成產量(C)bgdg009
         LET l_bgcj045 = 0
         SELECT SUM(bgcj045) INTO l_bgcj045
           FROM bgcj_t
          WHERE bgcjent = g_enterprise
            AND bgcj001 = '20'
            AND bgcjstus = 'FC'
            AND bgcj002 = g_bgdg_m.bgdg001
            AND bgcj003 = g_bgdg_m.bgdg002
            AND bgcj007 = g_bgdg_m.bgdg003
            AND bgcj008 = l_i
            AND bgcj009 = l_bgcj009
         IF cl_null(l_bgcj045) THEN 
            LET l_bgcj045 = 0
         END IF
         
         #當期銷售預算量
         LET l_bgdg.bgdg017 = l_bgcj045      #161225-00005#2 add lujh
 
         LET l_bgdg.bgdg009 = l_bgcj045 * (1-l_bgea029/100)
         
         #无条件进位
         LET l_bgdg.bgdg009 = s_num_round('4',l_bgdg.bgdg009,0)
         
         #生产提前量(D)bgdg010
         #下期销量
         LET l_bgcj045_n = 0
         SELECT SUM(bgcj045) INTO l_bgcj045_n
           FROM bgcj_t
          WHERE bgcjent = g_enterprise
            AND bgcj001 = '20'
            AND bgcjstus = 'FC'
            AND bgcj002 = g_bgdg_m.bgdg001
            AND bgcj003 = g_bgdg_m.bgdg002
            AND bgcj007 = g_bgdg_m.bgdg003
            AND bgcj008 = l_i + 1
            AND bgcj009 = l_bgcj009   

         IF cl_null(l_bgcj045_n) THEN 
            LET l_bgcj045_n = 0
         END IF
         
         #161129-00019#1--add--str--lujh
         #最后一起提前选项:2.按最后一起产生量计算
         IF g_bgdg_m.e = '2' AND l_i = l_bgac004 THEN 
            LET l_bgcj045_n = l_bgcj045
         END IF
         #161129-00019#1--add--end--lujh
         
         LET l_bgdg.bgdg010 = l_bgcj045_n * l_bgea029/100
         
         #无条件进位
         LET l_bgdg.bgdg010 = s_num_round('4',l_bgdg.bgdg010,0)
         
         #参考生产量(E)bgdg011
         #生产同步型
         IF g_bgdg_m.a = '1' THEN 
            #參考生產數量(E)   = 銷售量(C+D) - 期初庫存(A) +　期末庫存 (B)
            LET l_bgdg.bgdg011 = l_bgdg.bgdg009 + l_bgdg.bgdg010 - l_bgdg.bgdg008 + l_bgdg.bgdg016
         END IF
         
         #均衡生产型
         IF g_bgdg_m.a = '2' THEN 
            LET l_bgdg.bgdg009 = l_bgcj045 
         
            #无条件进位
            LET l_bgdg.bgdg009 = s_num_round('4',l_bgdg.bgdg009,0)
         
            LET l_bgdg.bgdg010 = 0
            
            #取出全年銷售量預算(abgt340) 
            SELECT SUM(bgcj045) INTO l_bgcj045_y
              FROM bgcj_t
             WHERE bgcjent = g_enterprise
               AND bgcj001 = '20'
               AND bgcjstus = 'FC'
               AND bgcj002 = g_bgdg_m.bgdg001
               AND bgcj003 = g_bgdg_m.bgdg002
               AND bgcj007 = g_bgdg_m.bgdg003
               AND bgcj008 BETWEEN 1 AND l_bgac004
               AND bgcj009 = l_bgcj009
               
            IF cl_null(l_bgcj045_y) THEN 
               LET l_bgcj045_y = 0
            END IF
               
            #全年銷售量預算/剩餘期別 (由abgi030週期取出有幾期12 or 13 )   
            LET l_bgdg.bgdg011 = (l_bgcj045_y - l_bgdg011_t)/ (l_bgac004 - l_i + 1) 
            
            #參考生產量(E) + 該期的期初庫存(A)   < 銷售量(C) + 提前至本期銷量(D)
            IF l_bgdg.bgdg011 + l_bgdg.bgdg008 < l_bgdg.bgdg009 + l_bgdg.bgdg010 THEN 
               #參考生產量(E) = 銷售量(C) + 提前至本期銷量(D) - 期初庫存量(A)   + 期未庫存(B)
               LET l_bgdg.bgdg011 = l_bgdg.bgdg009 + l_bgdg.bgdg010 - l_bgdg.bgdg008 + l_bgdg.bgdg016
            END IF
            
            LET l_bgdg011_t = l_bgdg.bgdg011 + l_bgdg011_t
         END IF
         
         #无条件进位
         LET l_bgdg.bgdg011 = s_num_round('4',l_bgdg.bgdg011,0)
         
         #重新推算期末庫存(B)  = 期初庫存(A) + 參考生產數量(E)　- 本期銷售量(C)
         LET l_bgdg.bgdg016 = l_bgdg.bgdg008 + l_bgdg.bgdg011 - l_bgcj045
         
         #无条件进位
         LET l_bgdg.bgdg016 = s_num_round('4',l_bgdg.bgdg016,0)
         
         LET l_bgdg016_o = l_bgdg.bgdg016
         
         LET l_bgdg.bgdgent = g_enterprise
         LET l_bgdg.bgdg001 = g_bgdg_m.bgdg001
         LET l_bgdg.bgdg002 = g_bgdg_m.bgdg002
         LET l_bgdg.bgdg003 = g_bgdg_m.bgdg003
         LET l_bgdg.bgdg004 = l_i
         LET l_bgdg.bgdg005 = l_bgcj009
         LET l_bgdg.bgdg006 = '1'
         SELECT bgea025 INTO l_bgdg.bgdg007
           FROM bgea_t
          WHERE bgeaent = g_enterprise
            AND bgea001 = g_bgdg_m.bgdg001
            AND bgea002 = g_bgdg_m.bgdg003
            AND bgea003 = l_bgcj009
            
         LET l_bgdg.bgdg012 = 0
         LET l_bgdg.bgdg013 = 0
         LET l_bgdg.bgdg014 = 0
         LET l_bgdg.bgdg015 = l_bgdg.bgdg011
         
         LET l_bgdg.bgdgownid = g_user
         LET l_bgdg.bgdgowndp = g_dept
         LET l_bgdg.bgdgcrtid = g_user
         LET l_bgdg.bgdgcrtdp = g_dept 
         LET l_bgdg.bgdgcrtdt = cl_get_current()
         LET l_bgdg.bgdgmodid = g_user
         LET l_bgdg.bgdgmoddt = cl_get_current()
         LET l_bgdg.bgdgstus = 'N'
         
         INSERT INTO bgdg_t(bgdgent,
                            bgdg001,bgdg002,bgdg003,bgdg004,
                            bgdg005,bgdg006,bgdg007,bgdg008,
                            bgdg009,bgdg010,bgdg011,bgdg012,
                            bgdg013,bgdg014,bgdg015,bgdg016,
                            bgdg017,                              #161225-00005#2 add lujh
                            bgdgownid,bgdgowndp,bgdgcrtid,bgdgcrtdp,
                            bgdgcrtdt,bgdgmodid,bgdgmoddt,bgdgstus)
         VALUES(l_bgdg.bgdgent,
                l_bgdg.bgdg001,l_bgdg.bgdg002,l_bgdg.bgdg003,l_bgdg.bgdg004,
                l_bgdg.bgdg005,l_bgdg.bgdg006,l_bgdg.bgdg007,l_bgdg.bgdg008,
                l_bgdg.bgdg009,l_bgdg.bgdg010,l_bgdg.bgdg011,l_bgdg.bgdg012,
                l_bgdg.bgdg013,l_bgdg.bgdg014,l_bgdg.bgdg015,l_bgdg.bgdg016,
                l_bgdg.bgdg017,                                   #161225-00005#2 add lujh
                l_bgdg.bgdgownid,l_bgdg.bgdgowndp,l_bgdg.bgdgcrtid,l_bgdg.bgdgcrtdp,
                l_bgdg.bgdgcrtdt,l_bgdg.bgdgmodid,l_bgdg.bgdgmoddt,l_bgdg.bgdgstus)
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins bgdg_t'
            LET g_errparam.code   = sqlca.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF
         
         LET r_flag = 'Y'
      END FOR
   END FOREACH
   
   RETURN r_success,r_flag
END FUNCTION

 
{</section>}
 
