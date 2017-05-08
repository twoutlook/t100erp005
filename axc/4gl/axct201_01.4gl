#該程式未解開Section, 採用最新樣板產出!
{<section id="axct201_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2017-04-28 11:28:06), PR版次:0014(2017-04-28 13:30:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000127
#+ Filename...: axct201_01
#+ Description: 依費用分攤設定產生
#+ Creator....: 02114(2014-05-13 10:47:13)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="axct201_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#151208-00020#1  15/12/15  by Sarah       產生資料時,增加帳款對象(xcbl024)=glar017,人員(xcbl025)=glar020
#160318-00025#11 16/04/25  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160613-00002#1  16/06/13  By xianghui    效能优化
#160906-00062#1  16/09/08  By Ann_Huang   調整[依費用分攤設定產生],分攤成本金額(xcbl100、xcbl110、xcbl120)需依帳別設定作取位動作
#161124-00048#12 2016/12/13 By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
#170216-00034#1  2017/03/07 By 00768      小数尾差处理
#170308-00054#1  2017/04/17 By xujing     1.在呼叫axct201_01_ins_xcbl的function之前，先依指定的比例方式，计算出分摊比例，并回写至axci115
#                                         2.年度期别管控调整
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
PRIVATE type type_g_xcbl_m        RECORD
       xcbl002 LIKE xcbl_t.xcbl002, 
   xcbl003 LIKE xcbl_t.xcbl003, 
   xcblld LIKE xcbl_t.xcblld, 
   xcblld_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sql         STRING
DEFINE g_glaacomp    LIKE glaa_t.glaacomp
DEFINE g_glaa004     LIKE glaa_t.glaa004 
DEFINE g_para_data   LIKE type_t.chr80    #啟用次要素否 140924
#end add-point
 
DEFINE g_xcbl_m        type_g_xcbl_m
 
   DEFINE g_xcbl002_t LIKE xcbl_t.xcbl002
DEFINE g_xcbl003_t LIKE xcbl_t.xcbl003
DEFINE g_xcblld_t LIKE xcbl_t.xcblld
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axct201_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axct201_01(--)
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
   #dorislai-20151023-add----(S)
   DEFINE l_comp        LIKE xccc_t.xccccomp
   DEFINE l_ld          LIKE xccc_t.xcccld
   DEFINE l_calc_type   LIKE xccc_t.xccc003
   #dorislai-20151023-add----(E)
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axct201_01 WITH FORM cl_ap_formpath("axc","axct201_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_errshow = 1
   #dorislai-20151023-moidfy----(S)
#   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6010') RETURNING l_year
#   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6011') RETURNING l_month
   CALL s_axc_set_site_default() RETURNING l_comp,l_ld,l_year,l_month,l_calc_type
   #dorislai-20151023-moidfy----(E)
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xcbl_m.xcbl002,g_xcbl_m.xcbl003,g_xcbl_m.xcblld ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_xcbl_m.xcbl002 = l_year
            LET g_xcbl_m.xcbl003 = l_month
            LET g_xcbl_m.xcblld = l_ld  #dorislai-20151023-add
            CALL axct201_01_ref_show()     #--151125-00012#1 ADD   
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbl002
            #add-point:BEFORE FIELD xcbl002 name="input.b.xcbl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbl002
            
            #add-point:AFTER FIELD xcbl002 name="input.a.xcbl002"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_xcbl_m.xcbl002) AND NOT cl_null(g_xcbl_m.xcbl003) THEN #170308-00054#1 add
#               IF g_xcbl_m.xcbl002 < l_year THEN  #170308-00054#1 mark
               IF (g_xcbl_m.xcbl002 * 12 + g_xcbl_m.xcbl003) < (l_year * 12 + l_month) THEN #170308-00054#1 add
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axc-00303'
                  LET g_errparam.extend = g_xcbl_m.xcbl002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD xcbl002
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbl002
            #add-point:ON CHANGE xcbl002 name="input.g.xcbl002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbl003
            #add-point:BEFORE FIELD xcbl003 name="input.b.xcbl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbl003
            
            #add-point:AFTER FIELD xcbl003 name="input.a.xcbl003"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_xcbl_m.xcbl003) AND NOT cl_null(g_xcbl_m.xcbl002) THEN  #170308-00054#1 add
#               IF g_xcbl_m.xcbl003 < l_month THEN  #170308-00054#1 mark
               IF (g_xcbl_m.xcbl002 * 12 + g_xcbl_m.xcbl003) < (l_year * 12 + l_month) THEN  #170308-00054#1 add
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axc-00304'
                  LET g_errparam.extend = g_xcbl_m.xcbl003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD xcbl003
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbl003
            #add-point:ON CHANGE xcbl003 name="input.g.xcbl003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcblld
            
            #add-point:AFTER FIELD xcblld name="input.a.xcblld"
            CALL axct201_01_ref_show()
            IF NOT cl_null(g_xcbl_m.xcblld) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcbl_m.xcblld
               #160318-00025#11--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#11--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL s_ld_chk_authorization(g_user,g_xcbl_m.xcblld) RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00022'
                     LET g_errparam.extend = g_xcbl_m.xcblld
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xcbl_m.xcblld = ''
                     CALL axct201_01_ref_show()
                     NEXT FIELD CURRENT
                  END IF 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcbl_m.xcblld = ''
                  CALL axct201_01_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcblld
            #add-point:BEFORE FIELD xcblld name="input.b.xcblld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcblld
            #add-point:ON CHANGE xcblld name="input.g.xcblld"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcbl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbl002
            #add-point:ON ACTION controlp INFIELD xcbl002 name="input.c.xcbl002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbl003
            #add-point:ON ACTION controlp INFIELD xcbl003 name="input.c.xcbl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcblld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcblld
            #add-point:ON ACTION controlp INFIELD xcblld name="input.c.xcblld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbl_m.xcblld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcbl_m.xcblld = g_qryparam.return1              
            CALL axct201_01_ref_show()
            DISPLAY g_xcbl_m.xcblld TO xcblld              #

            NEXT FIELD xcblld                          #返回原欄位


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
      LET INT_FLAG = TRUE 
   ELSE
      CALL axct201_01_upd_xcba009() #170308-00054#1 add
      CALL axct201_01_ins_xcbl()
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_axct201_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axct201_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axct201_01.other_function" readonly="Y" >}
# 參考欄位帶值
PRIVATE FUNCTION axct201_01_ref_show()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcbl_m.xcblld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcbl_m.xcblld_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_xcbl_m.xcblld_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcbl_m.xcblld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaacomp,glaa004 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_glaacomp = g_rtn_fields[1]
   LET g_glaa004 = g_rtn_fields[2]
END FUNCTION
# 依费用分摊设置产生
PRIVATE FUNCTION axct201_01_ins_xcbl()
   DEFINE l_xcba001            LIKE xcba_t.xcba001
   DEFINE l_xcba004            LIKE xcba_t.xcba004
   DEFINE l_xcba007            LIKE xcba_t.xcba007
   DEFINE l_xcba005            LIKE xcba_t.xcba005
   DEFINE l_xcba006            LIKE xcba_t.xcba006
   DEFINE l_xcba009            LIKE xcba_t.xcba009
   DEFINE l_glar005            LIKE glar_t.glar005
   DEFINE l_glar006            LIKE glar_t.glar006
   DEFINE l_glar034            LIKE glar_t.glar034
   DEFINE l_glar035            LIKE glar_t.glar035
   DEFINE l_glar036            LIKE glar_t.glar036
   DEFINE l_glar037            LIKE glar_t.glar037
   DEFINE l_glac008            LIKE glac_t.glac008
   DEFINE l_amt1               LIKE glar_t.glar005
   DEFINE l_amt2               LIKE glar_t.glar005
   DEFINE l_amt3               LIKE glar_t.glar005
#   DEFINE l_xcbl               RECORD  LIKE  xcbl_t.*  #161124-00048#12 mark
  #161124-00048#12 add(s)
  DEFINE l_xcbl RECORD  #人工制費收集維護檔
       xcblent LIKE xcbl_t.xcblent, #企业编号
       xcblcomp LIKE xcbl_t.xcblcomp, #法人组织
       xcblld LIKE xcbl_t.xcblld, #账套
       xcbl001 LIKE xcbl_t.xcbl001, #费用类型
       xcbl002 LIKE xcbl_t.xcbl002, #年度
       xcbl003 LIKE xcbl_t.xcbl003, #期别
       xcbl004 LIKE xcbl_t.xcbl004, #成本中心
       xcbl005 LIKE xcbl_t.xcbl005, #分摊方式
       xcblseq LIKE xcbl_t.xcblseq, #项次
       xcbl010 LIKE xcbl_t.xcbl010, #科目编号
       xcbl011 LIKE xcbl_t.xcbl011, #营运组织
       xcbl012 LIKE xcbl_t.xcbl012, #部门
       xcbl013 LIKE xcbl_t.xcbl013, #收付款客商
       xcbl014 LIKE xcbl_t.xcbl014, #客群
       xcbl015 LIKE xcbl_t.xcbl015, #区域
       xcbl016 LIKE xcbl_t.xcbl016, #成本中心
       xcbl017 LIKE xcbl_t.xcbl017, #经营类别
       xcbl018 LIKE xcbl_t.xcbl018, #渠道
       xcbl019 LIKE xcbl_t.xcbl019, #品类
       xcbl020 LIKE xcbl_t.xcbl020, #品牌
       xcbl021 LIKE xcbl_t.xcbl021, #项目编号
       xcbl022 LIKE xcbl_t.xcbl022, #WBS
       xcbl023 LIKE xcbl_t.xcbl023, #成本次要素
       xcbl100 LIKE xcbl_t.xcbl100, #分摊成本
       xcbl110 LIKE xcbl_t.xcbl110, #分摊成本(本位币二)
       xcbl120 LIKE xcbl_t.xcbl120, #分摊成本(本位币三)
       xcblownid LIKE xcbl_t.xcblownid, #资料所有者
       xcblowndp LIKE xcbl_t.xcblowndp, #资料所有部门
       xcblcrtid LIKE xcbl_t.xcblcrtid, #资料录入者
       xcblcrtdp LIKE xcbl_t.xcblcrtdp, #资料录入部门
       xcblcrtdt LIKE xcbl_t.xcblcrtdt, #资料创建日
       xcblmodid LIKE xcbl_t.xcblmodid, #资料更改者
       xcblmoddt LIKE xcbl_t.xcblmoddt, #最近更改日
       xcblstus LIKE xcbl_t.xcblstus, #状态码
       xcbl024 LIKE xcbl_t.xcbl024, #账款对象
       xcbl025 LIKE xcbl_t.xcbl025  #人员
END RECORD
  #161124-00048#12 add(e)
   DEFINE l_n                  LIKE type_t.num5
   DEFINE l_flag               LIKE type_t.chr1
   DEFINE l_flag1              LIKE type_t.chr1   #fengmy add 会计科目 
   DEFINE l_glaa001            LIKE glaa_t.glaa001  #160906-00062#1 add
   DEFINE l_glaa016            LIKE glaa_t.glaa001  #160906-00062#1 add
   DEFINE l_glaa020            LIKE glaa_t.glaa001  #160906-00062#1 add
   DEFINE l_success            LIKE type_t.num5     #170216-00034#1 add
   
   CALL s_transaction_begin()
   LET g_success = 'Y'
   LET l_flag = 'N'
   #140928 fengmy add begin
   CALL cl_err_collect_init() 
   LET g_coll_title[1] = cl_getmsg("axc-00584",g_lang) #法人
   LET g_coll_title[2] = cl_getmsg("axc-00585",g_lang) #账套
   LET g_coll_title[3] = cl_getmsg("axc-00582",g_lang) #科目
   #140928 fengmy add end
   SELECT COUNT(*) INTO l_n 
     FROM xcbl_t
    WHERE xcblent = g_enterprise
      AND xcblld  = g_xcbl_m.xcblld
      #AND xcbl001 IN (SELECT xcba001 FROM xcba_t
      #                 WHERE xcbaent = g_enterprise
      #                   AND xcbald  = g_xcbl_m.xcblld
      #                   AND xcba002 = g_xcbl_m.xcbl002
      #                   AND xcba003 = g_xcbl_m.xcbl003)
      AND xcbl002 = g_xcbl_m.xcbl002
      AND xcbl003 = g_xcbl_m.xcbl003
      
   IF l_n > 0 THEN 
      IF cl_ask_confirm('axc-00531') THEN
#fengmy--150104---begin---DELETE与上方查重复的sql条件 调整为一致
#         DELETE FROM xcbl_t
#          WHERE xcblent = g_enterprise
#            AND xcblld  = g_xcbl_m.xcblld
#            AND xcbl001 IN (SELECT xcba001 FROM xcba_t
#                             WHERE xcbaent = g_enterprise
#                               AND xcbald  = g_xcbl_m.xcblld
#                               AND xcba002 = g_xcbl_m.xcbl002
#                               AND xcba003 = g_xcbl_m.xcbl003)
#            AND xcbl002 = g_xcbl_m.xcbl002
#            AND xcbl003 = g_xcbl_m.xcbl003
         DELETE FROM xcbl_t
          WHERE xcblent = g_enterprise
            AND xcblld  = g_xcbl_m.xcblld            
            AND xcbl002 = g_xcbl_m.xcbl002
            AND xcbl003 = g_xcbl_m.xcbl003
#fengmy--150104---end
      END IF
   END IF
   
   #费用类型(xcba001)、成本中心(xcba004)、分摊方式(xcba007)、科目编号(xcba005)、部门编号(xcba006)、分摊权数(xcba009)
   LET g_sql = "SELECT xcba001,xcba004,xcba007,xcba005,xcba006,xcba009,",    
               " (SELECT glac008 FROM glac_t WHERE glacent = ",g_enterprise," AND glac001 = '",g_glaa004,"' AND glac002 = xcba005) glac008",   #160613-00002#1 add
               "  FROM xcba_t ",
               " WHERE xcbaent = '",g_enterprise,"'",
               "   AND xcbald  = '",g_xcbl_m.xcblld,"'",
               "   AND xcba002 = ",g_xcbl_m.xcbl002,
               "   AND xcba003 = ",g_xcbl_m.xcbl003
    PREPARE xcba_pre FROM g_sql
    DECLARE xcba_cur CURSOR FOR xcba_pre
 
    #160613-00002#1---add---s
    LET g_sql = "SELECT glar012,glar013,glar016,glar018,glar015,glar014,'','',glar019,glar022,glar023,",
                "       glar017,glar020,",   
                "       sum(glar005),sum(glar006),sum(glar034),sum(glar035),sum(glar036),sum(glar037)",
                "  FROM glar_t",
                " WHERE glarent = '",g_enterprise,"' ",
                "   AND glarld = '",g_xcbl_m.xcblld,"' ",
                "   AND glar001 = ? ",
                "   AND glar013 = ? ",
                "   AND glar002 = '",g_xcbl_m.xcbl002,"' ",
                "   AND glar003 = '",g_xcbl_m.xcbl003,"' ",
                "  GROUP BY glar012,glar013,glar016,glar018,glar015,glar014,'','',glar019,glar022,glar023,glar017,glar020 "   #151208-00020#1 add glar017,glar020
    PREPARE sel_glar_pre FROM g_sql        
    DECLARE sel_glar_cur CURSOR FOR sel_glar_pre    

    LET g_sql = "SELECT SUM(glaq004-glaq003),SUM(glaq041-glaq040),SUM(glaq044-glaq043)",                
                "  FROM glaq_t INNER JOIN glap_t ON glapld = glaqld AND glapdocno = glaqdocno AND glapent = glaqent",
                " WHERE glaqent = '",g_enterprise,"'",
                "   AND glaqld = '",g_xcbl_m.xcblld,"'",
                "   AND glaq002 =? AND glap002 = ",g_xcbl_m.xcbl002,
                "   AND glap003 =",g_xcbl_m.xcbl002," AND glapstus = 'S'",
                "   AND glap007 = 'XC'"   #成本结转
    PREPARE sel_sum_glaq_pre1 FROM g_sql                           
    LET g_sql = "SELECT SUM(glaq003-glaq004), SUM(glaq040-glaq041),SUM(glaq043-glaq044)",                 
                "  FROM glaq_t INNER JOIN glap_t ON glapld = glaqld AND glapdocno = glaqdocno AND glapent = glaqent",
                " WHERE glaqent = '",g_enterprise,"'",
                "   AND glaqld = '",g_xcbl_m.xcblld,"'",
                "   AND glaq002 =? AND glap002 = ",g_xcbl_m.xcbl002,
                "   AND glap003 =",g_xcbl_m.xcbl002," AND glapstus = 'S'",
                "   AND glap007 = 'XC'"   #成本结转
    PREPARE sel_sum_glaq_pre2 FROM g_sql                      
    #160613-00002#1---add---e
    
    FOREACH xcba_cur INTO l_xcba001,l_xcba004,l_xcba007,l_xcba005,l_xcba006,l_xcba009,l_glac008  #160613-00002#1 add glac008
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "FOREACH:"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          EXIT FOREACH
       END IF
#       LET l_flag = 'Y'    #未进入sel_glar_cur就变更变量，若sel_glar_cur无资料也提示成功 fengmy--150104--mark
       
       LET l_xcbl.xcblent  = g_enterprise
       LET l_xcbl.xcblcomp = g_glaacomp
       LET l_xcbl.xcblld   = g_xcbl_m.xcblld
       LET l_xcbl.xcbl001  = l_xcba001
       LET l_xcbl.xcbl002  = g_xcbl_m.xcbl002
       LET l_xcbl.xcbl003  = g_xcbl_m.xcbl003
       LET l_xcbl.xcbl004  = l_xcba004
       LET l_xcbl.xcbl005  = l_xcba007
       #150709-00013---mark----b
#       SELECT MAX(xcblseq) + 1 INTO l_xcbl.xcblseq
#         FROM xcbl_t
#        WHERE xcblent = g_enterprise
#          AND xcblld = g_xcbl_m.xcblld
#          AND xcbl001 = l_xcba001
#          AND xcbl002 = g_xcbl_m.xcbl002
#          AND xcbl003 = g_xcbl_m.xcbl003
#          AND xcbl004 = l_xcba004
#          AND xcbl005 = l_xcba007
#          
#       IF cl_null(l_xcbl.xcblseq) THEN 
#          LET l_xcbl.xcblseq = 1
#       END IF
       LET l_xcbl.xcblseq = ' ' 
       #150709-00013---mark----e
       LET l_xcbl.xcbl010  = l_xcba005
       
       #160613-00002#1---mark---s
#       LET g_sql = 
#       "SELECT glar012,glar013,glar016,glar018,glar015,glar014,'','',glar019,glar022,glar023,",
#       "       glar017,glar020,",   #151208-00020#1 add
#       "       sum(glar005),sum(glar006),sum(glar034),sum(glar035),sum(glar036),sum(glar037)",
#       "  FROM glar_t",
#       " WHERE glarent = '",g_enterprise,"' ",
#       "   AND glarld = '",g_xcbl_m.xcblld,"' ",
#       "   AND glar001 = '",l_xcba005,"' ",
#       "   AND glar013 = '",l_xcba006,"' ",
#       "   AND glar002 = '",g_xcbl_m.xcbl002,"' ",
#       "   AND glar003 = '",g_xcbl_m.xcbl003,"' ",
#       "  GROUP BY glar012,glar013,glar016,glar018,glar015,glar014,'','',glar019,glar022,glar023,glar017,glar020 "   #151208-00020#1 add glar017,glar020
#        PREPARE sel_glar_pre FROM g_sql        
#        DECLARE sel_glar_cur CURSOR FOR sel_glar_pre
        #160613-00002#1---mark---e
        #FOREACH sel_glar_cur INTO     #160613-00002#1 mark
        FOREACH sel_glar_cur USING l_xcba005,l_xcba006 INTO     #160613-00002#1 mark  
                l_xcbl.xcbl011,l_xcbl.xcbl012,l_xcbl.xcbl013,l_xcbl.xcbl014,l_xcbl.xcbl015,
                l_xcbl.xcbl016,l_xcbl.xcbl017,l_xcbl.xcbl018,l_xcbl.xcbl019,l_xcbl.xcbl021,
                l_xcbl.xcbl022,l_xcbl.xcbl024,l_xcbl.xcbl025,   #151208-00020#1 add xcbl024,xcbl025
                l_glar005,l_glar006,l_glar034,l_glar035,l_glar036,l_glar037
                          
              LET l_flag = 'Y'    #fengmy--150104--add             
              
              IF cl_null(l_glar005) THEN 
                 LET l_glar005 = 0
              END IF
              
              IF cl_null(l_glar006) THEN 
                 LET l_glar006 = 0
              END IF
              
              IF cl_null(l_glar034) THEN 
                 LET l_glar034 = 0
              END IF
              
              IF cl_null(l_glar035) THEN 
                 LET l_glar035 = 0
              END IF
       
              IF cl_null(l_glar036) THEN 
                 LET l_glar036 = 0
              END IF
              
              IF cl_null(l_glar037) THEN 
                 LET l_glar037 = 0
              END IF
                 
              #如果科目正常余额形态是借方
              #   根据该科目抓取结转类凭证的发生额(sum(贷方金额-借方金额)且分主本位币、功能币二、三)，如果抓不到给0。可以设计一个元件来实现。
              #   分摊成本(xcbl100)=(借方金额(glar005)-贷方金额(glar006)+结转类凭证发生额)*分摊权数(xcba009)
              #   分摊成本本位币二(xcbl110)=(借方金额(glar034)-贷方金额(glar035)+结转类凭证发生额)*分摊权数(xcba009)
              #   分摊成本本位币三(xcbl120)=(借方金额(glar036)-贷方金额(glar037)+结转类凭证发生额)*分摊权数(xcba009)
              #如果科目正常余额形态是贷方
              #   根据该科目抓取结转类凭证的发生额(sum(借方金额-贷方金额)且分主本位币、功能币二、三)，如果抓不到给0。可以设计一个元件来实现。
              #   分摊成本(xcbl100)=(贷方金额(glar006)-借方金额(glar005)+结转类凭证发生额)*分摊权数(xcba009)
              #   分摊成本本位币二(xcbl110)=(贷方金额(glar035)-借方金额(glar034)+结转类凭证发生额)*分摊权数(xcba009)
              #   分摊成本本位币三(xcbl120)=(贷方金额(glar037)-借方金额(glar036)+结转类凭证发生额)*分摊权数(xcba009)
              
              #160613-00002#1---mark--s
              ##科目正常余额形态
              #SELECT glac008 INTO l_glac008
              #  FROM glac_t
              # WHERE glacent = g_enterprise
              #   AND glac001 = g_glaa004
              #   AND glac002 = l_xcba005
              #160613-00002#1---mark--e
              
              LET l_amt1 = 0
              LET l_amt2 = 0
              LET l_amt3 = 0
               
              IF l_glac008 = '2' THEN
                 #160613-00002#1---mod--s
                 #SELECT SUM(glaq004-glaq003), SUM(glaq041-glaq040),SUM(glaq044-glaq043) 
                 #  INTO l_amt1,l_amt2,l_amt3                 
                 #  FROM glaq_t INNER JOIN glap_t ON glapld = glaqld AND glapdocno = glaqdocno AND glapent = glaqent
                 # WHERE glaqent = g_enterprise 
                 #   AND glaqld = g_xcbl_m.xcblld
                 #   AND glaq002 =l_xcba001 AND glap002 = g_xcbl_m.xcbl002
                 #   AND glap003 =g_xcbl_m.xcbl002 AND glapstus = 'S'
                 #   AND glap007 = 'XC'   #成本结转
                 EXECUTE sel_sum_glaq_pre1 USING l_xcba001 INTO l_amt1,l_amt2,l_amt3 
                 #160613-00002#1---mod--e                 
                 IF cl_null(l_amt1) THEN 
                    LET l_amt1 = 0
                 END IF
                                   
                 IF cl_null(l_amt2) THEN 
                    LET l_amt2 = 0
                 END IF
                    
                 IF cl_null(l_amt3) THEN 
                    LET l_amt3 = 0
                 END IF
                  
                 #   分摊成本(xcbl100)=(借方金额(glar005)-贷方金额(glar006)+结转类凭证发生额)*分摊权数(xcba009)
                 #   分摊成本本位币二(xcbl110)=(借方金额(glar034)-贷方金额(glar035)+结转类凭证发生额)*分摊权数(xcba009)
                 #   分摊成本本位币三(xcbl120)=(借方金额(glar036)-贷方金额(glar037)+结转类凭证发生额)*分摊权数(xcba009)           
                 LET l_xcbl.xcbl100 = (l_glar006 - l_glar005 + l_amt1) * l_xcba009 / 100
                 LET l_xcbl.xcbl110 = (l_glar035 - l_glar034 + l_amt2) * l_xcba009 / 100
                 LET l_xcbl.xcbl120 = (l_glar037 - l_glar036 + l_amt3) * l_xcba009 / 100
                 
              ELSE
                 #160613-00002#1---mod--s
                 #SELECT SUM(glaq003-glaq004), SUM(glaq040-glaq041),SUM(glaq043-glaq044)  
                 #  INTO l_amt1,l_amt2,l_amt3                  
                 #  FROM glaq_t INNER JOIN glap_t ON glapld = glaqld AND glapdocno = glaqdocno AND glapent = glaqent
                 # WHERE glaqent = g_enterprise 
                 #   AND glaqld = g_xcbl_m.xcblld
                 #   AND glaq002 =l_xcba001 AND glap002 = g_xcbl_m.xcbl002
                 #   AND glap003 =g_xcbl_m.xcbl002 AND glapstus = 'S'
                 #   AND glap007 = 'XC'   #成本结转
                 EXECUTE sel_sum_glaq_pre2 USING l_xcba001 INTO l_amt1,l_amt2,l_amt3  
                 #160613-00002#1---mod--e
                 IF cl_null(l_amt1) THEN 
                    LET l_amt1 = 0
                 END IF
                                   
                 IF cl_null(l_amt2) THEN 
                    LET l_amt2 = 0
                 END IF
                    
                 IF cl_null(l_amt3) THEN 
                    LET l_amt3 = 0
                 END IF
                 #   分摊成本(xcbl100)=(借方金额(glar006)-贷方金额(glar005)+结转类凭证发生额)*分摊权数(xcba009)
                 #   分摊成本本位币二(xcbl110)=(借方金额(glar035)-贷方金额(glar034)+结转类凭证发生额)*分摊权数(xcba009)
                 #   分摊成本本位币三(xcbl120)=(借方金额(glar037)-贷方金额(glar036)+结转类凭证发生额)*分摊权数(xcba009)           
                 LET l_xcbl.xcbl100 = (l_glar005 - l_glar006 + l_amt1) * l_xcba009 / 100
                 LET l_xcbl.xcbl110 = (l_glar034 - l_glar035 + l_amt2) * l_xcba009 / 100
                 LET l_xcbl.xcbl120 = (l_glar036 - l_glar037 + l_amt3) * l_xcba009 / 100
              END IF
       
              IF cl_null(l_xcbl.xcbl100) THEN 
                 LET l_xcbl.xcbl100 = 0
              END IF
              
              IF cl_null(l_xcbl.xcbl110) THEN 
                 LET l_xcbl.xcbl110 = 0
              END IF
              
              IF cl_null(l_xcbl.xcbl120) THEN 
                 LET l_xcbl.xcbl120 = 0
              END IF
              #160906-00062#1-(S)-add
                 SELECT glaa001,glaa016,glaa020
                   INTO l_glaa001,l_glaa016,l_glaa020
                   FROM glaa_t
                  WHERE glaaent = g_enterprise
                    AND glaald = l_xcbl.xcblld
              CALL s_curr_round_ld(1,l_xcbl.xcblld,l_glaa001,l_xcbl.xcbl100,5) RETURNING g_sub_success,g_errno,l_xcbl.xcbl100
              CALL s_curr_round_ld(1,l_xcbl.xcblld,l_glaa016,l_xcbl.xcbl110,5) RETURNING g_sub_success,g_errno,l_xcbl.xcbl110
              CALL s_curr_round_ld(1,l_xcbl.xcblld,l_glaa020,l_xcbl.xcbl120,5) RETURNING g_sub_success,g_errno,l_xcbl.xcbl120          
              #160906-00062#1-(E)-end
              
              #成本次要素 fengmy140924--begin
              CALL cl_get_para(g_enterprise,l_xcbl.xcblcomp,'S-FIN-6015') RETURNING g_para_data
              IF g_para_data = 'Y' THEN
                 SELECT xcay002 INTO l_xcbl.xcbl023 FROM xcay_t 
                  WHERE xcay001 = l_xcbl.xcbl010
                    AND xcayent = g_enterprise
                    AND xcayld = l_xcbl.xcblld
                    AND xcaystus = 'Y'  
                 IF cl_null(l_xcbl.xcbl023)  THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code   = 'axc-00583' 
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    LET g_errparam.coll_vals[1] = l_xcbl.xcblcomp
                    LET g_errparam.coll_vals[2] = l_xcbl.xcblld
                    LET g_errparam.coll_vals[3] = l_xcbl.xcbl010
                    LET g_errparam.sqlerr = 0
                    CALL cl_err()
                    LET l_xcbl.xcbl023 = ' '  
                 END IF                       
              ELSE
                 LET  l_xcbl.xcbl023 = ' '               
              END IF 
              #fengmy140924--end
              LET l_xcbl.xcblownid = g_user
              LET l_xcbl.xcblowndp = g_dept
              LET l_xcbl.xcblcrtid = g_user
              LET l_xcbl.xcblcrtdp = g_dept 
              LET l_xcbl.xcblcrtdt = cl_get_current()
              LET l_xcbl.xcblmodid = ""
              LET l_xcbl.xcblmoddt = ""
              #150709-00013-------b
              SELECT MAX(xcblseq) + 1 INTO l_xcbl.xcblseq
                FROM xcbl_t
               WHERE xcblent = g_enterprise
                 AND xcblld = g_xcbl_m.xcblld
                 AND xcbl001 = l_xcba001
                 AND xcbl002 = g_xcbl_m.xcbl002
                 AND xcbl003 = g_xcbl_m.xcbl003
                 AND xcbl004 = l_xcba004
                 AND xcbl005 = l_xcba007
                 
              IF cl_null(l_xcbl.xcblseq) THEN 
                 LET l_xcbl.xcblseq = 1
              END IF
              #150709-00013-------e       
#              INSERT INTO xcbl_t VALUES(l_xcbl.*)  #161124-00048#12
              #161124-00048#12 add(s)
              INSERT INTO xcbl_t(xcblent,xcblcomp,xcblld,xcbl001,xcbl002,xcbl003,xcbl004,xcbl005,xcblseq,xcbl010,
                                 xcbl011,xcbl012,xcbl013,xcbl014,xcbl015,xcbl016,xcbl017,xcbl018,xcbl019,xcbl020,
                                 xcbl021,xcbl022,xcbl023,xcbl100,xcbl110,xcbl120,xcblownid,xcblowndp,xcblcrtid,
                                 xcblcrtdp,xcblcrtdt,xcblmodid,xcblmoddt,xcblstus,xcbl024,xcbl025)
                          VALUES(l_xcbl.xcblent,l_xcbl.xcblcomp,l_xcbl.xcblld,l_xcbl.xcbl001,l_xcbl.xcbl002,l_xcbl.xcbl003,l_xcbl.xcbl004,l_xcbl.xcbl005,l_xcbl.xcblseq,l_xcbl.xcbl010,
                                 l_xcbl.xcbl011,l_xcbl.xcbl012,l_xcbl.xcbl013,l_xcbl.xcbl014,l_xcbl.xcbl015,l_xcbl.xcbl016,l_xcbl.xcbl017,l_xcbl.xcbl018,l_xcbl.xcbl019,l_xcbl.xcbl020,
                                 l_xcbl.xcbl021,l_xcbl.xcbl022,l_xcbl.xcbl023,l_xcbl.xcbl100,l_xcbl.xcbl110,l_xcbl.xcbl120,l_xcbl.xcblownid,l_xcbl.xcblowndp,l_xcbl.xcblcrtid,
                                 l_xcbl.xcblcrtdp,l_xcbl.xcblcrtdt,l_xcbl.xcblmodid,l_xcbl.xcblmoddt,l_xcbl.xcblstus,l_xcbl.xcbl024,l_xcbl.xcbl025)
              #161124-00048#12 add(e)
              IF SQLCA.SQLcode  THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "l_xcbl"
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
              
                 LET g_success = 'N'                        
              END IF
        END FOREACH
    END FOREACH
    
    #170216-00034#1 add--s 小数尾差处理
    CALL axct201_01_deal_diff() RETURNING l_success
    IF NOT l_success THEN
       LET g_success='N'
    END IF
    #170216-00034#1 add--e
    
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

################################################################################
# Descriptions...: 小数尾差处理
# Memo...........:
# Usage..........: CALL axct201_01_deal_diff()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success    处理结果TRUE/FALSE
# Date & Author..: 2017/03/07 By 00768 #170216-00034#1 add
# Modify.........:
################################################################################
PRIVATE FUNCTION axct201_01_deal_diff()
   DEFINE r_success LIKE type_t.num5
   DEFINE l_sql     STRING
   DEFINE l_xcba005 LIKE xcba_t.xcba005
   DEFINE l_xcba006 LIKE xcba_t.xcba006
   DEFINE l_xcba009 LIKE xcba_t.xcba009
   DEFINE l_glac008 LIKE glac_t.glac008
   #sum(xcbl)
   DEFINE l_xcbl100 LIKE xcbl_t.xcbl100 
   DEFINE l_xcbl110 LIKE xcbl_t.xcbl110 
   DEFINE l_xcbl120 LIKE xcbl_t.xcbl120 
   #sum(glar)
   DEFINE l_glar005 LIKE glar_t.glar005
   DEFINE l_glar006 LIKE glar_t.glar006
   DEFINE l_glar034 LIKE glar_t.glar034
   DEFINE l_glar035 LIKE glar_t.glar035
   DEFINE l_glar036 LIKE glar_t.glar036
   DEFINE l_glar037 LIKE glar_t.glar037
   #sum(glaq)
   DEFINE l_glaq003 LIKE glaq_t.glaq003
   DEFINE l_glaq004 LIKE glaq_t.glaq004
   DEFINE l_glaq040 LIKE glaq_t.glaq040
   DEFINE l_glaq041 LIKE glaq_t.glaq041
   DEFINE l_glaq043 LIKE glaq_t.glaq043
   DEFINE l_glaq044 LIKE glaq_t.glaq044
   #被分摊金额
   DEFINE l_amt1    LIKE glar_t.glar005
   DEFINE l_amt2    LIKE glar_t.glar005
   DEFINE l_amt3    LIKE glar_t.glar005
   #差异金额
   DEFINE l_diff1   LIKE glar_t.glar005
   DEFINE l_diff2   LIKE glar_t.glar005
   DEFINE l_diff3   LIKE glar_t.glar005
   #xcbl金额最大的那笔key
   DEFINE l_xcbl001 LIKE xcbl_t.xcbl001
   DEFINE l_xcbl004 LIKE xcbl_t.xcbl004
   DEFINE l_xcbl005 LIKE xcbl_t.xcbl005
   DEFINE l_xcblseq LIKE xcbl_t.xcblseq
   
   LET r_success = TRUE
   
   #1.A:取axct201己分攤的金額,依科目+部门作合計
   #2.B:取被分摊的金额(同axct201_01_ins_xcbl中的逻辑)
   #3.A-B若有差異, 則更新到最大金額的一筆 
   
   
   #搜出所有科目+部门，sum(xcba009)分摊权数为100的需处理小数尾差
   LET l_sql = " SELECT xcba005,xcba006,SUM(xcba009), ",
               "        (SELECT glac008 FROM glac_t ",
               "          WHERE glacent = ",g_enterprise,
               "            AND glac001 = '",g_glaa004,"' ",
               "            AND glac002 = xcba005) glac008 ",
               "   FROM xcba_t ",
               "  WHERE xcbaent = ",g_enterprise,
               "    AND xcbald  = '",g_xcbl_m.xcblld,"' ",
               "    AND xcba002 = ",g_xcbl_m.xcbl002,  #年
               "    AND xcba003 = ",g_xcbl_m.xcbl003,  #期
               "  GROUP BY xcba005,xcba006 ",
               " HAVING SUM(xcba009)=100 "
   PREPARE axct201_01_deal_diff_p FROM l_sql        
   DECLARE axct201_01_deal_diff_c CURSOR FOR axct201_01_deal_diff_p
   FOREACH axct201_01_deal_diff_c INTO l_xcba005,l_xcba006,l_xcba009,l_glac008
       #SUM(xcbl)
       SELECT NVL(SUM(xcbl100),0),NVL(SUM(xcbl110),0),NVL(SUM(xcbl120),0)
         INTO l_xcbl100,l_xcbl110,l_xcbl120
         FROM xcbl_t
        WHERE xcblent = g_enterprise
          AND xcblld  = g_xcbl_m.xcblld
          AND xcbl002 = g_xcbl_m.xcbl002  #年
          AND xcbl003 = g_xcbl_m.xcbl003  #期
          AND xcbl010 = l_xcba005 #科目
          AND xcbl012 = l_xcba006 #部门

       #SUM(glar)
       SELECT NVL(SUM(glar005),0),NVL(SUM(glar006),0),
              NVL(SUM(glar034),0),NVL(SUM(glar035),0),
              NVL(SUM(glar036),0),NVL(SUM(glar037),0)
         INTO l_glar005,l_glar006,l_glar034,l_glar035,l_glar036,l_glar037
         FROM glar_t
        WHERE glarent = g_enterprise
          AND glarld  = g_xcbl_m.xcblld
          AND glar001 = l_xcba005   #会计科目
          AND glar013 = l_xcba006   #部门
          AND glar002 = g_xcbl_m.xcbl002 #年
          AND glar003 = g_xcbl_m.xcbl003 #期

       #SUM(glaq)
       SELECT NVL(SUM(glaq003),0),NVL(SUM(glaq004),0),
              NVL(SUM(glaq040),0),NVL(SUM(glaq041),0),
              NVL(SUM(glaq043),0),NVL(SUM(glaq044),0)
         INTO l_glaq003,l_glaq004,l_glaq040,l_glaq041,l_glaq043,l_glaq044          
         FROM glaq_t INNER JOIN glap_t ON glapld = glaqld AND glapdocno = glaqdocno AND glapent = glaqent
        WHERE glaqent = g_enterprise
          AND glaqld  = g_xcbl_m.xcblld
          AND glaq002 = l_xcba005   #会计科目
          AND glap002 = g_xcbl_m.xcbl002
          AND glap003 = g_xcbl_m.xcbl002
          AND glapstus = 'S'
          AND glap007 = 'XC'

       IF l_glac008 = '2' THEN  #2.贷余型态
          #本位币一分摊金额=(贷方金额(glar006)-借贷方金额(glar005)+结转类凭证发生额)
          #本位币二分摊金额=(贷方金额(glar035)-借贷方金额(glar034)+结转类凭证发生额)
          #本位币三分摊金额=(贷方金额(glar037)-借贷方金额(glar036)+结转类凭证发生额)
          LET l_amt1 = (l_glar006 - l_glar005) + (l_glaq004 - l_glaq003)
          LET l_amt2 = (l_glar035 - l_glar034) + (l_glaq041 - l_glaq040)
          LET l_amt3 = (l_glar037 - l_glar036) + (l_glaq044 - l_glaq043)
       ELSE  #1.借余型态
          #本位币一分摊金额=(借方金额(glar005)-贷方金额(glar006)+结转类凭证发生额)
          #本位币二分摊金额=(借方金额(glar034)-贷方金额(glar035)+结转类凭证发生额)
          #本位币三分摊金额=(借方金额(glar036)-贷方金额(glar037)+结转类凭证发生额)
          LET l_amt1 = (l_glar005 - l_glar006) + (l_glaq003 - l_glaq004)
          LET l_amt2 = (l_glar034 - l_glar035) + (l_glaq040 - l_glaq041)
          LET l_amt3 = (l_glar036 - l_glar037) + (l_glaq043 - l_glaq044)
       END IF
       
       #搜出SUM(xcbl)与SUM(glar) + SUM(glaq)不匹配的需做小数处理
       IF l_xcbl100 != l_amt1 THEN  #l_xcbl110 = l_amt2/l_xcbl120 = l_amt3
          LET l_diff1 = l_amt1 - l_xcbl100
          LET l_diff2 = l_amt2 - l_xcbl110
          LET l_diff3 = l_amt3 - l_xcbl120
          
          SELECT xcbl001,xcbl004,xcbl005,xcblseq
            INTO l_xcbl001,l_xcbl004,l_xcbl005,l_xcblseq
            FROM xcbl_t 
           WHERE xcblent = g_enterprise
             AND xcblld  = g_xcbl_m.xcblld
             AND xcbl002 = g_xcbl_m.xcbl002  #年
             AND xcbl003 = g_xcbl_m.xcbl003  #期
             AND xcbl010 = l_xcba005 #科目
             AND xcbl012 = l_xcba006 #部门
             AND xcbl100 = (SELECT MAX(xcbl100) FROM xcbl_t
                             WHERE xcblent = g_enterprise
                               AND xcblld  = g_xcbl_m.xcblld
                               AND xcbl002 = g_xcbl_m.xcbl002  #年
                               AND xcbl003 = g_xcbl_m.xcbl003  #期
                               AND xcbl010 = l_xcba005 #科目
                               AND xcbl012 = l_xcba006 #部门
                           )
             AND ROWNUM=1
             
          #更新到xcbl最大金額的一筆
          UPDATE xcbl_t SET xcbl100 = xcbl100 + l_diff1,
                            xcbl110 = xcbl110 + l_diff2,
                            xcbl120 = xcbl120 + l_diff3
           WHERE xcblent = g_enterprise
             AND xcblld  = g_xcbl_m.xcblld
             AND xcbl001 = l_xcbl001
             AND xcbl002 = g_xcbl_m.xcbl002  #年
             AND xcbl003 = g_xcbl_m.xcbl003  #期
             AND xcbl004 = l_xcbl004
             AND xcbl005 = l_xcbl005
             AND xcblseq = l_xcblseq
             #AND xcbl010 = l_xcba005 #科目
             #AND xcbl012 = l_xcba006 #部门
       END IF
       
   END FOREACH
   
   RETURN r_success
END FUNCTION
#170308-00054#2 add
PRIVATE FUNCTION axct201_01_upd_xcba009()
DEFINE l_sql  STRING
DEFINE l_xcba RECORD  #成本要素分摊设置档
       xcba001 LIKE xcba_t.xcba001, #分摊类型
       xcba004 LIKE xcba_t.xcba004, #成本中心
       xcba005 LIKE xcba_t.xcba005, #科目编号
       xcba006 LIKE xcba_t.xcba006, #部门编号
       xcba007 LIKE xcba_t.xcba007, #分摊公式
       xcba008 LIKE xcba_t.xcba008, #部门属性
       xcba009 LIKE xcba_t.xcba009  #分摊权数
END RECORD
DEFINE l_count LIKE type_t.num5
DEFINE l_xcbi100 LIKE xcbi_t.xcbi100 #入库数量
DEFINE l_xcbi203 LIKE xcbi_t.xcbi203 #标准工时
DEFINE l_xcbi201 LIKE xcbi_t.xcbi201 #实际工时
DEFINE l_xcbi204 LIKE xcbi_t.xcbi204 #标准机时
DEFINE l_xcbi202 LIKE xcbi_t.xcbi202 #实际机时
DEFINE l_xcbi100_sum LIKE xcbi_t.xcbi100 #入库数量
DEFINE l_xcbi203_sum LIKE xcbi_t.xcbi203 #标准工时
DEFINE l_xcbi201_sum LIKE xcbi_t.xcbi201 #实际工时
DEFINE l_xcbi204_sum LIKE xcbi_t.xcbi204 #标准机时
DEFINE l_xcbi202_sum LIKE xcbi_t.xcbi202 #实际机时
DEFINE l_bdate LIKE type_t.dat
DEFINE l_edate LIKE type_t.dat
DEFINE l_percent LIKE type_t.num20_6
DEFINE l_datetime  DATETIME YEAR TO SECOND
   
   WHENEVER ERROR CONTINUE
   DROP TABLE axct201_tmp;
   CREATE TEMP TABLE axct201_tmp(
       xcba005 LIKE xcba_t.xcba005, #科目编号
       xcba006 LIKE xcba_t.xcba006 #部门编号
   );
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axct201_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   LET l_sql = "SELECT DISTINCT xcba004,xcba005,xcba006 FROM xcba_t ",
               " WHERE xcbaent = ",g_enterprise,
               "   AND xcbald = '",g_xcbl_m.xcblld,"'",
               "   AND xcba002 = ",g_xcbl_m.xcbl002,
               "   AND xcba003 = ",g_xcbl_m.xcbl003,
               "   AND xcba007 IN ('4','6','7','8','9')"
   PREPARE upd_xcba009_prep3 FROM l_sql
   DECLARE upd_xcba009_curs3 CURSOR FOR upd_xcba009_prep3
   
   FOREACH upd_xcba009_curs3 INTO l_xcba.xcba004,l_xcba.xcba005,l_xcba.xcba006
      LET l_count = 0
      #檢查帳套+年度+期別+科目編號+部門編號，有兩個(含)以上的分攤方式，則不處理該科目編號+部門編號
      SELECT COUNT(1) INTO l_count
        FROM xcba_t 
       WHERE xcbaent = g_enterprise
         AND xcbald  = g_xcbl_m.xcblld
         AND xcba002 = g_xcbl_m.xcbl002
         AND xcba003 = g_xcbl_m.xcbl003
         AND xcba004 = l_xcba.xcba004
         AND xcba005 = l_xcba.xcba005
         AND xcba006 = l_xcba.xcba006
      IF l_count > 1 THEN 
         CONTINUE FOREACH 
      END IF
      INSERT INTO axct201_tmp VALUES(l_xcba.xcba005,l_xcba.xcba006)
   END FOREACH
   INITIALIZE l_xcba.* TO NULL
   CALL s_transaction_begin()
   #用畫面上的帳套、年度、期別抓取axci115的科目編號、部門編號，只抓出分攤方式為4、6、7、8、9的資料做處理，
   LET l_sql = "SELECT DISTINCT xcba005,xcba006 FROM axct201_tmp "
   PREPARE upd_xcba009_prep1 FROM l_sql
   DECLARE upd_xcba009_curs1 CURSOR FOR upd_xcba009_prep1
   LET l_sql = "SELECT DISTINCT xcba001,xcba004,xcba007 FROM xcba_t ",
               " WHERE xcbaent = ",g_enterprise,
               "   AND xcbald = '",g_xcbl_m.xcblld,"'",
               "   AND xcba002 = ",g_xcbl_m.xcbl002,
               "   AND xcba003 = ",g_xcbl_m.xcbl003,
               "   AND xcba005 = ?",
               "   AND xcba006 = ?"
   PREPARE upd_xcba009_prep2 FROM l_sql
   DECLARE upd_xcba009_curs2 CURSOR FOR upd_xcba009_prep2
   
    FOREACH upd_xcba009_curs1 INTO l_xcba.xcba005,l_xcba.xcba006  
      FOREACH upd_xcba009_curs2 USING l_xcba.xcba005,l_xcba.xcba006 INTO l_xcba.xcba001,l_xcba.xcba004,l_xcba.xcba007
         CALL s_date_get_ymtodate(g_xcbl_m.xcbl002,g_xcbl_m.xcbl003,g_xcbl_m.xcbl002,g_xcbl_m.xcbl003) 
            RETURNING l_bdate,l_edate
         #依據分攤公式式抓取對應的數值：
         #到axct200，用法人組織=畫面帳套對應的法人、日期在該年度期別範圍內、成本中心=上面抓到的成本中心
         #a.當分攤公式=4.產出數量*分攤權數，數值=SUM(入庫數量)
         #b.當分攤公式=6.標準工時*分攤權數，數值=SUM(標準工時)
         #c.當分攤公式=7.實際工時*分攤權數，數值=SUM(實際工時)
         #d.當分攤公式=8.標準機時*分攤權數，數值=SUM(標準機時)
         #e.當分攤公式=9.實際機時*分攤權數，數值=SUM(實際機時)
         #对应成本中心的数量
         SELECT NVL(SUM(xcbi100),0),NVL(SUM(xcbi203),0),NVL(SUM(xcbi201),0),NVL(SUM(xcbi204),0),NVL(SUM(xcbi202),0)
           INTO l_xcbi100,l_xcbi203,l_xcbi201,l_xcbi204,l_xcbi202
           FROM xcbi_t,xcbh_t WHERE xcbient = g_enterprise
            AND xcbisite = g_site
            AND xcbicomp = g_glaacomp
            AND xcbi001 = l_xcba.xcba004
            AND xcbient = xcbhent
            AND xcbidocno = xcbhdocno
            AND xcbh001 BETWEEN l_bdate AND l_edate 
            AND xcbhstus = 'Y'
          #所有成本中心的数量  
          SELECT NVL(SUM(xcbi100),0),NVL(SUM(xcbi203),0),NVL(SUM(xcbi201),0),NVL(SUM(xcbi204),0),NVL(SUM(xcbi202),0)
           INTO l_xcbi100_sum,l_xcbi203_sum,l_xcbi201_sum,l_xcbi204_sum,l_xcbi202_sum
           FROM xcbi_t,xcbh_t WHERE xcbient = g_enterprise
            AND xcbisite = g_site
            AND xcbicomp = g_glaacomp
            AND xcbient = xcbhent
            AND xcbidocno = xcbhdocno
            AND xcbh001 BETWEEN l_bdate AND l_edate
            AND xcbhstus = 'Y'            
         #合计为0则不计算分摊权数         
         IF l_xcbi100_sum = 0 AND l_xcbi203_sum = 0 AND l_xcbi201_sum = 0 AND l_xcbi204_sum = 0 AND l_xcbi202_sum = 0 THEN 
            CONTINUE FOREACH 
         END IF 
         #分攤權數%=每筆對應的數值/SUM(相同的帳套+年度+期別+科目編號+部門編號的數值) * 100
         CASE l_xcba.xcba007
            WHEN '4'
               LET l_percent = (l_xcbi100 / l_xcbi100_sum) * 100
            WHEN '6'
               LET l_percent = (l_xcbi203 / l_xcbi203_sum) * 100
            WHEN '7'
               LET l_percent = (l_xcbi201 / l_xcbi201_sum) * 100
            WHEN '8'
               LET l_percent = (l_xcbi204 / l_xcbi204_sum) * 100
            WHEN '9'
               LET l_percent = (l_xcbi202 / l_xcbi202_sum) * 100
         END CASE
         LET l_datetime = cl_get_current()
         #更新对应分摊权数
         UPDATE xcba_t SET xcba009 = l_percent,
                           xcbamoddt = l_datetime,
                           xcbamodid = g_user
                     WHERE xcbaent = g_enterprise
                        AND xcbald  = g_xcbl_m.xcblld
                        AND xcba001 = l_xcba.xcba001
                        AND xcba002 = g_xcbl_m.xcbl002
                        AND xcba003 = g_xcbl_m.xcbl003
                        AND xcba004 = l_xcba.xcba004
                        AND xcba005 = l_xcba.xcba005
                        AND xcba006 = l_xcba.xcba006
                        AND xcba007 = l_xcba.xcba007
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "update xcba_t"
             LET g_errparam.popup = TRUE
             CALL cl_err()
             CALL s_transaction_end('N','0')
             DROP TABLE axct201_tmp;
             RETURN
          END IF
      END FOREACH
      #尾差處理：若帳套+年度+期別+科目編號+部門編號的分攤權數%的總合 <> 100，則將尾差放在分攤權數%最大的一筆(有多筆時取第一筆)
      SELECT NVL(SUM(xcba009),0) INTO l_xcba.xcba009 
        FROM xcba_t
       WHERE xcbaent = g_enterprise
         AND xcbald  = g_xcbl_m.xcblld
         AND xcba002 = g_xcbl_m.xcbl002
         AND xcba003 = g_xcbl_m.xcbl003
         AND xcba005 = l_xcba.xcba005
         AND xcba006 = l_xcba.xcba006
      IF l_xcba.xcba009 != 100 THEN
         LET l_datetime = cl_get_current()
         UPDATE xcba_t SET xcba009 = xcba009 + (100 - l_xcba.xcba009),
                           xcbamoddt = l_datetime,
                           xcbamodid = g_user
                     WHERE xcbaent = g_enterprise
                        AND xcbald  = g_xcbl_m.xcblld
                        AND xcba002 = g_xcbl_m.xcbl002
                        AND xcba003 = g_xcbl_m.xcbl003
                        AND xcba005 = l_xcba.xcba005
                        AND xcba006 = l_xcba.xcba006
                        AND xcba009 = (SELECT MAX(xcba009) FROM xcba_t
                                        WHERE xcbaent = g_enterprise
                                          AND xcbald  = g_xcbl_m.xcblld
                                          AND xcba002 = g_xcbl_m.xcbl002
                                          AND xcba003 = g_xcbl_m.xcbl003
                                          AND xcba005 = l_xcba.xcba005
                                          AND xcba006 = l_xcba.xcba006)
                        AND ROWNUM = 1   #只取一笔
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "update xcba_t"
             LET g_errparam.popup = TRUE
             CALL cl_err()
             CALL s_transaction_end('N','0')
             DROP TABLE axct201_tmp;
             RETURN
          END IF
      END IF
   END FOREACH
   CALL s_transaction_end('Y','0')
   DROP TABLE axct201_tmp;
END FUNCTION

 
{</section>}
 
