#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt920_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2014-12-18 19:19:46), PR版次:0010(2017-01-12 10:46:38)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000142
#+ Filename...: aapt920_01
#+ Description: 批次產生
#+ Creator....: 03080(2014-07-09 15:16:35)
#+ Modifier...: 04152 -SD/PR- 06694
 
{</section>}
 
{<section id="aapt920_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#151125-00006#2              By 06421   新增[編輯完單據後立即審核]和[編輯完單據後立即拋轉憑證]功能
#160822-00012#1  2016/08/02  By Reanna  新舊值處理
#160905-00002#4  2016/09/05  By 06821   補入WHERE條件漏掉ENT的部分
#161006-00005#31 2016/10/28  By 08732   組織類型與職能開窗調整
#161104-00024#6  2016/11/10  By 08729   處理DEFINE有星號
#161208-00026#15 2016/12/12  By 08732   SUB_程式中DEFINE / INSERT INTO 有星號整批調整(針對SELECT *的部份)
#161104-00046#8  2016/12/30  By 06821   資料依照單別user dept權限過濾單號
#161213-00023#2  2017/01/12  By 06694   新增aapp330_01元件單別參數，默認拋轉單別
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
PRIVATE type type_g_xreg_m        RECORD
       xregsite LIKE xreg_t.xregsite, 
   l_xregsite_desc LIKE type_t.chr80, 
   xregld LIKE xreg_t.xregld, 
   l_xregld_desc LIKE type_t.chr80, 
   xreg004 LIKE xreg_t.xreg004, 
   l_xreg004_desc LIKE type_t.chr80, 
   xregdocno LIKE xreg_t.xregdocno, 
   xreg001 LIKE xreg_t.xreg001, 
   xreg002 LIKE xreg_t.xreg002, 
   xregdocdt LIKE xreg_t.xregdocdt
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xreg_m_o      type_g_xreg_m
DEFINE g_wc_xregld     STRING
DEFINE r_xregdocno     LIKE xreg_t.xregdocno
DEFINE r_success       LIKE type_t.chr1

DEFINE g_user_slip_wc      STRING       #161104-00046#8 add
#end add-point
 
DEFINE g_xreg_m        type_g_xreg_m
 
   DEFINE g_xregdocno_t LIKE xreg_t.xregdocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt920_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt920_01(--)
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
   DEFINE l_comp          LIKE apca_t.apcacomp
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   DEFINE l_glaa024       LIKE glaa_t.glaa024
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_errno         LIKE type_t.chr100
   DEFINE l_glav002       LIKE glav_t.glav002
   DEFINE l_glav005       LIKE glav_t.glav005
   DEFINE l_sdate_s       LIKE glav_t.glav004
   DEFINE l_sdate_e       LIKE glav_t.glav004
   DEFINE l_glav006       LIKE glav_t.glav006
   DEFINE l_pdate_s       LIKE glav_t.glav004   #當期起始日
   DEFINE l_pdate_e       LIKE glav_t.glav004   #當期截止日
   DEFINE l_glav007       LIKE glav_t.glav007
   DEFINE l_wdate_s       LIKE glav_t.glav004
   DEFINE l_wdate_e       LIKE glav_t.glav004
   DEFINE l_xregcomp      LIKE xreg_t.xregcomp
   #DEFINE l_tmp           RECORD LIKE xreb_t.* #161104-00024#6 mark
   #161104-00024#6-add(s)
   DEFINE l_tmp   RECORD  #重評價月結檔
          xrebent   LIKE xreb_t.xrebent, #企業編號
          xrebcomp  LIKE xreb_t.xrebcomp, #法人
          xrebsite  LIKE xreb_t.xrebsite, #帳務中心
          xrebld    LIKE xreb_t.xrebld, #帳套
          xreb001   LIKE xreb_t.xreb001, #年度
          xreb002   LIKE xreb_t.xreb002, #期別
          xreb003   LIKE xreb_t.xreb003, #來源模組
          xreb004   LIKE xreb_t.xreb004, #帳款單性質
          xreb005   LIKE xreb_t.xreb005, #單據號碼
          xreb006   LIKE xreb_t.xreb006, #項次
          xreb007   LIKE xreb_t.xreb007, #分期帳款序
          xreb008   LIKE xreb_t.xreb008, #立帳日期
          xreb009   LIKE xreb_t.xreb009, #帳款對象
          xreb010   LIKE xreb_t.xreb010, #收款對象
          xreb011   LIKE xreb_t.xreb011, #部門
          xreb012   LIKE xreb_t.xreb012, #責任中心
          xreb013   LIKE xreb_t.xreb013, #區域
          xreb014   LIKE xreb_t.xreb014, #客群
          xreb015   LIKE xreb_t.xreb015, #產品類別
          xreb016   LIKE xreb_t.xreb016, #人員
          xreb017   LIKE xreb_t.xreb017, #專案編號
          xreb018   LIKE xreb_t.xreb018, #WBS編號
          xreb019   LIKE xreb_t.xreb019, #應收科目
          xreborga  LIKE xreb_t.xreborga, #來源組織
          xreb020   LIKE xreb_t.xreb020, #經營方式
          xreb021   LIKE xreb_t.xreb021, #通路
          xreb022   LIKE xreb_t.xreb022, #品牌
          xreb023   LIKE xreb_t.xreb023, #自由核算項一
          xreb024   LIKE xreb_t.xreb024, #自由核算項二
          xreb025   LIKE xreb_t.xreb025, #自由核算項三
          xreb026   LIKE xreb_t.xreb026, #自由核算項四
          xreb027   LIKE xreb_t.xreb027, #自由核算項五
          xreb028   LIKE xreb_t.xreb028, #自由核算項六
          xreb029   LIKE xreb_t.xreb029, #自由核算項七
          xreb030   LIKE xreb_t.xreb030, #自由核算項八
          xreb031   LIKE xreb_t.xreb031, #自由核算項九
          xreb032   LIKE xreb_t.xreb032, #自由核算項十
          xreb033   LIKE xreb_t.xreb033, #摘要
          xreb034   LIKE xreb_t.xreb034, #重評價會計科目
          xreb100   LIKE xreb_t.xreb100, #幣別
          xreb101   LIKE xreb_t.xreb101, #重評價匯率
          xreb102   LIKE xreb_t.xreb102, #上月重評匯率
          xreb103   LIKE xreb_t.xreb103, #本期原幣未沖金額
          xreb113   LIKE xreb_t.xreb113, #本期本幣未沖金額
          xreb114   LIKE xreb_t.xreb114, #本期重評價後本幣金額
          xreb115   LIKE xreb_t.xreb115, #本期匯差金額
          xreb116   LIKE xreb_t.xreb116, #本幣累計匯差
          xreb121   LIKE xreb_t.xreb121, #本位幣二重評價匯率
          xreb122   LIKE xreb_t.xreb122, #本位幣二上月重估匯率
          xreb123   LIKE xreb_t.xreb123, #本期本位幣二未沖金額
          xreb124   LIKE xreb_t.xreb124, #本期本位幣二重評價後金額
          xreb125   LIKE xreb_t.xreb125, #本期本位幣二匯差金額
          xreb126   LIKE xreb_t.xreb126, #本位幣二累計匯差
          xreb131   LIKE xreb_t.xreb131, #本位幣三重評價匯率
          xreb132   LIKE xreb_t.xreb132, #本位幣三上月重估匯率
          xreb133   LIKE xreb_t.xreb133, #本期本位幣三未沖金額
          xreb134   LIKE xreb_t.xreb134, #本期本位幣三重評價後金額
          xreb135   LIKE xreb_t.xreb135, #本期本位幣三匯差金額
          xreb136   LIKE xreb_t.xreb136, #本位幣三累計匯差
          xrebud001 LIKE xreb_t.xrebud001, #自定義欄位(文字)001
          xrebud002 LIKE xreb_t.xrebud002, #自定義欄位(文字)002
          xrebud003 LIKE xreb_t.xrebud003, #自定義欄位(文字)003
          xrebud004 LIKE xreb_t.xrebud004, #自定義欄位(文字)004
          xrebud005 LIKE xreb_t.xrebud005, #自定義欄位(文字)005
          xrebud006 LIKE xreb_t.xrebud006, #自定義欄位(文字)006
          xrebud007 LIKE xreb_t.xrebud007, #自定義欄位(文字)007
          xrebud008 LIKE xreb_t.xrebud008, #自定義欄位(文字)008
          xrebud009 LIKE xreb_t.xrebud009, #自定義欄位(文字)009
          xrebud010 LIKE xreb_t.xrebud010, #自定義欄位(文字)010
          xrebud011 LIKE xreb_t.xrebud011, #自定義欄位(數字)011
          xrebud012 LIKE xreb_t.xrebud012, #自定義欄位(數字)012
          xrebud013 LIKE xreb_t.xrebud013, #自定義欄位(數字)013
          xrebud014 LIKE xreb_t.xrebud014, #自定義欄位(數字)014
          xrebud015 LIKE xreb_t.xrebud015, #自定義欄位(數字)015
          xrebud016 LIKE xreb_t.xrebud016, #自定義欄位(數字)016
          xrebud017 LIKE xreb_t.xrebud017, #自定義欄位(數字)017
          xrebud018 LIKE xreb_t.xrebud018, #自定義欄位(數字)018
          xrebud019 LIKE xreb_t.xrebud019, #自定義欄位(數字)019
          xrebud020 LIKE xreb_t.xrebud020, #自定義欄位(數字)020
          xrebud021 LIKE xreb_t.xrebud021, #自定義欄位(日期時間)021
          xrebud022 LIKE xreb_t.xrebud022, #自定義欄位(日期時間)022
          xrebud023 LIKE xreb_t.xrebud023, #自定義欄位(日期時間)023
          xrebud024 LIKE xreb_t.xrebud024, #自定義欄位(日期時間)024
          xrebud025 LIKE xreb_t.xrebud025, #自定義欄位(日期時間)025
          xrebud026 LIKE xreb_t.xrebud026, #自定義欄位(日期時間)026
          xrebud027 LIKE xreb_t.xrebud027, #自定義欄位(日期時間)027
          xrebud028 LIKE xreb_t.xrebud028, #自定義欄位(日期時間)028
          xrebud029 LIKE xreb_t.xrebud029, #自定義欄位(日期時間)029
          xrebud030 LIKE xreb_t.xrebud030  #自定義欄位(日期時間)030
              END RECORD
   #161104-00024#6-add(e)
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE ld_date         DATETIME YEAR TO SECOND
   DEFINE l_success       LIKE type_t.num10
   DEFINE l_sfin3007      LIKE type_t.chr80 
   DEFINE l_flag1         LIKE type_t.num5   #161104-00046#8
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt920_01 WITH FORM cl_ap_formpath("aap","aapt920_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL s_fin_set_comp_scc('xreg001','43')   #年度
   CALL s_fin_set_comp_scc('xreg002','111')  #期別
   CALL s_fin_create_account_center_tmp()    #帳務中心
   
   #161104-00046#8 --s add
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_xreg_m','','','','','','')RETURNING g_sub_success
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#8 --e add   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xreg004,g_xreg_m.xregdocno,g_xreg_m.xreg001, 
          g_xreg_m.xreg002,g_xreg_m.xregdocdt ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_xreg_m.* TO NULL
            #帳務中心&帳別
            CALL s_aap_get_default_apcasite('','','') RETURNING g_sub_success,g_errno,g_xreg_m.xregsite,g_xreg_m.xregld,l_comp
            CALL s_desc_get_department_desc(g_xreg_m.xregsite) RETURNING g_xreg_m.l_xregsite_desc
            CALL s_desc_get_ld_desc(g_xreg_m.xregld)  RETURNING g_xreg_m.l_xregld_desc
            #帳務人員
            LET g_xreg_m.xreg004 = g_user
            CALL s_desc_get_person_desc(g_xreg_m.xreg004) RETURNING g_xreg_m.l_xreg004_desc
            #預設年度/期別
            CALL cl_get_para(g_enterprise,g_xreg_m.xregsite,'S-FIN-3007') RETURNING l_sfin3007
            LET g_xreg_m.xreg001 = YEAR(l_sfin3007)
            LET g_xreg_m.xreg002 = MONTH(l_sfin3007)
            #取得會計週期參照表/單據別參照表號
            CALL s_ld_sel_glaa(g_xreg_m.xregld,'glaa003|glaa024') RETURNING  g_sub_success,l_glaa003,l_glaa024
            #依年度+期別取得會計週期起迄日
            CALL s_get_accdate(l_glaa003,'',g_xreg_m.xreg001,g_xreg_m.xreg002)
            RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                      l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
            LET g_xreg_m.xregdocdt = l_pdate_e
            DISPLAY BY NAME g_xreg_m.xregsite,g_xreg_m.l_xregsite_desc
                           ,g_xreg_m.xregld,g_xreg_m.l_xregld_desc
                           ,g_xreg_m.xreg004,g_xreg_m.l_xreg004_desc
                           ,g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xregdocdt
            #LET g_xreg_m_o.* = g_xreg_m.*  #160822-00012#1
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregsite
            
            #add-point:AFTER FIELD xregsite name="input.a.xregsite"
            #帳務中心
            IF NOT cl_null(g_xreg_m.xregsite) THEN  
            #160822-00012#1 mark
           #IF g_xreg_m.xregsite != g_xreg_m_o.xregsite OR cl_null(g_xreg_m_o.xregsite) THEN #160822-00012#1
               IF g_xreg_m.xregsite != g_xreg_m_o.xregsite THEN
                  CALL s_fin_orga_get_comp_ld(g_xreg_m.xregsite) RETURNING g_sub_success,g_errno,l_comp,g_xreg_m.xregld
               END IF            
               CALL s_fin_account_center_with_ld_chk(g_xreg_m.xregsite,g_xreg_m.xregld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #160822-00012#1-s
                  #LET g_xreg_m.xregsite = g_xreg_m_o.xregsite
                  #LET g_xreg_m.xregld   = g_xreg_m_o.xregld
                  #CALL s_desc_get_department_desc(g_xreg_m.xregsite) RETURNING g_xreg_m.l_xregsite_desc
                  #CALL s_desc_get_ld_desc(g_xreg_m.xregld) RETURNING g_xreg_m.l_xregld_desc
                  #DISPLAY BY NAME g_xreg_m.xregsite,g_xreg_m.l_xregsite_desc,g_xreg_m.xregld,g_xreg_m.l_xregld_desc
                  #160822-00012#1-e
                  NEXT FIELD CURRENT
               END IF
               CALL s_fin_account_center_sons_query('3',g_xreg_m.xregsite,g_today,'1')
               CALL s_fin_account_center_ld_str() RETURNING g_wc_xregld
               CALL s_fin_get_wc_str(g_wc_xregld) RETURNING g_wc_xregld
               LET g_xreg_m.l_xregsite_desc= s_desc_get_department_desc(g_xreg_m.xregsite)
               LET g_xreg_m.l_xregld_desc  = s_desc_get_ld_desc(g_xreg_m.xregld)
               DISPLAY BY NAME g_xreg_m.l_xregsite_desc,g_xreg_m.xregld,g_xreg_m.l_xregld_desc
            END IF
            IF NOT cl_null(g_xreg_m.xregld) THEN
               #取的帳務中心的所屬法人
               SELECT ooef017 INTO l_comp
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_xreg_m.xregsite
            END IF
            #LET g_xreg_m_o.* = g_xreg_m.*  #160822-00012#1
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregsite
            #add-point:BEFORE FIELD xregsite name="input.b.xregsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xregsite
            #add-point:ON CHANGE xregsite name="input.g.xregsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregld
            
            #add-point:AFTER FIELD xregld name="input.a.xregld"
            IF NOT cl_null(g_xreg_m.xregld) THEN 
            #160822-00012#1 mark
           #IF g_xreg_m.xregld != g_xreg_m_o.xregld OR cl_null(g_xreg_m_o.xregld) THEN #160822-00012#1
               CALL s_fin_account_center_with_ld_chk(g_xreg_m.xregsite,g_xreg_m.xregld,g_user,'3','N',g_wc_xregld,g_xreg_m.xregdocdt) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #160822-00012#1-s
                  #LET g_xreg_m.xregld   = g_xreg_m_o.xregld
                  #CALL s_desc_get_ld_desc(g_xreg_m.xregld) RETURNING g_xreg_m.l_xregld_desc
                  #DISPLAY BY NAME g_xreg_m.l_xregld_desc
                  #160822-00012#1-e
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_xreg_m.xregld) THEN
                  #取的帳務中心的所屬法人
                  SELECT ooef017 INTO l_comp
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_xreg_m.xregsite
               END IF
               CALL s_desc_get_ld_desc(g_xreg_m.xregld) RETURNING g_xreg_m.l_xregld_desc
               DISPLAY BY NAME g_xreg_m.l_xregld_desc

               #取得會計週期參照表/單據別參照表號
               CALL s_ld_sel_glaa(g_xreg_m.xregld,'glaa003|glaa024') RETURNING  g_sub_success,l_glaa003,l_glaa024
               #依年度+期別取得會計週期起迄日
               CALL s_get_accdate(l_glaa003,'',g_xreg_m.xreg001,g_xreg_m.xreg002)
               RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               LET g_xreg_m.xregdocdt = l_pdate_e
               DISPLAY BY NAME g_xreg_m.xregdocdt
            END IF
            #LET g_xreg_m_o.* = g_xreg_m.*  #160822-00012#1
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregld
            #add-point:BEFORE FIELD xregld name="input.b.xregld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xregld
            #add-point:ON CHANGE xregld name="input.g.xregld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreg004
            
            #add-point:AFTER FIELD xreg004 name="input.a.xreg004"
            LET g_xreg_m.l_xreg004_desc = ' '
            IF NOT cl_null(g_xreg_m.xreg004) THEN
               LET g_errno = ''
               CALL s_employee_chk(g_xreg_m.xreg004) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_person_desc(g_xreg_m.xreg004) RETURNING g_xreg_m.l_xreg004_desc
            DISPLAY BY NAME g_xreg_m.l_xreg004_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreg004
            #add-point:BEFORE FIELD xreg004 name="input.b.xreg004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreg004
            #add-point:ON CHANGE xreg004 name="input.g.xreg004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregdocno
            #add-point:BEFORE FIELD xregdocno name="input.b.xregdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregdocno
            
            #add-point:AFTER FIELD xregdocno name="input.a.xregdocno"
            IF NOT cl_null(g_xreg_m.xregdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (cl_null(g_xregdocno_t) OR g_xreg_m.xregdocno != g_xregdocno_t)) THEN 
                  #以帳別去取所屬法人,以法人勾稽單別是否在單別參照表
                  CALL s_fin_slip_chk(g_xreg_m.xregdocno,g_prog,g_xreg_m.xregld,'D-FIN-3001') RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xreg_m.xregdocno = g_xregdocno_t
                     NEXT FIELD CURRENT
                  END IF
                  #161104-00046#8 --s add
                  CALL s_control_chk_doc('1',g_xreg_m.xregdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag1
                  IF g_sub_success AND l_flag1 THEN             
                  ELSE
                     LET g_xreg_m.xregdocno = g_xregdocno_t
                     NEXT FIELD CURRENT                
                  END IF
                  #161104-00046#8 --e add
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xregdocno
            #add-point:ON CHANGE xregdocno name="input.g.xregdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreg001
            #add-point:BEFORE FIELD xreg001 name="input.b.xreg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreg001
            
            #add-point:AFTER FIELD xreg001 name="input.a.xreg001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreg001
            #add-point:ON CHANGE xreg001 name="input.g.xreg001"
            #依年度+期別取得會計週期起迄日
            CALL s_get_accdate(l_glaa003,'',g_xreg_m.xreg001,g_xreg_m.xreg002)
            RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                      l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
            LET g_xreg_m.xregdocdt = l_pdate_e
            DISPLAY BY NAME g_xreg_m.xregdocdt
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreg002
            #add-point:BEFORE FIELD xreg002 name="input.b.xreg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreg002
            
            #add-point:AFTER FIELD xreg002 name="input.a.xreg002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreg002
            #add-point:ON CHANGE xreg002 name="input.g.xreg002"
            #依年度+期別取得會計週期起迄日
            CALL s_get_accdate(l_glaa003,'',g_xreg_m.xreg001,g_xreg_m.xreg002)
            RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                      l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
            LET g_xreg_m.xregdocdt = l_pdate_e
            DISPLAY BY NAME g_xreg_m.xregdocdt
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregdocdt
            #add-point:BEFORE FIELD xregdocdt name="input.b.xregdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregdocdt
            
            #add-point:AFTER FIELD xregdocdt name="input.a.xregdocdt"
            IF  NOT cl_null(g_xreg_m.xregdocdt) THEN
               #依年度+期別取得會計週期起迄日
               CALL s_get_accdate(l_glaa003,'',g_xreg_m.xreg001,g_xreg_m.xreg002)
               RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF g_xreg_m.xregdocdt <> l_pdate_e THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00238'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xregdocdt
            #add-point:ON CHANGE xregdocdt name="input.g.xregdocdt"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xregsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregsite
            #add-point:ON ACTION controlp INFIELD xregsite name="input.c.xregsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreg_m.xregsite
            #CALL q_ooef001()     #161006-00005#31   mark     
            CALL q_ooef001_46()   #161006-00005#31   add 
            LET g_xreg_m.xregsite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_xreg_m.xregsite) RETURNING g_xreg_m.l_xregsite_desc
            #取的帳務中心的所屬法人
            SELECT ooef017 INTO l_comp
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_xreg_m.xregsite
            DISPLAY BY NAME g_xreg_m.xregsite,g_xreg_m.l_xregsite_desc
            NEXT FIELD xregsite
            #END add-point
 
 
         #Ctrlp:input.c.xregld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregld
            #add-point:ON ACTION controlp INFIELD xregld name="input.c.xregld"
            INITIALIZE g_qryparam.* TO NULL
            CALL s_fin_account_center_sons_query('3',g_xreg_m.xregsite,g_xreg_m.xregdocdt,'1')
            CALL s_fin_account_center_ld_str() RETURNING g_wc_xregld
            CALL s_fin_get_wc_str(g_wc_xregld) RETURNING g_wc_xregld
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreg_m.xregld
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            LET g_qryparam.where = " glaald IN ",g_wc_xregld CLIPPED," "
            CALL q_authorised_ld()
            LET g_xreg_m.xregld = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_xreg_m.xregld) RETURNING g_xreg_m.l_xregld_desc
            DISPLAY BY NAME g_xreg_m.xregld,g_xreg_m.l_xregld_desc
            #取得會計週期參照表/單據別參照表號
            CALL s_ld_sel_glaa(g_xreg_m.xregld,'glaa003|glaa024') RETURNING  g_sub_success,l_glaa003,l_glaa024
            #依年度+期別取得會計週期起迄日
            CALL s_get_accdate(l_glaa003,'',g_xreg_m.xreg001,g_xreg_m.xreg002)
            RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                      l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
            LET g_xreg_m.xregdocdt = l_pdate_e
            DISPLAY BY NAME g_xreg_m.xregdocdt
            NEXT FIELD xregld
            #END add-point
 
 
         #Ctrlp:input.c.xreg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreg004
            #add-point:ON ACTION controlp INFIELD xreg004 name="input.c.xreg004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
   			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreg_m.xreg004
            CALL q_ooag001()
            LET g_xreg_m.xreg004 = g_qryparam.return1
            CALL s_desc_get_person_desc(g_xreg_m.xreg004) RETURNING g_xreg_m.l_xreg004_desc
            DISPLAY BY NAME g_xreg_m.xreg004,g_xreg_m.l_xreg004_desc
            NEXT FIELD xreg004
            #END add-point
 
 
         #Ctrlp:input.c.xregdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregdocno
            #add-point:ON ACTION controlp INFIELD xregdocno name="input.c.xregdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreg_m.xregdocno
            LET g_qryparam.where = "ooba001 = '",l_glaa024,"' AND oobx003 = 'aapt920'"
            #161104-00046#8 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_slip_wc CLIPPED
            END IF
            #161104-00046#8 --e add
            CALL q_ooba002_4()
            LET g_xreg_m.xregdocno = g_qryparam.return1
            DISPLAY BY NAME g_xreg_m.xregdocno
            NEXT FIELD xregdocno
            #END add-point
 
 
         #Ctrlp:input.c.xreg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreg001
            #add-point:ON ACTION controlp INFIELD xreg001 name="input.c.xreg001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xreg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreg002
            #add-point:ON ACTION controlp INFIELD xreg002 name="input.c.xreg002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xregdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregdocdt
            #add-point:ON ACTION controlp INFIELD xregdocdt name="input.c.xregdocdt"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            #先檢查該年度+期別+帳套+來源模組不可重複
            SELECT COUNT(*) INTO l_cnt
              FROM xreg_t
             WHERE xregent = g_enterprise
               AND xregld = g_xreg_m.xregld
               AND xreg001 = g_xreg_m.xreg001
               AND xreg002 = g_xreg_m.xreg002
               AND xreg003 = 'AP'
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            
            IF l_cnt > 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aap-00249'
               LET g_errparam.extend = 'Wrong!'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            ELSE
               LET l_success = TRUE
               #先判斷有沒有月結檔資料
               SELECT COUNT(*) INTO l_cnt
                 FROM xreb_t
                #WHERE xrebld = g_xreg_m.xregld                           #160905-00002#4 mark
                WHERE xrebent = g_enterprise AND xrebld = g_xreg_m.xregld #160905-00002#4 add
                  AND xreb001 = g_xreg_m.xreg001
                  AND xreb002 = g_xreg_m.xreg002
                  AND xreb003 = 'AP'
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt > 0 THEN
                  CALL s_transaction_begin()
                  #取得帳務中心的法人
                  SELECT ooef017 INTO l_xregcomp
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_xreg_m.xregsite
                  #設定單據編號
                  #CALL s_aooi200_gen_docno(l_xregcomp,g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_prog)
                  CALL s_aooi200_fin_gen_docno(g_xreg_m.xregld,'','',g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_prog)
                      RETURNING g_sub_success,g_xreg_m.xregdocno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00003'
                     LET g_errparam.extend = g_xreg_m.xregdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET l_success = FALSE
                  END IF
                  LET ld_date  = cl_get_current()
                  #產生單頭 xreg
                  INSERT INTO xreg_t (xregent,xregcomp,xregsite,xregdocno,xregdocdt
                                     ,xregld,xregstus
                                     ,xreg001,xreg002,xreg003,xreg004,xreg005
                                     ,xregownid,xregowndp,xregcrtid,xregcrtdp,xregcrtdt,xregmodid,xregmoddt,xregcnfid,xregcnfdt)
                              VALUES (g_enterprise,l_xregcomp,g_xreg_m.xregsite,g_xreg_m.xregdocno,g_xreg_m.xregdocdt
                                     ,g_xreg_m.xregld,'N'
                                     ,g_xreg_m.xreg001,g_xreg_m.xreg002,'AP',g_xreg_m.xreg004,''
                                     ,g_user,g_dept,g_user,g_dept,ld_date,'','','','')
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "ins xreg wrong"
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET l_success = FALSE
                     CONTINUE DIALOG
                  END IF
                  
                  #產生單身 xreh
                  #LET l_sql = "SELECT * FROM xreb_t",   #161208-00026#15   mark
                  #161208-00026#15   add---s
                  LET l_sql = "SELECT xrebent,xrebcomp,xrebsite,xrebld,xreb001,
                                      xreb002,xreb003,xreb004,xreb005,xreb006,
                                      xreb007,xreb008,xreb009,xreb010,xreb011,
                                      xreb012,xreb013,xreb014,xreb015,xreb016,
                                      xreb017,xreb018,xreb019,xreborga,xreb020,
                                      xreb021,xreb022,xreb023,xreb024,xreb025,
                                      xreb026,xreb027,xreb028,xreb029,xreb030,
                                      xreb031,xreb032,xreb033,xreb034,xreb100,
                                      xreb101,xreb102,xreb103,xreb113,xreb114,
                                      xreb115,xreb116,xreb121,xreb122,xreb123,
                                      xreb124,xreb125,xreb126,xreb131,xreb132,
                                      xreb133,xreb134,xreb135,xreb136,xrebud001,
                                      xrebud002,xrebud003,xrebud004,xrebud005,xrebud006,
                                      xrebud007,xrebud008,xrebud009,xrebud010,xrebud011,
                                      xrebud012,xrebud013,xrebud014,xrebud015,xrebud016,
                                      xrebud017,xrebud018,xrebud019,xrebud020,xrebud021,
                                      xrebud022,xrebud023,xrebud024,xrebud025,xrebud026,
                                      xrebud027,xrebud028,xrebud029,xrebud030 
                                 FROM xreb_t",
                 #161208-00026#15   add---e
                              " WHERE xrebent = ",g_enterprise,
                              "   AND xrebld = '",g_xreg_m.xregld,"'",
                              "   AND xreb001 = '",g_xreg_m.xreg001,"'",
                              "   AND xreb002 = '",g_xreg_m.xreg002,"'",
                              "   AND xreb003 = 'AP'"
                  PREPARE sel_xreb_pre FROM l_sql
                  DECLARE sel_xreb_cur CURSOR FOR sel_xreb_pre
                  LET l_i = 1
                  #FOREACH sel_xreb_cur INTO l_tmp.*   #161208-00026#15   mark
                  #161208-00026#15   add---s
                  FOREACH sel_xreb_cur 
                     INTO l_tmp.xrebent,l_tmp.xrebcomp,l_tmp.xrebsite,l_tmp.xrebld,l_tmp.xreb001,
                          l_tmp.xreb002,l_tmp.xreb003,l_tmp.xreb004,l_tmp.xreb005,l_tmp.xreb006,
                          l_tmp.xreb007,l_tmp.xreb008,l_tmp.xreb009,l_tmp.xreb010,l_tmp.xreb011,
                          l_tmp.xreb012,l_tmp.xreb013,l_tmp.xreb014,l_tmp.xreb015,l_tmp.xreb016,
                          l_tmp.xreb017,l_tmp.xreb018,l_tmp.xreb019,l_tmp.xreborga,l_tmp.xreb020,
                          l_tmp.xreb021,l_tmp.xreb022,l_tmp.xreb023,l_tmp.xreb024,l_tmp.xreb025,
                          l_tmp.xreb026,l_tmp.xreb027,l_tmp.xreb028,l_tmp.xreb029,l_tmp.xreb030,
                          l_tmp.xreb031,l_tmp.xreb032,l_tmp.xreb033,l_tmp.xreb034,l_tmp.xreb100,
                          l_tmp.xreb101,l_tmp.xreb102,l_tmp.xreb103,l_tmp.xreb113,l_tmp.xreb114,
                          l_tmp.xreb115,l_tmp.xreb116,l_tmp.xreb121,l_tmp.xreb122,l_tmp.xreb123,
                          l_tmp.xreb124,l_tmp.xreb125,l_tmp.xreb126,l_tmp.xreb131,l_tmp.xreb132,
                          l_tmp.xreb133,l_tmp.xreb134,l_tmp.xreb135,l_tmp.xreb136,l_tmp.xrebud001,
                          l_tmp.xrebud002,l_tmp.xrebud003,l_tmp.xrebud004,l_tmp.xrebud005,l_tmp.xrebud006,
                          l_tmp.xrebud007,l_tmp.xrebud008,l_tmp.xrebud009,l_tmp.xrebud010,l_tmp.xrebud011,
                          l_tmp.xrebud012,l_tmp.xrebud013,l_tmp.xrebud014,l_tmp.xrebud015,l_tmp.xrebud016,
                          l_tmp.xrebud017,l_tmp.xrebud018,l_tmp.xrebud019,l_tmp.xrebud020,l_tmp.xrebud021,
                          l_tmp.xrebud022,l_tmp.xrebud023,l_tmp.xrebud024,l_tmp.xrebud025,l_tmp.xrebud026,
                          l_tmp.xrebud027,l_tmp.xrebud028,l_tmp.xrebud029,l_tmp.xrebud030
                  #161208-00026#15   add---e
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = "sel xreb_t wrong!"
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        LET l_success = FALSE
                        EXIT FOREACH
                     END IF
                     INSERT INTO xreh_t(xrehent,xrehdocno,xrehld,xrehseq
                                       ,xreh001,xreh002,xreh003,xreh004,xreh005
                                       ,xreh006,xreh007,xreh008,xreh009,xreh010
                                       ,xreh011,xreh012,xreh013,xreh014,xreh015
                                       ,xreh016,xreh017,xreh018,xreh019,xrehorga
                                       ,xreh020,xreh021,xreh022,xreh023,xreh024,xreh025
                                       ,xreh026,xreh027,xreh028,xreh029,xreh030
                                       ,xreh031,xreh032,xreh033,xreh034
                                       ,xreh100,xreh101,xreh102,xreh103
                                       ,xreh113,xreh114,xreh115,xreh116
                                       ,xreh121,xreh122,xreh123,xreh124,xreh125,xreh126
                                       ,xreh131,xreh132,xreh133,xreh134,xreh135,xreh136)
                                 VALUES(g_enterprise,g_xreg_m.xregdocno,l_tmp.xrebld,l_i
                                       ,l_tmp.xreb001,l_tmp.xreb002,l_tmp.xreb003,l_tmp.xreb004,l_tmp.xreb005
                                       ,l_tmp.xreb006,l_tmp.xreb007,l_tmp.xreb008,l_tmp.xreb009,l_tmp.xreb010
                                       ,l_tmp.xreb011,l_tmp.xreb012,l_tmp.xreb013,l_tmp.xreb014,l_tmp.xreb015
                                       ,l_tmp.xreb016,l_tmp.xreb017,l_tmp.xreb018,l_tmp.xreb019,l_tmp.xreborga
                                       ,l_tmp.xreb020,l_tmp.xreb021,l_tmp.xreb022,l_tmp.xreb023,l_tmp.xreb024,l_tmp.xreb025
                                       ,l_tmp.xreb026,l_tmp.xreb027,l_tmp.xreb028,l_tmp.xreb029,l_tmp.xreb030
                                       ,l_tmp.xreb031,l_tmp.xreb032,l_tmp.xreb033,l_tmp.xreb034
                                       ,l_tmp.xreb100,l_tmp.xreb101,l_tmp.xreb102,l_tmp.xreb103
                                       ,l_tmp.xreb113,l_tmp.xreb114,l_tmp.xreb115,l_tmp.xreb116
                                       ,l_tmp.xreb121,l_tmp.xreb122,l_tmp.xreb123,l_tmp.xreb124,l_tmp.xreb125,l_tmp.xreb126
                                       ,l_tmp.xreb131,l_tmp.xreb132,l_tmp.xreb133,l_tmp.xreb134,l_tmp.xreb135,l_tmp.xreb136)
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = "g_xreb_m"
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        LET l_success = FALSE
                        EXIT FOREACH
                     END IF
                     LET l_i = l_i + 1
                  END FOREACH
                  IF l_success THEN
                     LET g_errparam.extend = ""
                     LET g_errparam.code = "adz-00217"
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  END IF
                  CALL s_transaction_end('Y','0')
                  LET r_success = l_success
                  LET r_xregdocno = g_xreg_m.xregdocno 
               ELSE
                  LET g_errparam.extend = ""
                  LET g_errparam.code = "sub-00491"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET r_success = l_success
                  LET r_xregdocno = g_xreg_m.xregdocno 
               END IF
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
      LET INT_FLAG = FALSE
      CLOSE WINDOW w_aapt920_01
      RETURN r_success,r_xregdocno
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aapt920_01 
   
   #add-point:input段after input name="input.post_input"
   #151125-00006#2
   LET g_xreg_m.xregdocno = r_xregdocno
   CALL aapt920_01_immediately_conf()
   CALL aapt920_01_immediately_gen()
   #151125-00006#2
   RETURN r_success,r_xregdocno
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt920_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt920_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 立即審核
# Memo...........:
# Usage..........: CALL aapt920_01_immediately_conf()
#                  RETURNING ---

# Date & Author..: 2015/12/02 By muping
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt920_01_immediately_conf()
#151125-00006#2--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_xregcomp        LIKE xreg_t.xregcomp
   DEFINE l_sfin3007  LIKE type_t.dat
   DEFINE  g_xregcnfdt    LIKE xreg_t.xregcnfdt
   #DEFINE  l_xreg       RECORD LIKE xreg_t.* #161104-00024#6 mark
   #161104-00024#6-add(s)
   DEFINE l_xreg  RECORD  #重評價帳務主檔
          xregent   LIKE xreg_t.xregent, #企業編號
          xregcomp  LIKE xreg_t.xregcomp, #法人
          xregsite  LIKE xreg_t.xregsite, #帳務中心
          xregdocno LIKE xreg_t.xregdocno, #單據號碼
          xregdocdt LIKE xreg_t.xregdocdt, #單據日期
          xregld    LIKE xreg_t.xregld, #帳套
          xreg001   LIKE xreg_t.xreg001, #年度
          xreg002   LIKE xreg_t.xreg002, #期別
          xreg003   LIKE xreg_t.xreg003, #來源模組
          xreg004   LIKE xreg_t.xreg004, #帳務人員
          xreg005   LIKE xreg_t.xreg005, #傳票號碼
          xregstus  LIKE xreg_t.xregstus, #狀態碼
          xregownid LIKE xreg_t.xregownid, #資料所有者
          xregowndp LIKE xreg_t.xregowndp, #資料所屬部門
          xregcrtid LIKE xreg_t.xregcrtid, #資料建立者
          xregcrtdp LIKE xreg_t.xregcrtdp, #資料建立部門
          xregcrtdt LIKE xreg_t.xregcrtdt, #資料創建日
          xregmodid LIKE xreg_t.xregmodid, #資料修改者
          xregmoddt LIKE xreg_t.xregmoddt, #最近修改日
          xregcnfid LIKE xreg_t.xregcnfid, #資料確認者
          xregcnfdt LIKE xreg_t.xregcnfdt, #資料確認日
          xregud001 LIKE xreg_t.xregud001, #自定義欄位(文字)001
          xregud002 LIKE xreg_t.xregud002, #自定義欄位(文字)002
          xregud003 LIKE xreg_t.xregud003, #自定義欄位(文字)003
          xregud004 LIKE xreg_t.xregud004, #自定義欄位(文字)004
          xregud005 LIKE xreg_t.xregud005, #自定義欄位(文字)005
          xregud006 LIKE xreg_t.xregud006, #自定義欄位(文字)006
          xregud007 LIKE xreg_t.xregud007, #自定義欄位(文字)007
          xregud008 LIKE xreg_t.xregud008, #自定義欄位(文字)008
          xregud009 LIKE xreg_t.xregud009, #自定義欄位(文字)009
          xregud010 LIKE xreg_t.xregud010, #自定義欄位(文字)010
          xregud011 LIKE xreg_t.xregud011, #自定義欄位(數字)011
          xregud012 LIKE xreg_t.xregud012, #自定義欄位(數字)012
          xregud013 LIKE xreg_t.xregud013, #自定義欄位(數字)013
          xregud014 LIKE xreg_t.xregud014, #自定義欄位(數字)014
          xregud015 LIKE xreg_t.xregud015, #自定義欄位(數字)015
          xregud016 LIKE xreg_t.xregud016, #自定義欄位(數字)016
          xregud017 LIKE xreg_t.xregud017, #自定義欄位(數字)017
          xregud018 LIKE xreg_t.xregud018, #自定義欄位(數字)018
          xregud019 LIKE xreg_t.xregud019, #自定義欄位(數字)019
          xregud020 LIKE xreg_t.xregud020, #自定義欄位(數字)020
          xregud021 LIKE xreg_t.xregud021, #自定義欄位(日期時間)021
          xregud022 LIKE xreg_t.xregud022, #自定義欄位(日期時間)022
          xregud023 LIKE xreg_t.xregud023, #自定義欄位(日期時間)023
          xregud024 LIKE xreg_t.xregud024, #自定義欄位(日期時間)024
          xregud025 LIKE xreg_t.xregud025, #自定義欄位(日期時間)025
          xregud026 LIKE xreg_t.xregud026, #自定義欄位(日期時間)026
          xregud027 LIKE xreg_t.xregud027, #自定義欄位(日期時間)027
          xregud028 LIKE xreg_t.xregud028, #自定義欄位(日期時間)028
          xregud029 LIKE xreg_t.xregud029, #自定義欄位(日期時間)029
          xregud030 LIKE xreg_t.xregud030  #自定義欄位(日期時間)030
              END RECORD
   #161104-00024#6-add(e)
   IF cl_null(g_xreg_m.xregld)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_xreg_m.xregsite)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_xreg_m.xregdocno) THEN RETURN END IF   #無資料直接返回不做處理
   #SELECT *  INTO  l_xreg.*  FROM xreg_t   #161208-00026#15   mark
   #161208-00026#15   add---s
   SELECT xregent,xregcomp,xregsite,xregdocno,xregdocdt,
          xregld,xreg001,xreg002,xreg003,xreg004,
          xreg005,xregstus,xregownid,xregowndp,xregcrtid,
          xregcrtdp,xregcrtdt,xregmodid,xregmoddt,xregcnfid,
          xregcnfdt,xregud001,xregud002,xregud003,xregud004,
          xregud005,xregud006,xregud007,xregud008,xregud009,
          xregud010,xregud011,xregud012,xregud013,xregud014,
          xregud015,xregud016,xregud017,xregud018,xregud019,
          xregud020,xregud021,xregud022,xregud023,xregud024,
          xregud025,xregud026,xregud027,xregud028,xregud029,
          xregud030  
     INTO l_xreg.xregent,l_xreg.xregcomp,l_xreg.xregsite,l_xreg.xregdocno,l_xreg.xregdocdt,
          l_xreg.xregld,l_xreg.xreg001,l_xreg.xreg002,l_xreg.xreg003,l_xreg.xreg004,
          l_xreg.xreg005,l_xreg.xregstus,l_xreg.xregownid,l_xreg.xregowndp,l_xreg.xregcrtid,
          l_xreg.xregcrtdp,l_xreg.xregcrtdt,l_xreg.xregmodid,l_xreg.xregmoddt,l_xreg.xregcnfid,
          l_xreg.xregcnfdt,l_xreg.xregud001,l_xreg.xregud002,l_xreg.xregud003,l_xreg.xregud004,
          l_xreg.xregud005,l_xreg.xregud006,l_xreg.xregud007,l_xreg.xregud008,l_xreg.xregud009,
          l_xreg.xregud010,l_xreg.xregud011,l_xreg.xregud012,l_xreg.xregud013,l_xreg.xregud014,
          l_xreg.xregud015,l_xreg.xregud016,l_xreg.xregud017,l_xreg.xregud018,l_xreg.xregud019,
          l_xreg.xregud020,l_xreg.xregud021,l_xreg.xregud022,l_xreg.xregud023,l_xreg.xregud024,
          l_xreg.xregud025,l_xreg.xregud026,l_xreg.xregud027,l_xreg.xregud028,l_xreg.xregud029,
          l_xreg.xregud030  
     FROM xreg_t
   #161208-00026#15   add---e
    #WHERE xregld = g_xreg_m.xregld AND xregsite = g_xreg_m.xregsite AND xregdocno =  g_xreg_m.xregdocno                            #160905-00002#4 mark
    WHERE xregent = g_enterprise AND xregld = g_xreg_m.xregld AND xregsite = g_xreg_m.xregsite AND xregdocno =  g_xreg_m.xregdocno  #160905-00002#4 add
    
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM xreh_t WHERE xrehent = g_enterprise
      AND xrehdocno = g_xreg_m.xregdocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN 
   END IF                   #单身無資料直接返回不做處理
   #只能執行大於等於關帳年月之資料
   SELECT xregcomp INTO l_xregcomp FROM xreg_t WHERE xregent = g_enterprise AND xregdocno = g_xreg_m.xregdocno AND xreg003 = 'AP' 
   CALL cl_get_para(g_enterprise,l_xregcomp,'S-FIN-3007') RETURNING l_sfin3007 
   #IF g_xreg_m.xregdocdt < l_sfin3007 THEN RETURN END IF
   
   #取得單別
   CALL s_aooi200_fin_get_slip(g_xreg_m.xregdocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(g_xreg_m.xregld,l_xreg.xregcomp,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
      

   IF NOT s_aapt920_conf_chk(g_xreg_m.xregdocno) THEN
      LET l_doc_success = FALSE
   END IF
   
   IF NOT s_aapt920_conf_upd(g_xreg_m.xregdocno) THEN
      LET l_doc_success = FALSE
   END IF

   
   #異動狀態碼欄位/修改人/修改日期
   LET g_xregcnfdt = cl_get_current()
   UPDATE xreg_t SET xregstus = 'Y',
                     xregmodid= g_user,
                     #xregmoddt= g_xreg_m.xregmoddt,
                     xregcnfid= g_user,
                     xregcnfdt= g_xregcnfdt
    WHERE xregent = g_enterprise AND xregld = g_xreg_m.xregld
      AND xregdocno = g_xreg_m.xregdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET l_doc_success = FALSE
   END IF
   IF l_doc_success = TRUE THEN
      CALL s_transaction_end('Y',1)
   ELSE
      CALL s_transaction_end('N',1)
      CALL cl_err_collect_show()
   END IF
#151125-00006#2--e
END FUNCTION

################################################################################
# Descriptions...: 立即拋轉憑證
# Memo...........:
# Usage..........: CALL aapt920_01_immediately_gen()
#                  RETURNING ---

# Date & Author..: 2015/12/02 By 06421
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt920_01_immediately_gen()
#151125-00006#2---s
   DEFINE l_cnt            LIKE type_t.num10
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0032        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_glap001         LIKE glap_t.glap001
   DEFINE la_param          RECORD
          prog              STRING,
          param             DYNAMIC ARRAY OF STRING
                            END RECORD
   DEFINE ls_js             STRING
   DEFINE l_glaa024         LIKE glaa_t.glaa024
   DEFINE l_date            LIKE glap_t.glapdocdt
   DEFINE l_chr             LIKE type_t.chr1       #狀態碼
   DEFINE l_gl_slip         LIKE ooba_t.ooba002      #總帳單別
   DEFINE l_sfin3007        LIKE type_t.dat
   DEFINE l_glaacomp        LIKE glaa_t.glaacomp
   DEFINE l_docno           LIKE xrem_t.xremdocno
   DEFINE l_start_no        LIKE glap_t.glapdocno
   DEFINE g_glaa102         LIKE glaa_t.glaa102
   DEFINE g_ap_slip         LIKE apca_t.apcadocno
   #DEFINE l_xreg            RECORD LIKE xreg_t.* #161104-00024#6 mark
   #161104-00024#6-add(s)
   DEFINE l_xreg  RECORD  #重評價帳務主檔
          xregent   LIKE xreg_t.xregent, #企業編號
          xregcomp  LIKE xreg_t.xregcomp, #法人
          xregsite  LIKE xreg_t.xregsite, #帳務中心
          xregdocno LIKE xreg_t.xregdocno, #單據號碼
          xregdocdt LIKE xreg_t.xregdocdt, #單據日期
          xregld    LIKE xreg_t.xregld, #帳套
          xreg001   LIKE xreg_t.xreg001, #年度
          xreg002   LIKE xreg_t.xreg002, #期別
          xreg003   LIKE xreg_t.xreg003, #來源模組
          xreg004   LIKE xreg_t.xreg004, #帳務人員
          xreg005   LIKE xreg_t.xreg005, #傳票號碼
          xregstus  LIKE xreg_t.xregstus, #狀態碼
          xregownid LIKE xreg_t.xregownid, #資料所有者
          xregowndp LIKE xreg_t.xregowndp, #資料所屬部門
          xregcrtid LIKE xreg_t.xregcrtid, #資料建立者
          xregcrtdp LIKE xreg_t.xregcrtdp, #資料建立部門
          xregcrtdt LIKE xreg_t.xregcrtdt, #資料創建日
          xregmodid LIKE xreg_t.xregmodid, #資料修改者
          xregmoddt LIKE xreg_t.xregmoddt, #最近修改日
          xregcnfid LIKE xreg_t.xregcnfid, #資料確認者
          xregcnfdt LIKE xreg_t.xregcnfdt, #資料確認日
          xregud001 LIKE xreg_t.xregud001, #自定義欄位(文字)001
          xregud002 LIKE xreg_t.xregud002, #自定義欄位(文字)002
          xregud003 LIKE xreg_t.xregud003, #自定義欄位(文字)003
          xregud004 LIKE xreg_t.xregud004, #自定義欄位(文字)004
          xregud005 LIKE xreg_t.xregud005, #自定義欄位(文字)005
          xregud006 LIKE xreg_t.xregud006, #自定義欄位(文字)006
          xregud007 LIKE xreg_t.xregud007, #自定義欄位(文字)007
          xregud008 LIKE xreg_t.xregud008, #自定義欄位(文字)008
          xregud009 LIKE xreg_t.xregud009, #自定義欄位(文字)009
          xregud010 LIKE xreg_t.xregud010, #自定義欄位(文字)010
          xregud011 LIKE xreg_t.xregud011, #自定義欄位(數字)011
          xregud012 LIKE xreg_t.xregud012, #自定義欄位(數字)012
          xregud013 LIKE xreg_t.xregud013, #自定義欄位(數字)013
          xregud014 LIKE xreg_t.xregud014, #自定義欄位(數字)014
          xregud015 LIKE xreg_t.xregud015, #自定義欄位(數字)015
          xregud016 LIKE xreg_t.xregud016, #自定義欄位(數字)016
          xregud017 LIKE xreg_t.xregud017, #自定義欄位(數字)017
          xregud018 LIKE xreg_t.xregud018, #自定義欄位(數字)018
          xregud019 LIKE xreg_t.xregud019, #自定義欄位(數字)019
          xregud020 LIKE xreg_t.xregud020, #自定義欄位(數字)020
          xregud021 LIKE xreg_t.xregud021, #自定義欄位(日期時間)021
          xregud022 LIKE xreg_t.xregud022, #自定義欄位(日期時間)022
          xregud023 LIKE xreg_t.xregud023, #自定義欄位(日期時間)023
          xregud024 LIKE xreg_t.xregud024, #自定義欄位(日期時間)024
          xregud025 LIKE xreg_t.xregud025, #自定義欄位(日期時間)025
          xregud026 LIKE xreg_t.xregud026, #自定義欄位(日期時間)026
          xregud027 LIKE xreg_t.xregud027, #自定義欄位(日期時間)027
          xregud028 LIKE xreg_t.xregud028, #自定義欄位(日期時間)028
          xregud029 LIKE xreg_t.xregud029, #自定義欄位(日期時間)029
          xregud030 LIKE xreg_t.xregud030  #自定義欄位(日期時間)030
              END RECORD
   #161104-00024#6-add(e)
   IF cl_null(g_xreg_m.xregld)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_xreg_m.xregsite)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_xreg_m.xregdocno) THEN RETURN END IF   #無資料直接返回不做處理
   #SELECT *  INTO  l_xreg.*  FROM xreg_t   #161208-00026#15   mark
   #161208-00026#15   add---s
   SELECT xregent,xregcomp,xregsite,xregdocno,xregdocdt,
          xregld,xreg001,xreg002,xreg003,xreg004,
          xreg005,xregstus,xregownid,xregowndp,xregcrtid,
          xregcrtdp,xregcrtdt,xregmodid,xregmoddt,xregcnfid,
          xregcnfdt,xregud001,xregud002,xregud003,xregud004,
          xregud005,xregud006,xregud007,xregud008,xregud009,
          xregud010,xregud011,xregud012,xregud013,xregud014,
          xregud015,xregud016,xregud017,xregud018,xregud019,
          xregud020,xregud021,xregud022,xregud023,xregud024,
          xregud025,xregud026,xregud027,xregud028,xregud029,
          xregud030  
     INTO l_xreg.xregent,l_xreg.xregcomp,l_xreg.xregsite,l_xreg.xregdocno,l_xreg.xregdocdt,
          l_xreg.xregld,l_xreg.xreg001,l_xreg.xreg002,l_xreg.xreg003,l_xreg.xreg004,
          l_xreg.xreg005,l_xreg.xregstus,l_xreg.xregownid,l_xreg.xregowndp,l_xreg.xregcrtid,
          l_xreg.xregcrtdp,l_xreg.xregcrtdt,l_xreg.xregmodid,l_xreg.xregmoddt,l_xreg.xregcnfid,
          l_xreg.xregcnfdt,l_xreg.xregud001,l_xreg.xregud002,l_xreg.xregud003,l_xreg.xregud004,
          l_xreg.xregud005,l_xreg.xregud006,l_xreg.xregud007,l_xreg.xregud008,l_xreg.xregud009,
          l_xreg.xregud010,l_xreg.xregud011,l_xreg.xregud012,l_xreg.xregud013,l_xreg.xregud014,
          l_xreg.xregud015,l_xreg.xregud016,l_xreg.xregud017,l_xreg.xregud018,l_xreg.xregud019,
          l_xreg.xregud020,l_xreg.xregud021,l_xreg.xregud022,l_xreg.xregud023,l_xreg.xregud024,
          l_xreg.xregud025,l_xreg.xregud026,l_xreg.xregud027,l_xreg.xregud028,l_xreg.xregud029,
          l_xreg.xregud030  
     FROM xreg_t
   #161208-00026#15   add---e
    #WHERE xregld = g_xreg_m.xregld AND xregsite = g_xreg_m.xregsite AND xregdocno =  g_xreg_m.xregdocno                             #160905-00002#4 mark
    WHERE xregent = g_enterprise AND xregld = g_xreg_m.xregld AND xregsite = g_xreg_m.xregsite AND xregdocno =  g_xreg_m.xregdocno   #160905-00002#4 add
    
   IF  l_xreg.xregstus != 'Y' OR cl_null(l_xreg.xregstus)  THEN
      RETURN
    END IF
   IF NOT cl_null(l_xreg.xreg005)  THEN RETURN END IF #传票号码已经存在返回不做处理
   #傳票成立時,借貸不平衡的處理方式
   CALL s_ld_sel_glaa(g_xreg_m.xregld,'glaacomp|glaa102')
        RETURNING g_sub_success,l_glaacomp,g_glaa102
   #取所屬法人關帳日
   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-3007') RETURNING l_sfin3007 
   
   
   # D-FIN-0030 产生分录传票否
   CALL s_aooi200_fin_get_slip(g_xreg_m.xregdocno) RETURNING g_sub_success,g_ap_slip
   CALL s_fin_get_doc_para(g_xreg_m.xregld,l_xreg.xregcomp,g_ap_slip,'D-FIN-0030') RETURNING l_chr
   IF l_chr <> 'Y' OR  cl_null(l_chr) THEN RETURN END IF 
    
   #取得單別
   CALL s_aooi200_fin_get_slip(g_xreg_m.xregdocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接抛转凭证"參數
   CALL s_fin_get_doc_para(g_xreg_m.xregld,l_xreg.xregcomp,l_slip,'D-FIN-0032') RETURNING l_dfin0032
    
   IF cl_null(l_dfin0032) OR l_dfin0032 MATCHES '[Nn]' THEN #參數值為空或為N則不做直接抛转凭证邏輯
      RETURN 
   END IF 
   #取得傳票單別(D-FIN-2002:產生之總帳傳票單別)
   LET l_gl_slip = ''
   CALL s_fin_get_doc_para(g_xreg_m.xregld,l_xreg.xregcomp,l_slip,'D-FIN-2002') RETURNING l_gl_slip
   
   IF NOT cl_ask_confirm('aap-00404') THEN RETURN END IF  #询问是否直接抛转凭证
   IF cl_null(l_gl_slip) THEN
      #產生單別/日期
      CALL aapp330_01(g_xreg_m.xregld,g_xreg_m.xregdocdt,'P40',g_xreg_m.xregdocno) RETURNING l_gl_slip,l_date   #161213-00023#2 add g_xreg_m.xregdocno
      
      #必須大於帳套關帳日期才可拋轉
      IF l_date < l_sfin3007 THEN 
         RETURN
      END IF
   ELSE 
     
      LET l_date = g_xreg_m.xregdocdt
   END IF 
   
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success            #不走分錄時使用
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #走分錄時使用
   CALL s_fin_continue_no_tmp()               
   CALL s_fin_create_account_center_tmp()     #展組織下階成員所需之暫存檔 
   CALL s_transaction_begin()
   
   DELETE FROM s_voucher_tmp
   
   INSERT INTO s_voucher_tmp (docno,type)
          VALUES (g_xreg_m.xregdocno, '0' )
   SELECT docno INTO l_docno FROM s_voucher_tmp WHERE type = 0
   
   SELECT count(*) INTO l_count
     FROM s_voucher_tmp
   IF l_count > 0 THEN
      CALL s_aapp330_gen_ac('1','P40',g_xreg_m.xregld,'','','1','!#@',l_xreg.xregstus) RETURNING g_sub_success,l_start_no,l_start_no
      IF g_sub_success THEN
         CALL s_transaction_end('Y','Y')
      ELSE
         CALL s_transaction_end('N','Y')
      END IF
   
      #傳票拋轉
      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      CALL s_aapp330_generate_voucher('P40',l_gl_slip,l_date,g_xreg_m.xregld,'1','Y',g_glaa102,'AP')
           RETURNING g_sub_success,l_xreg.xreg005,l_xreg.xreg005
      
      #成功則更新aapt920的傳票號碼
      IF g_sub_success THEN
         UPDATE xreg_t SET xreg005 = l_xreg.xreg005
          WHERE xregent = g_enterprise
            AND xregdocno = g_xreg_m.xregdocno
            AND xreg003 ='AP'
        
         UPDATE glga_t SET glga007 =  l_xreg.xreg005
          WHERE glgaent = g_enterprise AND glgald = g_xreg_m.xregld 
            AND glgadocno=g_xreg_m.xregdocno AND glga100 = 'AP' AND glga101 = 'P40'
        
         CALL s_transaction_end('Y','Y')
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00217'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         CALL s_transaction_end('N','Y')
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'adz-00218'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      CALL cl_err_collect_show()
   END IF
     
#151125-00006#2---e
END FUNCTION

 
{</section>}
 
