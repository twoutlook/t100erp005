#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi420_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2013-07-23 11:18:20), PR版次:0002(2016-09-05 16:30:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000134
#+ Filename...: aooi420_02
#+ Description: 時數整批更新
#+ Creator....: 01258(2013-08-16 10:54:05)
#+ Modifier...: 01996 -SD/PR- 01531
 
{</section>}
 
{<section id="aooi420_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160905-00007#9   2016/09/05 By 01531    调整系统中无ENT的SQL条件增加ent
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
PRIVATE type type_g_oogc_m        RECORD
       oogc001 LIKE oogc_t.oogc001, 
   oogc001_desc LIKE type_t.chr80, 
   oogc002 LIKE oogc_t.oogc002, 
   bdate LIKE type_t.dat, 
   edate LIKE type_t.dat, 
   hours LIKE type_t.num15_3
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_oogc_m_t        type_g_oogc_m
#end add-point
 
DEFINE g_oogc_m        type_g_oogc_m
 
   DEFINE g_oogc001_t LIKE oogc_t.oogc001
DEFINE g_oogc002_t LIKE oogc_t.oogc002
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aooi420_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aooi420_02(--)
   #add-point:input段變數傳入 name="input.get_var"
p_oogc001,p_oogc002
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
   DEFINE l_date_first          LIKE type_t.dat
   DEFINE l_date_last           LIKE type_t.dat
   DEFINE l_year                  LIKE type_t.chr10
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_sql1          STRING
   DEFINE l_success       LIKE type_t.chr1
   DEFINE p_oogc001       LIKE oogc_t.oogc001
   DEFINE p_oogc002       LIKE oogc_t.oogc002
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi420_02 WITH FORM cl_ap_formpath("aoo","aooi420_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('oogc002','25')
   LET g_oogc_m.oogc001 = p_oogc001
   LET g_oogc_m.oogc002 = p_oogc002
   DISPLAY BY NAME g_oogc_m.oogc001,g_oogc_m.oogc002
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_oogc_m.oogc001,g_oogc_m.oogc002,g_oogc_m.bdate,g_oogc_m.edate,g_oogc_m.hours ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET l_year = YEAR(g_today) + 1
            LET g_oogc_m.bdate = MDY(1,1,l_year)
            LET g_oogc_m.edate = MDY(12,31,l_year)
            DISPLAY BY NAME g_oogc_m.bdate,g_oogc_m.edate
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogc001
            
            #add-point:AFTER FIELD oogc001 name="input.a.oogc001"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_oogc_m.oogc001) THEN 
               LET l_n = 0
                SELECT COUNT(*) INTO l_n FROM ooal_t
                 WHERE ooalent = g_enterprise
                   AND ooal002 = g_oogc_m.oogc001
                   AND ooal001 = 4
                IF l_n = 0 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'agl-00007'
                   LET g_errparam.extend = g_oogc_m.oogc001
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   LET g_oogc_m.oogc001 = ''
                   DISPLAY BY NAME g_oogc_m.oogc001
                   NEXT FIELD CURRENT
                END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oogc_m.oogc001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oogc_m.oogc001_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oogc_m.oogc001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogc001
            #add-point:BEFORE FIELD oogc001 name="input.b.oogc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oogc001
            #add-point:ON CHANGE oogc001 name="input.g.oogc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oogc002
            #add-point:BEFORE FIELD oogc002 name="input.b.oogc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oogc002
            
            #add-point:AFTER FIELD oogc002 name="input.a.oogc002"
            #此段落由子樣板a05產生
            



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oogc002
            #add-point:ON CHANGE oogc002 name="input.g.oogc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bdate
            #add-point:BEFORE FIELD bdate name="input.b.bdate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bdate
            
            #add-point:AFTER FIELD bdate name="input.a.bdate"
            IF NOT cl_null(g_oogc_m.bdate) AND NOT cl_null(g_oogc_m.edate) THEN
               IF g_oogc_m.bdate > g_oogc_m.edate THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'sub-00095'
                   LET g_errparam.extend = g_oogc_m.bdate
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   NEXT FIELD bdate
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bdate
            #add-point:ON CHANGE bdate name="input.g.bdate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate
            #add-point:BEFORE FIELD edate name="input.b.edate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate
            
            #add-point:AFTER FIELD edate name="input.a.edate"
            IF NOT cl_null(g_oogc_m.bdate) AND NOT cl_null(g_oogc_m.edate) THEN
                IF g_oogc_m.bdate > g_oogc_m.edate THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'sub-00095'
                    LET g_errparam.extend = g_oogc_m.edate
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    NEXT FIELD edate
                END IF
             END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate
            #add-point:ON CHANGE edate name="input.g.edate"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD hours
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_oogc_m.hours,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD hours
            END IF 
 
 
 
            #add-point:AFTER FIELD hours name="input.a.hours"
            IF NOT cl_null(g_oogc_m.hours) AND g_oogc_m.hours < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aim-00003'
               LET g_errparam.extend = g_oogc_m.hours
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_oogc_m.hours = ''
               DISPLAY BY NAME g_oogc_m.hours
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD hours
            #add-point:BEFORE FIELD hours name="input.b.hours"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE hours
            #add-point:ON CHANGE hours name="input.g.hours"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.oogc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogc001
            #add-point:ON ACTION controlp INFIELD oogc001 name="input.c.oogc001"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_oogc_m.oogc001             #給予default值

            #給予arg
            LET g_qryparam.where = " ooal001 = '4'"

            CALL q_ooal002()                                #呼叫開窗
            INITIALIZE g_qryparam.where TO null
            LET g_oogc_m.oogc001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oogc_m.oogc001 TO oogc001              #顯示到畫面上

            NEXT FIELD oogc001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.oogc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oogc002
            #add-point:ON ACTION controlp INFIELD oogc002 name="input.c.oogc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.bdate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bdate
            #add-point:ON ACTION controlp INFIELD bdate name="input.c.bdate"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate
            #add-point:ON ACTION controlp INFIELD edate name="input.c.edate"
            
            #END add-point
 
 
         #Ctrlp:input.c.hours
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD hours
            #add-point:ON ACTION controlp INFIELD hours name="input.c.hours"
            
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
   CLOSE WINDOW w_aooi420_02 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      CALL s_transaction_begin()
      UPDATE oogc_t SET oogc004 = g_oogc_m.hours
                  WHERE oogc001 = g_oogc_m.oogc001
                    AND oogc002 = g_oogc_m.oogc002
                    AND oogc003 BETWEEN g_oogc_m.bdate AND g_oogc_m.edate
                    AND oogcent = g_enterprise  #160905-00007#9  add
      IF SQLCA.SQLCODE THEN
         LET l_success = 'N'
      ELSE
         LET l_success = 'Y'
      END IF
      CALL s_transaction_end(l_success,'1')
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aooi420_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aooi420_02.other_function" readonly="Y" >}

 
{</section>}
 
