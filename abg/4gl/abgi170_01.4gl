#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi170_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-11-14 17:57:53), PR版次:0001(2016-12-02 15:42:59)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgi170_01
#+ Description: 批次更新預算細項
#+ Creator....: 05016(2016-11-14 17:56:36)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="abgi170_01.global" >}
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
PRIVATE type type_g_bgea_m        RECORD
       bgea001 LIKE bgea_t.bgea001, 
   bgea001_desc LIKE type_t.chr80, 
   bgea002 LIKE bgea_t.bgea002, 
   bgea002_desc LIKE type_t.chr80, 
   bgea004 LIKE bgea_t.bgea004, 
   bgea004_desc LIKE type_t.chr80, 
   bgea005 LIKE bgea_t.bgea005, 
   bgea005_desc LIKE type_t.chr80, 
   bgea006 LIKE bgea_t.bgea006, 
   bgea006_desc LIKE type_t.chr80, 
   l_chk LIKE type_t.chr500, 
   bgea003 LIKE bgea_t.bgea003, 
   bgas005 LIKE type_t.chr500, 
   bgea009 LIKE bgea_t.bgea009, 
   bgea015 LIKE bgea_t.bgea015, 
   bgea031 LIKE bgea_t.bgea031
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc  STRING
DEFINE g_wc2 STRING
DEFINE g_bgaa008 LIKE bgaa_t.bgaa008
DEFINE l_sql STRING
#end add-point
 
DEFINE g_bgea_m        type_g_bgea_m
 
   DEFINE g_bgea001_t LIKE bgea_t.bgea001
DEFINE g_bgea002_t LIKE bgea_t.bgea002
DEFINE g_bgea003_t LIKE bgea_t.bgea003
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgi170_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgi170_01(--)
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
   DEFINE bgea001_t       LIKE bgea_t.bgea001
   DEFINE l_bgea003       LIKE bgea_t.bgea003
   DEFINE l_bgea004       LIKE bgea_t.bgea004
   DEFINE l_bgea005       LIKE bgea_t.bgea005
   DEFINE l_bgea006       LIKE bgea_t.bgea006
   DEFINE r_success       LIKE type_t.num5
  
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgi170_01 WITH FORM cl_ap_formpath("abg","abgi170_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('bgas005','1001')
   LET g_wc = ''
   LET g_wc2 = '' 
   LET g_bgea_m.l_chk  = 'N'
   LET g_bgea_m.bgea001 = '' LET g_bgea_m.bgea001_desc = ''
   LET g_bgea_m.bgea002 = '' LET g_bgea_m.bgea002_desc = ''
   LET g_bgea_m.bgea004 = '' LET g_bgea_m.bgea004_desc = ''
   LET g_bgea_m.bgea005 = '' LET g_bgea_m.bgea005_desc = ''
   LET g_bgea_m.bgea006 = '' LET g_bgea_m.bgea006_desc = ''
   DISPLAY BY NAME g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea004,g_bgea_m.bgea005,g_bgea_m.bgea006, 
                   g_bgea_m.bgea001_desc,g_bgea_m.bgea002_desc,
                   g_bgea_m.bgea004_desc,g_bgea_m.bgea005_desc,
                   g_bgea_m.bgea006_desc,g_bgea_m.l_chk
   LET r_success = TRUE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea004,g_bgea_m.bgea005,g_bgea_m.bgea006, 
          g_bgea_m.l_chk ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea001
            
            #add-point:AFTER FIELD bgea001 name="input.a.bgea001"
            LET g_bgea_m.bgea001_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea001_desc
            IF NOT cl_null(g_bgea_m.bgea001) THEN
               IF g_bgea_m.bgea001 != bgea001_t OR cl_null(bgea001_t) THEN
                  CALL s_fin_budget_chk(g_bgea_m.bgea001)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success  THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = 'abgi010'
                     LET g_errparam.replace[2] = cl_get_progname('abgi010',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi010'
                     CALL cl_err()
                     LET g_bgea_m.bgea001 = ''
                     CALL s_desc_get_budget_desc(g_bgea_m.bgea001) RETURNING g_bgea_m.bgea001_desc
                     DISPLAY BY NAME g_bgea_m.bgea001_desc
                     NEXT FIELD CURRENT
                  END IF
                  #修改預算編號,清空預算組織,避免修改成不存在組織樹中的組織
                  CALL s_fin_abg_center_sons_query(g_bgea_m.bgea001,'','')
                  LET g_bgea_m.bgea002 = ''
                  LET g_bgea_m.bgea002_desc = ''
                  DISPLAY BY NAME g_bgea_m.bgea002,g_bgea_m.bgea002_desc
               END IF
            END IF
            CALL s_desc_get_budget_desc(g_bgea_m.bgea001) RETURNING g_bgea_m.bgea001_desc
            DISPLAY BY NAME g_bgea_m.bgea001_desc
            LET bgea001_t = g_bgea_m.bgea001                                                
            #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001                                                       
           


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea001
            #add-point:BEFORE FIELD bgea001 name="input.b.bgea001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea001
            #add-point:ON CHANGE bgea001 name="input.g.bgea001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea002
            
            #add-point:AFTER FIELD bgea002 name="input.a.bgea002"

            LET g_bgea_m.bgea002_desc = ' '
            DISPLAY BY NAME g_bgea_m.bgea002_desc
            IF NOT cl_null(g_bgea_m.bgea002) THEN
               CALL abgi170_01_bgea002_chk(g_bgea_m.bgea002)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgea_m.bgea002 = ''
                  LET g_bgea_m.bgea002_desc =s_desc_get_department_desc(g_bgea_m.bgea002)
                  DISPLAY BY NAME g_bgea_m.bgea002,g_bgea_m.bgea002_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_bgea_m.bgea001)THEN
                  CALL s_abg_site_chk(g_bgea_m.bgea002)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgea_m.bgea002 = ''
                     LET g_bgea_m.bgea002_desc =s_desc_get_department_desc(g_bgea_m.bgea002)
                     DISPLAY BY NAME g_bgea_m.bgea002,g_bgea_m.bgea002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bgea_m.bgea002_desc =s_desc_get_department_desc(g_bgea_m.bgea002)
            DISPLAY BY NAME g_bgea_m.bgea002,g_bgea_m.bgea002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea002
            #add-point:BEFORE FIELD bgea002 name="input.b.bgea002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea002
            #add-point:ON CHANGE bgea002 name="input.g.bgea002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea004
            
            #add-point:AFTER FIELD bgea004 name="input.a.bgea004"
            #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
              
            LET g_bgea_m.bgea004_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea004_desc
            IF NOT cl_null(g_bgea_m.bgea004) THEN
               IF NOT ap_chk_isExist(g_bgea_m.bgea004,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' ",'abg-00035',0) THEN
                  LET g_bgea_m.bgea004 = ''
                  LET g_bgea_m.bgea004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea004)
                  NEXT FIELD CURRENT
               END IF                 
               IF NOT ap_chk_isExist(g_bgea_m.bgea004,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' AND bgae005='1' ",'abg-00175',0) THEN
                  LET g_bgea_m.bgea004 =''  
                  LET g_bgea_m.bgea004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea004)
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_isExist(g_bgea_m.bgea004,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' AND bgae005='1' AND bgaestus='Y' ",'sub-01302','abgi040') THEN
                  LET g_bgea_m.bgea004 = ''        
                  LET g_bgea_m.bgea004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea004)
                  NEXT FIELD CURRENT
               END IF                                   
            END IF
            LET g_bgea_m.bgea004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea004)
            DISPLAY BY NAME g_bgea_m.bgea004_desc
  

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea004
            #add-point:BEFORE FIELD bgea004 name="input.b.bgea004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea004
            #add-point:ON CHANGE bgea004 name="input.g.bgea004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea005
            
            #add-point:AFTER FIELD bgea005 name="input.a.bgea005"
            #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
              
            LET g_bgea_m.bgea005_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea005_desc
            IF NOT cl_null(g_bgea_m.bgea005) THEN  
               IF NOT ap_chk_isExist(g_bgea_m.bgea005,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' ",'abg-00035',0) THEN
                  LET g_bgea_m.bgea005 = ''
                  LET g_bgea_m.bgea005_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea005)
                  NEXT FIELD CURRENT
               END IF                 
               IF NOT ap_chk_isExist(g_bgea_m.bgea005,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' AND bgae005='3' ",'abg-00175',0) THEN
                  LET g_bgea_m.bgea005 = ''
                  LET g_bgea_m.bgea005_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea005)
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_isExist(g_bgea_m.bgea005,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' AND bgae005='3' AND bgaestus='Y' ",'sub-01302','abgi040') THEN
                  LET g_bgea_m.bgea005 = ''         
                  LET g_bgea_m.bgea005_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea005)
                  NEXT FIELD CURRENT
               END IF                  
            END IF
            LET g_bgea_m.bgea005_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea005)
            DISPLAY BY NAME g_bgea_m.bgea005_desc           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea005
            #add-point:BEFORE FIELD bgea005 name="input.b.bgea005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea005
            #add-point:ON CHANGE bgea005 name="input.g.bgea005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea006
            
            #add-point:AFTER FIELD bgea006 name="input.a.bgea006"
             #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
              
            LET g_bgea_m.bgea006_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea006_desc
            IF NOT cl_null(g_bgea_m.bgea006) THEN
               IF NOT ap_chk_isExist(g_bgea_m.bgea006,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' ",'abg-00035',0) THEN
                  LET g_bgea_m.bgea006 = ''  
                  LET g_bgea_m.bgea006_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea006)
                  NEXT FIELD CURRENT
               END IF                 
               IF NOT ap_chk_isExist(g_bgea_m.bgea006,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' AND bgae005='2' ",'abg-00175',0) THEN
                  LET g_bgea_m.bgea006 = '' 
                  LET g_bgea_m.bgea006_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea006)
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_isExist(g_bgea_m.bgea006,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' AND bgae005='2' AND bgaestus='Y' ",'sub-01302','abgi040') THEN
                  LET g_bgea_m.bgea006 = ''         
                  LET g_bgea_m.bgea006_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea006)
                  NEXT FIELD CURRENT
               END IF                  
            END IF
            LET g_bgea_m.bgea006_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea006)
            DISPLAY BY NAME g_bgea_m.bgea006_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea006
            #add-point:BEFORE FIELD bgea006 name="input.b.bgea006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea006
            #add-point:ON CHANGE bgea006 name="input.g.bgea006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk
            #add-point:BEFORE FIELD l_chk name="input.b.l_chk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk
            
            #add-point:AFTER FIELD l_chk name="input.a.l_chk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk
            #add-point:ON CHANGE l_chk name="input.g.l_chk"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgea001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea001
            #add-point:ON ACTION controlp INFIELD bgea001 name="input.c.bgea001"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   
            LET g_qryparam.state = 'i'  
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgaastus = 'Y' "
            LET g_qryparam.default1 = g_bgea_m.bgea001              #給予default值
            CALL q_bgaa001()                                        #呼叫開窗
            LET g_bgea_m.bgea001 = g_qryparam.return1               #將開窗取得的值回傳到變數
            CALL s_desc_get_budget_desc(g_bgea_m.bgea001) RETURNING g_bgea_m.bgea001_desc
            DISPLAY BY NAME g_bgea_m.bgea001,g_bgea_m.bgea001_desc
            NEXT FIELD bgea001                                      #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea002
            #add-point:ON ACTION controlp INFIELD bgea002 name="input.c.bgea002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef205 = 'Y' AND ooef001 IN (SELECT ooef001 FROM s_fin_tmp1 ) AND ooefstus = 'Y'"
            LET g_qryparam.default1 = g_bgea_m.bgea002
            CALL q_ooef001()
            LET g_bgea_m.bgea002 = g_qryparam.return1
            NEXT FIELD bgea002
            #END add-point
 
 
         #Ctrlp:input.c.bgea004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea004
            #add-point:ON ACTION controlp INFIELD bgea004 name="input.c.bgea004"
            #開窗i段
            #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
            
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea004         #給予default值
            LET g_qryparam.where = " bgae007='1' AND bgae005='1' AND bgae006='",g_bgaa008,"'"
            #給予arg
            CALL q_bgae001()                                   #呼叫開窗
            LET g_bgea_m.bgea004 = g_qryparam.return1          #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea004)
            DISPLAY BY NAME g_bgea_m.bgea004_desc              #顯示到畫面上
            NEXT FIELD bgea004                                 #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea005
            #add-point:ON ACTION controlp INFIELD bgea005 name="input.c.bgea005"
            #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
            
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea005      #給予default值
            LET g_qryparam.where = " bgae007='1' AND bgae005='3' AND bgae006='",g_bgaa008,"'"
            #給予arg
            CALL q_bgae001()                                #呼叫開窗
            LET g_bgea_m.bgea005 = g_qryparam.return1       #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea005_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea005)
            DISPLAY BY NAME g_bgea_m.bgea005                #顯示到畫面上
            NEXT FIELD bgea005                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea006
            #add-point:ON ACTION controlp INFIELD bgea006 name="input.c.bgea006"
            #開窗i段
            #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
            
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea006      #給予default值
            LET g_qryparam.where = " bgae007='1' AND bgae005='2' AND bgae006='",g_bgaa008,"'"
            #給予arg
            CALL q_bgae001()                                #呼叫開窗
            LET g_bgea_m.bgea006 = g_qryparam.return1       #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea006_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea006)
            DISPLAY BY NAME g_bgea_m.bgea006                #顯示到畫面上
            NEXT FIELD bgea006                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.l_chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk
            #add-point:ON ACTION controlp INFIELD l_chk name="input.c.l_chk"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            IF cl_null(g_bgea_m.bgea004) AND cl_null(g_bgea_m.bgea005) AND cl_null(g_bgea_m.bgea006) THEN
                LET g_errparam.code = 'abg-00244'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()
                NEXT FIELD bgea004            
            END IF
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT BY NAME g_wc2 ON bgas005
      END CONSTRUCT
      CONSTRUCT BY NAME g_wc ON bgea003,bgea009,bgea015,bgea031
        
        ON ACTION controlp INFIELD bgea003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgasstus = 'Y' "
            CALL q_bgas001()
            DISPLAY g_qryparam.return1 TO bgea003
            NEXT FIELD bgea003
        
        ON ACTION controlp INFIELD bgea009
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
           CALL q_imcd111_1()
           DISPLAY g_qryparam.return1 TO bgea009  #顯示到畫面上
           NEXT FIELD bgea009                     #返回原欄位
        
        ON ACTION controlp INFIELD bgea015
            #add-point:ON ACTION controlp INFIELD bgea015 name="construct.c.bgea015"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imce141_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea015  #顯示到畫面上
            NEXT FIELD bgea015            
        
         ON ACTION controlp INFIELD bgea031
            #add-point:ON ACTION controlp INFIELD bgea031 name="construct.c.bgea031"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "206"
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea031  #顯示到畫面上
            NEXT FIELD bgea031                     #返回原欄位
      
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
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_abgi170_01 
   
   #add-point:input段after input name="input.post_input"
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      LET r_success= FALSE
      RETURN r_success,g_bgea_m.bgea001,g_bgea_m.bgea002
   END IF
      
   IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF 
   IF cl_null(g_wc2) THEN LET g_wc2 = " 1=1" END IF     
   LET l_sql = " SELECT bgea003,bgea004,bgea005,bgea006 FROM bgea_t ",
               "  WHERE bgeaent = ",g_enterprise,"          ",
               "    AND bgea001 = '",g_bgea_m.bgea001,"' AND bgea002 = '",g_bgea_m.bgea002,"' ",
               "    AND ",g_wc
   PREPARE abgi170_bgeaupd_prep FROM l_sql
   DECLARE abgi170_bgeaupd_curs CURSOR FOR abgi170_bgeaupd_prep
   FOREACH abgi170_bgeaupd_curs INTO l_bgea003,l_bgea004,l_bgea005,l_bgea006
      
      IF g_wc2 != ' 1=1' THEN
         LET l_count = 0 
         LET l_sql = " SELECT COUNT(1) FROM bgas_t              ",
                     " WHERE bgasent = ",g_enterprise,"         ",
                     "   AND bgas001 = '",l_bgea003,"'          ",
                     "   AND ",g_wc2                       
         PREPARE abgi170_bgas_prep FROM l_sql
         EXECUTE abgi170_bgas_prep INTO l_count
         IF cl_null(l_count) THEN LET l_count = 0 END IF
         IF l_count = 0 THEN CONTINUE FOREACH END IF
      END IF
                                      
      IF g_bgea_m.l_chk = 'N' THEN
         IF cl_null(l_bgea004) AND NOT cl_null(g_bgea_m.bgea004) THEN 
           UPDATE bgea_t SET bgea004  = g_bgea_m.bgea004 
            WHERE bgeaent = g_enterprise
              AND bgea001 = g_bgea_m.bgea001 AND bgea002 = g_bgea_m.bgea002
              AND bgea003 = l_bgea003
           IF SQLCA.SQLCODE THEN LET r_success= FALSE END IF
         END IF
         IF cl_null(l_bgea005) AND NOT cl_null(g_bgea_m.bgea005) THEN 
            UPDATE bgea_t SET bgea005  = g_bgea_m.bgea005
             WHERE bgeaent = g_enterprise
               AND bgea001 = g_bgea_m.bgea001 AND bgea002 = g_bgea_m.bgea002
               AND bgea003 = l_bgea003
            IF SQLCA.SQLCODE THEN LET r_success= FALSE END IF
         END IF
         IF cl_null(l_bgea006) AND NOT cl_null(g_bgea_m.bgea006) THEN 
            UPDATE bgea_t SET bgea006  = g_bgea_m.bgea006 
             WHERE bgeaent = g_enterprise
               AND bgea001 = g_bgea_m.bgea001 AND bgea002 = g_bgea_m.bgea002
               AND bgea003 = l_bgea003
            IF SQLCA.SQLCODE THEN LET r_success= FALSE END IF
         END IF
      ELSE     
         IF NOT cl_null(g_bgea_m.bgea004) THEN
            UPDATE bgea_t SET bgea004  = g_bgea_m.bgea004
             WHERE bgeaent = g_enterprise
               AND bgea001 = g_bgea_m.bgea001 AND bgea002 = g_bgea_m.bgea002
               AND bgea003 = l_bgea003                           
            IF SQLCA.SQLCODE THEN LET r_success= FALSE END IF
         END IF
         IF NOT cl_null(g_bgea_m.bgea005) THEN
           UPDATE bgea_t SET bgea005 = g_bgea_m.bgea005
            WHERE bgeaent = g_enterprise
              AND bgea001 = g_bgea_m.bgea001 AND bgea002 = g_bgea_m.bgea002
              AND bgea003 = l_bgea003                           
           IF SQLCA.SQLCODE THEN LET r_success= FALSE END IF
         END IF
         IF NOT cl_null(g_bgea_m.bgea006) THEN
           UPDATE bgea_t SET bgea006 = g_bgea_m.bgea006
            WHERE bgeaent = g_enterprise
              AND bgea001 = g_bgea_m.bgea001 AND bgea002 = g_bgea_m.bgea002
              AND bgea003 = l_bgea003                           
           IF SQLCA.SQLCODE THEN LET r_success= FALSE END IF
         END IF
      END IF            
   END FOREACH
  
   RETURN r_success,g_bgea_m.bgea001,g_bgea_m.bgea002
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgi170_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgi170_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預算組織檢核
# Memo...........:
# Usage..........: CALL abgi170_bgea002_chk(p_bgea002)
# Date & Author..: 161014 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi170_01_bgea002_chk(p_bgea002)
  DEFINE p_bgea002   LIKE bgea_t.bgea002
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_ooef      RECORD
                      ooef205  LIKE ooef_t.ooef205,
                      ooefstus LIKE ooef_t.ooefstus
                      END RECORD

   LET r_success = TRUE
   LET r_errno   = ''
   INITIALIZE l_ooef.* TO NULL
   SELECT ooef205,ooefstus
     INTO l_ooef.*
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_bgea002

   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_success = FALSE
         LET r_errno = 'aoo-00094'
      WHEN l_ooef.ooefstus <> 'Y'
         LET r_success = FALSE
         LET r_errno = 'apm-00249'
      WHEN l_ooef.ooef205 <> 'Y'
         LET r_success = FALSE
         LET r_errno = 'axm-00159'
   END CASE

   RETURN r_success,r_errno
END FUNCTION

 
{</section>}
 
