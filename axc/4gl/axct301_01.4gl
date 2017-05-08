#該程式未解開Section, 採用最新樣板產出!
{<section id="axct301_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-04-14 00:00:00), PR版次:0004(2016-11-25 17:13:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000120
#+ Filename...: axct301_01
#+ Description: 整批導入
#+ Creator....: 02291(2014-04-14 14:00:01)
#+ Modifier...: 02291 -SD/PR- 08993
 
{</section>}
 
{<section id="axct301_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#11   2016/04/25 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#161109-00085#21   2016/11/17 By 08993       整批調整系統星號寫法
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
PRIVATE type type_g_xccb_m        RECORD
       xccbcomp LIKE xccb_t.xccbcomp, 
   xccbcomp_desc LIKE type_t.chr80, 
   xccbld LIKE xccb_t.xccbld, 
   xccbld_desc LIKE type_t.chr80, 
   format LIKE type_t.chr500, 
   mold LIKE type_t.chr2, 
   way LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xccb_m_t      type_g_xccb_m
DEFINE l_success       LIKE type_t.num5
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa019       LIKE glaa_t.glaa019
#end add-point
 
DEFINE g_xccb_m        type_g_xccb_m
 
   DEFINE g_xccbld_t LIKE xccb_t.xccbld
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axct301_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axct301_01(--)
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
   DEFINE l_excel         STRING 
   DEFINE ls_str          STRING
   DEFINE l_chr           LIKE type_t.chr1   
   DEFINE l_chr1          LIKE type_t.chr1   
   DEFINE l_num           LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axct301_01 WITH FORM cl_ap_formpath("axc","axct301_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_xccb_m.xccbcomp = ' '
   LET g_xccb_m.xccbld = '' 
   LET g_xccb_m.format = ''
   LET g_xccb_m.mold = ''
   LET g_xccb_m.way = ''
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xccb_m.xccbcomp,g_xccb_m.xccbld,g_xccb_m.format,g_xccb_m.mold,g_xccb_m.way ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            CALL cl_set_combo_scc('format','8915')
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccbcomp
            
            #add-point:AFTER FIELD xccbcomp name="input.a.xccbcomp"
            IF NOT cl_null(g_xccb_m.xccbcomp) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccb_m.xccbcomp
               #160318-00025#11--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#11--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist('v_ooef001_15') THEN
                  #檢查失敗時後續處理
                  LET g_xccb_m.xccbcomp = g_xccb_m_t.xccbcomp
                  CALL axct301_01_xccbcomp_desc() 
                  NEXT FIELD xccbcomp
               END IF
               IF NOT cl_null(g_xccb_m.xccbld) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM glaa_t 
                   WHERE glaaent = g_enterprise AND glaald = g_xccb_m.xccbld
                     AND glaacomp = g_xccb_m.xccbcomp
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00224'
                     LET g_errparam.extend = g_xccb_m_t.xccbcomp
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     CALL axct301_01_xccbcomp_desc() 
                     NEXT FIELD xccbld
                  END IF
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_xccb_m.xccbcomp
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_xccb_m.xccbcomp_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_xccb_m.xccbcomp_desc
               
               
                                                    
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccbcomp
            #add-point:BEFORE FIELD xccbcomp name="input.b.xccbcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccbcomp
            #add-point:ON CHANGE xccbcomp name="input.g.xccbcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccbld
            
            #add-point:AFTER FIELD xccbld name="input.a.xccbld"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccb_m.xccbld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccb_m.xccbld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccb_m.xccbld_desc

            IF NOT cl_null(g_xccb_m.xccbld) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccb_m.xccbld
               #160318-00025#11--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#11--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist('v_glaald') THEN
                  #檢查失敗時後續處理
                  LET g_xccb_m.xccbld = g_xccb_m_t.xccbld
                  CALL axct301_01_xccbld_desc()
                  NEXT FIELD xccbld
               END IF
               
               IF NOT cl_null(g_xccb_m.xccbcomp) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM glaa_t 
                   WHERE glaaent = g_enterprise AND glaacomp = g_xccb_m.xccbcomp
                     AND glaald = g_xccb_m.xccbld
                  IF l_n = 0 THEN
                     CALL axct301_01_xccbld_desc()
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00225'
                     LET g_errparam.extend = g_xccb_m.xccbld
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD xccbld
                  END IF
               END IF
               
               IF NOT s_ld_chk_authorization(g_user,g_xccb_m.xccbld) THEN
                  CALL axct301_01_xccbld_desc()
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00165'
                  LET g_errparam.extend = g_xccb_m.xccbcomp
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD xccbcomp
               END IF
               CALL axct301_01_xccbld_desc()                               
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccbld
            #add-point:BEFORE FIELD xccbld name="input.b.xccbld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccbld
            #add-point:ON CHANGE xccbld name="input.g.xccbld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD format
            #add-point:BEFORE FIELD format name="input.b.format"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD format
            
            #add-point:AFTER FIELD format name="input.a.format"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE format
            #add-point:ON CHANGE format name="input.g.format"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mold
            #add-point:BEFORE FIELD mold name="input.b.mold"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mold
            
            #add-point:AFTER FIELD mold name="input.a.mold"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mold
            #add-point:ON CHANGE mold name="input.g.mold"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD way
            #add-point:BEFORE FIELD way name="input.b.way"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD way
            
            #add-point:AFTER FIELD way name="input.a.way"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE way
            #add-point:ON CHANGE way name="input.g.way"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xccbcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccbcomp
            #add-point:ON ACTION controlp INFIELD xccbcomp name="input.c.xccbcomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccb_m.xccbcomp             #給予default值
            LET g_qryparam.default2 = "" #g_xccb_m.ooefl003 #說明(簡稱)
            #給予arg
           #LET g_qryparam.arg1 = "" #
           IF NOT cl_null(g_xccb_m.xccbld) THEN
              LET g_qryparam.where = "ooef003 = 'Y' AND ooef017 = (SELECT glaacomp FROM glaa_t",
                      "  WHERE glaaent = '",g_enterprise,"' AND glaald = '",g_xccb_m.xccbld,"' )"
            END IF

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_xccb_m.xccbcomp = g_qryparam.return1              
            #LET g_xccb_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_xccb_m.xccbcomp TO xccbcomp              #
            #DISPLAY g_xccb_m.ooefl003 TO ooefl003 #說明(簡稱)
            LET g_qryparam.where = NULL
            NEXT FIELD xccbcomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xccbld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccbld
            #add-point:ON ACTION controlp INFIELD xccbld name="input.c.xccbld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccb_m.xccbld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            IF NOT cl_null(g_xccb_m.xccbcomp) THEN
               LET g_qryparam.where = " glaacomp = '",g_xccb_m.xccbcomp,"'"
            END IF
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xccb_m.xccbld = g_qryparam.return1              

            DISPLAY g_xccb_m.xccbld TO xccbld              #
            LET g_qryparam.where = NULL

            NEXT FIELD xccbld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.format
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD format
            #add-point:ON ACTION controlp INFIELD format name="input.c.format"
            
            #END add-point
 
 
         #Ctrlp:input.c.mold
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mold
            #add-point:ON ACTION controlp INFIELD mold name="input.c.mold"
            
            #END add-point
 
 
         #Ctrlp:input.c.way
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD way
            #add-point:ON ACTION controlp INFIELD way name="input.c.way"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      ON ACTION browser
         CALL cl_client_browse_file() RETURNING g_xccb_m.way
         LET ls_str = g_xccb_m.way
         #抓取目录斜杆
         LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
         LET l_chr = ls_str.substring(l_num+1,l_num+1)                        #截取冒号后的字符 
         LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())    #判断是否为根目录
#         IF l_chr <> l_chr1  THEN         
#            LET g_xccb_m.way = g_xccb_m.way||l_chr
#         ELSE
            LET g_xccb_m.way = g_xccb_m.way
#         END IF 
         DISPLAY BY NAME g_xccb_m.way
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
   CLOSE WINDOW w_axct301_01 
   
   #add-point:input段after input name="input.post_input"
   CALL axct301_01_ins_excel(g_xccb_m.way) RETURNING l_success
   RETURN l_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axct301_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axct301_01.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axct301_01_xccbcomp_desc()
   SELECT ooefl003 INTO g_xccb_m.xccbcomp_desc FROM ooefl_t 
    WHERE ooeflent=g_enterprise AND ooefl001=g_xccb_m.xccbcomp AND ooefl002=g_dlang

   DISPLAY BY NAME g_xccb_m.xccbcomp_desc
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
PRIVATE FUNCTION axct301_01_ins_excel(p_excelname)
DEFINE p_excelname LIKE type_t.chr1000  #excel档名
DEFINE r_success   LIKE type_t.num5
DEFINE l_excelname STRING               #excel档名
DEFINE l_count     LIKE type_t.num10
DEFINE li_i        LIKE type_t.num10
DEFINE li_j        LIKE type_t.num10
DEFINE xlapp,iRes,iRow    LIKE type_t.num5
#161109-00085#21-s mod
#DEFINE l_xccb      RECORD LIKE xccb_t.*   #161109-00085#21-s mark
DEFINE l_xccb      RECORD  #期初在製數量成本開帳檔
       xccbent LIKE xccb_t.xccbent, #企業編號
       xccbld LIKE xccb_t.xccbld, #帳套
       xccbcomp LIKE xccb_t.xccbcomp, #法人組織
       xccb001 LIKE xccb_t.xccb001, #帳套本位幣順序
       xccb002 LIKE xccb_t.xccb002, #成本域
       xccb003 LIKE xccb_t.xccb003, #成本計算類型
       xccb004 LIKE xccb_t.xccb004, #年度
       xccb005 LIKE xccb_t.xccb005, #期別
       xccb006 LIKE xccb_t.xccb006, #工單編號
       xccb007 LIKE xccb_t.xccb007, #元件編號
       xccb008 LIKE xccb_t.xccb008, #特性
       xccb009 LIKE xccb_t.xccb009, #批號
       xccb010 LIKE xccb_t.xccb010, #元件類型
       xccb101 LIKE xccb_t.xccb101, #當月期末數量
       xccb102 LIKE xccb_t.xccb102, #當月期末金額-金額合計
       xccb102a LIKE xccb_t.xccb102a, #當月期末金額-材料
       xccb102b LIKE xccb_t.xccb102b, #當月期末金額-人工
       xccb102c LIKE xccb_t.xccb102c, #當月期末金額-委外加工
       xccb102d LIKE xccb_t.xccb102d, #當月期末金額-制費一
       xccb102e LIKE xccb_t.xccb102e, #當月期末金額-制費二
       xccb102f LIKE xccb_t.xccb102f, #當月期末金額-制費三
       xccb102g LIKE xccb_t.xccb102g, #當月期末金額-制費四
       xccb102h LIKE xccb_t.xccb102h, #當月期末金額-制費五
       xccbownid LIKE xccb_t.xccbownid, #資料所有者
       xccbowndp LIKE xccb_t.xccbowndp, #資料所屬部門
       xccbcrtid LIKE xccb_t.xccbcrtid, #資料建立者
       xccbcrtdp LIKE xccb_t.xccbcrtdp, #資料建立部門
       xccbcrtdt LIKE xccb_t.xccbcrtdt, #資料創建日
       xccbmodid LIKE xccb_t.xccbmodid, #資料修改者
       xccbmoddt LIKE xccb_t.xccbmoddt, #最近修改日
       xccbcnfid LIKE xccb_t.xccbcnfid, #資料確認者
       xccbcnfdt LIKE xccb_t.xccbcnfdt, #資料確認日
       xccbpstid LIKE xccb_t.xccbpstid, #資料過帳者
       xccbpstdt LIKE xccb_t.xccbpstdt, #資料過帳日
       xccbstus LIKE xccb_t.xccbstus, #狀態碼
       xccbud001 LIKE xccb_t.xccbud001, #自定義欄位(文字)001
       xccbud002 LIKE xccb_t.xccbud002, #自定義欄位(文字)002
       xccbud003 LIKE xccb_t.xccbud003, #自定義欄位(文字)003
       xccbud004 LIKE xccb_t.xccbud004, #自定義欄位(文字)004
       xccbud005 LIKE xccb_t.xccbud005, #自定義欄位(文字)005
       xccbud006 LIKE xccb_t.xccbud006, #自定義欄位(文字)006
       xccbud007 LIKE xccb_t.xccbud007, #自定義欄位(文字)007
       xccbud008 LIKE xccb_t.xccbud008, #自定義欄位(文字)008
       xccbud009 LIKE xccb_t.xccbud009, #自定義欄位(文字)009
       xccbud010 LIKE xccb_t.xccbud010, #自定義欄位(文字)010
       xccbud011 LIKE xccb_t.xccbud011, #自定義欄位(數字)011
       xccbud012 LIKE xccb_t.xccbud012, #自定義欄位(數字)012
       xccbud013 LIKE xccb_t.xccbud013, #自定義欄位(數字)013
       xccbud014 LIKE xccb_t.xccbud014, #自定義欄位(數字)014
       xccbud015 LIKE xccb_t.xccbud015, #自定義欄位(數字)015
       xccbud016 LIKE xccb_t.xccbud016, #自定義欄位(數字)016
       xccbud017 LIKE xccb_t.xccbud017, #自定義欄位(數字)017
       xccbud018 LIKE xccb_t.xccbud018, #自定義欄位(數字)018
       xccbud019 LIKE xccb_t.xccbud019, #自定義欄位(數字)019
       xccbud020 LIKE xccb_t.xccbud020, #自定義欄位(數字)020
       xccbud021 LIKE xccb_t.xccbud021, #自定義欄位(日期時間)021
       xccbud022 LIKE xccb_t.xccbud022, #自定義欄位(日期時間)022
       xccbud023 LIKE xccb_t.xccbud023, #自定義欄位(日期時間)023
       xccbud024 LIKE xccb_t.xccbud024, #自定義欄位(日期時間)024
       xccbud025 LIKE xccb_t.xccbud025, #自定義欄位(日期時間)025
       xccbud026 LIKE xccb_t.xccbud026, #自定義欄位(日期時間)026
       xccbud027 LIKE xccb_t.xccbud027, #自定義欄位(日期時間)027
       xccbud028 LIKE xccb_t.xccbud028, #自定義欄位(日期時間)028
       xccbud029 LIKE xccb_t.xccbud029, #自定義欄位(日期時間)029
       xccbud030 LIKE xccb_t.xccbud030  #自定義欄位(日期時間)030
                 END RECORD
#161109-00085#21-e mod
#161109-00085#21-s mod
#DEFINE l_xccb1      RECORD LIKE xccb_t.*   #161109-00085#21-s mark
DEFINE l_xccb1      RECORD  #期初在製數量成本開帳檔
       xccbent LIKE xccb_t.xccbent, #企業編號
       xccbld LIKE xccb_t.xccbld, #帳套
       xccbcomp LIKE xccb_t.xccbcomp, #法人組織
       xccb001 LIKE xccb_t.xccb001, #帳套本位幣順序
       xccb002 LIKE xccb_t.xccb002, #成本域
       xccb003 LIKE xccb_t.xccb003, #成本計算類型
       xccb004 LIKE xccb_t.xccb004, #年度
       xccb005 LIKE xccb_t.xccb005, #期別
       xccb006 LIKE xccb_t.xccb006, #工單編號
       xccb007 LIKE xccb_t.xccb007, #元件編號
       xccb008 LIKE xccb_t.xccb008, #特性
       xccb009 LIKE xccb_t.xccb009, #批號
       xccb010 LIKE xccb_t.xccb010, #元件類型
       xccb101 LIKE xccb_t.xccb101, #當月期末數量
       xccb102 LIKE xccb_t.xccb102, #當月期末金額-金額合計
       xccb102a LIKE xccb_t.xccb102a, #當月期末金額-材料
       xccb102b LIKE xccb_t.xccb102b, #當月期末金額-人工
       xccb102c LIKE xccb_t.xccb102c, #當月期末金額-委外加工
       xccb102d LIKE xccb_t.xccb102d, #當月期末金額-制費一
       xccb102e LIKE xccb_t.xccb102e, #當月期末金額-制費二
       xccb102f LIKE xccb_t.xccb102f, #當月期末金額-制費三
       xccb102g LIKE xccb_t.xccb102g, #當月期末金額-制費四
       xccb102h LIKE xccb_t.xccb102h, #當月期末金額-制費五
       xccbownid LIKE xccb_t.xccbownid, #資料所有者
       xccbowndp LIKE xccb_t.xccbowndp, #資料所屬部門
       xccbcrtid LIKE xccb_t.xccbcrtid, #資料建立者
       xccbcrtdp LIKE xccb_t.xccbcrtdp, #資料建立部門
       xccbcrtdt LIKE xccb_t.xccbcrtdt, #資料創建日
       xccbmodid LIKE xccb_t.xccbmodid, #資料修改者
       xccbmoddt LIKE xccb_t.xccbmoddt, #最近修改日
       xccbcnfid LIKE xccb_t.xccbcnfid, #資料確認者
       xccbcnfdt LIKE xccb_t.xccbcnfdt, #資料確認日
       xccbpstid LIKE xccb_t.xccbpstid, #資料過帳者
       xccbpstdt LIKE xccb_t.xccbpstdt, #資料過帳日
       xccbstus LIKE xccb_t.xccbstus, #狀態碼
       xccbud001 LIKE xccb_t.xccbud001, #自定義欄位(文字)001
       xccbud002 LIKE xccb_t.xccbud002, #自定義欄位(文字)002
       xccbud003 LIKE xccb_t.xccbud003, #自定義欄位(文字)003
       xccbud004 LIKE xccb_t.xccbud004, #自定義欄位(文字)004
       xccbud005 LIKE xccb_t.xccbud005, #自定義欄位(文字)005
       xccbud006 LIKE xccb_t.xccbud006, #自定義欄位(文字)006
       xccbud007 LIKE xccb_t.xccbud007, #自定義欄位(文字)007
       xccbud008 LIKE xccb_t.xccbud008, #自定義欄位(文字)008
       xccbud009 LIKE xccb_t.xccbud009, #自定義欄位(文字)009
       xccbud010 LIKE xccb_t.xccbud010, #自定義欄位(文字)010
       xccbud011 LIKE xccb_t.xccbud011, #自定義欄位(數字)011
       xccbud012 LIKE xccb_t.xccbud012, #自定義欄位(數字)012
       xccbud013 LIKE xccb_t.xccbud013, #自定義欄位(數字)013
       xccbud014 LIKE xccb_t.xccbud014, #自定義欄位(數字)014
       xccbud015 LIKE xccb_t.xccbud015, #自定義欄位(數字)015
       xccbud016 LIKE xccb_t.xccbud016, #自定義欄位(數字)016
       xccbud017 LIKE xccb_t.xccbud017, #自定義欄位(數字)017
       xccbud018 LIKE xccb_t.xccbud018, #自定義欄位(數字)018
       xccbud019 LIKE xccb_t.xccbud019, #自定義欄位(數字)019
       xccbud020 LIKE xccb_t.xccbud020, #自定義欄位(數字)020
       xccbud021 LIKE xccb_t.xccbud021, #自定義欄位(日期時間)021
       xccbud022 LIKE xccb_t.xccbud022, #自定義欄位(日期時間)022
       xccbud023 LIKE xccb_t.xccbud023, #自定義欄位(日期時間)023
       xccbud024 LIKE xccb_t.xccbud024, #自定義欄位(日期時間)024
       xccbud025 LIKE xccb_t.xccbud025, #自定義欄位(日期時間)025
       xccbud026 LIKE xccb_t.xccbud026, #自定義欄位(日期時間)026
       xccbud027 LIKE xccb_t.xccbud027, #自定義欄位(日期時間)027
       xccbud028 LIKE xccb_t.xccbud028, #自定義欄位(日期時間)028
       xccbud029 LIKE xccb_t.xccbud029, #自定義欄位(日期時間)029
       xccbud030 LIKE xccb_t.xccbud030  #自定義欄位(日期時間)030
                 END RECORD
#161109-00085#21-e mod
#161109-00085#21-s mod
#DEFINE l_xccb2      RECORD LIKE xccb_t.*   #161109-00085#21-s mark
DEFINE l_xccb2      RECORD  #期初在製數量成本開帳檔
       xccbent LIKE xccb_t.xccbent, #企業編號
       xccbld LIKE xccb_t.xccbld, #帳套
       xccbcomp LIKE xccb_t.xccbcomp, #法人組織
       xccb001 LIKE xccb_t.xccb001, #帳套本位幣順序
       xccb002 LIKE xccb_t.xccb002, #成本域
       xccb003 LIKE xccb_t.xccb003, #成本計算類型
       xccb004 LIKE xccb_t.xccb004, #年度
       xccb005 LIKE xccb_t.xccb005, #期別
       xccb006 LIKE xccb_t.xccb006, #工單編號
       xccb007 LIKE xccb_t.xccb007, #元件編號
       xccb008 LIKE xccb_t.xccb008, #特性
       xccb009 LIKE xccb_t.xccb009, #批號
       xccb010 LIKE xccb_t.xccb010, #元件類型
       xccb101 LIKE xccb_t.xccb101, #當月期末數量
       xccb102 LIKE xccb_t.xccb102, #當月期末金額-金額合計
       xccb102a LIKE xccb_t.xccb102a, #當月期末金額-材料
       xccb102b LIKE xccb_t.xccb102b, #當月期末金額-人工
       xccb102c LIKE xccb_t.xccb102c, #當月期末金額-委外加工
       xccb102d LIKE xccb_t.xccb102d, #當月期末金額-制費一
       xccb102e LIKE xccb_t.xccb102e, #當月期末金額-制費二
       xccb102f LIKE xccb_t.xccb102f, #當月期末金額-制費三
       xccb102g LIKE xccb_t.xccb102g, #當月期末金額-制費四
       xccb102h LIKE xccb_t.xccb102h, #當月期末金額-制費五
       xccbownid LIKE xccb_t.xccbownid, #資料所有者
       xccbowndp LIKE xccb_t.xccbowndp, #資料所屬部門
       xccbcrtid LIKE xccb_t.xccbcrtid, #資料建立者
       xccbcrtdp LIKE xccb_t.xccbcrtdp, #資料建立部門
       xccbcrtdt LIKE xccb_t.xccbcrtdt, #資料創建日
       xccbmodid LIKE xccb_t.xccbmodid, #資料修改者
       xccbmoddt LIKE xccb_t.xccbmoddt, #最近修改日
       xccbcnfid LIKE xccb_t.xccbcnfid, #資料確認者
       xccbcnfdt LIKE xccb_t.xccbcnfdt, #資料確認日
       xccbpstid LIKE xccb_t.xccbpstid, #資料過帳者
       xccbpstdt LIKE xccb_t.xccbpstdt, #資料過帳日
       xccbstus LIKE xccb_t.xccbstus, #狀態碼
       xccbud001 LIKE xccb_t.xccbud001, #自定義欄位(文字)001
       xccbud002 LIKE xccb_t.xccbud002, #自定義欄位(文字)002
       xccbud003 LIKE xccb_t.xccbud003, #自定義欄位(文字)003
       xccbud004 LIKE xccb_t.xccbud004, #自定義欄位(文字)004
       xccbud005 LIKE xccb_t.xccbud005, #自定義欄位(文字)005
       xccbud006 LIKE xccb_t.xccbud006, #自定義欄位(文字)006
       xccbud007 LIKE xccb_t.xccbud007, #自定義欄位(文字)007
       xccbud008 LIKE xccb_t.xccbud008, #自定義欄位(文字)008
       xccbud009 LIKE xccb_t.xccbud009, #自定義欄位(文字)009
       xccbud010 LIKE xccb_t.xccbud010, #自定義欄位(文字)010
       xccbud011 LIKE xccb_t.xccbud011, #自定義欄位(數字)011
       xccbud012 LIKE xccb_t.xccbud012, #自定義欄位(數字)012
       xccbud013 LIKE xccb_t.xccbud013, #自定義欄位(數字)013
       xccbud014 LIKE xccb_t.xccbud014, #自定義欄位(數字)014
       xccbud015 LIKE xccb_t.xccbud015, #自定義欄位(數字)015
       xccbud016 LIKE xccb_t.xccbud016, #自定義欄位(數字)016
       xccbud017 LIKE xccb_t.xccbud017, #自定義欄位(數字)017
       xccbud018 LIKE xccb_t.xccbud018, #自定義欄位(數字)018
       xccbud019 LIKE xccb_t.xccbud019, #自定義欄位(數字)019
       xccbud020 LIKE xccb_t.xccbud020, #自定義欄位(數字)020
       xccbud021 LIKE xccb_t.xccbud021, #自定義欄位(日期時間)021
       xccbud022 LIKE xccb_t.xccbud022, #自定義欄位(日期時間)022
       xccbud023 LIKE xccb_t.xccbud023, #自定義欄位(日期時間)023
       xccbud024 LIKE xccb_t.xccbud024, #自定義欄位(日期時間)024
       xccbud025 LIKE xccb_t.xccbud025, #自定義欄位(日期時間)025
       xccbud026 LIKE xccb_t.xccbud026, #自定義欄位(日期時間)026
       xccbud027 LIKE xccb_t.xccbud027, #自定義欄位(日期時間)027
       xccbud028 LIKE xccb_t.xccbud028, #自定義欄位(日期時間)028
       xccbud029 LIKE xccb_t.xccbud029, #自定義欄位(日期時間)029
       xccbud030 LIKE xccb_t.xccbud030  #自定義欄位(日期時間)030
                 END RECORD
#161109-00085#21-e mod
DEFINE l_today     LIKE type_t.dat       #zll g_today 没有了
DEFINE l_n         LIKE type_t.num5
DEFINE l_xccbstus  LIKE xccb_t.xccbstus
DEFINE l_xccbcrtdt    DATETIME YEAR TO SECOND

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   LET l_today= cl_get_current()
   LET l_count = LENGTH(p_excelname CLIPPED)
   #转换路径分隔符
   FOR li_i = 1 TO l_count
       IF p_excelname[li_i,li_i] ="/" THEN
          LET l_excelname = l_excelname CLIPPED,'\\'
       ELSE
          LET l_excelname = l_excelname CLIPPED,p_excelname[li_i,li_i]
       END IF
   END FOR

   CALL ui.interface.frontCall('WinCOM','CreateInstance',
                               ['Excel.Application'],[xlApp])
   IF xlApp <> -1 THEN
      CALL ui.interface.frontCall('WinCOM','CallMethod',
                                  [xlApp,'WorkBooks.Open',l_excelname],[iRes])
      IF iRes <> -1 THEN
         CALL ui.interface.frontCall('WinCOM','GetProperty',
              [xlApp,'ActiveSheet.UsedRange.Rows.Count'],[iRow])
         IF iRow > 1 THEN
            FOR li_i = 2 TO iRow
                INITIALIZE l_xccb.* TO NULL
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',1).Value'],[l_xccb.xccbent])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',2).Value'],[l_xccb.xccbld])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',3).Value'],[l_xccb.xccbcomp])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',4).Value'],[l_xccb.xccb001])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',5).Value'],[l_xccb.xccb002])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',6).Value'],[l_xccb.xccb003])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',7).Value'],[l_xccb.xccb004])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',8).Value'],[l_xccb.xccb005])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',9).Value'],[l_xccb.xccb006])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',10).Value'],[l_xccb.xccb007])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',11).Value'],[l_xccb.xccb008])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',12).Value'],[l_xccb.xccb009])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',13).Value'],[l_xccb.xccb010])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',14).Value'],[l_xccb.xccb101])
#                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',15).Value'],[l_xccb.xccb102])  #fengmy150120 mark
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',15).Value'],[l_xccb.xccb102a])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',16).Value'],[l_xccb.xccb102b])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',17).Value'],[l_xccb.xccb102c])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',18).Value'],[l_xccb.xccb102d])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',19).Value'],[l_xccb.xccb102e])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',20).Value'],[l_xccb.xccb102f])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',21).Value'],[l_xccb.xccb102g])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',22).Value'],[l_xccb.xccb102h])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',23).Value'],[l_xccb.xccb102])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',24).Value'],[l_xccb1.xccb102a])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',25).Value'],[l_xccb1.xccb102b])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',26).Value'],[l_xccb1.xccb102c])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',27).Value'],[l_xccb1.xccb102d])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',28).Value'],[l_xccb1.xccb102e])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',29).Value'],[l_xccb1.xccb102f])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',30).Value'],[l_xccb1.xccb102g])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',31).Value'],[l_xccb1.xccb102h])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',32).Value'],[l_xccb1.xccb102])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',33).Value'],[l_xccb2.xccb102a])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',34).Value'],[l_xccb2.xccb102b])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',35).Value'],[l_xccb2.xccb102c])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',36).Value'],[l_xccb2.xccb102d])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',37).Value'],[l_xccb2.xccb102e])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',38).Value'],[l_xccb2.xccb102f])
#                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',38).Value'],[l_xccb2.xccb102g])   #fengmy150121 mark
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',39).Value'],[l_xccb2.xccb102g])   #fengmy150121 
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',40).Value'],[l_xccb2.xccb102h])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',41).Value'],[l_xccb2.xccb102])
                                                                                                        
                #如果excel中存在不在畫面上的法人或者帳套CONTINUE
                IF l_xccb.xccbld != g_xccb_m.xccbld OR l_xccb.xccbcomp != g_xccb_m.xccbcomp THEN
                  #fengmy150122---begin
                  #CONTINUE FOR
                  #匯出畫面中帳套不一致的，提示檢核訊息，不予新增
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'axc-00514'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   LET r_success = FALSE
                   EXIT FOR
                   #fengmy150122---end
                END IF
                #fengmy150120--begin
                IF cl_null(l_xccb.xccb002) THEN LET l_xccb.xccb002 = ' ' END IF
                IF cl_null(l_xccb.xccb008) THEN LET l_xccb.xccb008 = ' ' END IF
                IF cl_null(l_xccb.xccb009) THEN LET l_xccb.xccb009 = ' ' END IF
                #fengmy150120--end                
                #赋默认值
                LET l_xccb1.xccbent = l_xccb.xccbent
                LET l_xccb1.xccbld =  l_xccb.xccbld
                LET l_xccb1.xccbcomp =l_xccb.xccbcomp
                LET l_xccb1.xccb002 = l_xccb.xccb002
                LET l_xccb1.xccb003 = l_xccb.xccb003
                LET l_xccb1.xccb004 = l_xccb.xccb004
                LET l_xccb1.xccb005 = l_xccb.xccb005
                LET l_xccb1.xccb006 = l_xccb.xccb006
                LET l_xccb1.xccb007 = l_xccb.xccb007
                LET l_xccb1.xccb008 = l_xccb.xccb008
                LET l_xccb1.xccb009 = l_xccb.xccb009
                LET l_xccb1.xccb010 = l_xccb.xccb010
                LET l_xccb1.xccb101 = l_xccb.xccb101
                LET l_xccb2.xccbent = l_xccb.xccbent
                LET l_xccb2.xccbld =  l_xccb.xccbld
                LET l_xccb2.xccbcomp =l_xccb.xccbcomp
                LET l_xccb2.xccb002 = l_xccb.xccb002
                LET l_xccb2.xccb003 = l_xccb.xccb003
                LET l_xccb2.xccb004 = l_xccb.xccb004
                LET l_xccb2.xccb005 = l_xccb.xccb005
                LET l_xccb2.xccb006 = l_xccb.xccb006
                LET l_xccb2.xccb007 = l_xccb.xccb007
                LET l_xccb2.xccb008 = l_xccb.xccb008
                LET l_xccb2.xccb009 = l_xccb.xccb009
                LET l_xccb2.xccb010 = l_xccb.xccb010
                LET l_xccb2.xccb101 = l_xccb.xccb101
                LET l_xccb.xccbownid = g_user
                LET l_xccb.xccbowndp = g_dept
                LET l_xccb.xccbcrtid = g_user
                LET l_xccb.xccbcrtdp = g_dept 
                LET l_xccbcrtdt = cl_get_current()
                LET l_xccb.xccbmodid = ""
                LET l_xccb.xccbmoddt = ""
                LET l_xccb.xccbcnfid = ""
                LET l_xccb.xccbcnfdt = "" 
                LET l_xccb.xccbpstid = ""
                LET l_xccb.xccbpstdt = "" 
                LET l_xccb.xccbpstdt = ""
                LET l_xccb1.xccb001 = '2'
                LET l_xccb1.xccbownid = g_user
                LET l_xccb1.xccbowndp = g_dept
                LET l_xccb1.xccbcrtid = g_user
                LET l_xccb1.xccbcrtdp = g_dept 
                LET l_xccb1.xccbmodid = ""
                LET l_xccb1.xccbmoddt = ""
                LET l_xccb1.xccbcnfid = ""
                LET l_xccb1.xccbcnfdt = "" 
                LET l_xccb1.xccbpstid = ""
                LET l_xccb1.xccbpstdt = "" 
                LET l_xccb1.xccbpstdt = ""
                LET l_xccb2.xccb001 = '3'
                LET l_xccb2.xccbownid = g_user
                LET l_xccb2.xccbowndp = g_dept
                LET l_xccb2.xccbcrtid = g_user
                LET l_xccb2.xccbcrtdp = g_dept 
                LET l_xccb2.xccbmodid = ""
                LET l_xccb2.xccbmoddt = ""
                LET l_xccb2.xccbcnfid = ""
                LET l_xccb2.xccbcnfdt = "" 
                LET l_xccb2.xccbpstid = ""
                LET l_xccb2.xccbpstdt = "" 
                LET l_xccb2.xccbpstdt = ""

                   
                   #161109-00085#21-s mod
#                   INSERT INTO xccb_t VALUES l_xccb.*   #161109-00085#21-s mark
                   INSERT INTO xccb_t (xccbent,xccbld,xccbcomp,xccb001,xccb002,xccb003,xccb004,xccb005,xccb006,xccb007,
                                       xccb008,xccb009,xccb010,xccb101,xccb102,xccb102a,xccb102b,xccb102c,xccb102d,xccb102e,
                                       xccb102f,xccb102g,xccb102h,xccbownid,xccbowndp,xccbcrtid,xccbcrtdp,xccbcrtdt,xccbmodid,xccbmoddt,
                                       xccbcnfid,xccbcnfdt,xccbpstid,xccbpstdt,xccbstus,xccbud001,xccbud002,xccbud003,xccbud004,xccbud005,
                                       xccbud006,xccbud007,xccbud008,xccbud009,xccbud010,xccbud011,xccbud012,xccbud013,xccbud014,xccbud015,
                                       xccbud016,xccbud017,xccbud018,xccbud019,xccbud020,xccbud021,xccbud022,xccbud023,xccbud024,xccbud025,
                                       xccbud026,xccbud027,xccbud028,xccbud029,xccbud030) 
                               VALUES (l_xccb.xccbent,l_xccb.xccbld,l_xccb.xccbcomp,l_xccb.xccb001,l_xccb.xccb002,
                                       l_xccb.xccb003,l_xccb.xccb004,l_xccb.xccb005,l_xccb.xccb006,l_xccb.xccb007,
                                       l_xccb.xccb008,l_xccb.xccb009,l_xccb.xccb010,l_xccb.xccb101,l_xccb.xccb102,
                                       l_xccb.xccb102a,l_xccb.xccb102b,l_xccb.xccb102c,l_xccb.xccb102d,l_xccb.xccb102e,
                                       l_xccb.xccb102f,l_xccb.xccb102g,l_xccb.xccb102h,l_xccb.xccbownid,l_xccb.xccbowndp,
                                       l_xccb.xccbcrtid,l_xccb.xccbcrtdp,l_xccb.xccbcrtdt,l_xccb.xccbmodid,l_xccb.xccbmoddt,
                                       l_xccb.xccbcnfid,l_xccb.xccbcnfdt,l_xccb.xccbpstid,l_xccb.xccbpstdt,l_xccb.xccbstus,
                                       l_xccb.xccbud001,l_xccb.xccbud002,l_xccb.xccbud003,l_xccb.xccbud004,l_xccb.xccbud005,
                                       l_xccb.xccbud006,l_xccb.xccbud007,l_xccb.xccbud008,l_xccb.xccbud009,l_xccb.xccbud010,
                                       l_xccb.xccbud011,l_xccb.xccbud012,l_xccb.xccbud013,l_xccb.xccbud014,l_xccb.xccbud015,
                                       l_xccb.xccbud016,l_xccb.xccbud017,l_xccb.xccbud018,l_xccb.xccbud019,l_xccb.xccbud020,
                                       l_xccb.xccbud021,l_xccb.xccbud022,l_xccb.xccbud023,l_xccb.xccbud024,l_xccb.xccbud025,
                                       l_xccb.xccbud026,l_xccb.xccbud027,l_xccb.xccbud028,l_xccb.xccbud029,l_xccb.xccbud030)
                   #161109-00085#21-e mod
                   IF g_glaa015 = 'Y' THEN
                      #161109-00085#21-s mod
#                      INSERT INTO xccb_t VALUES l_xccb1.*   #161109-00085#21-s mark
                      INSERT INTO xccb_t (xccbent,xccbld,xccbcomp,xccb001,xccb002,xccb003,xccb004,xccb005,xccb006,xccb007,
                                          xccb008,xccb009,xccb010,xccb101,xccb102,xccb102a,xccb102b,xccb102c,xccb102d,xccb102e,
                                          xccb102f,xccb102g,xccb102h,xccbownid,xccbowndp,xccbcrtid,xccbcrtdp,xccbcrtdt,xccbmodid,xccbmoddt,
                                          xccbcnfid,xccbcnfdt,xccbpstid,xccbpstdt,xccbstus,xccbud001,xccbud002,xccbud003,xccbud004,xccbud005,
                                          xccbud006,xccbud007,xccbud008,xccbud009,xccbud010,xccbud011,xccbud012,xccbud013,xccbud014,xccbud015,
                                          xccbud016,xccbud017,xccbud018,xccbud019,xccbud020,xccbud021,xccbud022,xccbud023,xccbud024,xccbud025,
                                          xccbud026,xccbud027,xccbud028,xccbud029,xccbud030) 
                                  VALUES (l_xccb1.xccbent,l_xccb1.xccbld,l_xccb1.xccbcomp,l_xccb1.xccb001,l_xccb1.xccb002,
                                          l_xccb1.xccb003,l_xccb1.xccb004,l_xccb1.xccb005,l_xccb1.xccb006,l_xccb1.xccb007,
                                          l_xccb1.xccb008,l_xccb1.xccb009,l_xccb1.xccb010,l_xccb1.xccb101,l_xccb1.xccb102,
                                          l_xccb1.xccb102a,l_xccb1.xccb102b,l_xccb1.xccb102c,l_xccb1.xccb102d,l_xccb1.xccb102e,
                                          l_xccb1.xccb102f,l_xccb1.xccb102g,l_xccb1.xccb102h,l_xccb1.xccbownid,l_xccb1.xccbowndp,
                                          l_xccb1.xccbcrtid,l_xccb1.xccbcrtdp,l_xccb1.xccbcrtdt,l_xccb1.xccbmodid,l_xccb1.xccbmoddt,
                                          l_xccb1.xccbcnfid,l_xccb1.xccbcnfdt,l_xccb1.xccbpstid,l_xccb1.xccbpstdt,l_xccb1.xccbstus,
                                          l_xccb1.xccbud001,l_xccb1.xccbud002,l_xccb1.xccbud003,l_xccb1.xccbud004,l_xccb1.xccbud005,
                                          l_xccb1.xccbud006,l_xccb1.xccbud007,l_xccb1.xccbud008,l_xccb1.xccbud009,l_xccb1.xccbud010,
                                          l_xccb1.xccbud011,l_xccb1.xccbud012,l_xccb1.xccbud013,l_xccb1.xccbud014,l_xccb1.xccbud015,
                                          l_xccb1.xccbud016,l_xccb1.xccbud017,l_xccb1.xccbud018,l_xccb1.xccbud019,l_xccb1.xccbud020,
                                          l_xccb1.xccbud021,l_xccb1.xccbud022,l_xccb1.xccbud023,l_xccb1.xccbud024,l_xccb1.xccbud025,
                                          l_xccb1.xccbud026,l_xccb1.xccbud027,l_xccb1.xccbud028,l_xccb1.xccbud029,l_xccb1.xccbud030)
                      #161109-00085#21-e mod
                   END IF
                   IF g_glaa019 = 'Y' THEN
                      #161109-00085#21-s mod
#                      INSERT INTO xccb_t VALUES l_xccb2.*   #161109-00085#21-s mark
                      INSERT INTO xccb_t (xccbent,xccbld,xccbcomp,xccb001,xccb002,xccb003,xccb004,xccb005,xccb006,xccb007,
                                          xccb008,xccb009,xccb010,xccb101,xccb102,xccb102a,xccb102b,xccb102c,xccb102d,xccb102e,
                                          xccb102f,xccb102g,xccb102h,xccbownid,xccbowndp,xccbcrtid,xccbcrtdp,xccbcrtdt,xccbmodid,xccbmoddt,
                                          xccbcnfid,xccbcnfdt,xccbpstid,xccbpstdt,xccbstus,xccbud001,xccbud002,xccbud003,xccbud004,xccbud005,
                                          xccbud006,xccbud007,xccbud008,xccbud009,xccbud010,xccbud011,xccbud012,xccbud013,xccbud014,xccbud015,
                                          xccbud016,xccbud017,xccbud018,xccbud019,xccbud020,xccbud021,xccbud022,xccbud023,xccbud024,xccbud025,
                                          xccbud026,xccbud027,xccbud028,xccbud029,xccbud030) 
                                  VALUES (l_xccb2.xccbent,l_xccb2.xccbld,l_xccb2.xccbcomp,l_xccb2.xccb001,l_xccb2.xccb002,
                                          l_xccb2.xccb003,l_xccb2.xccb004,l_xccb2.xccb005,l_xccb2.xccb006,l_xccb2.xccb007,
                                          l_xccb2.xccb008,l_xccb2.xccb009,l_xccb2.xccb010,l_xccb2.xccb101,l_xccb2.xccb102,
                                          l_xccb2.xccb102a,l_xccb2.xccb102b,l_xccb2.xccb102c,l_xccb2.xccb102d,l_xccb2.xccb102e,
                                          l_xccb2.xccb102f,l_xccb2.xccb102g,l_xccb2.xccb102h,l_xccb2.xccbownid,l_xccb2.xccbowndp,
                                          l_xccb2.xccbcrtid,l_xccb2.xccbcrtdp,l_xccb2.xccbcrtdt,l_xccb2.xccbmodid,l_xccb2.xccbmoddt,
                                          l_xccb2.xccbcnfid,l_xccb2.xccbcnfdt,l_xccb2.xccbpstid,l_xccb2.xccbpstdt,l_xccb2.xccbstus,
                                          l_xccb2.xccbud001,l_xccb2.xccbud002,l_xccb2.xccbud003,l_xccb2.xccbud004,l_xccb2.xccbud005,
                                          l_xccb2.xccbud006,l_xccb2.xccbud007,l_xccb2.xccbud008,l_xccb2.xccbud009,l_xccb2.xccbud010,
                                          l_xccb2.xccbud011,l_xccb2.xccbud012,l_xccb2.xccbud013,l_xccb2.xccbud014,l_xccb2.xccbud015,
                                          l_xccb2.xccbud016,l_xccb2.xccbud017,l_xccb2.xccbud018,l_xccb2.xccbud019,l_xccb2.xccbud020,
                                          l_xccb2.xccbud021,l_xccb2.xccbud022,l_xccb2.xccbud023,l_xccb2.xccbud024,l_xccb2.xccbud025,
                                          l_xccb2.xccbud026,l_xccb2.xccbud027,l_xccb2.xccbud028,l_xccb2.xccbud029,l_xccb2.xccbud030)
                      #161109-00085#21-e mod
                   END IF
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'ins xccb'
                      LET g_errparam.popup = FALSE
                      CALL cl_err()

                      LET r_success = FALSE
                      EXIT FOR
                   END IF
               #END IF
            END FOR
         END IF
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = ''
         LET g_errparam.extend = 'NO FILE'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = ''
      LET g_errparam.extend = 'NO EXCEL'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF

   CALL ui.interface.frontCall('WinCOM','CallMethod',[xlApp,'Quit'],[iRes])
   CALL ui.interface.frontCall('WinCOM','ReleaseInstance',[xlApp],[iRes])

   RETURN r_success
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
PRIVATE FUNCTION axct301_01_xccbld_desc()
   SELECT glaa015,glaa019 INTO g_glaa015,g_glaa019 FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = g_xccb_m.xccbld
    
   SELECT glaal003 INTO g_xccb_m.xccbld_desc FROM glaal_t 
    WHERE glaalent=g_enterprise AND glaal001=g_xccb_m.xccbld AND glaal002=g_dlang

   DISPLAY BY NAME g_xccb_m.xccbld_desc
END FUNCTION

 
{</section>}
 
