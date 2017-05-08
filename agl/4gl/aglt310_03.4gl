#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt310_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2013-10-23 10:18:47), PR版次:0002(2015-01-27 16:36:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000320
#+ Filename...: aglt310_03
#+ Description: 自由核算项维护
#+ Creator....: 02298(2013-08-27 09:24:03)
#+ Modifier...: 02298 -SD/PR- 02599
 
{</section>}
 
{<section id="aglt310_03.global" >}
#應用 c01b 樣板自動產生(Version:10)
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
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_glaq_m        RECORD
       glaq029 LIKE glaq_t.glaq029, 
   glaq029_desc LIKE type_t.chr80, 
   glaq030 LIKE glaq_t.glaq030, 
   glaq030_desc LIKE type_t.chr80, 
   glaq031 LIKE glaq_t.glaq031, 
   glaq031_desc LIKE type_t.chr80, 
   glaq032 LIKE glaq_t.glaq032, 
   glaq032_desc LIKE type_t.chr80, 
   glaq033 LIKE glaq_t.glaq033, 
   glaq033_desc LIKE type_t.chr80, 
   glaq034 LIKE glaq_t.glaq034, 
   glaq034_desc LIKE type_t.chr80, 
   glaq035 LIKE glaq_t.glaq035, 
   glaq035_desc LIKE type_t.chr80, 
   glaq036 LIKE glaq_t.glaq036, 
   glaq036_desc LIKE type_t.chr80, 
   glaq037 LIKE glaq_t.glaq037, 
   glaq037_desc LIKE type_t.chr80, 
   glaq038 LIKE glaq_t.glaq038, 
   glaq038_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaq_m_t       type_g_glaq_m
 #是否做自由科目核算项管理
   DEFINE g_glad017       LIKE glad_t.glad017
   DEFINE g_glad0171       LIKE glad_t.glad0171 
   DEFINE g_glad0172       LIKE glad_t.glad0172 
   DEFINE g_glad018       LIKE glad_t.glad018
   DEFINE g_glad0181       LIKE glad_t.glad0181
   DEFINE g_glad0182       LIKE glad_t.glad0182
   DEFINE g_glad019       LIKE glad_t.glad019
   DEFINE g_glad0191       LIKE glad_t.glad0191
   DEFINE g_glad0192       LIKE glad_t.glad0192
   DEFINE g_glad020       LIKE glad_t.glad020
   DEFINE g_glad0201       LIKE glad_t.glad0201
   DEFINE g_glad0202       LIKE glad_t.glad0202
   DEFINE g_glad021       LIKE glad_t.glad021
   DEFINE g_glad0211       LIKE glad_t.glad0211
   DEFINE g_glad0212       LIKE glad_t.glad0212
   DEFINE g_glad022       LIKE glad_t.glad022
   DEFINE g_glad0221       LIKE glad_t.glad0221
   DEFINE g_glad0222       LIKE glad_t.glad0222
   DEFINE g_glad023       LIKE glad_t.glad023
   DEFINE g_glad0231       LIKE glad_t.glad0231
   DEFINE g_glad0232       LIKE glad_t.glad0232
   DEFINE g_glad024       LIKE glad_t.glad024
   DEFINE g_glad0241       LIKE glad_t.glad0241
   DEFINE g_glad0242       LIKE glad_t.glad0242
   DEFINE g_glad025       LIKE glad_t.glad025
   DEFINE g_glad0251       LIKE glad_t.glad0251
   DEFINE g_glad0252       LIKE glad_t.glad0252
   DEFINE g_glad026       LIKE glad_t.glad026
   DEFINE g_glad0261       LIKE glad_t.glad0261
   DEFINE g_glad0262       LIKE glad_t.glad0262
   #开窗编号
   DEFINE g_glae009        LIKE glae_t.glae009
   DEFINE g_glae002        LIKE glae_t.glae002
#end add-point
 
DEFINE g_glaq_m        type_g_glaq_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglt310_03.input" >}
#+ 資料輸入
PUBLIC FUNCTION aglt310_03(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_glapld,p_glapdocno,p_glaqseq,p_glaq002,p_prog,p_glcf001,p_glcf002,p_glcf004
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
   DEFINE p_glapld        LIKE glap_t.glapld      #帐别
   DEFINE p_glapdocno     LIKE glap_t.glapdocno   #传票编号
   DEFINE p_glaqseq       LIKE glaq_t.glaqseq     #项次
   DEFINE p_glaq002       LIKE glaq_t.glaq002     #科目
   DEFINE p_prog          LIKE type_t.chr80       #程式编号
   DEFINE p_glcf001       LIKE glcf_t.glcf004     #年度
   DEFINE p_glcf002       LIKE glcf_t.glcf004     #期別
   DEFINE p_glcf004       LIKE glcf_t.glcf004     #組合碼
   DEFINE r_success       LIKE type_t.num5        #返回参数
   DEFINE l_errno          LIKE type_t.chr10
   #记录隐藏栏位标示
   DEFINE l_flag1         LIKE type_t.num5
   DEFINE l_flag2         LIKE type_t.num5   
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aglt310_03 WITH FORM cl_ap_formpath("agl","aglt310_03")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET l_flag1=0
   LET l_flag2=0
   INITIALIZE g_glaq_m.* TO NULL
   #资料检查
   IF cl_null(p_glapld) OR cl_null(p_glapdocno) OR cl_null(p_glaqseq) OR cl_null(p_glaq002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -400
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF 
   INITIALIZE g_glaq_m TO NULL
   INITIALIZE g_glaq_m_t TO NULL
    #总体说明：若启用该核算项管理则对应控制方式为2.必须输入不检查，3.必须输入必检查，则栏位不可空白，为1时可以空白，否则栏位不可进去
   SELECT glad017,glad0171,glad0172,glad018,glad0181,glad0182,
          glad019,glad0191,glad0192,glad020,glad0201,glad0202,
          glad021,glad0211,glad0212,glad022,glad0221,glad0222,
          glad023,glad0231,glad0232,glad024,glad0221,glad0242,
          glad025,glad0251,glad0252,glad026,glad0261,glad0262
    INTO  g_glad017,g_glad0171,g_glad0172,g_glad018,g_glad0181,g_glad0182,
          g_glad019,g_glad0191,g_glad0192,g_glad020,g_glad0201,g_glad0202,
          g_glad021,g_glad0211,g_glad0212,g_glad022,g_glad0221,g_glad0222,
          g_glad023,g_glad0231,g_glad0232,g_glad024,g_glad0241,g_glad0242,
          g_glad025,g_glad0251,g_glad0252,g_glad026,g_glad0261,g_glad0262
    FROM  glad_t
    WHERE gladent = g_enterprise
      AND gladld = p_glapld
      AND glad001 = p_glaq002

   #啟用自由核算項一
   IF g_glad017 = 'Y'  THEN
      CALL cl_set_comp_entry('glaq029',TRUE)
      IF g_glad0172 MATCHES'[23]' THEN
         CALL cl_set_comp_required('glaq029',TRUE)
      END IF
   ELSE
      CALL cl_set_comp_visible('glaq029,glaq029_desc','FALSE')
      LET l_flag1 = l_flag1+1   
   END IF

   #啟用自由核算項二
   IF g_glad018 = 'Y'  THEN
      CALL cl_set_comp_entry('glaq030',TRUE)
      IF g_glad0182 MATCHES'[23]' THEN
         CALL cl_set_comp_required('glaq030',TRUE)
      END IF
   ELSE
      CALL cl_set_comp_visible('glaq030,glaq030_desc','FALSE')
      LET l_flag1 = l_flag1+1   
   END IF

   #啟用自由核算項三
   IF g_glad019 = 'Y'  THEN
       CALL cl_set_comp_entry('glaq031',TRUE)
      IF g_glad0192 MATCHES'[23]' THEN
         CALL cl_set_comp_required('glaq031',TRUE)
      END IF
   ELSE
      CALL cl_set_comp_visible('glaq031,glaq031_desc','FALSE')
      LET l_flag1 = l_flag1+1   
   END IF

   #啟用自由核算項四
   IF g_glad020 = 'Y'  THEN
      CALL cl_set_comp_entry('glaq032',TRUE)
      IF g_glad0202 MATCHES'[23]' THEN
         CALL cl_set_comp_required('glaq032',TRUE)
      END IF
   ELSE
      CALL cl_set_comp_visible('glaq032,glaq032_desc','FALSE')
      LET l_flag1 = l_flag1+1   
   END IF

   #啟用自由核算項五
   IF g_glad021 = 'Y'  THEN
      CALL cl_set_comp_entry('glaq033',TRUE)
      IF g_glad0212 MATCHES'[23]' THEN
         CALL cl_set_comp_required('glaq033',TRUE)
      END IF
   ELSE
      CALL cl_set_comp_visible('glaq033,glaq033_desc','FALSE')
      LET l_flag1 = l_flag1+1   
      #如果该页签上的栏位都已隐藏，则隐藏该grid
       IF l_flag1 = 5 THEN
          CALL cl_set_comp_visible('grid3',FALSE)
       END IF  
   END IF

   #啟用自由核算項六
   IF g_glad022 = 'Y'  THEN
      CALL cl_set_comp_entry('glaq034',TRUE)
      IF g_glad0222 MATCHES'[23]' THEN
         CALL cl_set_comp_required('glaq034',TRUE)
      END IF
   ELSE
      CALL cl_set_comp_visible('glaq034,glaq034_desc',FALSE)
      LET l_flag2 = l_flag2+1   
   END IF

   #啟用自由核算項七
   IF g_glad023 = 'Y'  THEN
      CALL cl_set_comp_entry('glaq035',TRUE)
      IF g_glad0232 MATCHES'[23]' THEN
         CALL cl_set_comp_required('glaq035',TRUE)
      END IF
   ELSE
      CALL cl_set_comp_visible('glaq035,glaq035_desc',FALSE)
      LET l_flag2 = l_flag2+1  
   END IF

   #啟用自由核算項八
   IF g_glad024 = 'Y'  THEN
      CALL cl_set_comp_entry('glaq036',TRUE)
      IF g_glad0242 MATCHES'[23]' THEN
         CALL cl_set_comp_required('glaq036',TRUE)
      END IF
   ELSE
      CALL cl_set_comp_visible('glaq036,glaq036_desc',FALSE)
      LET l_flag2 = l_flag2+1  
   END IF

   #啟用自由核算項九
   IF g_glad025 = 'Y'  THEN
      CALL cl_set_comp_entry('glaq037',TRUE)
      IF g_glad0252 MATCHES'[23]' THEN
         CALL cl_set_comp_required('glaq037',TRUE)
      END IF
   ELSE
      CALL cl_set_comp_visible('glaq037,glaq037_desc',FALSE)
      LET l_flag2 = l_flag2+1  
   END IF

   #啟用自由核算項十
   IF g_glad026 = 'Y'  THEN
      CALL cl_set_comp_entry('glaq038',TRUE)
      IF g_glad0262 MATCHES'[23]' THEN
         CALL cl_set_comp_required('glaq038',TRUE)
      END IF
   ELSE
      CALL cl_set_comp_visible('glaq038,glaq038_desc',FALSE)
      LET l_flag2 = l_flag2+1
      #如果该页签上的栏位都已隐藏，则隐藏该grid
       IF l_flag2 = 5 THEN
          CALL cl_set_comp_visible('grid4',FALSE)
       END IF        
   END IF
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glaq_m.glaq029,g_glaq_m.glaq030,g_glaq_m.glaq031,g_glaq_m.glaq032,g_glaq_m.glaq033, 
          g_glaq_m.glaq034,g_glaq_m.glaq035,g_glaq_m.glaq036,g_glaq_m.glaq037,g_glaq_m.glaq038 ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            #录入前，若有资料先抓取显示
            IF p_prog = "aglt310" THEN
               SELECT glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038
                 INTO g_glaq_m.glaq029,g_glaq_m.glaq030,g_glaq_m.glaq031,g_glaq_m.glaq032,g_glaq_m.glaq033,
                      g_glaq_m.glaq034,g_glaq_m.glaq035,g_glaq_m.glaq036,g_glaq_m.glaq037,g_glaq_m.glaq038
                 FROM glaq_t
                WHERE glaqent = g_enterprise
                  AND glaqld = p_glapld
                  AND glaqdocno = p_glapdocno
                  AND glaqseq = p_glaqseq
            END IF
            IF p_prog = "aglt400" THEN
               SELECT glax029,glax030,glax031,glax032,glax033,glax034,glax035,glax036,glax037,glax038
                 INTO g_glaq_m.glaq029,g_glaq_m.glaq030,g_glaq_m.glaq031,g_glaq_m.glaq032,g_glaq_m.glaq033,
                      g_glaq_m.glaq034,g_glaq_m.glaq035,g_glaq_m.glaq036,g_glaq_m.glaq037,g_glaq_m.glaq038
                 FROM glax_t
                WHERE glaxent = g_enterprise
                  AND glaxld = p_glapld
                  AND glaxdocno = p_glapdocno
                  AND glaxseq = p_glaqseq
            END IF
            IF p_prog = "aglt420" THEN
               SELECT glcf062,glcf063,glcf064,glcf065,glcf066,glcf067,glcf068,glcf069,glcf070,glcf071
                 INTO g_glaq_m.glaq029,g_glaq_m.glaq030,g_glaq_m.glaq031,g_glaq_m.glaq032,g_glaq_m.glaq033,
                      g_glaq_m.glaq034,g_glaq_m.glaq035,g_glaq_m.glaq036,g_glaq_m.glaq037,g_glaq_m.glaq038
                 FROM glcf_t
                WHERE glcfent = g_enterprise AND glcfld = p_glapld
                  AND glcf001 = p_glcf001 AND glcf002 = p_glcf002
                  AND glcf003 = p_glaq002 AND glcf004 = p_glcf004
            END IF
            #旧值备份
            LET g_glaq_m_t.* = g_glaq_m.*
            CALL aglt310_03_free_account_desc()
            DISPLAY BY NAME  g_glaq_m.glaq029,g_glaq_m.glaq029_desc,g_glaq_m.glaq030,g_glaq_m.glaq030_desc,
                             g_glaq_m.glaq031,g_glaq_m.glaq031_desc,g_glaq_m.glaq032,g_glaq_m.glaq032_desc,
                             g_glaq_m.glaq033,g_glaq_m.glaq033_desc,g_glaq_m.glaq034,g_glaq_m.glaq034_desc,
                             g_glaq_m.glaq035,g_glaq_m.glaq035_desc,g_glaq_m.glaq036,g_glaq_m.glaq036_desc,
                             g_glaq_m.glaq037,g_glaq_m.glaq037_desc,g_glaq_m.glaq038,g_glaq_m.glaq038_desc

            
           
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq029
            
            #add-point:AFTER FIELD glaq029 name="input.a.glaq029"
            DISPLAY '' TO glaq029_desc
            IF NOT cl_null(g_glaq_m.glaq029) THEN
               CALL aglt310_03_free_account_chk(g_glad0171,g_glaq_m.glaq029,g_glad0172) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq029
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq029 = g_glaq_m_t.glaq029
                  CALL aglt310_03_free_account_desc()
                  DISPLAY BY NAME g_glaq_m.glaq029_desc
                  NEXT FIELD glaq029
               END IF
            END IF
            CALL aglt310_03_free_account_desc()
            DISPLAY BY NAME g_glaq_m.glaq029_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq029
            #add-point:BEFORE FIELD glaq029 name="input.b.glaq029"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0171
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0171
             END IF 
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF 
             
             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq029
            #add-point:ON CHANGE glaq029 name="input.g.glaq029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq030
            
            #add-point:AFTER FIELD glaq030 name="input.a.glaq030"
            DISPLAY '' TO glaq030_desc
            IF NOT cl_null(g_glaq_m.glaq030) THEN
               CALL aglt310_03_free_account_chk(g_glad0181,g_glaq_m.glaq030,g_glad0182) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq030
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq030 = g_glaq_m_t.glaq030
                  CALL aglt310_03_free_account_desc()
                  DISPLAY BY NAME g_glaq_m.glaq030_desc
                  NEXT FIELD glaq030
               END IF
            END IF
            CALL aglt310_03_free_account_desc()
            DISPLAY BY NAME g_glaq_m.glaq030_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq030
            #add-point:BEFORE FIELD glaq030 name="input.b.glaq030"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0181
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0181
             END IF 
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF 
             
             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq030
            #add-point:ON CHANGE glaq030 name="input.g.glaq030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq031
            
            #add-point:AFTER FIELD glaq031 name="input.a.glaq031"
            DISPLAY '' TO glaq031_desc
            IF NOT cl_null(g_glaq_m.glaq031) THEN
               CALL aglt310_03_free_account_chk(g_glad0191,g_glaq_m.glaq031,g_glad0192) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq031
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq031 = g_glaq_m_t.glaq031
                  CALL aglt310_03_free_account_desc()
                  DISPLAY BY NAME g_glaq_m.glaq031_desc
                  NEXT FIELD glaq031
               END IF
            END IF
            CALL aglt310_03_free_account_desc()
            DISPLAY BY NAME g_glaq_m.glaq031_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq031
            #add-point:BEFORE FIELD glaq031 name="input.b.glaq031"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0191
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0191
             END IF 
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF 
             
             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq031
            #add-point:ON CHANGE glaq031 name="input.g.glaq031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq032
            
            #add-point:AFTER FIELD glaq032 name="input.a.glaq032"
            DISPLAY '' TO glaq032_desc
            IF NOT cl_null(g_glaq_m.glaq032) THEN
               CALL aglt310_03_free_account_chk(g_glad0201,g_glaq_m.glaq032,g_glad0202) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq032
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq032 = g_glaq_m_t.glaq032
                  CALL aglt310_03_free_account_desc()
                  DISPLAY BY NAME g_glaq_m.glaq032_desc
                  NEXT FIELD glaq032
               END IF
            END IF
            CALL aglt310_03_free_account_desc()
            DISPLAY BY NAME g_glaq_m.glaq032_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq032
            #add-point:BEFORE FIELD glaq032 name="input.b.glaq032"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0201
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0201
             END IF 
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF 
             
             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq032
            #add-point:ON CHANGE glaq032 name="input.g.glaq032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq033
            
            #add-point:AFTER FIELD glaq033 name="input.a.glaq033"
             DISPLAY '' TO glaq033_desc
             IF NOT cl_null(g_glaq_m.glaq033) THEN
               CALL aglt310_03_free_account_chk(g_glad0211,g_glaq_m.glaq033,g_glad0212) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq033
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq033 = g_glaq_m_t.glaq033
                  CALL aglt310_03_free_account_desc()
                  DISPLAY BY NAME g_glaq_m.glaq033_desc
                  NEXT FIELD glaq033
               END IF
            END IF
            CALL aglt310_03_free_account_desc()
            DISPLAY BY NAME g_glaq_m.glaq033_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq033
            #add-point:BEFORE FIELD glaq033 name="input.b.glaq033"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0211
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0211
             END IF 
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF 
             
             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq033
            #add-point:ON CHANGE glaq033 name="input.g.glaq033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq034
            
            #add-point:AFTER FIELD glaq034 name="input.a.glaq034"
            DISPLAY '' TO  glaq034_desc
            IF NOT cl_null(g_glaq_m.glaq034) THEN
               CALL aglt310_03_free_account_chk(g_glad0221,g_glaq_m.glaq034,g_glad0222) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq034
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq034 = g_glaq_m_t.glaq034
                  CALL aglt310_03_free_account_desc()
                  DISPLAY BY NAME g_glaq_m.glaq034_desc
                  NEXT FIELD glaq034
               END IF
            END IF
            CALL aglt310_03_free_account_desc()
            DISPLAY BY NAME g_glaq_m.glaq034_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq034
            #add-point:BEFORE FIELD glaq034 name="input.b.glaq034"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0221
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0221
             END IF       
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF 
             
             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq034
            #add-point:ON CHANGE glaq034 name="input.g.glaq034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq035
            
            #add-point:AFTER FIELD glaq035 name="input.a.glaq035"
            DISPLAY '' TO glaq035_desc
            IF NOT cl_null(g_glaq_m.glaq035) THEN
               CALL aglt310_03_free_account_chk(g_glad0231,g_glaq_m.glaq035,g_glad0232) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq035
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq035 = g_glaq_m_t.glaq035
                  CALL aglt310_03_free_account_desc()
                  DISPLAY BY NAME g_glaq_m.glaq035_desc
                  NEXT FIELD glaq035
               END IF
            END IF
            CALL aglt310_03_free_account_desc()
            DISPLAY BY NAME g_glaq_m.glaq035_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq035
            #add-point:BEFORE FIELD glaq035 name="input.b.glaq035"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0231
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0231
             END IF 
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF 
             
             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq035
            #add-point:ON CHANGE glaq035 name="input.g.glaq035"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq036
            
            #add-point:AFTER FIELD glaq036 name="input.a.glaq036"
            DISPLAY '' TO glaq036_desc
            IF NOT cl_null(g_glaq_m.glaq036) THEN
               CALL aglt310_03_free_account_chk(g_glad0241,g_glaq_m.glaq036,g_glad0242) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq036
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq036 = g_glaq_m_t.glaq036
                  CALL aglt310_03_free_account_desc()
                  DISPLAY BY NAME g_glaq_m.glaq036_desc
                  NEXT FIELD glaq036
               END IF
            END IF
            CALL aglt310_03_free_account_desc()
            DISPLAY BY NAME g_glaq_m.glaq036_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq036
            #add-point:BEFORE FIELD glaq036 name="input.b.glaq036"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0241
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0241
             END IF 
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF 
             
             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq036
            #add-point:ON CHANGE glaq036 name="input.g.glaq036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq037
            
            #add-point:AFTER FIELD glaq037 name="input.a.glaq037"
             DISPLAY '' TO glaq037_desc
            IF NOT cl_null(g_glaq_m.glaq037) THEN
               CALL aglt310_03_free_account_chk(g_glad0251,g_glaq_m.glaq037,g_glad0252) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq037
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq037 = g_glaq_m_t.glaq037
                  CALL aglt310_03_free_account_desc()
                  DISPLAY BY NAME g_glaq_m.glaq037_desc
                  NEXT FIELD glaq037
               END IF
            END IF
            CALL aglt310_03_free_account_desc()
            DISPLAY BY NAME g_glaq_m.glaq037_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq037
            #add-point:BEFORE FIELD glaq037 name="input.b.glaq037"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0251
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0251
             END IF 
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF 
             
             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq037
            #add-point:ON CHANGE glaq037 name="input.g.glaq037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq038
            
            #add-point:AFTER FIELD glaq038 name="input.a.glaq038"
            DISPLAY '' TO glaq038_desc
            IF NOT cl_null(g_glaq_m.glaq038) THEN
               CALL aglt310_03_free_account_chk(g_glad0261,g_glaq_m.glaq038,g_glad0262) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq038
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq038 = g_glaq_m_t.glaq038
                  CALL aglt310_03_free_account_desc()
                  DISPLAY BY NAME g_glaq_m.glaq038_desc
                  NEXT FIELD glaq038
               END IF
            END IF
            CALL aglt310_03_free_account_desc()
            DISPLAY BY NAME g_glaq_m.glaq038_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq038
            #add-point:BEFORE FIELD glaq038 name="input.b.glaq038"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad0261
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad0261
             END IF 
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF 
             
             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq038
            #add-point:ON CHANGE glaq038 name="input.g.glaq038"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glaq029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq029
            #add-point:ON ACTION controlp INFIELD glaq029 name="input.c.glaq029"
#此段落由子樣板a07產生            
            #開窗i段
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq_m.glaq029             #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0171,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq_m.glaq029 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL aglt310_03_free_account_desc()
               DISPLAY g_glaq_m.glaq029 TO glaq029              #顯示到畫面上
               DISPLAY g_glaq_m.glaq029_desc TO glaq029_desc    #說明
               LET g_qryparam.where = ''
               NEXT FIELD glaq029                          #返回原欄位
            END IF 

            #END add-point
 
 
         #Ctrlp:input.c.glaq030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq030
            #add-point:ON ACTION controlp INFIELD glaq030 name="input.c.glaq030"
#此段落由子樣板a07產生            
            #開窗i段
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq_m.glaq030             #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
    
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where ="glaf001 = '",g_glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq_m.glaq030 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL aglt310_03_free_account_desc() #說明
    
               DISPLAY g_glaq_m.glaq030 TO glaq030              #顯示到畫面上
               DISPLAY g_glaq_m.glaq030_desc TO glaq030_desc    #說明
               LET g_qryparam.where =""
               NEXT FIELD glaq030                          #返回原欄位
            END IF 

            #END add-point
 
 
         #Ctrlp:input.c.glaq031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq031
            #add-point:ON ACTION controlp INFIELD glaq031 name="input.c.glaq031"
#此段落由子樣板a07產生            
            #開窗i段
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq_m.glaq031             #給予default值
               LET g_qryparam.default2  =""
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where  = "glaf001 = '",g_glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗
   
               LET g_glaq_m.glaq031 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL aglt310_03_free_account_desc() #說明
   
               DISPLAY g_glaq_m.glaq031 TO glaq031              #顯示到畫面上
               DISPLAY g_glaq_m.glaq031_desc TO glaq031_desc
               LET g_qryparam.where =""
               NEXT FIELD glaq031                          #返回原欄位
            END IF 

            #END add-point
 
 
         #Ctrlp:input.c.glaq032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq032
            #add-point:ON ACTION controlp INFIELD glaq032 name="input.c.glaq032"
#此段落由子樣板a07產生            
            #開窗i段
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq_m.glaq032             #給予default值
               LET g_qryparam.default2 = ""
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                               #呼叫開窗
   
               LET g_glaq_m.glaq032 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL aglt310_03_free_account_desc()
               DISPLAY g_glaq_m.glaq032 TO glaq032              #顯示到畫面上
               DISPLAY g_glaq_m.glaq032_desc TO glaq032_desc 
               LET g_qryparam.where =""
               NEXT FIELD glaq032                          #返回原欄位
            END IF 

            #END add-point
 
 
         #Ctrlp:input.c.glaq033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq033
            #add-point:ON ACTION controlp INFIELD glaq033 name="input.c.glaq033"
#此段落由子樣板a07產生            
            #開窗i段
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq_m.glaq033             #給予default值
               LET g_qryparam.default2 = ""
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗
   
               LET g_glaq_m.glaq033 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL aglt310_03_free_account_desc()
               DISPLAY g_glaq_m.glaq033 TO glaq033              #顯示到畫面上
               DISPLAY g_glaq_m.glaq033_desc TO glaq033_desc
               LET g_qryparam.where =""
               NEXT FIELD glaq033                          #返回原欄位
            END IF 

            #END add-point
 
 
         #Ctrlp:input.c.glaq034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq034
            #add-point:ON ACTION controlp INFIELD glaq034 name="input.c.glaq034"
#此段落由子樣板a07產生            
            #開窗i段
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq_m.glaq034             #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
    
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0221,"'" #自由核算項類型
               END IF  
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq_m.glaq034 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL aglt310_03_free_account_desc() #說明
    
               DISPLAY g_glaq_m.glaq034 TO glaq034              #顯示到畫面上
               DISPLAY g_glaq_m.glaq034_desc TO glaq034_desc    #說明
               LET g_qryparam.where =""
               NEXT FIELD glaq034                          #返回原欄位
            END IF 

            #END add-point
 
 
         #Ctrlp:input.c.glaq035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq035
            #add-point:ON ACTION controlp INFIELD glaq035 name="input.c.glaq035"
#此段落由子樣板a07產生            
            #開窗i段
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq_m.glaq035             #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
   
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where ="glaf001 = '",g_glad0231,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009)                                #呼叫開窗
   
               LET g_glaq_m.glaq035 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL aglt310_03_free_account_desc() #說明
   
               DISPLAY g_glaq_m.glaq035 TO glaq035              #顯示到畫面上
               DISPLAY g_glaq_m.glaq035_desc TO glaq035_desc    #說明
               LET g_qryparam.where =""
               NEXT FIELD glaq035                          #返回原欄位
            END IF 

            #END add-point
 
 
         #Ctrlp:input.c.glaq036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq036
            #add-point:ON ACTION controlp INFIELD glaq036 name="input.c.glaq036"
#此段落由子樣板a07產生            
            #開窗i段
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq_m.glaq036             #給予default
               LET g_qryparam.default2 = ""
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq_m.glaq036 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL aglt310_03_free_account_desc()#說明
    
               DISPLAY g_glaq_m.glaq036 TO glaq036              #顯示到畫面上
               DISPLAY g_glaq_m.glaq036_desc TO glaq036_desc    #說明
               NEXT FIELD glaq036                          #返回原欄位
            END IF 
 
            #END add-point
 
 
         #Ctrlp:input.c.glaq037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq037
            #add-point:ON ACTION controlp INFIELD glaq037 name="input.c.glaq037"
#此段落由子樣板a07產生            
            #開窗i段
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq_m.glaq037             #給予default值
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
   
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗
   
               LET g_glaq_m.glaq037 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL aglt310_03_free_account_desc() 
               DISPLAY g_glaq_m.glaq037 TO glaq037              #顯示到畫面上
               DISPLAY g_glaq_m.glaq037_desc TO glaq037_desc 
               LET g_qryparam.where =""
               NEXT FIELD glaq037                          #返回原欄位
            END IF 

            #END add-point
 
 
         #Ctrlp:input.c.glaq038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq038
            #add-point:ON ACTION controlp INFIELD glaq038 name="input.c.glaq038"
#此段落由子樣板a07產生            
            #開窗i段
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq_m.glaq038             #給予default值
               LET g_qryparam.default2 = ""
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗
   
               LET g_glaq_m.glaq038 = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL aglt310_03_free_account_desc()
               DISPLAY g_glaq_m.glaq038 TO glaq038              #顯示到畫面上
               DISPLAY g_glaq_m.glaq038_desc TO glaq038_desc 
               LET g_qryparam.where =""
               NEXT FIELD glaq038                          #返回原欄位
            END IF 

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
   CLOSE WINDOW w_aglt310_03 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      RETURN g_glaq_m_t.glaq029,g_glaq_m_t.glaq030,g_glaq_m_t.glaq031,g_glaq_m_t.glaq032,g_glaq_m_t.glaq033,
             g_glaq_m_t.glaq034,g_glaq_m_t.glaq035,g_glaq_m_t.glaq036,g_glaq_m_t.glaq037,g_glaq_m_t.glaq038
   END IF
    RETURN g_glaq_m.glaq029,g_glaq_m.glaq030,g_glaq_m.glaq031,g_glaq_m.glaq032,g_glaq_m.glaq033,
           g_glaq_m.glaq034,g_glaq_m.glaq035,g_glaq_m.glaq036,g_glaq_m.glaq037,g_glaq_m.glaq038   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglt310_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aglt310_03.other_function" readonly="Y" >}
#+核算项说明
#如果栏位对应的核算项类型对应的资料来源为‘1’，则自组sql来抓取说明
PRIVATE FUNCTION aglt310_03_free_account_desc()
   DEFINE l_glae002     LIKE glae_t.glae002     #资料来源
   DEFINE l_sql         STRING                  #组的抓取资料的sql
   
   #核算项一
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0171
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0171
      LET g_ref_fields[2] =g_glaq_m.glaq029
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_m.glaq029_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_m.glaq029
      CALL aglt310_03_make_sql_desc(g_glad0171) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq_m.glaq029_desc= g_rtn_fields[1]
   END IF 
   #核算项二
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0181
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0181
      LET g_ref_fields[2] =g_glaq_m.glaq030     
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_m.glaq030_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_m.glaq030
      CALL aglt310_03_make_sql_desc(g_glad0181) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq_m.glaq030_desc= g_rtn_fields[1]
   END IF       
   #核算项三
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0191
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0191
      LET g_ref_fields[2] =g_glaq_m.glaq031
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_m.glaq031_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_m.glaq031
      CALL aglt310_03_make_sql_desc(g_glad0191) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq_m.glaq031_desc= g_rtn_fields[1]   
   END IF      
   #核算项四
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0201
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0201
      LET g_ref_fields[2] =g_glaq_m.glaq032
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_m.glaq032_desc= g_rtn_fields[1]
    ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_m.glaq032
      CALL aglt310_03_make_sql_desc(g_glad0201) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq_m.glaq032_desc= g_rtn_fields[1]   
   END IF        
   #核算项五
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0211
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0211
      LET g_ref_fields[2] =g_glaq_m.glaq033
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_m.glaq033_desc= g_rtn_fields[1]  
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_m.glaq033
      CALL aglt310_03_make_sql_desc(g_glad0211) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq_m.glaq033_desc= g_rtn_fields[1]   
   END IF        
   #核算项六
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0221
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0221
      LET g_ref_fields[2] =g_glaq_m.glaq034
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_m.glaq034_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_m.glaq034
      CALL aglt310_03_make_sql_desc(g_glad0221) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq_m.glaq034_desc= g_rtn_fields[1]   
   END IF        
   #核算项七
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0231
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0231
      LET g_ref_fields[2] =g_glaq_m.glaq035
      CALL aglt310_03_make_sql_desc(g_glad0231) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_m.glaq035_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_m.glaq035
      CALL aglt310_03_make_sql_desc(g_glad0241) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq_m.glaq035_desc= g_rtn_fields[1]   
   END IF           
   #核算项八
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0241
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0241
      LET g_ref_fields[2] =g_glaq_m.glaq036
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_m.glaq036_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_m.glaq036
      CALL aglt310_03_make_sql_desc(g_glad0241) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq_m.glaq036_desc= g_rtn_fields[1]   
   END IF        
   #核算项九
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0251
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0251
      LET g_ref_fields[2] =g_glaq_m.glaq037
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_m.glaq037_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_m.glaq037
      CALL aglt310_03_make_sql_desc(g_glad0251) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq_m.glaq037_desc= g_rtn_fields[1]   
   END IF        
   #核算项十
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0261
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0261
      LET g_ref_fields[2] =g_glaq_m.glaq038
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq_m.glaq038_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq_m.glaq038
      CALL aglt310_03_make_sql_desc(g_glad0261) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq_m.glaq038_desc= g_rtn_fields[1]   
   END IF        
END FUNCTION
#+ 自由核算项检查
PUBLIC FUNCTION aglt310_03_free_account_chk(p_glaf001,p_glaf002,p_ctrl)
   DEFINE p_glaf001      LIKE glaf_t.glaf001
   DEFINE p_glaf002      LIKE glaf_t.glaf002
   DEFINE p_ctrl         LIKE type_t.chr5       #控制方式1.1.允许空白，2：必输不需检查或，3：必输需要检查
   DEFINE r_errno        LIKE type_t.chr10      #错误编号
   DEFINE l_glafstus     LIKE glaf_t.glafstus
   DEFINE l_glae002      LIKE glae_t.glae002
   DEFINE l_glae003      LIKE glae_t.glae003
   DEFINE l_glae004      LIKE glae_t.glae004
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_sql          STRING
   
      LET r_errno = ''
      LET l_glae002 = ''
      LET l_glae003 = ''
      LET l_glae004 = ''
      #.抓出改类型对应的资料来源，来源档案，来源编号栏位
      SELECT glae002,glae003,glae004 INTO l_glae002,l_glae003,l_glae004 FROM glae_t
       WHERE glaeent = g_enterprise
         AND glae001 = p_glaf001
      #来源类型为1.‘基本资料’，則檢核來源編號欄位是否存在,並依核算项类型对应的控制方式，檢核核算项值的合理性
      IF l_glae002 = '1' THEN
         SELECT count(*) INTO l_cnt FROM dzeb_t
          WHERE dzeb001 = l_glae003
            AND dzeb002 = l_glae004
         IF l_cnt = 0  THEN
            LET r_errno = 'agl-00073'
            RETURN r_errno
         END IF
         #控制方式3：必输必检查
         IF p_ctrl = '3'  THEN
            #1.检查资料的有效存在
             LET l_cnt = 0
             CALL aglt310_03_make_sql(l_glae003,l_glae004,p_glaf002) RETURNING l_sql
             PREPARE aglt310_03_chk  FROM l_sql
             EXECUTE aglt310_03_chk INTO l_cnt             
             IF  l_cnt = 0  THEN
                 LET r_errno = 'agl-00099'
                 RETURN r_errno
             END IF
             #IF  l_glafstus = 'N'  THEN
             #    LET g_errno = 'agl-00063'
             #    RETURN r_errno
             #END IF
         END IF
      END IF
      #来源类型为2.预设值，則輸入值應檢核是否存在自由核算項資料檔,並依核算项类型对应的控制方式，檢核核算项值的合理性
      IF l_glae002 = '2' THEN
         SELECT glafstus INTO l_glafstus FROM glaf_t
             WHERE glafent = g_enterprise
               AND glaf001 = p_glaf001
               AND glaf002 = p_glaf002
         IF SQLCA.SQLCODE = 100  THEN
            LET r_errno = 'agl-00062'
            RETURN r_errno
          END IF
          IF p_ctrl = '3'  THEN
             IF l_glafstus = 'N'  THEN
                LET g_errno = 'agl-00063'
                RETURN r_errno
             END IF
          END IF
      END IF
      #若来源类型为3.'自行輸入'則user可任意輸入且不需檢核
      RETURN r_errno
END FUNCTION
#+核算项说明
PUBLIC FUNCTION aglt310_03_make_sql_desc(p_glae001)
    DEFINE p_glae001   LIKE glae_t.glae001   #核算项类型
    #DEFINE p_field_value   LIKE glaf_t.glaf002   #核算项值
    DEFINE r_sql       STRING
    DEFINE l_glae003   LIKE glae_t.glae003   #来源档案
    DEFINE l_glae004   LIKE glae_t.glae004   #来源编号栏位
    DEFINE l_glae005   LIKE glae_t.glae005   #来源说明档案
    DEFINE l_glae006   LIKE glae_t.glae006   #来源说明栏位  
    DEFINE l_dzeb002   LIKE dzeb_t.dzeb002   #栏位代号
    DEFINE l_dzeb006   LIKE dzeb_t.dzeb002   #栏位属性    
    DEFINE l_sql     STRING
    DEFINE li_sql1   STRING    #抓主档表的key
    DEFINE li_sql2   STRING    #抓对应多语言表的key 
    #抓取主表的key放入数组
    DEFINE li_main    DYNAMIC ARRAY OF RECORD
           dzeb002    LIKE dzeb_t.dzeb002       
    END RECORD 
    #抓取多语言表的key放入数组
    DEFINE li_dlang    DYNAMIC ARRAY OF RECORD
           dzeb002    LIKE dzeb_t.dzeb002       
    END RECORD 
    DEFINE l_where   STRING    #组出的对应的抓取说明的where条件    
    DEFINE l_i,l_i2,l_i3       LIKE type_t.num5
    
    #初始化
    CALL li_main.clear()
    CALL li_dlang.clear()
    
   #抓取来源档案，来源说明档案，来源说明栏位
   SELECT glae003,glae004,glae005,glae006 INTO l_glae003,l_glae004,l_glae005,l_glae006 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = p_glae001
      
   #抓取主档key
   LET l_i = 1
   LET li_sql1 = " SELECT dzeb002 FROM dzeb_t ",
                 "  WHERE dzeb001 = '",l_glae003,"'",
                 "    AND dzeb004 = 'Y'", 
                 "  ORDER BY dzeb021 " 
   PREPARE aglt310_pr FROM li_sql1
   DECLARE aglt310_cs CURSOR FOR aglt310_pr
   FOREACH aglt310_cs INTO li_main[l_i].dzeb002
       LET l_i = l_i +1
   END FOREACH
   #真实数组长度
   LET l_i = l_i -1  
   
   #抓取多语言档key
   LET l_i2 = 1
   LET li_sql2 = " SELECT dzeb002 FROM dzeb_t ",
                 " WHERE dzeb001 = '",l_glae005,"'" ,
                  "  AND dzeb004 = 'Y'",
                 " ORDER BY dzeb021 "
   PREPARE aglt310_pr2 FROM li_sql2
   DECLARE aglt310_cs2 CURSOR FOR aglt310_pr2
   FOREACH aglt310_cs2 INTO li_dlang[l_i2].dzeb002
       LET l_i2 = l_i2 +1
   END FOREACH
   #真实数组长度
   LET l_i2 = l_i2 -1  

   
   #组合where条件 
   LET l_where = '1=1'
   FOR  l_i3 = 1 TO  l_i 
       LET l_where = l_where," AND ", li_main[l_i3].dzeb002, " = " ,li_dlang[l_i3].dzeb002
   END FOR    
   
   #组出的基础sql   
   LET r_sql = " SELECT ", l_glae006 ," FROM ",l_glae005 ,',',l_glae003,
               " WHERE " , l_glae004," = ?",
               "   AND " ,l_where
   #组sql               
   LET l_sql = "SELECT dzeb002,dzeb006 FROM dzeb_t ",
               " WHERE dzeb001 = '",l_glae005,"'",
               "   AND dzeb004 = 'Y'"
   PREPARE aglt310_make_sql_pre1 FROM l_sql
   DECLARE aglt310_make_sql_cs1 CURSOR FOR aglt310_make_sql_pre1
   FOREACH aglt310_make_sql_cs1 INTO l_dzeb002,l_dzeb006
      #判断是否有ent栏位
      IF l_dzeb006 = 'N802' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_enterprise,"' "
      END IF 
      
      IF l_dzeb006 = 'C800' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_dlang,"' "
      END IF

   END FOREACH
   RETURN r_sql
    
END FUNCTION
#组检查资料存在有效的sql
PRIVATE FUNCTION aglt310_03_make_sql(p_glae003,p_glae004,p_glaf002)
   DEFINE p_glae003 LIKE glae_t.glae003    #来源档案
   DEFINE p_glae004 LIKE glae_t.glae004    #来源编号栏位
   DEFINE p_glaf002 LIKE glaf_t.glaf002    #核算项值
   DEFINE l_dzeb002 LIKE dzeb_t.dzeb002
   DEFINE l_dzeb006 LIKE dzeb_t.dzeb006
   DEFINE l_sql     STRING
   DEFINE r_sql     STRING

   LET r_sql = " SELECT count(*) FROM ",p_glae003 ,
               "  WHERE ", p_glae004," = '",p_glaf002,"'"
               
   LET l_sql = "SELECT dzeb002,dzeb006 FROM dzeb_t ",
               " WHERE dzeb001 = '", p_glae003,"'"
   PREPARE aglt310_make_sql_pre FROM l_sql
   DECLARE aglt310_make_sql_cs CURSOR FOR aglt310_make_sql_pre
   FOREACH aglt310_make_sql_cs INTO l_dzeb002,l_dzeb006
      #判断是否有ent栏位
      IF l_dzeb006 = 'N802' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_enterprise,"' "
      END IF
      #判断是否有stus栏位
      IF l_dzeb002 LIKE '%stus'  THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='Y'"
      END IF
   END FOREACH
   RETURN r_sql

END FUNCTION

 
{</section>}
 
