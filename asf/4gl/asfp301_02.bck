#該程式已解開Section, 不再透過樣板產出!
{<section id="asfp301_02.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000006
#+ 
#+ Filename...: asfp301_02
#+ Description: ...
#+ Creator....: 00378(2014/07/08)
#+ Modifier...: 00378(2014/07/08)
#+ Buildtype..: 應用 c01b 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="asfp301_02.global" >}
#161109-00085#37 2016/11/17 By lienjunqi    整批調整系統星號寫法
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔
GLOBALS "../../asf/4gl/asfp301.inc"
#end add-point
 
#單頭 type 宣告
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="asfp301_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION asfp301_02(--)
)

 
 
 
 
 

 

 
 
 

 

 

 
END FUNCTION
 
{</section>}
 
{<section id="asfp301_02.other_dialog" readonly="Y" >}

DIALOG asfp301_02_input()
   DEFINE l_success       LIKE type_t.num5   
   DEFINE l_ooef004       LIKE ooef_t.ooef004
   
   INPUT BY NAME g_setting.*  ATTRIBUTE(WITHOUT DEFAULTS)
   
      BEFORE INPUT
         CALL asfp301_02_get_settings()
         CALL asfp301_02_set_entry_b()  
         CALL asfp301_02_set_no_entry_b()
         CALL cl_set_comp_required("choice8",FALSE)
         IF g_setting.choice7 = 'Y' THEN
            CALL cl_set_comp_required("choice8",TRUE)
         END IF

         
      ON ACTION save_settings
         CALL asfp301_02_save_settings()
              RETURNING l_success
         IF NOT l_success THEN
            CONTINUE DIALOG
         END IF
      
      BEFORE FIELD choice1
         CALL asfp301_02_set_entry_b()
         CALL asfp301_02_set_no_entry_b() #160214-00005#2-add
      
      #160214-00005#2-add----(S)
      ON CHANGE choice1
         CALL asfp301_02_set_entry_b()
         CALL asfp301_02_set_no_entry_b() 
         IF g_setting.choice1 = '1' THEN
            LET g_setting.choice2 = 'N'
            LET g_setting.choice3 = 'N'
            LET g_setting.choice4 = 'N'
            LET g_setting.choice5 = 'N'
         END IF
      #160214-00005#2-add----(E)
      
      AFTER FIELD choice1
         CALL asfp301_02_set_no_entry_b() 
 
      BEFORE FIELD choice7
        CALL cl_set_comp_required("choice8",FALSE)
        CALL asfp301_02_set_entry_b()
      
      #160214-00005#2-add----(S)
      ON CHANGE choice7
         CALL asfp301_02_set_entry_b()
         CALL asfp301_02_set_no_entry_b()  
         IF g_setting.choice7 = 'Y' THEN
            CALL cl_set_comp_required("choice8",TRUE)
         END IF
      #160214-00005#2-add----(E)
      
      AFTER FIELD choice7
         CALL asfp301_02_set_no_entry_b()     
         IF g_setting.choice7 = 'Y' THEN
            CALL cl_set_comp_required("choice8",TRUE)
            NEXT FIELD choice8
         ELSE
            LET g_setting.choice8 = ''
            LET g_setting.choice9 = 'N'
            DISPLAY BY NAME g_setting.choice8
            DISPLAY BY NAME g_setting.choice9
         END IF
         
      AFTER FIELD choice8
         IF NOT cl_null(g_setting.choice8) THEN
            #检查单别
            CALL s_aooi200_chk_slip(g_site,'',g_setting.choice8,'asft303')
                 RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
         END IF
 
      ON ACTION controlp
         CASE
            WHEN INFIELD(choice8)
                 INITIALIZE g_qryparam.* TO NULL
                 LET g_qryparam.state = 'i'
                 LET g_qryparam.reqry = FALSE
                 LET g_qryparam.default1 = g_setting.choice8

                 #給予arg
                 #单别参照表号
                 SELECT ooef004 INTO l_ooef004
                   FROM ooef_t
                  WHERE ooefent = g_enterprise
                    AND ooef001 = g_site
                 LET g_qryparam.arg1 = l_ooef004 #參照表編號
                 LET g_qryparam.arg2 = 'asft303'
                 CALL q_ooba002_1()
                 LET g_setting.choice8 = g_qryparam.return1
                 DISPLAY BY NAME g_setting.choice8
                 NEXT FIELD choice8
         END CASE
 
      AFTER INPUT
         IF g_setting.choice1 NOT MATCHES '[12]' THEN
            NEXT FIELD choice1
         END IF
      
         IF g_setting.choice2 NOT MATCHES '[YN]' THEN
            NEXT FIELD choice2
         END IF
         
         IF g_setting.choice3 NOT MATCHES '[YN]' THEN
            NEXT FIELD choice3
         END IF

         IF g_setting.choice4 NOT MATCHES '[YN]' THEN
            NEXT FIELD choice4
         END IF

         IF g_setting.choice5 NOT MATCHES '[YN]' THEN
            NEXT FIELD choice5
         END IF

         IF g_setting.choice6 NOT MATCHES '[YN]' THEN
            NEXT FIELD choice6
         END IF

         IF g_setting.choice7 NOT MATCHES '[YN]' THEN
            NEXT FIELD choice7
         END IF

         IF g_setting.choice9 NOT MATCHES '[YN]' THEN
            NEXT FIELD choice9
         END IF
         
         IF NOT cl_null(g_setting.choice8) THEN
            #检查单别
            CALL s_aooi200_chk_slip(g_site,'',g_setting.choice8,'asft303')
                 RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD choice8
            END IF
         END IF 

         IF g_setting.choice7 = 'Y' AND cl_null(g_setting.choice8) THEN
            #勾选"转入PBI"的选项时,PBI单别一定要录入!
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00469'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            NEXT FIELD choice8
         END IF
   END INPUT

END DIALOG

 
{</section>}
 
{<section id="asfp301_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取储存的条件设定
# Memo...........:
# Usage..........: CALL asfp301_02_get_settings()
#                       RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-07-08 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION asfp301_02_get_settings()
   DEFINE l_sql         STRING
   
   LET l_sql = "SELECT gzxn007 FROM gzxm_t,gzxn_t",
               " WHERE gzxment  = gzxnent AND gzxment = ",g_enterprise,
               "   AND gzxm001  = gzxn001 AND gzxm001 = 1 ",
               "   AND gzxm002  = gzxn002 AND gzxm002 = 'asfp301_02'",
               "   AND gzxm003  = gzxn003 AND gzxm003 = '",g_user,"'",
               "   AND gzxmstus = 'Y'",
               "   AND gzxn005  = ? "
   PREPARE asfp301_02_get_settings_p1 FROM l_sql
   
   #拼单选择
   EXECUTE asfp301_02_get_settings_p1 USING 'choice1' INTO g_setting.choice1
   IF cl_null(g_setting.choice1) THEN LET g_setting.choice1 = '1' END IF

   #拼单方式-预计交期
   EXECUTE asfp301_02_get_settings_p1 USING 'choice2' INTO g_setting.choice2
   IF cl_null(g_setting.choice2) THEN LET g_setting.choice2 = 'N' END IF

   #拼单方式-客户
   EXECUTE asfp301_02_get_settings_p1 USING 'choice3' INTO g_setting.choice3
   IF cl_null(g_setting.choice3) THEN LET g_setting.choice3 = 'N' END IF
   
   #拼单方式-产品特征
   EXECUTE asfp301_02_get_settings_p1 USING 'choice4' INTO g_setting.choice4
   IF cl_null(g_setting.choice4) THEN LET g_setting.choice4 = 'N' END IF

   #拼单方式-订单单号
   EXECUTE asfp301_02_get_settings_p1 USING 'choice5' INTO g_setting.choice5
   IF cl_null(g_setting.choice5) THEN LET g_setting.choice5 = 'N' END IF

   #下次不再进此画面
   EXECUTE asfp301_02_get_settings_p1 USING 'choice6' INTO g_setting.choice6
   IF cl_null(g_setting.choice6) THEN LET g_setting.choice6 = 'N' END IF

   #转入PBI
   EXECUTE asfp301_02_get_settings_p1 USING 'choice7' INTO g_setting.choice7
   IF cl_null(g_setting.choice7) THEN LET g_setting.choice7 = 'N' END IF

   #PBI单别
   EXECUTE asfp301_02_get_settings_p1 USING 'choice8' INTO g_setting.choice8

   #PBI单据自动审核
   EXECUTE asfp301_02_get_settings_p1 USING 'choice9' INTO g_setting.choice9
   IF cl_null(g_setting.choice9) THEN LET g_setting.choice9 = 'N' END IF
   
   
END FUNCTION

################################################################################
# Descriptions...: 取储存的条件设定
# Memo...........:
# Usage..........: CALL asfp301_02_save_settings()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success     成功否标识符
# Date & Author..: 2014-07-08 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION asfp301_02_save_settings()
   DEFINE r_success     LIKE type_t.num5
   #161109-00085#37-s
   #DEFINE l_gzxm_t      RECORD LIKE gzxm_t.*
   DEFINE l_gzxm_t RECORD  #查詢方案單頭檔
       gzxmstus LIKE gzxm_t.gzxmstus, #狀態碼
       gzxment LIKE gzxm_t.gzxment, #企業編號
       gzxm001 LIKE gzxm_t.gzxm001, #QBE編號
       gzxm002 LIKE gzxm_t.gzxm002, #作業編號
       gzxm003 LIKE gzxm_t.gzxm003, #員工編號
       gzxm004 LIKE gzxm_t.gzxm004, #是否為預設
       gzxm005 LIKE gzxm_t.gzxm005, #首頁使用
       gzxm006 LIKE gzxm_t.gzxm006, #查詢方案來源序號
       gzxm007 LIKE gzxm_t.gzxm007, #額外條件
       gzxm008 LIKE gzxm_t.gzxm008, #分群編號
       gzxmownid LIKE gzxm_t.gzxmownid, #資料所有者
       gzxmowndp LIKE gzxm_t.gzxmowndp, #資料所屬部門
       gzxmcrtid LIKE gzxm_t.gzxmcrtid, #資料建立者
       gzxmcrtdp LIKE gzxm_t.gzxmcrtdp, #資料建立部門
       gzxmcrtdt LIKE gzxm_t.gzxmcrtdt, #資料創建日
       gzxmmodid LIKE gzxm_t.gzxmmodid, #資料修改者
       gzxmmoddt LIKE gzxm_t.gzxmmoddt, #最近修改日
       gzxm009 LIKE gzxm_t.gzxm009, #順序
       gzxm010 LIKE gzxm_t.gzxm010, #分享
       gzxmud001 LIKE gzxm_t.gzxmud001, #自定義欄位(文字)001
       gzxmud002 LIKE gzxm_t.gzxmud002, #自定義欄位(文字)002
       gzxmud003 LIKE gzxm_t.gzxmud003, #自定義欄位(文字)003
       gzxmud004 LIKE gzxm_t.gzxmud004, #自定義欄位(文字)004
       gzxmud005 LIKE gzxm_t.gzxmud005, #自定義欄位(文字)005
       gzxmud006 LIKE gzxm_t.gzxmud006, #自定義欄位(文字)006
       gzxmud007 LIKE gzxm_t.gzxmud007, #自定義欄位(文字)007
       gzxmud008 LIKE gzxm_t.gzxmud008, #自定義欄位(文字)008
       gzxmud009 LIKE gzxm_t.gzxmud009, #自定義欄位(文字)009
       gzxmud010 LIKE gzxm_t.gzxmud010, #自定義欄位(文字)010
       gzxmud011 LIKE gzxm_t.gzxmud011, #自定義欄位(數字)011
       gzxmud012 LIKE gzxm_t.gzxmud012, #自定義欄位(數字)012
       gzxmud013 LIKE gzxm_t.gzxmud013, #自定義欄位(數字)013
       gzxmud014 LIKE gzxm_t.gzxmud014, #自定義欄位(數字)014
       gzxmud015 LIKE gzxm_t.gzxmud015, #自定義欄位(數字)015
       gzxmud016 LIKE gzxm_t.gzxmud016, #自定義欄位(數字)016
       gzxmud017 LIKE gzxm_t.gzxmud017, #自定義欄位(數字)017
       gzxmud018 LIKE gzxm_t.gzxmud018, #自定義欄位(數字)018
       gzxmud019 LIKE gzxm_t.gzxmud019, #自定義欄位(數字)019
       gzxmud020 LIKE gzxm_t.gzxmud020, #自定義欄位(數字)020
       gzxmud021 LIKE gzxm_t.gzxmud021, #自定義欄位(日期時間)021
       gzxmud022 LIKE gzxm_t.gzxmud022, #自定義欄位(日期時間)022
       gzxmud023 LIKE gzxm_t.gzxmud023, #自定義欄位(日期時間)023
       gzxmud024 LIKE gzxm_t.gzxmud024, #自定義欄位(日期時間)024
       gzxmud025 LIKE gzxm_t.gzxmud025, #自定義欄位(日期時間)025
       gzxmud026 LIKE gzxm_t.gzxmud026, #自定義欄位(日期時間)026
       gzxmud027 LIKE gzxm_t.gzxmud027, #自定義欄位(日期時間)027
       gzxmud028 LIKE gzxm_t.gzxmud028, #自定義欄位(日期時間)028
       gzxmud029 LIKE gzxm_t.gzxmud029, #自定義欄位(日期時間)029
       gzxmud030 LIKE gzxm_t.gzxmud030  #自定義欄位(日期時間)030
   END RECORD
   #161109-00085#37-e
   #161109-00085#37-s
   #DEFINE l_gzxn_t      RECORD LIKE gzxn_t.*
   DEFINE l_gzxn_t RECORD  #查詢方案單身檔
       gzxnent LIKE gzxn_t.gzxnent, #企業編號
       gzxn001 LIKE gzxn_t.gzxn001, #QBE編號
       gzxn002 LIKE gzxn_t.gzxn002, #作業編號
       gzxn003 LIKE gzxn_t.gzxn003, #員工編號
       gzxn004 LIKE gzxn_t.gzxn004, #條件序號
       gzxn005 LIKE gzxn_t.gzxn005, #欄位編號
       gzxn006 LIKE gzxn_t.gzxn006, #運運算元
       gzxn007 LIKE gzxn_t.gzxn007, #簡易條件值
       gzxn008 LIKE gzxn_t.gzxn008, #實際條件值
       gzxn009 LIKE gzxn_t.gzxn009, #條件類型
       gzxnud001 LIKE gzxn_t.gzxnud001, #自定義欄位(文字)001
       gzxnud002 LIKE gzxn_t.gzxnud002, #自定義欄位(文字)002
       gzxnud003 LIKE gzxn_t.gzxnud003, #自定義欄位(文字)003
       gzxnud004 LIKE gzxn_t.gzxnud004, #自定義欄位(文字)004
       gzxnud005 LIKE gzxn_t.gzxnud005, #自定義欄位(文字)005
       gzxnud006 LIKE gzxn_t.gzxnud006, #自定義欄位(文字)006
       gzxnud007 LIKE gzxn_t.gzxnud007, #自定義欄位(文字)007
       gzxnud008 LIKE gzxn_t.gzxnud008, #自定義欄位(文字)008
       gzxnud009 LIKE gzxn_t.gzxnud009, #自定義欄位(文字)009
       gzxnud010 LIKE gzxn_t.gzxnud010, #自定義欄位(文字)010
       gzxnud011 LIKE gzxn_t.gzxnud011, #自定義欄位(數字)011
       gzxnud012 LIKE gzxn_t.gzxnud012, #自定義欄位(數字)012
       gzxnud013 LIKE gzxn_t.gzxnud013, #自定義欄位(數字)013
       gzxnud014 LIKE gzxn_t.gzxnud014, #自定義欄位(數字)014
       gzxnud015 LIKE gzxn_t.gzxnud015, #自定義欄位(數字)015
       gzxnud016 LIKE gzxn_t.gzxnud016, #自定義欄位(數字)016
       gzxnud017 LIKE gzxn_t.gzxnud017, #自定義欄位(數字)017
       gzxnud018 LIKE gzxn_t.gzxnud018, #自定義欄位(數字)018
       gzxnud019 LIKE gzxn_t.gzxnud019, #自定義欄位(數字)019
       gzxnud020 LIKE gzxn_t.gzxnud020, #自定義欄位(數字)020
       gzxnud021 LIKE gzxn_t.gzxnud021, #自定義欄位(日期時間)021
       gzxnud022 LIKE gzxn_t.gzxnud022, #自定義欄位(日期時間)022
       gzxnud023 LIKE gzxn_t.gzxnud023, #自定義欄位(日期時間)023
       gzxnud024 LIKE gzxn_t.gzxnud024, #自定義欄位(日期時間)024
       gzxnud025 LIKE gzxn_t.gzxnud025, #自定義欄位(日期時間)025
       gzxnud026 LIKE gzxn_t.gzxnud026, #自定義欄位(日期時間)026
       gzxnud027 LIKE gzxn_t.gzxnud027, #自定義欄位(日期時間)027
       gzxnud028 LIKE gzxn_t.gzxnud028, #自定義欄位(日期時間)028
       gzxnud029 LIKE gzxn_t.gzxnud029, #自定義欄位(日期時間)029
       gzxnud030 LIKE gzxn_t.gzxnud030, #自定義欄位(日期時間)030
       gzxn010 LIKE gzxn_t.gzxn010  #檔案編號
   END RECORD
   #161109-00085#37-e
   LET r_success = FALSE
   
   DELETE FROM gzxm_t
    WHERE gzxment = g_enterprise
      AND gzxm001 = 1
      AND gzxm002 = 'asfp301_02'
      AND gzxm003 = g_user
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete gzxm_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DELETE FROM gzxn_t
    WHERE gzxnent = g_enterprise
      AND gzxn001 = 1
      AND gzxn002 = 'asfp301_02'
      AND gzxn003 = g_user
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete gzxn_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF   
   
   INITIALIZE l_gzxm_t.* TO NULL
   LET l_gzxm_t.gzxmstus  = 'Y'                   #狀態碼    
   LET l_gzxm_t.gzxment = g_enterprise            #企業編號  
   LET l_gzxm_t.gzxm001 = 1                       #QBE編號   
   LET l_gzxm_t.gzxm002 = 'asfp301_02'            #作業編號  
   LET l_gzxm_t.gzxm003 = g_user                  #員工編號  
   LET l_gzxm_t.gzxm004 = 'Y'                     #是否為預設
   LET l_gzxm_t.gzxm005 = 'N'                     #首頁使用  
   LET l_gzxm_t.gzxm006 = NULL                    #查詢方案來源序號  
   LET l_gzxm_t.gzxm007 = NULL                    #自設WHERE條件     
   LET l_gzxm_t.gzxm008 = NULL                    #分群編號    
   LET l_gzxm_t.gzxmownid = g_user                #資料所有者  
   LET l_gzxm_t.gzxmowndp = g_dept                #資料所屬部門
   LET l_gzxm_t.gzxmcrtid = g_user                #資料建立者  
   LET l_gzxm_t.gzxmcrtdp = g_dept                #資料建立部門
   LET l_gzxm_t.gzxmcrtdt = cl_get_current()      #資料創建日  
   LET l_gzxm_t.gzxmmodid = NULL                  #資料修改者  
   LET l_gzxm_t.gzxmmoddt = NULL                  #最近修改日  
   LET l_gzxm_t.gzxm009 = 1                       #順序       
   
   #161109-00085#37-s
   #INSERT INTO gzxm_t VALUES(l_gzxm_t.*) 
   INSERT INTO gzxm_t( gzxmstus,gzxment,gzxm001,gzxm002,gzxm003,
                       gzxm004,gzxm005,gzxm006,gzxm007,gzxm008,
                       gzxmownid,gzxmowndp,gzxmcrtid,gzxmcrtdp,gzxmcrtdt,
                       gzxmmodid,gzxmmoddt,gzxm009,gzxm010,gzxmud001,
                       gzxmud002,gzxmud003,gzxmud004,gzxmud005,gzxmud006,
                       gzxmud007,gzxmud008,gzxmud009,gzxmud010,gzxmud011,
                       gzxmud012,gzxmud013,gzxmud014,gzxmud015,gzxmud016,
                       gzxmud017,gzxmud018,gzxmud019,gzxmud020,gzxmud021,
                       gzxmud022,gzxmud023,gzxmud024,gzxmud025,gzxmud026,
                       gzxmud027,gzxmud028,gzxmud029,gzxmud030 )
              VALUES (l_gzxm_t.gzxmstus,l_gzxm_t.gzxment,l_gzxm_t.gzxm001,l_gzxm_t.gzxm002,l_gzxm_t.gzxm003,
                      l_gzxm_t.gzxm004,l_gzxm_t.gzxm005,l_gzxm_t.gzxm006,l_gzxm_t.gzxm007,l_gzxm_t.gzxm008,
                      l_gzxm_t.gzxmownid,l_gzxm_t.gzxmowndp,l_gzxm_t.gzxmcrtid,l_gzxm_t.gzxmcrtdp,l_gzxm_t.gzxmcrtdt,
                      l_gzxm_t.gzxmmodid,l_gzxm_t.gzxmmoddt,l_gzxm_t.gzxm009,l_gzxm_t.gzxm010,l_gzxm_t.gzxmud001,
                      l_gzxm_t.gzxmud002,l_gzxm_t.gzxmud003,l_gzxm_t.gzxmud004,l_gzxm_t.gzxmud005,l_gzxm_t.gzxmud006,
                      l_gzxm_t.gzxmud007,l_gzxm_t.gzxmud008,l_gzxm_t.gzxmud009,l_gzxm_t.gzxmud010,l_gzxm_t.gzxmud011,
                      l_gzxm_t.gzxmud012,l_gzxm_t.gzxmud013,l_gzxm_t.gzxmud014,l_gzxm_t.gzxmud015,l_gzxm_t.gzxmud016,
                      l_gzxm_t.gzxmud017,l_gzxm_t.gzxmud018,l_gzxm_t.gzxmud019,l_gzxm_t.gzxmud020,l_gzxm_t.gzxmud021,
                      l_gzxm_t.gzxmud022,l_gzxm_t.gzxmud023,l_gzxm_t.gzxmud024,l_gzxm_t.gzxmud025,l_gzxm_t.gzxmud026,
                      l_gzxm_t.gzxmud027,l_gzxm_t.gzxmud028,l_gzxm_t.gzxmud029,l_gzxm_t.gzxmud030)   
   #161109-00085#37-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert gzxm_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   INITIALIZE l_gzxn_t.* TO NULL
   LET l_gzxn_t.gzxnent = g_enterprise            #企業編號
   LET l_gzxn_t.gzxn001 = 1                       #QBE編號 
   LET l_gzxn_t.gzxn002 = 'asfp301_02'            #作業編號
   LET l_gzxn_t.gzxn003 = g_user                  #員工編號
   LET l_gzxn_t.gzxn004 = 1                       #條件序號
   LET l_gzxn_t.gzxn005 = 'choice1'               #欄位編號
   LET l_gzxn_t.gzxn006 = NULL                    #運算子  
   LET l_gzxn_t.gzxn007 = g_setting.choice1       #條件值1 
   LET l_gzxn_t.gzxn008 = NULL                    #條件值2 

   #161109-00085#37-s
   #INSERT INTO gzxn_t VALUES(l_gzxn_t.*)
   INSERT INTO gzxn_t (gzxnent,gzxn001,gzxn002,gzxn003,gzxn004,
                       gzxn005,gzxn006,gzxn007,gzxn008,gzxn009,
                       gzxnud001,gzxnud002,gzxnud003,gzxnud004,gzxnud005,
                       gzxnud006,gzxnud007,gzxnud008,gzxnud009,gzxnud010,
                       gzxnud011,gzxnud012,gzxnud013,gzxnud014,gzxnud015,
                       gzxnud016,gzxnud017,gzxnud018,gzxnud019,gzxnud020,
                       gzxnud021,gzxnud022,gzxnud023,gzxnud024,gzxnud025,
                       gzxnud026,gzxnud027,gzxnud028,gzxnud029,gzxnud030,
                       gzxn010) 
               VALUES (l_gzxn_t.gzxnent,l_gzxn_t.gzxn001,l_gzxn_t.gzxn002,l_gzxn_t.gzxn003,l_gzxn_t.gzxn004,
                       l_gzxn_t.gzxn005,l_gzxn_t.gzxn006,l_gzxn_t.gzxn007,l_gzxn_t.gzxn008,l_gzxn_t.gzxn009,
                       l_gzxn_t.gzxnud001,l_gzxn_t.gzxnud002,l_gzxn_t.gzxnud003,l_gzxn_t.gzxnud004,l_gzxn_t.gzxnud005,
                       l_gzxn_t.gzxnud006,l_gzxn_t.gzxnud007,l_gzxn_t.gzxnud008,l_gzxn_t.gzxnud009,l_gzxn_t.gzxnud010,
                       l_gzxn_t.gzxnud011,l_gzxn_t.gzxnud012,l_gzxn_t.gzxnud013,l_gzxn_t.gzxnud014,l_gzxn_t.gzxnud015,
                       l_gzxn_t.gzxnud016,l_gzxn_t.gzxnud017,l_gzxn_t.gzxnud018,l_gzxn_t.gzxnud019,l_gzxn_t.gzxnud020,
                       l_gzxn_t.gzxnud021,l_gzxn_t.gzxnud022,l_gzxn_t.gzxnud023,l_gzxn_t.gzxnud024,l_gzxn_t.gzxnud025,
                       l_gzxn_t.gzxnud026,l_gzxn_t.gzxnud027,l_gzxn_t.gzxnud028,l_gzxn_t.gzxnud029,l_gzxn_t.gzxnud030,
                       l_gzxn_t.gzxn010)    
   #161109-00085#37-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert gzxn_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET l_gzxn_t.gzxn004 = 2                       #條件序號
   LET l_gzxn_t.gzxn005 = 'choice2'               #欄位編號
   LET l_gzxn_t.gzxn007 = g_setting.choice2       #條件值1 

   #161109-00085#37-s
   #INSERT INTO gzxn_t VALUES(l_gzxn_t.*)
   INSERT INTO gzxn_t (gzxnent,gzxn001,gzxn002,gzxn003,gzxn004,
                       gzxn005,gzxn006,gzxn007,gzxn008,gzxn009,
                       gzxnud001,gzxnud002,gzxnud003,gzxnud004,gzxnud005,
                       gzxnud006,gzxnud007,gzxnud008,gzxnud009,gzxnud010,
                       gzxnud011,gzxnud012,gzxnud013,gzxnud014,gzxnud015,
                       gzxnud016,gzxnud017,gzxnud018,gzxnud019,gzxnud020,
                       gzxnud021,gzxnud022,gzxnud023,gzxnud024,gzxnud025,
                       gzxnud026,gzxnud027,gzxnud028,gzxnud029,gzxnud030,
                       gzxn010) 
               VALUES (l_gzxn_t.gzxnent,l_gzxn_t.gzxn001,l_gzxn_t.gzxn002,l_gzxn_t.gzxn003,l_gzxn_t.gzxn004,
                       l_gzxn_t.gzxn005,l_gzxn_t.gzxn006,l_gzxn_t.gzxn007,l_gzxn_t.gzxn008,l_gzxn_t.gzxn009,
                       l_gzxn_t.gzxnud001,l_gzxn_t.gzxnud002,l_gzxn_t.gzxnud003,l_gzxn_t.gzxnud004,l_gzxn_t.gzxnud005,
                       l_gzxn_t.gzxnud006,l_gzxn_t.gzxnud007,l_gzxn_t.gzxnud008,l_gzxn_t.gzxnud009,l_gzxn_t.gzxnud010,
                       l_gzxn_t.gzxnud011,l_gzxn_t.gzxnud012,l_gzxn_t.gzxnud013,l_gzxn_t.gzxnud014,l_gzxn_t.gzxnud015,
                       l_gzxn_t.gzxnud016,l_gzxn_t.gzxnud017,l_gzxn_t.gzxnud018,l_gzxn_t.gzxnud019,l_gzxn_t.gzxnud020,
                       l_gzxn_t.gzxnud021,l_gzxn_t.gzxnud022,l_gzxn_t.gzxnud023,l_gzxn_t.gzxnud024,l_gzxn_t.gzxnud025,
                       l_gzxn_t.gzxnud026,l_gzxn_t.gzxnud027,l_gzxn_t.gzxnud028,l_gzxn_t.gzxnud029,l_gzxn_t.gzxnud030,
                       l_gzxn_t.gzxn010)    
   #161109-00085#37-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert gzxn_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   LET l_gzxn_t.gzxn004 = 3                       #條件序號
   LET l_gzxn_t.gzxn005 = 'choice3'               #欄位編號
   LET l_gzxn_t.gzxn007 = g_setting.choice3       #條件值1 

   #161109-00085#37-s
   #INSERT INTO gzxn_t VALUES(l_gzxn_t.*)
   INSERT INTO gzxn_t (gzxnent,gzxn001,gzxn002,gzxn003,gzxn004,
                       gzxn005,gzxn006,gzxn007,gzxn008,gzxn009,
                       gzxnud001,gzxnud002,gzxnud003,gzxnud004,gzxnud005,
                       gzxnud006,gzxnud007,gzxnud008,gzxnud009,gzxnud010,
                       gzxnud011,gzxnud012,gzxnud013,gzxnud014,gzxnud015,
                       gzxnud016,gzxnud017,gzxnud018,gzxnud019,gzxnud020,
                       gzxnud021,gzxnud022,gzxnud023,gzxnud024,gzxnud025,
                       gzxnud026,gzxnud027,gzxnud028,gzxnud029,gzxnud030,
                       gzxn010) 
               VALUES (l_gzxn_t.gzxnent,l_gzxn_t.gzxn001,l_gzxn_t.gzxn002,l_gzxn_t.gzxn003,l_gzxn_t.gzxn004,
                       l_gzxn_t.gzxn005,l_gzxn_t.gzxn006,l_gzxn_t.gzxn007,l_gzxn_t.gzxn008,l_gzxn_t.gzxn009,
                       l_gzxn_t.gzxnud001,l_gzxn_t.gzxnud002,l_gzxn_t.gzxnud003,l_gzxn_t.gzxnud004,l_gzxn_t.gzxnud005,
                       l_gzxn_t.gzxnud006,l_gzxn_t.gzxnud007,l_gzxn_t.gzxnud008,l_gzxn_t.gzxnud009,l_gzxn_t.gzxnud010,
                       l_gzxn_t.gzxnud011,l_gzxn_t.gzxnud012,l_gzxn_t.gzxnud013,l_gzxn_t.gzxnud014,l_gzxn_t.gzxnud015,
                       l_gzxn_t.gzxnud016,l_gzxn_t.gzxnud017,l_gzxn_t.gzxnud018,l_gzxn_t.gzxnud019,l_gzxn_t.gzxnud020,
                       l_gzxn_t.gzxnud021,l_gzxn_t.gzxnud022,l_gzxn_t.gzxnud023,l_gzxn_t.gzxnud024,l_gzxn_t.gzxnud025,
                       l_gzxn_t.gzxnud026,l_gzxn_t.gzxnud027,l_gzxn_t.gzxnud028,l_gzxn_t.gzxnud029,l_gzxn_t.gzxnud030,
                       l_gzxn_t.gzxn010)    
   #161109-00085#37-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert gzxn_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET l_gzxn_t.gzxn004 = 4                       #條件序號
   LET l_gzxn_t.gzxn005 = 'choice4'               #欄位編號
   LET l_gzxn_t.gzxn007 = g_setting.choice4       #條件值1 

   #161109-00085#37-s
   #INSERT INTO gzxn_t VALUES(l_gzxn_t.*)
   INSERT INTO gzxn_t (gzxnent,gzxn001,gzxn002,gzxn003,gzxn004,
                       gzxn005,gzxn006,gzxn007,gzxn008,gzxn009,
                       gzxnud001,gzxnud002,gzxnud003,gzxnud004,gzxnud005,
                       gzxnud006,gzxnud007,gzxnud008,gzxnud009,gzxnud010,
                       gzxnud011,gzxnud012,gzxnud013,gzxnud014,gzxnud015,
                       gzxnud016,gzxnud017,gzxnud018,gzxnud019,gzxnud020,
                       gzxnud021,gzxnud022,gzxnud023,gzxnud024,gzxnud025,
                       gzxnud026,gzxnud027,gzxnud028,gzxnud029,gzxnud030,
                       gzxn010) 
               VALUES (l_gzxn_t.gzxnent,l_gzxn_t.gzxn001,l_gzxn_t.gzxn002,l_gzxn_t.gzxn003,l_gzxn_t.gzxn004,
                       l_gzxn_t.gzxn005,l_gzxn_t.gzxn006,l_gzxn_t.gzxn007,l_gzxn_t.gzxn008,l_gzxn_t.gzxn009,
                       l_gzxn_t.gzxnud001,l_gzxn_t.gzxnud002,l_gzxn_t.gzxnud003,l_gzxn_t.gzxnud004,l_gzxn_t.gzxnud005,
                       l_gzxn_t.gzxnud006,l_gzxn_t.gzxnud007,l_gzxn_t.gzxnud008,l_gzxn_t.gzxnud009,l_gzxn_t.gzxnud010,
                       l_gzxn_t.gzxnud011,l_gzxn_t.gzxnud012,l_gzxn_t.gzxnud013,l_gzxn_t.gzxnud014,l_gzxn_t.gzxnud015,
                       l_gzxn_t.gzxnud016,l_gzxn_t.gzxnud017,l_gzxn_t.gzxnud018,l_gzxn_t.gzxnud019,l_gzxn_t.gzxnud020,
                       l_gzxn_t.gzxnud021,l_gzxn_t.gzxnud022,l_gzxn_t.gzxnud023,l_gzxn_t.gzxnud024,l_gzxn_t.gzxnud025,
                       l_gzxn_t.gzxnud026,l_gzxn_t.gzxnud027,l_gzxn_t.gzxnud028,l_gzxn_t.gzxnud029,l_gzxn_t.gzxnud030,
                       l_gzxn_t.gzxn010)    
   #161109-00085#37-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert gzxn_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   LET l_gzxn_t.gzxn004 = 5                       #條件序號
   LET l_gzxn_t.gzxn005 = 'choice5'               #欄位編號
   LET l_gzxn_t.gzxn007 = g_setting.choice5       #條件值1 

   #161109-00085#37-s
   #INSERT INTO gzxn_t VALUES(l_gzxn_t.*)
   INSERT INTO gzxn_t (gzxnent,gzxn001,gzxn002,gzxn003,gzxn004,
                       gzxn005,gzxn006,gzxn007,gzxn008,gzxn009,
                       gzxnud001,gzxnud002,gzxnud003,gzxnud004,gzxnud005,
                       gzxnud006,gzxnud007,gzxnud008,gzxnud009,gzxnud010,
                       gzxnud011,gzxnud012,gzxnud013,gzxnud014,gzxnud015,
                       gzxnud016,gzxnud017,gzxnud018,gzxnud019,gzxnud020,
                       gzxnud021,gzxnud022,gzxnud023,gzxnud024,gzxnud025,
                       gzxnud026,gzxnud027,gzxnud028,gzxnud029,gzxnud030,
                       gzxn010) 
               VALUES (l_gzxn_t.gzxnent,l_gzxn_t.gzxn001,l_gzxn_t.gzxn002,l_gzxn_t.gzxn003,l_gzxn_t.gzxn004,
                       l_gzxn_t.gzxn005,l_gzxn_t.gzxn006,l_gzxn_t.gzxn007,l_gzxn_t.gzxn008,l_gzxn_t.gzxn009,
                       l_gzxn_t.gzxnud001,l_gzxn_t.gzxnud002,l_gzxn_t.gzxnud003,l_gzxn_t.gzxnud004,l_gzxn_t.gzxnud005,
                       l_gzxn_t.gzxnud006,l_gzxn_t.gzxnud007,l_gzxn_t.gzxnud008,l_gzxn_t.gzxnud009,l_gzxn_t.gzxnud010,
                       l_gzxn_t.gzxnud011,l_gzxn_t.gzxnud012,l_gzxn_t.gzxnud013,l_gzxn_t.gzxnud014,l_gzxn_t.gzxnud015,
                       l_gzxn_t.gzxnud016,l_gzxn_t.gzxnud017,l_gzxn_t.gzxnud018,l_gzxn_t.gzxnud019,l_gzxn_t.gzxnud020,
                       l_gzxn_t.gzxnud021,l_gzxn_t.gzxnud022,l_gzxn_t.gzxnud023,l_gzxn_t.gzxnud024,l_gzxn_t.gzxnud025,
                       l_gzxn_t.gzxnud026,l_gzxn_t.gzxnud027,l_gzxn_t.gzxnud028,l_gzxn_t.gzxnud029,l_gzxn_t.gzxnud030,
                       l_gzxn_t.gzxn010)    
   #161109-00085#37-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert gzxn_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET l_gzxn_t.gzxn004 = 6                       #條件序號
   LET l_gzxn_t.gzxn005 = 'choice6'               #欄位編號
   LET l_gzxn_t.gzxn007 = g_setting.choice6       #條件值1 

   #161109-00085#37-s
   #INSERT INTO gzxn_t VALUES(l_gzxn_t.*)
   INSERT INTO gzxn_t (gzxnent,gzxn001,gzxn002,gzxn003,gzxn004,
                       gzxn005,gzxn006,gzxn007,gzxn008,gzxn009,
                       gzxnud001,gzxnud002,gzxnud003,gzxnud004,gzxnud005,
                       gzxnud006,gzxnud007,gzxnud008,gzxnud009,gzxnud010,
                       gzxnud011,gzxnud012,gzxnud013,gzxnud014,gzxnud015,
                       gzxnud016,gzxnud017,gzxnud018,gzxnud019,gzxnud020,
                       gzxnud021,gzxnud022,gzxnud023,gzxnud024,gzxnud025,
                       gzxnud026,gzxnud027,gzxnud028,gzxnud029,gzxnud030,
                       gzxn010) 
               VALUES (l_gzxn_t.gzxnent,l_gzxn_t.gzxn001,l_gzxn_t.gzxn002,l_gzxn_t.gzxn003,l_gzxn_t.gzxn004,
                       l_gzxn_t.gzxn005,l_gzxn_t.gzxn006,l_gzxn_t.gzxn007,l_gzxn_t.gzxn008,l_gzxn_t.gzxn009,
                       l_gzxn_t.gzxnud001,l_gzxn_t.gzxnud002,l_gzxn_t.gzxnud003,l_gzxn_t.gzxnud004,l_gzxn_t.gzxnud005,
                       l_gzxn_t.gzxnud006,l_gzxn_t.gzxnud007,l_gzxn_t.gzxnud008,l_gzxn_t.gzxnud009,l_gzxn_t.gzxnud010,
                       l_gzxn_t.gzxnud011,l_gzxn_t.gzxnud012,l_gzxn_t.gzxnud013,l_gzxn_t.gzxnud014,l_gzxn_t.gzxnud015,
                       l_gzxn_t.gzxnud016,l_gzxn_t.gzxnud017,l_gzxn_t.gzxnud018,l_gzxn_t.gzxnud019,l_gzxn_t.gzxnud020,
                       l_gzxn_t.gzxnud021,l_gzxn_t.gzxnud022,l_gzxn_t.gzxnud023,l_gzxn_t.gzxnud024,l_gzxn_t.gzxnud025,
                       l_gzxn_t.gzxnud026,l_gzxn_t.gzxnud027,l_gzxn_t.gzxnud028,l_gzxn_t.gzxnud029,l_gzxn_t.gzxnud030,
                       l_gzxn_t.gzxn010)    
   #161109-00085#37-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert gzxn_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   LET l_gzxn_t.gzxn004 = 7                       #條件序號
   LET l_gzxn_t.gzxn005 = 'choice7'               #欄位編號
   LET l_gzxn_t.gzxn007 = g_setting.choice7       #條件值1 

   #161109-00085#37-s
   #INSERT INTO gzxn_t VALUES(l_gzxn_t.*)
   INSERT INTO gzxn_t (gzxnent,gzxn001,gzxn002,gzxn003,gzxn004,
                       gzxn005,gzxn006,gzxn007,gzxn008,gzxn009,
                       gzxnud001,gzxnud002,gzxnud003,gzxnud004,gzxnud005,
                       gzxnud006,gzxnud007,gzxnud008,gzxnud009,gzxnud010,
                       gzxnud011,gzxnud012,gzxnud013,gzxnud014,gzxnud015,
                       gzxnud016,gzxnud017,gzxnud018,gzxnud019,gzxnud020,
                       gzxnud021,gzxnud022,gzxnud023,gzxnud024,gzxnud025,
                       gzxnud026,gzxnud027,gzxnud028,gzxnud029,gzxnud030,
                       gzxn010) 
               VALUES (l_gzxn_t.gzxnent,l_gzxn_t.gzxn001,l_gzxn_t.gzxn002,l_gzxn_t.gzxn003,l_gzxn_t.gzxn004,
                       l_gzxn_t.gzxn005,l_gzxn_t.gzxn006,l_gzxn_t.gzxn007,l_gzxn_t.gzxn008,l_gzxn_t.gzxn009,
                       l_gzxn_t.gzxnud001,l_gzxn_t.gzxnud002,l_gzxn_t.gzxnud003,l_gzxn_t.gzxnud004,l_gzxn_t.gzxnud005,
                       l_gzxn_t.gzxnud006,l_gzxn_t.gzxnud007,l_gzxn_t.gzxnud008,l_gzxn_t.gzxnud009,l_gzxn_t.gzxnud010,
                       l_gzxn_t.gzxnud011,l_gzxn_t.gzxnud012,l_gzxn_t.gzxnud013,l_gzxn_t.gzxnud014,l_gzxn_t.gzxnud015,
                       l_gzxn_t.gzxnud016,l_gzxn_t.gzxnud017,l_gzxn_t.gzxnud018,l_gzxn_t.gzxnud019,l_gzxn_t.gzxnud020,
                       l_gzxn_t.gzxnud021,l_gzxn_t.gzxnud022,l_gzxn_t.gzxnud023,l_gzxn_t.gzxnud024,l_gzxn_t.gzxnud025,
                       l_gzxn_t.gzxnud026,l_gzxn_t.gzxnud027,l_gzxn_t.gzxnud028,l_gzxn_t.gzxnud029,l_gzxn_t.gzxnud030,
                       l_gzxn_t.gzxn010)    
   #161109-00085#37-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert gzxn_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF

   LET l_gzxn_t.gzxn004 = 8                       #條件序號
   LET l_gzxn_t.gzxn005 = 'choice8'               #欄位編號
   LET l_gzxn_t.gzxn007 = g_setting.choice8       #條件值1 

   #161109-00085#37-s
   #INSERT INTO gzxn_t VALUES(l_gzxn_t.*)
   INSERT INTO gzxn_t (gzxnent,gzxn001,gzxn002,gzxn003,gzxn004,
                       gzxn005,gzxn006,gzxn007,gzxn008,gzxn009,
                       gzxnud001,gzxnud002,gzxnud003,gzxnud004,gzxnud005,
                       gzxnud006,gzxnud007,gzxnud008,gzxnud009,gzxnud010,
                       gzxnud011,gzxnud012,gzxnud013,gzxnud014,gzxnud015,
                       gzxnud016,gzxnud017,gzxnud018,gzxnud019,gzxnud020,
                       gzxnud021,gzxnud022,gzxnud023,gzxnud024,gzxnud025,
                       gzxnud026,gzxnud027,gzxnud028,gzxnud029,gzxnud030,
                       gzxn010) 
               VALUES (l_gzxn_t.gzxnent,l_gzxn_t.gzxn001,l_gzxn_t.gzxn002,l_gzxn_t.gzxn003,l_gzxn_t.gzxn004,
                       l_gzxn_t.gzxn005,l_gzxn_t.gzxn006,l_gzxn_t.gzxn007,l_gzxn_t.gzxn008,l_gzxn_t.gzxn009,
                       l_gzxn_t.gzxnud001,l_gzxn_t.gzxnud002,l_gzxn_t.gzxnud003,l_gzxn_t.gzxnud004,l_gzxn_t.gzxnud005,
                       l_gzxn_t.gzxnud006,l_gzxn_t.gzxnud007,l_gzxn_t.gzxnud008,l_gzxn_t.gzxnud009,l_gzxn_t.gzxnud010,
                       l_gzxn_t.gzxnud011,l_gzxn_t.gzxnud012,l_gzxn_t.gzxnud013,l_gzxn_t.gzxnud014,l_gzxn_t.gzxnud015,
                       l_gzxn_t.gzxnud016,l_gzxn_t.gzxnud017,l_gzxn_t.gzxnud018,l_gzxn_t.gzxnud019,l_gzxn_t.gzxnud020,
                       l_gzxn_t.gzxnud021,l_gzxn_t.gzxnud022,l_gzxn_t.gzxnud023,l_gzxn_t.gzxnud024,l_gzxn_t.gzxnud025,
                       l_gzxn_t.gzxnud026,l_gzxn_t.gzxnud027,l_gzxn_t.gzxnud028,l_gzxn_t.gzxnud029,l_gzxn_t.gzxnud030,
                       l_gzxn_t.gzxn010)    
   #161109-00085#37-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert gzxn_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF


   LET l_gzxn_t.gzxn004 = 9                       #條件序號
   LET l_gzxn_t.gzxn005 = 'choice9'               #欄位編號
   LET l_gzxn_t.gzxn007 = g_setting.choice9       #條件值1 

   #161109-00085#37-s
   #INSERT INTO gzxn_t VALUES(l_gzxn_t.*)
   INSERT INTO gzxn_t (gzxnent,gzxn001,gzxn002,gzxn003,gzxn004,
                       gzxn005,gzxn006,gzxn007,gzxn008,gzxn009,
                       gzxnud001,gzxnud002,gzxnud003,gzxnud004,gzxnud005,
                       gzxnud006,gzxnud007,gzxnud008,gzxnud009,gzxnud010,
                       gzxnud011,gzxnud012,gzxnud013,gzxnud014,gzxnud015,
                       gzxnud016,gzxnud017,gzxnud018,gzxnud019,gzxnud020,
                       gzxnud021,gzxnud022,gzxnud023,gzxnud024,gzxnud025,
                       gzxnud026,gzxnud027,gzxnud028,gzxnud029,gzxnud030,
                       gzxn010) 
               VALUES (l_gzxn_t.gzxnent,l_gzxn_t.gzxn001,l_gzxn_t.gzxn002,l_gzxn_t.gzxn003,l_gzxn_t.gzxn004,
                       l_gzxn_t.gzxn005,l_gzxn_t.gzxn006,l_gzxn_t.gzxn007,l_gzxn_t.gzxn008,l_gzxn_t.gzxn009,
                       l_gzxn_t.gzxnud001,l_gzxn_t.gzxnud002,l_gzxn_t.gzxnud003,l_gzxn_t.gzxnud004,l_gzxn_t.gzxnud005,
                       l_gzxn_t.gzxnud006,l_gzxn_t.gzxnud007,l_gzxn_t.gzxnud008,l_gzxn_t.gzxnud009,l_gzxn_t.gzxnud010,
                       l_gzxn_t.gzxnud011,l_gzxn_t.gzxnud012,l_gzxn_t.gzxnud013,l_gzxn_t.gzxnud014,l_gzxn_t.gzxnud015,
                       l_gzxn_t.gzxnud016,l_gzxn_t.gzxnud017,l_gzxn_t.gzxnud018,l_gzxn_t.gzxnud019,l_gzxn_t.gzxnud020,
                       l_gzxn_t.gzxnud021,l_gzxn_t.gzxnud022,l_gzxn_t.gzxnud023,l_gzxn_t.gzxnud024,l_gzxn_t.gzxnud025,
                       l_gzxn_t.gzxnud026,l_gzxn_t.gzxnud027,l_gzxn_t.gzxnud028,l_gzxn_t.gzxnud029,l_gzxn_t.gzxnud030,
                       l_gzxn_t.gzxn010)    
   #161109-00085#37-e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert gzxn_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   

   
   #保存数据完成
   INITIALIZE g_errparam TO NULL
   LET g_errparam.code = 'aps-00023'
   LET g_errparam.popup = TRUE
   CALL cl_err()
   
   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION

PRIVATE FUNCTION asfp301_02_set_entry_b()
   CALL cl_set_comp_entry("choice2,choice3,choice4,choice5,choice8,choice9",TRUE)
   
END FUNCTION

PRIVATE FUNCTION asfp301_02_set_no_entry_b()
   IF g_setting.choice1 = '1' THEN
      CALL cl_set_comp_entry("choice2,choice3,choice4,choice5",FALSE)
   END IF

   IF g_setting.choice7 = 'N' THEN
      LET g_setting.choice9 = 'N'
      CALL cl_set_comp_entry("choice8,choice9",FALSE)
   END IF
END FUNCTION

 
{</section>}
 
