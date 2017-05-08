#該程式未解開Section, 採用最新樣板產出!
{<section id="astt340_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-07-09 21:59:12), PR版次:0007(2016-11-16 11:40:45)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000055
#+ Filename...: astt340_01
#+ Description: 結算單批量產生單身元件
#+ Creator....: 06189(2015-07-09 11:32:05)
#+ Modifier...: 06189 -SD/PR- 02481
 
{</section>}
 
{<section id="astt340_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160905-00007#16   2016/09/05   By 02599   SQL条件增加ent
#161111-00028#3    2016/11/16   by 02481   标准程式定义采用宣告模式,弃用.*写法
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
 
#單身 type 宣告
PRIVATE TYPE type_g_stbc_d        RECORD
       stbc001 LIKE stbc_t.stbc001, 
   stbc001_desc LIKE type_t.chr500, 
   sel LIKE type_t.chr500, 
   stbcsite LIKE stbc_t.stbcsite, 
   stbcsite_desc LIKE type_t.chr500, 
   stbc002 LIKE stbc_t.stbc002, 
   stbc003 LIKE stbc_t.stbc003, 
   stbc004 LIKE stbc_t.stbc004, 
   stbc005 LIKE stbc_t.stbc005, 
   stbc008 LIKE stbc_t.stbc008, 
   stbc008_desc LIKE type_t.chr500, 
   stbc012 LIKE stbc_t.stbc012, 
   stbc012_desc LIKE type_t.chr500, 
   stbc018 LIKE stbc_t.stbc018, 
   stbc020 LIKE stbc_t.stbc020, 
   stbc019 LIKE stbc_t.stbc019
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_stbdsite      LIKE stbd_t.stbdsite
DEFINE g_stbdunit      LIKE stbd_t.stbdunit       
DEFINE g_stbd006       LIKE stbd_t.stbd006   
DEFINE g_stbd005       LIKE stbd_t.stbd005 
DEFINE g_stbd001       LIKE stbd_t.stbd001  
DEFINE g_stbd002       LIKE stbd_t.stbd002
DEFINE g_stbd003       LIKE stbd_t.stbd003
DEFINE g_stbddocno     LIKE stbd_t.stbddocno
DEFINE g_curr_diag     ui.Dialog                     #Current Dialog
DEFINE gwin_curr       ui.Window                     #Current Window
DEFINE gfrm_curr       ui.Form                       #Current Form
DEFINE g_error_show    LIKE type_t.num5
DEFINE g_wc            STRING
DEFINE g_wc2           STRING 
DEFINE g_detail_cnt    LIKE type_t.num10
DEFINE g_stbd042       LIKE stbd_t.stbd042         #add by geza 20151120
DEFINE g_stbd048       LIKE stbd_t.stbd048         #add by geza 20151120
#end add-point
 
DEFINE g_stbc_d          DYNAMIC ARRAY OF type_g_stbc_d
DEFINE g_stbc_d_t        type_g_stbc_d
 
 
DEFINE g_stbc001_t   LIKE stbc_t.stbc001    #Key值備份
DEFINE g_stbc004_t      LIKE stbc_t.stbc004    #Key值備份
DEFINE g_stbc005_t      LIKE stbc_t.stbc005    #Key值備份
 
 
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
 
{<section id="astt340_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION astt340_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_stbddocno
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
   DEFINE p_stbddocno      LIKE stbd_t.stbddocno 
   CREATE TEMP TABLE astt340_01_tmp (
        sel LIKE type_t.chr500, 
        stbcsite LIKE stbc_t.stbcsite, 
        stbc001 LIKE stbc_t.stbc001,
        stbc002 LIKE stbc_t.stbc002, 
        stbc003 LIKE stbc_t.stbc003, 
        stbc004 LIKE stbc_t.stbc004,       
        stbc008 LIKE stbc_t.stbc008, 
        stbc012 LIKE stbc_t.stbc012, 
        stbc018 LIKE stbc_t.stbc018, 
        stbc020 LIKE stbc_t.stbc020, 
        stbc019 LIKE stbc_t.stbc019,
        stbc005 LIKE stbc_t.stbc005, 
        stbc013 LIKE stbc_t.stbc013, 
        stbc014 LIKE stbc_t.stbc014, 
        stbc015 LIKE stbc_t.stbc015, 
        stbc016 LIKE stbc_t.stbc016, 
        stbc017 LIKE stbc_t.stbc017, 
        stbc010 LIKE stbc_t.stbc010, 
        stbc011 LIKE stbc_t.stbc011,
        stbc025 LIKE stbc_t.stbc025, 
        stbc026 LIKE stbc_t.stbc026,
        stbc033 LIKE stbc_t.stbc033, 
        stbc034 LIKE stbc_t.stbc034, 
        stbc035 LIKE stbc_t.stbc035, 
        stbc036 LIKE stbc_t.stbc036, 
        stbc037 LIKE stbc_t.stbc037, 
        stbc038 LIKE stbc_t.stbc038, 
        stbc039 LIKE stbc_t.stbc039,
        stbc042 LIKE stbc_t.stbc042, #add by geza 20151120
        stbc045 LIKE stbc_t.stbc045, #add by geza 20151120
        stbc046 LIKE stbc_t.stbc046, #add by geza 20151120
        stbc057 LIKE stbc_t.stbc057 #add by geza 20150915
        );  

   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_astt340_01 WITH FORM cl_ap_formpath("ast","astt340_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('stbc003','6703')
   LET g_stbddocno = p_stbddocno
   SELECT stbdunit,stbdsite,stbd001,stbd002,stbd003,stbd005,stbd006,stbd042,stbd048                  #add by geza 20151120 stbd042,stbd048 含发票否,法人
    INTO g_stbdunit,g_stbdsite,g_stbd001,g_stbd002,g_stbd003,g_stbd005,g_stbd006,g_stbd042,g_stbd048 #add by geza 20151120 g_stbd042,g_stbd048 
    FROM stbd_t
   WHERE stbdent = g_enterprise
     AND stbddocno = g_stbddocno
   CALL cl_set_act_visible("modify,delete,modify_detail,insert,reproduce", FALSE)  
   CALL astt340_01_query()
   DROP TABLE astt340_01_tmp
   CLOSE WINDOW w_astt340_01    
   RETURN
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_stbc_d FROM s_detail1.*
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
            IF g_stbc_d.getLength() = 0  THEN
               EXIT DIALOG
            END IF
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="input.b.page1.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="input.a.page1.sel"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel
            #add-point:ON CHANGE sel name="input.g.page1.sel"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.page1.sel"
            
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
   CLOSE WINDOW w_astt340_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="astt340_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="astt340_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 初始化
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
PRIVATE FUNCTION astt340_init()
   CALL g_stbc_d.clear()
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   LET g_error_show = 1
END FUNCTION

################################################################################
# Descriptions...: 查詢方法
# Memo...........:
# Usage..........: CALL astt340_01_query()
#                  RETURNING 回传参数
# Date & Author..: geza By 20150709
# Modify.........:
################################################################################
PRIVATE FUNCTION astt340_01_query()
DEFINE l_cmd        LIKE type_t.chr1
   CLEAR FORM
   CALL g_stbc_d.clear()

   INITIALIZE g_wc TO NULL

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      
      CONSTRUCT BY NAME g_wc ON stbdsite
         BEFORE CONSTRUCT 
            DISPLAY g_stbdsite TO stbdsite  #By shi 20150710
         #一般欄位開窗相關處理
         #---------------------------<  Master  >---------------------------
         ON ACTION controlp INFIELD stbdsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbdsite',g_stbdsite,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO stbdsite  #顯示到畫面上
            NEXT FIELD stbdsite                     #返回原欄位
            
      END CONSTRUCT
      
      CONSTRUCT BY NAME g_wc2 ON stbc025
         BEFORE CONSTRUCT 

         #一般欄位開窗相關處理
         #---------------------------<  Master  >---------------------------
         ON ACTION controlp INFIELD stbc025
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbc025  #顯示到畫面上
            NEXT FIELD stbc025                        #返回原欄位
            
      END CONSTRUCT
      
      INPUT ARRAY g_stbc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = TRUE)  #By shi 20150710
         
         BEFORE INPUT
            IF g_stbc_d.getLength() = 0  THEN
               NEXT FIELD stbdsite
            END IF
            CALL astt340_01_b_fill()           
            LET g_rec_b = g_stbc_d.getLength()
            DISPLAY "g_rec_b:",g_rec_b
            
         BEFORE ROW
            LET l_ac = ARR_CURR()
                             
            #IF g_detail_cnt >= l_ac    #mark by geza 20151120
            IF g_rec_b >= l_ac          #add by geza 20151120  
               AND g_stbc_d[l_ac].sel IS NOT NULL
               AND g_stbc_d[l_ac].stbcsite IS NOT NULL
            THEN
               LET l_cmd='u'
               LET g_stbc_d_t.* = g_stbc_d[l_ac].*   
            ELSE
               LET l_cmd='a'
            END IF   
            IF l_cmd = 'a' THEN               
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            LET g_stbc_d_t.* = g_stbc_d[l_ac].*  #add by geza 20151120 
            
         AFTER FIELD sel
         
         BEFORE FIELD sel
         
         ON CHANGE sel
            #費用單分開顯示一筆一筆更新，其他單子匯總顯示批量更新   
            IF g_stbc_d[l_ac].stbc003 != '3' THEN
               UPDATE astt340_01_tmp SET sel = g_stbc_d[l_ac].sel WHERE stbc004 = g_stbc_d[l_ac].stbc004                
            ELSE
               UPDATE astt340_01_tmp SET sel = g_stbc_d[l_ac].sel WHERE stbc004 = g_stbc_d[l_ac].stbc004 AND stbc005 = g_stbc_d[l_ac].stbc005 #By shi Mod 20150710
            END IF
            

      END INPUT
      
      ON ACTION check_all
         #單身全選
         CALL astt340_01_check_all() 
      
      ON ACTION check_no_all
         #單身全不選
         CALL astt340_01_check_no_all()
      
      ON ACTION query_data
         #查詢資料
         CALL astt340_01_gen_stbd()      
                  
         
      ON ACTION produce_data
         ##產生結算單單身
         
         IF g_rec_b > 0 THEN                             
             LET g_success = TRUE
             IF NOT astt340_01_gen_detail() THEN
                IF NOT cl_ask_confirm('apm-00284') THEN #產生失敗，是否繼續
                   LET g_success = FALSE                 
                   RETURN
                END IF
             ELSE
                IF cl_ask_confirm('apm-00285') THEN #產生成功，是否繼續
                   CALL g_stbc_d.clear()
                   DELETE FROM astt340_01_tmp
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'Del astt340_01_tmp'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                   END IF
                   CALL astt340_01_query()                               
                ELSE
                   LET INT_FLAG = TRUE 
                   EXIT DIALOG
                END IF
             END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00241'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()      
         END IF
          
      ON ACTION accept
         ##產生結算單單身
         IF g_rec_b > 0 THEN                             
             LET g_success = TRUE
             IF NOT astt340_01_gen_detail() THEN
                IF NOT cl_ask_confirm('apm-00284') THEN #產生失敗，是否繼續
                   LET g_success = FALSE                 
                   RETURN
                END IF
             ELSE
                IF cl_ask_confirm('apm-00285') THEN #產生成功，是否繼續
                   CALL g_stbc_d.clear()
                   DELETE FROM astt340_01_tmp
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'Del astt340_01_tmp'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                   END IF
                   CALL astt340_01_query()                               
                ELSE
                   LET INT_FLAG = TRUE 
                   EXIT DIALOG
                END IF
             END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00241'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()      
         END IF
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
   
   IF INT_FLAG THEN
      RETURN
   END IF
END FUNCTION

################################################################################
# Descriptions...: 按查詢後把資料寫到tmp
# Memo...........:
# Usage..........: CALL astt340_01_gen_stbd()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/07/09 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt340_01_gen_stbd()
DEFINE l_sql             STRING
DEFINE l_where           STRING
DEFINE l_stan030     LIKE stan_t.stan030

   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF g_wc.getIndexOf("stbdsite",1) THEN
      LET g_wc = cl_replace_str(g_wc,"stbdsite","stbcsite")
   END IF
   
   DELETE FROM astt340_01_tmp
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Del astt340_01_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   INITIALIZE l_stan030 TO NULL
   SELECT stan030 INTO l_stan030
     FROM stan_t  
    WHERE stanent = g_enterprise  
      AND stan001 = g_stbd001
   
   LET l_where = " stbcsite IN (SELECT ooed004 FROM ooed_t ",
                 "               WHERE ooedent=",g_enterprise,#160905-00007#16 add
                 "               START WITH ooed005 = '",g_stbdsite,"' AND ooed001='12' AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL) ",
                 "             CONNECT BY  nocycle PRIOR ooed004=ooed005 AND ooed001='12' AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL) ",
#                 "               UNION SELECT ooed004 FROM ooed_t WHERE ooed004 ='",g_stbdsite,"') " #160905-00007#16 mark
                 "               UNION SELECT ooed004 FROM ooed_t WHERE ooedent=",g_enterprise," AND ooed004 ='",g_stbdsite,"') " #160905-00007#16 add


   LET l_sql = "INSERT INTO astt340_01_tmp(sel,       stbcsite,      stbc001,      stbc002,      stbc003,",       
               "                           stbc004,   stbc008,      stbc012, ",
               "                           stbc018,   stbc020,       stbc019,      stbc005,  ",
               "                           stbc013,   stbc014,       stbc015,      stbc016,  ",
               "                           stbc017,   stbc010,       stbc011,      stbc025,  ",
               "                           stbc026,   stbc033,       stbc034,      stbc035,  ",
               "                           stbc036,   stbc037,       stbc038,      stbc039,  ", 
               "                           stbc042,   stbc045,       stbc046,      stbc057 ) ", #add by geza 20150915 stbc057
               "SELECT DISTINCT            'Y',       stbcsite,      stbc001,      stbc002,      stbc003,",       
               "                           stbc004,   stbc008,      stbc012, ",
               "                           stbc018,   stbc020,       stbc019,      stbc005,  ",
               "                           stbc013,   stbc014,       stbc015,      stbc016, ",
               "                           stbc017,   stbc010,       stbc011,      stbc025,  ",
               "                           stbc026,   stbc033,       stbc034,      stbc035,  ",
               "                           stbc036,   stbc037,       stbc038,      stbc039,  ",
               "                           stbc042,   stbc045,       stbc046,      stbc057  ",  #add by geza 20150915 stbc057
               #mark by geza 20151120(S)
#               "  FROM stbc_t",
#               " WHERE stbcent =",g_enterprise,
#               "   AND stbc001 ='",g_stbdunit,"'",
#               "   AND ",l_where,  
#               "   AND stbc008 ='",g_stbd002,"'",
#               "   AND stbc009 ='",g_stbd003,"'",
#               "   AND (stbcstus ='1' OR stbcstus ='3')",
#               #"   AND stbc002 <='",g_stbd006,"'",                             #By shi 20150710
#               "   AND (stbc040 BETWEEN '",g_stbd005,"' AND '",g_stbd006,"') ", #By shi 20150710
#               "   AND stbc037 = 'Y' ",  #By shi Add 20150710
#               "   AND (stbc003 ='1' OR stbc003='2' OR stbc003='3' OR stbc003 = '8'  OR stbc003 = '9' OR stbc003 = '10' OR stbc003 = '11' )", #add by geza 20150714 加类型11 供应商往来调整
#               "   AND ",g_wc,
#               "   AND ",g_wc2
               #mark by geza 20151120(E)
               #add by geza 20151120(S)
               #天和回追产品
               "  FROM stbc_t,ooef_t",    
               " WHERE stbcent =",g_enterprise,
               "   AND stbc001 ='",g_stbdunit,"'",
               "   AND stbcent = ooefent ",           
               "   AND stbcsite = ooef001 ",          
               "   AND ooef017 = '",g_stbd048,"'",  
               "   AND ",l_where,  
               "   AND stbc008 ='",g_stbd002,"'",
               "   AND stbc009 ='",g_stbd003,"'",
               "   AND (stbcstus ='1' OR stbcstus ='3')",
               "   AND (stbc040 BETWEEN '",g_stbd005,"' AND '",g_stbd006,"') ", 
               "   AND stbc058 ='",g_stbd042,"'",
               #"   AND (stbc003 ='1' OR stbc003='2' OR stbc003='3' OR stbc003 = '8'  OR stbc003 = '9' OR stbc003 = '10' OR stbc003 = 'A' OR stbc003 = 'B' OR stbc003 = '11' OR stbc003 = '12' )",#By shi 20150710  add by geza 20150714 加类型11 供应商往来调整  加类型12 供应商领用单  #mark by geza 20160530
               "   AND (stbc003 ='1' OR stbc003='2' OR stbc003='3' OR stbc003='4' OR stbc003='5' OR stbc003 = '8'  OR stbc003 = '9' OR stbc003 = '10' OR stbc003 = 'A' OR stbc003 = 'B' OR stbc003 = '11' OR stbc003 = '12' )",#  add by geza 20160530 加类型4和5，销售销退  
               "   AND ",g_wc,
               "   AND ",g_wc2               #add by geza 20150610   
               #add by geza 20151120(E)
   #是否启用交款汇总单,为N生成交款明细，为Y不生成
   IF cl_get_para(g_enterprise,g_stbdsite,"S-CIR-2012") = 'Y' THEN
      LET l_sql = l_sql,"   AND stbc037 = 'Y' " 
   END IF   
   IF NOT cl_null(l_stan030) THEN
      LET l_sql = l_sql,"   AND (stbc030 ='",g_stbd001,"' OR stbc030 = '",l_stan030,"')"
   ELSE
      LET l_sql = l_sql,"   AND (stbc030 ='",g_stbd001,"')"
   END IF

   LET l_sql = l_sql ," ORDER BY stbc003,stbc004,stbc005  "

   PREPARE astt340_01_ins_tmp FROM l_sql
   EXECUTE astt340_01_ins_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Ins astt340_01_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
 
   
   CALL astt340_01_b_fill()
   
   LET g_rec_b = g_stbc_d.getLength()
   IF g_rec_b = 0 THEN
      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'apm-00294'   #160318-00005#44  mark
      LET g_errparam.code = 'sub-01321'   #160318-00005#44  add
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 畫面顯示
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150709 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt340_01_b_fill()
DEFINE l_sql          STRING

    CALL g_stbc_d.clear()
    LET l_ac = 1
 
    LET l_sql = "SELECT sel,         stbcsite,     t1.ooefl003,   ",
                "       stbc002,     stbc003,      stbc004, stbc005,  ",
                "       stbc008,     t2.pmaal004,      ",          #rtdx002
                "       stbc012,     t3.stael003,     stbc018, ",  
                "       stbc020,     stbc019 ",  
                "  FROM astt340_01_tmp ",
                "  LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = ",g_enterprise,
                "                            AND t1.ooefl001 = stbcsite",
                "                            AND t1.ooefl002 = '",g_dlang,"'",
                "  LEFT OUTER JOIN pmaal_t t2 ON t2.pmaalent = ",g_enterprise,
                "                            AND t2.pmaal001 = stbc008",
                "                            AND t2.pmaal002 = '",g_dlang,"'",
                "  LEFT OUTER JOIN stael_t t3 ON t3.staelent = ",g_enterprise,
                "                            AND t3.stael001 = stbc012",
                "                            AND t3.stael002 = '",g_dlang,"'",
                " WHERE stbc003 = '3'",
                " UNION ALL ",
                " (SELECT sel,        stbcsite,     t1.ooefl003,   ",
                "       stbc002,     stbc003,      stbc004,  0 AS stbc005, ",
                "       stbc008,     t2.pmaal004,      ",          #rtdx002
                "       stbc012,     t3.stael003,     SUM(stbc018), ",  
                "       SUM(stbc020),     SUM(stbc019) ",  
                "  FROM astt340_01_tmp ",
                "  LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = ",g_enterprise,
                "                            AND t1.ooefl001 = stbcsite",
                "                            AND t1.ooefl002 = '",g_dlang,"'",
                "  LEFT OUTER JOIN pmaal_t t2 ON t2.pmaalent = ",g_enterprise,
                "                            AND t2.pmaal001 = stbc008",
                "                            AND t2.pmaal002 = '",g_dlang,"'",
                "  LEFT OUTER JOIN stael_t t3 ON t3.staelent = ",g_enterprise,
                "                            AND t3.stael001 = stbc012",
                "                            AND t3.stael002 = '",g_dlang,"'",
                " WHERE stbc003 != '3'",
                "  GROUP BY sel,stbcsite,t1.ooefl003,stbc002,stbc003,stbc004,stbc005,stbc008,t2.pmaal004,stbc012,t3.stael003) "
        #        "  ORDER BY stbcsite,stbc002,stbc003,stbc004 "
    PREPARE astt340_01_stbc_pb FROM l_sql
    DECLARE astt340_01_stbc_cs CURSOR FOR astt340_01_stbc_pb
    FOREACH astt340_01_stbc_cs
       INTO g_stbc_d[l_ac].sel,                  g_stbc_d[l_ac].stbcsite,            g_stbc_d[l_ac].stbcsite_desc,                   
            g_stbc_d[l_ac].stbc002,              g_stbc_d[l_ac].stbc003,             g_stbc_d[l_ac].stbc004,  
            g_stbc_d[l_ac].stbc005,              g_stbc_d[l_ac].stbc008,              g_stbc_d[l_ac].stbc008_desc,    
            g_stbc_d[l_ac].stbc012,              g_stbc_d[l_ac].stbc012_desc,             g_stbc_d[l_ac].stbc018, 
            g_stbc_d[l_ac].stbc020,              g_stbc_d[l_ac].stbc019
                        
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "Foreach astt340_01_stbc_cs"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
       END IF
             
       LET l_ac = l_ac + 1
       IF l_ac > g_max_rec AND g_error_show = 1 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code =  9035
          LET g_errparam.extend =  ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
       END IF
    END FOREACH
    
    CALL g_stbc_d.deleteElement(g_stbc_d.getLength()) 
    LET l_ac = g_stbc_d.getLength() 
    LET g_rec_b = g_stbc_d.getLength() #By shi 20150710    
END FUNCTION

################################################################################
# Descriptions...: 產生結算單明細資料
# Memo...........:
# Usage..........: CALL astt340_01_gen_detail()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/07/09 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt340_01_gen_detail()
DEFINE l_sql     STRING
DEFINE l_stbc            RECORD 
        stbcsite LIKE stbc_t.stbcsite,
        stbc001 LIKE stbc_t.stbc001,          
        stbc002 LIKE stbc_t.stbc002, 
        stbc003 LIKE stbc_t.stbc003, 
        stbc004 LIKE stbc_t.stbc004, 
        stbc008 LIKE stbc_t.stbc008, 
        stbc012 LIKE stbc_t.stbc012, 
        stbc018 LIKE stbc_t.stbc018, 
        stbc020 LIKE stbc_t.stbc020, 
        stbc019 LIKE stbc_t.stbc019,
        stbc005 LIKE stbc_t.stbc005, 
        stbc013 LIKE stbc_t.stbc013, 
        stbc014 LIKE stbc_t.stbc014, 
        stbc015 LIKE stbc_t.stbc015, 
        stbc016 LIKE stbc_t.stbc016, 
        stbc017 LIKE stbc_t.stbc017, 
        stbc010 LIKE stbc_t.stbc010, 
        stbc011 LIKE stbc_t.stbc011,
        stbc025 LIKE stbc_t.stbc025, 
        stbc026 LIKE stbc_t.stbc026,
        stbc033 LIKE stbc_t.stbc033, 
        stbc034 LIKE stbc_t.stbc034, 
        stbc035 LIKE stbc_t.stbc035, 
        stbc036 LIKE stbc_t.stbc036, 
        stbc037 LIKE stbc_t.stbc037, 
        stbc038 LIKE stbc_t.stbc038, 
        stbc039 LIKE stbc_t.stbc039,
        stbc042 LIKE stbc_t.stbc042,  #add by geza 20151120
        stbc045 LIKE stbc_t.stbc045,  #add by geza 20151120
        stbc046 LIKE stbc_t.stbc046,  #add by geza 20151120
        stbc057 LIKE stbc_t.stbc057   #add by geza 20150915
                         END RECORD
#161111-00028#3--modify---begin----------                         
#DEFINE l_stbe RECORD LIKE stbe_t.*
#DEFINE l_stev      RECORD LIKE stev_t.*  #add by geza 20151120
DEFINE l_stbe RECORD  #結算單明細資料
       stbeent LIKE stbe_t.stbeent, #企業編號
       stbesite LIKE stbe_t.stbesite, #營運據點
       stbecomp LIKE stbe_t.stbecomp, #所屬法人
       stbedocno LIKE stbe_t.stbedocno, #單據編號
       stbeseq LIKE stbe_t.stbeseq, #單據項次
       stbe001 LIKE stbe_t.stbe001, #來源類別
       stbe002 LIKE stbe_t.stbe002, #來源單據
       stbe003 LIKE stbe_t.stbe003, #來源項次
       stbe004 LIKE stbe_t.stbe004, #來源日期
       stbe005 LIKE stbe_t.stbe005, #費用編號
       stbe006 LIKE stbe_t.stbe006, #起始日期
       stbe007 LIKE stbe_t.stbe007, #截止日期
       stbe008 LIKE stbe_t.stbe008, #幣別
       stbe009 LIKE stbe_t.stbe009, #稅別
       stbe010 LIKE stbe_t.stbe010, #價款類別
       stbe011 LIKE stbe_t.stbe011, #方向
       stbe012 LIKE stbe_t.stbe012, #價外金額
       stbe013 LIKE stbe_t.stbe013, #價內金額
       stbe014 LIKE stbe_t.stbe014, #未結算金額
       stbe015 LIKE stbe_t.stbe015, #已結算金額
       stbe016 LIKE stbe_t.stbe016, #本次結算金額
       stbe017 LIKE stbe_t.stbe017, #結算方式
       stbe018 LIKE stbe_t.stbe018, #結算類型
       stbe019 LIKE stbe_t.stbe019, #所屬品類
       stbe020 LIKE stbe_t.stbe020, #所屬部門
       stbe021 LIKE stbe_t.stbe021, #主帳套帳款金額
       stbe022 LIKE stbe_t.stbe022, #次帳套一帳款金額
       stbe023 LIKE stbe_t.stbe023, #次帳套二帳款金額
       stbe024 LIKE stbe_t.stbe024, #納入結算單否
       stbe025 LIKE stbe_t.stbe025, #票扣否
       stbe026 LIKE stbe_t.stbe026, #數量
       stbe027 LIKE stbe_t.stbe027, #單價
       stbe028 LIKE stbe_t.stbe028, #专柜编号
       stbe029 LIKE stbe_t.stbe029, #no use
       stbe030 LIKE stbe_t.stbe030, #no use
       stbe031 LIKE stbe_t.stbe031, #結算扣率
       stbe032 LIKE stbe_t.stbe032, #備註
       stbe033 LIKE stbe_t.stbe033, #日結成本類型
       stbe034 LIKE stbe_t.stbe034, #銷售金額
       stbe035 LIKE stbe_t.stbe035, #費用歸屬類型
       stbe036 LIKE stbe_t.stbe036, #費用歸屬組織
       stbe037 LIKE stbe_t.stbe037, #應收結算金額
       stbe038 LIKE stbe_t.stbe038, #帳套二應收結算金額
       stbe039 LIKE stbe_t.stbe039, #帳套三應收結算金額
       stbe040 LIKE stbe_t.stbe040  #收入立帳否
       END RECORD
DEFINE l_stev RECORD  #交款彙總明細資料
       stevent LIKE stev_t.stevent, #企業編號
       stevsite LIKE stev_t.stevsite, #所屬組織
       stevcomp LIKE stev_t.stevcomp, #所屬法人
       stevdocno LIKE stev_t.stevdocno, #單據編號
       stevseq LIKE stev_t.stevseq, #單據項次
       stev001 LIKE stev_t.stev001, #來源類型
       stev002 LIKE stev_t.stev002, #來源單據
       stev003 LIKE stev_t.stev003, #來源項次
       stev004 LIKE stev_t.stev004, #來源日期
       stev005 LIKE stev_t.stev005, #費用編號
       stev006 LIKE stev_t.stev006, #起始日期
       stev007 LIKE stev_t.stev007, #截止日期
       stev008 LIKE stev_t.stev008, #幣別
       stev009 LIKE stev_t.stev009, #稅別
       stev010 LIKE stev_t.stev010, #價款類型
       stev011 LIKE stev_t.stev011, #方向
       stev012 LIKE stev_t.stev012, #價外金額
       stev013 LIKE stev_t.stev013, #價內金額
       stev014 LIKE stev_t.stev014, #未結算金額
       stev015 LIKE stev_t.stev015, #已結算金額
       stev016 LIKE stev_t.stev016, #本次結算金額
       stev017 LIKE stev_t.stev017, #結算方式
       stev018 LIKE stev_t.stev018, #結算類型
       stev019 LIKE stev_t.stev019, #所屬品類
       stev020 LIKE stev_t.stev020, #所屬部門
       stev021 LIKE stev_t.stev021, #主帳套帳款金額
       stev022 LIKE stev_t.stev022, #次帳套一帳款金額
       stev023 LIKE stev_t.stev023, #次帳套二帳款金額
       stev024 LIKE stev_t.stev024, #專櫃編號
       stev025 LIKE stev_t.stev025, #已交款金額
       stev026 LIKE stev_t.stev026, #納入結算單否
       stev027 LIKE stev_t.stev027, #票扣否
       stev028 LIKE stev_t.stev028, #數量
       stev029 LIKE stev_t.stev029, #單價
       stev030 LIKE stev_t.stev030, #備註
       stev031 LIKE stev_t.stev031, #費用歸屬類型
       stev032 LIKE stev_t.stev032  #費用歸屬組織
       END RECORD
#161111-00028#3--modify---end------------
DEFINE r_success   LIKE type_t.num5
   LET r_success = TRUE
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
  
   INITIALIZE l_stbc.* TO NULL
   LET l_sql = " SELECT    stbcsite,  stbc001,       stbc002,      stbc003,",       
               "           stbc004,   stbc008,       stbc012, ",
               "           stbc018,   stbc020,       stbc019,      stbc005,  ",
               "           stbc013,   stbc014,       stbc015,      stbc016,  ",
               "           stbc017,   stbc010,       stbc011,      stbc025,  ",
               "           stbc026,   stbc033,       stbc034,      stbc035,  ",
               "           stbc036,   stbc037,       stbc038,      stbc039,  ",
               "           stbc042 ,  stbc045,       stbc046,      stbc057   ", #add by geza 20150915 stbc057
               "   FROM astt340_01_tmp ",
               "  WHERE sel='Y' ",
               "    AND stbc037 = 'Y' ",  #add by geza 20151120
               "  ORDER BY  stbc003,stbc004,stbc005"
   PREPARE astt340_01_ins_pre FROM l_sql
   DECLARE astt340_01_ins_cs CURSOR FOR astt340_01_ins_pre
   FOREACH astt340_01_ins_cs
      INTO l_stbc.stbcsite,      l_stbc.stbc001,       l_stbc.stbc002,      l_stbc.stbc003,      l_stbc.stbc004,       
           l_stbc.stbc008,       l_stbc.stbc012,       l_stbc.stbc018,      l_stbc.stbc020,
           l_stbc.stbc019,       l_stbc.stbc005,       l_stbc.stbc013,      l_stbc.stbc014,
           l_stbc.stbc015,       l_stbc.stbc016,       l_stbc.stbc017,      l_stbc.stbc010,
           l_stbc.stbc011,       l_stbc.stbc025,       l_stbc.stbc026,      l_stbc.stbc033,
           l_stbc.stbc034,       l_stbc.stbc035,       l_stbc.stbc036,      l_stbc.stbc037,
           l_stbc.stbc038,       l_stbc.stbc039,       l_stbc.stbc042,      l_stbc.stbc045,
           l_stbc.stbc046,       l_stbc.stbc057        #add by geza 20150915 stbc057
   
   
   INITIALIZE l_stbe.* TO NULL
   LET l_stbe.stbeent=g_enterprise
   LET l_stbe.stbesite=l_stbc.stbcsite
#   SELECT ooef017 INTO l_stbe.stbecomp
#     FROM ooef_t
#    WHERE ooefent = g_enterprise
#      AND ooef001 = g_stbdsite
   LET l_stbe.stbecomp=g_stbd048
   LET l_stbe.stbedocno=g_stbddocno
         
   SELECT MAX(stbeseq)+1 INTO l_stbe.stbeseq
     FROM stbe_t
    WHERE stbeent=g_enterprise
      AND stbedocno=g_stbddocno
   IF cl_null(l_stbe.stbeseq) THEN
      LET l_stbe.stbeseq=1
   END IF               
  
   LET l_stbe.stbe001=l_stbc.stbc003
   LET l_stbe.stbe002=l_stbc.stbc004
   LET l_stbe.stbe003=l_stbc.stbc005
   LET l_stbe.stbe004=l_stbc.stbc002
   LET l_stbe.stbe005=l_stbc.stbc012
   LET l_stbe.stbe006=l_stbc.stbc045
   LET l_stbe.stbe007=l_stbc.stbc046
   LET l_stbe.stbe008=l_stbc.stbc013
   LET l_stbe.stbe009=l_stbc.stbc014
   LET l_stbe.stbe010=l_stbc.stbc015
   LET l_stbe.stbe011=l_stbc.stbc016
   LET l_stbe.stbe012=l_stbc.stbc017
   LET l_stbe.stbe013=l_stbc.stbc018
   LET l_stbe.stbe014=l_stbc.stbc019
   LET l_stbe.stbe015=l_stbc.stbc020
   LET l_stbe.stbe016=l_stbc.stbc019
   LET l_stbe.stbe017=l_stbc.stbc010
   LET l_stbe.stbe018=l_stbc.stbc011
   LET l_stbe.stbe019=l_stbc.stbc025
   LET l_stbe.stbe020=l_stbc.stbc026
   LET l_stbe.stbe021='0'   #add  by geza 20150604
   LET l_stbe.stbe022='0'   #add  by geza 20150604  
   LET l_stbe.stbe023='0'   #add  by geza 20150604
   LET l_stbe.stbe028=l_stbc.stbc033   #add  by geza 20150604
   #本次結算數量=底稿中的數量-已立帳數量，單價=底稿中單價---huangrh add 20150604---
   #LET l_stbe.stbe026=l_stbc.stbc034-l_stbc.stbc035
   #本次結算數量=底稿中的數量-已结算數量
   IF l_stbc.stbc057 IS NULL THEN
      LET l_stbc.stbc057 = 0
   END IF
   LET l_stbe.stbe026=l_stbc.stbc034-l_stbc.stbc057   #add by geza 20150915
   LET l_stbe.stbe027=l_stbc.stbc036
   #本次結算單納入結算單否，票扣否---geza add 20150609---
   LET l_stbe.stbe024=l_stbc.stbc037
   LET l_stbe.stbe025=l_stbc.stbc038
   LET l_stbe.stbe031=l_stbc.stbc039  #结算扣率---geza add 20150706---
   #来源类型是费用单的，从费用单抓取备注
   IF l_stbc.stbc003='3' THEN  
      SELECT stbb017 INTO l_stbe.stbe032
        FROM stbb_t 
       WHERE stbbent = g_enterprise
         AND stbbdocno = l_stbc.stbc004
         AND stbbseq = l_stbc.stbc005
   END IF
   
  #INSERT INTO stbe_t VALUES (l_stbe.*)   ##161111-00028#3-mark
  #161111-00028#3--add---begin------
   INSERT INTO stbe_t (stbeent,stbesite,stbecomp,stbedocno,stbeseq,stbe001,stbe002,stbe003,stbe004,stbe005,stbe006,
                       stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,stbe013,stbe014,stbe015,stbe016,stbe017,
                       stbe018,stbe019,stbe020,stbe021,stbe022,stbe023,stbe024,stbe025,stbe026,stbe027,stbe028,
                       stbe029,stbe030,stbe031,stbe032,stbe033,stbe034,stbe035,stbe036,stbe037,stbe038,stbe039,stbe040)
    VALUES (l_stbe.stbeent,l_stbe.stbesite,l_stbe.stbecomp,l_stbe.stbedocno,l_stbe.stbeseq,l_stbe.stbe001,l_stbe.stbe002,l_stbe.stbe003,l_stbe.stbe004,l_stbe.stbe005,l_stbe.stbe006,
            l_stbe.stbe007,l_stbe.stbe008,l_stbe.stbe009,l_stbe.stbe010,l_stbe.stbe011,l_stbe.stbe012,l_stbe.stbe013,l_stbe.stbe014,l_stbe.stbe015,l_stbe.stbe016,l_stbe.stbe017,
            l_stbe.stbe018,l_stbe.stbe019,l_stbe.stbe020,l_stbe.stbe021,l_stbe.stbe022,l_stbe.stbe023,l_stbe.stbe024,l_stbe.stbe025,l_stbe.stbe026,l_stbe.stbe027,l_stbe.stbe028,
            l_stbe.stbe029,l_stbe.stbe030,l_stbe.stbe031,l_stbe.stbe032,l_stbe.stbe033,l_stbe.stbe034,l_stbe.stbe035,l_stbe.stbe036,l_stbe.stbe037,l_stbe.stbe038,l_stbe.stbe039,l_stbe.stbe040)
  #161111-00028#3--add---end--------
        
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins stbe_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      EXIT FOREACH
   END IF
   
   UPDATE stbc_t SET stbcstus='2'
     WHERE stbcent=g_enterprise
      #AND stbc001=l_stbc.stbc001 #By shi Mark 20150710
       AND stbc004=l_stbc.stbc004
       AND stbc005=l_stbc.stbc005   
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "update stbc_t"
       LET g_errparam.popup = TRUE
       CALL cl_err()
  
       LET r_success=FALSE
       RETURN r_success    
    END IF       
   
   END FOREACH
   
   #add by geza 20151120(S)
   #是否启用交款汇总单为N,生成结算单交款明细
   IF cl_get_para(g_enterprise,g_stbdsite,"S-CIR-2012") = 'N' THEN
            
      #交款汇总单的只抓 费用单且纳入结算单否=N   
      LET l_sql = " SELECT    stbcsite,  stbc001,       stbc002,      stbc003,",       
                  "           stbc004,   stbc008,       stbc012, ",
                  "           stbc018,   stbc020,       stbc019,      stbc005,  ",
                  "           stbc013,   stbc014,       stbc015,      stbc016,  ",
                  "           stbc017,   stbc010,       stbc011,      stbc025,  ",
                  "           stbc026,   stbc033,       stbc034,      stbc035,  ",
                  "           stbc036,   stbc037,       stbc038,      stbc039,  ",
                  "           stbc042 ,  stbc045,       stbc046,      stbc057   ", 
                  "   FROM astt340_01_tmp ",
                  "  WHERE sel='Y' ",
                  "    AND stbc037 = 'N' ",  #add by geza 20151120
               "  ORDER BY  stbc003,stbc004,stbc005"
      PREPARE astt340_01_insert_stev_pb FROM l_sql
      DECLARE astt340_01_insert_stev_cs CURSOR FOR astt340_01_insert_stev_pb
          
      
      INITIALIZE l_stbc.* TO NULL
      
      FOREACH astt340_01_insert_stev_cs 
         INTO l_stbc.stbcsite,      l_stbc.stbc001,       l_stbc.stbc002,      l_stbc.stbc003,      l_stbc.stbc004,       
              l_stbc.stbc008,       l_stbc.stbc012,       l_stbc.stbc018,      l_stbc.stbc020,
              l_stbc.stbc019,       l_stbc.stbc005,       l_stbc.stbc013,      l_stbc.stbc014,
              l_stbc.stbc015,       l_stbc.stbc016,       l_stbc.stbc017,      l_stbc.stbc010,
              l_stbc.stbc011,       l_stbc.stbc025,       l_stbc.stbc026,      l_stbc.stbc033,
              l_stbc.stbc034,       l_stbc.stbc035,       l_stbc.stbc036,      l_stbc.stbc037,
              l_stbc.stbc038,       l_stbc.stbc039,       l_stbc.stbc042,      l_stbc.stbc045,
              l_stbc.stbc046,       l_stbc.stbc057        #add by geza 20150915 stbc057   
         INITIALIZE l_stev.* TO NULL
         LET l_stev.stevent=g_enterprise
         LET l_stev.stevsite=l_stbc.stbcsite--
         LET l_stev.stevcomp=g_stbd048 
         LET l_stev.stevdocno=g_stbddocno              
         SELECT MAX(stevseq)+1 INTO l_stev.stevseq
           FROM stev_t
          WHERE stevent=g_enterprise
            AND stevdocno=g_stbddocno
         IF cl_null(l_stev.stevseq) THEN
            LET l_stev.stevseq=1
         END IF               
         LET l_stev.stev001=l_stbc.stbc003
         LET l_stev.stev002=l_stbc.stbc004
         LET l_stev.stev003=l_stbc.stbc005
         LET l_stev.stev004=l_stbc.stbc002
         LET l_stev.stev005=l_stbc.stbc012
         #生成交款汇总单的时候，交款汇总单的单身日期区间自动带底稿的值   
         LET l_stev.stev006=l_stbc.stbc045  
         LET l_stev.stev007=l_stbc.stbc046     
         LET l_stev.stev008=l_stbc.stbc013
         LET l_stev.stev009=l_stbc.stbc014
         LET l_stev.stev010=l_stbc.stbc015
         LET l_stev.stev011=l_stbc.stbc016
         LET l_stev.stev012=l_stbc.stbc017
         LET l_stev.stev013=l_stbc.stbc018
         LET l_stev.stev014=l_stbc.stbc019
         LET l_stev.stev015=l_stbc.stbc020
         LET l_stev.stev016=l_stbc.stbc019
         LET l_stev.stev017=l_stbc.stbc010
         LET l_stev.stev018=l_stbc.stbc011
         LET l_stev.stev019=l_stbc.stbc025
         LET l_stev.stev020=l_stbc.stbc026
         LET l_stev.stev021='0' #add  by geza 20150604
         LET l_stev.stev022='0' #add  by geza 20150604
         LET l_stev.stev023='0' #add  by geza 20150604
         LET l_stev.stev025='0'        
         LET l_stev.stev024=l_stbc.stbc033      
         LET l_stev.stev026=l_stbc.stbc037
         LET l_stev.stev027=l_stbc.stbc038
         #本次結算數量=底稿中的數量-已结算數量
         IF l_stbc.stbc057 IS NULL THEN
            LET l_stbc.stbc057 = 0
         END IF
         LET l_stev.stev028= l_stbc.stbc034-l_stbc.stbc057   
         LET l_stev.stev029=l_stbc.stbc036
         
         #add by geza 20150904(S)
         #来源类型是费用单的，从费用单抓取备注
         IF l_stbc.stbc003='3' THEN  
            SELECT stbb017 INTO l_stev.stev030
              FROM stbb_t 
             WHERE stbbent = g_enterprise
               AND stbbdocno = l_stbc.stbc004
               AND stbbseq = l_stbc.stbc005
         END IF
      
        #INSERT INTO stev_t VALUES (l_stev.*)     #161111-00028#3--mark
        #161111-00028#3--add--begin----
         INSERT INTO stev_t (stevent,stevsite,stevcomp,stevdocno,stevseq,stev001,stev002,stev003,stev004,
                             stev005,stev006,stev007,stev008,stev009,stev010,stev011,stev012,stev013,
                             stev014,stev015,stev016,stev017,stev018,stev019,stev020,stev021,stev022,
                             stev023,stev024,stev025,stev026,stev027,stev028,stev029,stev030,stev031,stev032)
          VALUES (l_stev.stevent,l_stev.stevsite,l_stev.stevcomp,l_stev.stevdocno,l_stev.stevseq,l_stev.stev001,l_stev.stev002,l_stev.stev003,l_stev.stev004,
                  l_stev.stev005,l_stev.stev006,l_stev.stev007,l_stev.stev008,l_stev.stev009,l_stev.stev010,l_stev.stev011,l_stev.stev012,l_stev.stev013,
                  l_stev.stev014,l_stev.stev015,l_stev.stev016,l_stev.stev017,l_stev.stev018,l_stev.stev019,l_stev.stev020,l_stev.stev021,l_stev.stev022,
                  l_stev.stev023,l_stev.stev024,l_stev.stev025,l_stev.stev026,l_stev.stev027,l_stev.stev028,l_stev.stev029,l_stev.stev030,l_stev.stev031,l_stev.stev032)
        #161111-00028#3--add--end------
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "into stev_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            LET r_success=FALSE
            RETURN r_success    
         END IF
         
         UPDATE stbc_t SET stbcstus='2'
          WHERE stbcent=g_enterprise
            AND stbc004=l_stbc.stbc004
            AND stbc005=l_stbc.stbc005   
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "update stbc_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            LET r_success=FALSE
            RETURN r_success    
         END IF
      END FOREACH
     FREE astt340_01_insert_stev_cs
   END IF   
   #add by geza 20151120(E)
   
   IF r_success THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF
   CALL cl_err_collect_show()
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 全选
# Memo...........:
# Usage..........: CALL astt340_01_check_all()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150710 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt340_01_check_all()
   UPDATE astt340_01_tmp SET sel = 'Y'  
   CALL astt340_01_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 全不选
# Memo...........:
# Usage..........: CALL astt340_01_check_no_all()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20150710 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt340_01_check_no_all()
   UPDATE astt340_01_tmp SET sel = 'N'    
   CALL astt340_01_b_fill()
END FUNCTION

 
{</section>}
 
