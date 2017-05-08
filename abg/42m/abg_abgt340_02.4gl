#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt340_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-11-04 11:32:43), PR版次:0001(2016-11-30 15:15:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgt340_02
#+ Description: 維度檢核
#+ Creator....: 02599(2016-11-04 11:20:06)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="abgt340_02.global" >}
#應用 c02c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
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

#end add-point
 
DEFINE g_rec_b               LIKE type_t.num10   
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE TYPE type_g_bgcj_d        RECORD
   bgcj007 LIKE bgcj_t.bgcj007,
   bgcj007_desc LIKE type_t.chr500, 
   bgcj009 LIKE bgcj_t.bgcj009,
   bgcj049 LIKE bgcj_t.bgcj049
      END RECORD
PRIVATE TYPE type_g_bgcj2_d        RECORD
   bgcjseq LIKE bgcj_t.bgcjseq,
   bgcj007 LIKE bgcj_t.bgcj007,
   bgcj007_2_desc LIKE type_t.chr500, 
   bgcj009 LIKE bgcj_t.bgcj009,
   bgcj049 LIKE bgcj_t.bgcj049,
   hsx LIKE type_t.num5
      END RECORD
DEFINE g_bgcj_d          DYNAMIC ARRAY OF type_g_bgcj_d
DEFINE g_bgcj2_d         DYNAMIC ARRAY OF type_g_bgcj2_d
DEFINE g_bgcj001         LIKE bgcj_t.bgcj001    
DEFINE g_bgcj002         LIKE bgcj_t.bgcj002    
DEFINE g_bgcj003         LIKE bgcj_t.bgcj003    
DEFINE g_bgcj004         LIKE bgcj_t.bgcj004    
DEFINE g_bgcj005         LIKE bgcj_t.bgcj005    
DEFINE g_bgcj006         LIKE bgcj_t.bgcj006    
DEFINE g_bgcj007         LIKE bgcj_t.bgcj007    
DEFINE g_bgcj009         LIKE bgcj_t.bgcj009
DEFINE g_bgcj011         LIKE bgcj_t.bgcj011
DEFINE l_ac              LIKE type_t.num10
DEFINE l_ac2             LIKE type_t.num10
DEFINE g_detail_idx      LIKE type_t.num10             #單身目前所在筆數
DEFINE g_curr_diag       ui.Dialog                     #Current Dialog
DEFINE g_current_page    LIKE type_t.num10             #目前所在頁數
DEFINE g_loc             LIKE type_t.chr5              #判斷游標所在位置
#end add-point
     
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
     
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point     
 
{</section>}
 
{<section id="abgt340_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgt340_02(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   p_bgcj001,p_bgcj002,p_bgcj003,p_bgcj004,p_bgcj005,p_bgcj006,p_bgcj007,p_bgcj009,p_bgcj011
   #end add-point
   )
   #add-point:construct段define name="construct.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   DEFINE p_bgcj001               LIKE bgcj_t.bgcj001
   DEFINE p_bgcj002               LIKE bgcj_t.bgcj002
   DEFINE p_bgcj003               LIKE bgcj_t.bgcj003
   DEFINE p_bgcj004               LIKE bgcj_t.bgcj004
   DEFINE p_bgcj005               LIKE bgcj_t.bgcj005
   DEFINE p_bgcj006               LIKE bgcj_t.bgcj006
   DEFINE p_bgcj007               LIKE bgcj_t.bgcj007
   DEFINE p_bgcj009               LIKE bgcj_t.bgcj009
   DEFINE p_bgcj011               LIKE bgcj_t.bgcj011
   DEFINE r_success               LIKE type_t.num5
   
   
   
   #在开启窗口前先抓取维度进行检核
   LET g_bgcj001 = p_bgcj001 
   LET g_bgcj002 = p_bgcj002 
   LET g_bgcj003 = p_bgcj003 
   LET g_bgcj004 = p_bgcj004 
   LET g_bgcj005 = p_bgcj005 
   LET g_bgcj006 = p_bgcj006 
   LET g_bgcj007 = p_bgcj007 
   LET g_bgcj009 = p_bgcj009
   LET g_bgcj011 = p_bgcj011
   #填充单身
   CALL abgt340_02_b_fill()
   LET r_success = TRUE
   IF g_bgcj_d.getLength() = 0 AND g_bgcj2_d.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "abg-00216" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN r_success
   ELSE
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "abg-00217" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
   END IF
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgt340_02 WITH FORM cl_ap_formpath("abg","abgt340_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="construct.pre_construct"
   #重写dialog ，因为只要显示单身资料就可以了，不用查询
   IF 1=2 THEN
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
    
      #輸入開始
      CONSTRUCT g_wc ON bgcj007,bgcj049 
           FROM s_detail1[1].bgcj007,s_detail1[1].bgcj049 
         
         #自訂ACTION
         #add-point:自訂ACTION name="construct.action"
         
         #end add-point
         
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.body.before_construct"
            
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.body.after_construct"
            
            #end add-point
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
           
            
      END CONSTRUCT
    
      #add-point:自定義construct name="construct.more_construct"
      
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
 
   #add-point:畫面關閉前 name="construct.before_close"
   END IF
   
   #重写dialog ，因为只要显示单身资料就可以了，不用查询
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
       DISPLAY ARRAY g_bgcj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL g_curr_diag.setSelectionMode("s_detail1",1)
               #顯示單身筆數
               CALL abgt340_02_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
 
               
         END DISPLAY
        
         DISPLAY ARRAY g_bgcj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL abgt340_02_idx_chk()
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 2
         END DISPLAY
    
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
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_abgt340_02 
   
   #add-point:construct段after construct name="construct.post_construct"
   RETURN r_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgt340_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgt340_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 填充单身
# Memo...........:
# Usage..........: CALL abgt340_02_b_fill()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/11/04 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_02_b_fill()
   DEFINE l_bgaw1           DYNAMIC ARRAY OF VARCHAR(1) #位置在单头+显示为 Y，否则为 N
   DEFINE l_bgaw2           DYNAMIC ARRAY OF VARCHAR(1) #位置在单身+显示为 Y，否则为 N
   DEFINE l_bgal            RECORD LIKE bgal_t.*
   DEFINE l_sql             STRING
   DEFINE l_bgcj007         LIKE bgcj_t.bgcj007
   DEFINE l_bgcj007_desc    LIKE ooefl_t.ooefl003
   DEFINE l_bgcj009         LIKE bgcj_t.bgcj009
   DEFINE l_bgcj049         LIKE bgcj_t.bgcj049
   DEFINE l_bgcjseq         LIKE bgcj_t.bgcjseq
   DEFINE l_bgcj012         LIKE bgcj_t.bgcj012
   DEFINE l_bgcj013         LIKE bgcj_t.bgcj013
   DEFINE l_bgcj014         LIKE bgcj_t.bgcj014
   DEFINE l_bgcj015         LIKE bgcj_t.bgcj015
   DEFINE l_bgcj016         LIKE bgcj_t.bgcj016
   DEFINE l_bgcj017         LIKE bgcj_t.bgcj017
   DEFINE l_bgcj018         LIKE bgcj_t.bgcj018
   DEFINE l_bgcj019         LIKE bgcj_t.bgcj019
   DEFINE l_bgcj020         LIKE bgcj_t.bgcj020
   DEFINE l_bgcj021         LIKE bgcj_t.bgcj021
   DEFINE l_bgcj022         LIKE bgcj_t.bgcj022
   DEFINE l_bgcj023         LIKE bgcj_t.bgcj023
   DEFINE l_bgcj024         LIKE bgcj_t.bgcj024
   
   CALL g_bgcj_d.clear()
   CALL g_bgcj2_d.clear()
   
   #样式设置
   CALL s_abg2_get_bgaw(g_bgcj011) RETURNING l_bgaw1,l_bgaw2
   #期别销售预算
   IF g_prog = 'abgt340' OR g_prog = 'abgt350' THEN
      LET l_sql="SELECT DISTINCT bgcj007,ooefl003,bgcj009,bgcj049 ",
                "  FROM bgcj_t ",
                "       LEFT JOIN ooefl_t ON bgcjent=ooeflent AND bgcj007=ooefl001 AND ooefl002='",g_dlang,"'",
                " WHERE bgcjent =  ",g_enterprise,
                "   AND bgcj001 = '",g_bgcj001,"'",
                "   AND bgcj002 = '",g_bgcj002,"'",
                "   AND bgcj003 = '",g_bgcj003,"'",
                "   AND bgcj004 = '",g_bgcj004,"'",
                "   AND bgcj005 = '",g_bgcj005,"'",
                "   AND bgcj006 = '",g_bgcj006,"'"
      IF NOT cl_null(g_bgcj007) THEN
         LET l_sql=l_sql," AND bgcj007 = '",g_bgcj007,"'"
      END IF
      IF NOT cl_null(g_bgcj009) THEN
         LET l_sql=l_sql," AND bgcj009 = '",g_bgcj009,"'"
      END IF
      LET l_sql=l_sql," ORDER BY bgcj007,bgcj009,bgcj049"
   END IF
   #期别采购预算
   IF g_prog = 'abgt510' OR g_prog = 'abgt520' THEN
      LET l_sql="SELECT DISTINCT bgeg007,ooefl003,bgeg009,bgeg049 ",
                "  FROM bgeg_t ",
                "       LEFT JOIN ooefl_t ON bgegent=ooeflent AND bgeg007=ooefl001 AND ooefl002='",g_dlang,"'",
                " WHERE bgegent =  ",g_enterprise,
                "   AND bgeg001 = '",g_bgcj001,"'",
                "   AND bgeg002 = '",g_bgcj002,"'",
                "   AND bgeg003 = '",g_bgcj003,"'",
                "   AND bgeg004 = '",g_bgcj004,"'",
                "   AND bgeg005 = '",g_bgcj005,"'",
                "   AND bgeg006 = '",g_bgcj006,"'"
      IF NOT cl_null(g_bgcj007) THEN
         LET l_sql=l_sql," AND bgeg007 = '",g_bgcj007,"'"
      END IF
      IF NOT cl_null(g_bgcj009) THEN
         LET l_sql=l_sql," AND bgeg009 = '",g_bgcj009,"'"
      END IF
      LET l_sql=l_sql," ORDER BY bgeg007,bgeg009,bgeg049"
   END IF
   #期别费用预算
   IF g_prog = 'abgt620' OR g_prog = 'abgt630' THEN
      LET l_sql="SELECT DISTINCT bgfb007,ooefl003,bgfb009,'' ",
                "  FROM bgfb_t ",
                "       LEFT JOIN ooefl_t ON bgfbent=ooeflent AND bgfb007=ooefl001 AND ooefl002='",g_dlang,"'",
                " WHERE bgfbent =  ",g_enterprise,
                "   AND bgfb001 = '",g_bgcj001,"'",
                "   AND bgfb002 = '",g_bgcj002,"'",
                "   AND bgfb003 = '",g_bgcj003,"'",
                "   AND bgfb004 = '",g_bgcj004,"'",
                "   AND bgfb005 = '",g_bgcj005,"'",
                "   AND bgfb006 = '",g_bgcj006,"'"
      IF NOT cl_null(g_bgcj007) THEN
         LET l_sql=l_sql," AND bgfb007 = '",g_bgcj007,"'"
      END IF
      IF NOT cl_null(g_bgcj009) THEN
         LET l_sql=l_sql," AND bgfb009 = '",g_bgcj009,"'"
      END IF
      LET l_sql=l_sql," ORDER BY bgfb007,bgfb009"
   END IF
   
   PREPARE abgt340_02_b_fill_pr FROM l_sql
   DECLARE abgt340_02_b_fill_cs CURSOR FOR abgt340_02_b_fill_pr
   LET l_ac = 1
   
   #罗列出样表和预算细项对核算项启用有差异的预算组织和预算料件
   #样表启用的核算项个数 >= 预算细项启用的核算项个数
   #显示要求：样表中显示但预算细项不启用，或是样表中不显示但预算细项启用
   #当调用程序为abgt350时，依照预算样表使用的核算项为主，当样表使用核算项时，预算细项必须启用，对应的abgt350中核算项也必须输入值
   FOREACH abgt340_02_b_fill_cs INTO l_bgcj007,l_bgcj007_desc,l_bgcj009,l_bgcj049
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF g_prog = 'abgt620' OR g_prog = 'abgt630' THEN
         LET l_bgcj049 = l_bgcj009
      END IF
      
      SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
             bgal010,bgal011,bgal012,bgal013,bgal014,
             bgal025,bgal026,bgal027 
        INTO l_bgal.bgal005,l_bgal.bgal006,l_bgal.bgal007,l_bgal.bgal008,l_bgal.bgal009,
             l_bgal.bgal010,l_bgal.bgal011,l_bgal.bgal012,l_bgal.bgal013,l_bgal.bgal014,
             l_bgal.bgal025,l_bgal.bgal026,l_bgal.bgal027
        FROM bgal_t 
       WHERE bgalent=g_enterprise AND bgal001=g_bgcj002
         AND bgal002=l_bgcj007 AND bgal003=l_bgcj049
      
      #部门
      IF (l_bgaw1[3]='N' AND l_bgaw2[3]='N') AND l_bgal.bgal005 = 'Y' THEN
         LET g_bgcj_d[l_ac].bgcj007 = l_bgcj007
         LET g_bgcj_d[l_ac].bgcj007_desc = l_bgcj007_desc
         LET g_bgcj_d[l_ac].bgcj009 = l_bgcj009
         LET g_bgcj_d[l_ac].bgcj049 = l_bgcj049
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
      #利润成本中心
      IF (l_bgaw1[4]='N' AND l_bgaw2[4]='N') AND l_bgal.bgal006 = 'Y' THEN
         LET g_bgcj_d[l_ac].bgcj007 = l_bgcj007
         LET g_bgcj_d[l_ac].bgcj007_desc = l_bgcj007_desc
         LET g_bgcj_d[l_ac].bgcj009 = l_bgcj009
         LET g_bgcj_d[l_ac].bgcj049 = l_bgcj049
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
      #区域
      IF (l_bgaw1[5]='N' AND l_bgaw2[5]='N') AND l_bgal.bgal007 = 'Y' THEN
         LET g_bgcj_d[l_ac].bgcj007 = l_bgcj007
         LET g_bgcj_d[l_ac].bgcj007_desc = l_bgcj007_desc
         LET g_bgcj_d[l_ac].bgcj009 = l_bgcj009
         LET g_bgcj_d[l_ac].bgcj049 = l_bgcj049
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
      #收付款客商
      IF (l_bgaw1[6]='N' AND l_bgaw2[6]='N') AND l_bgal.bgal008 = 'Y' THEN
         LET g_bgcj_d[l_ac].bgcj007 = l_bgcj007
         LET g_bgcj_d[l_ac].bgcj007_desc = l_bgcj007_desc
         LET g_bgcj_d[l_ac].bgcj009 = l_bgcj009
         LET g_bgcj_d[l_ac].bgcj049 = l_bgcj049
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
      #账款客商
      IF (l_bgaw1[7]='N' AND l_bgaw2[7]='N') AND l_bgal.bgal009 = 'Y' THEN
         LET g_bgcj_d[l_ac].bgcj007 = l_bgcj007
         LET g_bgcj_d[l_ac].bgcj007_desc = l_bgcj007_desc
         LET g_bgcj_d[l_ac].bgcj009 = l_bgcj009
         LET g_bgcj_d[l_ac].bgcj049 = l_bgcj049
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
      #客群
      IF (l_bgaw1[8]='N' AND l_bgaw2[8]='N') AND l_bgal.bgal010 = 'Y' THEN
         LET g_bgcj_d[l_ac].bgcj007 = l_bgcj007
         LET g_bgcj_d[l_ac].bgcj007_desc = l_bgcj007_desc
         LET g_bgcj_d[l_ac].bgcj009 = l_bgcj009
         LET g_bgcj_d[l_ac].bgcj049 = l_bgcj049
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
      #产品类别
      IF (l_bgaw1[9]='N' AND l_bgaw2[9]='N') AND l_bgal.bgal011 = 'Y' THEN
         LET g_bgcj_d[l_ac].bgcj007 = l_bgcj007
         LET g_bgcj_d[l_ac].bgcj007_desc = l_bgcj007_desc
         LET g_bgcj_d[l_ac].bgcj009 = l_bgcj009
         LET g_bgcj_d[l_ac].bgcj049 = l_bgcj049
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
      #经营方式
      IF (l_bgaw1[10]='N' AND l_bgaw2[10]='N') AND l_bgal.bgal025 = 'Y' THEN
         LET g_bgcj_d[l_ac].bgcj007 = l_bgcj007
         LET g_bgcj_d[l_ac].bgcj007_desc = l_bgcj007_desc
         LET g_bgcj_d[l_ac].bgcj009 = l_bgcj009
         LET g_bgcj_d[l_ac].bgcj049 = l_bgcj049
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
      #通路
      IF (l_bgaw1[11]='N' AND l_bgaw2[11]='N') AND l_bgal.bgal026 = 'Y' THEN
         LET g_bgcj_d[l_ac].bgcj007 = l_bgcj007
         LET g_bgcj_d[l_ac].bgcj007_desc = l_bgcj007_desc
         LET g_bgcj_d[l_ac].bgcj009 = l_bgcj009
         LET g_bgcj_d[l_ac].bgcj049 = l_bgcj049
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
      #品牌
      IF (l_bgaw1[12]='N' AND l_bgaw2[12]='N') AND l_bgal.bgal027 = 'Y'  THEN
         LET g_bgcj_d[l_ac].bgcj007 = l_bgcj007
         LET g_bgcj_d[l_ac].bgcj007_desc = l_bgcj007_desc
         LET g_bgcj_d[l_ac].bgcj009 = l_bgcj009
         LET g_bgcj_d[l_ac].bgcj049 = l_bgcj049
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
      #人员
      IF (l_bgaw1[13]='N' AND l_bgaw2[13]='N') AND l_bgal.bgal012 = 'Y' THEN
         LET g_bgcj_d[l_ac].bgcj007 = l_bgcj007
         LET g_bgcj_d[l_ac].bgcj007_desc = l_bgcj007_desc
         LET g_bgcj_d[l_ac].bgcj009 = l_bgcj009
         LET g_bgcj_d[l_ac].bgcj049 = l_bgcj049
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
      #专案
      IF (l_bgaw1[14]='N' AND l_bgaw2[14]='N') AND l_bgal.bgal013 = 'Y' THEN
         LET g_bgcj_d[l_ac].bgcj007 = l_bgcj007
         LET g_bgcj_d[l_ac].bgcj007_desc = l_bgcj007_desc
         LET g_bgcj_d[l_ac].bgcj009 = l_bgcj009
         LET g_bgcj_d[l_ac].bgcj049 = l_bgcj049
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
      #WBS
      IF (l_bgaw1[15]='N' AND l_bgaw2[15]='N') AND l_bgal.bgal014 = 'Y' THEN
         LET g_bgcj_d[l_ac].bgcj007 = l_bgcj007
         LET g_bgcj_d[l_ac].bgcj007_desc = l_bgcj007_desc
         LET g_bgcj_d[l_ac].bgcj009 = l_bgcj009
         LET g_bgcj_d[l_ac].bgcj049 = l_bgcj049
         LET l_ac = l_ac + 1
         CONTINUE FOREACH
      END IF
   END FOREACH
   
   #单身二
   #期别销售预算
   IF g_prog = 'abgt340' OR g_prog = 'abgt350' THEN
      LET l_sql="SELECT DISTINCT bgcj007,ooefl003,bgcj009,bgcj049,bgcjseq,",
                "       bgcj012,bgcj013,bgcj014,bgcj015,bgcj016,bgcj017,bgcj018,",
                "       bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024 ",
                "  FROM bgcj_t ",
                "       LEFT JOIN ooefl_t ON bgcjent=ooeflent AND bgcj007=ooefl001 AND ooefl002='",g_dlang,"'",
                " WHERE bgcjent =  ",g_enterprise,
                "   AND bgcj001 = '",g_bgcj001,"'",
                "   AND bgcj002 = '",g_bgcj002,"'",
                "   AND bgcj003 = '",g_bgcj003,"'",
                "   AND bgcj004 = '",g_bgcj004,"'",
                "   AND bgcj005 = '",g_bgcj005,"'",
                "   AND bgcj006 = '",g_bgcj006,"'"
      IF NOT cl_null(g_bgcj007) THEN
         LET l_sql=l_sql," AND bgcj007 = '",g_bgcj007,"'"
      END IF
      IF NOT cl_null(g_bgcj009) THEN
         LET l_sql=l_sql," AND bgcj009 = '",g_bgcj009,"'"
      END IF
      LET l_sql=l_sql," ORDER BY bgcj007,bgcj009,bgcj049,bgcjseq,",
                      "          bgcj012,bgcj013,bgcj014,bgcj015,bgcj016,bgcj017,bgcj018,",
                      "          bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024 "  
   END IF
   #期别采购预算
   IF g_prog = 'abgt510' OR g_prog = 'abgt520' THEN
      LET l_sql="SELECT DISTINCT bgeg007,ooefl003,bgeg009,bgeg049,bgegseq,",
                "       bgeg012,bgeg013,bgeg014,bgeg015,bgeg016,bgeg017,bgeg018,",
                "       bgeg019,bgeg020,bgeg021,bgeg022,bgeg023,bgeg024 ",
                "  FROM bgeg_t ",
                "       LEFT JOIN ooefl_t ON bgegent=ooeflent AND bgeg007=ooefl001 AND ooefl002='",g_dlang,"'",
                " WHERE bgegent =  ",g_enterprise,
                "   AND bgeg001 = '",g_bgcj001,"'",
                "   AND bgeg002 = '",g_bgcj002,"'",
                "   AND bgeg003 = '",g_bgcj003,"'",
                "   AND bgeg004 = '",g_bgcj004,"'",
                "   AND bgeg005 = '",g_bgcj005,"'",
                "   AND bgeg006 = '",g_bgcj006,"'"
      IF NOT cl_null(g_bgcj007) THEN
         LET l_sql=l_sql," AND bgeg007 = '",g_bgcj007,"'"
      END IF
      IF NOT cl_null(g_bgcj009) THEN
         LET l_sql=l_sql," AND bgeg009 = '",g_bgcj009,"'"
      END IF
      LET l_sql=l_sql," ORDER BY bgeg007,bgeg009,bgeg049,bgegseq,",
                      "          bgeg012,bgeg013,bgeg014,bgeg015,bgeg016,bgeg017,bgeg018,",
                      "          bgeg019,bgeg020,bgeg021,bgeg022,bgeg023,bgeg024 "  
   END IF
   #期别费用预算
   IF g_prog = 'abgt620' OR g_prog = 'abgt630' THEN
      LET l_sql="SELECT DISTINCT bgfb007,ooefl003,bgfb009,'',bgfbseq,",
                "       bgfb012,bgfb013,bgfb014,bgfb015,bgfb016,bgfb017,bgfb018,",
                "       bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024 ",
                "  FROM bgfb_t ",
                "       LEFT JOIN ooefl_t ON bgfbent=ooeflent AND bgfb007=ooefl001 AND ooefl002='",g_dlang,"'",
                " WHERE bgfbent =  ",g_enterprise,
                "   AND bgfb001 = '",g_bgcj001,"'",
                "   AND bgfb002 = '",g_bgcj002,"'",
                "   AND bgfb003 = '",g_bgcj003,"'",
                "   AND bgfb004 = '",g_bgcj004,"'",
                "   AND bgfb005 = '",g_bgcj005,"'",
                "   AND bgfb006 = '",g_bgcj006,"'"
      IF NOT cl_null(g_bgcj007) THEN
         LET l_sql=l_sql," AND bgfb007 = '",g_bgcj007,"'"
      END IF
      IF NOT cl_null(g_bgcj009) THEN
         LET l_sql=l_sql," AND bgfb009 = '",g_bgcj009,"'"
      END IF
      LET l_sql=l_sql," ORDER BY bgfb007,bgfb009,bgfbseq,",
                      "          bgfb012,bgfb013,bgfb014,bgfb015,bgfb016,bgfb017,bgfb018,",
                      "          bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024 "  
   END IF
   
   PREPARE abgt340_02_b_fill2_pr FROM l_sql
   DECLARE abgt340_02_b_fill2_cs CURSOR FOR abgt340_02_b_fill2_pr
   
   LET l_ac2 = 1
   #罗列出预算细项启用核算项，但核算项没有值的项次+预算组织+预算细项+核算项
   FOREACH abgt340_02_b_fill2_cs INTO l_bgcj007,l_bgcj007_desc,l_bgcj009,l_bgcj049,l_bgcjseq,
                                      l_bgcj012,l_bgcj013,l_bgcj014,l_bgcj015,l_bgcj016,l_bgcj017,l_bgcj018,
                                      l_bgcj019,l_bgcj020,l_bgcj021,l_bgcj022,l_bgcj023,l_bgcj024
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF g_prog = 'abgt620' OR g_prog = 'abgt630' THEN
         LET l_bgcj049 = l_bgcj009
      END IF
      
      SELECT bgal005,bgal006,bgal007,bgal008,bgal009,
             bgal010,bgal011,bgal012,bgal013,bgal014,
             bgal025,bgal026,bgal027 
        INTO l_bgal.bgal005,l_bgal.bgal006,l_bgal.bgal007,l_bgal.bgal008,l_bgal.bgal009,
             l_bgal.bgal010,l_bgal.bgal011,l_bgal.bgal012,l_bgal.bgal013,l_bgal.bgal014,
             l_bgal.bgal025,l_bgal.bgal026,l_bgal.bgal027
        FROM bgal_t 
       WHERE bgalent=g_enterprise AND bgal001=g_bgcj002
         AND bgal002=l_bgcj007 AND bgal003=l_bgcj049
      #部门
      IF (l_bgal.bgal005 = 'Y' AND cl_null(l_bgcj013)) OR 
         (l_bgal.bgal005 = 'N' AND l_bgcj013<>' ' ) THEN
         LET g_bgcj2_d[l_ac2].bgcjseq = l_bgcjseq
         LET g_bgcj2_d[l_ac2].bgcj007 = l_bgcj007
         LET g_bgcj2_d[l_ac2].bgcj007_2_desc = l_bgcj007_desc
         LET g_bgcj2_d[l_ac2].bgcj009 = l_bgcj009
         LET g_bgcj2_d[l_ac2].bgcj049 = l_bgcj049
         LET g_bgcj2_d[l_ac2].hsx = '2'
         LET l_ac2 = l_ac2 + 1
      END IF
      #利润成本中心
      IF (l_bgal.bgal006 = 'Y' AND cl_null(l_bgcj014)) OR 
         (l_bgal.bgal006 = 'N' AND l_bgcj014<>' ' ) THEN
         LET g_bgcj2_d[l_ac2].bgcjseq = l_bgcjseq
         LET g_bgcj2_d[l_ac2].bgcj007 = l_bgcj007
         LET g_bgcj2_d[l_ac2].bgcj007_2_desc = l_bgcj007_desc
         LET g_bgcj2_d[l_ac2].bgcj009 = l_bgcj009
         LET g_bgcj2_d[l_ac2].bgcj049 = l_bgcj049
         LET g_bgcj2_d[l_ac2].hsx = '3'
         LET l_ac2 = l_ac2 + 1
      END IF
      #区域
      IF (l_bgal.bgal007 = 'Y' AND cl_null(l_bgcj015)) OR 
         (l_bgal.bgal007 = 'N' AND l_bgcj015<>' ' ) THEN
         LET g_bgcj2_d[l_ac2].bgcjseq = l_bgcjseq
         LET g_bgcj2_d[l_ac2].bgcj007 = l_bgcj007
         LET g_bgcj2_d[l_ac2].bgcj007_2_desc = l_bgcj007_desc
         LET g_bgcj2_d[l_ac2].bgcj009 = l_bgcj009
         LET g_bgcj2_d[l_ac2].bgcj049 = l_bgcj049
         LET g_bgcj2_d[l_ac2].hsx = '4'
         LET l_ac2 = l_ac2 + 1
      END IF
      #收付款客商
      IF (l_bgal.bgal008 = 'Y' AND cl_null(l_bgcj016)) OR 
         (l_bgal.bgal008 = 'N' AND l_bgcj016<>' ' ) THEN
         LET g_bgcj2_d[l_ac2].bgcjseq = l_bgcjseq
         LET g_bgcj2_d[l_ac2].bgcj007 = l_bgcj007
         LET g_bgcj2_d[l_ac2].bgcj007_2_desc = l_bgcj007_desc
         LET g_bgcj2_d[l_ac2].bgcj009 = l_bgcj009
         LET g_bgcj2_d[l_ac2].bgcj049 = l_bgcj049
         LET g_bgcj2_d[l_ac2].hsx = '5'
         LET l_ac2 = l_ac2 + 1
      END IF
      #账款客商
      IF (l_bgal.bgal009 = 'Y' AND cl_null(l_bgcj017)) OR 
         (l_bgal.bgal009 = 'N' AND l_bgcj017<>' ' ) THEN
         LET g_bgcj2_d[l_ac2].bgcjseq = l_bgcjseq
         LET g_bgcj2_d[l_ac2].bgcj007 = l_bgcj007
         LET g_bgcj2_d[l_ac2].bgcj007_2_desc = l_bgcj007_desc
         LET g_bgcj2_d[l_ac2].bgcj009 = l_bgcj009
         LET g_bgcj2_d[l_ac2].bgcj049 = l_bgcj049
         LET g_bgcj2_d[l_ac2].hsx = '6'
         LET l_ac2 = l_ac2 + 1
      END IF
      #客群
      IF (l_bgal.bgal010 = 'Y' AND cl_null(l_bgcj018)) OR 
         (l_bgal.bgal010 = 'N' AND l_bgcj018<>' ' ) THEN
         LET g_bgcj2_d[l_ac2].bgcjseq = l_bgcjseq
         LET g_bgcj2_d[l_ac2].bgcj007 = l_bgcj007
         LET g_bgcj2_d[l_ac2].bgcj007_2_desc = l_bgcj007_desc
         LET g_bgcj2_d[l_ac2].bgcj009 = l_bgcj009
         LET g_bgcj2_d[l_ac2].bgcj049 = l_bgcj049
         LET g_bgcj2_d[l_ac2].hsx = '7'
         LET l_ac2 = l_ac2 + 1
      END IF
      #产品类别
      IF (l_bgal.bgal011 = 'Y' AND cl_null(l_bgcj019)) OR 
         (l_bgal.bgal011 = 'N' AND l_bgcj019<>' ' ) THEN
         LET g_bgcj2_d[l_ac2].bgcjseq = l_bgcjseq
         LET g_bgcj2_d[l_ac2].bgcj007 = l_bgcj007
         LET g_bgcj2_d[l_ac2].bgcj007_2_desc = l_bgcj007_desc
         LET g_bgcj2_d[l_ac2].bgcj009 = l_bgcj009
         LET g_bgcj2_d[l_ac2].bgcj049 = l_bgcj049
         LET g_bgcj2_d[l_ac2].hsx = '8'
         LET l_ac2 = l_ac2 + 1
      END IF
      #经营方式
      IF (l_bgal.bgal025 = 'Y' AND cl_null(l_bgcj022)) OR 
         (l_bgal.bgal025 = 'N' AND l_bgcj022<>' ' ) THEN
         LET g_bgcj2_d[l_ac2].bgcjseq = l_bgcjseq
         LET g_bgcj2_d[l_ac2].bgcj007 = l_bgcj007
         LET g_bgcj2_d[l_ac2].bgcj007_2_desc = l_bgcj007_desc
         LET g_bgcj2_d[l_ac2].bgcj009 = l_bgcj009
         LET g_bgcj2_d[l_ac2].bgcj049 = l_bgcj049
         LET g_bgcj2_d[l_ac2].hsx = '9'
         LET l_ac2 = l_ac2 + 1
      END IF
      #通路
      IF (l_bgal.bgal026 = 'Y' AND cl_null(l_bgcj023)) OR 
         (l_bgal.bgal026 = 'N' AND l_bgcj023<>' ' ) THEN
         LET g_bgcj2_d[l_ac2].bgcjseq = l_bgcjseq
         LET g_bgcj2_d[l_ac2].bgcj007 = l_bgcj007
         LET g_bgcj2_d[l_ac2].bgcj007_2_desc = l_bgcj007_desc
         LET g_bgcj2_d[l_ac2].bgcj009 = l_bgcj009
         LET g_bgcj2_d[l_ac2].bgcj049 = l_bgcj049
         LET g_bgcj2_d[l_ac2].hsx = '10'
         LET l_ac2 = l_ac2 + 1
      END IF
      #品牌
      IF (l_bgal.bgal027 = 'Y' AND cl_null(l_bgcj024)) OR 
         (l_bgal.bgal027 = 'N' AND l_bgcj024<>' ' ) THEN
         LET g_bgcj2_d[l_ac2].bgcjseq = l_bgcjseq
         LET g_bgcj2_d[l_ac2].bgcj007 = l_bgcj007
         LET g_bgcj2_d[l_ac2].bgcj007_2_desc = l_bgcj007_desc
         LET g_bgcj2_d[l_ac2].bgcj009 = l_bgcj009
         LET g_bgcj2_d[l_ac2].bgcj049 = l_bgcj049
         LET g_bgcj2_d[l_ac2].hsx = '11'
         LET l_ac2 = l_ac2 + 1
      END IF
      #人员
      IF (l_bgal.bgal012 = 'Y' AND cl_null(l_bgcj012)) OR 
         (l_bgal.bgal012 = 'N' AND l_bgcj012<>' ' ) THEN
         LET g_bgcj2_d[l_ac2].bgcjseq = l_bgcjseq
         LET g_bgcj2_d[l_ac2].bgcj007 = l_bgcj007
         LET g_bgcj2_d[l_ac2].bgcj007_2_desc = l_bgcj007_desc
         LET g_bgcj2_d[l_ac2].bgcj009 = l_bgcj009
         LET g_bgcj2_d[l_ac2].bgcj049 = l_bgcj049
         LET g_bgcj2_d[l_ac2].hsx = '12'
         LET l_ac2 = l_ac2 + 1
      END IF
      #专案
      IF (l_bgal.bgal013 = 'Y' AND cl_null(l_bgcj020)) OR 
         (l_bgal.bgal013 = 'N' AND l_bgcj020<>' ' ) THEN
         LET g_bgcj2_d[l_ac2].bgcjseq = l_bgcjseq
         LET g_bgcj2_d[l_ac2].bgcj007 = l_bgcj007
         LET g_bgcj2_d[l_ac2].bgcj007_2_desc = l_bgcj007_desc
         LET g_bgcj2_d[l_ac2].bgcj009 = l_bgcj009
         LET g_bgcj2_d[l_ac2].bgcj049 = l_bgcj049
         LET g_bgcj2_d[l_ac2].hsx = '13'
         LET l_ac2 = l_ac2 + 1
      END IF
      #WBS
      IF (l_bgal.bgal014 = 'Y' AND cl_null(l_bgcj021)) OR 
         (l_bgal.bgal014 = 'N' AND l_bgcj021<>' ' ) THEN
         LET g_bgcj2_d[l_ac2].bgcjseq = l_bgcjseq
         LET g_bgcj2_d[l_ac2].bgcj007 = l_bgcj007
         LET g_bgcj2_d[l_ac2].bgcj007_2_desc = l_bgcj007_desc
         LET g_bgcj2_d[l_ac2].bgcj009 = l_bgcj009
         LET g_bgcj2_d[l_ac2].bgcj049 = l_bgcj049
         LET g_bgcj2_d[l_ac2].hsx = '14'
         LET l_ac2 = l_ac2 + 1
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 显示当前光标停留位置
# Memo...........:
# Usage..........: CALL abgt340_02_idx_chk()
# Input parameter: 
# Return code....: 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt340_02_idx_chk()
   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_bgcj_d.getLength() THEN
         LET g_detail_idx = g_bgcj_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_bgcj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgcj_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_bgcj2_d.getLength() THEN
         LET g_detail_idx = g_bgcj2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bgcj2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgcj2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
END FUNCTION

 
{</section>}
 
