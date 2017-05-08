#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt400_11.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2014-08-18 14:53:12), PR版次:0005(2016-12-05 12:50:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000234
#+ Filename...: axrt400_11
#+ Description: 收款沖銷單身其他資訊維護
#+ Creator....: 01727(2013-11-26 16:33:35)
#+ Modifier...: 01727 -SD/PR- 02481
 
{</section>}
 
{<section id="axrt400_11.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#54 2016/03/29 By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#13 2016/04/15 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息
#161128-00061#5  2016/12/05 by 02481    标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_xrce_m        RECORD
       xrceseq LIKE xrce_t.xrceseq, 
   xrce002 LIKE xrce_t.xrce002, 
   xrce015 LIKE xrce_t.xrce015, 
   xrce003 LIKE xrce_t.xrce003, 
   xrce024 LIKE xrce_t.xrce024, 
   xrce025 LIKE xrce_t.xrce025, 
   xrce009 LIKE xrce_t.xrce009, 
   xrce017 LIKE xrce_t.xrce017, 
   xrce017_desc LIKE type_t.chr80, 
   xrce018 LIKE xrce_t.xrce018, 
   xrce018_desc LIKE type_t.chr80, 
   xrce019 LIKE xrce_t.xrce019, 
   xrce019_desc LIKE type_t.chr80, 
   xrce020 LIKE xrce_t.xrce020, 
   xrce020_desc LIKE type_t.chr80, 
   xrce016 LIKE xrce_t.xrce016, 
   xrce016_desc LIKE type_t.chr80, 
   xrce021 LIKE xrce_t.xrce021, 
   xrce021_desc LIKE type_t.chr80, 
   xrce022 LIKE xrce_t.xrce022, 
   xrce022_desc LIKE type_t.chr80, 
   xrce023 LIKE xrce_t.xrce023, 
   xrce023_desc LIKE type_t.chr80, 
   xrce011 LIKE xrce_t.xrce011, 
   xrce011_desc LIKE type_t.chr80, 
   xrce012 LIKE xrce_t.xrce012, 
   xrce012_desc LIKE type_t.chr80, 
   xrce026 LIKE xrce_t.xrce026
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xrce_m_t        type_g_xrce_m
DEFINE g_glaa004         LIKE glaa_t.glaa004
#end add-point
 
DEFINE g_xrce_m        type_g_xrce_m
 
   DEFINE g_xrceseq_t LIKE xrce_t.xrceseq
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrt400_11.input" >}
#+ 資料輸入
PUBLIC FUNCTION axrt400_11(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xrce_t
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
   #161128-00061#5---modify----begin-------------  
   #DEFINE p_xrce_t        RECORD LIKE xrce_t.*
   DEFINE p_xrce_t RECORD  #應收沖銷明細檔
       xrceent LIKE xrce_t.xrceent, #企業編號
       xrcecomp LIKE xrce_t.xrcecomp, #法人
       xrceld LIKE xrce_t.xrceld, #帳套
       xrcedocno LIKE xrce_t.xrcedocno, #沖銷單單號
       xrceseq LIKE xrce_t.xrceseq, #項次
       xrcelegl LIKE xrce_t.xrcelegl, #no use
       xrcesite LIKE xrce_t.xrcesite, #帳務中心
       xrceorga LIKE xrce_t.xrceorga, #帳務歸屬組織
       xrce001 LIKE xrce_t.xrce001, #來源作業
       xrce002 LIKE xrce_t.xrce002, #沖銷類型
       xrce003 LIKE xrce_t.xrce003, #沖銷帳款單單號
       xrce004 LIKE xrce_t.xrce004, #沖銷帳款單項次
       xrce005 LIKE xrce_t.xrce005, #沖銷帳款單帳期
       xrce006 LIKE xrce_t.xrce006, #no use
       xrce007 LIKE xrce_t.xrce007, #no use
       xrce008 LIKE xrce_t.xrce008, #no use
       xrce009 LIKE xrce_t.xrce009, #no use
       xrce010 LIKE xrce_t.xrce010, #摘要說明
       xrce011 LIKE xrce_t.xrce011, #no use
       xrce012 LIKE xrce_t.xrce012, #no use
       xrce013 LIKE xrce_t.xrce013, #no use
       xrce014 LIKE xrce_t.xrce014, #no use
       xrce015 LIKE xrce_t.xrce015, #沖銷加減項
       xrce016 LIKE xrce_t.xrce016, #沖銷科目
       xrce017 LIKE xrce_t.xrce017, #業務人員
       xrce018 LIKE xrce_t.xrce018, #業務部門
       xrce019 LIKE xrce_t.xrce019, #責任中心
       xrce020 LIKE xrce_t.xrce020, #產品類別
       xrce021 LIKE xrce_t.xrce021, #no use
       xrce022 LIKE xrce_t.xrce022, #專案編號
       xrce023 LIKE xrce_t.xrce023, #WBS編號
       xrce024 LIKE xrce_t.xrce024, #第二參考單號
       xrce025 LIKE xrce_t.xrce025, #第二參考單號項次
       xrce026 LIKE xrce_t.xrce026, #no use
       xrce027 LIKE xrce_t.xrce027, #應稅折抵否
       xrce028 LIKE xrce_t.xrce028, #產生方式
       xrce029 LIKE xrce_t.xrce029, #傳票號碼
       xrce030 LIKE xrce_t.xrce030, #傳票項次
       xrce035 LIKE xrce_t.xrce035, #區域
       xrce036 LIKE xrce_t.xrce036, #客戶分類
       xrce037 LIKE xrce_t.xrce037, #no use
       xrce038 LIKE xrce_t.xrce038, #對象
       xrce039 LIKE xrce_t.xrce039, #經營方式
       xrce040 LIKE xrce_t.xrce040, #通路
       xrce041 LIKE xrce_t.xrce041, #品牌
       xrce042 LIKE xrce_t.xrce042, #自由核算項一
       xrce043 LIKE xrce_t.xrce043, #自由核算項二
       xrce044 LIKE xrce_t.xrce044, #自由核算項三
       xrce045 LIKE xrce_t.xrce045, #自由核算項四
       xrce046 LIKE xrce_t.xrce046, #自由核算項五
       xrce047 LIKE xrce_t.xrce047, #自由核算項六
       xrce048 LIKE xrce_t.xrce048, #自由核算項七
       xrce049 LIKE xrce_t.xrce049, #自由核算項八
       xrce050 LIKE xrce_t.xrce050, #自由核算項九
       xrce051 LIKE xrce_t.xrce051, #自由核算項十
       xrce053 LIKE xrce_t.xrce053, #發票編號
       xrce054 LIKE xrce_t.xrce054, #發票號碼
       xrce100 LIKE xrce_t.xrce100, #幣別
       xrce101 LIKE xrce_t.xrce101, #匯率
       xrce104 LIKE xrce_t.xrce104, #原幣應稅折抵稅額
       xrce109 LIKE xrce_t.xrce109, #原幣沖帳金額
       xrce114 LIKE xrce_t.xrce114, #本幣應稅折抵稅額
       xrce119 LIKE xrce_t.xrce119, #本幣沖帳金額
       xrce120 LIKE xrce_t.xrce120, #本位幣二幣別
       xrce121 LIKE xrce_t.xrce121, #本位幣二匯率
       xrce124 LIKE xrce_t.xrce124, #本位幣二應稅折抵稅額
       xrce129 LIKE xrce_t.xrce129, #本位幣二沖帳金額
       xrce130 LIKE xrce_t.xrce130, #本位幣二幣別
       xrce131 LIKE xrce_t.xrce131, #本位幣三匯率
       xrce134 LIKE xrce_t.xrce134, #本位幣三應稅折抵稅額
       xrce139 LIKE xrce_t.xrce139, #本位幣三沖帳金額
       xrce055 LIKE xrce_t.xrce055, #費用編號
       xrce056 LIKE xrce_t.xrce056, #方向
       xrce057 LIKE xrce_t.xrce057, #預收待抵單號
       xrce058 LIKE xrce_t.xrce058, #應付單號
       xrce103 LIKE xrce_t.xrce103, #未稅原幣沖銷額
       xrce113 LIKE xrce_t.xrce113, #未稅本幣沖銷額
       xrce123 LIKE xrce_t.xrce123, #本位幣二未稅沖銷額
       xrce133 LIKE xrce_t.xrce133, #本位幣三未稅沖銷額
       xrce059 LIKE xrce_t.xrce059  #預收單號
       END RECORD
   #161128-00061#5---modify----end------------- 
   DEFINE l_sql           STRING
   DEFINE l_str           STRING
   DEFINE l_gzcb002       LIKE gzcb_t.gzcb002
   DEFINE l_ld            LIKE xrce_t.xrceld
   DEFINE l_glaa005       LIKE glaa_t.glaa005
   DEFINE l_nmadstus      LIKE nmad_t.nmadstus
   DEFINE l_xrce011       LIKE xrce_t.xrce011
   DEFINE l_xrce012       LIKE xrce_t.xrce012
   DEFINE l_xrce026       LIKE xrce_t.xrce026
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axrt400_11 WITH FORM cl_ap_formpath("axr","axrt400_11")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CLEAR FORM

   #xrce002下拉菜單取值,SCC_8306
   CALL cl_set_combo_scc('xrce002','8306')
   
   LET g_xrce_m.xrceseq = p_xrce_t.xrceseq 
   LET g_xrce_m.xrce002 = p_xrce_t.xrce002 
   LET g_xrce_m.xrce015 = p_xrce_t.xrce015 
   LET g_xrce_m.xrce003 = p_xrce_t.xrce003 
   LET g_xrce_m.xrce024 = p_xrce_t.xrce024 
   LET g_xrce_m.xrce025 = p_xrce_t.xrce025 
   LET g_xrce_m.xrce009 = p_xrce_t.xrce009 
   LET g_xrce_m.xrce017 = p_xrce_t.xrce017 
   LET g_xrce_m.xrce018 = p_xrce_t.xrce018 
   LET g_xrce_m.xrce019 = p_xrce_t.xrce019 
   LET g_xrce_m.xrce020 = p_xrce_t.xrce020 
   LET g_xrce_m.xrce016 = p_xrce_t.xrce016 
   LET g_xrce_m.xrce021 = p_xrce_t.xrce021 
   LET g_xrce_m.xrce022 = p_xrce_t.xrce022 
   LET g_xrce_m.xrce023 = p_xrce_t.xrce023 
   LET g_xrce_m.xrce011 = p_xrce_t.xrce011 
   LET g_xrce_m.xrce012 = p_xrce_t.xrce012 
   LET g_xrce_m.xrce026 = p_xrce_t.xrce026 
   
   SELECT glaa004,glaa005 INTO g_glaa004,l_glaa005 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = p_xrce_t.xrceld
   
   CALL axrt400_11_ref_show()
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xrce_m.xrceseq,g_xrce_m.xrce002,g_xrce_m.xrce015,g_xrce_m.xrce003,g_xrce_m.xrce024, 
          g_xrce_m.xrce025,g_xrce_m.xrce009,g_xrce_m.xrce017,g_xrce_m.xrce018,g_xrce_m.xrce019,g_xrce_m.xrce020, 
          g_xrce_m.xrce016,g_xrce_m.xrce021,g_xrce_m.xrce022,g_xrce_m.xrce023,g_xrce_m.xrce011,g_xrce_m.xrce012, 
          g_xrce_m.xrce026 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            DISPLAY BY NAME g_xrce_m.*
            LET g_xrce_m_t.* = g_xrce_m.*
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrceseq
            #add-point:BEFORE FIELD xrceseq name="input.b.xrceseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrceseq
            
            #add-point:AFTER FIELD xrceseq name="input.a.xrceseq"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrceseq
            #add-point:ON CHANGE xrceseq name="input.g.xrceseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce002
            #add-point:BEFORE FIELD xrce002 name="input.b.xrce002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce002
            
            #add-point:AFTER FIELD xrce002 name="input.a.xrce002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce002
            #add-point:ON CHANGE xrce002 name="input.g.xrce002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce015
            #add-point:BEFORE FIELD xrce015 name="input.b.xrce015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce015
            
            #add-point:AFTER FIELD xrce015 name="input.a.xrce015"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce015
            #add-point:ON CHANGE xrce015 name="input.g.xrce015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce003
            #add-point:BEFORE FIELD xrce003 name="input.b.xrce003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce003
            
            #add-point:AFTER FIELD xrce003 name="input.a.xrce003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce003
            #add-point:ON CHANGE xrce003 name="input.g.xrce003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce024
            #add-point:BEFORE FIELD xrce024 name="input.b.xrce024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce024
            
            #add-point:AFTER FIELD xrce024 name="input.a.xrce024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce024
            #add-point:ON CHANGE xrce024 name="input.g.xrce024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce025
            #add-point:BEFORE FIELD xrce025 name="input.b.xrce025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce025
            
            #add-point:AFTER FIELD xrce025 name="input.a.xrce025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce025
            #add-point:ON CHANGE xrce025 name="input.g.xrce025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce009
            #add-point:BEFORE FIELD xrce009 name="input.b.xrce009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce009
            
            #add-point:AFTER FIELD xrce009 name="input.a.xrce009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce009
            #add-point:ON CHANGE xrce009 name="input.g.xrce009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce017
            
            #add-point:AFTER FIELD xrce017 name="input.a.xrce017"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce017
            #add-point:BEFORE FIELD xrce017 name="input.b.xrce017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce017
            #add-point:ON CHANGE xrce017 name="input.g.xrce017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce018
            
            #add-point:AFTER FIELD xrce018 name="input.a.xrce018"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrce_m.xrce018
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrce_m.xrce018_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrce_m.xrce018_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce018
            #add-point:BEFORE FIELD xrce018 name="input.b.xrce018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce018
            #add-point:ON CHANGE xrce018 name="input.g.xrce018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce019
            
            #add-point:AFTER FIELD xrce019 name="input.a.xrce019"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrce_m.xrce019
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrce_m.xrce019_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrce_m.xrce019_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce019
            #add-point:BEFORE FIELD xrce019 name="input.b.xrce019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce019
            #add-point:ON CHANGE xrce019 name="input.g.xrce019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce020
            
            #add-point:AFTER FIELD xrce020 name="input.a.xrce020"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrce_m.xrce020
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrce_m.xrce020_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrce_m.xrce020_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce020
            #add-point:BEFORE FIELD xrce020 name="input.b.xrce020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce020
            #add-point:ON CHANGE xrce020 name="input.g.xrce020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce016
            
            #add-point:AFTER FIELD xrce016 name="input.a.xrce016"
            IF NOT cl_null(g_xrce_m.xrce016) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa004
               LET g_chkparam.arg2 = g_xrce_m.xrce016
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glac002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xrce_m.xrce016 = g_xrce_m_t.xrce016
                  CALL axrt400_11_ref_show()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL axrt400_11_ref_show()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce016
            #add-point:BEFORE FIELD xrce016 name="input.b.xrce016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce016
            #add-point:ON CHANGE xrce016 name="input.g.xrce016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce021
            
            #add-point:AFTER FIELD xrce021 name="input.a.xrce021"
            IF NOT cl_null(g_xrce_m.xrce021) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa004
               LET g_chkparam.arg2 = g_xrce_m.xrce021
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"    #160318-00025#13   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glac002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xrce_m.xrce021 = g_xrce_m_t.xrce021
                  CALL axrt400_11_ref_show()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL axrt400_11_ref_show()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce021
            #add-point:BEFORE FIELD xrce021 name="input.b.xrce021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce021
            #add-point:ON CHANGE xrce021 name="input.g.xrce021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce022
            
            #add-point:AFTER FIELD xrce022 name="input.a.xrce022"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce022
            #add-point:BEFORE FIELD xrce022 name="input.b.xrce022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce022
            #add-point:ON CHANGE xrce022 name="input.g.xrce022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce023
            
            #add-point:AFTER FIELD xrce023 name="input.a.xrce023"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce023
            #add-point:BEFORE FIELD xrce023 name="input.b.xrce023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce023
            #add-point:ON CHANGE xrce023 name="input.g.xrce023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce011
            
            #add-point:AFTER FIELD xrce011 name="input.a.xrce011"
            IF NOT cl_null(g_xrce_m.xrce011) THEN
               #檢查資料存在性、有效性
               SELECT nmadstus INTO l_nmadstus FROM nmad_t
                WHERE nmadent = g_enterprise
                  AND nmad001 = l_glaa005
                  AND nmad002 = g_xrce_m.xrce011
               LET g_errno = ' '
               CASE
                  WHEN SQLCA.SQLCODE = 100
                     LET g_errno = 'agl-00148'
                  WHEN l_nmadstus = 'N'
#                     LET g_errno = 'agl-00149'    #160318-00005#54  mark
                     LET g_errno = 'sub-01302'     #160318-00005#54  add
               END CASE
               IF NOT cl_null(g_errno) THEN
                  LET l_xrce011 = g_xrce_m.xrce011
                  LET g_xrce_m.xrce011 = g_xrce_m_t.xrce011
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_xrce_m.xrce011
                  CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_xrce_m.xrce011_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_xrce_m.xrce011,g_xrce_m.xrce011_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = l_xrce011
                  #160318-00005#52 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'anmi172'
                        LET g_errparam.replace[2] = cl_get_progname('anmi172',g_lang,"2")
                        LET g_errparam.exeprog = 'anmi172'
                  END CASE
                  #160318-00005#52 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD xrce011
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrce_m.xrce011
            CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrce_m.xrce011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrce_m.xrce011_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce011
            #add-point:BEFORE FIELD xrce011 name="input.b.xrce011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce011
            #add-point:ON CHANGE xrce011 name="input.g.xrce011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce012
            
            #add-point:AFTER FIELD xrce012 name="input.a.xrce012"
            CALL axrt400_11_chk_nmak(g_xrce_m.xrce012)
            IF NOT cl_null(g_errno) THEN
               LET l_xrce012 = g_xrce_m.xrce012
               LET g_xrce_m.xrce012 = g_xrce_m_t.xrce012
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_xrce_m.xrce012
               CALL ap_ref_array2(g_ref_fields,"SELECT nmakl003 FROM nmakl_t WHERE nmaklent='"||g_enterprise||"' AND nmakl001=? AND nmakl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_xrce_m.xrce012_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_xrce_m.xrce012,g_xrce_m.xrce012_desc
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = l_xrce012
               #160318-00005#54 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'anmi180'
                        LET g_errparam.replace[2] = cl_get_progname('anmi180',g_lang,"2")
                        LET g_errparam.exeprog = 'anmi180'
                  END CASE
               #160318-00005#54 --e add
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD xrce012
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrce_m.xrce012
            CALL ap_ref_array2(g_ref_fields,"SELECT nmakl003 FROM nmakl_t WHERE nmaklent='"||g_enterprise||"' AND nmakl001=? AND nmakl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrce_m.xrce012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrce_m.xrce012_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce012
            #add-point:BEFORE FIELD xrce012 name="input.b.xrce012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce012
            #add-point:ON CHANGE xrce012 name="input.g.xrce012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrce026
            #add-point:BEFORE FIELD xrce026 name="input.b.xrce026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrce026
            
            #add-point:AFTER FIELD xrce026 name="input.a.xrce026"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrce026
            #add-point:ON CHANGE xrce026 name="input.g.xrce026"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xrceseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrceseq
            #add-point:ON ACTION controlp INFIELD xrceseq name="input.c.xrceseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrce002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce002
            #add-point:ON ACTION controlp INFIELD xrce002 name="input.c.xrce002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrce015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce015
            #add-point:ON ACTION controlp INFIELD xrce015 name="input.c.xrce015"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrce003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce003
            #add-point:ON ACTION controlp INFIELD xrce003 name="input.c.xrce003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrce024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce024
            #add-point:ON ACTION controlp INFIELD xrce024 name="input.c.xrce024"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrce025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce025
            #add-point:ON ACTION controlp INFIELD xrce025 name="input.c.xrce025"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrce009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce009
            #add-point:ON ACTION controlp INFIELD xrce009 name="input.c.xrce009"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrce017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce017
            #add-point:ON ACTION controlp INFIELD xrce017 name="input.c.xrce017"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrce018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce018
            #add-point:ON ACTION controlp INFIELD xrce018 name="input.c.xrce018"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrce019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce019
            #add-point:ON ACTION controlp INFIELD xrce019 name="input.c.xrce019"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrce020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce020
            #add-point:ON ACTION controlp INFIELD xrce020 name="input.c.xrce020"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrce016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce016
            #add-point:ON ACTION controlp INFIELD xrce016 name="input.c.xrce016"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrce_m.xrce016             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glaa004,"'"
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_xrce_m.xrce016 = g_qryparam.return1              
            CALL axrt400_11_ref_show()
            DISPLAY g_xrce_m.xrce016 TO xrce016              #

            NEXT FIELD xrce016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrce021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce021
            #add-point:ON ACTION controlp INFIELD xrce021 name="input.c.xrce021"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrce_m.xrce021             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glaa004,"'"
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_xrce_m.xrce021 = g_qryparam.return1              
            CALL axrt400_11_ref_show()
            DISPLAY g_xrce_m.xrce021 TO xrce021              #

            NEXT FIELD xrce021                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrce022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce022
            #add-point:ON ACTION controlp INFIELD xrce022 name="input.c.xrce022"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrce023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce023
            #add-point:ON ACTION controlp INFIELD xrce023 name="input.c.xrce023"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrce011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce011
            #add-point:ON ACTION controlp INFIELD xrce011 name="input.c.xrce011"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrce_m.xrce011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_glaa005

            CALL q_nmad002()                                #呼叫開窗

            LET g_xrce_m.xrce011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xrce_m.xrce011 TO xrce011              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrce_m.xrce011
            CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrce_m.xrce011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrce_m.xrce011_desc

            NEXT FIELD xrce011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrce012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce012
            #add-point:ON ACTION controlp INFIELD xrce012 name="input.c.xrce012"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrce_m.xrce012             #給予default值

            #給予arg

            CALL q_nmak001()                                #呼叫開窗

            LET g_xrce_m.xrce012 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xrce_m.xrce012 TO xrce012              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xrce_m.xrce012
            CALL ap_ref_array2(g_ref_fields,"SELECT nmakl003 FROM nmakl_t WHERE nmaklent='"||g_enterprise||"' AND nmakl001=? AND nmakl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xrce_m.xrce012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xrce_m.xrce012_desc
            NEXT FIELD xrce012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrce026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrce026
            #add-point:ON ACTION controlp INFIELD xrce026 name="input.c.xrce026"
 
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
   CLOSE WINDOW w_axrt400_11 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN g_xrce_m_t.xrce016,g_xrce_m_t.xrce021,g_xrce_m_t.xrce011,g_xrce_m_t.xrce012,g_xrce_m_t.xrce026
   ELSE
      RETURN g_xrce_m.xrce016,g_xrce_m.xrce021,g_xrce_m.xrce011,g_xrce_m.xrce012,g_xrce_m.xrce026
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrt400_11.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axrt400_11.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 檢查現金異動碼分類編碼存在性、有效性
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
PRIVATE FUNCTION axrt400_11_chk_nmak(p_nmak001)
   DEFINE p_nmak001      LIKE nmak_t.nmak001
   DEFINE l_nmakstus     LIKE nmak_t.nmakstus
   
   SELECT nmakstus INTO l_nmakstus FROM nmak_t
    WHERE nmakent = g_enterprise
      AND nmak001 = p_nmak001
   LET g_errno = ' '
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET g_errno = 'anm-00004'   RETURN
      WHEN l_nmakstus = 'N'
#         LET g_errno = 'anm-00024'   RETURN    #160318-00005#54  mark
         LET g_errno = 'sub-01302'   RETURN     #160318-00005#54  add
   END CASE
   
END FUNCTION
################################################################################
# Descriptions...: 刷新說明欄位
# Memo...........:
# Usage..........: CALL axrt400_11_ref_show()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 2013/12/23 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt400_11_ref_show()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrce_m.xrce011
   CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrce_m.xrce011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xrce_m.xrce011_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrce_m.xrce012
   CALL ap_ref_array2(g_ref_fields,"SELECT nmakl003 FROM nmakl_t WHERE nmaklent='"||g_enterprise||"' AND nmakl001=? AND nmakl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrce_m.xrce012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xrce_m.xrce012_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrce_m.xrce017
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_xrce_m.xrce017_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xrce_m.xrce017_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrce_m.xrce018
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrce_m.xrce018_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xrce_m.xrce018_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrce_m.xrce019
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrce_m.xrce019_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xrce_m.xrce019_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrce_m.xrce020
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrce_m.xrce020_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xrce_m.xrce020_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa004
   LET g_ref_fields[2] = g_xrce_m.xrce016
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrce_m.xrce016_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xrce_m.xrce016_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa004
   LET g_ref_fields[2] = g_xrce_m.xrce021
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrce_m.xrce021_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xrce_m.xrce021_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrce_m.xrce011
   CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrce_m.xrce011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xrce_m.xrce011,g_xrce_m.xrce011_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xrce_m.xrce012
   CALL ap_ref_array2(g_ref_fields,"SELECT nmakl003 FROM nmakl_t WHERE nmaklent='"||g_enterprise||"' AND nmakl001=? AND nmakl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xrce_m.xrce012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xrce_m.xrce012,g_xrce_m.xrce012_desc

END FUNCTION

 
{</section>}
 
