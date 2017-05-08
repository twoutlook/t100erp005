#該程式未解開Section, 採用最新樣板產出!
{<section id="afat503_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2015-03-05 10:01:30), PR版次:0015(2017-02-20 10:14:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000209
#+ Filename...: afat503_01
#+ Description: 科目與核算項明細
#+ Creator....: 02599(2014-07-25 17:53:48)
#+ Modifier...: 02003 -SD/PR- 07900
 
{</section>}
 
{<section id="afat503_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#151105-00001#2   2015/11/05  By Jessy    單身卡片編號後增加欄位"主要類型",要可下條件
#150916-00015#1   2015/12/7   By Xiaozg   1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#160321-00016#26  2016/03/24  By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00005#11  2016/03/25  by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160129-00015#13  2016/04/20  By 01531    效能优化
#160318-00025#12  2016/04/26  By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160913-00017#1   2016/09/21  By 07900    AGL模组调整交易客商开窗
#161024-00008#4   2016/10/27  By Hans     AFA組織類型與職能開窗清單調整。
#161101-00071#1   2016/11/11  By 01531    自由核算项维护后无法显示
#161115-00003#1   2016/11/18 By 07900     增加显示保管人员，保管部门，串上faah表使 保管人员，保管部门 下qbe条件
#161111-00028#7   2016/11/24 by 02481       标准程式定义采用宣告模式,弃用.*写法
#161221-00054#4   2017/02/17  By 07900    相關單身(會計科目+部門) 及傳票預覽( 會計科目+部門), 要擋<<科目拒絕部門>> 參照agli060擋拒絕部門設定 
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_fabh_d        RECORD
       fabhseq LIKE fabh_t.fabhseq, 
   fabh021 LIKE fabh_t.fabh021, 
   fabh021_desc LIKE type_t.chr500, 
   fabh022 LIKE fabh_t.fabh022, 
   fabh022_desc LIKE type_t.chr500, 
   fabh036 LIKE fabh_t.fabh036, 
   fabh026 LIKE fabh_t.fabh026, 
   fabh026_desc LIKE type_t.chr500, 
   fabh027 LIKE fabh_t.fabh027, 
   fabh027_desc LIKE type_t.chr500, 
   fabh028 LIKE fabh_t.fabh028, 
   fabh028_desc LIKE type_t.chr500, 
   fabh029 LIKE fabh_t.fabh029, 
   fabh029_desc LIKE type_t.chr500, 
   fabh030 LIKE fabh_t.fabh030, 
   fabh030_desc LIKE type_t.chr500, 
   fabh031 LIKE fabh_t.fabh031, 
   fabh031_desc LIKE type_t.chr500, 
   fabh032 LIKE fabh_t.fabh032, 
   fabh032_desc LIKE type_t.chr500, 
   fabh033 LIKE fabh_t.fabh033, 
   fabh033_desc LIKE type_t.chr500, 
   fabh034 LIKE fabh_t.fabh034, 
   fabh034_desc LIKE type_t.chr500, 
   fabh035 LIKE fabh_t.fabh035, 
   fabh035_desc LIKE type_t.chr500, 
   fabh041 LIKE fabh_t.fabh041, 
   fabh042 LIKE fabh_t.fabh042, 
   fabh042_desc LIKE type_t.chr500, 
   fabh043 LIKE fabh_t.fabh043, 
   fabh043_desc LIKE type_t.chr500, 
   fabh060 LIKE fabh_t.fabh060, 
   fabh060_desc LIKE type_t.chr500, 
   fabh061 LIKE fabh_t.fabh061, 
   fabh061_desc LIKE type_t.chr500, 
   fabh062 LIKE fabh_t.fabh062, 
   fabh062_desc LIKE type_t.chr500, 
   fabh063 LIKE fabh_t.fabh063, 
   fabh063_desc LIKE type_t.chr500, 
   fabh064 LIKE fabh_t.fabh064, 
   fabh064_desc LIKE type_t.chr500, 
   fabh065 LIKE fabh_t.fabh065, 
   fabh065_desc LIKE type_t.chr500, 
   fabh066 LIKE fabh_t.fabh066, 
   fabh066_desc LIKE type_t.chr500, 
   fabh067 LIKE fabh_t.fabh067, 
   fabh067_desc LIKE type_t.chr500, 
   fabh068 LIKE fabh_t.fabh068, 
   fabh068_desc LIKE type_t.chr500, 
   fabh069 LIKE fabh_t.fabh069, 
   fabh069_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_loc                 LIKE type_t.chr5 
DEFINE g_fabh2_d             DYNAMIC ARRAY OF type_g_fabh_d
DEFINE g_fabh2_d_t           type_g_fabh_d
GLOBALS
   DEFINE p_prog             LIKE type_t.chr20
   DEFINE g_wc_subject       STRING
   DEFINE g_wc_d             STRING
   DEFINE g_fabgld           LIKE fabg_t.fabgld
   DEFINE g_fabgdocno        LIKE fabg_t.fabgdocno
   DEFINE g_fabhseq          LIKE fabh_t.fabhseq
   DEFINE g_fabgld_o         LIKE fabg_t.fabgld
   DEFINE g_fabgdocno_o      LIKE fabg_t.fabgdocno
   DEFINE g_fabhseq_o        LIKE fabh_t.fabhseq
   DEFINE g_detail_insert    LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete    LIKE type_t.num5   #單身的刪除權限
   DEFINE g_fabh_d2          DYNAMIC ARRAY OF type_g_fabh_d
END GLOBALS
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_sql                 STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_error_show          LIKE type_t.num5              #
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數   
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
DEFINE g_glaald              LIKE glaa_t.glaald
DEFINE g_glaa004             LIKE glaa_t.glaa004
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL  
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
DEFINE l_insert              BOOLEAN
DEFINE l_cmd                 LIKE type_t.chr1
DEFINE l_n                   LIKE type_t.num5              #檢查重複用
DEFINE l_count               LIKE type_t.num5
DEFINE l_lock_sw             LIKE type_t.chr1              #單身鎖住否
DEFINE lb_reproduce          BOOLEAN
DEFINE li_reproduce          LIKE type_t.num5
DEFINE li_reproduce_target   LIKE type_t.num5
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_fabgdocdt           LIKE fabg_t.fabgdocdt
DEFINE g_faaj001             LIKE faaj_t.faaj001           #核算项财产编号
DEFINE g_faaj002             LIKE faaj_t.faaj002           #核算项附号
DEFINE g_faaj037             LIKE faaj_t.faaj037           #核算项卡片编号
#end add-point
 
DEFINE g_fabh_d          DYNAMIC ARRAY OF type_g_fabh_d
DEFINE g_fabh_d_t        type_g_fabh_d
 
 
DEFINE g_fabhld_t   LIKE fabh_t.fabhld    #Key值備份
DEFINE g_fabhdocno_t      LIKE fabh_t.fabhdocno    #Key值備份
DEFINE g_fabhseq_t      LIKE fabh_t.fabhseq    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point    
 
{</section>}
 
{<section id="afat503_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION afat503_01(--)
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
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
    DEFINE l_sql                  STRING
    DEFINE l_glaa004              LIKE  glaa_t.glaa004 
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_afat503_01 WITH FORM cl_ap_formpath("afa","afat503_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('fabh041','6013') #20150114 add by chenying
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_fabh_d FROM s_detail1_afat503_01.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
           
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabhseq_2
            #add-point:BEFORE FIELD fabhseq_2 name="input.b.page1_afat503_01.fabhseq_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabhseq_2
            
            #add-point:AFTER FIELD fabhseq_2 name="input.a.page1_afat503_01.fabhseq_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabhseq_2
            #add-point:ON CHANGE fabhseq_2 name="input.g.page1_afat503_01.fabhseq_2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh021
            
            #add-point:AFTER FIELD fabh021 name="input.a.page1_afat503_01.fabh021"
            IF NOT cl_null(g_fabh2_d[l_ac].fabh021) THEN 
                 #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511202
              LET l_sql = " "
              IF  s_aglt310_getlike_lc_subject(g_fabgld,g_fabh_d[l_ac].fabh021,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_fabgld
                 LET g_qryparam.state = 'i'
                 LET g_qryparam.reqry = 'FALSE'
                 LET g_qryparam.default1 = g_fabh_d[l_ac].fabh021
                 
                 LET g_qryparam.arg1 = l_glaa004
                 LET g_qryparam.arg2 = g_fabh_d[l_ac].fabh021
                 LET g_qryparam.arg3 = g_fabgld
                 LET g_qryparam.arg4 = "1 "
                 CALL q_glac002_6()
                 LET g_fabh2_d[l_ac].fabh021 = g_qryparam.return1              

                 DISPLAY g_fabh2_d[l_ac].fabh021 TO fabh021              #
                 CALL afat503_01_fabh021_desc(g_fabh2_d[l_ac].fabh021)
              END IF
              IF  NOT s_aglt310_lc_subject(g_fabgld,g_fabh_d[l_ac].fabh021,'N') THEN   
                  NEXT FIELD CURRENT
              END IF
           #  150916-00015#1 END
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg2 = '參數2'
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
               #160318-00025#12--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_glac002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabh2_d[l_ac].fabh021
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001='' AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabh2_d[l_ac].fabh021_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh021_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh021
            #add-point:BEFORE FIELD fabh021 name="input.b.page1_afat503_01.fabh021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh021
            #add-point:ON CHANGE fabh021 name="input.g.page1_afat503_01.fabh021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh021_desc
            #add-point:BEFORE FIELD fabh021_desc name="input.b.page1_afat503_01.fabh021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh021_desc
            
            #add-point:AFTER FIELD fabh021_desc name="input.a.page1_afat503_01.fabh021_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh021_desc
            #add-point:ON CHANGE fabh021_desc name="input.g.page1_afat503_01.fabh021_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh022
            
            #add-point:AFTER FIELD fabh022 name="input.a.page1_afat503_01.fabh022"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh022
            #add-point:BEFORE FIELD fabh022 name="input.b.page1_afat503_01.fabh022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh022
            #add-point:ON CHANGE fabh022 name="input.g.page1_afat503_01.fabh022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh022_desc
            #add-point:BEFORE FIELD fabh022_desc name="input.b.page1_afat503_01.fabh022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh022_desc
            
            #add-point:AFTER FIELD fabh022_desc name="input.a.page1_afat503_01.fabh022_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh022_desc
            #add-point:ON CHANGE fabh022_desc name="input.g.page1_afat503_01.fabh022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh036
            #add-point:BEFORE FIELD fabh036 name="input.b.page1_afat503_01.fabh036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh036
            
            #add-point:AFTER FIELD fabh036 name="input.a.page1_afat503_01.fabh036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh036
            #add-point:ON CHANGE fabh036 name="input.g.page1_afat503_01.fabh036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh026
            #add-point:BEFORE FIELD fabh026 name="input.b.page1_afat503_01.fabh026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh026
            
            #add-point:AFTER FIELD fabh026 name="input.a.page1_afat503_01.fabh026"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabh2_d[l_ac].fabh026
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabh2_d[l_ac].fabh026_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh026_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh026
            #add-point:ON CHANGE fabh026 name="input.g.page1_afat503_01.fabh026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh026_desc
            #add-point:BEFORE FIELD fabh026_desc name="input.b.page1_afat503_01.fabh026_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh026_desc
            
            #add-point:AFTER FIELD fabh026_desc name="input.a.page1_afat503_01.fabh026_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh026_desc
            #add-point:ON CHANGE fabh026_desc name="input.g.page1_afat503_01.fabh026_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh027
            #add-point:BEFORE FIELD fabh027 name="input.b.page1_afat503_01.fabh027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh027
            
            #add-point:AFTER FIELD fabh027 name="input.a.page1_afat503_01.fabh027"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabh2_d[l_ac].fabh027
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabh2_d[l_ac].fabh027_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh027_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh027
            #add-point:ON CHANGE fabh027 name="input.g.page1_afat503_01.fabh027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh027_desc
            #add-point:BEFORE FIELD fabh027_desc name="input.b.page1_afat503_01.fabh027_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh027_desc
            
            #add-point:AFTER FIELD fabh027_desc name="input.a.page1_afat503_01.fabh027_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh027_desc
            #add-point:ON CHANGE fabh027_desc name="input.g.page1_afat503_01.fabh027_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh028
            #add-point:BEFORE FIELD fabh028 name="input.b.page1_afat503_01.fabh028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh028
            
            #add-point:AFTER FIELD fabh028 name="input.a.page1_afat503_01.fabh028"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabh2_d[l_ac].fabh028
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabh2_d[l_ac].fabh028_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh028_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh028
            #add-point:ON CHANGE fabh028 name="input.g.page1_afat503_01.fabh028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh028_desc
            #add-point:BEFORE FIELD fabh028_desc name="input.b.page1_afat503_01.fabh028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh028_desc
            
            #add-point:AFTER FIELD fabh028_desc name="input.a.page1_afat503_01.fabh028_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh028_desc
            #add-point:ON CHANGE fabh028_desc name="input.g.page1_afat503_01.fabh028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh029
            #add-point:BEFORE FIELD fabh029 name="input.b.page1_afat503_01.fabh029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh029
            
            #add-point:AFTER FIELD fabh029 name="input.a.page1_afat503_01.fabh029"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabh2_d[l_ac].fabh029
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='287' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabh2_d[l_ac].fabh029_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh029_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh029
            #add-point:ON CHANGE fabh029 name="input.g.page1_afat503_01.fabh029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh029_desc
            #add-point:BEFORE FIELD fabh029_desc name="input.b.page1_afat503_01.fabh029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh029_desc
            
            #add-point:AFTER FIELD fabh029_desc name="input.a.page1_afat503_01.fabh029_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh029_desc
            #add-point:ON CHANGE fabh029_desc name="input.g.page1_afat503_01.fabh029_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh030
            #add-point:BEFORE FIELD fabh030 name="input.b.page1_afat503_01.fabh030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh030
            
            #add-point:AFTER FIELD fabh030 name="input.a.page1_afat503_01.fabh030"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabh2_d[l_ac].fabh030
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabh2_d[l_ac].fabh030_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh030_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh030
            #add-point:ON CHANGE fabh030 name="input.g.page1_afat503_01.fabh030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh030_desc
            #add-point:BEFORE FIELD fabh030_desc name="input.b.page1_afat503_01.fabh030_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh030_desc
            
            #add-point:AFTER FIELD fabh030_desc name="input.a.page1_afat503_01.fabh030_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh030_desc
            #add-point:ON CHANGE fabh030_desc name="input.g.page1_afat503_01.fabh030_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh031
            #add-point:BEFORE FIELD fabh031 name="input.b.page1_afat503_01.fabh031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh031
            
            #add-point:AFTER FIELD fabh031 name="input.a.page1_afat503_01.fabh031"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabh2_d[l_ac].fabh031
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabh2_d[l_ac].fabh031_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh031_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh031
            #add-point:ON CHANGE fabh031 name="input.g.page1_afat503_01.fabh031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh031_desc
            #add-point:BEFORE FIELD fabh031_desc name="input.b.page1_afat503_01.fabh031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh031_desc
            
            #add-point:AFTER FIELD fabh031_desc name="input.a.page1_afat503_01.fabh031_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh031_desc
            #add-point:ON CHANGE fabh031_desc name="input.g.page1_afat503_01.fabh031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh032
            #add-point:BEFORE FIELD fabh032 name="input.b.page1_afat503_01.fabh032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh032
            
            #add-point:AFTER FIELD fabh032 name="input.a.page1_afat503_01.fabh032"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabh2_d[l_ac].fabh032
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabh2_d[l_ac].fabh032_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh032_desc


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh032
            #add-point:ON CHANGE fabh032 name="input.g.page1_afat503_01.fabh032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh032_desc
            #add-point:BEFORE FIELD fabh032_desc name="input.b.page1_afat503_01.fabh032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh032_desc
            
            #add-point:AFTER FIELD fabh032_desc name="input.a.page1_afat503_01.fabh032_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh032_desc
            #add-point:ON CHANGE fabh032_desc name="input.g.page1_afat503_01.fabh032_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh033
            #add-point:BEFORE FIELD fabh033 name="input.b.page1_afat503_01.fabh033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh033
            
            #add-point:AFTER FIELD fabh033 name="input.a.page1_afat503_01.fabh033"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh033
            #add-point:ON CHANGE fabh033 name="input.g.page1_afat503_01.fabh033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh033_desc
            #add-point:BEFORE FIELD fabh033_desc name="input.b.page1_afat503_01.fabh033_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh033_desc
            
            #add-point:AFTER FIELD fabh033_desc name="input.a.page1_afat503_01.fabh033_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh033_desc
            #add-point:ON CHANGE fabh033_desc name="input.g.page1_afat503_01.fabh033_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh034
            #add-point:BEFORE FIELD fabh034 name="input.b.page1_afat503_01.fabh034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh034
            
            #add-point:AFTER FIELD fabh034 name="input.a.page1_afat503_01.fabh034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh034
            #add-point:ON CHANGE fabh034 name="input.g.page1_afat503_01.fabh034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh034_desc
            #add-point:BEFORE FIELD fabh034_desc name="input.b.page1_afat503_01.fabh034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh034_desc
            
            #add-point:AFTER FIELD fabh034_desc name="input.a.page1_afat503_01.fabh034_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh034_desc
            #add-point:ON CHANGE fabh034_desc name="input.g.page1_afat503_01.fabh034_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh035
            #add-point:BEFORE FIELD fabh035 name="input.b.page1_afat503_01.fabh035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh035
            
            #add-point:AFTER FIELD fabh035 name="input.a.page1_afat503_01.fabh035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh035
            #add-point:ON CHANGE fabh035 name="input.g.page1_afat503_01.fabh035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh035_desc
            #add-point:BEFORE FIELD fabh035_desc name="input.b.page1_afat503_01.fabh035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh035_desc
            
            #add-point:AFTER FIELD fabh035_desc name="input.a.page1_afat503_01.fabh035_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh035_desc
            #add-point:ON CHANGE fabh035_desc name="input.g.page1_afat503_01.fabh035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh041
            #add-point:BEFORE FIELD fabh041 name="input.b.page1_afat503_01.fabh041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh041
            
            #add-point:AFTER FIELD fabh041 name="input.a.page1_afat503_01.fabh041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh041
            #add-point:ON CHANGE fabh041 name="input.g.page1_afat503_01.fabh041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh042
            #add-point:BEFORE FIELD fabh042 name="input.b.page1_afat503_01.fabh042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh042
            
            #add-point:AFTER FIELD fabh042 name="input.a.page1_afat503_01.fabh042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh042
            #add-point:ON CHANGE fabh042 name="input.g.page1_afat503_01.fabh042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh042_desc
            #add-point:BEFORE FIELD fabh042_desc name="input.b.page1_afat503_01.fabh042_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh042_desc
            
            #add-point:AFTER FIELD fabh042_desc name="input.a.page1_afat503_01.fabh042_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh042_desc
            #add-point:ON CHANGE fabh042_desc name="input.g.page1_afat503_01.fabh042_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh043
            #add-point:BEFORE FIELD fabh043 name="input.b.page1_afat503_01.fabh043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh043
            
            #add-point:AFTER FIELD fabh043 name="input.a.page1_afat503_01.fabh043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh043
            #add-point:ON CHANGE fabh043 name="input.g.page1_afat503_01.fabh043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh043_desc
            #add-point:BEFORE FIELD fabh043_desc name="input.b.page1_afat503_01.fabh043_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh043_desc
            
            #add-point:AFTER FIELD fabh043_desc name="input.a.page1_afat503_01.fabh043_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh043_desc
            #add-point:ON CHANGE fabh043_desc name="input.g.page1_afat503_01.fabh043_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh060
            #add-point:BEFORE FIELD fabh060 name="input.b.page1_afat503_01.fabh060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh060
            
            #add-point:AFTER FIELD fabh060 name="input.a.page1_afat503_01.fabh060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh060
            #add-point:ON CHANGE fabh060 name="input.g.page1_afat503_01.fabh060"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh060_desc
            #add-point:BEFORE FIELD fabh060_desc name="input.b.page1_afat503_01.fabh060_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh060_desc
            
            #add-point:AFTER FIELD fabh060_desc name="input.a.page1_afat503_01.fabh060_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh060_desc
            #add-point:ON CHANGE fabh060_desc name="input.g.page1_afat503_01.fabh060_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh061
            #add-point:BEFORE FIELD fabh061 name="input.b.page1_afat503_01.fabh061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh061
            
            #add-point:AFTER FIELD fabh061 name="input.a.page1_afat503_01.fabh061"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh061
            #add-point:ON CHANGE fabh061 name="input.g.page1_afat503_01.fabh061"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh061_desc
            #add-point:BEFORE FIELD fabh061_desc name="input.b.page1_afat503_01.fabh061_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh061_desc
            
            #add-point:AFTER FIELD fabh061_desc name="input.a.page1_afat503_01.fabh061_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh061_desc
            #add-point:ON CHANGE fabh061_desc name="input.g.page1_afat503_01.fabh061_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh062
            #add-point:BEFORE FIELD fabh062 name="input.b.page1_afat503_01.fabh062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh062
            
            #add-point:AFTER FIELD fabh062 name="input.a.page1_afat503_01.fabh062"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh062
            #add-point:ON CHANGE fabh062 name="input.g.page1_afat503_01.fabh062"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh062_desc
            #add-point:BEFORE FIELD fabh062_desc name="input.b.page1_afat503_01.fabh062_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh062_desc
            
            #add-point:AFTER FIELD fabh062_desc name="input.a.page1_afat503_01.fabh062_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh062_desc
            #add-point:ON CHANGE fabh062_desc name="input.g.page1_afat503_01.fabh062_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh063
            #add-point:BEFORE FIELD fabh063 name="input.b.page1_afat503_01.fabh063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh063
            
            #add-point:AFTER FIELD fabh063 name="input.a.page1_afat503_01.fabh063"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh063
            #add-point:ON CHANGE fabh063 name="input.g.page1_afat503_01.fabh063"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh063_desc
            #add-point:BEFORE FIELD fabh063_desc name="input.b.page1_afat503_01.fabh063_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh063_desc
            
            #add-point:AFTER FIELD fabh063_desc name="input.a.page1_afat503_01.fabh063_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh063_desc
            #add-point:ON CHANGE fabh063_desc name="input.g.page1_afat503_01.fabh063_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh064
            #add-point:BEFORE FIELD fabh064 name="input.b.page1_afat503_01.fabh064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh064
            
            #add-point:AFTER FIELD fabh064 name="input.a.page1_afat503_01.fabh064"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh064
            #add-point:ON CHANGE fabh064 name="input.g.page1_afat503_01.fabh064"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh064_desc
            #add-point:BEFORE FIELD fabh064_desc name="input.b.page1_afat503_01.fabh064_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh064_desc
            
            #add-point:AFTER FIELD fabh064_desc name="input.a.page1_afat503_01.fabh064_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh064_desc
            #add-point:ON CHANGE fabh064_desc name="input.g.page1_afat503_01.fabh064_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh065
            #add-point:BEFORE FIELD fabh065 name="input.b.page1_afat503_01.fabh065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh065
            
            #add-point:AFTER FIELD fabh065 name="input.a.page1_afat503_01.fabh065"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh065
            #add-point:ON CHANGE fabh065 name="input.g.page1_afat503_01.fabh065"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh065_desc
            #add-point:BEFORE FIELD fabh065_desc name="input.b.page1_afat503_01.fabh065_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh065_desc
            
            #add-point:AFTER FIELD fabh065_desc name="input.a.page1_afat503_01.fabh065_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh065_desc
            #add-point:ON CHANGE fabh065_desc name="input.g.page1_afat503_01.fabh065_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh066
            #add-point:BEFORE FIELD fabh066 name="input.b.page1_afat503_01.fabh066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh066
            
            #add-point:AFTER FIELD fabh066 name="input.a.page1_afat503_01.fabh066"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh066
            #add-point:ON CHANGE fabh066 name="input.g.page1_afat503_01.fabh066"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh066_desc
            #add-point:BEFORE FIELD fabh066_desc name="input.b.page1_afat503_01.fabh066_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh066_desc
            
            #add-point:AFTER FIELD fabh066_desc name="input.a.page1_afat503_01.fabh066_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh066_desc
            #add-point:ON CHANGE fabh066_desc name="input.g.page1_afat503_01.fabh066_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh067
            #add-point:BEFORE FIELD fabh067 name="input.b.page1_afat503_01.fabh067"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh067
            
            #add-point:AFTER FIELD fabh067 name="input.a.page1_afat503_01.fabh067"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh067
            #add-point:ON CHANGE fabh067 name="input.g.page1_afat503_01.fabh067"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh067_desc
            #add-point:BEFORE FIELD fabh067_desc name="input.b.page1_afat503_01.fabh067_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh067_desc
            
            #add-point:AFTER FIELD fabh067_desc name="input.a.page1_afat503_01.fabh067_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh067_desc
            #add-point:ON CHANGE fabh067_desc name="input.g.page1_afat503_01.fabh067_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh068
            #add-point:BEFORE FIELD fabh068 name="input.b.page1_afat503_01.fabh068"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh068
            
            #add-point:AFTER FIELD fabh068 name="input.a.page1_afat503_01.fabh068"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh068
            #add-point:ON CHANGE fabh068 name="input.g.page1_afat503_01.fabh068"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh068_desc
            #add-point:BEFORE FIELD fabh068_desc name="input.b.page1_afat503_01.fabh068_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh068_desc
            
            #add-point:AFTER FIELD fabh068_desc name="input.a.page1_afat503_01.fabh068_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh068_desc
            #add-point:ON CHANGE fabh068_desc name="input.g.page1_afat503_01.fabh068_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh069
            #add-point:BEFORE FIELD fabh069 name="input.b.page1_afat503_01.fabh069"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh069
            
            #add-point:AFTER FIELD fabh069 name="input.a.page1_afat503_01.fabh069"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh069
            #add-point:ON CHANGE fabh069 name="input.g.page1_afat503_01.fabh069"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh069_desc
            #add-point:BEFORE FIELD fabh069_desc name="input.b.page1_afat503_01.fabh069_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh069_desc
            
            #add-point:AFTER FIELD fabh069_desc name="input.a.page1_afat503_01.fabh069_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh069_desc
            #add-point:ON CHANGE fabh069_desc name="input.g.page1_afat503_01.fabh069_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1_afat503_01.fabhseq_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabhseq_2
            #add-point:ON ACTION controlp INFIELD fabhseq_2 name="input.c.page1_afat503_01.fabhseq_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh021
            #add-point:ON ACTION controlp INFIELD fabh021 name="input.c.page1_afat503_01.fabh021"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh021 = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh021 TO fabh021              #

            NEXT FIELD fabh021                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh021_desc
            #add-point:ON ACTION controlp INFIELD fabh021_desc name="input.c.page1_afat503_01.fabh021_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh022
            #add-point:ON ACTION controlp INFIELD fabh022 name="input.c.page1_afat503_01.fabh022"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh022 = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh022 TO fabh021              #

            NEXT FIELD fabh022                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh022_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh022_desc
            #add-point:ON ACTION controlp INFIELD fabh022_desc name="input.c.page1_afat503_01.fabh022_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh036
            #add-point:ON ACTION controlp INFIELD fabh036 name="input.c.page1_afat503_01.fabh036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh026
            #add-point:ON ACTION controlp INFIELD fabh026 name="input.c.page1_afat503_01.fabh026"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh026             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            #CALL q_ooed004_1()                                #呼叫開窗
            CALL q_ooef001_1()                                          #161024-00008#4 

            LET g_fabh2_d[l_ac].fabh026 = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh026 TO fabh026              #

            NEXT FIELD fabh026                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh026_desc
            #add-point:ON ACTION controlp INFIELD fabh026_desc name="input.c.page1_afat503_01.fabh026_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh026_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            #CALL q_ooed004_1()                                         #161024-00008#4 
            CALL q_ooef001_1()                                          #161024-00008#4 

            
            LET g_fabh2_d[l_ac].fabh026_desc = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh026_desc TO fabh026_desc              #

            NEXT FIELD fabh026_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh027
            #add-point:ON ACTION controlp INFIELD fabh027 name="input.c.page1_afat503_01.fabh027"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh027             #給予default值
            LET g_qryparam.default2 = "" #g_fabh2_d[l_ac].ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooeg001()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh027 = g_qryparam.return1              
            #LET g_fabh2_d[l_ac].ooeg001 = g_qryparam.return2 
            DISPLAY g_fabh2_d[l_ac].fabh027 TO fabh027              #
            #DISPLAY g_fabh2_d[l_ac].ooeg001 TO ooeg001 #部門編號
            NEXT FIELD fabh027                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh027_desc
            #add-point:ON ACTION controlp INFIELD fabh027_desc name="input.c.page1_afat503_01.fabh027_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh027_desc             #給予default值
            LET g_qryparam.default2 = "" #g_fabh2_d[l_ac].ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooeg001()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh027_desc = g_qryparam.return1              
            #LET g_fabh2_d[l_ac].ooeg001 = g_qryparam.return2 
            DISPLAY g_fabh2_d[l_ac].fabh027_desc TO fabh027_desc              #
            #DISPLAY g_fabh2_d[l_ac].ooeg001 TO ooeg001 #部門編號
            NEXT FIELD fabh027_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh028
            #add-point:ON ACTION controlp INFIELD fabh028 name="input.c.page1_afat503_01.fabh028"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh028             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooed004_1()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh028 = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh028 TO fabh028              #

            NEXT FIELD fabh028                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh028_desc
            #add-point:ON ACTION controlp INFIELD fabh028_desc name="input.c.page1_afat503_01.fabh028_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh028_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooed004_1()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh028_desc = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh028_desc TO fabh028_desc              #

            NEXT FIELD fabh028_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh029
            #add-point:ON ACTION controlp INFIELD fabh029 name="input.c.page1_afat503_01.fabh029"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh029             #給予default值
            LET g_qryparam.default2 = "" #g_fabh2_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh029 = g_qryparam.return1              
            #LET g_fabh2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabh2_d[l_ac].fabh029 TO fabh029              #
            #DISPLAY g_fabh2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabh029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh029_desc
            #add-point:ON ACTION controlp INFIELD fabh029_desc name="input.c.page1_afat503_01.fabh029_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh029_desc             #給予default值
            LET g_qryparam.default2 = "" #g_fabh2_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh029_desc = g_qryparam.return1              
            #LET g_fabh2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabh2_d[l_ac].fabh029_desc TO fabh029_desc              #
            #DISPLAY g_fabh2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabh029_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh030
            #add-point:ON ACTION controlp INFIELD fabh030 name="input.c.page1_afat503_01.fabh030"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh030             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()      #160913-00017#1  add
            #CALL q_pmaa001()        #160913-00017#1  mark               #呼叫開窗      

            LET g_fabh2_d[l_ac].fabh030 = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh030 TO fabh030              #

            NEXT FIELD fabh030                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh030_desc
            #add-point:ON ACTION controlp INFIELD fabh030_desc name="input.c.page1_afat503_01.fabh030_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh030_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()      #160913-00017#1  add
            #CALL q_pmaa001()        #160913-00017#1  mark               #呼叫開窗      

            LET g_fabh2_d[l_ac].fabh030_desc = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh030_desc TO fabh030_desc              #

            NEXT FIELD fabh030_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh031
            #add-point:ON ACTION controlp INFIELD fabh031 name="input.c.page1_afat503_01.fabh031"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()      #160913-00017#1  add
            #CALL q_pmaa001()        #160913-00017#1  mark               #呼叫開窗      

            LET g_fabh2_d[l_ac].fabh031 = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh031 TO fabh031              #

            NEXT FIELD fabh031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh031_desc
            #add-point:ON ACTION controlp INFIELD fabh031_desc name="input.c.page1_afat503_01.fabh031_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh_d[l_ac].fabh031_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()      #160913-00017#1  add
            #CALL q_pmaa001()        #160913-00017#1  mark               #呼叫開窗      

            LET g_fabh_d[l_ac].fabh031_desc = g_qryparam.return1              

            DISPLAY g_fabh_d[l_ac].fabh031_desc TO fabh031_desc              #

            NEXT FIELD fabh031_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh032
            #add-point:ON ACTION controlp INFIELD fabh032 name="input.c.page1_afat503_01.fabh032"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh032             #給予default值
            LET g_qryparam.default2 = "" #g_fabh2_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh032 = g_qryparam.return1              
            #LET g_fabh2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabh2_d[l_ac].fabh032 TO fabh032              #
            #DISPLAY g_fabh2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabh032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh032_desc
            #add-point:ON ACTION controlp INFIELD fabh032_desc name="input.c.page1_afat503_01.fabh032_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh_d[l_ac].fabh032_desc             #給予default值
            LET g_qryparam.default2 = "" #g_fabh_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabh_d[l_ac].fabh032_desc = g_qryparam.return1              
            #LET g_fabh_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabh_d[l_ac].fabh032_desc TO fabh032_desc              #
            #DISPLAY g_fabh_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabh032_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh033
            #add-point:ON ACTION controlp INFIELD fabh033 name="input.c.page1_afat503_01.fabh033"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh033             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh033 = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh033 TO fabh033              #

            NEXT FIELD fabh033                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh033_desc
            #add-point:ON ACTION controlp INFIELD fabh033_desc name="input.c.page1_afat503_01.fabh033_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh033_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh033_desc = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh033_desc TO fabh033_desc              #

            NEXT FIELD fabh033_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh034
            #add-point:ON ACTION controlp INFIELD fabh034 name="input.c.page1_afat503_01.fabh034"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh034             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh034 = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh034 TO fabh034              #

            NEXT FIELD fabh034                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh034_desc
            #add-point:ON ACTION controlp INFIELD fabh034_desc name="input.c.page1_afat503_01.fabh034_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh_d[l_ac].fabh034_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_fabh_d[l_ac].fabh034_desc = g_qryparam.return1              

            DISPLAY g_fabh_d[l_ac].fabh034_desc TO fabh034_desc              #

            NEXT FIELD fabh034_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh035
            #add-point:ON ACTION controlp INFIELD fabh035 name="input.c.page1_afat503_01.fabh035"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh035             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjbb002()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh035 = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh035 TO fabh035              #

            NEXT FIELD fabh035                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh035_desc
            #add-point:ON ACTION controlp INFIELD fabh035_desc name="input.c.page1_afat503_01.fabh035_desc"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh_d[l_ac].fabh035_desc             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_pjbb002()                                #呼叫開窗

            LET g_fabh_d[l_ac].fabh035_desc = g_qryparam.return1              

            DISPLAY g_fabh_d[l_ac].fabh035_desc TO fabh035_desc              #

            NEXT FIELD fabh035_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh041
            #add-point:ON ACTION controlp INFIELD fabh041 name="input.c.page1_afat503_01.fabh041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh042
            #add-point:ON ACTION controlp INFIELD fabh042 name="input.c.page1_afat503_01.fabh042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh042_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh042_desc
            #add-point:ON ACTION controlp INFIELD fabh042_desc name="input.c.page1_afat503_01.fabh042_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh043
            #add-point:ON ACTION controlp INFIELD fabh043 name="input.c.page1_afat503_01.fabh043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh043_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh043_desc
            #add-point:ON ACTION controlp INFIELD fabh043_desc name="input.c.page1_afat503_01.fabh043_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh060
            #add-point:ON ACTION controlp INFIELD fabh060 name="input.c.page1_afat503_01.fabh060"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh060_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh060_desc
            #add-point:ON ACTION controlp INFIELD fabh060_desc name="input.c.page1_afat503_01.fabh060_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh061
            #add-point:ON ACTION controlp INFIELD fabh061 name="input.c.page1_afat503_01.fabh061"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh061_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh061_desc
            #add-point:ON ACTION controlp INFIELD fabh061_desc name="input.c.page1_afat503_01.fabh061_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh062
            #add-point:ON ACTION controlp INFIELD fabh062 name="input.c.page1_afat503_01.fabh062"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh062_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh062_desc
            #add-point:ON ACTION controlp INFIELD fabh062_desc name="input.c.page1_afat503_01.fabh062_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh063
            #add-point:ON ACTION controlp INFIELD fabh063 name="input.c.page1_afat503_01.fabh063"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh063_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh063_desc
            #add-point:ON ACTION controlp INFIELD fabh063_desc name="input.c.page1_afat503_01.fabh063_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh064
            #add-point:ON ACTION controlp INFIELD fabh064 name="input.c.page1_afat503_01.fabh064"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh064_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh064_desc
            #add-point:ON ACTION controlp INFIELD fabh064_desc name="input.c.page1_afat503_01.fabh064_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh065
            #add-point:ON ACTION controlp INFIELD fabh065 name="input.c.page1_afat503_01.fabh065"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh065_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh065_desc
            #add-point:ON ACTION controlp INFIELD fabh065_desc name="input.c.page1_afat503_01.fabh065_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh066
            #add-point:ON ACTION controlp INFIELD fabh066 name="input.c.page1_afat503_01.fabh066"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh066_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh066_desc
            #add-point:ON ACTION controlp INFIELD fabh066_desc name="input.c.page1_afat503_01.fabh066_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh067
            #add-point:ON ACTION controlp INFIELD fabh067 name="input.c.page1_afat503_01.fabh067"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh067_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh067_desc
            #add-point:ON ACTION controlp INFIELD fabh067_desc name="input.c.page1_afat503_01.fabh067_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh068
            #add-point:ON ACTION controlp INFIELD fabh068 name="input.c.page1_afat503_01.fabh068"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh068_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh068_desc
            #add-point:ON ACTION controlp INFIELD fabh068_desc name="input.c.page1_afat503_01.fabh068_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh069
            #add-point:ON ACTION controlp INFIELD fabh069 name="input.c.page1_afat503_01.fabh069"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afat503_01.fabh069_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh069_desc
            #add-point:ON ACTION controlp INFIELD fabh069_desc name="input.c.page1_afat503_01.fabh069_desc"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel name="input.cancel"
         
         #end add-point
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
   CLOSE WINDOW w_afat503_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afat503_01.other_dialog" readonly="Y" >}

################################################################################
# Descriptions...: 顯示科目與核算項
# Memo...........:
# Usage..........: CALL afat503_01_display()
# Modify.........:
################################################################################
DIALOG afat503_01_display()
   DISPLAY ARRAY g_fabh2_d TO s_detail1_afat503_01.* ATTRIBUTES(COUNT=g_rec_b) 
      
      BEFORE ROW
         LET l_ac = DIALOG.getCurrentRow("s_detail1_afat503_01")
         LET g_detail_idx = l_ac
               
      BEFORE DISPLAY
         IF g_loc = 'm' THEN
            CALL FGL_SET_ARR_CURR(g_detail_idx)
         END IF
         LET g_loc = 'm'
         LET l_ac = DIALOG.getCurrentRow("s_detail1_afat503_01")
         LET g_current_page = 2  

      AFTER DISPLAY
         LET g_fabh_d2.* = g_fabh2_d.*
   END DISPLAY
END DIALOG

################################################################################
# Descriptions...: 录入科目與核算項
# Memo...........:
# Usage..........: CALL afat503_01_input()
# Modify.........:
################################################################################
DIALOG afat503_01_input()
   DEFINE l_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL  
   DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
   DEFINE l_insert              BOOLEAN
   DEFINE l_cmd                 LIKE type_t.chr1
   DEFINE l_n                   LIKE type_t.num5              #檢查重複用
   DEFINE l_count               LIKE type_t.num5
   DEFINE l_lock_sw             LIKE type_t.chr1              #單身鎖住否
   DEFINE lb_reproduce          BOOLEAN
   DEFINE li_reproduce          LIKE type_t.num5
   DEFINE li_reproduce_target   LIKE type_t.num5
   DEFINE l_success             LIKE type_t.num5 
   DEFINE l_errno               LIKE type_t.chr80   
   DEFINE l_desc                LIKE type_t.chr80     #接受s_get_orga返回值
   DEFINE l_date                LIKE ooed_t.ooed006   #接受s_get_orga返回值
   DEFINE l_fabg005             LIKE fabg_t.fabg005   #單據性質 
   DEFINE l_glaacomp            LIKE glaa_t.glaacomp  #20141109
   DEFINE l_para_data           STRING
  #161111-00028#7--modify---begin-------------
  #DEFINE g_glad                RECORD LIKE glad_t.*
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
   #161111-00028#7--modify---end-------------
   DEFINE l_glae009             LIKE glae_t.glae009
   #161221-00054#4--add--s--
   DEFINE l_wc                   STRING
   DEFINE l_glak_sql             STRING
   #161221-00054#4--add--e--
   
   INPUT ARRAY g_fabh2_d FROM s_detail1_afat503_01.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 

                 DELETE ROW = g_detail_delete,
                 APPEND ROW = g_detail_delete)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
           
            CALL afat503_01_b_fill()
            LET g_rec_b = g_fabh2_d.getLength()
            CALL cl_set_combo_scc('fabh041','6013')  #21050113 add by chenying
            LET g_forupd_sql = " SELECT fabgsite,'',fabg001,'',fabgld,'',fabg002,'',fabg003,'',fabg004,fabg005, 
            fabgdocno,fabgdocdt,fabg008,fabg009,fabg015,fabg016,fabgstus,fabgownid,'',fabgowndp,'',fabgcrtid, 
            '',fabgcrtdp,'',fabgcrtdt,fabgmodid,'',fabgmoddt,fabgcnfid,'',fabgcnfdt,fabgpstid,'',fabgpstdt", 
             
                           " FROM fabg_t",
                           " WHERE fabgent= ? AND fabgld=? AND fabgdocno=? FOR UPDATE"
   
            LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
            LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
            DECLARE afat503_01_cl CURSOR FROM g_forupd_sql      
            
            LET g_forupd_sql = "SELECT fabhseq,fabh021,fabh036,fabh026,'',fabh027,'',fabh028,'',fabh029,'',fabh030,
                               '',fabh031,'',fabh032,'',fabh033,'',fabh034,'',fabh035,'',fabh041,fabh042,'',fabh043,''
                               FROM fabh_t  
                               WHERE fabhent=? AND fabhld=? AND fabhdocno=? AND fabhseq=? FOR UPDATE"

#            LET g_forupd_sql = "SELECT fabhseq,fabh021,fabh036,faajsite,'',faaj039,'',faaj040,'',faaj041,'',faaj042,
#                               '',faaj043,'',faaj044,'',faaj047,'',faaj045,'',faaj046
#                               FROM fabh_t,faaj_t  
#                               WHERE faaj001=fabh001 AND faaj002=fabh002 AND faaj037=fabh000 AND faajent=fabhent
#                               AND fabhent=? AND fabhld=? AND fabhdocno=? AND fabhseq=? FOR UPDATE"
           
            LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
            LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
            DECLARE afat503_01_bcl CURSOR FROM g_forupd_sql
            
            SELECT glaa004 INTO g_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_fabgld
            SELECT fabgdocdt INTO g_fabgdocdt FROM fabg_t 
            WHERE fabgent=g_enterprise AND fabgld=g_fabgld AND fabgdocno=g_fabgdocno
            
            #end add-point
            
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD fabhseq_2
 
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabh2_d[l_ac].* TO NULL 
            INITIALIZE g_fabh2_d_t.* TO NULL 
            
            #add-point:modify段before備份

            #end add-point
            LET g_fabh2_d_t.* = g_fabh2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            
            #add-point:modify段after_set_entry_b

            #end add-point
    
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabh2_d[li_reproduce_target].* = g_fabh2_d[li_reproduce].*
               LET g_fabh2_d[li_reproduce_target].fabhseq = NULL
            END IF
            #公用欄位給值(單身2)
            
            
            #add-point:modify段before insert

            #end add-point  
            
         BEFORE ROW     
            #add-point:modify段before row2

            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN afat503_01_cl USING g_enterprise,g_fabgld,g_fabgdocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat503_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE afat503_01_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            LET g_rec_b = g_fabh2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fabh2_d[l_ac].fabhseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fabh2_d_t.* = g_fabh2_d[l_ac].*  #BACKUP
               #add-point:modify段after_set_entry_b

               #end add-point  
               IF NOT afat503_01_lock_b("fabh_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat503_01_bcl INTO g_fabh2_d[l_ac].fabhseq,g_fabh2_d[l_ac].fabh021, 
                      g_fabh2_d[l_ac].fabh036,
                      g_fabh2_d[l_ac].fabh026,g_fabh2_d[l_ac].fabh026_desc,
                      g_fabh2_d[l_ac].fabh027,g_fabh2_d[l_ac].fabh027_desc,
                      g_fabh2_d[l_ac].fabh028,g_fabh2_d[l_ac].fabh028_desc,
                      g_fabh2_d[l_ac].fabh029,g_fabh2_d[l_ac].fabh029_desc,
                      g_fabh2_d[l_ac].fabh030,g_fabh2_d[l_ac].fabh030_desc,
                      g_fabh2_d[l_ac].fabh031,g_fabh2_d[l_ac].fabh031_desc,
                      g_fabh2_d[l_ac].fabh032,g_fabh2_d[l_ac].fabh032_desc, 
                      g_fabh2_d[l_ac].fabh033,g_fabh2_d[l_ac].fabh033_desc,
                      g_fabh2_d[l_ac].fabh034,g_fabh2_d[l_ac].fabh034_desc,
                      g_fabh2_d[l_ac].fabh035,g_fabh2_d[l_ac].fabh035_desc,
                      g_fabh2_d[l_ac].fabh041,
                      g_fabh2_d[l_ac].fabh042,g_fabh2_d[l_ac].fabh042_desc,
                      g_fabh2_d[l_ac].fabh043,g_fabh2_d[l_ac].fabh043_desc                      
                      
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            #161221-00054#4--add--s--xul
            LET l_wc = g_fabh2_d[l_ac].fabh021
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc
            #161221-00054#4--add--e--xul
            CALL s_fin_sel_glad(g_fabgld,g_fabh2_d[l_ac].fabh021,'ALL') RETURNING g_glad.* #20150115 add by chenying 

            CALL afat503_01_fabh021_desc(g_fabh2_d[l_ac].fabh021)
            IF cl_null(g_fabh2_d[l_ac].fabh021) THEN 
               SELECT fabg005 INTO l_fabg005 FROM fabg_t WHERE fabgent = g_enterprise AND fabgld = g_fabgld AND fabgdocno = g_fabgdocno
               
               IF l_fabg005 = '8' THEN
                  SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
               WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='8' AND glab003='9902_01' 
               END IF
               
               IF l_fabg005 = '9' THEN
                  SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
               WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='9' AND glab003='9902_02' 
               END IF               
               IF l_fabg005 = '23' THEN
                  SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
               WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='23' AND glab003='9902_09' 
               END IF
               IF l_fabg005 = '24' THEN
                  SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
               WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='24' AND glab003='9902_10' 
               END IF
               
               #减值准备异动
               IF l_fabg005 = '14' THEN
                  SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
                  WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='14' AND glab003='9902_11' 
               END IF
               
               #20141109--add--str--
             SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabgld
               CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9017') RETURNING l_para_data                 
               #6:銷帳
               IF l_fabg005 = '6' THEN
                  IF l_para_data = 'Y' THEN
                     SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
                      WHERE glabent = g_enterprise AND glabld = g_fabgld
                        AND glab001 = '90' AND glab002 = '25'
                        AND glab003 = '9902_12' 
                  ELSE
                     SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
                      WHERE glabent = g_enterprise AND glabld = g_fabgld
                        AND glab001 = '90' AND glab002 = '6'
                        AND glab003 = '9902_04' 
                  END IF
               END IF
               
               #出售
               IF l_fabg005 = '4' THEN
                  IF l_para_data = 'Y' THEN        
                     SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
                      WHERE glabent=g_enterprise AND glabld=g_fabgld
                        AND glab002='25' AND glab001='90' AND glab003='9902_12'
                  ELSE
                     SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
                      WHERE glabent=g_enterprise AND glabld=g_fabgld
                        AND glab002='40' AND glab001='90' AND glab003='9902_05'       
                  END IF 
               END IF                   

               #报废
               IF l_fabg005 = '21' THEN
                  IF l_para_data = 'Y' THEN        
                     SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
                      WHERE glabent=g_enterprise AND glabld=g_fabgld
                        AND glab002='25' AND glab001='90' AND glab003='9902_12'
                  ELSE
                     SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
                      WHERE glabent=g_enterprise AND glabld=g_fabgld
                        AND glab002='21' AND glab001='90' AND glab003='9902_03'       
                  END IF 
               END IF               
               #20141109--add--end--
               
           #    SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
           #    WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002=g_glab002 AND glab003='9902_01'  
           #   WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='8' AND glab003='9902_01'
               DISPLAY  g_fabh2_d[l_ac].fabh021 TO fabh021
               CALL afat503_01_fabh021_desc(g_fabh2_d[l_ac].fabh021)
            END IF
#            IF cl_null(g_fabh2_d[l_ac].fabh026) AND cl_null(g_fabh2_d[l_ac].fabh027) AND cl_null(g_fabh2_d[l_ac].fabh028) AND
#               cl_null(g_fabh2_d[l_ac].fabh029) AND cl_null(g_fabh2_d[l_ac].fabh030) AND cl_null(g_fabh2_d[l_ac].fabh031) AND
#               cl_null(g_fabh2_d[l_ac].fabh031) AND cl_null(g_fabh2_d[l_ac].fabh032) AND cl_null(g_fabh2_d[l_ac].fabh033) AND
#               cl_null(g_fabh2_d[l_ac].fabh034) AND cl_null(g_fabh2_d[l_ac].fabh035) THEN
#               SELECT fabh036,faajsite,'',faaj039,'',faaj040,'',faaj041,'',faaj042,
#                      '',faaj043,'',faaj044,'',faaj047,'',faaj045,'',faaj046
#                 INTO g_fabh2_d[l_ac].fabh036,
#                      g_fabh2_d[l_ac].fabh026,g_fabh2_d[l_ac].fabh026_desc,
#                      g_fabh2_d[l_ac].fabh027,g_fabh2_d[l_ac].fabh027_desc,
#                      g_fabh2_d[l_ac].fabh028,g_fabh2_d[l_ac].fabh028_desc,
#                      g_fabh2_d[l_ac].fabh029,g_fabh2_d[l_ac].fabh029_desc,
#                      g_fabh2_d[l_ac].fabh030,g_fabh2_d[l_ac].fabh030_desc,
#                      g_fabh2_d[l_ac].fabh031,g_fabh2_d[l_ac].fabh031_desc,
#                      g_fabh2_d[l_ac].fabh032,g_fabh2_d[l_ac].fabh032_desc, 
#                      g_fabh2_d[l_ac].fabh033,g_fabh2_d[l_ac].fabh033_desc,
#                      g_fabh2_d[l_ac].fabh034,g_fabh2_d[l_ac].fabh034_desc,
#                      g_fabh2_d[l_ac].fabh035,g_fabh2_d[l_ac].fabh035_desc,
#                      g_fabh2_d[l_ac].fabh041,
#                      g_fabh2_d[l_ac].fabh042,g_fabh2_d[l_ac].fabh042_desc,
#                      g_fabh2_d[l_ac].fabh043,g_fabh2_d[l_ac].fabh043_desc
#                 FROM fabh_t,faaj_t  
#                WHERE faaj001=fabh001 AND faaj002=fabh002 AND faaj037=fabh000 AND faajent=fabhent
#                  AND fabhent=g_enterprise AND fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=g_fabh2_d[l_ac].fabhseq 
#                  AND fabhld = faajld          #add by yangxf
#            END IF

            SELECT fabh036 INTO g_fabh2_d[l_ac].fabh036   
              FROM fabh_t,faaj_t  
             WHERE faaj001=fabh001 AND faaj002=fabh002 AND faaj037=fabh000 AND faajent=fabhent
               AND fabhent=g_enterprise AND fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=g_fabh2_d[l_ac].fabhseq 
               AND fabhld = faajld               

            IF cl_null(g_fabh2_d[l_ac].fabh026) THEN 
               SELECT faajsite,'' INTO g_fabh2_d[l_ac].fabh026,g_fabh2_d[l_ac].fabh026_desc   
                 FROM fabh_t,faaj_t  
                WHERE faaj001=fabh001 AND faaj002=fabh002 AND faaj037=fabh000 AND faajent=fabhent
                  AND fabhent=g_enterprise AND fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=g_fabh2_d[l_ac].fabhseq 
                  AND fabhld = faajld                          
            END IF
            
            IF cl_null(g_fabh2_d[l_ac].fabh027) THEN 
               SELECT faaj039,'' INTO g_fabh2_d[l_ac].fabh027,g_fabh2_d[l_ac].fabh027_desc   
                 FROM fabh_t,faaj_t  
                WHERE faaj001=fabh001 AND faaj002=fabh002 AND faaj037=fabh000 AND faajent=fabhent
                  AND fabhent=g_enterprise AND fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=g_fabh2_d[l_ac].fabhseq 
                  AND fabhld = faajld                          
            END IF

            IF cl_null(g_fabh2_d[l_ac].fabh028) THEN 
               SELECT faaj040,'' INTO g_fabh2_d[l_ac].fabh028,g_fabh2_d[l_ac].fabh028_desc   
                 FROM fabh_t,faaj_t  
                WHERE faaj001=fabh001 AND faaj002=fabh002 AND faaj037=fabh000 AND faajent=fabhent
                  AND fabhent=g_enterprise AND fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=g_fabh2_d[l_ac].fabhseq 
                  AND fabhld = faajld                          
            END IF
            
            IF cl_null(g_fabh2_d[l_ac].fabh029) THEN 
               SELECT faaj041,'' INTO g_fabh2_d[l_ac].fabh029,g_fabh2_d[l_ac].fabh029_desc   
                 FROM fabh_t,faaj_t  
                WHERE faaj001=fabh001 AND faaj002=fabh002 AND faaj037=fabh000 AND faajent=fabhent
                  AND fabhent=g_enterprise AND fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=g_fabh2_d[l_ac].fabhseq 
                  AND fabhld = faajld                          
            END IF

            IF cl_null(g_fabh2_d[l_ac].fabh030) THEN 
               SELECT faaj042,'' INTO g_fabh2_d[l_ac].fabh030,g_fabh2_d[l_ac].fabh030_desc   
                 FROM fabh_t,faaj_t  
                WHERE faaj001=fabh001 AND faaj002=fabh002 AND faaj037=fabh000 AND faajent=fabhent
                  AND fabhent=g_enterprise AND fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=g_fabh2_d[l_ac].fabhseq 
                  AND fabhld = faajld                          
            END IF
            
            IF cl_null(g_fabh2_d[l_ac].fabh031) THEN 
               SELECT faaj043,'' INTO g_fabh2_d[l_ac].fabh031,g_fabh2_d[l_ac].fabh031_desc   
                 FROM fabh_t,faaj_t  
                WHERE faaj001=fabh001 AND faaj002=fabh002 AND faaj037=fabh000 AND faajent=fabhent
                  AND fabhent=g_enterprise AND fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=g_fabh2_d[l_ac].fabhseq 
                  AND fabhld = faajld                          
            END IF 

            IF cl_null(g_fabh2_d[l_ac].fabh032) THEN 
               SELECT faaj044,'' INTO g_fabh2_d[l_ac].fabh032,g_fabh2_d[l_ac].fabh032_desc   
                 FROM fabh_t,faaj_t  
                WHERE faaj001=fabh001 AND faaj002=fabh002 AND faaj037=fabh000 AND faajent=fabhent
                  AND fabhent=g_enterprise AND fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=g_fabh2_d[l_ac].fabhseq 
                  AND fabhld = faajld                          
            END IF
            
            IF cl_null(g_fabh2_d[l_ac].fabh033) THEN 
               SELECT faaj047,'' INTO g_fabh2_d[l_ac].fabh033,g_fabh2_d[l_ac].fabh033_desc   
                 FROM fabh_t,faaj_t  
                WHERE faaj001=fabh001 AND faaj002=fabh002 AND faaj037=fabh000 AND faajent=fabhent
                  AND fabhent=g_enterprise AND fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=g_fabh2_d[l_ac].fabhseq 
                  AND fabhld = faajld                          
            END IF            
 
            IF cl_null(g_fabh2_d[l_ac].fabh034) THEN 
               SELECT faaj045,'' INTO g_fabh2_d[l_ac].fabh034,g_fabh2_d[l_ac].fabh034_desc   
                 FROM fabh_t,faaj_t  
                WHERE faaj001=fabh001 AND faaj002=fabh002 AND faaj037=fabh000 AND faajent=fabhent
                  AND fabhent=g_enterprise AND fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=g_fabh2_d[l_ac].fabhseq 
                  AND fabhld = faajld                          
            END IF
            
            IF cl_null(g_fabh2_d[l_ac].fabh035) THEN 
               SELECT faaj046,'' INTO g_fabh2_d[l_ac].fabh035,g_fabh2_d[l_ac].fabh035_desc   
                 FROM fabh_t,faaj_t  
                WHERE faaj001=fabh001 AND faaj002=fabh002 AND faaj037=fabh000 AND faajent=fabhent
                  AND fabhent=g_enterprise AND fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=g_fabh2_d[l_ac].fabhseq 
                  AND fabhld = faajld                          
            END IF 
            
            CALL s_fin_sel_glad(g_fabgld,g_fabh2_d[l_ac].fabh021,'ALL') RETURNING g_glad.* #20150115 add by chenying 

            LET g_fabh2_d[l_ac].fabh026_desc=g_fabh2_d[l_ac].fabh026
            LET g_fabh2_d[l_ac].fabh027_desc=g_fabh2_d[l_ac].fabh027
            LET g_fabh2_d[l_ac].fabh028_desc=g_fabh2_d[l_ac].fabh028
            LET g_fabh2_d[l_ac].fabh029_desc=g_fabh2_d[l_ac].fabh029
            LET g_fabh2_d[l_ac].fabh030_desc=g_fabh2_d[l_ac].fabh030
            LET g_fabh2_d[l_ac].fabh031_desc=g_fabh2_d[l_ac].fabh031
            LET g_fabh2_d[l_ac].fabh032_desc=g_fabh2_d[l_ac].fabh032
            LET g_fabh2_d[l_ac].fabh033_desc=g_fabh2_d[l_ac].fabh033
            LET g_fabh2_d[l_ac].fabh034_desc=g_fabh2_d[l_ac].fabh034
            LET g_fabh2_d[l_ac].fabh035_desc=g_fabh2_d[l_ac].fabh035
            LET g_fabh2_d[l_ac].fabh042_desc=g_fabh2_d[l_ac].fabh042
            LET g_fabh2_d[l_ac].fabh043_desc=g_fabh2_d[l_ac].fabh043 
            LET g_fabh2_d[l_ac].fabh060_desc=g_fabh2_d[l_ac].fabh060
            LET g_fabh2_d[l_ac].fabh061_desc=g_fabh2_d[l_ac].fabh061
            LET g_fabh2_d[l_ac].fabh062_desc=g_fabh2_d[l_ac].fabh062
            LET g_fabh2_d[l_ac].fabh063_desc=g_fabh2_d[l_ac].fabh063
            LET g_fabh2_d[l_ac].fabh064_desc=g_fabh2_d[l_ac].fabh064
            LET g_fabh2_d[l_ac].fabh065_desc=g_fabh2_d[l_ac].fabh065
            LET g_fabh2_d[l_ac].fabh066_desc=g_fabh2_d[l_ac].fabh066
            LET g_fabh2_d[l_ac].fabh067_desc=g_fabh2_d[l_ac].fabh067 
            LET g_fabh2_d[l_ac].fabh068_desc=g_fabh2_d[l_ac].fabh068
            LET g_fabh2_d[l_ac].fabh069_desc=g_fabh2_d[l_ac].fabh069             
            CALL afat503_01_b_ref()
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
#                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
#                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前

               #end add-point    
               
               DELETE FROM fabh_t
                WHERE fabhent = g_enterprise AND fabhld = g_fabgld AND
                                          fabhdocno = g_fabgdocno AND
                      fabhseq = g_fabh2_d_t.fabhseq
                  
               #add-point:單身2刪除中

               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fabh_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
#                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身2刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE afat503_01_bcl
#               LET l_count = g_fabh_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabgld
               LET gs_keys[2] = g_fabgdocno
               LET gs_keys[3] = g_fabh2_d[g_detail_idx].fabhseq
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
                              CALL afat503_01_delete_b('fabh_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_fabh2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
#               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM fabh_t 
             WHERE fabhent = g_enterprise AND fabhld = g_fabgld
               AND fabhdocno = g_fabgdocno
               AND fabhseq = g_fabh2_d[l_ac].fabhseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabgld
               LET gs_keys[2] = g_fabgdocno
               LET gs_keys[3] = g_fabh2_d[g_detail_idx].fabhseq
#               CALL afat503_01_insert_b('fabh_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_fabh2_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
#               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabh_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
#               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat503_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_fabh2_d[l_ac].* = g_fabh2_d_t.*
               CLOSE afat503_01_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fabh2_d[l_ac].* = g_fabh2_d_t.*
            ELSE
               #add-point:單身page2修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               UPDATE fabh_t SET (fabh021, 
                   fabh036,fabh026,fabh027,fabh028,fabh029,fabh030,fabh031,fabh032,fabh033,fabh034,fabh035,fabh041,fabh042,
                   fabh043,fabh060,fabh061,fabh062,fabh063,fabh064,fabh065,fabh066,fabh067,fabh068,fabh069
                   ) = (g_fabh2_d[l_ac].fabh021, 
                   g_fabh2_d[l_ac].fabh036,g_fabh2_d[l_ac].fabh026,g_fabh2_d[l_ac].fabh027,g_fabh2_d[l_ac].fabh028, 
                   g_fabh2_d[l_ac].fabh029,g_fabh2_d[l_ac].fabh030,g_fabh2_d[l_ac].fabh031,g_fabh2_d[l_ac].fabh032, 
                   g_fabh2_d[l_ac].fabh033,g_fabh2_d[l_ac].fabh034,g_fabh2_d[l_ac].fabh035,g_fabh2_d[l_ac].fabh041,
                   g_fabh2_d[l_ac].fabh042,g_fabh2_d[l_ac].fabh043,g_fabh2_d[l_ac].fabh060,g_fabh2_d[l_ac].fabh061,
                   g_fabh2_d[l_ac].fabh062,g_fabh2_d[l_ac].fabh063,g_fabh2_d[l_ac].fabh064,g_fabh2_d[l_ac].fabh065,
                   g_fabh2_d[l_ac].fabh066,g_fabh2_d[l_ac].fabh067,g_fabh2_d[l_ac].fabh068,g_fabh2_d[l_ac].fabh069
                   ) #自訂欄位頁簽 

                WHERE fabhent = g_enterprise AND fabhld = g_fabgld
                  AND fabhdocno = g_fabgdocno
                  AND fabhseq = g_fabh2_d_t.fabhseq #項次 
                  
               #add-point:單身page2修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabh_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_fabh2_d[l_ac].* = g_fabh2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabh_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_fabh2_d[l_ac].* = g_fabh2_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabgld
               LET gs_keys_bak[1] = g_fabgld_o
               LET gs_keys[2] = g_fabgdocno
               LET gs_keys_bak[2] = g_fabgdocno_o
               LET gs_keys[3] = g_fabh2_d[g_detail_idx].fabhseq
               LET gs_keys_bak[3] = g_fabh2_d_t.fabhseq
               CALL afat503_01_update_b('fabh_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_fabh2_d_t)
               LET g_log2 = util.JSON.stringify(g_fabh2_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後

               #end add-point
            END IF
         
                  #此段落由子樣板a02產生
         AFTER FIELD fabh021
            
            #add-point:AFTER FIELD fabh021
            IF NOT cl_null(g_fabh2_d[l_ac].fabh021) THEN                                           
               CALL afat503_01_fabh021_chk(g_fabh2_d[l_ac].fabh021)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_fabh2_d[l_ac].fabh021
                  #160318-00005#11   --add--str
                  LET g_errparam.replace[1] ='agli020'
                  LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                  LET g_errparam.exeprog    ='agli020'
                  #160318-00005#11  --add--end
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_fabh2_d[l_ac].fabh021 = g_fabh_d_t.fabh021
                  NEXT FIELD fabh021                  
               END IF 
            END IF
            #161221-00054#4--add--s--xul
            LET l_wc = g_fabh2_d[l_ac].fabh021
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc
            #161221-00054#4--add--e--xul             
            CALL afat503_01_fabh021_desc(g_fabh2_d[l_ac].fabh021)
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh021
            #add-point:BEFORE FIELD fabh021

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE fabh021
            #add-point:ON CHANGE fabh021

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh036
            #add-point:BEFORE FIELD fabh036

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh036
            
            #add-point:AFTER FIELD fabh036

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh036
            #add-point:ON CHANGE fabh036

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh026
            #add-point:BEFORE FIELD fabh026

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh026
            
            #add-point:AFTER FIELD fabh026
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh026
            #add-point:ON CHANGE fabh026

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh026_desc
            #add-point:BEFORE FIELD fabh026_desc
            LET g_fabh2_d[l_ac].fabh026_desc = g_fabh2_d[l_ac].fabh026
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh026_desc
            
            #add-point:AFTER FIELD fabh026_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh026_desc) THEN
#20150114 mod by chenying
#               CALL s_get_orga('2',g_fabh2_d[l_ac].fabh026_desc,'',g_fabgdocdt) 
#               RETURNING l_success,g_fabh2_d[l_ac].fabh026_desc,l_desc,l_desc,l_date,l_date,l_errno
#               IF l_success = FALSE THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = l_errno
#                  LET g_errparam.extend = g_fabh2_d[l_ac].fabh026_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#               
#                  LET g_fabh2_d[l_ac].fabh026_desc = g_fabh2_d_t.fabh026
#                  NEXT FIELD fabh026_desc
#               END IF 
               CALL s_voucher_glaq017_chk(g_fabh2_d[l_ac].fabh026_desc)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'aooi100'
                  LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi100'
                  #160321-00016#26 --e add
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()   
                  
                  LET g_fabh2_d[l_ac].fabh026_desc = g_fabh2_d_t.fabh026
                  NEXT FIELD fabh026_desc
               END IF   
#20150114 mod by chenying
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'01',g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh026_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabh2_d[l_ac].fabh026_desc = g_fabh2_d_t.fabh026
                  NEXT FIELD fabh026_desc
               END IF
               #161221-00054#4--add--e--xul
               #161024-00008#4---s---
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabh2_d[l_ac].fabh026_desc   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_20") THEN
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabh2_d[l_ac].fabh026_desc = g_fabh2_d_t.fabh026
                  NEXT FIELD fabh026_desc
               END IF
               #161024-00008#4---e---
            END IF
            LET g_fabh2_d[l_ac].fabh026 = g_fabh2_d[l_ac].fabh026_desc
            CALL afat503_01_fabh026_desc(g_fabh2_d[l_ac].fabh026_desc) RETURNING l_desc
            LET g_fabh2_d[l_ac].fabh026_desc=g_fabh2_d[l_ac].fabh026_desc,l_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh026_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh026_desc
            #add-point:ON CHANGE fabh026_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabh027
            #add-point:BEFORE FIELD fabh027

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh027
            
            #add-point:AFTER FIELD fabh027
            
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh027
            #add-point:ON CHANGE fabh027

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh027_desc
            #add-point:BEFORE FIELD fabh027_desc
            LET g_fabh2_d[l_ac].fabh027_desc = g_fabh2_d[l_ac].fabh027
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh027_desc
            
            #add-point:AFTER FIELD fabh027_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh027_desc) THEN
#20150114 add by chenying     
#               CALL afat503_01_fabh027_chk(g_fabh2_d[l_ac].fabh027_desc)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_fabh2_d[l_ac].fabh027_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#
#                  LET g_fabh2_d[l_ac].fabh027_desc = g_fabh_d_t.fabh027
#                  NEXT FIELD fabh027_desc                  
#               END IF
               CALL s_department_chk(g_fabh2_d[l_ac].fabh027_desc,g_fabgdocdt) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabh2_d[l_ac].fabh027_desc = g_fabh_d_t.fabh027 
                  NEXT FIELD fabh027_desc                  
               END IF
#20150114 add by chenying               
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'02',g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh027_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabh2_d[l_ac].fabh027_desc = g_fabh_d_t.fabh027 
                  NEXT FIELD fabh027_desc
               END IF
               #161221-00054#4--add--e--xul
            END IF
            LET g_fabh2_d[l_ac].fabh027 = g_fabh2_d[l_ac].fabh027_desc
            CALL afat503_01_fabh026_desc(g_fabh2_d[l_ac].fabh027_desc) RETURNING l_desc
            LET g_fabh2_d[l_ac].fabh027_desc=g_fabh2_d[l_ac].fabh027_desc,l_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh027_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh027_desc
            #add-point:ON CHANGE fabh027_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabh028
            #add-point:BEFORE FIELD fabh028

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh028
            
            #add-point:AFTER FIELD fabh028
            
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh028
            #add-point:ON CHANGE fabh028

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh028_desc
            #add-point:BEFORE FIELD fabh028_desc
            LET g_fabh2_d[l_ac].fabh028_desc = g_fabh2_d[l_ac].fabh028
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh028_desc
            
            #add-point:AFTER FIELD fabh028_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh028_desc) THEN
#20150114 mod by chenying            
#               CALL s_get_orga('6',g_fabh2_d[l_ac].fabh028_desc,'',g_fabgdocdt) 
#               RETURNING l_success,g_fabh2_d[l_ac].fabh028_desc,l_desc,l_desc,l_date,l_date,l_errno
#               IF l_success = FALSE THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = l_errno
#                  LET g_errparam.extend = g_fabh2_d[l_ac].fabh028_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#               
#                  LET g_fabh2_d[l_ac].fabh028_desc = g_fabh2_d_t.fabh028
#                  NEXT FIELD fabh028_desc
#               END IF
               CALL s_voucher_glaq019_chk(g_fabh2_d[l_ac].fabh028_desc,g_fabgdocdt) 
               IF NOT cl_null(g_errno) THEN
                  LET g_fabh2_d[l_ac].fabh028_desc = g_fabh2_d_t.fabh028
                  NEXT FIELD fabh028_desc
               END IF
#20150114 mod by chenying
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'03',g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh028_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabh2_d[l_ac].fabh028_desc = g_fabh2_d_t.fabh028
                  NEXT FIELD fabh028_desc
               END IF
               #161221-00054#4--add--e--xul               
            END IF
            LET g_fabh2_d[l_ac].fabh028 = g_fabh2_d[l_ac].fabh028_desc
            CALL afat503_01_fabh026_desc(g_fabh2_d[l_ac].fabh028_desc) RETURNING l_desc
            LET g_fabh2_d[l_ac].fabh028_desc=g_fabh2_d[l_ac].fabh028_desc,l_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh028_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh028_desc
            #add-point:ON CHANGE fabh028_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabh029
            #add-point:BEFORE FIELD fabh029

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh029
            
            #add-point:AFTER FIELD fabh029
            
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh029
            #add-point:ON CHANGE fabh029

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh029_desc
            #add-point:BEFORE FIELD fabh029_desc
            LET g_fabh2_d[l_ac].fabh029_desc = g_fabh2_d[l_ac].fabh029
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh029_desc
            
            #add-point:AFTER FIELD fabh029_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh029_desc) THEN
#20150114 add by chenying
#               CALL afat503_01_fabh029_chk('287',g_fabh2_d[l_ac].fabh029_desc)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_fabh2_d[l_ac].fabh029_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#               
#                  LET g_fabh2_d[l_ac].fabh029_desc = g_fabh2_d_t.fabh029
#                  NEXT FIELD fabh029_desc
#               END IF
               IF NOT s_azzi650_chk_exist('287',g_fabh2_d[l_ac].fabh029_desc) THEN
                  LET g_fabh2_d[l_ac].fabh029_desc = g_fabh2_d_t.fabh029
                  NEXT FIELD fabh029_desc               
               END IF
#20150114 add by chenying
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'04',g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh029_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabh2_d[l_ac].fabh029_desc = g_fabh2_d_t.fabh029
                  NEXT FIELD fabh029_desc   
               END IF
               #161221-00054#4--add--e--xul                     
            END IF
            LET g_fabh2_d[l_ac].fabh029 = g_fabh2_d[l_ac].fabh029_desc
            CALL afat503_01_fabh043_desc('287',g_fabh2_d[l_ac].fabh029_desc) RETURNING l_desc
            LET g_fabh2_d[l_ac].fabh029_desc=g_fabh2_d[l_ac].fabh029_desc,l_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh029_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh029_desc
            #add-point:ON CHANGE fabh029_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabh030
            #add-point:BEFORE FIELD fabh030

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh030
            
            #add-point:AFTER FIELD fabh030
            
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh030
            #add-point:ON CHANGE fabh030

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh030_desc
            #add-point:BEFORE FIELD fabh030_desc
            LET g_fabh2_d[l_ac].fabh030_desc = g_fabh2_d[l_ac].fabh030
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh030_desc
            
            #add-point:AFTER FIELD fabh030_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh030_desc) THEN
#20150114 mod by chenying            
#               CALL afat503_01_fabh030_chk(g_fabh2_d[l_ac].fabh030_desc)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_fabh2_d[l_ac].fabh030_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#               
#                  LET g_fabh2_d[l_ac].fabh030_desc = g_fabh2_d_t.fabh030
#                  NEXT FIELD fabh030_desc
#               END IF
               CALL s_voucher_glaq021_chk(g_fabh2_d[l_ac].fabh030_desc)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'apmm100'
                  LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                  LET g_errparam.exeprog = 'apmm100'
                  #160321-00016#26 --e add
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_fabh2_d[l_ac].fabh030_desc = g_fabh2_d_t.fabh030
                  NEXT FIELD fabh030_desc
               END IF
#20150114 mod by chenying               
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'05',g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh030_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabh2_d[l_ac].fabh030_desc = g_fabh2_d_t.fabh030
                  NEXT FIELD fabh030_desc  
               END IF
               #161221-00054#4--add--e--xul              
            END IF
            LET g_fabh2_d[l_ac].fabh030 = g_fabh2_d[l_ac].fabh030_desc
            CALL afat503_01_fabh030_desc(g_fabh2_d[l_ac].fabh030_desc) RETURNING l_desc
            LET g_fabh2_d[l_ac].fabh030_desc=g_fabh2_d[l_ac].fabh030_desc,l_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh030_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh030_desc
            #add-point:ON CHANGE fabh030_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabh031
            #add-point:BEFORE FIELD fabh031

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh031
            
            #add-point:AFTER FIELD fabh031
            
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh031
            #add-point:ON CHANGE fabh031

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh031_desc
            #add-point:BEFORE FIELD fabh031_desc
            LET g_fabh2_d[l_ac].fabh031_desc = g_fabh2_d[l_ac].fabh031
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh031_desc
            
            #add-point:AFTER FIELD fabh031_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh031_desc) THEN
#20150114 mod by chenying  
#               CALL afat503_01_fabh030_chk(g_fabh2_d[l_ac].fabh031_desc)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_fabh2_d[l_ac].fabh031_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#               
#                  LET g_fabh2_d[l_ac].fabh031_desc = g_fabh2_d_t.fabh031
#                  NEXT FIELD fabh031_desc
#               END IF
               CALL s_voucher_glaq021_chk(g_fabh2_d[l_ac].fabh031_desc)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'apmm100'
                  LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                  LET g_errparam.exeprog = 'apmm100'
                  #160321-00016#26 --e add
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_fabh2_d[l_ac].fabh031_desc = g_fabh2_d_t.fabh031
                  NEXT FIELD fabh031_desc
               END IF
#20150114 mod by chenying                 
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'06',g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh031_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabh2_d[l_ac].fabh031_desc = g_fabh2_d_t.fabh031
                  NEXT FIELD fabh031_desc  
               END IF
               #161221-00054#4--add--e--xul                 
            END IF
            LET g_fabh2_d[l_ac].fabh031 = g_fabh2_d[l_ac].fabh031_desc
            CALL afat503_01_fabh030_desc(g_fabh2_d[l_ac].fabh031_desc) RETURNING l_desc
            LET g_fabh2_d[l_ac].fabh031_desc=g_fabh2_d[l_ac].fabh031_desc,l_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh031_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh031_desc
            #add-point:ON CHANGE fabh031_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabh032
            #add-point:BEFORE FIELD fabh032

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh032
            
            #add-point:AFTER FIELD fabh032
            
           
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh032
            #add-point:ON CHANGE fabh032

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh032_desc
            #add-point:BEFORE FIELD fabh032_desc
            LET g_fabh2_d[l_ac].fabh032_desc = g_fabh2_d[l_ac].fabh032
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh032_desc
            
            #add-point:AFTER FIELD fabh032_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh032_desc) THEN
#20150114 mod by chenying              
#               CALL afat503_01_fabh029_chk('281',g_fabh2_d[l_ac].fabh032_desc)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_fabh2_d[l_ac].fabh032_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#               
#                  LET g_fabh2_d[l_ac].fabh032_desc = g_fabh2_d_t.fabh032
#                  NEXT FIELD fabh032_desc
#               END IF 
               IF NOT s_azzi650_chk_exist('281',g_fabh2_d[l_ac].fabh032_desc) THEN
                  LET g_fabh2_d[l_ac].fabh032_desc = g_fabh2_d_t.fabh032
                  NEXT FIELD fabh032_desc               
               END IF
#20150114 mod by chenying  
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'07',g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh032_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabh2_d[l_ac].fabh032_desc = g_fabh2_d_t.fabh032
                  NEXT FIELD fabh032_desc 
               END IF
               #161221-00054#4--add--e--xul  
            END IF
            LET g_fabh2_d[l_ac].fabh032 = g_fabh2_d[l_ac].fabh032_desc
            CALL afat503_01_fabh043_desc('281',g_fabh2_d[l_ac].fabh032_desc) RETURNING l_desc 
            LET g_fabh2_d[l_ac].fabh032_desc=g_fabh2_d[l_ac].fabh032_desc,l_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh032_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh032_desc
            #add-point:ON CHANGE fabh032_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabh033
            #add-point:BEFORE FIELD fabh033

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh033
            
            #add-point:AFTER FIELD fabh033
            
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh033
            #add-point:ON CHANGE fabh033

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh033_desc
            #add-point:BEFORE FIELD fabh033_desc
            LET g_fabh2_d[l_ac].fabh033_desc = g_fabh2_d[l_ac].fabh033
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh033_desc
            
            #add-point:AFTER FIELD fabh033_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh033_desc) THEN
#20150114 mod by chenying 
#               CALL afat503_01_fabh033_chk(g_fabh2_d[l_ac].fabh033_desc)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_fabh2_d[l_ac].fabh033_desc
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#               
#                  LET g_fabh2_d[l_ac].fabh033_desc = g_fabh2_d_t.fabh033
#                  NEXT FIELD fabh033_desc
#               END IF
               CALL s_employee_chk(g_fabh2_d[l_ac].fabh033_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN 
                  LET g_fabh2_d[l_ac].fabh033_desc = g_fabh2_d_t.fabh033
                  NEXT FIELD fabh033_desc
               END IF
#20150114 mod by chenying               
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'12',g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh033_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabh2_d[l_ac].fabh033_desc = g_fabh2_d_t.fabh033
                 NEXT FIELD fabh033_desc
               END IF
               #161221-00054#4--add--e--xul               
            END IF
            LET g_fabh2_d[l_ac].fabh033 = g_fabh2_d[l_ac].fabh033_desc
            CALL afat503_01_fabh033_desc(g_fabh2_d[l_ac].fabh033_desc) RETURNING l_desc
            LET g_fabh2_d[l_ac].fabh033_desc=g_fabh2_d[l_ac].fabh033_desc,l_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh033_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh033_desc
            #add-point:ON CHANGE fabh033_desc

            #END add-point
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabh034
            #add-point:BEFORE FIELD fabh034

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh034
            
            #add-point:AFTER FIELD fabh034

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh034
            #add-point:ON CHANGE fabh034

            #END add-point
         BEFORE FIELD fabh034_desc
            LET g_fabh2_d[l_ac].fabh034_desc=g_fabh2_d[l_ac].fabh034
            
         AFTER FIELD fabh034_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh034_desc) THEN 
#20150114 mod by chenying            
#               #此段落由子樣板a19產生
#               #校驗代值
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabh2_d[l_ac].fabh034_desc
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_pjba001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#                  LET g_fabh2_d[l_ac].fabh034=g_fabh2_d[l_ac].fabh034_desc
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabh2_d[l_ac].fabh034_desc=g_fabh2_d_t.fabh034
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_aap_project_chk(g_fabh2_d[l_ac].fabh034_desc) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'apjm200'
                  LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                  LET g_errparam.exeprog = 'apjm200'
                  #160321-00016#26 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fabh2_d[l_ac].fabh034_desc=g_fabh2_d_t.fabh034
                  NEXT FIELD CURRENT
               END IF 
                               
#20150114 mod by chenying
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'13',g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh034_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                 LET g_fabh2_d[l_ac].fabh034_desc=g_fabh2_d_t.fabh034
                  NEXT FIELD CURRENT
               END IF
               #161221-00054#4--add--e--xul  
            END IF 
            LET g_fabh2_d[l_ac].fabh034=g_fabh2_d[l_ac].fabh034_desc
            CALL afat503_01_fabh034_desc(g_fabh2_d[l_ac].fabh034_desc) RETURNING l_desc
            LET g_fabh2_d[l_ac].fabh034_desc=g_fabh2_d[l_ac].fabh034_desc,l_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh034_desc
            
         #此段落由子樣板a01產生
         BEFORE FIELD fabh035
            #add-point:BEFORE FIELD fabh035

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh035
            
            #add-point:AFTER FIELD fabh035

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE fabh035
            #add-point:ON CHANGE fabh035

            #END add-point
 
         #20150114 add by chenying
         BEFORE FIELD fabh035_desc
            LET g_fabh2_d[l_ac].fabh035_desc=g_fabh2_d[l_ac].fabh035
            
         AFTER FIELD fabh035_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh035_desc) THEN 
###此段落由子樣板a19產生
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabh2_d[l_ac].fabh034
#               LET g_chkparam.arg2 = g_fabh2_d[l_ac].fabh035 
# 
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_pjbb002") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#                  LET g_fabh2_d[l_ac].fabh035 = g_fabh2_d[l_ac].fabh035_desc
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabh2_d[l_ac].fabh035_desc = g_fabh2_d_t.fabh035
#                  NEXT FIELD CURRENT
#               END IF  
#20150114 mod by chenying  
               CALL s_voucher_glaq028_chk(g_fabh2_d[l_ac].fabh034,g_fabh2_d[l_ac].fabh035_desc)
               IF NOT cl_null(g_errno) THEN  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fabh2_d[l_ac].fabh035_desc = g_fabh2_d_t.fabh035
                  NEXT FIELD CURRENT
               END IF    
               
#20150114 mod by chenying
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'14',g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh035_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabh2_d[l_ac].fabh035_desc = g_fabh2_d_t.fabh035
                  NEXT FIELD CURRENT
               END IF
               #161221-00054#4--add--e--xul  
            END IF
            LET g_fabh2_d[l_ac].fabh035=g_fabh2_d[l_ac].fabh035_desc            
            CALL afat503_01_fabh035_desc(g_fabh2_d[l_ac].fabh034,g_fabh2_d[l_ac].fabh035_desc) RETURNING l_desc
            LET g_fabh2_d[l_ac].fabh035_desc=g_fabh2_d[l_ac].fabh035_desc,l_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh035_desc            
            
         AFTER FIELD fabh041
            IF NOT cl_null(g_fabh2_d[l_ac].fabh041) THEN
               CALL s_voucher_glaq051_chk(g_fabh2_d[l_ac].fabh041)
               IF NOT cl_null(g_errno) THEN
                  LET g_fabh2_d[l_ac].fabh041 = g_fabh2_d_t.fabh041
                  NEXT FIELD CURRENT                 
               END IF
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'09',g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh041) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabh2_d[l_ac].fabh041 = g_fabh2_d_t.fabh041
                  NEXT FIELD CURRENT
               END IF
               #161221-00054#4--add--e--xul 
            END IF  
            
         BEFORE FIELD fabh042_desc
            LET g_fabh2_d[l_ac].fabh042_desc=g_fabh2_d[l_ac].fabh042
            
         AFTER FIELD fabh042_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh042_desc) THEN
               CALL s_voucher_glaq052_chk(g_fabh2_d[l_ac].fabh042_desc)
               IF NOT cl_null(g_errno) THEN 
                  LET g_fabh2_d[l_ac].fabh042_desc = g_fabh2_d_t.fabh042
                  NEXT FIELD CURRENT
               END IF
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'10',g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh042_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabh2_d[l_ac].fabh042_desc = g_fabh2_d_t.fabh042
                  NEXT FIELD CURRENT
               END IF
               #161221-00054#4--add--e--xul 
            END IF 
            LET g_fabh2_d[l_ac].fabh042 = g_fabh2_d[l_ac].fabh042_desc
            CALL afat503_01_fabh042_desc(g_fabh2_d[l_ac].fabh042_desc)  RETURNING l_desc     
            LET g_fabh2_d[l_ac].fabh042_desc=g_fabh2_d[l_ac].fabh042_desc,l_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh042_desc   

         BEFORE FIELD fabh043_desc
            LET g_fabh2_d[l_ac].fabh043_desc=g_fabh2_d[l_ac].fabh043
            
         AFTER FIELD fabh043_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh043_desc) THEN
               IF NOT s_azzi650_chk_exist('2002',g_fabh2_d[l_ac].fabh043_desc) THEN
                  LET g_fabh2_d[l_ac].fabh043_desc = g_fabh2_d_t.fabh043
                  NEXT FIELD CURRENT
               END IF
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabgld,'11',g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh043_desc) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabh2_d[l_ac].fabh043_desc = g_fabh2_d_t.fabh043
                  NEXT FIELD CURRENT
               END IF
               #161221-00054#4--add--e--xul 
            END IF 
            LET g_fabh2_d[l_ac].fabh043 = g_fabh2_d[l_ac].fabh043_desc
            CALL afat503_01_fabh043_desc('2002',g_fabh2_d[l_ac].fabh043_desc)  RETURNING l_desc     
            LET g_fabh2_d[l_ac].fabh043_desc=g_fabh2_d[l_ac].fabh043_desc,l_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh043_desc     

         #自由核算项
         #自由核算項一
         BEFORE FIELD fabh060_desc
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_fabh2_d[l_ac].fabh060_desc=g_fabh2_d[l_ac].fabh060
         
         AFTER FIELD fabh060_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh060_desc) THEN
               IF ( g_fabh2_d[l_ac].fabh060_desc != g_fabh2_d_t.fabh060_desc OR g_fabh2_d_t.fabh060_desc IS NULL ) THEN
                  LET g_fabh2_d[l_ac].fabh060 = g_fabh2_d[l_ac].fabh060_desc
 
                     CALL s_voucher_free_account_chk(g_glad.glad0171,g_fabh2_d[l_ac].fabh060_desc,g_glad.glad0172) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabh2_d[l_ac].fabh060        = g_fabh2_d_t.fabh060
                        LET g_fabh2_d[l_ac].fabh060_desc = g_fabh2_d_t.fabh060_desc
                        DISPLAY BY NAME g_fabh2_d[l_ac].fabh060,g_fabh2_d[l_ac].fabh060_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
         LET g_fabh2_d[l_ac].fabh060 = g_fabh2_d[l_ac].fabh060_desc   
         LET g_fabh2_d[l_ac].fabh060_desc = s_desc_show1(g_fabh2_d[l_ac].fabh060,s_fin_get_accting_desc(g_glad.glad0171,g_fabh2_d[l_ac].fabh060))
         LET g_fabh2_d_t.fabh060_desc = g_fabh2_d[l_ac].fabh060_desc
         DISPLAY BY NAME g_fabh2_d[l_ac].fabh060,g_fabh2_d[l_ac].fabh060_desc 

         #自由核算項二
         BEFORE FIELD fabh061_desc
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_fabh2_d[l_ac].fabh061_desc=g_fabh2_d[l_ac].fabh061
            
         AFTER FIELD fabh061_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh061_desc) THEN
               IF ( g_fabh2_d[l_ac].fabh061_desc != g_fabh2_d_t.fabh061_desc OR g_fabh2_d_t.fabh061_desc IS NULL ) THEN
                  LET g_fabh2_d[l_ac].fabh061 = g_fabh2_d[l_ac].fabh061_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0181,g_fabh2_d[l_ac].fabh061_desc,g_glad.glad0182) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabh2_d[l_ac].fabh061        = g_fabh2_d_t.fabh061
                        LET g_fabh2_d[l_ac].fabh061_desc = g_fabh2_d_t.fabh061_desc
                        DISPLAY BY NAME g_fabh2_d[l_ac].fabh061,g_fabh2_d[l_ac].fabh061_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabh2_d[l_ac].fabh061 = g_fabh2_d[l_ac].fabh061_desc
            LET g_fabh2_d[l_ac].fabh061_desc = s_desc_show1(g_fabh2_d[l_ac].fabh061,s_fin_get_accting_desc(g_glad.glad0181,g_fabh2_d[l_ac].fabh061))
            LET g_fabh2_d_t.fabh061_desc = g_fabh2_d[l_ac].fabh061_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh061,g_fabh2_d[l_ac].fabh061_desc

   
         
         #自由核算項三
         BEFORE FIELD fabh062_desc
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_fabh2_d[l_ac].fabh062_desc=g_fabh2_d[l_ac].fabh062

         
         AFTER FIELD fabh062_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh062_desc)  THEN
               IF ( g_fabh2_d[l_ac].fabh062_desc != g_fabh2_d_t.fabh062_desc OR g_fabh2_d_t.fabh062_desc IS NULL ) THEN
                  LET g_fabh2_d[l_ac].fabh062 = g_fabh2_d[l_ac].fabh062_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0191,g_fabh2_d[l_ac].fabh062_desc,g_glad.glad0192) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabh2_d[l_ac].fabh062        = g_fabh2_d_t.fabh062
                        LET g_fabh2_d[l_ac].fabh062_desc = g_fabh2_d_t.fabh062_desc
                        DISPLAY BY NAME g_fabh2_d[l_ac].fabh062,g_fabh2_d[l_ac].fabh062_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabh2_d[l_ac].fabh062 = g_fabh2_d[l_ac].fabh062_desc
            LET g_fabh2_d[l_ac].fabh062_desc = s_desc_show1(g_fabh2_d[l_ac].fabh062,s_fin_get_accting_desc(g_glad.glad0191,g_fabh2_d[l_ac].fabh062))
            LET g_fabh2_d_t.fabh062_desc = g_fabh2_d[l_ac].fabh062_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh062,g_fabh2_d[l_ac].fabh062_desc

 
            
         #自由核算項四
         BEFORE FIELD fabh063_desc
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_fabh2_d[l_ac].fabh063_desc=g_fabh2_d[l_ac].fabh063

         
         AFTER FIELD fabh063_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh063_desc) THEN
               IF ( g_fabh2_d[l_ac].fabh063_desc != g_fabh2_d_t.fabh063_desc OR g_fabh2_d_t.fabh063_desc IS NULL ) THEN
                  LET g_fabh2_d[l_ac].fabh063 = g_fabh2_d[l_ac].fabh063_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0201,g_fabh2_d[l_ac].fabh063_desc,g_glad.glad0202) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabh2_d[l_ac].fabh063        = g_fabh2_d_t.fabh063
                        LET g_fabh2_d[l_ac].fabh063_desc = g_fabh2_d_t.fabh063_desc
                        DISPLAY BY NAME g_fabh2_d[l_ac].fabh063,g_fabh2_d[l_ac].fabh063_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabh2_d[l_ac].fabh063 = g_fabh2_d[l_ac].fabh063_desc
            LET g_fabh2_d[l_ac].fabh063_desc = s_desc_show1(g_fabh2_d[l_ac].fabh063,s_fin_get_accting_desc(g_glad.glad0201,g_fabh2_d[l_ac].fabh063))
            LET g_fabh2_d_t.fabh063_desc = g_fabh2_d[l_ac].fabh063_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh063,g_fabh2_d[l_ac].fabh063_desc

  
         
         #自由核算項五
         BEFORE FIELD fabh064_desc
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_fabh2_d[l_ac].fabh064_desc=g_fabh2_d[l_ac].fabh064

         AFTER FIELD fabh064_desc 
            IF NOT cl_null(g_fabh2_d[l_ac].fabh064_desc) THEN
               IF ( g_fabh2_d[l_ac].fabh064_desc != g_fabh2_d_t.fabh064_desc OR g_fabh2_d_t.fabh064_desc IS NULL ) THEN
                  LET g_fabh2_d[l_ac].fabh064 = g_fabh2_d[l_ac].fabh064_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0211,g_fabh2_d[l_ac].fabh064_desc,g_glad.glad0212) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabh2_d[l_ac].fabh064        = g_fabh2_d_t.fabh064
                        LET g_fabh2_d[l_ac].fabh064_desc = g_fabh2_d_t.fabh064_desc
                        DISPLAY BY NAME g_fabh2_d[l_ac].fabh064,g_fabh2_d[l_ac].fabh064_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabh2_d[l_ac].fabh064 = g_fabh2_d[l_ac].fabh064_desc
            LET g_fabh2_d[l_ac].fabh064_desc = s_desc_show1(g_fabh2_d[l_ac].fabh064,s_fin_get_accting_desc(g_glad.glad0211,g_fabh2_d[l_ac].fabh064))
            LET g_fabh2_d_t.fabh064_desc = g_fabh2_d[l_ac].fabh064_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh064,g_fabh2_d[l_ac].fabh064_desc

            

         #自由核算項六
         BEFORE FIELD fabh065_desc
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_fabh2_d[l_ac].fabh065_desc=g_fabh2_d[l_ac].fabh065
            
         AFTER FIELD fabh065_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh065_desc) THEN
               IF ( g_fabh2_d[l_ac].fabh065_desc != g_fabh2_d_t.fabh065_desc OR g_fabh2_d_t.fabh065_desc IS NULL ) THEN
                  LET g_fabh2_d[l_ac].fabh065 = g_fabh2_d[l_ac].fabh065_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0221,g_fabh2_d[l_ac].fabh065_desc,g_glad.glad0222) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabh2_d[l_ac].fabh065        = g_fabh2_d_t.fabh065
                        LET g_fabh2_d[l_ac].fabh065_desc = g_fabh2_d_t.fabh065_desc
                        DISPLAY BY NAME g_fabh2_d[l_ac].fabh065,g_fabh2_d[l_ac].fabh065_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabh2_d[l_ac].fabh065 = g_fabh2_d[l_ac].fabh065_desc
            LET g_fabh2_d[l_ac].fabh065_desc = s_desc_show1(g_fabh2_d[l_ac].fabh065,s_fin_get_accting_desc(g_glad.glad0221,g_fabh2_d[l_ac].fabh065))
            LET g_fabh2_d_t.fabh065_desc = g_fabh2_d[l_ac].fabh065_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh065,g_fabh2_d[l_ac].fabh065_desc

 
         
         #自由核算項七
         BEFORE FIELD fabh066_desc
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_fabh2_d[l_ac].fabh066_desc=g_fabh2_d[l_ac].fabh066
         AFTER FIELD fabh066_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh066_desc) THEN
               IF ( g_fabh2_d[l_ac].fabh066_desc != g_fabh2_d_t.fabh066_desc OR g_fabh2_d_t.fabh066_desc IS NULL ) THEN
                  LET g_fabh2_d[l_ac].fabh066 = g_fabh2_d[l_ac].fabh066_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0231,g_fabh2_d[l_ac].fabh066_desc,g_glad.glad0232) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabh2_d[l_ac].fabh066        = g_fabh2_d_t.fabh066
                        LET g_fabh2_d[l_ac].fabh066_desc = g_fabh2_d_t.fabh066_desc
                        DISPLAY BY NAME g_fabh2_d[l_ac].fabh066,g_fabh2_d[l_ac].fabh066_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabh2_d[l_ac].fabh066 = g_fabh2_d[l_ac].fabh066_desc
            LET g_fabh2_d[l_ac].fabh066_desc = s_desc_show1(g_fabh2_d[l_ac].fabh066,s_fin_get_accting_desc(g_glad.glad0231,g_fabh2_d[l_ac].fabh066))
            LET g_fabh2_d_t.fabh066_desc = g_fabh2_d[l_ac].fabh066_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh066,g_fabh2_d[l_ac].fabh066_desc

   
         
         #自由核算項八
         BEFORE FIELD fabh067_desc
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_fabh2_d[l_ac].fabh067_desc=g_fabh2_d[l_ac].fabh067
         AFTER FIELD fabh067_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh067_desc) THEN
               IF ( g_fabh2_d[l_ac].fabh067_desc != g_fabh2_d_t.fabh067_desc OR g_fabh2_d_t.fabh067_desc IS NULL ) THEN
                  LET g_fabh2_d[l_ac].fabh067 = g_fabh2_d[l_ac].fabh067_desc
                   
                     CALL s_voucher_free_account_chk(g_glad.glad0241,g_fabh2_d[l_ac].fabh067_desc,g_glad.glad0242) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabh2_d[l_ac].fabh067        = g_fabh2_d_t.fabh067
                        LET g_fabh2_d[l_ac].fabh067_desc = g_fabh2_d_t.fabh067_desc
                        DISPLAY BY NAME g_fabh2_d[l_ac].fabh067,g_fabh2_d[l_ac].fabh067_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabh2_d[l_ac].fabh067 = g_fabh2_d[l_ac].fabh067_desc
            LET g_fabh2_d[l_ac].fabh067_desc = s_desc_show1(g_fabh2_d[l_ac].fabh067,s_fin_get_accting_desc(g_glad.glad0241,g_fabh2_d[l_ac].fabh067))
            LET g_fabh2_d_t.fabh067_desc = g_fabh2_d[l_ac].fabh067_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh067,g_fabh2_d[l_ac].fabh067_desc

 
            
         #自由核算項九
         BEFORE FIELD fabh068_desc
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_fabh2_d[l_ac].fabh068_desc=g_fabh2_d[l_ac].fabh068
         AFTER FIELD fabh068_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh068_desc) THEN
               IF ( g_fabh2_d[l_ac].fabh068_desc != g_fabh2_d_t.fabh068_desc OR g_fabh2_d_t.fabh068_desc IS NULL ) THEN
                  LET g_fabh2_d[l_ac].fabh068 = g_fabh2_d[l_ac].fabh068_desc
                
                     CALL s_voucher_free_account_chk(g_glad.glad0251,g_fabh2_d[l_ac].fabh068_desc,g_glad.glad0252) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabh2_d[l_ac].fabh068        = g_fabh2_d_t.fabh068
                        LET g_fabh2_d[l_ac].fabh068_desc = g_fabh2_d_t.fabh068_desc
                        DISPLAY BY NAME g_fabh2_d[l_ac].fabh068,g_fabh2_d[l_ac].fabh068_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabh2_d[l_ac].fabh068 = g_fabh2_d[l_ac].fabh068_desc
            LET g_fabh2_d[l_ac].fabh068_desc = s_desc_show1(g_fabh2_d[l_ac].fabh068,s_fin_get_accting_desc(g_glad.glad0251,g_fabh2_d[l_ac].fabh068))
            LET g_fabh2_d_t.fabh068_desc = g_fabh2_d[l_ac].fabh068_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh068,g_fabh2_d[l_ac].fabh068_desc

   
         
         #自由核算項十
         BEFORE FIELD fabh069_desc
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_fabh2_d[l_ac].fabh069_desc=g_fabh2_d[l_ac].fabh069
         AFTER FIELD fabh069_desc
            IF NOT cl_null(g_fabh2_d[l_ac].fabh069_desc)  THEN
               IF ( g_fabh2_d[l_ac].fabh069_desc != g_fabh2_d_t.fabh069_desc OR g_fabh2_d_t.fabh069_desc IS NULL ) THEN
                  LET g_fabh2_d[l_ac].fabh069 = g_fabh2_d[l_ac].fabh069_desc
               
                     CALL s_voucher_free_account_chk(g_glad.glad0261,g_fabh2_d[l_ac].fabh069_desc,g_glad.glad0262) RETURNING g_errno
                     IF NOT cl_null(g_errno) THEN
                        LET g_fabh2_d[l_ac].fabh069        = g_fabh2_d_t.fabh069
                        LET g_fabh2_d[l_ac].fabh069_desc = g_fabh2_d_t.fabh069_desc
                        DISPLAY BY NAME g_fabh2_d[l_ac].fabh069,g_fabh2_d[l_ac].fabh069_desc
                        NEXT FIELD CURRENT
                     END IF
                     
               END IF
            END IF
            LET g_fabh2_d[l_ac].fabh069 = g_fabh2_d[l_ac].fabh069_desc
            LET g_fabh2_d[l_ac].fabh069_desc = s_desc_show1(g_fabh2_d[l_ac].fabh069,s_fin_get_accting_desc(g_glad.glad0261,g_fabh2_d[l_ac].fabh069))
            LET g_fabh2_d_t.fabh069_desc = g_fabh2_d[l_ac].fabh069_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh069,g_fabh2_d[l_ac].fabh069_desc
         #20150114 add by chenying
 
                  #Ctrlp:input.c.page2.fabh021
         ON ACTION controlp INFIELD fabh021
            #add-point:ON ACTION controlp INFIELD fabh021
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fabgld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            
            CALL aglt310_04()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh021 = g_qryparam.return1              

            DISPLAY g_fabh2_d[l_ac].fabh021 TO fabh021              #
            CALL afat503_01_fabh021_desc(g_fabh2_d[l_ac].fabh021)

            NEXT FIELD fabh021                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat503_01.fabh036
         ON ACTION controlp INFIELD fabh036
            #add-point:ON ACTION controlp INFIELD fabh036

            #END add-point
 
         #Ctrlp:input.c.page1_afat503_01.fabh026
         ON ACTION controlp INFIELD fabh026
         
         ON ACTION controlp INFIELD fabh026_desc
            #add-point:ON ACTION controlp INFIELD fabh026
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh026             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
#20150113 mod by chenying            
#            LET g_qryparam.where ="ooed001 = '2' AND ooed006<='",g_fabgdocdt,"' AND (ooed007 IS NULL OR ooed007 >='",g_fabgdocdt,"')"
#            CALL q_ooed004_1()                                #呼叫開窗
            LET g_qryparam.where ="ooefstus='Y'"
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'01',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#4--add--e--xul
            #CALL q_ooef001()                                            #161024-00008#4
             CALL q_ooef001_1()                                          #161024-00008#4 
#20150113 mod by chenying               
            LET g_fabh2_d[l_ac].fabh026_desc = g_qryparam.return1              
 
            LET g_fabh2_d[l_ac].fabh026 = g_fabh2_d[l_ac].fabh026_desc
            DISPLAY BY NAME g_fabh2_d[l_ac].fabh026_desc               #

            NEXT FIELD fabh026_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat503_01.fabh027
         ON ACTION controlp INFIELD fabh027
         
         ON ACTION controlp INFIELD fabh027_desc
            #add-point:ON ACTION controlp INFIELD fabh027
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh027             #給予default值
            LET g_qryparam.default2 = "" #g_fabh2_d[l_ac].ooeg001 #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_fabgdocdt

            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'02',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            
#            CALL q_ooeg001()   #20150113 mark by chenying                 
            CALL q_ooeg001_4()  #20150113 add by chenying
            
            LET g_fabh2_d[l_ac].fabh027 = g_qryparam.return1  
            LET g_fabh2_d[l_ac].fabh027_desc = g_fabh2_d[l_ac].fabh027            
            #LET g_fabh2_d[l_ac].ooeg001 = g_qryparam.return2 
            DISPLAY g_fabh2_d[l_ac].fabh027_desc TO fabh027_desc              #
            #DISPLAY g_fabh2_d[l_ac].ooeg001 TO ooeg001 #部門編號
            NEXT FIELD fabh027_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat503_01.fabh028
         ON ACTION controlp INFIELD fabh028
         
         ON ACTION controlp INFIELD fabh028_desc
            #add-point:ON ACTION controlp INFIELD fabh028
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh028             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
#20150113 mod by chenying            
#            LET g_qryparam.where ="ooed001 = '2' AND ooed006<='",g_fabgdocdt,"' AND (ooed007 IS NULL OR ooed007 >='",g_fabgdocdt,"')"
#            
#            CALL q_ooed004_1()  
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'03',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#4--add--e--xul
            LET g_qryparam.arg1 = g_fabgdocdt
            #CALL q_ooeg001_5()                #呼叫開窗   #161221-00054#4 MARK xul
            CALL q_ooeg001_15()    #161221-00054#4 add xul     
#20150113 mod by chenying 
            LET g_fabh2_d[l_ac].fabh028 = g_qryparam.return1              
            LET g_fabh2_d[l_ac].fabh028_desc = g_fabh2_d[l_ac].fabh028
            DISPLAY g_fabh2_d[l_ac].fabh028_desc TO fabh028_desc              #

            NEXT FIELD fabh028_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat503_01.fabh029
         ON ACTION controlp INFIELD fabh029
         
         ON ACTION controlp INFIELD fabh029_desc
            #add-point:ON ACTION controlp INFIELD fabh029
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh029             #給予default值
            LET g_qryparam.default2 = "" #g_fabh2_d[l_ac].oocq002 #應用分類碼
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'04',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where =l_glak_sql
            #161221-00054#4--add--e--xul
            #給予arg
#20150113 mod by chenying            
#            LET g_qryparam.arg1 = "287" #
#            CALL q_oocq002()                                #呼叫開窗
            CALL q_oocq002_287()
#20150113 mod by chenying 
            LET g_fabh2_d[l_ac].fabh029 = g_qryparam.return1
            LET g_fabh2_d[l_ac].fabh029_desc = g_fabh2_d[l_ac].fabh029            
            #LET g_fabh2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabh2_d[l_ac].fabh029_desc TO fabh029_desc              #
            #DISPLAY g_fabh2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabh029_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat503_01.fabh030
         ON ACTION controlp INFIELD fabh030
         
         ON ACTION controlp INFIELD fabh030_desc
            #add-point:ON ACTION controlp INFIELD fabh030
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh030             #給予default值
            
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'05',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()      #160913-00017#1  add
            #CALL q_pmaa001()        #160913-00017#1  mark               #呼叫開窗      

            LET g_fabh2_d[l_ac].fabh030 = g_qryparam.return1              
            LET g_fabh2_d[l_ac].fabh030_desc = g_fabh2_d[l_ac].fabh030 
            DISPLAY g_fabh2_d[l_ac].fabh030_desc TO fabh030_desc              #

            NEXT FIELD fabh030_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat503_01.fabh031
         ON ACTION controlp INFIELD fabh031
         
         ON ACTION controlp INFIELD fabh031_desc
            #add-point:ON ACTION controlp INFIELD fabh031
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh031             #給予default值
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'06',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_25()      #160913-00017#1  add
            #CALL q_pmaa001()        #160913-00017#1  mark               #呼叫開窗      

            LET g_fabh2_d[l_ac].fabh031 = g_qryparam.return1              
            LET g_fabh2_d[l_ac].fabh031_desc = g_fabh2_d[l_ac].fabh031
            DISPLAY g_fabh2_d[l_ac].fabh031_desc TO fabh031_desc              #

            NEXT FIELD fabh031_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat503_01.fabh032
         ON ACTION controlp INFIELD fabh032
         
         ON ACTION controlp INFIELD fabh032_desc
            #add-point:ON ACTION controlp INFIELD fabh032
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh032             #給予default值
            LET g_qryparam.default2 = "" #g_fabh2_d[l_ac].oocq002 #應用分類碼
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'07',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            #給予arg
#            LET g_qryparam.arg1 = "281"  #20150113 mark by chenying
#            CALL q_oocq002()             #20150113 mark by chenying                    
            CALL q_oocq002_281()          #20150113 add by chenying
            LET g_fabh2_d[l_ac].fabh032 = g_qryparam.return1 
            LET g_fabh2_d[l_ac].fabh032_desc = g_fabh2_d[l_ac].fabh032            
            #LET g_fabh2_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_fabh2_d[l_ac].fabh032_desc TO fabh032_desc              #
            #DISPLAY g_fabh2_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD fabh032_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat503_01.fabh033
         ON ACTION controlp INFIELD fabh033
         
         ON ACTION controlp INFIELD fabh033_desc
            #add-point:ON ACTION controlp INFIELD fabh033
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh033             #給予default值
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'12',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            #給予arg
            LET g_qryparam.arg1 = "" #

            
#            CALL q_ooag001()   #20150113 mark by chenying                            #呼叫開窗
            CALL q_ooag001_8()  #20150113 add by chenying
            
            LET g_fabh2_d[l_ac].fabh033 = g_qryparam.return1              
            LET g_fabh2_d[l_ac].fabh033_desc = g_fabh2_d[l_ac].fabh033
            DISPLAY g_fabh2_d[l_ac].fabh033_desc TO fabh033_desc              #

            NEXT FIELD fabh033_desc                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat503_01.fabh034
         ON ACTION controlp INFIELD fabh034
         
         ON ACTION controlp INFIELD fabh034_desc 
            #add-point:ON ACTION controlp INFIELD fabh034
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh034             #給予default值
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'13',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pjba001()                                #呼叫開窗

            LET g_fabh2_d[l_ac].fabh034 = g_qryparam.return1   
            LET g_fabh2_d[l_ac].fabh034_desc = g_fabh2_d[l_ac].fabh034            
            DISPLAY g_fabh2_d[l_ac].fabh034_desc TO fabh034_desc              #

            NEXT FIELD fabh034_desc                        #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1_afat503_01.fabh035
         ON ACTION controlp INFIELD fabh035
         
         #20150113 add by chenying
         ON ACTION controlp INFIELD fabh035_desc
            #add-point:ON ACTION controlp INFIELD fabh035
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh035             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = g_fabh2_d[l_ac].fabh034

            
#            CALL q_pjbb002_2()                                #呼叫開窗

            IF NOT cl_null(g_fabh2_d[l_ac].fabh034) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_fabh2_d[l_ac].fabh034,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'14',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#4--add--e--xul
            CALL q_pjbb002()             #呼叫開窗

            LET g_fabh2_d[l_ac].fabh035 = g_qryparam.return1              
            LET g_fabh2_d[l_ac].fabh035_desc = g_fabh2_d[l_ac].fabh035 
            DISPLAY g_fabh2_d[l_ac].fabh035_desc TO fabh035_desc            #

            NEXT FIELD fabh035_desc                
         
         
         ON ACTION controlp INFIELD fabh042_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh042
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'10',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            CALL q_oojd001_2()
            LET g_fabh2_d[l_ac].fabh042 = g_qryparam.return1
            LET g_fabh2_d[l_ac].fabh042_desc = g_fabh2_d[l_ac].fabh042
            DISPLAY g_fabh2_d[l_ac].fabh042_desc TO fabh042_desc
            NEXT FIELD fabh042_desc 

         ON ACTION controlp INFIELD fabh043_desc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh043
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabgld,'11',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            CALL q_oocq002_2002()
            LET g_fabh2_d[l_ac].fabh043 = g_qryparam.return1
            LET g_fabh2_d[l_ac].fabh043_desc = g_fabh2_d[l_ac].fabh043
            DISPLAY g_fabh2_d[l_ac].fabh043_desc TO fabh043_desc
            NEXT FIELD fabh043_desc 
          
         #自由核算项（一~十）
         ON ACTION controlp INFIELD fabh060_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh060_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabh2_d[l_ac].fabh060        = g_qryparam.return1
               LET g_fabh2_d[l_ac].fabh060_desc = g_fabh2_d[l_ac].fabh060
               DISPLAY BY NAME g_fabh2_d[l_ac].fabh060 ,g_fabh2_d[l_ac].fabh060_desc
               NEXT FIELD fabh060_desc
            END IF  
            
         ON ACTION controlp INFIELD fabh061_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh061_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabh2_d[l_ac].fabh061        = g_qryparam.return1
               LET g_fabh2_d[l_ac].fabh061_desc = g_fabh2_d[l_ac].fabh061
               DISPLAY BY NAME g_fabh2_d[l_ac].fabh061 ,g_fabh2_d[l_ac].fabh061_desc
               NEXT FIELD fabh061_desc
            END IF   

         ON ACTION controlp INFIELD fabh062_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh062_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabh2_d[l_ac].fabh062        = g_qryparam.return1
               LET g_fabh2_d[l_ac].fabh062_desc = g_fabh2_d[l_ac].fabh062
               DISPLAY BY NAME g_fabh2_d[l_ac].fabh062 ,g_fabh2_d[l_ac].fabh062_desc
               NEXT FIELD fabh062_desc
            END IF  
            
         ON ACTION controlp INFIELD fabh063_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh063_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabh2_d[l_ac].fabh063        = g_qryparam.return1
               LET g_fabh2_d[l_ac].fabh063_desc = g_fabh2_d[l_ac].fabh063
               DISPLAY BY NAME g_fabh2_d[l_ac].fabh063 ,g_fabh2_d[l_ac].fabh063_desc
               NEXT FIELD fabh063_desc
            END IF   

         ON ACTION controlp INFIELD fabh064_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh064_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabh2_d[l_ac].fabh064        = g_qryparam.return1
               LET g_fabh2_d[l_ac].fabh064_desc = g_fabh2_d[l_ac].fabh064
               DISPLAY BY NAME g_fabh2_d[l_ac].fabh064 ,g_fabh2_d[l_ac].fabh064_desc
               NEXT FIELD fabh064_desc
            END IF  
            
         ON ACTION controlp INFIELD fabh065_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh065_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabh2_d[l_ac].fabh065        = g_qryparam.return1
               LET g_fabh2_d[l_ac].fabh065_desc = g_fabh2_d[l_ac].fabh065
               DISPLAY BY NAME g_fabh2_d[l_ac].fabh065 ,g_fabh2_d[l_ac].fabh065_desc
               NEXT FIELD fabh065_desc
            END IF 

         ON ACTION controlp INFIELD fabh066_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh066_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabh2_d[l_ac].fabh066        = g_qryparam.return1
               LET g_fabh2_d[l_ac].fabh066_desc = g_fabh2_d[l_ac].fabh066
               DISPLAY BY NAME g_fabh2_d[l_ac].fabh066 ,g_fabh2_d[l_ac].fabh066_desc
               NEXT FIELD fabh066_desc
            END IF  

         ON ACTION controlp INFIELD fabh067_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh067_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabh2_d[l_ac].fabh067        = g_qryparam.return1
               LET g_fabh2_d[l_ac].fabh067_desc = g_fabh2_d[l_ac].fabh067
               DISPLAY BY NAME g_fabh2_d[l_ac].fabh067 ,g_fabh2_d[l_ac].fabh067_desc
               NEXT FIELD fabh067_desc
            END IF

         ON ACTION controlp INFIELD fabh068_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh068_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabh2_d[l_ac].fabh068        = g_qryparam.return1
               LET g_fabh2_d[l_ac].fabh068_desc = g_fabh2_d[l_ac].fabh068
               DISPLAY BY NAME g_fabh2_d[l_ac].fabh068 ,g_fabh2_d[l_ac].fabh068_desc
               NEXT FIELD fabh068_desc
            END IF 

         ON ACTION controlp INFIELD fabh069_desc
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_fabh2_d[l_ac].fabh069_desc
               IF l_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009) 
               LET g_fabh2_d[l_ac].fabh069        = g_qryparam.return1
               LET g_fabh2_d[l_ac].fabh069_desc = g_fabh2_d[l_ac].fabh069
               DISPLAY BY NAME g_fabh2_d[l_ac].fabh069 ,g_fabh2_d[l_ac].fabh069_desc
               NEXT FIELD fabh069_desc
            END IF      
         #20150113 add by chenying
         
         
         AFTER ROW
            #add-point:單身page2 after_row

            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabh2_d[l_ac].* = g_fabh2_d_t.*
               END IF
               CLOSE afat503_01_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            IF cl_null(g_fabh2_d[l_ac].fabh026) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'afa-00451' 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()   
               NEXT FIELD fabh026
            END IF 
            #其他table進行unlock
            
            CALL afat503_01_unlock_b("fabh_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2

            #end add-point
 
         AFTER INPUT
            #add-point:input段after input
            IF cl_null(g_fabh2_d[l_ac].fabh026) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 'afa-00451' 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()   
               NEXT FIELD fabh026
            END IF 
            LET g_fabh_d2.* = g_fabh2_d.*
            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_fabh2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_fabh2_d.getLength()+1
 
      END INPUT
END DIALOG

################################################################################
# Descriptions...: 查詢
# Memo...........:
# Usage..........: CALL afat503_01_construct()
# Modify.........:
################################################################################
DIALOG afat503_01_construct()

   CONSTRUCT g_wc_subject ON fabh021,fabh036,fabh026,fabh026_desc,fabh027,fabh027_desc,fabh028,fabh028_desc,
                             fabh029,fabh029_desc,fabh030,fabh030_desc,fabh031,fabh031_desc,
                             fabh032,fabh032_desc,fabh033,fabh033_desc,fabh034,fabh034_desc,fabh035,fabh035_desc,
                             fabh041,fabh042,fabh042_desc,fabh043,fabh043_desc
#                             ,fabh060,fabh060_desc,
#                             fabh061,fabh061_desc,fabh062,fabh062_desc,fabh063,fabh063_desc,
#                             fabh064,fabh064_desc,fabh065,fabh065_desc,
#                             fabh066,fabh066_desc,fabh067,fabh067_desc,
#                             fabh068,fabh068_desc,fabh069,fabh069_desc                            

        FROM s_detail1_afat503_01[1].fabh021,s_detail1_afat503_01[1].fabh036,
             s_detail1_afat503_01[1].fabh026,s_detail1_afat503_01[1].fabh026_desc,
             s_detail1_afat503_01[1].fabh027,s_detail1_afat503_01[1].fabh027_desc,
             s_detail1_afat503_01[1].fabh028,s_detail1_afat503_01[1].fabh028_desc,
             s_detail1_afat503_01[1].fabh029,s_detail1_afat503_01[1].fabh029_desc,
             s_detail1_afat503_01[1].fabh030,s_detail1_afat503_01[1].fabh030_desc,
             s_detail1_afat503_01[1].fabh031,s_detail1_afat503_01[1].fabh031_desc,
             s_detail1_afat503_01[1].fabh032,s_detail1_afat503_01[1].fabh032_desc,
             s_detail1_afat503_01[1].fabh033,s_detail1_afat503_01[1].fabh033_desc,
             s_detail1_afat503_01[1].fabh034,s_detail1_afat503_01[1].fabh034_desc,
             s_detail1_afat503_01[1].fabh035,s_detail1_afat503_01[1].fabh035_desc,
             s_detail1_afat503_01[1].fabh041, 
             s_detail1_afat503_01[1].fabh042,s_detail1_afat503_01[1].fabh042_desc,
             s_detail1_afat503_01[1].fabh043,s_detail1_afat503_01[1].fabh043_desc
#             ,s_detail1_afat503_01[1].fabh060,s_detail1_afat503_01[1].fabh060_desc,
#             s_detail1_afat503_01[1].fabh061,s_detail1_afat503_01[1].fabh061_desc,
#             s_detail1_afat503_01[1].fabh062,s_detail1_afat503_01[1].fabh062_desc,
#             s_detail1_afat503_01[1].fabh063,s_detail1_afat503_01[1].fabh063_desc,
#             s_detail1_afat503_01[1].fabh064,s_detail1_afat503_01[1].fabh064_desc,
#             s_detail1_afat503_01[1].fabh065,s_detail1_afat503_01[1].fabh065_desc,
#             s_detail1_afat503_01[1].fabh066,s_detail1_afat503_01[1].fabh066_desc,
#             s_detail1_afat503_01[1].fabh067,s_detail1_afat503_01[1].fabh067_desc,
#             s_detail1_afat503_01[1].fabh068,s_detail1_afat503_01[1].fabh068_desc,
#             s_detail1_afat503_01[1].fabh069,s_detail1_afat503_01[1].fabh069_desc
             
      BEFORE CONSTRUCT
         SELECT glaa004 INTO g_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_fabgld
         
      ON ACTION controlp INFIELD fabh021
            #add-point:ON ACTION controlp INFIELD fabh021
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabh021  #顯示到畫面上
            NEXT FIELD fabh021                     #返回原欄位
    
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh021
            #add-point:BEFORE FIELD fabh021

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh021
            
            #add-point:AFTER FIELD fabh021

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh036
            #add-point:BEFORE FIELD fabh036

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh036
            
            #add-point:AFTER FIELD fabh036

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabh036
         ON ACTION controlp INFIELD fabh036
            #add-point:ON ACTION controlp INFIELD fabh036

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh026
            #add-point:BEFORE FIELD fabh026

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh026
            
            #add-point:AFTER FIELD fabh026

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabh026
         ON ACTION controlp INFIELD fabh026
         
         ON ACTION controlp INFIELD fabh026_desc
            #add-point:ON ACTION controlp INFIELD fabh026
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                                           #161024-00008#4 
            CALL q_ooef001_1()                                          #161024-00008#4 
            DISPLAY g_qryparam.return1 TO fabh026_desc  #顯示到畫面上
            NEXT FIELD fabh026_desc                     #返回原欄位            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh027
            #add-point:BEFORE FIELD fabh027

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh027
            
            #add-point:AFTER FIELD fabh027

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabh027
         ON ACTION controlp INFIELD fabh027
         
         ON ACTION controlp INFIELD fabh027_desc
            #add-point:ON ACTION controlp INFIELD fabh027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#20150113 mod by chenying            
#            CALL q_ooeg001()
            LET g_qryparam.arg1 = g_today    
            CALL q_ooeg001_4()
#20150113 mod by chenying                
            DISPLAY g_qryparam.return1 TO fabh027_desc  #顯示到畫面上
            NEXT FIELD fabh027_desc 
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh028
            #add-point:BEFORE FIELD fabh028

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh028
            
            #add-point:AFTER FIELD fabh028

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabh028
         ON ACTION controlp INFIELD fabh028
         
         ON ACTION controlp INFIELD fabh028_desc
            #add-point:ON ACTION controlp INFIELD fabh028
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#20150113 mod by chenying              
#            CALL q_ooef001()
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            LET g_qryparam.arg1 = g_today
            #CALL q_ooeg001_5()                #呼叫開窗   #161221-00054#4 MARK xul
            CALL q_ooeg001_15()       #161221-00054#4 add xul  
#20150113 mod by chenying             
            DISPLAY g_qryparam.return1 TO fabh028_desc  #顯示到畫面上
            NEXT FIELD fabh028_desc  
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh029
            #add-point:BEFORE FIELD fabh029

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh029
            
            #add-point:AFTER FIELD fabh029

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabh029
         ON ACTION controlp INFIELD fabh029
         
         ON ACTION controlp INFIELD fabh029_desc
            #add-point:ON ACTION controlp INFIELD fabh029
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#20150113 mod by chenying            
#            LET g_qryparam.arg1 = "287"  
#            CALL q_oocq002()                                
            CALL q_oocq002_287()
#20150113 mod by chenying 
            DISPLAY g_qryparam.return1 TO fabh029_desc  #顯示到畫面上
            NEXT FIELD fabh029_desc  
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh030
            #add-point:BEFORE FIELD fabh030

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh030
            
            #add-point:AFTER FIELD fabh030

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabh030
         ON ACTION controlp INFIELD fabh030
         
         ON ACTION controlp INFIELD fabh030_desc
            #add-point:ON ACTION controlp INFIELD fabh030
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#1  add
            #CALL q_pmaa001()        #160913-00017#1  mark               #呼叫開窗      
            DISPLAY g_qryparam.return1 TO fabh030_desc  #顯示到畫面上
            NEXT FIELD fabh030_desc  
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh031
            #add-point:BEFORE FIELD fabh031

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh031
            
            #add-point:AFTER FIELD fabh031

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabh031
         ON ACTION controlp INFIELD fabh031
         
         ON ACTION controlp INFIELD fabh031_desc
            #add-point:ON ACTION controlp INFIELD fabh031
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#1  add
            #CALL q_pmaa001()        #160913-00017#1  mark               #呼叫開窗      
            DISPLAY g_qryparam.return1 TO fabh031_desc  #顯示到畫面上
            NEXT FIELD fabh031_desc  
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh032
            #add-point:BEFORE FIELD fabh032

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh032
            
            #add-point:AFTER FIELD fabh032

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabh032
         ON ACTION controlp INFIELD fabh032
         
         ON ACTION controlp INFIELD fabh032_desc
            #add-point:ON ACTION controlp INFIELD fabh032
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = "281"  #20150113 mark by chenying
#            CALL q_oocq002()             #20150113 mark by chenying                    
            CALL q_oocq002_281()          #20150113 add by chenying
            DISPLAY g_qryparam.return1 TO fabh032_desc  #顯示到畫面上
            NEXT FIELD fabh032_desc  
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh033
            #add-point:BEFORE FIELD fabh033

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh033
            
            #add-point:AFTER FIELD fabh033

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabh033
         ON ACTION controlp INFIELD fabh033
         
         ON ACTION controlp INFIELD fabh033_desc
            #add-point:ON ACTION controlp INFIELD fabh033
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooag001()   #20150113 mark by chenying                            #呼叫開窗
            CALL q_ooag001_8()  #20150113 add by chenying
            DISPLAY g_qryparam.return1 TO fabh033_desc  #顯示到畫面上
            NEXT FIELD fabh033_desc 
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh034
            #add-point:BEFORE FIELD fabh034

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh034
            
            #add-point:AFTER FIELD fabh034

            #END add-point
            
 
         #Ctrlp:construct.c.page2.fabh034
         ON ACTION controlp INFIELD fabh034
         
         ON ACTION controlp INFIELD fabh034_desc
            #add-point:ON ACTION controlp INFIELD fabh034
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO fabh034_desc  #顯示到畫面上
            NEXT FIELD fabh034_desc 
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD fabh035
            #add-point:BEFORE FIELD fabh035

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD fabh035
            
            #add-point:AFTER FIELD fabh035

            #END add-point
            
         #20150113 add by chenying
         #Ctrlp:construct.c.page2.fabh035
         ON ACTION controlp INFIELD fabh035_desc
            #add-point:ON ACTION controlp INFIELD fabh035
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_2()
            DISPLAY g_qryparam.return1 TO fabh035_desc  #顯示到畫面上
            NEXT FIELD fabh035_desc
            #END add-point

         ON ACTION controlp INFIELD fabh042_desc
            #add-point:ON ACTION controlp INFIELD fabh042
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO fabh042_desc  #顯示到畫面上
            NEXT FIELD fabh042_desc
            #END add-point
 
         ON ACTION controlp INFIELD fabh043_desc
            #add-point:ON ACTION controlp INFIELD fabh043
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO fabh043_desc  #顯示到畫面上
            NEXT FIELD fabh043_desc
            #END add-point 
         #20150113 add by chenying   
   END CONSTRUCT            
END DIALOG

 
{</section>}
 
{<section id="afat503_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 顯示單身
# Memo...........:
# Usage..........: CALL afat503_01_b_fill()
# Modify.........:
################################################################################
PUBLIC FUNCTION afat503_01_b_fill()
   DEFINE p_wc2      STRING
     #161111-00028#7--modify---begin-------------
  #DEFINE g_glad                RECORD LIKE glad_t.*
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
   #161111-00028#7--modify---end-------------
   #160129-00015#13 add--str--
   #多語言SQL
   DEFINE l_get_sql   RECORD
          fabh027     STRING,  #部门
          fabh028     STRING,  #成本中心
          fabh029     STRING,  #区域
          fabh032     STRING,  #客群
          fabh033     STRING,  #人员
          fabh034     STRING,  #项目编号
          fabh035     STRING,  #WBS编号
          fabh042     STRING,  #渠道
          fabh043     STRING,  #品牌
          fabh030     STRING,  #交易客商
          fabh031     STRING,  #账款客商
          fabh026     STRING,  #营运据点
          fabh021     STRING   #异动科目     
                      END RECORD    
   #160129-00015#13 add--end--
   
   SELECT glaa004 INTO g_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_fabgld
   CALL g_fabh2_d.clear()
   
#160129-00015#13 add--str--
   INITIALIZE l_get_sql.* TO NULL

   #异动科目 fabh021
   CALL s_fin_get_account_sql('ta4','ta5','fabhent','fabhld','fabh021') RETURNING l_get_sql.fabh021
   #营运据点 fabh026
   CALL s_fin_get_department_sql('ta3','fabhent','fabh026') RETURNING l_get_sql.fabh026   
   #人員     fabh033
   CALL s_fin_get_person_sql('ta6','fabhent','fabh033') RETURNING l_get_sql.fabh033
   #部門     fabh027
   CALL s_fin_get_department_sql('ta7','fabhent','fabh027') RETURNING l_get_sql.fabh027
   #成本中心  fabh028 
   CALL s_fin_get_department_sql('ta8','fabhent','fabh028') RETURNING l_get_sql.fabh028
   #區域      fabh029
   CALL s_fin_get_acc_sql('ta9','fabhent','287','fabh029') RETURNING l_get_sql.fabh029
   #客群      fabh032
   CALL s_fin_get_acc_sql('ta10','fabhent','281','fabh032') RETURNING l_get_sql.fabh032
   #專案代號  fabh034
   CALL s_fin_get_project_sql('ta12','fabhent','fabh034') RETURNING l_get_sql.fabh034
   #WBS編號   fabh035  
   CALL s_fin_get_wbs_sql('ta13','fabhent','fabh034','fabh035') RETURNING l_get_sql.fabh035
   #渠道      fabh042
   CALL s_fin_get_oojdl003_sql('ta14','fabhent','fabh042') RETURNING l_get_sql.fabh042
   #品牌      fabh043
   CALL s_fin_get_acc_sql('ta15','fabhent','2002','fabh043') RETURNING l_get_sql.fabh043 
   #交易客商  fabh030
   CALL s_fin_get_trading_partner_abbr_sql('t16','fabhent','fabh030') RETURNING l_get_sql.fabh030
   #账款客商  fabh031
   CALL s_fin_get_trading_partner_abbr_sql('t17','fabhent','fabh031') RETURNING l_get_sql.fabh031
#160129-00015#13 add--end--   
   
   #160129-00015#13 mod--str--
   #LET g_sql = "SELECT  UNIQUE fabhseq,fabh021,fabh036,fabh026, 
   #            fabh027,fabh028,fabh029,fabh030,fabh031,fabh032,fabh033,fabh034,fabh035,
   #            fabh041,fabh042,fabh043,fabh060,fabh061,fabh062,fabh063,fabh064,fabh065,
   #            fabh066,fabh067,fabh068,fabh069
   #            FROM fabh_t",   
   #            " INNER JOIN fabg_t ON fabgld = fabhld ",                                                                                           
   #            " WHERE fabhent=? AND fabhld=? AND fabhdocno=?"
   #
   ##151105-00001#2 --s add
   #IF g_prog = 'afat509' THEN
   #   LET g_sql = "SELECT  UNIQUE fabhseq,fabh021,fabh036,fabh026, 
   #               fabh027,fabh028,fabh029,fabh030,fabh031,fabh032,fabh033,fabh034,fabh035,
   #               fabh041,fabh042,fabh043,fabh060,fabh061,fabh062,fabh063,fabh064,fabh065,
   #               fabh066,fabh067,fabh068,fabh069
   #               FROM fabh_t",   
   #               " INNER JOIN fabg_t ON fabgld = fabhld ",                                                                                           
   #               ",faah_t ",                                                                                                    
   #               " LEFT JOIN faacl_t ON faah006 = faacl001 AND faacl002 ='"||g_dlang||"' AND faaclent =  faahent",              
   #               " WHERE fabhent=? AND fabhld=? AND fabhdocno=?",                                                                
   #               " AND faahent = fabhent AND faahstus = 'Y' AND faah001 = fabh000 AND faah003 = fabh001 AND faah004 = fabh002"  
   #END IF
   ##151105-00001#2 --e add
   #160129-00015#13 mod--end--
   
      LET g_sql = "SELECT  UNIQUE fabhseq,fabh021,",l_get_sql.fabh021,",fabh036,fabh026,",l_get_sql.fabh026,", 
               fabh027,",l_get_sql.fabh027,",fabh028,",l_get_sql.fabh028,",fabh029,",l_get_sql.fabh029,",
               fabh030,",l_get_sql.fabh030,",fabh031,",l_get_sql.fabh031,",fabh032,",l_get_sql.fabh032,",
               fabh033,",l_get_sql.fabh033,",fabh034,",l_get_sql.fabh034,",fabh035,",l_get_sql.fabh035,",
               fabh041,fabh042,",l_get_sql.fabh042,",fabh043,",l_get_sql.fabh043,",
               fabh060,fabh061,fabh062,fabh063,fabh064,fabh065,
               fabh066,fabh067,fabh068,fabh069
               FROM fabh_t",   
               " INNER JOIN fabg_t ON fabgld = fabhld AND fabgent = fabhent ", #161221-00054#4 add  AND fabgent = fabhent
               " LEFT JOIN faah_t ON fabhent = faahent AND fabh000 =faah001 AND fabh001 = faah003 AND fabh002 = faah004 ", #161115-00003#1   2016/11/18 By 07900  add                
               " WHERE fabhent=? AND fabhld=? AND fabhdocno=?"
 
   IF g_prog = 'afat509' THEN
      LET g_sql = "SELECT  UNIQUE fabhseq,fabh021,",l_get_sql.fabh021,",fabh036,fabh026,",l_get_sql.fabh026,", 
                  fabh027,",l_get_sql.fabh027,",fabh028,",l_get_sql.fabh028,",fabh029,",l_get_sql.fabh029,",
                  fabh030,",l_get_sql.fabh030,",fabh031,",l_get_sql.fabh031,",fabh032,",l_get_sql.fabh032,",
                  fabh033,",l_get_sql.fabh033,",fabh034,",l_get_sql.fabh034,",fabh035,",l_get_sql.fabh035,",
                  fabh041,fabh042,",l_get_sql.fabh042,",fabh043,",l_get_sql.fabh043,",
                  fabh060,fabh061,fabh062,fabh063,fabh064,fabh065,
                  fabh066,fabh067,fabh068,fabh069
                  FROM fabh_t",   
                  " INNER JOIN fabg_t ON fabgld = fabhld AND fabgent = fabhent ", #161221-00054#4 add AND fabgent = fabhent                                                                                          
                  ",faah_t ",                                                                                                    
                  " LEFT JOIN faacl_t ON faah006 = faacl001 AND faacl002 ='"||g_dlang||"' AND faaclent =  faahent",              
                  " WHERE fabhent=? AND fabhld=? AND fabhdocno=?",                                                                
                  " AND faahent = fabhent AND faahstus = 'Y' AND faah001 = fabh000 AND faah003 = fabh001 AND faah004 = fabh002"  
   END IF

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF NOT cl_null(g_wc_d) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc_d CLIPPED
   END IF
   
   #子單身的WC
   
   LET g_sql = g_sql, " ORDER BY fabh_t.fabhseq"
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afat503_01_pb2 FROM g_sql
   DECLARE b_fill2_cs CURSOR FOR afat503_01_pb2
   
   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN b_fill2_cs USING g_enterprise,g_fabgld,g_fabgdocno
   #160129-00015#13 mod--str-- 
   #FOREACH b_fill2_cs INTO g_fabh2_d[l_ac].fabhseq,g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh036, 
   #    g_fabh2_d[l_ac].fabh026,g_fabh2_d[l_ac].fabh027,g_fabh2_d[l_ac].fabh028,g_fabh2_d[l_ac].fabh029, 
   #    g_fabh2_d[l_ac].fabh030,g_fabh2_d[l_ac].fabh031,g_fabh2_d[l_ac].fabh032,g_fabh2_d[l_ac].fabh033, 
   #    g_fabh2_d[l_ac].fabh034,g_fabh2_d[l_ac].fabh035,g_fabh2_d[l_ac].fabh041,
   #    g_fabh2_d[l_ac].fabh042,g_fabh2_d[l_ac].fabh043, g_fabh2_d[l_ac].fabh060,g_fabh2_d[l_ac].fabh061,
   #    g_fabh2_d[l_ac].fabh062,g_fabh2_d[l_ac].fabh063, g_fabh2_d[l_ac].fabh064,g_fabh2_d[l_ac].fabh065,
   #    g_fabh2_d[l_ac].fabh066,g_fabh2_d[l_ac].fabh067,g_fabh2_d[l_ac].fabh068,g_fabh2_d[l_ac].fabh069

   FOREACH b_fill2_cs INTO g_fabh2_d[l_ac].fabhseq,g_fabh2_d[l_ac].fabh021,g_fabh2_d[l_ac].fabh021_desc,
       g_fabh2_d[l_ac].fabh036,   
       g_fabh2_d[l_ac].fabh026,g_fabh2_d[l_ac].fabh026_desc,g_fabh2_d[l_ac].fabh027,g_fabh2_d[l_ac].fabh027_desc,
       g_fabh2_d[l_ac].fabh028,g_fabh2_d[l_ac].fabh028_desc,g_fabh2_d[l_ac].fabh029,g_fabh2_d[l_ac].fabh029_desc, 
       g_fabh2_d[l_ac].fabh030,g_fabh2_d[l_ac].fabh030_desc,g_fabh2_d[l_ac].fabh031,g_fabh2_d[l_ac].fabh031_desc,
       g_fabh2_d[l_ac].fabh032,g_fabh2_d[l_ac].fabh032_desc,g_fabh2_d[l_ac].fabh033,g_fabh2_d[l_ac].fabh033_desc, 
       g_fabh2_d[l_ac].fabh034,g_fabh2_d[l_ac].fabh034_desc,g_fabh2_d[l_ac].fabh035,g_fabh2_d[l_ac].fabh035_desc,
       g_fabh2_d[l_ac].fabh041,
       g_fabh2_d[l_ac].fabh042,g_fabh2_d[l_ac].fabh042_desc,g_fabh2_d[l_ac].fabh043,g_fabh2_d[l_ac].fabh043_desc,
       g_fabh2_d[l_ac].fabh060,g_fabh2_d[l_ac].fabh061,
       g_fabh2_d[l_ac].fabh062,g_fabh2_d[l_ac].fabh063, g_fabh2_d[l_ac].fabh064,g_fabh2_d[l_ac].fabh065,
       g_fabh2_d[l_ac].fabh066,g_fabh2_d[l_ac].fabh067,g_fabh2_d[l_ac].fabh068,g_fabh2_d[l_ac].fabh069
   #160129-00015#13 mod--end--  
   

  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

   #160129-00015#13 add--str--
   LET g_fabh2_d[l_ac].fabh026_desc = s_desc_show1(g_fabh2_d[l_ac].fabh026,g_fabh2_d[l_ac].fabh026_desc)
   LET g_fabh2_d[l_ac].fabh027_desc = s_desc_show1(g_fabh2_d[l_ac].fabh027,g_fabh2_d[l_ac].fabh027_desc)
   LET g_fabh2_d[l_ac].fabh028_desc = s_desc_show1(g_fabh2_d[l_ac].fabh028,g_fabh2_d[l_ac].fabh028_desc)
   LET g_fabh2_d[l_ac].fabh029_desc = s_desc_show1(g_fabh2_d[l_ac].fabh029,g_fabh2_d[l_ac].fabh029_desc)
   LET g_fabh2_d[l_ac].fabh030_desc = s_desc_show1(g_fabh2_d[l_ac].fabh030,g_fabh2_d[l_ac].fabh030_desc)
   LET g_fabh2_d[l_ac].fabh031_desc = s_desc_show1(g_fabh2_d[l_ac].fabh031,g_fabh2_d[l_ac].fabh031_desc)
   LET g_fabh2_d[l_ac].fabh032_desc = s_desc_show1(g_fabh2_d[l_ac].fabh032,g_fabh2_d[l_ac].fabh032_desc)
   LET g_fabh2_d[l_ac].fabh033_desc = s_desc_show1(g_fabh2_d[l_ac].fabh033,g_fabh2_d[l_ac].fabh033_desc)
   LET g_fabh2_d[l_ac].fabh034_desc = s_desc_show1(g_fabh2_d[l_ac].fabh034,g_fabh2_d[l_ac].fabh034_desc)
   LET g_fabh2_d[l_ac].fabh035_desc = s_desc_show1(g_fabh2_d[l_ac].fabh035,g_fabh2_d[l_ac].fabh035_desc)
   LET g_fabh2_d[l_ac].fabh042_desc = s_desc_show1(g_fabh2_d[l_ac].fabh042,g_fabh2_d[l_ac].fabh042_desc)  
   LET g_fabh2_d[l_ac].fabh043_desc = s_desc_show1(g_fabh2_d[l_ac].fabh043,g_fabh2_d[l_ac].fabh043_desc)    
   #160129-00015#13 add--end--

   #161101-00071#1 add s ---
   LET g_fabh2_d[l_ac].fabh060_desc = g_fabh2_d[l_ac].fabh060
   LET g_fabh2_d[l_ac].fabh061_desc = g_fabh2_d[l_ac].fabh061
   LET g_fabh2_d[l_ac].fabh062_desc = g_fabh2_d[l_ac].fabh062
   LET g_fabh2_d[l_ac].fabh063_desc = g_fabh2_d[l_ac].fabh063
   LET g_fabh2_d[l_ac].fabh064_desc = g_fabh2_d[l_ac].fabh064
   LET g_fabh2_d[l_ac].fabh065_desc = g_fabh2_d[l_ac].fabh065
   LET g_fabh2_d[l_ac].fabh066_desc = g_fabh2_d[l_ac].fabh066
   LET g_fabh2_d[l_ac].fabh067_desc = g_fabh2_d[l_ac].fabh067
   LET g_fabh2_d[l_ac].fabh068_desc = g_fabh2_d[l_ac].fabh068
   LET g_fabh2_d[l_ac].fabh069_desc = g_fabh2_d[l_ac].fabh069
   #161101-00071#1 add e ---

      CALL afat503_01_b_ref()
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   LET l_ac=l_ac-1
   CALL g_fabh2_d.deleteElement(g_fabh2_d.getLength())
   
   LET l_ac = g_cnt
   LET g_cnt = 0  
   LET g_fabh_d2.* = g_fabh2_d.*
   FREE afat503_01_pb2
END FUNCTION

################################################################################
# Descriptions...: 連動lock其他單身table資料
# Memo...........:
# Usage..........: CALL afat503_01_lock_b(ps_table,ps_page)
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   
   #鎖定整組table
   #LET ls_group = "'1','2','3',"
   #僅鎖定自身table
   LET ls_group = "fabh_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afat503_01_bcl USING g_enterprise,
                                       g_fabgld,g_fabgdocno,g_fabh2_d[g_detail_idx].fabhseq 
#      OPEN afat503_01_bcl USING g_enterprise,
#                                       g_fabgld,g_fafaaj001,g_faaj002,g_faaj037
                                               
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat503_01_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 科目說明
# Memo...........:
# Usage..........: CALL afat503_01_fabh021_desc(p_fabh021)
# Input parameter: p_fabh021      科目編號
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh021_desc(p_fabh021)
   DEFINE p_fabh021  LIKE fabh_t.fabh021
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa004
   LET g_ref_fields[2] = p_fabh021
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabh2_d[l_ac].fabh021_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabh2_d[l_ac].fabh021_desc
END FUNCTION

################################################################################
# Descriptions...: 刪除單身後其他table連動
# Memo...........:
# Usage..........: CALL afat503_01_delete_b(ps_table,ps_keys_bak,ps_page)
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
 
   #判斷是否是同一群組的table
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
    
      DELETE FROM fabh_t
       WHERE fabhent = g_enterprise AND
         fabhld = ps_keys_bak[1] AND fabhdocno = ps_keys_bak[2] AND fabhseq = ps_keys_bak[3]
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
        
   END IF
END FUNCTION

################################################################################
# Descriptions...: 修改單身後其他table連動
# Memo...........:
# Usage..........: CALL afat503_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fabh_t" THEN
      
      UPDATE fabh_t 
         SET (fabhld,fabhdocno,
              fabhseq
              ,fabh021,fabh036,fabh026,fabh027,fabh028,fabh029,fabh030,fabh031,fabh032,fabh033,fabh034,fabh035,
              fabh041,fabh042,fabh043,fabh060,fabh061,fabh062,fabh063,fabh064,fabh065,fabh066,fabh067,fabh068,fabh069) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fabh2_d[g_detail_idx].fabh021,g_fabh2_d[g_detail_idx].fabh036, 
                  g_fabh2_d[g_detail_idx].fabh026,g_fabh2_d[g_detail_idx].fabh027,g_fabh2_d[g_detail_idx].fabh028, 
                  g_fabh2_d[g_detail_idx].fabh029,g_fabh2_d[g_detail_idx].fabh030,g_fabh2_d[g_detail_idx].fabh031, 
                  g_fabh2_d[g_detail_idx].fabh032,g_fabh2_d[g_detail_idx].fabh033,g_fabh2_d[g_detail_idx].fabh034, 
                  g_fabh2_d[g_detail_idx].fabh035,g_fabh2_d[g_detail_idx].fabh041,g_fabh2_d[g_detail_idx].fabh042,
                  g_fabh2_d[g_detail_idx].fabh043,g_fabh2_d[g_detail_idx].fabh060,g_fabh2_d[g_detail_idx].fabh061,
                  g_fabh2_d[g_detail_idx].fabh062,g_fabh2_d[g_detail_idx].fabh063,g_fabh2_d[g_detail_idx].fabh064,
                  g_fabh2_d[g_detail_idx].fabh065,g_fabh2_d[g_detail_idx].fabh066,g_fabh2_d[g_detail_idx].fabh067,
                  g_fabh2_d[g_detail_idx].fabh068,g_fabh2_d[g_detail_idx].fabh069
                  ) 
         WHERE fabhent = g_enterprise AND fabhld = ps_keys_bak[1] AND fabhdocno = ps_keys_bak[2] AND fabhseq = ps_keys_bak[3]
      
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabh_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabh_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 連動unlock其他單身table資料
# Memo...........:
# Usage..........: CALL afat503_01_unlock_b(ps_table,ps_page)
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   
   
   LET ls_group = "'1','2','3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afat503_01_bcl
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 科目檢查
# Memo...........:
# Usage..........: CALL afat503_01_fabh021_chk(p_fabh021)
#                  RETURNING g_errno
# Input parameter: p_fabh021    科目編號
# Return code....: g_errno      錯誤編號
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh021_chk(p_fabh021)
   DEFINE p_fabh021    LIKE fabh_t.fabh021
   DEFINE l_glacstus   LIKE glac_t.glacstus
   DEFINE l_glac003    LIKE glac_t.glac003
   DEFINE l_glac006    LIKE glac_t.glac006
   
   LET g_errno = ''
   SELECT glacstus,glac003,glac006 INTO l_glacstus,l_glac003,l_glac006 FROM glac_t
    WHERE glacent = g_enterprise
      AND glac001 = g_glaa004  #会计科目参照表号
      AND glac002 = p_fabh021
       
   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00011'
      WHEN l_glacstus = 'N'      LET g_errno = 'sub-01302'  #'agl-00012'   #160318-00005#11 mod 
      WHEN l_glac003 = '1'       LET g_errno = 'agl-00013'  #必须为非统治类科目
      WHEN l_glac006 <>'1'       LET g_errno = 'agl-00030'  #须为账户性质   
   END CASE   
END FUNCTION

################################################################################
# Descriptions...: 部門檢查
# Memo...........:
# Usage..........: CALL afat503_01_fabh027_chk(p_fabh027)
#                  RETURNING g_errno
# Input parameter: p_fabh027    部門編號
# Return code....: g_errno      錯誤代碼
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh027_chk(p_fabh027)
   DEFINE p_fabh027      LIKE fabh_t.fabh027
   DEFINE l_ooegstus     LIKE ooeg_t.ooegstus
   
   LET g_errno = ''
   
   SELECT ooegstus INTO l_ooegstus FROM ooeg_t
    WHERE ooegent = g_enterprise
      AND ooeg001 = p_fabh027
      AND ooeg006 <= g_fabgdocdt
      AND (ooeg007 IS NULL OR ooeg007 >= g_fabgdocdt ) 
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'abm-00006'
      WHEN l_ooegstus = 'N'       LET g_errno = 'sub-01302'  #'abm-00007' #160318-00005#11 mod 
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 區域/客群編號檢核
# Memo...........:
# Usage..........: CALL afat503_01_fabh029_chk(p_oocq001,p_oocq002)
# Input parameter: p_oocq001      應用分類類型
#                : p_oocq002      應用分類碼
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh029_chk(p_oocq001,p_oocq002)
   DEFINE p_oocq001     LIKE oocq_t.oocq001
   DEFINE p_oocq002     LIKE oocq_t.oocq002
   DEFINE l_oocqstus     LIKE oocq_t.oocqstus
   
   LET g_errno = ''
   SELECT oocqstus INTO l_oocqstus FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = p_oocq001
      AND oocq002 = p_oocq002
   CASE
     WHEN SQLCA.SQLCODE = 100 
        IF p_oocq001 = '287' THEN      
           LET g_errno =  'sub-01303' #'apm-00092' #160318-00005#11 mod  
        ELSE
           LET g_errno = 'axm-00003'  
        END IF 
     
     WHEN l_oocqstus = 'N'
        IF p_oocq001 = '287' THEN    
           LET g_errno =  'sub-01302'  #'apm-00093' #160318-00005#11 mod 
        ELSE
           LET g_errno = 'sub-01302'  #'axm-00004' #160318-00005#11 mod
        END IF       
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 客商編號檢查
# Memo...........:
# Usage..........: CALL afat503_01_fabh030_chk(p_pmaa001)
# Input parameter: p_pmaa001     客商編號
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh030_chk(p_pmaa001)
   DEFINE p_pmaa001     LIKE pmaa_t.pmaa001
   DEFINE l_pmaastus    LIKE pmaa_t.pmaastus

   LET g_errno = ''
   SELECT pmaastus INTO l_pmaastus FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = p_pmaa001

   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'apm-00028'
      WHEN l_pmaastus = 'N'      LET g_errno = 'sub-01302' #'apm-00029' #160318-00005#11 mod  
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 人員編號檢查
# Memo...........:
# Usage..........: CALL afat503_01_fabh033_chk(p_fabh033)
# Input parameter: p_fabh033     人員編號
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh033_chk(p_fabh033)
   DEFINE p_fabh033    LIKE fabh_t.fabh033
   DEFINE l_ooagstus   LIKE ooag_t.ooagstus


   LET g_errno=''
   SELECT ooagstus INTO l_ooagstus FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = p_fabh033

   CASE
      WHEN SQLCA.SQLCODE=100   LET g_errno = 'aoo-00074'
      WHEN l_ooagstus ='N'     LET g_errno = 'sub-01302'  #'aoo-00071' #160318-00005#11 mod  
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 組織說明
# Memo...........:
# Usage..........: CALL afat503_01_ooefl003(p_ooefl001)
# Input parameter: p_ooefl001     組織編號
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh026_desc(p_ooefl001)
   DEFINE p_ooefl001       LIKE ooefl_t.ooefl001
   DEFINE r_desc           LIKE ooefl_t.ooefl003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooefl001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 區域/客群說明
# Memo...........:
# Usage..........: CALL afat503_01_fabh029_desc(p_oocql001,p_oocql002)
#                  RETURNING 回传参数
# Input parameter: p_oocql001     應用分類
#                : p_oocql002     應用分類碼
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh029_desc(p_oocql001,p_oocql002)
   DEFINE p_oocql001         LIKE oocql_t.oocql001
   DEFINE p_oocql002         LIKE oocql_t.oocql002
   DEFINE r_desc             LIKE oocql_t.oocql004
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oocql001
   LET g_ref_fields[1] = p_oocql002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= ? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 客戶名稱
# Memo...........:
# Usage..........: CALL afat503_01_fabh030_desc(p_pmaal001)
# Input parameter: p_pmaal001     客戶編號
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh030_desc(p_pmaal001)
   DEFINE p_pmaal001     LIKE pmaal_t.pmaal001
   DEFINE r_desc         LIKE pmaal_t.pmaal004
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmaal001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 姓名
# Memo...........:
# Usage..........: CALL afat503_01_fabh033_desc(p_fabh033)
# Input parameter: p_fabh033      與昂編號
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh033_desc(p_fabh033)
   DEFINE p_fabh033     LIKE fabh_t.fabh033
   DEFINE r_ooag011     LIKE ooag_t.ooag011
   
   SELECT ooag011 INTO r_ooag011 FROM ooag_t
   WHERE ooagent=g_enterprise AND ooag001=p_fabh033
   
   RETURN r_ooag011
END FUNCTION

#+欄位說明
PRIVATE FUNCTION afat503_01_b_ref()
# #161111-00028#7--modify---begin-------------
#  #DEFINE g_glad                RECORD LIKE glad_t.*
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
   #161111-00028#7--modify---end-------------



#160129-00015#13 mark--str--
#   CALL s_fin_sel_glad(g_fabgld,g_fabh2_d[l_ac].fabh021,'ALL') RETURNING g_glad.* #20150115 add by chenying
#   #科目
#   CALL afat503_01_fabh021_desc(g_fabh2_d[l_ac].fabh021)
#   #營運中心
#   CALL afat503_01_fabh026_desc(g_fabh2_d[l_ac].fabh026) RETURNING g_fabh2_d[l_ac].fabh026_desc
#   LET g_fabh2_d[l_ac].fabh026_desc=g_fabh2_d[l_ac].fabh026,g_fabh2_d[l_ac].fabh026_desc
#   #部門
#   CALL afat503_01_fabh026_desc(g_fabh2_d[l_ac].fabh027) RETURNING g_fabh2_d[l_ac].fabh027_desc
#   LET g_fabh2_d[l_ac].fabh027_desc=g_fabh2_d[l_ac].fabh027,g_fabh2_d[l_ac].fabh027_desc
#   #利潤中心
#   CALL afat503_01_fabh026_desc(g_fabh2_d[l_ac].fabh028) RETURNING g_fabh2_d[l_ac].fabh028_desc
#   LET g_fabh2_d[l_ac].fabh028_desc=g_fabh2_d[l_ac].fabh028,g_fabh2_d[l_ac].fabh028_desc
#   #區域
#   CALL afat503_01_fabh043_desc("287",g_fabh2_d[l_ac].fabh029) RETURNING g_fabh2_d[l_ac].fabh029_desc
#   LET g_fabh2_d[l_ac].fabh029_desc=g_fabh2_d[l_ac].fabh029,g_fabh2_d[l_ac].fabh029_desc
#   #交易客戶
#   CALL afat503_01_fabh030_desc(g_fabh2_d[l_ac].fabh030) RETURNING g_fabh2_d[l_ac].fabh030_desc
#   LET g_fabh2_d[l_ac].fabh030_desc=g_fabh2_d[l_ac].fabh030,g_fabh2_d[l_ac].fabh030_desc
#   #帳款客戶
#   CALL afat503_01_fabh030_desc(g_fabh2_d[l_ac].fabh031) RETURNING g_fabh2_d[l_ac].fabh031_desc
#   LET g_fabh2_d[l_ac].fabh031_desc=g_fabh2_d[l_ac].fabh031,g_fabh2_d[l_ac].fabh031_desc
#   #客群
#   CALL afat503_01_fabh043_desc("281",g_fabh2_d[l_ac].fabh032) RETURNING g_fabh2_d[l_ac].fabh032_desc
#   LET g_fabh2_d[l_ac].fabh032_desc=g_fabh2_d[l_ac].fabh032,g_fabh2_d[l_ac].fabh032_desc
#   #人員
#   CALL afat503_01_fabh033_desc(g_fabh2_d[l_ac].fabh033) RETURNING g_fabh2_d[l_ac].fabh033_desc
#   LET g_fabh2_d[l_ac].fabh033_desc=g_fabh2_d[l_ac].fabh033,g_fabh2_d[l_ac].fabh033_desc
#   #專案編號
#   CALL afat503_01_fabh034_desc(g_fabh2_d[l_ac].fabh034) RETURNING g_fabh2_d[l_ac].fabh034_desc
#   LET g_fabh2_d[l_ac].fabh034_desc=g_fabh2_d[l_ac].fabh034,g_fabh2_d[l_ac].fabh034_desc
#   #20150113 add by chenying
#   #WBS
#   CALL afat503_01_fabh035_desc(g_fabh2_d[l_ac].fabh034,g_fabh2_d[l_ac].fabh035) RETURNING g_fabh2_d[l_ac].fabh035_desc
#   LET g_fabh2_d[l_ac].fabh035_desc=g_fabh2_d[l_ac].fabh035,g_fabh2_d[l_ac].fabh035_desc  
#   #渠道
##   CALL s_desc_show1(g_fabh2_d[l_ac].fabh042,s_desc_get_oojdl003_desc(g_fabh2_d[l_ac].fabh042)) RETURNING g_fabh2_d[l_ac].fabh042_desc
#   CALL afat503_01_fabh042_desc(g_fabh2_d[l_ac].fabh042)  RETURNING g_fabh2_d[l_ac].fabh042_desc
#   LET g_fabh2_d[l_ac].fabh042_desc=g_fabh2_d[l_ac].fabh042,g_fabh2_d[l_ac].fabh042_desc  
#   #品牌
##   CALL s_desc_show1(g_fabh2_d[l_ac].fabh043,s_desc_get_acc_desc('2002',g_fabh2_d[l_ac].fabh043)) RETURNING g_fabh2_d[l_ac].fabh043_desc
#   CALL afat503_01_fabh043_desc('2002',g_fabh2_d[l_ac].fabh043) RETURNING g_fabh2_d[l_ac].fabh043_desc
#   LET g_fabh2_d[l_ac].fabh043_desc=g_fabh2_d[l_ac].fabh043,g_fabh2_d[l_ac].fabh043_desc   
#   CALL cl_set_combo_scc('fabh041','6013') #20150114 add by chenying
#160129-00015#13 mark--end--


   CALL s_fin_sel_glad(g_fabgld,g_fabh2_d[l_ac].fabh021,'ALL') RETURNING g_glad.* #161101-00071#1 add  
 
   
   IF g_glad.glad017 = 'Y' AND NOT cl_null(g_fabh2_d[l_ac].fabh060) THEN
      LET g_fabh2_d[l_ac].fabh060_desc = s_desc_show1(g_fabh2_d[l_ac].fabh060,s_fin_get_accting_desc(g_glad.glad0171,g_fabh2_d[l_ac].fabh060))
   END IF
   IF g_glad.glad018 = 'Y' AND NOT cl_null(g_fabh2_d[l_ac].fabh061) THEN
      LET g_fabh2_d[l_ac].fabh061_desc = s_desc_show1(g_fabh2_d[l_ac].fabh061,s_fin_get_accting_desc(g_glad.glad0181,g_fabh2_d[l_ac].fabh061))
   END IF
   IF g_glad.glad019 = 'Y' AND NOT cl_null(g_fabh2_d[l_ac].fabh062) THEN
      LET g_fabh2_d[l_ac].fabh062_desc = s_desc_show1(g_fabh2_d[l_ac].fabh062,s_fin_get_accting_desc(g_glad.glad0191,g_fabh2_d[l_ac].fabh062))
   END IF
   IF g_glad.glad020 = 'Y' AND NOT cl_null(g_fabh2_d[l_ac].fabh063) THEN
      LET g_fabh2_d[l_ac].fabh063_desc = s_desc_show1(g_fabh2_d[l_ac].fabh063,s_fin_get_accting_desc(g_glad.glad0201,g_fabh2_d[l_ac].fabh063))
   END IF
   IF g_glad.glad021 = 'Y' AND NOT cl_null(g_fabh2_d[l_ac].fabh064) THEN
      LET g_fabh2_d[l_ac].fabh064_desc = s_desc_show1(g_fabh2_d[l_ac].fabh064,s_fin_get_accting_desc(g_glad.glad0211,g_fabh2_d[l_ac].fabh064))
   END IF
   IF g_glad.glad022 = 'Y' AND NOT cl_null(g_fabh2_d[l_ac].fabh065) THEN   
      LET g_fabh2_d[l_ac].fabh065_desc = s_desc_show1(g_fabh2_d[l_ac].fabh065,s_fin_get_accting_desc(g_glad.glad0221,g_fabh2_d[l_ac].fabh065))
   END IF
   IF g_glad.glad023 = 'Y' AND NOT cl_null(g_fabh2_d[l_ac].fabh066) THEN
      LET g_fabh2_d[l_ac].fabh066_desc = s_desc_show1(g_fabh2_d[l_ac].fabh066,s_fin_get_accting_desc(g_glad.glad0231,g_fabh2_d[l_ac].fabh066))
   END IF
   IF g_glad.glad024 = 'Y' AND NOT cl_null(g_fabh2_d[l_ac].fabh067) THEN   
      LET g_fabh2_d[l_ac].fabh067_desc = s_desc_show1(g_fabh2_d[l_ac].fabh067,s_fin_get_accting_desc(g_glad.glad0241,g_fabh2_d[l_ac].fabh067))
   END IF
   IF g_glad.glad025 = 'Y' AND NOT cl_null(g_fabh2_d[l_ac].fabh068) THEN   
      LET g_fabh2_d[l_ac].fabh068_desc = s_desc_show1(g_fabh2_d[l_ac].fabh068,s_fin_get_accting_desc(g_glad.glad0251,g_fabh2_d[l_ac].fabh068))
   END IF
   IF g_glad.glad026 = 'Y' AND NOT cl_null(g_fabh2_d[l_ac].fabh069) THEN   
      LET g_fabh2_d[l_ac].fabh069_desc = s_desc_show1(g_fabh2_d[l_ac].fabh069,s_fin_get_accting_desc(g_glad.glad0261,g_fabh2_d[l_ac].fabh069))
   END IF   
   #20150113 add by chenying

 
   

#160129-00015#13 mod--str--
   #DISPLAY BY NAME g_fabh2_d[l_ac].fabh021_desc,g_fabh2_d[l_ac].fabh026_desc,g_fabh2_d[l_ac].fabh027_desc,
   #   g_fabh2_d[l_ac].fabh028_desc,g_fabh2_d[l_ac].fabh029_desc,g_fabh2_d[l_ac].fabh030_desc,
   #   g_fabh2_d[l_ac].fabh031_desc,g_fabh2_d[l_ac].fabh032_desc,g_fabh2_d[l_ac].fabh033_desc,
   #   g_fabh2_d[l_ac].fabh034_desc,
   #   g_fabh2_d[l_ac].fabh041,g_fabh2_d[l_ac].fabh035_desc,g_fabh2_d[l_ac].fabh042_desc,g_fabh2_d[l_ac].fabh043_desc #20150113 add by chenying
      
   DISPLAY BY NAME g_fabh2_d[l_ac].fabh041   
#160129-00015#13 mod--end--      
END FUNCTION

################################################################################
# Descriptions...: 專案說明
# Memo...........:
# Usage..........: CALL afat503_01_fabh034_desc(p_fabh034)
#                  RETURNING r_desc
# Input parameter: p_fabh034   專案編號
# Return code....: r_desc      說明
# Date & Author..: 2014/8/7 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh034_desc(p_fabh034)
   DEFINE p_fabh034      LIKE fabh_t.fabh034
   DEFINE r_desc         LIKE pjbal_t.pjbal003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_fabh034
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 调用子程序时,设定默认变量
# Memo...........:
# Usage..........: CALL afat503_01_set_defualt_value(p_fabgld,p_fabgdocno,p_fabhseq) 
#                  RETURNING 回传参数
# Input parameter: p_fabgld   帐套
#                : p_fabgdocno 异动单号
#                :p_fabhseq    项次
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/09/12 By 05426
# Modify.........:
################################################################################
PUBLIC FUNCTION afat503_01_set_defualt_value(p_fabgld,p_fabgdocno,p_fabhseq)
DEFINE p_fabgld      LIKE fabg_t.fabgld
DEFINE p_fabgdocno   LIKE fabg_t.fabgdocno
DEFINE p_fabhseq     LIKE fabh_t.fabhseq
DEFINE l_fabg005     LIKE fabg_t.fabg005   #單據性質 
DEFINE l_fabhseq     LIKE fabh_t.fabhseq   #项次
DEFINE l_fabh021     LIKE fabh_t.fabh021   #异动科目
DEFINE l_fabh020     LIKE fabh_t.fabh021   #异动科目
DEFINE l_glaacomp            LIKE glaa_t.glaacomp  #20141109
DEFINE l_para_data           STRING



   LET g_fabgld=p_fabgld
   LET g_fabgdocno=p_fabgdocno
   LET l_fabhseq=p_fabhseq
   LET l_ac=1                  
   SELECT  fabh021,fabh020 INTO l_fabh021,l_fabh020 FROM fabh_t WHERE fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=l_fabhseq AND fabhent=g_enterprise
   #预设带afai090的摘要
   SELECT oocq009 INTO g_fabh2_d[l_ac].fabh036 FROM oocq_t WHERE  oocqent=g_enterprise AND oocq001='3902' AND oocq002=l_fabh020  
   IF cl_null(l_fabh021) THEN 
   
      SELECT fabg005 INTO l_fabg005 FROM fabg_t WHERE fabgent = g_enterprise AND fabgld = g_fabgld AND fabgdocno = g_fabgdocno
               
      IF l_fabg005 = '8' THEN
         SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
         WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='8' AND glab003='9902_01' 
      END IF
      IF l_fabg005 = '9' THEN
         SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
         WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='9' AND glab003='9902_02' 
      END IF               
      IF l_fabg005 = '23' THEN
         SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
         WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='23' AND glab003='9902_09' 
      END IF
      IF l_fabg005 = '24' THEN
         SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
          WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='24' AND glab003='9902_10' 
      END IF
               
               #减值准备异动
      IF l_fabg005 = '14' THEN
         SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
         WHERE glabent=g_enterprise AND glabld=g_fabgld AND glab001='90' AND glab002='14' AND glab003='9902_11' 
      END IF
      
      #20141109--add--str--
      SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabgld
      CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9017') RETURNING l_para_data                 
      #6:銷帳
      IF l_fabg005 = '6' THEN
         IF l_para_data = 'Y' THEN
            SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
             WHERE glabent = g_enterprise AND glabld = g_fabgld
               AND glab001 = '90' AND glab002 = '25'
               AND glab003 = '9902_12' 
         ELSE
            SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
             WHERE glabent = g_enterprise AND glabld = g_fabgld
               AND glab001 = '90' AND glab002 = '6'
               AND glab003 = '9902_04' 
         END IF
      END IF
      
      #出售
      IF l_fabg005 = '4' THEN
         IF l_para_data = 'Y' THEN        
            SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
             WHERE glabent=g_enterprise AND glabld=g_fabgld
               AND glab002='25' AND glab001='90' AND glab003='9902_12'
         ELSE
            SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
             WHERE glabent=g_enterprise AND glabld=g_fabgld
               AND glab002='40' AND glab001='90' AND glab003='9902_05'       
         END IF 
         SELECT fabg005 INTO g_fabh2_d[l_ac].fabh031 FROM fabg_t WHERE fabgent = g_enterprise AND fabgld = g_fabgld AND fabgdocno = g_fabgdocno
          UPDATE fabh_t SET fabh031=g_fabh2_d[l_ac].fabh031
           WHERE fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=l_fabhseq AND fabhent=g_enterprise 
      END IF                   

      #报废
      IF l_fabg005 = '21' THEN
         IF l_para_data = 'Y' THEN        
            SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
             WHERE glabent=g_enterprise AND glabld=g_fabgld
               AND glab002='25' AND glab001='90' AND glab003='9902_12'
         ELSE
            SELECT glab005 INTO g_fabh2_d[l_ac].fabh021 FROM glab_t
             WHERE glabent=g_enterprise AND glabld=g_fabgld
               AND glab002='21' AND glab001='90' AND glab003='9902_03'       
         END IF 
      END IF               
      #20141109--add--end--   
      
      DISPLAY  g_fabh2_d[l_ac].fabh021 TO fabh021
      CALL afat503_01_fabh021_desc(g_fabh2_d[l_ac].fabh021)
      
      UPDATE fabh_t SET fabh021=g_fabh2_d[l_ac].fabh021,
                        fabh036=g_fabh2_d[l_ac].fabh036
      WHERE fabhld=g_fabgld AND fabhdocno=g_fabgdocno AND fabhseq=l_fabhseq AND fabhent=g_enterprise 
   END IF      
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
PRIVATE FUNCTION afat503_01_fabh022_desc(p_fabh022)
   DEFINE p_fabh022  LIKE fabh_t.fabh022
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa004
   LET g_ref_fields[2] = p_fabh022
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabh2_d[l_ac].fabh022_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabh2_d[l_ac].fabh022_desc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afat503_01_fabh035_desc(p_fabh034,p_fabh035)
# Input parameter:  
# Date & Author..: 20150113 By chenying
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh035_desc(p_fabh034,p_fabh035)
   DEFINE p_fabh034      LIKE fabh_t.fabh034
   DEFINE p_fabh035      LIKE fabh_t.fabh035
   DEFINE r_desc         LIKE pjbal_t.pjbal003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_fabh034
   LET g_ref_fields[2] = p_fabh035
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc

END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afat503_01_fabh042_desc(p_fabh042) 
# Input parameter:  
# Date & Author..: 20150114 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh042_desc(p_fabh042)
   DEFINE p_fabh042        LIKE fabh_t.fabh042
   DEFINE r_desc           LIKE oojdl_t.oojdl003
   
   LET r_desc = ''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_fabh042 
   CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL afat503_01_fabh043_desc(p_oocq001,p_oocq002)
# Input parameter:  
# Date & Author..: 20150114 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat503_01_fabh043_desc(p_oocq001,p_oocq002)
   DEFINE p_oocq001   LIKE oocq_t.oocq001
   DEFINE p_oocq002   LIKE oocq_t.oocq002
   DEFINE r_ref       LIKE type_t.chr500
   WHENEVER ERROR CONTINUE

   LET r_ref = NULL

   SELECT oocql004 INTO r_ref FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = p_oocq001
      AND oocql002 = p_oocq002
      AND oocql003 = g_dlang

   RETURN r_ref
END FUNCTION

 
{</section>}
 
