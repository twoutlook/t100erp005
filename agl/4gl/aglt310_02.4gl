#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt310_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-09-13 11:28:27), PR版次:0012(2017-02-09 18:18:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000497
#+ Filename...: aglt310_02
#+ Description: 核算項維護
#+ Creator....: 01258(2013-08-16 10:39:29)
#+ Modifier...: 05016 -SD/PR- 04152
 
{</section>}
 
{<section id="aglt310_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#151014-00015#1   2015/10/14 BY 03538    自由核算項一~十,無維護該核算項時,也應給予一個空白字元(' '),避免寫進glar時異常
#150814-00006#3   2015/10/27 By 02599    根據借貸方向預設現金變動碼值
#160321-00016#30  2016/03/28 By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00005#17  2016/03/29 by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160614-00004#1   2016/06/14 By 02599    品类开窗控管只查出层级等于管理层级的品类资料
#160913-00017#3   2016/09/21 By 07900    AGL模组调整交易客商开窗
#160902-00034#1   2016/09/23 By Hans     1.專案編號不檢核是否必輸
#160729-00009#1   2016/09/28 By 02599    核算项开窗检核增加agli060相关联判断，当agli060中有维护核算项资料时，
#                                        如果是正向(允许)，核算项只可以抓取agli060中维护的值；如果是反向(拒绝)，核算项不可以抓取agli060中维护的值；
#                                        如果没有维护agli060中的值，就按照原逻辑
#161021-00037#3   2016/10/24 By 06821    組織類型與職能開窗調整
#170111-00005#7   2017/02/06 By 06821    核算项维护窗口中，WBS输入框有啓用核算項的話，也不限定為必輸，底色调整为无色
#161221-00054#1   2017/02/09 By Reanna   CALL s_voucher_get_glak_sql()調整傳入參數
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
       glaq018 LIKE glaq_t.glaq018, 
   glaq018_desc LIKE type_t.chr80, 
   glaq019 LIKE glaq_t.glaq019, 
   glaq019_desc LIKE type_t.chr80, 
   glaq020 LIKE glaq_t.glaq020, 
   glaq020_desc LIKE type_t.chr80, 
   glaq021 LIKE glaq_t.glaq021, 
   glaq021_desc LIKE type_t.chr80, 
   glaq022 LIKE glaq_t.glaq022, 
   glaq022_desc LIKE type_t.chr80, 
   glaq023 LIKE glaq_t.glaq023, 
   glaq023_desc LIKE type_t.chr80, 
   glaq024 LIKE glaq_t.glaq024, 
   glaq024_desc LIKE type_t.chr80, 
   glbc004 LIKE glbc_t.glbc004, 
   glbc004_desc LIKE type_t.chr80, 
   glaq051 LIKE glaq_t.glaq051, 
   glaq052 LIKE glaq_t.glaq052, 
   glaq052_desc LIKE type_t.chr80, 
   glaq053 LIKE glaq_t.glaq053, 
   glaq053_desc LIKE type_t.chr80, 
   glaq025 LIKE glaq_t.glaq025, 
   glaq025_desc LIKE type_t.chr80, 
   glaq027 LIKE glaq_t.glaq027, 
   glaq027_desc LIKE type_t.chr80, 
   glaq028 LIKE glaq_t.glaq028, 
   glaq028_desc LIKE type_t.chr80, 
   glaq017 LIKE glaq_t.glaq017, 
   glaq017_desc LIKE type_t.chr80, 
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
type type_g_glaq_r        RECORD
       glaq017 LIKE glaq_t.glaq017,
       glaq018 LIKE glaq_t.glaq018,
       glaq019 LIKE glaq_t.glaq019,
       glaq020 LIKE glaq_t.glaq020,
       glaq021 LIKE glaq_t.glaq021,
       glaq022 LIKE glaq_t.glaq022,
       glaq023 LIKE glaq_t.glaq023, 
       glaq024 LIKE glaq_t.glaq024, 
       glaq051 LIKE glaq_t.glaq051, 
       glaq052 LIKE glaq_t.glaq052,
       glaq053 LIKE glaq_t.glaq053,
       glaq025 LIKE glaq_t.glaq025,
       glaq027 LIKE glaq_t.glaq027,
       glaq028 LIKE glaq_t.glaq028, 
       glaq029 LIKE glaq_t.glaq029, 
       glaq030 LIKE glaq_t.glaq030, 
       glaq031 LIKE glaq_t.glaq031, 
       glaq032 LIKE glaq_t.glaq032, 
       glaq033 LIKE glaq_t.glaq033, 
       glaq034 LIKE glaq_t.glaq034, 
       glaq035 LIKE glaq_t.glaq035, 
       glaq036 LIKE glaq_t.glaq036, 
       glaq037 LIKE glaq_t.glaq037, 
       glaq038 LIKE glaq_t.glaq038,
       glbc004 LIKE glbc_t.glbc004
       END RECORD
DEFINE g_glaq_m_t       type_g_glaq_m
DEFINE g_glaq_r         type_g_glaq_r
DEFINE g_glaa001        LIKE glaa_t.glaa001  #幣別  
DEFINE g_glaa002        LIKE glaa_t.glaa002  #匯率參照表號
DEFINE g_glaa004        LIKE glaa_t.glaa004  #会计科目参照表号
DEFINE g_glaa005        LIKE glaa_t.glaa005  #現金變動碼参照表号
DEFINE g_ooag003        LIKE ooag_t.ooag003  #部門
DEFINE g_ooag004        LIKE ooag_t.ooag004  #營運據點
DEFINE g_glaacomp       LIKE glaa_t.glaacomp
DEFINE g_glcf001        LIKE glcf_t.glcf001
DEFINE g_glcf002        LIKE glcf_t.glcf002
DEFINE g_glaa003        LIKE glaa_t.glaa003
#固定科目核算项
DEFINE g_glad007       LIKE glad_t.glad007
DEFINE g_glad008       LIKE glad_t.glad008
DEFINE g_glad009       LIKE glad_t.glad009
DEFINE g_glad010       LIKE glad_t.glad010
DEFINE g_glad027       LIKE glad_t.glad027
DEFINE g_glad011       LIKE glad_t.glad011
DEFINE g_glad012       LIKE glad_t.glad012
DEFINE g_glad013       LIKE glad_t.glad013
DEFINE g_glad015       LIKE glad_t.glad015
DEFINE g_glad016       LIKE glad_t.glad016
DEFINE g_glad031       LIKE glad_t.glad031
DEFINE g_glad032       LIKE glad_t.glad032
DEFINE g_glad033       LIKE glad_t.glad033
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
DEFINE g_glapld         LIKE glap_t.glapld
DEFINE g_glaq002        LIKE glaq_t.glaq002
#end add-point
 
DEFINE g_glaq_m        type_g_glaq_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglt310_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aglt310_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_flag,p_glapld,p_glapdocno,p_glapdocdt,p_glaq002,p_seq,p_prog,p_glaq_r
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
   DEFINE p_flag          LIKE type_t.chr5     #金额借贷方向
   DEFINE p_glapld        LIKE glap_t.glapld   #帳別
   DEFINE p_glapdocno     LIKE glap_t.glapdocno #傳票编号
   DEFINE p_glapdocdt     LIKE glap_t.glapdocdt #傳票日期
   DEFINE p_glaq002       LIKE glaq_t.glaq002  #科目     
   DEFINE p_seq           LIKE glaq_t.glaqseq  #项次
   DEFINE p_prog          LIKE type_t.chr80    #程式编号
   DEFINE p_glaq_r        type_g_glaq_r
   
   #记录隐藏栏位标示
   DEFINE l_flag1         LIKE type_t.num5
   DEFINE l_flag2         LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5 
   DEFINE l_errno         LIKE type_t.chr80   
   DEFINE l_desc          LIKE type_t.chr80     #接受s_get_orga返回值
   DEFINE l_date          LIKE ooed_t.ooed006   #接受s_get_orga返回值
   DEFINE l_glac016       LIKE glac_t.glac016   #現金科目否
   DEFINE l_nmaistus      LIKE nmai_t.nmaistus
   DEFINE l_glac008       LIKE glac_t.glac008
   DEFINE l_glad006       LIKE glad_t.glad006
   DEFINE l_glad036       LIKE glad_t.glad036   #150814-00006#3 add
   DEFINE l_ooaa002       LIKE ooaa_t.ooaa002   #160614-00004#1 add
   #160729-00009#1--add--str--
   DEFINE l_glak_sql      STRING
   DEFINE l_glak002       LIKE glak_t.glak002 
   DEFINE l_gzcb002       LIKE gzcb_t.gzcb002
   DEFINE l_str           STRING
   DEFINE l_sql           STRING
   #160729-00009#1--add--end
   DEFINE l_wc            STRING                #161221-00054#1
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aglt310_02 WITH FORM cl_ap_formpath("agl","aglt310_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_glaq_r.*=p_glaq_r.*
   LET g_glapld = p_glapld
   LET g_glaq002 = p_glaq002
   #161221-00054#1 add ------
   LET l_wc = g_glaq002
   CALL s_fin_get_wc_str(l_wc) RETURNING l_wc
   #161221-00054#1 add end---
   #初始化
   INITIALIZE g_glaq_m.* TO NULL
   INITIALIZE g_glaq_m_t.* TO NULL   
   LET l_flag1 = 0
   LET l_flag2 = 0  
  
   ##依据对应的主账套编码，抓取币别，汇率参照编号，会计科目参照表号
   SELECT glaa001,glaa002,glaa003,glaa004,glaa005,glaacomp 
     INTO g_glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa005,g_glaacomp
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glapld 
   #依據登入用戶抓取所在部門
   SELECT ooag003 INTO g_ooag003 FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_user
   
   #固定核算项开启  
   CALL s_voucher_fix_acc_open_chk(p_glapld,p_glaq002)
   RETURNING g_glad007,g_glad008,g_glad009,g_glad010,g_glad027,g_glad011,g_glad012,g_glad013,g_glad015,g_glad016,g_glad031,g_glad032,g_glad033  
   #自由核算项开启
   SELECT glad017,glad0171,glad0172,glad018,glad0181,glad0182,
          glad019,glad0191,glad0192,glad020,glad0201,glad0202,
          glad021,glad0211,glad0212,glad022,glad0221,glad0222,
          glad023,glad0231,glad0232,glad024,glad0241,glad0242,
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
      
   #該科目做部門管理時，部門不可空白,否则隐藏  
   IF g_glad007 = 'Y' THEN     
      CALL cl_set_comp_visible('glaq018,glaq018_desc',TRUE) 
   ELSE
      CALL cl_set_comp_visible('glaq018,glaq018_desc',FALSE)
      LET l_flag1 = l_flag1+1      
   END IF 
   #該科目做利潤成本管理時，利潤成本不可空白,否则隐藏  
   IF g_glad008 = 'Y' THEN      
      CALL cl_set_comp_visible('glaq019,glaq019_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('glaq019,glaq019_desc',FALSE)
      LET l_flag1 = l_flag1+1
   END IF 
   #該科目做區域管理時，區域不可空白 ,否则隐藏 
   IF g_glad009 = 'Y' THEN    
      CALL cl_set_comp_visible('glaq020,glaq020_desc',TRUE)       
   ELSE
      CALL cl_set_comp_visible('glaq020,glaq020_desc',FALSE)
      LET l_flag1 = l_flag1+1
   END IF 
   #該科目做交易客商管理時，客商不可空白 ,否则隐藏 
   IF g_glad010 = 'Y' THEN 
      CALL cl_set_comp_visible('glaq021,glaq021_desc',TRUE)
   ELSE
       CALL cl_set_comp_visible('glaq021,glaq021_desc',FALSE)
       LET l_flag1 = l_flag1+1
   END IF 
   #該科目做账款客商管理時，客商不可空白 ,否则隐藏 
   IF g_glad027 = 'Y' THEN 
      CALL cl_set_comp_visible('glaq022,glaq022_desc',TRUE)
   ELSE
       CALL cl_set_comp_visible('glaq022,glaq022_desc',FALSE) 
       LET l_flag1 = l_flag1+1
   END IF 
   #該科目做客群管理時，客群不可空白,否则隐藏  
   IF g_glad011 = 'Y' THEN
      CALL cl_set_comp_visible('glaq023,glaq023_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('glaq023,glaq023_desc',FALSE)
      LET l_flag1 = l_flag1+1
   END IF 
   
   #該科目做產品分類管理時，部門不可空白,否则隐藏  
   IF g_glad012 = 'Y' THEN       
      CALL cl_set_comp_visible('glaq024,glaq024_desc',TRUE)
      #品类管理层级aoos010
      CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002 #160614-00004#1 add
   ELSE
      CALL cl_set_comp_visible('glaq024,glaq024_desc',FALSE)
      LET l_flag1 = l_flag1+1      
   END IF 
   #判斷該科目是否為現金類科目
   CALL cl_set_comp_visible("glbc004,glbc004_desc",FALSE)
   LET l_flag1 = l_flag1+1 
#   IF p_prog <> 'aglt420' THEN
   SELECT glac016,glac008 INTO l_glac016,l_glac008 FROM glac_t 
   WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=p_glaq002
   IF l_glac016='Y' THEN
      CALL cl_set_comp_visible("glbc004,glbc004_desc",TRUE)
      CALL cl_set_comp_required("glbc004",FALSE)  #2015/11/13 add
      LET l_flag1 = l_flag1-1 
      #150814-00006#3--add--str--
      IF cl_null(p_flag) THEN
         IF l_glac008 = '1' THEN  #借方
            LET p_flag='d' 
         ELSE #贷方
            LET p_flag='c'
         END IF 
      END IF
      #150814-00006#3--add--end
   END IF
#   END IF
   #如果该页签上的栏位都已隐藏，则隐藏该gird
   IF l_flag1 = '8' THEN
      CALL cl_set_comp_visible('grid5',FALSE)
   ELSE
      CALL cl_set_comp_visible('grid5',TRUE)      
   END IF 
   
   #該科目做经营方式管理時，经营方式不可空白,否则隐藏  
   IF g_glad031 = 'Y' THEN
      CALL cl_set_comp_visible('glaq051',TRUE)
   ELSE
      CALL cl_set_comp_visible('glaq051',FALSE)
   END IF 
   #該科目做渠道管理時，渠道不可空白,否则隐藏  
   IF g_glad032 = 'Y' THEN
      CALL cl_set_comp_visible('glaq052,glaq052_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('glaq052,glaq052_desc',FALSE)
   END IF 
   #該科目做品牌管理時，品牌不可空白,否则隐藏  
   IF g_glad033 = 'Y' THEN
      CALL cl_set_comp_visible('glaq053,glaq053_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('glaq053,glaq053_desc',FALSE)
   END IF 
   
   #該科目做人員管理時，部門不可空白,否则隐藏  
   IF g_glad013 = 'Y' THEN       
      CALL cl_set_comp_visible('glaq025,glaq025_desc',TRUE)
   ELSE
      CALL cl_set_comp_visible('glaq025,glaq025_desc',FALSE) 
   END IF 
 
   #該科目做專案管理時，部門不可空白,否则隐藏  
   IF g_glad015 = 'Y' THEN 
      CALL cl_set_comp_visible('glaq027,glaq027_desc',TRUE)
      CALL cl_set_comp_required('glaq027,glaq027_desc',FALSE) #160902-00034#1 
   ELSE
      CALL cl_set_comp_visible('glaq027,glaq027_desc',FALSE)
   END IF 
   #該科目做WBS管理時，部門不可空白,否则隐藏  
   IF g_glad016 = 'Y' THEN
      CALL cl_set_comp_visible('glaq028,glaq028_desc',TRUE)
      CALL cl_set_comp_required('glaq028,glaq028_desc',FALSE) #170111-00005#7 add
   ELSE
      CALL cl_set_comp_visible('glaq028,glaq028_desc',FALSE)
   END IF
   LET l_flag1=0
   LET l_flag2=0
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
   IF l_flag1=5 AND l_flag2=5 THEN
      CALL cl_set_comp_visible('group_1',FALSE)
   END IF
   #经营方式
   #160729-00009#1--add--str--
   #当agli060设置了限制录入内容，下拉框内容需要按照限制内容加载
   IF g_glad031 = 'Y' THEN 
      LET l_glak002=''
      SELECT DISTINCT glak002 INTO l_glak002 FROM glak_t
       WHERE glakent=g_enterprise AND glakld=g_glapld AND glak001='09'
         AND glak003=g_glaq002
      IF NOT cl_null(l_glak002) THEN
         LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '6013'"
         #正向（允许）
         IF l_glak002 = '1' THEN
            LET l_sql = l_sql," AND gzcb002 IN "
         ELSE
         #反向(拒绝)
            LET l_sql = l_sql," AND gzcb002 NOT IN "
         END IF
         LET l_sql = l_sql," (SELECT glak004 FROM glak_t ",
                           "   WHERE glakent=",g_enterprise," AND glakld='",g_glapld,"'",
                           "     AND glak001='09' AND glak003='",g_glaq002,"')",
                           " ORDER BY gzcb002 ASC"
         PREPARE glaq051_pre FROM l_sql
         DECLARE glaq051_cur CURSOR FOR glaq051_pre
         LET l_str = NULL
         LET l_gzcb002 = NULL
         FOREACH glaq051_cur INTO l_gzcb002
            IF cl_null(l_str) THEN LET l_str = l_gzcb002 CONTINUE FOREACH END IF
            LET l_str = l_str,",",l_gzcb002
         END FOREACH
         CALL cl_set_combo_scc_part('glaq051','6013',l_str)
      ELSE
   #160729-00009#1--add--end
         CALL cl_set_combo_scc('glaq051','6013')
      END IF #160729-00009#1 add
   END IF #160729-00009#1 add
   IF p_prog = 'aglt420' THEN
      SELECT glav002,glav006 INTO g_glcf001,g_glcf002 FROM glav_t
       WHERE glavent = g_enterprise AND glav001 = g_glaa003 AND glav004 = p_glapdocdt
   END IF
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glaq_m.glaq018,g_glaq_m.glaq019,g_glaq_m.glaq020,g_glaq_m.glaq021,g_glaq_m.glaq022, 
          g_glaq_m.glaq023,g_glaq_m.glaq024,g_glaq_m.glbc004,g_glaq_m.glaq051,g_glaq_m.glaq052,g_glaq_m.glaq053, 
          g_glaq_m.glaq025,g_glaq_m.glaq027,g_glaq_m.glaq028,g_glaq_m.glaq017,g_glaq_m.glaq029,g_glaq_m.glaq030, 
          g_glaq_m.glaq031,g_glaq_m.glaq032,g_glaq_m.glaq033,g_glaq_m.glaq034,g_glaq_m.glaq035,g_glaq_m.glaq036, 
          g_glaq_m.glaq037,g_glaq_m.glaq038 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            #抓取原值顯示
            CALL aglt310_02_mod_default_set()

            #单身科目若有启用 '部门'核算项, 请预设login人员的归属部门, 若有启用利润/成本中心核算项,请预设login人员归属部门对应的所属责任中心(ooeg004)            
            #營運據點(默认帐套法人)
            IF cl_null(g_glaq_m.glaq017) THEN
               LET g_glaq_m.glaq017 = g_glaacomp
            END IF
            #160729-00009#1--add--str--
            IF NOT cl_null(g_glaq_m.glaq017) THEN
               LET l_glak002=''
               SELECT DISTINCT glak002 INTO l_glak002 FROM glak_t
                WHERE glakent=g_enterprise AND glakld=g_glapld
                  AND glak001='01' AND glak003=g_glaq002
               IF NOT cl_null(l_glak002) THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM glak_t 
                   WHERE glakent=g_enterprise AND glakld=g_glapld
                     AND glak001='01' AND glak003=g_glaq002
                     AND glak004=g_glaq_m.glaq017
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  #正向(允许)
                  IF l_glak002='1' THEN
                     IF l_cnt = 0 THEN LET g_glaq_m.glaq017 = '' END IF
                  ELSE
                  #反向(拒绝)
                     IF l_cnt > 0 THEN LET g_glaq_m.glaq017 = '' END IF
                  END IF
               END IF
            END IF
            #160729-00009#1--add--end    
            
            #部門
            IF g_glad007 = 'Y' THEN
               IF cl_null(g_glaq_m.glaq018) THEN 
                  IF p_prog = 'aglt420' THEN
                     SELECT glce003 INTO g_glaq_m.glaq018 FROM glce_t
                      WHERE glceent=g_enterprise AND glceld=p_glapld 
                        AND glce001=g_glcf001 AND glce002=g_glcf002
                     IF cl_null(g_glaq_m.glaq018) THEN 
                        LET g_glaq_m.glaq018 = g_ooag003
                     END IF
                  ELSE
                     LET g_glaq_m.glaq018 = g_ooag003
                  END IF
               END IF 
               #160729-00009#1--add--str--
               IF NOT cl_null(g_glaq_m.glaq018) THEN
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM ooeg_t 
                   WHERE ooegent = g_enterprise AND ooeg001 = g_glaq_m.glaq018
                     AND ooeg006<=p_glapdocdt 
                     AND (ooeg007 IS NULL OR ooeg007 > p_glapdocdt)
                     AND ooegstus='Y'
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt > 0 THEN
                     LET l_glak002=''
                     SELECT DISTINCT glak002 INTO l_glak002 FROM glak_t
                      WHERE glakent=g_enterprise AND glakld=g_glapld
                        AND glak001='02' AND glak003=g_glaq002
                     IF NOT cl_null(l_glak002) THEN
                        LET l_cnt = 0
                        SELECT COUNT(*) INTO l_cnt FROM glak_t 
                         WHERE glakent=g_enterprise AND glakld=g_glapld
                           AND glak001='02' AND glak003=g_glaq002
                           AND glak004=g_glaq_m.glaq018
                        IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                        #正向(允许)
                        IF l_glak002='1' THEN
                           IF l_cnt = 0 THEN LET g_glaq_m.glaq018 = '' END IF
                        ELSE
                        #反向(拒绝)
                           IF l_cnt > 0 THEN LET g_glaq_m.glaq018 = '' END IF
                        END IF
                     END IF
                  ELSE
                     LET g_glaq_m.glaq018 = ''
                  END IF
               END IF
               #160729-00009#1--add--end
                  
            END IF 
            #利润/成本中心
            IF g_glad008 = 'Y' THEN
               IF cl_null(g_glaq_m.glaq019) THEN 
                  IF NOT cl_null(g_glaq_m.glaq018) THEN
                     SELECT ooeg004 INTO g_glaq_m.glaq019 FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = g_glaq_m.glaq018
                  ELSE
                     SELECT ooeg004 INTO g_glaq_m.glaq019 FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = g_ooag003
                  END IF
               END IF 
               #160729-00009#1--add--str--
               IF NOT cl_null(g_glaq_m.glaq019) THEN
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM ooeg_t 
                   WHERE ooegent = g_enterprise AND ooeg001 = g_glaq_m.glaq019
                     AND ooeg006<=p_glapdocdt 
                     AND (ooeg007 IS NULL OR ooeg007 > p_glapdocdt)
                     AND ooegstus='Y' AND ooeg003 IN ('1','2','3')
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt > 0 THEN
                     LET l_glak002=''
                     SELECT DISTINCT glak002 INTO l_glak002 FROM glak_t
                      WHERE glakent=g_enterprise AND glakld=g_glapld
                        AND glak001='03' AND glak003=g_glaq002
                     IF NOT cl_null(l_glak002) THEN
                        LET l_cnt = 0
                        SELECT COUNT(*) INTO l_cnt FROM glak_t 
                         WHERE glakent=g_enterprise AND glakld=g_glapld
                           AND glak001='03' AND glak003=g_glaq002
                           AND glak004=g_glaq_m.glaq019
                        IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                        #正向(允许)
                        IF l_glak002='1' THEN
                           IF l_cnt = 0 THEN LET g_glaq_m.glaq019 = '' END IF
                        ELSE
                        #反向(拒绝)
                           IF l_cnt > 0 THEN LET g_glaq_m.glaq019 = '' END IF
                        END IF
                     END IF
                  ELSE
                     LET g_glaq_m.glaq019 = ''
                  END IF
               END IF
               #160729-00009#1--add--end
            END IF  
            #人員
            IF g_glad013='Y' THEN
               IF cl_null(g_glaq_m.glaq025) THEN
                  LET g_glaq_m.glaq025=g_user
               END IF
               #160729-00009#1--add--str--
               IF NOT cl_null(g_glaq_m.glaq025) THEN
                  LET l_glak002=''
                  SELECT DISTINCT glak002 INTO l_glak002 FROM glak_t
                   WHERE glakent=g_enterprise AND glakld=g_glapld
                     AND glak001='12' AND glak003=g_glaq002
                  IF NOT cl_null(l_glak002) THEN
                     LET l_cnt = 0
                     SELECT COUNT(*) INTO l_cnt FROM glak_t 
                      WHERE glakent=g_enterprise AND glakld=g_glapld
                        AND glak001='12' AND glak003=g_glaq002
                        AND glak004=g_glaq_m.glaq025
                     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                     #正向(允许)
                     IF l_glak002='1' THEN
                        IF l_cnt = 0 THEN LET g_glaq_m.glaq025 = '' END IF
                     ELSE
                     #反向(拒绝)
                        IF l_cnt > 0 THEN LET g_glaq_m.glaq025 = '' END IF
                     END IF
                  END IF
               END IF
               #160729-00009#1--add--end
            END IF
            
            #現金變動碼
            IF l_glac016='Y' THEN
#               IF cl_null(g_glaq_m.glbc004) THEN #2015/11/16 by 02599 mark
               IF g_glaq_m.glbc004 IS NULL OR (cl_null(g_glaq_m.glbc004) AND g_glaq_m.glbc004<>' ') THEN #2015/11/16 by 02599 add
                  #150814-00006#3--mod--str--
                  #根据借贷方向设置预设值
                  SELECT glad006,glad036 INTO l_glad006,l_glad036 FROM glad_t  
                  WHERE gladent=g_enterprise AND gladld=p_glapld AND glad001=p_glaq002
                  IF p_flag='c' THEN #贷余
                     LET g_glaq_m.glbc004=l_glad036
                  ELSE
                     LET g_glaq_m.glbc004=l_glad006
                  END IF
                  #150814-00006#3--mod--end
               END IF
            END IF
            #旧值备份               
            LET g_glaq_m_t.* = g_glaq_m.*    
            DISPLAY BY NAME 
            g_glaq_m.glaq017,g_glaq_m.glaq018,g_glaq_m.glaq019,g_glaq_m.glaq020,g_glaq_m.glaq021,g_glaq_m.glaq022,
            g_glaq_m.glaq023,g_glaq_m.glaq024,g_glaq_m.glaq051,g_glaq_m.glaq052,g_glaq_m.glaq053,g_glaq_m.glaq025,
            g_glaq_m.glaq027,g_glaq_m.glaq028,g_glaq_m.glbc004,g_glaq_m.glaq029,g_glaq_m.glaq030,g_glaq_m.glaq031,
            g_glaq_m.glaq032,g_glaq_m.glaq033,g_glaq_m.glaq034,g_glaq_m.glaq035,g_glaq_m.glaq036,g_glaq_m.glaq037,
            g_glaq_m.glaq038
                          
            CALL aglt310_02_show_ref()            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq018
            
            #add-point:AFTER FIELD glaq018 name="input.a.glaq018"
            DISPLAY '' TO glaq018_desc
            IF NOT cl_null(g_glaq_m.glaq018) THEN
               CALL s_department_chk(g_glaq_m.glaq018,p_glapdocdt) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq018 = g_glaq_m_t.glaq018
                  CALL aglt310_02_ooef001_desc(g_glaq_m.glaq018) RETURNING g_glaq_m.glaq018_desc
                  DISPLAY BY NAME g_glaq_m.glaq018_desc
                  NEXT FIELD glaq018
               END IF
               
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'02',g_glaq002,g_glaq_m.glaq018) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq018 = g_glaq_m_t.glaq018
                  CALL aglt310_02_ooef001_desc(g_glaq_m.glaq018) RETURNING g_glaq_m.glaq018_desc
                  DISPLAY BY NAME g_glaq_m.glaq018_desc
                  NEXT FIELD glaq018
               END IF
               #160729-00009#1--add--end
   
               
               IF cl_null(g_glaq_m.glaq019) AND g_glad008 = 'Y' THEN 
                  SELECT ooeg004 INTO g_glaq_m.glaq019 FROM ooeg_t 
                   WHERE ooegent = g_enterprise AND ooeg001 = g_glaq_m.glaq018
                  CALL aglt310_02_ooef001_desc(g_glaq_m.glaq019) RETURNING g_glaq_m.glaq019_desc
                  DISPLAY BY NAME g_glaq_m.glaq019_desc
               END IF
            END IF 
            CALL aglt310_02_ooef001_desc(g_glaq_m.glaq018) RETURNING g_glaq_m.glaq018_desc
            DISPLAY BY NAME g_glaq_m.glaq018_desc
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq018
            #add-point:BEFORE FIELD glaq018 name="input.b.glaq018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq018
            #add-point:ON CHANGE glaq018 name="input.g.glaq018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq019
            
            #add-point:AFTER FIELD glaq019 name="input.a.glaq019"
            DISPLAY '' TO glaq019_desc
            IF NOT cl_null(g_glaq_m.glaq019) THEN 
               CALL s_voucher_glaq019_chk(g_glaq_m.glaq019,p_glapdocdt) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glaq_m.glaq019
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'aooi125'
                  LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi125'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_glaq_m.glaq019 = g_glaq_m_t.glaq019
                  CALL aglt310_02_ooef001_desc(g_glaq_m.glaq019) RETURNING g_glaq_m.glaq019_desc
                  DISPLAY BY NAME g_glaq_m.glaq019_desc
                  NEXT FIELD glaq019
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'03',g_glaq002,g_glaq_m.glaq019) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq019 = g_glaq_m_t.glaq019
                  CALL aglt310_02_ooef001_desc(g_glaq_m.glaq019) RETURNING g_glaq_m.glaq019_desc
                  DISPLAY BY NAME g_glaq_m.glaq019_desc
                  NEXT FIELD glaq019
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL aglt310_02_ooef001_desc(g_glaq_m.glaq019) RETURNING g_glaq_m.glaq019_desc
            DISPLAY BY NAME g_glaq_m.glaq019_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq019
            #add-point:BEFORE FIELD glaq019 name="input.b.glaq019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq019
            #add-point:ON CHANGE glaq019 name="input.g.glaq019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq020
            
            #add-point:AFTER FIELD glaq020 name="input.a.glaq020"
            DISPLAY '' TO glaq020_desc
            IF NOT cl_null(g_glaq_m.glaq020) THEN
               CALL s_azzi650_chk_exist('287',g_glaq_m.glaq020) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq020 = g_glaq_m_t.glaq020
                  CALL aglt310_02_glaq020_desc('287',g_glaq_m.glaq020) RETURNING g_glaq_m.glaq020_desc
                  DISPLAY BY NAME g_glaq_m.glaq020_desc
                  NEXT FIELD glaq020
               END IF
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'04',g_glaq002,g_glaq_m.glaq020) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq020 = g_glaq_m_t.glaq020
                  CALL aglt310_02_glaq020_desc('287',g_glaq_m.glaq020) RETURNING g_glaq_m.glaq020_desc
                  DISPLAY BY NAME g_glaq_m.glaq020_desc
                  NEXT FIELD glaq020
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL aglt310_02_glaq020_desc('287',g_glaq_m.glaq020) RETURNING g_glaq_m.glaq020_desc
            DISPLAY BY NAME g_glaq_m.glaq020_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq020
            #add-point:BEFORE FIELD glaq020 name="input.b.glaq020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq020
            #add-point:ON CHANGE glaq020 name="input.g.glaq020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq021
            
            #add-point:AFTER FIELD glaq021 name="input.a.glaq021"
            DISPLAY '' TO glaq021_desc
            IF NOT cl_null(g_glaq_m.glaq021) THEN
               CALL s_voucher_glaq021_chk(g_glaq_m.glaq021) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glaq_m.glaq021
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'apmm100'
                  LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                  LET g_errparam.exeprog = 'apmm100'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq021 = g_glaq_m_t.glaq021
                  CALL aglt310_02_glaq021_desc(g_glaq_m.glaq021) RETURNING g_glaq_m.glaq021_desc
                  DISPLAY BY NAME g_glaq_m.glaq021_desc
                  NEXT FIELD glaq021
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'05',g_glaq002,g_glaq_m.glaq021) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq021 = g_glaq_m_t.glaq021
                  CALL aglt310_02_glaq021_desc(g_glaq_m.glaq021) RETURNING g_glaq_m.glaq021_desc
                  DISPLAY BY NAME g_glaq_m.glaq021_desc
                  NEXT FIELD glaq021
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL aglt310_02_glaq021_desc(g_glaq_m.glaq021) RETURNING g_glaq_m.glaq021_desc
            DISPLAY BY NAME g_glaq_m.glaq021_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq021
            #add-point:BEFORE FIELD glaq021 name="input.b.glaq021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq021
            #add-point:ON CHANGE glaq021 name="input.g.glaq021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq022
            
            #add-point:AFTER FIELD glaq022 name="input.a.glaq022"
            DISPLAY '' TO glaq022_desc
            IF NOT cl_null(g_glaq_m.glaq022) THEN
               CALL s_voucher_glaq021_chk(g_glaq_m.glaq022) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glaq_m.glaq022
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'apmm100'
                  LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                  LET g_errparam.exeprog = 'apmm100'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq022 = g_glaq_m_t.glaq022
                  CALL aglt310_02_glaq021_desc(g_glaq_m.glaq022) RETURNING g_glaq_m.glaq022_desc
                  DISPLAY BY NAME g_glaq_m.glaq022_desc
                  NEXT FIELD glaq022
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'06',g_glaq002,g_glaq_m.glaq022) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq022 = g_glaq_m_t.glaq022
                  CALL aglt310_02_glaq021_desc(g_glaq_m.glaq022) RETURNING g_glaq_m.glaq022_desc
                  DISPLAY BY NAME g_glaq_m.glaq022_desc
                  NEXT FIELD glaq022
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL aglt310_02_glaq021_desc(g_glaq_m.glaq022) RETURNING g_glaq_m.glaq022_desc
            DISPLAY BY NAME g_glaq_m.glaq022_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq022
            #add-point:BEFORE FIELD glaq022 name="input.b.glaq022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq022
            #add-point:ON CHANGE glaq022 name="input.g.glaq022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq023
            
            #add-point:AFTER FIELD glaq023 name="input.a.glaq023"
             DISPLAY '' TO glaq023_desc
            IF NOT cl_null(g_glaq_m.glaq023) THEN
               CALL s_azzi650_chk_exist('281',g_glaq_m.glaq023) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq023 = g_glaq_m_t.glaq023
                  CALL aglt310_02_glaq020_desc('281',g_glaq_m.glaq023) RETURNING g_glaq_m.glaq023_desc
                  DISPLAY BY NAME g_glaq_m.glaq023_desc
                  NEXT FIELD glaq023
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'07',g_glaq002,g_glaq_m.glaq023) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq023 = g_glaq_m_t.glaq023
                  CALL aglt310_02_glaq020_desc('281',g_glaq_m.glaq023) RETURNING g_glaq_m.glaq023_desc
                  DISPLAY BY NAME g_glaq_m.glaq023_desc
                  NEXT FIELD glaq023
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL aglt310_02_glaq020_desc('281',g_glaq_m.glaq023) RETURNING g_glaq_m.glaq023_desc
            DISPLAY BY NAME g_glaq_m.glaq023_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq023
            #add-point:BEFORE FIELD glaq023 name="input.b.glaq023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq023
            #add-point:ON CHANGE glaq023 name="input.g.glaq023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq024
            
            #add-point:AFTER FIELD glaq024 name="input.a.glaq024"
            DISPLAY '' TO glaq024_desc
            IF NOT cl_null(g_glaq_m.glaq024) THEN
               CALL s_voucher_glaq024_chk(g_glaq_m.glaq024) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glaq_m.glaq024
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'arti202'
                  LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                  LET g_errparam.exeprog = 'arti202'
                  #160321-00016#30 --e add 
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq024 = g_glaq_m_t.glaq024
                  CALL aglt310_02_glaq024_desc(g_glaq_m.glaq024) RETURNING g_glaq_m.glaq024_desc
                  DISPLAY BY NAME g_glaq_m.glaq024_desc
                  NEXT FIELD glaq024
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'08',g_glaq002,g_glaq_m.glaq024) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq024 = g_glaq_m_t.glaq024
                  CALL aglt310_02_glaq024_desc(g_glaq_m.glaq024) RETURNING g_glaq_m.glaq024_desc
                  DISPLAY BY NAME g_glaq_m.glaq024_desc
                  NEXT FIELD glaq024
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL aglt310_02_glaq024_desc(g_glaq_m.glaq024) RETURNING g_glaq_m.glaq024_desc
            DISPLAY BY NAME g_glaq_m.glaq024_desc
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq024
            #add-point:BEFORE FIELD glaq024 name="input.b.glaq024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq024
            #add-point:ON CHANGE glaq024 name="input.g.glaq024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbc004
            
            #add-point:AFTER FIELD glbc004 name="input.a.glbc004"
            IF NOT cl_null(g_glaq_m.glbc004) THEN
               LET l_nmaistus='N'
               SELECT nmaistus INTO l_nmaistus FROM nmai_t 
                WHERE nmaient=g_enterprise AND nmai001=g_glaa005
                  AND nmai002=g_glaq_m.glbc004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = g_glaq_m.glbc004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glbc004=g_glaq_m_t.glbc004
                  NEXT FIELD glbc004
               END IF
               IF l_nmaistus<>'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  'sub-01302'  #160318-00005#17 mod'abg-00002'
                  LET g_errparam.extend = ''
                  #160318-00005#17  --add--str
                  LET g_errparam.replace[1] ='anmi160'
                  LET g_errparam.replace[2] = cl_get_progname('anmi160',g_lang,"2")
                  LET g_errparam.exeprog    ='anmi160'
                  #160318-00005#17 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glbc004=g_glaq_m_t.glbc004
                  NEXT FIELD glbc004
               END IF
            END IF
            CALL s_desc_get_nmail004_desc(g_glaa005,g_glaq_m.glbc004)  RETURNING g_glaq_m.glbc004_desc
            DISPLAY BY NAME g_glaq_m.glbc004_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbc004
            #add-point:BEFORE FIELD glbc004 name="input.b.glbc004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbc004
            #add-point:ON CHANGE glbc004 name="input.g.glbc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq051
            #add-point:BEFORE FIELD glaq051 name="input.b.glaq051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq051
            
            #add-point:AFTER FIELD glaq051 name="input.a.glaq051"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq051
            #add-point:ON CHANGE glaq051 name="input.g.glaq051"
            IF NOT cl_null(g_glaq_m.glaq051) THEN
               CALL s_voucher_glaq051_chk(g_glaq_m.glaq051) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glaq_m.glaq051
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq051 = g_glaq_m_t.glaq051
                  NEXT FIELD glaq051  #160729-00009#1 add
               END IF
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'09',g_glaq002,g_glaq_m.glaq051) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq051 = g_glaq_m_t.glaq051
                  NEXT FIELD glaq051
               END IF
               #160729-00009#1--add--end
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq052
            
            #add-point:AFTER FIELD glaq052 name="input.a.glaq052"
            DISPLAY '' TO glaq052_desc
            IF NOT cl_null(g_glaq_m.glaq052) THEN
               CALL s_voucher_glaq052_chk(g_glaq_m.glaq052) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glaq_m.glaq052
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq052 = g_glaq_m_t.glaq052
                  CALL aglt310_02_glaq052_desc(g_glaq_m.glaq052) RETURNING g_glaq_m.glaq052_desc
                  DISPLAY BY NAME g_glaq_m.glaq052_desc
                  NEXT FIELD glaq052
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'10',g_glaq002,g_glaq_m.glaq052) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq052 = g_glaq_m_t.glaq052
                  CALL aglt310_02_glaq052_desc(g_glaq_m.glaq052) RETURNING g_glaq_m.glaq052_desc
                  DISPLAY BY NAME g_glaq_m.glaq052_desc
                  NEXT FIELD glaq052
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL aglt310_02_glaq052_desc(g_glaq_m.glaq052) RETURNING g_glaq_m.glaq052_desc
            DISPLAY BY NAME g_glaq_m.glaq052_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq052
            #add-point:BEFORE FIELD glaq052 name="input.b.glaq052"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq052
            #add-point:ON CHANGE glaq052 name="input.g.glaq052"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq053
            
            #add-point:AFTER FIELD glaq053 name="input.a.glaq053"
            DISPLAY '' TO glaq053_desc
            IF NOT cl_null(g_glaq_m.glaq053) THEN
               CALL s_azzi650_chk_exist('2002',g_glaq_m.glaq053) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq053 = g_glaq_m_t.glaq053
                  CALL aglt310_02_glaq020_desc('2002',g_glaq_m.glaq053) RETURNING g_glaq_m.glaq053_desc
                  DISPLAY BY NAME g_glaq_m.glaq053_desc
                  NEXT FIELD glaq053
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'11',g_glaq002,g_glaq_m.glaq053) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq053 = g_glaq_m_t.glaq053
                  CALL aglt310_02_glaq020_desc('2002',g_glaq_m.glaq053) RETURNING g_glaq_m.glaq053_desc
                  DISPLAY BY NAME g_glaq_m.glaq053_desc
                  NEXT FIELD glaq053
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL aglt310_02_glaq020_desc('2002',g_glaq_m.glaq053) RETURNING g_glaq_m.glaq053_desc
            DISPLAY BY NAME g_glaq_m.glaq053_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq053
            #add-point:BEFORE FIELD glaq053 name="input.b.glaq053"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq053
            #add-point:ON CHANGE glaq053 name="input.g.glaq053"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq025
            
            #add-point:AFTER FIELD glaq025 name="input.a.glaq025"
            DISPLAY '' TO glaq025_desc
            IF NOT cl_null(g_glaq_m.glaq025) THEN
               CALL s_employee_chk(g_glaq_m.glaq025) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq025 = g_glaq_m_t.glaq025
                  CALL aglt310_02_glaq013_desc(g_glaq_m.glaq025) RETURNING g_glaq_m.glaq025_desc
                  DISPLAY BY NAME g_glaq_m.glaq025_desc
                  NEXT FIELD glaq025
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'12',g_glaq002,g_glaq_m.glaq025) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq025 = g_glaq_m_t.glaq025
                  CALL aglt310_02_glaq013_desc(g_glaq_m.glaq025) RETURNING g_glaq_m.glaq025_desc
                  DISPLAY BY NAME g_glaq_m.glaq025_desc
                  NEXT FIELD glaq025
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL aglt310_02_glaq013_desc(g_glaq_m.glaq025) RETURNING g_glaq_m.glaq025_desc
            DISPLAY BY NAME g_glaq_m.glaq025_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq025
            #add-point:BEFORE FIELD glaq025 name="input.b.glaq025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq025
            #add-point:ON CHANGE glaq025 name="input.g.glaq025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq027
            
            #add-point:AFTER FIELD glaq027 name="input.a.glaq027"
            DISPLAY '' TO glaq027_desc
            IF NOT cl_null(g_glaq_m.glaq027) THEN
               CALL s_aap_project_chk(g_glaq_m.glaq027) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glaq_m.glaq027
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'apjm200'
                  LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                  LET g_errparam.exeprog = 'apjm200'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq027 = g_glaq_m_t.glaq027
                  CALL s_desc_get_project_desc(g_glaq_m.glaq027) RETURNING g_glaq_m.glaq027_desc
                  DISPLAY BY NAME g_glaq_m.glaq027_desc
                  NEXT FIELD glaq027
               END IF
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'13',g_glaq002,g_glaq_m.glaq027) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq027 = g_glaq_m_t.glaq027
                  CALL s_desc_get_project_desc(g_glaq_m.glaq027) RETURNING g_glaq_m.glaq027_desc
                  DISPLAY BY NAME g_glaq_m.glaq027_desc
                  NEXT FIELD glaq027
               END IF
               #160729-00009#1--add--end               
            END IF 
            CALL s_desc_get_project_desc(g_glaq_m.glaq027) RETURNING g_glaq_m.glaq027_desc
            DISPLAY BY NAME g_glaq_m.glaq027_desc
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq027
            #add-point:BEFORE FIELD glaq027 name="input.b.glaq027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq027
            #add-point:ON CHANGE glaq027 name="input.g.glaq027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq028
            
            #add-point:AFTER FIELD glaq028 name="input.a.glaq028"
            DISPLAY '' TO glaq028_desc
            IF NOT cl_null(g_glaq_m.glaq028) THEN
               CALL s_voucher_glaq028_chk(g_glaq_m.glaq027,g_glaq_m.glaq028)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glaq_m.glaq028
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq028 = g_glaq_m_t.glaq028
                  CALL s_desc_get_wbs_desc(g_glaq_m.glaq027,g_glaq_m.glaq028) RETURNING g_glaq_m.glaq028_desc
                  DISPLAY BY NAME g_glaq_m.glaq028_desc
                  NEXT FIELD glaq028
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'14',g_glaq002,g_glaq_m.glaq028) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq028 = g_glaq_m_t.glaq028
                  CALL s_desc_get_wbs_desc(g_glaq_m.glaq027,g_glaq_m.glaq028) RETURNING g_glaq_m.glaq028_desc
                  DISPLAY BY NAME g_glaq_m.glaq028_desc
                  NEXT FIELD glaq028
               END IF
               #160729-00009#1--add--end  
            END IF 
            CALL s_desc_get_wbs_desc(g_glaq_m.glaq027,g_glaq_m.glaq028) RETURNING g_glaq_m.glaq028_desc
            DISPLAY BY NAME g_glaq_m.glaq028_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq028
            #add-point:BEFORE FIELD glaq028 name="input.b.glaq028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq028
            #add-point:ON CHANGE glaq028 name="input.g.glaq028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq017
            
            #add-point:AFTER FIELD glaq017 name="input.a.glaq017"
            DISPLAY '' TO glaq017_desc
            IF NOT cl_null(g_glaq_m.glaq017) THEN
               CALL s_voucher_glaq017_chk(g_glaq_m.glaq017) 
               IF NOT cl_null(g_errno) THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = g_errno
                 LET g_errparam.extend = g_glaq_m.glaq017
                 #160321-00016#30 --s add
                 LET g_errparam.replace[1] = 'aooi100'
                 LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                 LET g_errparam.exeprog = 'aooi100'
                 #160321-00016#30 --e add
                 LET g_errparam.popup = TRUE
                 CALL cl_err()

                 LET g_glaq_m.glaq017 = g_glaq_m_t.glaq017
                 CALL aglt310_02_ooef001_desc(g_glaq_m.glaq017) RETURNING g_glaq_m.glaq017_desc #160729-00009#1 add
                 DISPLAY g_glaq_m.glaq017_desc TO glaq017_desc #160729-00009#1 add
                 NEXT FIELD glaq017
               #161021-00037#3 --s add
               ELSE
                  INITIALIZE g_chkparam.* TO NULL 
                  LET g_chkparam.arg1 = g_glaq_m.glaq017
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  IF NOT cl_chk_exist("v_ooef001_13") THEN  
                     LET g_glaq_m.glaq017 = g_glaq_m_t.glaq017
                     CALL aglt310_02_ooef001_desc(g_glaq_m.glaq017) RETURNING g_glaq_m.glaq017_desc
                     DISPLAY g_glaq_m.glaq017_desc TO glaq017_desc 
                     NEXT FIELD glaq017
                  END IF
               #161021-00037#3 --e add
              END IF
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glapld,'01',g_glaq002,g_glaq_m.glaq017) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glaq_m.glaq017 = g_glaq_m_t.glaq017
                  CALL aglt310_02_ooef001_desc(g_glaq_m.glaq017) RETURNING g_glaq_m.glaq017_desc
                  DISPLAY g_glaq_m.glaq017_desc TO glaq017_desc
                  NEXT FIELD glaq017
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL aglt310_02_ooef001_desc(g_glaq_m.glaq017) RETURNING g_glaq_m.glaq017_desc
            DISPLAY g_glaq_m.glaq017_desc TO glaq017_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq017
            #add-point:BEFORE FIELD glaq017 name="input.b.glaq017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq017
            #add-point:ON CHANGE glaq017 name="input.g.glaq017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq029
            
            #add-point:AFTER FIELD glaq029 name="input.a.glaq029"
            DISPLAY '' TO glaq029_desc
            IF NOT cl_null(g_glaq_m.glaq029) THEN
               CALL s_voucher_free_account_chk(g_glad0171,g_glaq_m.glaq029,g_glad0172) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq029
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq029 = g_glaq_m_t.glaq029
                  CALL s_voucher_free_account_desc(g_glad0171,g_glaq_m.glaq029) RETURNING g_glaq_m.glaq029_desc
                  DISPLAY BY NAME g_glaq_m.glaq029_desc
                  NEXT FIELD glaq029
               END IF
            ELSE                            #151014-00015#1
               LET g_glaq_m.glaq029 = ' '   #151014-00015#1
            END IF
            CALL s_voucher_free_account_desc(g_glad0171,g_glaq_m.glaq029) RETURNING g_glaq_m.glaq029_desc
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
               CALL s_voucher_free_account_chk(g_glad0181,g_glaq_m.glaq030,g_glad0182) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq030
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq030 = g_glaq_m_t.glaq030
                  CALL s_voucher_free_account_desc(g_glad0181,g_glaq_m.glaq030) RETURNING g_glaq_m.glaq030_desc
                  DISPLAY BY NAME g_glaq_m.glaq030_desc
                  NEXT FIELD glaq030
               END IF
            ELSE                            #151014-00015#1
               LET g_glaq_m.glaq030 = ' '   #151014-00015#1               
            END IF
            CALL s_voucher_free_account_desc(g_glad0181,g_glaq_m.glaq030) RETURNING g_glaq_m.glaq030_desc
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
               CALL s_voucher_free_account_chk(g_glad0191,g_glaq_m.glaq031,g_glad0192) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq031
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq031 = g_glaq_m_t.glaq031
                  CALL s_voucher_free_account_desc(g_glad0191,g_glaq_m.glaq031) RETURNING g_glaq_m.glaq031_desc
                  DISPLAY BY NAME g_glaq_m.glaq031_desc
                  NEXT FIELD glaq031
               END IF
            ELSE                            #151014-00015#1
               LET g_glaq_m.glaq031 = ' '   #151014-00015#1                              
            END IF
            CALL s_voucher_free_account_desc(g_glad0191,g_glaq_m.glaq031) RETURNING g_glaq_m.glaq031_desc
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
               CALL s_voucher_free_account_chk(g_glad0201,g_glaq_m.glaq032,g_glad0202) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq032
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq032 = g_glaq_m_t.glaq032
                  CALL s_voucher_free_account_desc(g_glad0201,g_glaq_m.glaq032) RETURNING g_glaq_m.glaq032_desc
                  DISPLAY BY NAME g_glaq_m.glaq032_desc
                  NEXT FIELD glaq032
               END IF
            ELSE                            #151014-00015#1
               LET g_glaq_m.glaq032 = ' '   #151014-00015#1                              
            END IF
            CALL s_voucher_free_account_desc(g_glad0201,g_glaq_m.glaq032) RETURNING g_glaq_m.glaq032_desc
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
               CALL s_voucher_free_account_chk(g_glad0211,g_glaq_m.glaq033,g_glad0212) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq033
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq033 = g_glaq_m_t.glaq033
                  CALL s_voucher_free_account_desc(g_glad0211,g_glaq_m.glaq033) RETURNING g_glaq_m.glaq033_desc
                  DISPLAY BY NAME g_glaq_m.glaq033_desc
                  NEXT FIELD glaq033
               END IF
            ELSE                            #151014-00015#1
               LET g_glaq_m.glaq033 = ' '   #151014-00015#1                              
            END IF
            CALL s_voucher_free_account_desc(g_glad0211,g_glaq_m.glaq033) RETURNING g_glaq_m.glaq033_desc
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
               CALL s_voucher_free_account_chk(g_glad0221,g_glaq_m.glaq034,g_glad0222) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq034
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq034 = g_glaq_m_t.glaq034
                  CALL s_voucher_free_account_desc(g_glad0221,g_glaq_m.glaq034) RETURNING g_glaq_m.glaq034_desc
                  DISPLAY BY NAME g_glaq_m.glaq034_desc
                  NEXT FIELD glaq034
               END IF
            ELSE                            #151014-00015#1
               LET g_glaq_m.glaq034 = ' '   #151014-00015#1                              
            END IF
            CALL s_voucher_free_account_desc(g_glad0221,g_glaq_m.glaq034) RETURNING g_glaq_m.glaq034_desc
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
               CALL s_voucher_free_account_chk(g_glad0231,g_glaq_m.glaq035,g_glad0232) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq035
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq035 = g_glaq_m_t.glaq035
                  CALL s_voucher_free_account_desc(g_glad0231,g_glaq_m.glaq035) RETURNING g_glaq_m.glaq035_desc
                  DISPLAY BY NAME g_glaq_m.glaq035_desc
                  NEXT FIELD glaq035
               END IF
            ELSE                            #151014-00015#1
               LET g_glaq_m.glaq035 = ' '   #151014-00015#1                              
            END IF
            CALL s_voucher_free_account_desc(g_glad0231,g_glaq_m.glaq035) RETURNING g_glaq_m.glaq035_desc
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
               CALL s_voucher_free_account_chk(g_glad0241,g_glaq_m.glaq036,g_glad0242) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq036
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq036 = g_glaq_m_t.glaq036
                  CALL s_voucher_free_account_desc(g_glad0241,g_glaq_m.glaq036) RETURNING g_glaq_m.glaq036_desc
                  DISPLAY BY NAME g_glaq_m.glaq036_desc
                  NEXT FIELD glaq036
               END IF
            ELSE                            #151014-00015#1
               LET g_glaq_m.glaq036 = ' '   #151014-00015#1                              
            END IF
            CALL s_voucher_free_account_desc(g_glad0241,g_glaq_m.glaq036) RETURNING g_glaq_m.glaq036_desc
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
               CALL s_voucher_free_account_chk(g_glad0251,g_glaq_m.glaq037,g_glad0252) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq037
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq037 = g_glaq_m_t.glaq037
                  CALL s_voucher_free_account_desc(g_glad0251,g_glaq_m.glaq037) RETURNING g_glaq_m.glaq037_desc
                  DISPLAY BY NAME g_glaq_m.glaq037_desc
                  NEXT FIELD glaq037
               END IF
            ELSE                            #151014-00015#1
               LET g_glaq_m.glaq037 = ' '   #151014-00015#1                              
            END IF
            CALL s_voucher_free_account_desc(g_glad0251,g_glaq_m.glaq037) RETURNING g_glaq_m.glaq037_desc
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
               CALL s_voucher_free_account_chk(g_glad0261,g_glaq_m.glaq038,g_glad0262) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq_m.glaq038
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_m.glaq038 = g_glaq_m_t.glaq038
                  CALL s_voucher_free_account_desc(g_glad0261,g_glaq_m.glaq038) RETURNING g_glaq_m.glaq038_desc
                  DISPLAY BY NAME g_glaq_m.glaq038_desc
                  NEXT FIELD glaq038
               END IF
            ELSE                            #151014-00015#1
               LET g_glaq_m.glaq038 = ' '   #151014-00015#1                              
            END IF
            CALL s_voucher_free_account_desc(g_glad0261,g_glaq_m.glaq038) RETURNING g_glaq_m.glaq038_desc
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
                  #Ctrlp:input.c.glaq018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq018
            #add-point:ON ACTION controlp INFIELD glaq018 name="input.c.glaq018"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_glaq_m.glaq018             #給予default值

            #給予arg
            LET g_qryparam.arg1=p_glapdocdt
            
            #160729-00009#1--add--str--
            #agli060设置的部门限制条件
            #CALL s_voucher_get_glak_sql(g_glapld,'02',g_glaq002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glapld,'02',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_ooeg001_4()
            LET g_glaq_m.glaq018 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aglt310_02_ooef001_desc(g_glaq_m.glaq018) RETURNING g_glaq_m.glaq018_desc
            DISPLAY BY NAME g_glaq_m.glaq018_desc
            DISPLAY g_glaq_m.glaq018 TO glaq018              #顯示到畫面上
            NEXT FIELD glaq018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaq019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq019
            #add-point:ON ACTION controlp INFIELD glaq019 name="input.c.glaq019"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_glaq_m.glaq019             #給予default值

            #給予arg
            LET g_qryparam.arg1=p_glapdocdt
            LET g_qryparam.where = " ooeg003 IN ('1','2','3')"
            
            #160729-00009#1--add--str--
            #agli060设置的利润成本中心限制条件
            #CALL s_voucher_get_glak_sql(g_glapld,'03',g_glaq002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glapld,'03',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_ooeg001_4()  
            LET g_glaq_m.glaq019 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aglt310_02_ooef001_desc(g_glaq_m.glaq019) RETURNING g_glaq_m.glaq019_desc
            DISPLAY BY NAME g_glaq_m.glaq019_desc
            DISPLAY g_glaq_m.glaq019 TO glaq019              #顯示到畫面上
            LET g_qryparam.arg1 = ""
            NEXT FIELD glaq019                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaq020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq020
            #add-point:ON ACTION controlp INFIELD glaq020 name="input.c.glaq020"
             #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_glaq_m.glaq020             #給予default值

            #給予arg
            
            #160729-00009#1--add--str--
            #agli060设置的区域限制条件
            #CALL s_voucher_get_glak_sql(g_glapld,'04',g_glaq002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glapld,'04',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_oocq002_287()                                #呼叫開窗
            LET g_glaq_m.glaq020 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aglt310_02_glaq020_desc('287',g_glaq_m.glaq020) RETURNING g_glaq_m.glaq020_desc
            DISPLAY BY NAME g_glaq_m.glaq020_desc
            DISPLAY g_glaq_m.glaq020 TO glaq020              #顯示到畫面上
            LET g_qryparam.arg1 = ""
            NEXT FIELD glaq020                 
            #END add-point
 
 
         #Ctrlp:input.c.glaq021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq021
            #add-point:ON ACTION controlp INFIELD glaq021 name="input.c.glaq021"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_glaq_m.glaq021             #給予default值

            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的收付款客商限制条件
            #CALL s_voucher_get_glak_sql(g_glapld,'05',g_glaq002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glapld,'05',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗

            LET g_glaq_m.glaq021 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aglt310_02_glaq021_desc(g_glaq_m.glaq021) RETURNING g_glaq_m.glaq021_desc
            DISPLAY BY NAME g_glaq_m.glaq021_desc
            DISPLAY g_glaq_m.glaq021 TO glaq021              #顯示到畫面上

            NEXT FIELD glaq021                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaq022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq022
            #add-point:ON ACTION controlp INFIELD glaq022 name="input.c.glaq022"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_glaq_m.glaq022             #給予default值

            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的账款客商限制条件
            #CALL s_voucher_get_glak_sql(g_glapld,'06',g_glaq002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glapld,'06',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗

            LET g_glaq_m.glaq022 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aglt310_02_glaq021_desc(g_glaq_m.glaq022) RETURNING g_glaq_m.glaq022_desc
            DISPLAY BY NAME g_glaq_m.glaq022_desc
            DISPLAY g_glaq_m.glaq022 TO glaq022              #顯示到畫面上

            NEXT FIELD glaq022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaq023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq023
            #add-point:ON ACTION controlp INFIELD glaq023 name="input.c.glaq023"
             #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_glaq_m.glaq023             #給予default值

            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的客群限制条件
            #CALL s_voucher_get_glak_sql(g_glapld,'07',g_glaq002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glapld,'07',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_oocq002_281()                                #呼叫開窗
            LET g_glaq_m.glaq023 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aglt310_02_glaq020_desc('281',g_glaq_m.glaq023) RETURNING g_glaq_m.glaq023_desc
            DISPLAY BY NAME g_glaq_m.glaq023_desc
            DISPLAY g_glaq_m.glaq023 TO glaq023              #顯示到畫面上
            LET g_qryparam.arg1 = ""
            NEXT FIELD glaq023           
            #END add-point
 
 
         #Ctrlp:input.c.glaq024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq024
            #add-point:ON ACTION controlp INFIELD glaq024 name="input.c.glaq024"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_glaq_m.glaq024             #給予default值
            LET g_qryparam.where = " rtax004='",l_ooaa002,"'" #160614-00004#1 add
            #160729-00009#1--add--str--
            #agli060设置的产品类别限制条件
            #CALL s_voucher_get_glak_sql(g_glapld,'08',g_glaq002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glapld,'08',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql 
            CALL q_rtax001_1()
            #160729-00009#1--add--end
            #給予arg
           
#            CALL q_rtax001()                                #呼叫開窗 #160729-00009#1 mark

            LET g_glaq_m.glaq024 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aglt310_02_glaq024_desc(g_glaq_m.glaq024) RETURNING g_glaq_m.glaq024_desc
            DISPLAY BY NAME g_glaq_m.glaq024_desc
            DISPLAY g_glaq_m.glaq024 TO glaq024              #顯示到畫面上

            NEXT FIELD glaq024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glbc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbc004
            #add-point:ON ACTION controlp INFIELD glbc004 name="input.c.glbc004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_m.glbc004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where="nmai001='",g_glaa005,"'"

            CALL q_nmai002()                                #呼叫開窗

            LET g_glaq_m.glbc004 = g_qryparam.return1              

            DISPLAY g_glaq_m.glbc004 TO glbc004              #

            NEXT FIELD glbc004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaq051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq051
            #add-point:ON ACTION controlp INFIELD glaq051 name="input.c.glaq051"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaq052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq052
            #add-point:ON ACTION controlp INFIELD glaq052 name="input.c.glaq052"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_m.glaq052             #給予default值

            #給予arg
            LET g_qryparam.where = " oojdstus='Y' "
            #160729-00009#1--add--str--
            #agli060设置的通路限制条件
            #CALL s_voucher_get_glak_sql(g_glapld,'10',g_glaq002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glapld,'10',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_oojd001_2()                                #呼叫開窗

            LET g_glaq_m.glaq052 = g_qryparam.return1              
            CALL aglt310_02_glaq052_desc(g_glaq_m.glaq052) RETURNING g_glaq_m.glaq052_desc
            DISPLAY BY NAME g_glaq_m.glaq052_desc
            DISPLAY g_glaq_m.glaq052 TO glaq052              #

            NEXT FIELD glaq052                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaq053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq053
            #add-point:ON ACTION controlp INFIELD glaq053 name="input.c.glaq053"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_m.glaq053             #給予default值
            LET g_qryparam.default2 = "" #g_glaq_m.oocq002 #應用分類碼
            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的品牌限制条件
            #CALL s_voucher_get_glak_sql(g_glapld,'11',g_glaq002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glapld,'11',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_oocq002_2002()                                #呼叫開窗

            LET g_glaq_m.glaq053 = g_qryparam.return1              
            #LET g_glaq_m.oocq002 = g_qryparam.return2 
            DISPLAY g_glaq_m.glaq053 TO glaq053              #
            #DISPLAY g_glaq_m.oocq002 TO oocq002 #應用分類碼
            CALL aglt310_02_glaq020_desc('2002',g_glaq_m.glaq053) RETURNING g_glaq_m.glaq053_desc
            DISPLAY BY NAME g_glaq_m.glaq053_desc
            NEXT FIELD glaq053                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaq025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq025
            #add-point:ON ACTION controlp INFIELD glaq025 name="input.c.glaq025"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_glaq_m.glaq025             #給予default值
            LET g_qryparam.default2 = "" #g_glaq_m.oofa011 #全名

            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的人员限制条件
            #CALL s_voucher_get_glak_sql(g_glapld,'12',g_glaq002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glapld,'12',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_ooag001_8()                                #呼叫開窗

            LET g_glaq_m.glaq025 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_glaq_m.oofa011 = g_qryparam.return2 #全名
            CALL aglt310_02_glaq013_desc(g_glaq_m.glaq025) RETURNING g_glaq_m.glaq025_desc
            DISPLAY BY NAME g_glaq_m.glaq025_desc
            DISPLAY g_glaq_m.glaq025 TO glaq025              #顯示到畫面上
            #DISPLAY g_glaq_m.oofa011 TO oofa011 #全名

            NEXT FIELD glaq025                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaq027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq027
            #add-point:ON ACTION controlp INFIELD glaq027 name="input.c.glaq027"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_glaq_m.glaq027            #給予default值
            #160729-00009#1--add--str--
            #agli060设置的通路限制条件
            #CALL s_voucher_get_glak_sql(g_glapld,'13',g_glaq002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glapld,'13',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_pjba001()                                #呼叫開窗

            LET g_glaq_m.glaq027 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_desc_get_project_desc(g_glaq_m.glaq027) RETURNING g_glaq_m.glaq027_desc
            DISPLAY BY NAME g_glaq_m.glaq027_desc
            DISPLAY g_glaq_m.glaq027 TO glaq027              #顯示到畫面上
            #END add-point
 
 
         #Ctrlp:input.c.glaq028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq028
            #add-point:ON ACTION controlp INFIELD glaq028 name="input.c.glaq028"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_glaq_m.glaq028            #給予default值
            IF NOT cl_null(g_glaq_m.glaq027) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_glaq_m.glaq027,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            #160729-00009#1--add--str--
            #agli060设置的WBS限制条件
            #CALL s_voucher_get_glak_sql(g_glapld,'14',g_glaq002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glapld,'14',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_pjbb002()                                #呼叫開窗

            LET g_glaq_m.glaq028 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_desc_get_wbs_desc(g_glaq_m.glaq027,g_glaq_m.glaq028) RETURNING g_glaq_m.glaq028_desc
            DISPLAY BY NAME g_glaq_m.glaq028_desc
            DISPLAY g_glaq_m.glaq028 TO glaq028              #顯示到畫面上
            #END add-point
 
 
         #Ctrlp:input.c.glaq017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq017
            #add-point:ON ACTION controlp INFIELD glaq017 name="input.c.glaq017"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_glaq_m.glaq017             #給予default值

            #給予arg
            LET g_qryparam.where ="ooefstus='Y'"
            #160729-00009#1--add--str--
            #agli060设置的WBS限制条件
            #CALL s_voucher_get_glak_sql(g_glapld,'01',g_glaq002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glapld,'01',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql 
            #160729-00009#1--add--end
            LET g_qryparam.where = g_qryparam.where," AND ooef201 = 'Y' " #161021-00037#3 add
            CALL q_ooef001()
            LET g_glaq_m.glaq017 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aglt310_02_ooef001_desc(g_glaq_m.glaq017) RETURNING g_glaq_m.glaq017_desc
            DISPLAY BY NAME g_glaq_m.glaq017_desc
            DISPLAY g_glaq_m.glaq017 TO glaq017              #顯示到畫面上

            NEXT FIELD glaq017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaq029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq029
            #add-point:ON ACTION controlp INFIELD glaq029 name="input.c.glaq029"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            IF NOT cl_null(g_glae009) THEN
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
               CALL s_voucher_free_account_desc(g_glad0171,g_glaq_m.glaq029) RETURNING g_glaq_m.glaq029_desc
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
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            IF NOT cl_null(g_glae009) THEN
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
               CALL s_voucher_free_account_desc(g_glad0181,g_glaq_m.glaq030) RETURNING g_glaq_m.glaq030_desc#說明
    
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
            IF NOT cl_null(g_glae009) THEN
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
               CALL s_voucher_free_account_desc(g_glad0191,g_glaq_m.glaq031) RETURNING g_glaq_m.glaq031_desc#說明
   
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
            IF NOT cl_null(g_glae009) THEN
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
               CALL s_voucher_free_account_desc(g_glad0201,g_glaq_m.glaq032) RETURNING g_glaq_m.glaq032_desc
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
            IF NOT cl_null(g_glae009) THEN
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
               CALL s_voucher_free_account_desc(g_glad0211,g_glaq_m.glaq033) RETURNING g_glaq_m.glaq033_desc
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
            IF NOT cl_null(g_glae009) THEN
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
               CALL s_voucher_free_account_desc(g_glad0221,g_glaq_m.glaq034) RETURNING g_glaq_m.glaq034_desc#說明
    
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
            IF NOT cl_null(g_glae009) THEN
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
               CALL s_voucher_free_account_desc(g_glad0231,g_glaq_m.glaq035) RETURNING g_glaq_m.glaq035_desc#說明
   
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
            IF NOT cl_null(g_glae009) THEN
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
               CALL s_voucher_free_account_desc(g_glad0241,g_glaq_m.glaq036) RETURNING g_glaq_m.glaq036_desc#說明
    
               DISPLAY g_glaq_m.glaq036 TO glaq036              #顯示到畫面上
               DISPLAY g_glaq_m.glaq036_desc TO glaq036_desc    #說明
               NEXT FIELD glaq036                          #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.glaq037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq037
            #add-point:ON ACTION controlp INFIELD glaq037 name="input.c.glaq037"
            IF NOT cl_null(g_glae009) THEN
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
               CALL s_voucher_free_account_desc(g_glad0251,g_glaq_m.glaq037) RETURNING g_glaq_m.glaq037_desc
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
            IF NOT cl_null(g_glae009) THEN
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
               CALL s_voucher_free_account_desc(g_glad0261,g_glaq_m.glaq038) RETURNING g_glaq_m.glaq038_desc
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
   CLOSE WINDOW w_aglt310_02 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      RETURN g_glaq_r.glaq017,g_glaq_r.glaq018,g_glaq_r.glaq019,g_glaq_r.glaq020,g_glaq_r.glaq021,g_glaq_r.glaq022,
             g_glaq_r.glaq023,g_glaq_r.glaq024,g_glaq_r.glaq051,g_glaq_r.glaq052,g_glaq_r.glaq053,g_glaq_r.glaq025,
             g_glaq_r.glaq027,g_glaq_r.glaq028,g_glaq_r.glaq029,g_glaq_r.glaq030,g_glaq_r.glaq031,g_glaq_r.glaq032,
             g_glaq_r.glaq033,g_glaq_r.glaq034,g_glaq_r.glaq035,g_glaq_r.glaq036,g_glaq_r.glaq037,g_glaq_r.glaq038,
             g_glaq_r.glbc004 
   END IF
   #2015/1117--add--str--
   #当没有录入现金变动码时，现金变动码赋值=空格，用于现金变动码分割
   IF cl_null(g_glaq_m.glbc004) THEN 
      LET g_glaq_m.glbc004=' ' 
   END IF
   #2015/1117--add--end
   RETURN  g_glaq_m.glaq017,g_glaq_m.glaq018,g_glaq_m.glaq019,g_glaq_m.glaq020,g_glaq_m.glaq021,g_glaq_m.glaq022,
           g_glaq_m.glaq023,g_glaq_m.glaq024,g_glaq_m.glaq051,g_glaq_m.glaq052,g_glaq_m.glaq053,g_glaq_m.glaq025,
           g_glaq_m.glaq027,g_glaq_m.glaq028,g_glaq_m.glaq029,g_glaq_m.glaq030,g_glaq_m.glaq031,g_glaq_m.glaq032,
           g_glaq_m.glaq033,g_glaq_m.glaq034,g_glaq_m.glaq035,g_glaq_m.glaq036,g_glaq_m.glaq037,g_glaq_m.glaq038,
           g_glaq_m.glbc004
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglt310_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aglt310_02.other_function" readonly="Y" >}
#產品分類說明
PRIVATE FUNCTION aglt310_02_glaq024_desc(p_glaq024)
    DEFINE p_glaq024   LIKE glaq_t.glaq024
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaq024
    CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     RETURN  g_rtn_fields[1] 
END FUNCTION
#+ 產品分類資料檢查
PRIVATE FUNCTION aglt310_02_glaq024_chk(p_glaq024)
  DEFINE p_glaq024   LIKE glaq_t.glaq024
  DEFINE l_rtaxstus  LIKE rtax_t.rtaxstus

  LET g_errno = ''
  SELECT rtaxstus INTO l_rtaxstus FROM rtax_t
   WHERE rtaxent = g_enterprise
     AND rtax001 = p_glaq024

  CASE
     WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aoo-00137'
     WHEN l_rtaxstus = 'N'      LET g_errno = 'sub-01302'  #160318-00005#17 mod'aoo-00138'
  END CASE
END FUNCTION
#客商說明
PRIVATE FUNCTION aglt310_02_glaq021_desc(p_pmaa001)
   DEFINE p_pmaa001    LIKE pmaa_t.pmaa001

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION
#營運據點/部門/成本利潤中心說明
PRIVATE FUNCTION aglt310_02_ooef001_desc(p_ooef001)
   DEFINE p_ooef001     LIKE ooef_t.ooef001
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_ooef001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1] 
           
END FUNCTION
#预算编号说明
PRIVATE FUNCTION aglt310_02_glaq026_desc(p_glaq026)
   DEFINE p_glaq026      LIKE glaq_t.glaq026
   
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaq026
    CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1] 


END FUNCTION
#預算編號資料檢查
PRIVATE FUNCTION aglt310_02_glaq026_chk(p_glaq026)
    DEFINE p_glaq026     LIKE glaq_t.glaq026
    DEFINE l_bgaastus    LIKE bgaa_t.bgaastus
    
    LET g_errno = ''
     SELECT bgaastus INTO l_bgaastus FROM bgaa_t
   WHERE bgaaent = g_enterprise
     AND bgaa001 = p_glaq026

  CASE
     WHEN SQLCA.SQLCODE = 100   LET g_errno = 'abg-00007'
     WHEN l_bgaastus = 'N'      LET g_errno = 'sub-01302'  #160318-00005#17 mod#'abg-00008'
  END CASE
END FUNCTION
#人員資料檢查
PRIVATE FUNCTION aglt310_02_glaq013_chk(p_glaq013)
   DEFINE p_glaq013    LIKE glaq_t.glaq013 
   DEFINE  l_ooagstus  LIKE ooag_t.ooagstus


   LET g_errno=''
   SELECT ooagstus INTO l_ooagstus FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = p_glaq013

   CASE
      WHEN SQLCA.SQLCODE=100   LET g_errno = 'aoo-00074'
      WHEN l_ooagstus ='N'     LET g_errno = 'sub-01302'  #160318-00005#17 mod'aoo-00071'
   END CASE
END FUNCTION
#+計價單位檢查
PRIVATE FUNCTION aglt310_02_glaq007_chk(p_glaq007)
   DEFINE p_glaq007     LIKE glaq_t.glaq007
   DEFINE l_oocastus    LIKE ooca_t.oocastus
   
   LET g_errno = ''
   SELECT oocastus INTO l_oocastus FROM ooca_t
    WHERE oocaent = g_enterprise
      AND ooca001 = p_glaq007
    
    CASE  
        WHEN SQLCA.sqlcode = 100   LET g_errno = 'aim-00004'
        WHEN l_oocastus = 'N'      LET g_errno = 'sub-01302'  #160318-00005#17 mod #'aim-00005'
     END CASE
   
END FUNCTION
#部門/利潤成本中心檢查
PRIVATE FUNCTION aglt310_02_glaq018_chk(p_glaq018,p_glapdocdt)
   DEFINE l_ooegstus     LIKE ooeg_t.ooegstus
   DEFINE p_glaq018      LIKE glaq_t.glaq018
   DEFINE p_glapdocdt    LIKE glap_t.glapdocdt    #传票日期
   LET g_errno = ''
   
   SELECT ooegstus INTO l_ooegstus FROM ooeg_t
    WHERE ooegent = g_enterprise
      AND ooeg001 = p_glaq018
      AND ooeg006 <= p_glapdocdt
      AND (ooeg007 IS NULL OR ooeg007 >= p_glapdocdt ) 
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'abm-00006'
      WHEN l_ooegstus = 'N'       LET g_errno = 'sub-01302'  #160318-00005#17 mod#'abm-00007'
   END CASE
END FUNCTION
#營運據點資料檢查
PRIVATE FUNCTION aglt310_02_glaq017_chk(p_glaq017)
   DEFINE p_glaq017      LIKE glaq_t.glaq017
   DEFINE l_ooefstus     LIKE ooef_t.ooefstus
   
   LET g_errno = ''
   
   SELECT ooefstus INTO l_ooefstus FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_glaq017
      
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'aoo-00088'
      WHEN l_ooefstus = 'N'       LET g_errno = 'sub-01302'  #160318-00005#17 mod#'aoo-00089'
   END CASE
END FUNCTION
#人員全稱
PRIVATE FUNCTION aglt310_02_glaq013_desc(p_glaq013)
   DEFINE l_ooag011        LIKE ooag_t.ooag011
   DEFINE p_glaq013        LIKE glaq_t.glaq013

   LET  l_ooag011 = ''
   SELECT ooag011 INTO l_ooag011 FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = p_glaq013
   RETURN l_ooag011
END FUNCTION
#+说明
PRIVATE FUNCTION aglt310_02_show_ref()
    CALL aglt310_02_ooef001_desc(g_glaq_m.glaq017) RETURNING g_glaq_m.glaq017_desc
    DISPLAY BY NAME g_glaq_m.glaq017_desc
    
    CALL aglt310_02_ooef001_desc(g_glaq_m.glaq018) RETURNING g_glaq_m.glaq018_desc
    DISPLAY BY NAME g_glaq_m.glaq018_desc
    
    CALL aglt310_02_ooef001_desc(g_glaq_m.glaq019) RETURNING g_glaq_m.glaq019_desc
    DISPLAY BY NAME g_glaq_m.glaq019_desc 
    
    CALL aglt310_02_glaq020_desc('287',g_glaq_m.glaq020) RETURNING g_glaq_m.glaq020_desc
    DISPLAY BY NAME g_glaq_m.glaq020_desc 
    
    CALL aglt310_02_glaq021_desc(g_glaq_m.glaq021) RETURNING g_glaq_m.glaq021_desc
    DISPLAY BY NAME g_glaq_m.glaq021_desc 
    
    CALL aglt310_02_glaq021_desc(g_glaq_m.glaq022) RETURNING g_glaq_m.glaq022_desc
    DISPLAY BY NAME g_glaq_m.glaq022_desc 
    
    CALL aglt310_02_glaq020_desc('281',g_glaq_m.glaq023) RETURNING g_glaq_m.glaq023_desc
    DISPLAY BY NAME g_glaq_m.glaq023_desc 
    
    CALL aglt310_02_glaq024_desc(g_glaq_m.glaq024) RETURNING g_glaq_m.glaq024_desc
    DISPLAY BY NAME g_glaq_m.glaq024_desc 
    
    CALL aglt310_02_glaq013_desc(g_glaq_m.glaq025) RETURNING g_glaq_m.glaq025_desc
    DISPLAY BY NAME g_glaq_m.glaq025_desc 
    
#    CALL aglt310_02_glaq026_desc(g_glaq_m.glaq026) RETURNING g_glaq_m.glaq026_desc
#    DISPLAY BY NAME g_glaq_m.glaq026_desc 
   #渠道
   CALL aglt310_02_glaq052_desc(g_glaq_m.glaq052) RETURNING g_glaq_m.glaq052_desc
   DISPLAY BY NAME g_glaq_m.glaq052_desc
   #品牌
   CALL aglt310_02_glaq020_desc('2002',g_glaq_m.glaq053) RETURNING g_glaq_m.glaq053_desc
   DISPLAY BY NAME g_glaq_m.glaq053_desc  
   #現金變動碼
   CALL s_desc_get_nmail004_desc(g_glaa005,g_glaq_m.glbc004)  RETURNING g_glaq_m.glbc004_desc
   DISPLAY BY NAME g_glaq_m.glbc004_desc
   #自由核算项
   CALL s_voucher_free_account_desc(g_glad0171,g_glaq_m.glaq029) RETURNING g_glaq_m.glaq029_desc
   DISPLAY BY NAME g_glaq_m.glaq029_desc
   CALL s_voucher_free_account_desc(g_glad0181,g_glaq_m.glaq030) RETURNING g_glaq_m.glaq030_desc
   DISPLAY BY NAME g_glaq_m.glaq030_desc
   CALL s_voucher_free_account_desc(g_glad0191,g_glaq_m.glaq031) RETURNING g_glaq_m.glaq031_desc
   DISPLAY BY NAME g_glaq_m.glaq031_desc
   CALL s_voucher_free_account_desc(g_glad0201,g_glaq_m.glaq032) RETURNING g_glaq_m.glaq032_desc
   DISPLAY BY NAME g_glaq_m.glaq032_desc
   CALL s_voucher_free_account_desc(g_glad0211,g_glaq_m.glaq033) RETURNING g_glaq_m.glaq033_desc
   DISPLAY BY NAME g_glaq_m.glaq033_desc
   CALL s_voucher_free_account_desc(g_glad0221,g_glaq_m.glaq034) RETURNING g_glaq_m.glaq034_desc
   DISPLAY BY NAME g_glaq_m.glaq034_desc
   CALL s_voucher_free_account_desc(g_glad0231,g_glaq_m.glaq035) RETURNING g_glaq_m.glaq035_desc
   DISPLAY BY NAME g_glaq_m.glaq035_desc
   CALL s_voucher_free_account_desc(g_glad0241,g_glaq_m.glaq036) RETURNING g_glaq_m.glaq036_desc
   DISPLAY BY NAME g_glaq_m.glaq036_desc
   CALL s_voucher_free_account_desc(g_glad0251,g_glaq_m.glaq037) RETURNING g_glaq_m.glaq037_desc
   DISPLAY BY NAME g_glaq_m.glaq037_desc
   CALL s_voucher_free_account_desc(g_glad0261,g_glaq_m.glaq038) RETURNING g_glaq_m.glaq038_desc
   DISPLAY BY NAME g_glaq_m.glaq038_desc
END FUNCTION
#+区域客群说明
PRIVATE FUNCTION aglt310_02_glaq020_desc(p_oocql001,p_oocql002)
    DEFINE p_oocql001     LIKE oocql_t.oocql001
    DEFINE p_oocql002     LIKE oocql_t.oocql002
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_oocql001
    LET g_ref_fields[2] = p_oocql002
    CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1]
END FUNCTION
#区域客群检查
PRIVATE FUNCTION aglt310_02_glaq020_chk(p_oocq001,p_oocq002)
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
           LET g_errno = 'sub-01303' #'apm-00092' #160318-00005#17 mod 
        ELSE
           LET g_errno = 'axm-00003'  
        END IF 
     
     WHEN l_oocqstus = 'N'
        IF p_oocq001 = '287' THEN    
           LET g_errno =  'sub-01302'  #160318-00005#17 mod#'apm-00093' 
        ELSE
           LET g_errno = 'sub-01302'  #160318-00005#17 mod'axm-00004' 
        END IF       
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 渠道说明
# Memo...........:
# Usage..........: CALL aglt310_02_glaq052_desc(p_glaq052)
# Date & Author..: 2014/10/13 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_02_glaq052_desc(p_glaq052)
   DEFINE p_glaq052    LIKE glaq_t.glaq052
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaq052
   CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 修改操作時，將舊科目的核算項值賦值給新科目
# Memo...........:
# Usage..........: CALL aglt310_02_mod_default_set()
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_02_mod_default_set()

   #該科目做部門管理
   IF g_glad007 <> 'Y' OR g_glad007 IS NULL THEN
      LET g_glaq_r.glaq018 = ' ' 
   END IF 
   #該科目做利潤成本管理時
   IF g_glad008 <> 'Y' OR g_glad008 IS NULL THEN
      LET g_glaq_r.glaq019 = ' '      
   END IF 
   #該科目做區域管理時
   IF g_glad009 <> 'Y' OR g_glad009 IS NULL THEN
      LET g_glaq_r.glaq020 = ' '
   ELSE
      IF cl_null(g_glaq_r.glaq020) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'4') RETURNING g_glaq_r.glaq020
      END IF
   END IF 
   #該科目做客商管理
   IF g_glad010 <> 'Y' OR g_glad010 IS NULL THEN
      LET g_glaq_r.glaq021 = ' '
   ELSE
      IF cl_null(g_glaq_r.glaq021) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'5') RETURNING g_glaq_r.glaq021
      END IF
   END IF 
   #該科目做账款客商管理時
   IF g_glad027 <> 'Y' OR g_glad027 IS NULL THEN
      LET g_glaq_r.glaq022 = ' '
   ELSE
      IF cl_null(g_glaq_r.glaq022) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'6') RETURNING g_glaq_r.glaq022
      END IF
   END IF 
   #該科目做客群管理時
   IF g_glad011 <> 'Y' OR g_glad011 IS NULL THEN
      LET g_glaq_r.glaq023 = ' '     
   ELSE
      IF cl_null(g_glaq_r.glaq023) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'7') RETURNING g_glaq_r.glaq023
      END IF   
   END IF 
   #該科目做產品分類管理時，
   IF g_glad012 <> 'Y' OR g_glad012 IS NULL THEN
      LET g_glaq_r.glaq024 = ' '    
   ELSE
      IF cl_null(g_glaq_r.glaq024) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'8') RETURNING g_glaq_r.glaq024
      END IF
   END IF 
   #該科目做经营方式管理時，
   IF g_glad031 <> 'Y' OR g_glad031 IS NULL THEN
      LET g_glaq_r.glaq051 = ' '   
   ELSE
      IF cl_null(g_glaq_r.glaq051) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'9') RETURNING g_glaq_r.glaq051
      END IF
   END IF
   #該科目做渠道管理時，
   IF g_glad032 <> 'Y' OR g_glad032 IS NULL THEN
      LET g_glaq_r.glaq052 = ' '    
   ELSE
      IF cl_null(g_glaq_r.glaq052) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'10') RETURNING g_glaq_r.glaq052
      END IF
   END IF
   #該科目做品牌管理時，
   IF g_glad033 <> 'Y' OR g_glad033 IS NULL THEN
      LET g_glaq_r.glaq053 = ' '    
   ELSE
      IF cl_null(g_glaq_r.glaq053) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'11') RETURNING g_glaq_r.glaq053
      END IF
   END IF
   #該科目做人員管理時，
   IF g_glad013 <> 'Y' OR g_glad013 IS NULL THEN
      LET g_glaq_r.glaq025 = ' '        
   END IF 
   #該科目做專案管理時，
   IF g_glad015 <> 'Y' OR g_glad015 IS NULL THEN
      LET g_glaq_r.glaq027 = ' '     
   ELSE
      IF cl_null(g_glaq_r.glaq027) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'13') RETURNING g_glaq_r.glaq027
      END IF 
   END IF 
   #該科目做WBS管理時，
   IF g_glad016 <> 'Y' OR g_glad016 IS NULL THEN
      LET g_glaq_r.glaq028 = ' '   
   ELSE
      IF cl_null(g_glaq_r.glaq028) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'14') RETURNING g_glaq_r.glaq028
      END IF
   END IF 
   #核算项一
   IF g_glad017 <> 'Y' OR g_glad017 IS NULL THEN
      LET g_glaq_r.glaq029 = ' '   
   ELSE
      IF cl_null(g_glaq_r.glaq029) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'15') RETURNING g_glaq_r.glaq029
         IF cl_null(g_glaq_r.glaq029) THEN LET g_glaq_r.glaq029 = ' ' END IF   #151014-00015#1
      END IF      
   END IF 
   #核算项二
   IF g_glad018 <> 'Y' OR g_glad018 IS NULL THEN
      LET g_glaq_r.glaq030 = ' '   
   ELSE
      IF cl_null(g_glaq_r.glaq030) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'16') RETURNING g_glaq_r.glaq030
         IF cl_null(g_glaq_r.glaq030) THEN LET g_glaq_r.glaq030 = ' ' END IF   #151014-00015#1
      END IF
   END IF
   #核算项三
   IF g_glad019 <> 'Y' OR g_glad019 IS NULL THEN
      LET g_glaq_r.glaq031 = ' '  
   ELSE
      IF cl_null(g_glaq_r.glaq031) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'17') RETURNING g_glaq_r.glaq031
         IF cl_null(g_glaq_r.glaq031) THEN LET g_glaq_r.glaq031 = ' ' END IF   #151014-00015#1
      END IF   
   END IF
   #核算项四
   IF g_glad020 <> 'Y' OR g_glad020 IS NULL THEN
      LET g_glaq_r.glaq032 = ' '   
   ELSE
      IF cl_null(g_glaq_r.glaq032) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'18') RETURNING g_glaq_r.glaq032
         IF cl_null(g_glaq_r.glaq032) THEN LET g_glaq_r.glaq032 = ' ' END IF   #151014-00015#1
      END IF
   END IF
   #核算项五
   IF g_glad021 <> 'Y' OR g_glad021 IS NULL THEN
      LET g_glaq_r.glaq033 = ' '   
   ELSE
      IF cl_null(g_glaq_r.glaq033) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'19') RETURNING g_glaq_r.glaq033
         IF cl_null(g_glaq_r.glaq033) THEN LET g_glaq_r.glaq033 = ' ' END IF   #151014-00015#1
      END IF
   END IF
   #核算项四六
   IF g_glad022 <> 'Y' OR g_glad022 IS NULL THEN
      LET g_glaq_r.glaq034 = ' '   
   ELSE
      IF cl_null(g_glaq_r.glaq034) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'20') RETURNING g_glaq_r.glaq034
         IF cl_null(g_glaq_r.glaq034) THEN LET g_glaq_r.glaq034 = ' ' END IF   #151014-00015#1
      END IF
   END IF
   #核算项七
   IF g_glad023 <> 'Y' OR g_glad023 IS NULL THEN
      LET g_glaq_r.glaq035 = ' '   
   ELSE
      IF cl_null(g_glaq_r.glaq035) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'21') RETURNING g_glaq_r.glaq035
         IF cl_null(g_glaq_r.glaq035) THEN LET g_glaq_r.glaq035 = ' ' END IF   #151014-00015#1
      END IF
   END IF
   #核算项八
   IF g_glad024 <> 'Y' OR g_glad024 IS NULL THEN
      LET g_glaq_r.glaq036 = ' '   
   ELSE
      IF cl_null(g_glaq_r.glaq036) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'22') RETURNING g_glaq_r.glaq036
         IF cl_null(g_glaq_r.glaq036) THEN LET g_glaq_r.glaq036 = ' ' END IF   #151014-00015#1
      END IF
   END IF
   #核算项九
   IF g_glad025 <> 'Y' OR g_glad025 IS NULL THEN
      LET g_glaq_r.glaq037 = ' '   
   ELSE
      IF cl_null(g_glaq_r.glaq037) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'23') RETURNING g_glaq_r.glaq037
         IF cl_null(g_glaq_r.glaq037) THEN LET g_glaq_r.glaq037 = ' ' END IF   #151014-00015#1
      END IF
   END IF
   #核算项十
   IF g_glad026 <> 'Y' OR g_glad026 IS NULL THEN
      LET g_glaq_r.glaq038 = ' '   
   ELSE
      IF cl_null(g_glaq_r.glaq038) THEN
         CALL s_voucher_get_fix_default_value(g_glapld,g_glaq002,'24') RETURNING g_glaq_r.glaq038
         IF cl_null(g_glaq_r.glaq038) THEN LET g_glaq_r.glaq038 = ' ' END IF   #151014-00015#1
      END IF
   END IF
   LET g_glaq_m.glaq017 = g_glaq_r.glaq017
   LET g_glaq_m.glaq018 = g_glaq_r.glaq018
   LET g_glaq_m.glaq019 = g_glaq_r.glaq019
   LET g_glaq_m.glaq020 = g_glaq_r.glaq020
   LET g_glaq_m.glaq021 = g_glaq_r.glaq021
   LET g_glaq_m.glaq022 = g_glaq_r.glaq022
   LET g_glaq_m.glaq023 = g_glaq_r.glaq023
   LET g_glaq_m.glaq024 = g_glaq_r.glaq024
   LET g_glaq_m.glaq051 = g_glaq_r.glaq051
   LET g_glaq_m.glaq052 = g_glaq_r.glaq052
   LET g_glaq_m.glaq053 = g_glaq_r.glaq053
   LET g_glaq_m.glaq025 = g_glaq_r.glaq025
   LET g_glaq_m.glaq027 = g_glaq_r.glaq027
   LET g_glaq_m.glaq028 = g_glaq_r.glaq028
   LET g_glaq_m.glaq029 = g_glaq_r.glaq029
   LET g_glaq_m.glaq030 = g_glaq_r.glaq030
   LET g_glaq_m.glaq031 = g_glaq_r.glaq031
   LET g_glaq_m.glaq032 = g_glaq_r.glaq032
   LET g_glaq_m.glaq033 = g_glaq_r.glaq033
   LET g_glaq_m.glaq034 = g_glaq_r.glaq034
   LET g_glaq_m.glaq035 = g_glaq_r.glaq035
   LET g_glaq_m.glaq036 = g_glaq_r.glaq036
   LET g_glaq_m.glaq037 = g_glaq_r.glaq037
   LET g_glaq_m.glaq038 = g_glaq_r.glaq038
   LET g_glaq_m.glbc004 = g_glaq_r.glbc004
END FUNCTION
#客商資料檢查
PRIVATE FUNCTION aglt310_02_glaq021_chk(p_pmaa001)
   DEFINE p_pmaa002     LIKE pmaa_t.pmaa002
   DEFINE p_pmaa001     LIKE pmaa_t.pmaa001
   DEFINE l_pmaastus    LIKE pmaa_t.pmaastus

   LET g_errno = ''
   SELECT pmaastus INTO l_pmaastus FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = p_pmaa001

   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'apm-00028'
      WHEN l_pmaastus = 'N'      LET g_errno = 'sub-01302'  #160318-00005#17 mod'apm-00029'
   END CASE
END FUNCTION

 
{</section>}
 
