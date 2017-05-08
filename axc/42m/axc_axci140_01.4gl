#該程式未解開Section, 採用最新樣板產出!
{<section id="axci140_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2014-06-29 23:39:14), PR版次:0005(2016-10-24 16:38:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000120
#+ Filename...: axci140_01
#+ Description: 整批複製
#+ Creator....: 02114(2014-02-26 23:14:44)
#+ Modifier...: 02114 -SD/PR- 05423
 
{</section>}
 
{<section id="axci140_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#46  2016/04/28   By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#161019-00017#7   2016/10/19   By zhujing 据点组织开窗资料整批调整
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
PRIVATE type type_g_xcbe_m        RECORD
       xcbesite LIKE xcbe_t.xcbesite, 
   xcbesite_desc LIKE type_t.chr80, 
   xcbe001 LIKE xcbe_t.xcbe001, 
   xcbe002 LIKE xcbe_t.xcbe002, 
   xcbesite_2 LIKE type_t.chr10, 
   xcbesite_2_desc LIKE type_t.chr80, 
   xcbe001_2 LIKE type_t.num5, 
   xcbe002_2 LIKE type_t.num5
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sql      STRING
#end add-point
 
DEFINE g_xcbe_m        type_g_xcbe_m
 
   DEFINE g_xcbesite_t LIKE xcbe_t.xcbesite
DEFINE g_xcbe001_t LIKE xcbe_t.xcbe001
DEFINE g_xcbe002_t LIKE xcbe_t.xcbe002
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axci140_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axci140_01(--)
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
   
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axci140_01 WITH FORM cl_ap_formpath("axc","axci140_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   INITIALIZE g_xcbe_m.* TO NULL
   LET g_errshow = 1
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xcbe_m.xcbesite,g_xcbe_m.xcbe001,g_xcbe_m.xcbe002,g_xcbe_m.xcbesite_2,g_xcbe_m.xcbe001_2, 
          g_xcbe_m.xcbe002_2 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbesite
            
            #add-point:AFTER FIELD xcbesite name="input.a.xcbesite"
            #此段落由子樣板a05產生
            CALL axci140_01_xcbesite_desc()
            IF NOT cl_null(g_xcbe_m.xcbesite) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcbe_m.xcbesite

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xcbesite") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL axci140_01_xcbesite_2_chk()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xcbe_m.xcbesite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xcbe_m.xcbesite = ''
                     CALL axci140_01_xcbesite_desc()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcbe_m.xcbesite = ''
                  CALL axci140_01_xcbesite_desc()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbesite
            #add-point:BEFORE FIELD xcbesite name="input.b.xcbesite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbesite
            #add-point:ON CHANGE xcbesite name="input.g.xcbesite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbe001
            #add-point:BEFORE FIELD xcbe001 name="input.b.xcbe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbe001
            
            #add-point:AFTER FIELD xcbe001 name="input.a.xcbe001"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_xcbe_m.xcbe001) THEN 
               IF g_xcbe_m.xcbe001 <1000 OR g_xcbe_m.xcbe001 >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_xcbe_m.xcbe001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xcbe_m.xcbe001 =''
                  NEXT FIELD xcbe001
               END IF
               CALL axci140_01_xcbesite_2_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xcbe_m.xcbe001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xcbe_m.xcbe001 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbe001
            #add-point:ON CHANGE xcbe001 name="input.g.xcbe001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbe002
            #add-point:BEFORE FIELD xcbe002 name="input.b.xcbe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbe002
            
            #add-point:AFTER FIELD xcbe002 name="input.a.xcbe002"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_xcbe_m.xcbe002) THEN 
               IF (g_xcbe_m.xcbe002 < 1) OR (g_xcbe_m.xcbe002 > 12) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = g_xcbe_m.xcbe002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xcbe_m.xcbe002 = ''
                  NEXT FIELD xcbe002
               END IF
               CALL axci140_01_xcbesite_2_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xcbe_m.xcbe002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xcbe_m.xcbe002 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbe002
            #add-point:ON CHANGE xcbe002 name="input.g.xcbe002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbesite_2
            
            #add-point:AFTER FIELD xcbesite_2 name="input.a.xcbesite_2"
            CALL axci140_01_xcbesite_desc()
            IF NOT cl_null(g_xcbe_m.xcbesite_2) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcbe_m.xcbesite_2

               #160318-00025#46  2016/04/28  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#46  2016/04/28  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001_11") THEN      #161019-00017#7 marked
               IF cl_chk_exist("v_ooef001_13") THEN       #161019-00017#7 add
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL axci140_01_xcbesite_2_get()
                  CALL axci140_01_xcbesite_2_chk()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_xcbe_m.xcbesite_2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xcbe_m.xcbesite_2 = ''
                     CALL axci140_01_xcbesite_desc()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcbe_m.xcbesite_2 = ''
                  CALL axci140_01_xcbesite_desc()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbesite_2
            #add-point:BEFORE FIELD xcbesite_2 name="input.b.xcbesite_2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbesite_2
            #add-point:ON CHANGE xcbesite_2 name="input.g.xcbesite_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbe001_2
            #add-point:BEFORE FIELD xcbe001_2 name="input.b.xcbe001_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbe001_2
            
            #add-point:AFTER FIELD xcbe001_2 name="input.a.xcbe001_2"
            IF NOT cl_null(g_xcbe_m.xcbe001_2) THEN 
               IF g_xcbe_m.xcbe001_2 <1000 OR g_xcbe_m.xcbe001_2 >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_xcbe_m.xcbe001_2
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xcbe_m.xcbe001_2 =''
                  NEXT FIELD xcbe001_2
               END IF
               CALL axci140_01_xcbesite_2_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xcbe_m.xcbe001_2
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xcbe_m.xcbe001_2 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbe001_2
            #add-point:ON CHANGE xcbe001_2 name="input.g.xcbe001_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbe002_2
            #add-point:BEFORE FIELD xcbe002_2 name="input.b.xcbe002_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbe002_2
            
            #add-point:AFTER FIELD xcbe002_2 name="input.a.xcbe002_2"
            IF NOT cl_null(g_xcbe_m.xcbe002_2) THEN 
               IF (g_xcbe_m.xcbe002_2 < 1) OR (g_xcbe_m.xcbe002_2 > 12) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = g_xcbe_m.xcbe002_2
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xcbe_m.xcbe002_2 = ''
                  NEXT FIELD xcbe002_2
               END IF
               CALL axci140_01_xcbesite_2_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xcbe_m.xcbe002_2
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xcbe_m.xcbe002_2 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbe002_2
            #add-point:ON CHANGE xcbe002_2 name="input.g.xcbe002_2"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcbesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbesite
            #add-point:ON ACTION controlp INFIELD xcbesite name="input.c.xcbesite"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbe_m.xcbesite             #給予default值

            #給予arg

            CALL q_xcbesite()                                #呼叫開窗

            LET g_xcbe_m.xcbesite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xcbe_m.xcbesite TO xcbesite              #顯示到畫面上
            CALL axci140_01_xcbesite_desc()
            NEXT FIELD xcbesite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcbe001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbe001
            #add-point:ON ACTION controlp INFIELD xcbe001 name="input.c.xcbe001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbe002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbe002
            #add-point:ON ACTION controlp INFIELD xcbe002 name="input.c.xcbe002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbesite_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbesite_2
            #add-point:ON ACTION controlp INFIELD xcbesite_2 name="input.c.xcbesite_2"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbe_m.xcbesite_2             #給予default值
#            LET g_qryparam.where = " (ooef003 = 'Y' OR ooef201 = 'Y' OR ooef204 = 'Y')"     #161019-00017#7 marked
            #給予arg

#            CALL q_ooef001_10()                               #呼叫開窗    #161019-00017#7 marked
            CALL q_ooef001_1()                                 #呼叫開窗    #161019-00017#7 add
            #161019-00017#7
            LET g_xcbe_m.xcbesite_2 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xcbe_m.xcbesite_2 TO xcbesite_2              #顯示到畫面上
            CALL axci140_01_xcbesite_desc()
            NEXT FIELD xcbesite_2                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcbe001_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbe001_2
            #add-point:ON ACTION controlp INFIELD xcbe001_2 name="input.c.xcbe001_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbe002_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbe002_2
            #add-point:ON ACTION controlp INFIELD xcbe002_2 name="input.c.xcbe002_2"
            
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
   CLOSE WINDOW w_axci140_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      RETURN 
   END IF
   
   CALL axci140_01_xcbe_ins()
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axci140_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axci140_01.other_function" readonly="Y" >}
# 插入xcbe_t在制約當量設定檔
PRIVATE FUNCTION axci140_01_xcbe_ins()
   DEFINE l_xcbe003       LIKE xcbe_t.xcbe003
   DEFINE l_xcbe004       LIKE xcbe_t.xcbe004
   DEFINE l_xcbe005       LIKE xcbe_t.xcbe005
   DEFINE l_xcbe006       LIKE xcbe_t.xcbe006
   DEFINE l_xcbeownid     LIKE xcbe_t.xcbeownid
   DEFINE l_xcbeowndp     LIKE xcbe_t.xcbeowndp
   DEFINE l_xcbecrtid     LIKE xcbe_t.xcbecrtid 
   DEFINE l_xcbecrtdp     LIKE xcbe_t.xcbecrtdp
   DEFINE l_xcbecrtdt     LIKE xcbe_t.xcbecrtdt
   DEFINE l_xcbemodid     LIKE xcbe_t.xcbemodid
   DEFINE l_xcbemoddt     LIKE xcbe_t.xcbemoddt 
   DEFINE l_n             LIKE type_t.num5
   
   
   CALL s_transaction_begin()
   CALL cl_showmsg_init()
   LET g_success = 'Y'
   
   LET g_sql = "SELECT xcbe003,xcbe004,xcbe005,xcbe006 ",
               "  FROM xcbe_t ",
               " WHERE xcbeent = '",g_enterprise,"'",
               "   AND xcbesite = '",g_xcbe_m.xcbesite,"'",
               "   AND xcbe001 = '",g_xcbe_m.xcbe001,"'",
               "   AND xcbe002 = '",g_xcbe_m.xcbe002,"'",
               " ORDER BY xcbe003 "
               
   PREPARE axci140_01_pre FROM g_sql
   DECLARE axci140_01_cure CURSOR FOR axci140_01_pre
   FOREACH axci140_01_cure INTO l_xcbe003,l_xcbe004,l_xcbe005,l_xcbe006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_xcbeownid = g_user
      LET l_xcbeowndp = g_dept
      LET l_xcbecrtid = g_user
      LET l_xcbecrtdp = g_dept 
      LET l_xcbecrtdt = cl_get_current()
      LET l_xcbemodid = ""
      LET l_xcbemoddt = ""
      
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM xcbe_t
       WHERE xcbeent = g_enterprise
         AND xcbesite = g_xcbe_m.xcbesite_2
         AND xcbe001 = g_xcbe_m.xcbe001_2
         AND xcbe002 = g_xcbe_m.xcbe002_2
         AND xcbe003 = l_xcbe003
         AND xcbe004 = l_xcbe004
         
      IF l_n > 0 THEN 
         CONTINUE FOREACH
      END IF
      
      #目的營運據點不存在製程料號，則不插入
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n
        FROM ecba_t
       WHERE ecbaent = g_enterprise
         AND ecbasite = g_xcbe_m.xcbesite_2
         AND ecba001 = l_xcbe003
         AND ecba002 = l_xcbe004
         
      IF l_n = 0 THEN  
         CALL cl_errmsg('',l_xcbe003,'','axc-00283',1)
         CONTINUE FOREACH
      END IF
      
      INSERT INTO xcbe_t(xcbeent,xcbesite,xcbe001,xcbe002,xcbe003,xcbe004,xcbe005,xcbe006,xcbestus,
                         xcbeownid,xcbeowndp,xcbecrtid,xcbecrtdp,xcbecrtdt,xcbemodid,xcbemoddt)
                  VALUES(g_enterprise,g_xcbe_m.xcbesite_2,g_xcbe_m.xcbe001_2,g_xcbe_m.xcbe002_2,
                         l_xcbe003,l_xcbe004,l_xcbe005,l_xcbe006,'Y',l_xcbeownid,l_xcbeowndp,l_xcbecrtid,
                         l_xcbecrtdp,l_xcbecrtdt,l_xcbemodid,l_xcbemoddt)
                         
      IF SQLCA.SQLcode  THEN
         LET g_success = 'N'
      ELSE
         LET g_success = 'Y'
      END IF
   END FOREACH 
   
   IF g_success = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "xcbe_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      CALL s_transaction_end('N','1') 
   ELSE
      CALL s_transaction_end('Y','1')
   END IF
   CALL cl_err_showmsg()
END FUNCTION
# 參考欄位帶值
PRIVATE FUNCTION axci140_01_xcbesite_desc()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcbe_m.xcbesite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcbe_m.xcbesite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcbe_m.xcbesite_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcbe_m.xcbesite_2
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcbe_m.xcbesite_2_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcbe_m.xcbesite_2_desc
END FUNCTION
# 抓取現行年度/期別
PRIVATE FUNCTION axci140_01_xcbesite_2_get()
   DEFINE l_ooef017     LIKE ooef_t.ooef017

   CALL cl_get_para(g_enterprise,g_xcbe_m.xcbesite_2,'S-FIN-6010') RETURNING g_xcbe_m.xcbe001_2
   CALL cl_get_para(g_enterprise,g_xcbe_m.xcbesite_2,'S-FIN-6011') RETURNING g_xcbe_m.xcbe002_2

   DISPLAY g_xcbe_m.xcbe001_2 TO xcbe001_2
   DISPLAY g_xcbe_m.xcbe002_2 TO xcbe002_2
END FUNCTION
# 目的营运据点+目的年度/期别　不能等于　来源营运据点+来源年度/期别
PRIVATE FUNCTION axci140_01_xcbesite_2_chk()
   
   LET g_errno = ''
   
   IF NOT cl_null(g_xcbe_m.xcbesite) AND NOT cl_null(g_xcbe_m.xcbe001) AND NOT cl_null(g_xcbe_m.xcbe002) AND
      NOT cl_null(g_xcbe_m.xcbesite_2) AND NOT cl_null(g_xcbe_m.xcbe001_2) AND NOT cl_null(g_xcbe_m.xcbe002_2)
      THEN 
      IF g_xcbe_m.xcbesite = g_xcbe_m.xcbesite_2 AND g_xcbe_m.xcbe001 = g_xcbe_m.xcbe001_2 AND g_xcbe_m.xcbe002 = g_xcbe_m.xcbe002_2 THEN 
         LET g_errno = 'axc-00111'
      END IF
   END IF
END FUNCTION

 
{</section>}
 
