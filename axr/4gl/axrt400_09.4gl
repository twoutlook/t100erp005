#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt400_09.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2014-11-25 10:45:43), PR版次:0010(2017-01-19 14:21:03)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000253
#+ Filename...: axrt400_09
#+ Description: 差異金額處理
#+ Creator....: 01727(2013-11-26 16:33:06)
#+ Modifier...: 02114 -SD/PR- 00768
 
{</section>}
 
{<section id="axrt400_09.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161031-00043#1  2016/10/31  By 01727      收款核銷單維護_20:溢收轉待抵單..幣別錯誤
#161128-00061#5  2016/12/05  by 02481      标准程式定义采用宣告模式,弃用.*写法
#161202-00030#1  2016/12/05  By 02114      当收款币别和账款币别为同一币别时,差异币别放账款币别,汇率为账款币别对本币汇率
#170119-00015#1  2017/01/19  By 00768      修改汇率取得的方式，应该考虑是日汇率还是月汇率
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util  #170119-00015#1 add
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_xrda_m        RECORD
       lbl_esc LIKE type_t.chr500, 
   lbl_ra1 LIKE type_t.chr500, 
   lbl_ra3 LIKE type_t.chr500, 
   lbl_ra2 LIKE type_t.chr500, 
   lbl_ra4 LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_type          LIKE type_t.chr1
#161128-00061#5---modify----begin------------- 
#DEFINE g_xrde_t       RECORD LIKE xrde_t.*
#DEFINE g_glaa_t       RECORD LIKE glaa_t.*
DEFINE g_xrde_t RECORD  #收款及差異處理明細檔
       xrdeent LIKE xrde_t.xrdeent, #企業編號
       xrdecomp LIKE xrde_t.xrdecomp, #法人
       xrdeld LIKE xrde_t.xrdeld, #帳套
       xrdedocno LIKE xrde_t.xrdedocno, #沖銷單單號
       xrdeseq LIKE xrde_t.xrdeseq, #項次
       xrdesite LIKE xrde_t.xrdesite, #帳務中心
       xrdeorga LIKE xrde_t.xrdeorga, #帳務歸屬組織
       xrde001 LIKE xrde_t.xrde001, #來源作業
       xrde002 LIKE xrde_t.xrde002, #沖銷帳款類型
       xrde003 LIKE xrde_t.xrde003, #來源單號
       xrde004 LIKE xrde_t.xrde004, #來源單項次
       xrde006 LIKE xrde_t.xrde006, #款別編號
       xrde007 LIKE xrde_t.xrde007, #款別編號
       xrde008 LIKE xrde_t.xrde008, #帳戶/票券號碼
       xrde010 LIKE xrde_t.xrde010, #摘要
       xrde011 LIKE xrde_t.xrde011, #銀行存提碼
       xrde012 LIKE xrde_t.xrde012, #現金變動碼
       xrde013 LIKE xrde_t.xrde013, #轉入客商碼
       xrde014 LIKE xrde_t.xrde014, #轉入帳款單編號
       xrde015 LIKE xrde_t.xrde015, #沖銷加減項
       xrde016 LIKE xrde_t.xrde016, #沖銷會科
       xrde017 LIKE xrde_t.xrde017, #業務人員
       xrde018 LIKE xrde_t.xrde018, #業務部門
       xrde019 LIKE xrde_t.xrde019, #責任中心
       xrde020 LIKE xrde_t.xrde020, #產品類別
       xrde022 LIKE xrde_t.xrde022, #專案編號
       xrde023 LIKE xrde_t.xrde023, #WBS編號
       xrde028 LIKE xrde_t.xrde028, #產生方式
       xrde029 LIKE xrde_t.xrde029, #傳票號碼
       xrde030 LIKE xrde_t.xrde030, #傳票項次
       xrde035 LIKE xrde_t.xrde035, #區域
       xrde036 LIKE xrde_t.xrde036, #客群
       xrde038 LIKE xrde_t.xrde038, #對象
       xrde039 LIKE xrde_t.xrde039, #經營方式
       xrde040 LIKE xrde_t.xrde040, #通路
       xrde041 LIKE xrde_t.xrde041, #品牌
       xrde042 LIKE xrde_t.xrde042, #自由核算項一
       xrde043 LIKE xrde_t.xrde043, #自由核算項二
       xrde044 LIKE xrde_t.xrde044, #自由核算項三
       xrde045 LIKE xrde_t.xrde045, #自由核算項四
       xrde046 LIKE xrde_t.xrde046, #自由核算項五
       xrde047 LIKE xrde_t.xrde047, #自由核算項六
       xrde048 LIKE xrde_t.xrde048, #自由核算項七
       xrde049 LIKE xrde_t.xrde049, #自由核算項八
       xrde050 LIKE xrde_t.xrde050, #自由核算項九
       xrde051 LIKE xrde_t.xrde051, #自由核算項十
       xrde100 LIKE xrde_t.xrde100, #幣別
       xrde101 LIKE xrde_t.xrde101, #匯率
       xrde109 LIKE xrde_t.xrde109, #原幣沖帳金額
       xrde119 LIKE xrde_t.xrde119, #本幣沖帳金額
       xrde120 LIKE xrde_t.xrde120, #本位幣二幣別
       xrde121 LIKE xrde_t.xrde121, #本位幣二匯率
       xrde129 LIKE xrde_t.xrde129, #本位幣二沖帳金額
       xrde130 LIKE xrde_t.xrde130, #本位幣三幣別
       xrde131 LIKE xrde_t.xrde131, #本位幣三匯率
       xrde139 LIKE xrde_t.xrde139, #本位幣三沖帳金額
       xrde032 LIKE xrde_t.xrde032, #收款日期
       xrde108 LIKE xrde_t.xrde108, #原幣手續費
       xrde118 LIKE xrde_t.xrde118  #本幣手續費
       END RECORD
DEFINE g_glaa_t RECORD  #帳套資料檔
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
#161128-00061#5---modify----end------------- 
DEFINE g_xrdasite      LIKE xrda_t.xrdasite
DEFINE g_comp          LIKE xrda_t.xrdacomp
DEFINE g_xrda003       LIKE xrda_t.xrda003
DEFINE g_xrda004       LIKE xrda_t.xrda004
DEFINE g_docno         LIKE xrda_t.xrdadocno
DEFINE g_docdt         LIKE xrda_t.xrdadocdt
DEFINE g_ld            LIKE xrda_t.xrdald
DEFINE g_amt1          LIKE xrce_t.xrce109
DEFINE g_amt2          LIKE xrce_t.xrce109
DEFINE g_amt3          LIKE xrce_t.xrce109

#170119-00015#1 add--s
DEFINE g_xrda   RECORD
                xrdacomp    LIKE xrda_t.xrdacomp ,
                xrdald      LIKE xrda_t.xrdald   ,
                xrdadocdt   LIKE xrda_t.xrdadocdt,
                xrda005     LIKE xrda_t.xrda005
                END RECORD
#170119-00015#1 add--s
#end add-point
 
DEFINE g_xrda_m        type_g_xrda_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrt400_09.input" >}
#+ 資料輸入
PUBLIC FUNCTION axrt400_09(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_type,p_xrdasite,p_comp,p_xrda003,p_xrda004,p_docno,p_docdt,p_ld,p_amt
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
   DEFINE p_type          LIKE type_t.chr1
   DEFINE p_xrdasite      LIKE xrda_t.xrdasite
   DEFINE p_comp          LIKE xrda_t.xrdacomp
   DEFINE p_xrda003       LIKE xrda_t.xrda003
   DEFINE p_xrda004       LIKE xrda_t.xrda004
   DEFINE p_docno         LIKE xrda_t.xrdadocno
   DEFINE p_docdt         LIKE xrda_t.xrdadocdt
   DEFINE p_ld            LIKE xrda_t.xrdald
   DEFINE p_amt           LIKE xrce_t.xrce109
   
   
   #170119-00015#1 add--s
   SELECT xrdacomp,xrdald,xrdadocdt,xrda005
     INTO g_xrda.xrdacomp,g_xrda.xrdald,g_xrda.xrdadocdt,g_xrda.xrda005
     FROM xrda_t
    WHERE xrdaent   = g_enterprise
      AND xrdald    = p_ld
      AND xrdadocno = p_docno
   #170119-00015#1 add--e
   
   #2015/11/02--by--02599--add--str--
   #axrt460中調用，且不顯示畫面
   IF g_prog='axrt460' THEN
      LET g_type    = p_type
      LET g_xrdasite= p_xrdasite
      LET g_comp    = p_comp
      LET g_xrda003 = p_xrda003
      LET g_xrda004 = p_xrda004
      LET g_docno   = p_docno
      LET g_docdt   = p_docdt
      LET g_ld      = p_ld
      LET g_amt1    = p_amt
      #161128-00061#5-----modify--begin----------
      #SELECT * INTO g_glaa_t.* 
       SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
              glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
              glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
              glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
              glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
              glaa140,glaa123,glaa124,glaa028 INTO g_glaa_t.* 
      #161128-00061#5----modify--end----------
      FROM glaa_t
       WHERE glaaent = g_enterprise AND glaald  = g_ld
      IF g_type = '1' THEN
         LET g_xrda_m.lbl_ra1 = '12'
      ELSE
         LET g_xrda_m.lbl_ra2 = '11'
      END IF
      LET g_prog='axrt400'
      CALL axrt400_09_ins_xrde()
      LET g_prog='axrt460'
      RETURN
   END IF
   #2015/11/02--by--02599--add--end
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axrt400_09 WITH FORM cl_ap_formpath("axr","axrt400_09")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_type    = p_type
   LET g_xrdasite= p_xrdasite
   LET g_comp    = p_comp
   LET g_xrda003 = p_xrda003
   LET g_xrda004 = p_xrda004
   LET g_docno   = p_docno
   LET g_docdt   = p_docdt
   LET g_ld      = p_ld
   LET g_amt1    = p_amt
   
   IF g_type = '1' THEN
      CALL cl_set_comp_entry('lbl_ra2',FALSE)
      #LET g_xrda_m.lbl_ra2 = 0
      LET g_xrda_m.lbl_ra2 = ''
   ELSE
      CALL cl_set_comp_entry('lbl_ra1',FALSE)
      #LET g_xrda_m.lbl_ra1 = 0
      LET g_xrda_m.lbl_ra1 = ''
   END IF
   
   IF g_prog = 'axrt400' THEN 
      CALL cl_set_comp_visible('lbl_ra3',FALSE)
      CALL cl_set_comp_visible('lbl_ra4',FALSE)
   ELSE
      IF p_type = '1' THEN 
         CALL cl_set_comp_visible('lbl_group3',FALSE)
         CALL cl_set_comp_visible('lbl_ra1',FALSE)
      ELSE
         CALL cl_set_comp_visible('lbl_group2',FALSE)
         CALL cl_set_comp_visible('lbl_ra2',FALSE)
      END IF
   END IF
   
   #161128-00061#5-----modify--begin----------
   #SELECT * INTO g_glaa_t.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
           glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
           glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
           glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
           glaa140,glaa123,glaa124,glaa028 INTO g_glaa_t.* 
   #161128-00061#5----modify--end----------
   FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_ld
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xrda_m.lbl_esc,g_xrda_m.lbl_ra1,g_xrda_m.lbl_ra3,g_xrda_m.lbl_ra2,g_xrda_m.lbl_ra4  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_xrda_m.lbl_esc = ''
            IF g_type = '1' THEN
               IF g_prog = 'axrt400' THEN 
                  LET g_xrda_m.lbl_ra1 = '12'
               ELSE
                  LET g_xrda_m.lbl_ra3 = '12'
               END IF
            ELSE
               IF g_prog = 'axrt400' THEN 
                  LET g_xrda_m.lbl_ra2 = '11'
               ELSE
                  LET g_xrda_m.lbl_ra4 = '11'
               END IF
            END IF
            DISPLAY BY NAME g_xrda_m.lbl_esc,g_xrda_m.lbl_ra1,g_xrda_m.lbl_ra2
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_esc
            #add-point:BEFORE FIELD lbl_esc name="input.b.lbl_esc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_esc
            
            #add-point:AFTER FIELD lbl_esc name="input.a.lbl_esc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_esc
            #add-point:ON CHANGE lbl_esc name="input.g.lbl_esc"
            IF NOT cl_null(g_xrda_m.lbl_esc) AND g_xrda_m.lbl_esc = '1' THEN
               LET g_xrda_m.lbl_ra1 = ''
               LET g_xrda_m.lbl_ra2 = ''
               DISPLAY BY NAME g_xrda_m.lbl_ra1,g_xrda_m.lbl_ra2
               EXIT DIALOG
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_ra1
            #add-point:BEFORE FIELD lbl_ra1 name="input.b.lbl_ra1"
            IF g_type = '2' THEN
               NEXT FIELD lbl_ra2
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_ra1
            
            #add-point:AFTER FIELD lbl_ra1 name="input.a.lbl_ra1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_ra1
            #add-point:ON CHANGE lbl_ra1 name="input.g.lbl_ra1"
            IF NOT cl_null(g_xrda_m.lbl_ra1) THEN lET g_xrda_m.lbl_ra2 = Null END IF
            DISPLAY BY NAME g_xrda_m.lbl_ra1
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_ra3
            #add-point:BEFORE FIELD lbl_ra3 name="input.b.lbl_ra3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_ra3
            
            #add-point:AFTER FIELD lbl_ra3 name="input.a.lbl_ra3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_ra3
            #add-point:ON CHANGE lbl_ra3 name="input.g.lbl_ra3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_ra2
            #add-point:BEFORE FIELD lbl_ra2 name="input.b.lbl_ra2"
            IF g_type = '1' THEN
               NEXT FIELD lbl_ra1
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_ra2
            
            #add-point:AFTER FIELD lbl_ra2 name="input.a.lbl_ra2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_ra2
            #add-point:ON CHANGE lbl_ra2 name="input.g.lbl_ra2"
            IF NOT cl_null(g_xrda_m.lbl_ra1) THEN lET g_xrda_m.lbl_ra2 = Null END IF
            DISPLAY BY NAME g_xrda_m.lbl_ra2
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_ra4
            #add-point:BEFORE FIELD lbl_ra4 name="input.b.lbl_ra4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_ra4
            
            #add-point:AFTER FIELD lbl_ra4 name="input.a.lbl_ra4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_ra4
            #add-point:ON CHANGE lbl_ra4 name="input.g.lbl_ra4"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.lbl_esc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_esc
            #add-point:ON ACTION controlp INFIELD lbl_esc name="input.c.lbl_esc"
            
            #END add-point
 
 
         #Ctrlp:input.c.lbl_ra1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_ra1
            #add-point:ON ACTION controlp INFIELD lbl_ra1 name="input.c.lbl_ra1"
            
            #END add-point
 
 
         #Ctrlp:input.c.lbl_ra3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_ra3
            #add-point:ON ACTION controlp INFIELD lbl_ra3 name="input.c.lbl_ra3"
            
            #END add-point
 
 
         #Ctrlp:input.c.lbl_ra2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_ra2
            #add-point:ON ACTION controlp INFIELD lbl_ra2 name="input.c.lbl_ra2"
            
            #END add-point
 
 
         #Ctrlp:input.c.lbl_ra4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_ra4
            #add-point:ON ACTION controlp INFIELD lbl_ra4 name="input.c.lbl_ra4"
            
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
   CLOSE WINDOW w_axrt400_09 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG OR g_xrda_m.lbl_esc = '1' THEN
      LET INT_FLAG = FALSE
      RETURN
   END IF
   
   IF g_xrda_m.lbl_ra1 = '12' OR g_xrda_m.lbl_ra2 = '11' OR g_xrda_m.lbl_ra3 = '12' OR g_xrda_m.lbl_ra4 = '11' THEN
      CALL axrt400_09_ins_xrde()
   ELSE
      CALL axrt400_09_ref_amt()
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrt400_09.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axrt400_09.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 根據條件,處理單據金額差異
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
PRIVATE FUNCTION axrt400_09_ins_xrde()
   DEFINE l_glab003     LIKE glab_t.glab003
   #161128-00061#5---modify----begin------------- 
   #DEFINE l_xrde_t      RECORD LIKE xrde_t.*
   DEFINE l_xrde_t RECORD  #收款及差異處理明細檔
       xrdeent LIKE xrde_t.xrdeent, #企業編號
       xrdecomp LIKE xrde_t.xrdecomp, #法人
       xrdeld LIKE xrde_t.xrdeld, #帳套
       xrdedocno LIKE xrde_t.xrdedocno, #沖銷單單號
       xrdeseq LIKE xrde_t.xrdeseq, #項次
       xrdesite LIKE xrde_t.xrdesite, #帳務中心
       xrdeorga LIKE xrde_t.xrdeorga, #帳務歸屬組織
       xrde001 LIKE xrde_t.xrde001, #來源作業
       xrde002 LIKE xrde_t.xrde002, #沖銷帳款類型
       xrde003 LIKE xrde_t.xrde003, #來源單號
       xrde004 LIKE xrde_t.xrde004, #來源單項次
       xrde006 LIKE xrde_t.xrde006, #款別編號
       xrde007 LIKE xrde_t.xrde007, #款別編號
       xrde008 LIKE xrde_t.xrde008, #帳戶/票券號碼
       xrde010 LIKE xrde_t.xrde010, #摘要
       xrde011 LIKE xrde_t.xrde011, #銀行存提碼
       xrde012 LIKE xrde_t.xrde012, #現金變動碼
       xrde013 LIKE xrde_t.xrde013, #轉入客商碼
       xrde014 LIKE xrde_t.xrde014, #轉入帳款單編號
       xrde015 LIKE xrde_t.xrde015, #沖銷加減項
       xrde016 LIKE xrde_t.xrde016, #沖銷會科
       xrde017 LIKE xrde_t.xrde017, #業務人員
       xrde018 LIKE xrde_t.xrde018, #業務部門
       xrde019 LIKE xrde_t.xrde019, #責任中心
       xrde020 LIKE xrde_t.xrde020, #產品類別
       xrde022 LIKE xrde_t.xrde022, #專案編號
       xrde023 LIKE xrde_t.xrde023, #WBS編號
       xrde028 LIKE xrde_t.xrde028, #產生方式
       xrde029 LIKE xrde_t.xrde029, #傳票號碼
       xrde030 LIKE xrde_t.xrde030, #傳票項次
       xrde035 LIKE xrde_t.xrde035, #區域
       xrde036 LIKE xrde_t.xrde036, #客群
       xrde038 LIKE xrde_t.xrde038, #對象
       xrde039 LIKE xrde_t.xrde039, #經營方式
       xrde040 LIKE xrde_t.xrde040, #通路
       xrde041 LIKE xrde_t.xrde041, #品牌
       xrde042 LIKE xrde_t.xrde042, #自由核算項一
       xrde043 LIKE xrde_t.xrde043, #自由核算項二
       xrde044 LIKE xrde_t.xrde044, #自由核算項三
       xrde045 LIKE xrde_t.xrde045, #自由核算項四
       xrde046 LIKE xrde_t.xrde046, #自由核算項五
       xrde047 LIKE xrde_t.xrde047, #自由核算項六
       xrde048 LIKE xrde_t.xrde048, #自由核算項七
       xrde049 LIKE xrde_t.xrde049, #自由核算項八
       xrde050 LIKE xrde_t.xrde050, #自由核算項九
       xrde051 LIKE xrde_t.xrde051, #自由核算項十
       xrde100 LIKE xrde_t.xrde100, #幣別
       xrde101 LIKE xrde_t.xrde101, #匯率
       xrde109 LIKE xrde_t.xrde109, #原幣沖帳金額
       xrde119 LIKE xrde_t.xrde119, #本幣沖帳金額
       xrde120 LIKE xrde_t.xrde120, #本位幣二幣別
       xrde121 LIKE xrde_t.xrde121, #本位幣二匯率
       xrde129 LIKE xrde_t.xrde129, #本位幣二沖帳金額
       xrde130 LIKE xrde_t.xrde130, #本位幣三幣別
       xrde131 LIKE xrde_t.xrde131, #本位幣三匯率
       xrde139 LIKE xrde_t.xrde139, #本位幣三沖帳金額
       xrde032 LIKE xrde_t.xrde032, #收款日期
       xrde108 LIKE xrde_t.xrde108, #原幣手續費
       xrde118 LIKE xrde_t.xrde118  #本幣手續費
       END RECORD
   #161128-00061#5---modify----end-------------      
   DEFINE l_sql         STRING
   DEFINE l_xrde100     LIKE xrde_t.xrde100
   DEFINE l_xrde109     LIKE xrde_t.xrde109
   DEFINE l_xrde119     LIKE xrde_t.xrde119
   DEFINE l_xrde109_1   LIKE xrde_t.xrde109
   DEFINE l_xrde119_1   LIKE xrde_t.xrde119
   DEFINE l_xrde109_2   LIKE xrde_t.xrde109
   DEFINE l_xrde119_2   LIKE xrde_t.xrde119
   DEFINE l_ooab002     LIKE ooab_t.ooab002
   DEFINE l_amt         LIKE xrde_t.xrde119   #匯差

   SELECT MAX(xrdeseq) + 1 INTO l_xrde_t.xrdeseq
     FROM xrde_t
    WHERE xrdeent = g_enterprise 
      AND xrdeld = g_ld
      AND xrdedocno = g_docno
      
   IF cl_null(l_xrde_t.xrdeseq) THEN 
      LET l_xrde_t.xrdeseq = 1
   END IF
   
   IF l_xrde_t.xrdeseq > 1 THEN 
      SELECT xrde010 INTO l_xrde_t.xrde010
        FROM xrde_t
       WHERE xrdeent = g_enterprise
         AND xrdeld = g_ld
         AND xrdedocno = g_docno
         AND xrdeseq = l_xrde_t.xrdeseq - 1 
   END IF

   LET l_xrde_t.xrdeent  = g_enterprise
   LET l_xrde_t.xrdecomp = g_comp
   LET l_xrde_t.xrdeld   = g_ld
   LET l_xrde_t.xrdesite = g_xrdasite
   LET l_xrde_t.xrdedocno= g_docno

   #計算差異
   #依次計算本位幣三、本位幣二、本位幣

#   #本位幣三
#   IF g_glaa_t.glaa019 = 'Y' THEN
#      LET l_sql ="SELECT xrce100,SUM(xrce139),SUM(xrce139_1)",
#                 "  FROM(",
#                 "       SELECT xrce100,SUM(xrce139) xrce139,0 xrce139_1 FROM xrce_t,gzcb_t",
#                 "        WHERE xrce002 = gzcb002",
#                 "          AND gzcb001 = '8306'",
#                 "          AND gzcb004 = '1'",
#                 "          AND xrceent = '",g_enterprise,"'",
#                 "          AND xrcedocno = '",g_docno,"'",
#                 "          AND xrceld = '",g_ld,"'",
#                 "        GROUP BY xrce100",
#                 "        UNION ",
#                 "       SELECT xrce100,0 xrce139,SUM(xrce139) xrce139_1 FROM xrce_t,gzcb_t",
#                 "        WHERE xrce002 = gzcb002",
#                 "          AND gzcb001 = '8306'",
#                 "          AND gzcb004 = '2'",
#                 "          AND xrceent = '",g_enterprise,"'",
#                 "          AND xrcedocno = '",g_docno,"'",
#                 "          AND xrceld = '",g_ld,"'",
#                 "        GROUP BY xrce100",
#                 "      )",
#                 " GROUP BY xrce100"
#      PREPARE axrt400_01_prep313 FROM l_sql
#      DECLARE axrt400_01_xrce13 CURSOR FOR axrt400_01_prep313
#   
#      #產生本位幣三匯兌損益
#      FOREACH axrt400_01_xrce13 INTO l_xrce100,l_xrce119,l_xrce119_1
#         #本幣帳款 < 收款:12.匯兌收益;　反之 11.匯兌損失.
#         IF l_xrce119 != l_xrce119_1 THEN
#            IF l_xrce119 < l_xrce119_1 THEN
#               LET l_xrce_t.xrce002  = '11'
#               LET l_glab003 = '9711_12'
#               LET l_amt = l_xrce119_1 - l_xrce119
#            ELSE
#               LET l_xrce_t.xrce002  = '12'
#               LET l_glab003 = '9711_11'
#               LET l_amt = l_xrce119 - l_xrce119_1
#            END IF
#            SELECT gzcb003 INTO l_xrce_t.xrce015 FROM gzcb_t
#             WHERE gzcb002 = l_xrce_t.xrce002
#               AND gzcb001 = '8306'
#            LET l_xrce_t.xrce006  = ''
#            LET l_xrce_t.xrce001  = 'axrt400'
#            LET l_xrce_t.xrce003  = ''
#            LET l_xrce_t.xrce004  = ''
#            LET l_xrce_t.xrce005  = ''
#            LET l_xrce_t.xrce024  = ''
#            LET l_xrce_t.xrce025  = ''
#            LET l_xrce_t.xrce007  = ''
#            LET l_xrce_t.xrce008  = ''
#            LET l_xrce_t.xrce009  = 'N'
#            LET l_xrce_t.xrce010  = ''
#            LET l_xrce_t.xrce013  = ''
#            LET l_xrce_t.xrce014  = ''
#            LET l_xrce_t.xrce020  = ''
#            LET l_xrce_t.xrce021  = ''
#            LET l_xrce_t.xrce022  = ''
#            LET l_xrce_t.xrce023  = ''
#            LET l_xrce_t.xrce017  = g_xrda003
#            SELECT ooag003,ooag004 INTO l_xrce_t.xrce018,l_xrce_t.xrceorga FROM ooag_t
#             WHERE ooagent = g_enterprise
#               AND ooag001 = g_xrda003
#            LET l_xrce_t.xrce019  = l_xrce_t.xrceorga
#               
#            SELECT glab005,glab010 INTO l_xrce_t.xrce016,l_xrce_t.xrce011 FROM glab_t
#             WHERE glabent = g_enterprise
#               AND glabld = g_ld
#               AND glab003 = l_glab003
#            
#            SELECT nmad003 INTO l_xrce_t.xrce012 FROM nmad_t
#             WHERE nmadent = g_enterprise
#               AND nmad001 = g_glaa_t.glaa005
#               AND nmad002 = l_xrce_t.xrce011
#              
#            SELECT gzcb003 INTO l_xrce_t.xrce015 FROM gzcb_t
#             WHERE gzcb002 = '20'
#               AND gzcb001 = '8306'
#
#            SELECT ooab002 INTO l_ooab002 FROM ooab_t
#             WHERE ooabent = g_enterprise
#               AND ooabsite= g_site
#               AND ooab001 = 'S-BAS-0010'
#   
#                                     #類型;帳套;日期;來源幣別
#            CALL s_aooi160_get_exrate('2',g_ld,g_docdt,g_glaa_t.glaa020,
#                                     #目的幣別;         交易金額;               匯類類型
#                                      g_glaa_t.glaa001,l_amt,g_glaa_t.glaa022)
#                RETURNING l_xrce_t.xrce109
#
#                                     #類型;帳套;日期;來源幣別
#            CALL s_aooi160_get_exrate('2',g_ld,g_docdt,g_glaa_t.glaa001,
#                                     #目的幣別;         交易金額;               匯類類型
#                                      g_glaa_t.glaa020,0,g_glaa_t.glaa022)
#                RETURNING l_xrce_t.xrce131
#
#            LET l_xrce_t.xrce100  = g_glaa_t.glaa001
#            LET l_xrce_t.xrce101  = 1
#            LET l_xrce_t.xrce119  = l_xrce_t.xrce109
#            LET l_xrce_t.xrce120  = ''
#            LET l_xrce_t.xrce121  = 0
#            LET l_xrce_t.xrce129  = 0
#            LET l_xrce_t.xrce130  = g_glaa_t.glaa020
#            LET l_xrce_t.xrce139  = l_amt
#            
#            IF l_xrce_t.xrce119 < 0 THEN 
#               LET l_xrce_t.xrce119 = l_xrce_t.xrce119 * -1
#            END IF
#            
#            IF l_xrce_t.xrce129 < 0 THEN 
#               LET l_xrce_t.xrce129 = l_xrce_t.xrce129 * -1
#            END IF
#            
#            IF l_xrce_t.xrce139 < 0 THEN 
#               LET l_xrce_t.xrce139 = l_xrce_t.xrce139 * -1
#            END IF
#
#            INSERT INTO xrce_t VALUES(l_xrce_t.*)
#            IF SQLCA.sqlcode THEN
#               LET g_success = 'N' RETURN
#            END IF
#            
#            LET l_xrce_t.xrceseq = l_xrce_t.xrceseq + 1
#            
#         END IF
#
#      END FOREACH
#   END IF
#
#
#   #本位幣二
#   IF g_glaa_t.glaa015 = 'Y' THEN
#      LET l_sql ="SELECT xrce100,SUM(xrce129),SUM(xrce129_1)",
#                 "  FROM(",
#                 "       SELECT xrce100,SUM(xrce129) xrce129,0 xrce129_1 FROM xrce_t,gzcb_t",
#                 "        WHERE xrce002 = gzcb002",
#                 "          AND gzcb001 = '8306'",
#                 "          AND gzcb004 = '1'",
#                 "          AND xrceent = '",g_enterprise,"'",
#                 "          AND xrcedocno = '",g_docno,"'",
#                 "          AND xrceld = '",g_ld,"'",
#                 "        GROUP BY xrce100",
#                 "        UNION ",
#                 "       SELECT xrce100,0 xrce129,SUM(xrce129) xrce129_1 FROM xrce_t,gzcb_t",
#                 "        WHERE xrce002 = gzcb002",
#                 "          AND gzcb001 = '8306'",
#                 "          AND gzcb004 = '2'",
#                 "          AND xrceent = '",g_enterprise,"'",
#                 "          AND xrcedocno = '",g_docno,"'",
#                 "          AND xrceld = '",g_ld,"'",
#                 "        GROUP BY xrce100",
#                 "      )",
#                 " GROUP BY xrce100"
#      PREPARE axrt400_01_prep312 FROM l_sql
#      DECLARE axrt400_01_xrce12 CURSOR FOR axrt400_01_prep312
#   
#      #產生本位幣二匯兌損益
#      FOREACH axrt400_01_xrce12 INTO l_xrce100,l_xrce119,l_xrce119_1
#         #本幣帳款 < 收款:12.匯兌收益;　反之 11.匯兌損失.
#         IF l_xrce119 != l_xrce119_1 THEN
#            IF l_xrce119 < l_xrce119_1 THEN
#               LET l_xrce_t.xrce002  = '11'
#               LET l_glab003 = '9711_12'
#               LET l_amt = l_xrce119_1 - l_xrce119
#            ELSE
#               LET l_xrce_t.xrce002  = '12'
#               LET l_glab003 = '9711_11'
#               LET l_amt = l_xrce119 - l_xrce119_1
#            END IF
#            SELECT gzcb003 INTO l_xrce_t.xrce015 FROM gzcb_t
#             WHERE gzcb002 = l_xrce_t.xrce002
#               AND gzcb001 = '8306'
#            LET l_xrce_t.xrce006  = ''
#            LET l_xrce_t.xrce001  = 'axrt400'
#            LET l_xrce_t.xrce003  = ''
#            LET l_xrce_t.xrce004  = ''
#            LET l_xrce_t.xrce005  = ''
#            LET l_xrce_t.xrce024  = ''
#            LET l_xrce_t.xrce025  = ''
#            LET l_xrce_t.xrce007  = ''
#            LET l_xrce_t.xrce008  = ''
#            LET l_xrce_t.xrce009  = 'N'
#            LET l_xrce_t.xrce010  = ''
#            LET l_xrce_t.xrce013  = ''
#            LET l_xrce_t.xrce014  = ''
#            LET l_xrce_t.xrce020  = ''
#            LET l_xrce_t.xrce021  = ''
#            LET l_xrce_t.xrce022  = ''
#            LET l_xrce_t.xrce023  = ''
#            LET l_xrce_t.xrce017  = g_xrda003
#            SELECT ooag003,ooag004 INTO l_xrce_t.xrce018,l_xrce_t.xrceorga FROM ooag_t
#             WHERE ooagent = g_enterprise
#               AND ooag001 = g_xrda003
#            LET l_xrce_t.xrce019  = l_xrce_t.xrceorga
#               
#            SELECT glab005,glab010 INTO l_xrce_t.xrce016,l_xrce_t.xrce011 FROM glab_t
#             WHERE glabent = g_enterprise
#               AND glabld = g_ld
#               AND glab003 = l_glab003
#            
#            SELECT nmad003 INTO l_xrce_t.xrce012 FROM nmad_t
#             WHERE nmadent = g_enterprise
#               AND nmad001 = g_glaa_t.glaa005
#               AND nmad002 = l_xrce_t.xrce011
#              
#            SELECT gzcb003 INTO l_xrce_t.xrce015 FROM gzcb_t
#             WHERE gzcb002 = '20'
#               AND gzcb001 = '8306'
#
#                                     #類型;帳套;日期;來源幣別
#            CALL s_aooi160_get_exrate('2',g_ld,g_docdt,g_glaa_t.glaa016,
#                                     #目的幣別;         交易金額;               匯類類型
#                                      g_glaa_t.glaa001,l_amt,g_glaa_t.glaa018)
#                RETURNING l_xrce_t.xrce109
#                
#            IF l_xrce_t.xrce109 = 1 THEN LET l_xrce_t.xrce109 = l_amt END IF
#
#                                     #類型;帳套;日期;來源幣別
#            CALL s_aooi160_get_exrate('2',g_ld,g_docdt,g_glaa_t.glaa001,
#                                     #目的幣別;         交易金額;               匯類類型
#                                      g_glaa_t.glaa016,0,g_glaa_t.glaa018)
#                RETURNING l_xrce_t.xrce121
#
#            LET l_xrce_t.xrce100  = g_glaa_t.glaa001
#            LET l_xrce_t.xrce101  = 1
#            LET l_xrce_t.xrce119  = l_xrce_t.xrce109
#            LET l_xrce_t.xrce120  = g_glaa_t.glaa016
#            LET l_xrce_t.xrce129  = l_amt
#            LET l_xrce_t.xrce130  = ''
#            LET l_xrce_t.xrce131  = 0
#            LET l_xrce_t.xrce139  = 0
#            
#            IF l_xrce_t.xrce119 < 0 THEN 
#               LET l_xrce_t.xrce119 = l_xrce_t.xrce119 * -1
#            END IF
#            
#            IF l_xrce_t.xrce129 < 0 THEN 
#               LET l_xrce_t.xrce129 = l_xrce_t.xrce129 * -1
#            END IF
#            
#            IF l_xrce_t.xrce139 < 0 THEN 
#               LET l_xrce_t.xrce139 = l_xrce_t.xrce139 * -1
#            END IF
#
#            INSERT INTO xrce_t VALUES(l_xrce_t.*)
#            IF SQLCA.sqlcode THEN
#               LET g_success = 'N' RETURN
#            END IF
#            
#            LET l_xrce_t.xrceseq = l_xrce_t.xrceseq + 1
#            
#         END IF
#
#      END FOREACH
#   END IF

   #本幣
   LET l_sql ="SELECT SUM(xrde109),SUM(xrde119),SUM(xrde109_1),SUM(xrde119_1),SUM(xrde109_2),SUM(xrde119_2)",
              "  FROM(",
              "       SELECT SUM(xrde109) xrde109,SUM(xrde119) xrde119,0 xrde109_1,0 xrde119_1,0 xrde109_2,0 xrde119_2 FROM xrde_t",       #收款金額
              "        WHERE xrde002 = 10",
              "          AND xrdeent = '",g_enterprise,"'",
              "          AND xrdedocno = '",g_docno,"'",
              "          AND xrdeld = '",g_ld,"'",
              "        UNION ",
              "       SELECT 0 xrde109,0 xrde119,SUM(xrce109 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END) xrde109_1,SUM(xrce119 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END) xrde119_1,0 xrde109_2,0 xrde119_2 FROM xrce_t,gzcb_t",#帳款金額
              "        WHERE xrce002 = gzcb002",
              "          AND gzcb001 = '8306'",
              "          AND gzcb004 = '2'",
              "          AND xrceent = '",g_enterprise,"'",
              "          AND xrcedocno = '",g_docno,"'",
              "          AND xrceld = '",g_ld,"'",
              "        UNION ",
              "       SELECT 0 xrde109,0 xrde119,0 xrde109_1,0 xrde119_1,SUM(xrde109 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END) xrde109_2,SUM(xrde119 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END) xrde119_2 FROM xrde_t,gzcb_t",#帳款金額
              "        WHERE xrde002 = gzcb002",
              "          AND gzcb001 = '8306'",
              "          AND gzcb004 = '1'",
              "          AND xrde002 <> 10",
              "          AND xrdeent = '",g_enterprise,"'",
              "          AND xrdedocno = '",g_docno,"'",
              "          AND xrdeld = '",g_ld,"'",
              "      )"
   PREPARE axrt400_01_prep31 FROM l_sql
   DECLARE axrt400_01_xrde1 CURSOR FOR axrt400_01_prep31

   FOREACH axrt400_01_xrde1 INTO l_xrde109,l_xrde119,l_xrde109_1,l_xrde119_1,l_xrde109_2,l_xrde119_2
      IF cl_null(l_xrde109)   THEN LET l_xrde109   = 0 END IF
      IF cl_null(l_xrde119)   THEN LET l_xrde119   = 0 END IF
      IF cl_null(l_xrde109_1) THEN LET l_xrde109_1 = 0 END IF
      IF cl_null(l_xrde119_1) THEN LET l_xrde119_1 = 0 END IF
      IF cl_null(l_xrde109_2) THEN LET l_xrde109_2 = 0 END IF
      IF cl_null(l_xrde119_2) THEN LET l_xrde119_2 = 0 END IF
      #本幣帳款 < 收款:12.匯兌收益;　反之(11.匯損).
      #需要考慮本位幣二、三產生的匯兌損益
      IF l_xrde119 - l_xrde119_2 != l_xrde119_1 THEN
         LET l_amt = l_xrde119 + l_xrde119_1 + l_xrde119_2
         IF g_prog <> 'axrt400' THEN 
            LET l_amt = g_amt1
         END IF
         IF l_amt < 0 THEN
            LET l_xrde_t.xrde002  = '11'
            LET l_glab003 = '9711_11'
            LET l_amt = l_amt * -1
         ELSE
            LET l_xrde_t.xrde002  = '12'
            LET l_glab003 = '9711_12'
         END IF
         SELECT gzcb003 INTO l_xrde_t.xrde015 FROM gzcb_t
          WHERE gzcb002 = l_xrde_t.xrde002
            AND gzcb001 = '8306'
         LET l_xrde_t.xrde006  = ''
         IF g_prog = 'axrt400' THEN 
            LET l_xrde_t.xrde001  = 'axrt400'
         ELSE
            LET l_xrde_t.xrde001  = 'axrt300'
         END IF
         LET l_xrde_t.xrde003  = ''
         LET l_xrde_t.xrde004  = ''
         LET l_xrde_t.xrde008  = ''
         LET l_xrde_t.xrde013  = ''
         LET l_xrde_t.xrde014  = ''
         LET l_xrde_t.xrde100  = g_glaa_t.glaa001
         LET l_xrde_t.xrde101  = 1
         LET l_xrde_t.xrde109  = 0
         LET l_xrde_t.xrde119  = l_amt
         LET l_xrde_t.xrde120 = g_glaa_t.glaa016
         LET l_xrde_t.xrde121 = 0
         LET l_xrde_t.xrde129 = 0
         LET l_xrde_t.xrde130 = g_glaa_t.glaa020
         LET l_xrde_t.xrde131 = 0
         LET l_xrde_t.xrde139 = 0
         LET l_xrde_t.xrde017  = g_xrda003
         
         SELECT ooag003 INTO l_xrde_t.xrde018 FROM ooag_t
          WHERE ooagent = g_enterprise
            AND ooag001 = g_xrda003
         
         SELECT glaacomp INTO l_xrde_t.xrdeorga 
           FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaald  = g_ld
         LET l_xrde_t.xrde019  = l_xrde_t.xrdeorga
         LET l_xrde_t.xrde020  = ''
         LET l_xrde_t.xrde022  = ''
         LET l_xrde_t.xrde023  = ''
         
             
         SELECT glab005,glab010 INTO l_xrde_t.xrde016,l_xrde_t.xrde011 FROM glab_t
          WHERE glabent = g_enterprise
            AND glabld = g_ld
            AND glab003 = l_glab003
         
         SELECT nmad003 INTO l_xrde_t.xrde012 FROM nmad_t
          WHERE nmadent = g_enterprise
            AND nmad001 = g_glaa_t.glaa005
            AND nmad002 = l_xrde_t.xrde011
           
         #SELECT gzcb003 INTO l_xrde_t.xrde015 FROM gzcb_t
         # WHERE gzcb002 = '20'
         #   AND gzcb001 = '8306'
            
         IF l_xrde_t.xrde119 < 0 THEN 
            LET l_xrde_t.xrde119 = l_xrde_t.xrde119 * -1
         END IF
         
         IF l_xrde_t.xrde129 < 0 THEN 
            LET l_xrde_t.xrde129 = l_xrde_t.xrde129 * -1
         END IF
         
         IF l_xrde_t.xrde139 < 0 THEN 
            LET l_xrde_t.xrde139 = l_xrde_t.xrde139 * -1
         END IF

         #INSERT INTO xrde_t VALUES(l_xrde_t.*)
         INSERT INTO xrde_t(xrdeent,xrdecomp,xrdeld,xrdesite,xrdeorga,xrdedocno,xrdeseq,xrde001,
                            xrde002,xrde003,xrde004,xrde006,xrde008,xrde010,xrde011,xrde012,xrde013,
                            xrde014,xrde015,xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,
                            xrde100,xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139)
                     VALUES(l_xrde_t.xrdeent ,l_xrde_t.xrdecomp ,l_xrde_t.xrdeld ,l_xrde_t.xrdesite,
                            l_xrde_t.xrdeorga,l_xrde_t.xrdedocno,l_xrde_t.xrdeseq,l_xrde_t.xrde001,
                            l_xrde_t.xrde002 ,l_xrde_t.xrde003  ,l_xrde_t.xrde004,l_xrde_t.xrde006,
                            l_xrde_t.xrde008 ,l_xrde_t.xrde010  ,l_xrde_t.xrde011,l_xrde_t.xrde012,
                            l_xrde_t.xrde013 ,l_xrde_t.xrde014  ,l_xrde_t.xrde015,l_xrde_t.xrde016,
                            l_xrde_t.xrde017 ,l_xrde_t.xrde018  ,l_xrde_t.xrde019,l_xrde_t.xrde020,
                            l_xrde_t.xrde022 ,l_xrde_t.xrde023  ,l_xrde_t.xrde100,l_xrde_t.xrde101,
                            l_xrde_t.xrde109 ,l_xrde_t.xrde119  ,l_xrde_t.xrde120,l_xrde_t.xrde121,
                            l_xrde_t.xrde129 ,l_xrde_t.xrde130  ,l_xrde_t.xrde131,l_xrde_t.xrde139
                            )
         
         
         IF SQLCA.sqlcode THEN
            LET g_success = 'N' RETURN
         END IF
         
         LET l_xrde_t.xrdeseq = l_xrde_t.xrdeseq + 1
         
      END IF

   END FOREACH
END FUNCTION

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
PRIVATE FUNCTION axrt400_09_ref_amt()
   DEFINE l_amt1,l_amt2      LIKE xrde_t.xrde109     #收款金額
   DEFINE l_amt3,l_amt4      LIKE xrde_t.xrde109     #帳款金額
   DEFINE l_amt5,l_amt6      LIKE xrde_t.xrde109     #匯差及調整金額
   DEFINE l_amt7,l_amt8      LIKE xrde_t.xrde109     #差異金額
   DEFINE l_amt1_1,l_amt2_1  LIKE xrde_t.xrde109     #收款金額         本位幣二/三
   DEFINE l_amt3_1,l_amt4_1  LIKE xrde_t.xrde109     #帳款金額         本位幣二/三
   DEFINE l_amt5_1,l_amt6_1  LIKE xrde_t.xrde109     #匯差及調整金額    本位幣二/三
   DEFINE l_amt7_1,l_amt8_1  LIKE xrde_t.xrde109     #差異金額         本位幣二/三
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_slip             LIKE xrde_t.xrde014
   DEFINE l_ooac004          LIKE ooac_t.ooac004
   DEFINE l_pmab105          LIKE pmab_t.pmab105
   DEFINE l_n                LIKE type_t.num5        #151117-00001#8 add lujh
   DEFINE l_sql              STRING                  #161031-00043#1 Add
   #170119-00015#1 add--s
   DEFINE l_xrde121          LIKE xrde_t.xrde121
   DEFINE l_xrde131          LIKE xrde_t.xrde131
   DEFINE ls_js              STRING
   DEFINE lc_param               RECORD
            type                 LIKE type_t.chr1,
            apca004              LIKE apca_t.apca004
                             END RECORD
   #170119-00015#1 add--e
   
   #計算收款
   SELECT SUM(xrde109),SUM(xrde119) INTO l_amt1,l_amt2 FROM xrde_t,gzcb_t
    WHERE xrdeent = g_enterprise
      AND xrdeld  = g_ld
      AND xrdedocno = g_docno
      AND xrde002 = gzcb002
      AND gzcb001 = '8306'
      AND gzcb004 = '1'
      AND xrde002 = '10'
   IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
   IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
   
   #計算帳款
   SELECT SUM(xrce109 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END),SUM(xrce119 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END)
     INTO l_amt3,l_amt4
     FROM xrce_t,gzcb_t
    WHERE xrceent = g_enterprise
      AND xrceld  = g_ld
      AND xrcedocno = g_docno
      AND gzcb001 = '8306'
      AND gzcb004 = '2'
      AND gzcb002 = xrce002
   IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
   IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
   
   #計算匯差及調整帳款
   SELECT SUM(xrde109 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END),SUM(xrde119 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END)
     INTO l_amt5,l_amt6
     FROM xrde_t,gzcb_t
    WHERE xrdeent = g_enterprise
      AND xrdeld  = g_ld
      AND xrdedocno = g_docno
      AND xrde002 = gzcb002
      AND gzcb001 = '8306'
      AND xrde002 <> 10
      AND gzcb004 = '1'
   IF cl_null(l_amt5) THEN LET l_amt5 = 0 END IF
   IF cl_null(l_amt6) THEN LET l_amt6 = 0 END IF
   
   LET l_amt7 = 0
   LET l_amt8 = l_amt2 + l_amt4 + l_amt6
   
   #計算收款---本位幣二/三
   SELECT SUM(xrde129),SUM(xrde139) INTO l_amt1_1,l_amt2_1 FROM xrde_t,gzcb_t
    WHERE xrdeent = g_enterprise
      AND xrdeld  = g_ld
      AND xrdedocno = g_docno
      AND xrde002 = gzcb002
      AND gzcb001 = '8306'
      AND gzcb004 = '1'
      AND xrde002 = '10'
   IF cl_null(l_amt1_1) THEN LET l_amt1_1 = 0 END IF
   IF cl_null(l_amt2_1) THEN LET l_amt2_1 = 0 END IF
   
   #計算帳款---本位幣二/三
   SELECT SUM(xrce129 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END),SUM(xrce139 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END)
     INTO l_amt3_1,l_amt4_1
     FROM xrce_t,gzcb_t
    WHERE xrceent = g_enterprise
      AND xrceld  = g_ld
      AND xrcedocno = g_docno
      AND gzcb001 = '8306'
      AND gzcb004 = '2'
      AND gzcb002 = xrce002
   IF cl_null(l_amt3_1) THEN LET l_amt3_1 = 0 END IF
   IF cl_null(l_amt4_1) THEN LET l_amt4_1 = 0 END IF
   
   #計算匯差及調整帳款---本位幣二/三
   SELECT SUM(xrde129 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END),SUM(xrde139 * CASE WHEN gzcb003 = 'D' THEN 1 ELSE -1 END)
     INTO l_amt5_1,l_amt6_1
     FROM xrde_t,gzcb_t
    WHERE xrdeent = g_enterprise
      AND xrdeld  = g_ld
      AND xrdedocno = g_docno
      AND xrde002 = gzcb002
      AND gzcb001 = '8306'
      AND gzcb004 = '1'
      AND xrde002 <> 10
   IF cl_null(l_amt5_1) THEN LET l_amt5_1 = 0 END IF
   IF cl_null(l_amt6_1) THEN LET l_amt6_1 = 0 END IF
   
   LET l_amt7_1 = l_amt1_1 + l_amt3_1 + l_amt5_1
   LET l_amt8_1 = l_amt2_1 + l_amt4_1 + l_amt6_1
   
   LET g_amt1 = l_amt8
   LET g_amt2 = l_amt7_1
   LET g_amt3 = l_amt8_1
   
   INITIALIZE g_xrde_t.* To Null
   
   #抓取单据别
   CALL s_aooi200_fin_get_slip(g_docno)
      RETURNING l_success,l_slip
   
   SELECT MAX(xrdeseq) + 1 INTO g_xrde_t.xrdeseq
     FROM xrde_t
    WHERE xrdeent = g_enterprise AND xrdeld = g_ld
      AND xrdedocno = g_docno
      
   IF cl_null(g_xrde_t.xrdeseq) THEN 
      LET g_xrde_t.xrdeseq = 1
   END IF
   
   IF g_xrde_t.xrdeseq > 1 THEN 
      SELECT xrde010 INTO g_xrde_t.xrde010
        FROM xrde_t
       WHERE xrdeent = g_enterprise
         AND xrdeld = g_ld
         AND xrdedocno = g_docno
         AND xrdeseq = g_xrde_t.xrdeseq - 1 
   END IF
      
   LET g_xrde_t.xrdeent  = g_enterprise
   LET g_xrde_t.xrdesite = g_xrdasite
   LET g_xrde_t.xrdecomp = g_comp
   LET g_xrde_t.xrdeld   = g_ld
   LET g_xrde_t.xrdedocno= g_docno
   LET g_xrde_t.xrde006  = ''
   LET g_xrde_t.xrde001  = 'axrt400'
   LET g_xrde_t.xrde003  = ''
   LET g_xrde_t.xrde004  = ''
   LET g_xrde_t.xrde008  = ''
   LET g_xrde_t.xrde101  = 1       #161202-00030#1 add lujh
   LET g_xrde_t.xrde109  = g_amt1
   LET g_xrde_t.xrde120  = g_glaa_t.glaa016
   LET g_xrde_t.xrde130  = g_glaa_t.glaa020
   LET g_xrde_t.xrde119  = g_amt1
   LET g_xrde_t.xrde129  = g_amt2
   LET g_xrde_t.xrde121  = g_xrde_t.xrde129 / g_xrde_t.xrde119
   LET g_xrde_t.xrde139  = g_amt3
   LET g_xrde_t.xrde131  = g_xrde_t.xrde139 / g_xrde_t.xrde119
   
   #161031-00043#1 Mark ---(S)---
  ##151117-00001#8--add--str--lujh
  ##计算账款单身一共有几个币别
  #LET l_n = 0    #161028-00003#1 Add
  #SELECT COUNT(DISTINCT xrce100) INTO l_n
  #  FROM xrce_t
  # WHERE xrceent = g_enterprise
  #   AND xrcedocno = g_docno
  #   AND xrceld = g_ld
  #   
  #IF g_xrda_m.lbl_ra1 = '20' OR g_xrda_m.lbl_ra1 = '21' OR g_xrda_m.lbl_ra2 = '22' THEN 
  #   #多幣別則產生之待抵單(20.21.22) 幣別為本幣,若單一幣別, 則依帳款單之幣別產生
  #   IF l_n = 1 THEN  #161028-00003#1 Mod <= --> =
  #      SELECT DISTINCT xrce100 INTO g_xrde_t.xrde100
  #        FROM xrce_t
  #       WHERE xrceent = g_enterprise
  #         AND xrcedocno = g_docno
  #         AND xrceld = g_ld
  #   ELSE
  #      LET g_xrde_t.xrde100  = g_glaa_t.glaa001
  #   END IF
  #ELSE
  #   LET g_xrde_t.xrde100  = g_glaa_t.glaa001
  #END IF
  ##151117-00001#8--add--str--lujh
  ##LET g_xrde_t.xrde100  = g_glaa_t.glaa001   #151117-00001#8 mark lujh
   #161031-00043#1 Mark ---(E)---
   #161031-00043#1 Add  ---(S)---
   LET l_n = 0
   #计算2个单身一共有几个币别
   LET l_sql = "SELECT COUNT(DISTINCT xrde100) ",
               "  FROM ", 
               " ( ",
               " SELECT DISTINCT xrde100 xrde100 ",
               "   FROM xrde_t ",
               "  WHERE xrdeent = ",g_enterprise,
               "    AND xrdedocno = '",g_docno,"'",
               "    AND xrdeld = '",g_ld,"'",
               " UNION ",
               " SELECT DISTINCT xrce100 xrce100 ",
               "   FROM xrce_t ",
               "  WHERE xrceent = ",g_enterprise,
               "    AND xrcedocno = '",g_docno,"'",
               "    AND xrceld = '",g_ld,"'",
               " ) "
   PREPARE axrt400_09_xrde100_cnt_pre FROM l_sql
   EXECUTE axrt400_09_xrde100_cnt_pre INTO l_n
   IF cl_null(l_n) THEN LET l_n = 0 END IF
   IF g_xrda_m.lbl_ra1 = '20' OR g_xrda_m.lbl_ra1 = '21' OR g_xrda_m.lbl_ra2 = '22' THEN 
      IF l_n > 1 THEN
         LET g_xrde_t.xrde100  = g_glaa_t.glaa001
      ELSE
         LET g_xrde_t.xrde100 = ''
         SELECT DISTINCT xrce100 INTO g_xrde_t.xrde100
           FROM xrce_t
          WHERE xrceent = g_enterprise
            AND xrcedocno = g_docno
            AND xrceld = g_ld
         IF cl_null(g_xrde_t.xrde100) THEN
            SELECT DISTINCT xrde100 INTO g_xrde_t.xrde100
              FROM xrde_t
             WHERE xrdeent = g_enterprise
               AND xrdedocno = g_docno
               AND xrdeld = g_ld
         END IF
         
         #161202-00030#1--add--str--lujh
         #重新计算汇率
         #170119-00015#1 mod--s
         #                    #匯率參照表;帳套; 日期;       來源幣別
         #CALL s_aooi160_get_exrate('2',g_ld,g_docdt,g_xrde_t.xrde100,
         #                          #目的幣別;   交易金額;  匯類類型
         #                          g_glaa_t.glaa001,0,g_glaa_t.glaa025)
         #     RETURNING g_xrde_t.xrde101
         INITIALIZE lc_param.* TO NULL
         LET lc_param.type    = '1'
         LET lc_param.apca004 = g_xrda.xrda005
         LET ls_js = util.JSON.stringify(lc_param)
         CALL s_fin_get_curr_rate(g_xrda.xrdacomp,g_xrda.xrdald,g_xrda.xrdadocdt,g_xrde_t.xrde100,ls_js)
              RETURNING g_xrde_t.xrde101,l_xrde121,l_xrde131
         #170119-00015#1 mod--e
              
         LET g_xrde_t.xrde109 = g_xrde_t.xrde119 / g_xrde_t.xrde101
         #161202-00030#1--add--end--lujh
      END IF
   ELSE
      LET g_xrde_t.xrde100  = g_glaa_t.glaa001
   END IF
   #161031-00043#1 Add  ---(E)---
   #LET g_xrde_t.xrde101  = 1    #161202-00030#1 mark lujh
   LET g_xrde_t.xrde020  = ''
   LET g_xrde_t.xrde022  = ''
   LET g_xrde_t.xrde023  = ''
   
   LET g_xrde_t.xrde017 = g_xrda003
   SELECT ooag003,ooag004 INTO g_xrde_t.xrde018,g_xrde_t.xrde019 FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_xrda003

   #SELECT ooag004 INTO g_xrde_t.xrdeorga FROM ooag_t
   # WHERE ooagent = g_enterprise
   #   AND ooag001 = g_xrda003
      
   SELECT glaacomp INTO g_xrde_t.xrdeorga 
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_ld

   IF NOT cl_null(g_xrda_m.lbl_ra1) AND g_xrda_m.lbl_ra1 != 21 THEN
      
      SELECT nmad003 INTO g_xrde_t.xrde012 FROM nmad_t
       WHERE nmadent = g_enterprise
         AND nmad001 = g_glaa_t.glaa005
         AND nmad002 = g_xrde_t.xrde011
      
   END IF
   
   SELECT pmab105 INTO l_pmab105 
     FROM pmab_t 
    WHERE pmabent = g_enterprise 
      AND pmabsite = g_comp 
      AND pmab001 = g_xrda004
   
   #收款＞帳款
   IF NOT cl_null(g_xrda_m.lbl_ra1) THEN
      CASE
         WHEN g_xrda_m.lbl_ra1 = '12'
            #SELECT glab005,glab010 INTO g_xrde_t.xrde016,g_xrde_t.xrde011 FROM glab_t
            # WHERE glabent = g_enterprise
            #   AND glabld = g_ld
            #   AND glab001 = '12'
            #   AND glab002 = '9711'
            #   AND glab003 = '9711_12'
            
            CALL s_subject_get('12',g_ld,g_comp,g_xrda004) RETURNING l_success,g_xrde_t.xrde016,g_xrde_t.xrde011       
               
            LET g_xrde_t.xrde013 = ''
            LET g_xrde_t.xrde002 = '12'
            
            SELECT gzcb003 INTO g_xrde_t.xrde015 FROM gzcb_t
             WHERE gzcb002 = g_xrde_t.xrde002
               AND gzcb001 = '8306'
            
            SELECT nmad003 INTO g_xrde_t.xrde012 FROM nmad_t
             WHERE nmadent = g_enterprise
               AND nmad001 = g_glaa_t.glaa005
               AND nmad002 = g_xrde_t.xrde011
         
         WHEN g_xrda_m.lbl_ra1 = '20'        
            #SELECT glab005,glab010 INTO g_xrde_t.xrde016,g_xrde_t.xrde011 FROM glab_t
            # WHERE glabent = g_enterprise
            #   AND glabld = g_ld
            #   AND glab001 = '12'
            #   AND glab002 = l_pmab105
            #   AND glab003 = '8304_24'
               
            CALL s_subject_get('20',g_ld,g_comp,g_xrda004) RETURNING l_success,g_xrde_t.xrde016,g_xrde_t.xrde011   
               
            LET g_xrde_t.xrde013 = g_xrda004
            LET g_xrde_t.xrde002 = '20'
            
            SELECT gzcb003 INTO g_xrde_t.xrde015 FROM gzcb_t
             WHERE gzcb002 = g_xrde_t.xrde002
               AND gzcb001 = '8306'
            
            SELECT nmad003 INTO g_xrde_t.xrde012 FROM nmad_t
             WHERE nmadent = g_enterprise
               AND nmad001 = g_glaa_t.glaa005
               AND nmad002 = g_xrde_t.xrde011
               
            CALL s_fin_get_doc_para(g_ld,g_xrde_t.xrdecomp,l_slip,'D-FIN-2005') RETURNING g_xrde_t.xrde014
            IF g_xrde_t.xrde014 <> '.' AND NOT cl_null(g_xrde_t.xrde014) THEN   #161028-00003#1 Add
            
               CALL s_fin_get_doc_para(g_ld,g_xrde_t.xrdecomp,g_xrde_t.xrde014,'D-FIN-0030') RETURNING l_ooac004
            
               IF l_ooac004 = 'Y' THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_xrde_t.xrde014
                  LET g_errparam.code   = 'axr-00232'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()

                  LET g_xrde_t.xrde014 = ''
               END IF
            #161028-00003#1 Add  ---(S)---
            ELSE
               LET g_xrde_t.xrde014 = ''
            END IF
            #161028-00003#1 Add  ---(E)---
         
         WHEN g_xrda_m.lbl_ra1 = '21'
            #SELECT glab005 INTO g_xrde_t.xrde016 FROM glab_t
            # WHERE glabent = g_enterprise
            #   AND glabld = g_ld
            #   AND glab001 = '13'
            #   AND glab002 = l_pmab105
            #   AND glab003 = '8304_25'
               
            CALL s_subject_get('21',g_ld,g_comp,g_xrda004) RETURNING l_success,g_xrde_t.xrde016,g_xrde_t.xrde011               
            
            LET g_xrde_t.xrde013 = g_xrda004
            LET g_xrde_t.xrde002 = '21'
            
            SELECT gzcb003 INTO g_xrde_t.xrde015 FROM gzcb_t
             WHERE gzcb002 = g_xrde_t.xrde002
               AND gzcb001 = '8306'
               
            SELECT nmad003 INTO g_xrde_t.xrde012 FROM nmad_t
             WHERE nmadent = g_enterprise
               AND nmad001 = g_glaa_t.glaa005
               AND nmad002 = g_xrde_t.xrde011
      END CASE
   END IF
   
   #收款＜帳款
   IF NOT cl_null(g_xrda_m.lbl_ra2) THEN
      CASE
         WHEN g_xrda_m.lbl_ra2 = '11'
            #SELECT glab005,glab010 INTO g_xrde_t.xrde016,g_xrde_t.xrde011 FROM glab_t
            # WHERE glabent = g_enterprise
            #   AND glabld = g_ld
            #   AND glab001 = '12'
            #   AND glab002 = '9711'
            #   AND glab003 = '9711_11'
              
            CALL s_subject_get('11',g_ld,g_comp,g_xrda004) RETURNING l_success,g_xrde_t.xrde016,g_xrde_t.xrde011                
              
            LET g_xrde_t.xrde013 = ''
            LET g_xrde_t.xrde002 = '11'
            
            SELECT gzcb003 INTO g_xrde_t.xrde015 FROM gzcb_t
             WHERE gzcb002 = g_xrde_t.xrde002
               AND gzcb001 = '8306'
            
            SELECT nmad003 INTO g_xrde_t.xrde012 FROM nmad_t
             WHERE nmadent = g_enterprise
               AND nmad001 = g_glaa_t.glaa005
               AND nmad002 = g_xrde_t.xrde011
            
         WHEN g_xrda_m.lbl_ra2 = '15'
            #SELECT glab005,glab010 INTO g_xrde_t.xrde016,g_xrde_t.xrde011 FROM glab_t
            # WHERE glabent = g_enterprise
            #   AND glabld = g_ld
            #   AND glab001 = '13'
            #   AND glab002 = l_pmab105
            #   AND glab003 = '8304_05'
               
            CALL s_subject_get('15',g_ld,g_comp,g_xrda004) RETURNING l_success,g_xrde_t.xrde016,g_xrde_t.xrde011     
               
            LET g_xrde_t.xrde013 = ''
            LET g_xrde_t.xrde002 = '15'
            
            SELECT gzcb003 INTO g_xrde_t.xrde015 FROM gzcb_t
             WHERE gzcb002 = g_xrde_t.xrde002
               AND gzcb001 = '8306'
            
            SELECT nmad003 INTO g_xrde_t.xrde012 FROM nmad_t
             WHERE nmadent = g_enterprise
               AND nmad001 = g_glaa_t.glaa005
               AND nmad002 = g_xrde_t.xrde011
            
         WHEN g_xrda_m.lbl_ra2 = '14'
            #SELECT glab005,glab010 INTO g_xrde_t.xrde016,g_xrde_t.xrde011 FROM glab_t
            # WHERE glabent = g_enterprise
            #   AND glabld = g_ld
            #   AND glab001 = '12'
            #   AND glab002 = '9711'
            #   AND glab003 = '9711_21'
               
            CALL s_subject_get('14',g_ld,g_comp,g_xrda004) RETURNING l_success,g_xrde_t.xrde016,g_xrde_t.xrde011     
               
            LET g_xrde_t.xrde013 = ''
            LET g_xrde_t.xrde002 = '14'
            
            SELECT gzcb003 INTO g_xrde_t.xrde015 FROM gzcb_t
             WHERE gzcb002 = g_xrde_t.xrde002
               AND gzcb001 = '8306'
            
            SELECT nmad003 INTO g_xrde_t.xrde012 FROM nmad_t
             WHERE nmadent = g_enterprise
               AND nmad001 = g_glaa_t.glaa005
               AND nmad002 = g_xrde_t.xrde011
            
         WHEN g_xrda_m.lbl_ra2 = '22'
           #SELECT glab005 INTO g_xrde_t.xrde016 FROM glab_t
           #  WHERE glabent = g_enterprise
           #    AND glabld = g_ld
           #    AND glab001 = '13'
           #    AND glab002 = l_pmab105
           #    AND glab003 = '8304_06'
               
           CALL s_subject_get('22',g_ld,g_comp,g_xrda004) RETURNING l_success,g_xrde_t.xrde016,g_xrde_t.xrde011       
               
           LET g_xrde_t.xrde013 = g_xrda004
           LET g_xrde_t.xrde002 = '22'
           
           SELECT gzcb003 INTO g_xrde_t.xrde015 FROM gzcb_t
             WHERE gzcb002 = g_xrde_t.xrde002
               AND gzcb001 = '8306'
           
           CALL s_fin_get_doc_para(g_ld,g_xrde_t.xrdecomp,l_slip,'D-FIN-2001') RETURNING g_xrde_t.xrde014
           IF g_xrde_t.xrde014 <> '.' AND NOT cl_null(g_xrde_t.xrde014) THEN   #161028-00003#1 Add
            
              CALL s_fin_get_doc_para(g_ld,g_xrde_t.xrdecomp,g_xrde_t.xrde014,'D-FIN-0030') RETURNING l_ooac004
            
              IF l_ooac004 = 'Y' THEN 
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = g_xrde_t.xrde014
                 LET g_errparam.code   = 'axr-00232'
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err()
                 LET g_xrde_t.xrde014 = ''
              END IF
           #161028-00003#1 Add  ---(S)---
           ELSE
              LET g_xrde_t.xrde014 = ''
           END IF
           #161028-00003#1 Add  ---(E)---
      END CASE
   END IF
   
   IF g_xrde_t.xrde109 < 0 THEN 
      LET g_xrde_t.xrde109 = g_xrde_t.xrde109 * -1
   END IF
   
   IF g_xrde_t.xrde119 < 0 THEN 
      LET g_xrde_t.xrde119 = g_xrde_t.xrde119 * -1
   END IF
   
   IF g_xrde_t.xrde129 < 0 THEN 
      LET g_xrde_t.xrde129 = g_xrde_t.xrde129 * -1
   END IF
   
   IF g_xrde_t.xrde139 < 0 THEN 
      LET g_xrde_t.xrde139 = g_xrde_t.xrde139 * -1
   END IF
   
   #INSERT INTO xrde_t VALUES(g_xrde_t.*)
   INSERT INTO xrde_t(xrdeent,xrdecomp,xrdeld,xrdesite,xrdeorga,xrdedocno,xrdeseq,xrde001,
                            xrde002,xrde003,xrde004,xrde006,xrde008,xrde010,xrde011,xrde012,xrde013,
                            xrde014,xrde015,xrde016,xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,
                            xrde100,xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,xrde131,xrde139)
                     VALUES(g_xrde_t.xrdeent ,g_xrde_t.xrdecomp ,g_xrde_t.xrdeld ,g_xrde_t.xrdesite,
                            g_xrde_t.xrdeorga,g_xrde_t.xrdedocno,g_xrde_t.xrdeseq,g_xrde_t.xrde001,
                            g_xrde_t.xrde002 ,g_xrde_t.xrde003  ,g_xrde_t.xrde004,g_xrde_t.xrde006,
                            g_xrde_t.xrde008 ,g_xrde_t.xrde010  ,g_xrde_t.xrde011,g_xrde_t.xrde012,
                            g_xrde_t.xrde013 ,g_xrde_t.xrde014  ,g_xrde_t.xrde015,g_xrde_t.xrde016,
                            g_xrde_t.xrde017 ,g_xrde_t.xrde018  ,g_xrde_t.xrde019,g_xrde_t.xrde020,
                            g_xrde_t.xrde022 ,g_xrde_t.xrde023  ,g_xrde_t.xrde100,g_xrde_t.xrde101,
                            g_xrde_t.xrde109 ,g_xrde_t.xrde119  ,g_xrde_t.xrde120,g_xrde_t.xrde121,
                            g_xrde_t.xrde129 ,g_xrde_t.xrde130  ,g_xrde_t.xrde131,g_xrde_t.xrde139
                            )

END FUNCTION

 
{</section>}
 
