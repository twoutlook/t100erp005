#該程式未解開Section, 採用最新樣板產出!
{<section id="afap280_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2014-08-22 00:32:36), PR版次:0017(2017-02-22 16:13:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000146
#+ Filename...: afap280_01
#+ Description: 傳票底稿
#+ Creator....: 02599(2014-08-15 09:38:01)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="afap280_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#151001-00005#1   2015/10/08  By yangtt 臨時表afap280_01_fa_group名稱太長，只能為18碼,改成afap280_01_group
#160318-00005#9   2016/03/23  by 07675  將重複內容的錯誤訊息置換為公用錯誤訊息
#160405-00007#1   2016/04/05  By 02599  在产生分录底稿资料时，将临时表清空
#160318-00025#1   2016/04/05  By 07675  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160329-00025#3   2016/04/07  By 01531  新增盘盈盘亏处理
#140122-00001#129 2016/04/12  By lujh   增加afat522的邏輯
#160419-00060#1   2016/04/25  By Ann_Huang  調整借/貸方重估科目應該為fabh021,而非fabh022
#150918-00001#6   2016/04/30  By 02599  产生凭证时，当摘要为空，调用s_account_item带出预设值
#160525-00021#3   2016/05/25  By Dido   拋轉傳票指定傳票時宣告單別長度不足問題
#160426-00014#10  2016/07/25  By 01531  增加afat523的邏輯
#160727-00019#2   2016/08/01  By 08742  系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                       Mod   afap280_01_group -->afap280_tmp02
#                                       Mod   afap280_01_fa_tmp -->afap280_tmp01
#160727-00019#34   16/08/15   By 08734  临时表长度超过15码的减少到15码以下 s_pre_voucher_tmp ——> s_pre_vr_tmp01
#160905-00007#1   2016-09-05  By 08734  ent调整
#160913-00017#1   2016/09/19  By 07900  AFA模组调整交易客商开窗
#161024-00008#2   2016/10/24  By Hans   AFA組織類型與職能開窗清單調整。 
#160426-00014#45  2016/10/31  By 02114  增加afat517的逻辑
#160426-00014#44  2016/11/02  By 02114  增加afat510的逻辑
#161215-00044#1   2016/12/15  by 02481  标准程式定义采用宣告模式,弃用.*写
#161221-00030#1   2016/12/23  By 01531  参数是否转资产清理科目时，分录借贷颠倒了。应取消参数的判断
#170103-00019#11  2017/01/04  By 02599  抛转产生凭证时，同步产生相关细项立账资料
#161101-00014#6   2017/02/10  By 07900  aoos020勾选的‘资产转入清理科目’，分录产生错误，应该只有资产部分（借：累折、减值准备、清理科目 贷：固定资产）。
#170221-00042#1   2017/02/21  By 02599  afat507凭证为，借方：累折； 贷方，当aoos020勾选的‘资产转入清理科目’'S-FIN-9017'=Y 贷：清理科目， 'S-FIN-9017'=N 贷：固定资产
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
PRIVATE TYPE type_g_glaq_d        RECORD
       docno LIKE type_t.chr500, 
   docdt LIKE type_t.chr500, 
   glaq022 LIKE glaq_t.glaq022, 
   glaq022_desc LIKE type_t.chr500, 
   glaqseq LIKE glaq_t.glaqseq, 
   glaq001 LIKE glaq_t.glaq001, 
   glaq002 LIKE glaq_t.glaq002, 
   lc_subject LIKE type_t.chr500, 
   glaq003 LIKE glaq_t.glaq003, 
   glaq004 LIKE glaq_t.glaq004, 
   glaq040 LIKE glaq_t.glaq040, 
   glaq041 LIKE glaq_t.glaq041, 
   glaq043 LIKE glaq_t.glaq043, 
   glaq044 LIKE glaq_t.glaq044
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_loc                 LIKE type_t.chr5 
DEFINE g_glaa004             LIKE glaa_t.glaa004
TYPE type_g_glaq2_d        RECORD
       docno  LIKE xrca_t.xrcadocno, 
       seq     LIKE type_t.num5,       
       glaq002 LIKE glaq_t.glaq002,
       glaq002_desc LIKE type_t.chr80,       
       glaq017 LIKE glaq_t.glaq017,
       glaq017_desc LIKE type_t.chr80,       
       glaq018 LIKE glaq_t.glaq018, 
       glaq018_desc LIKE type_t.chr80,
       glaq019 LIKE glaq_t.glaq019,
       glaq019_desc LIKE type_t.chr80,
       glaq020 LIKE glaq_t.glaq020,
       glaq020_desc LIKE type_t.chr80,
       glaq021 LIKE glaq_t.glaq022,
       glaq021_desc LIKE type_t.chr80,
       glaq022 LIKE glaq_t.glaq022,
       glaq022_desc LIKE type_t.chr80,
       glaq023 LIKE glaq_t.glaq023,
       glaq023_desc LIKE type_t.chr80,
       glaq024 LIKE glaq_t.glaq024,
       glaq024_desc LIKE type_t.chr80,
       glaq025 LIKE glaq_t.glaq025,
       glaq025_desc LIKE type_t.chr80,
#       glaq026 LIKE glaq_t.glaq026,
#       glaq026_desc LIKE type_t.chr80,
       glaq027 LIKE glaq_t.glaq027,
       glaq028 LIKE glaq_t.glaq028,
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
       glaq038_desc LIKE type_t.chr80,
       source   LIKE type_t.chr100,
       sw       LIKE type_t.chr1,
       glaq001  LIKE glaq_t.glaq001
       END RECORD
DEFINE g_glaq2_d       DYNAMIC ARRAY OF type_g_glaq2_d
DEFINE g_glaq2_d_t     type_g_glaq2_d 
DEFINE l_ac4           LIKE type_t.num5
DEFINE g_rec_b4        LIKE type_t.num5 
DEFINE g_detail_idx4   LIKE type_t.num5 
#是否做自由科目核算项管理
DEFINE g_glad017       LIKE glad_t.glad017
DEFINE g_glad0171      LIKE glad_t.glad0171 
DEFINE g_glad0172      LIKE glad_t.glad0172 
DEFINE g_glad018       LIKE glad_t.glad018
DEFINE g_glad0181      LIKE glad_t.glad0181
DEFINE g_glad0182      LIKE glad_t.glad0182
DEFINE g_glad019       LIKE glad_t.glad019
DEFINE g_glad0191      LIKE glad_t.glad0191
DEFINE g_glad0192      LIKE glad_t.glad0192
DEFINE g_glad020       LIKE glad_t.glad020
DEFINE g_glad0201      LIKE glad_t.glad0201
DEFINE g_glad0202      LIKE glad_t.glad0202
DEFINE g_glad021       LIKE glad_t.glad021
DEFINE g_glad0211      LIKE glad_t.glad0211
DEFINE g_glad0212      LIKE glad_t.glad0212
DEFINE g_glad022       LIKE glad_t.glad022
DEFINE g_glad0221      LIKE glad_t.glad0221
DEFINE g_glad0222      LIKE glad_t.glad0222
DEFINE g_glad023       LIKE glad_t.glad023
DEFINE g_glad0231      LIKE glad_t.glad0231
DEFINE g_glad0232      LIKE glad_t.glad0232
DEFINE g_glad024       LIKE glad_t.glad024
DEFINE g_glad0241      LIKE glad_t.glad0241
DEFINE g_glad0242      LIKE glad_t.glad0242
DEFINE g_glad025       LIKE glad_t.glad025
DEFINE g_glad0251      LIKE glad_t.glad0251
DEFINE g_glad0252      LIKE glad_t.glad0252
DEFINE g_glad026       LIKE glad_t.glad026
DEFINE g_glad0261      LIKE glad_t.glad0261
DEFINE g_glad0262      LIKE glad_t.glad0262
#开窗编号
DEFINE g_glae009        LIKE glae_t.glae009
DEFINE g_glae002        LIKE glae_t.glae002
GLOBALS
   DEFINE g_fabgld             LIKE fabg_t.fabgld
   DEFINE g_fabg005            LIKE fabg_t.fabg005
   DEFINE g_type               LIKE type_t.chr1  
END GLOBALS
DEFINE g_input          RECORD 
       glapdocno        LIKE glap_t.glapdocno,
       glapdocdt        LIKE glap_t.glapdocdt,
       flag             LIKE type_t.chr1,
       docno_s          LIKE glap_t.glapdocno,
       docno_e          LIKE glap_t.glapdocno
                        END RECORD
DEFINE g_sql            STRING

TYPE type_g_glaq3_d        RECORD
       docno    LIKE glaq_t.glaqdocno,
       docdt    LIKE glap_t.glapdocdt,
       sw       LIKE type_t.chr1,     
       glaqent  LIKE glaq_t.glaqent,  
       glaqcomp LIKE glaq_t.glaqcomp, 
       glaqld   LIKE glaq_t.glaqld,   
       glaq001  LIKE glaq_t.glaq001,  
       glaq002  LIKE glaq_t.glaq002,  
       glaq005  LIKE glaq_t.glaq005,  
       glaq006  LIKE glaq_t.glaq006,  
       glaq007  LIKE glaq_t.glaq007,  
       glaq009  LIKE glaq_t.glaq009,  
       glaq011  LIKE glaq_t.glaq011,  
       glaq012  LIKE glaq_t.glaq012,  
       glaq013  LIKE glaq_t.glaq013,  
       glaq014  LIKE glaq_t.glaq014,  
       glaq015  LIKE glaq_t.glaq015,  
       glaq016  LIKE glaq_t.glaq016,  
       glaq017  LIKE glaq_t.glaq017,  
       glaq018  LIKE glaq_t.glaq018,  
       glaq019  LIKE glaq_t.glaq019,  
       glaq020  LIKE glaq_t.glaq020,  
       glaq021  LIKE glaq_t.glaq021,  
       glaq022  LIKE glaq_t.glaq022,  
       glaq023  LIKE glaq_t.glaq023,  
       glaq024  LIKE glaq_t.glaq024,  
       glaq025  LIKE glaq_t.glaq025,  
       glaq027  LIKE glaq_t.glaq027,  
       glaq028  LIKE glaq_t.glaq028,  
       glaq051  LIKE glaq_t.glaq051,  #經營方式
       glaq052  LIKE glaq_t.glaq052,  #渠道 
       glaq053  LIKE glaq_t.glaq053,  #品牌
       glaq029  LIKE glaq_t.glaq029,  
       glaq030  LIKE glaq_t.glaq030,  
       glaq031  LIKE glaq_t.glaq031,  
       glaq032  LIKE glaq_t.glaq032,  
       glaq033  LIKE glaq_t.glaq033,  
       glaq034  LIKE glaq_t.glaq034,  
       glaq035  LIKE glaq_t.glaq035,  
       glaq036  LIKE glaq_t.glaq036,  
       glaq037  LIKE glaq_t.glaq037,  
       glaq038  LIKE glaq_t.glaq038,   
       d        LIKE glaq_t.glaq003,  
       c        LIKE glaq_t.glaq004,  
       qty      LIKE glaq_t.glaq008,  
       sum      LIKE glaq_t.glaq010,
       glaq039  LIKE glaq_t.glaq039,
       glaq040  LIKE glaq_t.glaq040,
       glaq041  LIKE glaq_t.glaq041,
       glaq042  LIKE glaq_t.glaq042,
       glaq043  LIKE glaq_t.glaq043,
       glaq044  LIKE glaq_t.glaq044,
       seq      LIKE glaq_t.glaqseq,
       source   LIKE type_t.chr100,
       glaqseq  LIKE glaq_t.glaqseq,
       xrca039  LIKE xrca_t.xrca039
       END RECORD
DEFINE g_glaq3_d   DYNAMIC ARRAY OF type_g_glaq3_d
DEFINE g_prog_t    LIKE type_t.chr100   #150918-00001#6 add
#end add-point
 
DEFINE g_glaq_d          DYNAMIC ARRAY OF type_g_glaq_d
DEFINE g_glaq_d_t        type_g_glaq_d
 
 
DEFINE g_glaqld_t   LIKE glaq_t.glaqld    #Key值備份
DEFINE g_glaqdocno_t      LIKE glaq_t.glaqdocno    #Key值備份
DEFINE g_glaqseq_t      LIKE glaq_t.glaqseq    #Key值備份
 
 
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
 
{<section id="afap280_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION afap280_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_fabgld,p_fabg005,p_type,p_fabgdocno
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
   DEFINE p_fabgld        LIKE fabg_t.fabgld
   DEFINE p_fabg005       LIKE fabg_t.fabg005
   DEFINE p_type          LIKE type_t.chr2  
   DEFINE p_fabgdocno     LIKE fabg_t.fabgdocno
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_afap280_01 WITH FORM cl_ap_formpath("afa","afap280_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_glaq_d FROM s_detail1_afap280_01.*
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
         BEFORE FIELD docno
            #add-point:BEFORE FIELD docno name="input.b.page1_afap280_01.docno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD docno
            
            #add-point:AFTER FIELD docno name="input.a.page1_afap280_01.docno"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE docno
            #add-point:ON CHANGE docno name="input.g.page1_afap280_01.docno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD docdt
            #add-point:BEFORE FIELD docdt name="input.b.page1_afap280_01.docdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD docdt
            
            #add-point:AFTER FIELD docdt name="input.a.page1_afap280_01.docdt"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE docdt
            #add-point:ON CHANGE docdt name="input.g.page1_afap280_01.docdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq022
            
            #add-point:AFTER FIELD glaq022 name="input.a.page1_afap280_01.glaq022"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaq_d[l_ac].glaq022
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glaq_d[l_ac].glaq022_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaq_d[l_ac].glaq022_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq022
            #add-point:BEFORE FIELD glaq022 name="input.b.page1_afap280_01.glaq022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq022
            #add-point:ON CHANGE glaq022 name="input.g.page1_afap280_01.glaq022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqseq
            #add-point:BEFORE FIELD glaqseq name="input.b.page1_afap280_01.glaqseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqseq
            
            #add-point:AFTER FIELD glaqseq name="input.a.page1_afap280_01.glaqseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaqseq
            #add-point:ON CHANGE glaqseq name="input.g.page1_afap280_01.glaqseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq001
            #add-point:BEFORE FIELD glaq001 name="input.b.page1_afap280_01.glaq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq001
            
            #add-point:AFTER FIELD glaq001 name="input.a.page1_afap280_01.glaq001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq001
            #add-point:ON CHANGE glaq001 name="input.g.page1_afap280_01.glaq001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq002
            #add-point:BEFORE FIELD glaq002 name="input.b.page1_afap280_01.glaq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq002
            
            #add-point:AFTER FIELD glaq002 name="input.a.page1_afap280_01.glaq002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq002
            #add-point:ON CHANGE glaq002 name="input.g.page1_afap280_01.glaq002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lc_subject
            #add-point:BEFORE FIELD lc_subject name="input.b.page1_afap280_01.lc_subject"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lc_subject
            
            #add-point:AFTER FIELD lc_subject name="input.a.page1_afap280_01.lc_subject"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lc_subject
            #add-point:ON CHANGE lc_subject name="input.g.page1_afap280_01.lc_subject"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq003
            #add-point:BEFORE FIELD glaq003 name="input.b.page1_afap280_01.glaq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq003
            
            #add-point:AFTER FIELD glaq003 name="input.a.page1_afap280_01.glaq003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq003
            #add-point:ON CHANGE glaq003 name="input.g.page1_afap280_01.glaq003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq004
            #add-point:BEFORE FIELD glaq004 name="input.b.page1_afap280_01.glaq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq004
            
            #add-point:AFTER FIELD glaq004 name="input.a.page1_afap280_01.glaq004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq004
            #add-point:ON CHANGE glaq004 name="input.g.page1_afap280_01.glaq004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq040
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glaq_d[l_ac].glaq040,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD glaq040
            END IF 
 
 
 
            #add-point:AFTER FIELD glaq040 name="input.a.page1_afap280_01.glaq040"
            IF NOT cl_null(g_glaq_d[l_ac].glaq040) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq040
            #add-point:BEFORE FIELD glaq040 name="input.b.page1_afap280_01.glaq040"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq040
            #add-point:ON CHANGE glaq040 name="input.g.page1_afap280_01.glaq040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq041
            #add-point:BEFORE FIELD glaq041 name="input.b.page1_afap280_01.glaq041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq041
            
            #add-point:AFTER FIELD glaq041 name="input.a.page1_afap280_01.glaq041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq041
            #add-point:ON CHANGE glaq041 name="input.g.page1_afap280_01.glaq041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq043
            #add-point:BEFORE FIELD glaq043 name="input.b.page1_afap280_01.glaq043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq043
            
            #add-point:AFTER FIELD glaq043 name="input.a.page1_afap280_01.glaq043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq043
            #add-point:ON CHANGE glaq043 name="input.g.page1_afap280_01.glaq043"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq044
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glaq_d[l_ac].glaq044,"0.000","1","10.000","1","azz-00087",1) THEN 
 
               NEXT FIELD glaq044
            END IF 
 
 
 
            #add-point:AFTER FIELD glaq044 name="input.a.page1_afap280_01.glaq044"
            IF NOT cl_null(g_glaq_d[l_ac].glaq044) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq044
            #add-point:BEFORE FIELD glaq044 name="input.b.page1_afap280_01.glaq044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq044
            #add-point:ON CHANGE glaq044 name="input.g.page1_afap280_01.glaq044"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1_afap280_01.docno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD docno
            #add-point:ON ACTION controlp INFIELD docno name="input.c.page1_afap280_01.docno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afap280_01.docdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD docdt
            #add-point:ON ACTION controlp INFIELD docdt name="input.c.page1_afap280_01.docdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afap280_01.glaq022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq022
            #add-point:ON ACTION controlp INFIELD glaq022 name="input.c.page1_afap280_01.glaq022"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            #CALL q_pmaa001()      #160913-00017#1  MARK                       #呼叫開窗
             CALL q_pmaa001_25()   #160913-00017#1  ADD 

            LET g_glaq_d[l_ac].glaq022 = g_qryparam.return1              

            DISPLAY g_glaq_d[l_ac].glaq022 TO glaq022              #

            NEXT FIELD glaq022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afap280_01.glaqseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqseq
            #add-point:ON ACTION controlp INFIELD glaqseq name="input.c.page1_afap280_01.glaqseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afap280_01.glaq001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq001
            #add-point:ON ACTION controlp INFIELD glaq001 name="input.c.page1_afap280_01.glaq001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_oocq002_2()                                #呼叫開窗

            LET g_glaq_d[l_ac].glaq001 = g_qryparam.return1              

            DISPLAY g_glaq_d[l_ac].glaq001 TO glaq001              #

            NEXT FIELD glaq001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afap280_01.glaq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq002
            #add-point:ON ACTION controlp INFIELD glaq002 name="input.c.page1_afap280_01.glaq002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_glaq_d[l_ac].glaq002 = g_qryparam.return1              

            DISPLAY g_glaq_d[l_ac].glaq002 TO glaq002              #

            NEXT FIELD glaq002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afap280_01.lc_subject
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lc_subject
            #add-point:ON ACTION controlp INFIELD lc_subject name="input.c.page1_afap280_01.lc_subject"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].lc_subject             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_glaq_d[l_ac].lc_subject = g_qryparam.return1              

            DISPLAY g_glaq_d[l_ac].lc_subject TO lc_subject              #

            NEXT FIELD lc_subject                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_afap280_01.glaq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq003
            #add-point:ON ACTION controlp INFIELD glaq003 name="input.c.page1_afap280_01.glaq003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afap280_01.glaq004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq004
            #add-point:ON ACTION controlp INFIELD glaq004 name="input.c.page1_afap280_01.glaq004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afap280_01.glaq040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq040
            #add-point:ON ACTION controlp INFIELD glaq040 name="input.c.page1_afap280_01.glaq040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afap280_01.glaq041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq041
            #add-point:ON ACTION controlp INFIELD glaq041 name="input.c.page1_afap280_01.glaq041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afap280_01.glaq043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq043
            #add-point:ON ACTION controlp INFIELD glaq043 name="input.c.page1_afap280_01.glaq043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_afap280_01.glaq044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq044
            #add-point:ON ACTION controlp INFIELD glaq044 name="input.c.page1_afap280_01.glaq044"
            
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
   CLOSE WINDOW w_afap280_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afap280_01.other_dialog" readonly="Y" >}

################################################################################
# Descriptions...: 顯示傳票資料
# Memo...........:
# Usage..........: CALL afap280_01_display()
# Modify.........:
################################################################################
DIALOG afap280_01_display()
   DISPLAY ARRAY g_glaq_d TO s_detail1_afap280_01.* ATTRIBUTES(COUNT=g_rec_b) 
      
      BEFORE ROW
         LET l_ac = DIALOG.getCurrentRow("s_detail1_afap280_01")
         LET g_detail_idx = l_ac
               
      BEFORE DISPLAY
         IF g_loc = 'm' THEN
            CALL FGL_SET_ARR_CURR(g_detail_idx)
         END IF
         LET g_loc = 'm'
         LET l_ac = DIALOG.getCurrentRow("s_detail1_afap280_01")  

       ON ACTION afap280_s01
          IF l_ac > 0 THEN
             CALL afap280_01_s01(g_glaq_d[l_ac].docno,g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002,g_fabgld,g_type)                  
          END IF      
   END DISPLAY
END DIALOG

 
{</section>}
 
{<section id="afap280_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 傳票單身資料填充
# Memo...........:
# Usage..........: CALL afap280_01_glap_fill(p_sum_type,p_ld,p_docno,p_docdt,p_glaq022)
#                : p_sum_type      匯總方式
#                : p_ld            帳套
#                : p_docno         單據號碼
#                : p_docdt         單據日期
#                : p_glaq022       帳款客戶編號
################################################################################
PUBLIC FUNCTION afap280_01_glap_fill(p_sum_type,p_ld,p_docno,p_docdt,p_glaq022)
   DEFINE p_sum_type        LIKE type_t.chr1
   DEFINE p_ld              LIKE fabg_t.fabgld
   DEFINE p_docno           LIKE glap_t.glapdocno
   DEFINE p_docdt           LIKE glap_t.glapdocdt
   DEFINE p_glaq022         LIKE glaq_t.glaq022
   DEFINE l_sql             STRING
   DEFINE l_glaa015         LIKE glaa_t.glaa015
   DEFINE l_glaa016         LIKE glaa_t.glaa016
   DEFINE l_glaa019         LIKE glaa_t.glaa019
   DEFINE l_glaa020         LIKE glaa_t.glaa020
   DEFINE l_str1            STRING
   DEFINE l_str2            STRING
   DEFINE l_str3            STRING
   DEFINE l_str4            STRING
   DEFINE l_msg1            STRING
   DEFINE l_msg2            STRING
   DEFINE l_msg3            STRING
   DEFINE l_msg4            STRING

   CALL g_glaq_d.clear()
   
   IF p_sum_type = '1' THEN 
      CALL cl_set_comp_visible('docno,docdt',TRUE)
      CALL cl_set_comp_visible('glaq022,glaq022_desc',FALSE)       
   END IF
   IF p_sum_type = '2' THEN 
      CALL cl_set_comp_visible('docdt',TRUE)
      CALL cl_set_comp_visible('docno,glaq022,glaq022_desc',FALSE)   
   END IF
#   IF p_sum_type = '3' THEN 
#      CALL cl_set_comp_visible('glaq022,glaq022_desc',TRUE)
#      CALL cl_set_comp_visible('docdt,docno',FALSE) 
#   END IF
   
   SELECT glaa004,glaa015,glaa016,glaa019,glaa020
     INTO g_glaa004,l_glaa015,l_glaa016,l_glaa019,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = p_ld
      
   LET l_str1 = cl_getmsg("axr-00090",g_lang)     #借方金額(
   LET l_str2 = cl_getmsg("axr-00091",g_lang)     #貸方金額(
   LET l_str3 = cl_getmsg("axr-00092",g_lang)     #)(本位幣二)
   LET l_str4 = cl_getmsg("axr-00093",g_lang)     #)(本位幣三)
   
   LET l_msg1 = l_str1 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg2 = l_str2 CLIPPED,l_glaa016 CLIPPED,l_str3
   LET l_msg3 = l_str1 CLIPPED,l_glaa020 CLIPPED,l_str4
   LET l_msg4 = l_str2 CLIPPED,l_glaa020 CLIPPED,l_str4
      
   IF l_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible('glaq040,glaq041',TRUE)
      CALL cl_set_comp_att_text('glaq040',l_msg1)
      CALL cl_set_comp_att_text('glaq041',l_msg2)
   ELSE
      CALL cl_set_comp_visible('glaq040,glaq041',FALSE)
   END IF
      
   IF l_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('glaq043,glaq044',TRUE)
      CALL cl_set_comp_att_text('glaq043',l_msg3)
      CALL cl_set_comp_att_text('glaq044',l_msg4)
   ELSE
      CALL cl_set_comp_visible('glaq043,glaq044',FALSE)
   END IF

   IF p_sum_type = '1' THEN 
     #LET l_sql= " SELECT DISTINCT docno,docdt,'','',glaqseq,glaq001,glaq002,'',d,c,glaq040,glaq041,glaq043,glaq044 FROM afap280_01_fa_group ", #151001-00005#1
      LET l_sql= " SELECT DISTINCT docno,docdt,'','',glaqseq,glaq001,glaq002,'',d,c,glaq040,glaq041,glaq043,glaq044 FROM afap280_tmp02 ",    #151001-00005#1  #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
                 "  WHERE docno = '",p_docno,"'",
                 "  ORDER BY glaqseq,glaq002 "
   END IF
   IF p_sum_type = '2' THEN 
     #LET l_sql= " SELECT DISTINCT '',docdt,'','',glaqseq,glaq001,glaq002,'',d,c,glaq040,glaq041,glaq043,glaq044 FROM afap280_01_fa_group ",  #151001-00005#1
      LET l_sql= " SELECT DISTINCT '',docdt,'','',glaqseq,glaq001,glaq002,'',d,c,glaq040,glaq041,glaq043,glaq044 FROM afap280_tmp02 ",     #151001-00005#1    #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
                 "  WHERE docdt = '",p_docdt,"'",
                 "  ORDER BY glaqseq,glaq002 "                 
   END IF
#   IF p_sum_type = '3' THEN 
#      LET l_sql= " SELECT DISTINCT '','',glaq022,'',glaqseq,glaq001,glaq002,'',d,c,glaq040,glaq041,glaq043,glaq044 FROM s_voucher_ar_group ",
#                 "  WHERE glaq022 = '",p_glaq022,"'",
#                 "  ORDER BY glaqseq,glaq002 "
#   END IF   

   
   PREPARE glaq_pre FROM l_sql
   DECLARE glaq_cur CURSOR FOR glaq_pre

   LET l_ac = 1
   FOREACH glaq_cur INTO g_glaq_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
#      LET g_glaq_d_t[l_ac].glaq001 = g_glaq_d[l_ac].glaq001
      LET g_glaq_d[l_ac].glaqseq = l_ac
      CALL afap280_01_glaq002_desc(g_glaq_d[l_ac].glaq002,p_ld) RETURNING l_str1,l_str2
      LET g_glaq_d[l_ac].lc_subject =  g_glaq_d[l_ac].glaq002,l_str2,'\n',l_str1
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET l_ac=l_ac-1
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())
   
   LET g_rec_b = l_ac
   LET l_ac = 0
   
   DISPLAY g_rec_b TO h_count 
   FREE glaq_pre
END FUNCTION

################################################################################
# Descriptions...: 自动产生凭证
# Memo...........:
# Usage..........: CALL afap280_01_gen_ar(p_type,p_ld,p_date,p_slip,p_sum_type,p_wc,p_preview,p_prog)
#                       RETURNING r_success,g_glaq
# Input parameter: p_type         来源类型
#                                 1.afat503 資產重估
#                                 2.afat504 資產出售
#                : p_ld           帐套
#                : p_date         立帐日期
#                : p_slip         凭证单别
#                : p_sum_type     汇总方式 
#                : p_wc           ＱＢＥ的範圍條件
#                : p_preview      是否先預覽后再拋憑證（Y/N）
#                : p_prog         根據條件判斷憑證預覽範圍(程式代號)
# Return code....: r_success      成功否标识位
#                : g_glaq         傳票底稿清單
# Date & Author..: 2014/08/16 By wangrr
# Modify.........:
################################################################################
PUBLIC FUNCTION afap280_01_gen_ar(p_type,p_ld,p_date,p_slip,p_sum_type,p_wc,p_preview,p_prog)
   DEFINE p_type          LIKE type_t.chr2
   DEFINE p_ld            LIKE glaa_t.glaald
   DEFINE p_date          LIKE glap_t.glapdocdt
   DEFINE p_slip          LIKE ooba_t.ooba002
   DEFINE p_sum_type      LIKE type_t.chr1
   DEFINE p_wc            LIKE type_t.chr1000
   DEFINE p_preview       LIKE type_t.chr1
   DEFINE p_prog          LIKE gzza_t.gzza001
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_start_no      LIKE glap_t.glapdocno
   DEFINE r_end_no        LIKE glap_t.glapdocno
   DEFINE l_site          LIKE ooef_t.ooef001
   DEFINE l_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   
   LET r_success  = FALSE
   
 
   IF cl_null(p_ld) THEN
      #帐套参数为空
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00121'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #检查帐套是否正确
   CALL s_ld_chk_authorization(g_user,p_ld) RETURNING l_success
   IF l_success = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00022'
      LET g_errparam.extend = p_ld
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      RETURN r_success
   END IF 
   
   
   #检查单别CALL s_aooi200_chk_slip()
   #目前无法取得单别参数表号,需要再确认
   SELECT glaacomp INTO l_site FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = p_ld
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sel glaacomp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success 
   END IF
   
   IF cl_null(p_sum_type) THEN
      #产生凭证的汇总方式为空
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00123'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success 
   END IF
   
   IF cl_null(p_wc) THEN LET p_wc = " 1=1" END IF
   
   #CALL s_transaction_begin()   #151125-00006#1---mark by aiqq
   
   #检查事务中
   IF NOT s_transaction_chk('Y',1) THEN
      RETURN r_success
   END IF   

#151125-00006#1---mark--s by aiqq
#   #建立臨時表
#   CALL afap280_01_cre_fa_tmp_table() RETURNING l_success
#   IF NOT l_success THEN
#      RETURN r_success    
#   END IF
#151125-00006#1---mark--e by aiqq
   
   LET g_prog_t = p_prog #150918-00001#6 add
   
   #自動產生傳票底稿
   CALL afap280_01_gen_ar_1(p_type,p_ld,p_sum_type,p_wc,p_prog) RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success    
   END IF
 
   #將明細資料彙總
   DELETE FROM afap280_tmp02#160405-00007#1 add   #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
   CALL afap280_01_gen_fa_2_ins_group_tmp(p_ld,p_sum_type) RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success    
   END IF
   
   IF p_preview = 'Y' THEN   #先預覽,不產生憑證
      LET r_success=TRUE
      RETURN r_success
   ELSE                      #不預覽,直接產生憑證
      #插入凭证单头
      CALL afap280_01_gen_ar_2_ins_glap(p_slip,p_date,p_type,p_ld,p_sum_type)
         RETURNING r_success,r_start_no,r_end_no
      RETURN r_success  
   END IF

END FUNCTION

################################################################################
# Descriptions...: 自动产生凭证 定义CURSOR
# Memo...........:
# Usage..........: CALL afap280_01_gen_ar_def_cursor(p_type,p_ld,p_wc,p_sum_type,p_prog)
#                  RETURNING r_success
# Input parameter: p_type         異動類型
#                : p_ld           帐套
#                : p_wc           QBE条件(帐款来源)
#                : p_sum_type     匯總方式
# Return code....: r_success      成功否标识位
# Date & Author..: 2014/08/16 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_def_cursor(p_type,p_ld,p_wc,p_sum_type,p_prog)
   DEFINE p_type      LIKE type_t.chr2
   DEFINE p_ld        LIKE fabg_t.fabgld
   DEFINE p_wc        STRING
   DEFINE p_sum_type  LIKE type_t.chr1
   DEFINE p_prog      LIKE gzza_t.gzza001
   DEFINE l_sql       STRING
   DEFINE l_sql1      STRING   #存借方sql 账套等资料
   DEFINE l_sql2      STRING   #存核算项等资料
   DEFINE l_sql3      STRING   #表关联及where条件
   DEFINE l_sql4      STRING   #存贷方sql 账套等资料
   DEFINE l_sql43     STRING   #160426-00014#35
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_glab005   LIKE glab_t.glab005
   DEFINE l_ooab002   LIKE ooab_t.ooab002
   DEFINE l_glaacomp  LIKE glaa_t.glaacomp
   DEFINE l_para_data STRING
   
   LET r_success=FALSE
   #是否转入资产清理科目
   SELECT glaacomp INTO l_glaacomp FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_ld
    
   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9017') RETURNING l_ooab002
   
   #161215-00044#1---modify----begin-----------------
   #LET l_sql = "SELECT * FROM fabg_t ",
   LET l_sql = "SELECT fabgent,fabgcomp,fabgld,fabgdocno,fabgdocdt,fabgsite,fabg001,fabg002,fabg003,fabg004,",
               "fabg005,fabg006,fabg007,fabg008,fabg009,fabg010,fabg011,fabg012,fabg013,fabg014,fabg015,fabg016,",
               "fabg017,fabg018,fabg019,fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid,",
               "fabgmoddt,fabgcnfid,fabgcnfdt,fabgpstid,fabgpstdt,fabgud001,fabgud002,fabgud003,fabgud004,",
               "fabgud005,fabgud006,fabgud007,fabgud008,fabgud009,fabgud010,fabgud011,fabgud012,fabgud013,",
               "fabgud014,fabgud015,fabgud016,fabgud017,fabgud018,fabgud019,fabgud020,fabgud021,fabgud022,",
               "fabgud023,fabgud024,fabgud025,fabgud026,fabgud027,fabgud028,fabgud029,fabgud030,fabg020 FROM fabg_t ",
   #161215-00044#1---modify----end-----------------
               " WHERE fabgld = '",p_ld CLIPPED,"'",
               "   AND fabg005= '",p_type,"'",
               "   AND fabgent= ",g_enterprise, #160405-00007#1 add
              #"   AND fabgstus = 'S' ",
              #"   AND fabg008 IS NULL ",
               "   AND ",p_wc
   IF p_prog = 'afap280' THEN
      LET l_sql = l_sql CLIPPED,"   AND fabgstus = 'S' ",
                                "   AND fabg008 IS NULL "
   ELSE
      LET l_sql = l_sql CLIPPED
   END IF
   PREPARE afap280_01_gen_ar_1_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_1_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DECLARE afap280_01_gen_ar_1_cs1 CURSOR FOR afap280_01_gen_ar_1_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_1_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   #出售抓取fabo_t 其余类型抓取fabh_t
   IF p_type <> '4' THEN
#mark by yangxf ----
#      IF p_type = '22' OR p_type = '26' THEN 
#         LET l_sql1= "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,fabs013,"
#      ELSE
#                     #单号/日期/借/企业/法人/帐套/摘要
#         LET l_sql1= "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,fabh036,"
#      END IF
#mark by yangxf ---

#add by yangxf ---
      CASE 
         WHEN p_type = '22' OR p_type = '26'
                          #单号/日期/借/企业/法人/帐套/摘要
              LET l_sql1= "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,fabs013,"
         WHEN p_type = '30'
                          #单号/日期/借/企业/法人/帐套/摘要
              LET l_sql1= "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,fabp037,"
         OTHERWISE
                          #单号/日期/借/企业/法人/帐套/摘要
              LET l_sql1= "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,fabh036,"
      END CASE 
#add by yagnxf ---

      CASE 
         WHEN p_type = '14'  #減值準備時，原幣金額取減值準備金額值
                      #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
            LET l_sql2= "       fabg015,fabg016,fabh005,'',fabh019,'','',fabg002,'','','',"
         WHEN p_type = '9'  #改良時，原幣金額取改良成本金額值
                      #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
            LET l_sql2= "       fabg015,fabg016,fabh005,'',fabh010,'','',fabg002,'','','',"
         WHEN p_type = '0'  #折旧時，原幣金額取折旧金額值
                      #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
            LET l_sql2= "       fabg015,fabg016,fabh005,'',fabh010,'','',fabg002,'','','',"
         #140122-00001#129--add--str--lujh
         WHEN p_type = '35'  #投保保险
                      #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
            LET l_sql2= "       fabg015,fabg016,fabh005,'',fabh010,'','',fabg002,'','','',"
         #140122-00001#129--add--end--lujh
         WHEN p_type = '22' OR p_type = '26'   #资本化
                      #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
            LET l_sql2= "       fabs009,fabs010,'','',fabs011,'','',fabg002,'','','',"
         #add by yangxf ---
         WHEN p_type = '30'
                      #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
            LET l_sql2= "       fabg015,fabg016,'','',fabp006,'','',fabg002,'','','',"
         #add by yangxf ---
         #150417-00007#65--add--str--
         WHEN p_type = '31'
            LET l_sql2 = " "
         #150417-00007#65--add--end
         OTHERWISE
                        #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
            LET l_sql2= "       fabg015,fabg016,fabh005,'',fabh008,'','',fabg002,'','','',"
      END CASE
#mark by yangxf ---
#      IF p_type = '22'  OR p_type = '26' THEN 
#                                              #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
#         LET l_sql2 = l_sql2 CLIPPED, "       fabs014,fabs015,fabs016,fabs017,fabs018,fabs019,fabs020,fabs021,fabs022,",
#                     #专案编号/WBS/自由核算项1~10
#                     "       fabs024,fabs025,'','','','','','','','','','','','','',"
#      ELSE
#                                         #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
#         LET l_sql2 = l_sql2 CLIPPED, "       fabh026,fabh027,fabh028,fabh029,fabh030,fabh031,fabh032,'',fabh033,",
#                     #专案编号/WBS/自由核算项1~10
#                    #"       fabh034,fabh035,fabh041,fabh042,fabh043,'','','','','','','','','','',"    #mark by yangxf
#                     "       fabh034,fabh035,fabh041,fabh042,fabh043,fabh060,fabh061,fabh062,fabh063,fabh064,fabh065,fabh066,fabh067,fabh068,fabh069,"  #add by yangxf
#      END IF 
#      
#      IF p_type = '22'  OR p_type = '26' THEN 
#                     #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
#         LET l_sql3= "       fabsseq,'fabs','','',1 ",
#                     "  FROM fabg_t,fabs_t ",
#                     " WHERE fabgent   = ",g_enterprise,
#                     "   AND fabgld    = '",p_ld CLIPPED,"'",
#                     "   AND fabgdocno = ? ",
#                     "   AND fabgent   = fabsent ",
#                     "   AND fabgld    = fabsld  ",
#                     "   AND fabgdocno = fabsdocno "    
#                     
#                     #单号/日期/借/企业/法人/帐套/摘要
#         LET l_sql4= "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,fabs013,"
#      ELSE
#                     #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
#         LET l_sql3= "       fabhseq,'fabh','','',1 ",
#                     "  FROM fabg_t,fabh_t ",
#                     " WHERE fabgent   = ",g_enterprise,
#                     "   AND fabgld    = '",p_ld CLIPPED,"'",
#                     "   AND fabgdocno = ? ",
#                     "   AND fabgent   = fabhent ",
#                     "   AND fabgld    = fabhld  ",
#                     "   AND fabgdocno = fabhdocno "    
#                     
#                     #单号/日期/借/企业/法人/帐套/摘要
#         LET l_sql4= "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,fabh036,"
#      END IF 
#mark by yangxf ---
#add by yangxf ---
      CASE 
         WHEN p_type = '22'  OR p_type = '26' 
                                                   #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
              LET l_sql2 = l_sql2 CLIPPED, "       fabs014,fabs015,fabs016,fabs017,fabs018,fabs019,fabs020,fabs021,fabs022,",
                                                   #专案编号/WBS/自由核算项1~10
                                           "       fabs024,fabs025,'','','','','','','','','','','','','',"
                                  #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
              LET l_sql3= "       fabsseq,'fabs','','',1 ",
                          "  FROM fabg_t,fabs_t ",
                          " WHERE fabgent   = ",g_enterprise,
                          "   AND fabgld    = '",p_ld CLIPPED,"'",
                          "   AND fabgdocno = ? ",
                          "   AND fabgent   = fabsent ",
                          "   AND fabgld    = fabsld  ",
                          "   AND fabgdocno = fabsdocno "    
                          
                          #单号/日期/借/企业/法人/帐套/摘要
              LET l_sql4= "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,fabs013,"
         WHEN p_type = '30'
                                            #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
              LET l_sql2 = l_sql2 CLIPPED, "       fabp027,fabp028,fabp029,fabp030,fabp031,fabp032,fabp033,'',fabp034,",
                                           #专案编号/WBS/自由核算项1~10
                                           "       fabp035,fabp036,fabp038,fabp039,fabp040,fabp041,fabp042,fabp043,fabp044,fabp045,fabp046,fabp047,fabp048,fabp049,fabp050,"
                          #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
              LET l_sql3= "       fabpseq,'fabp','','',1 ",
                          "  FROM fabg_t,fabp_t ",
                          " WHERE fabgent   = ",g_enterprise,
                          "   AND fabgld    = '",p_ld CLIPPED,"'",
                          "   AND fabgdocno = ? ",
                          "   AND fabgent   = fabpent ",
                          "   AND fabgld    = fabpld  ",
                          "   AND fabgdocno = fabpdocno "    
                          
                          #单号/日期/借/企业/法人/帐套/摘要
              LET l_sql4= "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,fabp037,"
         
         #160329-00025#1 add--str-
         #盘盈考虑帐面数量fabh006是否为0         
         WHEN p_type = '23'
                                            #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
              LET l_sql2 = l_sql2 CLIPPED, "       fabh026,fabh027,fabh028,fabh029,fabh030,fabh031,fabh032,'',fabh033,",
                                           #专案编号/WBS/自由核算项1~10
                                           "       fabh034,fabh035,fabh041,fabh042,fabh043,fabh060,fabh061,fabh062,fabh063,fabh064,fabh065,fabh066,fabh067,fabh068,fabh069,"
                          #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
              LET l_sql3= "       fabhseq,'fabh','','',1,fabh006 ", 
                          "  FROM fabg_t,fabh_t ",
                          " WHERE fabgent   = ",g_enterprise,
                          "   AND fabgld    = '",p_ld CLIPPED,"'",
                          "   AND fabgdocno = ? ",
                          "   AND fabgent   = fabhent ",
                          "   AND fabgld    = fabhld  ",
                          "   AND fabgdocno = fabhdocno "
                          
                          #单号/日期/借/企业/法人/帐套/摘要
              LET l_sql4= "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,fabh036,"
              
         OTHERWISE
                                            #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
              LET l_sql2 = l_sql2 CLIPPED, "       fabh026,fabh027,fabh028,fabh029,fabh030,fabh031,fabh032,'',fabh033,",
                                           #专案编号/WBS/自由核算项1~10
                                           "       fabh034,fabh035,fabh041,fabh042,fabh043,fabh060,fabh061,fabh062,fabh063,fabh064,fabh065,fabh066,fabh067,fabh068,fabh069,"
                          #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
              LET l_sql3= "       fabhseq,'fabh','','',1 ",
                          "  FROM fabg_t,fabh_t ",
                          " WHERE fabgent   = ",g_enterprise,
                          "   AND fabgld    = '",p_ld CLIPPED,"'",
                          "   AND fabgdocno = ? ",
                          "   AND fabgent   = fabhent ",
                          "   AND fabgld    = fabhld  ",
                          "   AND fabgdocno = fabhdocno "
                          
                          #单号/日期/借/企业/法人/帐套/摘要
              LET l_sql4= "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,fabh036,"
      END CASE 
#add by yangxf ---

   ELSE
                  #单号/日期/借/企业/法人/帐套/摘要/科目
      LET l_sql1= "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,fabo042,"
      
     #            #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
     #LET l_sql5= "       fabg015,fabg016,fabo005,'',fabo008,'','',fabg002,'','','',",
                  #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
      LET l_sql2= "       fabo031,fabo032,fabo033,fabo034,fabo035,fabo036,fabo037,'',fabo038,",
                  #专案编号/WB/自由核算项1~10
                  "       fabo039,fabo040,fabo054,fabo055,fabo056,'','','','','','','','','','',"
                  
                  #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
      LET l_sql3= "       faboseq,'fabo','','',1 ",
                  "  FROM fabg_t,fabo_t ",
                  " WHERE fabgent   = ",g_enterprise,
                  "   AND fabgld    = '",p_ld CLIPPED,"'",
                  "   AND fabgdocno = ? ",
                  "   AND fabgent   = faboent ",
                  "   AND fabgld    = fabold  ",
                  "   AND fabgdocno = fabodocno " 
                  
                  #单号/日期/贷/企业/法人/帐套/摘要/科目
      LET l_sql4= "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,fabo042,"                   
   END IF
   
   CASE
      #销账/报废
      WHEN p_type='6' OR p_type='21'
         #借：固定资产清理fabh021 金额：本币成本-累计折旧-已提列减值准备(fabh008-fabh011-fabh017)
         #IF l_ooab002='Y' THEN   #161221-00030#1 mark
            LET l_sql = l_sql1,
                        #科目
                        " fabh021,",
                        l_sql2,
                        #借/贷/计价数量/原币金额
                        " fabh008-fabh011-fabh017,0,fabh007,fabh008-fabh011-fabh017,",
                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                        " fabh101,fabh102-fabh104-fabh109,0,fabh151,fabh152-fabh154-fabh159,0,",
                        l_sql3,
                        " AND (fabh008-fabh011-fabh017)<>0 "
#161221-00030#1 mark s---                        
#          ELSE
#             LET l_sql = l_sql4,
#                        #科目
#                        " fabh021,",
#                        l_sql2,
#                        #借/贷/计价数量/原币金额
#                        " 0,fabh008-fabh011-fabh017,fabh007,fabh008-fabh011-fabh017,",
#                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
#                        " fabh101,0,fabh102-fabh104-fabh109,fabh151,0,fabh152-fabh154-fabh159,",
#                        l_sql3,
#                        " AND (fabh008-fabh011-fabh017)<>0 "
#          END IF
#161221-00030#1 mark e---
         PREPARE afap280_01_gen_ar_6_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_6_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_6_d_cs1 CURSOR FOR afap280_01_gen_ar_6_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_6_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF   

         #借：累计折旧fabh023 金额：累计折旧fabh011
         #IF l_ooab002='Y' THEN #161221-00030#1 mark 
            LET l_sql = l_sql1,
                        #科目
                        " fabh023,",
                        l_sql2,
                        #借/贷/计价数量/原币金额
                        " fabh011,0,fabh007,fabh011,",
                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                        " fabh101,fabh104,0,fabh151,fabh154,0,",
                        l_sql3,
                        " AND fabh011<>0 "
#161221-00030#1 mark s---                         
#         ELSE
#            LET l_sql = l_sql4,
#                        #科目
#                        " fabh023,",
#                        l_sql2,
#                        #借/贷/计价数量/原币金额
#                        " 0,fabh011,fabh007,fabh011,",
#                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
#                        " fabh101,0,fabh104,fabh151,0,fabh154,",
#                        l_sql3,
#                        " AND fabh011<>0 "
#         END IF
#161221-00030#1 mark e--- 
         PREPARE afap280_01_gen_ar_6_d_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_6_d_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_6_d_cs2 CURSOR FOR afap280_01_gen_ar_6_d_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_6_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF    
         
         #借：减值准备科目fabh025 金额：已提列减准备fabh017>0
         #IF l_ooab002='Y' THEN #161221-00030#1 mark  
            LET l_sql = l_sql1,
                        #科目
                        " fabh025,",
                        l_sql2,
                        #借/贷/计价数量/原币金额
                        " fabh017,0,fabh007,fabh017,",
                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                        " fabh101,fabh109,0,fabh151,fabh159,0,",
                        l_sql3,
                        " AND fabh017<>0 "
#161221-00030#1 mark s---                         
#         ELSE
#            LET l_sql = l_sql4,
#                        #科目
#                        " fabh025,",
#                        l_sql2,
#                        #借/贷/计价数量/原币金额
#                        " 0,fabh017,fabh007,fabh017,",
#                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
#                        " fabh101,0,fabh109,fabh151,0,fabh159,",
#                        l_sql3,
#                        " AND fabh017<>0 "
#         END IF
#161221-00030#1 mark e--- 
         PREPARE afap280_01_gen_ar_6_d_p3 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_6_d_p3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_6_d_cs3 CURSOR FOR afap280_01_gen_ar_6_d_p3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_6_d_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF             
                     
         #贷：固定资产资产科目fabh024 金额：本币成本fabh008
         #IF l_ooab002='Y' THEN #161221-00030#1 mark
         #170221-00042#1--mod--str--
         IF l_ooab002='Y' THEN
            #贷方，当aoos020勾选的‘资产转入清理科目’'S-FIN-9017'=Y 贷：清理科目， 'S-FIN-9017'=N 贷：固定资产
            #固定資產清理科目
            SELECT glab005 INTO l_glab005 FROM glab_t
             WHERE glabent=g_enterprise AND glabld=p_ld AND glab001='90' AND glab002='25' AND glab003='9902_12'
            LET l_sql = l_sql4,
                        #科目
                        "'",l_glab005,"',"
         ELSE
            LET l_sql = l_sql4,
                        #科目
                        " fabh024,"
         END IF
         LET l_sql = l_sql,   
         #170221-00042#1--mod--end
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh008,fabh007,fabh008,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh102,fabh151,0,fabh152,",
                     l_sql3,
                     " AND fabh008<>0"
#161221-00030#1 mark s---                         
#         ELSE
#            LET l_sql = l_sql1,
#                        #科目
#                        " fabh024,",
#                        l_sql2,
#                        #借/贷/计价数量/原币金额
#                        " fabh008,0,fabh007,fabh008,",
#                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
#                        " fabh101,fabh102,0,fabh151,fabh152,0,",
#                        l_sql3,
#                        " AND fabh008<>0"
#         END IF
#161221-00030#1 mark e--- 
         PREPARE afap280_01_gen_ar_6_c_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_6_c_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_6_c_cs1 CURSOR FOR afap280_01_gen_ar_6_c_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_6_c_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
      #重估  
      WHEN p_type='8'  OR p_type='39' #160426-00014#10 add '39'
         #累计折旧虽属资产类科目,实质上就是资产的减项,计提折旧时,要计在贷方,只有处置资产时,对应的累计折旧才能计在借方.
         #调增（对于栏位调整成本）			
         #借	：固定资产资产科目	fabh024	调整成本fabh010
         LET l_sql = l_sql1,
                     #科目
                     " fabh024,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh010,0,fabh006,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh103,0,fabh151,fabh153,0,",
                     l_sql3,
                     " AND fabh010<>0 AND fabh018='1'"
         PREPARE afap280_01_gen_ar_8_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_8_d_cs1 CURSOR FOR afap280_01_gen_ar_8_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF             
         
         #借：以前年度损益调整科目	afai071中科目	重估的累计折旧fabh021
         SELECT glab005 INTO l_glab005 FROM glab_t
          WHERE glabent=g_enterprise AND glabld=p_ld AND glab001='90' AND glab002='8' AND glab003='9902_12'
         LET l_sql = l_sql1,
                     #科目
                     "fabh021,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " CASE WHEN fabh012-fabh011 >0 THEN fabh012-fabh011 ELSE (fabh012-fabh011) *(-1) END,0,fabh006,CASE WHEN fabh012-fabh011 >0 THEN fabh012-fabh011 ELSE (fabh012-fabh011) *(-1) END,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,CASE WHEN fabh105-fabh104 >0 THEN fabh105-fabh104 ELSE (fabh105-fabh104) *(-1) END,0,fabh151,CASE WHEN fabh155-fabh154 >0 THEN fabh155-fabh154 ELSE (fabh155-fabh154) *(-1) END,0,",
                     l_sql3,
                     " AND fabh012-fabh011<>0 AND fabh018='1'"
         PREPARE afap280_01_gen_ar_8_d_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_d_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_8_d_cs2 CURSOR FOR afap280_01_gen_ar_8_d_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF             
         
         #贷	：重估的对方科目	fabh021(单身的异动科目）	调整成本fabh010
         LET l_sql = l_sql4,
                     #科目
                    #" fabh022,",   #160419-00060#1  --- mark
                     " fabh021,",   #160419-00060#1  --- add
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh010,fabh006,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh103,fabh151,0,fabh153,",
                     l_sql3,
                     " AND fabh010<>0 AND fabh018='1'"
         PREPARE afap280_01_gen_ar_8_c_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_c_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_8_c_cs1 CURSOR FOR afap280_01_gen_ar_8_c_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_c_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF             
         
         #贷：累折科目	fabh023	重估的累计折旧fabh012
         LET l_sql = l_sql4,
                     #科目
                     "fabh023,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,CASE WHEN fabh012-fabh011 >0 THEN fabh012-fabh011 ELSE (fabh012-fabh011) *(-1) END,fabh006,CASE WHEN fabh012-fabh011 >0 THEN fabh012-fabh011 ELSE (fabh012-fabh011) *(-1) END,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,CASE WHEN fabh105-fabh104 >0 THEN fabh105-fabh104 ELSE (fabh105-fabh104) *(-1) END,fabh151,0,CASE WHEN fabh155-fabh154 >0 THEN fabh155-fabh154 ELSE (fabh155-fabh154) *(-1) END,",
                     l_sql3,
                     " AND fabh012-fabh011<>0 AND fabh018='1'"		
         PREPARE afap280_01_gen_ar_8_c_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_c_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_8_c_cs2 CURSOR FOR afap280_01_gen_ar_8_c_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_c_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF                      
         
         #调减（对于栏位调整成本）			
         #借：重估的对方科目	fabh021(单身的异动科目）	调整成本fabh010
         LET l_sql = l_sql1,
                     #科目
                    #" fabh022,",   #160419-00060#1   --- mark
                     " fabh021,",   #160419-00060#1   --- add
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh010,0,fabh006,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh103,0,fabh151,fabh153,0,",
                     l_sql3,
                     " AND fabh010<>0 AND fabh018='2'"
         PREPARE afap280_01_gen_ar_8_d_p3 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_d_p3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_8_d_cs3 CURSOR FOR afap280_01_gen_ar_8_d_p3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_d_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借	：累折科目 fabh023	 重估的累计折旧fabh012
         LET l_sql = l_sql1,
                     #科目
                     "fabh023,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh012-fabh011,0,fabh006,fabh012-fabh011,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh105-fabh104,0,fabh151,fabh155-fabh154,0,",
                     l_sql3,
                     " AND fabh012-fabh011<>0 AND fabh018='2'"	
         PREPARE afap280_01_gen_ar_8_d_p4 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_d_p4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_8_d_cs4 CURSOR FOR afap280_01_gen_ar_8_d_p4
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_d_cs4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
        
         #贷：固定资产资产科目	fabh024	
         LET l_sql = l_sql4,
                     #科目
                     " fabh024,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh010,fabh006,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh103,fabh151,0,fabh153,",
                     l_sql3,
                     " AND fabh010<>0 AND fabh018='2'"
         PREPARE afap280_01_gen_ar_8_c_p3 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_c_p3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_8_c_cs3 CURSOR FOR afap280_01_gen_ar_8_c_p3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_c_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF 
         
         #贷	：以前年度损益调整科目	afai071中科目	
         LET l_sql = l_sql4,
                     #科目
                     "fabh021,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh012-fabh011,fabh006,fabh012-fabh011,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh105-fabh104,fabh151,0,fabh155-fabh154,",
                     l_sql3,
                     " AND fabh012-fabh011<>0 AND fabh018='2'"	
         PREPARE afap280_01_gen_ar_8_c_p4 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_c_p4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_8_c_cs4 CURSOR FOR afap280_01_gen_ar_8_c_p4
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_8_c_cs4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF 
         
      #减值准备               
      WHEN p_type='14' 	
         #调增时
         #借	：減值準備對方科目	fabh021(单身的异动科目）	减值准备金额fabh019
         LET l_sql = l_sql1,
                     #科目
                     "fabh021,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh019,0,fabh007,fabh019,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh110,0,fabh151,fabh160,0,",
                     l_sql3,
                     " AND fabh019<>0 AND fabh018='1'"	
         PREPARE afap280_01_gen_ar_14_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_14_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_14_d_cs1 CURSOR FOR afap280_01_gen_ar_14_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_14_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF 
         
         #贷：减值准备科目	fabh025	减值准备金额 fabh019
         LET l_sql = l_sql4,
                     #科目
                     "fabh025,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh019,fabh007,fabh019,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh110,fabh151,0,fabh160,",
                     l_sql3,
                     " AND fabh019<>0 AND fabh018='1'"	
         PREPARE afap280_01_gen_ar_14_c_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_14_c_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_14_c_cs1 CURSOR FOR afap280_01_gen_ar_14_c_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_14_c_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
                     
         #调减时
         #借	：减值准备科目	fabh025
         LET l_sql = l_sql1,
                     #科目
                     "fabh025,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh019,0,fabh007,fabh019,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh110,0,fabh151,fabh160,0,",
                     l_sql3,
                     " AND fabh019<>0 AND fabh018='2'"	
         PREPARE afap280_01_gen_ar_14_d_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_14_d_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_14_d_cs2 CURSOR FOR afap280_01_gen_ar_14_d_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_14_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
                     
         #贷	：減值準備對方科目	fabh021(单身的异动科目）
         LET l_sql = l_sql4,
                     #科目
                     "fabh021,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh019,fabh007,fabh019,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh110,fabh151,0,fabh160,",
                     l_sql3,
                     " AND fabh019<>0 AND fabh018='2'"	
         PREPARE afap280_01_gen_ar_14_c_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_14_c_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_14_c_cs2 CURSOR FOR afap280_01_gen_ar_14_c_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_14_c_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
      #出售
      WHEN p_type='4'			
         #借：固定资产清理(帐面价值）fabo024	 金額fabo018-fabo019-fabo020
         LET l_sql = l_sql1,
                     #科目
                     "fabo024,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "fabg015,fabg016,fabo005,'',fabo018-fabo019-fabo020,'','',fabg002,'','','',", #20141112 fao019-->fabo019
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabo018-fabo019-fabo020,0,fabo007,fabo018-fabo019-fabo020,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabo102,fabo107-fabo108-fabo109,0,fabo151,fabo156-fabo157-fabo158,0,",
                     l_sql3,
                     " AND (fabo018-fabo019-fabo020)<>0 "	
         PREPARE afap280_01_gen_ar_4_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_4_d_cs1 CURSOR FOR afap280_01_gen_ar_4_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借：累折科目	fabo026	fabo019
         LET l_sql = l_sql1,
                     #科目
                     "fabo026,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "fabg015,fabg016,fabo005,'',fabo019,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabo019,0,fabo007,fabo019,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabo102,fabo108,0,fabo151,fabo157,0,",
                     l_sql3,
                     " AND fabo019<>0 "	
         PREPARE afap280_01_gen_ar_4_d_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_d_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_4_d_cs2 CURSOR FOR afap280_01_gen_ar_4_d_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借：减值准备科目	fabo027	fabo020
         LET l_sql = l_sql1,
                     #科目
                     "fabo027,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "fabg015,fabg016,fabo005,'',fabo020,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabo020,0,fabo007,fabo020,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabo102,fabo109,0,fabo151,fabo158,0,",
                     l_sql3,
                     " AND fabo020<>0 "	
         PREPARE afap280_01_gen_ar_4_d_p3 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_d_p3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_4_d_cs3 CURSOR FOR afap280_01_gen_ar_4_d_p3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_d_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #贷：资产科目（帐面原值）	fabo028	fabo018
         LET l_sql = l_sql4,
                     #科目
                     "fabo028,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "fabg015,fabg016,fabo005,'',fabo018,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabo018,fabo007,fabo018,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabo102,0,fabo107,fabo151,0,fabo156,",
                     l_sql3,
                     " AND fabo018<>0 "
         PREPARE afap280_01_gen_ar_4_c_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_c_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_4_c_cs1 CURSOR FOR afap280_01_gen_ar_4_c_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_c_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借：出售应收科目fabo029  出售应收金额	

         LET l_sql = l_sql1,
                     #科目
                     "fabo029,", 
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "fabg015,fabg016,fabo005,'',fabo017,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabo017,0,fabo007,fabo017,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabo102,fabo105,0,fabo151,fabo154,0,",
                     l_sql3,
                     " AND fabo017<>0 "	
         PREPARE afap280_01_gen_ar_4_d_p4 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_d_p4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_4_d_cs4 CURSOR FOR afap280_01_gen_ar_4_d_p4
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_d_cs4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #貸：出售收益科目		
         #afai071中出售收益科目		
         SELECT glab005 INTO l_glab005 FROM glab_t
          WHERE glabent=g_enterprise AND glabld=p_ld AND glab001='90' AND glab002='41' AND glab003='9902_06'
         LET l_sql = l_sql1,
                     #科目
                     "'",l_glab005,"',",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "fabg015,fabg016,fabo005,'',fabo049,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabo049,fabo007,fabo049,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabo102,0,fabo106,fabo151,0,fabo155,",
                     l_sql3,
                     " AND fabo049>0 "
         PREPARE afap280_01_gen_ar_4_c_p4 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_c_d_p4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_4_c_cs4 CURSOR FOR afap280_01_gen_ar_4_c_p4
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_c_cs4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借：出售损失科目
         #afai071中出售损失科目	
         SELECT glab005 INTO l_glab005 FROM glab_t
          WHERE glabent=g_enterprise AND glabld=p_ld AND glab001='90' AND glab002='42' AND glab003='9902_07'
         LET l_sql = l_sql1,
                     #科目
                     "'",l_glab005,"',",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "fabg015,fabg016,fabo005,'',fabo049*(-1),'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabo049*(-1),0,fabo007,fabo049*(-1),",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabo102,fabo106*(-1),0,fabo151,fabo155*(-1),0,",
                     l_sql3,
                     " AND fabo049<0 "
         PREPARE afap280_01_gen_ar_4_d_p5 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_d_p5'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_4_d_cs5 CURSOR FOR afap280_01_gen_ar_4_d_p5
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_d_cs5'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借	：減值準備科目	
         LET l_sql = l_sql4,
                     #科目
                     "fabo027,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "fabg015,fabg016,fabo005,'',fabo020,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabo020,0,fabo007,fabo020,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabo102,fabo109,0,fabo151,fabo158,0,",
                     l_sql3,
                     " AND fabo020<>0 "	  
         PREPARE afap280_01_gen_ar_4_d_p6 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_d_p6'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_4_d_cs6 CURSOR FOR afap280_01_gen_ar_4_d_p6
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_c_cs6'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借：累折科目	
         LET l_sql = l_sql4,
                     #科目
                     "fabo026,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "fabg015,fabg016,fabo005,'',fabo019,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabo019,0,fabo007,fabo019,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabo102,fabo108,0,fabo151,fabo157,0,",
                     l_sql3,
                     " AND fabo019<>0 "	  
         PREPARE afap280_01_gen_ar_4_d_p7 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_d_p7'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_4_d_cs7 CURSOR FOR afap280_01_gen_ar_4_d_p7
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_d_cs7'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
        
         #贷 销项税额:出售
         LET l_sql = l_sql4,
                     #科目
                     "fabo030,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "fabg015,fabg016,fabo005,'',xrcd114,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额/本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       0,xrcd114,0, xrcd104,xrcd121,0,xrcd124,xrcd131,0,xrcd134,",
                     #交易稅項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       xrcdseq,'xrcd','','',''  ",
                     "  FROM fabg_t,fabo_t,xrcd_t",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = faboent ",
                     "   AND fabgld    = fabold  ",
                     "   AND fabgdocno = fabodocno ",
                     "   AND xrcdent   = faboent ",
                     "   AND xrcdld    = fabold ",
                     "   AND xrcddocno = fabodocno ",
                     "   AND xrcdseq   = faboseq "
         PREPARE afap280_01_gen_ar_4_c_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_c_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_4_c_cs2 CURSOR FOR afap280_01_gen_ar_4_c_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_c_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #贷	：固定资产清理	
         LET l_sql = l_sql4,
                     #科目
                     "fabo028,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "fabg015,fabg016,fabo005,'',fabo018,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabo018,fabo007,fabo018,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabo102,0,fabo107,fabo151,0,fabo156,",
                     l_sql3,
                     " AND fabo018<>0 "	  
         PREPARE afap280_01_gen_ar_4_c_p3 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_c_p3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_4_c_cs3 CURSOR FOR afap280_01_gen_ar_4_c_p3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_4_c_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF                     

      #160426-00014#45--add--str--lujh
      #拨出账务
      WHEN p_type='43'			
         #借：固定资产清理(帐面价值）faca019	 金額faca009-fabv012-fabv013
                             #单号/日期/借/企业/法人/帐套/摘要 
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       faca019,",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,faca009-fabv012-fabv013,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       faca009-fabv012-fabv013,0,faca008,faca009-fabv012-fabv013,",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,faca043-fabv018-fabv019,0,faca046,faca050-fabv025-fabv026,0,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ",                     
                     "   AND (faca009-fabv012-fabv013)<>0 "	
         PREPARE afap280_01_gen_ar_43_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_43_d_cs1 CURSOR FOR afap280_01_gen_ar_43_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借：累折科目	faca020	fabv012
                             #单号/日期/借/企业/法人/帐套/摘要 
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       faca020,",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,fabv012,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       fabv012,0,faca008,fabv012,",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,fabv018,0,faca046,fabv025,0,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ",     
                     "   AND fabv012 <> 0 "	
         PREPARE afap280_01_gen_ar_43_d_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_d_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_43_d_cs2 CURSOR FOR afap280_01_gen_ar_43_d_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借：减值准备科目	faca021	fabv013
                             #单号/日期/借/企业/法人/帐套/摘要 
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       faca021,",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,fabv013,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       fabv013,0,faca008,fabv013,",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,fabv019,0,faca046,fabv026,0,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ",     
                     "   AND fabv013 <> 0 "	
         PREPARE afap280_01_gen_ar_43_d_p3 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_d_p3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_43_d_cs3 CURSOR FOR afap280_01_gen_ar_43_d_p3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_d_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #贷：资产科目（帐面原值）	faca022	faca009
                             #单号/日期/贷/企业/法人/帐套/摘要 
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       faca022,",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,faca009,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       0,faca009,faca008,faca009,",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,0,faca043,faca046,0,faca050,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ",  
                     "   AND faca009 <> 0 "
         PREPARE afap280_01_gen_ar_43_c_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_c_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_43_c_cs1 CURSOR FOR afap280_01_gen_ar_43_c_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_c_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借：应收科目faca023  应收金额	 

                             #单号/日期/借/企业/法人/帐套/摘要 
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       faca023,", 
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,faca013,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       faca016,0,faca008,faca013,",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,faca042,0,faca046,faca049,0,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ", 
                     "   AND faca016 <> 0 "	
         PREPARE afap280_01_gen_ar_43_d_p4 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_d_p4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_43_d_cs4 CURSOR FOR afap280_01_gen_ar_43_d_p4
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_d_cs4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #貸：收益科目		
         #afai071中出售收益科目		
         SELECT glab005 INTO l_glab005 FROM glab_t
          WHERE glabent=g_enterprise AND glabld=p_ld AND glab001='90' AND glab002='41' AND glab003='9902_06'
                             #单号/日期/贷/企业/法人/帐套/摘要 
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       '",l_glab005,"',",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,faca018,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       0,faca018,faca008,faca018,",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,0,faca044,faca046,0,faca051,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ", 
                     "   AND faca018 > 0 "
         PREPARE afap280_01_gen_ar_43_c_p4 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_c_p4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_43_c_cs4 CURSOR FOR afap280_01_gen_ar_43_c_p4
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_c_cs4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借：出售损失科目
         #afai071中出售损失科目	
         SELECT glab005 INTO l_glab005 FROM glab_t
          WHERE glabent=g_enterprise AND glabld=p_ld AND glab001='90' AND glab002='42' AND glab003='9902_07'
                             #单号/日期/借/企业/法人/帐套/摘要 
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       '",l_glab005,"',",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,faca018*(-1),'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       faca018*(-1),0,faca008,faca018*(-1),",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,faca044*(-1),0,faca046,faca051*(-1),0,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ", 
                     "   AND faca018 < 0 "
         PREPARE afap280_01_gen_ar_43_d_p5 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_d_p5'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_43_d_cs5 CURSOR FOR afap280_01_gen_ar_43_d_p5
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_d_cs5'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借：減值準備科目	
                             #单号/日期/贷/企业/法人/帐套/摘要 
         #LET l_sql = "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,faca036,",
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       faca021,",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,fabv013,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       fabv013,0,faca008,fabv013,",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,fabv019,0,faca046,fabv026,0,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ", 
                     "   AND fabv013 <> 0 "	  
         PREPARE afap280_01_gen_ar_43_d_p6 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_d_p6'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_43_d_cs6 CURSOR FOR afap280_01_gen_ar_43_d_p6
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_c_cs6'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借：累折科目	
                             #单号/日期/贷/企业/法人/帐套/摘要 
         #LET l_sql = "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,faca036,",
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       faca020,",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,fabv012,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       fabv012,0,faca008,fabv012,",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,fabv018,0,faca046,fabv025,0,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ",     
                     "   AND fabv012 <> 0 "	  
         PREPARE afap280_01_gen_ar_43_d_p7 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_d_p7'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_43_d_cs7 CURSOR FOR afap280_01_gen_ar_43_d_p7
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_d_cs7'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
        
         #贷 销项税额:出售
                             #单号/日期/贷/企业/法人/帐套/摘要 
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       xrcd009,",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,xrcd104,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                     #       借/贷/计价数量/原币金额/本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       0,xrcd114,0, xrcd104,xrcd121,0,xrcd124,xrcd131,0,xrcd134,",
                     #       交易稅項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       xrcdseq,'xrcd','','',''  ",
                     "  FROM fabg_t,faca_t,xrcd_t",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND xrcdent   = facaent ",
                     "   AND xrcdld    = facald ",
                     "   AND xrcddocno = facadocno ",
                     "   AND xrcdseq   = facaseq "
         PREPARE afap280_01_gen_ar_43_c_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_c_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_43_c_cs2 CURSOR FOR afap280_01_gen_ar_43_c_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_c_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #贷	：固定资产清理	
                             #单号/日期/贷/企业/法人/帐套/摘要 
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       faca022,",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,faca009,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       0,faca009,faca008,faca009,",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,0,faca043,faca046,0,faca050,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ",  
                     "   AND faca009 <> 0 "
         PREPARE afap280_01_gen_ar_43_c_p3 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_c_p3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_43_c_cs3 CURSOR FOR afap280_01_gen_ar_43_c_p3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_43_c_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF      
      #160426-00014#45--add--end--lujh
      
      
      #160426-00014#44--add--str--lujh
      #拨入账务
      WHEN p_type='44'			
         #借：资产科目（帐面原值）	faca022	faca009
                             #单号/日期/贷/企业/法人/帐套/摘要 
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'1',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       faca022,",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,faca009,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       0,faca009,faca008,faca009,",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,0,faca043,faca046,0,faca050,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ",  
                     "   AND faca009 <> 0 "
         PREPARE afap280_01_gen_ar_44_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_44_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_44_d_cs1 CURSOR FOR afap280_01_gen_ar_44_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_44_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
      
         #贷：累折科目	faca020	fabv012
                             #单号/日期/借/企业/法人/帐套/摘要 
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       faca020,",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,fabv012,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       fabv012,0,faca008,fabv012,",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,fabv018,0,faca046,fabv025,0,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ",     
                     "   AND fabv012 <> 0 "	
         PREPARE afap280_01_gen_ar_44_c_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_44_c_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_44_c_cs1 CURSOR FOR afap280_01_gen_ar_44_c_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_44_c_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #贷：减值准备科目	faca021	fabv013
                             #单号/日期/借/企业/法人/帐套/摘要 
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       faca021,",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,fabv013,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       fabv013,0,faca008,fabv013,",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,fabv019,0,faca046,fabv026,0,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ",     
                     "   AND fabv013 <> 0 "	
         PREPARE afap280_01_gen_ar_44_c_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_44_c_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_44_c_cs2 CURSOR FOR afap280_01_gen_ar_44_c_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_44_c_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
      
         #贷：固定资产清理(帐面价值）faca019	 金額faca009-fabv012-fabv013
                             #单号/日期/借/企业/法人/帐套/摘要 
         LET l_sql = "SELECT fabgdocno,fabgdocdt,'2',fabgent,fabgcomp,fabgld,faca036,",
                             #科目
                     "       faca019,",
                             #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     "       fabg015,fabg016,faca006,faca007,faca009-fabv012-fabv013,'','',fabg001,'','','',", 
                             #营运据点/部门/利润中心/区域/交易客户/帐款客户/客群/产品类别/人员
                     "       faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca065,faca032,",
                             #专案编号/WB/經營方式/渠道/品牌/自由核算项1~10
                     "       faca033,faca034,faca052,faca053,faca054,faca055,faca056,faca057,faca058,",
                     "       faca059,faca060,faca060,faca062,faca063,faca064,",
                             #借/贷/计价数量/原币金额
                     "       faca009-fabv012-fabv013,0,faca008,faca009-fabv012-fabv013,",
                             #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     "       faca039,faca043-fabv018-fabv019,0,faca046,faca050-fabv025-fabv026,0,",
                             #單身項次/單身表名/傳票項次/會計檢核附件數/正負值方向
                     "       facaseq,'faca','','',1 ",
                     "  FROM fabg_t,faca_t,fabv_t ",
                     " WHERE fabgent   = ",g_enterprise,
                     "   AND fabgld    = '",p_ld CLIPPED,"'",
                     "   AND fabgdocno = ? ",
                     "   AND fabgent   = facaent ",
                     "   AND fabgld    = facald  ",
                     "   AND fabgdocno = facadocno ",
                     "   AND faca001   = fabvdocno ",
                     "   AND faca002   = fabvseq ",                     
                     "   AND (faca009-fabv012-fabv013)<>0 "	
         PREPARE afap280_01_gen_ar_44_c_p3 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_44_c_p3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_44_c_cs3 CURSOR FOR afap280_01_gen_ar_44_c_p3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_44_c_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
      #160426-00014#44--add--end--lujh

      #改良              
      WHEN p_type='9' 	
         #调增时
         #借	：固定資產資產科目	fabh024	調整成本fabh010
         LET l_sql = l_sql1,
                     #科目
                     "fabh024,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh010,0,fabh007,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh103,0,fabh151,fabh153,0,",
                     l_sql3,
                     " AND fabh010<>0 AND fabh018='1'"	
         PREPARE afap280_01_gen_ar_9_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_9_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_9_d_cs1 CURSOR FOR afap280_01_gen_ar_9_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_9_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF 
         
         #贷：改良對方科目	fabh021	調整成本 fabh010
         LET l_sql = l_sql4,
                     #科目
                     "fabh021,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh010,fabh007,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh103,fabh151,0,fabh153,",
                     l_sql3,
                     " AND fabh010<>0 AND fabh018='1'"	
         PREPARE afap280_01_gen_ar_9_c_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_9_c_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_9_c_cs1 CURSOR FOR afap280_01_gen_ar_9_c_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_9_c_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
                     
         #调减时
         #借	：改良對方科目	fabh021	調整成本 fabh010
         LET l_sql = l_sql1,
                     #科目
                     "fabh021,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh010,0,fabh007,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh103,0,fabh151,fabh153,0,",
                     l_sql3,
                     " AND fabh010<>0 AND fabh018='2'"	
         PREPARE afap280_01_gen_ar_9_d_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_9_d_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_9_d_cs2 CURSOR FOR afap280_01_gen_ar_9_d_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_9_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
                     
         #贷	：固定資產資產科目	fabh024	調整成本fabh010
         LET l_sql = l_sql4,
                     #科目
                     "fabh024,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh010,fabh007,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh103,fabh151,0,fabh153,",
                     l_sql3,
                     " AND fabh010<>0 AND fabh018='2'"	
         PREPARE afap280_01_gen_ar_9_c_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_9_c_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_9_c_cs2 CURSOR FOR afap280_01_gen_ar_9_c_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_9_c_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
      #折旧
      WHEN p_type='0'
         #借：固定资产清理fabh021 金额：折旧金额(fabh010)
         LET l_sql = l_sql1,
                     #科目
                     " fabh021,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh010,0,fabh007,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh010,0,fabh151,fabh010,0,",
                     l_sql3,
                     " AND fabh010 <> 0 "
         PREPARE afap280_01_gen_ar_0_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_0_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_0_d_cs1 CURSOR FOR afap280_01_gen_ar_0_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_0_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         #贷：固定资产清理fabh023 金额：折旧金额(fabh010)
         LET l_sql = l_sql1,
                     #科目
                     " fabh023,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh010,fabh007,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh010,fabh151,0,fabh010,",
                     l_sql3,
                     " AND fabh010 <> 0 "
         PREPARE afap280_01_gen_ar_0_d_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_0_d_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_0_d_cs2 CURSOR FOR afap280_01_gen_ar_0_d_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_0_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
      #140122-00001#129--add--str--lujh
      #投保保费
      WHEN p_type='35'
         #借：保险费用fabh074 金额：本期保险金额(fabh010)
         LET l_sql = l_sql1,
                     #科目
                     " fabh074,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh010,0,fabh007,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh010,0,fabh151,fabh010,0,",
                     l_sql3,
                     " AND fabh010 <> 0 "
         PREPARE afap280_01_gen_ar_35_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_35_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_35_d_cs1 CURSOR FOR afap280_01_gen_ar_35_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_35_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         #贷：异动科目(预付保险费科目)fabh021 金额：本期保险金额(fabh010)
         LET l_sql = l_sql1,
                     #科目
                     " fabh021,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh010,fabh007,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh010,fabh151,0,fabh010,",
                     l_sql3,
                     " AND fabh010 <> 0 "
         PREPARE afap280_01_gen_ar_35_d_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_35_d_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_35_d_cs2 CURSOR FOR afap280_01_gen_ar_35_d_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_35_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF   
      #140122-00001#129--add--end--lujh   
         
      #资本化
      WHEN p_type='22'  OR p_type = '26' 
         #借：原币金额fabs011
         LET l_sql = l_sql1,
                     #科目
                     " fabs007,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabs011,0,1,fabs011,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabs101,fabs011,0,fabs151,fabs011,0,",
                     l_sql3
         PREPARE afap280_01_gen_ar_22_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_22_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_22_d_cs1 CURSOR FOR afap280_01_gen_ar_22_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_22_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         #贷：fabs011
         LET l_sql = l_sql1,
                     #科目
                     " fabs008,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabs011,1,fabs011,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabs101,0,fabs011,fabs151,0,fabs011,",
                     l_sql3
         PREPARE afap280_01_gen_ar_22_d_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_22_d_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_22_d_cs2 CURSOR FOR afap280_01_gen_ar_22_d_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_22_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
#add by yangxf ---
      #类型异动
      WHEN p_type='30'
         #借：固定资产清理fabp023 金额：折旧金额(fabp007)
         LET l_sql = l_sql1,
                     #科目
                     " fabp023,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabp006,0,0,fabp006,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabp101,fabp102,0,fabp111,fabp112,0,",
                     l_sql3,
                     " AND fabp013 <> fabp023 "
         PREPARE afap280_01_gen_ar_30_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_30_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_30_d_cs1 CURSOR FOR afap280_01_gen_ar_30_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_30_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         #贷：固定资产清理fabp013 金额：折旧金额(fabp006)
         LET l_sql = l_sql1,
                     #科目
                     " fabp013,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabp006,0,fabp006,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabp101,0,fabp102,fabp111,0,fabp112,",
                     l_sql3,
                     " AND fabp013 <> fabp023 "
         PREPARE afap280_01_gen_ar_30_d_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_30_d_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_30_d_cs2 CURSOR FOR afap280_01_gen_ar_30_d_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_30_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         #借：固定资产清理fabp024 金额：折旧金额(fabp007)
         LET l_sql = l_sql1,
                     #科目
                     " fabp024,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabp007,0,0,fabp007,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabp101,fabp102,0,fabp111,fabp112,0,",
                     l_sql3,
                     " AND fabp014 <> fabp024 "
         PREPARE afap280_01_gen_ar_30_d_p3 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_30_d_p3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_30_d_cs3 CURSOR FOR afap280_01_gen_ar_30_d_p3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_30_d_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         #贷：固定资产清理fabp014 金额：折旧金额(fabp007)
         LET l_sql = l_sql1,
                     #科目
                     " fabp014,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabp007,0,fabp007,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabp101,0,fabp102,fabp111,0,fabp112,",
                     l_sql3,
                     " AND fabp014 <> fabp024 "
         PREPARE afap280_01_gen_ar_30_d_p4 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_30_d_p4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_30_d_cs4 CURSOR FOR afap280_01_gen_ar_30_d_p4
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_30_d_cs4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
#add by yangxf ---

      #150417-00007#65--add--str--
      WHEN p_type='31'
         #借	：新資產科目	fabh024	成本fabh008
         LET l_sql = l_sql1,
                     #科目
                     "fabh024,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     " fabg015,fabg016,fabh005,'',fabh008,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh008,0,fabh007,fabh008,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh102,0,fabh151,fabh152,0,",
                     l_sql3,
                     " AND fabh008<>0 "	
         PREPARE afap280_01_gen_ar_31_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_31_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_31_d_cs1 CURSOR FOR afap280_01_gen_ar_31_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_31_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF 
         
         #借	：旧累计折旧科目	fabh070	累折fabh011
         LET l_sql = l_sql1,
                     #科目
                     "fabh070,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     " fabg015,fabg016,fabh005,'',fabh011,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh011,0,fabh007,fabh011,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh104,0,fabh151,fabh154,0,",
                     l_sql3,
                     " AND fabh011<>0 "	
         PREPARE afap280_01_gen_ar_31_d_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_31_d_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_31_d_cs2 CURSOR FOR afap280_01_gen_ar_31_d_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_31_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #借	：新减值准备科目	fabh025	已计提减值准备fabh017
         LET l_sql = l_sql1,
                     #科目
                     "fabh025,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     " fabg015,fabg016,fabh005,'',fabh017,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh017,0,fabh007,fabh017,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh109,0,fabh151,fabh159,0,",
                     l_sql3,
                     " AND fabh017<>0 "	
         PREPARE afap280_01_gen_ar_31_d_p3 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_31_d_p3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_31_d_cs3 CURSOR FOR afap280_01_gen_ar_31_d_p3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_31_d_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #贷：旧资产科目	fabh071	成本 fabh008
         LET l_sql = l_sql4,
                     #科目
                     "fabh071,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     " fabg015,fabg016,fabh005,'',fabh008,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh008,fabh007,fabh008,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh102,fabh151,0,fabh152,",
                     l_sql3,
                     " AND fabh008<>0 "	
         PREPARE afap280_01_gen_ar_31_c_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_31_c_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_31_c_cs1 CURSOR FOR afap280_01_gen_ar_31_c_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_31_c_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
                     
         #贷	：新累计折旧科目	fabh023	累折fabh011
         LET l_sql = l_sql4,
                     #科目
                     "fabh023,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     " fabg015,fabg016,fabh005,'',fabh011,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh011,fabh007,fabh011,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh104,fabh151,0,fabh154,",
                     l_sql3,
                     " AND fabh011<>0 "	
         PREPARE afap280_01_gen_ar_31_c_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_31_c_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_31_c_cs2 CURSOR FOR afap280_01_gen_ar_31_c_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_31_c_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         
         #贷：旧减值准备科目	fabh072	已计提减值准备 fabh017
         LET l_sql = l_sql4,
                     #科目
                     "fabh072,",
                     #币别/汇率/计价单位/单价/原幣金額/票据编号/票据日期/申请人/银行帐号/结算方式/收支项目
                     " fabg015,fabg016,fabh005,'',fabh017,'','',fabg002,'','','',",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh017,fabh007,fabh017,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh109,fabh151,0,fabh159,",
                     l_sql3,
                     " AND fabh017<>0 "	
         PREPARE afap280_01_gen_ar_31_c_p3 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_31_c_p3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_31_c_cs3 CURSOR FOR afap280_01_gen_ar_31_c_p3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_31_c_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
      #150417-00007#65--add--end   
      
      #160329-00025#3 add--str--
      #盘盈  
      WHEN p_type='23'
      
  
         #盘盈（帐面上有）			
         #借	：固定资产资产科目	fabh024	调整成本fabh010
         LET l_sql = l_sql1,
                     #科目
                     " fabh024,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh010,0,fabh006,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh103,0,fabh151,fabh153,0,",
                     l_sql3,
                     " AND fabh010<>0 "
         PREPARE afap280_01_gen_ar_23_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_23_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_23_d_cs1 CURSOR FOR afap280_01_gen_ar_23_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_23_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF             
                   
         
         #贷	：盘盈对方科目	fabh021(单身的异动科目）	调整成本fabh010-重估累折fabh012
         LET l_sql = l_sql4,
                     #科目
                     " fabh021,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh010-fabh012,fabh006,fabh010,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh103-fabh105,fabh151,0,fabh153-fabh155,",
                     l_sql3,
                     " AND fabh010-fabh012<>0 "
         PREPARE afap280_01_gen_ar_23_c_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_23_c_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_23_c_cs1 CURSOR FOR afap280_01_gen_ar_23_c_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_23_c_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF             
         
         #贷：累折科目	fabh023	重估的累计折旧fabh012
         LET l_sql = l_sql4,
                     #科目
                     "fabh023,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh012,fabh006,fabh012,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh105,fabh151,0,fabh155,",
                     l_sql3,
                     " AND fabh012<>0 "		
         PREPARE afap280_01_gen_ar_23_c_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_23_c_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_23_c_cs2 CURSOR FOR afap280_01_gen_ar_23_c_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_23_c_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF                      
         
         #盘盈（帐面上无）		
         #借	：固定资产资产科目	fabh024	成本fabh008
         LET l_sql = l_sql1,
                     #科目
                     " fabh024,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " fabh008,0,fabh006,fabh008,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,fabh102,0,fabh151,fabh152,0,",
                     l_sql3,
                     " AND fabh008<>0 "
         PREPARE afap280_01_gen_ar_23_d_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_23_d_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_23_d_cs2 CURSOR FOR afap280_01_gen_ar_23_d_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_23_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
    
         #贷：累折科目	fabh023  累折fabh011	
         LET l_sql = l_sql4,
                     #科目
                     " fabh023,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh011,fabh006,fabh011,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh104,fabh151,0,fabh154,",
                     l_sql3,
                     " AND fabh011<>0 "
         PREPARE afap280_01_gen_ar_23_c_p3 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_23_c_p3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_23_c_cs3 CURSOR FOR afap280_01_gen_ar_23_c_p3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_23_c_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF 
         
         #贷	：盘盈对方科目	fabh021(单身的异动科目）	成本fabh008-累折fabh011
         LET l_sql = l_sql4,
                     #科目
                     "fabh021,",
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh008-fabh011,fabh006,fabh008-fabh011,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh102-fabh104,fabh151,0,fabh152-fabh154,",
                     l_sql3,
                     " AND fabh008-fabh011<>0 "	
         PREPARE afap280_01_gen_ar_23_c_p4 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_23_c_p4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_23_c_cs4 CURSOR FOR afap280_01_gen_ar_23_c_p4
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_23_c_cs4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF  
      
      #盘亏
      WHEN p_type='24'
         #借：固定资产清理fabh021 金额：本币成本-累计折旧-已提列减值准备(fabh008-fabh011-fabh017)
#         IF l_ooab002='Y' THEN #170221-00042#1 mark
            LET l_sql = l_sql1,
                        #科目
                        " fabh021,",
                        l_sql2,
                        #借/贷/计价数量/原币金额
                        " fabh008-fabh011-fabh017,0,fabh007,fabh008-fabh011-fabh017,",
                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                        " fabh101,fabh102-fabh104-fabh109,0,fabh151,fabh152-fabh154-fabh159,0,",
                        l_sql3,
                        " AND (fabh008-fabh011-fabh017)<>0 "
#170221-00042#1--mark--str--
#          ELSE
#             LET l_sql = l_sql4,
#                        #科目
#                        " fabh021,",
#                        l_sql2,
#                        #借/贷/计价数量/原币金额
#                        " 0,fabh008-fabh011-fabh017,fabh007,fabh008-fabh011-fabh017,",
#                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
#                        " fabh101,0,fabh102-fabh104-fabh109,fabh151,0,fabh152-fabh154-fabh159,",
#                        l_sql3,
#                        " AND (fabh008-fabh011-fabh017)<>0 "
#          END IF
#170221-00042#1--mark--end
         PREPARE afap280_01_gen_ar_24_d_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_24_d_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_24_d_cs1 CURSOR FOR afap280_01_gen_ar_24_d_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_24_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF   

         #借：累计折旧fabh023 金额：累计折旧fabh011
#         IF l_ooab002='Y' THEN #170221-00042#1 mark
            LET l_sql = l_sql1,
                        #科目
                        " fabh023,",
                        l_sql2,
                        #借/贷/计价数量/原币金额
                        " fabh011,0,fabh007,fabh011,",
                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                        " fabh101,fabh104,0,fabh151,fabh154,0,",
                        l_sql3,
                        " AND fabh011<>0 "
#170221-00042#1--mark--str--
#         ELSE
#            LET l_sql = l_sql4,
#                        #科目
#                        " fabh023,",
#                        l_sql2,
#                        #借/贷/计价数量/原币金额
#                        " 0,fabh011,fabh007,fabh011,",
#                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
#                        " fabh101,0,fabh104,fabh151,0,fabh154,",
#                        l_sql3,
#                        " AND fabh011<>0 "
#         END IF
#170221-00042#1--mark--end
         PREPARE afap280_01_gen_ar_24_d_p2 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_24_d_p2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_24_d_cs2 CURSOR FOR afap280_01_gen_ar_24_d_p2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_24_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF    
         
         #借：减值准备科目fabh025 金额：已提列减准备fabh017>0
#         IF l_ooab002='Y' THEN #170221-00042#1 mark
            LET l_sql = l_sql1,
                        #科目
                        " fabh025,",
                        l_sql2,
                        #借/贷/计价数量/原币金额
                        " fabh017,0,fabh007,fabh017,",
                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                        " fabh101,fabh109,0,fabh151,fabh159,0,",
                        l_sql3,
                        " AND fabh017<>0 "
#170221-00042#1--mark--str--
#         ELSE
#            LET l_sql = l_sql4,
#                        #科目
#                        " fabh025,",
#                        l_sql2,
#                        #借/贷/计价数量/原币金额
#                        " 0,fabh017,fabh007,fabh017,",
#                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
#                        " fabh101,0,fabh109,fabh151,0,fabh159,",
#                        l_sql3,
#                        " AND fabh017<>0 "
#         END IF
#170221-00042#1--mark--end
         PREPARE afap280_01_gen_ar_24_d_p3 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_24_d_p3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_24_d_cs3 CURSOR FOR afap280_01_gen_ar_24_d_p3
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_24_d_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF             
                     
         #贷：固定资产资产科目fabh024 金额：本币成本fabh008
         IF l_ooab002='Y' THEN
         #170221-00042#1--mod--str--
            #贷方，当aoos020勾选的‘资产转入清理科目’'S-FIN-9017'=Y 贷：清理科目， 'S-FIN-9017'=N 贷：固定资产
            #固定資產清理科目
            SELECT glab005 INTO l_glab005 FROM glab_t
             WHERE glabent=g_enterprise AND glabld=p_ld AND glab001='90' AND glab002='25' AND glab003='9902_12'
            LET l_sql = l_sql4,
                        #科目
                        "'",l_glab005,"',"
         ELSE
            LET l_sql = l_sql4,
                        #科目
                        " fabh024,"
         END IF
         LET l_sql = l_sql,
         #170221-00042#1--mod--end
                     l_sql2,
                     #借/贷/计价数量/原币金额
                     " 0,fabh008,fabh007,fabh008,",
                     #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
                     " fabh101,0,fabh102,fabh151,0,fabh152,",
                     l_sql3,
                     " AND fabh008<>0"
#170221-00042#1--mark--str--
#         ELSE
#            LET l_sql = l_sql1,
#                        #科目
#                        " fabh024,",
#                        l_sql2,
#                        #借/贷/计价数量/原币金额
#                        " fabh008,0,fabh007,fabh008,",
#                        #本位幣二匯率/借方金額/貸方金額/本位幣三匯率/借方金額/貸方金額
#                        " fabh101,fabh102,0,fabh151,fabh152,0,",
#                        l_sql3,
#                        " AND fabh008<>0"
#         END IF
#170221-00042#1--mark--end
         PREPARE afap280_01_gen_ar_24_c_p1 FROM l_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_24_c_p1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         DECLARE afap280_01_gen_ar_24_c_cs1 CURSOR FOR afap280_01_gen_ar_24_c_p1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'afap280_01_gen_ar_24_c_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
      #160329-00025#3 add--end--       
   END CASE
   
   
   
   #从临时表中取科目
   LET l_sql = " SELECT DISTINCT docno,glaq002 FROM afap280_tmp01 ",  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01 
               "  ORDER BY docno"
   PREPARE afap280_01_gen_ar_2_p5 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_2_p5'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   DECLARE afap280_01_gen_ar_2_cs5 CURSOR FOR afap280_01_gen_ar_2_p5
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_2_cs5'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF   

   #从agli030取科目设置
   LET l_sql = " SELECT glad005,glad007,glad008,glad009,glad010,glad011,glad012,glad013,glad014,glad015,",
               "        glad016,glad017,glad018,glad019,glad020,glad021,glad022,glad023,glad024,glad025,",
               "        glad026 ",
               "   FROM glad_t ",
               "  WHERE gladent = ",g_enterprise,
               "    AND gladld  = '",p_ld CLIPPED,"'",
               "    AND glad001 = ? "
   PREPARE afap280_01_gen_ar_2_p6 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_2_p6'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   DECLARE afap280_01_gen_ar_2_cs6 CURSOR FOR afap280_01_gen_ar_2_p6
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_2_cs6'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF   
   
   #用于生成glaq_t资料的临时表
  #LET l_sql = " SELECT * FROM afap280_01_fa_group "  #151001-00005#1
  #LET l_sql = " SELECT * FROM afap280_01_group "     #151001-00005#1 
   LET l_sql = " SELECT * FROM afap280_tmp02 "    #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
   CASE p_sum_type
      WHEN '1' LET l_sql = l_sql CLIPPED," WHERE docno = ? "
      WHEN '2' LET l_sql = l_sql CLIPPED," WHERE docdt = ? "
#      WHEN '3' LET l_sql = l_sql CLIPPED," WHERE glaq021 = ? "
   END CASE
   LET l_sql = l_sql CLIPPED," ORDER BY glaq002 "
   PREPARE afap280_01_gen_ar_2_p9 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_2_p9'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   DECLARE afap280_01_gen_ar_2_cs9 CURSOR FOR afap280_01_gen_ar_2_p9
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_2_cs9'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET l_sql = "UPDATE fabg_t SET fabg008 = ?,fabg009 = ? ",
               " WHERE fabgent   = ",g_enterprise,
               "   AND fabgld    = '",p_ld,"'",
               "   AND fabgdocno = ? "
   PREPARE afap280_01_gen_ar_2_p10 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_2_p10'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #根據匯總條件抓單據單號
   LET l_sql = "SELECT docno  ",
               "  FROM afap280_tmp01 ",   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01 
               " WHERE docdt    = ? ",
               "   AND glaqent  = ? ",
               "   AND (glaqcomp  = ? OR ( ? IS NULL AND glaqcomp IS NULL) OR glaqcomp = ' ')",
               "   AND (glaq001  = ? OR ( ? IS NULL AND glaq001 IS NULL) OR glaq001 = ' ')",
               "   AND (glaq002  = ? OR ( ? IS NULL AND glaq002 IS NULL) OR glaq002 = ' ')",
               "   AND (glaq005  = ? OR ( ? IS NULL AND glaq005 IS NULL) OR glaq005 = ' ')",
               "   AND (glaq006  = ? OR ( ? IS NULL AND glaq006 IS NULL))",
               "   AND (glaq039  = ? OR ( ? IS NULL AND glaq039 IS NULL))",
               "   AND (glaq042  = ? OR ( ? IS NULL AND glaq042 IS NULL))",
               "   AND (glaq018  = ? OR ( ? IS NULL AND glaq018 IS NULL) OR glaq018 = ' ')",
               "   AND (glaq019  = ? OR ( ? IS NULL AND glaq019 IS NULL) OR glaq019 = ' ')",
               "   AND (glaq020  = ? OR ( ? IS NULL AND glaq020 IS NULL) OR glaq020 = ' ')",
               "   AND (glaq021  = ? OR ( ? IS NULL AND glaq021 IS NULL) OR glaq021 = ' ')",
               "   AND (glaq022  = ? OR ( ? IS NULL AND glaq022 IS NULL) OR glaq022 = ' ')",
               "   AND (glaq023  = ? OR ( ? IS NULL AND glaq023 IS NULL) OR glaq023 = ' ')",
               "   AND (glaq024  = ? OR ( ? IS NULL AND glaq024 IS NULL) OR glaq024 = ' ')",
               "   AND (glaq025  = ? OR ( ? IS NULL AND glaq025 IS NULL) OR glaq025 = ' ')",
              #"   AND (glaq026  = ? OR ( ? IS NULL AND glaq026 IS NULL) OR glaq026 = ' ')",
               "   AND (glaq027  = ? OR ( ? IS NULL AND glaq027 IS NULL) OR glaq027 = ' ')",
               "   AND (glaq028  = ? OR ( ? IS NULL AND glaq028 IS NULL) OR glaq028 = ' ')",
               "   AND (glaq029  = ? OR ( ? IS NULL AND glaq029 IS NULL) OR glaq029 = ' ')",
               "   AND (glaq030  = ? OR ( ? IS NULL AND glaq030 IS NULL) OR glaq030 = ' ')",
               "   AND (glaq031  = ? OR ( ? IS NULL AND glaq031 IS NULL) OR glaq031 = ' ')",
               "   AND (glaq032  = ? OR ( ? IS NULL AND glaq032 IS NULL) OR glaq032 = ' ')",
               "   AND (glaq033  = ? OR ( ? IS NULL AND glaq033 IS NULL) OR glaq033 = ' ')",
               "   AND (glaq034  = ? OR ( ? IS NULL AND glaq034 IS NULL) OR glaq034 = ' ')",
               "   AND (glaq035  = ? OR ( ? IS NULL AND glaq035 IS NULL) OR glaq035 = ' ')",
               "   AND (glaq036  = ? OR ( ? IS NULL AND glaq036 IS NULL) OR glaq036 = ' ')",
               "   AND (glaq037  = ? OR ( ? IS NULL AND glaq037 IS NULL) OR glaq037 = ' ')",
               "   AND (glaq038  = ? OR ( ? IS NULL AND glaq038 IS NULL) OR glaq038 = ' ')",
               "   AND (glaq007  = ? OR ( ? IS NULL AND glaq007 IS NULL) OR glaq007 = ' ')"

   PREPARE afap280_01_gen_ar_2_p13 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_2_p13'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   DECLARE afap280_01_gen_ar_2_cs13 CURSOR FOR afap280_01_gen_ar_2_p13
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_2_cs13'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF 

   LET l_sql = "SELECT docno  ",
               "  FROM afap280_tmp01 ",  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01 
               " WHERE glaqent  = ? ",
               "   AND (glaqcomp  = ? OR ( ? IS NULL AND glaqcomp IS NULL) OR glaqcomp = ' ')",
               "   AND (glaq001  = ? OR ( ? IS NULL AND glaq001 IS NULL) OR glaq001 = ' ')",
               "   AND (glaq002  = ? OR ( ? IS NULL AND glaq002 IS NULL) OR glaq002 = ' ')",
               "   AND (glaq021  = ? OR ( ? IS NULL AND glaq021 IS NULL) OR glaq021 = ' ')",
               "   AND (glaq022  = ? OR ( ? IS NULL AND glaq022 IS NULL) OR glaq022 = ' ')",
               "   AND (glaq005  = ? OR ( ? IS NULL AND glaq005 IS NULL) OR glaq005 = ' ')",
               "   AND (glaq006  = ? OR ( ? IS NULL AND glaq006 IS NULL))",
               "   AND (glaq039  = ? OR ( ? IS NULL AND glaq039 IS NULL))",
               "   AND (glaq042  = ? OR ( ? IS NULL AND glaq042 IS NULL))",
               "   AND (glaq018  = ? OR ( ? IS NULL AND glaq018 IS NULL) OR glaq018 = ' ')",
               "   AND (glaq019  = ? OR ( ? IS NULL AND glaq019 IS NULL) OR glaq019 = ' ')",
               "   AND (glaq020  = ? OR ( ? IS NULL AND glaq020 IS NULL) OR glaq020 = ' ')",
               "   AND (glaq021  = ? OR ( ? IS NULL AND glaq021 IS NULL) OR glaq021 = ' ')",
               "   AND (glaq022  = ? OR ( ? IS NULL AND glaq022 IS NULL) OR glaq022 = ' ')",
               "   AND (glaq023  = ? OR ( ? IS NULL AND glaq023 IS NULL) OR glaq023 = ' ')",
               "   AND (glaq024  = ? OR ( ? IS NULL AND glaq024 IS NULL) OR glaq024 = ' ')",
               "   AND (glaq025  = ? OR ( ? IS NULL AND glaq025 IS NULL) OR glaq025 = ' ')",
              #"   AND (glaq026  = ? OR ( ? IS NULL AND glaq026 IS NULL) OR glaq026 = ' ')",
               "   AND (glaq027  = ? OR ( ? IS NULL AND glaq027 IS NULL) OR glaq027 = ' ')",
               "   AND (glaq028  = ? OR ( ? IS NULL AND glaq028 IS NULL) OR glaq028 = ' ')",
               "   AND (glaq029  = ? OR ( ? IS NULL AND glaq029 IS NULL) OR glaq029 = ' ')",
               "   AND (glaq030  = ? OR ( ? IS NULL AND glaq030 IS NULL) OR glaq030 = ' ')",
               "   AND (glaq031  = ? OR ( ? IS NULL AND glaq031 IS NULL) OR glaq031 = ' ')",
               "   AND (glaq032  = ? OR ( ? IS NULL AND glaq032 IS NULL) OR glaq032 = ' ')",
               "   AND (glaq033  = ? OR ( ? IS NULL AND glaq033 IS NULL) OR glaq033 = ' ')",
               "   AND (glaq034  = ? OR ( ? IS NULL AND glaq034 IS NULL) OR glaq034 = ' ')",
               "   AND (glaq035  = ? OR ( ? IS NULL AND glaq035 IS NULL) OR glaq035 = ' ')",
               "   AND (glaq036  = ? OR ( ? IS NULL AND glaq036 IS NULL) OR glaq036 = ' ')",
               "   AND (glaq037  = ? OR ( ? IS NULL AND glaq037 IS NULL) OR glaq037 = ' ')",
               "   AND (glaq038  = ? OR ( ? IS NULL AND glaq038 IS NULL) OR glaq038 = ' ')",
               "   AND (glaq007  = ? OR ( ? IS NULL AND glaq007 IS NULL) OR glaq007 = ' ')"
   PREPARE afap280_01_gen_ar_2_p14 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_2_p14'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   DECLARE afap280_01_gen_ar_2_cs14 CURSOR FOR afap280_01_gen_ar_2_p14
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_2_cs14'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   LET r_success=TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 应收立帐自动产生凭证
# Memo...........:
# Usage..........: CALL afap280_01_gen_ar_1(p_type,p_ld,p_sum_type,p_wc,p_prog)
#                       RETURNING r_success,g_glaq
# Input parameter: p_type         来源类型
#                                 8.afat503 資產重估
#                                 4.afat504 資產出售
#                : p_ld           帐套
#                : p_sum_type     汇总方式 
#                : p_wc           QBE条件(帐款来源)
# Return code....: r_success      成功否标识位
#                : g_glaq         傳票底稿清單
# Date & Author..: 2014/08/16 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_1(p_type,p_ld,p_sum_type,p_wc,p_prog)
   DEFINE p_type          LIKE type_t.chr2
   DEFINE p_ld            LIKE glaa_t.glaald
   DEFINE p_sum_type      LIKE type_t.chr1
   DEFINE p_wc            LIKE type_t.chr1000
   DEFINE p_prog          LIKE gzza_t.gzza001
   DEFINE r_success       LIKE type_t.num5
   #161215-00044#1---modify----begin-----------------
   #DEFINE l_fabg          RECORD LIKE fabg_t.*
   DEFINE l_fabg RECORD  #資產異動單頭檔(一帳套)
       fabgent LIKE fabg_t.fabgent, #企業編號
       fabgcomp LIKE fabg_t.fabgcomp, #法人
       fabgld LIKE fabg_t.fabgld, #帳套
       fabgdocno LIKE fabg_t.fabgdocno, #來源單號
       fabgdocdt LIKE fabg_t.fabgdocdt, #單據日期
       fabgsite LIKE fabg_t.fabgsite, #資產中心
       fabg001 LIKE fabg_t.fabg001, #帳務人員
       fabg002 LIKE fabg_t.fabg002, #申請人員
       fabg003 LIKE fabg_t.fabg003, #申請部門
       fabg004 LIKE fabg_t.fabg004, #申請日期
       fabg005 LIKE fabg_t.fabg005, #異動類型
       fabg006 LIKE fabg_t.fabg006, #帳款客戶
       fabg007 LIKE fabg_t.fabg007, #收款客戶
       fabg008 LIKE fabg_t.fabg008, #傳票號碼
       fabg009 LIKE fabg_t.fabg009, #傳票日期
       fabg010 LIKE fabg_t.fabg010, #所有組織
       fabg011 LIKE fabg_t.fabg011, #產生應收帳款編號
       fabg012 LIKE fabg_t.fabg012, #產生應付帳款編號
       fabg013 LIKE fabg_t.fabg013, #稅別
       fabg014 LIKE fabg_t.fabg014, #稅率
       fabg015 LIKE fabg_t.fabg015, #幣別
       fabg016 LIKE fabg_t.fabg016, #匯率
       fabg017 LIKE fabg_t.fabg017, #調撥流水碼
       fabg018 LIKE fabg_t.fabg018, #核算組織
       fabg019 LIKE fabg_t.fabg019, #來源單號
       fabgstus LIKE fabg_t.fabgstus, #狀態碼
       fabgownid LIKE fabg_t.fabgownid, #資料所有者
       fabgowndp LIKE fabg_t.fabgowndp, #資料所屬部門
       fabgcrtid LIKE fabg_t.fabgcrtid, #資料建立者
       fabgcrtdp LIKE fabg_t.fabgcrtdp, #資料建立部門
       fabgcrtdt LIKE fabg_t.fabgcrtdt, #資料創建日
       fabgmodid LIKE fabg_t.fabgmodid, #資料修改者
       fabgmoddt LIKE fabg_t.fabgmoddt, #最近修改日
       fabgcnfid LIKE fabg_t.fabgcnfid, #資料確認者
       fabgcnfdt LIKE fabg_t.fabgcnfdt, #資料確認日
       fabgpstid LIKE fabg_t.fabgpstid, #資料過帳者
       fabgpstdt LIKE fabg_t.fabgpstdt, #資料過帳日
       fabgud001 LIKE fabg_t.fabgud001, #自定義欄位(文字)001
       fabgud002 LIKE fabg_t.fabgud002, #自定義欄位(文字)002
       fabgud003 LIKE fabg_t.fabgud003, #自定義欄位(文字)003
       fabgud004 LIKE fabg_t.fabgud004, #自定義欄位(文字)004
       fabgud005 LIKE fabg_t.fabgud005, #自定義欄位(文字)005
       fabgud006 LIKE fabg_t.fabgud006, #自定義欄位(文字)006
       fabgud007 LIKE fabg_t.fabgud007, #自定義欄位(文字)007
       fabgud008 LIKE fabg_t.fabgud008, #自定義欄位(文字)008
       fabgud009 LIKE fabg_t.fabgud009, #自定義欄位(文字)009
       fabgud010 LIKE fabg_t.fabgud010, #自定義欄位(文字)010
       fabgud011 LIKE fabg_t.fabgud011, #自定義欄位(數字)011
       fabgud012 LIKE fabg_t.fabgud012, #自定義欄位(數字)012
       fabgud013 LIKE fabg_t.fabgud013, #自定義欄位(數字)013
       fabgud014 LIKE fabg_t.fabgud014, #自定義欄位(數字)014
       fabgud015 LIKE fabg_t.fabgud015, #自定義欄位(數字)015
       fabgud016 LIKE fabg_t.fabgud016, #自定義欄位(數字)016
       fabgud017 LIKE fabg_t.fabgud017, #自定義欄位(數字)017
       fabgud018 LIKE fabg_t.fabgud018, #自定義欄位(數字)018
       fabgud019 LIKE fabg_t.fabgud019, #自定義欄位(數字)019
       fabgud020 LIKE fabg_t.fabgud020, #自定義欄位(數字)020
       fabgud021 LIKE fabg_t.fabgud021, #自定義欄位(日期時間)021
       fabgud022 LIKE fabg_t.fabgud022, #自定義欄位(日期時間)022
       fabgud023 LIKE fabg_t.fabgud023, #自定義欄位(日期時間)023
       fabgud024 LIKE fabg_t.fabgud024, #自定義欄位(日期時間)024
       fabgud025 LIKE fabg_t.fabgud025, #自定義欄位(日期時間)025
       fabgud026 LIKE fabg_t.fabgud026, #自定義欄位(日期時間)026
       fabgud027 LIKE fabg_t.fabgud027, #自定義欄位(日期時間)027
       fabgud028 LIKE fabg_t.fabgud028, #自定義欄位(日期時間)028
       fabgud029 LIKE fabg_t.fabgud029, #自定義欄位(日期時間)029
       fabgud030 LIKE fabg_t.fabgud030, #自定義欄位(日期時間)030
       fabg020 LIKE fabg_t.fabg020  #資產性質
       END RECORD

   #161215-00044#1---modify----end-----------------
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_ac            LIKE type_t.num5
   DEFINE l_ac1           LIKE type_t.num5
   DEFINE l_docno         LIKE glaq_t.glaqdocno
   DEFINE l_glaq002       LIKE glaq_t.glaq002
   DEFINE l_field         LIKE type_t.chr1000
   DEFINE l_field1        LIKE type_t.chr1000
   DEFINE l_field2        LIKE type_t.chr1000
   DEFINE l_field3        LIKE type_t.chr1000
   DEFINE l_field4        LIKE type_t.chr1000
   DEFINE l_group_field   LIKE type_t.chr1000
   DEFINE l_glad_r        RECORD 
                          glad005   LIKE glad_t.glad005,  #数量/金额管理否
                          glad007   LIKE glad_t.glad007,  #部门管理否
                          glad008   LIKE glad_t.glad008,  #利润成本管理否
                          glad009   LIKE glad_t.glad009,  #区域管理否
                          glad010   LIKE glad_t.glad010,  #客商管理否
                          glad011   LIKE glad_t.glad011,  #客群管理否
                          glad012   LIKE glad_t.glad012,  #产品类别管理否
                          glad013   LIKE glad_t.glad013,  #人员管理否
                          glad014   LIKE glad_t.glad014,  #预算管理否
                          glad015   LIKE glad_t.glad015,  #专案管理否
                          glad016   LIKE glad_t.glad016,  #WBS管理否
                          glad017   LIKE glad_t.glad017,  #自由核算项1管理否
                          glad018   LIKE glad_t.glad018,  #自由核算项2管理否
                          glad019   LIKE glad_t.glad019,  #自由核算项3管理否
                          glad020   LIKE glad_t.glad020,  #自由核算项4管理否
                          glad021   LIKE glad_t.glad021,  #自由核算项5管理否
                          glad022   LIKE glad_t.glad022,  #自由核算项6管理否
                          glad023   LIKE glad_t.glad023,  #自由核算项7管理否
                          glad024   LIKE glad_t.glad024,  #自由核算项8管理否
                          glad025   LIKE glad_t.glad025,  #自由核算项9管理否
                          glad026   LIKE glad_t.glad026,  #自由核算项10管理否
                          glad027   LIKE glad_t.glad027   #帳款客商管理                          
                          END RECORD
   
   WHENEVER ERROR CONTINUE
   LET r_success  = FALSE

   IF p_sum_type NOT MATCHES '[12]' THEN
      #产生凭证的汇总方式仅可为1或2
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00124'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DELETE FROM afap280_tmp01;  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
   #1.定义CURSOR
   CALL afap280_01_gen_ar_def_cursor(p_type,p_ld,p_wc,p_sum_type,p_prog) RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF
 
   #2.插入临时表
   FOREACH afap280_01_gen_ar_1_cs1 INTO l_fabg.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_1_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      CASE
         #销账/报废
         WHEN p_type='6' OR p_type='21'
            CALL afap280_01_gen_ar_ins_tmp_6(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF 
         #重估  
         WHEN p_type='8' OR p_type='39' #160426-00014#10 '39' 调整
            CALL afap280_01_gen_ar_ins_tmp_8(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF 
         #减值准备               
         WHEN p_type='14'
            CALL afap280_01_gen_ar_ins_tmp_14(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF 
         #出售
         WHEN p_type='4'
            CALL afap280_01_gen_ar_ins_tmp_4(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF
         #160426-00014#45--add--str--lujh
         #拨出账务
         WHEN p_type='43'
            CALL afap280_01_gen_ar_ins_tmp_43(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF
         #160426-00014#45--add--end--lujh
         #160426-00014#44--add--str--lujh
         #拨出账务
         WHEN p_type='44'
            CALL afap280_01_gen_ar_ins_tmp_44(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF
         #160426-00014#44--add--end--lujh
         #改良               
         WHEN p_type='9'
            CALL afap280_01_gen_ar_ins_tmp_9(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF  
         #销账/报废
         WHEN p_type='0' 
            CALL afap280_01_gen_ar_ins_tmp_0(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF 
         #140122-00001#129--add--str--lujh
         #投保保费
         WHEN p_type='35' 
            CALL afap280_01_gen_ar_ins_tmp_35(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF   
         #140122-00001#129--add--end--lujh            
         #资本化
         WHEN p_type='22'  OR p_type = '26' 
            CALL afap280_01_gen_ar_ins_tmp_22(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF     
         #add by yangxf ---
         #类型异动
         WHEN p_type='30'
            CALL afap280_01_gen_ar_ins_tmp_30(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF  
         #add by yangxf ---
         #150417-00007#65--add--str--
         #资产科目异动
         WHEN p_type='31'
            CALL afap280_01_gen_ar_ins_tmp_31(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF
         #150417-00007#65--add--end
         #160329-00025 add--str--
         #盘盈
         WHEN p_type='23'
            CALL afap280_01_gen_ar_ins_tmp_23(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF  

         #盘亏
         WHEN p_type='24'
            CALL afap280_01_gen_ar_ins_tmp_24(l_fabg.fabgld,l_fabg.fabgdocno,'')
               RETURNING l_success
            IF NOT l_success THEN
               RETURN r_success    
            END IF           
         #160329-00025 add--end--
      END CASE
   END FOREACH
   
   #3.按科目设置进行UPDATE,若有做不管理的字段,UPDATE至' '
   CALL afap280_01_gen_ar_2_upd_tmp(p_ld) RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success    
   END IF
  
   LET r_success = TRUE
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 处理借方科目及金额等
# Memo...........: 銷帳/報廢
# Usage..........: CALL afap280_01_gen_ar_ins_tmp_6(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno    異動单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: 2014/08/16 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_6(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,  
                          #glaq026  LIKE glaq_t.glaq026,  
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028,  
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL

   #销账/报废
   #借：固定资产清理faah022 金额：本币成本-累计折旧-已提列减值准备(fabh008-fabh011-fabh017)
   FOREACH afap280_01_gen_ar_6_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_6_d_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
#      IF l_xrcb022 = -1 THEN 
#         LET l_tmp.sw = '2'
#         LET l_tmp.c = l_tmp.d
#         LET l_tmp.d = 0
#      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   
   #借：累计折旧faah023 金额：累计折旧fabh011
   FOREACH afap280_01_gen_ar_6_d_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_6_d_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
#      IF l_xrcb022 = -1 THEN 
#         LET l_tmp.sw = '2'
#         LET l_tmp.c = l_tmp.d
#         LET l_tmp.d = 0
#      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   #借：减值准备科目fabh024 金额：已提列减准备fabh017>0
   FOREACH afap280_01_gen_ar_6_d_cs3 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_6_d_cs3'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
#      IF l_xrcb022 = -1 THEN 
#         LET l_tmp.sw = '2'
#         LET l_tmp.c = l_tmp.d
#         LET l_tmp.d = 0
#      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   #贷：固定资产资产科目fabh024 金额：本币成本fabh008
   FOREACH afap280_01_gen_ar_6_c_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_6_c_cs1'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
#       IF l_xrcb022 = -1 THEN 
#          LET l_tmp.sw = '1'
#          LET l_tmp.d = l_tmp.c
#          LET l_tmp.c = 0
#       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH

   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 处理借方科目及金额等
# Memo...........: 出售
# Usage..........: CALL afap280_01_gen_ar_2_ins_tmp(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno   应收帐款单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: 2014/08/16 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_4(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_ooab002        LIKE ooab_t.ooab002
   DEFINE l_glaacomp       LIKE glaa_t.glaacomp
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,  
                          #glaq026  LIKE glaq_t.glaq026,  
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028, 
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌                           
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL
   SELECT glaacomp INTO l_glaacomp FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_fabgld
    
   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9017') RETURNING l_ooab002
   
   IF l_ooab002 = 'Y' THEN
   #借：固定资产清理(帐面价值）fabo024	 金額fabo018-fabo019-fabo020
   FOREACH afap280_01_gen_ar_4_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_4_d_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH

   #借：累折科目	fabo026	fabo019
   FOREACH afap280_01_gen_ar_4_d_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_4_d_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   
   #借：資產科目	fabo028	fabo018
   FOREACH afap280_01_gen_ar_4_c_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_4_c_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   
   #借：减值准备科目	fabo027	fabo020
   FOREACH afap280_01_gen_ar_4_d_cs3 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_4_d_cs3'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   
   ELSE
   #借：出售应收科目fabo029  出售应收金额
   FOREACH afap280_01_gen_ar_4_d_cs4 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_4_d_cs4'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '2'
          LET l_tmp.c = l_tmp.d
          LET l_tmp.d = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH  
   
   #借：出售损失科目	
   FOREACH afap280_01_gen_ar_4_d_cs5 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_4_d_cs5'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH  

   #借	：減值準備科目
   FOREACH afap280_01_gen_ar_4_d_cs6 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_4_d_cs6'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH  
   
   #借：累折科目
   FOREACH afap280_01_gen_ar_4_d_cs7 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_4_d_cs7'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01' #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH  
   
   #貸：出售收益科目		
   FOREACH afap280_01_gen_ar_4_c_cs4 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_4_c_cs4'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH  
   
   #贷 销项税额:出售
   FOREACH afap280_01_gen_ar_4_c_cs2 USING p_fabgdocno INTO l_tmp.*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_4_c_cs2'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       
       #若為負數金額,則借貸方向要相反
       IF l_tmp.c < 0 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c * -1
          LET l_tmp.c = 0
       END IF
       
       #沒有稅額,不產生
       IF l_tmp.d = 0 AND l_tmp.c = 0 THEN 
          CONTINUE FOREACH 
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH   
   
   #贷	：資產科目
   FOREACH afap280_01_gen_ar_4_c_cs3 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_4_c_cs3'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH  
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 自动生成凭证 - 产生凭证单头
# Memo...........:
# Usage..........: CALL afap280_01_gen_ar_2_ins_glap(p_slip,p_date,p_type,p_ld,p_sum_type)
#                       RETURNING r_success,r_start_no,r_end_no
# Input parameter: p_slip         凭证单别
#                : p_date         傳票日期
#                : p_type         異動類型
#                : p_ld           帳套
#                : p_sum_type     匯總方式
# Return code....: r_success      成功否标识位
#                : r_start_no     生成的起始凭证单号
#                : r_end_no       生成的截止凭证单号
# Date & Author..: 2014/08/16 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_2_ins_glap(p_slip,p_date,p_type,p_ld,p_sum_type)
  #DEFINE p_slip          LIKE ooba_t.ooba002    #160525-00021#3 mark
   DEFINE p_slip          LIKE type_t.chr50      #160525-00021#3     
   DEFINE p_type          LIKE type_t.chr2
   DEFINE p_ld            LIKE glaa_t.glaald
   DEFINE p_sum_type      LIKE type_t.chr1
   DEFINE p_date          LIKE glap_t.glapdocdt
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_start_no      LIKE glap_t.glapdocno
   DEFINE r_end_no        LIKE glap_t.glapdocno
   #161215-00044#1---modify----begin-----------------
   #DEFINE l_glap          RECORD LIKE glap_t.*
   DEFINE l_glap RECORD  #傳票憑證單頭檔
       glapent LIKE glap_t.glapent, #企業編號
       glapld LIKE glap_t.glapld, #帳套
       glapcomp LIKE glap_t.glapcomp, #法人
       glapdocno LIKE glap_t.glapdocno, #單號
       glapdocdt LIKE glap_t.glapdocdt, #單據日期
       glap001 LIKE glap_t.glap001, #傳票性質
       glap002 LIKE glap_t.glap002, #會計年度
       glap003 LIKE glap_t.glap003, #會計季別
       glap004 LIKE glap_t.glap004, #會計期別
       glap005 LIKE glap_t.glap005, #會計周別
       glap006 LIKE glap_t.glap006, #收支科目
       glap007 LIKE glap_t.glap007, #來源碼
       glap008 LIKE glap_t.glap008, #帳款類型
       glap009 LIKE glap_t.glap009, #總號
       glap010 LIKE glap_t.glap010, #借方總金額
       glap011 LIKE glap_t.glap011, #貸方總金額
       glap012 LIKE glap_t.glap012, #列印次數
       glap013 LIKE glap_t.glap013, #附件張數
       glap014 LIKE glap_t.glap014, #外幣憑證否
       glap015 LIKE glap_t.glap015, #原傳票編號
       glap016 LIKE glap_t.glap016, #來源帳套編號
       glap017 LIKE glap_t.glap017, #來源傳票編號
       glapownid LIKE glap_t.glapownid, #資料所有者
       glapowndp LIKE glap_t.glapowndp, #資料所屬部門
       glapcrtid LIKE glap_t.glapcrtid, #資料建立者
       glapcrtdp LIKE glap_t.glapcrtdp, #資料建立部門
       glapcrtdt LIKE glap_t.glapcrtdt, #資料創建日
       glapmodid LIKE glap_t.glapmodid, #資料修改者
       glapmoddt LIKE glap_t.glapmoddt, #最近修改日
       glapcnfid LIKE glap_t.glapcnfid, #資料確認者
       glapcnfdt LIKE glap_t.glapcnfdt, #資料確認日
       glappstid LIKE glap_t.glappstid, #資料過帳者
       glappstdt LIKE glap_t.glappstdt, #資料過帳日
       glapstus LIKE glap_t.glapstus, #狀態碼
       glapud001 LIKE glap_t.glapud001, #自定義欄位(文字)001
       glapud002 LIKE glap_t.glapud002, #自定義欄位(文字)002
       glapud003 LIKE glap_t.glapud003, #自定義欄位(文字)003
       glapud004 LIKE glap_t.glapud004, #自定義欄位(文字)004
       glapud005 LIKE glap_t.glapud005, #自定義欄位(文字)005
       glapud006 LIKE glap_t.glapud006, #自定義欄位(文字)006
       glapud007 LIKE glap_t.glapud007, #自定義欄位(文字)007
       glapud008 LIKE glap_t.glapud008, #自定義欄位(文字)008
       glapud009 LIKE glap_t.glapud009, #自定義欄位(文字)009
       glapud010 LIKE glap_t.glapud010, #自定義欄位(文字)010
       glapud011 LIKE glap_t.glapud011, #自定義欄位(數字)011
       glapud012 LIKE glap_t.glapud012, #自定義欄位(數字)012
       glapud013 LIKE glap_t.glapud013, #自定義欄位(數字)013
       glapud014 LIKE glap_t.glapud014, #自定義欄位(數字)014
       glapud015 LIKE glap_t.glapud015, #自定義欄位(數字)015
       glapud016 LIKE glap_t.glapud016, #自定義欄位(數字)016
       glapud017 LIKE glap_t.glapud017, #自定義欄位(數字)017
       glapud018 LIKE glap_t.glapud018, #自定義欄位(數字)018
       glapud019 LIKE glap_t.glapud019, #自定義欄位(數字)019
       glapud020 LIKE glap_t.glapud020, #自定義欄位(數字)020
       glapud021 LIKE glap_t.glapud021, #自定義欄位(日期時間)021
       glapud022 LIKE glap_t.glapud022, #自定義欄位(日期時間)022
       glapud023 LIKE glap_t.glapud023, #自定義欄位(日期時間)023
       glapud024 LIKE glap_t.glapud024, #自定義欄位(日期時間)024
       glapud025 LIKE glap_t.glapud025, #自定義欄位(日期時間)025
       glapud026 LIKE glap_t.glapud026, #自定義欄位(日期時間)026
       glapud027 LIKE glap_t.glapud027, #自定義欄位(日期時間)027
       glapud028 LIKE glap_t.glapud028, #自定義欄位(日期時間)028
       glapud029 LIKE glap_t.glapud029, #自定義欄位(日期時間)029
       glapud030 LIKE glap_t.glapud030  #自定義欄位(日期時間)030
       END RECORD

   #161215-00044#1---modify----end-----------------
   DEFINE l_glaqent       LIKE glaq_t.glaqent
   DEFINE l_glaqld        LIKE glaq_t.glaqld
   DEFINE l_glaqcomp      LIKE glaq_t.glaqcomp
   DEFINE l_docno         LIKE glap_t.glapdocno
   DEFINE l_docdt         LIKE glap_t.glapdocdt
   DEFINE l_glaq021       LIKE glaq_t.glaq021
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_ooef008       LIKE ooef_t.ooef008
   DEFINE l_ooef010       LIKE ooef_t.ooef010
   DEFINE l_glaa001       LIKE glaa_t.glaa001
   DEFINE l_glaa100       LIKE glaa_t.glaa100  #160810-00004#1 add
   DEFINE l_glaa024       LIKE glaa_t.glaa024  #160810-00004#1 add
   DEFINE l_fabg015       LIKE fabg_t.fabg015
   DEFINE l_sql           STRING
   DEFINE l_field         STRING
   DEFINE l_cnt           LIKE type_t.num5
   
   
   WHENEVER ERROR CONTINUE
   LET r_success  = FALSE
   LET r_start_no = NULL
   LET r_end_no   = NULL
   
   #1.定义CURSOR
   #临时表GROUP,以便产生凭证单据的单头档glap_t
   CASE p_sum_type
      WHEN '1'  LET l_field = "docno,'',''"
      WHEN '2'  LET l_field = "'',docdt,''"
#      WHEN '3'  LET l_field = "'','',glaq021"
   END CASE
   
   LET l_sql = " SELECT UNIQUE glaqcomp,",l_field CLIPPED,
               "   FROM afap280_tmp02 "         #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
              #"   FROM afap280_01_group "      #151001-00005#1
              #"   FROM afap280_01_fa_group "   #151001-00005#1
   
   PREPARE afap280_01_gen_ar_2_p8 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_2_p8'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   DECLARE afap280_01_gen_ar_2_cs8 CURSOR FOR afap280_01_gen_ar_2_p8
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_ar_2_cs8'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #160810-00004#1 add--s
   SELECT glaa100,glaa024 INTO l_glaa100,l_glaa024
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = p_ld
   IF l_glaa100 = 'Y' THEN
      DELETE FROM s_fin_tmp  #160727-00019#31  2016/08/10  By 08734    临时表长度超过15码的减少到15码以下?s_fin_tmp_conti_no ——> s_fin_tmp
      CALL s_fin_continue_no_ins(p_ld,l_glaa024,p_slip,p_date,'3') RETURNING g_sub_success,g_errno
   END IF
   #160810-00004#1 add--e
   LET l_sql = " SELECT docno FROM s_fin_tmp  WHERE isuse = 'N' ORDER BY docno"     #160727-00019#31  2016/08/10  By 08734    临时表长度超过15码的减少到15码以下?s_fin_tmp_conti_no ——> s_fin_tmp
   PREPARE continue_no_pb1 FROM l_sql
   DECLARE continue_no_cs1 CURSOR FOR continue_no_pb1
   
   FOREACH afap280_01_gen_ar_2_cs8 INTO l_glaqcomp,l_docno,l_docdt,l_glaq021
      IF SQLCA.sqlcode THEN  
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'afap280_01_gen_ar_2_cs8'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success,r_start_no,r_end_no
      END IF
      
      INITIALIZE l_glap.* TO NULL
      SELECT ooef008,ooef010 INTO l_ooef008,l_ooef010 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_glaqcomp
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel ooef'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_start_no = NULL
         LET r_end_no   = NULL
         RETURN r_success,r_start_no,r_end_no
      END IF
      
      #帳套主幣別
      SELECT glaa001 INTO l_glaa001 
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = p_ld
         
      SELECT fabg015 INTO l_fabg015
        FROM fabg_t
       WHERE fabgent = g_enterprise
         AND fabgld = p_ld
         AND fabgdocno = l_docno

      #自动编号
#      CALL s_aooi200_gen_docno(l_glaqcomp,p_slip,p_date,'aglt310') RETURNING l_success,l_glap.glapdocno   #mark by yangxf
#add by yagnxf start ---
      SELECT count(*) INTO l_cnt
        FROM s_fin_tmp  #160727-00019#31  2016/08/10  By 08734    临时表长度超过15码的减少到15码以下?s_fin_tmp_conti_no ——> s_fin_tmp
       WHERE isuse = 'N'
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF

      IF l_cnt > 0 THEN
         FOREACH continue_no_cs1 INTO l_glap.glapdocno
            UPDATE s_fin_tmp    #160727-00019#31  2016/08/10  By 08734    临时表长度超过15码的减少到15码以下?s_fin_tmp_conti_no ——> s_fin_tmp
               SET isuse = 'Y'
             WHERE docno = l_glap.glapdocno
            #檢查是否號碼已被使用
            SELECT count(*) INTO l_cnt
              FROM glap_t
             WHERE glapent = g_enterprise AND glapld = p_ld
              AND glapdocno=l_glap.glapdocno
            IF l_cnt = 0 THEN
               EXIT FOREACH
            END IF
         END FOREACH
         #假設整個單號都已被取用還是透過s_aooi200_fin_gen_docno取單號
         IF l_cnt > 0 THEN
            CALL s_aooi200_fin_gen_docno(p_ld,'','',p_slip,p_date,'aglt310') RETURNING l_success,l_glap.glapdocno
         END IF
      ELSE
         CALL s_aooi200_fin_gen_docno(p_ld,'','',p_slip,p_date,'aglt310') RETURNING l_success,l_glap.glapdocno
      END IF
#add by yangxf end ---
      IF SQLCA.sqlcode THEN
         LET r_start_no = NULL
         LET r_end_no   = NULL
         RETURN r_success,r_start_no,r_end_no
      END IF
      
      #处理起始单号,截止单号
      IF cl_null(r_start_no) THEN LET r_start_no = l_glap.glapdocno END IF
      LET r_end_no   = l_glap.glapdocno 
      
      LET l_glap.glapent   =  g_enterprise  # 企業代碼
      LET l_glap.glapld    =  p_ld          # 帳別
      LET l_glap.glapcomp  =  l_glaqcomp    # 法人
      LET l_glap.glapdocdt =  p_date        # 單據日期
      LET l_glap.glap001   = '1'            # 傳票性質
      
      # 會計年度/會計期別/會計季別/會計周別
      SELECT oogc015,oogc006,oogc007,oogc008 INTO l_glap.glap002,l_glap.glap004,l_glap.glap003,l_glap.glap005
        FROM oogc_t
       WHERE oogcent = g_enterprise
         AND oogc001 = l_ooef008
         AND oogc002 = l_ooef010
         AND oogc003 = l_glap.glapdocdt
      
      LET l_glap.glap006   =  ''         # 收支科目
      LET l_glap.glap007   =  'FA'       # 來源碼
      # 帳款類型
#20141228 mod by chenying 
#scc-8035 
#      CASE p_type
#         WHEN '0'
#            LET l_glap.glap008   =  'afat509'  
#         WHEN '1'
#            LET l_glap.glap008   =  'afat500'  
#         WHEN '4'
#            LET l_glap.glap008   =  'afat504'  
#         WHEN '6'
#            LET l_glap.glap008   =  'afat506'  
#         WHEN '8'
#            LET l_glap.glap008   =  'afat503' 
#         WHEN '14'
#            LET l_glap.glap008   =  'afat502'  
#         WHEN '21'
#            LET l_glap.glap008   =  'afat507'
#      END CASE 
      CASE p_type
         WHEN '0'
            LET l_glap.glap008   =  'F30'  
         WHEN '1'
            LET l_glap.glap008   =  'F10'  
         WHEN '4'
            LET l_glap.glap008   =  'F40'  
         WHEN '6'
            LET l_glap.glap008   =  'F50'  
         WHEN '8'
            LET l_glap.glap008   =  'F50'
         #160426-00014#10 add s---   
         WHEN '39'
            LET l_glap.glap008   =  'F50'   
         #160426-00014#10 add e---   
         WHEN '14'
            LET l_glap.glap008   =  'F50'  
         WHEN '21'
            LET l_glap.glap008   =  'F50'
         WHEN '31'                          #150417-00007#65 add '31'
            LET l_glap.glap008   =  'F50'   
         #160329-00025#3 add--str--
         WHEN '23'                           
            LET l_glap.glap008   =  'F50' 
         WHEN '24'                           
            LET l_glap.glap008   =  'F50'             
         #160329-00025#3 add--end--         
      END CASE  
#20141228 add by chenying     
      
      LET l_glap.glap009   =  0          # 總號
      LET l_glap.glap010   =  0          # 借方總金額
      LET l_glap.glap011   =  0          # 貸方總金額
      LET l_glap.glap012   =  0          # 列印次數
      LET l_glap.glap013   =  0          # 附件張數
      IF l_glaa001 = l_fabg015 THEN 
         LET l_glap.glap014   =  'N'        # 外幣憑證否
      ELSE
         LET l_glap.glap014   =  'Y'        # 外幣憑證否
      END IF
      LET l_glap.glap015   =  ''         # 原傳票編號
      LET l_glap.glap016   =  ''         # 來源帳別編號
      LET l_glap.glap017   =  ''         # 來源傳票編號
      LET l_glap.glapownid =  g_user     # 資料所有者
      LET l_glap.glapowndp =  g_dept     # 資料所屬部門
      LET l_glap.glapcrtid =  g_user     # 資料建立者
      LET l_glap.glapcrtdp =  g_dept     # 資料建立部門
      LET l_glap.glapcrtdt =  cl_get_current()  # 資料創建日
      LET l_glap.glapmodid =  ''         # 資料修改者
      LET l_glap.glapmoddt =  ''         # 最近修改日
      LET l_glap.glapcnfid =  ''         # 資料確認者
      LET l_glap.glapcnfdt =  ''         # 資料確認日
      LET l_glap.glappstid =  ''         # 資料過帳者
      LET l_glap.glappstdt =  ''         # 資料過帳日
      LET l_glap.glapstus  =  'N'        # 狀態碼

      INSERT INTO glap_t VALUES(l_glap.*)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins glap'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_start_no = NULL
         LET r_end_no   = NULL
         RETURN r_success,r_start_no,r_end_no         
      END IF
      
      #产生凭证单身
      CALL afap280_01_gen_ar_2_ins_glaq(l_glap.glapdocno,p_date,p_ld,l_glaqcomp,l_docno,l_docdt,l_glaq021,p_sum_type)
           RETURNING l_success
      IF NOT l_success THEN
         LET r_start_no = NULL
         LET r_end_no   = NULL
         RETURN r_success,r_start_no,r_end_no           
      END IF
  
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success,r_start_no,r_end_no
END FUNCTION

################################################################################
# Descriptions...: 科目名稱+核算項說明
# Memo...........:
# Usage..........: CALL afap280_01_glaq002_desc(p_glaq002,p_glaqld)
#                  RETURNING r_desc
# Input parameter: p_glaq002      科目編號
#                : p_glaqld       帐套
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_glaq002_desc(p_glaq002,p_glaqld)
   DEFINE p_glaq002           LIKE glaq_t.glaq002
   DEFINE p_glaqld            LIKE glaq_t.glaqld
   DEFINE l_glaq002_desc      LIKE glacl_t.glacl004
   DEFINE r_glaq002           STRING
   DEFINE l_desc              STRING
   DEFINE r_str               STRING
   DEFINE l_glaq      RECORD 
         glaq017        LIKE glaq_t.glaq017,
         glaq018        LIKE glaq_t.glaq018,
         glaq019        LIKE glaq_t.glaq019,
         glaq020        LIKE glaq_t.glaq020,
         glaq021        LIKE glaq_t.glaq021,
         glaq022        LIKE glaq_t.glaq022,
         glaq023        LIKE glaq_t.glaq023,
         glaq024        LIKE glaq_t.glaq024,
         glaq025        LIKE glaq_t.glaq025,
        #glaq026        LIKE glaq_t.glaq026,
         glaq027        LIKE glaq_t.glaq027,
         glaq028        LIKE glaq_t.glaq028
                   END RECORD
   
   SELECT glaq017,glaq018,glaq019,glaq020,glaq021,
          glaq022,glaq023,glaq024,glaq025,glaq027,
          glaq028
     INTO l_glaq.*
    #FROM afap280_01_fa_group   #151001-00005#1
    FROM afap280_tmp02      #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
    #FROM afap280_01_group      #151001-00005#1   
    WHERE glaqent = g_enterprise
      AND glaqld = p_glaqld
      AND glaq002 = p_glaq002
   
   #抓取科目名称
   LET l_glaq002_desc = ''
   SELECT glacl004 INTO l_glaq002_desc FROM glacl_t
    WHERE glaclent = g_enterprise
      AND glacl001 = g_glaa004
      AND glacl002 = p_glaq002
      AND glacl003 = g_dlang   
   #组合名称以及核算项
   LET r_glaq002 = ''
   LET r_str = ''
   #營運據點
   IF NOT cl_null(l_glaq.glaq017) THEN
      CALL afap280_01_ooef001_desc(l_glaq.glaq017) RETURNING l_desc
      LET r_glaq002 = l_desc    
      LET r_str=l_glaq.glaq017    
   END IF
   #部门
   IF NOT cl_null(l_glaq.glaq018) THEN
      CALL afap280_01_ooef001_desc(l_glaq.glaq018) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq018
      ELSE
         LET r_str=l_glaq.glaq018
      END IF    
   END IF 
   #成本利润中心
   IF NOT cl_null(l_glaq.glaq019) THEN
      CALL afap280_01_ooef001_desc(l_glaq.glaq019) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq019
      ELSE
         LET r_str=l_glaq.glaq019
      END IF
   END IF 
   
   #区域
   IF NOT cl_null(l_glaq.glaq020) THEN 
      CALL afap280_01_glaq020_desc('287',l_glaq.glaq020) RETURNING l_desc   
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq020
      ELSE
         LET r_str=l_glaq.glaq020
      END IF      
   END IF 
   #交易客商
   IF NOT cl_null(l_glaq.glaq021) THEN
      CALL afap280_01_glaq021_desc(l_glaq.glaq021) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF 
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq021
      ELSE
         LET r_str=l_glaq.glaq021
      END IF      
   END IF 
   #帐款客商
   IF NOT cl_null(l_glaq.glaq022) THEN
      CALL afap280_01_glaq021_desc(l_glaq.glaq022) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq022
      ELSE
         LET r_str=l_glaq.glaq022
      END IF      
   END IF 
   #客群
   IF NOT cl_null(l_glaq.glaq023) THEN
      CALL afap280_01_glaq020_desc('281',l_glaq.glaq023) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq023
      ELSE
         LET r_str=l_glaq.glaq023
      END IF      
   END IF 
   
   #产品分类
   IF NOT cl_null(l_glaq.glaq024) THEN
      CALL afap280_01_glaq024_desc(l_glaq.glaq024) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq024
      ELSE
         LET r_str=l_glaq.glaq024
      END IF      
   END IF 
   #人员
   IF NOT cl_null(l_glaq.glaq025) THEN
       CALL afap280_01_glaq025_desc(l_glaq.glaq025) RETURNING l_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq025
      ELSE
         LET r_str=l_glaq.glaq025
      END IF      
   END IF 
#   #预算编号
#   IF NOT cl_null(l_glaq.glaq026) THEN
#       CALL afap280_01_glaq026_desc(l_glaq.glaq026) RETURNING l_desc
#      IF NOT cl_null(r_glaq002) THEN
#         LET r_glaq002 = r_glaq002 ,'-',l_desc
#      ELSE
#         LET r_glaq002 = l_desc
#      END IF
#      IF NOT cl_null(r_str) THEN
#         LET r_str=r_str,'-',l_glaq.glaq026
#      ELSE
#         LET r_str=l_glaq.glaq026
#      END IF      
#   END IF 
   #专案编号
   IF NOT cl_null(l_glaq.glaq027) THEN
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_glaq.glaq027
      ELSE
         LET r_glaq002 = l_glaq.glaq027
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq027
      ELSE
         LET r_str=l_glaq.glaq027
      END IF      
   END IF 
   #WBS
   IF NOT cl_null(l_glaq.glaq028) THEN
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_glaq.glaq028
      ELSE
         LET r_glaq002 = l_glaq.glaq028
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',l_glaq.glaq028
      ELSE
         LET r_str=l_glaq.glaq028
      END IF      
   END IF 
   #组合科目名称以及核算项
   LET r_glaq002 = l_glaq002_desc,'\n',
                   r_glaq002
   IF NOT cl_null(r_str) THEN
      LET r_str="(",r_str,")"
   END IF                
   RETURN r_glaq002,r_str            
END FUNCTION

################################################################################
# Descriptions...: 組織名稱
# Memo...........:
# Usage..........: CALL afap280_01_ooef001_desc(p_ooef001)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_ooef001_desc(p_ooef001)
   DEFINE p_ooef001     LIKE ooef_t.ooef001
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_ooef001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 區域客群說明
# Memo...........:
# Usage..........: CALL afap280_01_glaq020_desc(p_oocql001,p_oocql002)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_glaq020_desc(p_oocql001,p_oocql002)
   DEFINE p_oocql001     LIKE oocql_t.oocql001
    DEFINE p_oocql002     LIKE oocql_t.oocql002
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_oocql001
    LET g_ref_fields[2] = p_oocql002
    CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1] 
END FUNCTION

################################################################################
# Descriptions...: 客戶名稱
# Memo...........:
# Usage..........: CALL afap280_01_glaq021_desc(p_glaq021)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_glaq021_desc(p_glaq021)
   DEFINE p_glaq021    LIKE pmaa_t.pmaa001

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaq021
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 產品分類說明
# Memo...........:
# Usage..........: CALL afap280_01_glaq024_desc(p_glaq024)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_glaq024_desc(p_glaq024)
   DEFINE p_glaq024   LIKE glaq_t.glaq024
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaq024
    CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 人員名稱
# Memo...........:
# Usage..........: CALL afap280_01_glaq025_desc(p_glaq025)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_glaq025_desc(p_glaq025)
   DEFINE l_oogf002_desc        LIKE oofa_t.oofa011
   DEFINE p_glaq025             LIKE glaq_t.glaq025

    LET  l_oogf002_desc = ''
    SELECT oofa011 INTO l_oogf002_desc FROM oofa_t
     WHERE oofaent = g_enterprise
       AND oofa001 IN (SELECT ooag002 FROM ooag_t
                        WHERE ooagent = g_enterprise
                          AND ooag001 = p_glaq025)
     RETURN l_oogf002_desc
END FUNCTION

################################################################################
# Descriptions...: 預算說明
# Memo...........:
# Usage..........: CALL afap280_01_glaq026_desc(p_glaq026)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_glaq026_desc(p_glaq026)
   DEFINE p_glaq026      LIKE glaq_t.glaq026
#   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = p_glaq026
#   CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   RETURN g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 自动产生凭证 - BY 科目的管理设置做UPDATE
# Memo...........:
# Usage..........: CALL afap280_01_gen_ar_2_upd_tmp(p_ld)
#                  RETURNING r_success
# Input parameter: p_ld           帐套
# Return code....: r_success      成功否标识位
# Date & Author..: 2014/08/16 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_2_upd_tmp(p_ld)
   DEFINE p_ld            LIKE glaa_t.glaald
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_ld            LIKE glaa_t.glaald
   DEFINE l_glaq002       LIKE glaq_t.glaq002
   DEFINE l_docno         LIKE glaq_t.glaqdocno
   DEFINE l_upd_field     LIKE type_t.chr1000
   DEFINE l_sql           STRING
   DEFINE l_glad_r        RECORD 
                          glad005   LIKE glad_t.glad005,  #数量/金额管理否
                          glad007   LIKE glad_t.glad007,  #部门管理否
                          glad008   LIKE glad_t.glad008,  #利润成本管理否
                          glad009   LIKE glad_t.glad009,  #区域管理否
                          glad010   LIKE glad_t.glad010,  #客商管理否
                          glad011   LIKE glad_t.glad011,  #客群管理否
                          glad012   LIKE glad_t.glad012,  #产品类别管理否
                          glad013   LIKE glad_t.glad013,  #人员管理否
                          glad014   LIKE glad_t.glad014,  #预算管理否
                          glad015   LIKE glad_t.glad015,  #专案管理否
                          glad016   LIKE glad_t.glad016,  #WBS管理否
                          glad017   LIKE glad_t.glad017,  #自由核算项1管理否
                          glad018   LIKE glad_t.glad018,  #自由核算项2管理否
                          glad019   LIKE glad_t.glad019,  #自由核算项3管理否
                          glad020   LIKE glad_t.glad020,  #自由核算项4管理否
                          glad021   LIKE glad_t.glad021,  #自由核算项5管理否
                          glad022   LIKE glad_t.glad022,  #自由核算项6管理否
                          glad023   LIKE glad_t.glad023,  #自由核算项7管理否
                          glad024   LIKE glad_t.glad024,  #自由核算项8管理否
                          glad025   LIKE glad_t.glad025,  #自由核算项9管理否
                          glad026   LIKE glad_t.glad026,  #自由核算项10管理否  
                          glad027   LIKE glad_t.glad027   #帳款客商管理                        
                          END RECORD
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE   
      
   FOREACH afap280_01_gen_ar_2_cs5 INTO l_docno,l_glaq002
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_2_cs5'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF  
       
       EXECUTE afap280_01_gen_ar_2_cs6 USING l_glaq002 INTO l_glad_r.*

       LET l_upd_field = NULL
       IF l_glad_r.glad005 = 'N' OR cl_null(l_glad_r.glad005) THEN  #数量/金额不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq007 = ' ',qty = 0,glaq009 = 0"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq007 = ' ',glaq008 = 0,glaq009 = 0"
          END IF
       END IF
       IF l_glad_r.glad007 = 'N' OR cl_null(l_glad_r.glad007) THEN  #部门不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq018 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq018 = ' '"
          END IF
       END IF
       IF l_glad_r.glad008 = 'N' OR cl_null(l_glad_r.glad008) THEN  #利润成本不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq019 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq019 = ' '"
          END IF       
       END IF       

       IF l_glad_r.glad009 = 'N' OR cl_null(l_glad_r.glad009) THEN  #区域不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq020 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq020 = ' '"
          END IF       
       END IF 
       
       #20150109 add
       IF l_glad_r.glad010 = 'N' THEN  #交易客商不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq021 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq021 = ' '"
          END IF       
       END IF 
       
       IF l_glad_r.glad027 = 'N' THEN  #账款客商不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq022 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq022 = ' '"
          END IF       
       END IF 
       
       IF l_glad_r.glad011 = 'N' THEN  #客群不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq023 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq023 = ' '"
          END IF       
       END IF  
       #20150109 add
       
       IF l_glad_r.glad012 = 'N' OR cl_null(l_glad_r.glad012) THEN  #产品类别不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq024 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq024 = ' '"
          END IF       
       END IF 
       IF l_glad_r.glad013 = 'N' OR cl_null(l_glad_r.glad013) THEN  #人员不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq025 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq025 = ' '"
          END IF       
       END IF        
#       IF l_glad_r.glad014 = 'N' OR cl_null(l_glad_r.glad014) THEN  #预算不管理
#          IF cl_null(l_upd_field) THEN
#             LET l_upd_field = "glaq026 = ' '"
#          ELSE
#             LET l_upd_field = l_upd_field CLIPPED,",glaq026 = ' '"
#          END IF       
#       END IF        
       IF l_glad_r.glad015 = 'N' OR cl_null(l_glad_r.glad015) THEN  #专案不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq027 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq027 = ' '"
          END IF       
       END IF        
       IF l_glad_r.glad016 = 'N' OR cl_null(l_glad_r.glad016) THEN  #WBS不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq028 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq028 = ' '"
          END IF       
       END IF        
       IF l_glad_r.glad017 = 'N' OR cl_null(l_glad_r.glad017) THEN  #自由核算项1不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq029 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq029 = ' '"
          END IF       
       END IF        
       IF l_glad_r.glad018 = 'N' OR cl_null(l_glad_r.glad018) THEN  #自由核算项2不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq030 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq030 = ' '"
          END IF       
       END IF        
       IF l_glad_r.glad019 = 'N' OR cl_null(l_glad_r.glad019) THEN  #自由核算项3不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq031 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq031 = ' '"
          END IF       
       END IF 
       IF l_glad_r.glad020 = 'N' OR cl_null(l_glad_r.glad020) THEN  #自由核算项4不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq032 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq032 = ' '"
          END IF       
       END IF 
       IF l_glad_r.glad021 = 'N' OR cl_null(l_glad_r.glad021) THEN  #自由核算项5不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq033 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq033 = ' '"
          END IF       
       END IF 
       IF l_glad_r.glad022 = 'N' OR cl_null(l_glad_r.glad022) THEN  #自由核算项6不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq034 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq034 = ' '"
          END IF       
       END IF 
       IF l_glad_r.glad023 = 'N' OR cl_null(l_glad_r.glad023) THEN  #自由核算项7不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq035 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq035 = ' '"
          END IF       
       END IF 
       IF l_glad_r.glad024 = 'N' OR cl_null(l_glad_r.glad024) THEN  #自由核算项8不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq036 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq036 = ' '"
          END IF       
       END IF 
       IF l_glad_r.glad025 = 'N' OR cl_null(l_glad_r.glad025) THEN  #自由核算项9不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq037 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq037 = ' '"
          END IF       
       END IF        
       IF l_glad_r.glad026 = 'N' OR cl_null(l_glad_r.glad026) THEN  #自由核算项10不管理
          IF cl_null(l_upd_field) THEN
             LET l_upd_field = "glaq038 = ' '"
          ELSE
             LET l_upd_field = l_upd_field CLIPPED,",glaq038 = ' '"
          END IF       
       END IF   
       
       IF NOT cl_null(l_upd_field) THEN
          LET l_sql = "UPDATE afap280_tmp01 SET ",l_upd_field,  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
                      " WHERE glaqld  = '",p_ld CLIPPED,"'",
                      "   AND glaq002 = '",l_glaq002,"'"
          PREPARE afap280_01_gen_ar_2_upd_tmp_p1 FROM l_sql
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'afap280_01_gen_ar_2_upd_tmp_p1'
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN r_success
          END IF
          EXECUTE afap280_01_gen_ar_2_upd_tmp_p1
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'execute afap280_01_gen_ar_2_upd_tmp_p1'
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN r_success
          END IF
       END IF

   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success    
   
END FUNCTION

################################################################################
# Descriptions...: 自动产生凭证 - BY 科目的管理设置做UPDATE
# Memo...........:
# Usage..........: CALL afap280_01_gen_ar_2_ins_glaq(p_glapdocno,p_glapdocdt,p_glaqld,p_glaqcomp,p_docno,p_docdt,p_glaq022,p_sum_type)
#                  RETURNING r_success
# Input parameter: p_glapdocno    傳票單號
#                : p_glapdocdt    傳票日期
#                : p_glaqld       帐套
#                : p_glaqcomp     法人
#                : p_docno        来源单号
#                : p_docdt        凭证日期
#                : p_glaq022      帳款客戶
#                : p_sum_type     匯總方式
# Return code....: r_success      成功否标识位
# Date & Author..: 2014/08/16 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_2_ins_glaq(p_glapdocno,p_glapdocdt,p_glaqld,p_glaqcomp,p_docno,p_docdt,p_glaq022,p_sum_type)
   DEFINE p_glapdocno         LIKE glap_t.glapdocno
   DEFINE p_glapdocdt         LIKE glap_t.glapdocdt
   DEFINE p_glaqent           LIKE glaq_t.glaqent
   DEFINE p_glaqld            LIKE glaq_t.glaqld
   DEFINE p_glaqcomp          LIKE glaq_t.glaqcomp
   DEFINE p_docno             LIKE glaq_t.glaqdocno
   DEFINE p_docdt             LIKE glap_t.glapdocdt
   DEFINE p_sum_type          LIKE type_t.chr1
   DEFINE p_glaq022           LIKE glaq_t.glaq022
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_value             LIKE type_t.chr50
   #161215-00044#1---modify----begin-----------------
   #DEFINE l_glaq              RECORD LIKE glaq_t.*
   DEFINE l_glaq RECORD  #傳票憑證單身檔
       glaqent LIKE glaq_t.glaqent, #企業編號
       glaqcomp LIKE glaq_t.glaqcomp, #法人
       glaqld LIKE glaq_t.glaqld, #帳套
       glaqdocno LIKE glaq_t.glaqdocno, #單號
       glaqseq LIKE glaq_t.glaqseq, #項次
       glaq001 LIKE glaq_t.glaq001, #摘要
       glaq002 LIKE glaq_t.glaq002, #科目編號
       glaq003 LIKE glaq_t.glaq003, #借方金額
       glaq004 LIKE glaq_t.glaq004, #貸方金額
       glaq005 LIKE glaq_t.glaq005, #交易幣別
       glaq006 LIKE glaq_t.glaq006, #匯率
       glaq007 LIKE glaq_t.glaq007, #計價單位
       glaq008 LIKE glaq_t.glaq008, #數量
       glaq009 LIKE glaq_t.glaq009, #單價
       glaq010 LIKE glaq_t.glaq010, #原幣金額
       glaq011 LIKE glaq_t.glaq011, #票據編碼
       glaq012 LIKE glaq_t.glaq012, #票據日期
       glaq013 LIKE glaq_t.glaq013, #申請人
       glaq014 LIKE glaq_t.glaq014, #銀行帳號
       glaq015 LIKE glaq_t.glaq015, #款別編號
       glaq016 LIKE glaq_t.glaq016, #收支專案
       glaq017 LIKE glaq_t.glaq017, #營運據點
       glaq018 LIKE glaq_t.glaq018, #部門
       glaq019 LIKE glaq_t.glaq019, #利潤/成本中心
       glaq020 LIKE glaq_t.glaq020, #區域
       glaq021 LIKE glaq_t.glaq021, #收付款客商
       glaq022 LIKE glaq_t.glaq022, #帳款客戶
       glaq023 LIKE glaq_t.glaq023, #客群
       glaq024 LIKE glaq_t.glaq024, #產品類別
       glaq025 LIKE glaq_t.glaq025, #人員
       glaq026 LIKE glaq_t.glaq026, #no use
       glaq027 LIKE glaq_t.glaq027, #專案編號
       glaq028 LIKE glaq_t.glaq028, #WBS
       glaq029 LIKE glaq_t.glaq029, #自由核算項一
       glaq030 LIKE glaq_t.glaq030, #自由核算項二
       glaq031 LIKE glaq_t.glaq031, #自由核算項三
       glaq032 LIKE glaq_t.glaq032, #自由核算項四
       glaq033 LIKE glaq_t.glaq033, #自由核算項五
       glaq034 LIKE glaq_t.glaq034, #自由核算項六
       glaq035 LIKE glaq_t.glaq035, #自由核算項七
       glaq036 LIKE glaq_t.glaq036, #自由核算項八
       glaq037 LIKE glaq_t.glaq037, #自由核算項九
       glaq038 LIKE glaq_t.glaq038, #自由核算項十
       glaq039 LIKE glaq_t.glaq039, #匯率(本位幣二)
       glaq040 LIKE glaq_t.glaq040, #借方金額(本位幣二)
       glaq041 LIKE glaq_t.glaq041, #貸方金額(本位幣二)
       glaq042 LIKE glaq_t.glaq042, #匯率(本位幣三)
       glaq043 LIKE glaq_t.glaq043, #借方金額(本位幣三)
       glaq044 LIKE glaq_t.glaq044, #貸方金額(本位幣三)
       glaq051 LIKE glaq_t.glaq051, #經營方式
       glaq052 LIKE glaq_t.glaq052, #通路
       glaq053 LIKE glaq_t.glaq053, #品牌
       glaqud001 LIKE glaq_t.glaqud001, #自定義欄位(文字)001
       glaqud002 LIKE glaq_t.glaqud002, #自定義欄位(文字)002
       glaqud003 LIKE glaq_t.glaqud003, #自定義欄位(文字)003
       glaqud004 LIKE glaq_t.glaqud004, #自定義欄位(文字)004
       glaqud005 LIKE glaq_t.glaqud005, #自定義欄位(文字)005
       glaqud006 LIKE glaq_t.glaqud006, #自定義欄位(文字)006
       glaqud007 LIKE glaq_t.glaqud007, #自定義欄位(文字)007
       glaqud008 LIKE glaq_t.glaqud008, #自定義欄位(文字)008
       glaqud009 LIKE glaq_t.glaqud009, #自定義欄位(文字)009
       glaqud010 LIKE glaq_t.glaqud010, #自定義欄位(文字)010
       glaqud011 LIKE glaq_t.glaqud011, #自定義欄位(數字)011
       glaqud012 LIKE glaq_t.glaqud012, #自定義欄位(數字)012
       glaqud013 LIKE glaq_t.glaqud013, #自定義欄位(數字)013
       glaqud014 LIKE glaq_t.glaqud014, #自定義欄位(數字)014
       glaqud015 LIKE glaq_t.glaqud015, #自定義欄位(數字)015
       glaqud016 LIKE glaq_t.glaqud016, #自定義欄位(數字)016
       glaqud017 LIKE glaq_t.glaqud017, #自定義欄位(數字)017
       glaqud018 LIKE glaq_t.glaqud018, #自定義欄位(數字)018
       glaqud019 LIKE glaq_t.glaqud019, #自定義欄位(數字)019
       glaqud020 LIKE glaq_t.glaqud020, #自定義欄位(數字)020
       glaqud021 LIKE glaq_t.glaqud021, #自定義欄位(日期時間)021
       glaqud022 LIKE glaq_t.glaqud022, #自定義欄位(日期時間)022
       glaqud023 LIKE glaq_t.glaqud023, #自定義欄位(日期時間)023
       glaqud024 LIKE glaq_t.glaqud024, #自定義欄位(日期時間)024
       glaqud025 LIKE glaq_t.glaqud025, #自定義欄位(日期時間)025
       glaqud026 LIKE glaq_t.glaqud026, #自定義欄位(日期時間)026
       glaqud027 LIKE glaq_t.glaqud027, #自定義欄位(日期時間)027
       glaqud028 LIKE glaq_t.glaqud028, #自定義欄位(日期時間)028
       glaqud029 LIKE glaq_t.glaqud029, #自定義欄位(日期時間)029
       glaqud030 LIKE glaq_t.glaqud030  #自定義欄位(日期時間)030
       END RECORD

   #161215-00044#1---modify----end-----------------
   DEFINE l_glap013           LIKE glap_t.glap013
   DEFINE l_last_glapdocno    LIKE glap_t.glapdocno
   DEFINE l_foreign           LIKE type_t.chr1
   DEFINE l_glaa001           LIKE glaa_t.glaa001
   DEFINE l_glap010           LIKE glap_t.glap010
   DEFINE l_glap011           LIKE glap_t.glap011
   DEFINE l_glapdocno         LIKE glap_t.glapdocno
   DEFINE l_glad_r            RECORD 
                              glad005   LIKE glad_t.glad005,  #数量/金额管理否
                              glad007   LIKE glad_t.glad007,  #部门管理否
                              glad008   LIKE glad_t.glad008,  #利润成本管理否
                              glad009   LIKE glad_t.glad009,  #区域管理否
                              glad010   LIKE glad_t.glad010,  #客商管理否
                              glad011   LIKE glad_t.glad011,  #客群管理否
                              glad012   LIKE glad_t.glad012,  #产品类别管理否
                              glad013   LIKE glad_t.glad013,  #人员管理否
                              glad014   LIKE glad_t.glad014,  #预算管理否
                              glad015   LIKE glad_t.glad015,  #专案管理否
                              glad016   LIKE glad_t.glad016,  #WBS管理否
                              glad017   LIKE glad_t.glad017,  #自由核算项1管理否
                              glad018   LIKE glad_t.glad018,  #自由核算项2管理否
                              glad019   LIKE glad_t.glad019,  #自由核算项3管理否
                              glad020   LIKE glad_t.glad020,  #自由核算项4管理否
                              glad021   LIKE glad_t.glad021,  #自由核算项5管理否
                              glad022   LIKE glad_t.glad022,  #自由核算项6管理否
                              glad023   LIKE glad_t.glad023,  #自由核算项7管理否
                              glad024   LIKE glad_t.glad024,  #自由核算项8管理否
                              glad025   LIKE glad_t.glad025,  #自由核算项9管理否
                              glad026   LIKE glad_t.glad026   #自由核算项10管理否                        
                              END RECORD
   DEFINE l_tmp               RECORD 
                              docno    LIKE glaq_t.glaqdocno,
                              docdt    LIKE glap_t.glapdocdt,
                              sw       LIKE type_t.chr1,       #1.借  2.贷
                              glaqent  LIKE glaq_t.glaqent,  
                              glaqcomp LIKE glaq_t.glaqcomp, 
                              glaqld   LIKE glaq_t.glaqld,   
                              glaq001  LIKE glaq_t.glaq001,  
                              glaq002  LIKE glaq_t.glaq002,  
                              glaq005  LIKE glaq_t.glaq005,  
                              glaq006  LIKE glaq_t.glaq006,  
                              glaq007  LIKE glaq_t.glaq007,  
                              glaq009  LIKE glaq_t.glaq009,  
#                              glaq010  LIKE glaq_t.glaq010,  #20141106 MARK
                              glaq011  LIKE glaq_t.glaq011,  
                              glaq012  LIKE glaq_t.glaq012,  
                              glaq013  LIKE glaq_t.glaq013,  
                              glaq014  LIKE glaq_t.glaq014,  
                              glaq015  LIKE glaq_t.glaq015,  
                              glaq016  LIKE glaq_t.glaq016,  
                              glaq017  LIKE glaq_t.glaq017,  
                              glaq018  LIKE glaq_t.glaq018,  
                              glaq019  LIKE glaq_t.glaq019,  
                              glaq020  LIKE glaq_t.glaq020,  
                              glaq021  LIKE glaq_t.glaq021,  
                              glaq022  LIKE glaq_t.glaq022,  
                              glaq023  LIKE glaq_t.glaq023,  
                              glaq024  LIKE glaq_t.glaq024,  
                              glaq025  LIKE glaq_t.glaq025,  
                             #glaq026  LIKE glaq_t.glaq026,  
                              glaq027  LIKE glaq_t.glaq027,  
                              glaq028  LIKE glaq_t.glaq028,  
                              glaq051  LIKE glaq_t.glaq051,  #經營方式
                              glaq052  LIKE glaq_t.glaq052,  #渠道
                              glaq053  LIKE glaq_t.glaq053,  #品牌
                              glaq029  LIKE glaq_t.glaq029,  
                              glaq030  LIKE glaq_t.glaq030,  
                              glaq031  LIKE glaq_t.glaq031,  
                              glaq032  LIKE glaq_t.glaq032,  
                              glaq033  LIKE glaq_t.glaq033,  
                              glaq034  LIKE glaq_t.glaq034,  
                              glaq035  LIKE glaq_t.glaq035,  
                              glaq036  LIKE glaq_t.glaq036,  
                              glaq037  LIKE glaq_t.glaq037,  
                              glaq038  LIKE glaq_t.glaq038,   
                              d        LIKE glaq_t.glaq003,  
                              c        LIKE glaq_t.glaq004,  
                              qty      LIKE glaq_t.glaq008,  
                              sum      LIKE glaq_t.glaq010,
                              glaq039  LIKE glaq_t.glaq039,
                              glaq040  LIKE glaq_t.glaq040,
                              glaq041  LIKE glaq_t.glaq041,
                              glaq042  LIKE glaq_t.glaq042,
                              glaq043  LIKE glaq_t.glaq043,
                              glaq044  LIKE glaq_t.glaq044,
                              seq      LIKE glaq_t.glaqseq,
                              source   LIKE type_t.chr100,
                              glaqseq  LIKE glaq_t.glaqseq,
                              xrca039  LIKE xrca_t.xrca039                              
                              END RECORD
   DEFINE l_success           LIKE type_t.num5 #170103-00019#11 add
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   CASE p_sum_type
        WHEN '1'  LET l_value = p_docno
        WHEN '2'  LET l_value = p_docdt
#        WHEN '3'  LET l_value = p_glaq022
   END CASE
   
   SELECT glaa001 INTO l_glaa001 FROM glaa_t WHERE glaald = p_glaqld AND glaaent=g_enterprise #160905-00007#1 add
   
   LET l_glap013 = 0  #附件张数
   LET l_foreign = 'N' #外币凭证否
   
   INITIALIZE l_tmp.* TO NULL
   LET l_last_glapdocno = NULL
   
   FOREACH afap280_01_gen_ar_2_cs9 USING l_value INTO l_tmp.*
      IF SQLCA.sqlcode THEN  
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'afap280_01_gen_ar_2_cs9'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF   
      INITIALIZE l_glaq.* TO NULL
      
      
      IF l_foreign = 'N' THEN
         IF l_tmp.glaq005 <> l_glaa001 THEN
            LET l_foreign = 'Y'
         END IF
      END IF
      
      LET l_glaq.glaqent   = l_tmp.glaqent    #企業代碼
      LET l_glaq.glaqcomp  = l_tmp.glaqcomp   #法人
      LET l_glaq.glaqld    = p_glaqld         #帳別
      LET l_glaq.glaqdocno = p_glapdocno      #單號
      #项次
      SELECT MAX(glaqseq) + 1 INTO l_glaq.glaqseq
        FROM glaq_t
       WHERE glaqent   = l_glaq.glaqent
         AND glaqld    = l_glaq.glaqld
         AND glaqdocno = l_glaq.glaqdocno
      IF cl_null(l_glaq.glaqseq) THEN
         LET l_glaq.glaqseq = 1
      END IF
      LET l_glaq.glaq001   = l_tmp.glaq001    #摘要
      LET l_glaq.glaq002   = l_tmp.glaq002    #科目編號
      LET l_glaq.glaq003   = l_tmp.d          #借方金額
      LET l_glaq.glaq004   = l_tmp.c          #貸方金額
      LET l_glaq.glaq005   = l_tmp.glaq005    #交易幣別
      LET l_glaq.glaq006   = l_tmp.glaq006    #匯率
      LET l_glaq.glaq007   = l_tmp.glaq007    #計價單位
      LET l_glaq.glaq008   = l_tmp.qty        #數量
      LET l_glaq.glaq009   = l_tmp.glaq009    #單價
      LET l_glaq.glaq010   = l_tmp.sum        #原幣金額
      LET l_glaq.glaq011   = l_tmp.glaq011    #票據編碼
      LET l_glaq.glaq012   = l_tmp.glaq012    #票據日期
      LET l_glaq.glaq013   = l_tmp.glaq013    #申請人
      LET l_glaq.glaq014   = l_tmp.glaq014    #銀行帳號
      LET l_glaq.glaq015   = l_tmp.glaq015    #結算方式
      LET l_glaq.glaq016   = l_tmp.glaq016    #收支項目
      LET l_glaq.glaq017   = l_tmp.glaq017    #營運據點
      LET l_glaq.glaq018   = l_tmp.glaq018    #部門
      LET l_glaq.glaq019   = l_tmp.glaq019    #利潤/成本中心
      LET l_glaq.glaq020   = l_tmp.glaq020    #區域
      
      #对于同一AR单据,若不同科目中有些做客商管理,有些不做客商管理
      #若在s_voucher_gen_ar_1_upd_tmp中直接对glaq021/glaq022做UPDATE时
      #会导致同一AR拆成两张不同的GL
      #故对glaq021/glaq022的判断放置插入glaq时做
      EXECUTE afap280_01_gen_ar_2_cs6 USING l_glaq.glaq002 INTO l_glad_r.*

#20150109
#      IF l_glad_r.glad010 = 'N' OR cl_null(l_glad_r.glad010) THEN            #客商不管理
#         LET l_glaq.glaq021   = ''              #交易客商
#      ELSE
#         LET l_glaq.glaq021   = l_tmp.glaq021   #交易客商      
#      END IF      
#      IF l_glad_r.glad011 = 'N' OR cl_null(l_glad_r.glad011) THEN            #客群不管理
#         LET l_glaq.glaq022   = ''              #交易客商
#      ELSE
#         LET l_glaq.glaq022   = l_tmp.glaq022   #交易客商      
#      END IF  

      
#      UPDATE afap280_01_fa_tmp SET glaq021 = l_glaq.glaq021,
#                                  glaq022 = l_glaq.glaq022
#       WHERE glaqld  = p_glaqld
#         AND glaq002 = l_glaq.glaq002  
#20150109

      LET l_glaq.glaq023   = l_tmp.glaq023    #客群
      LET l_glaq.glaq024   = l_tmp.glaq024    #產品類別
      LET l_glaq.glaq025   = l_tmp.glaq025    #人員
     #LET l_glaq.glaq026   = l_tmp.glaq026    #預算編號
      LET l_glaq.glaq027   = l_tmp.glaq027    #專案編號
      LET l_glaq.glaq028   = l_tmp.glaq028    #WBS
      LET l_glaq.glaq029   = l_tmp.glaq029    #自由核算項一
      LET l_glaq.glaq030   = l_tmp.glaq030    #自由核算項二
      LET l_glaq.glaq031   = l_tmp.glaq031    #自由核算項三
      LET l_glaq.glaq032   = l_tmp.glaq032    #自由核算項四
      LET l_glaq.glaq033   = l_tmp.glaq033    #自由核算項五
      LET l_glaq.glaq034   = l_tmp.glaq034    #自由核算項六
      LET l_glaq.glaq035   = l_tmp.glaq035    #自由核算項七
      LET l_glaq.glaq036   = l_tmp.glaq036    #自由核算項八
      LET l_glaq.glaq037   = l_tmp.glaq037    #自由核算項九
      LET l_glaq.glaq038   = l_tmp.glaq038    #自由核算項十
      
      LET l_glaq.glaq039   = l_tmp.glaq039
      LET l_glaq.glaq040   = l_tmp.glaq040
      LET l_glaq.glaq041   = l_tmp.glaq041
      LET l_glaq.glaq042   = l_tmp.glaq042
      LET l_glaq.glaq043   = l_tmp.glaq043
      LET l_glaq.glaq044   = l_tmp.glaq044
      
      #20150206 add by chenying
      #核算项如果没值,给个空格 
      IF l_glaq.glaq018 IS NULL THEN LET l_glaq.glaq018 = ' ' END IF
      IF l_glaq.glaq019 IS NULL THEN LET l_glaq.glaq019 = ' ' END IF
      IF l_glaq.glaq020 IS NULL THEN LET l_glaq.glaq020 = ' ' END IF
      IF l_glaq.glaq021 IS NULL THEN LET l_glaq.glaq021 = ' ' END IF
      IF l_glaq.glaq022 IS NULL THEN LET l_glaq.glaq022 = ' ' END IF
      IF l_glaq.glaq023 IS NULL THEN LET l_glaq.glaq023 = ' ' END IF
      IF l_glaq.glaq024 IS NULL THEN LET l_glaq.glaq024 = ' ' END IF
      IF l_glaq.glaq025 IS NULL THEN LET l_glaq.glaq025 = ' ' END IF
      IF l_glaq.glaq027 IS NULL THEN LET l_glaq.glaq027 = ' ' END IF
      IF l_glaq.glaq028 IS NULL THEN LET l_glaq.glaq028 = ' ' END IF
      IF l_glaq.glaq051 IS NULL THEN LET l_glaq.glaq051 = ' ' END IF
      IF l_glaq.glaq052 IS NULL THEN LET l_glaq.glaq052 = ' ' END IF
      IF l_glaq.glaq053 IS NULL THEN LET l_glaq.glaq053 = ' ' END IF
      IF l_glaq.glaq029 IS NULL THEN LET l_glaq.glaq029 = ' ' END IF
      IF l_glaq.glaq030 IS NULL THEN LET l_glaq.glaq030 = ' ' END IF
      IF l_glaq.glaq031 IS NULL THEN LET l_glaq.glaq031 = ' ' END IF
      IF l_glaq.glaq032 IS NULL THEN LET l_glaq.glaq032 = ' ' END IF
      IF l_glaq.glaq033 IS NULL THEN LET l_glaq.glaq033 = ' ' END IF
      IF l_glaq.glaq034 IS NULL THEN LET l_glaq.glaq034 = ' ' END IF
      IF l_glaq.glaq035 IS NULL THEN LET l_glaq.glaq035 = ' ' END IF
      IF l_glaq.glaq036 IS NULL THEN LET l_glaq.glaq036 = ' ' END IF
      IF l_glaq.glaq037 IS NULL THEN LET l_glaq.glaq037 = ' ' END IF
      IF l_glaq.glaq038 IS NULL THEN LET l_glaq.glaq038 = ' ' END IF
      #20150206 add by chenying
      
      INSERT INTO glaq_t VALUES(l_glaq.*)
      IF SQLCA.sqlcode THEN      
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins glaq'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      
      #170103-00019#11--add--str--
      #插入细项立冲账资料
      LET l_success = TRUE
      CALL s_pre_voucher_insert_glax(l_glaq.*) RETURNING l_success
      IF l_success = FALSE THEN
         RETURN r_success
      END IF
      #170103-00019#11--add--end
      
      #汇总 附件张数 & update 来源单据的"抛转凭证单号"
      IF cl_null(l_last_glapdocno) OR l_last_glapdocno <> l_tmp.docno THEN
         LET l_glap013 = l_glap013 + l_tmp.xrca039
         
         IF p_sum_type = '1' THEN 
            EXECUTE afap280_01_gen_ar_2_p10 USING p_glapdocno,p_glapdocdt,l_tmp.docno 

            IF SQLCA.sqlcode THEN  
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'execute afap280_01_gen_ar_2_cs10'
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               RETURN r_success
            END IF         
         END IF
         
         #匯總時沒有單號,所以要把group的字段拿來當條件回寫單號
         LET l_glapdocno = ''
         IF p_sum_type = '2' THEN 
            FOREACH afap280_01_gen_ar_2_cs13 USING p_docdt,g_enterprise,
                                                  l_glaq.glaqcomp,l_glaq.glaqcomp,
                                                  l_glaq.glaq001,l_glaq.glaq001,
                                                  l_glaq.glaq002,l_glaq.glaq002,
                                                  l_glaq.glaq005,l_glaq.glaq005,
                                                  l_glaq.glaq006,l_glaq.glaq006,
                                                  l_glaq.glaq039,l_glaq.glaq039,
                                                  l_glaq.glaq042,l_glaq.glaq042,
                                                  l_glaq.glaq018,l_glaq.glaq018,
                                                  l_glaq.glaq019,l_glaq.glaq019,
                                                  l_glaq.glaq020,l_glaq.glaq020,
                                                  l_glaq.glaq021,l_glaq.glaq021,
                                                  l_glaq.glaq022,l_glaq.glaq022,
                                                  l_glaq.glaq023,l_glaq.glaq023,
                                                  l_glaq.glaq024,l_glaq.glaq024,
                                                  l_glaq.glaq025,l_glaq.glaq025,
                                                 #l_glaq.glaq026,l_glaq.glaq026,
                                                  l_glaq.glaq027,l_glaq.glaq027,
                                                  l_glaq.glaq028,l_glaq.glaq028,
                                                  l_glaq.glaq029,l_glaq.glaq029,
                                                  l_glaq.glaq030,l_glaq.glaq030,
                                                  l_glaq.glaq031,l_glaq.glaq031,
                                                  l_glaq.glaq032,l_glaq.glaq032,
                                                  l_glaq.glaq033,l_glaq.glaq033,
                                                  l_glaq.glaq034,l_glaq.glaq034,
                                                  l_glaq.glaq035,l_glaq.glaq035,
                                                  l_glaq.glaq036,l_glaq.glaq036,
                                                  l_glaq.glaq037,l_glaq.glaq037,
                                                  l_glaq.glaq038,l_glaq.glaq038,
                                                  l_glaq.glaq007,l_glaq.glaq007
                                            INTO l_glapdocno
               EXECUTE afap280_01_gen_ar_2_p10 USING p_glapdocno,p_glapdocdt,l_glapdocno
               
               IF SQLCA.sqlcode THEN  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'execute afap280_01_gen_ar_2_cs10'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  RETURN r_success
               END IF  
            END FOREACH 
         END IF
         
#         IF p_sum_type = '3' THEN 
#            FOREACH afap280_01_gen_ar_2_cs14 USING g_enterprise,
#                                                  l_glaq.glaqcomp,l_glaq.glaqcomp,
#                                                  l_glaq.glaq001,l_glaq.glaq001,
#                                                  l_glaq.glaq002,l_glaq.glaq002,
#                                                  l_glaq.glaq021,l_glaq.glaq021,
#                                                  l_glaq.glaq022,l_glaq.glaq022,
#                                                  l_glaq.glaq005,l_glaq.glaq005,
#                                                  l_glaq.glaq006,l_glaq.glaq006,
#                                                  l_glaq.glaq039,l_glaq.glaq039,
#                                                  l_glaq.glaq042,l_glaq.glaq042,
#                                                  l_glaq.glaq018,l_glaq.glaq018,
#                                                  l_glaq.glaq019,l_glaq.glaq019,
#                                                  l_glaq.glaq020,l_glaq.glaq020,
#                                                  l_glaq.glaq021,l_glaq.glaq021,
#                                                  l_glaq.glaq022,l_glaq.glaq022,
#                                                  l_glaq.glaq023,l_glaq.glaq023,
#                                                  l_glaq.glaq024,l_glaq.glaq024,
#                                                  l_glaq.glaq025,l_glaq.glaq025,
#                                                  l_glaq.glaq026,l_glaq.glaq026,
#                                                  l_glaq.glaq027,l_glaq.glaq027,
#                                                  l_glaq.glaq028,l_glaq.glaq028,
#                                                  l_glaq.glaq029,l_glaq.glaq029,
#                                                  l_glaq.glaq030,l_glaq.glaq030,
#                                                  l_glaq.glaq031,l_glaq.glaq031,
#                                                  l_glaq.glaq032,l_glaq.glaq032,
#                                                  l_glaq.glaq033,l_glaq.glaq033,
#                                                  l_glaq.glaq034,l_glaq.glaq034,
#                                                  l_glaq.glaq035,l_glaq.glaq035,
#                                                  l_glaq.glaq036,l_glaq.glaq036,
#                                                  l_glaq.glaq037,l_glaq.glaq037,
#                                                  l_glaq.glaq038,l_glaq.glaq038,
#                                                  l_glaq.glaq007,l_glaq.glaq007
#                                            INTO l_glapdocno
#                                            
#               EXECUTE afap280_01_gen_ar_2_p10 USING p_glapdocno,l_glapdocno
#               
#               IF SQLCA.sqlcode THEN  
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = 'execute afap280_01_gen_ar_2_p10'
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  
#                  RETURN r_success
#               END IF  
#            END FOREACH        
#         END IF
      END IF
      
   END FOREACH
   
   #一笔凭证处理完毕后,对凭证单头进行更行
   #总借/贷
   SELECT SUM(glaq003),SUM(glaq004) INTO l_glap010,l_glap011
     FROM glaq_t
    WHERE glaqent   = g_enterprise
      AND glaqld    = p_glaqld
      AND glaqdocno = p_glapdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sel glaq'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   IF cl_null(l_glap010) THEN LET l_glap010 = 0 END IF
   IF cl_null(l_glap011) THEN LET l_glap011 = 0 END IF
   
   #附件张数
   UPDATE glap_t SET glap010 = l_glap010,glap011 = l_glap011,glap013 = l_glap013,glap014 = l_foreign
    WHERE glapent   = g_enterprise
      AND glapld    = p_glaqld
      AND glapdocno = p_glapdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd glap_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 修改核算項
# Memo...........:
# Usage..........: CALL afap280_01_s01(p_docno,p_glaq001,p_glaq002,p_ld,p_sum_type)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_s01(p_docno,p_glaq001,p_glaq002,p_ld,p_sum_type)
   DEFINE p_docno       LIKE xrca_t.xrcadocno 
   DEFINE p_glaq001     LIKE glaq_t.glaq001
   DEFINE p_glaq002     LIKE glaq_t.glaq002
   DEFINE p_ld          LIKE glaq_t.glaqld
   DEFINE p_sum_type    LIKE type_t.chr1
   DEFINE l_success     LIKE type_t.num5

   CALL afap280_01_glaq2_fill(p_docno,p_glaq001,p_glaq002)

   OPEN WINDOW w_afap280_s01 WITH FORM cl_ap_formpath("afa","afap280_s01") 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         DISPLAY ARRAY g_glaq2_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b4)   
    
            BEFORE ROW
               LET l_ac4 = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx4 = l_ac4
               DISPLAY g_detail_idx4 TO idx
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx4)
               LET l_ac4 = DIALOG.getCurrentRow("s_detail4")
               DISPLAY g_rec_b4 TO cnt
               CALL cl_set_comp_visible('grid1',FALSE)
               CALL cl_set_act_visible("accept,cancel", FALSE)
               
            ON ACTION modify_detail
               CALL afap280_01_s01_modify(p_ld)
               CONTINUE DIALOG               
               
         END DISPLAY

         ON ACTION close
            LET INT_FLAG = FALSE
            EXIT DIALOG
            
         ON ACTION exit
            LET INT_FLAG = FALSE
            EXIT DIALOG
      END DIALOG


  DELETE FROM afap280_01_voucher_fa_group
  CALL afap280_01_gen_fa_2_ins_group_tmp(p_ld,p_sum_type) RETURNING l_success  
  #畫面關閉
  CLOSE WINDOW w_afap280_s01
END FUNCTION

################################################################################
# Descriptions...: 核算項單身填充
# Memo...........:
# Usage..........: CALL afap280_01_glaq2_fill(p_docno,p_glaq001,p_glaq002)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_glaq2_fill(p_docno,p_glaq001,p_glaq002)
   DEFINE p_docno       LIKE xrca_t.xrcadocno
   DEFINE l_sql         STRING
   DEFINE p_glaq001     LIKE glaq_t.glaq001
   DEFINE p_glaq002     LIKE glaq_t.glaq002
   DEFINE l_n           LIKE type_t.num5

   CALL g_glaq2_d.clear()


   LET l_sql= " SELECT DISTINCT docno,seq,glaq002,'',glaq017,'',glaq018,'',glaq019,'',", 
              "                 glaq020,'',glaq021,'',glaq022,'',glaq023,'',glaq024,'',",
              "                 glaq025,'',glaq027,glaq028,glaq029,'',glaq030,'',",
              "                 glaq031,'',glaq032,'',glaq033,'',glaq034,'',glaq035,'',",
              "                 glaq036,'',glaq037,'',glaq038,'',",
              "                 source,sw,'' ",
              "   FROM afap280_tmp01 ",   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
              "  WHERE docno = '",p_docno,"'"
   IF NOT cl_null(p_glaq002) THEN 
      LET l_sql= l_sql CLIPPED,"  AND glaq002 = '",p_glaq002,"'"
   ELSE
      LET l_sql= l_sql CLIPPED,"  AND glaq002 IS NULL"
   END IF
   
   IF NOT cl_null(p_glaq001) THEN 
      LET l_sql= l_sql CLIPPED,"  AND glaq001 = '",p_glaq001,"'"
   ELSE
      LET l_sql= l_sql CLIPPED,"  AND glaq001 IS NULL"
   END IF
   
   LET l_sql = l_sql CLIPPED,"  ORDER BY docno,seq "
   
   PREPARE glaq2_pre FROM l_sql
   DECLARE glaq2_cur CURSOR FOR glaq2_pre
   

   LET l_ac4 = 1
   FOREACH glaq2_cur INTO g_glaq2_d[l_ac4].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
      LET g_glaq2_d[l_ac4].glaq001 = p_glaq001
      LET l_ac4 = l_ac4 + 1
      IF l_ac4 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET l_ac4=l_ac4 - 1
   CALL g_glaq2_d.deleteElement(g_glaq2_d.getLength())
   
   LET g_rec_b4 = l_ac4
   LET l_ac4 = 1
   CALL afap280_01_s01_show()
END FUNCTION

################################################################################
# Descriptions...: 修改臨時表數據
# Memo...........:
# Usage..........: CALL afap280_01_s01_modify(p_glaqld)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_s01_modify(p_glaqld)
   DEFINE p_glaqld     LIKE glaq_t.glaqld
   DEFINE l_seccess    LIKE type_t.num5
   DEFINE l_errno      LIKE type_t.chr10

  CALL cl_set_comp_visible('grid1',TRUE)
  CALL cl_set_act_visible("accept,cancel", TRUE)
  LET g_errshow = 1
  SELECT glaa004 INTO g_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=p_glaqld
  
  INPUT ARRAY g_glaq2_d FROM s_detail4.*
     ATTRIBUTE(COUNT = g_rec_b4,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
              INSERT ROW = FALSE, 
              DELETE ROW = FALSE,
              APPEND ROW = FALSE)       
     
     BEFORE INPUT 
       LET g_rec_b4 = g_glaq2_d.getLength()
       DISPLAY g_rec_b4 TO FORMONLY.cnt
     
     BEFORE ROW
        LET l_ac4 = ARR_CURR()
        LET g_detail_idx4 = l_ac4
        DISPLAY l_ac4 TO FORMONLY.idx
        LET g_glaq2_d_t.* = g_glaq2_d[l_ac4].*
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
           AND gladld = p_glaqld
           AND glad001 = g_glaq2_d[l_ac4].glaq002
        
     
     BEFORE FIELD glaq002
 
        
     AFTER FIELD glaq002
          IF NOT cl_null(g_glaq2_d[l_ac4].glaq002) THEN 
             #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
             INITIALIZE g_chkparam.* TO NULL    
             #設定g_chkparam.*的參數
             LET g_chkparam.arg1 = g_glaa004
             LET g_chkparam.arg2 = g_glaq2_d[l_ac4].glaq002   
             #160318-00025#1--add--str
             LET g_errshow = TRUE 
             LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
             #160318-00025#1--add--end             
             #呼叫檢查存在並帶值的library
             IF cl_chk_exist("v_glac002_1") THEN
                #檢查成功時後續處理
                #LET  = g_chkparam.return1
                #DISPLAY BY NAME 
             ELSE
                #檢查失敗時後續處理
                LET g_glaq2_d[l_ac4].glaq002 = g_glaq2_d_t.glaq002
                NEXT FIELD CURRENT
             END IF
          END IF  
       
     BEFORE FIELD glaq002_desc
        LET g_glaq2_d[l_ac4].glaq002_desc = g_glaq2_d[l_ac4].glaq002
        
      AFTER FIELD glaq002_desc
         LET g_glaq2_d[l_ac4].glaq002 = g_glaq2_d[l_ac4].glaq002_desc
         CALL afap280_01_glaq002_desc1()
         IF NOT cl_null(g_glaq2_d[l_ac4].glaq002) THEN 
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL    
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_glaa004
            LET g_chkparam.arg2 = g_glaq2_d[l_ac4].glaq002     
            #呼叫檢查存在並帶值的library
            #160318-00025#1--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
            #160318-00025#1--add--end
            IF cl_chk_exist("v_glac002_1") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
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
                 FROM glad_t
                WHERE gladent = g_enterprise
                  AND gladld = p_glaqld
                  AND glad001 = g_glaq2_d[l_ac4].glaq002
            ELSE
               #檢查失敗時後續處理
               LET g_glaq2_d[l_ac4].glaq002 = g_glaq2_d_t.glaq002
               LET g_glaq2_d[l_ac4].glaq002_desc = g_glaq2_d_t.glaq002_desc
               CALL afap280_01_glaq002_desc1()
               NEXT FIELD CURRENT
            END IF
         END IF        
         
      ON ACTION controlp INFIELD glaq002
		   INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
		   LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq002             #給予default值
         LET g_qryparam.where = " glac001 = '",g_glaa004,"' AND glac003 <> '1' AND glac006 = '1'"
         #給予arg
         CALL aglt310_04()                                #呼叫開窗
         LET g_glaq2_d[l_ac4].glaq002 = g_qryparam.return1              #將開窗取得的值回傳到變數
         DISPLAY g_glaq2_d[l_ac4].glaq002 TO glaq002              #顯示到畫面上
         NEXT FIELD glaq002                          #返回原欄位

      ON ACTION controlp INFIELD glaq002_desc
			INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq002             #給予default值
         LET g_qryparam.where = " glac001 = '",g_glaa004,"' AND glac003 <> '1' AND glac006 = '1'"
         #給予arg
         CALL aglt310_04()                                #呼叫開窗
         LET g_glaq2_d[l_ac4].glaq002 = g_qryparam.return1              #將開窗取得的值回傳到變數
         CALL afap280_01_glaq002_desc1()           #顯示到畫面上
         NEXT FIELD glaq002_desc                          #返回原欄位


      BEFORE FIELD glaq017
         
         
      AFTER FIELD glaq017
         CALL afap280_01_ooef001_desc(g_glaq2_d[l_ac4].glaq017) RETURNING g_glaq2_d[l_ac4].glaq017_desc
         IF NOT cl_null(g_glaq2_d[l_ac4].glaq017) THEN 
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq017
            #160318-00025#1--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
            #160318-00025#1--add--end            
            #呼叫檢查存在並帶值的library
            #IF cl_chk_exist("v_ooef001") THEN   #161024-00008#2 
            IF cl_chk_exist("v_ooef001_13") THEN #161024-00008#2 
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
            ELSE
               #檢查失敗時後續處理
               LET g_glaq2_d[l_ac4].glaq017 = g_glaq2_d_t.glaq017
               CALL afap280_01_ooef001_desc(g_glaq2_d[l_ac4].glaq017) RETURNING g_glaq2_d[l_ac4].glaq017_desc
               NEXT FIELD CURRENT
            END IF
         END IF  
         DISPLAY BY NAME g_glaq2_d[l_ac4].glaq017_desc
         
      BEFORE FIELD glaq017_desc
          LET g_glaq2_d[l_ac4].glaq017_desc = g_glaq2_d[l_ac4].glaq017
          
      AFTER FIELD glaq017_desc
         LET g_glaq2_d[l_ac4].glaq017 = g_glaq2_d[l_ac4].glaq017_desc
         IF NOT cl_null(g_glaq2_d[l_ac4].glaq017) THEN 
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq017 
            #160318-00025#1--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
            #160318-00025#1--add--end            
            #呼叫檢查存在並帶值的library
            #IF cl_chk_exist("v_ooef001") THEN    #161024-00008#2  
             IF cl_chk_exist("v_ooef001_13") THEN #161024-00008#2  
            
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
            ELSE
               #檢查失敗時後續處理
               LET g_glaq2_d[l_ac4].glaq017 = g_glaq2_d_t.glaq017
               CALL afap280_01_ooef001_desc(g_glaq2_d[l_ac4].glaq017) RETURNING g_glaq2_d[l_ac4].glaq017_desc
               LET g_glaq2_d[l_ac4].glaq017_desc=g_glaq2_d[l_ac4].glaq017,g_glaq2_d[l_ac4].glaq017_desc
               DISPLAY g_glaq2_d[l_ac4].glaq017_desc TO s_detail4[l_ac4].glaq017_desc
               NEXT FIELD CURRENT
            END IF
         END IF
         CALL afap280_01_ooef001_desc(g_glaq2_d[l_ac4].glaq017) RETURNING g_glaq2_d[l_ac4].glaq017_desc
         LET g_glaq2_d[l_ac4].glaq017_desc=g_glaq2_d[l_ac4].glaq017,g_glaq2_d[l_ac4].glaq017_desc
         DISPLAY g_glaq2_d[l_ac4].glaq017_desc TO s_detail4[l_ac4].glaq017_desc

       BEFORE FIELD glaq018
          
       AFTER FIELD glaq018
          
          IF NOT cl_null(g_glaq2_d[l_ac4].glaq018) THEN 
             #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
             INITIALIZE g_chkparam.* TO NULL          
             #設定g_chkparam.*的參數
             LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq018
             LET g_chkparam.arg2 = g_today
             #160318-00025#1--add--str
             LET g_errshow = TRUE 
             LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
             #160318-00025#1--add--end             
             #呼叫檢查存在並帶值的library
             IF cl_chk_exist("v_ooeg001") THEN
                #檢查成功時後續處理
                #LET  = g_chkparam.return1
                #DISPLAY BY NAME 
             ELSE
                #檢查失敗時後續處理
                LET g_glaq2_d[l_ac4].glaq018 = g_glaq2_d_t.glaq018
                NEXT FIELD CURRENT
             END IF          
          END IF 
          
      BEFORE FIELD glaq018_desc
         LET g_glaq2_d[l_ac4].glaq018_desc = g_glaq2_d[l_ac4].glaq018
         
      AFTER FIELD glaq018_desc
         LET g_glaq2_d[l_ac4].glaq018 = g_glaq2_d[l_ac4].glaq018_desc
         IF NOT cl_null(g_glaq2_d[l_ac4].glaq018) THEN 
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL          
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq018
            LET g_chkparam.arg2 = g_today
            #160318-00025#1--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
            #160318-00025#1--add--end            
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_ooeg001") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
            ELSE
               #檢查失敗時後續處理
               LET g_glaq2_d[l_ac4].glaq018 = g_glaq2_d_t.glaq018
               CALL afap280_01_ooef001_desc(g_glaq2_d[l_ac4].glaq018) RETURNING g_glaq2_d[l_ac4].glaq018_desc
               LET g_glaq2_d[l_ac4].glaq018_desc=g_glaq2_d[l_ac4].glaq018,g_glaq2_d[l_ac4].glaq018_desc
               DISPLAY g_glaq2_d[l_ac4].glaq018_desc TO s_detail4[l_ac4].glaq018_desc
               NEXT FIELD CURRENT
            END IF          
         END IF 
         CALL afap280_01_ooef001_desc(g_glaq2_d[l_ac4].glaq018) RETURNING g_glaq2_d[l_ac4].glaq018_desc
         LET g_glaq2_d[l_ac4].glaq018_desc=g_glaq2_d[l_ac4].glaq018,g_glaq2_d[l_ac4].glaq018_desc
         DISPLAY g_glaq2_d[l_ac4].glaq018_desc TO s_detail4[l_ac4].glaq018_desc
         
       BEFORE FIELD glaq019
          
       AFTER FIELD glaq019
            
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq019) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL              
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq019
               LET g_chkparam.arg2 = g_today 
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#1--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_glaq2_d[l_ac4].glaq019 = g_glaq2_d_t.glaq019
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
      BEFORE FIELD glaq019_desc
         LET g_glaq2_d[l_ac4].glaq019_desc = g_glaq2_d[l_ac4].glaq019
      AFTER FIELD glaq019_desc
         LET g_glaq2_d[l_ac4].glaq019 = g_glaq2_d[l_ac4].glaq019_desc
         IF NOT cl_null(g_glaq2_d[l_ac4].glaq019) THEN 
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL              
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq019
            LET g_chkparam.arg2 = g_today  
            #160318-00025#1--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
            #160318-00025#1--add--end            
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_ooeg001") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
            ELSE
               #檢查失敗時後續處理
               LET g_glaq2_d[l_ac4].glaq019 = g_glaq2_d_t.glaq019
               CALL afap280_01_ooef001_desc(g_glaq2_d[l_ac4].glaq019) RETURNING g_glaq2_d[l_ac4].glaq019_desc
               LET g_glaq2_d[l_ac4].glaq019_desc=g_glaq2_d[l_ac4].glaq019,g_glaq2_d[l_ac4].glaq019_desc
               DISPLAY g_glaq2_d[l_ac4].glaq019_desc TO s_detail4[l_ac4].glaq019_desc
               NEXT FIELD CURRENT
            END IF
         END IF      
         CALL afap280_01_ooef001_desc(g_glaq2_d[l_ac4].glaq019) RETURNING g_glaq2_d[l_ac4].glaq019_desc
         LET g_glaq2_d[l_ac4].glaq019_desc=g_glaq2_d[l_ac4].glaq019,g_glaq2_d[l_ac4].glaq019_desc
         DISPLAY g_glaq2_d[l_ac4].glaq019_desc TO s_detail4[l_ac4].glaq019_desc

      BEFORE FIELD glaq020
          
      AFTER FIELD glaq020
         
         IF NOT cl_null(g_glaq2_d[l_ac4].glaq020) THEN 
            #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            INITIALIZE g_chkparam.* TO NULL            
            #設定g_chkparam.*的參數
            LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq020 
            #160318-00025#1--add--str
            LET g_errshow = TRUE 
            LET g_chkparam.err_str[1] = "axm-00004:sub-01302|axmi027|",cl_get_progname("axmi027",g_lang,"2"),"|:EXEPROGaxmi027"
            #160318-00025#1--add--end             
            #呼叫檢查存在並帶值的library
            IF cl_chk_exist("v_oocq002_287") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
            ELSE
               #檢查失敗時後續處理
               LET g_glaq2_d[l_ac4].glaq020 = g_glaq2_d_t.glaq020
               NEXT FIELD CURRENT
            END IF
         END IF 
            
      BEFORE FIELD glaq020_desc
         LET g_glaq2_d[l_ac4].glaq020_desc = g_glaq2_d[l_ac4].glaq020
      AFTER FIELD glaq020_desc
           LET g_glaq2_d[l_ac4].glaq020 = g_glaq2_d[l_ac4].glaq020_desc
           CALL afap280_01_glaq020_desc('287',g_glaq2_d[l_ac4].glaq020) RETURNING g_glaq2_d[l_ac4].glaq020_desc
           LET g_glaq2_d[l_ac4].glaq020_desc=g_glaq2_d[l_ac4].glaq020,g_glaq2_d[l_ac4].glaq020_desc
           DISPLAY g_glaq2_d[l_ac4].glaq020_desc TO s_detail4[l_ac4].glaq020_desc
           IF NOT cl_null(g_glaq2_d[l_ac4].glaq020) THEN 
              #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
              INITIALIZE g_chkparam.* TO NULL            
              #設定g_chkparam.*的參數
              LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq020 
              #160318-00025#1--add--str
              LET g_errshow = TRUE 
              LET g_chkparam.err_str[1] = "axm-00004:sub-01302|axmi027|",cl_get_progname("axmi027",g_lang,"2"),"|:EXEPROGaxmi027"
              #160318-00025#1--add--end              
              #呼叫檢查存在並帶值的library
              IF cl_chk_exist("v_oocq002_287") THEN
                 #檢查成功時後續處理
                 #LET  = g_chkparam.return1
                 #DISPLAY BY NAME 
              ELSE
                 #檢查失敗時後續處理
                 LET g_glaq2_d[l_ac4].glaq020 = g_glaq2_d_t.glaq020
                 CALL afap280_01_glaq020_desc('287',g_glaq2_d[l_ac4].glaq020) RETURNING g_glaq2_d[l_ac4].glaq020_desc
                 LET g_glaq2_d[l_ac4].glaq020_desc=g_glaq2_d[l_ac4].glaq020,g_glaq2_d[l_ac4].glaq020_desc
                 DISPLAY g_glaq2_d[l_ac4].glaq020_desc TO s_detail4[l_ac4].glaq020_desc
                 NEXT FIELD CURRENT
              END IF
           END IF 
            
       BEFORE FIELD glaq021
          
       AFTER FIELD glaq021
            
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq021) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq021
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#1--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN

               ELSE
                  #檢查失敗時後續處理
                  LET g_glaq2_d[l_ac4].glaq021 = g_glaq2_d_t.glaq021
                  NEXT FIELD CURRENT
               END IF               
            END IF   

       BEFORE FIELD glaq021_desc
          LET g_glaq2_d[l_ac4].glaq021_desc = g_glaq2_d[l_ac4].glaq021
          
       AFTER FIELD glaq021_desc 
            LET g_glaq2_d[l_ac4].glaq021 = g_glaq2_d[l_ac4].glaq021_desc
            CALL afap280_01_glaq021_desc(g_glaq2_d[l_ac4].glaq021) RETURNING g_glaq2_d[l_ac4].glaq021_desc
            LET g_glaq2_d[l_ac4].glaq021_desc=g_glaq2_d[l_ac4].glaq021,g_glaq2_d[l_ac4].glaq021_desc
            DISPLAY g_glaq2_d[l_ac4].glaq021_desc TO s_detail4[l_ac4].glaq021_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq021) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq021
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#1--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN

               ELSE
                  #檢查失敗時後續處理
                  LET g_glaq2_d[l_ac4].glaq021 = g_glaq2_d_t.glaq021
                  CALL afap280_01_glaq021_desc(g_glaq2_d[l_ac4].glaq021) RETURNING g_glaq2_d[l_ac4].glaq021_desc
                  LET g_glaq2_d[l_ac4].glaq021_desc=g_glaq2_d[l_ac4].glaq021,g_glaq2_d[l_ac4].glaq021_desc
                  DISPLAY g_glaq2_d[l_ac4].glaq021_desc TO s_detail4[l_ac4].glaq021_desc
                  NEXT FIELD CURRENT
               END IF               
            END IF 
       
       BEFORE FIELD glaq022
          
       AFTER FIELD glaq022
            
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq022) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL          
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq022 
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#1--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_glaq2_d[l_ac4].glaq022 = g_glaq2_d_t.glaq022
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
       BEFORE FIELD glaq022_desc
          LET g_glaq2_d[l_ac4].glaq022_desc = g_glaq2_d[l_ac4].glaq022
          
       AFTER FIELD glaq022_desc
            LET g_glaq2_d[l_ac4].glaq022 = g_glaq2_d[l_ac4].glaq022_desc
            CALL afap280_01_glaq021_desc(g_glaq2_d[l_ac4].glaq022) RETURNING g_glaq2_d[l_ac4].glaq022_desc
            LET g_glaq2_d[l_ac4].glaq022_desc=g_glaq2_d[l_ac4].glaq022,g_glaq2_d[l_ac4].glaq022_desc
            DISPLAY g_glaq2_d[l_ac4].glaq021_desc TO s_detail4[l_ac4].glaq021_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq022) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL          
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq022 
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#1--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_glaq2_d[l_ac4].glaq022 = g_glaq2_d_t.glaq022
                  CALL afap280_01_glaq021_desc(g_glaq2_d[l_ac4].glaq022) RETURNING g_glaq2_d[l_ac4].glaq022_desc
                  LET g_glaq2_d[l_ac4].glaq022_desc=g_glaq2_d[l_ac4].glaq022,g_glaq2_d[l_ac4].glaq022_desc
                  DISPLAY g_glaq2_d[l_ac4].glaq021_desc TO s_detail4[l_ac4].glaq021_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
       BEFORE FIELD glaq023
          
       AFTER FIELD glaq023
            
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq023) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL        
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq023 
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00093:sub-01302|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"
               LET g_chkparam.err_str[2] = "apm-00092:sub-01303|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"
               #160318-00025#1--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_281") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_glaq2_d[l_ac4].glaq023 = g_glaq2_d_t.glaq023
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
            
       BEFORE FIELD glaq023_desc
          LET g_glaq2_d[l_ac4].glaq023_desc = g_glaq2_d[l_ac4].glaq023
          
       AFTER FIELD glaq023_desc
            LET g_glaq2_d[l_ac4].glaq023 = g_glaq2_d[l_ac4].glaq023_desc
            CALL afap280_01_glaq020_desc('281',g_glaq2_d[l_ac4].glaq023) RETURNING g_glaq2_d[l_ac4].glaq023_desc
            LET g_glaq2_d[l_ac4].glaq023_desc=g_glaq2_d[l_ac4].glaq023,g_glaq2_d[l_ac4].glaq023_desc
            DISPLAY g_glaq2_d[l_ac4].glaq023_desc TO s_detail4[l_ac4].glaq023_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq023) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL        
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq023
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00093:sub-01302|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"
               LET g_chkparam.err_str[2] = "apm-00092:sub-01303|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"
               #160318-00025#1--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_281") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_glaq2_d[l_ac4].glaq023 = g_glaq2_d_t.glaq023
                  CALL afap280_01_glaq020_desc('281',g_glaq2_d[l_ac4].glaq023) RETURNING g_glaq2_d[l_ac4].glaq023_desc
                  LET g_glaq2_d[l_ac4].glaq023_desc=g_glaq2_d[l_ac4].glaq023,g_glaq2_d[l_ac4].glaq023_desc
                  DISPLAY g_glaq2_d[l_ac4].glaq023_desc TO s_detail4[l_ac4].glaq023_desc
                  NEXT FIELD CURRENT
               END IF
            END IF      
            
            
       BEFORE FIELD glaq024

       AFTER FIELD glaq024
            
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq024) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL    
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq024
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"
               #160318-00025#1--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_glaq2_d[l_ac4].glaq024 = g_glaq2_d_t.glaq024
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
       BEFORE FIELD glaq024_desc
          LET g_glaq2_d[l_ac4].glaq024_desc = g_glaq2_d[l_ac4].glaq024
          
       AFTER FIELD glaq024_desc
            LET g_glaq2_d[l_ac4].glaq024 = g_glaq2_d[l_ac4].glaq024_desc
            CALL afap280_01_glaq024_desc(g_glaq2_d[l_ac4].glaq024) RETURNING g_glaq2_d[l_ac4].glaq024_desc
            LET g_glaq2_d[l_ac4].glaq024_desc=g_glaq2_d[l_ac4].glaq024,g_glaq2_d[l_ac4].glaq024_desc
            DISPLAY g_glaq2_d[l_ac4].glaq024_desc TO s_detail4[l_ac4].glaq024_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq024) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL    
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq024
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"
               #160318-00025#1--add--end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_glaq2_d[l_ac4].glaq024 = g_glaq2_d_t.glaq024
                  CALL afap280_01_glaq024_desc(g_glaq2_d[l_ac4].glaq024) RETURNING g_glaq2_d[l_ac4].glaq024_desc
                  LET g_glaq2_d[l_ac4].glaq024_desc=g_glaq2_d[l_ac4].glaq024,g_glaq2_d[l_ac4].glaq024_desc
                  DISPLAY g_glaq2_d[l_ac4].glaq024_desc TO s_detail4[l_ac4].glaq024_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
            
       BEFORE FIELD glaq025
          
       AFTER FIELD glaq025
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq025) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq025
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#1--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_glaq2_d[l_ac4].glaq025 = g_glaq2_d_t.glaq025
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
       BEFORE FIELD glaq025_desc
          LET g_glaq2_d[l_ac4].glaq025_desc = g_glaq2_d[l_ac4].glaq025
          
       AFTER FIELD glaq025_desc
            LET g_glaq2_d[l_ac4].glaq025 = g_glaq2_d[l_ac4].glaq025_desc
            CALL afap280_01_glaq025_desc(g_glaq2_d[l_ac4].glaq025) RETURNING g_glaq2_d[l_ac4].glaq025_desc
            LET g_glaq2_d[l_ac4].glaq025_desc=g_glaq2_d[l_ac4].glaq025,g_glaq2_d[l_ac4].glaq025_desc
            DISPLAY g_glaq2_d[l_ac4].glaq025_desc TO s_detail4[l_ac4].glaq025_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq025) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq025
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#1--add--end
               #呼叫檢查存在並帶值的library
              
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_glaq2_d[l_ac4].glaq025 = g_glaq2_d_t.glaq025
                  CALL afap280_01_glaq025_desc(g_glaq2_d[l_ac4].glaq025) RETURNING g_glaq2_d[l_ac4].glaq025_desc
                  LET g_glaq2_d[l_ac4].glaq025_desc=g_glaq2_d[l_ac4].glaq025,g_glaq2_d[l_ac4].glaq025_desc
                  DISPLAY g_glaq2_d[l_ac4].glaq025_desc TO s_detail4[l_ac4].glaq025_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
#       BEFORE FIELD glaq026
#          
#       AFTER FIELD glaq026
#            
#            IF NOT cl_null(g_glaq2_d[l_ac4].glaq026) THEN 
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL      
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq026        
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_bgaa001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_glaq2_d[l_ac4].glaq026 = g_glaq2_d_t.glaq026
#                  NEXT FIELD CURRENT
#               END IF
#            END IF 
#            
#       BEFORE FIELD glaq026_desc
#          LET g_glaq2_d[l_ac4].glaq026_desc = g_glaq2_d[l_ac4].glaq026
#          
#       AFTER FIELD glaq026_desc
#            LET g_glaq2_d[l_ac4].glaq026 = g_glaq2_d[l_ac4].glaq026_desc
#            CALL afap280_01_glaq026_desc(g_glaq2_d[l_ac4].glaq026) RETURNING g_glaq2_d[l_ac4].glaq026_desc
#            LET g_glaq2_d[l_ac4].glaq026_desc=g_glaq2_d[l_ac4].glaq026,g_glaq2_d[l_ac4].glaq026_desc
#            DISPLAY g_glaq2_d[l_ac4].glaq026_desc TO s_detail4[l_ac4].glaq026_desc
#            IF NOT cl_null(g_glaq2_d[l_ac4].glaq026) THEN 
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL      
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_glaq2_d[l_ac4].glaq026        
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_bgaa001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_glaq2_d[l_ac4].glaq026 = g_glaq2_d_t.glaq026
#                  CALL afap280_01_glaq026_desc(g_glaq2_d[l_ac4].glaq026) RETURNING g_glaq2_d[l_ac4].glaq026_desc
#                  LET g_glaq2_d[l_ac4].glaq026_desc=g_glaq2_d[l_ac4].glaq026,g_glaq2_d[l_ac4].glaq026_desc
#                  DISPLAY g_glaq2_d[l_ac4].glaq026_desc TO s_detail4[l_ac4].glaq026_desc
#                  NEXT FIELD CURRENT
#               END IF
#            END IF 
            
       BEFORE FIELD glaq027
       AFTER FIELD glaq027

       BEFORE FIELD glaq028
       AFTER FIELD glaq028
       
            
       BEFORE FIELD glaq029_desc
          LET g_glaq2_d[l_ac4].glaq029_desc = g_glaq2_d[l_ac4].glaq029
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
          
       AFTER FIELD glaq029_desc
            LET g_glaq2_d[l_ac4].glaq029 = g_glaq2_d[l_ac4].glaq029_desc
            DISPLAY '' TO glaq029_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq029) THEN
               CALL afap280_01_free_account_chk(g_glad0171,g_glaq2_d[l_ac4].glaq029,g_glad0172) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq2_d[l_ac4].glaq029
                  #160318-00005#9   --add--str
                  LET g_errparam.replace[1] ='agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog    ='agli041'
                  #160318-00005#9   --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq2_d[l_ac4].glaq029 = g_glaq2_d_t.glaq029
                  LET g_glaq2_d[l_ac4].glaq029_desc = g_glaq2_d_t.glaq029_desc
                  CALL afap280_01_free_account_desc()
                  DISPLAY g_glaq2_d[l_ac4].glaq029_desc TO s_detail4[l_ac4].glaq029_desc
                  NEXT FIELD glaq029_desc
               END IF
            END IF
            CALL afap280_01_free_account_desc()
            DISPLAY g_glaq2_d[l_ac4].glaq029_desc TO s_detail4[l_ac4].glaq029_desc
            
      BEFORE FIELD glaq030_desc
          LET g_glaq2_d[l_ac4].glaq030_desc = g_glaq2_d[l_ac4].glaq030
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
          
       AFTER FIELD glaq030_desc
            LET g_glaq2_d[l_ac4].glaq030 = g_glaq2_d[l_ac4].glaq030_desc
            DISPLAY '' TO glaq030_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq030) THEN
               CALL afap280_01_free_account_chk(g_glad0181,g_glaq2_d[l_ac4].glaq030,g_glad0182) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq2_d[l_ac4].glaq030
                  #160318-00005#9   --add--str
                  LET g_errparam.replace[1] ='agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog    ='agli041'
                  #160318-00005#9   --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq2_d[l_ac4].glaq030 = g_glaq2_d_t.glaq030
                  LET g_glaq2_d[l_ac4].glaq030_desc = g_glaq2_d_t.glaq030_desc
                  CALL afap280_01_free_account_desc()
                  DISPLAY g_glaq2_d[l_ac4].glaq030_desc TO s_detail4[l_ac4].glaq030_desc
                  NEXT FIELD glaq030_desc
               END IF
            END IF
            CALL afap280_01_free_account_desc()
            DISPLAY g_glaq2_d[l_ac4].glaq030_desc TO s_detail4[l_ac4].glaq030_desc
            
      BEFORE FIELD glaq031_desc
          LET g_glaq2_d[l_ac4].glaq031_desc = g_glaq2_d[l_ac4].glaq031
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
          
       AFTER FIELD glaq031_desc
            LET g_glaq2_d[l_ac4].glaq031 = g_glaq2_d[l_ac4].glaq031_desc
            DISPLAY '' TO glaq031_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq031) THEN
               CALL afap280_01_free_account_chk(g_glad0191,g_glaq2_d[l_ac4].glaq031,g_glad0192) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq2_d[l_ac4].glaq031
                  #160318-00005#9   --add--str
                  LET g_errparam.replace[1] ='agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog    ='agli041'
                  #160318-00005#9   --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq2_d[l_ac4].glaq031 = g_glaq2_d_t.glaq031
                  LET g_glaq2_d[l_ac4].glaq031_desc = g_glaq2_d_t.glaq031_desc
                  CALL afap280_01_free_account_desc()
                  DISPLAY g_glaq2_d[l_ac4].glaq031_desc TO s_detail4[l_ac4].glaq031_desc
                  NEXT FIELD glaq031_desc
               END IF
            END IF
            CALL afap280_01_free_account_desc()
            DISPLAY g_glaq2_d[l_ac4].glaq031_desc TO s_detail4[l_ac4].glaq031_desc
            
      BEFORE FIELD glaq032_desc
          LET g_glaq2_d[l_ac4].glaq032_desc = g_glaq2_d[l_ac4].glaq032
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
          
       AFTER FIELD glaq032_desc
            LET g_glaq2_d[l_ac4].glaq032 = g_glaq2_d[l_ac4].glaq032_desc
            DISPLAY '' TO glaq032_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq032) THEN
               CALL afap280_01_free_account_chk(g_glad0201,g_glaq2_d[l_ac4].glaq032,g_glad0202) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq2_d[l_ac4].glaq032
                  #160318-00005#9   --add--str
                  LET g_errparam.replace[1] ='agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog    ='agli041'
                  #160318-00005#9   --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq2_d[l_ac4].glaq032 = g_glaq2_d_t.glaq032
                  LET g_glaq2_d[l_ac4].glaq032_desc = g_glaq2_d_t.glaq032_desc
                  CALL afap280_01_free_account_desc()
                  DISPLAY g_glaq2_d[l_ac4].glaq032_desc TO s_detail4[l_ac4].glaq032_desc
                  NEXT FIELD glaq032_desc
               END IF
            END IF
            CALL afap280_01_free_account_desc()
            DISPLAY g_glaq2_d[l_ac4].glaq032_desc TO s_detail4[l_ac4].glaq032_desc      
      
      BEFORE FIELD glaq033_desc
          LET g_glaq2_d[l_ac4].glaq033_desc = g_glaq2_d[l_ac4].glaq033
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
          
       AFTER FIELD glaq033_desc
            LET g_glaq2_d[l_ac4].glaq033 = g_glaq2_d[l_ac4].glaq033_desc
            DISPLAY '' TO glaq033_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq033) THEN
               CALL afap280_01_free_account_chk(g_glad0211,g_glaq2_d[l_ac4].glaq033,g_glad0212) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq2_d[l_ac4].glaq033
                  #160318-00005#9   --add--str
                  LET g_errparam.replace[1] ='agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog    ='agli041'
                  #160318-00005#9   --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq2_d[l_ac4].glaq033 = g_glaq2_d_t.glaq033
                  LET g_glaq2_d[l_ac4].glaq033_desc = g_glaq2_d_t.glaq033_desc
                  CALL afap280_01_free_account_desc()
                  DISPLAY g_glaq2_d[l_ac4].glaq033_desc TO s_detail4[l_ac4].glaq033_desc
                  NEXT FIELD glaq033_desc
               END IF
            END IF
            CALL afap280_01_free_account_desc()
            DISPLAY g_glaq2_d[l_ac4].glaq033_desc TO s_detail4[l_ac4].glaq033_desc 
      
      BEFORE FIELD glaq034_desc
          LET g_glaq2_d[l_ac4].glaq034_desc = g_glaq2_d[l_ac4].glaq034
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
          
       AFTER FIELD glaq034_desc
            LET g_glaq2_d[l_ac4].glaq034 = g_glaq2_d[l_ac4].glaq034_desc
            DISPLAY '' TO glaq034_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq034) THEN
               CALL afap280_01_free_account_chk(g_glad0221,g_glaq2_d[l_ac4].glaq034,g_glad0222) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq2_d[l_ac4].glaq034
                  #160318-00005#9   --add--str
                  LET g_errparam.replace[1] ='agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog    ='agli041'
                  #160318-00005#9   --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq2_d[l_ac4].glaq034 = g_glaq2_d_t.glaq034
                  LET g_glaq2_d[l_ac4].glaq034_desc = g_glaq2_d_t.glaq034_desc
                  CALL afap280_01_free_account_desc()
                  DISPLAY g_glaq2_d[l_ac4].glaq034_desc TO s_detail4[l_ac4].glaq034_desc
                  NEXT FIELD glaq034_desc
               END IF
            END IF
            CALL afap280_01_free_account_desc()
            DISPLAY g_glaq2_d[l_ac4].glaq034_desc TO s_detail4[l_ac4].glaq034_desc 
            
      BEFORE FIELD glaq035_desc
          LET g_glaq2_d[l_ac4].glaq035_desc = g_glaq2_d[l_ac4].glaq035
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
          
       AFTER FIELD glaq035_desc
            LET g_glaq2_d[l_ac4].glaq035 = g_glaq2_d[l_ac4].glaq035_desc
            DISPLAY '' TO glaq035_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq035) THEN
               CALL afap280_01_free_account_chk(g_glad0231,g_glaq2_d[l_ac4].glaq035,g_glad0232) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq2_d[l_ac4].glaq035
                  #160318-00005#9   --add--str
                  LET g_errparam.replace[1] ='agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog    ='agli041'
                  #160318-00005#9   --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq2_d[l_ac4].glaq035 = g_glaq2_d_t.glaq035
                  LET g_glaq2_d[l_ac4].glaq035_desc = g_glaq2_d_t.glaq035_desc
                  CALL afap280_01_free_account_desc()
                  DISPLAY g_glaq2_d[l_ac4].glaq035_desc TO s_detail4[l_ac4].glaq035_desc
                  NEXT FIELD glaq035_desc
               END IF
            END IF
            CALL afap280_01_free_account_desc()
            DISPLAY g_glaq2_d[l_ac4].glaq035_desc TO s_detail4[l_ac4].glaq035_desc 
            
      BEFORE FIELD glaq036_desc
          LET g_glaq2_d[l_ac4].glaq036_desc = g_glaq2_d[l_ac4].glaq036
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
          
       AFTER FIELD glaq036_desc
            LET g_glaq2_d[l_ac4].glaq036 = g_glaq2_d[l_ac4].glaq036_desc
            DISPLAY '' TO glaq036_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq036) THEN
               CALL afap280_01_free_account_chk(g_glad0241,g_glaq2_d[l_ac4].glaq036,g_glad0242) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq2_d[l_ac4].glaq036
                  #160318-00005#9   --add--str
                  LET g_errparam.replace[1] ='agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog    ='agli041'
                  #160318-00005#9   --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq2_d[l_ac4].glaq036 = g_glaq2_d_t.glaq036
                  LET g_glaq2_d[l_ac4].glaq036_desc = g_glaq2_d_t.glaq036_desc
                  CALL afap280_01_free_account_desc()
                  DISPLAY g_glaq2_d[l_ac4].glaq036_desc TO s_detail4[l_ac4].glaq036_desc
                  NEXT FIELD glaq036_desc
               END IF
            END IF
            CALL afap280_01_free_account_desc()
            DISPLAY g_glaq2_d[l_ac4].glaq036_desc TO s_detail4[l_ac4].glaq036_desc 
            
      BEFORE FIELD glaq037_desc
          LET g_glaq2_d[l_ac4].glaq037_desc = g_glaq2_d[l_ac4].glaq037
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
          
       AFTER FIELD glaq037_desc
            LET g_glaq2_d[l_ac4].glaq037 = g_glaq2_d[l_ac4].glaq037_desc
            DISPLAY '' TO glaq037_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq037) THEN
               CALL afap280_01_free_account_chk(g_glad0251,g_glaq2_d[l_ac4].glaq037,g_glad0252) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq2_d[l_ac4].glaq037
                  #160318-00005#9   --add--str
                  LET g_errparam.replace[1] ='agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog    ='agli041'
                  #160318-00005#9   --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq2_d[l_ac4].glaq037 = g_glaq2_d_t.glaq037
                  LET g_glaq2_d[l_ac4].glaq037_desc = g_glaq2_d_t.glaq037_desc
                  CALL afap280_01_free_account_desc()
                  DISPLAY g_glaq2_d[l_ac4].glaq037_desc TO s_detail4[l_ac4].glaq037_desc
                  NEXT FIELD glaq037_desc
               END IF
            END IF
            CALL afap280_01_free_account_desc()
            DISPLAY g_glaq2_d[l_ac4].glaq037_desc TO s_detail4[l_ac4].glaq037_desc 
            
      BEFORE FIELD glaq038_desc
          LET g_glaq2_d[l_ac4].glaq038_desc = g_glaq2_d[l_ac4].glaq038
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
          
       AFTER FIELD glaq038_desc
            LET g_glaq2_d[l_ac4].glaq038 = g_glaq2_d[l_ac4].glaq038_desc
            DISPLAY '' TO glaq038_desc
            IF NOT cl_null(g_glaq2_d[l_ac4].glaq038) THEN
               CALL afap280_01_free_account_chk(g_glad0261,g_glaq2_d[l_ac4].glaq038,g_glad0262) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_glaq2_d[l_ac4].glaq038
                  #160318-00005#9   --add--str
                  LET g_errparam.replace[1] ='agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog    ='agli041'
                  #160318-00005#9   --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq2_d[l_ac4].glaq038 = g_glaq2_d_t.glaq038
                  LET g_glaq2_d[l_ac4].glaq038_desc = g_glaq2_d_t.glaq038_desc
                  CALL afap280_01_free_account_desc()
                  DISPLAY g_glaq2_d[l_ac4].glaq038_desc TO s_detail4[l_ac4].glaq038_desc
                  NEXT FIELD glaq038_desc
               END IF
            END IF
            CALL afap280_01_free_account_desc()
            DISPLAY g_glaq2_d[l_ac4].glaq038_desc TO s_detail4[l_ac4].glaq038_desc 
      
      #--------------------開窗------------------------------      
       
       ON ACTION controlp INFIELD glaq017
		  INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'i'
		  LET g_qryparam.reqry = FALSE
          LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq017   #給予default值
          #給予arg
          LET g_qryparam.where = " ooef201 = 'Y' " #161024-00008#2
          CALL q_ooef001()                                     #呼叫開窗
          LET g_glaq2_d[l_ac4].glaq017 = g_qryparam.return1    #將開窗取得的值回傳到變數
          DISPLAY g_glaq2_d[l_ac4].glaq017 TO glaq017          #顯示到畫面上
          NEXT FIELD glaq017                                   #返回原欄位
          
        ON ACTION controlp INFIELD glaq017_desc
		    INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'i'
		    LET g_qryparam.reqry = FALSE
          LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq017   #給予default值
          #給予arg
          LET g_qryparam.where = " ooef201 = 'Y' " #161024-00008#2
          CALL q_ooef001()                                     #呼叫開窗
          LET g_glaq2_d[l_ac4].glaq017 = g_qryparam.return1    #將開窗取得的值回傳到變數
          LET g_glaq2_d[l_ac4].glaq017_desc = g_glaq2_d[l_ac4].glaq017
          DISPLAY g_glaq2_d[l_ac4].glaq017_desc TO s_detail4[l_ac4].glaq017_desc
          NEXT FIELD glaq017_desc 

         ON ACTION controlp INFIELD glaq018
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq018       #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                         #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq018 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_glaq2_d[l_ac4].glaq018 TO glaq018              #顯示到畫面上
            NEXT FIELD glaq018                                       #返回原欄位
            
            
         ON ACTION controlp INFIELD glaq018_desc
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq018       #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                         #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq018 = g_qryparam.return1        #將開窗取得的值回傳到變數
            
            LET g_glaq2_d[l_ac4].glaq018_desc=g_glaq2_d[l_ac4].glaq018
            DISPLAY g_glaq2_d[l_ac4].glaq018_desc TO s_detail4[l_ac4].glaq018_desc
            NEXT FIELD glaq018_desc                                  #返回原欄位

         ON ACTION controlp INFIELD glaq019
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq019               #給予default值
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                        #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq019 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_glaq2_d[l_ac4].glaq019 TO glaq019             #顯示到畫面上
            NEXT FIELD glaq019                                      #返回原欄位
            
         ON ACTION controlp INFIELD glaq019_desc
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq019               #給予default值
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                        #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq019 = g_qryparam.return1       #將開窗取得的值回傳到變數
            LET g_glaq2_d[l_ac4].glaq019_desc=g_glaq2_d[l_ac4].glaq019
            DISPLAY g_glaq2_d[l_ac4].glaq019_desc TO s_detail4[l_ac4].glaq019_desc
            NEXT FIELD glaq019_desc                                 #返回原欄位

         ON ACTION controlp INFIELD glaq020
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq020             #給予default值
            #給予arg
            LET g_qryparam.arg1 = '287'
            CALL q_oocq002()                                       #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq020 = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY g_glaq2_d[l_ac4].glaq020 TO glaq020            #顯示到畫面上
            NEXT FIELD glaq020                                     #返回原欄位
            
         ON ACTION controlp INFIELD glaq020_desc
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq020             #給予default值
            #給予arg
            LET g_qryparam.arg1 = '287'
            CALL q_oocq002()                                       #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq020 = g_qryparam.return1      #將開窗取得的值回傳到變數
            LET g_glaq2_d[l_ac4].glaq020_desc=g_glaq2_d[l_ac4].glaq020
            DISPLAY g_glaq2_d[l_ac4].glaq020_desc TO s_detail4[l_ac4].glaq020_desc
            NEXT FIELD glaq020_desc                                #返回原欄位

         ON ACTION controlp INFIELD glaq021
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq021             #給予default值
            #給予arg
             #CALL q_pmaa001()      #160913-00017#1  MARK                       #呼叫開窗
             CALL q_pmaa001_25()   #160913-00017#1  ADD 
            LET g_glaq2_d[l_ac4].glaq021 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_glaq2_d[l_ac4].glaq021 TO glaq021              #顯示到畫面上
            NEXT FIELD glaq021                                       #返回原欄位
            
         ON ACTION controlp INFIELD glaq021_desc
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq021             #給予default值
            #給予arg
            #CALL q_pmaa001()      #160913-00017#1  MARK                       #呼叫開窗
             CALL q_pmaa001_25()   #160913-00017#1  ADD 
            LET g_glaq2_d[l_ac4].glaq021 = g_qryparam.return1        #將開窗取得的值回傳到變數
            LET g_glaq2_d[l_ac4].glaq021_desc=g_glaq2_d[l_ac4].glaq021
            DISPLAY g_glaq2_d[l_ac4].glaq021_desc TO s_detail4[l_ac4].glaq021_desc
            NEXT FIELD glaq021_desc                                  #返回原欄位
 
         ON ACTION controlp INFIELD glaq022
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq022             #給予default值
            #給予arg
            CALL q_pmaa001_25()   #160913-00017#1  ADD 
            #CALL q_pmaa001()     #160913-00017#1  MARK               #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq022 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_glaq2_d[l_ac4].glaq022 TO glaq022              #顯示到畫面上
            NEXT FIELD glaq022                                       #返回原欄位
            
         ON ACTION controlp INFIELD glaq022_desc
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq022             #給予default值
            #給予arg
            CALL q_pmaa001_25()   #160913-00017#1  ADD 
           #CALL q_pmaa001()      #160913-00017#1  MARK                #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq022 = g_qryparam.return1        #將開窗取得的值回傳到變數
            LET g_glaq2_d[l_ac4].glaq022_desc=g_glaq2_d[l_ac4].glaq022
            DISPLAY g_glaq2_d[l_ac4].glaq022_desc TO s_detail4[l_ac4].glaq022_desc
            NEXT FIELD glaq022_desc                                  #返回原欄位
 
         ON ACTION controlp INFIELD glaq023
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq023             #給予default值
            #給予arg
            LET g_qryparam.arg1 = '281'
            CALL q_oocq002()                                         #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq023 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_glaq2_d[l_ac4].glaq023 TO glaq023              #顯示到畫面上
            NEXT FIELD glaq023                                       #返回原欄位
            
         ON ACTION controlp INFIELD glaq023_desc
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq023             #給予default值
            #給予arg
            LET g_qryparam.arg1 = '281'
            CALL q_oocq002()                                         #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq023 = g_qryparam.return1        #將開窗取得的值回傳到變數
            LET g_glaq2_d[l_ac4].glaq023_desc=g_glaq2_d[l_ac4].glaq023
            DISPLAY g_glaq2_d[l_ac4].glaq023_desc TO s_detail4[l_ac4].glaq023_desc
            NEXT FIELD glaq023_desc                                  #返回原欄位

         ON ACTION controlp INFIELD glaq024
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq024             #給予default值
            #給予arg
            CALL q_rtax001_1()                                       #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq024 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_glaq2_d[l_ac4].glaq024 TO glaq024              #顯示到畫面上
            NEXT FIELD glaq024                                       #返回原欄位
            
         ON ACTION controlp INFIELD glaq024_desc
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq024             #給予default值
            #給予arg
            CALL q_rtax001_1()                                       #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq024 = g_qryparam.return1        #將開窗取得的值回傳到變數
            LET g_glaq2_d[l_ac4].glaq024_desc=g_glaq2_d[l_ac4].glaq024
            DISPLAY g_glaq2_d[l_ac4].glaq024_desc TO s_detail4[l_ac4].glaq024_desc
            NEXT FIELD glaq024_desc                                  #返回原欄位

         ON ACTION controlp INFIELD glaq025
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq025             #給予default值
            #給予arg
            CALL q_ooag001()                                         #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq025 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_glaq2_d[l_ac4].glaq025 TO glaq025              #顯示到畫面上
            NEXT FIELD glaq025                                       #返回原欄位
            
         ON ACTION controlp INFIELD glaq025_desc
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq025             #給予default值
            #給予arg
            CALL q_ooag001()                                         #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq025 = g_qryparam.return1        #將開窗取得的值回傳到變數
            LET g_glaq2_d[l_ac4].glaq025_desc=g_glaq2_d[l_ac4].glaq025
            DISPLAY g_glaq2_d[l_ac4].glaq025_desc TO s_detail4[l_ac4].glaq025_desc
            NEXT FIELD glaq025_desc                                  #返回原欄位

#         ON ACTION controlp INFIELD glaq026
#			INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#			LET g_qryparam.reqry = FALSE
#            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq026       #給予default值
#            #給予arg
#            CALL q_bgaa001()                                         #呼叫開窗
#            LET g_glaq2_d[l_ac4].glaq026 = g_qryparam.return1        #將開窗取得的值回傳到變數
#            DISPLAY g_glaq2_d[l_ac4].glaq026 TO glaq026              #顯示到畫面上
#            NEXT FIELD glaq026                                       #返回原欄位
#            
#         ON ACTION controlp INFIELD glaq026_desc
#			INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#			LET g_qryparam.reqry = FALSE
#            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq026       #給予default值
#            #給予arg
#            CALL q_bgaa001()                                         #呼叫開窗
#            LET g_glaq2_d[l_ac4].glaq026 = g_qryparam.return1        #將開窗取得的值回傳到變數
#            LET g_glaq2_d[l_ac4].glaq026_desc=g_glaq2_d[l_ac4].glaq026
#            DISPLAY g_glaq2_d[l_ac4].glaq026_desc TO s_detail4[l_ac4].glaq026_desc
#            NEXT FIELD glaq026_desc                                  #返回原欄位

         ON ACTION controlp INFIELD glaq027
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq027       #給予default值
            #給予arg
            CALL q_pjba001()                                         #呼叫開窗
            LET g_glaq2_d[l_ac4].glaq027 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_glaq2_d[l_ac4].glaq027 TO glaq027              #顯示到畫面上
            NEXT FIELD glaq027                                       #返回原欄位

         ON ACTION controlp INFIELD glaq028

         
          
         ON ACTION controlp INFIELD glaq029_desc
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq029             #給予default值
               
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0171,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq2_d[l_ac4].glaq029 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_glaq2_d[l_ac4].glaq029_desc = g_glaq2_d[l_ac4].glaq029
               DISPLAY g_glaq2_d[l_ac4].glaq029_desc TO s_detail4[l_ac4].glaq029_desc    #說明
               LET g_qryparam.where = ''
               NEXT FIELD glaq029_desc                          #返回原欄位
            END IF 
            
        ON ACTION controlp INFIELD glaq030_desc
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq030             #給予default值
               
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq2_d[l_ac4].glaq030 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_glaq2_d[l_ac4].glaq030_desc = g_glaq2_d[l_ac4].glaq030
               DISPLAY g_glaq2_d[l_ac4].glaq030_desc TO s_detail4[l_ac4].glaq030_desc    #說明
               LET g_qryparam.where = ''
               NEXT FIELD glaq030_desc                          #返回原欄位
            END IF    
         
         ON ACTION controlp INFIELD glaq031_desc
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq031             #給予default值
               
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0191,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq2_d[l_ac4].glaq031 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_glaq2_d[l_ac4].glaq031_desc = g_glaq2_d[l_ac4].glaq031
               DISPLAY g_glaq2_d[l_ac4].glaq031_desc TO s_detail4[l_ac4].glaq031_desc    #說明
               LET g_qryparam.where = ''
               NEXT FIELD glaq031_desc                          #返回原欄位
            END IF
            
         ON ACTION controlp INFIELD glaq032_desc
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq032             #給予default值
               
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0201,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq2_d[l_ac4].glaq032 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_glaq2_d[l_ac4].glaq032_desc = g_glaq2_d[l_ac4].glaq032
               DISPLAY g_glaq2_d[l_ac4].glaq032_desc TO s_detail4[l_ac4].glaq032_desc    #說明
               LET g_qryparam.where = ''
               NEXT FIELD glaq032_desc                          #返回原欄位
            END IF
            
         ON ACTION controlp INFIELD glaq033_desc
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq033             #給予default值
               
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0211,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq2_d[l_ac4].glaq033 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_glaq2_d[l_ac4].glaq033_desc = g_glaq2_d[l_ac4].glaq033
               DISPLAY g_glaq2_d[l_ac4].glaq033_desc TO s_detail4[l_ac4].glaq033_desc    #說明
               LET g_qryparam.where = ''
               NEXT FIELD glaq033_desc                          #返回原欄位
            END IF

         ON ACTION controlp INFIELD glaq034_desc
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq034             #給予default值
               
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0221,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq2_d[l_ac4].glaq034 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_glaq2_d[l_ac4].glaq034_desc = g_glaq2_d[l_ac4].glaq034
               DISPLAY g_glaq2_d[l_ac4].glaq034_desc TO s_detail4[l_ac4].glaq034_desc    #說明
               LET g_qryparam.where = ''
               NEXT FIELD glaq034_desc                          #返回原欄位
            END IF
            
         ON ACTION controlp INFIELD glaq035_desc
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq035             #給予default值
               
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0231,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq2_d[l_ac4].glaq035 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_glaq2_d[l_ac4].glaq035_desc = g_glaq2_d[l_ac4].glaq035
               DISPLAY g_glaq2_d[l_ac4].glaq035_desc TO s_detail4[l_ac4].glaq035_desc    #說明
               LET g_qryparam.where = ''
               NEXT FIELD glaq035_desc                          #返回原欄位
            END IF
            
         ON ACTION controlp INFIELD glaq036_desc
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq036             #給予default值
               
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0241,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq2_d[l_ac4].glaq036 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_glaq2_d[l_ac4].glaq036_desc = g_glaq2_d[l_ac4].glaq036
               DISPLAY g_glaq2_d[l_ac4].glaq036_desc TO s_detail4[l_ac4].glaq036_desc    #說明
               LET g_qryparam.where = ''
               NEXT FIELD glaq036_desc                          #返回原欄位
            END IF
            
         ON ACTION controlp INFIELD glaq037_desc
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq037             #給予default值
               
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0251,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq2_d[l_ac4].glaq037 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_glaq2_d[l_ac4].glaq037_desc = g_glaq2_d[l_ac4].glaq037
               DISPLAY g_glaq2_d[l_ac4].glaq037_desc TO s_detail4[l_ac4].glaq037_desc    #說明
               LET g_qryparam.where = ''
               NEXT FIELD glaq037_desc                          #返回原欄位
            END IF
            
         ON ACTION controlp INFIELD glaq038_desc
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_glaq2_d[l_ac4].glaq038             #給予default值
               
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0261,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009)                                #呼叫開窗
    
               LET g_glaq2_d[l_ac4].glaq038 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_glaq2_d[l_ac4].glaq038_desc = g_glaq2_d[l_ac4].glaq038
               DISPLAY g_glaq2_d[l_ac4].glaq038_desc TO s_detail4[l_ac4].glaq038_desc    #說明
               LET g_qryparam.where = ''
               NEXT FIELD glaq038_desc                          #返回原欄位
            END IF

 
       ON ROW CHANGE
          IF INT_FLAG THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 9001
             LET g_errparam.extend = ''
             LET g_errparam.popup = FALSE
             CALL cl_err()

             LET INT_FLAG = 0
             LET g_glaq2_d[l_ac4].* = g_glaq2_d_t.*
             EXIT INPUT 
          END IF
            
          IF NOT cl_null(g_glaq2_d_t.glaq002) THEN   
             UPDATE afap280_tmp01 SET (docno,seq,glaq002,glaq017,glaq018,glaq019,glaq020,glaq021,   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
                 glaq022,glaq023,glaq024,glaq025,glaq027,glaq028,
                 glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                 glaq036,glaq037,glaq038,glaq001) = (g_glaq2_d[l_ac4].docno,g_glaq2_d[l_ac4].seq,
                 g_glaq2_d[l_ac4].glaq002,g_glaq2_d[l_ac4].glaq017,g_glaq2_d[l_ac4].glaq018,
                 g_glaq2_d[l_ac4].glaq019,g_glaq2_d[l_ac4].glaq020,g_glaq2_d[l_ac4].glaq021,
                 g_glaq2_d[l_ac4].glaq022,g_glaq2_d[l_ac4].glaq023,g_glaq2_d[l_ac4].glaq024,
                 g_glaq2_d[l_ac4].glaq025,g_glaq2_d[l_ac4].glaq027,
                 g_glaq2_d[l_ac4].glaq028,g_glaq2_d[l_ac4].glaq029,g_glaq2_d[l_ac4].glaq030,
                 g_glaq2_d[l_ac4].glaq031,g_glaq2_d[l_ac4].glaq032,g_glaq2_d[l_ac4].glaq033,
                 g_glaq2_d[l_ac4].glaq034,g_glaq2_d[l_ac4].glaq035,g_glaq2_d[l_ac4].glaq036,
                 g_glaq2_d[l_ac4].glaq037,g_glaq2_d[l_ac4].glaq038,g_glaq2_d[l_ac4].glaq001)
              WHERE docno = g_glaq2_d[l_ac4].docno 
                AND glaq002 = g_glaq2_d_t.glaq002   
                AND seq = g_glaq2_d[l_ac4].seq
                AND sw = g_glaq2_d[l_ac4].sw
                AND source = g_glaq2_d[l_ac4].source
          ELSE
             UPDATE afap280_tmp01 SET (docno,seq,glaq002,glaq017,glaq018,glaq019,glaq020,glaq021,   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
                 glaq022,glaq023,glaq024,glaq025,glaq027,glaq028,
                 glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,
                 glaq036,glaq037,glaq038,glaq001) = (g_glaq2_d[l_ac4].docno,g_glaq2_d[l_ac4].seq,
                 g_glaq2_d[l_ac4].glaq002,g_glaq2_d[l_ac4].glaq017,g_glaq2_d[l_ac4].glaq018,
                 g_glaq2_d[l_ac4].glaq019,g_glaq2_d[l_ac4].glaq020,g_glaq2_d[l_ac4].glaq021,
                 g_glaq2_d[l_ac4].glaq022,g_glaq2_d[l_ac4].glaq023,g_glaq2_d[l_ac4].glaq024,
                 g_glaq2_d[l_ac4].glaq025,g_glaq2_d[l_ac4].glaq027,
                 g_glaq2_d[l_ac4].glaq028,g_glaq2_d[l_ac4].glaq029,g_glaq2_d[l_ac4].glaq030,
                 g_glaq2_d[l_ac4].glaq031,g_glaq2_d[l_ac4].glaq032,g_glaq2_d[l_ac4].glaq033,
                 g_glaq2_d[l_ac4].glaq034,g_glaq2_d[l_ac4].glaq035,g_glaq2_d[l_ac4].glaq036,
                 g_glaq2_d[l_ac4].glaq037,g_glaq2_d[l_ac4].glaq038,g_glaq2_d[l_ac4].glaq001)
              WHERE docno = g_glaq2_d[l_ac4].docno 
                AND glaq002 IS NULL 
                AND seq = g_glaq2_d[l_ac4].seq
                AND sw = g_glaq2_d[l_ac4].sw
                AND source = g_glaq2_d[l_ac4].source
          END IF
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "xrcb_t"
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET g_glaq2_d[l_ac4].* = g_glaq2_d_t.*                     
          END IF 
          
          
#          CALL axrp330_update_axr()

       ON ACTION accept
          ACCEPT INPUT
              
       ON ACTION close       #在dialog 右上角 (X)
          LET INT_FLAG = TRUE 
          EXIT INPUT
     
       ON ACTION exit        #toolbar 離開
          LET INT_FLAG = TRUE       
          EXIT INPUT
          
    END INPUT           

    CALL cl_set_act_visible("accept,cancel", FALSE)
    CALL cl_set_comp_visible('grid1',FALSE)    
    CALL afap280_01_s01_show()
END FUNCTION

################################################################################
# Descriptions...: 科目說明
# Memo...........:
# Usage..........: CALL afap280_01_glaq002_desc1()
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_glaq002_desc1()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa004
   LET g_ref_fields[2] = g_glaq2_d[l_ac4].glaq002
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001= ? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaq2_d[l_ac4].glaq002_desc = '', g_rtn_fields[1] , ''
   LET g_glaq2_d[l_ac4].glaq002_desc = g_glaq2_d[l_ac4].glaq002 CLIPPED ,g_glaq2_d[l_ac4].glaq002_desc
   DISPLAY g_glaq2_d[l_ac4].glaq002_desc TO s_detail4[l_ac4].glaq002_desc
END FUNCTION

################################################################################
# Descriptions...: 顯示說明資料
# Memo...........:
# Usage..........: CALL afap280_01_s01_show()
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_s01_show()
   FOR l_ac4 = 1 TO g_glaq2_d.getLength()
       CALL afap280_01_glaq002_desc1()
       CALL afap280_01_ooef001_desc(g_glaq2_d[l_ac4].glaq017) RETURNING g_glaq2_d[l_ac4].glaq017_desc
       CALL afap280_01_ooef001_desc(g_glaq2_d[l_ac4].glaq018) RETURNING g_glaq2_d[l_ac4].glaq018_desc
       CALL afap280_01_ooef001_desc(g_glaq2_d[l_ac4].glaq019) RETURNING g_glaq2_d[l_ac4].glaq019_desc
       CALL afap280_01_glaq020_desc('287',g_glaq2_d[l_ac4].glaq020) RETURNING g_glaq2_d[l_ac4].glaq020_desc
       CALL afap280_01_glaq021_desc(g_glaq2_d[l_ac4].glaq021) RETURNING g_glaq2_d[l_ac4].glaq021_desc
       CALL afap280_01_glaq021_desc(g_glaq2_d[l_ac4].glaq022) RETURNING g_glaq2_d[l_ac4].glaq022_desc
       CALL afap280_01_glaq020_desc('281',g_glaq2_d[l_ac4].glaq023) RETURNING g_glaq2_d[l_ac4].glaq023_desc
       CALL afap280_01_glaq024_desc(g_glaq2_d[l_ac4].glaq024) RETURNING g_glaq2_d[l_ac4].glaq024_desc
       CALL afap280_01_glaq025_desc(g_glaq2_d[l_ac4].glaq025) RETURNING g_glaq2_d[l_ac4].glaq025_desc
#       CALL afap280_01_glaq026_desc(g_glaq2_d[l_ac4].glaq026) RETURNING g_glaq2_d[l_ac4].glaq026_desc
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 核算項檢查
# Memo...........:
# Usage..........: CALL afap280_01_free_account_chk(p_glaf001,p_glaf002,p_ctrl)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_free_account_chk(p_glaf001,p_glaf002,p_ctrl)
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
   #.抓出該类型对应的资料来源，来源档案，来源编号栏位
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
          CALL afap280_01_make_sql(l_glae003,l_glae004,p_glaf002) RETURNING l_sql
          PREPARE afap280_03_chk  FROM l_sql
          EXECUTE afap280_03_chk INTO l_cnt             
          IF  l_cnt = 0  THEN
              LET r_errno = 'agl-00099'
              RETURN r_errno
          END IF
          
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
             LET g_errno ='sub-01302'       #'agl-00063' #160318-00005#9 mod
             RETURN r_errno
          END IF
       END IF
   END IF
   #若来源类型为3.'自行輸入'則user可任意輸入且不需檢核
   RETURN r_errno
END FUNCTION

################################################################################
# Descriptions...: #核算项说明
#                  如果栏位对应的核算项类型对应的资料来源为‘1’，则自组sql来抓取说明
# Memo...........:
# Usage..........: CALL afap280_01_free_account_desc()
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_free_account_desc()
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
      LET g_ref_fields[2] =g_glaq2_d[l_ac4].glaq029
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq029_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq2_d[l_ac4].glaq029
      CALL afap280_01_make_sql_desc(g_glad0171) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq029_desc= g_rtn_fields[1]
   END IF 
   LET g_glaq2_d[l_ac4].glaq029_desc = g_glaq2_d[l_ac4].glaq029 CLIPPED ,g_glaq2_d[l_ac4].glaq029_desc
   #核算项二
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0181
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0181
      LET g_ref_fields[2] =g_glaq2_d[l_ac4].glaq030     
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq030_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq2_d[l_ac4].glaq030
      CALL afap280_01_make_sql_desc(g_glad0181) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq030_desc= g_rtn_fields[1]
   END IF   
   LET g_glaq2_d[l_ac4].glaq030_desc = g_glaq2_d[l_ac4].glaq030 CLIPPED ,g_glaq2_d[l_ac4].glaq030_desc   
   #核算项三
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0191
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0191
      LET g_ref_fields[2] =g_glaq2_d[l_ac4].glaq031
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq031_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq2_d[l_ac4].glaq031
      CALL afap280_01_make_sql_desc(g_glad0191) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq031_desc= g_rtn_fields[1]   
   END IF     
   LET g_glaq2_d[l_ac4].glaq031_desc = g_glaq2_d[l_ac4].glaq031 CLIPPED ,g_glaq2_d[l_ac4].glaq031_desc   
   #核算项四
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0201
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0201
      LET g_ref_fields[2] =g_glaq2_d[l_ac4].glaq032
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq032_desc= g_rtn_fields[1]
    ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq2_d[l_ac4].glaq032
      CALL afap280_01_make_sql_desc(g_glad0201) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq032_desc= g_rtn_fields[1]   
   END IF   
   LET g_glaq2_d[l_ac4].glaq032_desc = g_glaq2_d[l_ac4].glaq032 CLIPPED ,g_glaq2_d[l_ac4].glaq032_desc    
   #核算项五
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0211
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0211
      LET g_ref_fields[2] =g_glaq2_d[l_ac4].glaq033
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq033_desc= g_rtn_fields[1]  
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq2_d[l_ac4].glaq033
      CALL afap280_01_make_sql_desc(g_glad0211) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq033_desc= g_rtn_fields[1]   
   END IF    
   LET g_glaq2_d[l_ac4].glaq033_desc = g_glaq2_d[l_ac4].glaq033 CLIPPED ,g_glaq2_d[l_ac4].glaq033_desc     
   #核算项六
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0221
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0221
      LET g_ref_fields[2] =g_glaq2_d[l_ac4].glaq034
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq034_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq2_d[l_ac4].glaq034
      CALL afap280_01_make_sql_desc(g_glad0221) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq034_desc= g_rtn_fields[1]   
   END IF    
   LET g_glaq2_d[l_ac4].glaq034_desc = g_glaq2_d[l_ac4].glaq034 CLIPPED ,g_glaq2_d[l_ac4].glaq034_desc     
   #核算项七
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0231
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0231
      LET g_ref_fields[2] =g_glaq2_d[l_ac4].glaq035
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq035_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq2_d[l_ac4].glaq035
      CALL afap280_01_make_sql_desc(g_glad0241) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq035_desc= g_rtn_fields[1]   
   END IF     
   LET g_glaq2_d[l_ac4].glaq035_desc = g_glaq2_d[l_ac4].glaq035 CLIPPED ,g_glaq2_d[l_ac4].glaq035_desc     
   #核算项八
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0241
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0241
      LET g_ref_fields[2] =g_glaq2_d[l_ac4].glaq036
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq036_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq2_d[l_ac4].glaq036
      CALL afap280_01_make_sql_desc(g_glad0241) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq036_desc= g_rtn_fields[1]   
   END IF     
   LET g_glaq2_d[l_ac4].glaq036_desc = g_glaq2_d[l_ac4].glaq036 CLIPPED ,g_glaq2_d[l_ac4].glaq036_desc     
   #核算项九
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0251
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0251
      LET g_ref_fields[2] =g_glaq2_d[l_ac4].glaq037
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq037_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq2_d[l_ac4].glaq037
      CALL afap280_01_make_sql_desc(g_glad0251) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq037_desc= g_rtn_fields[1]   
   END IF  
   LET g_glaq2_d[l_ac4].glaq037_desc = g_glaq2_d[l_ac4].glaq037 CLIPPED ,g_glaq2_d[l_ac4].glaq037_desc     
   #核算项十
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad0261
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad0261
      LET g_ref_fields[2] =g_glaq2_d[l_ac4].glaq038
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq038_desc= g_rtn_fields[1]
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaq2_d[l_ac4].glaq038
      CALL afap280_01_make_sql_desc(g_glad0261) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_glaq2_d[l_ac4].glaq038_desc= g_rtn_fields[1]   
   END IF  
   LET g_glaq2_d[l_ac4].glaq038_desc = g_glaq2_d[l_ac4].glaq038 CLIPPED ,g_glaq2_d[l_ac4].glaq038_desc 
END FUNCTION

################################################################################
# Descriptions...: 组检查资料存在有效的sql
# Memo...........:
# Usage..........: CALL afap280_01_make_sql(p_glae003,p_glae004,p_glaf002)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_make_sql(p_glae003,p_glae004,p_glaf002)
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
   PREPARE afap280_01_make_sql_pre FROM l_sql
   DECLARE afap280_01_make_sql_cs CURSOR FOR afap280_01_make_sql_pre
   FOREACH afap280_01_make_sql_cs INTO l_dzeb002,l_dzeb006
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

################################################################################
# Descriptions...: 自由核算項說明
# Memo...........:
# Usage..........: CALL afap280_01_make_sql_desc(p_glae001)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_make_sql_desc(p_glae001)
   DEFINE p_glae001   LIKE glae_t.glae001   #核算项类型
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
   PREPARE afap280_01_pr FROM li_sql1
   DECLARE afap280_01_cs1 CURSOR FOR afap280_01_pr
   FOREACH afap280_01_cs1 INTO li_main[l_i].dzeb002
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
   PREPARE afap280_01_pr2 FROM li_sql2
   DECLARE afap280_01_cs2 CURSOR FOR afap280_01_pr2
   FOREACH afap280_01_cs2 INTO li_dlang[l_i2].dzeb002
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
   PREPARE afap280_01_make_sql_pre1 FROM l_sql
   DECLARE afap280_01_make_sql_cs1 CURSOR FOR afap280_01_make_sql_pre1
   FOREACH afap280_01_make_sql_cs1 INTO l_dzeb002,l_dzeb006
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

################################################################################
# Descriptions...: 处理借方科目及金额等
# Memo...........: 重估
# Usage..........: CALL afap280_01_gen_ar_ins_tmp_8(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno    異動单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: 2014/08/16 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_8(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,  
                          #glaq026  LIKE glaq_t.glaq026,  
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028, 
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌                           
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL
   
   #重估
   #累计折旧虽属资产类科目,实质上就是资产的减项,计提折旧时,要计在贷方,只有处置资产时,对应的累计折旧才能计在借方.
   #调增（对于栏位调整成本）			
   #借	：固定资产资产科目	fabh024	调整成本fabh010
   FOREACH afap280_01_gen_ar_8_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_8_d_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   
   #借：以前年度损益调整科目   afai071中科目   重估的累计折旧fabh012
   FOREACH afap280_01_gen_ar_8_d_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_8_d_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   #贷	：重估的对方科目	fabh021(单身的异动科目）	调整成本fabh010
   FOREACH afap280_01_gen_ar_8_c_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_8_c_cs1'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH

   #贷：累折科目   fabh023   重估的累计折旧fabh012
   FOREACH afap280_01_gen_ar_8_c_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_8_c_cs2'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH
   
   
   #调减（对于栏位调整成本）			
   #借：重估的对方科目	fabh021(单身的异动科目）	调整成本fabh010
   FOREACH afap280_01_gen_ar_8_d_cs3 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_8_d_cs3'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   #借	：累折科目 fabh023	 重估的累计折旧fabh012
   FOREACH afap280_01_gen_ar_8_d_cs4 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_8_d_cs4'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   #贷：固定资产资产科目	fabh024	
   FOREACH afap280_01_gen_ar_8_c_cs3 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_8_c_cs3'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH

   #贷	：以前年度损益调整科目	afai071中科目
   FOREACH afap280_01_gen_ar_8_c_cs4 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_8_c_cs4'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 处理借方科目及金额等
# Memo...........: 減值準備
# Usage..........: CALL afap280_01_gen_ar_ins_tmp_14(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno    異動单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: 2014/08/16 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_14(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028,  
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL
   
   #減值準備
   #调增时
   #借	：減值準備對方科目	fabh021(单身的异动科目）	减值准备金额fabh019
   FOREACH afap280_01_gen_ar_14_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_14_d_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   
   #贷：减值准备科目	fabh025	减值准备金额 fabh019
   FOREACH afap280_01_gen_ar_14_c_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_14_c_cs1'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH

   #调减时
   #借	：减值准备科目	fabh025
   FOREACH afap280_01_gen_ar_14_d_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_14_d_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   #贷	：減值準備對方科目	fabh021(单身的异动科目）
   FOREACH afap280_01_gen_ar_14_c_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_14_c_cs2'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH

   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 錄入傳票單據別產生傳票
# Memo...........:
# Usage..........: CALL afap280_01_s02(p_type,p_ld,p_sum_type)
# Input parameter: p_type         異動類型
#                : p_ld           帐套
#                : p_sum_type     汇总方式 
#                : p_fabg005      判斷是否從其他程序調用
# Modify.........:
################################################################################
PUBLIC FUNCTION afap280_01_s02(p_type,p_ld,p_sum_type,p_fabg005)
   DEFINE p_type        LIKE type_t.chr2
   DEFINE p_ld          LIKE glap_t.glapld
   DEFINE p_sum_type    LIKE type_t.chr1
   DEFINE p_fabg005     LIKE fabg_t.fabg005
   DEFINE l_ooef004     LIKE ooef_t.ooef004
   DEFINE l_glaa013     LIKE glaa_t.glaa013
   DEFINE l_cate        LIKE type_t.chr10
   DEFINE r_success     LIKE type_t.num5
   #161215-00044#1---modify----begin-----------------
   #DEFINE g_glaa        RECORD LIKE glaa_t.*
   DEFINE g_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
       END RECORD

   #161215-00044#1---modify----end-----------------
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_wc          STRING
   DEFINE l_glaa024     LIKE glaa_t.glaa024
   
   OPEN WINDOW w_afap280_s02 WITH FORM cl_ap_formpath("afa","afap280_s02")
   
   LET g_input.glapdocdt=g_today
   LET g_input.flag='N'
   DISPLAY BY NAME g_input.glapdocdt,g_input.flag
   #單據別參照表
  #######################mark by huangtao
  #SELECT ooef004 INTO l_ooef004 FROM ooef_t
  # WHERE ooefent=g_enterprise 
  #   AND ooef001=(SELECT glaacomp FROM glaa_t WHERE glaaent=g_enterprise AND glaald=p_ld)
  
  SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_ld
   #######################mark by huangtao
   #總帳關帳日期
   SELECT glaa013 INTO l_glaa013 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=p_ld
   
   DROP TABLE s_pre_vr_tmp01;                          #20150112 add by chenying  #160727-00019#34   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_pre_voucher_tmp ——> s_pre_vr_tmp01
   CALL s_pre_voucher_cre_tmp_table() RETURNING l_success #20150112 add by chenying
   
   WHILE TRUE
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
             #輸入開始
         INPUT BY NAME g_input.glapdocno,g_input.glapdocdt,g_input.flag
            ATTRIBUTE(WITHOUT DEFAULTS)
       
            BEFORE INPUT
               
            AFTER FIELD glapdocno
               IF NOT cl_null(g_input.glapdocno) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL               
                  LET g_chkparam.arg1 = l_glaa024
                  LET g_chkparam.arg2 = g_input.glapdocno
                  #160318-00025#1--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
                  #160318-00025#1--add--end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooba002_07") THEN
                  ELSE
                     #檢查失敗時後續處理
                     LET g_input.glapdocno = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF 
            
            AFTER FIELD glapdocdt
               IF NOT cl_null(g_input.glapdocdt) THEN
                  IF g_input.glapdocdt<=l_glaa013 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "asf-00008"
                     LET g_errparam.extend = g_input.glapdocdt
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD glapdocdt
                  END IF                  
               END IF
              
            ON ACTION controlp INFIELD glapdocno
   			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
   			   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.glapdocno  #給予default值
               LET g_qryparam.arg1 = l_glaa024
               LET g_qryparam.arg2 = 'aglt310'
               CALL q_ooba002_1()                            #呼叫開窗
               LET g_input.glapdocno = g_qryparam.return1   #將開窗取得的值回傳到變數
               DISPLAY g_input.glapdocno TO glapdocno       #顯示到畫面上
               NEXT FIELD glapdocno 
         END INPUT
      
         ON ACTION cancel
            LET INT_FLAG = TRUE 
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG = TRUE 
            EXIT DIALOG
      
         ON ACTION exit
            LET INT_FLAG = TRUE 
            EXIT DIALOG
            
         ON ACTION accept
            IF cl_null(g_input.glapdocno) THEN
               NEXT FIELD glapdocno
            END IF
            IF cl_null(g_input.glapdocdt) THEN
               NEXT FIELD glapdocdt
            END IF
            #20150112 add by chenying
            CASE p_type 
               WHEN '0'
                  LET l_cate =  'F30'  
               WHEN '4'
                  LET l_cate =  'F40'  
               WHEN '6'
                  LET l_cate =  'F50'  
               WHEN '8'
                  LET l_cate =  'F50' 
               #160426-00014#10  add s---   
               WHEN '39'
                  LET l_cate =  'F50'    
               #160426-00014#10  add e---                  
               WHEN '14'
                  LET l_cate =  'F50'  
               WHEN '21'
                  LET l_cate =  'F50'
               WHEN '9'
                  LET l_cate =  'F50'                  
            END CASE  
            #20150112 add by chenying
            
            IF NOT cl_null(g_input.docno_s) OR NOT cl_null(g_input.docno_e) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00408'
               LET g_errparam.extend = g_input.docno_s
               LET g_errparam.popup = TRUE
               CALL cl_err()
            ELSE
               #20150112 add by chenying 
               #161215-00044#1---modify----begin-----------------
               #SELECT * INTO g_glaa.* 
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,
               glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
               glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,
               glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,
               glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,
               glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.*
               #161215-00044#1---modify----end-----------------
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_ld
               IF g_glaa.glaa121 = 'Y' THEN 
                  CALL s_transaction_begin()
                  CALL cl_err_collect_init() 
                  #20150130 mod by chenying 
                  #当选择单据日期汇总时， afap280_01_group临时表中docno清空了
#                  LET l_wc =" glgbdocno IN (SELECT docno FROM afap280_01_group)" 
                  IF p_sum_type = '1' THEN                   
                    #LET l_wc =" glgbdocno IN (SELECT docno FROM afap280_01_fa_group)"  #151001-00005#1 
                    #LET l_wc =" glgbdocno IN (SELECT docno FROM afap280_01_group)"     #151001-00005#1 
                     LET l_wc =" glgbdocno IN (SELECT docno FROM afap280_tmp02)"        #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
                  ELSE
                    #LET l_wc =" glgbdocno IN (SELECT docno FROM afap280_01_fa_tmp)"    #151001-00005#1
                     LET l_wc =" glgbdocno IN (SELECT docno FROM afap280_01_tmp)"       #151001-00005#1
                  END IF   
                  #20150130 mod by chenying                   
                  CALL s_pre_voucher_ins_glap('FA',l_cate,p_ld,g_input.glapdocdt,g_input.glapdocno,p_sum_type,l_wc) RETURNING r_success,g_input.docno_s,g_input.docno_e
                  DISPLAY BY NAME g_input.docno_s,g_input.docno_e
                  IF r_success THEN
                     CALL s_transaction_end('Y','1')
                  ELSE
                     CALL s_transaction_end('N','1')    
                  END IF
                  CALL cl_err_collect_show()
               ELSE 
               #20150112 add by chenying
                  CALL afap280_01_p(p_type,p_ld,p_sum_type,g_input.glapdocno,g_input.glapdocdt)
                  RETURNING g_input.docno_s,g_input.docno_e
               END IF   #20150112 add by chenying 
               #在畫面中顯示拋轉的起始截止單號
               DISPLAY BY NAME g_input.docno_s,g_input.docno_e
            END IF
            IF NOT cl_null(p_fabg005) THEN
               LET INT_FLAG = TRUE 
               EXIT DIALOG
            ELSE
               ACCEPT DIALOG
            END IF
            
      END DIALOG
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF
   END WHILE
   
   #畫面關閉
   CLOSE WINDOW w_afap280_s02                  
END FUNCTION

################################################################################
# Descriptions...: 自动产生凭证-建立临时表
# Memo...........:
# Usage..........: afap280_01_cre_fa_tmp_table()
#                  RETURNING r_success
# Return code....: r_success      临时表建立成功否
# Date & Author..: 2014/10/20 By yangtt
# Modify.........:
################################################################################
PUBLIC FUNCTION afap280_01_cre_fa_tmp_table()
   DEFINE r_success       LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE

   DROP TABLE afap280_tmp01;             #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
   CREATE TEMP TABLE afap280_tmp01(      #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
   docno    LIKE glaq_t.glaqdocno,
   docdt    LIKE glap_t.glapdocdt,
   sw       LIKE type_t.chr1,
   glaqent  LIKE glaq_t.glaqent,
   glaqcomp LIKE glaq_t.glaqcomp,
   glaqld   LIKE glaq_t.glaqld,
   glaq001  LIKE glaq_t.glaq001,
   glaq002  LIKE glaq_t.glaq002,
   glaq005  LIKE glaq_t.glaq005,
   glaq006  LIKE glaq_t.glaq006,
   glaq007  LIKE glaq_t.glaq007,
   glaq009  LIKE glaq_t.glaq009,
   glaq010  LIKE glaq_t.glaq010,  #原幣金額
   glaq011  LIKE glaq_t.glaq011,
   glaq012  LIKE glaq_t.glaq012,
   glaq013  LIKE glaq_t.glaq013,
   glaq014  LIKE glaq_t.glaq014,
   glaq015  LIKE glaq_t.glaq015,
   glaq016  LIKE glaq_t.glaq016,
   glaq017  LIKE glaq_t.glaq017,
   glaq018  LIKE glaq_t.glaq018,
   glaq019  LIKE glaq_t.glaq019,
   glaq020  LIKE glaq_t.glaq020,
   glaq021  LIKE glaq_t.glaq021,
   glaq022  LIKE glaq_t.glaq022,
   glaq023  LIKE glaq_t.glaq023,
   glaq024  LIKE glaq_t.glaq024,
   glaq025  LIKE glaq_t.glaq025,
   glaq027  LIKE glaq_t.glaq027,
   glaq028  LIKE glaq_t.glaq028,
   glaq051  LIKE glaq_t.glaq051,  #經營方式
   glaq052  LIKE glaq_t.glaq052,  #渠道
   glaq053  LIKE glaq_t.glaq053,  #品牌
   glaq029  LIKE glaq_t.glaq029,
   glaq030  LIKE glaq_t.glaq030,
   glaq031  LIKE glaq_t.glaq031,
   glaq032  LIKE glaq_t.glaq032,
   glaq033  LIKE glaq_t.glaq033,
   glaq034  LIKE glaq_t.glaq034,
   glaq035  LIKE glaq_t.glaq035,
   glaq036  LIKE glaq_t.glaq036,
   glaq037  LIKE glaq_t.glaq037,
   glaq038  LIKE glaq_t.glaq038,
   d        LIKE glaq_t.glaq003,
   c        LIKE glaq_t.glaq004,
   qty      LIKE glaq_t.glaq008,
   sum      LIKE glaq_t.glaq010,
   glaq039  LIKE glaq_t.glaq039,
   glaq040  LIKE glaq_t.glaq040,
   glaq041  LIKE glaq_t.glaq041,
   glaq042  LIKE glaq_t.glaq042,
   glaq043  LIKE glaq_t.glaq043,
   glaq044  LIKE glaq_t.glaq044,
   seq      LIKE glaq_t.glaqseq,
   source   LIKE type_t.chr100,
   glaqseq  LIKE glaq_t.glaqseq,
   xrca039  LIKE xrca_t.xrca039
   );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
#   DROP TABLE afap280_01_fa_group;        #151001-00005#1 mark
#   CREATE TEMP TABLE afap280_01_fa_group( #151001-00005#1 mark
#  DROP TABLE afap280_01_group;            #151001-00005#1 add
#  CREATE TEMP TABLE afap280_01_group(     #151001-00005#1 add  
   DROP TABLE afap280_tmp02;               #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
   CREATE TEMP TABLE afap280_tmp02(        #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
   docno    LIKE glaq_t.glaqdocno,
   docdt    LIKE glap_t.glapdocdt, 
   sw       LIKE type_t.chr1,   
   glaqent  LIKE glaq_t.glaqent,
   glaqcomp LIKE glaq_t.glaqcomp,
   glaqld   LIKE glaq_t.glaqld,
   glaq001  LIKE glaq_t.glaq001,
   glaq002  LIKE glaq_t.glaq002,
   glaq005  LIKE glaq_t.glaq005,
   glaq006  LIKE glaq_t.glaq006,
   glaq007  LIKE glaq_t.glaq007,
   glaq009  LIKE glaq_t.glaq009,
   glaq011  LIKE glaq_t.glaq011,
   glaq012  LIKE glaq_t.glaq012,
   glaq013  LIKE glaq_t.glaq013,
   glaq014  LIKE glaq_t.glaq014,
   glaq015  LIKE glaq_t.glaq015,
   glaq016  LIKE glaq_t.glaq016,   
   glaq017  LIKE glaq_t.glaq017,
   glaq018  LIKE glaq_t.glaq018,
   glaq019  LIKE glaq_t.glaq019,
   glaq020  LIKE glaq_t.glaq020,
   glaq021  LIKE glaq_t.glaq021,
   glaq022  LIKE glaq_t.glaq022,
   glaq023  LIKE glaq_t.glaq023,
   glaq024  LIKE glaq_t.glaq024,
   glaq025  LIKE glaq_t.glaq025,
   glaq027  LIKE glaq_t.glaq027,
   glaq028  LIKE glaq_t.glaq028,
   glaq051  LIKE glaq_t.glaq051,  #經營方式
   glaq052  LIKE glaq_t.glaq052,  #渠道 
   glaq053  LIKE glaq_t.glaq053,  #品牌
   glaq029  LIKE glaq_t.glaq029,
   glaq030  LIKE glaq_t.glaq030,
   glaq031  LIKE glaq_t.glaq031,
   glaq032  LIKE glaq_t.glaq032,
   glaq033  LIKE glaq_t.glaq033,
   glaq034  LIKE glaq_t.glaq034,
   glaq035  LIKE glaq_t.glaq035,
   glaq036  LIKE glaq_t.glaq036,
   glaq037  LIKE glaq_t.glaq037,
   glaq038  LIKE glaq_t.glaq038,
   d        LIKE glaq_t.glaq003,
   c        LIKE glaq_t.glaq004,
   qty      LIKE glaq_t.glaq008,
   sum      LIKE glaq_t.glaq010,
   glaq039  LIKE glaq_t.glaq039,
   glaq040  LIKE glaq_t.glaq040,
   glaq041  LIKE glaq_t.glaq041,
   glaq042  LIKE glaq_t.glaq042,
   glaq043  LIKE glaq_t.glaq043,
   glaq044  LIKE glaq_t.glaq044,
   seq      LIKE glaq_t.glaqseq,
   source   LIKE type_t.chr100,
   glaqseq  LIKE glaq_t.glaqseq,
   xrca039  LIKE xrca_t.xrca039    
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 固定資產科目、改良科目及金额等
# Memo...........: 改良
# Usage..........: CALL afap280_01_gen_ar_ins_tmp_9(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno    異動单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: 2014/10/21 yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_9(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,  
                          #glaq026  LIKE glaq_t.glaq026,  
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028,  
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL
   
   #改良
   #调增时
   #借	：固定資產資產科目	fabh024	調整成本fabh010
   FOREACH afap280_01_gen_ar_9_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_9_d_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)           #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   
   #貸：改良對方科目	fabh021	調整成本fabh010
   FOREACH afap280_01_gen_ar_9_c_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_9_c_cs1'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)             #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'     #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH

   #调减时
   #借：改良對方科目	fabh021	調整成本fabh010
   FOREACH afap280_01_gen_ar_9_d_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_9_d_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)            #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   #貸：固定資產資產科目	fabh024	調整成本fabh010
   FOREACH afap280_01_gen_ar_9_c_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_9_c_cs2'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)            #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH

   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
#                  afap280_01_gen_ar_2_ins_group_tmp(p_ld,p_sum_type)
#                  RETURNING r_success
# Input parameter: p_ld           帐套
#                : p_sum_type     汇总方式 
# Return code....: r_success      成功否标识位
# Date & Author..: 2014/10/27 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_fa_2_ins_group_tmp(p_ld,p_sum_type)
   DEFINE p_ld            LIKE glaa_t.glaald
   DEFINE p_sum_type      LIKE type_t.chr1
   DEFINE p_wc            LIKE type_t.chr1000
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_sql           STRING
   #161215-00044#1---modify----begin-----------------
   #DEFINE l_xrca          RECORD LIKE xrca_t.*
   DEFINE l_xrca RECORD  #應收憑單單頭
       xrcaent LIKE xrca_t.xrcaent, #企業編號
       xrcaownid LIKE xrca_t.xrcaownid, #資料所有者
       xrcaowndp LIKE xrca_t.xrcaowndp, #資料所屬部門
       xrcacrtid LIKE xrca_t.xrcacrtid, #資料建立者
       xrcacrtdp LIKE xrca_t.xrcacrtdp, #資料建立部門
       xrcacrtdt LIKE xrca_t.xrcacrtdt, #資料創建日
       xrcamodid LIKE xrca_t.xrcamodid, #資料修改者
       xrcamoddt LIKE xrca_t.xrcamoddt, #最近修改日
       xrcacnfid LIKE xrca_t.xrcacnfid, #資料確認者
       xrcacnfdt LIKE xrca_t.xrcacnfdt, #資料確認日
       xrcapstid LIKE xrca_t.xrcapstid, #資料過帳者
       xrcapstdt LIKE xrca_t.xrcapstdt, #資料過帳日
       xrcastus LIKE xrca_t.xrcastus, #狀態碼
       xrcacomp LIKE xrca_t.xrcacomp, #法人
       xrcald LIKE xrca_t.xrcald, #帳套
       xrcadocno LIKE xrca_t.xrcadocno, #應收帳款單號碼
       xrcadocdt LIKE xrca_t.xrcadocdt, #帳款日期
       xrca001 LIKE xrca_t.xrca001, #帳款單性質
       xrcasite LIKE xrca_t.xrcasite, #帳務中心
       xrca003 LIKE xrca_t.xrca003, #帳務人員
       xrca004 LIKE xrca_t.xrca004, #帳款客戶編號
       xrca005 LIKE xrca_t.xrca005, #收款客戶
       xrca006 LIKE xrca_t.xrca006, #客戶分類
       xrca007 LIKE xrca_t.xrca007, #帳款類別
       xrca008 LIKE xrca_t.xrca008, #收款條件編號
       xrca009 LIKE xrca_t.xrca009, #應收款日/應扣抵日
       xrca010 LIKE xrca_t.xrca010, #容許票據到期日
       xrca011 LIKE xrca_t.xrca011, #稅別
       xrca012 LIKE xrca_t.xrca012, #稅率
       xrca013 LIKE xrca_t.xrca013, #含稅否
       xrca014 LIKE xrca_t.xrca014, #人員編號
       xrca015 LIKE xrca_t.xrca015, #部門編號
       xrca016 LIKE xrca_t.xrca016, #來源作業類型
       xrca017 LIKE xrca_t.xrca017, #產生方式
       xrca018 LIKE xrca_t.xrca018, #來源參考單號
       xrca019 LIKE xrca_t.xrca019, #系統產生對應單號(待抵帳款-預收)
       xrca020 LIKE xrca_t.xrca020, #信用狀申請流程否
       xrca021 LIKE xrca_t.xrca021, #商業發票號碼(IV no.)
       xrca022 LIKE xrca_t.xrca022, #出口報單號碼
       xrca023 LIKE xrca_t.xrca023, #發票客戶編號
       xrca024 LIKE xrca_t.xrca024, #發票客戶統一編號
       xrca025 LIKE xrca_t.xrca025, #發票客戶全名
       xrca026 LIKE xrca_t.xrca026, #發票客戶地址
       xrca028 LIKE xrca_t.xrca028, #發票類型
       xrca029 LIKE xrca_t.xrca029, #發票匯率
       xrca030 LIKE xrca_t.xrca030, #發票應開未稅金額
       xrca031 LIKE xrca_t.xrca031, #發票應開稅額
       xrca032 LIKE xrca_t.xrca032, #發票應開含稅金額
       xrca033 LIKE xrca_t.xrca033, #專案編號
       xrca034 LIKE xrca_t.xrca034, #責任中心
       xrca035 LIKE xrca_t.xrca035, #應收(借方)科目編號
       xrca036 LIKE xrca_t.xrca036, #收入(貸方)科目編號
       xrca037 LIKE xrca_t.xrca037, #分錄傳票產生否
       xrca038 LIKE xrca_t.xrca038, #拋轉傳票號碼
       xrca039 LIKE xrca_t.xrca039, #會計檢核附件份數
       xrca040 LIKE xrca_t.xrca040, #留置否
       xrca041 LIKE xrca_t.xrca041, #留置理由碼
       xrca042 LIKE xrca_t.xrca042, #留置設定日期
       xrca043 LIKE xrca_t.xrca043, #留置解除日期
       xrca044 LIKE xrca_t.xrca044, #留置原幣金額
       xrca045 LIKE xrca_t.xrca045, #留置說明
       xrca046 LIKE xrca_t.xrca046, #關係人否
       xrca047 LIKE xrca_t.xrca047, #多角序號
       xrca048 LIKE xrca_t.xrca048, #集團代收/代付單號
       xrca049 LIKE xrca_t.xrca049, #來源營運中心編號
       xrca050 LIKE xrca_t.xrca050, #交易原始單據份數
       xrca051 LIKE xrca_t.xrca051, #作廢理由碼
       xrca052 LIKE xrca_t.xrca052, #列印次數
       xrca053 LIKE xrca_t.xrca053, #備註
       xrca054 LIKE xrca_t.xrca054, #多帳期設定
       xrca055 LIKE xrca_t.xrca055, #繳款優惠條件
       xrca056 LIKE xrca_t.xrca056, #會計檢核附件狀態
       xrca057 LIKE xrca_t.xrca057, #交易對象識別碼
       xrca058 LIKE xrca_t.xrca058, #銷售分類
       xrca059 LIKE xrca_t.xrca059, #預算編號
       xrca060 LIKE xrca_t.xrca060, #發票開立原則
       xrca061 LIKE xrca_t.xrca061, #預計開立發票日期
       xrca062 LIKE xrca_t.xrca062, #多角性質
       xrca063 LIKE xrca_t.xrca063, #整帳批序號
       xrca064 LIKE xrca_t.xrca064, #訂金序次
       xrca065 LIKE xrca_t.xrca065, #發票編號
       xrca066 LIKE xrca_t.xrca066, #發票號碼
       xrca100 LIKE xrca_t.xrca100, #交易原幣別
       xrca101 LIKE xrca_t.xrca101, #原幣匯率
       xrca103 LIKE xrca_t.xrca103, #原幣未稅金額
       xrca104 LIKE xrca_t.xrca104, #原幣稅額
       xrca106 LIKE xrca_t.xrca106, #原幣直接折抵合計金額
       xrca107 LIKE xrca_t.xrca107, #原幣直接沖帳(調整)合計金額
       xrca108 LIKE xrca_t.xrca108, #原幣應收金額
       xrca113 LIKE xrca_t.xrca113, #本幣未稅金額
       xrca114 LIKE xrca_t.xrca114, #本幣稅額
       xrca116 LIKE xrca_t.xrca116, #本幣直接沖帳(調整)合計金額
       xrca117 LIKE xrca_t.xrca117, #本幣直接沖帳(調整)合計金額
       xrca118 LIKE xrca_t.xrca118, #本幣應收金額
       xrca120 LIKE xrca_t.xrca120, #本位幣二幣別
       xrca121 LIKE xrca_t.xrca121, #本位幣二匯率
       xrca123 LIKE xrca_t.xrca123, #本位幣二未稅金額
       xrca124 LIKE xrca_t.xrca124, #本位幣二稅額
       xrca126 LIKE xrca_t.xrca126, #本位幣二直接折抵合計金額
       xrca127 LIKE xrca_t.xrca127, #本位幣二直接沖帳(調整)合計金額
       xrca128 LIKE xrca_t.xrca128, #本位幣二應收金額
       xrca130 LIKE xrca_t.xrca130, #本位幣三幣別
       xrca131 LIKE xrca_t.xrca131, #本位幣三匯率
       xrca133 LIKE xrca_t.xrca133, #本位幣三未稅金額
       xrca134 LIKE xrca_t.xrca134, #本位幣三稅額
       xrca136 LIKE xrca_t.xrca136, #本位幣三直接折抵合計金額
       xrca137 LIKE xrca_t.xrca137, #本位幣三直接沖帳(調整)合計金額
       xrca138 LIKE xrca_t.xrca138, #本位幣三應收金額
       xrcaud001 LIKE xrca_t.xrcaud001, #自定義欄位(文字)001
       xrcaud002 LIKE xrca_t.xrcaud002, #自定義欄位(文字)002
       xrcaud003 LIKE xrca_t.xrcaud003, #自定義欄位(文字)003
       xrcaud004 LIKE xrca_t.xrcaud004, #自定義欄位(文字)004
       xrcaud005 LIKE xrca_t.xrcaud005, #自定義欄位(文字)005
       xrcaud006 LIKE xrca_t.xrcaud006, #自定義欄位(文字)006
       xrcaud007 LIKE xrca_t.xrcaud007, #自定義欄位(文字)007
       xrcaud008 LIKE xrca_t.xrcaud008, #自定義欄位(文字)008
       xrcaud009 LIKE xrca_t.xrcaud009, #自定義欄位(文字)009
       xrcaud010 LIKE xrca_t.xrcaud010, #自定義欄位(文字)010
       xrcaud011 LIKE xrca_t.xrcaud011, #自定義欄位(數字)011
       xrcaud012 LIKE xrca_t.xrcaud012, #自定義欄位(數字)012
       xrcaud013 LIKE xrca_t.xrcaud013, #自定義欄位(數字)013
       xrcaud014 LIKE xrca_t.xrcaud014, #自定義欄位(數字)014
       xrcaud015 LIKE xrca_t.xrcaud015, #自定義欄位(數字)015
       xrcaud016 LIKE xrca_t.xrcaud016, #自定義欄位(數字)016
       xrcaud017 LIKE xrca_t.xrcaud017, #自定義欄位(數字)017
       xrcaud018 LIKE xrca_t.xrcaud018, #自定義欄位(數字)018
       xrcaud019 LIKE xrca_t.xrcaud019, #自定義欄位(數字)019
       xrcaud020 LIKE xrca_t.xrcaud020, #自定義欄位(數字)020
       xrcaud021 LIKE xrca_t.xrcaud021, #自定義欄位(日期時間)021
       xrcaud022 LIKE xrca_t.xrcaud022, #自定義欄位(日期時間)022
       xrcaud023 LIKE xrca_t.xrcaud023, #自定義欄位(日期時間)023
       xrcaud024 LIKE xrca_t.xrcaud024, #自定義欄位(日期時間)024
       xrcaud025 LIKE xrca_t.xrcaud025, #自定義欄位(日期時間)025
       xrcaud026 LIKE xrca_t.xrcaud026, #自定義欄位(日期時間)026
       xrcaud027 LIKE xrca_t.xrcaud027, #自定義欄位(日期時間)027
       xrcaud028 LIKE xrca_t.xrcaud028, #自定義欄位(日期時間)028
       xrcaud029 LIKE xrca_t.xrcaud029, #自定義欄位(日期時間)029
       xrcaud030 LIKE xrca_t.xrcaud030  #自定義欄位(日期時間)030
       END RECORD

   #161215-00044#1---modify----end-----------------
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_ac            LIKE type_t.num5
   DEFINE l_docno         LIKE glaq_t.glaqdocno
   DEFINE l_glaq002       LIKE glaq_t.glaq002
   DEFINE l_field         LIKE type_t.chr1000
   DEFINE l_field1        LIKE type_t.chr1000
   DEFINE l_field2        LIKE type_t.chr1000
   DEFINE l_field3        LIKE type_t.chr1000
   DEFINE l_field4        LIKE type_t.chr1000
   DEFINE l_field5        LIKE type_t.chr1000
   DEFINE l_group_field   LIKE type_t.chr1000
   DEFINE l_glad_r        RECORD 
                          glad005   LIKE glad_t.glad005,  #数量/金额管理否
                          glad007   LIKE glad_t.glad007,  #部门管理否
                          glad008   LIKE glad_t.glad008,  #利润成本管理否
                          glad009   LIKE glad_t.glad009,  #区域管理否
                          glad010   LIKE glad_t.glad010,  #交易客商管理否
                          glad011   LIKE glad_t.glad011,  #客群管理否
                          glad012   LIKE glad_t.glad012,  #产品类别管理否
                          glad013   LIKE glad_t.glad013,  #人员管理否
#                          glad014   LIKE glad_t.glad014,  #预算管理否
                          glad015   LIKE glad_t.glad015,  #专案管理否
                          glad016   LIKE glad_t.glad016,  #WBS管理否
                          glad017   LIKE glad_t.glad017,  #自由核算项1管理否
                          glad018   LIKE glad_t.glad018,  #自由核算项2管理否
                          glad019   LIKE glad_t.glad019,  #自由核算项3管理否
                          glad020   LIKE glad_t.glad020,  #自由核算项4管理否
                          glad021   LIKE glad_t.glad021,  #自由核算项5管理否
                          glad022   LIKE glad_t.glad022,  #自由核算项6管理否
                          glad023   LIKE glad_t.glad023,  #自由核算项7管理否
                          glad024   LIKE glad_t.glad024,  #自由核算项8管理否
                          glad025   LIKE glad_t.glad025,  #自由核算项9管理否
                          glad026   LIKE glad_t.glad026,  #自由核算项10管理否 
                          glad027   LIKE glad_t.glad027,  #账款客商管理否   
                          glad031   LIKE glad_t.glad031,  #經營方式管理否
                          glad032   LIKE glad_t.glad032,  #渠道管理否
                          glad033   LIKE glad_t.glad033   #品牌管理否                            
                          END RECORD
   
   WHENEVER ERROR CONTINUE
   LET r_success  = FALSE
   
    #1.定义CURSOR
#   CALL afap280_01_gen_fa_2_def_cursor(p_ld,'','','') RETURNING l_success
#   IF NOT l_success THEN
#      RETURN r_success
#   END IF

   #从临时表中取科目
   LET l_sql = " SELECT DISTINCT docno,glaq002 FROM afap280_tmp01 ",         #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
               "  ORDER BY docno"
   PREPARE afap280_01_gen_fa_2_p5 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_fa_2_p5'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   DECLARE afap280_01_gen_fa_2_cs5 CURSOR FOR afap280_01_gen_fa_2_p5
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_fa_2_cs5'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF      
   
   #从agli030取科目设置
   LET l_sql = " SELECT glad005,glad007,glad008,glad009,glad010,glad011,glad012,glad013,glad015,",
               "        glad016,glad017,glad018,glad019,glad020,glad021,glad022,glad023,glad024,",
               "        glad025,glad026,glad027,glad031,glad032,glad033 ",
               "   FROM glad_t ",
               "  WHERE gladent = ",g_enterprise,
               "    AND gladld  = '",p_ld CLIPPED,"'",
               "    AND glad001 = ? "
   PREPARE afap280_01_gen_fa_2_p6 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'afap280_01_gen_fa_2_p6'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   DECLARE afap280_01_gen_fa_2_cs6 CURSOR FOR afap280_01_gen_fa_2_p6
   
   
   LET l_ac = 1
   select count(*) into l_count  from afap280_tmp01              #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
   FOREACH afap280_01_gen_fa_2_cs5 INTO l_docno,l_glaq002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'afap280_01_gen_fa_2_cs5'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF  
      
      EXECUTE afap280_01_gen_fa_2_cs6 USING l_glaq002 INTO l_glad_r.*
      
      LET l_group_field = NULL
      IF l_glad_r.glad007 = 'Y' THEN  #部门管理
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq018"
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq018"
         END IF
      END IF
      IF l_glad_r.glad008 = 'Y' THEN  #利润成本管理
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq019"
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq019"
         END IF       
      END IF       

      IF l_glad_r.glad009 = 'Y' THEN  #区域管理
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq020"
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq020 "
         END IF       
      END IF 
      IF l_glad_r.glad010 = 'Y' THEN  #客商管理
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq021"
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq021"
         END IF       
      END IF
      IF l_glad_r.glad027 = 'Y' THEN  #賬款客商
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq022"
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq022"
         END IF       
      END IF      
      IF l_glad_r.glad011 = 'Y' THEN  #客群管理
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq023 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq023 "
         END IF       
      END IF 
      IF l_glad_r.glad012 = 'Y' THEN  #产品类别管理
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq024 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq024 "
         END IF       
      END IF 
      IF l_glad_r.glad013 = 'Y' THEN  #人员管理
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq025 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq025"
         END IF       
      END IF        
#      IF l_glad_r.glad014 = 'Y' THEN  #预算管理
#         IF cl_null(l_group_field) THEN
#            LET l_group_field = ",glaq026 "
#         ELSE
#            LET l_group_field = l_group_field CLIPPED,",glaq026 "
#         END IF       
#      END IF        
      IF l_glad_r.glad015 = 'Y' THEN  #专案管理
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq027 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq027 "
         END IF       
      END IF        
      IF l_glad_r.glad016 = 'Y' THEN  #WBS管理
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq028 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq028 "
         END IF       
      END IF 
      IF l_glad_r.glad031 = 'Y' THEN  #經營方式管理
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq051 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq051 "
         END IF       
      END IF 
      IF l_glad_r.glad032 = 'Y' THEN  #經營方式管理
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq052 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq052 "
         END IF       
      END IF 
      IF l_glad_r.glad033 = 'Y' THEN  #經營方式管理
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq053 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq053 "
         END IF       
      END IF
      IF l_glad_r.glad017 = 'Y' THEN  #自由核算项1
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq029 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq029 "
         END IF       
      END IF  
      IF l_glad_r.glad018 = 'Y' THEN  #自由核算项2
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq030 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq030 "
         END IF       
      END IF   
      IF l_glad_r.glad019 = 'Y' THEN  #自由核算项3
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq031 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq031 "
         END IF       
      END IF 
      IF l_glad_r.glad020 = 'Y' THEN  #自由核算项4
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq032 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq032 "
         END IF       
      END IF 
      IF l_glad_r.glad021 = 'Y' THEN  #自由核算项5
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq033 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq033 "
         END IF       
      END IF  
      IF l_glad_r.glad022 = 'Y' THEN  #自由核算项6
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq034 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq034 "
         END IF       
      END IF  
      IF l_glad_r.glad023 = 'Y' THEN  #自由核算项7
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq035 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq035 "
         END IF       
      END IF  
      IF l_glad_r.glad024 = 'Y' THEN  #自由核算项8
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq036 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq036 "
         END IF       
      END IF  
      IF l_glad_r.glad025 = 'Y' THEN  #自由核算项9
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq037 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq037 "
         END IF       
      END IF  
      IF l_glad_r.glad026 = 'Y' THEN  #自由核算项10
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq038 "
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq038 "
         END IF       
      END IF       
      IF l_glad_r.glad005 = 'Y' THEN  #数量/金额管理
         IF cl_null(l_group_field) THEN
            LET l_group_field = ",glaq007"
         ELSE
            LET l_group_field = l_group_field CLIPPED,",glaq007"
         END IF
      END IF
      
      LET l_field = NULL
      LET l_field1 = NULL
      LET l_field2 = NULL
      LET l_field3 = NULL
      LET l_field4 = NULL
      LET l_field5 = NULL
      
      IF l_glad_r.glad007 = 'Y' THEN  #部门管理
         IF cl_null(l_field) THEN
            LET l_field = "glaq018"
         ELSE
            LET l_field = l_field CLIPPED,",glaq018"
         END IF
      ELSE
         IF cl_null(l_field) THEN
            LET l_field = "''"
         ELSE
            LET l_field = l_field CLIPPED,",''"
         END IF
      END IF
      IF l_glad_r.glad008 = 'Y' THEN  #利润成本管理
         IF cl_null(l_field) THEN
            LET l_field = "glaq019"
         ELSE
            LET l_field = l_field CLIPPED,",glaq019"
         END IF 
      ELSE
         IF cl_null(l_field) THEN
            LET l_field = "''"
         ELSE
            LET l_field = l_field CLIPPED,",''"
         END IF         
      END IF       

      IF l_glad_r.glad009 = 'Y' THEN  #区域管理
         IF cl_null(l_field) THEN
            LET l_field = "glaq020"
         ELSE
            LET l_field = l_field CLIPPED,",glaq020 "
         END IF   
      ELSE
         IF cl_null(l_field) THEN
            LET l_field = "''"
         ELSE
            LET l_field = l_field CLIPPED,",''"
         END IF         
      END IF 
      IF l_glad_r.glad010 = 'Y' THEN  #客商管理
         IF cl_null(l_field) THEN
            LET l_field = "glaq021"
         ELSE
            LET l_field = l_field CLIPPED,",glaq021"
         END IF       
      ELSE
         IF cl_null(l_field) THEN
            LET l_field = "''"
         ELSE
            LET l_field = l_field CLIPPED,",''"
         END IF
      END IF 
      IF l_glad_r.glad027 = 'Y' THEN  #賬款客商
         IF cl_null(l_field) THEN
            LET l_field = "glaq022"
         ELSE
            LET l_field = l_field CLIPPED,",glaq022"
         END IF       
      ELSE
         IF cl_null(l_field) THEN
            LET l_field = "''"
         ELSE
            LET l_field = l_field CLIPPED,",''"
         END IF
      END IF 
      IF l_glad_r.glad011 = 'Y' THEN  #客群管理
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq023 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq023 "
         END IF   
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF 
      IF l_glad_r.glad012 = 'Y' THEN  #产品类别管理
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq024 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq024 "
         END IF
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF 
      IF l_glad_r.glad013 = 'Y' THEN  #人员管理
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq025 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq025"
         END IF    
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF        
#      IF l_glad_r.glad014 = 'Y' THEN  #预算管理
#         IF cl_null(l_field3) THEN
#            LET l_field3 = "glaq026 "
#         ELSE
#            LET l_field3 = l_field3 CLIPPED,",glaq026 "
#         END IF  
#      ELSE
#         IF cl_null(l_field3) THEN
#            LET l_field3 = "''"
#         ELSE
#            LET l_field3 = l_field3 CLIPPED,",''"
#         END IF         
#      END IF        
      IF l_glad_r.glad015 = 'Y' THEN  #专案管理
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq027 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq027 "
         END IF 
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF        
      IF l_glad_r.glad016 = 'Y' THEN  #WBS管理
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq028 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq028 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF  

      IF l_glad_r.glad031 = 'Y' THEN  #經營方式管理
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq051 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq051 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF
      
      IF l_glad_r.glad032 = 'Y' THEN  #渠道管理
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq052 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq052 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF
      
      IF l_glad_r.glad033 = 'Y' THEN  #品牌管理
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq053 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq053 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF
      
      IF l_glad_r.glad017 = 'Y' THEN  #自由核算项1
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq029 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq029 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF
      
      IF l_glad_r.glad018 = 'Y' THEN  #自由核算项2
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq030 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq030 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF
      
      IF l_glad_r.glad019 = 'Y' THEN  #自由核算项3
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq031 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq031 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF
      
      IF l_glad_r.glad020 = 'Y' THEN  #自由核算项4
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq032 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq032 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF
      
      IF l_glad_r.glad021 = 'Y' THEN  #自由核算项5
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq033 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq033 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF
      
      IF l_glad_r.glad022 = 'Y' THEN  #自由核算项6
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq034 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq034 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF
      
      IF l_glad_r.glad023 = 'Y' THEN  #自由核算项7
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq035 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq035 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF
      
      IF l_glad_r.glad024 = 'Y' THEN  #自由核算项8
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq036 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq036 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF
      
      IF l_glad_r.glad025 = 'Y' THEN  #自由核算项9
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq037 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq037 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF
      
      IF l_glad_r.glad026 = 'Y' THEN  #自由核算项10
         IF cl_null(l_field3) THEN
            LET l_field3 = "glaq038 "
         ELSE
            LET l_field3 = l_field3 CLIPPED,",glaq038 "
         END IF      
      ELSE
         IF cl_null(l_field3) THEN
            LET l_field3 = "''"
         ELSE
            LET l_field3 = l_field3 CLIPPED,",''"
         END IF         
      END IF


      IF l_glad_r.glad005 = 'Y' THEN  #数量/金额管理
         IF cl_null(l_field1) THEN
            LET l_field1 = "glaq007"
         ELSE
            LET l_field1 = l_field1 CLIPPED,",glaq007"
         END IF
         IF cl_null(l_field2) THEN
            LET l_field2 = "SUM(qty)"
         ELSE
            LET l_field2 = l_field2 CLIPPED,",SUM(qty)"
         END IF
      ELSE
         IF cl_null(l_field1) THEN
            LET l_field1 = "''"
         ELSE
            LET l_field1 = l_field1 CLIPPED,",''"
         END IF
         IF cl_null(l_field2) THEN
            LET l_field2 = "''"
         ELSE
            LET l_field2 = l_field2 CLIPPED,",''"
         END IF
      END IF
 
      IF NOT cl_null(l_glaq002) THEN 
         LET l_field4 = " glaq002 = '",l_glaq002,"'"
      ELSE
         LET l_field4 = " glaq002 IS NULL"
      END IF
      IF p_sum_type = '1' THEN 
    
         LET g_sql = "SELECT docno,docdt,'',glaqent,glaqcomp,glaqld,glaq001,glaq002,glaq005,",
                     "       glaq006,",l_field1 CLIPPED,",",
                     "       '','','','','','','',glaq017,",l_field CLIPPED,",",
                    #"       glaq021,glaq022,",l_field3 CLIPPED,",",
                             l_field3 CLIPPED,",", 
                     "       CASE WHEN SUM(d-c) < 0 THEN 0 ELSE SUM(d-c) END CASE ,",
                     "       CASE WHEN SUM(c-d) < 0 THEN 0 ELSE SUM(c-d) END CASE ,",l_field2 CLIPPED,",",
                     "       SUM(sum),glaq039,",
                     "       CASE WHEN SUM(glaq040-glaq041) < 0 THEN 0 ELSE SUM(glaq040-glaq041) END CASE,",
                     "       CASE WHEN SUM(glaq041-glaq040) < 0 THEN 0 ELSE SUM(glaq041-glaq040) END CASE,",
                     "       glaq042,",
                     "       CASE WHEN SUM(glaq043-glaq044) < 0 THEN 0 ELSE SUM(glaq043-glaq044) END CASE,",
                     "       CASE WHEN SUM(glaq044-glaq043) < 0 THEN 0 ELSE SUM(glaq044-glaq043) END CASE,",
                     "       '','','','' ",
                     "  FROM afap280_tmp01 ",   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
                     " WHERE docno = '",l_docno,"'",
                     "   AND ",l_field4,
                     " GROUP BY docno,docdt,glaqent,glaqcomp,glaqld,glaq001,glaq002,glaq005,glaq006,glaq039,glaq042,glaq017 ",l_group_field          
      END IF
      IF p_sum_type = '2' THEN 
         LET g_sql = "SELECT '',docdt,'',glaqent,glaqcomp,glaqld,glaq001,glaq002,glaq005,",
                     "       glaq006,",l_field1 CLIPPED,",",
                     "       '','','','','','','',glaq017,",l_field CLIPPED,",",
                    #"       '','',",l_field3 CLIPPED,",",
                             l_field3 CLIPPED,",",
                     "       CASE WHEN SUM(d-c) < 0 THEN 0 ELSE SUM(d-c) END CASE ,",
                     "       CASE WHEN SUM(c-d) < 0 THEN 0 ELSE SUM(c-d) END CASE ,",l_field2 CLIPPED,",",
                     "       SUM(sum),glaq039,",
                     "       CASE WHEN SUM(glaq040-glaq041) < 0 THEN 0 ELSE SUM(glaq040-glaq041) END CASE,",
                     "       CASE WHEN SUM(glaq041-glaq040) < 0 THEN 0 ELSE SUM(glaq041-glaq040) END CASE,",
                     "       glaq042,",
                     "       CASE WHEN SUM(glaq043-glaq044) < 0 THEN 0 ELSE SUM(glaq043-glaq044) END CASE,",
                     "       CASE WHEN SUM(glaq044-glaq043) < 0 THEN 0 ELSE SUM(glaq044-glaq043) END CASE,",
                     "       '','','','' ",
                     "  FROM afap280_tmp01 ",          #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
#                     " WHERE docno = '",l_docno,"'",  #20150130 mark by chenying
#                     "   AND ",l_field4,              #20150130 mark by chenying
                     "  WHERE ",l_field4,              #20150130 add by chenying   
                     " GROUP BY docdt,glaqent,glaqcomp,glaqld,glaq001,glaq002,glaq005,glaq006,glaq039,glaq042,glaq017 ",l_group_field
      END IF
      IF p_sum_type = '3' THEN 
         LET g_sql = "SELECT '','','',glaqent,glaqcomp,glaqld,glaq001,glaq002,glaq005,",
                     "       glaq006,",l_field1 CLIPPED,",",
                     "       '','','','','','','',glaq017,",l_field CLIPPED,",",
                    #"       glaq021,glaq022,",l_field3 CLIPPED,",",
                             l_field3 CLIPPED,",",
                     "       CASE WHEN SUM(d-c) < 0 THEN 0 ELSE SUM(d-c) END CASE ,",
                     "       CASE WHEN SUM(c-d) < 0 THEN 0 ELSE SUM(c-d) END CASE ,",l_field2 CLIPPED,",",
                     "       SUM(sum),glaq039,",
                     "       CASE WHEN SUM(glaq040-glaq041) < 0 THEN 0 ELSE SUM(glaq040-glaq041) END CASE,",
                     "       CASE WHEN SUM(glaq041-glaq040) < 0 THEN 0 ELSE SUM(glaq041-glaq040) END CASE,",
                     "       glaq042,",
                     "       CASE WHEN SUM(glaq043-glaq044) < 0 THEN 0 ELSE SUM(glaq043-glaq044) END CASE,",
                     "       CASE WHEN SUM(glaq044-glaq043) < 0 THEN 0 ELSE SUM(glaq044-glaq043) END CASE,",
                     "       '','','','' ",
                     "  FROM afap280_tmp01 ",            #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
                     " WHERE docno = '",l_docno,"'",
                     "   AND ",l_field4,
                     " GROUP BY glaqent,glaqcomp,glaqld,glaq001,glaq002,glaq005,glaq006,glaq039,glaq042,glaq017 ",l_group_field
      END IF
      
      IF p_sum_type = '4' THEN 
         LET g_sql = "SELECT '',docdt,'',glaqent,glaqcomp,glaqld,glaq001,glaq002,glaq005,",
                     "       glaq006,",l_field1 CLIPPED,",",
                     "       '','','','','','','',glaq017,",l_field CLIPPED,",",
                    #"       glaq021,glaq022,",l_field3 CLIPPED,",",
                             l_field3 CLIPPED,",",
                     "       CASE WHEN SUM(d-c) < 0 THEN 0 ELSE SUM(d-c) END CASE ,",
                     "       CASE WHEN SUM(c-d) < 0 THEN 0 ELSE SUM(c-d) END CASE ,",l_field2 CLIPPED,",",
                     "       SUM(sum),glaq039,",
                     "       CASE WHEN SUM(glaq040-glaq041) < 0 THEN 0 ELSE SUM(glaq040-glaq041) END CASE,",
                     "       CASE WHEN SUM(glaq041-glaq040) < 0 THEN 0 ELSE SUM(glaq041-glaq040) END CASE,",
                     "       glaq042,",
                     "       CASE WHEN SUM(glaq043-glaq044) < 0 THEN 0 ELSE SUM(glaq043-glaq044) END CASE,",
                     "       CASE WHEN SUM(glaq044-glaq043) < 0 THEN 0 ELSE SUM(glaq044-glaq043) END CASE,",
                     "       '','','','' ",
                     "  FROM afap280_tmp01 ",         #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
                     " WHERE docno = '",l_docno,"'",
                     "   AND ",l_field4,
                     " GROUP BY docdt,glaqent,glaqcomp,glaqld,glaq001,glaq002,glaq005,glaq006,glaq039,glaq042,glaq017 ",l_group_field
      END IF
      
      
      PREPARE afap280_01_gen_fa_2_p12 FROM g_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'afap280_01_gen_fa_2_p12'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      DECLARE afap280_01_gen_fa_2_cs12 CURSOR FOR afap280_01_gen_fa_2_p12
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'afap280_01_gen_fa_2_cs12'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF 
      
      FOREACH afap280_01_gen_fa_2_cs12 INTO g_glaq3_d[l_ac].*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach afap280_01_gen_fa_2_cs12'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
         #2015/08/25--by--02599--add--str--
         #当借方金额和贷方金额都是0，不插入临时表
         IF g_glaq3_d[l_ac].d=0 AND g_glaq3_d[l_ac].c=0 THEN
            CONTINUE FOREACH
         END IF
         #2015/08/25--by--02599--add--end
         LET g_glaq3_d[l_ac].seq = l_ac
         #add by yangxf ---start 原币金额=本币金额
         IF g_glaq3_d[l_ac].d > 0 THEN 
            LET g_glaq3_d[l_ac].sum = g_glaq3_d[l_ac].d
         ELSE
            LET g_glaq3_d[l_ac].sum = g_glaq3_d[l_ac].c
         END IF
         #add by yangxf ---end
         
        #INSERT INTO afap280_01_fa_group VALUES(g_glaq3_d[l_ac].*) #151001-00005#1
        #INSERT INTO afap280_01_group VALUES(g_glaq3_d[l_ac].*)    #151001-00005#1
         INSERT INTO afap280_tmp02 VALUES(g_glaq3_d[l_ac].*)       #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
         LET l_ac = l_ac + 1
      END FOREACH
      CALL g_glaq3_d.deleteElement(l_ac)   
   END FOREACH 
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 自动产生凭证 定义CURSOR
# Memo...........:
# Usage..........: CALL afap280_01_gen_fa_1_def_cursor(p_ld,p_wc)
#                  RETURNING r_success
# Input parameter: p_ld           帐套
#                : p_wc           QBE条件(帐款来源)
#                : p_sum_type     汇总方式
# Return code....: r_success      成功否标识位
# Date & Author..: 2014/03/02 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_fa_2_def_cursor(p_ld,p_wc,p_sum_type,p_date)
   DEFINE p_ld            LIKE glaa_t.glaald
   DEFINE p_wc            LIKE type_t.chr1000
   DEFINE p_sum_type      LIKE type_t.chr1
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_sql           STRING  
   DEFINE l_glaa004       LIKE glaa_t.glaa004   
   DEFINE l_field         STRING
   DEFINE l_field1        STRING
   DEFINE p_date          LIKE type_t.dat
   DEFINE l_xreb001       LIKE xreb_t.xreb001
   DEFINE l_xreb002       LIKE xreb_t.xreb002
   DEFINE l_8319_11       LIKE gzcb_t.gzcb002      #壞帳費用科目
   DEFINE l_8319_21       LIKE gzcb_t.gzcb002      #壞帳準備提列科目
   DEFINE l_8318_11       LIKE gzcb_t.gzcb002      #重評價匯兌收益科目
   DEFINE l_8318_12       LIKE gzcb_t.gzcb002      #重評價匯兌損失科目
   DEFINE l_glab005d      LIKE glab_t.glab005      #借方科目
   DEFINE l_glab005c      LIKE glab_t.glab005      #贷方科目

#   WHENEVER ERROR CONTINUE
#   LET r_success = FALSE 
#
#   #从临时表中取科目
#   LET l_sql = " SELECT DISTINCT docno,glaq002 FROM afap280_01_fa_tmp ",
#               "  ORDER BY docno"
#   PREPARE afap280_01_gen_fa_2_p5 FROM l_sql
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = 'afap280_01_gen_fa_2_p5'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#
#      RETURN r_success
#   END IF
#   DECLARE afap280_01_gen_fa_2_cs5 CURSOR FOR afap280_01_gen_fa_2_p5
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = 'afap280_01_gen_fa_2_cs5'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#
#      RETURN r_success
#   END IF      
#   
#   #从agli030取科目设置
#   LET l_sql = " SELECT glad005,glad007,glad008,glad009,glad010,glad011,glad012,glad013,glad015,",
#               "        glad016,glad017,glad018,glad019,glad020,glad021,glad022,glad023,glad024,",
#               "        glad025,glad026,glad027,glad031,glad032,glad033 ",
#               "   FROM glad_t ",
#               "  WHERE gladent = ",g_enterprise,
#               "    AND gladld  = '",p_ld CLIPPED,"'",
#               "    AND glad001 = ? "
#   PREPARE afap280_01_gen_fa_2_p6 FROM l_sql
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = 'afap280_01_gen_fa_2_p6'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#
#      RETURN r_success
#   END IF
#   DECLARE afap280_01_gen_fa_2_cs6 CURSOR FOR afap280_01_gen_fa_2_p6
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = 'afap280_01_gen_fa_2_cs6'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#
#      RETURN r_success
#   END IF
#   
#   LET r_success = TRUE
#   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 处理借方科目及金额等
# Memo...........: 折旧
# Usage..........: CALL afap280_01_gen_ar_ins_tmp_0(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno    異動单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: 2014/12/18 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_0(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,  
                          #glaq026  LIKE glaq_t.glaq026,  
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028,  
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL

   #折旧
   #借：固定资产清理faah021 金额：折旧金额(fabh010)
   FOREACH afap280_01_gen_ar_0_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_0_d_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)          #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   #折旧
   #贷：固定资产清理faah023 金额：折旧金额(fabh010)
   FOREACH afap280_01_gen_ar_0_d_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_0_d_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)              #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'      #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 处理借方科目及金额等
# Memo...........: 銷帳/報廢
# Usage..........: CALL afap280_01_gen_ar_ins_tmp_22(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno    異動单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: 2014/08/16 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_22(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,  
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028,  
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL

   #资本化
   #借：fabs011
   FOREACH afap280_01_gen_ar_22_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_22_d_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)             #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'      #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   
   #贷：fabs011
   FOREACH afap280_01_gen_ar_22_d_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_22_d_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)              #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'      #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生傳票插入glap_t glaq_t
# Memo...........:
# Usage..........: CALL afap280_01_p(p_type,p_ld,p_sum_type,p_slip,p_date)
# Input parameter: p_tye          異動類型
#                : p_ld           帐套
#                : p_sum_type     汇总方式
#                : p_slip         單據別
#                : p_date         單據日期
# Modify.........:
################################################################################
PUBLIC FUNCTION afap280_01_p(p_type,p_ld,p_sum_type,p_slip,p_date)
   DEFINE p_type        LIKE type_t.chr2
   DEFINE p_ld          LIKE glap_t.glapld
   DEFINE p_sum_type    LIKE type_t.chr1
   DEFINE p_date        LIKE glap_t.glapdocdt
  #DEFINE p_slip        LIKE ooba_t.ooba002    #160525-00021#3 mark
   DEFINE p_slip        LIKE type_t.chr50      #160525-00021#3       
   DEFINE l_sql         STRING
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_start_no    LIKE glap_t.glapdocno
   DEFINE r_end_no      LIKE glap_t.glapdocno
   
   LET l_sql = "SELECT COUNT(*) FROM afap280_tmp01 ",         #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
               " WHERE glaq002 IS NULL "
   PREPARE chk_glaq002 FROM l_sql
   EXECUTE chk_glaq002 INTO l_cnt   
   IF l_cnt > 0 THEN  
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00068'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN '',''
   END IF
   
   CALL s_transaction_begin()
   #插入凭证单头
   CALL afap280_01_gen_ar_2_ins_glap(p_slip,p_date,p_type,p_ld,p_sum_type)
         RETURNING r_success,r_start_no,r_end_no
    IF NOT r_success THEN
       RETURN '',''     
    END IF  

    IF r_success THEN
       CALL s_transaction_end('Y','0')
       RETURN r_start_no,r_end_no
    ELSE
       CALL s_transaction_end('N','0')
       RETURN '',''
    END IF
END FUNCTION

################################################################################
# Descriptions...: 处理借方科目及金额等
# Memo...........: 类型异动
# Usage..........: CALL afap280_01_gen_ar_ins_tmp_22(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno    異動单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: 2015/05/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_30(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,  
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028,  
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL

   #资产科目
   #借
   FOREACH afap280_01_gen_ar_30_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_30_d_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)              #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'      #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   
   #贷
   FOREACH afap280_01_gen_ar_30_d_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_30_d_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)              #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'      #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   #累折科目
   #借
   FOREACH afap280_01_gen_ar_30_d_cs3 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_30_d_cs3'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)            #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   #贷
   FOREACH afap280_01_gen_ar_30_d_cs4 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_30_d_cs4'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)                 #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'         #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 处理借方科目及金额等
# Memo...........: 类型异动
# Usage..........: CALL afap280_01_gen_ar_ins_tmp_31(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno    異動单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: 2015/08/20 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_31(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,  
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028,  
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL

   #借:新资产科目fabh024
   FOREACH afap280_01_gen_ar_31_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_31_d_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)           #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   
   #借:旧累折科目fabh070
   FOREACH afap280_01_gen_ar_31_d_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_31_d_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)            #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   
   #借:新减值准备科目fabh025
   FOREACH afap280_01_gen_ar_31_d_cs3 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_31_d_cs3'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)                  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'          #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   #贷：旧资产科目fabh071
   FOREACH afap280_01_gen_ar_31_c_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_31_c_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)                 #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'         #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   #贷：新累折科目fabh023
   FOREACH afap280_01_gen_ar_31_c_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_31_c_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)                   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'           #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   #贷：旧减值准备科目fabh072
   FOREACH afap280_01_gen_ar_31_c_cs3 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_31_c_cs3'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)                #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'        #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 处理借方科目及金额等
# Memo...........: 盘盈
# Usage..........: CALL afap280_01_gen_ar_ins_tmp_23(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno    異動单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: 2016/04/07 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_23(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_fabh006        LIKE fabh_t.fabh006  #160329-00025#1 add
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,  
                          #glaq026  LIKE glaq_t.glaq026,  
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028, 
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌                           
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL
   
   #盘盈(帐面上有的)		
   #借	：固定资产资产科目	fabh024	调整成本fabh010
   FOREACH afap280_01_gen_ar_23_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022,l_fabh006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_23_d_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_fabh006 = 0 THEN CONTINUE FOREACH END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)                     #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'             #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH    
   
   #贷	：盘盈对方科目	fabh021(单身的异动科目）	调整成本fabh010-重估累折fabh012
   FOREACH afap280_01_gen_ar_23_c_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022,l_fabh006
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_23_c_cs1'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF l_fabh006 = 0 THEN CONTINUE FOREACH END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)                  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'           #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH

   #贷：累折科目 fabh023   重估累计折旧fabh012
   FOREACH afap280_01_gen_ar_23_c_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022,l_fabh006
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_23_c_cs2'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF l_fabh006 = 0 THEN CONTINUE FOREACH END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)                   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'           #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE             
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH
   
   
   #盘盈(帐面上无)		
   #借	：固定资产资产科目	fabh024	成本fabh008
   FOREACH afap280_01_gen_ar_23_d_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022,l_fabh006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_23_d_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      IF l_fabh006 > 0 THEN CONTINUE FOREACH END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)             #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'     #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   
   #贷：累折科目	fabh023	
   FOREACH afap280_01_gen_ar_23_c_cs3 USING p_fabgdocno INTO l_tmp.*,l_xrcb022,l_fabh006
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_23_c_cs3'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF l_fabh006 > 0 THEN CONTINUE FOREACH END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)             #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'     #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH

   #贷	：盘盈对方科目	fabh021(单身的异动科目）	成本fabh008-累折fabh011
   FOREACH afap280_01_gen_ar_23_c_cs4 USING p_fabgdocno INTO l_tmp.*,l_xrcb022,l_fabh006
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_23_c_cs4'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF l_fabh006 > 0 THEN CONTINUE FOREACH END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
       IF l_xrcb022 = -1 THEN 
          LET l_tmp.sw = '1'
          LET l_tmp.d = l_tmp.c
          LET l_tmp.c = 0
       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)            #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 处理借方科目及金额等
# Memo...........: 盘亏
# Usage..........: CALL afap280_01_gen_ar_ins_tmp_24(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno    異動单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: 2016/04/07 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_24(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,  
                          #glaq026  LIKE glaq_t.glaq026,  
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028,  
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL

   #盘亏
   #借：固定资产清理faah022 金额：本币成本-累计折旧-已提列减值准备(fabh008-fabh011-fabh017)
   FOREACH afap280_01_gen_ar_24_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_24_d_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
#      IF l_xrcb022 = -1 THEN 
#         LET l_tmp.sw = '2'
#         LET l_tmp.c = l_tmp.d
#         LET l_tmp.d = 0
#      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)               #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'       #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   
   #借：累计折旧faah023 金额：累计折旧fabh011
   FOREACH afap280_01_gen_ar_24_d_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_24_d_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
#      IF l_xrcb022 = -1 THEN 
#         LET l_tmp.sw = '2'
#         LET l_tmp.c = l_tmp.d
#         LET l_tmp.d = 0
#      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)            #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'     #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   #借：减值准备科目fabh024 金额：已提列减准备fabh017>0
   FOREACH afap280_01_gen_ar_24_d_cs3 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_24_d_cs3'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
#      IF l_xrcb022 = -1 THEN 
#         LET l_tmp.sw = '2'
#         LET l_tmp.c = l_tmp.d
#         LET l_tmp.d = 0
#      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)              #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'      #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH
   
   #贷：固定资产资产科目fabh024 金额：本币成本fabh008
   FOREACH afap280_01_gen_ar_24_c_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach afap280_01_gen_ar_24_c_cs1'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
       IF NOT cl_null(p_xrca036) THEN
          LET l_tmp.glaq002 = p_xrca036
       END IF
#       IF l_xrcb022 = -1 THEN 
#          LET l_tmp.sw = '1'
#          LET l_tmp.d = l_tmp.c
#          LET l_tmp.c = 0
#       END IF
       #150918-00001#6--add--str--
       IF cl_null(l_tmp.glaq001) THEN
          #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
          CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
          RETURNING l_tmp.glaq001
       END IF
       #150918-00001#6--add--end
       INSERT INTO afap280_tmp01 VALUES(l_tmp.*)                  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert afap280_tmp01'           #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success                   
       END IF               
   END FOREACH

   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 处理借方科目及金额等
# Memo...........: 折旧
# Usage..........: CALL afap280_01_gen_ar_ins_tmp_35(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno    異動单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: #140122-00001#129 By lujh
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_35(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,  
                          #glaq026  LIKE glaq_t.glaq026,  
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028,  
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL

   #投保保费
   #借：保险费用科目faah074 金额：本期保费金额(fabh010)
   FOREACH afap280_01_gen_ar_35_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_35_d_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)                 #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'          #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   #投保保费
   #贷：异动科目(预付保险费科)faah021 金额：本期保费金额(fabh010)
   FOREACH afap280_01_gen_ar_35_d_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_35_d_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      #150918-00001#6--add--str--
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      #150918-00001#6--add--end
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)               #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'       #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success                   
      END IF               
   END FOREACH 
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 处理借方科目及金额等
# Memo...........: 拨出账务处理
# Usage..........: CALL afap280_01_gen_ar_ins_tmp_43(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno    单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: 2016/10/31 By lujh   #160426-00014#45
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_43(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_ooab002        LIKE ooab_t.ooab002
   DEFINE l_glaacomp       LIKE glaa_t.glaacomp
   DEFINE l_fabg011        LIKE fabg_t.fabg011
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,  
                          #glaq026  LIKE glaq_t.glaq026,  
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028, 
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌                           
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL
   SELECT glaacomp INTO l_glaacomp FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_fabgld

   SELECT fabg011 INTO l_fabg011
     FROM fabg_t
    WHERE fabgent = g_enterprise
      AND fabgld = p_fabgld
      AND fabgdocno = p_fabgdocno
      
#  CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9017') RETURNING l_ooab002 #161101-00014#6 add xul  #161101-00014#6 mark
   
#   IF l_fabg011 = 'F'  OR (l_fabg011 <>'F' AND l_ooab002 = 'Y') THEN  #161101-00014#6 add OR (l_fabg011 <>'F' AND l_ooab002 = 'Y') #161101-00014#6 MARK
    IF l_fabg011 = 'F' THEN
      #借：固定资产清理(帐面价值）fabo024	 金額fabo018-fabo019-fabo020
      FOREACH afap280_01_gen_ar_43_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_d_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            RETURN r_success
         END IF
         IF l_xrcb022 = -1 THEN 
            LET l_tmp.sw = '2'
            LET l_tmp.c = l_tmp.d
            LET l_tmp.d = 0
         END IF
         IF cl_null(l_tmp.glaq001) THEN
            #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
            CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
            RETURNING l_tmp.glaq001
         END IF
         INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert afap280_tmp01'  
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            RETURN r_success                   
         END IF               
      END FOREACH

      #借：累折科目	fabo026	fabo019
      FOREACH afap280_01_gen_ar_43_d_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_d_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            RETURN r_success
         END IF
         IF l_xrcb022 = -1 THEN 
            LET l_tmp.sw = '2'
            LET l_tmp.c = l_tmp.d
            LET l_tmp.d = 0
         END IF
         IF cl_null(l_tmp.glaq001) THEN
            #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
            CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
            RETURNING l_tmp.glaq001
         END IF
         INSERT INTO afap280_tmp01 VALUES(l_tmp.*) 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert afap280_tmp01'  
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            RETURN r_success                   
         END IF               
      END FOREACH 
   
      #借：資產科目	fabo028	fabo018
      FOREACH afap280_01_gen_ar_43_c_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_c_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            RETURN r_success
         END IF
         IF l_xrcb022 = -1 THEN 
            LET l_tmp.sw = '2'
            LET l_tmp.c = l_tmp.d
            LET l_tmp.d = 0
         END IF
         IF cl_null(l_tmp.glaq001) THEN
            #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
            CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
            RETURNING l_tmp.glaq001
         END IF
         INSERT INTO afap280_tmp01 VALUES(l_tmp.*) 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert afap280_tmp01' 
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            RETURN r_success                   
         END IF               
      END FOREACH 
   
      #借：减值准备科目	fabo027	fabo020
      FOREACH afap280_01_gen_ar_43_d_cs3 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_d_cs3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            RETURN r_success
         END IF
         IF l_xrcb022 = -1 THEN 
            LET l_tmp.sw = '2'
            LET l_tmp.c = l_tmp.d
            LET l_tmp.d = 0
         END IF
         IF cl_null(l_tmp.glaq001) THEN
            #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
            CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
            RETURNING l_tmp.glaq001
         END IF
         INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert afap280_tmp01' 
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            RETURN r_success                   
         END IF               
      END FOREACH 
   
   ELSE
      #借：出售应收科目fabo029  出售应收金额
      FOREACH afap280_01_gen_ar_43_d_cs4 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_d_cs4'
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success
          END IF
          IF l_xrcb022 = -1 THEN 
             LET l_tmp.sw = '2'
             LET l_tmp.c = l_tmp.d
             LET l_tmp.d = 0
          END IF
          IF cl_null(l_tmp.glaq001) THEN
             #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
             CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
             RETURNING l_tmp.glaq001
          END IF
          INSERT INTO afap280_tmp01 VALUES(l_tmp.*)   
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'insert afap280_tmp01'  
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success                   
          END IF               
      END FOREACH  
      
      #借：出售损失科目	
      FOREACH afap280_01_gen_ar_43_d_cs5 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_d_cs5'
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success
          END IF
          IF NOT cl_null(p_xrca036) THEN
             LET l_tmp.glaq002 = p_xrca036
          END IF
          IF l_xrcb022 = -1 THEN 
             LET l_tmp.sw = '1'
             LET l_tmp.d = l_tmp.c
             LET l_tmp.c = 0
          END IF
          IF cl_null(l_tmp.glaq001) THEN
             #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
             CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
             RETURNING l_tmp.glaq001
          END IF
          INSERT INTO afap280_tmp01 VALUES(l_tmp.*) 
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'insert afap280_tmp01' 
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success                   
          END IF               
      END FOREACH  
      
      #借	：減值準備科目
      FOREACH afap280_01_gen_ar_43_d_cs6 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_d_cs6'
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success
          END IF
          IF NOT cl_null(p_xrca036) THEN
             LET l_tmp.glaq002 = p_xrca036
          END IF
          IF l_xrcb022 = -1 THEN 
             LET l_tmp.sw = '1'
             LET l_tmp.d = l_tmp.c
             LET l_tmp.c = 0
          END IF
          IF cl_null(l_tmp.glaq001) THEN
             #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
             CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
             RETURNING l_tmp.glaq001
          END IF
          INSERT INTO afap280_tmp01 VALUES(l_tmp.*) 
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'insert afap280_tmp01'  
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success                   
          END IF               
      END FOREACH  
      
      #借：累折科目
      FOREACH afap280_01_gen_ar_43_d_cs7 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_d_cs7'
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success
          END IF
          IF NOT cl_null(p_xrca036) THEN
             LET l_tmp.glaq002 = p_xrca036
          END IF
          IF l_xrcb022 = -1 THEN 
             LET l_tmp.sw = '1'
             LET l_tmp.d = l_tmp.c
             LET l_tmp.c = 0
          END IF
          IF cl_null(l_tmp.glaq001) THEN
             #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
             CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
             RETURNING l_tmp.glaq001
          END IF
          INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'insert afap280_tmp01' 
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success                   
          END IF               
      END FOREACH  
      
      #貸：出售收益科目		
      FOREACH afap280_01_gen_ar_43_c_cs4 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_c_cs4'
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success
          END IF
          IF NOT cl_null(p_xrca036) THEN
             LET l_tmp.glaq002 = p_xrca036
          END IF
          IF l_xrcb022 = -1 THEN 
             LET l_tmp.sw = '1'
             LET l_tmp.d = l_tmp.c
             LET l_tmp.c = 0
          END IF
          IF cl_null(l_tmp.glaq001) THEN
             #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
             CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
             RETURNING l_tmp.glaq001
          END IF
          INSERT INTO afap280_tmp01 VALUES(l_tmp.*)    
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'insert afap280_tmp01'   
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success                   
          END IF               
      END FOREACH  
      
      #贷 销项税额:出售
      FOREACH afap280_01_gen_ar_43_c_cs2 USING p_fabgdocno INTO l_tmp.*
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_c_cs2'
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success
          END IF
          
          #若為負數金額,則借貸方向要相反
          IF l_tmp.c < 0 THEN 
             LET l_tmp.sw = '1'
             LET l_tmp.d = l_tmp.c * -1
             LET l_tmp.c = 0
          END IF
          
          #沒有稅額,不產生
          IF l_tmp.d = 0 AND l_tmp.c = 0 THEN 
             CONTINUE FOREACH 
          END IF
          IF cl_null(l_tmp.glaq001) THEN
             #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
             CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
             RETURNING l_tmp.glaq001
          END IF
          INSERT INTO afap280_tmp01 VALUES(l_tmp.*)    
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'insert afap280_tmp01'   
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success                   
          END IF               
      END FOREACH   
      
      #贷	：資產科目
      FOREACH afap280_01_gen_ar_43_c_cs3 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_c_cs3'
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success
          END IF
          IF NOT cl_null(p_xrca036) THEN
             LET l_tmp.glaq002 = p_xrca036
          END IF
          IF l_xrcb022 = -1 THEN 
             LET l_tmp.sw = '1'
             LET l_tmp.d = l_tmp.c
             LET l_tmp.c = 0
          END IF
          IF cl_null(l_tmp.glaq001) THEN
             #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
             CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
             RETURNING l_tmp.glaq001
          END IF
          INSERT INTO afap280_tmp01 VALUES(l_tmp.*)   
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'insert afap280_tmp01'   
             LET g_errparam.popup = TRUE
             CALL cl_err()
      
             RETURN r_success                   
          END IF               
      END FOREACH  
   END IF
  
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 处理借方科目及金额等
# Memo...........: 拨出账务处理
# Usage..........: CALL afap280_01_gen_ar_ins_tmp_44(p_fabgld,p_fabgdocno,p_xrca036)
#                  RETURNING r_success
# Input parameter: p_fabgld       帐套
#                : p_fabgdocno    单号
#                : p_xrca036      科目
# Return code....: r_success      成功否标识位
# Date & Author..: 2016/11/02 By lujh   #160426-00014#44
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_01_gen_ar_ins_tmp_44(p_fabgld,p_fabgdocno,p_xrca036)
   DEFINE p_fabgld         LIKE fabg_t.fabgld
   DEFINE p_fabgdocno      LIKE fabg_t.fabgdocno
   DEFINE p_xrca036        LIKE xrca_t.xrca036
   DEFINE l_xrcb022        LIKE xrcb_t.xrcb022
   DEFINE l_xrce015        LIKE xrce_t.xrce015
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_ooab002        LIKE ooab_t.ooab002
   DEFINE l_glaacomp       LIKE glaa_t.glaacomp
   DEFINE l_fabg011        LIKE fabg_t.fabg011
   DEFINE l_tmp            RECORD 
                           docno    LIKE glaq_t.glaqdocno,
                           docdt    LIKE glap_t.glapdocdt,
                           sw       LIKE type_t.chr1,     
                           glaqent  LIKE glaq_t.glaqent,  
                           glaqcomp LIKE glaq_t.glaqcomp, 
                           glaqld   LIKE glaq_t.glaqld,   
                           glaq001  LIKE glaq_t.glaq001,  
                           glaq002  LIKE glaq_t.glaq002,  
                           glaq005  LIKE glaq_t.glaq005,  
                           glaq006  LIKE glaq_t.glaq006,  
                           glaq007  LIKE glaq_t.glaq007,  
                           glaq009  LIKE glaq_t.glaq009,  
                           glaq010  LIKE glaq_t.glaq010,  #原幣金額
                           glaq011  LIKE glaq_t.glaq011,  
                           glaq012  LIKE glaq_t.glaq012,  
                           glaq013  LIKE glaq_t.glaq013,  
                           glaq014  LIKE glaq_t.glaq014,  
                           glaq015  LIKE glaq_t.glaq015,  
                           glaq016  LIKE glaq_t.glaq016,  
                           glaq017  LIKE glaq_t.glaq017,  
                           glaq018  LIKE glaq_t.glaq018,  
                           glaq019  LIKE glaq_t.glaq019,  
                           glaq020  LIKE glaq_t.glaq020,  
                           glaq021  LIKE glaq_t.glaq021,  
                           glaq022  LIKE glaq_t.glaq022,  
                           glaq023  LIKE glaq_t.glaq023,  
                           glaq024  LIKE glaq_t.glaq024,  
                           glaq025  LIKE glaq_t.glaq025,  
                          #glaq026  LIKE glaq_t.glaq026,  
                           glaq027  LIKE glaq_t.glaq027,  
                           glaq028  LIKE glaq_t.glaq028, 
                           glaq051  LIKE glaq_t.glaq051,  #經營方式
                           glaq052  LIKE glaq_t.glaq052,  #渠道
                           glaq053  LIKE glaq_t.glaq053,  #品牌                           
                           glaq029  LIKE glaq_t.glaq029,  
                           glaq030  LIKE glaq_t.glaq030,  
                           glaq031  LIKE glaq_t.glaq031,  
                           glaq032  LIKE glaq_t.glaq032,  
                           glaq033  LIKE glaq_t.glaq033,  
                           glaq034  LIKE glaq_t.glaq034,  
                           glaq035  LIKE glaq_t.glaq035,  
                           glaq036  LIKE glaq_t.glaq036,  
                           glaq037  LIKE glaq_t.glaq037,  
                           glaq038  LIKE glaq_t.glaq038,   
                           d        LIKE glaq_t.glaq003,  
                           c        LIKE glaq_t.glaq004,  
                           qty      LIKE glaq_t.glaq008,  
                           sum      LIKE glaq_t.glaq010,
                           glaq039  LIKE glaq_t.glaq039,
                           glaq040  LIKE glaq_t.glaq040,
                           glaq041  LIKE glaq_t.glaq041,
                           glaq042  LIKE glaq_t.glaq042,
                           glaq043  LIKE glaq_t.glaq043,
                           glaq044  LIKE glaq_t.glaq044,
                           seq      LIKE glaq_t.glaqseq,
                           source   LIKE type_t.chr100,
                           glaqseq  LIKE glaq_t.glaqseq,
                           xrca039  LIKE xrca_t.xrca039                              
                           END RECORD
   WHENEVER ERROR CONTINUE    

   LET r_success = FALSE                        
   INITIALIZE l_tmp.* TO NULL
   SELECT glaacomp INTO l_glaacomp FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_fabgld

   #借：资产科目（帐面原值）
   FOREACH afap280_01_gen_ar_44_d_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_44_d_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
   
         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'  
         LET g_errparam.popup = TRUE
         CALL cl_err()
   
         RETURN r_success                   
      END IF               
   END FOREACH
    
   #贷：累折科目
   FOREACH afap280_01_gen_ar_44_c_cs1 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_d_cs2'
         LET g_errparam.popup = TRUE
         CALL cl_err()
   
         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01'  
         LET g_errparam.popup = TRUE
         CALL cl_err()
   
         RETURN r_success                   
      END IF               
   END FOREACH 
    
   #贷：减值准备科目
   FOREACH afap280_01_gen_ar_44_c_cs2 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_c_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
   
         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01' 
         LET g_errparam.popup = TRUE
         CALL cl_err()
   
         RETURN r_success                   
      END IF               
   END FOREACH 
    
   #贷：固定资产清理(帐面价值）
   FOREACH afap280_01_gen_ar_44_c_cs3 USING p_fabgdocno INTO l_tmp.*,l_xrcb022
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach afap280_01_gen_ar_43_d_cs3'
         LET g_errparam.popup = TRUE
         CALL cl_err()
   
         RETURN r_success
      END IF
      IF l_xrcb022 = -1 THEN 
         LET l_tmp.sw = '2'
         LET l_tmp.c = l_tmp.d
         LET l_tmp.d = 0
      END IF
      IF cl_null(l_tmp.glaq001) THEN
         #                 2:摘要/账套     /科目编号     /程序编号/目的字段 /单据编号     /单据项次1/单据项次2
         CALL s_account_item('2',p_fabgld,l_tmp.glaq002,g_prog_t,'glgb001',p_fabgdocno,l_tmp.seq,'')
         RETURNING l_tmp.glaq001
      END IF
      INSERT INTO afap280_tmp01 VALUES(l_tmp.*)  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert afap280_tmp01' 
         LET g_errparam.popup = TRUE
         CALL cl_err()
   
         RETURN r_success                   
      END IF               
   END FOREACH 
  
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

 
{</section>}
 
