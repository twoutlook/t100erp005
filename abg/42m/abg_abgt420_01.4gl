#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt420_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-11-17 11:21:58), PR版次:0001(2016-12-13 15:03:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgt420_01
#+ Description: 匯入資料
#+ Creator....: 02114(2016-11-17 11:20:26)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="abgt420_01.global" >}
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
PRIVATE type type_g_bgde_m        RECORD
       bgde001 LIKE bgde_t.bgde001, 
   bgde001_desc LIKE type_t.chr80, 
   bgde002 LIKE bgde_t.bgde002, 
   bgde002_desc LIKE type_t.chr80, 
   type LIKE type_t.chr500, 
   bgde005 LIKE bgde_t.bgde005, 
   a LIKE type_t.chr500, 
   b LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_str           STRING
#end add-point
 
DEFINE g_bgde_m        type_g_bgde_m
 
   DEFINE g_bgde001_t LIKE bgde_t.bgde001
DEFINE g_bgde002_t LIKE bgde_t.bgde002
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgt420_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgt420_01(--)
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
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_success       LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgt420_01 WITH FORM cl_ap_formpath("abg","abgt420_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_bgde_m.type = '1'
   LET g_bgde_m.a = 'Y'
   LET g_bgde_m.b = 'Y'
   LET g_errshow = 1
   LET g_bgde_m.bgde001 = ''
   LET g_bgde_m.bgde002 = ''
   LET g_site_str = ''
   CALL cl_set_combo_scc('type','8964')
   CALL abgt420_01_create_tmp() RETURNING l_success
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_bgde_m.bgde001,g_bgde_m.bgde002,g_bgde_m.type,g_bgde_m.bgde005,g_bgde_m.a,g_bgde_m.b  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgde001
            
            #add-point:AFTER FIELD bgde001 name="input.a.bgde001"
            IF NOT cl_null(g_bgde_m.bgde001) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bgde_m.bgde001

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_bgaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_bgde_m.bgde001 = ''
                  CALL abgt420_01_bgde001_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL abgt420_01_bgde001_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgde001
            #add-point:BEFORE FIELD bgde001 name="input.b.bgde001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgde001
            #add-point:ON CHANGE bgde001 name="input.g.bgde001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgde002
            
            #add-point:AFTER FIELD bgde002 name="input.a.bgde002"
            IF NOT cl_null(g_bgde_m.bgde002) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_bgde_m.bgde002
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_24") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL s_abg2_get_budget_site(g_bgde_m.bgde001,'',g_user,'02') RETURNING g_site_str
                  IF cl_null(g_site_str) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00248'
                     LET g_errparam.extend = g_bgde_m.bgde002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgde_m.bgde002 = ''
                     CALL s_desc_get_department_desc(g_bgde_m.bgde002) RETURNING g_bgde_m.bgde002_desc
                     DISPLAY BY NAME g_bgde_m.bgde002_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢查預算組織是否在abgi090中可操作的組織中
                  IF s_chr_get_index_of(g_site_str,g_bgde_m.bgde002,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00247'
                     LET g_errparam.extend = g_bgde_m.bgde002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgde_m.bgde002 = ''
                     CALL s_desc_get_department_desc(g_bgde_m.bgde002) RETURNING g_bgde_m.bgde002_desc
                     DISPLAY BY NAME g_bgde_m.bgde002_desc
                     NEXT FIELD CURRENT
                  END IF
                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_bgde_m.bgde002 = ''
                  CALL s_desc_get_department_desc(g_bgde_m.bgde002) RETURNING g_bgde_m.bgde002_desc
                  DISPLAY BY NAME g_bgde_m.bgde002_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_bgde_m.bgde002) RETURNING g_bgde_m.bgde002_desc
            DISPLAY BY NAME g_bgde_m.bgde002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgde002
            #add-point:BEFORE FIELD bgde002 name="input.b.bgde002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgde002
            #add-point:ON CHANGE bgde002 name="input.g.bgde002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD type
            #add-point:BEFORE FIELD type name="input.b.type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD type
            
            #add-point:AFTER FIELD type name="input.a.type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE type
            #add-point:ON CHANGE type name="input.g.type"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgde005
            #add-point:BEFORE FIELD bgde005 name="input.b.bgde005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgde005
            
            #add-point:AFTER FIELD bgde005 name="input.a.bgde005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgde005
            #add-point:ON CHANGE bgde005 name="input.g.bgde005"
            
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
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgde001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgde001
            #add-point:ON ACTION controlp INFIELD bgde001 name="input.c.bgde001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgde_m.bgde001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgaa001()                                #呼叫開窗
 
            LET g_bgde_m.bgde001 = g_qryparam.return1              
            CALL abgt420_01_bgde001_desc()
            DISPLAY g_bgde_m.bgde001 TO bgde001              #

            NEXT FIELD bgde001                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgde002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgde002
            #add-point:ON ACTION controlp INFIELD bgde002 name="input.c.bgde002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_bgde_m.bgde002             #給予default值
            
            #檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_bgde_m.bgde001,'',g_user,'02') RETURNING g_site_str
            CALL s_fin_get_wc_str(g_site_str) RETURNING g_site_str
            IF NOT cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = g_qryparam.where,
                                      " AND ooef001 IN ",g_site_str
            ELSE
               LET g_qryparam.where = " ooef001 IN ",g_site_str
            END IF
            
            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooef001_77()                                #呼叫開窗
 
            LET g_bgde_m.bgde002 = g_qryparam.return1              
            CALL s_desc_get_department_desc(g_bgde_m.bgde002) RETURNING g_bgde_m.bgde002_desc
            DISPLAY g_bgde_m.bgde002 TO bgde002              #

            NEXT FIELD bgde002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD type
            #add-point:ON ACTION controlp INFIELD type name="input.c.type"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgde005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgde005
            #add-point:ON ACTION controlp INFIELD bgde005 name="input.c.bgde005"
            
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
   CLOSE WINDOW w_abgt420_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN '',''
   END IF
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   CALL abgt420_01_ins() RETURNING l_success,l_flag
   
   DROP TABLE abgt420_tmp01;
   DROP TABLE abgt420_tmp02;
   
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
         RETURN '',''
      ELSE
         CALL s_transaction_end('Y','1')
         CALL cl_err_collect_show()
         RETURN g_bgde_m.bgde001,g_site_str
      END IF
   ELSE
      CALL s_transaction_end('N','1')
      CALL cl_err_collect_show()
      RETURN '',''
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgt420_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgt420_01.other_function" readonly="Y" >}
# 预算编号说明
PRIVATE FUNCTION abgt420_01_bgde001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bgde_m.bgde001
   CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent="||g_enterprise||" AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bgde_m.bgde001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_bgde_m.bgde001_desc
END FUNCTION
# 创建临时表
PRIVATE FUNCTION abgt420_01_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE abgt420_tmp01;
   CREATE TEMP TABLE abgt420_tmp01(
   master       VARCHAR(40),
   child        VARCHAR(40),
   bmba011      DECIMAL(20,6),
   bmba012      DECIMAL(20,6),
   qty          DECIMAL(20,6),
   lvl          INTEGER
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DROP TABLE abgt420_tmp02;
   CREATE TEMP TABLE abgt420_tmp02(
   bgdf003           VARCHAR(40), 
   bgdf007           DECIMAL(20,6),
   bgdf902a          DECIMAL(20,6),
   bgdf902b          DECIMAL(20,6),
   bgdf902c          DECIMAL(20,6),
   bgdf902d          DECIMAL(20,6),
   bgdf902e          DECIMAL(20,6),
   bgdf902f          DECIMAL(20,6),
   bgdf902g          DECIMAL(20,6),
   bgdf902h          DECIMAL(20,6)
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# 產生bgdf檔
PRIVATE FUNCTION abgt420_01_ins()
   DEFINE l_sql                STRING
   DEFINE l_glaa               RECORD LIKE glaa_t.*
   DEFINE l_comp               LIKE glaa_t.glaacomp
   DEFINE l_year               STRING
   DEFINE l_month              STRING
   DEFINE l_bgde005            STRING
   DEFINE l_bgde002            LIKE bgde_t.bgde002
   DEFINE l_imae037            LIKE imae_t.imae037
   DEFINE l_bmaasite           LIKE bmaa_t.bmaasite 
   DEFINE l_bmaa001            LIKE bmaa_t.bmaa001
   DEFINE l_bmaa002            LIKE bmaa_t.bmaa002
   DEFINE l_bgea025            LIKE bgea_t.bgea025
   DEFINE l_bgde008            LIKE bgde_t.bgde008
   DEFINE l_n                  LIKE type_t.num5
   DEFINE l_n1                 LIKE type_t.num5
   DEFINE l_n2                 LIKE type_t.num5
   DEFINE l_y                  LIKE type_t.num5
   DEFINE l_qty                LIKE bmba_t.bmba011
   DEFINE l_xccc280a           LIKE xccc_t.xccc280a 
   DEFINE l_xccc280b           LIKE xccc_t.xccc280b
   DEFINE l_xccc280c           LIKE xccc_t.xccc280c
   DEFINE l_xccc280d           LIKE xccc_t.xccc280d
   DEFINE l_xccc280e           LIKE xccc_t.xccc280e
   DEFINE l_xccc280f           LIKE xccc_t.xccc280f
   DEFINE l_xccc280g           LIKE xccc_t.xccc280g
   DEFINE l_xccc280h           LIKE xccc_t.xccc280h
   DEFINE l_tmp                RECORD
                               xccc006          LIKE xccc_t.xccc006,
                               xccc901          LIKE xccc_t.xccc901,
                               xccc902a         LIKE xccc_t.xccc902a,
                               xccc902b         LIKE xccc_t.xccc902b,
                               xccc902c         LIKE xccc_t.xccc902c,
                               xccc902d         LIKE xccc_t.xccc902d,
                               xccc902e         LIKE xccc_t.xccc902e,
                               xccc902f         LIKE xccc_t.xccc902f,
                               xccc902g         LIKE xccc_t.xccc902g,
                               xccc902h         LIKE xccc_t.xccc902h
                               END RECORD
   DEFINE l_tmp1               RECORD
                               master           LIKE bmba_t.bmba001,
                               child            LIKE bmba_t.bmba003,
                               bmba011          LIKE bmba_t.bmba011,
                               bmba012          LIKE bmba_t.bmba012,
                               qty              LIKE bmba_t.bmba011,
                               level            LIKE type_t.num10   
                               END RECORD
   DEFINE l_tmp2               RECORD
                               bgdf003          LIKE bgdf_t.bgdf003, 
                               bgdf007_sum      LIKE bgdf_t.bgdf007,
                               bgdf902a_sum     LIKE bgdf_t.bgdf902a,
                               bgdf902b_sum     LIKE bgdf_t.bgdf902b,
                               bgdf902c_sum     LIKE bgdf_t.bgdf902c,
                               bgdf902d_sum     LIKE bgdf_t.bgdf902d,
                               bgdf902e_sum     LIKE bgdf_t.bgdf902e,
                               bgdf902f_sum     LIKE bgdf_t.bgdf902f,
                               bgdf902g_sum     LIKE bgdf_t.bgdf902g,
                               bgdf902h_sum     LIKE bgdf_t.bgdf902h
                               END RECORD
   DEFINE l_bgdf               RECORD  #预算期初實際料件库存档
                               bgdfent          LIKE bgdf_t.bgdfent, #企業編號
                               bgdf001          LIKE bgdf_t.bgdf001, #預算編號
                               bgdf002          LIKE bgdf_t.bgdf002, #預算組織
                               bgdf003          LIKE bgdf_t.bgdf003, #預算料號
                               bgdf004          LIKE bgdf_t.bgdf004, #實際料件
                               bgdf005          LIKE bgdf_t.bgdf005, #庫存單位
                               bgdf006          LIKE bgdf_t.bgdf006, #庫存年月
                               bgdf007          LIKE bgdf_t.bgdf007, #庫存數量
                               bgdf008          LIKE bgdf_t.bgdf008, #上階料件
                               bgdf009          LIKE bgdf_t.bgdf009, #單位轉換率
                               bgdf100          LIKE bgdf_t.bgdf100, #本位幣別
                               bgdf902a         LIKE bgdf_t.bgdf902a, #庫存成本-材料
                               bgdf902b         LIKE bgdf_t.bgdf902b, #庫存成本-人工
                               bgdf902c         LIKE bgdf_t.bgdf902c, #庫存成本-加工
                               bgdf902d         LIKE bgdf_t.bgdf902d, #庫存成本-制費一
                               bgdf902e         LIKE bgdf_t.bgdf902e, #庫存成本-制費二
                               bgdf902f         LIKE bgdf_t.bgdf902f, #庫存成本-制費三
                               bgdf902g         LIKE bgdf_t.bgdf902g, #庫存成本-制費四
                               bgdf902h         LIKE bgdf_t.bgdf902h, #庫存成本-制費五
                               bgdf902          LIKE bgdf_t.bgdf902, #庫存成本
                               bgdfud001        LIKE bgdf_t.bgdfud001, #自定義欄位(文字)001
                               bgdfud002        LIKE bgdf_t.bgdfud002, #自定義欄位(文字)002
                               bgdfud003        LIKE bgdf_t.bgdfud003, #自定義欄位(文字)003
                               bgdfud004        LIKE bgdf_t.bgdfud004, #自定義欄位(文字)004
                               bgdfud005        LIKE bgdf_t.bgdfud005, #自定義欄位(文字)005
                               bgdfud006        LIKE bgdf_t.bgdfud006, #自定義欄位(文字)006
                               bgdfud007        LIKE bgdf_t.bgdfud007, #自定義欄位(文字)007
                               bgdfud008        LIKE bgdf_t.bgdfud008, #自定義欄位(文字)008
                               bgdfud009        LIKE bgdf_t.bgdfud009, #自定義欄位(文字)009
                               bgdfud010        LIKE bgdf_t.bgdfud010, #自定義欄位(文字)010
                               bgdfud011        LIKE bgdf_t.bgdfud011, #自定義欄位(數字)011
                               bgdfud012        LIKE bgdf_t.bgdfud012, #自定義欄位(數字)012
                               bgdfud013        LIKE bgdf_t.bgdfud013, #自定義欄位(數字)013
                               bgdfud014        LIKE bgdf_t.bgdfud014, #自定義欄位(數字)014
                               bgdfud015        LIKE bgdf_t.bgdfud015, #自定義欄位(數字)015
                               bgdfud016        LIKE bgdf_t.bgdfud016, #自定義欄位(數字)016
                               bgdfud017        LIKE bgdf_t.bgdfud017, #自定義欄位(數字)017
                               bgdfud018        LIKE bgdf_t.bgdfud018, #自定義欄位(數字)018
                               bgdfud019        LIKE bgdf_t.bgdfud019, #自定義欄位(數字)019
                               bgdfud020        LIKE bgdf_t.bgdfud020, #自定義欄位(數字)020
                               bgdfud021        LIKE bgdf_t.bgdfud021, #自定義欄位(日期時間)021
                               bgdfud022        LIKE bgdf_t.bgdfud022, #自定義欄位(日期時間)022
                               bgdfud023        LIKE bgdf_t.bgdfud023, #自定義欄位(日期時間)023
                               bgdfud024        LIKE bgdf_t.bgdfud024, #自定義欄位(日期時間)024
                               bgdfud025        LIKE bgdf_t.bgdfud025, #自定義欄位(日期時間)025
                               bgdfud026        LIKE bgdf_t.bgdfud026, #自定義欄位(日期時間)026
                               bgdfud027        LIKE bgdf_t.bgdfud027, #自定義欄位(日期時間)027
                               bgdfud028        LIKE bgdf_t.bgdfud028, #自定義欄位(日期時間)028
                               bgdfud029        LIKE bgdf_t.bgdfud029, #自定義欄位(日期時間)029
                               bgdfud030        LIKE bgdf_t.bgdfud030  #自定義欄位(日期時間)030
                               END RECORD
   DEFINE l_bgde               RECORD  #預算期初庫存檔
                               bgdeent          LIKE bgde_t.bgdeent, #企業編號
                               bgdeownid        LIKE bgde_t.bgdeownid, #資料所有者
                               bgdeowndp        LIKE bgde_t.bgdeowndp, #資料所屬部門
                               bgdecrtid        LIKE bgde_t.bgdecrtid, #資料建立者
                               bgdecrtdp        LIKE bgde_t.bgdecrtdp, #資料建立部門
                               bgdecrtdt        LIKE bgde_t.bgdecrtdt, #資料創建日
                               bgdemodid        LIKE bgde_t.bgdemodid, #資料修改者
                               bgdemoddt        LIKE bgde_t.bgdemoddt, #最近修改日
                               bgdecnfid        LIKE bgde_t.bgdecnfid, #資料確認者
                               bgdecnfdt        LIKE bgde_t.bgdecnfdt, #資料確認日
                               bgdepstid        LIKE bgde_t.bgdepstid, #資料過帳者
                               bgdepstdt        LIKE bgde_t.bgdepstdt, #資料過帳日
                               bgdestus         LIKE bgde_t.bgdestus, #狀態碼
                               bgde001          LIKE bgde_t.bgde001, #預算編號
                               bgde002          LIKE bgde_t.bgde002, #預算組織
                               bgde003          LIKE bgde_t.bgde003, #資料來源
                               bgde004          LIKE bgde_t.bgde004, #預算料號
                               bgde005          LIKE bgde_t.bgde005, #庫存年月
                               bgde006          LIKE bgde_t.bgde006, #成本計算類型
                               bgde007          LIKE bgde_t.bgde007, #庫存數量
                               bgde008          LIKE bgde_t.bgde008, #庫存單位
                               bgde100          LIKE bgde_t.bgde100, #預算幣別
                               bgde101          LIKE bgde_t.bgde101, #汇率
                               bgde902a         LIKE bgde_t.bgde902a, #庫存成本-材料
                               bgde902b         LIKE bgde_t.bgde902b, #庫存成本-人工
                               bgde902c         LIKE bgde_t.bgde902c, #庫存成本-加工費
                               bgde902d         LIKE bgde_t.bgde902d, #庫存成本-制費一
                               bgde902e         LIKE bgde_t.bgde902e, #庫存成本-制費二
                               bgde902f         LIKE bgde_t.bgde902f, #庫存成本-制費三
                               bgde902g         LIKE bgde_t.bgde902g, #庫存成本-制費四
                               bgde902h         LIKE bgde_t.bgde902h, #庫存成本-制費五
                               bgde902          LIKE bgde_t.bgde902, #結存庫存成本
                               bgdeud001        LIKE bgde_t.bgdeud001, #自定義欄位(文字)001
                               bgdeud002        LIKE bgde_t.bgdeud002, #自定義欄位(文字)002
                               bgdeud003        LIKE bgde_t.bgdeud003, #自定義欄位(文字)003
                               bgdeud004        LIKE bgde_t.bgdeud004, #自定義欄位(文字)004
                               bgdeud005        LIKE bgde_t.bgdeud005, #自定義欄位(文字)005
                               bgdeud006        LIKE bgde_t.bgdeud006, #自定義欄位(文字)006
                               bgdeud007        LIKE bgde_t.bgdeud007, #自定義欄位(文字)007
                               bgdeud008        LIKE bgde_t.bgdeud008, #自定義欄位(文字)008
                               bgdeud009        LIKE bgde_t.bgdeud009, #自定義欄位(文字)009
                               bgdeud010        LIKE bgde_t.bgdeud010, #自定義欄位(文字)010
                               bgdeud011        LIKE bgde_t.bgdeud011, #自定義欄位(數字)011
                               bgdeud012        LIKE bgde_t.bgdeud012, #自定義欄位(數字)012
                               bgdeud013        LIKE bgde_t.bgdeud013, #自定義欄位(數字)013
                               bgdeud014        LIKE bgde_t.bgdeud014, #自定義欄位(數字)014
                               bgdeud015        LIKE bgde_t.bgdeud015, #自定義欄位(數字)015
                               bgdeud016        LIKE bgde_t.bgdeud016, #自定義欄位(數字)016
                               bgdeud017        LIKE bgde_t.bgdeud017, #自定義欄位(數字)017
                               bgdeud018        LIKE bgde_t.bgdeud018, #自定義欄位(數字)018
                               bgdeud019        LIKE bgde_t.bgdeud019, #自定義欄位(數字)019
                               bgdeud020        LIKE bgde_t.bgdeud020, #自定義欄位(數字)020
                               bgdeud021        LIKE bgde_t.bgdeud021, #自定義欄位(日期時間)021
                               bgdeud022        LIKE bgde_t.bgdeud022, #自定義欄位(日期時間)022
                               bgdeud023        LIKE bgde_t.bgdeud023, #自定義欄位(日期時間)023
                               bgdeud024        LIKE bgde_t.bgdeud024, #自定義欄位(日期時間)024
                               bgdeud025        LIKE bgde_t.bgdeud025, #自定義欄位(日期時間)025
                               bgdeud026        LIKE bgde_t.bgdeud026, #自定義欄位(日期時間)026
                               bgdeud027        LIKE bgde_t.bgdeud027, #自定義欄位(日期時間)027
                               bgdeud028        LIKE bgde_t.bgdeud028, #自定義欄位(日期時間)028
                               bgdeud029        LIKE bgde_t.bgdeud029, #自定義欄位(日期時間)029
                               bgdeud030        LIKE bgde_t.bgdeud030  #自定義欄位(日期時間)030                           
                               END RECORD
   DEFINE l_site_str           STRING
   DEFINE l_success            LIKE type_t.num5
   DEFINE r_flag               LIKE type_t.chr1
   DEFINE r_success            LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET l_success = TRUE
   LET r_flag = 'N'
   
   LET l_bgde005 = g_bgde_m.bgde005
   LET l_year = l_bgde005.subString(1,4)
   LET l_month = l_bgde005.subString(5,l_bgde005.getLength())
   
   CALL s_abg2_get_site(g_bgde_m.bgde001,g_bgde_m.bgde002,'02') RETURNING l_site_str
   
   #抓取組織
   LET l_sql = "SELECT ooef001 FROM ooef_t ",
               " WHERE ooefent = ",g_enterprise,
               "   AND ooef001 = '",g_bgde_m.bgde002,"'"
   
   IF g_bgde_m.a = 'Y' THEN   #含下層組織
      LET l_sql = l_sql," OR ooef001 IN ",l_site_str
   END IF
   
   PREPARE abgt420_01_pre FROM l_sql
   DECLARE abgt420_01_cs CURSOR FOR abgt420_01_pre

   #抓取xccc資料
   LET l_sql = "SELECT xccc006,SUM(xccc901),",
               "       SUM(xccc902a),SUM(xccc902b),SUM(xccc902c),SUM(xccc902d),",
               "       SUM(xccc902e),SUM(xccc902f),SUM(xccc902g),SUM(xccc902h) ",
               "  FROM xccc_t ",
               " WHERE xcccent = ",g_enterprise,
               "   AND xcccld = ? ",
               "   AND xccc003 = ? ",             
               "   AND xccc004 = '",l_year,"'",
               "   AND xccc005 = '",l_month,"'",  
               "   AND xccc901 > 0 ",      
               " GROUP BY xccc006 ",               
               " ORDER BY xccc006 "
   PREPARE abgt420_01_pre1 FROM l_sql
   DECLARE abgt420_01_cs1 CURSOR FOR abgt420_01_pre1
   
   #抓第一筆BOM資料
   LET l_sql = "SELECT bmaasite,bmaa001,bmaa002 ",
               "  FROM bmaa_t ",
               " WHERE bmaaent = ",g_enterprise,
               "   AND bmaasite = ? ",
               "   AND bmaa001 = ? ",
               "   AND bmaastus = 'Y'  "
   PREPARE bmaa_pre1 FROM l_sql
   DECLARE bmaa_cur1 SCROLL CURSOR WITH HOLD FOR bmaa_pre1
   
   #抓取BOM资料
   LET l_sql = "SELECT DISTINCT bmaa001,bmba003,bmba011,bmba012,0,level FROM bmaa_t ,bmba_t ",
               " WHERE bmaaent = bmbaent ",
               "   AND bmaasite = bmbasite ",
               "   AND bmaa001 = bmba001 ",
               "   AND bmaa002 = bmba002 ",
               "   AND bmaastus = 'Y' ",
               " START WITH bmaa001 = ? ",
               "        AND bmaasite = ? ",
               "        AND bmaa002 = ? ",
               "CONNECT BY PRIOR bmba003 = bmaa001 ",
               "        AND bmaasite = ? ",
               "        AND bmaa002 = ? ",
               "  ORDER BY level "
   PREPARE abgt420_01_pre2 FROM l_sql
   DECLARE abgt420_01_cs2 CURSOR FOR abgt420_01_pre2
   
   #中间阶展BOM到最底阶后将资料插到bgdf中
   LET l_sql = "SELECT * FROM abgt420_tmp01 ORDER BY lvl "
   PREPARE abgt420_01_pr3 FROM l_sql
   DECLARE abgt420_01_cs3 CURSOR FOR abgt420_01_pr3
   
   #展BOM到最底阶后,金额用展算出来的库存量*单价(xccc280(a-h))
   #相同料件抓取第一笔xccc280
   LET l_sql = "SELECT xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h ",
               "  FROM xccc_t ",
               " WHERE xcccent = ",g_enterprise,
               "   AND xcccld = ? ",
               "   AND xccc003 = ? ",     
               "   AND xccc006 = ? ",               
               "   AND xccc004 = '",l_year,"'",
               "   AND xccc005 = '",l_month,"'",  
               "   AND xccc901 > 0 "
   PREPARE abgt420_01_pre4 FROM l_sql
   DECLARE abgt420_01_cs4 SCROLL CURSOR WITH HOLD FOR abgt420_01_pre4
   
   #将资料汇总到bgde
   LET l_sql = "SELECT bgdf003,SUM(bgdf007),",
               "       SUM(bgdf902a),SUM(bgdf902b),SUM(bgdf902c),SUM(bgdf902d),",
               "       SUM(bgdf902e),SUM(bgdf902f),SUM(bgdf902g),SUM(bgdf902h) ",
               "  FROM abgt420_tmp02 ",
               " GROUP BY bgdf003 "
   PREPARE abgt420_01_pre5 FROM l_sql
   DECLARE abgt420_01_cs5 CURSOR FOR abgt420_01_pre5
   
   FOREACH abgt420_01_cs INTO l_bgde002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgt420_01_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
      END IF
   
      DELETE FROM abgt420_tmp02;
      
      #检查是否已经存在资料
      LET l_n = 0
      SELECT COUNT(1) INTO l_n
        FROM bgde_t
       WHERE bgdeent = g_enterprise
         AND bgde001 = g_bgde_m.bgde001
         AND bgde002 = l_bgde002
         
      IF l_n > 0 THEN 
         IF g_bgde_m.b = 'Y' THEN 
            DELETE FROM bgde_t WHERE bgdeent = g_enterprise AND bgde001 = g_bgde_m.bgde001 AND bgde002 = l_bgde002
            DELETE FROM bgdf_t WHERE bgdfent = g_enterprise AND bgdf001 = g_bgde_m.bgde001 AND bgdf002 = l_bgde002
         ELSE
            CONTINUE FOREACH
         END IF
      END IF
   
      LET l_comp = ''
      SELECT ooef017 INTO l_comp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_bgde002
      
      INITIALIZE l_glaa.* TO NULL
      INITIALIZE l_tmp.* TO NULL
      
      SELECT * INTO l_glaa.*
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = l_comp
         AND glaa014 = 'Y'
   
      FOREACH abgt420_01_cs1 USING l_glaa.glaald,l_glaa.glaa120 INTO l_tmp.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'abgt420_01_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            LET r_success = FALSE
         END IF  
         
         #到aimm205工单预设页签抓预设BOM特性,若没有值,则abmm210有多笔相同资料时,抓第一笔
         SELECT imae037 INTO l_imae037
           FROM imae_t
          WHERE imaeent = g_enterprise
            AND imaesite = l_bgde002
            AND imae001 = l_tmp.xccc006
            
         IF l_imae037 IS NULL THEN 
            OPEN bmaa_cur1 USING l_bgde002,l_tmp.xccc006
            FETCH FIRST bmaa_cur1 INTO l_bmaasite,l_bmaa001,l_bmaa002
            CLOSE bmaa_cur1
         ELSE
            SELECT bmaasite,bmaa001,bmaa002
              INTO l_bmaasite,l_bmaa001,l_bmaa002
              FROM bmaa_t
             WHERE bmaaent = g_enterprise
               AND bmaasite = l_bgde002
               AND bmaa001 = l_tmp.xccc006
               AND bmaa002 = l_imae037
               AND bmaastus = 'Y' 
         END IF
         
         #抓不到BOM资料则返回继续下一个料件
         #IF cl_null(l_bmaa001) THEN 
         #   CONTINUE FOREACH
         #END IF
         
         #看看是否有上層組織
         LET l_n1 = 0
         SELECT COUNT(1) INTO l_n1
           FROM bmba_t
          WHERE bmbaent = g_enterprise
            AND bmbasite = l_bmaasite
            AND bmba002 = l_bmaa002
            AND bmba003 = l_tmp.xccc006
            
         #看看是否有下層組織
         LET l_n2 = 0
         SELECT COUNT(1) INTO l_n2
           FROM bmba_t
          WHERE bmbaent = g_enterprise
            AND bmbasite = l_bmaasite
            AND bmba002 = l_bmaa002
            AND bmba001 = l_tmp.xccc006

         #如果有上层组织,也有下层组织,说明是中间组织,要展BOM到最低阶计算库存量
         #否则是最上层组织或者是最下层组织,直接插入bgdf表
         IF l_n1 > 0 AND l_n2 > 0 THEN 
            #展BOM计算库存量,插入到临时表中
            DELETE FROM abgt420_tmp01;
            INITIALIZE l_tmp1.* TO NULL
            FOREACH abgt420_01_cs2 USING l_tmp.xccc006,l_bmaasite,l_bmaa002,l_bmaasite,l_bmaa002 INTO l_tmp1.*
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'abgt420_01_cs2'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                
                  LET r_success = FALSE
               END IF 
               
               #如果是第一层,则库存数量直接抓xccc901
               IF l_tmp1.level = 1 THEN 
                  LET l_tmp1.qty = l_tmp1.bmba011 / l_tmp1.bmba012 * l_tmp.xccc901
               ELSE
                  #从第二层开始,库存数量=(組成用量/主件底数) * 上层的库存量
                  SELECT qty INTO l_qty
                    FROM abgt420_tmp01
                   WHERE child = l_tmp1.master
                     AND lvl = l_tmp1.level - 1
                     
                  LET l_tmp1.qty = l_tmp1.bmba011 / l_tmp1.bmba012 * l_qty
               END IF
               
               INSERT INTO abgt420_tmp01 VALUES(l_tmp1.*)
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'ins abgt420_tmp01'
                  LET g_errparam.code   = sqlca.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF
            END FOREACH
            
            INITIALIZE l_tmp1.* TO NULL
            
            #将临时表的资料插入到bgdf
            FOREACH abgt420_01_cs3 INTO l_tmp1.*
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'abgt420_01_cs3'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                
                  LET r_success = FALSE
               END IF
               
               INITIALIZE l_bgdf.* TO NULL
               
               #看当前子节点是否有下层,如果有,说明不是最低阶,不插入bgdf
               LET l_n = 0
               SELECT COUNT(1) INTO l_n
                 FROM abgt420_tmp01
                WHERE master = l_tmp1.child
               
               IF l_n > 0 THEN 
                  CONTINUE FOREACH
               END IF
               
               #若没有子节点了,说明是最低价,插入bgdf
               #去abgi170通过对应料号找预算料号,如果没资料,则不插入
               SELECT bgeb003 INTO l_bgdf.bgdf003
                 FROM bgeb_t
                WHERE bgebent = g_enterprise
                  AND bgeb001 = g_bgde_m.bgde001
                  AND bgeb002 = l_bgde002
                  AND bgeb004 = l_tmp1.child
                  
               IF cl_null(l_bgdf.bgdf003) THEN 
                  CONTINUE FOREACH
               END IF
               
               #预算单位
               LET l_bgea025 = ''
               SELECT bgea025 INTO l_bgea025 
                 FROM bgea_t
                WHERE bgeaent = g_enterprise
                  AND bgea001 = g_bgde_m.bgde001
                  AND bgea002 = l_bgde002
                  AND bgea003 = l_bgdf.bgdf003
               
               #基础单位
               SELECT imaa006 INTO l_bgdf.bgdf005
                 FROM imaa_t
                WHERE imaaent = g_enterprise
                  AND imaa001 = l_tmp1.child
               
               #基础单位和预算单位的转换率
               IF NOT cl_null(l_bgea025) AND NOT cl_null(l_bgdf.bgdf005) THEN 
                  CALL s_aimi190_get_convert(l_tmp1.child,l_bgdf.bgdf005,l_bgea025) RETURNING l_success,l_bgdf.bgdf009
               END IF            
               
               OPEN abgt420_01_cs4 USING l_glaa.glaald,l_glaa.glaa120,l_tmp1.child
               FETCH FIRST abgt420_01_cs4 INTO l_xccc280a,l_xccc280b,l_xccc280c,l_xccc280d,
                                               l_xccc280e,l_xccc280f,l_xccc280g,l_xccc280h
               CLOSE abgt420_01_cs4
               
               IF cl_null(l_xccc280a) THEN LET l_xccc280a = 0 END IF
               IF cl_null(l_xccc280b) THEN LET l_xccc280b = 0 END IF
               IF cl_null(l_xccc280c) THEN LET l_xccc280c = 0 END IF
               IF cl_null(l_xccc280d) THEN LET l_xccc280d = 0 END IF
               IF cl_null(l_xccc280e) THEN LET l_xccc280e = 0 END IF
               IF cl_null(l_xccc280f) THEN LET l_xccc280f = 0 END IF
               IF cl_null(l_xccc280g) THEN LET l_xccc280g = 0 END IF
               IF cl_null(l_xccc280h) THEN LET l_xccc280h = 0 END IF
               
               LET l_bgdf.bgdfent  = g_enterprise
               LET l_bgdf.bgdf001  = g_bgde_m.bgde001
               LET l_bgdf.bgdf002  = l_bgde002
               LET l_bgdf.bgdf004  = l_tmp1.child
               LET l_bgdf.bgdf006  = g_bgde_m.bgde005
               LET l_bgdf.bgdf007  = l_tmp1.qty
               LET l_bgdf.bgdf008  = l_tmp.xccc006
               LET l_bgdf.bgdf100  = l_glaa.glaa001
               LET l_bgdf.bgdf902a = l_xccc280a * l_bgdf.bgdf007
               LET l_bgdf.bgdf902b = l_xccc280b * l_bgdf.bgdf007
               LET l_bgdf.bgdf902c = l_xccc280c * l_bgdf.bgdf007
               LET l_bgdf.bgdf902d = l_xccc280d * l_bgdf.bgdf007
               LET l_bgdf.bgdf902e = l_xccc280e * l_bgdf.bgdf007
               LET l_bgdf.bgdf902f = l_xccc280f * l_bgdf.bgdf007
               LET l_bgdf.bgdf902g = l_xccc280g * l_bgdf.bgdf007
               LET l_bgdf.bgdf902h = l_xccc280h * l_bgdf.bgdf007
               LET l_bgdf.bgdf902  = l_bgdf.bgdf902a + l_bgdf.bgdf902b + l_bgdf.bgdf902c +
                                     l_bgdf.bgdf902d + l_bgdf.bgdf902e + l_bgdf.bgdf902f +
                                     l_bgdf.bgdf902g + l_bgdf.bgdf902h 
                                     
               INSERT INTO bgdf_t(bgdfent,bgdf001,bgdf002,bgdf003,bgdf004,bgdf005,
                                  bgdf006,bgdf007,bgdf008,bgdf009,bgdf100,bgdf902a,
                                  bgdf902b,bgdf902c,bgdf902d,bgdf902e,bgdf902f,bgdf902g,
                                  bgdf902h,bgdf902)
               VALUES(l_bgdf.bgdfent,l_bgdf.bgdf001,l_bgdf.bgdf002,l_bgdf.bgdf003,
                      l_bgdf.bgdf004,l_bgdf.bgdf005,l_bgdf.bgdf006,l_bgdf.bgdf007,
                      l_bgdf.bgdf008,l_bgdf.bgdf009,l_bgdf.bgdf100,l_bgdf.bgdf902a,
                      l_bgdf.bgdf902b,l_bgdf.bgdf902c,l_bgdf.bgdf902d,l_bgdf.bgdf902e,
                      l_bgdf.bgdf902f,l_bgdf.bgdf902g,l_bgdf.bgdf902h,l_bgdf.bgdf902)
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'ins bgdf_t'
                  LET g_errparam.code   = sqlca.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF 
               #将bgdf实体料件换算预算料件插入临时表
               LET l_qty = 0
               CALL s_aooi250_convert_qty(l_bgdf.bgdf004,l_bgdf.bgdf005,l_bgea025,l_bgdf.bgdf007) RETURNING l_success,l_qty
               
               INSERT INTO abgt420_tmp02(bgdf003,bgdf007,bgdf902a,bgdf902b,bgdf902c,bgdf902d,bgdf902e,bgdf902f,bgdf902g,bgdf902h) 
               VALUES(l_bgdf.bgdf003,l_qty,l_bgdf.bgdf902a,l_bgdf.bgdf902b,l_bgdf.bgdf902c,l_bgdf.bgdf902d,
                      l_bgdf.bgdf902e,l_bgdf.bgdf902f,l_bgdf.bgdf902g,l_bgdf.bgdf902h)
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'ins abgt420_tmp02'
                  LET g_errparam.code   = sqlca.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF
               
            END FOREACH
         ELSE
            INITIALIZE l_bgdf.* TO NULL
            
            #去abgi170通过对应料号找预算料号,如果没资料,则不插入
            SELECT bgeb003 INTO l_bgdf.bgdf003
              FROM bgeb_t
             WHERE bgebent = g_enterprise
               AND bgeb001 = g_bgde_m.bgde001
               AND bgeb002 = l_bgde002
               AND bgeb004 = l_tmp.xccc006
               
            IF cl_null(l_bgdf.bgdf003) THEN 
               CONTINUE FOREACH
            END IF
            
            #预算单位
            LET l_bgea025 = ''
            SELECT bgea025 INTO l_bgea025 
              FROM bgea_t
             WHERE bgeaent = g_enterprise
               AND bgea001 = g_bgde_m.bgde001
               AND bgea002 = l_bgde002
               AND bgea003 = l_bgdf.bgdf003
         
            #基础单位
            SELECT imaa006 INTO l_bgdf.bgdf005
              FROM imaa_t
             WHERE imaaent = g_enterprise
               AND imaa001 = l_tmp.xccc006
            
            #基础单位和预算单位的转换率
            IF NOT cl_null(l_bgea025) AND NOT cl_null(l_bgdf.bgdf005) THEN 
               CALL s_aimi190_get_convert(l_tmp.xccc006,l_bgdf.bgdf005,l_bgea025) RETURNING l_success,l_bgdf.bgdf009
            END IF            
         
            LET l_bgdf.bgdfent  = g_enterprise
            LET l_bgdf.bgdf001  = g_bgde_m.bgde001
            LET l_bgdf.bgdf002  = l_bgde002
            LET l_bgdf.bgdf004  = l_tmp.xccc006
            LET l_bgdf.bgdf006  = g_bgde_m.bgde005
            LET l_bgdf.bgdf007  = l_tmp.xccc901
            LET l_bgdf.bgdf008  = ' '
            LET l_bgdf.bgdf100  = l_glaa.glaa001
            LET l_bgdf.bgdf902a = l_tmp.xccc902a
            LET l_bgdf.bgdf902b = l_tmp.xccc902b
            LET l_bgdf.bgdf902c = l_tmp.xccc902c
            LET l_bgdf.bgdf902d = l_tmp.xccc902d
            LET l_bgdf.bgdf902e = l_tmp.xccc902e
            LET l_bgdf.bgdf902f = l_tmp.xccc902f
            LET l_bgdf.bgdf902g = l_tmp.xccc902g
            LET l_bgdf.bgdf902h = l_tmp.xccc902h
            LET l_bgdf.bgdf902  = l_bgdf.bgdf902a + l_bgdf.bgdf902b + l_bgdf.bgdf902c +
                                  l_bgdf.bgdf902d + l_bgdf.bgdf902e + l_bgdf.bgdf902f +
                                  l_bgdf.bgdf902g + l_bgdf.bgdf902h 
                                  
            INSERT INTO bgdf_t(bgdfent,bgdf001,bgdf002,bgdf003,bgdf004,bgdf005,
                               bgdf006,bgdf007,bgdf008,bgdf009,bgdf100,bgdf902a,
                               bgdf902b,bgdf902c,bgdf902d,bgdf902e,bgdf902f,bgdf902g,
                               bgdf902h,bgdf902)
            VALUES(l_bgdf.bgdfent,l_bgdf.bgdf001,l_bgdf.bgdf002,l_bgdf.bgdf003,
                   l_bgdf.bgdf004,l_bgdf.bgdf005,l_bgdf.bgdf006,l_bgdf.bgdf007,
                   l_bgdf.bgdf008,l_bgdf.bgdf009,l_bgdf.bgdf100,l_bgdf.bgdf902a,
                   l_bgdf.bgdf902b,l_bgdf.bgdf902c,l_bgdf.bgdf902d,l_bgdf.bgdf902e,
                   l_bgdf.bgdf902f,l_bgdf.bgdf902g,l_bgdf.bgdf902h,l_bgdf.bgdf902)
                   
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins bgfd_t'
               LET g_errparam.code   = sqlca.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
            
            #将bgdf实体料件换算预算料件插入临时表
            LET l_qty = 0
            CALL s_aooi250_convert_qty(l_bgdf.bgdf004,l_bgdf.bgdf005,l_bgea025,l_bgdf.bgdf007) RETURNING l_success,l_qty
            
            INSERT INTO abgt420_tmp02(bgdf003,bgdf007,bgdf902a,bgdf902b,bgdf902c,bgdf902d,bgdf902e,bgdf902f,bgdf902g,bgdf902h) 
            VALUES(l_bgdf.bgdf003,l_qty,l_bgdf.bgdf902a,l_bgdf.bgdf902b,l_bgdf.bgdf902c,l_bgdf.bgdf902d,
                   l_bgdf.bgdf902e,l_bgdf.bgdf902f,l_bgdf.bgdf902g,l_bgdf.bgdf902h)
                   
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'isn abgt420_tmp02'
               LET g_errparam.code   = sqlca.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
         END IF
      END FOREACH
      
      #将临时表的资料汇总到bgde
      INITIALIZE l_tmp2.* TO NULL
      FOREACH abgt420_01_cs5 INTO l_tmp2.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'abgt420_01_cs5'
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            LET r_success = FALSE
         END IF
         
         #预算单位
         SELECT bgea025 INTO l_bgde.bgde008 
           FROM bgea_t
          WHERE bgeaent = g_enterprise
            AND bgea001 = g_bgde_m.bgde001
            AND bgea002 = l_bgde002
            AND bgea003 = l_tmp2.bgdf003
            
         #预算币别   
         SELECT bgaa003 INTO l_bgde.bgde100
           FROM bgaa_t
          WHERE bgaaent = g_enterprise
            AND bgaa001 = g_bgde_m.bgde001
            
         IF NOT cl_null(l_bgde.bgde100) AND NOT cl_null(l_glaa.glaa001) THEN 
            CALL s_abg_get_bg_rate(g_bgde_m.bgde001,g_today,l_bgde.bgde100,l_glaa.glaa001)
            RETURNING l_bgde.bgde101
            
            IF cl_null(l_bgde.bgde101) THEN 
               LET l_bgde.bgde101 = 1
            END IF
         END IF
         
         LET l_bgde.bgdeent  = g_enterprise
         LET l_bgde.bgde001  = g_bgde_m.bgde001
         LET l_bgde.bgde002  = l_bgde002
         LET l_bgde.bgde003  = '2'
         LET l_bgde.bgde004  = l_tmp2.bgdf003
         LET l_bgde.bgde005  = g_bgde_m.bgde005
         LET l_bgde.bgde006  = l_glaa.glaa120
         LET l_bgde.bgde007  = l_tmp2.bgdf007_sum   
         LET l_bgde.bgde902a = l_tmp2.bgdf902a_sum * l_bgde.bgde101
         LET l_bgde.bgde902b = l_tmp2.bgdf902b_sum * l_bgde.bgde101
         LET l_bgde.bgde902c = l_tmp2.bgdf902c_sum * l_bgde.bgde101
         LET l_bgde.bgde902d = l_tmp2.bgdf902d_sum * l_bgde.bgde101
         LET l_bgde.bgde902e = l_tmp2.bgdf902e_sum * l_bgde.bgde101
         LET l_bgde.bgde902f = l_tmp2.bgdf902f_sum * l_bgde.bgde101
         LET l_bgde.bgde902g = l_tmp2.bgdf902g_sum * l_bgde.bgde101
         LET l_bgde.bgde902h = l_tmp2.bgdf902h_sum * l_bgde.bgde101
         LET l_bgde.bgde902  = l_bgde.bgde902a + l_bgde.bgde902b + l_bgde.bgde902c + l_bgde.bgde902d +
                               l_bgde.bgde902e + l_bgde.bgde902f + l_bgde.bgde902g + l_bgde.bgde902h 
         
         LET l_bgde.bgdeownid = g_user
         LET l_bgde.bgdeowndp = g_dept
         LET l_bgde.bgdecrtid = g_user
         LET l_bgde.bgdecrtdp = g_dept 
         LET l_bgde.bgdecrtdt = cl_get_current()
         LET l_bgde.bgdemodid = g_user
         LET l_bgde.bgdemoddt = cl_get_current()
         LET l_bgde.bgdestus = 'Y'
         
         INSERT INTO bgde_t(bgdeent,bgde001,bgde002,bgde003,
                            bgde004,bgde005,bgde006,bgde007,
                            bgde008,bgde100,bgde101,bgde902,
                            bgde902a,bgde902b,bgde902c,bgde902d,
                            bgde902e,bgde902f,bgde902g,bgde902h,
                            bgdeownid,bgdeowndp,bgdecrtid,bgdecrtdp,
                            bgdecrtdt,bgdemodid,bgdemoddt,bgdecnfid,
                            bgdecnfdt,bgdepstid,bgdepstdt,bgdestus)
         VALUES(l_bgde.bgdeent,l_bgde.bgde001,l_bgde.bgde002,l_bgde.bgde003,
                l_bgde.bgde004,l_bgde.bgde005,l_bgde.bgde006,l_bgde.bgde007,
                l_bgde.bgde008,l_bgde.bgde100,l_bgde.bgde101,l_bgde.bgde902,
                l_bgde.bgde902a,l_bgde.bgde902b,l_bgde.bgde902c,l_bgde.bgde902d,
                l_bgde.bgde902e,l_bgde.bgde902f,l_bgde.bgde902g,l_bgde.bgde902h,
                l_bgde.bgdeownid,l_bgde.bgdeowndp,l_bgde.bgdecrtid,l_bgde.bgdecrtdp,
                l_bgde.bgdecrtdt,l_bgde.bgdemodid,l_bgde.bgdemoddt,l_bgde.bgdecnfid,
                l_bgde.bgdecnfdt,l_bgde.bgdepstid,l_bgde.bgdepstdt,l_bgde.bgdestus)
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins bgde_t'
            LET g_errparam.code   = sqlca.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF
         
         LET r_flag = 'Y'
      END FOREACH
   END FOREACH
   
   RETURN r_success,r_flag
END FUNCTION

 
{</section>}
 
