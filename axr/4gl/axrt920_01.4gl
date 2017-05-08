#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt920_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-10-28 14:50:46), PR版次:0004(2016-12-05 14:06:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000124
#+ Filename...: axrt920_01
#+ Description: 依幣別更新重評匯率
#+ Creator....: 01727(2014-04-23 11:22:40)
#+ Modifier...: 02114 -SD/PR- 02481
 
{</section>}
 
{<section id="axrt920_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#12   2016/04/26 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#161128-00061#5    2016/12/05 by 02481       标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_xreb_m        RECORD
       xrebld LIKE xreb_t.xrebld, 
   xrebld_desc LIKE type_t.chr80, 
   lbl_comb LIKE type_t.chr500, 
   ooai001 LIKE type_t.chr500, 
   xreb001 LIKE xreb_t.xreb001, 
   xreb002 LIKE xreb_t.xreb002, 
   xreb100 LIKE xreb_t.xreb100, 
   xreb101 LIKE xreb_t.xreb101, 
   xreb006 LIKE xreb_t.xreb006, 
   xreb007 LIKE xreb_t.xreb007, 
   xreb005 LIKE xreb_t.xreb005
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#161128-00061#5-----modify--begin----------
#DEFINE g_glaa_t              RECORD LIKE glaa_t.* 
DEFINE g_glaa_t  RECORD  #帳套資料檔
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
#161128-00061#5-----modify--end----------
DEFINE g_xreb_t        type_g_xreb_m
#end add-point
 
DEFINE g_xreb_m        type_g_xreb_m
 
   DEFINE g_xrebld_t LIKE xreb_t.xrebld
DEFINE g_xreb001_t LIKE xreb_t.xreb001
DEFINE g_xreb002_t LIKE xreb_t.xreb002
DEFINE g_xreb006_t LIKE xreb_t.xreb006
DEFINE g_xreb007_t LIKE xreb_t.xreb007
DEFINE g_xreb005_t LIKE xreb_t.xreb005
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrt920_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axrt920_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xrebld,p_xreb001,p_xreb002
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
   DEFINE p_xrebld        LIKE xreb_t.xrebld
   DEFINE p_xreb001       LIKE xreb_t.xreb001
   DEFINE p_xreb002       LIKE xreb_t.xreb002
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_ooag003       LIKE ooag_t.ooag003
   DEFINE l_date          LIKE type_t.dat
   DEFINE l_ooab002       LIKE ooab_t.ooab002
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axrt920_01 WITH FORM cl_ap_formpath("axr","axrt920_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   #161128-00061#5-----modify--begin----------
   #SELECT * INTO g_glaa_t.* 
   SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
          glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
          glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
          glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
          glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
          glaa140,glaa123,glaa124,glaa028 INTO g_glaa_t.* 
  #161128-00061#5----modify--end---
   FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_xrebld
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xreb_m.xrebld,g_xreb_m.lbl_comb,g_xreb_m.ooai001,g_xreb_m.xreb001,g_xreb_m.xreb002, 
          g_xreb_m.xreb100,g_xreb_m.xreb101 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_xreb_m.xrebld  = g_glaa_t.glaald
            CALL axrt920_01_xreb_ref('xrebld')
            LET g_xreb_m.lbl_comb= '0'
            LET g_xreb_m.ooai001 = g_glaa_t.glaa001
            LET g_xreb_m.xreb001 = p_xreb001
            LET g_xreb_m.xreb002 = p_xreb002
            LET l_date = axrt920_01_get_date(g_xreb_m.xreb001,g_xreb_m.xreb002,g_glaa_t.glaa003)
            DISPLAY BY NAME g_xreb_m.xrebld,g_xreb_m.lbl_comb,g_xreb_m.ooai001,g_xreb_m.xreb001,g_xreb_m.xreb002
            LET g_xreb_t.* = g_xreb_m.*
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrebld
            
            #add-point:AFTER FIELD xrebld name="input.a.xrebld"
            LET g_xreb_m.xrebld_desc = ' '
            DISPLAY BY NAME g_xreb_m.xrebld_desc
            IF NOT cl_null(g_xreb_m.xrebld) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_xreb_m.xrebld
               LET g_chkparam.arg2 = ' '
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#12--add--end
               IF NOT cl_chk_exist("v_glaald_1") THEN
                  LET g_xreb_m.xrebld = ''
                  CALL axrt920_01_xreb_ref('xrebld')
                  NEXT FIELD CURRENT
               END IF
               #資料邏輯正確性檢查
               CALL s_ld_chk_authorization(g_user,g_xreb_m.xrebld) RETURNING l_success
               IF l_success = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00022'
                  LET g_errparam.extend = g_xreb_m.xrebld
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xreb_m.xrebld = ''
                  CALL axrt920_01_xreb_ref('xrebld')
                  NEXT FIELD CURRENT
               END IF
              #161128-00061#5-----modify--begin----------
              #SELECT * INTO g_glaa_t.* 
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                      glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                      glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                      glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                      glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                      glaa140,glaa123,glaa124,glaa028 INTO g_glaa_t.* 
              #161128-00061#5----modify--end---
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xreb_m.xrebld
               CASE
                  WHEN g_xreb_m.lbl_comb = '0'
                     LET g_xreb_m.ooai001 = g_glaa_t.glaa001
                  WHEN g_xreb_m.lbl_comb = '1'
                     LET g_xreb_m.ooai001 = g_glaa_t.glaa016
                  WHEN g_xreb_m.lbl_comb = '2'
                     LET g_xreb_m.ooai001 = g_glaa_t.glaa020
               END CASE
               DISPLAY BY NAME g_xreb_m.ooai001
               IF cl_null(g_xreb_t.xrebld) OR g_xreb_t.xrebld <> g_xreb_m.xrebld THEN
                  CALL axrt920_01_ref_cur()
               END IF
            END IF
            CALL axrt920_01_xreb_ref('xrebld')
            LET g_xreb_t.xrebld = g_xreb_m.xrebld
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrebld
            #add-point:BEFORE FIELD xrebld name="input.b.xrebld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrebld
            #add-point:ON CHANGE xrebld name="input.g.xrebld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_comb
            #add-point:BEFORE FIELD lbl_comb name="input.b.lbl_comb"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_comb
            
            #add-point:AFTER FIELD lbl_comb name="input.a.lbl_comb"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_comb
            #add-point:ON CHANGE lbl_comb name="input.g.lbl_comb"
            CASE
               WHEN g_xreb_m.lbl_comb = '0'
                  LET g_xreb_m.ooai001 = g_glaa_t.glaa001
               WHEN g_xreb_m.lbl_comb = '1'
                  LET g_xreb_m.ooai001 = g_glaa_t.glaa016
               WHEN g_xreb_m.lbl_comb = '2'
                  LET g_xreb_m.ooai001 = g_glaa_t.glaa020
            END CASE
            DISPLAY BY NAME g_xreb_m.ooai001
            CALL axrt920_01_ref_cur()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooai001
            #add-point:BEFORE FIELD ooai001 name="input.b.ooai001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooai001
            
            #add-point:AFTER FIELD ooai001 name="input.a.ooai001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooai001
            #add-point:ON CHANGE ooai001 name="input.g.ooai001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreb001
            #add-point:BEFORE FIELD xreb001 name="input.b.xreb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreb001
            
            #add-point:AFTER FIELD xreb001 name="input.a.xreb001"
            IF NOT cl_null(g_xreb_m.xreb001) AND NOT cl_null(g_xreb_m.xreb002) THEN
               LET l_date = axrt920_01_get_date(g_xreb_m.xreb001,g_xreb_m.xreb002,g_glaa_t.glaa003)
               IF l_date <= g_glaa_t.glaa013 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00117'
                  LET g_errparam.extend = g_xreb_m.xreb001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               SELECT COUNT(*) INTO l_count FROM xref_t WHERE xrefent = g_enterprise
                  AND xrefld = g_xreb_m.xrebld
                  AND xref001= g_xreb_m.xreb001
                  AND xref002= g_xreb_m.xreb002
                  AND xref005 IS NOT NULL
               IF l_count > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00118'
                  LET g_errparam.extend = g_xreb_m.xreb001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               IF cl_null(g_xreb_t.xreb001) OR g_xreb_t.xreb001 <> g_xreb_m.xreb001 THEN
                  CALL axrt920_01_ref_cur()
               END IF
            END IF
            LET g_xreb_t.xreb001 = g_xreb_m.xreb001
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreb001
            #add-point:ON CHANGE xreb001 name="input.g.xreb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreb002
            #add-point:BEFORE FIELD xreb002 name="input.b.xreb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreb002
            
            #add-point:AFTER FIELD xreb002 name="input.a.xreb002"
            IF NOT cl_null(g_xreb_m.xreb001) AND NOT cl_null(g_xreb_m.xreb002) THEN
               LET l_date = axrt920_01_get_date(g_xreb_m.xreb001,g_xreb_m.xreb002,g_glaa_t.glaa003)
               IF l_date <= g_glaa_t.glaa013 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00117'
                  LET g_errparam.extend = l_date
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               SELECT COUNT(*) INTO l_count FROM xreb_t WHERE xrebent = g_enterprise
                  AND xrebld = g_xreb_m.xrebld
                  AND xreb001= g_xreb_m.xreb001
                  AND xreb002= g_xreb_m.xreb002
                  AND xreb035 IS NOT NULL
               IF l_count > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00118'
                  LET g_errparam.extend = g_xreb_m.xreb001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               IF cl_null(g_xreb_t.xreb002) OR g_xreb_t.xreb002 <> g_xreb_m.xreb002 THEN
                  CALL axrt920_01_ref_cur()
               END IF
            END IF
            LET g_xreb_t.xreb002 = g_xreb_m.xreb002
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreb002
            #add-point:ON CHANGE xreb002 name="input.g.xreb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreb100
            #add-point:BEFORE FIELD xreb100 name="input.b.xreb100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreb100
            
            #add-point:AFTER FIELD xreb100 name="input.a.xreb100"
            IF NOT cl_null(g_xreb_m.xreb100) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_glaa_t.glaa026
               LET g_chkparam.arg2 = g_xreb_m.xreb100
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#12--add--end
               IF NOT cl_chk_exist("v_ooaj002_1") THEN
                  LET g_xreb_m.xreb100 = ''
                  NEXT FIELD CURRENT
               END IF
               IF cl_null(g_xreb_t.xreb100) OR g_xreb_t.xreb100 <> g_xreb_m.xreb100 THEN
                  CALL axrt920_01_ref_cur()
               END IF
            END IF
            LET g_xreb_t.xreb100 = g_xreb_m.xreb100
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreb100
            #add-point:ON CHANGE xreb100 name="input.g.xreb100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreb101
            #add-point:BEFORE FIELD xreb101 name="input.b.xreb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreb101
            
            #add-point:AFTER FIELD xreb101 name="input.a.xreb101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreb101
            #add-point:ON CHANGE xreb101 name="input.g.xreb101"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xrebld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrebld
            #add-point:ON ACTION controlp INFIELD xrebld name="input.c.xrebld"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.default1 = g_xreb_m.xrebld             #給予default值
            
            #給予arg
            SELECT ooag003 INTO l_ooag003 FROM ooag_t WHERE ooagent = g_enterprise
               AND ooag001 = g_user
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = l_ooag003

            CALL q_authorised_ld()                                #呼叫開窗
            
            LET g_xreb_m.xrebld = g_qryparam.return1              #將開窗取得的值回傳到變數
            
            DISPLAY g_xreb_m.xrebld TO xrebld                     #顯示到畫面上
            CALL axrt920_01_xreb_ref('xrebld')
            
            NEXT FIELD xrebld                                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.lbl_comb
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_comb
            #add-point:ON ACTION controlp INFIELD lbl_comb name="input.c.lbl_comb"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooai001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooai001
            #add-point:ON ACTION controlp INFIELD ooai001 name="input.c.ooai001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xreb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreb001
            #add-point:ON ACTION controlp INFIELD xreb001 name="input.c.xreb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xreb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreb002
            #add-point:ON ACTION controlp INFIELD xreb002 name="input.c.xreb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xreb100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreb100
            #add-point:ON ACTION controlp INFIELD xreb100 name="input.c.xreb100"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreb_m.xreb100             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_glaa_t.glaa026

            CALL q_ooaj002_4()                                     #呼叫開窗
            LET g_xreb_m.xreb100 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xreb_m.xreb100 TO xreb100                    #顯示到畫面上
            NEXT FIELD xreb100                                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xreb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreb101
            #add-point:ON ACTION controlp INFIELD xreb101 name="input.c.xreb101"
            
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
      CASE
         WHEN g_xreb_m.lbl_comb = '0'
            CALL axrt920_01_upd_1()
         WHEN g_xreb_m.lbl_comb = '1'
            CALL axrt920_01_upd_2()
         WHEN g_xreb_m.lbl_comb = '2'
            CALL axrt920_01_upd_3()
      END CASE
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_axrt920_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrt920_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axrt920_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt920_01_xreb_ref(p_lab)
   DEFINE p_lab         LIKE type_t.chr20

   CASE
      WHEN p_lab = 'xrebld'
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xreb_m.xrebld
         CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xreb_m.xrebld_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xreb_m.xrebld_desc
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axrt920_01_get_date(p_xreb001,p_xreb002,p_glaa003)
#                  RETURNING ---
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt920_01_get_date(p_xreb001,p_xreb002,p_glaa003)
   DEFINE p_xreb001         LIKE xreb_t.xreb001
   DEFINE p_xreb002         LIKE xreb_t.xreb002
   DEFINE p_glaa003         LIKE glaa_t.glaa003
   DEFINE r_glav004         LIKE glav_t.glav004

   SELECT MAX(glav004) INTO r_glav004 FROM glav_t WHERE glavent = g_enterprise
      AND glav001 = p_glaa003
      AND glav002 = p_xreb001
      AND glav006 = p_xreb002

   RETURN r_glav004

END FUNCTION

################################################################################
# Descriptions...: 更新本幣重評價匯率
# Memo...........:
# Usage..........: CALL axrt920_01_upd_1()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/04/24 By zhangwei
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt920_01_upd_1()
   DEFINE l_sql         STRING
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xreb        RECORD LIKE xreb_t.*
   DEFINE l_xreb RECORD  #重評價月結檔
       xrebent LIKE xreb_t.xrebent, #企業編號
       xrebcomp LIKE xreb_t.xrebcomp, #法人
       xrebsite LIKE xreb_t.xrebsite, #帳務中心
       xrebld LIKE xreb_t.xrebld, #帳套
       xreb001 LIKE xreb_t.xreb001, #年度
       xreb002 LIKE xreb_t.xreb002, #期別
       xreb003 LIKE xreb_t.xreb003, #來源模組
       xreb004 LIKE xreb_t.xreb004, #帳款單性質
       xreb005 LIKE xreb_t.xreb005, #單據號碼
       xreb006 LIKE xreb_t.xreb006, #項次
       xreb007 LIKE xreb_t.xreb007, #分期帳款序
       xreb008 LIKE xreb_t.xreb008, #立帳日期
       xreb009 LIKE xreb_t.xreb009, #帳款對象
       xreb010 LIKE xreb_t.xreb010, #收款對象
       xreb011 LIKE xreb_t.xreb011, #部門
       xreb012 LIKE xreb_t.xreb012, #責任中心
       xreb013 LIKE xreb_t.xreb013, #區域
       xreb014 LIKE xreb_t.xreb014, #客群
       xreb015 LIKE xreb_t.xreb015, #產品類別
       xreb016 LIKE xreb_t.xreb016, #人員
       xreb017 LIKE xreb_t.xreb017, #專案編號
       xreb018 LIKE xreb_t.xreb018, #WBS編號
       xreb019 LIKE xreb_t.xreb019, #應收科目
       xreborga LIKE xreb_t.xreborga, #來源組織
       xreb020 LIKE xreb_t.xreb020, #經營方式
       xreb021 LIKE xreb_t.xreb021, #通路
       xreb022 LIKE xreb_t.xreb022, #品牌
       xreb023 LIKE xreb_t.xreb023, #自由核算項一
       xreb024 LIKE xreb_t.xreb024, #自由核算項二
       xreb025 LIKE xreb_t.xreb025, #自由核算項三
       xreb026 LIKE xreb_t.xreb026, #自由核算項四
       xreb027 LIKE xreb_t.xreb027, #自由核算項五
       xreb028 LIKE xreb_t.xreb028, #自由核算項六
       xreb029 LIKE xreb_t.xreb029, #自由核算項七
       xreb030 LIKE xreb_t.xreb030, #自由核算項八
       xreb031 LIKE xreb_t.xreb031, #自由核算項九
       xreb032 LIKE xreb_t.xreb032, #自由核算項十
       xreb033 LIKE xreb_t.xreb033, #摘要
       xreb034 LIKE xreb_t.xreb034, #重評價會計科目
       xreb100 LIKE xreb_t.xreb100, #幣別
       xreb101 LIKE xreb_t.xreb101, #重評價匯率
       xreb102 LIKE xreb_t.xreb102, #上月重評匯率
       xreb103 LIKE xreb_t.xreb103, #本期原幣未沖金額
       xreb113 LIKE xreb_t.xreb113, #本期本幣未沖金額
       xreb114 LIKE xreb_t.xreb114, #本期重評價後本幣金額
       xreb115 LIKE xreb_t.xreb115, #本期匯差金額
       xreb116 LIKE xreb_t.xreb116, #本幣累計匯差
       xreb121 LIKE xreb_t.xreb121, #本位幣二重評價匯率
       xreb122 LIKE xreb_t.xreb122, #本位幣二上月重估匯率
       xreb123 LIKE xreb_t.xreb123, #本期本位幣二未沖金額
       xreb124 LIKE xreb_t.xreb124, #本期本位幣二重評價後金額
       xreb125 LIKE xreb_t.xreb125, #本期本位幣二匯差金額
       xreb126 LIKE xreb_t.xreb126, #本位幣二累計匯差
       xreb131 LIKE xreb_t.xreb131, #本位幣三重評價匯率
       xreb132 LIKE xreb_t.xreb132, #本位幣三上月重估匯率
       xreb133 LIKE xreb_t.xreb133, #本期本位幣三未沖金額
       xreb134 LIKE xreb_t.xreb134, #本期本位幣三重評價後金額
       xreb135 LIKE xreb_t.xreb135, #本期本位幣三匯差金額
       xreb136 LIKE xreb_t.xreb136 #本位幣三累計匯差
       END RECORD

   #161128-00061#5---modify----end------------- 
   DEFINE l_date        LIKE type_t.dat
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_xreb114     LIKE xreb_t.xreb114
   
   #161128-00061#5---modify----begin------------- 
   #LET l_sql = "SELECT * FROM xreb_t",
   LET l_sql = "SELECT xrebent,xrebcomp,xrebsite,xrebld,xreb001,xreb002,xreb003,xreb004,xreb005,",
               "xreb006,xreb007,xreb008,xreb009,xreb010,xreb011,xreb012,xreb013,xreb014,xreb015,",
               "xreb016,xreb017,xreb018,xreb019,xreborga,xreb020,xreb021,xreb022,xreb023,xreb024,",
               "xreb025,xreb026,xreb027,xreb028,xreb029,xreb030,xreb031,xreb032,xreb033,xreb034,",
               "xreb100,xreb101,xreb102,xreb103,xreb113,xreb114,xreb115,xreb116,xreb121,xreb122,",
               "xreb123,xreb124,xreb125,xreb126,xreb131,xreb132,xreb133,xreb134,xreb135,xreb136 FROM xreb_t",
   #161128-00061#5---modify----end------------- 
               " WHERE xrebent = '",g_enterprise,"'",
               "   AND xreb001 = '",g_xreb_m.xreb001,"'",
               "   AND xreb002 = '",g_xreb_m.xreb002,"'",
               "   AND xrebld  = '",g_xreb_m.xrebld,"'"
   PREPARE axrt920_01_prep FROM l_sql
   DECLARE axrt920_01_curs CURSOR FOR axrt920_01_prep

   #  xreb101	重評價匯率 = 條件式重評價匯率 
   #  xreb114	本期重評價後本幣金額  =xreb015 * xreb014 重評價匯率
   #  xreb115	本期匯差金額 =xreb113-xreb114 
   #  xrcc102	原幣重估後匯率    = xreb101 
   #  xrcc113	本幣重評價調整數  = xreb115 

   LET l_date = axrt920_01_get_date(g_xreb_m.xreb001,g_xreb_m.xreb002,g_glaa_t.glaa003)

   FOREACH axrt920_01_curs INTO l_xreb.*
      CALL s_axrt300_exrate(g_glaa_t.glaa002,l_date,g_xreb_m.xreb100,g_xreb_m.ooai001,l_xreb.xreb103,g_xreb_m.xreb101,g_glaa_t.glaacomp)
         RETURNING l_success,l_xreb114
      LET l_xreb.xreb101 = g_xreb_m.xreb101
      LET l_xreb.xreb114 = l_xreb114
      LET l_xreb.xreb115 = l_xreb.xreb113 - l_xreb.xreb114
      
      UPDATE xreb_t SET xreb101 = l_xreb.xreb101,
                        xreb114 = l_xreb.xreb114,
                        xreb115 = l_xreb.xreb115
       WHERE xrebent = g_enterprise
         AND xreb001 = l_xreb.xreb001
         AND xreb002 = l_xreb.xreb002
         AND xrebld  = l_xreb.xrebld
         AND xreb005 = l_xreb.xreb005
         AND xreb006 = l_xreb.xreb006
         AND xreb007 = l_xreb.xreb007

      UPDATE xrcc_t SET xrcc102 = l_xreb.xreb101,
                        xrcc113 = l_xreb.xreb115
       WHERE xrccent  = g_enterprise
         AND xrccdocno= l_xreb.xreb005
         AND xrccseq  = l_xreb.xreb006
         AND xrcc001  = l_xreb.xreb007
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 更新本幣二重評價匯率
# Memo...........:
# Usage..........: CALL axrt920_01_upd_2()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/04/24 By zhangwei
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt920_01_upd_2()
   DEFINE l_sql         STRING
      #161128-00061#5---modify----begin------------- 
   #DEFINE l_xreb        RECORD LIKE xreb_t.*
   DEFINE l_xreb RECORD  #重評價月結檔
       xrebent LIKE xreb_t.xrebent, #企業編號
       xrebcomp LIKE xreb_t.xrebcomp, #法人
       xrebsite LIKE xreb_t.xrebsite, #帳務中心
       xrebld LIKE xreb_t.xrebld, #帳套
       xreb001 LIKE xreb_t.xreb001, #年度
       xreb002 LIKE xreb_t.xreb002, #期別
       xreb003 LIKE xreb_t.xreb003, #來源模組
       xreb004 LIKE xreb_t.xreb004, #帳款單性質
       xreb005 LIKE xreb_t.xreb005, #單據號碼
       xreb006 LIKE xreb_t.xreb006, #項次
       xreb007 LIKE xreb_t.xreb007, #分期帳款序
       xreb008 LIKE xreb_t.xreb008, #立帳日期
       xreb009 LIKE xreb_t.xreb009, #帳款對象
       xreb010 LIKE xreb_t.xreb010, #收款對象
       xreb011 LIKE xreb_t.xreb011, #部門
       xreb012 LIKE xreb_t.xreb012, #責任中心
       xreb013 LIKE xreb_t.xreb013, #區域
       xreb014 LIKE xreb_t.xreb014, #客群
       xreb015 LIKE xreb_t.xreb015, #產品類別
       xreb016 LIKE xreb_t.xreb016, #人員
       xreb017 LIKE xreb_t.xreb017, #專案編號
       xreb018 LIKE xreb_t.xreb018, #WBS編號
       xreb019 LIKE xreb_t.xreb019, #應收科目
       xreborga LIKE xreb_t.xreborga, #來源組織
       xreb020 LIKE xreb_t.xreb020, #經營方式
       xreb021 LIKE xreb_t.xreb021, #通路
       xreb022 LIKE xreb_t.xreb022, #品牌
       xreb023 LIKE xreb_t.xreb023, #自由核算項一
       xreb024 LIKE xreb_t.xreb024, #自由核算項二
       xreb025 LIKE xreb_t.xreb025, #自由核算項三
       xreb026 LIKE xreb_t.xreb026, #自由核算項四
       xreb027 LIKE xreb_t.xreb027, #自由核算項五
       xreb028 LIKE xreb_t.xreb028, #自由核算項六
       xreb029 LIKE xreb_t.xreb029, #自由核算項七
       xreb030 LIKE xreb_t.xreb030, #自由核算項八
       xreb031 LIKE xreb_t.xreb031, #自由核算項九
       xreb032 LIKE xreb_t.xreb032, #自由核算項十
       xreb033 LIKE xreb_t.xreb033, #摘要
       xreb034 LIKE xreb_t.xreb034, #重評價會計科目
       xreb100 LIKE xreb_t.xreb100, #幣別
       xreb101 LIKE xreb_t.xreb101, #重評價匯率
       xreb102 LIKE xreb_t.xreb102, #上月重評匯率
       xreb103 LIKE xreb_t.xreb103, #本期原幣未沖金額
       xreb113 LIKE xreb_t.xreb113, #本期本幣未沖金額
       xreb114 LIKE xreb_t.xreb114, #本期重評價後本幣金額
       xreb115 LIKE xreb_t.xreb115, #本期匯差金額
       xreb116 LIKE xreb_t.xreb116, #本幣累計匯差
       xreb121 LIKE xreb_t.xreb121, #本位幣二重評價匯率
       xreb122 LIKE xreb_t.xreb122, #本位幣二上月重估匯率
       xreb123 LIKE xreb_t.xreb123, #本期本位幣二未沖金額
       xreb124 LIKE xreb_t.xreb124, #本期本位幣二重評價後金額
       xreb125 LIKE xreb_t.xreb125, #本期本位幣二匯差金額
       xreb126 LIKE xreb_t.xreb126, #本位幣二累計匯差
       xreb131 LIKE xreb_t.xreb131, #本位幣三重評價匯率
       xreb132 LIKE xreb_t.xreb132, #本位幣三上月重估匯率
       xreb133 LIKE xreb_t.xreb133, #本期本位幣三未沖金額
       xreb134 LIKE xreb_t.xreb134, #本期本位幣三重評價後金額
       xreb135 LIKE xreb_t.xreb135, #本期本位幣三匯差金額
       xreb136 LIKE xreb_t.xreb136 #本位幣三累計匯差
       END RECORD

   #161128-00061#5---modify----end------------- 
   DEFINE l_date        LIKE type_t.dat
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_xreb124     LIKE xreb_t.xreb124
   
  #161128-00061#5---modify----begin------------- 
   #LET l_sql = "SELECT * FROM xreb_t",
   LET l_sql = "SELECT xrebent,xrebcomp,xrebsite,xrebld,xreb001,xreb002,xreb003,xreb004,xreb005,",
               "xreb006,xreb007,xreb008,xreb009,xreb010,xreb011,xreb012,xreb013,xreb014,xreb015,",
               "xreb016,xreb017,xreb018,xreb019,xreborga,xreb020,xreb021,xreb022,xreb023,xreb024,",
               "xreb025,xreb026,xreb027,xreb028,xreb029,xreb030,xreb031,xreb032,xreb033,xreb034,",
               "xreb100,xreb101,xreb102,xreb103,xreb113,xreb114,xreb115,xreb116,xreb121,xreb122,",
               "xreb123,xreb124,xreb125,xreb126,xreb131,xreb132,xreb133,xreb134,xreb135,xreb136 FROM xreb_t",
   #161128-00061#5---modify----end------------- 
               " WHERE xrebent = '",g_enterprise,"'",
               "   AND xreb001 = '",g_xreb_m.xreb001,"'",
               "   AND xreb002 = '",g_xreb_m.xreb002,"'",
               "   AND xrebld  = '",g_xreb_m.xrebld,"'"
   PREPARE axrt920_01_prep2 FROM l_sql
   DECLARE axrt920_01_curs2 CURSOR FOR axrt920_01_prep2

   #  xreb121	本位幣二重評價匯率 = 依其他本位幣原則計算取得匯率
   #  xreb124	本期本位幣二重評價後金額 = xreb123*xreb121
   #  xreb125	本期本位幣二匯差金額 = xreb123 -xrcb124
   #  xrcc122	本位幣二重估後匯率  = xreb121
   #  xrcc123	本位幣二重評價調整數 = xreb125 

   LET l_date = axrt920_01_get_date(g_xreb_m.xreb001,g_xreb_m.xreb002,g_glaa_t.glaa003)

   FOREACH axrt920_01_curs2 INTO l_xreb.*
      IF g_glaa_t.glaa015 = 'Y' THEN
         IF g_glaa_t.glaa017 = '1' THEN
            #换算基准:交易原幣
            CALL s_axrt300_exrate(g_glaa_t.glaa002,l_date,g_xreb_m.xreb100,g_xreb_m.ooai001,l_xreb.xreb103,g_xreb_m.xreb101,g_glaa_t.glaacomp)
               RETURNING l_success,l_xreb124
         ELSE
            #换算基准:帳簿幣別
            CALL s_axrt300_exrate(g_glaa_t.glaa002,l_date,g_glaa_t.glaa001,g_xreb_m.ooai001,l_xreb.xreb123,g_xreb_m.xreb101,g_glaa_t.glaacomp)
               RETURNING l_success,l_xreb124
         END IF
      ELSE
         LET l_xreb124 = 0
      END IF
      LET l_xreb.xreb121 = g_xreb_m.xreb101
      LET l_xreb.xreb124 = l_xreb124
      LET l_xreb.xreb125 = l_xreb.xreb123 - l_xreb.xreb124
      
      UPDATE xreb_t SET xreb121 = l_xreb.xreb121,
                        xreb124 = l_xreb.xreb124,
                        xreb125 = l_xreb.xreb125
       WHERE xrebent = g_enterprise
         AND xreb001 = l_xreb.xreb001
         AND xreb002 = l_xreb.xreb002
         AND xrebld  = l_xreb.xrebld
         AND xreb005 = l_xreb.xreb005
         AND xreb006 = l_xreb.xreb006
         AND xreb007 = l_xreb.xreb007

      UPDATE xrcc_t SET xrcc122 = l_xreb.xreb121,
                        xrcc123 = l_xreb.xreb125
       WHERE xrccent  = g_enterprise
         AND xrccdocno= l_xreb.xreb005
         AND xrccseq  = l_xreb.xreb006
         AND xrcc001  = l_xreb.xreb007
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 更新本幣三重評價匯率
# Memo...........:
# Usage..........: CALL axrt920_01_upd_3()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/04/24 By zhangwei
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt920_01_upd_3()
   DEFINE l_sql         STRING
      #161128-00061#5---modify----begin------------- 
   #DEFINE l_xreb        RECORD LIKE xreb_t.*
   DEFINE l_xreb RECORD  #重評價月結檔
       xrebent LIKE xreb_t.xrebent, #企業編號
       xrebcomp LIKE xreb_t.xrebcomp, #法人
       xrebsite LIKE xreb_t.xrebsite, #帳務中心
       xrebld LIKE xreb_t.xrebld, #帳套
       xreb001 LIKE xreb_t.xreb001, #年度
       xreb002 LIKE xreb_t.xreb002, #期別
       xreb003 LIKE xreb_t.xreb003, #來源模組
       xreb004 LIKE xreb_t.xreb004, #帳款單性質
       xreb005 LIKE xreb_t.xreb005, #單據號碼
       xreb006 LIKE xreb_t.xreb006, #項次
       xreb007 LIKE xreb_t.xreb007, #分期帳款序
       xreb008 LIKE xreb_t.xreb008, #立帳日期
       xreb009 LIKE xreb_t.xreb009, #帳款對象
       xreb010 LIKE xreb_t.xreb010, #收款對象
       xreb011 LIKE xreb_t.xreb011, #部門
       xreb012 LIKE xreb_t.xreb012, #責任中心
       xreb013 LIKE xreb_t.xreb013, #區域
       xreb014 LIKE xreb_t.xreb014, #客群
       xreb015 LIKE xreb_t.xreb015, #產品類別
       xreb016 LIKE xreb_t.xreb016, #人員
       xreb017 LIKE xreb_t.xreb017, #專案編號
       xreb018 LIKE xreb_t.xreb018, #WBS編號
       xreb019 LIKE xreb_t.xreb019, #應收科目
       xreborga LIKE xreb_t.xreborga, #來源組織
       xreb020 LIKE xreb_t.xreb020, #經營方式
       xreb021 LIKE xreb_t.xreb021, #通路
       xreb022 LIKE xreb_t.xreb022, #品牌
       xreb023 LIKE xreb_t.xreb023, #自由核算項一
       xreb024 LIKE xreb_t.xreb024, #自由核算項二
       xreb025 LIKE xreb_t.xreb025, #自由核算項三
       xreb026 LIKE xreb_t.xreb026, #自由核算項四
       xreb027 LIKE xreb_t.xreb027, #自由核算項五
       xreb028 LIKE xreb_t.xreb028, #自由核算項六
       xreb029 LIKE xreb_t.xreb029, #自由核算項七
       xreb030 LIKE xreb_t.xreb030, #自由核算項八
       xreb031 LIKE xreb_t.xreb031, #自由核算項九
       xreb032 LIKE xreb_t.xreb032, #自由核算項十
       xreb033 LIKE xreb_t.xreb033, #摘要
       xreb034 LIKE xreb_t.xreb034, #重評價會計科目
       xreb100 LIKE xreb_t.xreb100, #幣別
       xreb101 LIKE xreb_t.xreb101, #重評價匯率
       xreb102 LIKE xreb_t.xreb102, #上月重評匯率
       xreb103 LIKE xreb_t.xreb103, #本期原幣未沖金額
       xreb113 LIKE xreb_t.xreb113, #本期本幣未沖金額
       xreb114 LIKE xreb_t.xreb114, #本期重評價後本幣金額
       xreb115 LIKE xreb_t.xreb115, #本期匯差金額
       xreb116 LIKE xreb_t.xreb116, #本幣累計匯差
       xreb121 LIKE xreb_t.xreb121, #本位幣二重評價匯率
       xreb122 LIKE xreb_t.xreb122, #本位幣二上月重估匯率
       xreb123 LIKE xreb_t.xreb123, #本期本位幣二未沖金額
       xreb124 LIKE xreb_t.xreb124, #本期本位幣二重評價後金額
       xreb125 LIKE xreb_t.xreb125, #本期本位幣二匯差金額
       xreb126 LIKE xreb_t.xreb126, #本位幣二累計匯差
       xreb131 LIKE xreb_t.xreb131, #本位幣三重評價匯率
       xreb132 LIKE xreb_t.xreb132, #本位幣三上月重估匯率
       xreb133 LIKE xreb_t.xreb133, #本期本位幣三未沖金額
       xreb134 LIKE xreb_t.xreb134, #本期本位幣三重評價後金額
       xreb135 LIKE xreb_t.xreb135, #本期本位幣三匯差金額
       xreb136 LIKE xreb_t.xreb136 #本位幣三累計匯差
       END RECORD

   #161128-00061#5---modify----end------------- 
   DEFINE l_date        LIKE type_t.dat
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_xreb134     LIKE xreb_t.xreb134
   
   #161128-00061#5---modify----begin------------- 
   #LET l_sql = "SELECT * FROM xreb_t",
   LET l_sql = "SELECT xrebent,xrebcomp,xrebsite,xrebld,xreb001,xreb002,xreb003,xreb004,xreb005,",
               "xreb006,xreb007,xreb008,xreb009,xreb010,xreb011,xreb012,xreb013,xreb014,xreb015,",
               "xreb016,xreb017,xreb018,xreb019,xreborga,xreb020,xreb021,xreb022,xreb023,xreb024,",
               "xreb025,xreb026,xreb027,xreb028,xreb029,xreb030,xreb031,xreb032,xreb033,xreb034,",
               "xreb100,xreb101,xreb102,xreb103,xreb113,xreb114,xreb115,xreb116,xreb121,xreb122,",
               "xreb123,xreb124,xreb125,xreb126,xreb131,xreb132,xreb133,xreb134,xreb135,xreb136 FROM xreb_t",
   #161128-00061#5---modify----end------------- 
               " WHERE xrebent = '",g_enterprise,"'",
               "   AND xreb001 = '",g_xreb_m.xreb001,"'",
               "   AND xreb002 = '",g_xreb_m.xreb002,"'",
               "   AND xrebld  = '",g_xreb_m.xrebld,"'"
   PREPARE axrt920_01_prep3 FROM l_sql
   DECLARE axrt920_01_curs3 CURSOR FOR axrt920_01_prep3

   #  xreb131	本位幣三重評價匯率   = 依其他本位幣原則計算取得匯率
   #  xreb134	本期本位幣三重評價後金額 = xreb133*xreb131
   #  xreb135	本期本位幣三匯差金額 = xreb133-xreb134
   #  xrcc132	本位幣三重估後匯率  = xreb131
   #  xrcc133	本位幣三重評價調整數 = xreb135 

   LET l_date = axrt920_01_get_date(g_xreb_m.xreb001,g_xreb_m.xreb002,g_glaa_t.glaa003)

   FOREACH axrt920_01_curs3 INTO l_xreb.*
      IF g_glaa_t.glaa019 = 'Y' THEN
         #計算本位幣三金額
         IF g_glaa_t.glaa021 = '1' THEN
            #换算基准:交易原幣
            CALL s_axrt300_exrate(g_glaa_t.glaa002,l_date,g_xreb_m.xreb100,g_xreb_m.ooai001,l_xreb.xreb103,g_xreb_m.xreb101,g_glaa_t.glaacomp)
               RETURNING l_success,l_xreb134
         ELSE
            #换算基准:帳簿幣別
            CALL s_axrt300_exrate(g_glaa_t.glaa002,l_date,g_glaa_t.glaa001,g_glaa_t.glaa020,l_xreb.xreb113,g_xreb_m.xreb101,g_glaa_t.glaacomp)
               RETURNING l_success,l_xreb134
         END IF
      ELSE
         LET l_xreb134 = 0
      END IF
      LET l_xreb.xreb131 = g_xreb_m.xreb101
      LET l_xreb.xreb134 = l_xreb134
      LET l_xreb.xreb135 = l_xreb.xreb133 - l_xreb.xreb134
      
      UPDATE xreb_t SET xreb131 = l_xreb.xreb131,
                        xreb134 = l_xreb.xreb134,
                        xreb135 = l_xreb.xreb135
       WHERE xrebent = g_enterprise
         AND xreb001 = l_xreb.xreb001
         AND xreb002 = l_xreb.xreb002
         AND xrebld  = l_xreb.xrebld
         AND xreb005 = l_xreb.xreb005
         AND xreb006 = l_xreb.xreb006
         AND xreb007 = l_xreb.xreb007

      UPDATE xrcc_t SET xrcc132 = l_xreb.xreb131,
                        xrcc133 = l_xreb.xreb135
       WHERE xrccent  = g_enterprise
         AND xrccdocno= l_xreb.xreb005
         AND xrccseq  = l_xreb.xreb006
         AND xrcc001  = l_xreb.xreb007
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 重新计算汇率
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt920_01_ref_cur()
   DEFINE l_date        LIKE type_t.dat
   DEFINE l_ooab002     LIKE ooab_t.ooab002
   DEFINE l_tmp         LIKE xreb_t.xreb103

   LET l_date = axrt920_01_get_date(g_xreb_m.xreb001,g_xreb_m.xreb002,g_glaa_t.glaa003)

   CALL cl_get_para(g_enterprise,g_glaa_t.glaacomp,'S-BAS-0010') RETURNING l_ooab002
   CALL s_aooi160_get_exrate('2',g_xreb_m.xrebld,l_date,g_xreb_m.xreb100,g_glaa_t.glaa001,0,l_ooab002)
      RETURNING l_tmp

   CASE
      WHEN g_xreb_m.lbl_comb = '0'      #目的幣別為:本位幣
         LET g_xreb_m.xreb101 = l_tmp
      WHEN g_xreb_m.lbl_comb = '1'      #目的幣別為:本位幣二
         IF g_glaa_t.glaa017 = '1' THEN
            #换算基准:交易原幣
            CALL s_aooi160_get_exrate('2',g_xreb_m.xrebld,l_date,g_xreb_m.xreb100,g_xreb_m.ooai001,0,g_glaa_t.glaa018)
               RETURNING g_xreb_m.xreb101
         ELSE
            #换算基准:帳簿幣別
            CALL s_aooi160_get_exrate('2',g_xreb_m.xrebld,l_date,g_glaa_t.glaa001,g_xreb_m.ooai001,l_tmp,g_glaa_t.glaa018)
               RETURNING g_xreb_m.xreb101
         END IF
      WHEN g_xreb_m.lbl_comb = '2'      #目的幣別為:本位幣二
         IF g_glaa_t.glaa019 = '1' THEN
            #换算基准:交易原幣
            CALL s_aooi160_get_exrate('2',g_xreb_m.xrebld,l_date,g_xreb_m.xreb100,g_xreb_m.ooai001,0,g_glaa_t.glaa022)
               RETURNING g_xreb_m.xreb101
         ELSE
            #换算基准:帳簿幣別
            CALL s_aooi160_get_exrate('2',g_xreb_m.xrebld,l_date,g_glaa_t.glaa001,g_xreb_m.ooai001,l_tmp,g_glaa_t.glaa022)
               RETURNING g_xreb_m.xreb101
         END IF
   END CASE

   DISPLAY BY NAME g_xreb_m.xreb101

END FUNCTION

 
{</section>}
 
