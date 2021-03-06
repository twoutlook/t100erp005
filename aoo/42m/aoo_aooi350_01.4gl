#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi350_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2015-06-03 14:34:42), PR版次:0014(2016-12-13 14:44:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000332
#+ Filename...: aooi350_01
#+ Description: 地址資料
#+ Creator....: 01258(2013-08-16 10:43:33)
#+ Modifier...: 02294 -SD/PR- 08734
 
{</section>}
 
{<section id="aooi350_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#30  2016/03/24 By 07900    重复错误信息修改
#160909-00071#1   2016/09/12 By 01258    先输入地址后开窗输入邮编会清空原先输入的地址的问题的修正
#160929-00035#1   2016/10/05 By charles4m 將AFTER FIELD oofb013要帶出後方欄位資訊前先判斷新舊值
#161011-00021#1   2016/10/11 By 01258    接160909-00071#1问题修正
#161027-00029#1   2016/10/28 By Ann_Huang 修正若聯絡地址沒輸入國家/省份,直接選擇縣市後,會提示沒有對應的州省資料,
#                                         新建開窗q_oock003_2,增加回傳所在國家資訊
#161103-00033#1   2016/11/09 By fionchen  調整離開聯絡地址頁籤會有資料鎖定問題
#161109-00080#1   2016/11/10 By wuxja     新增维护多笔地址及通讯方式后来回上下切换会出现锁表问题调整
#161124-00048#7   2016/12/13 By 08734     星号整批调整
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../aoo/4gl/aooi350_01.inc"
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_oofb_d        RECORD
       oofbstus LIKE oofb_t.oofbstus, 
   oofb001 LIKE oofb_t.oofb001, 
   oofb019 LIKE oofb_t.oofb019, 
   oofb011 LIKE oofb_t.oofb011, 
   oofb008 LIKE oofb_t.oofb008, 
   oofb009 LIKE oofb_t.oofb009, 
   oofb009_desc LIKE type_t.chr500, 
   oofb010 LIKE oofb_t.oofb010, 
   oofb012 LIKE oofb_t.oofb012, 
   oofb012_desc LIKE type_t.chr500, 
   oofb013 LIKE oofb_t.oofb013, 
   oofb014 LIKE oofb_t.oofb014, 
   oofb014_desc LIKE type_t.chr500, 
   oofb015 LIKE oofb_t.oofb015, 
   oofb015_desc LIKE type_t.chr500, 
   oofb016 LIKE oofb_t.oofb016, 
   oofb016_desc LIKE type_t.chr500, 
   oofb017 LIKE oofb_t.oofb017, 
   oofb022 LIKE oofb_t.oofb022, 
   oofb022_desc LIKE type_t.chr500, 
   oofb020 LIKE oofb_t.oofb020, 
   oofb021 LIKE oofb_t.oofb021, 
   oofb018 LIKE oofb_t.oofb018
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#GLOBALS
#   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
#   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
#   DEFINE g_wc2_i35001      STRING             #單身QBE條件
#   DEFINE g_d_idx_i35001    LIKE type_t.num5   #單身所在筆數
#   DEFINE g_d_cnt_i35001    LIKE type_t.num5   #單身總筆數
#   DEFINE g_pmaa027_d       LIKE pmaa_t.pmaa027
#   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
#END GLOBALS
#end add-point
 
DEFINE g_oofb_d          DYNAMIC ARRAY OF type_g_oofb_d
DEFINE g_oofb_d_t        type_g_oofb_d
 
 
DEFINE g_oofb001_t   LIKE oofb_t.oofb001    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"
GLOBALS   
   DEFINE g_pmba_d          DYNAMIC ARRAY OF type_g_oofb_d
   DEFINE g_oofb_d2          DYNAMIC ARRAY OF type_g_oofb_d
END GLOBALS 
#end add-point    
 
{</section>}
 
{<section id="aooi350_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aooi350_01(--)
   #add-point:input段變數傳入 name="input.get_var"
      p_oofb002 
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
      DEFINE p_oofb002      LIKE oofb_t.oofb002
   #DEFINE l_oofb         RECORD LIKE oofb_t.*  #161124-00048#7  2016/12/13 By 08734 mark
   #161124-00048#7  2016/12/13 By 08734 add(S)
   DEFINE l_oofb RECORD  #聯絡地址檔
       oofbstus LIKE oofb_t.oofbstus, #状态码
       oofbent LIKE oofb_t.oofbent, #企业编号
       oofb001 LIKE oofb_t.oofb001, #联络地址识别码
       oofb002 LIKE oofb_t.oofb002, #联络对象识别码
       oofb003 LIKE oofb_t.oofb003, #联络对象编号一
       oofb004 LIKE oofb_t.oofb004, #联络对象编号二
       oofb005 LIKE oofb_t.oofb005, #联络对象编号三
       oofb006 LIKE oofb_t.oofb006, #联络对象编号四
       oofb007 LIKE oofb_t.oofb007, #联络对象编号五
       oofb008 LIKE oofb_t.oofb008, #地址类型
       oofb009 LIKE oofb_t.oofb009, #地址应用分类
       oofb010 LIKE oofb_t.oofb010, #主要联络地址
       oofb011 LIKE oofb_t.oofb011, #简要说明
       oofb012 LIKE oofb_t.oofb012, #国家/地区
       oofb013 LIKE oofb_t.oofb013, #邮政编号
       oofb014 LIKE oofb_t.oofb014, #州/省/直辖市
       oofb015 LIKE oofb_t.oofb015, #县/市
       oofb016 LIKE oofb_t.oofb016, #行政区域
       oofb017 LIKE oofb_t.oofb017, #地址
       oofb018 LIKE oofb_t.oofb018, #失效日期
       oofbownid LIKE oofb_t.oofbownid, #资料所有者
       oofbowndp LIKE oofb_t.oofbowndp, #资料所有部门
       oofbcrtid LIKE oofb_t.oofbcrtid, #资料录入者
       oofbcrtdp LIKE oofb_t.oofbcrtdp, #资料录入部门
       oofbcrtdt LIKE oofb_t.oofbcrtdt, #资料创建日
       oofbmodid LIKE oofb_t.oofbmodid, #资料更改者
       oofbmoddt LIKE oofb_t.oofbmoddt, #最近更改日
       oofb019 LIKE oofb_t.oofb019, #简要编号
       oofb020 LIKE oofb_t.oofb020, #经度
       oofb021 LIKE oofb_t.oofb021, #维度
       oofb022 LIKE oofb_t.oofb022, #收货站点
       oofb023 LIKE oofb_t.oofb023 #联络对象类型
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E)
   DEFINE l_forupd_sql   STRING
   DEFINE l_lock_sw      LIKE type_t.chr1 
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_wc           STRING
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_oofb017      LIKE oofb_t.oofb017      #161011-00021#1 add
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi350_01 WITH FORM cl_ap_formpath("aoo","aooi350_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CALL cl_err_msg_log
   CALL cl_set_combo_scc('oofb008','9')
   CALL cl_set_combo_scc('oofb009','1')
   CALL aooi350_01_b_fill(p_oofb002)
   LET l_forupd_sql = " SELECT oofbstus,oofb001,oofb019,oofb011,oofb008,oofb009,'',oofb010,oofb012,'',oofb013,oofb014,'',oofb015,'',oofb016,'',oofb017,oofb022,'',oofb020,oofb021,oofb018 ",
                      " FROM oofb_t WHERE oofbent = '",g_enterprise,"' AND oofb002 = '",p_oofb002,"' AND oofb001 = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)  
   PREPARE aooi350_01_b FROM l_forupd_sql
   DECLARE aooi350_01_bcl CURSOR FOR aooi350_01_b 
   LET INT_FLAG = FALSE   
   LET g_errshow = 1
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_oofb_d FROM s_detail1_aooi350_01.*
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
            CALL aooi350_01_b_fill(p_oofb002)
            LET g_rec_b = g_oofb_d.getLength()
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()

            #CALL aooi350_01_b_fill(p_oofb002)
            LET g_rec_b = g_oofb_d.getLength()
            
            IF g_rec_b >= l_ac THEN  
               LET l_cmd='u'
               LET g_oofb_d_t.* = g_oofb_d[l_ac].*  #BACKUP
               OPEN aooi350_01_bcl USING g_oofb_d[l_ac].oofb001                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "aooi350_01_bcl"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               ELSE                                       
                  FETCH aooi350_01_bcl INTO g_oofb_d[l_ac].oofbstus,g_oofb_d[l_ac].oofb001,g_oofb_d[l_ac].oofb019,g_oofb_d[l_ac].oofb011,
                                            g_oofb_d[l_ac].oofb008,g_oofb_d[l_ac].oofb009,g_oofb_d[l_ac].oofb009_desc,
                                            g_oofb_d[l_ac].oofb010, g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb012_desc,g_oofb_d[l_ac].oofb013, 
                                            g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb014_desc,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb015_desc,
                                            g_oofb_d[l_ac].oofb016,g_oofb_d[l_ac].oofb016_desc,g_oofb_d[l_ac].oofb017,g_oofb_d[l_ac].oofb022,g_oofb_d[l_ac].oofb022_desc,
                                            g_oofb_d[l_ac].oofb020,g_oofb_d[l_ac].oofb021,g_oofb_d[l_ac].oofb018
                                            
                  IF SQLCA.sqlcode THEN
                     LET l_lock_sw = "Y"
                  END IF
                  IF cl_null(g_oofb_d[l_ac].oofb015) THEN
                     LET g_oofb_d[l_ac].oofb015 = ' '
                  END IF
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb009
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb009_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_oofb_d[l_ac].oofb009_desc  
  
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb012_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_oofb_d[l_ac].oofb012_desc 
                  
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
                  LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocil004 FROM oocil_t WHERE oocilent='"||g_enterprise||"' AND oocil001=? AND oocil002=? AND oocil003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb014_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_oofb_d[l_ac].oofb014_desc
                  
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
                  LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
                  LET g_ref_fields[3] = g_oofb_d[l_ac].oofb015
                  CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl001=? AND oockl002=? AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb015_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_oofb_d[l_ac].oofb015_desc
                  
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
                  LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
                  LET g_ref_fields[3] = g_oofb_d[l_ac].oofb015
                  LET g_ref_fields[4] = g_oofb_d[l_ac].oofb016
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocml006 FROM oocml_t WHERE oocmlent='"||g_enterprise||"' AND oocml001=? AND oocml002=? AND oocml003=? AND oocml004=? AND oocml005='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb016_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_oofb_d[l_ac].oofb016_desc

                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb022
                  CALL ap_ref_array2(g_ref_fields,"SELECT dbadl003 FROM dbadl_t WHERE dbadlent='"||g_enterprise||"' AND dbadl001=? AND dbadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb022_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_oofb_d[l_ac].oofb022_desc
               
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #IF g_oofb_d[l_ac].oofb008 = '3' AND cl_null(g_oofb_d[l_ac].oofb022) THEN
            #    CALL cl_set_comp_required('oofb022',TRUE)
            #ELSE
            #   CALL cl_set_comp_required('oofb022',FALSE)
            #END IF      
            
         BEFORE INSERT
            CALL s_transaction_begin()
            LET l_cmd = 'a'
            INITIALIZE g_oofb_d_t.* TO NULL
            INITIALIZE g_oofb_d[l_ac].* TO NULL 
            
            LET g_oofb_d_t.* = g_oofb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()   
            LET g_oofb_d[l_ac].oofbstus = 'Y'
            LET g_oofb_d[l_ac].oofb010 = 'N'
            
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            IF cl_null(g_oofb_d[l_ac].oofb015) THEN
               LET g_oofb_d[l_ac].oofb015 = ' '
            END IF
            LET l_oofb.oofbent = g_enterprise
            LET l_oofb.oofbstus =g_oofb_d[l_ac].oofbstus
            LET l_success = NULL
            LET l_wc = " oofbent = '",g_enterprise,"' "
            CALL s_aooi350_get_idno('oofb001','oofb_t',l_wc) RETURNING l_success,l_oofb.oofb001 
            LET g_oofb_d[l_ac].oofb001 =  l_oofb.oofb001    #161109-00080#1 add            
            LET l_oofb.oofb002 = p_oofb002
            LET l_oofb.oofb008 = g_oofb_d[l_ac].oofb008
            LET l_oofb.oofb009 = g_oofb_d[l_ac].oofb009
            LET l_oofb.oofb010 = g_oofb_d[l_ac].oofb010 
            LET l_oofb.oofb011 = g_oofb_d[l_ac].oofb011
            LET l_oofb.oofb012 = g_oofb_d[l_ac].oofb012
            LET l_oofb.oofb013 = g_oofb_d[l_ac].oofb013
            LET l_oofb.oofb014 = g_oofb_d[l_ac].oofb014
            LET l_oofb.oofb015 = g_oofb_d[l_ac].oofb015
            LET l_oofb.oofb016 = g_oofb_d[l_ac].oofb016
            LET l_oofb.oofb017 = g_oofb_d[l_ac].oofb017
            LET l_oofb.oofb018 = g_oofb_d[l_ac].oofb018
            LET l_oofb.oofb019 = g_oofb_d[l_ac].oofb019
            LET l_oofb.oofb020 = g_oofb_d[l_ac].oofb020
            LET l_oofb.oofb021 = g_oofb_d[l_ac].oofb021
            LET l_oofb.oofb022 = g_oofb_d[l_ac].oofb022
            LET l_oofb.oofbownid = g_user
            LET l_oofb.oofbowndp = g_dept
            LET l_oofb.oofbcrtid = g_user
            LET l_oofb.oofbcrtdp = g_dept 
            LET l_oofb.oofbcrtdt = cl_get_current()
            LET l_oofb.oofbmodid = g_user
            LET l_oofb.oofbmoddt = cl_get_current()
            SELECT COUNT(*) INTO l_count FROM oofb_t 
             WHERE oofbent = g_enterprise AND oofb001 = g_oofb_d[l_ac].oofb001 AND oofb002 = p_oofb002
                        
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #INSERT INTO oofb_t VALUES(l_oofb.*)
               INSERT INTO oofb_t(oofbstus,oofbent,oofb001,oofb002,oofb003,oofb004,oofb005,oofb006,oofb007,oofb008,oofb009,oofb010,oofb011,oofb012,oofb013,oofb014,oofb015,oofb016,oofb017,oofb018,oofb019,oofb020,oofb021,oofb022,
                                  oofbownid,oofbowndp,oofbcrtid,oofbcrtdp,oofbcrtdt,oofbmodid,oofbmoddt) 
                  VALUES(l_oofb.oofbstus,l_oofb.oofbent,l_oofb.oofb001,l_oofb.oofb002,l_oofb.oofb003,l_oofb.oofb004,l_oofb.oofb005,l_oofb.oofb006, 
                         l_oofb.oofb007, l_oofb.oofb008,l_oofb.oofb009,l_oofb.oofb010,l_oofb.oofb011,l_oofb.oofb012,l_oofb.oofb013,l_oofb.oofb014, 
                         l_oofb.oofb015, l_oofb.oofb016,l_oofb.oofb017,l_oofb.oofb018,l_oofb.oofb019,l_oofb.oofb020,l_oofb.oofb021,l_oofb.oofb022,
                         l_oofb.oofbownid,l_oofb.oofbowndp,l_oofb.oofbcrtid,l_oofb.oofbcrtdp,l_oofb.oofbcrtdt,l_oofb.oofbmodid,l_oofb.oofbmoddt)
                         
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_oofb_d[l_ac].* TO NULL
               CALL s_transaction_end('N',0)
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
               CALL s_transaction_end('N',0)                   
               CANCEL INSERT
            ELSE
              
               CALL s_transaction_end('Y',0)
               
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
 
        BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_oofb_d[l_ac].oofb001) THEN

               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               DELETE FROM oofb_t
                WHERE oofbent = g_enterprise AND oofb001 = g_oofb_d[l_ac].oofb001 AND oofb002 = p_oofb002
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N',0)
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  CALL s_transaction_end('Y',0)
               END IF 
               CLOSE aooi350_01_bcl
               LET l_count = g_oofb_d.getLength()
            END IF 
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_oofb_d[l_ac].* = g_oofb_d_t.*
               CLOSE aooi350_01_bcl
               CALL s_transaction_end('N',0)
               EXIT DIALOG 
            END IF
            
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = l_oofb.oofb001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_oofb_d[l_ac].* = g_oofb_d_t.*
            ELSE
               UPDATE oofb_t SET (oofbstus,oofb008,oofb009,oofb010,oofb019,oofb011,oofb012,oofb013,oofb014,oofb015,oofb016,oofb017,oofb018,oofb020,oofb021,oofb022)= (g_oofb_d[l_ac].oofbstus,g_oofb_d[l_ac].oofb008,g_oofb_d[l_ac].oofb009,g_oofb_d[l_ac].oofb010,g_oofb_d[l_ac].oofb019,g_oofb_d[l_ac].oofb011,g_oofb_d[l_ac].oofb012,
                                  g_oofb_d[l_ac].oofb013,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016,g_oofb_d[l_ac].oofb017,g_oofb_d[l_ac].oofb018,g_oofb_d[l_ac].oofb020,g_oofb_d[l_ac].oofb021,g_oofb_d[l_ac].oofb022)
                WHERE oofbent = g_enterprise AND oofb001 = g_oofb_d[l_ac].oofb001 AND oofb002 = p_oofb002 
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_oofb_d[l_ac].* = g_oofb_d_t.*
                  CALL s_transaction_end('N',0) 
               ELSE
                  CALL s_transaction_end('Y',0)                
               END IF

            END IF
            
         AFTER ROW
            CLOSE aooi350_01_bcl
        
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofbstus
            #add-point:BEFORE FIELD oofbstus name="input.b.page1_aooi350_01.oofbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofbstus
            
            #add-point:AFTER FIELD oofbstus name="input.a.page1_aooi350_01.oofbstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofbstus
            #add-point:ON CHANGE oofbstus name="input.g.page1_aooi350_01.oofbstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb001
            #add-point:BEFORE FIELD oofb001 name="input.b.page1_aooi350_01.oofb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb001
            
            #add-point:AFTER FIELD oofb001 name="input.a.page1_aooi350_01.oofb001"
                        #此段落由子樣板a05產生
            IF  g_oofb_d[g_detail_idx].oofb001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_oofb_d[g_detail_idx].oofb001 != g_oofb_d_t.oofb001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oofb_t WHERE "||"oofbent = '" ||g_enterprise|| "' AND "||"oofb001 = '"||g_oofb_d[g_detail_idx].oofb001 ||"'",'std-00004',1) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb001
            #add-point:ON CHANGE oofb001 name="input.g.page1_aooi350_01.oofb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb019
            #add-point:BEFORE FIELD oofb019 name="input.b.page1_aooi350_01.oofb019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb019
            
            #add-point:AFTER FIELD oofb019 name="input.a.page1_aooi350_01.oofb019"
            IF NOT cl_null(g_oofb_d[l_ac].oofb019) THEN
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_oofb_d[l_ac].oofb019 != g_oofb_d_t.oofb019) OR g_oofb_d_t.oofb019 IS NULL)) THEN
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oofb_t WHERE oofbent = '" ||g_enterprise|| "' AND oofb002 = '"||p_oofb002 || "' AND oofb019 = '"||g_oofb_d[l_ac].oofb019 ||"'",'std-00004',1) THEN 
                      LET g_oofb_d[l_ac].oofb019 = g_oofb_d_t.oofb019
                      NEXT FIELD oofb019
                   END IF
                END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb019
            #add-point:ON CHANGE oofb019 name="input.g.page1_aooi350_01.oofb019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb011
            #add-point:BEFORE FIELD oofb011 name="input.b.page1_aooi350_01.oofb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb011
            
            #add-point:AFTER FIELD oofb011 name="input.a.page1_aooi350_01.oofb011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb011
            #add-point:ON CHANGE oofb011 name="input.g.page1_aooi350_01.oofb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb008
            #add-point:BEFORE FIELD oofb008 name="input.b.page1_aooi350_01.oofb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb008
            
            #add-point:AFTER FIELD oofb008 name="input.a.page1_aooi350_01.oofb008"
            #IF g_oofb_d[l_ac].oofb008 <> g_oofb_d_t.oofb008 OR g_oofb_d_t.oofb008 IS NULL THEN
            #  IF g_oofb_d[l_ac].oofb008 = '3' AND cl_null(g_oofb_d[l_ac].oofb022) THEN
            #      CALL cl_set_comp_required('oofb022',TRUE)
            #  ELSE
            #     CALL cl_set_comp_required('oofb022',FALSE)
            #  END IF
            #END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb008
            #add-point:ON CHANGE oofb008 name="input.g.page1_aooi350_01.oofb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb009
            
            #add-point:AFTER FIELD oofb009 name="input.a.page1_aooi350_01.oofb009"
            IF NOT cl_null(g_oofb_d[l_ac].oofb009) THEN
               CALL s_azzi650_chk_exist('1',g_oofb_d[l_ac].oofb009) RETURNING l_success
               IF NOT l_success THEN
                  LET g_oofb_d[l_ac].oofb009 = g_oofb_d_t.oofb009
                  LET g_oofb_d[l_ac].oofb009_desc = g_oofb_d_t.oofb009_desc
                  NEXT FIELD oofb009
               END IF   
            END IF            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb009_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb009
            #add-point:BEFORE FIELD oofb009 name="input.b.page1_aooi350_01.oofb009"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb009_desc            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb009
            #add-point:ON CHANGE oofb009 name="input.g.page1_aooi350_01.oofb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb010
            #add-point:BEFORE FIELD oofb010 name="input.b.page1_aooi350_01.oofb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb010
            
            #add-point:AFTER FIELD oofb010 name="input.a.page1_aooi350_01.oofb010"
            IF NOT cl_null(g_oofb_d[l_ac].oofb008) AND g_oofb_d[l_ac].oofb010 = 'Y' THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_oofb_d[l_ac].oofb010 != g_oofb_d_t.oofb010))) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM oofb_t
                   WHERE oofbent = g_enterprise
                     AND oofb002 = p_oofb002
                     AND oofb008 = g_oofb_d[l_ac].oofb008
                     AND oofb010 = 'Y'
                   IF l_n > 0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'aoo-00156'
                      LET g_errparam.extend = g_oofb_d[l_ac].oofb010
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET g_oofb_d[l_ac].oofb010 = 'N'
                      NEXT FIELD oofb010
                   END IF
                END IF
             END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb010
            #add-point:ON CHANGE oofb010 name="input.g.page1_aooi350_01.oofb010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb012
            
            #add-point:AFTER FIELD oofb012 name="input.a.page1_aooi350_01.oofb012"
            IF NOT aooi350_01_oofb_chk(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb013,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016) THEN 
               LET g_oofb_d[l_ac].oofb012 = g_oofb_d_t.oofb012
               LET g_oofb_d[l_ac].oofb012_desc = g_oofb_d_t.oofb012_desc
               NEXT FIELD oofb012
            END IF           
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb012_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb012
            #add-point:BEFORE FIELD oofb012 name="input.b.page1_aooi350_01.oofb012"
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)          
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb012
            #add-point:ON CHANGE oofb012 name="input.g.page1_aooi350_01.oofb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb013
            #add-point:BEFORE FIELD oofb013 name="input.b.page1_aooi350_01.oofb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb013
            
            #add-point:AFTER FIELD oofb013 name="input.a.page1_aooi350_01.oofb013"
           #IF NOT cl_null(g_oofb_d[l_ac].oofb013) THEN #160929-00035#1 mark
            IF NOT cl_null(g_oofb_d[l_ac].oofb013) AND (g_oofb_d[l_ac].oofb013 <> g_oofb_d_t.oofb013) OR cl_null(g_oofb_d_t.oofb013) THEN #160929-00035#1 add
              SELECT oocn003,oocn004,oocn005,oocn006 INTO g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016,l_oofb017  #161011-00021#1 g_oofb_d[l_ac].oofb017-->l_oofb017
                FROM oocn_t
               WHERE oocnent=g_enterprise
                 AND oocn001 = g_oofb_d[l_ac].oofb012
                 AND oocn002 = g_oofb_d[l_ac].oofb013
               #161011-00021#1 by wuxja add  --begin--  
               IF cl_null(g_oofb_d[l_ac].oofb017) THEN
                  LET g_oofb_d[l_ac].oofb017 = l_oofb017
               END IF
               #161011-00021#1 by wuxja add  --end--
           #END IF ##160929-00035#1 mark
               DISPLAY BY NAME g_oofb_d[l_ac].oofb014
               DISPLAY BY NAME g_oofb_d[l_ac].oofb015
               DISPLAY BY NAME g_oofb_d[l_ac].oofb016
               DISPLAY BY NAME g_oofb_d[l_ac].oofb017
            END IF #160929-00035#1 add

            IF cl_null(g_oofb_d[l_ac].oofb015) THEN
               LET g_oofb_d[l_ac].oofb015 = ' '
            END IF
            IF NOT aooi350_01_oofb_chk(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb013,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016) THEN 
               LET g_oofb_d[l_ac].oofb013 = g_oofb_d_t.oofb013
               LET g_oofb_d[l_ac].oofb014 = g_oofb_d_t.oofb014
               LET g_oofb_d[l_ac].oofb015 = g_oofb_d_t.oofb015
               LET g_oofb_d[l_ac].oofb016 = g_oofb_d_t.oofb016
               LET g_oofb_d[l_ac].oofb017 = g_oofb_d_t.oofb017
               NEXT FIELD oofb013
            END IF   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
            CALL ap_ref_array2(g_ref_fields,"SELECT oocil004 FROM oocil_t WHERE oocilent='"||g_enterprise||"' AND oocil001=? AND oocil002=? AND oocil003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb014_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oofb_d[l_ac].oofb014_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
            LET g_ref_fields[3] = g_oofb_d[l_ac].oofb015
            CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl001=? AND oockl002=? AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb015_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oofb_d[l_ac].oofb015_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
            LET g_ref_fields[3] = g_oofb_d[l_ac].oofb015
            LET g_ref_fields[4] = g_oofb_d[l_ac].oofb016
            CALL ap_ref_array2(g_ref_fields,"SELECT oocml006 FROM oocml_t WHERE oocmlent='"||g_enterprise||"' AND oocml001=? AND oocml002=? AND oocml003=? AND oocml004=? AND oocml005='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb016_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oofb_d[l_ac].oofb016_desc            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb013
            #add-point:ON CHANGE oofb013 name="input.g.page1_aooi350_01.oofb013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb014
            
            #add-point:AFTER FIELD oofb014 name="input.a.page1_aooi350_01.oofb014"
            IF NOT aooi350_01_oofb_chk(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb013,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016) THEN 
               LET g_oofb_d[l_ac].oofb014 = g_oofb_d_t.oofb014
               LET g_oofb_d[l_ac].oofb014_desc = g_oofb_d_t.oofb014_desc
               NEXT FIELD oofb014
            END IF            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
            CALL ap_ref_array2(g_ref_fields,"SELECT oocil004 FROM oocil_t WHERE oocilent='"||g_enterprise||"' AND oocil001=? AND oocil002=? AND oocil003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb014_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb014_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb014
            #add-point:BEFORE FIELD oofb014 name="input.b.page1_aooi350_01.oofb014"
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)         
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb014
            #add-point:ON CHANGE oofb014 name="input.g.page1_aooi350_01.oofb014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb015
            
            #add-point:AFTER FIELD oofb015 name="input.a.page1_aooi350_01.oofb015"
            IF NOT aooi350_01_oofb_chk(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb013,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016) THEN 
               LET g_oofb_d[l_ac].oofb015 = g_oofb_d_t.oofb015
               LET g_oofb_d[l_ac].oofb015_desc = g_oofb_d_t.oofb015_desc
               NEXT FIELD oofb015
            END IF            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
            LET g_ref_fields[3] = g_oofb_d[l_ac].oofb015
            CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl001=? AND oockl002=? AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb015_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb015
            #add-point:BEFORE FIELD oofb015 name="input.b.page1_aooi350_01.oofb015"
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)         
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb015
            #add-point:ON CHANGE oofb015 name="input.g.page1_aooi350_01.oofb015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb016
            
            #add-point:AFTER FIELD oofb016 name="input.a.page1_aooi350_01.oofb016"
            IF NOT aooi350_01_oofb_chk(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb013,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016) THEN 
               LET g_oofb_d[l_ac].oofb016 = g_oofb_d_t.oofb016
               LET g_oofb_d[l_ac].oofb016_desc = g_oofb_d_t.oofb016_desc
               NEXT FIELD oofb016
            END IF
            IF cl_null(g_oofb_d[l_ac].oofb015) THEN
               LET g_oofb_d[l_ac].oofb015 = ' '
            END IF            
            INITIALIZE g_ref_fields TO NULL
            IF cl_null(g_oofb_d[l_ac].oofb015) THEN LET g_oofb_d[l_ac].oofb015=' ' END IF
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
            LET g_ref_fields[3] = g_oofb_d[l_ac].oofb015
            LET g_ref_fields[4] = g_oofb_d[l_ac].oofb016
            CALL ap_ref_array2(g_ref_fields,"SELECT oocml006 FROM oocml_t WHERE oocmlent='"||g_enterprise||"' AND oocml001=? AND oocml002=? AND oocml003=? AND oocml004=? AND oocml005='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb016_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb016_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb016
            #add-point:BEFORE FIELD oofb016 name="input.b.page1_aooi350_01.oofb016"
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)         
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb016
            #add-point:ON CHANGE oofb016 name="input.g.page1_aooi350_01.oofb016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb017
            #add-point:BEFORE FIELD oofb017 name="input.b.page1_aooi350_01.oofb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb017
            
            #add-point:AFTER FIELD oofb017 name="input.a.page1_aooi350_01.oofb017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb017
            #add-point:ON CHANGE oofb017 name="input.g.page1_aooi350_01.oofb017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb022
            
            #add-point:AFTER FIELD oofb022 name="input.a.page1_aooi350_01.oofb022"
            IF NOT cl_null(g_oofb_d[l_ac].oofb022) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_oofb_d[l_ac].oofb022
               CALL ap_ref_array2(g_ref_fields,"SELECT dbadl003 FROM dbadl_t WHERE dbadlent='"||g_enterprise||"' AND dbadl001=? AND dbadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_oofb_d[l_ac].oofb022_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_oofb_d[l_ac].oofb022_desc
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_oofb_d[l_ac].oofb022
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_dbad001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_oofb_d[l_ac].oofb022 = g_oofb_d_t.oofb022
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb022
                  CALL ap_ref_array2(g_ref_fields,"SELECT dbadl003 FROM dbadl_t WHERE dbadlent='"||g_enterprise||"' AND dbadl001=? AND dbadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb022_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_oofb_d[l_ac].oofb022_desc                  
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb022
            CALL ap_ref_array2(g_ref_fields,"SELECT dbadl003 FROM dbadl_t WHERE dbadlent='"||g_enterprise||"' AND dbadl001=? AND dbadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb022_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb022_desc

            #IF g_oofb_d[l_ac].oofb022 <> g_oofb_d_t.oofb022 OR cl_null(g_oofb_d[l_ac].oofb022) THEN
            #  IF g_oofb_d[l_ac].oofb008 = '3' AND cl_null(g_oofb_d[l_ac].oofb022) THEN
            #      CALL cl_set_comp_required('oofb022',TRUE)
            #  ELSE
            #     CALL cl_set_comp_required('oofb022',FALSE)
            #  END IF
            #END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb022
            #add-point:BEFORE FIELD oofb022 name="input.b.page1_aooi350_01.oofb022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb022
            #add-point:ON CHANGE oofb022 name="input.g.page1_aooi350_01.oofb022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb020
            #add-point:BEFORE FIELD oofb020 name="input.b.page1_aooi350_01.oofb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb020
            
            #add-point:AFTER FIELD oofb020 name="input.a.page1_aooi350_01.oofb020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb020
            #add-point:ON CHANGE oofb020 name="input.g.page1_aooi350_01.oofb020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb021
            #add-point:BEFORE FIELD oofb021 name="input.b.page1_aooi350_01.oofb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb021
            
            #add-point:AFTER FIELD oofb021 name="input.a.page1_aooi350_01.oofb021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb021
            #add-point:ON CHANGE oofb021 name="input.g.page1_aooi350_01.oofb021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofb018
            #add-point:BEFORE FIELD oofb018 name="input.b.page1_aooi350_01.oofb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofb018
            
            #add-point:AFTER FIELD oofb018 name="input.a.page1_aooi350_01.oofb018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofb018
            #add-point:ON CHANGE oofb018 name="input.g.page1_aooi350_01.oofb018"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1_aooi350_01.oofbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofbstus
            #add-point:ON ACTION controlp INFIELD oofbstus name="input.c.page1_aooi350_01.oofbstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb001
            #add-point:ON ACTION controlp INFIELD oofb001 name="input.c.page1_aooi350_01.oofb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb019
            #add-point:ON ACTION controlp INFIELD oofb019 name="input.c.page1_aooi350_01.oofb019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb011
            #add-point:ON ACTION controlp INFIELD oofb011 name="input.c.page1_aooi350_01.oofb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb008
            #add-point:ON ACTION controlp INFIELD oofb008 name="input.c.page1_aooi350_01.oofb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb009
            #add-point:ON ACTION controlp INFIELD oofb009 name="input.c.page1_aooi350_01.oofb009"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_oofb_d[l_ac].oofb009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oofb_d[l_ac].oofb009 TO oofb009              #顯示到畫面上

            NEXT FIELD oofb009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb010
            #add-point:ON ACTION controlp INFIELD oofb010 name="input.c.page1_aooi350_01.oofb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb012
            #add-point:ON ACTION controlp INFIELD oofb012 name="input.c.page1_aooi350_01.oofb012"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb012             #給予default值

            #給予arg

            CALL q_oocg001()                                #呼叫開窗

            LET g_oofb_d[l_ac].oofb012 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oofb_d[l_ac].oofb012 TO oofb012              #顯示到畫面上
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)            
            NEXT FIELD oofb012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb013
            #add-point:ON ACTION controlp INFIELD oofb013 name="input.c.page1_aooi350_01.oofb013"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb013             #給予default值
            LET g_qryparam.default2 = g_oofb_d[l_ac].oofb012             #給予default值
            LET g_qryparam.default3 = g_oofb_d[l_ac].oofb014             #給予default值
            LET g_qryparam.default4 = g_oofb_d[l_ac].oofb015             #給予default值
            LET g_qryparam.default5 = g_oofb_d[l_ac].oofb016             #給予default值
            LET g_qryparam.default6 = g_oofb_d[l_ac].oofb017             #給予default值
            
            #給予arg

            IF NOT cl_null(g_oofb_d[l_ac].oofb012) THEN
               LET g_qryparam.where = " oocn001 = '",g_oofb_d[l_ac].oofb012,"'"
            END IF
            
            #160909-00071#1 add  --begin--
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = " 1 = 1 "
            END IF
            IF NOT cl_null(g_oofb_d[l_ac].oofb014) THEN
               LET g_qryparam.where = g_qryparam.where," AND oocn003 = '",g_oofb_d[l_ac].oofb014,"'"
            END IF
            IF NOT cl_null(g_oofb_d[l_ac].oofb015) THEN
               LET g_qryparam.where = g_qryparam.where," AND oocn004 = '",g_oofb_d[l_ac].oofb015,"'"
            END IF
            IF NOT cl_null(g_oofb_d[l_ac].oofb016) THEN
               LET g_qryparam.where = g_qryparam.where," AND oocn005 = '",g_oofb_d[l_ac].oofb016,"'"
            END IF
            #161011-00021#1 by wuxja mark --begin--
            #IF NOT cl_null(g_oofb_d[l_ac].oofb017) THEN
            #   LET g_qryparam.where = g_qryparam.where," AND oocn006 = '",g_oofb_d[l_ac].oofb017,"'"
            #END IF
            #161011-00021#1 by wuxja mark --end--
            #160909-00071#1 add  --end--
            
            CALL q_oocn002_1()                                #呼叫開窗

            LET g_oofb_d[l_ac].oofb013 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb012 = g_qryparam.return2              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb014 = g_qryparam.return3              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb015 = g_qryparam.return4              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb016 = g_qryparam.return5              #將開窗取得的值回傳到變數
            IF cl_null(g_oofb_d[l_ac].oofb017) THEN       #161011-00021#1 add
               LET g_oofb_d[l_ac].oofb017 = g_qryparam.return6              #將開窗取得的值回傳到變數
            END IF  #161011-00021#1 add

            DISPLAY g_oofb_d[l_ac].oofb013 TO oofb013              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb012 TO oofb012              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb014 TO oofb014              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb015 TO oofb015              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb016 TO oofb016              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb017 TO oofb017              #顯示到畫面上           
            
            #重新顯示州省、縣市、行政地區的名稱
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)            
            
            NEXT FIELD oofb013                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb014
            #add-point:ON ACTION controlp INFIELD oofb014 name="input.c.page1_aooi350_01.oofb014"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb012             #給予default值
            LET g_qryparam.default2 = g_oofb_d[l_ac].oofb014             #給予default值

            #給予arg

            IF NOT cl_null(g_oofb_d[l_ac].oofb012) THEN
               LET g_qryparam.where = " ooci001 = '",g_oofb_d[l_ac].oofb012,"'"
            END IF

            CALL q_ooci002_2()                                #呼叫開窗

            LET g_oofb_d[l_ac].oofb012 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb014 = g_qryparam.return2              #將開窗取得的值回傳到變數

            DISPLAY g_oofb_d[l_ac].oofb014 TO oofb012              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb014 TO oofb014              #顯示到畫面上

            #重新顯示州省、縣市、行政地區的名稱
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)            
            
            NEXT FIELD oofb014                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb015
            #add-point:ON ACTION controlp INFIELD oofb015 name="input.c.page1_aooi350_01.oofb015"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb014             #給予default值
            LET g_qryparam.default2 = g_oofb_d[l_ac].oofb015             #給予default值

            #給予arg

            IF NOT cl_null(g_oofb_d[l_ac].oofb012) THEN
               LET g_qryparam.where = " oock001 = '",g_oofb_d[l_ac].oofb012,"'"
            END IF
            IF NOT cl_null(g_oofb_d[l_ac].oofb014) THEN
               LET g_qryparam.where = g_qryparam.where," AND oock002 = '",g_oofb_d[l_ac].oofb014,"'"
            END IF

            #161027-00029#1-(S)-mark 
            #CALL q_oock003_1()                                #呼叫開窗             
            #
            #LET g_oofb_d[l_ac].oofb014 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_oofb_d[l_ac].oofb015 = g_qryparam.return2              #將開窗取得的值回傳到變數
            #161027-00029#1-(E)-mark 
            
            #161027-00029#1-(S)-add 
            CALL q_oock003_2()                                #呼叫開窗             
            
            LET g_oofb_d[l_ac].oofb012 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb014 = g_qryparam.return2              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb015 = g_qryparam.return3              #將開窗取得的值回傳到變數
            DISPLAY g_oofb_d[l_ac].oofb015 TO oofb012              #顯示到畫面上
            #161027-00029#1-(E)-add            

            DISPLAY g_oofb_d[l_ac].oofb015 TO oofb014              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb015 TO oofb015              #顯示到畫面上

            #重新顯示州省、縣市、行政地區的名稱
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)            
            
            NEXT FIELD oofb015                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb016
            #add-point:ON ACTION controlp INFIELD oofb016 name="input.c.page1_aooi350_01.oofb016"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb014             #給予default值
            LET g_qryparam.default2 = g_oofb_d[l_ac].oofb015             #給予default值
            LET g_qryparam.default3 = g_oofb_d[l_ac].oofb016             #給予default值

            #給予arg

            IF NOT cl_null(g_oofb_d[l_ac].oofb012) THEN
               LET g_qryparam.where = " oocm001 = '",g_oofb_d[l_ac].oofb012,"'"
            END IF
            IF NOT cl_null(g_oofb_d[l_ac].oofb014) THEN
               LET g_qryparam.where = g_qryparam.where," AND oocm002 = '",g_oofb_d[l_ac].oofb014,"'"
            END IF
            IF NOT cl_null(g_oofb_d[l_ac].oofb015) THEN
               LET g_qryparam.where = g_qryparam.where," AND oocm003 = '",g_oofb_d[l_ac].oofb015,"'"
            END IF
            
            CALL q_oocm004_2()                                #呼叫開窗

            LET g_oofb_d[l_ac].oofb014 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb015 = g_qryparam.return2              #將開窗取得的值回傳到變數            
            LET g_oofb_d[l_ac].oofb016 = g_qryparam.return3              #將開窗取得的值回傳到變數

            DISPLAY g_oofb_d[l_ac].oofb016 TO oofb014              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb016 TO oofb015              #顯示到畫面上            
            DISPLAY g_oofb_d[l_ac].oofb016 TO oofb016              #顯示到畫面上

            #重新顯示州省、縣市、行政地區的名稱
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)            
            
            NEXT FIELD oofb016                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb017
            #add-point:ON ACTION controlp INFIELD oofb017 name="input.c.page1_aooi350_01.oofb017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb022
            #add-point:ON ACTION controlp INFIELD oofb022 name="input.c.page1_aooi350_01.oofb022"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_dbad001_1()                                #呼叫開窗

            LET g_oofb_d[l_ac].oofb022 = g_qryparam.return1              

            DISPLAY g_oofb_d[l_ac].oofb022 TO oofb022              #

            NEXT FIELD oofb022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb020
            #add-point:ON ACTION controlp INFIELD oofb020 name="input.c.page1_aooi350_01.oofb020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb021
            #add-point:ON ACTION controlp INFIELD oofb021 name="input.c.page1_aooi350_01.oofb021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi350_01.oofb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofb018
            #add-point:ON ACTION controlp INFIELD oofb018 name="input.c.page1_aooi350_01.oofb018"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            LET g_oofb_d2.* = g_oofb_d.*  
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
   CLOSE WINDOW w_aooi350_01 
   
   #add-point:input段after input name="input.post_input"
       CLOSE aooi350_01_bcl
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aooi350_01.other_dialog" readonly="Y" >}
################################################################################
# Descriptions...: 被主程式嵌入的地址資料顯示模式
# Memo...........: 
# Usage..........: CALL aooi350_01_display()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/24 By Saki
# Modify.........:
################################################################################
DIALOG aooi350_01_display()
   DISPLAY ARRAY g_oofb_d TO s_detail1_aooi350_01.* ATTRIBUTE(COUNT=g_d_cnt_i35001)

      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_i35001)
         #單身不連動, 所以進入單身時, 要重新顯示單身筆數
         DISPLAY g_d_idx_i35001, g_d_cnt_i35001 TO FORMONLY.idx, FORMONLY.cnt

      BEFORE ROW
         LET g_d_idx_i35001 = DIALOG.getCurrentRow("s_detail1_aooi350_01")
         DISPLAY g_d_idx_i35001 TO FORMONLY.idx
         # 點的當筆放入g_appoint_idx中, 可讓雙擊直接進入指定筆
         LET g_appoint_idx = g_d_idx_i35001

      AFTER DISPLAY
         LET g_oofb_d2.* = g_oofb_d.*

   END DISPLAY
END DIALOG
################################################################################
# Descriptions...: 被主程式嵌入的地址查詢模式
# Memo...........: 
# Usage..........: CALL aooi350_01_construct()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/24 By Saki
# Modify.........:
################################################################################
DIALOG aooi350_01_construct()
   DEFINE ls_result   STRING

   CONSTRUCT g_wc2_i35001 ON oofbstus,oofb001,oofb008,oofb009,oofb010,
                             oofb019,oofb011,oofb022,oofb012,oofb013,oofb014,
                             oofb015,oofb016,oofb017,oofb020,oofb021,oofb018
        FROM s_detail1_aooi350_01[1].oofbstus,s_detail1_aooi350_01[1].oofb001,
             s_detail1_aooi350_01[1].oofb008,s_detail1_aooi350_01[1].oofb009,
             s_detail1_aooi350_01[1].oofb010,s_detail1_aooi350_01[1].oofb019,
             s_detail1_aooi350_01[1].oofb011,s_detail1_aooi350_01[1].oofb022,
             s_detail1_aooi350_01[1].oofb012,s_detail1_aooi350_01[1].oofb013,
             s_detail1_aooi350_01[1].oofb014,s_detail1_aooi350_01[1].oofb015,
             s_detail1_aooi350_01[1].oofb016,s_detail1_aooi350_01[1].oofb017,
             s_detail1_aooi350_01[1].oofb020,s_detail1_aooi350_01[1].oofb021,
             s_detail1_aooi350_01[1].oofb018

      AFTER FIELD oofbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

      AFTER FIELD oofbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            
         ON ACTION controlp INFIELD oofb009
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            #給予arg
            LET g_qryparam.arg1 = "1" #
            CALL q_oocq002()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofb009              #顯示到畫面上
            NEXT FIELD oofb009                          #返回原欄位     

         ON ACTION controlp INFIELD oofb022
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            CALL q_dbad001_1()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofb022              #顯示到畫面上
            NEXT FIELD oofb022                          #返回原欄位
            
         ON ACTION controlp INFIELD oofb012
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            CALL q_oocg001()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofb012              #顯示到畫面上
            NEXT FIELD oofb012                          #返回原欄位

         ON ACTION controlp INFIELD oofb013
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            CALL q_oocn002_2()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofb013              #顯示到畫面上
            NEXT FIELD oofb013                         #返回原欄位
            
         ON ACTION controlp INFIELD oofb014
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            CALL q_ooci002()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofb014             #顯示到畫面上
            NEXT FIELD oofb014                        #返回原欄位      

         ON ACTION controlp INFIELD oofb015
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            CALL q_oock003()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofb015             #顯示到畫面上
            NEXT FIELD oofb015                        #返回原欄位 
            
         ON ACTION controlp INFIELD oofb016
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            CALL q_oocm004()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO oofb016             #顯示到畫面上
            NEXT FIELD oofb016                        #返回原欄位             
   END CONSTRUCT
END DIALOG
################################################################################
# Descriptions...: 被主程式嵌入的地址輸入模式
# Memo...........: 
# Usage..........: CALL aooi350_01_construct()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/24 By Saki
# Modify.........:
################################################################################
DIALOG aooi350_01_input()
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   {</Local define>}
   #add-point:input段define
   #DEFINE l_oofb         RECORD LIKE oofb_t.*  #161124-00048#7  2016/12/13 By 08734 mark
   #161124-00048#7  2016/12/13 By 08734 add(S)
   DEFINE l_oofb RECORD  #聯絡地址檔
       oofbstus LIKE oofb_t.oofbstus, #状态码
       oofbent LIKE oofb_t.oofbent, #企业编号
       oofb001 LIKE oofb_t.oofb001, #联络地址识别码
       oofb002 LIKE oofb_t.oofb002, #联络对象识别码
       oofb003 LIKE oofb_t.oofb003, #联络对象编号一
       oofb004 LIKE oofb_t.oofb004, #联络对象编号二
       oofb005 LIKE oofb_t.oofb005, #联络对象编号三
       oofb006 LIKE oofb_t.oofb006, #联络对象编号四
       oofb007 LIKE oofb_t.oofb007, #联络对象编号五
       oofb008 LIKE oofb_t.oofb008, #地址类型
       oofb009 LIKE oofb_t.oofb009, #地址应用分类
       oofb010 LIKE oofb_t.oofb010, #主要联络地址
       oofb011 LIKE oofb_t.oofb011, #简要说明
       oofb012 LIKE oofb_t.oofb012, #国家/地区
       oofb013 LIKE oofb_t.oofb013, #邮政编号
       oofb014 LIKE oofb_t.oofb014, #州/省/直辖市
       oofb015 LIKE oofb_t.oofb015, #县/市
       oofb016 LIKE oofb_t.oofb016, #行政区域
       oofb017 LIKE oofb_t.oofb017, #地址
       oofb018 LIKE oofb_t.oofb018, #失效日期
       oofbownid LIKE oofb_t.oofbownid, #资料所有者
       oofbowndp LIKE oofb_t.oofbowndp, #资料所有部门
       oofbcrtid LIKE oofb_t.oofbcrtid, #资料录入者
       oofbcrtdp LIKE oofb_t.oofbcrtdp, #资料录入部门
       oofbcrtdt LIKE oofb_t.oofbcrtdt, #资料创建日
       oofbmodid LIKE oofb_t.oofbmodid, #资料更改者
       oofbmoddt LIKE oofb_t.oofbmoddt, #最近更改日
       oofb019 LIKE oofb_t.oofb019, #简要编号
       oofb020 LIKE oofb_t.oofb020, #经度
       oofb021 LIKE oofb_t.oofb021, #维度
       oofb022 LIKE oofb_t.oofb022, #收货站点
       oofb023 LIKE oofb_t.oofb023 #联络对象类型
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E)
   DEFINE l_forupd_sql   STRING
   DEFINE l_lock_sw      LIKE type_t.chr1 
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_wc           STRING
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_oofb017      LIKE oofb_t.oofb017    #161011-00021#1 add

   
   
   INPUT ARRAY g_oofb_d FROM s_detail1_aooi350_01.*
      ATTRIBUTE(COUNT = g_d_cnt_i35001,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                INSERT ROW = g_detail_insert,
                DELETE ROW = g_detail_delete,
                APPEND ROW = g_detail_insert)
         
         #自訂ACTION
         #add-point:單身前置處理

         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理
            LET l_forupd_sql = " SELECT oofbstus,oofb001,oofb019,oofb011,oofb008,oofb009,'',oofb010,oofb012,'',oofb013,oofb014,'',oofb015,'',oofb016,'',oofb017,oofb022,'',oofb020,oofb021,oofb018 ",
                               " FROM oofb_t WHERE oofbent = '",g_enterprise,"' AND oofb002 = '",g_pmaa027_d,"' AND oofb001 = ? FOR UPDATE"
            LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)  
            PREPARE aooi350_01_dialog_b FROM l_forupd_sql
            DECLARE aooi350_01_dialog_bcl CURSOR FOR aooi350_01_dialog_b
            IF g_appoint_idx > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1_aooi350_01",g_appoint_idx)
            END IF
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()

            LET g_rec_b = g_oofb_d.getLength()
            
            IF g_rec_b >= l_ac THEN  
               LET l_cmd='u'
               LET g_oofb_d_t.* = g_oofb_d[l_ac].*  #BACKUP
               OPEN aooi350_01_dialog_bcl USING g_oofb_d[l_ac].oofb001                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "aooi350_01_dialog_bcl"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               ELSE                                       
                  FETCH aooi350_01_dialog_bcl INTO g_oofb_d[l_ac].oofbstus,g_oofb_d[l_ac].oofb001,g_oofb_d[l_ac].oofb019,g_oofb_d[l_ac].oofb011,
                                            g_oofb_d[l_ac].oofb008,g_oofb_d[l_ac].oofb009,g_oofb_d[l_ac].oofb009_desc,
                                            g_oofb_d[l_ac].oofb010, g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb012_desc,g_oofb_d[l_ac].oofb013, 
                                            g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb014_desc,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb015_desc,
                                            g_oofb_d[l_ac].oofb016,g_oofb_d[l_ac].oofb016_desc,g_oofb_d[l_ac].oofb017,g_oofb_d[l_ac].oofb022,g_oofb_d[l_ac].oofb022_desc,
                                            g_oofb_d[l_ac].oofb020,g_oofb_d[l_ac].oofb021,g_oofb_d[l_ac].oofb018
                                            
                  IF SQLCA.sqlcode THEN
                     LET l_lock_sw = "Y"
                  END IF
                  IF cl_null(g_oofb_d[l_ac].oofb015) THEN
                     LET g_oofb_d[l_ac].oofb015 = ' '
                  END IF
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb009
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb009_desc = g_rtn_fields[1]
                  IF l_lock_sw = "N" THEN                     #161103-00033#1 add
                     DISPLAY BY NAME g_oofb_d[l_ac].oofb009_desc  
                  END IF                                      #161103-00033#1 add
  
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb012_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_oofb_d[l_ac].oofb012_desc 
                  
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
                  LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocil004 FROM oocil_t WHERE oocilent='"||g_enterprise||"' AND oocil001=? AND oocil002=? AND oocil003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb014_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_oofb_d[l_ac].oofb014_desc
                  
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
                  LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
                  LET g_ref_fields[3] = g_oofb_d[l_ac].oofb015
                  CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl001=? AND oockl002=? AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb015_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_oofb_d[l_ac].oofb015_desc
                  
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
                  LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
                  LET g_ref_fields[3] = g_oofb_d[l_ac].oofb015
                  LET g_ref_fields[4] = g_oofb_d[l_ac].oofb016
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocml006 FROM oocml_t WHERE oocmlent='"||g_enterprise||"' AND oocml001=? AND oocml002=? AND oocml003=? AND oocml004=? AND oocml005='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb016_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_oofb_d[l_ac].oofb016_desc

                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb022
                  CALL ap_ref_array2(g_ref_fields,"SELECT dbadl003 FROM dbadl_t WHERE dbadlent='"||g_enterprise||"' AND dbadl001=? AND dbadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb022_desc = '', g_rtn_fields[1] , ''
                  IF l_lock_sw = "N" THEN                     #161103-00033#1 add
                     DISPLAY BY NAME g_oofb_d[l_ac].oofb022_desc
                  END IF                                      #161103-00033#1 add
               
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF

            #IF g_oofb_d[l_ac].oofb008 = '3' AND cl_null(g_oofb_d[l_ac].oofb022) THEN
            #    CALL cl_set_comp_required('oofb022',TRUE)
            #ELSE
            #   CALL cl_set_comp_required('oofb022',FALSE)
            #END IF
            
         BEFORE INSERT
            CALL s_transaction_begin()
            LET l_cmd = 'a'
            INITIALIZE g_oofb_d_t.* TO NULL
            INITIALIZE g_oofb_d[l_ac].* TO NULL 
            
            LET g_oofb_d_t.* = g_oofb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()   
            LET g_oofb_d[l_ac].oofbstus = 'Y'
            LET g_oofb_d[l_ac].oofb010 = 'N'
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET INT_FLAG = 0
#               CANCEL INSERT
            END IF
            IF cl_null(g_oofb_d[l_ac].oofb015) THEN
               LET g_oofb_d[l_ac].oofb015 = ' '
            END IF
            LET l_oofb.oofbent = g_enterprise
            LET l_oofb.oofbstus =g_oofb_d[l_ac].oofbstus
            LET l_success = NULL
            LET l_wc = " oofbent = '",g_enterprise,"' "
            CALL s_aooi350_get_idno('oofb001','oofb_t',l_wc) RETURNING l_success,l_oofb.oofb001 
            LET g_oofb_d[l_ac].oofb001 =  l_oofb.oofb001    #161109-00080#1 add             
            LET l_oofb.oofb002 = g_pmaa027_d
            LET l_oofb.oofb008 = g_oofb_d[l_ac].oofb008
            LET l_oofb.oofb009 = g_oofb_d[l_ac].oofb009
            LET l_oofb.oofb010 = g_oofb_d[l_ac].oofb010 
            LET l_oofb.oofb011 = g_oofb_d[l_ac].oofb011
            LET l_oofb.oofb012 = g_oofb_d[l_ac].oofb012
            LET l_oofb.oofb013 = g_oofb_d[l_ac].oofb013
            LET l_oofb.oofb014 = g_oofb_d[l_ac].oofb014
            LET l_oofb.oofb015 = g_oofb_d[l_ac].oofb015
            LET l_oofb.oofb016 = g_oofb_d[l_ac].oofb016
            LET l_oofb.oofb017 = g_oofb_d[l_ac].oofb017
            LET l_oofb.oofb018 = g_oofb_d[l_ac].oofb018
            LET l_oofb.oofb019 = g_oofb_d[l_ac].oofb019
            LET l_oofb.oofb020 = g_oofb_d[l_ac].oofb020
            LET l_oofb.oofb021 = g_oofb_d[l_ac].oofb021
            LET l_oofb.oofb022 = g_oofb_d[l_ac].oofb022
            LET l_oofb.oofbownid = g_user
            LET l_oofb.oofbowndp = g_dept
            LET l_oofb.oofbcrtid = g_user
            LET l_oofb.oofbcrtdp = g_dept 
            LET l_oofb.oofbcrtdt = cl_get_current()
            LET l_oofb.oofbmodid = g_user
            LET l_oofb.oofbmoddt = cl_get_current()
            SELECT COUNT(*) INTO l_count FROM oofb_t 
             WHERE oofbent = g_enterprise AND oofb001 = g_oofb_d[l_ac].oofb001 AND oofb002 = g_pmaa027_d
                        
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #INSERT INTO oofb_t VALUES(l_oofb.*)
               INSERT INTO oofb_t(oofbstus,oofbent,oofb001,oofb002,oofb003,oofb004,oofb005,oofb006,oofb007,oofb008,oofb009,oofb010,oofb011,oofb012,oofb013,oofb014,oofb015,oofb016,oofb017,oofb018,oofb019,oofb020,oofb021,oofb022,
                                  oofbownid,oofbowndp,oofbcrtid,oofbcrtdp,oofbcrtdt,oofbmodid,oofbmoddt) 
                  VALUES(l_oofb.oofbstus,l_oofb.oofbent,l_oofb.oofb001,l_oofb.oofb002,l_oofb.oofb003,l_oofb.oofb004,l_oofb.oofb005,l_oofb.oofb006, 
                         l_oofb.oofb007, l_oofb.oofb008,l_oofb.oofb009,l_oofb.oofb010,l_oofb.oofb011,l_oofb.oofb012,l_oofb.oofb013,l_oofb.oofb014, 
                         l_oofb.oofb015, l_oofb.oofb016,l_oofb.oofb017,l_oofb.oofb018,l_oofb.oofb019,l_oofb.oofb020,l_oofb.oofb021,l_oofb.oofb022,
                         l_oofb.oofbownid,l_oofb.oofbowndp,l_oofb.oofbcrtid,l_oofb.oofbcrtdp,l_oofb.oofbcrtdt,l_oofb.oofbmodid,l_oofb.oofbmoddt)
                         
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofb_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

               END IF
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_oofb_d[l_ac].* TO NULL
               CALL s_transaction_end('N',0)
#               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "oofb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N',0)                   
#               CANCEL INSERT
            ELSE
              
               CALL s_transaction_end('Y',0)
               
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
 
        BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_oofb_d[l_ac].oofb001) THEN

               #IF NOT cl_ask_del_detail() THEN
#              ##    CANCEL DELETE
               #END IF
               IF cl_ask_del_detail() THEN
                  IF l_lock_sw = "Y" THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  -263
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
#                     CANCEL DELETE
                  END IF
                  DELETE FROM oofb_t
                   WHERE oofbent = g_enterprise AND oofb001 = g_oofb_d[l_ac].oofb001 AND oofb002 = g_pmaa027_d
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                     CALL s_transaction_end('N',0)
#                     CANCEL DELETE   
                  ELSE
                     LET g_rec_b = g_rec_b-1
                     
                     CALL s_transaction_end('Y',0)
                  END IF 
                  CLOSE aooi350_01_dialog_bcl
                  LET l_count = g_oofb_d.getLength()
               END IF
            END IF

         AFTER DELETE
            CALL aooi350_01_b_fill(g_pmaa027_d)
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_oofb_d[l_ac].* = g_oofb_d_t.*
               CLOSE aooi350_01_dialog_bcl
               CALL s_transaction_end('N',0)
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = l_oofb.oofb001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_oofb_d[l_ac].* = g_oofb_d_t.*
            ELSE
               UPDATE oofb_t SET (oofbstus,oofb008,oofb009,oofb010,oofb019,oofb011,oofb012,oofb013,oofb014,oofb015,oofb016,oofb017,oofb018,oofb020,oofb021,oofb022)= (g_oofb_d[l_ac].oofbstus,g_oofb_d[l_ac].oofb008,g_oofb_d[l_ac].oofb009,g_oofb_d[l_ac].oofb010,g_oofb_d[l_ac].oofb019,g_oofb_d[l_ac].oofb011,g_oofb_d[l_ac].oofb012,
                                  g_oofb_d[l_ac].oofb013,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016,g_oofb_d[l_ac].oofb017,g_oofb_d[l_ac].oofb018,g_oofb_d[l_ac].oofb020,g_oofb_d[l_ac].oofb021,g_oofb_d[l_ac].oofb022)
                WHERE oofbent = g_enterprise AND oofb001 = g_oofb_d[l_ac].oofb001 AND oofb002 = g_pmaa027_d 
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "oofb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_oofb_d[l_ac].* = g_oofb_d_t.*
                  CALL s_transaction_end('N',0) 
               ELSE
                  CALL s_transaction_end('Y',0)                
               END IF

            END IF
            
         AFTER ROW
            CLOSE aooi350_01_dialog_bcl
        
            #end add-point
          
         #---------------------<  Detail: page1  >---------------------
         #----<<oofbstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofbstus
            #add-point:BEFORE FIELD oofbstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofbstus
            
            #add-point:AFTER FIELD oofbstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofbstus
            #add-point:ON CHANGE oofbstus

            #END add-point
 
         #----<<oofb001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofb001
            #add-point:BEFORE FIELD oofb001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofb001
            
            #add-point:AFTER FIELD oofb001
            IF  g_oofb_d[g_detail_idx].oofb001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_oofb_d[g_detail_idx].oofb001 != g_oofb_d_t.oofb001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oofb_t WHERE "||"oofbent = '" ||g_enterprise|| "' AND "||"oofb001 = '"||g_oofb_d[g_detail_idx].oofb001 ||"'",'std-00004',1) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofb001
            #add-point:ON CHANGE oofb001

            #END add-point
 
         #----<<oofb008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofb008
            #add-point:BEFORE FIELD oofb008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofb008
            
            #add-point:AFTER FIELD oofb008
            #IF g_oofb_d[l_ac].oofb008 <> g_oofb_d_t.oofb008 OR g_oofb_d_t.oofb008 IS NULL THEN
            #  IF g_oofb_d[l_ac].oofb008 = '3' AND cl_null(g_oofb_d[l_ac].oofb022) THEN
            #      CALL cl_set_comp_required('oofb022',TRUE)
            #  ELSE
            #     CALL cl_set_comp_required('oofb022',FALSE)
            #  END IF
            #END IF 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofb008
            #add-point:ON CHANGE oofb008

            #END add-point
 
         #----<<oofb009>>----
         #此段落由子樣板a02產生
         AFTER FIELD oofb009
            
            #add-point:AFTER FIELD oofb009
            IF NOT cl_null(g_oofb_d[l_ac].oofb009) THEN
               CALL s_azzi650_chk_exist('1',g_oofb_d[l_ac].oofb009) RETURNING l_success
               IF NOT l_success THEN
                  LET g_oofb_d[l_ac].oofb009 = g_oofb_d_t.oofb009
                  LET g_oofb_d[l_ac].oofb009_desc = g_oofb_d_t.oofb009_desc
                  NEXT FIELD oofb009
               END IF   
            END IF            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb009_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD oofb009
            #add-point:BEFORE FIELD oofb009
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb009_desc
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE oofb009
            #add-point:ON CHANGE oofb009

            #END add-point
 
         #----<<oofb010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofb010
            #add-point:BEFORE FIELD oofb010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofb010
            
            #add-point:AFTER FIELD oofb010
            IF NOT cl_null(g_oofb_d[l_ac].oofb008) AND g_oofb_d[l_ac].oofb010 = 'Y' THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_oofb_d[l_ac].oofb010 != g_oofb_d_t.oofb010))) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM oofb_t
                   WHERE oofbent = g_enterprise
                     AND oofb002 = g_pmaa027_d
                     AND oofb008 = g_oofb_d[l_ac].oofb008
                     AND oofb010 = 'Y'
                   IF l_n > 0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'aoo-00156'
                      LET g_errparam.extend = g_oofb_d[l_ac].oofb010
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET g_oofb_d[l_ac].oofb010 = 'N'
                      NEXT FIELD oofb010
                   END IF
                END IF
             END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofb010
            #add-point:ON CHANGE oofb010

            #END add-point
 
         #----<<oofb019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofb019
            #add-point:BEFORE FIELD oofb019

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofb019
            
            #add-point:AFTER FIELD oofb019
            IF NOT cl_null(g_oofb_d[l_ac].oofb019) THEN
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_oofb_d[l_ac].oofb019 != g_oofb_d_t.oofb019) OR g_oofb_d_t.oofb019 IS NULL)) THEN
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oofb_t WHERE oofbent = '" ||g_enterprise|| "' AND oofb002 = '"|| g_pmaa027_d ||  "' AND oofb019 = '"||g_oofb_d[l_ac].oofb019 ||"'",'std-00004',1) THEN 
                      LET g_oofb_d[l_ac].oofb019 = g_oofb_d_t.oofb019
                      NEXT FIELD oofb019
                   END IF
                END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofb019
            #add-point:ON CHANGE oofb019

            #END add-point
 
         #----<<oofb011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofb011
            #add-point:BEFORE FIELD oofb011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofb011
            
            #add-point:AFTER FIELD oofb011

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofb011
            #add-point:ON CHANGE oofb011

            #END add-point
       #此段落由子樣板a02產生
         AFTER FIELD oofb022            
            IF NOT cl_null(g_oofb_d[l_ac].oofb022) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_oofb_d[l_ac].oofb022
               CALL ap_ref_array2(g_ref_fields,"SELECT dbadl003 FROM dbadl_t WHERE dbadlent='"||g_enterprise||"' AND dbadl001=? AND dbadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_oofb_d[l_ac].oofb022_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_oofb_d[l_ac].oofb022_desc
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_oofb_d[l_ac].oofb022
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_dbad001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_oofb_d[l_ac].oofb022 = g_oofb_d_t.oofb022
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofb_d[l_ac].oofb022
                  CALL ap_ref_array2(g_ref_fields,"SELECT dbadl003 FROM dbadl_t WHERE dbadlent='"||g_enterprise||"' AND dbadl001=? AND dbadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofb_d[l_ac].oofb022_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_oofb_d[l_ac].oofb022_desc                  
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            #IF g_oofb_d[l_ac].oofb022 <> g_oofb_d_t.oofb022 OR cl_null(g_oofb_d[l_ac].oofb022) THEN
            #   IF g_oofb_d[l_ac].oofb008 = '3' AND cl_null(g_oofb_d[l_ac].oofb022) THEN
            #       CALL cl_set_comp_required('oofb022',TRUE)
            #   ELSE
            #      CALL cl_set_comp_required('oofb022',FALSE)
            #   END IF
            #END IF            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb022
            CALL ap_ref_array2(g_ref_fields,"SELECT dbadl003 FROM dbadl_t WHERE dbadlent='"||g_enterprise||"' AND dbadl001=? AND dbadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb022_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb022_desc
 
         #----<<oofb012>>----
         #此段落由子樣板a02產生
         AFTER FIELD oofb012
            
            #add-point:AFTER FIELD oofb012
            IF NOT aooi350_01_oofb_chk(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb013,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016) THEN 
               LET g_oofb_d[l_ac].oofb012 = g_oofb_d_t.oofb012
               LET g_oofb_d[l_ac].oofb012_desc = g_oofb_d_t.oofb012_desc
               NEXT FIELD oofb012
            END IF           
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb012_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD oofb012
            #add-point:BEFORE FIELD oofb012
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)         
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE oofb012
            #add-point:ON CHANGE oofb012

            #END add-point
 
         #----<<oofb013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofb013
            #add-point:BEFORE FIELD oofb013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofb013
            
            #add-point:AFTER FIELD oofb013
           #IF NOT cl_null(g_oofb_d[l_ac].oofb013) THEN #160929-00035#1 mark
            IF NOT cl_null(g_oofb_d[l_ac].oofb013) AND (g_oofb_d[l_ac].oofb013 <> g_oofb_d_t.oofb013) OR cl_null(g_oofb_d_t.oofb013) THEN #160929-00035#1 add
              SELECT oocn003,oocn004,oocn005,oocn006 INTO g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016,l_oofb017  #161011-00021#1 g_oofb_d[l_ac].oofb017-->l_oofb017
                FROM oocn_t
               WHERE oocnent=g_enterprise
                 AND oocn001 = g_oofb_d[l_ac].oofb012
                 AND oocn002 = g_oofb_d[l_ac].oofb013
               #161011-00021#1 by wuxja add  --begin--  
               IF cl_null(g_oofb_d[l_ac].oofb017) THEN
                  LET g_oofb_d[l_ac].oofb017 = l_oofb017
               END IF
               #161011-00021#1 by wuxja add  --end--
           #END IF ##160929-00035#1 mark
               DISPLAY BY NAME g_oofb_d[l_ac].oofb014
               DISPLAY BY NAME g_oofb_d[l_ac].oofb015
               DISPLAY BY NAME g_oofb_d[l_ac].oofb016
               DISPLAY BY NAME g_oofb_d[l_ac].oofb017
            END IF #160929-00035#1 add

            IF cl_null(g_oofb_d[l_ac].oofb015) THEN
               LET g_oofb_d[l_ac].oofb015 = ' '
            END IF
            IF NOT aooi350_01_oofb_chk(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb013,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016) THEN 
               LET g_oofb_d[l_ac].oofb013 = g_oofb_d_t.oofb013
               LET g_oofb_d[l_ac].oofb014 = g_oofb_d_t.oofb014
               LET g_oofb_d[l_ac].oofb015 = g_oofb_d_t.oofb015
               LET g_oofb_d[l_ac].oofb016 = g_oofb_d_t.oofb016
               LET g_oofb_d[l_ac].oofb017 = g_oofb_d_t.oofb017
               NEXT FIELD oofb013
            END IF   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
            CALL ap_ref_array2(g_ref_fields,"SELECT oocil004 FROM oocil_t WHERE oocilent='"||g_enterprise||"' AND oocil001=? AND oocil002=? AND oocil003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb014_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oofb_d[l_ac].oofb014_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
            LET g_ref_fields[3] = g_oofb_d[l_ac].oofb015
            CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl001=? AND oockl002=? AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb015_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oofb_d[l_ac].oofb015_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
            LET g_ref_fields[3] = g_oofb_d[l_ac].oofb015
            LET g_ref_fields[4] = g_oofb_d[l_ac].oofb016
            CALL ap_ref_array2(g_ref_fields,"SELECT oocml006 FROM oocml_t WHERE oocmlent='"||g_enterprise||"' AND oocml001=? AND oocml002=? AND oocml003=? AND oocml004=? AND oocml005='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb016_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oofb_d[l_ac].oofb016_desc
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofb013
            #add-point:ON CHANGE oofb013

            #END add-point
 
         #----<<oofb014>>----
         #此段落由子樣板a02產生
         AFTER FIELD oofb014
            
            #add-point:AFTER FIELD oofb014
            IF NOT aooi350_01_oofb_chk(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb013,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016) THEN 
               LET g_oofb_d[l_ac].oofb014 = g_oofb_d_t.oofb014
               LET g_oofb_d[l_ac].oofb014_desc = g_oofb_d_t.oofb014_desc
               NEXT FIELD oofb014
            END IF            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
            CALL ap_ref_array2(g_ref_fields,"SELECT oocil004 FROM oocil_t WHERE oocilent='"||g_enterprise||"' AND oocil001=? AND oocil002=? AND oocil003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb014_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb014_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD oofb014
            #add-point:BEFORE FIELD oofb014
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)         
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE oofb014
            #add-point:ON CHANGE oofb014

            #END add-point
 
         #----<<oofb015>>----
         #此段落由子樣板a02產生
         AFTER FIELD oofb015
            
            #add-point:AFTER FIELD oofb015
            IF NOT aooi350_01_oofb_chk(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb013,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016) THEN 
               LET g_oofb_d[l_ac].oofb015 = g_oofb_d_t.oofb015
               LET g_oofb_d[l_ac].oofb015_desc = g_oofb_d_t.oofb015_desc
               NEXT FIELD oofb015
            END IF            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
            LET g_ref_fields[3] = g_oofb_d[l_ac].oofb015
            CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl001=? AND oockl002=? AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb015_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD oofb015
            #add-point:BEFORE FIELD oofb015
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)         
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE oofb015
            #add-point:ON CHANGE oofb015

            #END add-point
 
         #----<<oofb016>>----
         #此段落由子樣板a02產生
         AFTER FIELD oofb016
            
            #add-point:AFTER FIELD oofb016
            IF NOT aooi350_01_oofb_chk(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb013,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016) THEN 
               LET g_oofb_d[l_ac].oofb016 = g_oofb_d_t.oofb016
               LET g_oofb_d[l_ac].oofb016_desc = g_oofb_d_t.oofb016_desc
               NEXT FIELD oofb016
            END IF
            IF cl_null(g_oofb_d[l_ac].oofb015) THEN
               LET g_oofb_d[l_ac].oofb015 = ' '
            END IF            
            INITIALIZE g_ref_fields TO NULL
            IF cl_null(g_oofb_d[l_ac].oofb015) THEN LET g_oofb_d[l_ac].oofb015=' ' END IF
            LET g_ref_fields[1] = g_oofb_d[l_ac].oofb012
            LET g_ref_fields[2] = g_oofb_d[l_ac].oofb014
            LET g_ref_fields[3] = g_oofb_d[l_ac].oofb015
            LET g_ref_fields[4] = g_oofb_d[l_ac].oofb016
            CALL ap_ref_array2(g_ref_fields,"SELECT oocml006 FROM oocml_t WHERE oocmlent='"||g_enterprise||"' AND oocml001=? AND oocml002=? AND oocml003=? AND oocml004=? AND oocml005='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofb_d[l_ac].oofb016_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofb_d[l_ac].oofb016_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD oofb016
            #add-point:BEFORE FIELD oofb016
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)         
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE oofb016
            #add-point:ON CHANGE oofb016

            #END add-point
 
         #----<<oofb017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofb017
            #add-point:BEFORE FIELD oofb017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofb017
            
            #add-point:AFTER FIELD oofb017

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofb017
            #add-point:ON CHANGE oofb017

            #END add-point
 
         #----<<oofb018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofb018
            #add-point:BEFORE FIELD oofb018

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofb018
            
            #add-point:AFTER FIELD oofb018

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofb018
            #add-point:ON CHANGE oofb018

            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<oofbstus>>----
         #Ctrlp:input.c.page1_aooi350_01.oofbstus
         ON ACTION controlp INFIELD oofbstus
            #add-point:ON ACTION controlp INFIELD oofbstus

            #END add-point
 
         #----<<oofb001>>----
         #Ctrlp:input.c.page1_aooi350_01.oofb001
         ON ACTION controlp INFIELD oofb001
            #add-point:ON ACTION controlp INFIELD oofb001

            #END add-point
 
         #----<<oofb008>>----
         #Ctrlp:input.c.page1_aooi350_01.oofb008
         ON ACTION controlp INFIELD oofb008
            #add-point:ON ACTION controlp INFIELD oofb008

            #END add-point
 
         #----<<oofb009>>----
         #Ctrlp:input.c.page1_aooi350_01.oofb009
         ON ACTION controlp INFIELD oofb009
            #add-point:ON ACTION controlp INFIELD oofb009
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_oofb_d[l_ac].oofb009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oofb_d[l_ac].oofb009 TO oofb009              #顯示到畫面上

            NEXT FIELD oofb009                          #返回原欄位

            #END add-point
 
         #----<<oofb010>>----
         #Ctrlp:input.c.page1_aooi350_01.oofb010
         ON ACTION controlp INFIELD oofb010
            #add-point:ON ACTION controlp INFIELD oofb010

            #END add-point
 
         #----<<oofb019>>----
         #Ctrlp:input.c.page1_aooi350_01.oofb019
         ON ACTION controlp INFIELD oofb019
            #add-point:ON ACTION controlp INFIELD oofb019

            #END add-point
         ON ACTION controlp INFIELD oofb022
            #add-point:ON ACTION controlp INFIELD oofb022
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_dbad001_1()                                #呼叫開窗

            LET g_oofb_d[l_ac].oofb022 = g_qryparam.return1              

            DISPLAY g_oofb_d[l_ac].oofb022 TO oofb022              #

            NEXT FIELD oofb022                          #返回原欄位
 
         #----<<oofb011>>----
         #Ctrlp:input.c.page1_aooi350_01.oofb011
         ON ACTION controlp INFIELD oofb011
            #add-point:ON ACTION controlp INFIELD oofb011

            #END add-point
 
         #----<<oofb012>>----
         #Ctrlp:input.c.page1_aooi350_01.oofb012
         ON ACTION controlp INFIELD oofb012
            #add-point:ON ACTION controlp INFIELD oofb012
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb012             #給予default值

            #給予arg

            CALL q_oocg001()                                #呼叫開窗

            LET g_oofb_d[l_ac].oofb012 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oofb_d[l_ac].oofb012 TO oofb012              #顯示到畫面上
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)            
            NEXT FIELD oofb012                          #返回原欄位

            #END add-point
 
         #----<<oofb013>>----
         #Ctrlp:input.c.page1_aooi350_01.oofb013
         ON ACTION controlp INFIELD oofb013
            #add-point:ON ACTION controlp INFIELD oofb013
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb013             #給予default值
            LET g_qryparam.default2 = g_oofb_d[l_ac].oofb012             #給予default值
            LET g_qryparam.default3 = g_oofb_d[l_ac].oofb014             #給予default值
            LET g_qryparam.default4 = g_oofb_d[l_ac].oofb015             #給予default值
            LET g_qryparam.default5 = g_oofb_d[l_ac].oofb016             #給予default值
            LET g_qryparam.default6 = g_oofb_d[l_ac].oofb017             #給予default值
            
            #給予arg

            IF NOT cl_null(g_oofb_d[l_ac].oofb012) THEN
               LET g_qryparam.where = " oocn001 = '",g_oofb_d[l_ac].oofb012,"'"
            END IF
            
            #160909-00071#1 add  --begin--
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = " 1 = 1 "
            END IF
            IF NOT cl_null(g_oofb_d[l_ac].oofb014) THEN
               LET g_qryparam.where = g_qryparam.where," AND oocn003 = '",g_oofb_d[l_ac].oofb014,"'"
            END IF
            IF NOT cl_null(g_oofb_d[l_ac].oofb015) THEN
               LET g_qryparam.where = g_qryparam.where," AND oocn004 = '",g_oofb_d[l_ac].oofb015,"'"
            END IF
            IF NOT cl_null(g_oofb_d[l_ac].oofb016) THEN
               LET g_qryparam.where = g_qryparam.where," AND oocn005 = '",g_oofb_d[l_ac].oofb016,"'"
            END IF
            #161011-00021#1 by wuxja mark --begin--
            #IF NOT cl_null(g_oofb_d[l_ac].oofb017) THEN
            #   LET g_qryparam.where = g_qryparam.where," AND oocn006 = '",g_oofb_d[l_ac].oofb017,"'"
            #END IF
            #161011-00021#1 by wuxja mark --end--
            #160909-00071#1 add  --end--
            
            CALL q_oocn002_1()                                #呼叫開窗

            LET g_oofb_d[l_ac].oofb013 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb012 = g_qryparam.return2              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb014 = g_qryparam.return3              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb015 = g_qryparam.return4              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb016 = g_qryparam.return5              #將開窗取得的值回傳到變數
            IF cl_null(g_oofb_d[l_ac].oofb017) THEN  #161011-00021#1 add
               LET g_oofb_d[l_ac].oofb017 = g_qryparam.return6              #將開窗取得的值回傳到變數
            END IF #161011-00021#1 add

            DISPLAY g_oofb_d[l_ac].oofb013 TO oofb013              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb012 TO oofb012              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb014 TO oofb014              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb015 TO oofb015              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb016 TO oofb016              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb017 TO oofb017              #顯示到畫面上           
            
            #重新顯示州省、縣市、行政地區的名稱
            
            NEXT FIELD oofb013                          #返回原欄位
            #END add-point
 
         #----<<oofb014>>----
         #Ctrlp:input.c.page1_aooi350_01.oofb014
         ON ACTION controlp INFIELD oofb014
            #add-point:ON ACTION controlp INFIELD oofb014
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb012             #給予default值
            LET g_qryparam.default2 = g_oofb_d[l_ac].oofb014             #給予default值

            #給予arg

            IF NOT cl_null(g_oofb_d[l_ac].oofb012) THEN
               LET g_qryparam.where = " ooci001 = '",g_oofb_d[l_ac].oofb012,"'"
            END IF

            CALL q_ooci002_2()                                #呼叫開窗

            LET g_oofb_d[l_ac].oofb012 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb014 = g_qryparam.return2              #將開窗取得的值回傳到變數

            DISPLAY g_oofb_d[l_ac].oofb014 TO oofb012              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb014 TO oofb014              #顯示到畫面上

            #重新顯示州省、縣市、行政地區的名稱
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)            
            
            NEXT FIELD oofb014                          #返回原欄位
            #END add-point
 
         #----<<oofb015>>----
         #Ctrlp:input.c.page1_aooi350_01.oofb015
         ON ACTION controlp INFIELD oofb015
            #add-point:ON ACTION controlp INFIELD oofb015
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb014             #給予default值
            LET g_qryparam.default2 = g_oofb_d[l_ac].oofb015             #給予default值

            #給予arg

            IF NOT cl_null(g_oofb_d[l_ac].oofb012) THEN
               LET g_qryparam.where = " oock001 = '",g_oofb_d[l_ac].oofb012,"'"
            END IF
            IF NOT cl_null(g_oofb_d[l_ac].oofb014) THEN
               LET g_qryparam.where = g_qryparam.where," AND oock002 = '",g_oofb_d[l_ac].oofb014,"'"
            END IF

            #161027-00029#1-(S)-mark
            #CALL q_oock003_1()                                #呼叫開窗
            #
            #LET g_oofb_d[l_ac].oofb014 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_oofb_d[l_ac].oofb015 = g_qryparam.return2              #將開窗取得的值回傳到變數
            #161027-00029#1-(E)-mark
            
            #161027-00029#1-(S)-add 
            CALL q_oock003_2()                                #呼叫開窗             
            
            LET g_oofb_d[l_ac].oofb012 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb014 = g_qryparam.return2              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb015 = g_qryparam.return3              #將開窗取得的值回傳到變數
            DISPLAY g_oofb_d[l_ac].oofb015 TO oofb012              #顯示到畫面上
            #161027-00029#1-(E)-add         

            DISPLAY g_oofb_d[l_ac].oofb015 TO oofb014              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb015 TO oofb015              #顯示到畫面上

            #重新顯示州省、縣市、行政地區的名稱
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)            
            
            NEXT FIELD oofb015                   
            #END add-point
 
         #----<<oofb016>>----
         #Ctrlp:input.c.page1_aooi350_01.oofb016
         ON ACTION controlp INFIELD oofb016
            #add-point:ON ACTION controlp INFIELD oofb016
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = ''
            LET g_qryparam.default1 = g_oofb_d[l_ac].oofb014             #給予default值
            LET g_qryparam.default2 = g_oofb_d[l_ac].oofb015             #給予default值
            LET g_qryparam.default3 = g_oofb_d[l_ac].oofb016             #給予default值

            #給予arg

            IF NOT cl_null(g_oofb_d[l_ac].oofb012) THEN
               LET g_qryparam.where = " oocm001 = '",g_oofb_d[l_ac].oofb012,"'"
            END IF
            IF NOT cl_null(g_oofb_d[l_ac].oofb014) THEN
               LET g_qryparam.where = g_qryparam.where," AND oocm002 = '",g_oofb_d[l_ac].oofb014,"'"
            END IF
            IF NOT cl_null(g_oofb_d[l_ac].oofb015) THEN
               LET g_qryparam.where = g_qryparam.where," AND oocm003 = '",g_oofb_d[l_ac].oofb015,"'"
            END IF
            
            CALL q_oocm004_2()                                #呼叫開窗

            LET g_oofb_d[l_ac].oofb014 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_oofb_d[l_ac].oofb015 = g_qryparam.return2              #將開窗取得的值回傳到變數            
            LET g_oofb_d[l_ac].oofb016 = g_qryparam.return3              #將開窗取得的值回傳到變數

            DISPLAY g_oofb_d[l_ac].oofb016 TO oofb014              #顯示到畫面上
            DISPLAY g_oofb_d[l_ac].oofb016 TO oofb015              #顯示到畫面上            
            DISPLAY g_oofb_d[l_ac].oofb016 TO oofb016              #顯示到畫面上

            #重新顯示州省、縣市、行政地區的名稱
            CALL aooi350_01_show_ref(g_oofb_d[l_ac].oofb012,g_oofb_d[l_ac].oofb014,g_oofb_d[l_ac].oofb015,g_oofb_d[l_ac].oofb016)            
            
            #END add-point
 
         #----<<oofb017>>----
         #Ctrlp:input.c.page1_aooi350_01.oofb017
         ON ACTION controlp INFIELD oofb017
            #add-point:ON ACTION controlp INFIELD oofb017

            #END add-point
 
         #----<<oofb018>>----
         #Ctrlp:input.c.page1_aooi350_01.oofb018
         ON ACTION controlp INFIELD oofb018
            #add-point:ON ACTION controlp INFIELD oofb018

            #END add-point
 
 
 
         AFTER INPUT
            #add-point:單身輸入後處理
            LET g_pmba_d.* = g_oofb_d.*
            LET g_oofb_d2.* = g_oofb_d.*
            ##end add-point
            
      END INPUT
END DIALOG

 
{</section>}
 
{<section id="aooi350_01.other_function" readonly="Y" >}
# 單身陣列填充
PUBLIC FUNCTION aooi350_01_b_fill(p_oofb002)
   DEFINE l_sql      STRING
   DEFINE p_oofb002   LIKE oofb_t.oofb002
   DEFINE l_ac1      LIKE type_t.num5
   LET l_sql = " SELECT oofbstus,oofb001,oofb019,oofb011,oofb008,oofb009,'',oofb010,oofb012,'',oofb013,oofb014,'',oofb015,'',oofb016,'',oofb017,oofb022,'',oofb020,oofb021,oofb018 ",
               "   FROM oofb_t WHERE oofbent = '",g_enterprise,"' AND oofb002 = '",p_oofb002,"'"
   IF NOT cl_null(g_wc2_i35001) THEN
      LET l_sql = l_sql CLIPPED, " AND ",g_wc2_i35001 CLIPPED
   END IF
   LET l_sql = l_sql, " ORDER BY oofb008,oofb009"  
   PREPARE aooi350_01_pb FROM l_sql
   DECLARE b_fill_curs CURSOR FOR aooi350_01_pb 
   
   CALL g_oofb_d.clear()
   LET l_ac1 = 1
   FOREACH b_fill_curs INTO g_oofb_d[l_ac1].oofbstus,g_oofb_d[l_ac1].oofb001,g_oofb_d[l_ac1].oofb019,g_oofb_d[l_ac1].oofb011,
                            g_oofb_d[l_ac1].oofb008,g_oofb_d[l_ac1].oofb009,g_oofb_d[l_ac1].oofb009_desc,
                            g_oofb_d[l_ac1].oofb010, g_oofb_d[l_ac1].oofb012,g_oofb_d[l_ac1].oofb012_desc,g_oofb_d[l_ac1].oofb013, 
                            g_oofb_d[l_ac1].oofb014,g_oofb_d[l_ac1].oofb014_desc,g_oofb_d[l_ac1].oofb015,g_oofb_d[l_ac1].oofb015_desc,
                            g_oofb_d[l_ac1].oofb016,g_oofb_d[l_ac1].oofb016_desc,g_oofb_d[l_ac1].oofb017,g_oofb_d[l_ac1].oofb022,g_oofb_d[l_ac1].oofb022_desc,
                            g_oofb_d[l_ac1].oofb020,g_oofb_d[l_ac1].oofb021,g_oofb_d[l_ac1].oofb018
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      IF cl_null(g_oofb_d[l_ac1].oofb015) THEN
         LET g_oofb_d[l_ac1].oofb015 = ' '
      END IF
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_oofb_d[l_ac1].oofb009
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_oofb_d[l_ac1].oofb009_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_oofb_d[l_ac1].oofb009_desc  
  
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_oofb_d[l_ac1].oofb012
      CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_oofb_d[l_ac1].oofb012_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_oofb_d[l_ac1].oofb012_desc 
                  
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_oofb_d[l_ac1].oofb012
      LET g_ref_fields[2] = g_oofb_d[l_ac1].oofb014
      CALL ap_ref_array2(g_ref_fields,"SELECT oocil004 FROM oocil_t WHERE oocilent='"||g_enterprise||"' AND oocil001=? AND oocil002=? AND oocil003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_oofb_d[l_ac1].oofb014_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_oofb_d[l_ac1].oofb014_desc
                  
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_oofb_d[l_ac1].oofb012
      LET g_ref_fields[2] = g_oofb_d[l_ac1].oofb014
      LET g_ref_fields[3] = g_oofb_d[l_ac1].oofb015
      CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl001=? AND oockl002=? AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_oofb_d[l_ac1].oofb015_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_oofb_d[l_ac1].oofb015_desc
                  
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_oofb_d[l_ac1].oofb012
      LET g_ref_fields[2] = g_oofb_d[l_ac1].oofb014
      LET g_ref_fields[3] = g_oofb_d[l_ac1].oofb015
      LET g_ref_fields[4] = g_oofb_d[l_ac1].oofb016
      CALL ap_ref_array2(g_ref_fields,"SELECT oocml006 FROM oocml_t WHERE oocmlent='"||g_enterprise||"' AND oocml001=? AND oocml002=? AND oocml003=? AND oocml004=? AND oocml005='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_oofb_d[l_ac1].oofb016_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_oofb_d[l_ac1].oofb016_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_oofb_d[l_ac1].oofb022
      CALL ap_ref_array2(g_ref_fields,"SELECT dbadl003 FROM dbadl_t WHERE dbadlent='"||g_enterprise||"' AND dbadl001=? AND dbadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_oofb_d[l_ac1].oofb022_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_oofb_d[l_ac1].oofb022_desc
               
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         #CALL cl_err( "", 9035, 0 )
         EXIT FOREACH
      END IF
      
   END FOREACH 
   CALL g_oofb_d.deleteElement(g_oofb_d.getLength())   
   LET g_rec_b = l_ac1 - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   LET g_pmba_d.* = g_oofb_d.*
   #將總筆數, 目前筆數指定到共用變數中
   IF g_rec_b > 0 THEN
      LET g_d_idx_i35001 = 1
   ELSE
      LET g_d_idx_i35001 = 0
   END IF
   LET g_d_cnt_i35001 = g_rec_b
   LET g_oofb_d2.* = g_oofb_d.* 
   CLOSE b_fill_curs
   FREE aooi350_01_pb
END FUNCTION
################################################################################
# Descriptions...: 清除畫面上聯絡地址單身
# Memo...........: 
# Usage..........: CALL aooi350_01_clear_detail()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/24 By Saki
# Modify.........:
################################################################################
PUBLIC FUNCTION aooi350_01_clear_detail()
   CALL g_oofb_d.clear()
END FUNCTION
# 國家地區、州省、縣市、郵政編號相關欄位檢查
PRIVATE FUNCTION aooi350_01_oofb_chk(p_oofb012,p_oofb013,p_oofb014,p_oofb015,p_oofb016)
DEFINE p_oofb012    LIKE oofb_t.oofb012
DEFINE p_oofb013    LIKE oofb_t.oofb013
DEFINE p_oofb014    LIKE oofb_t.oofb014
DEFINE p_oofb015    LIKE oofb_t.oofb015
DEFINE p_oofb016    LIKE oofb_t.oofb016
DEFINE l_oocg001    LIKE oocg_t.oocg001
DEFINE l_oocgstus   LIKE oocg_t.oocgstus
DEFINE l_sql        STRING 


IF NOT cl_null(p_oofb012) THEN 
   LET l_oocg001 = ''
   LET l_oocgstus = ''   
   SELECT oocg001,oocgstus INTO l_oocg001,l_oocgstus FROM oocg_t 
    WHERE oocg001 = p_oofb012 AND oocgent = g_enterprise
   IF cl_null(l_oocg001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00013'
      LET g_errparam.extend = p_oofb012
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF 
   IF l_oocgstus != 'Y' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-01302'  #aoo-00035  #160318-00005#31 by 07900 --mod
      LET g_errparam.extend = p_oofb012
      #160318-00005#31  By 07900 --add-str
      LET g_errparam.replace[1] ='aooi200'
      LET g_errparam.replace[2] = cl_get_progname("aooi200",g_lang,"2")
      LET g_errparam.exeprog ='aooi200'
      #160318-00005#31  By 07900 --add-end
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF 
END IF 

IF NOT cl_null(p_oofb013) THEN 
   LET l_oocg001 = ''
   LET l_oocgstus = ''   
   SELECT oocn002,oocnstus INTO l_oocg001,l_oocgstus FROM oocn_t
    WHERE oocn001 = p_oofb012 AND oocn002 = p_oofb013 AND oocnent = g_enterprise
   IF cl_null(l_oocg001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00151'
      LET g_errparam.extend = p_oofb014
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF 
   IF l_oocgstus != 'Y' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00152'
      LET g_errparam.extend = p_oofb014
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF  
END IF 
    
IF NOT cl_null(p_oofb014) THEN 
   LET l_oocg001 = ''
   LET l_oocgstus = ''
   SELECT ooci002,oocistus INTO l_oocg001,l_oocgstus FROM ooci_t
    WHERE ooci001 = p_oofb012 AND ooci002 = p_oofb014 AND oocient = g_enterprise
   IF cl_null(l_oocg001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00014'
      LET g_errparam.extend = p_oofb014
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF 
   IF l_oocgstus != 'Y' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-01302' #aoo-00143  #160318-00005#31 by 07900 --mod
      LET g_errparam.extend = p_oofb014
      #160318-00005#31  By 07900 --add-str
      LET g_errparam.replace[1] ='aooi030'
      LET g_errparam.replace[2] = cl_get_progname("aooi030",g_lang,"2")
      LET g_errparam.exeprog ='aooi030'
      #160318-00005#31  By 07900 --add-end
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF  
END IF 

IF NOT cl_null(p_oofb015) THEN 
   LET l_oocg001 = ''
   LET l_oocgstus = ''
   LET l_sql = "SELECT oock003,oockstus FROM oock_t",
               " WHERE oock001 = '",p_oofb012,"' AND oock003 = '",p_oofb015,"' AND oockent = '",g_enterprise,"'"
   IF NOT cl_null(p_oofb014) THEN 
      LET l_sql = l_sql ," AND oock002='",p_oofb014,"'"
   END IF
   PREPARE pre_oofb015 FROM l_sql
   EXECUTE pre_oofb015 INTO l_oocg001,l_oocgstus
   IF cl_null(l_oocg001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00015'
      LET g_errparam.extend = p_oofb015
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF 
   IF l_oocgstus != 'Y' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00036'
      LET g_errparam.extend = p_oofb015
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF  
END IF 

IF NOT cl_null(p_oofb016) THEN 
   LET l_oocg001 = ''
   LET l_oocgstus = ''
   LET l_sql = "SELECT oocm004,oocmstus FROM oocm_t",
               " WHERE oocm001 = '",p_oofb012,"' AND oocm004 = '",p_oofb016,"' AND oocment = '",g_enterprise,"'"
   IF NOT cl_null(p_oofb014) THEN 
      LET l_sql = l_sql ," AND oocm002='",p_oofb014,"'"
   END IF
   IF NOT cl_null(p_oofb015) THEN
      LET l_sql = l_sql ," AND oocm003='",p_oofb015,"'"
   END IF   
   PREPARE pre_oofb016 FROM l_sql
   EXECUTE pre_oofb016 INTO l_oocg001,l_oocgstus
   IF cl_null(l_oocg001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00022'
      LET g_errparam.extend = p_oofb016
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF 
   IF l_oocgstus != 'Y' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00144'
      LET g_errparam.extend = p_oofb016
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF  
END IF 

RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aooi350_01_show_ref(p_oofb012,p_oofb014,p_oofb015,p_oofb016)
#                  RETURNING 回传参数
# Input parameter: p_oofb012   國家/地區
#                : p_oofb014   州/省/直轄市
#                : p_oofb015   縣/市
#                : p_oofb016   行政區域
# Return code....: 無
# Date & Author..: 140311 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi350_01_show_ref(p_oofb012,p_oofb014,p_oofb015,p_oofb016)
DEFINE p_oofb012       LIKE oofb_t.oofb012
DEFINE p_oofb014       LIKE oofb_t.oofb014
DEFINE p_oofb015       LIKE oofb_t.oofb015
DEFINE p_oofb016       LIKE oofb_t.oofb016

   IF cl_null(p_oofb015) THEN LET p_oofb015 = ' ' END IF
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oofb012
   CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_oofb_d[l_ac].oofb012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_oofb_d[l_ac].oofb012_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oofb012
   LET g_ref_fields[2] = p_oofb014
   CALL ap_ref_array2(g_ref_fields,"SELECT oocil004 FROM oocil_t WHERE oocilent='"||g_enterprise||"' AND oocil001=? AND oocil002=? AND oocil003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_oofb_d[l_ac].oofb014_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_oofb_d[l_ac].oofb014_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oofb012
   LET g_ref_fields[2] = p_oofb014
   LET g_ref_fields[3] = p_oofb015
   CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl001=? AND oockl002=? AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_oofb_d[l_ac].oofb015_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_oofb_d[l_ac].oofb015_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oofb012
   LET g_ref_fields[2] = p_oofb014
   LET g_ref_fields[3] = p_oofb015
   LET g_ref_fields[4] = p_oofb016
   CALL ap_ref_array2(g_ref_fields,"SELECT oocml006 FROM oocml_t WHERE oocmlent='"||g_enterprise||"' AND oocml001=? AND oocml002=? AND oocml003=? AND oocml004=? AND oocml005='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_oofb_d[l_ac].oofb016_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_oofb_d[l_ac].oofb016_desc
   
END FUNCTION

 
{</section>}
 
