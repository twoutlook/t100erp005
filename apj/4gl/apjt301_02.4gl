#該程式未解開Section, 採用最新樣板產出!
{<section id="apjt301_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-10-08 17:29:29), PR版次:0003(2016-12-15 16:59:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: apjt301_02
#+ Description: 
#+ Creator....: 02294(2015-10-08 10:21:30)
#+ Modifier...: 02294 -SD/PR- 08734
 
{</section>}
 
{<section id="apjt301_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#8   2016/04/20 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#161124-00048#16  2016/12/15 By 08734       星号整批调整
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
PRIVATE type type_g_pjbz_m        RECORD
       pjbz001 LIKE pjbz_t.pjbz001, 
   pjbzld LIKE pjbz_t.pjbzld, 
   pjbzld_desc LIKE type_t.chr80, 
   pjbz002 LIKE pjbz_t.pjbz002, 
   pjbz003 LIKE pjbz_t.pjbz003, 
   pjbz004 LIKE pjbz_t.pjbz004, 
   pjbz004_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaacomp    LIKE glaa_t.glaacomp
DEFINE g_glaa004     LIKE glaa_t.glaa004 
DEFINE g_wc          STRING
DEFINE g_sql         STRING
DEFINE g_para_data   LIKE type_t.chr80    #啟用次要素否 140924
#end add-point
 
DEFINE g_pjbz_m        type_g_pjbz_m
 
   DEFINE g_pjbz001_t LIKE pjbz_t.pjbz001
DEFINE g_pjbzld_t LIKE pjbz_t.pjbzld
DEFINE g_pjbz002_t LIKE pjbz_t.pjbz002
DEFINE g_pjbz003_t LIKE pjbz_t.pjbz003
DEFINE g_pjbz004_t LIKE pjbz_t.pjbz004
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apjt301_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION apjt301_02(--)
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
   DEFINE l_year          LIKE type_t.num5
   DEFINE l_month         LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_errno         LIKE gzze_t.gzze001
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_apjt301_02 WITH FORM cl_ap_formpath("apj","apjt301_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('pjbz001','8908')
 
   LET g_errshow = 1
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6010') RETURNING l_year
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6011') RETURNING l_month
   CALL s_fin_ld_carry('',g_user)
   RETURNING l_success,g_pjbz_m.pjbzld,g_glaacomp,l_errno
   
   LET g_pjbz_m.pjbz001 =  '1'
   
   CALL apjt301_02_ref_show()
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_pjbz_m.pjbz001,g_pjbz_m.pjbzld,g_pjbz_m.pjbz002,g_pjbz_m.pjbz003,g_pjbz_m.pjbz004  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_pjbz_m.pjbz002 = l_year
            LET g_pjbz_m.pjbz003 = l_month
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz001
            #add-point:BEFORE FIELD pjbz001 name="input.b.pjbz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz001
            
            #add-point:AFTER FIELD pjbz001 name="input.a.pjbz001"
            #此段落由子樣板a05產生



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz001
            #add-point:ON CHANGE pjbz001 name="input.g.pjbz001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbzld
            
            #add-point:AFTER FIELD pjbzld name="input.a.pjbzld"
            CALL apjt301_02_ref_show()
            IF NOT cl_null(g_pjbz_m.pjbzld) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbz_m.pjbzld
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#8--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL s_ld_chk_authorization(g_user,g_pjbz_m.pjbzld) RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00022'
                     LET g_errparam.extend = g_pjbz_m.pjbzld
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pjbz_m.pjbzld = ''
                     CALL apjt301_02_ref_show()
                     NEXT FIELD CURRENT
                  END IF 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbz_m.pjbzld = ''
                  CALL apjt301_02_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            SELECT glaa004,glaacomp
              INTO g_glaa004,g_glaacomp
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_pjbz_m.pjbzld
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbzld
            #add-point:BEFORE FIELD pjbzld name="input.b.pjbzld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbzld
            #add-point:ON CHANGE pjbzld name="input.g.pjbzld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz002
            #add-point:BEFORE FIELD pjbz002 name="input.b.pjbz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz002
            
            #add-point:AFTER FIELD pjbz002 name="input.a.pjbz002"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz002
            #add-point:ON CHANGE pjbz002 name="input.g.pjbz002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz003
            #add-point:BEFORE FIELD pjbz003 name="input.b.pjbz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz003
            
            #add-point:AFTER FIELD pjbz003 name="input.a.pjbz003"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz003
            #add-point:ON CHANGE pjbz003 name="input.g.pjbz003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjbz004
            
            #add-point:AFTER FIELD pjbz004 name="input.a.pjbz004"
            CALL apjt301_02_ref_show()
            IF NOT cl_null(g_pjbz_m.pjbz004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"
               #160318-00025#8--add--end
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbz_m.pjbz004
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjba001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbz_m.pjbz004 = ''
                  CALL apjt301_02_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjbz004
            #add-point:BEFORE FIELD pjbz004 name="input.b.pjbz004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjbz004
            #add-point:ON CHANGE pjbz004 name="input.g.pjbz004"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pjbz001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz001
            #add-point:ON ACTION controlp INFIELD pjbz001 name="input.c.pjbz001"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjbzld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbzld
            #add-point:ON ACTION controlp INFIELD pjbzld name="input.c.pjbzld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_m.pjbzld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_pjbz_m.pjbzld = g_qryparam.return1              
            CALL apjt301_02_ref_show()
            DISPLAY g_pjbz_m.pjbzld TO pjbzld              #

            NEXT FIELD pjbzld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pjbz002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz002
            #add-point:ON ACTION controlp INFIELD pjbz002 name="input.c.pjbz002"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjbz003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz003
            #add-point:ON ACTION controlp INFIELD pjbz003 name="input.c.pjbz003"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjbz004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjbz004
            #add-point:ON ACTION controlp INFIELD pjbz004 name="input.c.pjbz004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbz_m.pjbz004             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = ""

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_pjbz_m.pjbz004 = g_qryparam.return1              
            CALL apjt301_02_ref_show()
            DISPLAY g_pjbz_m.pjbz004 TO pjbz004              #

            NEXT FIELD pjbz004                          #返回原欄位


            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT BY NAME g_wc ON glar001,glar013
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD glar001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           #LET g_qryparam.where = " glac003 != '1' "  fengmy mark 141231
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1'"  #fengmy add 141231
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glar001       #顯示到畫面上
            NEXT FIELD glar001                          #返回原欄位
         
         ON ACTION controlp INFIELD glar013
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO glar013       #顯示到畫面上
            NEXT FIELD glar013                          #返回原欄位
         
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
   IF INT_FLAG THEN
      LET INT_FLAG = TRUE 
   ELSE
      CALL apjt301_02_ins_pjbz()
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_apjt301_02 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apjt301_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="apjt301_02.other_function" readonly="Y" >}
# 參考欄位帶值
PRIVATE FUNCTION apjt301_02_ref_show()
   CALL s_desc_get_ld_desc(g_pjbz_m.pjbzld) RETURNING g_pjbz_m.pjbzld_desc
   DISPLAY BY NAME g_pjbz_m.pjbzld_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjbz_m.pjbzld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaa004 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_glaa004 = '', g_rtn_fields[1] , ''
   
    CALL s_desc_get_project_desc(g_pjbz_m.pjbz004) RETURNING g_pjbz_m.pjbz004_desc
    DISPLAY BY NAME g_pjbz_m.pjbz004_desc
   
END FUNCTION
# 整批產生
PRIVATE FUNCTION apjt301_02_ins_pjbz()
   #DEFINE l_pjbz               RECORD  LIKE  pjbz_t.*  #161124-00048#16  2016/12/15 By 08734 mark
   #161124-00048#16  2016/12/15 By 08734 add(S)
   DEFINE l_pjbz RECORD  #專案人工制費收集維護檔
       pjbzent LIKE pjbz_t.pjbzent, #企业编号
       pjbzcomp LIKE pjbz_t.pjbzcomp, #法人组织
       pjbzld LIKE pjbz_t.pjbzld, #账套
       pjbz001 LIKE pjbz_t.pjbz001, #费用类型
       pjbz002 LIKE pjbz_t.pjbz002, #年度
       pjbz003 LIKE pjbz_t.pjbz003, #期别
       pjbz004 LIKE pjbz_t.pjbz004, #项目编号
       pjbzseq LIKE pjbz_t.pjbzseq, #项次
       pjbz010 LIKE pjbz_t.pjbz010, #科目编号
       pjbz011 LIKE pjbz_t.pjbz011, #营运组织
       pjbz012 LIKE pjbz_t.pjbz012, #部门
       pjbz013 LIKE pjbz_t.pjbz013, #交易对象
       pjbz014 LIKE pjbz_t.pjbz014, #客群
       pjbz015 LIKE pjbz_t.pjbz015, #区域
       pjbz016 LIKE pjbz_t.pjbz016, #成本中心
       pjbz017 LIKE pjbz_t.pjbz017, #经营类别
       pjbz018 LIKE pjbz_t.pjbz018, #渠道
       pjbz019 LIKE pjbz_t.pjbz019, #品类
       pjbz020 LIKE pjbz_t.pjbz020, #品牌
       pjbz021 LIKE pjbz_t.pjbz021, #项目编号
       pjbz022 LIKE pjbz_t.pjbz022, #WBS
       pjbz100 LIKE pjbz_t.pjbz100, #分摊成本
       pjbzownid LIKE pjbz_t.pjbzownid, #资料所有者
       pjbzowndp LIKE pjbz_t.pjbzowndp, #资料所有部门
       pjbzcrtid LIKE pjbz_t.pjbzcrtid, #资料录入者
       pjbzcrtdp LIKE pjbz_t.pjbzcrtdp, #资料录入部门
       pjbzcrtdt LIKE pjbz_t.pjbzcrtdt, #资料创建日
       pjbzmodid LIKE pjbz_t.pjbzmodid, #资料更改者
       pjbzmoddt LIKE pjbz_t.pjbzmoddt, #最近更改日
       pjbzstus LIKE pjbz_t.pjbzstus #状态码
END RECORD
#161124-00048#16  2016/12/15 By 08734 add(E)
   #DEFINE l_glar               RECORD  LIKE  glar_t.*  #161124-00048#16  2016/12/15 By 08734 mark
   #161124-00048#16  2016/12/15 By 08734 add(S)
   DEFINE l_glar RECORD  #會計科目各期餘額檔
       glarent LIKE glar_t.glarent, #企业编号
       glarcomp LIKE glar_t.glarcomp, #法人
       glarld LIKE glar_t.glarld, #账套
       glar001 LIKE glar_t.glar001, #会计科目
       glar002 LIKE glar_t.glar002, #年度
       glar003 LIKE glar_t.glar003, #期别
       glar004 LIKE glar_t.glar004, #组合要素(key)
       glar005 LIKE glar_t.glar005, #借方金额
       glar006 LIKE glar_t.glar006, #贷方金额
       glar007 LIKE glar_t.glar007, #借方笔数
       glar008 LIKE glar_t.glar008, #贷方笔数
       glar009 LIKE glar_t.glar009, #交易币种
       glar010 LIKE glar_t.glar010, #原币借方金额
       glar011 LIKE glar_t.glar011, #原币贷方金额
       glar012 LIKE glar_t.glar012, #营运据点
       glar013 LIKE glar_t.glar013, #部门
       glar014 LIKE glar_t.glar014, #利润/成本中心
       glar015 LIKE glar_t.glar015, #区域
       glar016 LIKE glar_t.glar016, #收付款客商
       glar017 LIKE glar_t.glar017, #账款客商
       glar018 LIKE glar_t.glar018, #客群
       glar019 LIKE glar_t.glar019, #产品类别
       glar020 LIKE glar_t.glar020, #人员
       glar021 LIKE glar_t.glar021, #no use
       glar022 LIKE glar_t.glar022, #项目编号
       glar023 LIKE glar_t.glar023, #WBS
       glar024 LIKE glar_t.glar024, #自由核算项一
       glar025 LIKE glar_t.glar025, #自由核算项二
       glar026 LIKE glar_t.glar026, #自由核算项三
       glar027 LIKE glar_t.glar027, #自由核算项四
       glar028 LIKE glar_t.glar028, #自由核算项五
       glar029 LIKE glar_t.glar029, #自由核算项六
       glar030 LIKE glar_t.glar030, #自由核算项七
       glar031 LIKE glar_t.glar031, #自由核算项八
       glar032 LIKE glar_t.glar032, #自由核算项九
       glar033 LIKE glar_t.glar033, #自由核算项十
       glar034 LIKE glar_t.glar034, #借方金额(本位币二)
       glar035 LIKE glar_t.glar035, #贷方金额(本位币二)
       glar036 LIKE glar_t.glar036, #借方金额(本位币三)
       glar037 LIKE glar_t.glar037, #贷方金额(本位币三)
       glar051 LIKE glar_t.glar051, #经营方式
       glar052 LIKE glar_t.glar052, #渠道
       glar053 LIKE glar_t.glar053 #品牌
END RECORD
#161124-00048#16  2016/12/15 By 08734 add(E)
   DEFINE l_pjbz100_sum        LIKE pjbz_t.pjbz100
   DEFINE l_glac008            LIKE glac_t.glac008
   DEFINE l_amt1               LIKE glar_t.glar005
   DEFINE l_n                  LIKE type_t.num5
   DEFINE l_flag               LIKE type_t.chr1
   
   CALL s_transaction_begin()
   LET g_success = 'Y'
   LET l_flag = 'N'
   
   CALL cl_err_collect_init() 
   LET g_coll_title[1] = cl_getmsg("axc-00584",g_lang) #法人
   LET g_coll_title[2] = cl_getmsg("axc-00585",g_lang) #账套
   LET g_coll_title[3] = cl_getmsg("axc-00582",g_lang) #科目
  
   SELECT COUNT(*) INTO l_n 
     FROM pjbz_t
    WHERE pjbzent = g_enterprise
      AND pjbzld  = g_pjbz_m.pjbzld
      AND pjbz001 = g_pjbz_m.pjbz001
      AND pjbz002 = g_pjbz_m.pjbz002
      AND pjbz003 = g_pjbz_m.pjbz003
      
   IF l_n > 0 THEN 
      IF cl_ask_confirm('axc-00531') THEN
         DELETE FROM pjbz_t
          WHERE pjbzent = g_enterprise
            AND pjbzld  = g_pjbz_m.pjbzld
            AND pjbz001 = g_pjbz_m.pjbz001
            AND pjbz002 = g_pjbz_m.pjbz002
            AND pjbz003 = g_pjbz_m.pjbz003
      END IF
   END IF
   
   #LET g_sql = "SELECT * FROM glar_t",  #161124-00048#16  2016/12/15 By 08734 mark
   LET g_sql = "SELECT glarent,glarcomp,glarld,glar001,glar002,glar003,glar004,glar005,glar006,glar007,glar008,glar009,glar010,",
               "glar011,glar012,glar013,glar014,glar015,glar016,glar017,glar018,glar019,glar020,",
               "glar021,glar022,glar023,glar024,glar025,glar026,glar027,glar028,glar029,glar030,",
               "glar031,glar032,glar033,glar034,glar035,glar036,glar037,glar051,glar052,glar053 FROM glar_t",  #161124-00048#16  2016/12/15 By 08734 add
               " WHERE glarent = '",g_enterprise,"'",
               "   AND glarld = '",g_pjbz_m.pjbzld,"'",
               "   AND glar002 = '",g_pjbz_m.pjbz002,"'",
               "   AND glar003 = '",g_pjbz_m.pjbz003,"'",
               "   AND ",g_wc
   PREPARE xcba_pre FROM g_sql
   DECLARE xcba_cur CURSOR FOR xcba_pre   

   FOREACH xcba_cur INTO l_glar.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_flag = 'Y'
       
      LET l_pjbz.pjbzent  = g_enterprise
      LET l_pjbz.pjbzcomp = g_glaacomp
      LET l_pjbz.pjbzld   = g_pjbz_m.pjbzld
      LET l_pjbz.pjbz001  = g_pjbz_m.pjbz001
      LET l_pjbz.pjbz002  = g_pjbz_m.pjbz002
      LET l_pjbz.pjbz003  = g_pjbz_m.pjbz003
      LET l_pjbz.pjbz004  = g_pjbz_m.pjbz004
      
      SELECT MAX(pjbzseq) + 1 INTO l_pjbz.pjbzseq
        FROM pjbz_t
       WHERE pjbzent = g_enterprise
         AND pjbzld = g_pjbz_m.pjbzld
         AND pjbz001 = g_pjbz_m.pjbz001
         AND pjbz002 = g_pjbz_m.pjbz002
         AND pjbz003 = g_pjbz_m.pjbz003
         AND pjbz004 = g_pjbz_m.pjbz004
         
       IF cl_null(l_pjbz.pjbzseq) THEN 
          LET l_pjbz.pjbzseq = 1
       END IF 
       
       LET l_pjbz.pjbz010 = l_glar.glar001
       LET l_pjbz.pjbz011 = l_glar.glar012
       LET l_pjbz.pjbz012 = l_glar.glar013
       LET l_pjbz.pjbz013 = l_glar.glar016
       LET l_pjbz.pjbz014 = l_glar.glar018
       LET l_pjbz.pjbz015 = l_glar.glar015
       LET l_pjbz.pjbz016 = l_glar.glar014
       LET l_pjbz.pjbz017 = l_glar.glar051
       LET l_pjbz.pjbz018 = l_glar.glar052
       LET l_pjbz.pjbz019 = l_glar.glar019
       LET l_pjbz.pjbz020 = l_glar.glar053
       LET l_pjbz.pjbz021 = l_glar.glar022
       LET l_pjbz.pjbz022 = l_glar.glar023
       
       #判断是否超额分摊：
       #根据该账套、年度、期别、科目+营运组织+部门+交易对象+客群+区域+成本中心+经营类别+渠
       #道+品类+品牌+项目编号+WBS从pjbz_t中抓取已分摊的金额sum(pjbz100)
       SELECT sum(pjbz100)
         INTO l_pjbz100_sum
         FROM pjbz_t
        WHERE pjbzent = g_enterprise
          AND pjbzld  = g_pjbz_m.pjbzld
          AND pjbz002 = g_pjbz_m.pjbz002
          AND pjbz003 = g_pjbz_m.pjbz003
          AND pjbz010 = l_pjbz.pjbz010
          AND pjbz011 = l_pjbz.pjbz011
          AND pjbz012 = l_pjbz.pjbz012
          AND pjbz013 = l_pjbz.pjbz013
          AND pjbz014 = l_pjbz.pjbz014
          AND pjbz015 = l_pjbz.pjbz015
          AND pjbz016 = l_pjbz.pjbz016
          AND pjbz017 = l_pjbz.pjbz017
          AND pjbz018 = l_pjbz.pjbz018
          AND pjbz019 = l_pjbz.pjbz019
          AND pjbz020 = l_pjbz.pjbz020
          AND pjbz021 = l_pjbz.pjbz021
          AND pjbz022 = l_pjbz.pjbz022
          
       IF cl_null(l_pjbz100_sum) THEN 
          LET l_pjbz100_sum = 0
       END IF 
       
       #科目正常余额形态
       SELECT glac008 INTO l_glac008
         FROM glac_t
        WHERE glacent = g_enterprise
          AND glac001 = g_glaa004
          AND glac002 = l_glar.glar001   
          
       IF cl_null(l_glar.glar005) THEN 
          LET l_glar.glar005 = 0
       END IF
       
       IF cl_null(l_glar.glar006) THEN 
          LET l_glar.glar006 = 0
       END IF
       
       LET l_amt1 = 0
      
       IF l_glac008 = '1' THEN
          SELECT SUM(glar006 - glar005) INTO l_amt1
            FROM glar_t
           WHERE glarent = g_enterprise
             AND glarld = g_pjbz_m.pjbzld
             AND glar001 = l_glar.glar001
             AND glar002 = g_pjbz_m.pjbz002
             AND glar003 = g_pjbz_m.pjbz003
             AND glar004 = ' '
             
          IF cl_null(l_amt1) THEN 
             LET l_amt1 = 0
          END IF
         
          #分摊成本(pjbz100)=借方金额(glar005)-贷方金额(glar006)+结转类凭证发生额
          LET l_pjbz.pjbz100 = l_glar.glar005 - l_glar.glar006 + l_amt1
         
       ELSE
          SELECT SUM(glar005 - glar006) INTO l_amt1
            FROM glar_t
           WHERE glarent = g_enterprise
             AND glarld = g_pjbz_m.pjbzld
             AND glar001 = l_glar.glar001
             AND glar002 = g_pjbz_m.pjbz002
             AND glar003 = g_pjbz_m.pjbz003
             AND glar004 = ' '
             
          #分摊成本(pjbz100)=贷方金额(glar006)-借方金额(glar005)+结转类凭证发生额      
          LET l_pjbz.pjbz100 = l_glar.glar006 - l_glar.glar005 + l_amt1
       END IF   
       
       #IF  分摊成本(pjbz100)>已分摊的金额sum(pjbz100) THEN
       #     分摊成本(pjbz100)=分摊成本(pjbz100)-已分摊的金额sum(pjbz100)
       #END IF
       IF l_pjbz.pjbz100 > l_pjbz100_sum THEN 
          LET l_pjbz.pjbz100 = l_pjbz.pjbz100 - l_pjbz100_sum
       END IF
       
       IF cl_null(l_pjbz.pjbz100) THEN 
          LET l_pjbz.pjbz100 = 0
       END IF
       
       #IF  分摊成本(pjbz100)<=已分摊的金额sum(pjbz100) THEN
       #     CONTINUE FOREACH
       #END IF
       IF l_pjbz.pjbz100 <= l_pjbz100_sum THEN 
          CONTINUE FOREACH
       END IF
       
       LET l_pjbz.pjbzownid = g_user
       LET l_pjbz.pjbzowndp = g_dept
       LET l_pjbz.pjbzcrtid = g_user
       LET l_pjbz.pjbzcrtdp = g_dept 
       LET l_pjbz.pjbzcrtdt = cl_get_current()
       LET l_pjbz.pjbzmodid = ""
       LET l_pjbz.pjbzmoddt = ""
       
       #INSERT INTO pjbz_t VALUES(l_pjbz.*)  #161124-00048#16  2016/12/15 By 08734 mark
       INSERT INTO pjbz_t(pjbzent,pjbzcomp,pjbzld,pjbz001,pjbz002,pjbz003,pjbz004,pjbzseq,pjbz010,pjbz011,
                          pjbz012,pjbz013,pjbz014,pjbz015,pjbz016,pjbz017,pjbz018,pjbz019,pjbz020,pjbz021,
                          pjbz022,pjbz100,pjbzownid,pjbzowndp,pjbzcrtid,pjbzcrtdp,pjbzcrtdt,pjbzmodid,pjbzmoddt,pjbzstus)  #161124-00048#16  2016/12/15 By 08734 add
          VALUES(l_pjbz.pjbzent,l_pjbz.pjbzcomp,l_pjbz.pjbzld,l_pjbz.pjbz001,l_pjbz.pjbz002,l_pjbz.pjbz003,l_pjbz.pjbz004,l_pjbz.pjbzseq,l_pjbz.pjbz010,l_pjbz.pjbz011,
                 l_pjbz.pjbz012,l_pjbz.pjbz013,l_pjbz.pjbz014,l_pjbz.pjbz015,l_pjbz.pjbz016,l_pjbz.pjbz017,l_pjbz.pjbz018,l_pjbz.pjbz019,l_pjbz.pjbz020,l_pjbz.pjbz021,
                 l_pjbz.pjbz022,l_pjbz.pjbz100,l_pjbz.pjbzownid,l_pjbz.pjbzowndp,l_pjbz.pjbzcrtid,l_pjbz.pjbzcrtdp,l_pjbz.pjbzcrtdt,l_pjbz.pjbzmodid,l_pjbz.pjbzmoddt,l_pjbz.pjbzstus)
       
       IF SQLCA.SQLcode  THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "l_pjbz"
          LET g_errparam.popup = TRUE
          CALL cl_err()
  
          LET g_success = 'N'                        
       END IF
          
   END FOREACH 
   CALL cl_err_collect_show()   #140928  fengmy add
   IF g_success = 'N' THEN
      CALL s_transaction_end('N','1') 
   ELSE
      IF l_flag = 'N' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.code   = 'axc-00530' 
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')  
      ELSE
         CALL s_transaction_end('Y','1')
      END IF
   END IF
    
END FUNCTION

 
{</section>}
 
