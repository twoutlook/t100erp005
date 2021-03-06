#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp310_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2015-12-23 15:22:39), PR版次:0010(2016-12-13 14:24:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000123
#+ Filename...: asfp310_01
#+ Description: 產生發料單
#+ Creator....: 00768(2014-04-22 09:40:53)
#+ Modifier...: 00593 -SD/PR- 08992
 
{</section>}
 
{<section id="asfp310_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150101 单位转换率改写
#151209-00022#1  15/12/23  by Sarah  在產生發料單的匯總選項加上4.不拆單，預設條件改為4
#160408-00035#7 16/04/21 By xianghui  插入sfdd时增加备置量和在拣量的计算
#161109-00085#39 2016/11/17 By lienjunqi    整批調整系統星號寫法
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
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"
 
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_sfda_m        RECORD
       sfdadocno LIKE sfda_t.sfdadocno, 
   method LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_sfaa_d   RECORD
                     sel_1       LIKE type_t.chr1,      #选择
                     lock_1      LIKE type_t.chr1,      #锁定
                     seq_1       LIKE type_t.num5,      #顺序
                     sfaadocno_1 LIKE sfaa_t.sfaadocno, #工单单号
                     sfaa010_1   LIKE sfaa_t.sfaa010,   #生产料号
                     sfaa010_imaal003_1  LIKE imaal_t.imaal003,
                     sfaa010_imaal004_1  LIKE imaal_t.imaal004,
                     sfaa019_1   LIKE sfaa_t.sfaa019,   #预计开工日
                     sfaa020_1   LIKE sfaa_t.sfaa020,   #预计完工日
                     sfaa017_1   LIKE sfaa_t.sfaa017,   #部门厂商
                     sfaa017_desc_1      LIKE type_t.chr80,
                     sfaa002_1   LIKE sfaa_t.sfaa002,   #生管员
                     sfaa002_desc_1      LIKE type_t.chr80,
                     sfba003_1   LIKE sfba_t.sfba003,   #作业编号
                     sfba004_1   LIKE sfba_t.sfba004,   #作业序
                     sfaa012_1   LIKE sfaa_t.sfaa012,   #生产数量
                     sfaa049_1   LIKE sfaa_t.sfaa049,   #已发套数
                     has_sets_1  LIKE sfaa_t.sfaa049,   #已发齐套数
                     can_sets_1  LIKE sfaa_t.sfaa049    #可齐料套数
                     END RECORD
TYPE type_g_gen_d    RECORD
                     seq_1       LIKE type_t.num5,      #顺序
                     sfaadocno_1 LIKE sfaa_t.sfaadocno, #工单单号
                     sfaa010_1   LIKE sfaa_t.sfaa010,   #生产料号
                     sfaa019_1   LIKE sfaa_t.sfaa019,   #预计开工日
                     sfaa020_1   LIKE sfaa_t.sfaa020,   #预计完工日
                     sfaa017_1   LIKE sfaa_t.sfaa017,   #部门厂商
                     sfaa002_1   LIKE sfaa_t.sfaa002,   #生管员
                     sfba003_1   LIKE sfba_t.sfba003,   #作业编号
                     sfba004_1   LIKE sfba_t.sfba004,   #作业序
                     sfaa012_1   LIKE sfaa_t.sfaa012,   #生产数量
                     sfaa049_1   LIKE sfaa_t.sfaa049,   #已发套数
                     has_sets_1  LIKE sfaa_t.sfaa049,   #已发齐套数
                     can_sets_1  LIKE sfaa_t.sfaa049,   #可齐料套数
                     seq_2       LIKE type_t.num5,      #项次
                     seq1_2      LIKE type_t.num5,      #项序
                     sfba002_2   LIKE sfba_t.sfba002,   #部位
                     sfba003_2   LIKE sfba_t.sfba003,   #作业
                     sfba004_2   LIKE sfba_t.sfba004,   #作业序
                     sfba006_2   LIKE sfba_t.sfba006,   #发料料号
                     sfba021_2   LIKE sfba_t.sfba021,   #产品特征
                     sfba014_2   LIKE sfba_t.sfba014,   #单位
                     sfba013_2   LIKE sfba_t.sfba013,   #应发数量  
                     sfba016_2   LIKE sfba_t.sfba016,   #已发数量
                     no_issue_2  LIKE sfba_t.sfba016,   #未发数量
                     issue_qty_2 LIKE sfba_t.sfba016,   #发料量
                     inag008_2   LIKE sfba_t.sfba016,   #库存可用量
                     inan010_2   LIKE sfba_t.sfba016,   #在捡量
                     
                     #sfba019     LIKE sfba_t.sfba019,   #指定库位
                     #sfba020     LIKE sfba_t.sfba020,   #指定储位
                     #sfba029     LIKE sfba_t.sfba029,   #指定批号
                     #sfba030     LIKE sfba_t.sfba030,   #指定库存管理特征

                     bmea007_4   LIKE bmea_t.bmea007,   #取替代特性
                     bmea008_4   LIKE bmea_t.bmea008,   #料件编号 实际发料料号
                     bmea019_4   LIKE bmea_t.bmea019,   #產品特徵
                     replace_rate_4 LIKE sfba_t.sfba022,   #替代率
                     bmea016_4   LIKE bmea_t.bmea016,   #替代方式
                     bmea017_4   LIKE bmea_t.bmea017,   #替代上限比率
                     inag004_4   LIKE inag_t.inag004,   #库位
                     inag005_4   LIKE inag_t.inag005,   #储位
                     inag006_4   LIKE inag_t.inag006,   #批号
                     inag003_4   LIKE inag_t.inag003,   #库存管理特征 
                     inag007_4   LIKE inag_t.inag007,   #单位
                     inag008_4   LIKE inag_t.inag008,   #现有库存数量 
                     inan010_4   LIKE inan_t.inan010,   #库存在捡量
                     #has_qty_4   LIKE inag_t.inag008,   #其他工单分配量    
                     issue_qty_4 LIKE inag_t.inag008,   #发料量
                     sort        LIKE type_t.chr100,    #分类排序--g_sfda_m.method
                     sort2       LIKE type_t.chr100     #排序2--工单+项次+项序+库位 用于sfdc插入判断
                     END RECORD
DEFINE g_sfaa_d      DYNAMIC ARRAY OF type_g_sfaa_d
DEFINE g_count       LIKE type_t.num5

DEFINE la_param  RECORD
                 prog   STRING,
                 param  DYNAMIC ARRAY OF STRING
                 END RECORD
DEFINE ls_js     STRING
DEFINE g_wc_str  STRING   #产生成功的发料单号

DEFINE g_ooba002       LIKE ooba_t.ooba002  #单别
DEFINE g_para          LIKE type_t.chr80  #工單指定發料庫儲，發料時允許修改
#end add-point
 
DEFINE g_sfda_m        type_g_sfda_m
 
   DEFINE g_sfdadocno_t LIKE sfda_t.sfdadocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="asfp310_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION asfp310_01(--)
   #add-point:input段變數傳入 name="input.get_var"
p_sfaa_d
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
   DEFINE l_success       LIKE type_t.num5
   DEFINE p_sfaa_d        DYNAMIC ARRAY OF type_g_sfaa_d
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_ooef004       LIKE ooef_t.ooef004
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_asfp310_01 WITH FORM cl_ap_formpath("asf","asfp310_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('method','4018')
   LET g_sfda_m.method = '4'   #151209-00022#1 mod 預設值2->4
   
   LET g_sfaa_d.* = p_sfaa_d.*
   {
   #赋值全局变量，顺带将需产生发料单的资料理出来
   LET g_count = 0
   FOR l_i = 1 TO p_sfaa_d.getLength()
       IF p_sfaa_d[l_i].sel_1 = 'Y' THEN
          LET g_count = g_count + 1
          LET g_sfaa_d[g_count].* = p_sfaa_d[l_i].*
       END IF
   END FOR
   }
   WHENEVER ERROR CONTINUE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_sfda_m.sfdadocno,g_sfda_m.method ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfdadocno
            #add-point:BEFORE FIELD sfdadocno name="input.b.sfdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfdadocno
            
            #add-point:AFTER FIELD sfdadocno name="input.a.sfdadocno"
            IF NOT cl_null(g_sfda_m.sfdadocno) THEN
               #是否存在成套发料单别内
               CALL s_aooi200_chk_slip(g_site,'',g_sfda_m.sfdadocno,'asft311')
               RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfdadocno
            #add-point:ON CHANGE sfdadocno name="input.g.sfdadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD method
            #add-point:BEFORE FIELD method name="input.b.method"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD method
            
            #add-point:AFTER FIELD method name="input.a.method"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE method
            #add-point:ON CHANGE method name="input.g.method"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.sfdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfdadocno
            #add-point:ON ACTION controlp INFIELD sfdadocno name="input.c.sfdadocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfda_m.sfdadocno      #給予default值
            #給予arg
            CALL s_aooi100_sel_ooef004(g_site) RETURNING l_success,l_ooef004
            LET g_qryparam.arg1 = l_ooef004                   #參照表編號
            LET g_qryparam.arg2 = 'asft311'                   #作业代号            
            CALL q_ooba002_1()                                #呼叫開窗
            LET g_sfda_m.sfdadocno = g_qryparam.return1
            DISPLAY g_sfda_m.sfdadocno TO sfdadocno
            NEXT FIELD sfdadocno                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.method
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD method
            #add-point:ON ACTION controlp INFIELD method name="input.c.method"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            CALL asfp310_01_gen()
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
   CLOSE WINDOW w_asfp310_01 
   
   #add-point:input段after input name="input.post_input"
   IF NOT cl_null(g_wc_str) THEN
      LET r_success = TRUE
   ELSE
      LET r_success = FALSE
   END IF
   RETURN r_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asfp310_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="asfp310_01.other_function" readonly="Y" >}
###########################################
#产生成套发料单
#汇总方式
#1.依库位
#2.依工单
#3.依工单+库位
###########################################
PRIVATE FUNCTION asfp310_01_gen()
DEFINE l_success     LIKE type_t.num5
DEFINE l_cnt         LIKE type_t.num5

   CALL asfp310_01_crt_table() RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF
   
   CALL s_transaction_begin()
   LET g_wc_str = ''  #清除成功清单

   #插入临时表
   CALL asfp310_01_gen_ins_tmp() RETURNING l_success
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
      CALL asfp310_01_drop_table()
      LET g_wc_str = ''  #清除成功清单
      RETURN
   END IF

   #产生发料单
   CALL asfp310_01_gen_asft310() RETURNING l_success
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
      CALL asfp310_01_drop_table()
      LET g_wc_str = ''  #清除成功清单
      RETURN
   END IF

   CALL s_transaction_end('Y','0')

   IF NOT cl_null(g_wc_str) THEN
      #执行成功，是否开启发料单
      IF cl_ask_confirm('asf-00243') THEN
          LET la_param.prog     = "asft311"
          LET la_param.param[2] = "sfdadocno IN (",g_wc_str CLIPPED,")"
          LET ls_js = util.JSON.stringify( la_param )
          CALL cl_cmdrun(ls_js)
      END IF
   ELSE
      #无可产生的数据，请先选择数据
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00242'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   CALL asfp310_01_drop_table()

END FUNCTION

PRIVATE FUNCTION asfp310_01_crt_table()
DEFINE r_success    LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5

   LET r_success = FALSE
   #DROP TABLE asfp310_01_t;
   #CREATE TEMP TABLE asfp310_01_t(
   #   sfaadocno    LIKE sfaa_t.sfaadocno,      #工单号
   #   ware         LIKE sfdc_t.sfdc012,        #库位
   #   sfdadocno    LIKE sfda_t.sfdadocno       #发料单号
   #);
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'create table'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   RETURN r_success
   #END IF
   
   DROP TABLE asfp310_01_t;
   CREATE TEMP TABLE asfp310_01_t(
                     seq_1       LIKE type_t.num5,      #顺序
                     sfaadocno_1 LIKE sfaa_t.sfaadocno, #工单单号
                     sfaa010_1   LIKE sfaa_t.sfaa010,   #生产料号
                     sfaa019_1   LIKE sfaa_t.sfaa019,   #预计开工日
                     sfaa020_1   LIKE sfaa_t.sfaa020,   #预计完工日
                     sfaa017_1   LIKE sfaa_t.sfaa017,   #部门厂商
                     sfaa002_1   LIKE sfaa_t.sfaa002,   #生管员
                     sfba003_1   LIKE sfba_t.sfba003,   #作业编号
                     sfba004_1   LIKE sfba_t.sfba004,   #作业序
                     sfaa012_1   LIKE sfaa_t.sfaa012,   #生产数量
                     sfaa049_1   LIKE sfaa_t.sfaa049,   #已发套数
                     has_sets_1  LIKE sfaa_t.sfaa049,   #已发齐套数
                     can_sets_1  LIKE sfaa_t.sfaa049,   #可齐料套数
                     seq_2       LIKE type_t.num5,      #项次
                     seq1_2      LIKE type_t.num5,      #项序
                     sfba002_2   LIKE sfba_t.sfba002,   #部位
                     sfba003_2   LIKE sfba_t.sfba003,   #作业
                     sfba004_2   LIKE sfba_t.sfba004,   #作业序
                     sfba006_2   LIKE sfba_t.sfba006,   #发料料号
                     sfba021_2   LIKE sfba_t.sfba021,   #产品特征
                     sfba014_2   LIKE sfba_t.sfba014,   #单位
                     sfba013_2   LIKE sfba_t.sfba013,   #应发数量  
                     sfba016_2   LIKE sfba_t.sfba016,   #已发数量
                     no_issue_2  LIKE sfba_t.sfba016,   #未发数量
                     issue_qty_2 LIKE sfba_t.sfba016,   #发料量
                     inag008_2   LIKE sfba_t.sfba016,   #库存可用量
                     inan010_2   LIKE sfba_t.sfba016,   #在捡量
                     bmea007_4   LIKE bmea_t.bmea007,   #取替代特性
                     bmea008_4   LIKE bmea_t.bmea008,   #料件编号
                     bmea019_4   LIKE bmea_t.bmea019,   #產品特徵
                     replace_rate_4 LIKE sfba_t.sfba022,   #替代率
                     bmea016_4   LIKE bmea_t.bmea016,   #替代方式
                     bmea017_4   LIKE bmea_t.bmea017,   #替代上限比率
                     inag004_4   LIKE inag_t.inag004,   #库位
                     inag005_4   LIKE inag_t.inag005,   #储位
                     inag006_4   LIKE inag_t.inag006,   #批号
                     inag003_4   LIKE inag_t.inag003,   #库存管理特征 
                     inag007_4   LIKE inag_t.inag007,   #单位
                     inag008_4   LIKE inag_t.inag008,   #现有库存数量 
                     inan010_4   LIKE inan_t.inan010,   #库存在捡量
                     issue_qty_4 LIKE inag_t.inag008,   #发料量
                     sort        LIKE type_t.chr100,    #分类排序--g_sfda_m.method
                     sort2       LIKE type_t.chr100     #排序2--工单+项次+项序+库位 用于sfdc插入判断
                       );
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'asfp310_01_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   ##建立预计套数sfdb006的table
   #DROP TABLE asfp310_01_tmp01;
   #CREATE TEMP TABLE asfp310_01_tmp01(
   #   sfdb003      LIKE sfdb_t.sfdb003, #部位
   #   sfdb004      LIKE sfdb_t.sfdb004, #作业编号
   #   sfdb005      LIKE sfdb_t.sfdb005, #作业序
   #   sfdb006      LIKE sfdb_t.sfdb006  #预计套数
   #);
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'create asfp310_01_tmp01'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   RETURN r_success
   #END IF
   #CREATE UNIQUE INDEX asfp310_01_tmp01_01 on asfp310_01_tmp01 (sfdb003,sfdb004,sfdb005)
   #IF SQLCA.sqlcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'create asfp310_01_tmp01:index'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   RETURN r_success
   #END IF
   CALL s_asft310_create_table1() RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF

   LET r_success = TRUE
   RETURN r_success
END FUNCTION
#将需产生发料单的资料插入临时表
PRIVATE FUNCTION asfp310_01_gen_ins_tmp()
DEFINE r_success     LIKE type_t.num5
DEFINE l_sql         STRING
DEFINE l_i           LIKE type_t.num5
DEFINE l_sfba        RECORD
                     seq_1       LIKE type_t.num5,      #顺序
                     seq_2       LIKE type_t.num5,      #项次
                     seq1_2      LIKE type_t.num5,      #项序
                     sfba002_2   LIKE sfba_t.sfba002,   #部位
                     sfba003_2   LIKE sfba_t.sfba003,   #作业
                     sfba004_2   LIKE sfba_t.sfba004,   #作业序
                     sfba006_2   LIKE sfba_t.sfba006,   #发料料号
                     sfba021_2   LIKE sfba_t.sfba021,   #产品特征
                     sfba014_2   LIKE sfba_t.sfba014,   #单位
                     sfba013_2   LIKE sfba_t.sfba013,   #应发数量  
                     sfba016_2   LIKE sfba_t.sfba016,   #已发数量
                     no_issue_2  LIKE sfba_t.sfba016,   #未发数量
                     issue_qty_2 LIKE sfba_t.sfba016,   #发料量
                     inag008_2   LIKE sfba_t.sfba016,   #库存可用量
                     inan010_2   LIKE sfba_t.sfba016    #在捡量
                     END RECORD
DEFINE l_sfba019  LIKE sfba_t.sfba019  #指定库位
DEFINE l_sfba020  LIKE sfba_t.sfba020  #指定储位
DEFINE l_sfba029  LIKE sfba_t.sfba029  #指定批号
DEFINE l_sfba030  LIKE sfba_t.sfba030  #指定库存管理特征

DEFINE l_inag        RECORD
                     seq_1       LIKE type_t.num5,      #顺序
                     seq_2       LIKE type_t.num5,      #项次
                     seq1_2      LIKE type_t.num5,      #项序
                     inag004_3   LIKE inag_t.inag004,   #库位
                     inag005_3   LIKE inag_t.inag005,   #储位
                     inag006_3   LIKE inag_t.inag006,   #批号
                     inag003_3   LIKE inag_t.inag003,   #库存管理特征
                     inag007_3   LIKE inag_t.inag007,   #单位
                     inag008_3   LIKE inag_t.inag008,   #现有库存数量
                     inan010_3   LIKE inan_t.inan010,   #库存在捡量
                     #has_qty_3   LIKE inag_t.inag008,   #其他工单分配量
                     issue_qty_3 LIKE inag_t.inag008    #发料量
                     END RECORD
DEFINE l_bmea        RECORD
                     seq_1       LIKE type_t.num5,      #顺序
                     seq_2       LIKE type_t.num5,      #项次
                     seq1_2      LIKE type_t.num5,      #项序
                     bmea007_4   LIKE bmea_t.bmea007,   #取替代特性
                     bmea008_4   LIKE bmea_t.bmea008,   #料件编号
                     bmea019_4   LIKE bmea_t.bmea019,   #產品特徵
                     replace_rate_4    LIKE sfba_t.sfba022,   #替代率
                     bmea016_4   LIKE bmea_t.bmea016,   #替代方式
                     bmea017_4   LIKE bmea_t.bmea017,   #替代上限比率
                     inag004_4   LIKE inag_t.inag004,   #库位
                     inag005_4   LIKE inag_t.inag005,   #储位
                     inag006_4   LIKE inag_t.inag006,   #批号
                     inag003_4   LIKE inag_t.inag003,   #库存管理特征 
                     inag007_4   LIKE inag_t.inag007,   #单位
                     inag008_4   LIKE inag_t.inag008,   #现有库存数量 
                     inan010_4   LIKE inan_t.inan010,   #库存在捡量
                     #has_qty_4   LIKE inag_t.inag008,   #其他工单分配量    
                     issue_qty_4 LIKE inag_t.inag008    #发料量
                     END RECORD
DEFINE l_gen         type_g_gen_d

   LET r_success = FALSE
   
   #定义游标--有发料量的发料资料
   LET l_sql = " SELECT * FROM asfp310_sfba ",
               "  WHERE seq_1 = ? ",
               "    AND issue_qty_2 > 0 "
   PREPARE asfp310_01_gen_sfba_p FROM l_sql
   DECLARE asfp310_01_gen_sfba_c CURSOR FOR asfp310_01_gen_sfba_p
   
   #LET l_sql = " SELECT sfba019,sfba020,sfba029,sfba030 ",
   #            "   FROM sfba_t ",
   #            "  WHERE sfbaent  = ",g_enterprise,
   #            "    AND sfbadocno= ? ",
   #            "    AND sfbaseq  = ? ",
   #            "    AND sfbaseq1 = ? "
   #PREPARE asfp310_01_gen_sfba_p2 FROM l_sql

   LET l_sql = " SELECT * FROM asfp310_inag ",
               "  WHERE seq_1 = ? ",
               "    AND seq_2 = ? ",
               "    AND seq1_2= ? ",
               "    AND issue_qty_3 > 0 "
   PREPARE asfp310_01_gen_inag_p FROM l_sql
   DECLARE asfp310_01_gen_inag_c CURSOR FOR asfp310_01_gen_inag_p
   
   LET l_sql = " SELECT * FROM asfp310_bmea ",
               "  WHERE seq_1 = ? ",
               "    AND seq_2 = ? ",
               "    AND seq1_2= ? ",
               "    AND issue_qty_4 > 0 "
   PREPARE asfp310_01_gen_bmea_p FROM l_sql
   DECLARE asfp310_01_gen_bmea_c CURSOR FOR asfp310_01_gen_bmea_p
   

   FOR l_i = 1 TO g_sfaa_d.getLength()
       IF g_sfaa_d[l_i].sel_1 = 'Y' THEN
          #抓取工单单身sfba资料
          OPEN asfp310_01_gen_sfba_c USING g_sfaa_d[l_i].seq_1
          FOREACH asfp310_01_gen_sfba_c INTO l_sfba.*
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "FOREACH:"
                LET g_errparam.popup = TRUE
                CALL cl_err()
                RETURN r_success
             END IF
             
             INITIALIZE l_gen.* TO NULL
             LET l_gen.seq_1          = g_sfaa_d[l_i].seq_1       #顺序
             LET l_gen.sfaadocno_1    = g_sfaa_d[l_i].sfaadocno_1 #工单单号
             LET l_gen.sfaa010_1      = g_sfaa_d[l_i].sfaa010_1   #生产料号
             LET l_gen.sfaa019_1      = g_sfaa_d[l_i].sfaa019_1   #预计开工日
             LET l_gen.sfaa020_1      = g_sfaa_d[l_i].sfaa020_1   #预计完工日
             LET l_gen.sfaa017_1      = g_sfaa_d[l_i].sfaa017_1   #部门厂商
             LET l_gen.sfaa002_1      = g_sfaa_d[l_i].sfaa002_1   #生管员
             LET l_gen.sfba003_1      = g_sfaa_d[l_i].sfba003_1   #作业编号
             LET l_gen.sfba004_1      = g_sfaa_d[l_i].sfba004_1   #作业序
             LET l_gen.sfaa012_1      = g_sfaa_d[l_i].sfaa012_1   #生产数量
             LET l_gen.sfaa049_1      = g_sfaa_d[l_i].sfaa049_1   #已发套数
             LET l_gen.has_sets_1     = g_sfaa_d[l_i].has_sets_1  #已发齐套数
             LET l_gen.can_sets_1     = g_sfaa_d[l_i].can_sets_1  #可齐料套数
             LET l_gen.seq_2          = l_sfba.seq_2              #项次
             LET l_gen.seq1_2         = l_sfba.seq1_2             #项序
             LET l_gen.sfba002_2      = l_sfba.sfba002_2          #部位
             LET l_gen.sfba003_2      = l_sfba.sfba003_2          #作业
             LET l_gen.sfba004_2      = l_sfba.sfba004_2          #作业序
             LET l_gen.sfba006_2      = l_sfba.sfba006_2          #发料料号
             LET l_gen.sfba021_2      = l_sfba.sfba021_2          #产品特征
             LET l_gen.sfba014_2      = l_sfba.sfba014_2          #单位
             LET l_gen.sfba013_2      = l_sfba.sfba013_2          #应发数量  
             LET l_gen.sfba016_2      = l_sfba.sfba016_2          #已发数量
             LET l_gen.no_issue_2     = l_sfba.no_issue_2         #未发数量
             LET l_gen.issue_qty_2    = l_sfba.issue_qty_2        #发料量
             LET l_gen.inag008_2      = l_sfba.inag008_2          #库存可用量
             LET l_gen.inan010_2      = l_sfba.inan010_2          #在捡量
             
             ##用于D-MFG-0050工單指定發料庫儲，發料時允許修改
             #EXECUTE asfp310_01_gen_sfba_p2 USING l_gen.sfaadocno_1,l_gen.seq_2,l_gen.seq1_2
             #   INTO l_gen.sfba019,l_gen.sfba020,l_gen.sfba029,l_gen.sfba030
                
             #抓取inag资料
             OPEN asfp310_01_gen_inag_c USING l_sfba.seq_1,l_sfba.seq_2,l_sfba.seq1_2
             FOREACH asfp310_01_gen_inag_c INTO l_inag.*
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = "FOREACH:"
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   RETURN r_success
                END IF

                LET l_gen.bmea007_4      = ''                        #取替代特性
                LET l_gen.bmea008_4      = l_sfba.sfba006_2          #料件编号 实际发料料号
                LET l_gen.bmea019_4      = l_sfba.sfba021_2          #料件编号 实际发料料号
                LET l_gen.replace_rate_4 = 1                         #替代率
                LET l_gen.bmea016_4      = ''                        #替代方式
                LET l_gen.bmea017_4      = 0                         #替代上限比率
                LET l_gen.inag004_4      = l_inag.inag004_3          #库位
                LET l_gen.inag005_4      = l_inag.inag005_3          #储位
                LET l_gen.inag006_4      = l_inag.inag006_3          #批号
                LET l_gen.inag003_4      = l_inag.inag003_3          #库存管理特征 
                LET l_gen.inag007_4      = l_inag.inag007_3          #单位
                LET l_gen.inag008_4      = l_inag.inag008_3          #现有库存数量 
                LET l_gen.inan010_4      = l_inag.inan010_3          #库存在捡量
                #LET l_gen.has_qty_4      = l_inag.has_qty_3          #其他工单分配量    
                LET l_gen.issue_qty_4    = l_inag.issue_qty_3        #发料量
                
                #sort :分类排序--g_sfda_m.method
                #sort2:排序2--工单+项次+项序+库位 用于sfdc插入判断
                CASE g_sfda_m.method
                   WHEN '1'  #库位
                        LET l_gen.sort = l_gen.inag004_4
                   WHEN '2'  #工单
                        LET l_gen.sort = l_gen.sfaadocno_1
                   WHEN '3'  #工单+库位
                        LET l_gen.sort = l_gen.sfaadocno_1,l_gen.inag004_4
                  #151209-00022#1 add -----(S)
                   WHEN '4'  #不拆單   任意給一個值,這樣後續在產生發料單時才不會拆單
                        LET l_gen.sort = "1"
                  #151209-00022#1 add -----(E)
                END CASE
                LET l_gen.sort2 = l_gen.sfaadocno_1,' ',l_gen.seq_2,' ',l_gen.seq1_2,' ',l_gen.inag004_4
                #161109-00085#39-s
                #INSERT INTO asfp310_01_t VALUES(l_gen.*)
                INSERT INTO asfp310_01_t (seq_1,sfaadocno_1,sfaa010_1,sfaa019_1,sfaa020_1,
                                          sfaa017_1,sfaa002_1,sfba003_1,sfba004_1,sfaa012_1,
                                          sfaa049_1,has_sets_1,can_sets_1,seq_2,seq1_2,
                                          sfba002_2,sfba003_2,sfba004_2,sfba006_2,sfba021_2,
                                          sfba014_2,sfba013_2,sfba016_2,no_issue_2,issue_qty_2,
                                          inag008_2,inan010_2,bmea007_4,bmea008_4,bmea019_4,
                                          replace_rate_4,bmea016_4,bmea017_4,inag004_4,inag005_4,
                                          inag006_4,inag003_4,inag007_4,inag008_4,inan010_4,
                                          issue_qty_4,sort,sort2)
                                  VALUES (l_gen.seq_1,l_gen.sfaadocno_1,l_gen.sfaa010_1,l_gen.sfaa019_1,l_gen.sfaa020_1,  
                                          l_gen.sfaa017_1,l_gen.sfaa002_1,l_gen.sfba003_1,l_gen.sfba004_1,l_gen.sfaa012_1,  
                                          l_gen.sfaa049_1,l_gen.has_sets_1,l_gen.can_sets_1,l_gen.seq_2,l_gen.seq1_2,
                                          l_gen.sfba002_2,l_gen.sfba003_2,l_gen.sfba004_2,l_gen.sfba006_2,l_gen.sfba021_2,
                                          l_gen.sfba014_2,l_gen.sfba013_2,l_gen.sfba016_2,l_gen.no_issue_2,l_gen.issue_qty_2,
                                          l_gen.inag008_2,l_gen.inan010_2,l_gen.bmea007_4,l_gen.bmea008_4,l_gen.bmea019_4,
                                          l_gen.replace_rate_4,l_gen.bmea016_4,l_gen.bmea017_4,l_gen.inag004_4,l_gen.inag005_4, 
                                          l_gen.inag006_4,l_gen.inag003_4,l_gen.inag007_4,l_gen.inag008_4,l_gen.inan010_4,
                                          l_gen.issue_qty_4,l_gen.sort,l_gen.sort2)                                                                                                                                                                                                                                                                                                                  
                #161109-00085#39-e
             END FOREACH

             #抓取bmea资料
             OPEN asfp310_01_gen_bmea_c USING l_sfba.seq_1,l_sfba.seq_2,l_sfba.seq1_2
             FOREACH asfp310_01_gen_bmea_c INTO l_bmea.*
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = "FOREACH:"
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   RETURN r_success
                END IF
                
                LET l_gen.bmea007_4      = l_bmea.bmea007_4          #取替代特性
                LET l_gen.bmea008_4      = l_bmea.bmea008_4          #料件编号 实际发料料号
                LET l_gen.bmea019_4      = l_bmea.bmea019_4          #产品特征
                LET l_gen.replace_rate_4 = l_bmea.replace_rate_4     #替代率
                LET l_gen.bmea016_4      = l_bmea.bmea016_4          #替代方式
                LET l_gen.bmea017_4      = l_bmea.bmea017_4          #替代上限比率
                LET l_gen.inag004_4      = l_bmea.inag004_4          #库位
                LET l_gen.inag005_4      = l_bmea.inag005_4          #储位
                LET l_gen.inag006_4      = l_bmea.inag006_4          #批号
                LET l_gen.inag003_4      = l_bmea.inag003_4          #库存管理特征 
                LET l_gen.inag007_4      = l_bmea.inag007_4          #单位
                LET l_gen.inag008_4      = l_bmea.inag008_4          #现有库存数量 
                LET l_gen.inan010_4      = l_bmea.inan010_4          #库存在捡量
                #LET l_gen.has_qty_4      = l_bmea.has_qty_4          #其他工单分配量    
                LET l_gen.issue_qty_4    = l_bmea.issue_qty_4        #发料量
                CASE g_sfda_m.method
                   WHEN '1'  #库位
                        LET l_gen.sort = l_gen.inag004_4
                   WHEN '2'  #工单
                        LET l_gen.sort = l_gen.sfaadocno_1
                   WHEN '3'  #工单+库位
                        LET l_gen.sort = l_gen.sfaadocno_1,l_gen.inag004_4
                  #151209-00022#1 add -----(S)
                   WHEN '4'  #不拆單   任意給一個值,這樣後續在產生發料單時才不會拆單
                        LET l_gen.sort = "1"
                  #151209-00022#1 add -----(E)
                END CASE
                LET l_gen.sort2 = l_gen.sfaadocno_1,' ',l_gen.seq_2,' ',l_gen.seq1_2,' ',l_gen.inag004_4
                #161109-00085#39-s
                #INSERT INTO asfp310_01_t VALUES(l_gen.*)
                INSERT INTO asfp310_01_t (seq_1,sfaadocno_1,sfaa010_1,sfaa019_1,sfaa020_1,
                                          sfaa017_1,sfaa002_1,sfba003_1,sfba004_1,sfaa012_1,
                                          sfaa049_1,has_sets_1,can_sets_1,seq_2,seq1_2,
                                          sfba002_2,sfba003_2,sfba004_2,sfba006_2,sfba021_2,
                                          sfba014_2,sfba013_2,sfba016_2,no_issue_2,issue_qty_2,
                                          inag008_2,inan010_2,bmea007_4,bmea008_4,bmea019_4,
                                          replace_rate_4,bmea016_4,bmea017_4,inag004_4,inag005_4,
                                          inag006_4,inag003_4,inag007_4,inag008_4,inan010_4,
                                          issue_qty_4,sort,sort2)
                                  VALUES (l_gen.seq_1,l_gen.sfaadocno_1,l_gen.sfaa010_1,l_gen.sfaa019_1,l_gen.sfaa020_1,  
                                          l_gen.sfaa017_1,l_gen.sfaa002_1,l_gen.sfba003_1,l_gen.sfba004_1,l_gen.sfaa012_1,  
                                          l_gen.sfaa049_1,l_gen.has_sets_1,l_gen.can_sets_1,l_gen.seq_2,l_gen.seq1_2,
                                          l_gen.sfba002_2,l_gen.sfba003_2,l_gen.sfba004_2,l_gen.sfba006_2,l_gen.sfba021_2,
                                          l_gen.sfba014_2,l_gen.sfba013_2,l_gen.sfba016_2,l_gen.no_issue_2,l_gen.issue_qty_2,
                                          l_gen.inag008_2,l_gen.inan010_2,l_gen.bmea007_4,l_gen.bmea008_4,l_gen.bmea019_4,
                                          l_gen.replace_rate_4,l_gen.bmea016_4,l_gen.bmea017_4,l_gen.inag004_4,l_gen.inag005_4, 
                                          l_gen.inag006_4,l_gen.inag003_4,l_gen.inag007_4,l_gen.inag008_4,l_gen.inan010_4,
                                          l_gen.issue_qty_4,l_gen.sort,l_gen.sort2)                                                                                                                                                                                                                                                                                                                  
                #161109-00085#39-e
             END FOREACH
          END FOREACH
       END IF
   END FOR
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
#插入发料单
PRIVATE FUNCTION asfp310_01_gen_asft310()
DEFINE r_success     LIKE type_t.num5
DEFINE l_sql         STRING
DEFINE l_gen         type_g_gen_d
DEFINE l_sort_t      LIKE type_t.chr100   #sort :分类排序--g_sfda_m.method
DEFINE l_sort2_t     LIKE type_t.chr100   #sort2:排序2--工单+项次+项序+库位 用于sfdc插入判断
DEFINE l_sfdadocno   LIKE sfda_t.sfdadocno
#161109-00085#39-s
#DEFINE l_sfdb        RECORD LIKE sfdb_t.*
DEFINE l_sfdb RECORD  #發退料套數檔
       sfdbent LIKE sfdb_t.sfdbent, #企業編號
       sfdbsite LIKE sfdb_t.sfdbsite, #營運據點
       sfdbdocno LIKE sfdb_t.sfdbdocno, #發退料單號
       sfdb001 LIKE sfdb_t.sfdb001, #工單單號
       sfdb002 LIKE sfdb_t.sfdb002, #Run Card
       sfdb003 LIKE sfdb_t.sfdb003, #部位
       sfdb004 LIKE sfdb_t.sfdb004, #作業
       sfdb005 LIKE sfdb_t.sfdb005, #作業序
       sfdb006 LIKE sfdb_t.sfdb006, #預計套數
       sfdb007 LIKE sfdb_t.sfdb007, #實際套數
       sfdb008 LIKE sfdb_t.sfdb008, #正負
       sfdbud001 LIKE sfdb_t.sfdbud001, #自定義欄位(文字)001
       sfdbud002 LIKE sfdb_t.sfdbud002, #自定義欄位(文字)002
       sfdbud003 LIKE sfdb_t.sfdbud003, #自定義欄位(文字)003
       sfdbud004 LIKE sfdb_t.sfdbud004, #自定義欄位(文字)004
       sfdbud005 LIKE sfdb_t.sfdbud005, #自定義欄位(文字)005
       sfdbud006 LIKE sfdb_t.sfdbud006, #自定義欄位(文字)006
       sfdbud007 LIKE sfdb_t.sfdbud007, #自定義欄位(文字)007
       sfdbud008 LIKE sfdb_t.sfdbud008, #自定義欄位(文字)008
       sfdbud009 LIKE sfdb_t.sfdbud009, #自定義欄位(文字)009
       sfdbud010 LIKE sfdb_t.sfdbud010, #自定義欄位(文字)010
       sfdbud011 LIKE sfdb_t.sfdbud011, #自定義欄位(數字)011
       sfdbud012 LIKE sfdb_t.sfdbud012, #自定義欄位(數字)012
       sfdbud013 LIKE sfdb_t.sfdbud013, #自定義欄位(數字)013
       sfdbud014 LIKE sfdb_t.sfdbud014, #自定義欄位(數字)014
       sfdbud015 LIKE sfdb_t.sfdbud015, #自定義欄位(數字)015
       sfdbud016 LIKE sfdb_t.sfdbud016, #自定義欄位(數字)016
       sfdbud017 LIKE sfdb_t.sfdbud017, #自定義欄位(數字)017
       sfdbud018 LIKE sfdb_t.sfdbud018, #自定義欄位(數字)018
       sfdbud019 LIKE sfdb_t.sfdbud019, #自定義欄位(數字)019
       sfdbud020 LIKE sfdb_t.sfdbud020, #自定義欄位(數字)020
       sfdbud021 LIKE sfdb_t.sfdbud021, #自定義欄位(日期時間)021
       sfdbud022 LIKE sfdb_t.sfdbud022, #自定義欄位(日期時間)022
       sfdbud023 LIKE sfdb_t.sfdbud023, #自定義欄位(日期時間)023
       sfdbud024 LIKE sfdb_t.sfdbud024, #自定義欄位(日期時間)024
       sfdbud025 LIKE sfdb_t.sfdbud025, #自定義欄位(日期時間)025
       sfdbud026 LIKE sfdb_t.sfdbud026, #自定義欄位(日期時間)026
       sfdbud027 LIKE sfdb_t.sfdbud027, #自定義欄位(日期時間)027
       sfdbud028 LIKE sfdb_t.sfdbud028, #自定義欄位(日期時間)028
       sfdbud029 LIKE sfdb_t.sfdbud029, #自定義欄位(日期時間)029
       sfdbud030 LIKE sfdb_t.sfdbud030  #自定義欄位(日期時間)030
END RECORD
#161109-00085#39-e
#161109-00085#39-s
#DEFINE l_sfdc        RECORD LIKE sfdc_t.*
DEFINE l_sfdc RECORD  #發退料需求檔
       sfdcent LIKE sfdc_t.sfdcent, #企業編號
       sfdcsite LIKE sfdc_t.sfdcsite, #營運據點
       sfdcdocno LIKE sfdc_t.sfdcdocno, #發退料單號
       sfdcseq LIKE sfdc_t.sfdcseq, #項次
       sfdc001 LIKE sfdc_t.sfdc001, #工單單號
       sfdc002 LIKE sfdc_t.sfdc002, #工單項次
       sfdc003 LIKE sfdc_t.sfdc003, #工單項序
       sfdc004 LIKE sfdc_t.sfdc004, #需求料號
       sfdc005 LIKE sfdc_t.sfdc005, #產品特徵
       sfdc006 LIKE sfdc_t.sfdc006, #單位
       sfdc007 LIKE sfdc_t.sfdc007, #申請數量
       sfdc008 LIKE sfdc_t.sfdc008, #實際數量
       sfdc009 LIKE sfdc_t.sfdc009, #參考單位
       sfdc010 LIKE sfdc_t.sfdc010, #參考單位需求數量
       sfdc011 LIKE sfdc_t.sfdc011, #參考單位實際數量
       sfdc012 LIKE sfdc_t.sfdc012, #指定庫位
       sfdc013 LIKE sfdc_t.sfdc013, #指定儲位
       sfdc014 LIKE sfdc_t.sfdc014, #指定批號
       sfdc015 LIKE sfdc_t.sfdc015, #理由碼
       sfdc016 LIKE sfdc_t.sfdc016, #庫存管理特徴
       sfdc017 LIKE sfdc_t.sfdc017, #正負
       sfdcud001 LIKE sfdc_t.sfdcud001, #自定義欄位(文字)001
       sfdcud002 LIKE sfdc_t.sfdcud002, #自定義欄位(文字)002
       sfdcud003 LIKE sfdc_t.sfdcud003, #自定義欄位(文字)003
       sfdcud004 LIKE sfdc_t.sfdcud004, #自定義欄位(文字)004
       sfdcud005 LIKE sfdc_t.sfdcud005, #自定義欄位(文字)005
       sfdcud006 LIKE sfdc_t.sfdcud006, #自定義欄位(文字)006
       sfdcud007 LIKE sfdc_t.sfdcud007, #自定義欄位(文字)007
       sfdcud008 LIKE sfdc_t.sfdcud008, #自定義欄位(文字)008
       sfdcud009 LIKE sfdc_t.sfdcud009, #自定義欄位(文字)009
       sfdcud010 LIKE sfdc_t.sfdcud010, #自定義欄位(文字)010
       sfdcud011 LIKE sfdc_t.sfdcud011, #自定義欄位(數字)011
       sfdcud012 LIKE sfdc_t.sfdcud012, #自定義欄位(數字)012
       sfdcud013 LIKE sfdc_t.sfdcud013, #自定義欄位(數字)013
       sfdcud014 LIKE sfdc_t.sfdcud014, #自定義欄位(數字)014
       sfdcud015 LIKE sfdc_t.sfdcud015, #自定義欄位(數字)015
       sfdcud016 LIKE sfdc_t.sfdcud016, #自定義欄位(數字)016
       sfdcud017 LIKE sfdc_t.sfdcud017, #自定義欄位(數字)017
       sfdcud018 LIKE sfdc_t.sfdcud018, #自定義欄位(數字)018
       sfdcud019 LIKE sfdc_t.sfdcud019, #自定義欄位(數字)019
       sfdcud020 LIKE sfdc_t.sfdcud020, #自定義欄位(數字)020
       sfdcud021 LIKE sfdc_t.sfdcud021, #自定義欄位(日期時間)021
       sfdcud022 LIKE sfdc_t.sfdcud022, #自定義欄位(日期時間)022
       sfdcud023 LIKE sfdc_t.sfdcud023, #自定義欄位(日期時間)023
       sfdcud024 LIKE sfdc_t.sfdcud024, #自定義欄位(日期時間)024
       sfdcud025 LIKE sfdc_t.sfdcud025, #自定義欄位(日期時間)025
       sfdcud026 LIKE sfdc_t.sfdcud026, #自定義欄位(日期時間)026
       sfdcud027 LIKE sfdc_t.sfdcud027, #自定義欄位(日期時間)027
       sfdcud028 LIKE sfdc_t.sfdcud028, #自定義欄位(日期時間)028
       sfdcud029 LIKE sfdc_t.sfdcud029, #自定義欄位(日期時間)029
       sfdcud030 LIKE sfdc_t.sfdcud030  #自定義欄位(日期時間)030
END RECORD
#161109-00085#39-e
#161109-00085#39-s
#DEFINE l_sfdd        RECORD LIKE sfdd_t.*
DEFINE l_sfdd RECORD  #發退料明細檔
       sfddent LIKE sfdd_t.sfddent, #企業編號
       sfddsite LIKE sfdd_t.sfddsite, #營運據點
       sfdddocno LIKE sfdd_t.sfdddocno, #發退料單號
       sfddseq LIKE sfdd_t.sfddseq, #項次
       sfddseq1 LIKE sfdd_t.sfddseq1, #項序
       sfdd001 LIKE sfdd_t.sfdd001, #發退料料號
       sfdd002 LIKE sfdd_t.sfdd002, #替代率
       sfdd003 LIKE sfdd_t.sfdd003, #庫位
       sfdd004 LIKE sfdd_t.sfdd004, #儲位
       sfdd005 LIKE sfdd_t.sfdd005, #批號
       sfdd006 LIKE sfdd_t.sfdd006, #單位
       sfdd007 LIKE sfdd_t.sfdd007, #數量
       sfdd008 LIKE sfdd_t.sfdd008, #參考單位
       sfdd009 LIKE sfdd_t.sfdd009, #參考單位數量
       sfdd010 LIKE sfdd_t.sfdd010, #庫存管理特徵
       sfdd011 LIKE sfdd_t.sfdd011, #包裝容器
       sfdd012 LIKE sfdd_t.sfdd012, #正負
       sfdd013 LIKE sfdd_t.sfdd013, #產品特徵
       sfddud001 LIKE sfdd_t.sfddud001, #自定義欄位(文字)001
       sfddud002 LIKE sfdd_t.sfddud002, #自定義欄位(文字)002
       sfddud003 LIKE sfdd_t.sfddud003, #自定義欄位(文字)003
       sfddud004 LIKE sfdd_t.sfddud004, #自定義欄位(文字)004
       sfddud005 LIKE sfdd_t.sfddud005, #自定義欄位(文字)005
       sfddud006 LIKE sfdd_t.sfddud006, #自定義欄位(文字)006
       sfddud007 LIKE sfdd_t.sfddud007, #自定義欄位(文字)007
       sfddud008 LIKE sfdd_t.sfddud008, #自定義欄位(文字)008
       sfddud009 LIKE sfdd_t.sfddud009, #自定義欄位(文字)009
       sfddud010 LIKE sfdd_t.sfddud010, #自定義欄位(文字)010
       sfddud011 LIKE sfdd_t.sfddud011, #自定義欄位(數字)011
       sfddud012 LIKE sfdd_t.sfddud012, #自定義欄位(數字)012
       sfddud013 LIKE sfdd_t.sfddud013, #自定義欄位(數字)013
       sfddud014 LIKE sfdd_t.sfddud014, #自定義欄位(數字)014
       sfddud015 LIKE sfdd_t.sfddud015, #自定義欄位(數字)015
       sfddud016 LIKE sfdd_t.sfddud016, #自定義欄位(數字)016
       sfddud017 LIKE sfdd_t.sfddud017, #自定義欄位(數字)017
       sfddud018 LIKE sfdd_t.sfddud018, #自定義欄位(數字)018
       sfddud019 LIKE sfdd_t.sfddud019, #自定義欄位(數字)019
       sfddud020 LIKE sfdd_t.sfddud020, #自定義欄位(數字)020
       sfddud021 LIKE sfdd_t.sfddud021, #自定義欄位(日期時間)021
       sfddud022 LIKE sfdd_t.sfddud022, #自定義欄位(日期時間)022
       sfddud023 LIKE sfdd_t.sfddud023, #自定義欄位(日期時間)023
       sfddud024 LIKE sfdd_t.sfddud024, #自定義欄位(日期時間)024
       sfddud025 LIKE sfdd_t.sfddud025, #自定義欄位(日期時間)025
       sfddud026 LIKE sfdd_t.sfddud026, #自定義欄位(日期時間)026
       sfddud027 LIKE sfdd_t.sfddud027, #自定義欄位(日期時間)027
       sfddud028 LIKE sfdd_t.sfddud028, #自定義欄位(日期時間)028
       sfddud029 LIKE sfdd_t.sfddud029, #自定義欄位(日期時間)029
       sfddud030 LIKE sfdd_t.sfddud030, #自定義欄位(日期時間)030
       sfdd014 LIKE sfdd_t.sfdd014, #備置量
       sfdd015 LIKE sfdd_t.sfdd015  #在揀量
END RECORD
#161109-00085#39-e
DEFINE l_seq_1_t     LIKE type_t.num5
#DEFINE l_sfdb007_1        LIKE sfdb_t.sfdb007  #已发套数
#DEFINE l_sfdb007_2        LIKE sfdb_t.sfdb007  #已退套数
#DEFINE l_sfaa012          LIKE sfaa_t.sfaa012  #生产数量
#DEFINE l_sfaa049          LIKE sfaa_t.sfaa049  #已发套数
DEFINE l_sfdcseq          LIKE sfdc_t.sfdcseq   #项次
DEFINE l_sfddseq1         LIKE sfdd_t.sfddseq1  #项序
DEFINE l_rate      LIKE inaj_t.inaj014  #单位换算率
#DEFINE l_sfdb006     LIKE sfdb_t.sfdb006   #工单+部位+作业+作业序 预计发料套数
#DEFINE l_sfdc007     LIKE sfdc_t.sfdc007   #本发料单据其他项次的发料数量
#DEFINE l_sfba010     LIKE sfba_t.sfba010   #标准QPA分子
#DEFINE l_sfba011     LIKE sfba_t.sfba011   #标准QPA分母
#DEFINE l_sfba002     LIKE sfba_t.sfba002   #部位
#DEFINE l_sfba003     LIKE sfba_t.sfba003   #作业
#DEFINE l_sfba004     LIKE sfba_t.sfba004   #作业序
#DEFINE l_sfba013     LIKE sfba_t.sfba013
#DEFINE l_sfba016     LIKE sfba_t.sfba016   #已发数量
DEFINE l_success     LIKE type_t.num5
DEFINE l_sfba019  LIKE sfba_t.sfba019  #指定库位
DEFINE l_sfba020  LIKE sfba_t.sfba020  #指定储位
DEFINE l_sfba029  LIKE sfba_t.sfba029  #指定批号
DEFINE l_sfba030  LIKE sfba_t.sfba030  #指定库存管理特征
DEFINE l_qty            LIKE sfdd_t.sfdd014    #160408-00035#7

   LET r_success = FALSE
   
   LET l_sql = "SELECT * FROM asfp310_01_t ",
               " ORDER BY sort,sort2 "
   PREPARE asfp310_01_gen_p FROM l_sql
   DECLARE asfp310_01_gen_c CURSOR FOR asfp310_01_gen_p
   LET l_sort_t = ''
   LET l_sort2_t = ''
   FOREACH asfp310_01_gen_c INTO l_gen.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      ####################
      #-->产生单头资料
      ####################
      IF cl_null(l_sort_t) OR l_gen.sort != l_sort_t THEN
         CALL asfp310_01_ins_sfda() RETURNING l_success,l_sfdadocno
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')
            RETURN r_success
         END IF
         #已产生发料单
         IF cl_null(g_wc_str) THEN
            LET g_wc_str = g_wc_str CLIPPED,"'",l_sfdadocno,"'"
         ELSE
            LET g_wc_str = g_wc_str CLIPPED,",'",l_sfdadocno,"'"
         END IF
         
         LET l_sort_t  = l_gen.sort
         LET l_seq_1_t = 0  #重新开始
         LET l_sfdcseq = 0  #项次
         LET l_sfddseq1= 0  #项序
      END IF
      
      ####################
      #-->sfdb_t
      ####################
      IF l_seq_1_t = 0 OR l_gen.seq_1 != l_seq_1_t THEN  #第一个单身的顺序 工单资讯
         LET l_seq_1_t = l_gen.seq_1
         
         INITIALIZE l_sfdb.* TO NULL
         LET l_sfdb.sfdbent   = g_enterprise       #企業代碼
         LET l_sfdb.sfdbsite  = g_site             #營運據點
         LET l_sfdb.sfdbdocno = l_sfdadocno        #發退料單號
         LET l_sfdb.sfdb001   = l_gen.sfaadocno_1  #工單單號
         
         #Run Card
         SELECT sfca001 INTO l_sfdb.sfdb002 FROM sfca_t
          WHERE sfcaent = g_enterprise
            AND sfcasite= g_site
            AND sfcadocno=l_gen.sfaadocno_1   #工单单号
        
         LET l_sfdb.sfdb003   = ' '                #部位
         LET l_sfdb.sfdb004   = l_gen.sfba003_1    #作業
         LET l_sfdb.sfdb005   = l_gen.sfba004_1    #作業序
         
         #預計套數
         ##IF 部位、作业、制程序 都没输入 THEN              
         ##    最大套数=工单生产数量sfaa012-工单已发套数sfaa049
         ##ELSE (部位 <> 空白 OR 作业<>空白 )
         ##    最大套数=工单生产数量sfaa012-(同工单的发料单未指定部位作业的实际套数+发料单有指定相同部位、作业、制程序的实际套数-退料单未指定部位作业的实际套数-退料单有指定相同部位、作业、制程序的实际套数)
         ##END IF
         #SELECT sfaa012,sfaa049  INTO l_sfaa012,l_sfaa049
         #  FROM sfaa_t
         # WHERE sfaaent   = g_enterprise
         #   AND sfaasite  = g_site
         #   AND sfaadocno = l_sfdb.sfdb001
         #IF cl_null(l_sfdb.sfdb003) AND cl_null(l_sfdb.sfdb004) AND cl_null(l_sfdb.sfdb005) THEN  #部位、作業、製程序 都沒輸入
         #   LET l_sfdb.sfdb006 =l_sfaa012-l_sfaa049  #工单生产数量-已发套数
         #ELSE #(部位 <> 空白 OR 作業<>空白 )
         #   #委外发料数量
         #   CALL s_asft310_get_sfdb007('11',l_sfdb.sfdb001,l_sfdb.sfdb003,l_sfdb.sfdb004,l_sfdb.sfdb005)
         #      RETURNING l_sfdb007_1     
         #   #委外退料数量
         #   CALL s_asft310_get_sfdb007('21',l_sfdb.sfdb001,l_sfdb.sfdb003,l_sfdb.sfdb004,l_sfdb.sfdb005)
         #      RETURNING l_sfdb007_2
         #
         #   LET l_sfdb.sfdb006 = l_sfaa012 - (l_sfdb007_1 - l_sfdb007_2)
         #END IF
         CALL s_asft310_get_sfdb006_11(l_sfdb.sfdb001,l_sfdb.sfdb003,l_sfdb.sfdb004,l_sfdb.sfdb005)
            RETURNING l_success,l_sfdb.sfdb006
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')
            RETURN r_success
         END IF
          
         LET l_sfdb.sfdb007   = l_sfdb.sfdb006     #實際套數
         LET l_sfdb.sfdb008   = -1                 #正負         
         #161109-00085#39-s
         #INSERT INTO sfdb_t VALUES(l_sfdb.*)
         INSERT INTO sfdb_t(sfdbent,sfdbsite,sfdbdocno,sfdb001,sfdb002,
                            sfdb003,sfdb004,sfdb005,sfdb006,sfdb007,
                            sfdb008,sfdbud001,sfdbud002,sfdbud003,sfdbud004,
                            sfdbud005,sfdbud006,sfdbud007,sfdbud008,sfdbud009,
                            sfdbud010,sfdbud011,sfdbud012,sfdbud013,sfdbud014,
                            sfdbud015,sfdbud016,sfdbud017,sfdbud018,sfdbud019,
                            sfdbud020,sfdbud021,sfdbud022,sfdbud023,sfdbud024,
                            sfdbud025,sfdbud026,sfdbud027,sfdbud028,sfdbud029,
                            sfdbud030) 
            VALUES(l_sfdb.sfdbent,l_sfdb.sfdbsite,l_sfdb.sfdbdocno,l_sfdb.sfdb001,l_sfdb.sfdb002,
                   l_sfdb.sfdb003,l_sfdb.sfdb004,l_sfdb.sfdb005,l_sfdb.sfdb006,l_sfdb.sfdb007,
                   l_sfdb.sfdb008,l_sfdb.sfdbud001,l_sfdb.sfdbud002,l_sfdb.sfdbud003,l_sfdb.sfdbud004,
                   l_sfdb.sfdbud005,l_sfdb.sfdbud006,l_sfdb.sfdbud007,l_sfdb.sfdbud008,l_sfdb.sfdbud009,
                   l_sfdb.sfdbud010,l_sfdb.sfdbud011,l_sfdb.sfdbud012,l_sfdb.sfdbud013,l_sfdb.sfdbud014,
                   l_sfdb.sfdbud015,l_sfdb.sfdbud016,l_sfdb.sfdbud017,l_sfdb.sfdbud018,l_sfdb.sfdbud019,
                   l_sfdb.sfdbud020,l_sfdb.sfdbud021,l_sfdb.sfdbud022,l_sfdb.sfdbud023,l_sfdb.sfdbud024,
                   l_sfdb.sfdbud025,l_sfdb.sfdbud026,l_sfdb.sfdbud027,l_sfdb.sfdbud028,l_sfdb.sfdbud029,
                   l_sfdb.sfdbud030)
         #161109-00085#39-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins sfdb_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
      END IF
      
      ####################
      #-->sfdc_t
      ####################
      IF cl_null(l_sort2_t) OR l_gen.sort2 != l_sort2_t THEN
         LET l_sort2_t = l_gen.sort2
         LET l_sfddseq1= 0  #项序
         INITIALIZE l_sfdc.* TO NULL
         LET l_sfdc.sfdcent   = g_enterprise      #企業代碼                         
         LET l_sfdc.sfdcsite  = g_site            #營運據點                         
         LET l_sfdc.sfdcdocno = l_sfdadocno       #發退料單號
         LET l_sfdcseq = l_sfdcseq + 1      
         LET l_sfdc.sfdcseq   = l_sfdcseq         #項次       
         LET l_sfdc.sfdc001   = l_gen.sfaadocno_1 #工單單號                         
         LET l_sfdc.sfdc002   = l_gen.seq_2       #工單項次                         
         LET l_sfdc.sfdc003   = l_gen.seq1_2      #工單項序                         
         LET l_sfdc.sfdc004   = l_gen.sfba006_2   #需求料號                         
         LET l_sfdc.sfdc005   = l_gen.sfba021_2   #特徵                             
         LET l_sfdc.sfdc006   = l_gen.sfba014_2   #單位

         ##申请数量
         #SELECT sfaa012,sfaa049,sfba013,sfba016,sfba010,sfba011,
         #       sfba002,sfba003,sfba004
         #  INTO l_sfaa012,l_sfaa049,l_sfba013,l_sfba016,l_sfba010,l_sfba011,
         #       l_sfba002,l_sfba003,l_sfba004
         #  FROM sfba_t,sfaa_t
         # WHERE sfaaent   = sfbaent
         #   AND sfaadocno = sfbadocno
         #   AND sfbaent   = g_enterprise
         #   AND sfbadocno = l_sfdc.sfdc001
         #   AND sfbaseq   = l_sfdc.sfdc002
         #   AND sfbaseq1  = l_sfdc.sfdc003

         #IF l_sfdb.sfdb006 = l_sfaa012 - l_sfaa049 THEN  #預計發料套數=生產數量-已發套數,即要把剩余
         #   #應發總數量-已發數量
         #   LET l_sfdc.sfdc007 = l_sfba013 - l_sfba016
         #ELSE
         #   #預計發料套數*標準QPA分子/標準QPA分母
         #   LET l_sfdc.sfdc007 = l_sfdb.sfdb006 * l_sfba010 / l_sfba011
         #END IF
         #IF l_sfdc.sfdc007 < 0 THEN
         #   LET l_sfdc.sfdc007 = 0        #申請數量   
         #END IF
         
         #参考单位
         SELECT imaf015 INTO l_sfdc.sfdc009
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite= g_site
            AND imaf001 = l_sfdc.sfdc004
         ##參考單位需求數量
         #CALL s_aimi190_get_convert(l_sfdc.sfdc004,l_sfdc.sfdc006,l_sfdc.sfdc009)
         #   RETURNING l_success,l_rate
         #IF NOT l_success THEN
         #   LET l_rate = 1
         #END IF
         #LET l_sfdc.sfdc010 = l_sfdc.sfdc007 * l_rate
         #mod 跟实际数量一起更新
         LET l_sfdc.sfdc007 = 0     #申請數量
         LET l_sfdc.sfdc010 = 0     #参考申請數量
         LET l_sfdc.sfdc008   = 0                 #實際數量                  
         LET l_sfdc.sfdc011   = 0                 #參考單位實際數量  
         LET l_sfdc.sfdc015   = ''                #理由碼
         LET l_sfdc.sfdc017   = -1                #正負
         
         #仓、储、批、库存管理特征给值
         #检查参数D-MFG-0050工單指定發料庫儲，發料時允許修改
         CALL s_aooi200_get_slip(l_sfdc.sfdc001) RETURNING l_success,g_ooba002
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         CALL cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0050')
            RETURNING g_para  #工單指定發料庫儲，發料時允許修改
         IF g_para = 'Y' THEN
            LET l_sfdc.sfdc012   = l_gen.inag004_4   #指定庫位
            LET l_sfdc.sfdc013   = ' '               #指定儲位
            LET l_sfdc.sfdc014   = ' '               #指定批號
            LET l_sfdc.sfdc016   = ' '               #庫存管理特徴
         ELSE
            LET l_sfba019 = ''
            LET l_sfba020 = ''
            LET l_sfba029 = ''
            LET l_sfba030 = ''
            SELECT sfba019,sfba020,sfba029,sfba030
              INTO l_sfba019,l_sfba020,l_sfba029,l_sfba030
              FROM sfba_t
             WHERE sfbaent  = g_enterprise
               AND sfbadocno= l_sfdc.sfdc001  #工单
               AND sfbaseq  = l_sfdc.sfdc002  #工单项次
               AND sfbaseq1 = l_sfdc.sfdc003  #工单项序
            IF NOT cl_null(l_sfba019) THEN
               LET l_sfdc.sfdc012   = l_sfba019   #指定庫位
            ELSE
               LET l_sfdc.sfdc012   = l_gen.inag004_4   #指定庫位 库位不能为空
            END IF
            IF NOT cl_null(l_sfba020) THEN
               LET l_sfdc.sfdc013   = l_sfba020   #指定儲位
            END IF
            IF NOT cl_null(l_sfba029) THEN
               LET l_sfdc.sfdc014   = l_sfba029   #指定批號
            END IF
            IF NOT cl_null(l_sfba030) THEN
               LET l_sfdc.sfdc016   = l_sfba030   #庫存管理特徴
            END IF
         END IF
         IF cl_null(l_sfdc.sfdc005) THEN LET l_sfdc.sfdc005 = ' ' END IF  #产品特征
         #161109-00085#39-s
         #INSERT INTO sfdc_t VALUES(l_sfdc.*)
         INSERT INTO sfdc_t ( sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,
                              sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,
                              sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,
                              sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,
                              sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004,
                              sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009,
                              sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014,
                              sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019,
                              sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024,
                              sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029,
                              sfdcud030)
                      VALUES(l_sfdc.sfdcent,l_sfdc.sfdcsite,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,
                             l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,
                             l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,l_sfdc.sfdc011,
                             l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,
                             l_sfdc.sfdc017,l_sfdc.sfdcud001,l_sfdc.sfdcud002,l_sfdc.sfdcud003,l_sfdc.sfdcud004,
                             l_sfdc.sfdcud005,l_sfdc.sfdcud006,l_sfdc.sfdcud007,l_sfdc.sfdcud008,l_sfdc.sfdcud009,
                             l_sfdc.sfdcud010,l_sfdc.sfdcud011,l_sfdc.sfdcud012,l_sfdc.sfdcud013,l_sfdc.sfdcud014,
                             l_sfdc.sfdcud015,l_sfdc.sfdcud016,l_sfdc.sfdcud017,l_sfdc.sfdcud018,l_sfdc.sfdcud019,
                             l_sfdc.sfdcud020,l_sfdc.sfdcud021,l_sfdc.sfdcud022,l_sfdc.sfdcud023,l_sfdc.sfdcud024,
                             l_sfdc.sfdcud025,l_sfdc.sfdcud026,l_sfdc.sfdcud027,l_sfdc.sfdcud028,l_sfdc.sfdcud029,
                             l_sfdc.sfdcud030)
         #161109-00085#39-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins sfdc_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
         
         #新增或更新sfde(包含新增或更新sfdf)   'N'代表不自动增加sfdf
         CALL s_asft310_chg_sfde_f_sfdc_ins(l_sfdadocno,l_sfdc.sfdcseq,'N') RETURNING l_success
         IF NOT l_success THEN
            RETURN r_success
         END IF
         
      END IF
      ####################
      #-->sfdd_t
      ####################
      INITIALIZE l_sfdd.* TO NULL
      LET l_sfdd.sfddent   = g_enterprise           #企業代碼
      LET l_sfdd.sfddsite  = g_site                 #營運據
      LET l_sfdd.sfdddocno = l_sfdadocno            #發退料單號
      LET l_sfdd.sfddseq   = l_sfdcseq              #項次
      LET l_sfddseq1 = l_sfddseq1 + 1
      LET l_sfdd.sfddseq1  = l_sfddseq1             #項序
      LET l_sfdd.sfdd001   = l_gen.bmea008_4        #發退料料號
      LET l_sfdd.sfdd013   = l_gen.bmea019_4        #产品特征
      LET l_sfdd.sfdd002   = l_gen.replace_rate_4   #替代率
      LET l_sfdd.sfdd003   = l_gen.inag004_4        #庫位
      LET l_sfdd.sfdd004   = l_gen.inag005_4        #儲位
      LET l_sfdd.sfdd005   = l_gen.inag006_4        #批號
      LET l_sfdd.sfdd006   = l_gen.inag007_4        #單位
      LET l_sfdd.sfdd007   = l_gen.issue_qty_4      #數量
      
      #参考单位
      IF l_sfdd.sfdd001 = l_sfdc.sfdc004 THEN #没发生取替代  #料号没变
         LET l_sfdd.sfdd008 = l_sfdc.sfdc009
      ELSE
         SELECT imaf015 INTO l_sfdd.sfdd008
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite= g_site
            AND imaf001 = l_sfdd.sfdd001
      END IF
      #參考單位數量
      IF cl_null(l_sfdd.sfdd008) THEN
         LET l_sfdd.sfdd009 = 0
      ELSE
         #mod 150101
         #CALL s_aimi190_get_convert(l_sfdd.sfdd001,l_sfdd.sfdd006,l_sfdd.sfdd008)
         #   RETURNING l_success,l_rate
         #IF NOT l_success THEN
         #   LET l_rate = 1
         #END IF
         #LET l_sfdd.sfdd009 = l_sfdd.sfdd007 * l_rate
         CALL s_aooi250_convert_qty(l_sfdd.sfdd001,l_sfdd.sfdd006,l_sfdd.sfdd008,l_sfdd.sfdd007)
            RETURNING l_success,l_sfdd.sfdd009
         IF NOT l_success THEN
            LET l_sfdd.sfdd009 = l_sfdd.sfdd007
         END IF
         #mod 150101 end
      END IF

      LET l_sfdd.sfdd010   = l_gen.inag003_4        #庫存管理特徵
      LET l_sfdd.sfdd011   = ''   #包裝容器
      LET l_sfdd.sfdd012   = -1   #正負
      #160408-00035#7---add---begin
      CALL s_asft310_get_sfbb008_sfbb009(l_sfdc.sfdc001,l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc016,l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc006)
         RETURNING l_qty
      IF l_sfdd.sfdd007 >= l_qty THEN 
         LET l_sfdd.sfdd014 = l_qty
      ELSE   
         LET l_sfdd.sfdd014 = l_sfdd.sfdd007 
      END IF
      LET l_sfdd.sfdd015 = l_sfdd.sfdd007 - l_sfdd.sfdd014
      ##160408-00035#7---add---end      
      IF cl_null(l_sfdd.sfdd013) THEN LET l_sfdd.sfdd013 = ' ' END IF  #产品特征
      #161109-00085#39-s
      #INSERT INTO sfdd_t VALUES(l_sfdd.*)
      INSERT INTO sfdd_t ( sfddent,sfddsite,sfdddocno,sfddseq,sfddseq1,
                           sfdd001,sfdd002,sfdd003,sfdd004,sfdd005,
                           sfdd006,sfdd007,sfdd008,sfdd009,sfdd010,
                           sfdd011,sfdd012,sfdd013,sfddud001,sfddud002,
                           sfddud003,sfddud004,sfddud005,sfddud006,sfddud007,
                           sfddud008,sfddud009,sfddud010,sfddud011,sfddud012,
                           sfddud013,sfddud014,sfddud015,sfddud016,sfddud017,
                           sfddud018,sfddud019,sfddud020,sfddud021,sfddud022,
                           sfddud023,sfddud024,sfddud025,sfddud026,sfddud027,
                           sfddud028,sfddud029,sfddud030,sfdd014,sfdd015)
         VALUES(l_sfdd.sfddent,l_sfdd.sfddsite,l_sfdd.sfdddocno,l_sfdd.sfddseq,l_sfdd.sfddseq1,
                l_sfdd.sfdd001,l_sfdd.sfdd002,l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,
                l_sfdd.sfdd006,l_sfdd.sfdd007,l_sfdd.sfdd008,l_sfdd.sfdd009,l_sfdd.sfdd010,
                l_sfdd.sfdd011,l_sfdd.sfdd012,l_sfdd.sfdd013,l_sfdd.sfddud001,l_sfdd.sfddud002,
                l_sfdd.sfddud003,l_sfdd.sfddud004,l_sfdd.sfddud005,l_sfdd.sfddud006,l_sfdd.sfddud007,
                l_sfdd.sfddud008,l_sfdd.sfddud009,l_sfdd.sfddud010,l_sfdd.sfddud011,l_sfdd.sfddud012,
                l_sfdd.sfddud013,l_sfdd.sfddud014,l_sfdd.sfddud015,l_sfdd.sfddud016,l_sfdd.sfddud017,
                l_sfdd.sfddud018,l_sfdd.sfddud019,l_sfdd.sfddud020,l_sfdd.sfddud021,l_sfdd.sfddud022,
                l_sfdd.sfddud023,l_sfdd.sfddud024,l_sfdd.sfddud025,l_sfdd.sfddud026,l_sfdd.sfddud027,
                l_sfdd.sfddud028,l_sfdd.sfddud029,l_sfdd.sfddud030,l_sfdd.sfdd014,l_sfdd.sfdd015)
      #161109-00085#39-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins sfdd_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
         
      #更新sfdc
      CALL s_asft310_chg_sfdc_f_sfdd_ins(l_sfdadocno,l_sfdc.sfdcseq,l_sfdd.sfddseq1) RETURNING l_success
      IF NOT l_success THEN
         RETURN r_success
      END IF
      #处理sfdf,sfde：sfdd与sfdf总数应该平的
      CALL s_asft310_chg_sfdf_f_sfdd_ins(l_sfdadocno,l_sfdc.sfdcseq,l_sfdd.sfddseq1) RETURNING l_success
      IF NOT l_success THEN
         RETURN r_success
      END IF

      #更新申请数量=实际数量
      UPDATE sfdc_t SET sfdc007 = sfdc008,  #申請數量
                        sfdc010 = sfdc011   #参考单位申請數量
       WHERE sfdcent  = g_enterprise
         AND sfdcdocno =l_sfdadocno
      UPDATE sfde_t SET sfde004 = sfde005,  #申請數量
                        sfde007 = sfde008   #参考单位申請數量
       WHERE sfdeent  = g_enterprise
         AND sfdedocno =l_sfdadocno

   END FOREACH

   LET r_success = TRUE
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION asfp310_01_ins_sfda()
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_sfdadocno     LIKE sfda_t.sfdadocno
   #161109-00085#39-s
   #DEFINE l_sfda          RECORD LIKE sfda_t.*
   DEFINE l_sfda RECORD  #發退料單頭檔
          sfdaent LIKE sfda_t.sfdaent, #企業編號
          sfdasite LIKE sfda_t.sfdasite, #營運據點
          sfdadocno LIKE sfda_t.sfdadocno, #發退料單號
          sfdadocdt LIKE sfda_t.sfdadocdt, #單據日期
          sfda001 LIKE sfda_t.sfda001, #過帳日期
          sfda002 LIKE sfda_t.sfda002, #發退料類別
          sfda003 LIKE sfda_t.sfda003, #生產部門
          sfda004 LIKE sfda_t.sfda004, #申請人
          sfda005 LIKE sfda_t.sfda005, #PBI編號
          sfda006 LIKE sfda_t.sfda006, #生產料號
          sfda007 LIKE sfda_t.sfda007, #BOM特性
          sfda008 LIKE sfda_t.sfda008, #產品特徵
          sfda009 LIKE sfda_t.sfda009, #生產控制組
          sfda010 LIKE sfda_t.sfda010, #作業編號
          sfda011 LIKE sfda_t.sfda011, #作業序
          sfda012 LIKE sfda_t.sfda012, #庫位
          sfda013 LIKE sfda_t.sfda013, #套數
          sfda014 LIKE sfda_t.sfda014, #來源單號
          sfda015 LIKE sfda_t.sfda015, #來源類型
          sfdaownid LIKE sfda_t.sfdaownid, #資料所有者
          sfdaowndp LIKE sfda_t.sfdaowndp, #資料所屬部門
          sfdacrtid LIKE sfda_t.sfdacrtid, #資料建立者
          sfdacrtdp LIKE sfda_t.sfdacrtdp, #資料建立部門
          sfdacrtdt LIKE sfda_t.sfdacrtdt, #資料創建日
          sfdamodid LIKE sfda_t.sfdamodid, #資料修改者
          sfdamoddt LIKE sfda_t.sfdamoddt, #最近修改日
          sfdacnfid LIKE sfda_t.sfdacnfid, #資料確認者
          sfdacnfdt LIKE sfda_t.sfdacnfdt, #資料確認日
          sfdapstid LIKE sfda_t.sfdapstid, #資料過帳者
          sfdapstdt LIKE sfda_t.sfdapstdt, #資料過帳日
          sfdastus LIKE sfda_t.sfdastus, #狀態碼
          sfdaud001 LIKE sfda_t.sfdaud001, #自定義欄位(文字)001
          sfdaud002 LIKE sfda_t.sfdaud002, #自定義欄位(文字)002
          sfdaud003 LIKE sfda_t.sfdaud003, #自定義欄位(文字)003
          sfdaud004 LIKE sfda_t.sfdaud004, #自定義欄位(文字)004
          sfdaud005 LIKE sfda_t.sfdaud005, #自定義欄位(文字)005
          sfdaud006 LIKE sfda_t.sfdaud006, #自定義欄位(文字)006
          sfdaud007 LIKE sfda_t.sfdaud007, #自定義欄位(文字)007
          sfdaud008 LIKE sfda_t.sfdaud008, #自定義欄位(文字)008
          sfdaud009 LIKE sfda_t.sfdaud009, #自定義欄位(文字)009
          sfdaud010 LIKE sfda_t.sfdaud010, #自定義欄位(文字)010
          sfdaud011 LIKE sfda_t.sfdaud011, #自定義欄位(數字)011
          sfdaud012 LIKE sfda_t.sfdaud012, #自定義欄位(數字)012
          sfdaud013 LIKE sfda_t.sfdaud013, #自定義欄位(數字)013
          sfdaud014 LIKE sfda_t.sfdaud014, #自定義欄位(數字)014
          sfdaud015 LIKE sfda_t.sfdaud015, #自定義欄位(數字)015
          sfdaud016 LIKE sfda_t.sfdaud016, #自定義欄位(數字)016
          sfdaud017 LIKE sfda_t.sfdaud017, #自定義欄位(數字)017
          sfdaud018 LIKE sfda_t.sfdaud018, #自定義欄位(數字)018
          sfdaud019 LIKE sfda_t.sfdaud019, #自定義欄位(數字)019
          sfdaud020 LIKE sfda_t.sfdaud020, #自定義欄位(數字)020
          sfdaud021 LIKE sfda_t.sfdaud021, #自定義欄位(日期時間)021
          sfdaud022 LIKE sfda_t.sfdaud022, #自定義欄位(日期時間)022
          sfdaud023 LIKE sfda_t.sfdaud023, #自定義欄位(日期時間)023
          sfdaud024 LIKE sfda_t.sfdaud024, #自定義欄位(日期時間)024
          sfdaud025 LIKE sfda_t.sfdaud025, #自定義欄位(日期時間)025
          sfdaud026 LIKE sfda_t.sfdaud026, #自定義欄位(日期時間)026
          sfdaud027 LIKE sfda_t.sfdaud027, #自定義欄位(日期時間)027
          sfdaud028 LIKE sfda_t.sfdaud028, #自定義欄位(日期時間)028
          sfdaud029 LIKE sfda_t.sfdaud029, #自定義欄位(日期時間)029
          sfdaud030 LIKE sfda_t.sfdaud030  #自定義欄位(日期時間)030
   END RECORD
   #161109-00085#39-e
   #DEFINE l_sfda          RECORD
   #             sfdaent         LIKE sfda_t.sfdaent,       #企業編號
   #             sfdasite        LIKE sfda_t.sfdasite,      #營運據點
   #             sfdadocno       LIKE sfda_t.sfdadocno,     #發退料單號
   #             sfdadocdt       LIKE sfda_t.sfdadocdt,     #單據日期
   #             sfda001         LIKE sfda_t.sfda001,       #過帳日期
   #             sfda002         LIKE sfda_t.sfda002,       #發退料類別
   #             sfda003         LIKE sfda_t.sfda003,       #生產部門
   #             sfda004         LIKE sfda_t.sfda004,       #申請人
   #             sfda005         LIKE sfda_t.sfda005,       #PBI編號
   #             sfda006         LIKE sfda_t.sfda006,       #生產料號
   #             sfda007         LIKE sfda_t.sfda007,       #BOM特性
   #             sfda008         LIKE sfda_t.sfda008,       #產品特徵
   #             sfda009         LIKE sfda_t.sfda009,       #生產控制組
   #             sfda010         LIKE sfda_t.sfda010,       #作業編號
   #             sfda011         LIKE sfda_t.sfda011,       #作業序
   #             sfda012         LIKE sfda_t.sfda012,       #庫位
   #             sfda013         LIKE sfda_t.sfda013,       #套數
   #             sfda015         LIKE sfda_t.sfda015,       #来源类型
   #             sfdaownid       LIKE sfda_t.sfdaownid,     #資料所有者
   #             sfdaowndp       LIKE sfda_t.sfdaowndp,     #資料所屬部門
   #             sfdacrtid       LIKE sfda_t.sfdacrtid,     #資料建立者
   #             sfdacrtdp       LIKE sfda_t.sfdacrtdp,     #資料建立部門
   #             sfdacrtdt       DATETIME YEAR TO SECOND,   #資料創建日
   #             sfdamodid       LIKE sfda_t.sfdamodid,     #資料修改者
   #             sfdamoddt       DATETIME YEAR TO SECOND,   #最近修改日
   #             sfdacnfid       LIKE sfda_t.sfdacnfid,     #資料確認者
   #             sfdacnfdt       DATETIME YEAR TO SECOND,   #資料確認日
   #             sfdapstid       LIKE sfda_t.sfdapstid,     #資料過帳者
   #             sfdapstdt       DATETIME YEAR TO SECOND,   #資料過帳日
   #             sfdastus        LIKE sfda_t.sfdastus       #狀態碼
   #                       END RECORD
   
   LET r_success  = TRUE
   LET r_sfdadocno = NULL
   
   INITIALIZE l_sfda.* TO NULL
   LET l_sfda.sfdaent   = g_enterprise      #企業代碼
   LET l_sfda.sfdasite  = g_site            #營運據點
   LET l_sfda.sfdadocdt = cl_get_today()    #單據日期
   LET l_sfda.sfda001   = cl_get_today()    #過帳日期
   LET l_sfda.sfda002   = '11'              #發料類別
   LET l_sfda.sfda003   = g_dept            #生產部門
   LET l_sfda.sfda004   = g_user            #申請人
   LET l_sfda.sfda005   = ''                #PBI編號
   LET l_sfda.sfda006   = ''                #生產料號
   LET l_sfda.sfda007   = ''                #BOM特性
   LET l_sfda.sfda008   = ''                #產品特徵
   LET l_sfda.sfda009   = ''                #生產控制組
   LET l_sfda.sfda010   = ''                #作業編號
   LET l_sfda.sfda011   = ''                #製程序
   LET l_sfda.sfda012   = ''                #庫位
   LET l_sfda.sfda013   = 0                 #套數
   LET l_sfda.sfda015   = '01'              #来源类型
   LET l_sfda.sfdaownid = g_user            #資料所有者
   LET l_sfda.sfdaowndp = g_dept            #資料所屬部門
   LET l_sfda.sfdacrtid = g_user            #資料建立者
   LET l_sfda.sfdacrtdp = g_dept            #資料建立部門
   LET l_sfda.sfdacrtdt = cl_get_current()  #資料創建日
   LET l_sfda.sfdamodid = ''                #資料修改者
   LET l_sfda.sfdamoddt = ''                #最近修改日
   LET l_sfda.sfdacnfid = ''                #資料確認者
   LET l_sfda.sfdacnfdt = ''                #資料確認日
   LET l_sfda.sfdapstid = ''                #資料過帳者
   LET l_sfda.sfdapstdt = ''                #資料過帳日
   LET l_sfda.sfdastus  = 'N'               #狀態碼
   
   #發退料單號
   CALL s_aooi200_gen_docno(g_site,g_sfda_m.sfdadocno,l_sfda.sfdadocdt,'asft311')
        RETURNING r_success,l_sfda.sfdadocno
   IF NOT r_success THEN
      RETURN r_success,r_sfdadocno
   END IF 
   
   #161109-00085#39-s
   #INSERT INTO sfda_t VALUES(l_sfda.*)
   INSERT INTO sfda_t ( sfdaent,sfdasite,sfdadocno,sfdadocdt,sfda001,
                        sfda002,sfda003,sfda004,sfda005,sfda006,
                        sfda007,sfda008,sfda009,sfda010,sfda011,
                        sfda012,sfda013,sfda014,sfda015,sfdaownid,
                        sfdaowndp,sfdacrtid,sfdacrtdp,sfdacrtdt,sfdamodid,
                        sfdamoddt,sfdacnfid,sfdacnfdt,sfdapstid,sfdapstdt,
                        sfdastus,sfdaud001,sfdaud002,sfdaud003,sfdaud004,
                        sfdaud005,sfdaud006,sfdaud007,sfdaud008,sfdaud009,
                        sfdaud010,sfdaud011,sfdaud012,sfdaud013,sfdaud014,
                        sfdaud015,sfdaud016,sfdaud017,sfdaud018,sfdaud019,
                        sfdaud020,sfdaud021,sfdaud022,sfdaud023,sfdaud024,
                        sfdaud025,sfdaud026,sfdaud027,sfdaud028,sfdaud029,
                        sfdaud030 )
      VALUES (l_sfda.sfdaent,l_sfda.sfdasite,l_sfda.sfdadocno,l_sfda.sfdadocdt,l_sfda.sfda001,
              l_sfda.sfda002,l_sfda.sfda003,l_sfda.sfda004,l_sfda.sfda005,l_sfda.sfda006,
              l_sfda.sfda007,l_sfda.sfda008,l_sfda.sfda009,l_sfda.sfda010,l_sfda.sfda011,
              l_sfda.sfda012,l_sfda.sfda013,l_sfda.sfda014,l_sfda.sfda015,l_sfda.sfdaownid,
              l_sfda.sfdaowndp,l_sfda.sfdacrtid,l_sfda.sfdacrtdp,l_sfda.sfdacrtdt,l_sfda.sfdamodid,
              l_sfda.sfdamoddt,l_sfda.sfdacnfid,l_sfda.sfdacnfdt,l_sfda.sfdapstid,l_sfda.sfdapstdt,
              l_sfda.sfdastus,l_sfda.sfdaud001,l_sfda.sfdaud002,l_sfda.sfdaud003,l_sfda.sfdaud004,
              l_sfda.sfdaud005,l_sfda.sfdaud006,l_sfda.sfdaud007,l_sfda.sfdaud008,l_sfda.sfdaud009,
              l_sfda.sfdaud010,l_sfda.sfdaud011,l_sfda.sfdaud012,l_sfda.sfdaud013,l_sfda.sfdaud014,
              l_sfda.sfdaud015,l_sfda.sfdaud016,l_sfda.sfdaud017,l_sfda.sfdaud018,l_sfda.sfdaud019,
              l_sfda.sfdaud020,l_sfda.sfdaud021,l_sfda.sfdaud022,l_sfda.sfdaud023,l_sfda.sfdaud024,
              l_sfda.sfdaud025,l_sfda.sfdaud026,l_sfda.sfdaud027,l_sfda.sfdaud028,l_sfda.sfdaud029,
              l_sfda.sfdaud030)
   #161109-00085#39-e
   #INSERT INTO sfda_t (sfdaent  ,sfdasite ,sfdadocno,sfdadocdt,sfda001  ,
   #                    sfda002  ,sfda003  ,sfda004  ,sfda005  ,sfda006  ,
   #                    sfda007  ,sfda008  ,sfda009  ,sfda010  ,sfda011  ,
   #                    sfda012  ,sfda013  ,sfda015  ,sfdaownid,sfdaowndp,
   #                    sfdacrtid,sfdacrtdp,sfdacrtdt,sfdamodid,sfdamoddt,
   #                    sfdacnfid,sfdacnfdt,sfdapstid,sfdapstdt,sfdastus)
   #   VALUES (l_sfda.sfdaent  ,l_sfda.sfdasite ,l_sfda.sfdadocno,l_sfda.sfdadocdt,l_sfda.sfda001  ,
   #           l_sfda.sfda002  ,l_sfda.sfda003  ,l_sfda.sfda004  ,l_sfda.sfda005  ,l_sfda.sfda006  ,
   #           l_sfda.sfda007  ,l_sfda.sfda008  ,l_sfda.sfda009  ,l_sfda.sfda010  ,l_sfda.sfda011  ,
   #           l_sfda.sfda012  ,l_sfda.sfda013  ,l_sfda.sfda015  ,l_sfda.sfdaownid,l_sfda.sfdaowndp,
   #           l_sfda.sfdacrtid,l_sfda.sfdacrtdp,l_sfda.sfdacrtdt,l_sfda.sfdamodid,l_sfda.sfdamoddt,
   #           l_sfda.sfdacnfid,l_sfda.sfdacnfdt,l_sfda.sfdapstid,l_sfda.sfdapstdt,l_sfda.sfdastus)
   #record like已支持日期时间型，不需每个再列出来了
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins sfda_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,r_sfdadocno
   END IF

   LET r_sfdadocno = l_sfda.sfdadocno
   RETURN r_success,r_sfdadocno
END FUNCTION

PRIVATE FUNCTION asfp310_01_drop_table()
   DEFINE l_success LIKE type_t.num5
   
   DROP TABLE asfp310_01_t;
   
   #DROP TABLE asfp310_01_tmp01;
   CALL s_asft310_drop_table1() RETURNING l_success
END FUNCTION

 
{</section>}
 
