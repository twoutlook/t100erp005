#該程式未解開Section, 採用最新樣板產出!
{<section id="afat509_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-10-17 14:15:14), PR版次:0003(2016-11-28 14:00:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000006
#+ Filename...: afat509_01
#+ Description: 批次產生
#+ Creator....: 02599(2016-10-17 14:01:45)
#+ Modifier...: 02599 -SD/PR- 02481
 
{</section>}
 
{<section id="afat509_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161024-00008#4   2016/10/27  By Hans     AFA組織類型與職能開窗清單調整。
#161111-00028#8   2016/11/28  by 02481    标准程式定义采用宣告模式,弃用.*写法
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
       fabgsite LIKE fabg_t.fabgsite, 
   fabgsite_desc LIKE type_t.chr80, 
   fabg001 LIKE fabg_t.fabg001, 
   fabg001_desc LIKE type_t.chr80, 
   fabgld LIKE fabg_t.fabgld, 
   fabgld_desc LIKE type_t.chr80, 
   fabgcomp LIKE fabg_t.fabgcomp, 
   fabgcomp_desc LIKE type_t.chr80, 
   type LIKE type_t.chr500, 
   fabg002 LIKE fabg_t.fabg002, 
   fabg002_desc LIKE type_t.chr80, 
   fabg003 LIKE fabg_t.fabg003, 
   fabg003_desc LIKE type_t.chr80, 
   fabg004 LIKE fabg_t.fabg004, 
   fabgdocno LIKE fabg_t.fabgdocno, 
   fabgdocdt LIKE fabg_t.fabgdocdt, 
   yy LIKE type_t.num10, 
   mm LIKE type_t.num10, 
   fabg005 LIKE fabg_t.fabg005, 
   docno_509 LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#161111-00028#8----modify----begin---------
#DEFINE g_glaa                RECORD LIKE glaa_t.*
DEFINE g_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
       END RECORD

#161111-00028#8----modify----end---------
DEFINE g_bookno              LIKE glaa_t.glaald
DEFINE g_fabgdocdt_t         LIKE fabg_t.fabgdocdt
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
 
{<section id="afat509_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION afat509_01(--)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_para_data           LIKE fabg_t.fabg004
   DEFINE  l_year                LIKE type_t.num5
   DEFINE  l_month               LIKE type_t.num5
   DEFINE  l_origin_str          STRING   #組織範圍
   DEFINE  l_wc                  STRING
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat509_01 WITH FORM cl_ap_formpath("afa","afat509_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('fabg005','9910')
   CALL afat509_01_default()
   LET g_fabgdocdt_t=g_fabg_m.fabgdocdt
   WHILE TRUE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_fabg_m.fabgsite,g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabgcomp,g_fabg_m.type, 
          g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.yy, 
          g_fabg_m.mm,g_fabg_m.fabg005,g_fabg_m.docno_509 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
 
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgsite
            
            #add-point:AFTER FIELD fabgsite name="input.a.fabgsite"
            IF NOT cl_null(g_fabg_m.fabgsite) THEN
               CALL s_afa_site_chk(g_fabg_m.fabgsite,NULL,'',g_fabg_m.fabgld,g_fabg_m.fabgdocdt)
               RETURNING l_success,g_glaa.glaacomp,g_fabg_m.fabgld
               
               IF l_success = FALSE THEN 
                  LET g_fabg_m.fabgsite = NULL
                  LET g_fabg_m.fabgld = NULL
                  LET g_fabg_m.fabgsite_desc=''
                  DISPLAY BY NAME g_fabg_m.fabgsite_desc
                  NEXT FIELD CURRENT
               END IF
               
               #人员不为空
               IF NOT cl_null(g_fabg_m.fabg001) THEN
                  CALL s_afa_person_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001)
                  RETURNING l_success
                  IF l_success = FALSE THEN
                     LET g_fabg_m.fabgsite = NULL
                     LET g_fabg_m.fabgsite_desc=''
                     DISPLAY BY NAME g_fabg_m.fabgsite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_fin_account_center_sons_query('5',g_fabg_m.fabgsite,g_today,'1')
            CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc
            CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
            DISPLAY BY NAME g_fabg_m.fabgsite_desc,g_fabg_m.fabgld_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgsite
            #add-point:BEFORE FIELD fabgsite name="input.b.fabgsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgsite
            #add-point:ON CHANGE fabgsite name="input.g.fabgsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg001
            
            #add-point:AFTER FIELD fabg001 name="input.a.fabg001"
            IF NOT cl_null(g_fabg_m.fabg001) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabg_m.fabg001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  IF NOT cl_null(g_fabg_m.fabgsite) THEN 
                     CALL s_afa_person_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001) RETURNING l_success
                     
                     IF l_success = FALSE THEN
                        LET g_fabg_m.fabg001 = NULL
                        LET g_fabg_m.fabg001_desc = ''
                        DISPLAY BY NAME g_fabg_m.fabg001_desc  
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_person_desc(g_fabg_m.fabg001) RETURNING g_fabg_m.fabg001_desc
            DISPLAY BY NAME g_fabg_m.fabg001_desc 
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg001
            #add-point:BEFORE FIELD fabg001 name="input.b.fabg001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg001
            #add-point:ON CHANGE fabg001 name="input.g.fabg001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgld
            
            #add-point:AFTER FIELD fabgld name="input.a.fabgld"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_fabg_m.fabgld) AND NOT cl_null(g_fabg_m.fabgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t  OR g_fabg_m.fabgdocno != g_fabgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabg_t WHERE "||"fabgent = '" ||g_enterprise|| "' AND "||"fabgld = '"||g_fabg_m.fabgld ||"' AND "|| "fabgdocno = '"||g_fabg_m.fabgdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_fabg_m.fabgld) THEN
               CALL s_afa_ld_chk(g_fabg_m.fabgsite,g_fabg_m.fabgld)
               RETURNING l_success,g_glaa.glaacomp
               
               IF l_success = FALSE THEN 
                  LET g_fabg_m.fabgld = NULL
                  LET g_fabg_m.fabgld_desc = ''
                  DISPLAY BY NAME g_fabg_m.fabgld_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            #161111-00028#3---MODIFY----begin---------
            #SELECT * INTO g_glaa.* 
             SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                    glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                    glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,
                    glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,
                    glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,
                    glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.*
            #161111-00028#3---MODIFY----end--------- 
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
            LET g_fabg_m.fabgcomp=g_glaa.glaacomp
            CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
            DISPLAY BY NAME g_fabg_m.fabgld_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgld
            #add-point:BEFORE FIELD fabgld name="input.b.fabgld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgld
            #add-point:ON CHANGE fabgld name="input.g.fabgld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgcomp
            
            #add-point:AFTER FIELD fabgcomp name="input.a.fabgcomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabgcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabg_m.fabgcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabgcomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgcomp
            #add-point:BEFORE FIELD fabgcomp name="input.b.fabgcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgcomp
            #add-point:ON CHANGE fabgcomp name="input.g.fabgcomp"
            
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg002
            
            #add-point:AFTER FIELD fabg002 name="input.a.fabg002"
            IF NOT cl_null(g_fabg_m.fabg002) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=g_fabg_m.fabg002
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#6--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabg_m.fabg002=NULL
                  LET g_fabg_m.fabg002_desc = ''
                  DISPLAY BY NAME g_fabg_m.fabg002_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_person_desc(g_fabg_m.fabg002) RETURNING g_fabg_m.fabg002_desc
            DISPLAY BY NAME g_fabg_m.fabg002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg002
            #add-point:BEFORE FIELD fabg002 name="input.b.fabg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg002
            #add-point:ON CHANGE fabg002 name="input.g.fabg002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg003
            
            #add-point:AFTER FIELD fabg003 name="input.a.fabg003"
            IF NOT cl_null(g_fabg_m.fabg003) THEN
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=g_fabg_m.fabg003
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_14") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabg_m.fabg003=NULL
                  LET g_fabg_m.fabg003_desc = ''
                  DISPLAY BY NAME g_fabg_m.fabg003_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_department_desc(g_fabg_m.fabg003) RETURNING g_fabg_m.fabg003_desc           
            DISPLAY BY NAME g_fabg_m.fabg003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg003
            #add-point:BEFORE FIELD fabg003 name="input.b.fabg003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg003
            #add-point:ON CHANGE fabg003 name="input.g.fabg003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg004
            #add-point:BEFORE FIELD fabg004 name="input.b.fabg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg004
            
            #add-point:AFTER FIELD fabg004 name="input.a.fabg004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg004
            #add-point:ON CHANGE fabg004 name="input.g.fabg004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocno
            #add-point:BEFORE FIELD fabgdocno name="input.b.fabgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocno
            
            #add-point:AFTER FIELD fabgdocno name="input.a.fabgdocno"
            IF NOT cl_null(g_fabg_m.fabgdocno) THEN
               #161111-00028#3---MODIFY----begin---------
               #SELECT * INTO g_glaa.* 
                SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                       glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                       glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,
                       glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,
                       glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,
                       glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.*
               #161111-00028#3---MODIFY----end--------- 
                FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
               
               IF NOT s_aooi200_fin_chk_slip(g_fabg_m.fabgld,g_glaa.glaa024,g_fabg_m.fabgdocno,g_prog) THEN
                  LET g_fabg_m.fabgdocno = g_fabgdocno_t
                  NEXT FIELD CURRENT
               END IF
            END IF
            #確認資料無重複
            IF  NOT cl_null(g_fabg_m.fabgld) AND NOT cl_null(g_fabg_m.fabgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t  OR g_fabg_m.fabgdocno != g_fabgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabg_t WHERE "||"fabgent = '" ||g_enterprise|| "' AND "||"fabgld = '"||g_fabg_m.fabgld ||"' AND "|| "fabgdocno = '"||g_fabg_m.fabgdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgdocno
            #add-point:ON CHANGE fabgdocno name="input.g.fabgdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocdt
            #add-point:BEFORE FIELD fabgdocdt name="input.b.fabgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocdt
            
            #add-point:AFTER FIELD fabgdocdt name="input.a.fabgdocdt"
            IF NOT cl_null(g_fabg_m.fabgdocdt) THEN
               IF NOT cl_null(l_para_data) AND g_fabg_m.fabgdocdt<=l_para_data THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "afa-00060"
                  LET g_errparam.extend = g_fabg_m.fabgdocdt
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  
                  LET g_fabg_m.fabgdocdt = g_fabgdocdt_t
                  NEXT FIELD fabgdocdt
               END IF
               #现行年月检查
               CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-9018') RETURNING l_year
               CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-9019') RETURNING l_month
               IF l_year <> YEAR(g_fabg_m.fabgdocdt) OR l_month <> MONTH(g_fabg_m.fabgdocdt) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00283'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fabg_m.fabgdocdt = g_fabgdocdt_t
                  NEXT FIELD fabgdocdt
               END IF
               #檢查主鍵重複
               IF NOT afat509_01_chk_id() THEN
                  LET g_fabg_m.fabgdocdt = g_fabgdocdt_t
                  LET g_fabg_m.yy = YEAR(g_fabg_m.fabgdocdt)
                  LET g_fabg_m.mm = MONTH(g_fabg_m.fabgdocdt)
                  DISPLAY BY NAME g_fabg_m.fabgdocdt,g_fabg_m.yy,g_fabg_m.mm
                  NEXT FIELD fabgdocdt
               END IF 
               LET g_fabg_m.yy = l_year
               LET g_fabg_m.mm = l_month
               DISPLAY BY NAME g_fabg_m.yy,g_fabg_m.mm
            ELSE
               LET g_fabg_m.yy = ''
               LET g_fabg_m.mm = ''
               DISPLAY BY NAME g_fabg_m.yy,g_fabg_m.mm
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgdocdt
            #add-point:ON CHANGE fabgdocdt name="input.g.fabgdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD yy
            #add-point:BEFORE FIELD yy name="input.b.yy"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD yy
            
            #add-point:AFTER FIELD yy name="input.a.yy"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE yy
            #add-point:ON CHANGE yy name="input.g.yy"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mm
            #add-point:BEFORE FIELD mm name="input.b.mm"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mm
            
            #add-point:AFTER FIELD mm name="input.a.mm"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mm
            #add-point:ON CHANGE mm name="input.g.mm"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg005
            #add-point:BEFORE FIELD fabg005 name="input.b.fabg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg005
            
            #add-point:AFTER FIELD fabg005 name="input.a.fabg005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg005
            #add-point:ON CHANGE fabg005 name="input.g.fabg005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD docno_509
            #add-point:BEFORE FIELD docno_509 name="input.b.docno_509"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD docno_509
            
            #add-point:AFTER FIELD docno_509 name="input.a.docno_509"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE docno_509
            #add-point:ON CHANGE docno_509 name="input.g.docno_509"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fabgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgsite
            #add-point:ON ACTION controlp INFIELD fabgsite name="input.c.fabgsite"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.fabgsite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = " ooef207 = 'Y' "
            #CALL q_ooef001()                                #呼叫開窗   #161024-00008#4 
            CALL q_ooef001_47()                                         #161024-00008#4 
 
            LET g_fabg_m.fabgsite = g_qryparam.return1              

            DISPLAY g_fabg_m.fabgsite TO fabgsite              #
            CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc
            DISPLAY BY NAME g_fabg_m.fabgsite_desc
            NEXT FIELD fabgsite                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg001
            #add-point:ON ACTION controlp INFIELD fabg001 name="input.c.fabg001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.fabg001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_fabg_m.fabg001 = g_qryparam.return1              

            DISPLAY g_fabg_m.fabg001 TO fabg001              #
            CALL s_desc_get_person_desc(g_fabg_m.fabg001) RETURNING g_fabg_m.fabg001_desc
            DISPLAY BY NAME g_fabg_m.fabg001_desc
            NEXT FIELD fabg001                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgld
            #add-point:ON ACTION controlp INFIELD fabgld name="input.c.fabgld"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.fabgld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user #s
            LET g_qryparam.arg2 = g_dept #s
            #取得资产組織下所屬成員
            CALL s_fin_account_center_sons_query('5',g_fabg_m.fabgsite,g_fabg_m.fabgdocdt,'1')
            #取得资产中心下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str  
            
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_origin_str
            CALL q_authorised_ld()                                #呼叫開窗
 
            LET g_fabg_m.fabgld = g_qryparam.return1              

            DISPLAY g_fabg_m.fabgld TO fabgld              #
            CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
            DISPLAY BY NAME g_fabg_m.fabgld_desc
            NEXT FIELD fabgld                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabgcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgcomp
            #add-point:ON ACTION controlp INFIELD fabgcomp name="input.c.fabgcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD type
            #add-point:ON ACTION controlp INFIELD type name="input.c.type"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg002
            #add-point:ON ACTION controlp INFIELD fabg002 name="input.c.fabg002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.fabg002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_fabg_m.fabg002 = g_qryparam.return1              

            DISPLAY g_fabg_m.fabg002 TO fabg002              #
            CALL s_desc_get_person_desc(g_fabg_m.fabg002) RETURNING g_fabg_m.fabg002_desc
            DISPLAY BY NAME g_fabg_m.fabg002_desc
            NEXT FIELD fabg002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg003
            #add-point:ON ACTION controlp INFIELD fabg003 name="input.c.fabg003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.fabg003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooef001_9()                                #呼叫開窗
 
            LET g_fabg_m.fabg003 = g_qryparam.return1              

            DISPLAY g_fabg_m.fabg003 TO fabg003              #
            CALL s_desc_get_department_desc(g_fabg_m.fabg003) RETURNING g_fabg_m.fabg003_desc
            DISPLAY BY NAME g_fabg_m.fabg003_desc
            NEXT FIELD fabg003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg004
            #add-point:ON ACTION controlp INFIELD fabg004 name="input.c.fabg004"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocno
            #add-point:ON ACTION controlp INFIELD fabgdocno name="input.c.fabgdocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.fabgdocno             #給予default值

            #給予arg
            #161111-00028#3---MODIFY----begin---------
            #SELECT * INTO g_glaa.* 
             SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                    glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                    glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,
                    glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,
                    glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,
                    glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.*
            #161111-00028#3---MODIFY----end--------- 
             FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld   
            LET g_qryparam.arg1 = g_glaa.glaa024 
            LET g_qryparam.arg2 = "afat509"
 
            CALL q_ooba002_1()                                #呼叫開窗
 
            LET g_fabg_m.fabgdocno = g_qryparam.return1              

            DISPLAY g_fabg_m.fabgdocno TO fabgdocno              #

            NEXT FIELD fabgdocno                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocdt
            #add-point:ON ACTION controlp INFIELD fabgdocdt name="input.c.fabgdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.yy
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD yy
            #add-point:ON ACTION controlp INFIELD yy name="input.c.yy"
            
            #END add-point
 
 
         #Ctrlp:input.c.mm
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mm
            #add-point:ON ACTION controlp INFIELD mm name="input.c.mm"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg005
            #add-point:ON ACTION controlp INFIELD fabg005 name="input.c.fabg005"
            
            #END add-point
 
 
         #Ctrlp:input.c.docno_509
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD docno_509
            #add-point:ON ACTION controlp INFIELD docno_509 name="input.c.docno_509"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            #檢查主鍵重複
            IF NOT afat509_01_chk_id() THEN
               LET g_fabg_m.fabgdocdt = g_fabgdocdt_t
               LET g_fabg_m.yy = YEAR(g_fabg_m.fabgdocdt)
               LET g_fabg_m.mm = MONTH(g_fabg_m.fabgdocdt)
               DISPLAY BY NAME g_fabg_m.fabgdocdt,g_fabg_m.yy,g_fabg_m.mm
               NEXT FIELD fabgdocdt
            END IF 
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
      EXIT WHILE
   ELSE
      #檢查主鍵重複
      IF NOT afat509_01_chk_id() THEN
         CONTINUE WHILE
      END IF 
      #根据录入条件产生资产折旧资料
      CALL afat509_01_ins_fabg()
      DISPLAY BY NAME g_fabg_m.docno_509
      IF NOT cl_null(g_fabg_m.docno_509) THEN
         IF cl_ask_confirm('apm-00285') THEN
            CONTINUE WHILE
         ELSE
            EXIT WHILE
         END IF
      END IF
      CONTINUE WHILE
   END IF
   END WHILE
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_afat509_01 
   
   #add-point:input段after input name="input.post_input"
   IF NOT cl_null(g_fabg_m.docno_509) THEN
      LET l_wc = " fabgld='",g_fabg_m.fabgld,"' AND fabgdocdt='",g_fabg_m.fabgdocdt,"'"
   ELSE
      LET l_wc = ''
   END IF
   RETURN l_wc
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afat509_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afat509_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 設置默認值
# Memo...........:
# Usage..........: CALL afat509_01_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/17 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION afat509_01_default()
   DEFINE l_sql          STRING
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_success      LIKE type_t.chr1
   DEFINE l_para_data    LIKE fabg_t.fabg004
   DEFINE l_year         LIKE type_t.num5
   DEFINE l_month        LIKE type_t.num5
   DEFINE l_flag1        LIKE type_t.chr1
   DEFINE l_errno        LIKE type_t.chr100
   DEFINE l_glav002      LIKE glav_t.glav002
   DEFINE l_glav005      LIKE glav_t.glav005
   DEFINE l_sdate_s      LIKE glav_t.glav004
   DEFINE l_sdate_e      LIKE glav_t.glav004
   DEFINE l_glav006      LIKE glav_t.glav006
   DEFINE l_glav007      LIKE glav_t.glav007
   DEFINE l_pdate_s      LIKE glav_t.glav004
   DEFINE l_pdate_e      LIKE glav_t.glav004
   DEFINE l_wdate_s      LIKE glav_t.glav004
   DEFINE l_wdate_e      LIKE glav_t.glav004
 
   CALL s_afat503_default(g_bookno) RETURNING l_success,g_fabg_m.fabgsite,g_fabg_m.fabgld,g_fabg_m.fabgcomp
   CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc
   CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
   LET g_fabg_m.fabg001   = g_user 
   #161111-00028#3---MODIFY----begin---------
   #SELECT * INTO g_glaa.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
           glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,
           glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,
           glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,
           glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.*
   #161111-00028#3---MODIFY----end--------- 
   FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
   IF cl_null(g_fabg_m.fabgsite) THEN
      LET g_fabg_m.fabg001 = NULL
   ELSE
      IF NOT s_afat502_site_user_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001) THEN 
         LET g_fabg_m.fabg001 = NULL
      END IF 
   END IF
   
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-9018') RETURNING l_year
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-9019') RETURNING l_month
   CALL s_get_accdate(g_glaa.glaa003,'',l_year,l_month) 
      RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e

   #人員名稱
   CALL s_desc_get_person_desc(g_fabg_m.fabg001) RETURNING g_fabg_m.fabg001_desc
   
   #申請人員、部門、時間
   LET g_fabg_m.fabg002=g_user
   LET g_fabg_m.fabg003=g_dept  
   LET g_fabg_m.fabgdocdt = ''
   CALL s_desc_get_person_desc(g_fabg_m.fabg002) RETURNING g_fabg_m.fabg002_desc 
   CALL s_desc_get_department_desc(g_fabg_m.fabg003) RETURNING g_fabg_m.fabg003_desc 
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-9003') RETURNING l_para_data
   IF g_today>=l_para_data THEN
      #单据日期
      LET g_fabg_m.fabgdocdt = l_pdate_e 
      #申請時間
      LET g_fabg_m.fabg004=g_today
   END IF
   LET g_fabg_m.yy = YEAR(g_fabg_m.fabgdocdt)
   LET g_fabg_m.mm = MONTH(g_fabg_m.fabgdocdt)
   #異動類型
   LET g_fabg_m.fabg005='0'
   #產生方式
   LET g_fabg_m.type='0'
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc,
                   g_fabg_m.fabgld,g_fabg_m.fabgld_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,
                   g_fabg_m.fabg003,g_fabg_m.fabg003_desc,g_fabg_m.fabg004,g_fabg_m.fabgdocdt,
                   g_fabg_m.yy,g_fabg_m.mm,g_fabg_m.fabg005,g_fabg_m.type
END FUNCTION

################################################################################
# Descriptions...: 檢查主機是否重複
# Memo...........:
# Usage..........: CALL afat509_01_chk_id()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/17 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION afat509_01_chk_id()
   DEFINE l_n      LIKE type_t.num5
   DEFINE l_first  LIKE fabg_t.fabgdocdt
   DEFINE l_last   LIKE fabg_t.fabgdocdt
   
   IF cl_null(g_fabg_m.fabgsite) OR cl_null(g_fabg_m.fabgld) OR cl_null(g_fabg_m.fabgdocdt) THEN 
      RETURN TRUE
   END IF 
   #获取当前月第一天
   CALL s_date_get_first_date(g_fabg_m.fabgdocdt) RETURNING l_first
   #获取当前月最后一天
   CALL s_date_get_last_date(g_fabg_m.fabgdocdt) RETURNING l_last 
   #检查同一帐套下是否已存在日期范围内单据
   SELECT COUNT(*) INTO l_n
     FROM fabg_t
    WHERE fabgent = g_enterprise
      AND fabgsite = g_fabg_m.fabgsite
      AND fabgld = g_fabg_m.fabgld
      AND fabg005 = '0'
      AND fabgdocdt BETWEEN l_first AND l_last
      AND fabgstus <> 'X'  
   IF l_n > 0 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ""
      LET g_errparam.code   = "afa-00320"
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 产生折旧异动单资料
# Memo...........:
# Usage..........: CALL afat509_01_ins_fabg()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION afat509_01_ins_fabg()
   #161111-00028#8----modify----begin--------- 
   #DEFINE l_fabg        RECORD LIKE fabg_t.*
   DEFINE l_fabg RECORD  #資產異動單頭檔(一帳套)
       fabgent LIKE fabg_t.fabgent, #企業編號
       fabgcomp LIKE fabg_t.fabgcomp, #法人
       fabgld LIKE fabg_t.fabgld, #帳套
       fabgdocno LIKE fabg_t.fabgdocno, #來源單號
       fabgdocdt LIKE fabg_t.fabgdocdt, #單據日期
       fabgsite LIKE fabg_t.fabgsite, #資產中心
       fabg001 LIKE fabg_t.fabg001, #帳務人員
       fabg002 LIKE fabg_t.fabg002, #申請人員
       fabg003 LIKE fabg_t.fabg003, #申請部門
       fabg004 LIKE fabg_t.fabg004, #申請日期
       fabg005 LIKE fabg_t.fabg005, #異動類型
       fabg006 LIKE fabg_t.fabg006, #帳款客戶
       fabg007 LIKE fabg_t.fabg007, #收款客戶
       fabg008 LIKE fabg_t.fabg008, #傳票號碼
       fabg009 LIKE fabg_t.fabg009, #傳票日期
       fabg010 LIKE fabg_t.fabg010, #所有組織
       fabg011 LIKE fabg_t.fabg011, #產生應收帳款編號
       fabg012 LIKE fabg_t.fabg012, #產生應付帳款編號
       fabg013 LIKE fabg_t.fabg013, #稅別
       fabg014 LIKE fabg_t.fabg014, #稅率
       fabg015 LIKE fabg_t.fabg015, #幣別
       fabg016 LIKE fabg_t.fabg016, #匯率
       fabg017 LIKE fabg_t.fabg017, #調撥流水碼
       fabg018 LIKE fabg_t.fabg018, #核算組織
       fabg019 LIKE fabg_t.fabg019, #來源單號
       fabgstus LIKE fabg_t.fabgstus, #狀態碼
       fabgownid LIKE fabg_t.fabgownid, #資料所有者
       fabgowndp LIKE fabg_t.fabgowndp, #資料所屬部門
       fabgcrtid LIKE fabg_t.fabgcrtid, #資料建立者
       fabgcrtdp LIKE fabg_t.fabgcrtdp, #資料建立部門
       fabgcrtdt LIKE fabg_t.fabgcrtdt, #資料創建日
       fabgmodid LIKE fabg_t.fabgmodid, #資料修改者
       fabgmoddt LIKE fabg_t.fabgmoddt, #最近修改日
       fabgcnfid LIKE fabg_t.fabgcnfid, #資料確認者
       fabgcnfdt LIKE fabg_t.fabgcnfdt, #資料確認日
       fabgpstid LIKE fabg_t.fabgpstid, #資料過帳者
       fabgpstdt LIKE fabg_t.fabgpstdt, #資料過帳日
       fabg020 LIKE fabg_t.fabg020 #資產性質
       END RECORD

   #161111-00028#8----modify----end---------
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_docno       STRING #产生的单据编号
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET g_success = 'Y'
   
   INITIALIZE l_fabg TO NULL
   LET l_fabg.fabgent=g_enterprise
   LET l_fabg.fabgcomp=g_fabg_m.fabgcomp
   LET l_fabg.fabgld=g_fabg_m.fabgld
   LET l_fabg.fabgdocdt=g_fabg_m.fabgdocdt
   LET l_fabg.fabgsite=g_fabg_m.fabgsite
   LET l_fabg.fabg001=g_fabg_m.fabg001
   LET l_fabg.fabg002=g_fabg_m.fabg002
   LET l_fabg.fabg003=g_fabg_m.fabg003
   LET l_fabg.fabg004=g_fabg_m.fabg004
   LET l_fabg.fabg005=g_fabg_m.fabg005
   LET l_fabg.fabg015=g_glaa.glaa001
   LET l_fabg.fabg016=1
   LET l_fabg.fabgstus='N'
   LET l_fabg.fabgownid = g_user
   LET l_fabg.fabgowndp = g_dept
   LET l_fabg.fabgcrtid = g_user
   LET l_fabg.fabgcrtdp = g_dept 
   LET l_fabg.fabgcrtdt = cl_get_current()
   LET l_fabg.fabgmodid = g_user
   LET l_fabg.fabgmoddt = cl_get_current()
   
   LET l_docno=''
   #当选择0：全部汇总时，只产生一笔异动单据；当选择1：按资产类型产生时，产生多笔异动单据
   IF g_fabg_m.type = '0' THEN
      LET l_fabg.fabg020='0'
      CALL s_aooi200_fin_gen_docno(g_fabg_m.fabgld,'','',g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_prog)
      RETURNING l_success,l_fabg.fabgdocno
      IF l_success  = 0  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = l_fabg.fabgdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success='N'
      END IF
      
      INSERT INTO fabg_t (fabgent,fabgsite,fabg001,fabgld,fabgcomp,
                          fabg020,fabg002,fabg003,fabg004,fabgdocno, 
                          fabgdocdt,fabg005,fabg008,fabg009,fabg015,
                          fabg016,fabgstus,fabgownid,fabgowndp,fabgcrtid, 
                          fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid,
                          fabgcnfdt,fabgpstid,fabgpstdt)
      VALUES (l_fabg.fabgent,l_fabg.fabgsite,l_fabg.fabg001,l_fabg.fabgld,l_fabg.fabgcomp, 
              l_fabg.fabg020,l_fabg.fabg002,l_fabg.fabg003,l_fabg.fabg004,l_fabg.fabgdocno, 
              l_fabg.fabgdocdt,l_fabg.fabg005,l_fabg.fabg008,l_fabg.fabg009,l_fabg.fabg015, 
              l_fabg.fabg016,l_fabg.fabgstus,l_fabg.fabgownid,l_fabg.fabgowndp,l_fabg.fabgcrtid, 
              l_fabg.fabgcrtdp,l_fabg.fabgcrtdt,l_fabg.fabgmodid,l_fabg.fabgmoddt,l_fabg.fabgcnfid, 
              l_fabg.fabgcnfdt,l_fabg.fabgpstid,l_fabg.fabgpstdt) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins fabg_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         LET g_success='N'
      END IF
      CALL afat509_01_ins_fabh(l_fabg.fabgdocno,l_fabg.fabg020) RETURNING l_success
      IF l_success = FALSE THEN
         LET g_success='N'
      END IF
      LET l_docno=l_fabg.fabgdocno
   ELSE
      #按章资产性质产生折旧异动单据
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM faam_t 
       WHERE faament = g_enterprise 
         AND faamld = g_fabg_m.fabgld
         AND faam004 = g_fabg_m.yy
         AND faam005 = g_fabg_m.mm
         AND faam024 IS NOT NULL
      
      LET l_sql="SELECT UNIQUE faah005 ",
                "  FROM faam_t,faah_t",
                " WHERE faahent = faament AND faah003 = faam001 AND faah004 = faam002 ",
                "   AND faah001 = faam000 AND faament= '",g_enterprise,"'",
                "   AND faamld = '",g_fabg_m.fabgld,"'",
                "   AND faam004 = ",g_fabg_m.yy,
                "   AND faam005 = ",g_fabg_m.mm,
                "   AND (faam007 = '1' OR faam007 = '3')" ,              
                "   AND faah032 = '",g_fabg_m.fabgcomp,"'" 
      IF l_n > 0 THEN
         LET l_sql = l_sql CLIPPED," AND faam024 IS NOT NULL"
      ELSE
         LET l_sql = l_sql CLIPPED
      END IF
      LET l_sql = l_sql CLIPPED," ORDER BY faah005"
      PREPARE afat509_01_faah005_pr FROM l_sql
      DECLARE afat509_01_faah005_cs CURSOR FOR afat509_01_faah005_pr
      
      FOREACH afat509_01_faah005_cs INTO l_fabg.fabg020
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'faam_cur:' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success='N'
            EXIT FOREACH
         END IF
         CALL s_aooi200_fin_gen_docno(g_fabg_m.fabgld,'','',g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_prog)
         RETURNING l_success,l_fabg.fabgdocno
         IF l_success  = 0  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00003'
            LET g_errparam.extend = l_fabg.fabgdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success='N'
         END IF
         
         INSERT INTO fabg_t (fabgent,fabgsite,fabg001,fabgld,fabgcomp,
                             fabg020,fabg002,fabg003,fabg004,fabgdocno, 
                             fabgdocdt,fabg005,fabg008,fabg009,fabg015,
                             fabg016,fabgstus,fabgownid,fabgowndp,fabgcrtid, 
                             fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid,
                             fabgcnfdt,fabgpstid,fabgpstdt)
         VALUES (l_fabg.fabgent,l_fabg.fabgsite,l_fabg.fabg001,l_fabg.fabgld,l_fabg.fabgcomp, 
                 l_fabg.fabg020,l_fabg.fabg002,l_fabg.fabg003,l_fabg.fabg004,l_fabg.fabgdocno, 
                 l_fabg.fabgdocdt,l_fabg.fabg005,l_fabg.fabg008,l_fabg.fabg009,l_fabg.fabg015, 
                 l_fabg.fabg016,l_fabg.fabgstus,l_fabg.fabgownid,l_fabg.fabgowndp,l_fabg.fabgcrtid, 
                 l_fabg.fabgcrtdp,l_fabg.fabgcrtdt,l_fabg.fabgmodid,l_fabg.fabgmoddt,l_fabg.fabgcnfid, 
                 l_fabg.fabgcnfdt,l_fabg.fabgpstid,l_fabg.fabgpstdt) 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ins fabg_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            LET g_success='N'
         END IF
         CALL afat509_01_ins_fabh(l_fabg.fabgdocno,l_fabg.fabg020) RETURNING l_success
         IF l_success = FALSE THEN
            LET g_success='N'
         END IF
         IF cl_null(l_docno) THEN
            LET l_docno=l_fabg.fabgdocno
         END IF
      END FOREACH
      IF l_docno<>l_fabg.fabgdocno THEN
         LET l_docno=l_docno,"~",l_fabg.fabgdocno
      END IF
   END IF
   IF cl_null(l_docno) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 'agl-00167' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      LET  g_success = 'N'      
   END IF
   
   CALL cl_err_collect_show()
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','1')
      LET g_fabg_m.docno_509=l_docno
   ELSE
      CALL s_transaction_end('N','1')
      LET g_fabg_m.docno_509=NULL
   END IF
END FUNCTION

################################################################################
# Descriptions...: 产生单身资料
# Memo...........:
# Usage..........: CALL afat509_01_ins_fabh(p_fabgdocno,p_fabg020)
#                  RETURNING r_success
# Input parameter: p_fabgdocno    折旧单号
#                : p_fabg020      汇总方式
# Return code....: r_success      执行结果TRUE/FALSE
# Date & Author..: 2016/10/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION afat509_01_ins_fabh(p_fabgdocno,p_fabg020)
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_fabg020        LIKE fabg_t.fabg020
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_n              LIKE type_t.num5
   #161111-00028#8----modify----begin---------
   #DEFINE l_fabh           RECORD LIKE fabh_t.*
   DEFINE l_fabh RECORD  #資產異動單身檔
       fabhent LIKE fabh_t.fabhent, #企業編號
       fabhld LIKE fabh_t.fabhld, #帳套
       fabhsite LIKE fabh_t.fabhsite, #營運據點
       fabhdocno LIKE fabh_t.fabhdocno, #異動單號
       fabhseq LIKE fabh_t.fabhseq, #項次
       fabh000 LIKE fabh_t.fabh000, #卡片編號
       fabh001 LIKE fabh_t.fabh001, #財產編號
       fabh002 LIKE fabh_t.fabh002, #附號
       fabh003 LIKE fabh_t.fabh003, #資產狀態
       fabh004 LIKE fabh_t.fabh004, #未折減餘額
       fabh005 LIKE fabh_t.fabh005, #單位
       fabh006 LIKE fabh_t.fabh006, #數量
       fabh007 LIKE fabh_t.fabh007, #處置數量
       fabh008 LIKE fabh_t.fabh008, #成本
       fabh009 LIKE fabh_t.fabh009, #累計調整成本
       fabh010 LIKE fabh_t.fabh010, #調整成本/公允價值
       fabh011 LIKE fabh_t.fabh011, #累折
       fabh012 LIKE fabh_t.fabh012, #重估累計折舊
       fabh013 LIKE fabh_t.fabh013, #未用年限
       fabh014 LIKE fabh_t.fabh014, #重估未用年限
       fabh015 LIKE fabh_t.fabh015, #預留殘值
       fabh016 LIKE fabh_t.fabh016, #重估預留殘值
       fabh017 LIKE fabh_t.fabh017, #已計提減值準備
       fabh018 LIKE fabh_t.fabh018, #異動
       fabh019 LIKE fabh_t.fabh019, #減值準備金額
       fabh020 LIKE fabh_t.fabh020, #異動原因
       fabh021 LIKE fabh_t.fabh021, #異動科目
       fabh022 LIKE fabh_t.fabh022, #調整成本
       fabh023 LIKE fabh_t.fabh023, #累計折舊科目
       fabh024 LIKE fabh_t.fabh024, #資產科目
       fabh025 LIKE fabh_t.fabh025, #減值準備科目
       fabh026 LIKE fabh_t.fabh026, #營運據點
       fabh027 LIKE fabh_t.fabh027, #部門
       fabh028 LIKE fabh_t.fabh028, #利潤/成本中心
       fabh029 LIKE fabh_t.fabh029, #區域
       fabh030 LIKE fabh_t.fabh030, #交易客商
       fabh031 LIKE fabh_t.fabh031, #帳款客商
       fabh032 LIKE fabh_t.fabh032, #客群
       fabh033 LIKE fabh_t.fabh033, #人員
       fabh034 LIKE fabh_t.fabh034, #專案編號
       fabh035 LIKE fabh_t.fabh035, #WBS
       fabh036 LIKE fabh_t.fabh036, #摘要
       fabh037 LIKE fabh_t.fabh037, #來源編號
       fabh038 LIKE fabh_t.fabh038, #來源項次
       fabh039 LIKE fabh_t.fabh039, #盤點編號
       fabh040 LIKE fabh_t.fabh040, #盤點序號
       fabh041 LIKE fabh_t.fabh041, #經營方式
       fabh042 LIKE fabh_t.fabh042, #通路
       fabh043 LIKE fabh_t.fabh043, #品牌
       fabh060 LIKE fabh_t.fabh060, #自由核算項一
       fabh061 LIKE fabh_t.fabh061, #自由核算項二
       fabh062 LIKE fabh_t.fabh062, #自由核算項三
       fabh063 LIKE fabh_t.fabh063, #自由核算項四
       fabh064 LIKE fabh_t.fabh064, #自由核算項五
       fabh065 LIKE fabh_t.fabh065, #自由核算項六
       fabh066 LIKE fabh_t.fabh066, #自由核算項七
       fabh067 LIKE fabh_t.fabh067, #自由核算項八
       fabh068 LIKE fabh_t.fabh068, #自由核算項九
       fabh069 LIKE fabh_t.fabh069, #自由核算項十
       fabh100 LIKE fabh_t.fabh100, #本位幣二幣別
       fabh101 LIKE fabh_t.fabh101, #本位幣二匯率
       fabh102 LIKE fabh_t.fabh102, #本位幣二成本
       fabh103 LIKE fabh_t.fabh103, #本位幣二調整成本
       fabh104 LIKE fabh_t.fabh104, #本位幣二累折
       fabh105 LIKE fabh_t.fabh105, #本位幣二重估累折
       fabh106 LIKE fabh_t.fabh106, #本位幣二預留殘值
       fabh107 LIKE fabh_t.fabh107, #本位幣二重估殘值
       fabh108 LIKE fabh_t.fabh108, #本位幣二未折減額
       fabh109 LIKE fabh_t.fabh109, #本位幣二已計提減值準備
       fabh110 LIKE fabh_t.fabh110, #本位幣二減值準備金額
       fabh150 LIKE fabh_t.fabh150, #本位幣三幣別
       fabh151 LIKE fabh_t.fabh151, #本位幣三匯率
       fabh152 LIKE fabh_t.fabh152, #本位幣三成本
       fabh153 LIKE fabh_t.fabh153, #本位幣三調整成本
       fabh154 LIKE fabh_t.fabh154, #本位幣三累折
       fabh155 LIKE fabh_t.fabh155, #本位幣三重估累折
       fabh156 LIKE fabh_t.fabh156, #本位幣三預留殘值
       fabh157 LIKE fabh_t.fabh157, #本位幣三重估殘值
       fabh158 LIKE fabh_t.fabh158, #本位幣三未折減額
       fabh159 LIKE fabh_t.fabh159, #本位幣三已計提減值準備
       fabh160 LIKE fabh_t.fabh160, #本位幣三減值準備金額
       fabh070 LIKE fabh_t.fabh070, #累計折舊科目(舊)
       fabh071 LIKE fabh_t.fabh071, #資產科目(舊)
       fabh072 LIKE fabh_t.fabh072, #減值準備科目(舊)
       fabh073 LIKE fabh_t.fabh073, #處置本年累折
       fabh111 LIKE fabh_t.fabh111, #本位幣二處置本年累折
       fabh161 LIKE fabh_t.fabh161, #本位幣三處置本年累折
       fabh074 LIKE fabh_t.fabh074, #保險費用科目
       fabh075 LIKE fabh_t.fabh075, #主要類別
       fabh076 LIKE fabh_t.fabh076  #主要類別新
       END RECORD
   #161111-00028#8----modify----end---------
   DEFINE l_faaj012        LIKE faaj_t.faaj012
   DEFINE l_faaj013        LIKE faaj_t.faaj013
   DEFINE l_faah006        LIKE faah_t.faah006
   DEFINE l_str            STRING 
   DEFINE l_faaj006        LIKE faaj_t.faaj006
   DEFINE l_faaj007        LIKE faaj_t.faaj007
   DEFINE l_faaj025        LIKE faaj_t.faaj025      
   DEFINE l_para_data      LIKE type_t.chr10  
   DEFINE l_sql            STRING
   
   INITIALIZE l_fabh TO NULL
   LET r_success = TRUE
   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM faam_t 
    WHERE faament = g_enterprise 
      AND faamld = g_fabg_m.fabgld
      AND faam004 = g_fabg_m.yy
      AND faam005 = g_fabg_m.mm
      AND faam024 IS NOT NULL
      
   LET l_sql = "SELECT  UNIQUE faam001,faam002,faam000,faah015,faam014,faah017,faah018,faam013,faam015,faah006,faam018,faam022,faam021, ", 
               "               faam020,faam023,faam028,faam029,faam030,faam031,faam032,faam033,faam034,faam035,faam036,",
               "               faam101,faam102,faam103,faam104,faam105,faam108,",
               "               faam151,faam152,faam153,faam154,faam155,faam158,faam009 ",
               "  FROM faam_t,faah_t",
               " WHERE faahent = faament AND faah003 = faam001 AND faah004 = faam002 ",
               "   AND faah001 = faam000 AND faament= '",g_enterprise,"'",
               "   AND faamld = '",g_fabg_m.fabgld,"'",
               "   AND faam004 = ",g_fabg_m.yy,
               "   AND faam005 = ",g_fabg_m.mm,
               "   AND (faam007 = '1' OR faam007 = '3')" ,              
               "   AND faah032 = '",g_fabg_m.fabgcomp,"'" 
   IF l_n > 0 THEN
      LET l_sql = l_sql CLIPPED," AND faam024 IS NOT NULL"
   ELSE
      LET l_sql = l_sql CLIPPED
   END IF

   #當按照資產性質產生折舊時，加入資產性質條件
   IF p_fabg020 <> '0' THEN
      LET l_sql = l_sql," AND faah005 = ",p_fabg020
   END IF
   
   LET l_para_data = NULL
   CALL cl_get_para(g_enterprise,g_fabg_m.fabgcomp,'S-FIN-9009') RETURNING l_para_data 
   
   LET l_n = 1
   PREPARE afat509_01_sel_pr FROM l_sql
   DECLARE afat509_01_sel_cs CURSOR FOR afat509_01_sel_pr
   FOREACH afat509_01_sel_cs INTO l_fabh.fabh001,l_fabh.fabh002,l_fabh.fabh000,l_fabh.fabh003,
                         l_fabh.fabh008,l_fabh.fabh005,l_fabh.fabh006,l_fabh.fabh010,
                         l_fabh.fabh011,l_faah006,l_fabh.fabh017,l_fabh.fabh021,l_fabh.fabh023,l_fabh.fabh024,l_fabh.fabh025,
                         l_fabh.fabh027,l_fabh.fabh028,l_fabh.fabh029,l_fabh.fabh030,
                         l_fabh.fabh031,l_fabh.fabh032,l_fabh.fabh033,l_fabh.fabh034,l_fabh.fabh035,
                         l_fabh.fabh100,l_fabh.fabh101,l_fabh.fabh102,l_fabh.fabh104,l_fabh.fabh105,l_fabh.fabh108,
                         l_fabh.fabh150,l_fabh.fabh151,l_fabh.fabh152,l_fabh.fabh154,l_fabh.fabh155,l_fabh.fabh158,
                         l_fabh.fabh027
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'afat509_01_sel_cs:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success=FALSE
         EXIT FOREACH
      END IF
      LET l_fabh.fabhseq = l_n
      LET l_fabh.fabhent = g_enterprise
      LET l_fabh.fabhld = g_fabg_m.fabgld
      LET l_fabh.fabhsite = g_fabg_m.fabgsite
      LET l_fabh.fabhdocno = p_fabgdocno
      LET l_fabh.fabh009 = 0
      LET l_fabh.fabh004 = l_fabh.fabh008 - l_fabh.fabh011
      LET l_fabh.fabh007 = 0
      LET l_fabh.fabh012 = l_fabh.fabh011
      LET l_fabh.fabh013 = NULL
      LET l_fabh.fabh014 = NULL
      LET l_fabh.fabh016 = l_fabh.fabh015
      LET l_fabh.fabh018 = NULL
      LET l_fabh.fabh019 = 0
      LET l_str = cl_getmsg_parm("afa-00421", g_lang, g_fabg_m.yy || "|" || g_fabg_m.mm)
      LET l_fabh.fabh036 = l_str.trim()
      IF l_fabh.fabh003='7' THEN
         SELECT faaj012,faaj013 INTO l_faaj012,l_faaj013
           FROM faaj_t
          WHERE faajent = g_enterprise
            AND faajld = g_fabg_m.fabgld
            AND faaj001 = l_fabh.fabh001
            AND faaj002 = l_fabh.fabh002
            AND faaj037 = l_fabh.fabh000
         LET l_fabh.fabh013 = l_faaj012
         LET l_fabh.fabh015 = l_faaj013
      END IF
      IF cl_null(l_fabh.fabh017) THEN 
         LET l_fabh.fabh017 = 0
      END IF 
     
     ####多部门分摊则fabh021为famm022,以下为单一部门分摊，需要重新取值
     #资产：抓faaj007;部门：抓afai050
     IF g_fabg_m.fabg005 = '0' THEN
        LET l_faaj006 = NULL
        LET l_faaj007 = NULL
        LET l_faah006 = NULL                  
        SELECT faaj006,faaj007,faaj025,faah006 
          INTO l_faaj006,l_faaj007,l_faaj025,l_faah006 
          FROM faah_t,faaj_t  
         WHERE faaj001=faah003 AND faaj002=faah004 AND faaj037=faah001 AND faajent=faahent
           AND faahent=g_enterprise 
           AND faajld=g_fabg_m.fabgld  AND faaj001=l_fabh.fabh001 AND faaj002=l_fabh.fabh002
           AND faaj037=l_fabh.fabh000
        
        IF l_faaj006 = '1' THEN #单一部门 
           IF l_para_data = '2' THEN 
              #资产
              LET l_fabh.fabh021 = l_faaj025
           ELSE
              #部门
              SELECT faae003 INTO l_fabh.fabh021 FROM faae_t
               WHERE faaeent = g_enterprise AND faaeld = g_fabg_m.fabgld
                 AND faae001 = l_faaj007 AND faae002 = l_faah006 
           END IF
        END IF              
     END IF
     
     SELECT faajsite INTO l_fabh.fabh026
       FROM faaj_t
      WHERE faajent=g_enterprise
        AND faaj001 = l_fabh.fabh001 AND faaj002 = l_fabh.fabh002 AND faaj037 = l_fabh.fabh000
        AND faajld = g_fabg_m.fabgld                
      
      #161111-00028#8----modify----begin---------
      #INSERT INTO fabh_t VALUES(l_fabh.*)
      INSERT INTO fabh_t (fabhent,fabhld,fabhsite,fabhdocno,fabhseq,fabh000,fabh001,fabh002,fabh003,fabh004,
                          fabh005,fabh006,fabh007,fabh008,fabh009,fabh010,fabh011,fabh012,fabh013,fabh014,
                          fabh015,fabh016,fabh017,fabh018,fabh019,fabh020,fabh021,fabh022,fabh023,fabh024,
                          fabh025,fabh026,fabh027,fabh028,fabh029,fabh030,fabh031,fabh032,fabh033,fabh034,
                          fabh035,fabh036,fabh037,fabh038,fabh039,fabh040,fabh041,fabh042,fabh043,fabh060,
                          fabh061,fabh062,fabh063,fabh064,fabh065,fabh066,fabh067,fabh068,fabh069,fabh100,
                          fabh101,fabh102,fabh103,fabh104,fabh105,fabh106,fabh107,fabh108,fabh109,fabh110,
                          fabh150,fabh151,fabh152,fabh153,fabh154,fabh155,fabh156,fabh157,fabh158,fabh159,
                          fabh160,fabh070,fabh071,fabh072,fabh073,fabh111,fabh161,fabh074,fabh075,fabh076)
       VALUES(l_fabh.fabhent,l_fabh.fabhld,l_fabh.fabhsite,l_fabh.fabhdocno,l_fabh.fabhseq,l_fabh.fabh000,l_fabh.fabh001,l_fabh.fabh002,l_fabh.fabh003,l_fabh.fabh004,
              l_fabh.fabh005,l_fabh.fabh006,l_fabh.fabh007,l_fabh.fabh008,l_fabh.fabh009,l_fabh.fabh010,l_fabh.fabh011,l_fabh.fabh012,l_fabh.fabh013,l_fabh.fabh014,
              l_fabh.fabh015,l_fabh.fabh016,l_fabh.fabh017,l_fabh.fabh018,l_fabh.fabh019,l_fabh.fabh020,l_fabh.fabh021,l_fabh.fabh022,l_fabh.fabh023,l_fabh.fabh024,
              l_fabh.fabh025,l_fabh.fabh026,l_fabh.fabh027,l_fabh.fabh028,l_fabh.fabh029,l_fabh.fabh030,l_fabh.fabh031,l_fabh.fabh032,l_fabh.fabh033,l_fabh.fabh034,
              l_fabh.fabh035,l_fabh.fabh036,l_fabh.fabh037,l_fabh.fabh038,l_fabh.fabh039,l_fabh.fabh040,l_fabh.fabh041,l_fabh.fabh042,l_fabh.fabh043,l_fabh.fabh060,
              l_fabh.fabh061,l_fabh.fabh062,l_fabh.fabh063,l_fabh.fabh064,l_fabh.fabh065,l_fabh.fabh066,l_fabh.fabh067,l_fabh.fabh068,l_fabh.fabh069,l_fabh.fabh100,
              l_fabh.fabh101,l_fabh.fabh102,l_fabh.fabh103,l_fabh.fabh104,l_fabh.fabh105,l_fabh.fabh106,l_fabh.fabh107,l_fabh.fabh108,l_fabh.fabh109,l_fabh.fabh110,
              l_fabh.fabh150,l_fabh.fabh151,l_fabh.fabh152,l_fabh.fabh153,l_fabh.fabh154,l_fabh.fabh155,l_fabh.fabh156,l_fabh.fabh157,l_fabh.fabh158,l_fabh.fabh159,
              l_fabh.fabh160,l_fabh.fabh070,l_fabh.fabh071,l_fabh.fabh072,l_fabh.fabh073,l_fabh.fabh111,l_fabh.fabh161,l_fabh.fabh074,l_fabh.fabh075,l_fabh.fabh076)
      #161111-00028#8----modify----end---------
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabh_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      LET l_n = l_n + 1
   END FOREACH 
   LET l_n = l_n - 1
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = p_fabgdocno 
      LET g_errparam.code   = 'axr-00241' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE     
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
