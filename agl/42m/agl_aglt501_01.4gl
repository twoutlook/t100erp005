#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt501_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2017-02-13 15:52:01), PR版次:0008(2017-02-13 16:13:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000064
#+ Filename...: aglt501_01
#+ Description: 固定核算項
#+ Creator....: 03080(2015-03-04 15:17:13)
#+ Modifier...: 08729 -SD/PR- 08729
 
{</section>}
 
{<section id="aglt501_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160321-00016#31   2016/03/25  By Jessy         修正azzi920重複定義之錯誤訊息
#160913-00017#3    2016/09/21  By 07900         AGL模组调整交易客商开窗
#161021-00037#4    2016/10/24  By 06821         組織類型與職能開窗調整
#161111-00028#9    2016/11/24  by 02481         标准程式定义采用宣告模式,弃用.*写法
#160824-00007#260  2016/12/20  By 08171         新舊值調整
#170111-00005#1    2017/02/13  By 08729         專案管理,WBS 核算項 此二欄位改為1.有啓用核算項的話，也不限定為必輸 2.有啓用核算項 但欄位空白，則提示訊息把"不允許空白"改為 "空白")

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
PRIVATE type type_g_gldh_m        RECORD
       gldh001 LIKE gldh_t.gldh001, 
   gldh002 LIKE gldh_t.gldh002, 
   gldh003 LIKE gldh_t.gldh003, 
   gldh005 LIKE gldh_t.gldh005, 
   gldh006 LIKE gldh_t.gldh006, 
   gldh007 LIKE gldh_t.gldh007, 
   gldh008 LIKE gldh_t.gldh008, 
   gldh008_desc LIKE type_t.chr80, 
   gldh009 LIKE gldh_t.gldh009, 
   gldh009_desc LIKE type_t.chr80, 
   gldh010 LIKE gldh_t.gldh010, 
   gldh010_desc LIKE type_t.chr80, 
   gldh011 LIKE gldh_t.gldh011, 
   gldh011_desc LIKE type_t.chr80, 
   gldh012 LIKE gldh_t.gldh012, 
   gldh012_desc LIKE type_t.chr80, 
   gldh013 LIKE gldh_t.gldh013, 
   gldh013_desc LIKE type_t.chr80, 
   gldh014 LIKE gldh_t.gldh014, 
   gldh014_desc LIKE type_t.chr80, 
   gldh015 LIKE gldh_t.gldh015, 
   gldh015_desc LIKE type_t.chr80, 
   gldh016 LIKE gldh_t.gldh016, 
   gldh017 LIKE gldh_t.gldh017, 
   gldh017_desc LIKE type_t.chr80, 
   gldh018 LIKE gldh_t.gldh018, 
   gldh018_desc LIKE type_t.chr80, 
   gldh019 LIKE gldh_t.gldh019, 
   gldh019_desc LIKE type_t.chr80, 
   gldh020 LIKE gldh_t.gldh020, 
   gldh020_desc LIKE type_t.chr80, 
   gldh021 LIKE gldh_t.gldh021, 
   gldh021_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_gldh_m_t        type_g_gldh_m   #舊值
DEFINE g_gldh_m_o        type_g_gldh_m   #160824-00007#260 161220 By 08171 add
#161111-00028#9---modify---begin----------  
#DEFINE g_glad            RECORD LIKE glad_t.*
#DEFINE g_glda            RECORD LIKE glda_t.*
DEFINE g_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企業編號
       gladownid LIKE glad_t.gladownid, #資料所有者
       gladowndp LIKE glad_t.gladowndp, #資料所屬部門
       gladcrtid LIKE glad_t.gladcrtid, #資料建立者
       gladcrtdp LIKE glad_t.gladcrtdp, #資料建立部門
       gladcrtdt LIKE glad_t.gladcrtdt, #資料創建日
       gladmodid LIKE glad_t.gladmodid, #資料修改者
       gladmoddt LIKE glad_t.gladmoddt, #最近修改日
       gladstus LIKE glad_t.gladstus, #狀態碼
       gladld LIKE glad_t.gladld, #帳套
       glad001 LIKE glad_t.glad001, #會計科目編號
       glad002 LIKE glad_t.glad002, #是否按餘額類型產生分錄
       glad003 LIKE glad_t.glad003, #啟用傳票項次細項立沖
       glad004 LIKE glad_t.glad004, #傳票項次異動別
       glad005 LIKE glad_t.glad005, #是否啟用數量金額式
       glad006 LIKE glad_t.glad006, #借方現金變動碼
       glad007 LIKE glad_t.glad007, #啟用部門管理
       glad008 LIKE glad_t.glad008, #啟用利潤成本管理
       glad009 LIKE glad_t.glad009, #啟用區域管理
       glad010 LIKE glad_t.glad010, #啟用收付款客商管理
       glad011 LIKE glad_t.glad011, #啟用客群管理
       glad012 LIKE glad_t.glad012, #啟用產品類別管理
       glad013 LIKE glad_t.glad013, #啟用人員管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #啟用專案管理
       glad016 LIKE glad_t.glad016, #啟用WBS管理
       glad017 LIKE glad_t.glad017, #啟用自由核算項一
       glad0171 LIKE glad_t.glad0171, #自由核算項一類型編號
       glad0172 LIKE glad_t.glad0172, #自由核算項一控制方式
       glad018 LIKE glad_t.glad018, #啟用自由核算項二
       glad0181 LIKE glad_t.glad0181, #自由核算項二類型編號
       glad0182 LIKE glad_t.glad0182, #自由核算項二控制方式
       glad019 LIKE glad_t.glad019, #啟用自由核算項三
       glad0191 LIKE glad_t.glad0191, #自由核算項三類型編號
       glad0192 LIKE glad_t.glad0192, #自由核算項三控制方式
       glad020 LIKE glad_t.glad020, #啟用自由核算項四
       glad0201 LIKE glad_t.glad0201, #自由核算項四類型編號
       glad0202 LIKE glad_t.glad0202, #自由核算項四控制方式
       glad021 LIKE glad_t.glad021, #啟用自由核算項五
       glad0211 LIKE glad_t.glad0211, #自由核算項五類型編號
       glad0212 LIKE glad_t.glad0212, #自由核算項五控制方式
       glad022 LIKE glad_t.glad022, #啟用自由核算項六
       glad0221 LIKE glad_t.glad0221, #自由核算項六類型編號
       glad0222 LIKE glad_t.glad0222, #自由核算項六控制方式
       glad023 LIKE glad_t.glad023, #啟用自由核算項七
       glad0231 LIKE glad_t.glad0231, #自由核算項七類型編號
       glad0232 LIKE glad_t.glad0232, #自由核算項七控制方式
       glad024 LIKE glad_t.glad024, #啟用自由核算項八
       glad0241 LIKE glad_t.glad0241, #自由核算項八類型編號
       glad0242 LIKE glad_t.glad0242, #自由核算項八控制方式
       glad025 LIKE glad_t.glad025, #啟用自由核算項九
       glad0251 LIKE glad_t.glad0251, #自由核算項九類型編號
       glad0252 LIKE glad_t.glad0252, #自由核算項九控制方式
       glad026 LIKE glad_t.glad026, #啟用自由核算項十
       glad0261 LIKE glad_t.glad0261, #自由核算項十類型編號
       glad0262 LIKE glad_t.glad0262, #自由核算項十控制方式
       glad027 LIKE glad_t.glad027, #啟用帳款客商管理
       glad030 LIKE glad_t.glad030, #是否進行預算管控
       glad031 LIKE glad_t.glad031, #啟用經營方式管理
       glad032 LIKE glad_t.glad032, #啟用渠道管理
       glad033 LIKE glad_t.glad033, #啟用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多幣別管理
       glad035 LIKE glad_t.glad035, #是否是子系統科目
       glad036 LIKE glad_t.glad036  #貸方現金變動碼
       END RECORD

DEFINE g_glda RECORD  #個體公司基本資料檔
       gldaent LIKE glda_t.gldaent, #企業編號
       gldaownid LIKE glda_t.gldaownid, #資料所有者
       gldaowndp LIKE glda_t.gldaowndp, #資料所屬部門
       gldacrtid LIKE glda_t.gldacrtid, #資料建立者
       gldacrtdp LIKE glda_t.gldacrtdp, #資料建立部門
       gldacrtdt LIKE glda_t.gldacrtdt, #資料創建日
       gldamodid LIKE glda_t.gldamodid, #資料修改者
       gldamoddt LIKE glda_t.gldamoddt, #最近修改日
       gldastus LIKE glda_t.gldastus, #狀態碼
       glda001 LIKE glda_t.glda001, #公司編號
       glda002 LIKE glda_t.glda002, #使用T100
       glda003 LIKE glda_t.glda003, #法人營運據點編號
       glda004 LIKE glda_t.glda004  #關係人編號
       END RECORD
#161111-00028#9---modify---end----------       
#end add-point
 
DEFINE g_gldh_m        type_g_gldh_m
 
   DEFINE g_gldh001_t LIKE gldh_t.gldh001
DEFINE g_gldh002_t LIKE gldh_t.gldh002
DEFINE g_gldh003_t LIKE gldh_t.gldh003
DEFINE g_gldh005_t LIKE gldh_t.gldh005
DEFINE g_gldh006_t LIKE gldh_t.gldh006
DEFINE g_gldh007_t LIKE gldh_t.gldh007
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglt501_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aglt501_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_array
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
   DEFINE p_array  DYNAMIC ARRAY OF RECORD
          chr     LIKE type_t.chr1000,
          dat     LIKE type_t.dat
                  END RECORD
                  
   DEFINE l_strdat LIKE type_t.dat                #期別第一日 用於部門等檢核開窗
   
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aglt501_01 WITH FORM cl_ap_formpath("agl","aglt501_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL aglt501_01_array_to_g_gldh(p_array)
   CALL cl_set_combo_scc('gldh016','6013')
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_gldh_m.gldh001,g_gldh_m.gldh002,g_gldh_m.gldh003,g_gldh_m.gldh005,g_gldh_m.gldh006, 
          g_gldh_m.gldh007,g_gldh_m.gldh008,g_gldh_m.gldh009,g_gldh_m.gldh010,g_gldh_m.gldh011,g_gldh_m.gldh012, 
          g_gldh_m.gldh013,g_gldh_m.gldh014,g_gldh_m.gldh015,g_gldh_m.gldh016,g_gldh_m.gldh017,g_gldh_m.gldh018, 
          g_gldh_m.gldh019,g_gldh_m.gldh020,g_gldh_m.gldh021 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh001
            #add-point:BEFORE FIELD gldh001 name="input.b.gldh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh001
            
            #add-point:AFTER FIELD gldh001 name="input.a.gldh001"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh001
            #add-point:ON CHANGE gldh001 name="input.g.gldh001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh002
            #add-point:BEFORE FIELD gldh002 name="input.b.gldh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh002
            
            #add-point:AFTER FIELD gldh002 name="input.a.gldh002"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh002
            #add-point:ON CHANGE gldh002 name="input.g.gldh002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh003
            #add-point:BEFORE FIELD gldh003 name="input.b.gldh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh003
            
            #add-point:AFTER FIELD gldh003 name="input.a.gldh003"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh003
            #add-point:ON CHANGE gldh003 name="input.g.gldh003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh005
            #add-point:BEFORE FIELD gldh005 name="input.b.gldh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh005
            
            #add-point:AFTER FIELD gldh005 name="input.a.gldh005"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh005
            #add-point:ON CHANGE gldh005 name="input.g.gldh005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh006
            #add-point:BEFORE FIELD gldh006 name="input.b.gldh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh006
            
            #add-point:AFTER FIELD gldh006 name="input.a.gldh006"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh006
            #add-point:ON CHANGE gldh006 name="input.g.gldh006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh007
            #add-point:BEFORE FIELD gldh007 name="input.b.gldh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh007
            
            #add-point:AFTER FIELD gldh007 name="input.a.gldh007"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh007
            #add-point:ON CHANGE gldh007 name="input.g.gldh007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh008
            
            #add-point:AFTER FIELD gldh008 name="input.a.gldh008"
            LET g_gldh_m.gldh008_desc = ' '
            DISPLAY BY NAME g_gldh_m.gldh008_desc
            IF NOT cl_null(g_gldh_m.gldh008) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_m.gldh008 != g_gldh_m_t.gldh008 OR g_gldh_m_t.gldh008 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_gldh_m_o.gldh008) OR g_gldh_m.gldh008 != g_gldh_m_o.gldh008 THEN  #160824-00007#260 161220 By 08171 add
                  LET g_errno = NULL
                  CALL s_voucher_glaq017_chk(g_gldh_m.gldh008)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     #160321-00016#31 --s add
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     #160321-00016#31 --e add
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_gldh_m.gldh008 = g_gldh_m_t.gldh008 #160824-00007#260 161220 By 08171 mark
                     LET g_gldh_m.gldh008 = g_gldh_m_o.gldh008 #160824-00007#260 161220 By 08171 add
                     LET g_gldh_m.gldh008_desc = s_desc_get_department_desc(g_gldh_m.gldh008)
                     DISPLAY BY NAME g_gldh_m.gldh008,g_gldh_m.gldh008_desc
                     NEXT FIELD CURRENT
                  #161021-00037#4 --s add
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL 
                     LET g_chkparam.arg1 = g_gldh_m.gldh008
                     LET g_errshow = TRUE 
                     LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                     IF NOT cl_chk_exist("v_ooef001_13") THEN  
                       #LET g_gldh_m.gldh008 = g_gldh_m_t.gldh008 #160824-00007#260 161220 By 08171 mark
                        LET g_gldh_m.gldh008 = g_gldh_m_o.gldh008 #160824-00007#260 161220 By 08171 add
                        LET g_gldh_m.gldh008_desc = s_desc_get_department_desc(g_gldh_m.gldh008)
                        DISPLAY BY NAME g_gldh_m.gldh008,g_gldh_m.gldh008_desc
                        NEXT FIELD CURRENT
                     END IF
                  #161021-00037#4 --e add
                  END IF
               END IF
            END IF
            LET g_gldh_m.gldh008_desc = s_desc_get_department_desc(g_gldh_m.gldh008)
            DISPLAY BY NAME g_gldh_m.gldh008,g_gldh_m.gldh008_desc            
            LET g_gldh_m_o.* = g_gldh_m.* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh008
            #add-point:BEFORE FIELD gldh008 name="input.b.gldh008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh008
            #add-point:ON CHANGE gldh008 name="input.g.gldh008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh009
            
            #add-point:AFTER FIELD gldh009 name="input.a.gldh009"
            LET g_gldh_m.gldh009_desc = ' '
            DISPLAY BY NAME g_gldh_m.gldh009_desc 
            IF NOT cl_null(g_gldh_m.gldh009) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_m.gldh009 != g_gldh_m_t.gldh009 OR g_gldh_m_t.gldh009 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_gldh_m_o.gldh009) OR g_gldh_m.gldh009 != g_gldh_m_o.gldh009 THEN #160824-00007#260 161220 By 08171 add
                  IF g_glda.glda002 = 'Y' THEN
                     IF NOT s_department_chk(g_gldh_m.gldh009,g_today) THEN
                       #LET g_gldh_m.gldh009 = g_gldh_m_t.gldh009 #160824-00007#260 161220 By 08171 mark
                        LET g_gldh_m.gldh009 = g_gldh_m_o.gldh009 #160824-00007#260 161220 By 08171 add
                        LET g_gldh_m.gldh009_desc = s_desc_get_department_desc(g_gldh_m.gldh009)
                        DISPLAY BY NAME g_gldh_m.gldh009,g_gldh_m.gldh009_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  IF cl_null(g_gldh_m.gldh010) AND g_glad.glad008 = 'Y' THEN
                     SELECT ooeg004 INTO g_gldh_m.gldh010 FROM ooeg_t
                      WHERE ooegent = g_enterprise AND ooeg001 = g_gldh_m.gldh009
                     LET g_gldh_m.gldh010_desc = s_desc_get_department_desc(g_gldh_m.gldh010)
                     DISPLAY BY NAME g_gldh_m.gldh010_desc
                  END IF
               END IF
            END IF
            LET g_gldh_m.gldh009_desc = s_desc_get_department_desc(g_gldh_m.gldh009)
            DISPLAY BY NAME g_gldh_m.gldh009,g_gldh_m.gldh009_desc    
            LET g_gldh_m_o.* = g_gldh_m.* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh009
            #add-point:BEFORE FIELD gldh009 name="input.b.gldh009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh009
            #add-point:ON CHANGE gldh009 name="input.g.gldh009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh010
            
            #add-point:AFTER FIELD gldh010 name="input.a.gldh010"
            LET g_gldh_m.gldh010_desc = ' '
            DISPLAY BY NAME g_gldh_m.gldh010_desc
            IF NOT cl_null(g_gldh_m.gldh010) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_m.gldh010!= g_gldh_m_t.gldh010 OR g_gldh_m_t.gldh010 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_gldh_m_o.gldh010) OR g_gldh_m.gldh010!= g_gldh_m_o.gldh010 THEN #160824-00007#260 161220 By 08171 add
                  IF g_glda.glda002 = 'Y' THEN
                     LET g_errno = NULL
                     CALL s_voucher_glaq019_chk(g_gldh_m.gldh010,g_today)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_gldh_m.gldh010
                        #160321-00016#31 --s add
                        LET g_errparam.replace[1] = 'aooi125'
                        LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                        LET g_errparam.exeprog = 'aooi125'
                        #160321-00016#31 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                       #LET g_gldh_m.gldh010 = g_gldh_m_t.gldh010 #160824-00007#260 161220 By 08171 mark
                        LET g_gldh_m.gldh010 = g_gldh_m_o.gldh010 #160824-00007#260 161220 By 08171 add
                        LET g_gldh_m.gldh010_desc = s_desc_get_department_desc(g_gldh_m.gldh010)
                        DISPLAY BY NAME g_gldh_m.gldh010_desc,g_gldh_m.gldh010
                        NEXT FIELD gldh010
                     END IF
                  END IF
               END IF
            END IF
            LET g_gldh_m.gldh010_desc = s_desc_get_department_desc(g_gldh_m.gldh010)
            DISPLAY BY NAME g_gldh_m.gldh010_desc,g_gldh_m.gldh010
            LET g_gldh_m_o.* = g_gldh_m.* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh010
            #add-point:BEFORE FIELD gldh010 name="input.b.gldh010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh010
            #add-point:ON CHANGE gldh010 name="input.g.gldh010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh011
            
            #add-point:AFTER FIELD gldh011 name="input.a.gldh011"
            LET g_gldh_m.gldh011_desc = ' '
            DISPLAY BY NAME g_gldh_m.gldh011_desc
            IF NOT cl_null(g_gldh_m.gldh011) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_m.gldh011 != g_gldh_m_t.gldh011 OR g_gldh_m_t.gldh011 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_gldh_m_o.gldh011) OR g_gldh_m.gldh011 != g_gldh_m_o.gldh011 THEN #160824-00007#260 161220 By 08171 add
                  IF g_glda.glda002 = 'Y' THEN
                     CALL s_azzi650_chk_exist('287',g_gldh_m.gldh011) RETURNING g_sub_success             
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                       #LET g_gldh_m.gldh011 = g_gldh_m_t.gldh011 #160824-00007#260 161220 By 08171 mark
                        LET g_gldh_m.gldh011 = g_gldh_m_o.gldh011 #160824-00007#260 161220 By 08171 add
                        LET g_gldh_m.gldh011_desc = s_desc_get_acc_desc('287',g_gldh_m.gldh011)
                        DISPLAY BY NAME g_gldh_m.gldh011,g_gldh_m.gldh011_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_gldh_m.gldh011_desc = s_desc_get_acc_desc('287',g_gldh_m.gldh011)
            DISPLAY BY NAME g_gldh_m.gldh011,g_gldh_m.gldh011_desc
            LET g_gldh_m_o.* = g_gldh_m.* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh011
            #add-point:BEFORE FIELD gldh011 name="input.b.gldh011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh011
            #add-point:ON CHANGE gldh011 name="input.g.gldh011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh012
            
            #add-point:AFTER FIELD gldh012 name="input.a.gldh012"
            LET g_gldh_m.gldh012_desc = ' '
            DISPLAY BY NAME g_gldh_m.gldh012_desc
            IF NOT cl_null(g_gldh_m.gldh012) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_m.gldh012 != g_gldh_m_t.gldh012 OR g_gldh_m_t.gldh012 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_gldh_m_o.gldh012) OR g_gldh_m.gldh012 != g_gldh_m_o.gldh012 THEN #160824-00007#260 161220 By 08171 add
                  IF g_glda.glda002 = 'Y' THEN
                     LET g_errno = NULL
                     CALL s_voucher_glaq021_chk(g_gldh_m.gldh012)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#31 --s add
                        LET g_errparam.replace[1] = 'apmm100'
                        LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                        LET g_errparam.exeprog = 'apmm100'
                        #160321-00016#31 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                       #LET g_gldh_m.gldh012 = g_gldh_m_t.gldh012 #160824-00007#260 161220 By 08171 
                        LET g_gldh_m.gldh012 = g_gldh_m_o.gldh012 
                        LET g_gldh_m.gldh012_desc = s_desc_get_trading_partner_abbr_desc(g_gldh_m.gldh012)
                        DISPLAY BY NAME g_gldh_m.gldh012,g_gldh_m.gldh012_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_gldh_m.gldh012_desc = s_desc_get_trading_partner_abbr_desc(g_gldh_m.gldh012)
            DISPLAY BY NAME g_gldh_m.gldh012,g_gldh_m.gldh012_desc
            LET g_gldh_m_o.* = g_gldh_m.* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh012
            #add-point:BEFORE FIELD gldh012 name="input.b.gldh012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh012
            #add-point:ON CHANGE gldh012 name="input.g.gldh012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh013
            
            #add-point:AFTER FIELD gldh013 name="input.a.gldh013"
            LET g_gldh_m.gldh013_desc = ' '
            DISPLAY BY NAME g_gldh_m.gldh013_desc
            IF NOT cl_null(g_gldh_m.gldh013) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_m.gldh013 != g_gldh_m_t.gldh013 OR g_gldh_m_t.gldh013 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_gldh_m_o.gldh013) OR g_gldh_m.gldh013 != g_gldh_m_o.gldh013 THEN #160824-00007#260 161220 By 08171 add
                  IF g_glda.glda002 = 'Y' THEN
                     LET g_errno = NULL
                     CALL s_voucher_glaq021_chk(g_gldh_m.gldh013)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#31 --s add
                        LET g_errparam.replace[1] = 'apmm100'
                        LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                        LET g_errparam.exeprog = 'apmm100'
                        #160321-00016#31 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                       #LET g_gldh_m.gldh013 = g_gldh_m_t.gldh013 #160824-00007#260 161220 By 08171 mark
                        LET g_gldh_m.gldh013 = g_gldh_m_o.gldh013 #160824-00007#260 161220 By 08171 add
                        LET g_gldh_m.gldh013_desc = s_desc_get_trading_partner_abbr_desc(g_gldh_m.gldh013)
                        DISPLAY BY NAME g_gldh_m.gldh013,g_gldh_m.gldh013_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_gldh_m.gldh013_desc = s_desc_get_trading_partner_abbr_desc(g_gldh_m.gldh013)
            DISPLAY BY NAME g_gldh_m.gldh013,g_gldh_m.gldh013_desc
            LET g_gldh_m_o.* = g_gldh_m.* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh013
            #add-point:BEFORE FIELD gldh013 name="input.b.gldh013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh013
            #add-point:ON CHANGE gldh013 name="input.g.gldh013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh014
            
            #add-point:AFTER FIELD gldh014 name="input.a.gldh014"
            LET g_gldh_m.gldh014_desc = ' '
            DISPLAY BY NAME g_gldh_m.gldh014_desc
            IF NOT cl_null(g_gldh_m.gldh014) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_m.gldh014 != g_gldh_m_t.gldh014 OR g_gldh_m.gldh014 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_gldh_m_o.gldh014) OR g_gldh_m.gldh014 != g_gldh_m_o.gldh014 THEN #160824-00007#260 161220 By 08171 add
                  IF g_glda.glda002 = 'Y' THEN
                     CALL s_azzi650_chk_exist('281',g_gldh_m.gldh014) RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                       #LET g_gldh_m.gldh014 = g_gldh_m_t.gldh014 #160824-00007#260 161220 By 08171 mark
                        LET g_gldh_m.gldh014 = g_gldh_m_o.gldh014 #160824-00007#260 161220 By 08171 add
                        LET g_gldh_m.gldh014_desc = s_desc_get_acc_desc('281',g_gldh_m.gldh014)
                        DISPLAY BY NAME g_gldh_m.gldh014,g_gldh_m.gldh014_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_gldh_m.gldh014_desc = s_desc_get_acc_desc('281',g_gldh_m.gldh014)
            DISPLAY BY NAME g_gldh_m.gldh014,g_gldh_m.gldh014_desc
            LET g_gldh_m_o.* = g_gldh_m.* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh014
            #add-point:BEFORE FIELD gldh014 name="input.b.gldh014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh014
            #add-point:ON CHANGE gldh014 name="input.g.gldh014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh015
            
            #add-point:AFTER FIELD gldh015 name="input.a.gldh015"
            LET g_gldh_m.gldh015_desc = ' '
            DISPLAY BY NAME g_gldh_m.gldh015_desc
            IF NOT cl_null(g_gldh_m.gldh015) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_m.gldh015 != g_gldh_m_t.gldh015 OR g_gldh_m_t.gldh015 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_gldh_m_o.gldh015) OR g_gldh_m.gldh015 != g_gldh_m_o.gldh015 THEN #160824-00007#260 161220 By 08171 add
                  IF g_glda.glda002 = 'Y' THEN
                     LET g_errno = NULL
                     CALL s_voucher_glaq024_chk(g_gldh_m.gldh015)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#31 --s add
                        LET g_errparam.replace[1] = 'arti202'
                        LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                        LET g_errparam.exeprog = 'arti202'
                        #160321-00016#31 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                       #LET g_gldh_m.gldh015 = g_gldh_m_t.gldh015 #160824-00007#260 161220 By 08171 mark
                        LET g_gldh_m.gldh015 = g_gldh_m_o.gldh015 #160824-00007#260 161220 By 08171 add
                        LET g_gldh_m.gldh015_desc = s_desc_get_rtaxl003_desc(g_gldh_m.gldh015)
                        DISPLAY BY NAME g_gldh_m.gldh015,g_gldh_m.gldh015_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_gldh_m.gldh015_desc = s_desc_get_rtaxl003_desc(g_gldh_m.gldh015)
            DISPLAY BY NAME g_gldh_m.gldh015,g_gldh_m.gldh015_desc
            LET g_gldh_m_o.* = g_gldh_m.* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh015
            #add-point:BEFORE FIELD gldh015 name="input.b.gldh015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh015
            #add-point:ON CHANGE gldh015 name="input.g.gldh015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh016
            #add-point:BEFORE FIELD gldh016 name="input.b.gldh016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh016
            
            #add-point:AFTER FIELD gldh016 name="input.a.gldh016"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh016
            #add-point:ON CHANGE gldh016 name="input.g.gldh016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh017
            
            #add-point:AFTER FIELD gldh017 name="input.a.gldh017"
            LET g_gldh_m.gldh017_desc = ' '
            DISPLAY BY NAME g_gldh_m.gldh017_desc
            IF NOT cl_null(g_gldh_m.gldh017) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_m.gldh017 != g_gldh_m_t.gldh017 OR g_gldh_m_t.gldh017 IS NULL )) THEN
                  IF g_glda.glda002 = 'Y' THEN
                     LET g_errno = NULL
                     CALL s_voucher_glaq052_chk(g_gldh_m.gldh017)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_gldh_m.gldh017 = g_gldh_m_t.gldh017
                        LET g_gldh_m.gldh017_desc = s_desc_get_oojdl003_desc(g_gldh_m.gldh017)
                        DISPLAY BY NAME g_gldh_m.gldh017,g_gldh_m.gldh017_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_gldh_m.gldh017_desc = s_desc_get_oojdl003_desc(g_gldh_m.gldh017)
            DISPLAY BY NAME g_gldh_m.gldh017,g_gldh_m.gldh017_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh017
            #add-point:BEFORE FIELD gldh017 name="input.b.gldh017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh017
            #add-point:ON CHANGE gldh017 name="input.g.gldh017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh018
            
            #add-point:AFTER FIELD gldh018 name="input.a.gldh018"
            LET g_gldh_m.gldh018_desc = ' '
            DISPLAY BY NAME g_gldh_m.gldh018_desc
            IF NOT cl_null(g_gldh_m.gldh018) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_m.gldh018 != g_gldh_m_t.gldh018 OR g_gldh_m.gldh018 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_gldh_m_o.gldh018) OR g_gldh_m.gldh018 != g_gldh_m_o.gldh018 THEN 
                  IF g_glda.glda002 = 'Y' THEN
                     CALL s_azzi650_chk_exist('2002',g_gldh_m.gldh018) RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                       #LET g_gldh_m.gldh018 = g_gldh_m_t.gldh018 #160824-00007#260 161220 By 08171 mark
                        LET g_gldh_m.gldh018 = g_gldh_m_o.gldh018 #160824-00007#260 161220 By 08171 add
                        LET g_gldh_m.gldh018_desc = s_desc_get_acc_desc('2002',g_gldh_m.gldh018)
                        DISPLAY BY NAME g_gldh_m.gldh018,g_gldh_m.gldh018_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_gldh_m.gldh018_desc = s_desc_get_acc_desc('2002',g_gldh_m.gldh018)
            DISPLAY BY NAME g_gldh_m.gldh018,g_gldh_m.gldh018_desc
            LET g_gldh_m_o.* = g_gldh_m.* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh018
            #add-point:BEFORE FIELD gldh018 name="input.b.gldh018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh018
            #add-point:ON CHANGE gldh018 name="input.g.gldh018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh019
            
            #add-point:AFTER FIELD gldh019 name="input.a.gldh019"
            LET g_gldh_m.gldh019_desc = ' '
            DISPLAY BY NAME g_gldh_m.gldh019_desc
            IF NOT cl_null(g_gldh_m.gldh019) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_m.gldh019 != g_gldh_m_t.gldh019 OR g_gldh_m.gldh019 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_gldh_m_o.gldh019) OR g_gldh_m.gldh019 != g_gldh_m_o.gldh019 THEN #160824-00007#260 161220 By 08171 add
                  IF g_glda.glda002 = 'Y' THEN
                     CALL s_employee_chk(g_gldh_m.gldh019) RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                       #LET g_gldh_m.gldh019 = g_gldh_m_t.gldh019 #160824-00007#260 161220 By 08171 mark
                        LET g_gldh_m.gldh019 = g_gldh_m_o.gldh019 #160824-00007#260 161220 By 08171 add
                        LET g_gldh_m.gldh019_desc = s_desc_get_person_desc(g_gldh_m.gldh019) 
                        DISPLAY BY NAME g_gldh_m.gldh019,g_gldh_m.gldh019_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_gldh_m.gldh019_desc = s_desc_get_person_desc(g_gldh_m.gldh019)
            DISPLAY BY NAME g_gldh_m.gldh019,g_gldh_m.gldh019_desc
            LET g_gldh_m_o.* = g_gldh_m.* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh019
            #add-point:BEFORE FIELD gldh019 name="input.b.gldh019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh019
            #add-point:ON CHANGE gldh019 name="input.g.gldh019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh020
            
            #add-point:AFTER FIELD gldh020 name="input.a.gldh020"
            LET g_gldh_m.gldh020_desc = ' '
            DISPLAY BY NAME g_gldh_m.gldh020_desc
            IF NOT cl_null(g_gldh_m.gldh020) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_m.gldh020 != g_gldh_m_t.gldh020 OR g_gldh_m_t.gldh020 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_gldh_m_o.gldh020) OR g_gldh_m.gldh020 != g_gldh_m_o.gldh020 THEN #160824-00007#260 161220 By 08171 add
                  IF g_glda.glda002 = 'Y' THEN
                     CALL s_aap_project_chk(g_gldh_m.gldh020) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#31 --s add
                        LET g_errparam.replace[1] = 'apjm200'
                        LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                        LET g_errparam.exeprog = 'apjm200'
                        #160321-00016#31 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                       #LET g_gldh_m.gldh020 = g_gldh_m_t.gldh020  #160824-00007#260 161220 By 08171 mark
                        LET g_gldh_m.gldh020 = g_gldh_m_o.gldh020  #160824-00007#260 161220 By 08171 add
                        LET g_gldh_m.gldh020_desc = s_desc_get_project_desc(g_gldh_m.gldh020)
                        DISPLAY BY NAME g_gldh_m.gldh020,g_gldh_m.gldh020_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_gldh_m.gldh020_desc = s_desc_get_project_desc(g_gldh_m.gldh020)
            DISPLAY BY NAME g_gldh_m.gldh020,g_gldh_m.gldh020_desc
            LET g_gldh_m_o.* = g_gldh_m.* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh020
            #add-point:BEFORE FIELD gldh020 name="input.b.gldh020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh020
            #add-point:ON CHANGE gldh020 name="input.g.gldh020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh021
            
            #add-point:AFTER FIELD gldh021 name="input.a.gldh021"
            LET g_gldh_m.gldh021_desc = ' '
            DISPLAY BY NAME g_gldh_m.gldh021_desc
            IF NOT cl_null(g_gldh_m.gldh021) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_m.gldh021 != g_gldh_m_t.gldh021 OR g_gldh_m_t.gldh021 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_gldh_m_o.gldh021) OR g_gldh_m.gldh021 != g_gldh_m_o.gldh021 THEN #160824-00007#260 161220 By 08171 add
                  IF g_glda.glda002 = 'Y' THEN
                     LET g_errno = NULL
                     CALL s_voucher_glaq028_chk(g_gldh_m.gldh020,g_gldh_m.gldh021)
                      
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                       #LET g_gldh_m.gldh021 = g_gldh_m_t.gldh021 #160824-00007#260 161220 By 08171 mark
                        LET g_gldh_m.gldh021 = g_gldh_m_o.gldh021 #160824-00007#260 161220 By 08171 add
                        LET g_gldh_m.gldh021_desc = s_desc_get_pjbbl004_desc(g_gldh_m.gldh020,g_gldh_m.gldh021)
                        DISPLAY BY NAME g_gldh_m.gldh021_desc,g_gldh_m.gldh021
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_gldh_m.gldh021_desc = s_desc_get_pjbbl004_desc(g_gldh_m.gldh020,g_gldh_m.gldh021)
            DISPLAY BY NAME g_gldh_m.gldh021_desc,g_gldh_m.gldh021
            LET g_gldh_m_o.* = g_gldh_m.* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh021
            #add-point:BEFORE FIELD gldh021 name="input.b.gldh021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh021
            #add-point:ON CHANGE gldh021 name="input.g.gldh021"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gldh001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh001
            #add-point:ON ACTION controlp INFIELD gldh001 name="input.c.gldh001"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldh002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh002
            #add-point:ON ACTION controlp INFIELD gldh002 name="input.c.gldh002"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh003
            #add-point:ON ACTION controlp INFIELD gldh003 name="input.c.gldh003"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldh005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh005
            #add-point:ON ACTION controlp INFIELD gldh005 name="input.c.gldh005"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh006
            #add-point:ON ACTION controlp INFIELD gldh006 name="input.c.gldh006"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh007
            #add-point:ON ACTION controlp INFIELD gldh007 name="input.c.gldh007"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldh008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh008
            #add-point:ON ACTION controlp INFIELD gldh008 name="input.c.gldh008"
            #營運中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_gldh_m.gldh008
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()    #161021-00037#4 mark
            CALL q_ooef001_01()  #161021-00037#4 add                       
            LET g_gldh_m.gldh008 = g_qryparam.return1  
            LET g_gldh_m.gldh008_desc = s_desc_get_department_desc(g_gldh_m.gldh008)
            DISPLAY BY NAME g_gldh_m.gldh008,g_gldh_m.gldh008_desc
            NEXT FIELD gldh008         
            #END add-point
 
 
         #Ctrlp:input.c.gldh009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh009
            #add-point:ON ACTION controlp INFIELD gldh009 name="input.c.gldh009"
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_gldh_m.gldh009      
            LET g_qryparam.arg1=g_today   #無單據日期先給g_today
            CALL q_ooeg001_4()
            LET g_gldh_m.gldh009 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_desc_get_department_desc(g_gldh_m.gldh009)RETURNING g_gldh_m.gldh009_desc
            DISPLAY BY NAME g_gldh_m.gldh009,g_gldh_m.gldh009_desc
            NEXT FIELD gldh009
            #END add-point
 
 
         #Ctrlp:input.c.gldh010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh010
            #add-point:ON ACTION controlp INFIELD gldh010 name="input.c.gldh010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 =g_gldh_m.gldh010             #給予default值
            #給予arg
            LET g_qryparam.arg1=g_today
            CALL q_ooeg001_5()
            LET g_gldh_m.gldh010 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_desc_get_department_desc(g_gldh_m.gldh010) RETURNING g_gldh_m.gldh010_desc
            DISPLAY BY NAME g_gldh_m.gldh010,g_gldh_m.gldh010_desc
            NEXT FIELD gldh010 
            #END add-point
 
 
         #Ctrlp:input.c.gldh011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh011
            #add-point:ON ACTION controlp INFIELD gldh011 name="input.c.gldh011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_gldh_m.gldh011             #給予default值
            CALL q_oocq002_287()                                #呼叫開窗
            LET g_gldh_m.gldh011 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_desc_get_acc_desc('287',g_gldh_m.gldh011) RETURNING g_gldh_m.gldh011_desc
            DISPLAY BY NAME g_gldh_m.gldh011,g_gldh_m.gldh011_desc
            NEXT FIELD gldh011
            #END add-point
 
 
         #Ctrlp:input.c.gldh012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh012
            #add-point:ON ACTION controlp INFIELD gldh012 name="input.c.gldh012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_gldh_m.gldh012             #給予default值
             CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            LET g_gldh_m.gldh012 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_desc_get_trading_partner_abbr_desc(g_gldh_m.gldh012)RETURNING g_gldh_m.gldh012_desc
            DISPLAY BY NAME g_gldh_m.gldh012,g_gldh_m.gldh012_desc            
            NEXT FIELD gldh012
            #END add-point
 
 
         #Ctrlp:input.c.gldh013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh013
            #add-point:ON ACTION controlp INFIELD gldh013 name="input.c.gldh013"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_gldh_m.gldh013             #給予default值
             CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗
            LET g_gldh_m.gldh013 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_desc_get_trading_partner_abbr_desc(g_gldh_m.gldh013) RETURNING g_gldh_m.gldh013_desc
            DISPLAY BY NAME g_gldh_m.gldh013,g_gldh_m.gldh013_desc 
            NEXT FIELD gldh013                        #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.gldh014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh014
            #add-point:ON ACTION controlp INFIELD gldh014 name="input.c.gldh014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_gldh_m.gldh014             #給予default值
            CALL q_oocq002_281()                                #呼叫開窗
            LET g_gldh_m.gldh014 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_desc_get_acc_desc('281',g_gldh_m.gldh014) RETURNING g_gldh_m.gldh014_desc
            DISPLAY BY NAME g_gldh_m.gldh014,g_gldh_m.gldh014_desc
            NEXT FIELD gldh014
            #END add-point
 
 
         #Ctrlp:input.c.gldh015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh015
            #add-point:ON ACTION controlp INFIELD gldh015 name="input.c.gldh015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_gldh_m.gldh015
            CALL q_rtax001()                                
            LET g_gldh_m.gldh015 = g_qryparam.return1            
            CALL　s_desc_get_rtaxl003_desc(g_gldh_m.gldh015)RETURNING g_gldh_m.gldh015_desc
            DISPLAY BY NAME g_gldh_m.gldh015,g_gldh_m.gldh015_desc
            NEXT FIELD gldh015       
            #END add-point
 
 
         #Ctrlp:input.c.gldh016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh016
            #add-point:ON ACTION controlp INFIELD gldh016 name="input.c.gldh016"
            
            #END add-point
 
 
         #Ctrlp:input.c.gldh017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh017
            #add-point:ON ACTION controlp INFIELD gldh017 name="input.c.gldh017"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldh_m.gldh017            
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                       
            LET g_gldh_m.gldh017 = g_qryparam.return1
            CALL s_desc_get_oojdl003_desc(g_gldh_m.gldh017)RETURNING g_gldh_m.gldh017_desc
            DISPLAY BY NAME g_gldh_m.gldh017,g_gldh_m.gldh017_desc
            NEXT FIELD gldh017                        
            #END add-point
 
 
         #Ctrlp:input.c.gldh018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh018
            #add-point:ON ACTION controlp INFIELD gldh018 name="input.c.gldh018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldh_m.gldh018             #給予default值
            CALL q_oocq002_2002()                                #呼叫開窗
            LET g_gldh_m.gldh018 = g_qryparam.return1
            CALL s_desc_get_acc_desc('2002',g_gldh_m.gldh018)RETURNING g_gldh_m.gldh018_desc
            DISPLAY BY NAME g_gldh_m.gldh018,g_gldh_m.gldh018_desc            
            NEXT FIELD gldh018
            #END add-point
 
 
         #Ctrlp:input.c.gldh019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh019
            #add-point:ON ACTION controlp INFIELD gldh019 name="input.c.gldh019"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_gldh_m.gldh019            #給予default值
            CALL q_ooag001_8()                                #呼叫開窗
            LET g_gldh_m.gldh019 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_desc_get_person_desc(g_gldh_m.gldh019)RETURNING g_gldh_m.gldh019_desc 
            DISPLAY BY NAME g_gldh_m.gldh019,g_gldh_m.gldh019_desc  
            NEXT FIELD gldh019                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.gldh020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh020
            #add-point:ON ACTION controlp INFIELD gldh020 name="input.c.gldh020"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 =  g_gldh_m.gldh020           
            CALL q_pjba001()                               
            LET g_gldh_m.gldh020 = g_qryparam.return1             
            CALL s_desc_get_project_desc(g_gldh_m.gldh020) RETURNING  g_gldh_m.gldh020_desc
            DISPLAY BY NAME g_gldh_m.gldh020,g_gldh_m.gldh020_desc 
            NEXT FIELD gldh020
            #END add-point
 
 
         #Ctrlp:input.c.gldh021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh021
            #add-point:ON ACTION controlp INFIELD gldh021 name="input.c.gldh021"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_gldh_m.gldh021            #給予default值
            IF NOT cl_null(g_gldh_m.gldh020) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_gldh_m.gldh020,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            CALL q_pjbb002()                                #呼叫開窗
            LET g_gldh_m.gldh021 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_desc_get_pjbbl004_desc(g_gldh_m.gldh020,g_gldh_m.gldh021)RETURNING g_gldh_m.gldh021_desc
            DISPLAY BY NAME g_gldh_m.gldh021,g_gldh_m.gldh021_desc
            NEXT FIELD gldh021
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
   CLOSE WINDOW w_aglt501_01 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      CALL aglt501_01_g_gldh_to_array()RETURNING p_array
   ELSE
      LET INT_FLAG = 0
   END IF
   
   RETURN p_array
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglt501_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aglt501_01.other_function" readonly="Y" >}

PRIVATE FUNCTION aglt501_01_array_to_g_gldh(p_array)
   DEFINE p_array DYNAMIC ARRAY OF RECORD
          chr     LIKE type_t.chr1000,
          dat     LIKE type_t.dat
                  END RECORD
   DEFINE l_flag1 LIKE type_t.num5
   DEFINE l_progtype LIKE type_t.chr1     #1:aglt501 2:其他
   WHENEVER ERROR CONTINUE
   #1  [1].chr  gldh001
   #2  [2].chr  gldh002
   #3  [3].chr  gldh003    X
   #4  [4].chr  gldh004    X
   #5  [5].chr  gldh005
   #6  [6].chr  gldh006
   #7  [7].chr  gldh007    X
   #8  [8].chr  gldh008
   #9  [9].chr  gldh009
   #10 [10].chr gldh010
   #11 [11].chr gldh011
   #12 [12].chr gldh012
   #13 [13].chr gldh013
   #14 [14].chr gldh014
   #15 [15].chr gldh015
   #16 [16].chr gldh016
   #17 [17].chr gldh017
   #18 [18].chr gldh018
   #19 [19].chr gldh019
   #20 [20].chr gldh020
   #21 [21].chr gldh021
   #22 [22].chr 1:aglt501 2:其他
  
   INITIALIZE g_gldh_m.* TO NULL
   LET g_gldh_m.gldh001 = p_array[1].chr 
   LET g_gldh_m.gldh002 = p_array[2].chr 
   LET g_gldh_m.gldh003 = p_array[3].chr 
   #LET g_gldh_m.gldh004 = p_array[4].chr 
   LET g_gldh_m.gldh005 = p_array[5].chr 
   LET g_gldh_m.gldh006 = p_array[6].chr 
   #LET g_gldh_m.gldh007 = p_array[7].chr 
   LET g_gldh_m.gldh008 = p_array[8].chr 
   LET g_gldh_m.gldh009 = p_array[9].chr 
   LET g_gldh_m.gldh010 = p_array[10].chr
   LET g_gldh_m.gldh011 = p_array[11].chr
   LET g_gldh_m.gldh012 = p_array[12].chr
   LET g_gldh_m.gldh013 = p_array[13].chr
   LET g_gldh_m.gldh014 = p_array[14].chr
   LET g_gldh_m.gldh015 = p_array[15].chr
   LET g_gldh_m.gldh016 = p_array[16].chr
   LET g_gldh_m.gldh017 = p_array[17].chr
   LET g_gldh_m.gldh018 = p_array[18].chr
   LET g_gldh_m.gldh019 = p_array[19].chr
   LET g_gldh_m.gldh020 = p_array[20].chr
   LET g_gldh_m.gldh021 = p_array[21].chr
   LET l_progtype       = p_array[22].chr
   

   LET g_gldh_m.gldh008_desc = s_desc_get_department_desc(g_gldh_m.gldh008)
   LET g_gldh_m.gldh009_desc = s_desc_get_department_desc(g_gldh_m.gldh009)
   LET g_gldh_m.gldh010_desc = s_desc_get_department_desc(g_gldh_m.gldh010)
   LET g_gldh_m.gldh011_desc = s_desc_get_acc_desc('287',g_gldh_m.gldh011)
   LET g_gldh_m.gldh012_desc = s_desc_get_trading_partner_abbr_desc(g_gldh_m.gldh012)
   LET g_gldh_m.gldh013_desc = s_desc_get_trading_partner_abbr_desc(g_gldh_m.gldh013)
   LET g_gldh_m.gldh014_desc = s_desc_get_acc_desc('281',g_gldh_m.gldh014)   
   LET g_gldh_m.gldh015_desc = s_desc_get_rtaxl003_desc(g_gldh_m.gldh015)   
   LET g_gldh_m.gldh017_desc = s_desc_get_oojdl003_desc(g_gldh_m.gldh017)   
   LET g_gldh_m.gldh018_desc = s_desc_get_acc_desc('2002',g_gldh_m.gldh018) 
   LET g_gldh_m.gldh019_desc = s_desc_get_person_desc(g_gldh_m.gldh019) 
   LET g_gldh_m.gldh020_desc = s_desc_get_project_desc(g_gldh_m.gldh020) 
   LET g_gldh_m.gldh021_desc = s_desc_get_pjbbl004_desc(g_gldh_m.gldh020,g_gldh_m.gldh021) 
   
   DISPLAY BY NAME g_gldh_m.gldh008_desc,g_gldh_m.gldh009_desc,g_gldh_m.gldh010_desc,
                   g_gldh_m.gldh011_desc,g_gldh_m.gldh012_desc,g_gldh_m.gldh013_desc,
                   g_gldh_m.gldh014_desc,g_gldh_m.gldh015_desc,                
                   g_gldh_m.gldh017_desc,g_gldh_m.gldh018_desc,g_gldh_m.gldh019_desc,
                   g_gldh_m.gldh020_desc,g_gldh_m.gldh021_desc
                   
                   
   LET g_gldh_m_t.* = g_gldh_m.*
   
   
   CALL s_fin_sel_glad(g_gldh_m.gldh002,g_gldh_m.gldh003,'ALL') RETURNING g_glad.*
   
  #161111-00028#9---modify---begin----------
  #SELECT * INTO g_glda.* 
   SELECT gldaent,gldaownid,gldaowndp,gldacrtid,gldacrtdp,gldacrtdt,gldamodid,
          gldamoddt,gldastus,glda001,glda002,glda003,glda004 INTO g_glda.* 
  #161111-00028#9---modify---end----------        
   FROM glda_t
    WHERE gldaent = g_enterprise
      AND glda001 = g_gldh_m.gldh001

#   #albireo 150330-----s
    IF l_progtype = '2' THEN
       LET g_glda.glda002 = 'Y'
    END IF
#   #albireo 150330-----e
#   #albireo 150309-----s   
   #先required 後visible 避免 欄位多語言說明消失
   CALL cl_set_comp_required('gldh009,gldh010,gldh011,gldh012,gldh013,gldh014,gldh015',TRUE)
   #CALL cl_set_comp_required('gldh016,gldh017,gldh018,gldh019,gldh020,gldh021',TRUE) #170111-00005#1 mark
   CALL cl_set_comp_required('gldh016,gldh017,gldh018,gldh019',TRUE)#170111-00005#1 add
   IF g_glda.glda002 = 'N' THEN
      CALL cl_set_comp_required('gldh009,gldh010,gldh011,gldh012,gldh013,gldh014,gldh015',FALSE)
      CALL cl_set_comp_required('gldh016,gldh017,gldh018,gldh019,gldh020,gldh021',FALSE)
   END IF
#   #albireo 150309-----e
   
   #隱藏未勾選的
   LET l_flag1 = 0
   #該科目做部門管理時，部門不可空白,否则隐藏  
   IF g_glad.glad007 = 'Y' OR g_glda.glda002 = 'N' THEN     
      CALL cl_set_comp_visible('gldh009,gldh009_desc',TRUE) 
   ELSE
      CALL cl_set_comp_visible('gldh009,gldh009_desc',FALSE)
      LET l_flag1 = l_flag1+1      
   END IF 
   #該科目做利潤成本管理時，利潤成本不可空白,否则隐藏  
   IF g_glad.glad008 = 'Y' OR g_glda.glda002 = 'N' THEN      
      CALL cl_set_comp_visible('gldh010,gldh010_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('gldh010,gldh010_desc',FALSE)
      LET l_flag1 = l_flag1+1
   END IF 
   #該科目做區域管理時，區域不可空白 ,否则隐藏 
   IF g_glad.glad009 = 'Y' OR g_glda.glda002 = 'N' THEN    
      CALL cl_set_comp_visible('gldh011,gldh011_desc',TRUE)       
   ELSE
      CALL cl_set_comp_visible('gldh011,gldh011_desc',FALSE)
      LET l_flag1 = l_flag1+1
   END IF 
   #該科目做交易客商管理時，客商不可空白 ,否则隐藏 
   IF g_glad.glad010 = 'Y' OR g_glda.glda002 = 'N' THEN 
      CALL cl_set_comp_visible('gldh012,gldh012_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('gldh012,gldh012_desc',FALSE)
      LET l_flag1 = l_flag1+1
   END IF 
   #該科目做账款客商管理時，客商不可空白 ,否则隐藏 
   IF g_glad.glad027 = 'Y' OR g_glda.glda002 = 'N' THEN 
      CALL cl_set_comp_visible('gldh013,gldh013_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('gldh013,gldh013_desc',FALSE) 
      LET l_flag1 = l_flag1+1
   END IF 
   #該科目做客群管理時，客群不可空白,否则隐藏  
   IF g_glad.glad011 = 'Y' OR g_glda.glda002 = 'N' THEN
      CALL cl_set_comp_visible('gldh014,gldh014_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('gldh014,gldh014_desc',FALSE)
      LET l_flag1 = l_flag1+1
   END IF 
   
   #該科目做產品分類管理時，部門不可空白,否则隐藏  
   IF g_glad.glad012 = 'Y' OR g_glda.glda002 = 'N' THEN       
      CALL cl_set_comp_visible('gldh015,gldh015_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('gldh015,gldh015_desc',FALSE)
      LET l_flag1 = l_flag1+1      
   END IF 

   #該科目做经营方式管理時，经营方式不可空白,否则隐藏  
   IF g_glad.glad031 = 'Y' OR g_glda.glda002 = 'N' THEN
      CALL cl_set_comp_visible('gldh016',TRUE)
   ELSE
      CALL cl_set_comp_visible('gldh016',FALSE)
   END IF 
   #該科目做渠道管理時，渠道不可空白,否则隐藏  
   IF g_glad.glad032 = 'Y' OR g_glda.glda002 = 'N' THEN
      CALL cl_set_comp_visible('gldh017,gldh017_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('gldh017,gldh017_desc',FALSE)
   END IF 
   #該科目做品牌管理時，品牌不可空白,否则隐藏  
   IF g_glad.glad033 = 'Y' OR g_glda.glda002 = 'N' THEN
      CALL cl_set_comp_visible('gldh018,gldh018_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('gldh018,gldh018_desc',FALSE)
   END IF 
   
   #該科目做人員管理時，部門不可空白,否则隐藏  
   IF g_glad.glad013 = 'Y' OR g_glda.glda002 = 'N' THEN       
      CALL cl_set_comp_visible('gldh019,gldh019_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('gldh019,gldh019_desc',FALSE) 
   END IF 
 
   #該科目做專案管理時，部門不可空白,否则隐藏  
   IF g_glad.glad015 = 'Y' OR g_glda.glda002 = 'N' THEN 
      CALL cl_set_comp_visible('gldh020,gldh020_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('gldh020,gldh020_desc',FALSE)
   END IF 
   #該科目做WBS管理時，部門不可空白,否则隐藏  
   IF g_glad.glad016 = 'Y' OR g_glda.glda002 = 'N' THEN
      CALL cl_set_comp_visible('gldh021,gldh021_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('gldh021,gldh021_desc',FALSE)
   END IF

END FUNCTION

PRIVATE FUNCTION aglt501_01_g_gldh_to_array()
   DEFINE r_array DYNAMIC ARRAY OF RECORD
          chr     LIKE type_t.chr1000,
          dat     LIKE type_t.dat
                  END RECORD
   WHENEVER ERROR CONTINUE
   CALL r_array.clear()
   LET r_array[1].chr  = g_gldh_m.gldh001
   LET r_array[2].chr  = g_gldh_m.gldh002
   #LET r_array[3].chr  = g_gldh_m.gldh003
   #LET r_array[4].chr  = g_gldh_m.gldh004
   LET r_array[5].chr  = g_gldh_m.gldh005
   LET r_array[6].chr  = g_gldh_m.gldh006
   #LET r_array[7].chr  = g_gldh_m.gldh007
   LET r_array[8].chr  = g_gldh_m.gldh008
   LET r_array[9].chr  = g_gldh_m.gldh009
   LET r_array[10].chr = g_gldh_m.gldh010
   LET r_array[11].chr = g_gldh_m.gldh011
   LET r_array[12].chr = g_gldh_m.gldh012
   LET r_array[13].chr = g_gldh_m.gldh013
   LET r_array[14].chr = g_gldh_m.gldh014
   LET r_array[15].chr = g_gldh_m.gldh015
   LET r_array[16].chr = g_gldh_m.gldh016
   LET r_array[17].chr = g_gldh_m.gldh017
   LET r_array[18].chr = g_gldh_m.gldh018
   LET r_array[19].chr = g_gldh_m.gldh019
   LET r_array[20].chr = g_gldh_m.gldh020
   LET r_array[21].chr = g_gldh_m.gldh021
   RETURN r_array
END FUNCTION

 
{</section>}
 
