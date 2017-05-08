#該程式已解開Section, 不再透過樣板產出!
{<section id="asrp370_01.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000014
#+ 
#+ Filename...: asrp370_01
#+ Description: 重複性生產調撥產生作業——擬調撥生產計劃挑選
#+ Creator....: 00768(2014-11-11 16:12:15)
#+ Modifier...: 00768(2014-11-12 17:32:03) -SD/PR- 01996
#+ Buildtype..: 應用 c03c 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="asrp370_01.global" >}
#150105 单位转换率改写
#160318-00025#22   2016/04/21 BY 07900     校验代码重复错误讯息的修改
#160406-00004#1    2016/04/26 By xianghui  BOM组成用量抓取调整 
#160512-00016#14   2016/05/27 By ming      s_asft300_02_bom增加參數 
#160512-00016#25   2016/05/31 By 02295     保税否栏位給值'N'
#160727-00019#19   2016/08/04 By 08734     临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01,asrp370_01_temp2 ——> asrp370_tmp02,p370_01_lock_b_t ——> asrp370_tmp03
#160706-00037#11   2016/10/26 By shiun     引導式作業調整的作法
#161124-00048#21  2016/12/13  By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔
GLOBALS "../../asr/4gl/asrp370.inc"
#end add-point
 
DEFINE g_rec_b            LIKE type_t.num5   
DEFINE g_wc_m             STRING
DEFINE g_wc               STRING 
DEFINE g_ref_fields       DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields       DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE l_ac                  LIKE type_t.num5
DEFINE g_master_idx          LIKE type_t.num5
DEFINE g_rec_b2           LIKE type_t.num5 
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point       
 
{</section>}
 
{<section id="asrp370_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION asrp370_01(--)
   #add-point:construct段變數傳入

   #end add-point
   )
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:construct段define

   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_asrp370_01 WITH FORM cl_ap_formpath("asr","asrp370_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單頭前置處理

   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc_m ON sraa001 
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理

            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理

            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      ##輸入開始
      #CONSTRUCT g_wc ON  
      #     FROM  
         
         #自訂ACTION
         #add-point:自訂ACTION

         #end add-point
         
      #   BEFORE CONSTRUCT
            #add-point:單頭輸入前處理

            #end add-point
            
      #   AFTER CONSTRUCT
            #add-point:單頭輸入後處理

            #end add-point
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
           
            
      #END CONSTRUCT
      
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
 
   #add-point:畫面關閉前

   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_asrp370_01 
   
   #add-point:construct段after construct 

   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asrp370_01.other_dialog" readonly="Y" >}

DIALOG asrp370_01_construct()
   DEFINE l_success  LIKE type_t.num5
   
   CONSTRUCT BY NAME g_wc_01 ON sraa001,srab004,srab005,srab006
      BEFORE CONSTRUCT
         
      ON ACTION controlp INFIELD sraa001
         #生產計劃
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.where = " srzastus = 'Y' "
         CALL q_srza001()                           #呼叫開窗
         DISPLAY g_qryparam.return1 TO sraa001  #顯示到畫面上
         NEXT FIELD sraa001                    #返回原欄位
         
      ON ACTION controlp INFIELD srab004
         #需求料号
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = "c"
         LET g_qryparam.reqry = FALSE
         CALL q_bmaa001_3()
         DISPLAY g_qryparam.return1 TO srab004
         NEXT FIELD srab004                     #返回原欄位

      ON ACTION controlp INFIELD srab005
         #BOM特性
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = "c"
         LET g_qryparam.reqry = FALSE
         CALL q_bmaa002_2()
         DISPLAY g_qryparam.return1 TO srab005
         NEXT FIELD srab005                     #返回原欄位

      ON ACTION controlp INFIELD srab006
         #產品特徵
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = "c"
         LET g_qryparam.reqry = FALSE
         CALL q_srab006()
         DISPLAY g_qryparam.return1 TO srab006
         NEXT FIELD srab006                     #返回原欄位

      ON ACTION accept
         CALL asrp370_01_gen_b() RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD CURRENT
         END IF
         CALL s_transaction_begin()   #add--160706-00037#10 By shiun
         CALL asrp370_01_b_fill()
         CALL s_transaction_end('Y','0')   #add--160706-00037#10 By shiun
         

       ON ACTION selall
          CALL asrp370_01_sel_all("Y")
       
       ON ACTION selnone
          CALL asrp370_01_sel_all("N")
       
   END CONSTRUCT
END DIALOG

DIALOG asrp370_01_input_a()
   DEFINE l_ooef004    LIKE ooef_t.ooef004  #单据别参照表号
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_success_tot    LIKE type_t.num5
   DEFINE l_date       LIKE indc_t.indc022  #成本关账日期
   DEFINE l_indc022    LIKE indc_t.indc022  #扣帐日期
   
   INPUT BY NAME g_asrp370_01_m.ware,g_asrp370_01_m.loca,g_asrp370_01_m.yy,g_asrp370_01_m.mm,g_asrp370_01_m.workno
      ATTRIBUTE(WITHOUT DEFAULTS)

      BEFORE INPUT

      AFTER FIELD ware
         IF NOT cl_null(g_asrp370_01_m.ware) THEN
            IF NOT asrp370_01_chk_column_a('ware') THEN
               NEXT FIELD CURRENT
            END IF
         END IF
         CALL s_desc_get_stock_desc(g_site,g_asrp370_01_m.ware) RETURNING g_asrp370_01_m.ware_desc
         DISPLAY BY NAME g_asrp370_01_m.ware_desc

      AFTER FIELD loca
         IF NOT cl_null(g_asrp370_01_m.loca) THEN
            IF NOT asrp370_01_chk_column_a('loca') THEN
               NEXT FIELD CURRENT
            END IF
         END IF
         CALL s_desc_get_locator_desc(g_site,g_asrp370_01_m.ware,g_asrp370_01_m.loca)
            RETURNING g_asrp370_01_m.loca_desc
         DISPLAY BY NAME g_asrp370_01_m.loca_desc

      AFTER FIELD yy
         IF NOT cl_null(g_asrp370_01_m.yy) THEN
            IF NOT asrp370_01_chk_column_a('yy') THEN
               NEXT FIELD CURRENT
            END IF
         END IF

      AFTER FIELD mm
         IF NOT cl_null(g_asrp370_01_m.mm) THEN
            IF NOT asrp370_01_chk_column_a('mm') THEN
               NEXT FIELD CURRENT
            END IF
         END IF

      AFTER FIELD workno
         IF NOT cl_null(g_asrp370_01_m.workno) THEN
            IF NOT asrp370_01_chk_column_a('workno') THEN
               NEXT FIELD CURRENT
            END IF
         END IF
         CALL s_desc_get_acc_desc('221',g_asrp370_01_m.workno) RETURNING g_asrp370_01_m.workno_desc
         DISPLAY BY NAME g_asrp370_01_m.workno_desc

      ON ACTION controlp INFIELD ware #庫位
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = "i"
         LET g_qryparam.reqry = FALSE
         #LET g_qryparam.where = " inaastus='Y' "
         LET g_qryparam.default1 = g_asrp370_01_m.ware             #給予default值
         CALL q_inaa001_12()  #库位
         LET g_asrp370_01_m.ware = g_qryparam.return1
         DISPLAY g_asrp370_01_m.ware TO ware
         CALL s_desc_get_stock_desc(g_site,g_asrp370_01_m.ware) RETURNING g_asrp370_01_m.ware_desc
         IF NOT cl_null(g_asrp370_01_m.loca) THEN
            CALL s_desc_get_locator_desc(g_site,g_asrp370_01_m.ware,g_asrp370_01_m.loca) RETURNING g_asrp370_01_m.loca_desc
         END IF
         DISPLAY g_asrp370_01_m.ware_desc TO ware_desc
         DISPLAY g_asrp370_01_m.loca_desc TO loca_desc
         NEXT FIELD ware
         
      ON ACTION controlp INFIELD loca #储位
         IF cl_null(g_asrp370_01_m.ware) THEN
            #请先维护库位
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00419'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            NEXT FIELD ware
         END IF
         #储位
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = "i"
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.arg1 = g_asrp370_01_m.ware
         LET g_qryparam.default1 = g_asrp370_01_m.loca
         CALL q_inab002_5()  #储位
         LET g_asrp370_01_m.loca = g_qryparam.return1
         DISPLAY g_asrp370_01_m.loca TO loca
         #栏位说明
         CALL s_desc_get_locator_desc(g_site,g_asrp370_01_m.ware,g_asrp370_01_m.loca) RETURNING g_asrp370_01_m.loca_desc
         DISPLAY g_asrp370_01_m.loca_desc TO loca_desc
         NEXT FIELD loca
         
      ON ACTION controlp INFIELD workno  #作业编号
         #储位
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = "i"
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_asrp370_01_m.workno
         LET g_qryparam.arg1 = "221" #應用分類
         CALL q_oocq002()                                #呼叫開窗
         LET g_asrp370_01_m.workno = g_qryparam.return1
         DISPLAY g_asrp370_01_m.workno TO workno
         #栏位说明
         CALL s_desc_get_acc_desc('221',g_asrp370_01_m.workno) RETURNING g_asrp370_01_m.workno_desc
         DISPLAY g_asrp370_01_m.workno_desc TO workno_desc
         NEXT FIELD workno               #開窗i段
         
      ON ACTION accept
         CALL asrp370_01_gen_b() RETURNING l_success
         IF NOT l_success THEN
            NEXT FIELD CURRENT
         END IF
         CALL s_transaction_begin()   #add--160706-00037#10 By shiun
         CALL asrp370_01_b_fill()
         CALL s_transaction_end('Y','0')   #add--160706-00037#10 By shiun
         

      ON ACTION selall
         CALL asrp370_01_sel_all("Y")
      
      ON ACTION selnone
         CALL asrp370_01_sel_all("N")
       
   END INPUT
END DIALOG

DIALOG asrp370_01_input_b()
   INPUT ARRAY g_srab01_d FROM s_detail1_asrp370_01.*
       ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
               INSERT ROW = FALSE,DELETE ROW = FALSE,APPEND ROW = FALSE)
       BEFORE INPUT
       
       BEFORE ROW
          LET l_ac = ARR_CURR()
          LET g_master_idx  = l_ac
          CALL asrp370_01_b_fill2(g_master_idx)
          
       AFTER FIELD sel
          IF cl_null(g_srab01_d[l_ac].sel) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aqc-00006'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()
             NEXT FIELD CURRENT
          END IF
          IF g_srab01_d[l_ac].sel NOT MATCHES '[NY]' THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'agl-00144'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()
             NEXT FIELD CURRENT
          END IF
          
       ON ROW CHANGE
          
       ON CHANGE sel
          UPDATE asrp370_tmp01 SET sel = g_srab01_d[l_ac].sel   #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
           WHERE srab001 = g_srab01_d[l_ac].srab001   #生產計劃
             AND srab004 = g_srab01_d[l_ac].srab004   #料件編號
             AND srab005 = g_srab01_d[l_ac].srab005   #BOM特性
             AND srab006 = g_srab01_d[l_ac].srab006   #產品特徵
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'upd asrp370_tmp01'  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
             LET g_errparam.popup = TRUE
             CALL cl_err()
             NEXT FIELD CURRENT
          END IF 
   
       ON ACTION selall
          CALL asrp370_01_sel_all("Y")
       
       ON ACTION selnone
          CALL asrp370_01_sel_all("N")
       
   END INPUT

END DIALOG

DIALOG asrp370_01_display2()
   DISPLAY ARRAY g_sfdc01_d TO s_detail2_asrp370_01.* ATTRIBUTE(COUNT = g_rec_b2)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(l_ac)

      BEFORE ROW
        LET l_ac = DIALOG.getCurrentRow("s_detail2_asrp370_01")
   END DISPLAY
END DIALOG

 
{</section>}
 
{<section id="asrp370_01.other_function" readonly="Y" >}

PUBLIC FUNCTION asrp370_01_init()
   WHENEVER ERROR CONTINUE
   
   #當整體參數有使用參考單位時才顯示
   IF g_ref_unit = 'N' THEN
      CALL cl_set_comp_visible("sfdc009,sfdc010",FALSE) #參考單位
   END IF
END FUNCTION

PUBLIC FUNCTION asrp370_01_b_fill()
   
   WHENEVER ERROR CONTINUE
   
   CALL asrp370_01_b_fill1()
   CALL asrp370_01_b_fill2(g_master_idx)
END FUNCTION

#生产计划挑选单身
PUBLIC FUNCTION asrp370_01_b_fill1()
   DEFINE l_sql        STRING
   DEFINE l_ac_t       LIKE type_t.num5
   DEFINE l_rate       LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_success    LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   CALL g_srab01_d.clear()
   
   LET l_sql = "SELECT UNIQUE sel,srab001,srab004,imaal003,imaal004, ",
               "       srab005,srab006,'',srab010,srab011, ",
               "       hasqty,planqty,planware,inayl003,planloca,inab003  ",
               "  FROM asrp370_tmp01 LEFT JOIN imaal_t ON imaalent='"||g_enterprise||"' AND imaal001=srab004 AND imaal002='"||g_dlang||"' ",  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
               "                        LEFT JOIN inayl_t ON inaylent="||g_enterprise||" AND inayl001= planware AND inayl002 = '",g_dlang,"' ",
               "                        LEFT JOIN inab_t  ON inabent ="||g_enterprise||" AND inabsite='"||g_site||"' AND inab001=planware AND inab002=planloca  ",
               " ORDER BY srab001,srab004,srab005,srab006"
   PREPARE asrp370_01_b_fill1_sel FROM l_sql
   DECLARE asrp370_01_b_fill1_curs CURSOR FOR asrp370_01_b_fill1_sel
   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"
   
   FOREACH asrp370_01_b_fill1_curs INTO g_srab01_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asrp370_01_b_fill1_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      #产品特征说明
      CALL s_feature_description(g_srab01_d[l_ac].srab004,g_srab01_d[l_ac].srab006)
         RETURNING l_success,g_srab01_d[l_ac].srab006_desc
         
      ##库位说明
      #CALL s_desc_get_stock_desc(g_site,g_srab01_d[l_ac].planware)
      #   RETURNING g_srab01_d[l_ac].planware_desc
      #
      ##储位说明
      #CALL s_desc_get_locator_desc(g_site,g_srab01_d[l_ac].planware,g_srab01_d[l_ac].planloca)
      #   RETURNING g_srab01_d[l_ac].planloca_desc
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET g_rec_b = l_ac - 1
   CALL g_srab01_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE asrp370_01_b_fill1_curs
   FREE asrp370_01_b_fill1_sel
   
   LET g_master_idx = l_ac
   IF cl_null(g_master_idx) OR g_master_idx = 0 THEN
      LET g_master_idx = 1
   END IF
END FUNCTION

#需求料号明细单身
PUBLIC FUNCTION asrp370_01_b_fill2(p_ac)
   DEFINE p_ac         LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_ac_t       LIKE type_t.num5
   DEFINE l_rate       LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_success    LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   CALL g_sfdc01_d.clear()
   
   IF cl_null(p_ac) OR p_ac=0 THEN
      RETURN
   END IF
   
   LET l_sql = "SELECT UNIQUE sfdcseq,sfdc004,imaal003,imaal004,sfdc005,'',imaf034,imae092, ",
               "       sfdc006,sfdc007,sfdc009,sfdc010,sfdc012,inayl003,sfdc013,inab003,sfdc014,sfdc016  ",
               "  FROM asrp370_tmp02 LEFT JOIN imaal_t ON imaalent="||g_enterprise||" AND imaal001=sfdc004 AND imaal002='"||g_dlang||"' ",  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp2 ——> asrp370_tmp02
               "                        LEFT JOIN imaf_t  ON imafent ="||g_enterprise||" AND imafsite='"||g_site||"' AND imaf001=sfdc004 ",
               "                        LEFT JOIN imae_t  ON imaeent ="||g_enterprise||" AND imaesite='"||g_site||"' AND imae001=sfdc004 ",
               "                        LEFT JOIN inayl_t ON inaylent="||g_enterprise||" AND inayl001= sfdc012 AND inayl002 = '",g_dlang,"' ",
               "                        LEFT JOIN inab_t  ON inabent ="||g_enterprise||" AND inabsite='"||g_site||"' AND inab001=sfdc012 AND inab002=sfdc013  ",
               " WHERE srab001 = '",g_srab01_d[p_ac].srab001,"' ",
               "   AND srab004 = '",g_srab01_d[p_ac].srab004,"' ",
               "   AND srab005 = '",g_srab01_d[p_ac].srab005,"' ",
               "   AND srab006 = '",g_srab01_d[p_ac].srab006,"' ",
               " ORDER BY sfdcseq"
   PREPARE asrp370_01_b_fill2_sel FROM l_sql
   DECLARE asrp370_01_b_fill2_curs CURSOR FOR asrp370_01_b_fill2_sel
   LET l_ac_t = l_ac
   LET l_ac = 1
   ERROR "Searching!"
   FOREACH asrp370_01_b_fill2_curs INTO g_sfdc01_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asrp370_01_b_fill2_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      #产品特征说明
      CALL s_feature_description(g_sfdc01_d[l_ac].sfdc004,g_sfdc01_d[l_ac].sfdc005)
         RETURNING l_success,g_sfdc01_d[l_ac].sfdc005_desc
         
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH
   LET g_rec_b2 = l_ac - 1
   CALL g_sfdc01_d.deleteElement(l_ac)
   LET l_ac = l_ac_t
   CLOSE asrp370_01_b_fill2_curs
   FREE asrp370_01_b_fill2_sel
   
   #LET g_master_idx = l_ac
END FUNCTION

PUBLIC FUNCTION asrp370_01_sel_all(p_flag)
   DEFINE p_flag         LIKE type_t.chr1
   DEFINE l_i            LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   
   IF g_rec_b = 0 THEN
      RETURN
   END IF
   
   FOR l_i = 1 TO g_rec_b
       LET g_srab01_d[l_i].sel = p_flag
       #更新临时表
       UPDATE asrp370_tmp01 SET sel = g_srab01_d[l_i].sel  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
        WHERE srab001 = g_srab01_d[l_i].srab001   #生產計劃
          AND srab004 = g_srab01_d[l_i].srab004   #料件編號
          AND srab005 = g_srab01_d[l_i].srab005   #BOM特性
          AND srab006 = g_srab01_d[l_i].srab006   #產品特徵
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'upd asrp370_tmp01'  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOR
       END IF 
   END FOR
END FUNCTION

PUBLIC FUNCTION asrp370_01_create_temp_table()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   IF NOT asrp370_01_drop_temp_table() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE asrp370_tmp01(   #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
      sel                 VARCHAR(1),             #选择
      srab001             VARCHAR(10),        #生產計劃
      srab004             VARCHAR(40),        #料件編號
      srab005             VARCHAR(30),        #BOM特性
      srab006             VARCHAR(256),        #產品特徵
      srab010             DECIMAL(20,6),        #數量
      srab011             VARCHAR(10),        #單位
      hasqty              DECIMAL(20,6),        #已發套數
      planqty             DECIMAL(20,6),        #擬調撥套數
      planware            VARCHAR(10),        #擬撥入庫位
      planloca            VARCHAR(10)     #擬撥入儲位
      )
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asrp370_tmp01'  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE UNIQUE INDEX asrp370_tmp01_01 on asrp370_tmp01 (srab001,srab004,srab005,srab006)  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index asrp370_tmp01'  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE asrp370_tmp02(  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp2 ——> asrp370_tmp02
      srab001             VARCHAR(10),        #生產計劃
      srab004             VARCHAR(40),        #料件編號
      srab005             VARCHAR(30),        #BOM特性
      srab006             VARCHAR(256),        #產品特徵
      sfdcseq             INTEGER,          #项次
      sfdc004             VARCHAR(40),          #需求料号
      sfdc005             VARCHAR(256),          #特征
      sfdc006             VARCHAR(10),          #单位
      sfdc007             DECIMAL(20,6),          #申请数量
      sfdc009             VARCHAR(10),          #参考单位
      sfdc010             DECIMAL(20,6),          #参考单位申请数量
      sfdc012             VARCHAR(10),          #指定库位
      sfdc013             VARCHAR(10),          #指定储位
      sfdc014             VARCHAR(30),          #指定批号
      sfdc016             VARCHAR(30)     #库存管理特征
      )
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asrp370_tmp02'  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp2 ——> asrp370_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE UNIQUE INDEX asrp370_tmp02_01 on asrp370_tmp02 (srab001,srab004,srab005,srab006,sfdcseq)  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp2 ——> asrp370_tmp02
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create index asrp370_tmp02'  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp2 ——> asrp370_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #160120-00002#10 160218 pomelo add(S)
   CREATE TEMP TABLE asrp370_tmp03(   #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 p370_01_lock_b_t ——> asrp370_tmp03
      srab000             INTEGER,         #版本
      srab001             VARCHAR(10),         #生產計劃
      srab002             SMALLINT,         #年
      srab003             SMALLINT,         #月
      srab004             VARCHAR(40),         #料件編號
      srab005             VARCHAR(30),         #BOM特性
      srab006             VARCHAR(256),         #產品特徵
      srab009             DATE     #日期
   )
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create asrp370_tmp03'  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 p370_01_lock_b_t ——> asrp370_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160120-00002#10 160218 pomelo add(E)

   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asrp370_01_drop_temp_table()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   DROP TABLE asrp370_tmp01  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop asrp370_tmp01'  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE asrp370_tmp02  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp2 ——> asrp370_tmp02
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop asrp370_tmp02'  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp2 ——> asrp370_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #160120-00002#10 160218 pomelo add(S)
   DROP TABLE asrp370_tmp03  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 p370_01_lock_b_t ——> asrp370_tmp03
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop asrp370_tmp03'  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 p370_01_lock_b_t ——> asrp370_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160120-00002#10 160218 pomelo add(E)

   RETURN r_success
END FUNCTION

PUBLIC FUNCTION asrp370_01_delete_temp_table()

   WHENEVER ERROR CONTINUE
   
   DELETE FROM asrp370_tmp01  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
   DELETE FROM asrp370_tmp02  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp2 ——> asrp370_tmp02
   DELETE FROM asrp370_tmp03    #160120-00002#10 160218 pomelo add  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 p370_01_lock_b_t ——> asrp370_tmp03
   
END FUNCTION

#產生單身
PUBLIC FUNCTION asrp370_01_gen_b()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_rate       LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_srab       RECORD
                       srab001  LIKE srab_t.srab001,  #生產計畫
                       srab000  LIKE srab_t.srab000,   #版本  asrt300中已做控管，只会出现一笔 取出用于计算已发套数
                       srab004  LIKE srab_t.srab004,  #料件編號
                       srab005  LIKE srab_t.srab005,  #BOM特性
                       srab006  LIKE srab_t.srab006,  #產品特徵
                       srab011  LIKE srab_t.srab011,  #单位
                       srab010  LIKE srab_t.srab010,  #數量
                       hasqty   LIKE srab_t.srab010,   #已發套數
                       planqty  LIKE srab_t.srab010,   #擬調撥套數
                       planware LIKE inag_t.inag004,   #擬撥入庫位
                       planloca LIKE inag_t.inag005    #擬撥入儲位
                       END RECORD
   #160120-00002#10 160218 pomelo add(S)
   DEFINE l_lock       RECORD
          srab000      LIKE srab_t.srab000,            #版本
          srab001      LIKE srab_t.srab001,            #生產計劃
          srab002      LIKE srab_t.srab002,            #年
          srab003      LIKE srab_t.srab003,            #月
          srab004      LIKE srab_t.srab004,            #料件編號
          srab005      LIKE srab_t.srab005,            #BOM特性
          srab006      LIKE srab_t.srab006,            #產品特徵
          srab009      LIKE srab_t.srab009             #日期
                       END RECORD
   DEFINE l_srab001    LIKE srab_t.srab001
   #160120-00002#10 160218 pomelo add(E)
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET g_today_dt= cl_get_current()
   
   IF cl_null(g_asrp370_01_m.yy) OR cl_null(g_asrp370_01_m.mm) OR cl_null(g_asrp370_01_m.ware) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   SELECT COUNT(*) INTO l_cnt FROM asrp370_tmp01  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
   IF l_cnt > 0 THEN
      #单身有一笔及以上资料,是否先删除后重新产生?
      IF cl_ask_confirm('amm-00070') THEN
         #先删除旧资料
         CALL asrp370_01_delete_temp_table()
      ELSE
         RETURN r_success
      END IF
   END IF
   
   #160120-00002#10 160218 pomelo add(S)
   LET l_sql = "SELECT srab000, srab001, srab002, srab003,",
               "       srab004, srab005, srab006, srab009",
               "  FROM srab_t,sraa_t ",
               " WHERE srabent=sraaent AND srabsite=sraasite ",
               "   AND srab000=sraa000 AND srab001=sraa001 ",
               "   AND srab002=sraa002 AND srab003=sraa003 ",
               "   AND srabent = ",g_enterprise,
               "   AND srabsite='",g_site,"'",
               "   AND srab002 = ",g_asrp370_01_m.yy,
               "   AND srab003 = ",g_asrp370_01_m.mm,
               "   AND ",g_wc_01 CLIPPED,
               "   AND sraastus= 'Y' "
   IF NOT cl_null(g_asrp370_01_m.workno) THEN 
      LET l_sql = l_sql CLIPPED,
                  " AND EXISTS (SELECT 1 FROM bmba_t ",
                  "              WHERE bmbaent = srabent AND bmbasite= srabsite ",
                  "                AND bmba001 = srab004 AND bmba002 = srab005 ",
                  "                AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss')<= '",g_today_dt,"' ",
                  "                AND (to_char(bmba006,'yyyy-mm-dd hh24:mi:ss')> '",g_today_dt,"' OR to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') IS NULL ) ",
                  "                AND bmba007 ='",g_asrp370_01_m.workno,"') "
   END IF
   PREPARE asrp370_01_sel_lock_pre FROM l_sql
   DECLARE asrp370_01_sel_lock_cs CURSOR FOR asrp370_01_sel_lock_pre
   
   LET l_sql = "SELECT srab001",
               "  FROM srab_t",
               " WHERE srabent = ",g_enterprise,
               "   AND srabsite = '",g_site,"'",
               "   AND srab000 = ?",
               "   AND srab001 = ?",
               "   AND srab002 = ?",
               "   AND srab003 = ?",
               "   AND srab004 = ?",
               "   AND srab005 = ?",
               "   AND srab006 = ?",
               "   AND srab009 = ?",
               " FOR UPDATE SKIP LOCKED"
   PREPARE asrp370_01_lock_sel_srab FROM l_sql
   
   LET l_sql = "INSERT INTO asrp370_tmp03(srab000, srab001, srab002, srab003,",  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 p370_01_lock_b_t ——> asrp370_tmp03
               "                             srab004, srab005, srab006, srab009)",
               " VALUES(?, ?, ?, ?,  ?, ?, ?, ?)"
   PREPARE aspr370_01_ins_lock_tmp FROM l_sql
   
   INITIALIZE l_lock.* TO NULL
   FOREACH asrp370_01_sel_lock_cs
      INTO l_lock.srab000, l_lock.srab001, l_lock.srab002, l_lock.srab003,
           l_lock.srab004, l_lock.srab005, l_lock.srab006, l_lock.srab009
      
      LET l_srab001 = ''
      EXECUTE asrp370_01_lock_sel_srab
        USING l_lock.srab000, l_lock.srab001, l_lock.srab002, l_lock.srab003,
              l_lock.srab004, l_lock.srab005, l_lock.srab006, l_lock.srab009
         INTO l_srab001
              
      IF NOT cl_null(l_srab001) THEN
         EXECUTE aspr370_01_ins_lock_tmp
           USING l_lock.srab000, l_lock.srab001, l_lock.srab002, l_lock.srab003,
                 l_lock.srab004, l_lock.srab005, l_lock.srab006, l_lock.srab009
      END IF
   END FOREACH
   
   LET l_sql = "SELECT COUNT(*)",
               "  FROM asrp370_tmp03",   #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 p370_01_lock_b_t ——> asrp370_tmp03
               " WHERE srab000 = ?",
               "   AND srab001 = ?",
               "   AND srab004 = ?",
               "   AND srab005 = ?",
               "   AND srab006 = ?"
   PREPARE asrp370_01_cnt_lock_tmp FROM l_sql
   #160120-00002#10 160218 pomelo add(E)
   
   #获取资料插入临时表1
   LET l_sql = "SELECT UNIQUE srab001,srab000,srab004,srab005,srab006,srab011,sum(srab010) ",
               "  FROM srab_t,sraa_t ",
               " WHERE srabent=sraaent AND srabsite=sraasite ",
               "   AND srab000=sraa000 AND srab001=sraa001 ",
               "   AND srab002=sraa002 AND srab003=sraa003 ",
               "   AND srabent = ",g_enterprise,
               "   AND srabsite='",g_site,"'",
               "   AND srab002 = ",g_asrp370_01_m.yy,
               "   AND srab003 = ",g_asrp370_01_m.mm,
               "   AND ",g_wc_01 CLIPPED,
               "   AND sraastus= 'Y' " #当年月最大版本号 不用另外写,asrt300审核时会将其他版本号结案掉
   IF NOT cl_null(g_asrp370_01_m.workno) THEN #作业编号
      #LET l_sql = l_sql CLIPPED," AND srab008='",g_asrp370_01_m.workno,"' "
      LET l_sql = l_sql CLIPPED," AND EXISTS (SELECT 1 FROM bmba_t ",
                                "              WHERE bmbaent = srabent AND bmbasite= srabsite ",
                                "                AND bmba001 = srab004 AND bmba002 = srab005 ",
                                "                AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss')<= '",g_today_dt,"' ",
                                "                AND (to_char(bmba006,'yyyy-mm-dd hh24:mi:ss')> '",g_today_dt,"' OR to_char(bmba006,'yyyy-mm-dd hh24:mi:ss') IS NULL ) ",
                                "                AND bmba007 ='",g_asrp370_01_m.workno,"' ",
                                "            ) "
   END IF
   LET l_sql = l_sql CLIPPED,
               " GROUP BY srab001,srab000,srab004,srab005,srab006,srab011 ",
               " ORDER BY srab001,srab000,srab004,srab005,srab006,srab011"
   PREPARE asrp370_01_gen_b_sel FROM l_sql
   DECLARE asrp370_01_gen_b_curs CURSOR FOR asrp370_01_gen_b_sel
   ERROR "Searching!"
   FOREACH asrp370_01_gen_b_curs INTO l_srab.srab001,l_srab.srab000,l_srab.srab004,l_srab.srab005,
                                      l_srab.srab006,l_srab.srab011,l_srab.srab010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:asrp370_01_gen_b_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #160120-00002#10 160218 pomelo add(S)
      LET l_cnt = 0
      EXECUTE asrp370_01_cnt_lock_tmp
        USING l_srab.srab000, l_srab.srab001, l_srab.srab004,
              l_srab.srab005, l_srab.srab006
         INTO l_cnt
      IF l_cnt = 0 THEN
         CONTINUE FOREACH
      END IF
      #160120-00002#10 160218 pomelo add(E)

      #已發套數
      SELECT SUM(sfda013) INTO l_srab.hasqty
        FROM sfda_t
       WHERE sfdaent = g_enterprise
         AND sfdasite= g_site
         AND sfda009 = l_srab.srab001  #生产计划
         AND sfda006 = l_srab.srab004  #生产料号
         AND sfda007 = l_srab.srab005  #bom特性
         AND sfda008 = l_srab.srab006  #产品特征
      IF cl_null(l_srab.hasqty) THEN LET l_srab.hasqty = 0 END IF
      
      #擬調撥套數=计划数量-已发套数
      LET l_srab.planqty  = l_srab.srab010 - l_srab.hasqty
      IF cl_null(l_srab.planqty) OR l_srab.planqty < 0 THEN
         LET l_srab.planqty = 0
      END IF
      
      #擬撥入庫位
      LET l_srab.planware = g_asrp370_01_m.ware
      IF cl_null(l_srab.planware) THEN LET l_srab.planware = ' ' END IF
      
      #擬撥入儲位
      LET l_srab.planloca = g_asrp370_01_m.loca
      IF cl_null(l_srab.planloca) THEN LET l_srab.planloca = ' ' END IF
   

   #   
   #   #计算库存量
   #   CALL asrp370_01_get_inag008(l_sfdc004,l_sfdc005,l_sfdc012,l_sfdc013,l_sfdc006) RETURNING l_inag008  #库存数量
   #   
   #   IF NOT cl_null(l_sfdc009) THEN
   #      #计算单位换算率
   #      CALL s_aimi190_get_convert(l_sfdc004,l_sfdc006,l_sfdc009)
   #         RETURNING l_success,l_rate
   #      IF NOT l_success THEN
   #         LET l_rate = 1
   #      END IF
   #      #计算参考单位库存量及差异量
   #      LET l_inag025 = l_inag008 * l_rate  #参考单位库存数量
   #   ELSE
   #      LET l_sfdc010 = 0   #参考单位需求数量
   #      LET l_inag025 = 0   #参考单位库存数量
   #   END IF
   #
      INSERT INTO asrp370_tmp01(     sel,   #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
                                   srab001 ,srab004 ,srab005 ,
                                   srab006 ,srab010 ,srab011 ,
                                   hasqty  ,planqty ,planware,
                                   planloca)
         VALUES('N'        ,
                l_srab.srab001 ,l_srab.srab004 ,l_srab.srab005 ,
                l_srab.srab006 ,l_srab.srab010 ,l_srab.srab011 ,
                l_srab.hasqty  ,l_srab.planqty ,l_srab.planware,
                l_srab.planloca)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins asrp370_tmp01'  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp1 ——> asrp370_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF 
      
      #产生单身2资料
      CALL asrp370_01_gen_b2(l_srab.srab001,l_srab.srab004,l_srab.srab005,l_srab.srab006,l_srab.planqty) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END FOREACH
   CLOSE asrp370_01_gen_b_curs
   FREE asrp370_01_gen_b_sel
   
   RETURN r_success
END FUNCTION

#依“生产计划挑选”页签中每一个生产计划产生所需的需求料号，并依拟调拨套数计算需求料号的申请数量（逻辑同发料单）
PUBLIC FUNCTION asrp370_01_gen_b2(p_srab001,p_srab004,p_srab005,p_srab006,p_planqty)
   DEFINE p_srab001            LIKE srab_t.srab001   #生產計劃
   DEFINE p_srab004            LIKE srab_t.srab004   #料件編號
   DEFINE p_srab005            LIKE srab_t.srab005   #BOM特性
   DEFINE p_srab006            LIKE srab_t.srab006   #產品特徵
   DEFINE p_planqty            LIKE srab_t.srab010   #擬調撥套數
   DEFINE r_success            LIKE type_t.num5
   DEFINE lr_bmba                DYNAMIC ARRAY OF RECORD #回传数组
          bmba001                LIKE bmba_t.bmba001,    #bom相关资料都可以通过回传的key值抓取
          bmba002                LIKE bmba_t.bmba002,
          bmba003                LIKE bmba_t.bmba003,
          bmba004                LIKE bmba_t.bmba004,
          bmba005                DATETIME YEAR TO SECOND,
          bmba007                LIKE bmba_t.bmba007,
          bmba008                LIKE bmba_t.bmba008,
          bmba035                LIKE bmba_t.bmba035,     #保稅否   #160512-00016#25
          l_bmba011              LIKE bmba_t.bmba011,     #QPA 分子，对应于原始的主件料号
          l_bmba012              LIKE bmba_t.bmba012,     #QPA 分母，对应于原始的主件料号
          l_inam002              LIKE inam_t.inam002      #元件对应特征
                                 END RECORD
   DEFINE l_imaa006         LIKE imaa_t.imaa006
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_bmba005_1       LIKE ooff_t.ooff007
   DEFINE l_sql             STRING
#   DEFINE l_bmba            RECORD LIKE bmba_t.* #161124-00048#21 mark
#   DEFINE l_sfdc            RECORD LIKE sfdc_t.* #161124-00048#21 mark
#161124-00048#21 add(s)
DEFINE l_bmba RECORD  #產品結構研發資料單身檔
       bmbaent LIKE bmba_t.bmbaent, #企业编号
       bmbasite LIKE bmba_t.bmbasite, #营运据点
       bmba001 LIKE bmba_t.bmba001, #主件料号
       bmba002 LIKE bmba_t.bmba002, #特性
       bmba003 LIKE bmba_t.bmba003, #元件料号
       bmba004 LIKE bmba_t.bmba004, #部位编号
       bmba005 LIKE bmba_t.bmba005, #生效日期时间
       bmba006 LIKE bmba_t.bmba006, #失效日期时间
       bmba007 LIKE bmba_t.bmba007, #作业编号
       bmba008 LIKE bmba_t.bmba008, #作业序
       bmba009 LIKE bmba_t.bmba009, #项次
       bmba010 LIKE bmba_t.bmba010, #发料单位
       bmba011 LIKE bmba_t.bmba011, #组成用量
       bmba012 LIKE bmba_t.bmba012, #主件底数
       bmba013 LIKE bmba_t.bmba013, #必要
       bmba014 LIKE bmba_t.bmba014, #特征管理
       bmba015 LIKE bmba_t.bmba015, #指定发料库位
       bmba016 LIKE bmba_t.bmba016, #指定发料储位
       bmba017 LIKE bmba_t.bmba017, #FAS选择群组
       bmba018 LIKE bmba_t.bmba018, #插件位置
       bmba019 LIKE bmba_t.bmba019, #参照研发中心
       bmba020 LIKE bmba_t.bmba020, #可选件
       bmba021 LIKE bmba_t.bmba021, #工单展开选项
       bmba022 LIKE bmba_t.bmba022, #代买料
       bmba023 LIKE bmba_t.bmba023, #元件投料时距
       bmba024 LIKE bmba_t.bmba024, #主要替代料
       bmba025 LIKE bmba_t.bmba025, #附属零件
       bmba026 LIKE bmba_t.bmba026, #ECN单号
       bmba027 LIKE bmba_t.bmba027, #用量是否使用公式
       bmba028 LIKE bmba_t.bmba028, #用量公式
       bmba029 LIKE bmba_t.bmba029, #损耗率型态
       bmba030 LIKE bmba_t.bmba030, #倒扣料
       bmba031 LIKE bmba_t.bmba031, #客供料
       bmba032 LIKE bmba_t.bmba032, #指定库存管理特征
       bmba033 LIKE bmba_t.bmba033, #损耗率是否使用公式
       bmba034 LIKE bmba_t.bmba034, #损耗率公式
       bmba035 LIKE bmba_t.bmba035  #保税否
END RECORD
DEFINE l_sfdc RECORD  #發退料需求檔
       sfdcent LIKE sfdc_t.sfdcent, #企业编号
       sfdcsite LIKE sfdc_t.sfdcsite, #营运据点
       sfdcdocno LIKE sfdc_t.sfdcdocno, #发退料单号
       sfdcseq LIKE sfdc_t.sfdcseq, #项次
       sfdc001 LIKE sfdc_t.sfdc001, #工单单号
       sfdc002 LIKE sfdc_t.sfdc002, #工单项次
       sfdc003 LIKE sfdc_t.sfdc003, #工单项序
       sfdc004 LIKE sfdc_t.sfdc004, #需求料号
       sfdc005 LIKE sfdc_t.sfdc005, #产品特征
       sfdc006 LIKE sfdc_t.sfdc006, #单位
       sfdc007 LIKE sfdc_t.sfdc007, #申请数量
       sfdc008 LIKE sfdc_t.sfdc008, #实际数量
       sfdc009 LIKE sfdc_t.sfdc009, #参考单位
       sfdc010 LIKE sfdc_t.sfdc010, #参考单位需求数量
       sfdc011 LIKE sfdc_t.sfdc011, #参考单位实际数量
       sfdc012 LIKE sfdc_t.sfdc012, #指定库位
       sfdc013 LIKE sfdc_t.sfdc013, #指定储位
       sfdc014 LIKE sfdc_t.sfdc014, #指定批号
       sfdc015 LIKE sfdc_t.sfdc015, #理由码
       sfdc016 LIKE sfdc_t.sfdc016, #库存管理特徴
       sfdc017 LIKE sfdc_t.sfdc017  #正负
END RECORD
#161124-00048#21 add(e)
   DEFINE l_qty             LIKE sfba_t.sfba013
   DEFINE l_qty1            LIKE sfba_t.sfba013
   DEFINE l_qty2            LIKE sfba_t.sfba013
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_rate            LIKE inaj_t.inaj014
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #从bom中获取元件需求资料,同asrt310方式处理
   SELECT imaa006 INTO l_imaa006
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = p_srab004
   #160512-00016#14 20160527 modify by ming -----(S) 
   #目前不確定此程式是否走保稅，所以不指定Y/N
   #CALL s_asft300_02_bom(0,p_srab004,p_srab005,l_imaa006,1,1,'','N','',p_srab006,'') RETURNING lr_bmba
   CALL s_asft300_02_bom(0,p_srab004,p_srab005,l_imaa006,1,1,'','N','',p_srab006,'','N') RETURNING lr_bmba   #160512-00016#25 保税否栏位給值N
   #160512-00016#14 20160527 modify by ming -----(E) 
   
   #产生到单身2
   FOR l_i = 1 TO lr_bmba.getLength()
      LET l_bmba005_1 = lr_bmba[l_i].bmba005
#      LET l_sql="SELECT * FROM bmba_t WHERE bmbaent='",g_enterprise,"' AND bmbasite='",g_site,"'", #161124-00048#21 mark
      #161124-00048#21 add(s)
      LET l_sql="SELECT bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba004,bmba005,bmba006,bmba007,",
                "       bmba008,bmba009,bmba010,bmba011,bmba012,bmba013,bmba014,bmba015,bmba016, ",
                "       bmba017,bmba018,bmba019,bmba020,bmba021,bmba022,bmba023,bmba024,bmba025, ",
                "       bmba026,bmba027,bmba028,bmba029,bmba030,bmba031,bmba032,bmba033,bmba034, ",
                "       bmba035 FROM bmba_t WHERE bmbaent='",g_enterprise,"' AND bmbasite='",g_site,"'",
      #161124-00048#21 add(e)
                "  AND bmba001='",lr_bmba[l_i].bmba001,"' AND bmba002='",lr_bmba[l_i].bmba002,"' AND bmba003='",lr_bmba[l_i].bmba003,"'",
                "  AND bmba004='",lr_bmba[l_i].bmba004,"' AND bmba007='",lr_bmba[l_i].bmba007,"' AND bmba008='",lr_bmba[l_i].bmba008,"'",
                "  AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss')='",l_bmba005_1,"'",
                "ORDER BY bmba009 "
      PREPARE s_asrp370_01_gen_b2_pre FROM l_sql
      EXECUTE s_asrp370_01_gen_b2_pre INTO l_bmba.*
      
      IF NOT cl_null(g_asrp370_01_m.workno) THEN #作业编号
         IF cl_null(l_bmba.bmba007) OR g_asrp370_01_m.workno!=l_bmba.bmba007 THEN
            CONTINUE FOR
         END IF
      END IF
      
      INITIALIZE l_sfdc.* TO NULL
      #项次
      SELECT MAX(sfdcseq)+1 INTO l_sfdc.sfdcseq
        FROM asrp370_tmp02  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp2 ——> asrp370_tmp02
       WHERE srab001 = p_srab001
         AND srab004 = p_srab004
         AND srab005 = p_srab005
         AND srab006 = p_srab006
      IF cl_null(l_sfdc.sfdcseq) THEN
         LET l_sfdc.sfdcseq = 1
      END IF
      #需求料号
      LET l_sfdc.sfdc004 = l_bmba.bmba003
      #特徵管理有分為3種方式：
      #1.主件特徴限定用料:當主件的特徵=尺寸時，且尺寸=S時，元件用的A料號，尺寸=L時，元件用B料號
      #  此情況元件本身不會記錄特徵，但需要根據主件的特徵判斷需要用哪個元件
      #  當BOM的資料為同一項次+部位+作業+製程序，但不同料號時，代表為同一組的資
      #2.主件特徵與元件特徵對應:當主件的特徵=紅時，元件則用特徵黑色，主件特徵=藍時，元件特徵用白色，元件的黑色與白色為同一料號
      #  此情況元件需記錄特徵
      #3.限定元件特徵：此情況不需考慮主件的庫存特徵，元件本身指定用哪個特徵，將特徵記錄於發料單身即可
      LET l_sfdc.sfdc005 = ' '
      LET l_sfdc.sfdc006 = l_bmba.bmba010 #单位
      LET l_qty = p_planqty * lr_bmba[l_i].l_bmba011 / lr_bmba[l_i].l_bmba012 #套数*QPA
      IF l_bmba.bmba027 = 'Y' THEN #用量是否使用公式
         CALL s_asft300_04('',l_bmba.bmba001,l_bmba.bmba003,l_bmba.bmba028,l_sfdc.sfdc005,l_qty) RETURNING l_success,l_qty1   #160406-00004#1
         IF NOT l_success THEN
            LET l_qty1=0
         END IF
      ELSE
         LET l_qty1 = l_qty
      END IF
      #CALL s_aooi200_get_slip(p_sfdadocno) RETURNING l_success,l_doc_slip
      #CALL cl_get_doc_para(g_enterprise,g_site,l_doc_slip,'D-MFG-0046') RETURNING l_sys #工單備料數量是否考慮外加損耗率
      ##BOM的損秏為內含損秏時，允許誤差率=BOM變動損秏率，如果為外加損秏則=0
      #LET l_sql="SELECT bmbb011,bmbb012 FROM bmbb_t WHERE bmbbent='",g_enterprise,"' AND bmbbsite='",g_site,"'",
      #          "   AND bmbb001='",p_bmba[l_i].bmba001,"' AND bmbb002='",p_bmba[l_i].bmba002,"' AND bmbb003='",p_bmba[l_i].bmba003,"'",
      #          "   AND bmbb004='",p_bmba[l_i].bmba004,"' AND bmbb007='",p_bmba[l_i].bmba007,"' AND bmbb008='",p_bmba[l_i].bmba008,"'",
      #          "   AND to_char(bmbb005,'yyyy-mm-dd hh24:mi:ss')='",l_bmba005_1,"'",
      #          "   AND ((bmbb009<=",l_qty," AND bmbb010 IS NULL) OR (bmbb009<=",l_qty," AND bmbb010>=",l_qty,"))"
      #PREPARE s_asrt310_sel_bmbb_pre2 FROM l_sql
      #EXECUTE s_asrt310_sel_bmbb_pre2 INTO l_bmbb011,l_bmbb012
      #IF l_bmba.bmba029= '2' AND l_sys = 'Y' THEN
      #   LET l_qty2=l_qty*(l_bmbb011+l_bmbb012)/100
      #ELSE
         LET l_qty2=0
      #END IF
      LET l_sfdc.sfdc007 =l_qty1 + l_qty2 #申請數量
      CALL s_asft300_03(p_srab004,l_sfdc.sfdc007 ) RETURNING l_success,l_sfdc.sfdc007 #根据设定的最小发料数和发料批量推算出建议应发数量
      IF cl_null(l_sfdc.sfdc007) THEN
         LET l_sfdc.sfdc007 = 0
      END IF
      SELECT imaf015 INTO l_sfdc.sfdc009 #參考單位
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = l_bmba.bmba003
      #mod 150105
      #CALL s_aimi190_get_convert(l_bmba.bmba003,l_sfdc.sfdc006,l_sfdc.sfdc009) RETURNING l_success,l_rate
      #LET l_sfdc.sfdc010 = l_sfdc.sfdc007*l_rate #參考單位需求數量
      IF NOT cl_null(l_sfdc.sfdc009) THEN
         CALL s_aooi250_convert_qty(l_bmba.bmba003,l_sfdc.sfdc006,l_sfdc.sfdc009,l_sfdc.sfdc007)
            RETURNING l_success,l_sfdc.sfdc010
         IF NOT l_success THEN
            LET l_sfdc.sfdc010 = l_sfdc.sfdc007
         END IF
      ELSE
         LET l_sfdc.sfdc010 = 0
      END IF
      #mod 150105 end
      LET l_sfdc.sfdc012 = l_bmba.bmba015        #指定庫位
      #IF cl_null(l_sfdc.sfdc012) THEN
      #   LET l_sfdc.sfdc012 = p_sfda012
      #END IF
      LET l_sfdc.sfdc013 = l_bmba.bmba016        #指定儲位
      LET l_sfdc.sfdc014 = ' '         #指定批號
      LET l_sfdc.sfdc016 = l_bmba.bmba032       #庫存管理特徴
      IF cl_null(l_sfdc.sfdc012) THEN LET l_sfdc.sfdc012 = ' ' END IF
      IF cl_null(l_sfdc.sfdc013) THEN LET l_sfdc.sfdc013 = ' ' END IF
      IF cl_null(l_sfdc.sfdc014) THEN LET l_sfdc.sfdc014 = ' ' END IF
      IF cl_null(l_sfdc.sfdc016) THEN LET l_sfdc.sfdc016 = ' ' END IF
      
      INSERT INTO asrp370_tmp02(srab001,srab004,srab005,srab006,   #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp2 ——> asrp370_tmp02
                                   sfdcseq,sfdc004,sfdc005,sfdc006,
                                   sfdc007,sfdc009,sfdc010,sfdc012,
                                   sfdc013,sfdc014,sfdc016)
         VALUES(p_srab001,p_srab004,p_srab005,p_srab006,
                l_sfdc.sfdcseq,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,
                l_sfdc.sfdc007,l_sfdc.sfdc009,l_sfdc.sfdc010,l_sfdc.sfdc012,
                l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc016)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins asrp370_tmp02'  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asrp370_01_temp2 ——> asrp370_tmp02
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END FOR

   RETURN r_success
END FUNCTION

#单头input栏位检查
PUBLIC FUNCTION asrp370_01_chk_column_a(p_column)
   DEFINE p_column      LIKE type_t.chr20
   DEFINE r_success     LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
    CASE p_column
      WHEN 'ware'  #库位
           IF cl_null(g_asrp370_01_m.ware) THEN
              #此字段不可空白,请输入资料!
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'aoo-00052'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
           #是否存在库位资料
           INITIALIZE g_chkparam.* TO NULL
           LET g_chkparam.arg1 = g_asrp370_01_m.ware
           #160318-00025#22  by 07900 --add-str
           LET g_errshow = TRUE #是否開窗                   
           LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
           #160318-00025#22  by 07900 --add-end 
           IF NOT cl_chk_exist("v_inaa001_2") THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           #如果储位已有，检查储位
           IF NOT cl_null(g_asrp370_01_m.loca) THEN
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_site
              LET g_chkparam.arg2 = g_asrp370_01_m.ware
              LET g_chkparam.arg3 = g_asrp370_01_m.loca
              #160318-00025#22  by 07900 --add-str
              LET g_errshow = TRUE #是否開窗                   
              LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
              #160318-00025#22  by 07900 --add-end
              IF NOT cl_chk_exist("v_inab002") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'loca'  #储位
           IF NOT cl_null(g_asrp370_01_m.loca) THEN
              #检查库位+储位
              IF NOT cl_null(g_asrp370_01_m.ware) THEN
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = g_site
                 LET g_chkparam.arg2 = g_asrp370_01_m.ware
                 LET g_chkparam.arg3 = g_asrp370_01_m.loca
                 #160318-00025#22  by 07900 --add-str
                 LET g_errshow = TRUE #是否開窗                   
                 LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                 #160318-00025#22  by 07900 --add-end
                 IF NOT cl_chk_exist("v_inab002") THEN
                    LET r_success = FALSE
                    RETURN r_success
                 END IF
              END IF
              
           END IF
      WHEN 'yy'  #计划年
           IF cl_null(g_asrp370_01_m.yy) THEN
              #此字段不可空白,请输入资料!
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'aoo-00052'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
           IF NOT cl_ap_chk_range(g_asrp370_01_m.yy,"0","1","","","azz-00079",1) THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
      WHEN 'mm'  #计划月
           IF cl_null(g_asrp370_01_m.mm) THEN
              #此字段不可空白,请输入资料!
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'aoo-00052'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
           IF NOT cl_ap_chk_range(g_asrp370_01_m.mm,"1","1","12","1","azz-00087",1) THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
      WHEN 'workno'  #作业编号
           IF NOT cl_null(g_asrp370_01_m.workno) THEN
              #校验
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = '221'
              LET g_chkparam.arg2 = g_asrp370_01_m.workno
              #160318-00025#22  by 07900 --add-str
              LET g_errshow = TRUE #是否開窗                   
              LET g_chkparam.err_str[1] ="aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
             #160318-00025#22  by 07900 --add-end
              IF NOT cl_chk_exist("v_oocq002_1") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      OTHERWISE
   END CASE

   RETURN r_success

END FUNCTION

 
{</section>}
 
