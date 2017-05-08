#該程式未解開Section, 採用最新樣板產出!
{<section id="axct200_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0022(2016-10-13 10:58:51), PR版次:0022(2017-04-18 16:07:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000133
#+ Filename...: axct200_01
#+ Description: 擷取標準工時
#+ Creator....: 02114(2014-05-07 11:26:44)
#+ Modifier...: 02040 -SD/PR- 02295
 
{</section>}
 
{<section id="axct200_01.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#150907-00015#1  15/11/25  By catmoon 成本中心來源增加報工單sffb030，並為默認值
#161012-00030#1  16/10/12  By 06948   調整刪除時，單頭刪除後並沒有一同刪除單身
#161010-00011#1  16/10/13  By 02040   QBE加上工單類型條件
#161019-00017#11 16/10/20  By 08734   调整法人组织开窗由q_ooef001为q_ooef001_1
#161109-00071#1  16/11/21  By charles4m 實際工時與機時從報工單取的部分增加報工取當月日期區間
#161202-00021#1  2016/12/05  By 06694   (1)抓工單時，不考慮該工單有無完工入庫，並加入二條件：工單作廢的不抓；與 在單頭日期該月的第一天到最後一天的區間。
#                                       (2)單身變數清空，避免被上一筆資料影響。
#                                       (3)交易數量如果不為空的話需做數量轉換。
#                                       (4)实际工时和机时从报工单取時，多取一 sffb017(良品數量)總和，如果實際工時為空or 0的話，讓他等於良品數量總和；並加入一條件： 在單頭日期該月的第一天到最後一天的區間。
#161124-00048#12 2016/12/13 By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
#170202-00005#1  2017/02/03 By 06694   增加法人權限管控
#170209-00001#1  2017/02/10 By zhaoqya 调整入库量取法
#170213-00017#1  2017/02/13 By stellar0130   在所有CALL s_aooi250_convert_qty函數前加判斷
#170210-00024#1  2017/02/14 By 00768   调整画面法人条件的处理方式
#170215-00026#1  2017/02/16 By charles4m 成本中心改用sfaa068
#170224-00023#1  2017/02/24 By Whitney 重新產生時沒有更新單別流水碼
#160711-00040#35 2017/03/29 By 08734   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                      CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
#170411-00074#1  2017/04/14 By 02295 委外工单截取否不勾选时,再抓取asft335报工工时时需排除委外的报工单
#end add-point
 
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
 
DEFINE g_rec_b               LIKE type_t.num10
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 type type_g_xcbh_m        RECORD
   xcbhdocno LIKE xcbh_t.xcbhdocno, 
   xcbh001   LIKE xcbh_t.xcbh001, 
   Outsourcing LIKE type_t.chr1, 
   xcbi001     LIKE xcbi_t.xcbi001,
   sum_source  LIKE type_t.num5      #fengmy151029
       END RECORD
DEFINE g_xcbh_m          type_g_xcbh_m

DEFINE g_wc1                 STRING
DEFINE g_wc2                 STRING
DEFINE g_sql                 STRING
DEFINE g_wc_cs_comp          STRING   #170202-00005#1 add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="axct200_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axct200_01(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   
   #end add-point
   )
   #add-point:construct段define name="construct.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   DEFINE  l_success      LIKE type_t.num5  #160711-00040#35 add
   DEFINE  l_sql1         STRING   #160711-00040#35 add
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_axct200_01 WITH FORM cl_ap_formpath("axc","axct200_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   WHENEVER ERROR CONTINUE
   CALL cl_set_combo_scc('sum_source','8870')   #fengmy151029
   CALL cl_set_combo_scc('sfaa003','4007')      #161010-00011#1 add
   LET g_xcbh_m.sum_source = '1'                #161010-00011#1 add
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp   #170202-00005#1 add
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON sfaasite 
      
            #add-point:自定義action name="construct.action"
            ON ACTION controlp INFIELD sfaasite
            #add-point:ON ACTION controlp INFIELD sfaasite
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_1()                           #呼叫開窗  #161019-00017#11 16/10/20  By 08734
            DISPLAY g_qryparam.return1 TO sfaasite  #顯示到畫面上
            NEXT FIELD sfaasite                     #返回原欄位
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
 
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
            
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
      CONSTRUCT BY NAME g_wc1 ON xcbhcomp
      
            #add-point:自定義action
            ON ACTION controlp INFIELD xcbhcomp
            #add-point:ON ACTION controlp INFIELD xcbhcomp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #170202-00005#1---(s)--- 
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #170202-00005#1---(e)---             
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbhcomp  #顯示到畫面上
            NEXT FIELD xcbhcomp                     #返回原欄位
            #end add-point
	  
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理

            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理

            #end add-point
            
         
 
         
       
      END CONSTRUCT
      
      CONSTRUCT BY NAME g_wc2 ON sfaadocno,sfaa010,sfaadocdt,sfaa003    #161010-00011#1 add sfaa003
      
            #add-point:自定義action
            ON ACTION controlp INFIELD sfaadocno
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfaadocno_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaadocno  #顯示到畫面上
            NEXT FIELD sfaadocno                     #返回原欄位
            
            ON ACTION controlp INFIELD sfaa010
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa010  #顯示到畫面上
            NEXT FIELD sfaa010                     #返回原欄位
            #end add-point
	  
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理

            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理

            #end add-point
            
         
 
         
       
      END CONSTRUCT
      
      INPUT BY NAME g_xcbh_m.xcbhdocno,g_xcbh_m.xcbh001,g_xcbh_m.Outsourcing,g_xcbh_m.xcbi001,g_xcbh_m.sum_source ATTRIBUTE(WITHOUT DEFAULTS)  #fengmy1029 add sum_source
         BEFORE INPUT

         AFTER FIELD xcbhdocno
            
            
         ON ACTION controlp INFIELD xcbhdocno
            #add-point:ON ACTION controlp INFIELD xcbhdocno
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbh_m.xcbhdocno             #給予default值
            LET g_qryparam.where = " oobx003 = 'axct200'" 
            #160711-00040#35 add(S)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",l_sql1
            END IF
            #160711-00040#35 add(S)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooba002()                                #呼叫開窗

            LET g_xcbh_m.xcbhdocno = g_qryparam.return1              
            
            DISPLAY g_xcbh_m.xcbhdocno TO xcbhdocno              #

            NEXT FIELD xcbhdocno                          #返回原欄位   
      
         AFTER INPUT
         #add-point:單頭輸入後處理

         #end add-point
            
      END INPUT
      
      BEFORE DIALOG
         LET g_xcbh_m.xcbh001 = g_today
         LET g_xcbh_m.Outsourcing = 'N'
         LET g_xcbh_m.xcbi001 = '1'    #預設為報工單 #150907-00015#1 add
      #end add-point
      
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
   IF INT_FLAG THEN
      LET INT_FLAG = TRUE 
   ELSE
      CALL axct200_01_ins()
   END IF
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_axct200_01 
   
   #add-point:construct段after construct name="construct.post_construct"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct200_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axct200_01.other_function" readonly="Y" >}
# 整批插入
#fengmy151026 成本中心取报工单上sffb030,依照工单+成本中心汇总
PRIVATE FUNCTION axct200_01_ins()
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_site_t   LIKE sfaa_t.sfaasite
   DEFINE l_sffb006  LIKE sffb_t.sffb006
   DEFINE l_sffb007  LIKE sffb_t.sffb007
   DEFINE l_sffb008  LIKE sffb_t.sffb008
   DEFINE l_sfcb024  LIKE sfcb_t.sfcb024
   DEFINE l_sfcb026  LIKE sfcb_t.sfcb026
   DEFINE l_time1    LIKE sfcb_t.sfcb024
   DEFINE l_time2    LIKE sfcb_t.sfcb026
#   DEFINE l_xcbh     RECORD  LIKE  xcbh_t.*   #161124-00048#12 mark
   #161124-00048#12 add(s)
   DEFINE l_xcbh RECORD  #在製報工和統計單頭檔
       xcbhent LIKE xcbh_t.xcbhent, #企业编号
       xcbhsite LIKE xcbh_t.xcbhsite, #营运组织
       xcbhcomp LIKE xcbh_t.xcbhcomp, #法人组织
       xcbhdocno LIKE xcbh_t.xcbhdocno, #单据编号
       xcbh001 LIKE xcbh_t.xcbh001, #日期
       xcbh002 LIKE xcbh_t.xcbh002, #备注
       xcbhownid LIKE xcbh_t.xcbhownid, #资料所有者
       xcbhowndp LIKE xcbh_t.xcbhowndp, #资料所有部门
       xcbhcrtid LIKE xcbh_t.xcbhcrtid, #资料录入者
       xcbhcrtdp LIKE xcbh_t.xcbhcrtdp, #资料录入部门
       xcbhcrtdt LIKE xcbh_t.xcbhcrtdt, #资料创建日
       xcbhmodid LIKE xcbh_t.xcbhmodid, #资料更改者
       xcbhmoddt LIKE xcbh_t.xcbhmoddt, #最近更改日
       xcbhcnfid LIKE xcbh_t.xcbhcnfid, #资料审核者
       xcbhcnfdt LIKE xcbh_t.xcbhcnfdt, #数据审核日
       xcbhpstid LIKE xcbh_t.xcbhpstid, #资料过账者
       xcbhpstdt LIKE xcbh_t.xcbhpstdt, #资料过账日
       xcbhstus LIKE xcbh_t.xcbhstus  #状态码
END RECORD
   #161124-00048#12 add(e)
#   DEFINE l_xcbi     RECORD  LIKE  xcbi_t.*    #161124-00048#12 mark
   #161124-00048#12 add(s)
   DEFINE l_xcbi RECORD  #在製報工和統計單身檔
       xcbient LIKE xcbi_t.xcbient, #企业编号
       xcbisite LIKE xcbi_t.xcbisite, #营运据点
       xcbicomp LIKE xcbi_t.xcbicomp, #法人组织
       xcbidocno LIKE xcbi_t.xcbidocno, #单据编号
       xcbiseq LIKE xcbi_t.xcbiseq, #行序
       xcbi001 LIKE xcbi_t.xcbi001, #成本中心
       xcbi002 LIKE xcbi_t.xcbi002, #工单编号
       xcbi009 LIKE xcbi_t.xcbi009, #备注
       xcbi100 LIKE xcbi_t.xcbi100, #入库数量
       xcbi101 LIKE xcbi_t.xcbi101, #期末在制数量
       xcbi102 LIKE xcbi_t.xcbi102, #期末在制约当率
       xcbi103 LIKE xcbi_t.xcbi103, #期末在制约当量
       xcbi104 LIKE xcbi_t.xcbi104, #报工数量
       xcbi201 LIKE xcbi_t.xcbi201, #实际工时
       xcbi202 LIKE xcbi_t.xcbi202, #实际几时
       xcbi203 LIKE xcbi_t.xcbi203, #标准工时
       xcbi204 LIKE xcbi_t.xcbi204  #标准几时
END RECORD
   #161124-00048#12 add(e)
#   DEFINE l_sfaa     RECORD  LIKE  sfaa_t.*   #161124-00048#12 mark
   #161124-00048#12 add(s)
   DEFINE l_sfaa RECORD  #工單單頭檔
       sfaaent LIKE sfaa_t.sfaaent, #企业编号
       sfaaownid LIKE sfaa_t.sfaaownid, #资料所有者
       sfaaowndp LIKE sfaa_t.sfaaowndp, #资料所有部门
       sfaacrtid LIKE sfaa_t.sfaacrtid, #资料录入者
       sfaacrtdp LIKE sfaa_t.sfaacrtdp, #资料录入部门
       sfaacrtdt LIKE sfaa_t.sfaacrtdt, #资料创建日
       sfaamodid LIKE sfaa_t.sfaamodid, #资料更改者
       sfaamoddt LIKE sfaa_t.sfaamoddt, #最近更改日
       sfaacnfid LIKE sfaa_t.sfaacnfid, #资料审核者
       sfaacnfdt LIKE sfaa_t.sfaacnfdt, #数据审核日
       sfaapstid LIKE sfaa_t.sfaapstid, #资料过账者
       sfaapstdt LIKE sfaa_t.sfaapstdt, #资料过账日
       sfaastus LIKE sfaa_t.sfaastus, #状态码
       sfaasite LIKE sfaa_t.sfaasite, #营运据点
       sfaadocno LIKE sfaa_t.sfaadocno, #单号
       sfaadocdt LIKE sfaa_t.sfaadocdt, #单据日期
       sfaa001 LIKE sfaa_t.sfaa001, #变更版本
       sfaa002 LIKE sfaa_t.sfaa002, #生管人员
       sfaa003 LIKE sfaa_t.sfaa003, #工单类型
       sfaa004 LIKE sfaa_t.sfaa004, #发料制度
       sfaa005 LIKE sfaa_t.sfaa005, #工单来源
       sfaa006 LIKE sfaa_t.sfaa006, #来源单号
       sfaa007 LIKE sfaa_t.sfaa007, #来源项次
       sfaa008 LIKE sfaa_t.sfaa008, #来源项序
       sfaa009 LIKE sfaa_t.sfaa009, #参考客户
       sfaa010 LIKE sfaa_t.sfaa010, #生产料号
       sfaa011 LIKE sfaa_t.sfaa011, #特性
       sfaa012 LIKE sfaa_t.sfaa012, #生产数量
       sfaa013 LIKE sfaa_t.sfaa013, #生产单位
       sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
       sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
       sfaa016 LIKE sfaa_t.sfaa016, #工艺编号
       sfaa017 LIKE sfaa_t.sfaa017, #部门供应商
       sfaa018 LIKE sfaa_t.sfaa018, #协作据点
       sfaa019 LIKE sfaa_t.sfaa019, #预计开工日
       sfaa020 LIKE sfaa_t.sfaa020, #预计完工日
       sfaa021 LIKE sfaa_t.sfaa021, #母工单单号
       sfaa022 LIKE sfaa_t.sfaa022, #参考原始单号
       sfaa023 LIKE sfaa_t.sfaa023, #参考原始项次
       sfaa024 LIKE sfaa_t.sfaa024, #参考原始项序
       sfaa025 LIKE sfaa_t.sfaa025, #前工单单号
       sfaa026 LIKE sfaa_t.sfaa026, #料表批号(PBI)
       sfaa027 LIKE sfaa_t.sfaa027, #No Use
       sfaa028 LIKE sfaa_t.sfaa028, #项目编号
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活动
       sfaa031 LIKE sfaa_t.sfaa031, #理由码
       sfaa032 LIKE sfaa_t.sfaa032, #紧急比率
       sfaa033 LIKE sfaa_t.sfaa033, #优先级
       sfaa034 LIKE sfaa_t.sfaa034, #预计入库库位
       sfaa035 LIKE sfaa_t.sfaa035, #预计入库储位
       sfaa036 LIKE sfaa_t.sfaa036, #手册编号
       sfaa037 LIKE sfaa_t.sfaa037, #保税核准文号
       sfaa038 LIKE sfaa_t.sfaa038, #保税核销
       sfaa039 LIKE sfaa_t.sfaa039, #备料已生成
       sfaa040 LIKE sfaa_t.sfaa040, #生产工艺路线已审核
       sfaa041 LIKE sfaa_t.sfaa041, #冻结
       sfaa042 LIKE sfaa_t.sfaa042, #返工
       sfaa043 LIKE sfaa_t.sfaa043, #备置
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa045 LIKE sfaa_t.sfaa045, #实际开始发料日
       sfaa046 LIKE sfaa_t.sfaa046, #最后入库日
       sfaa047 LIKE sfaa_t.sfaa047, #生管结案日
       sfaa048 LIKE sfaa_t.sfaa048, #成本结案日
       sfaa049 LIKE sfaa_t.sfaa049, #已发料套数
       sfaa050 LIKE sfaa_t.sfaa050, #已入库合格量
       sfaa051 LIKE sfaa_t.sfaa051, #已入库不合格量
       sfaa052 LIKE sfaa_t.sfaa052, #Bouns
       sfaa053 LIKE sfaa_t.sfaa053, #工单转入数量
       sfaa054 LIKE sfaa_t.sfaa054, #工单转出数量
       sfaa055 LIKE sfaa_t.sfaa055, #下线数量
       sfaa056 LIKE sfaa_t.sfaa056, #报废数量
       sfaa057 LIKE sfaa_t.sfaa057, #委外类型
       sfaa058 LIKE sfaa_t.sfaa058, #参考数量
       sfaa059 LIKE sfaa_t.sfaa059, #预计入库批号
       sfaa060 LIKE sfaa_t.sfaa060, #参考单位
       sfaa061 LIKE sfaa_t.sfaa061, #工艺
       sfaa062 LIKE sfaa_t.sfaa062, #纳入APS计算
       sfaa063 LIKE sfaa_t.sfaa063, #来源分批序
       sfaa064 LIKE sfaa_t.sfaa064, #参考原始分批序
       sfaa065 LIKE sfaa_t.sfaa065, #生管结案状态
       sfaa066 LIKE sfaa_t.sfaa066, #多角流程编号
       sfaa067 LIKE sfaa_t.sfaa067, #多角流进程号
       sfaa068 LIKE sfaa_t.sfaa068, #成本中心
       sfaa069 LIKE sfaa_t.sfaa069, #可供给量
       sfaa070 LIKE sfaa_t.sfaa070, #原始预计完工日期
       sfaa071 LIKE sfaa_t.sfaa071, #齐料套数
       sfaa072 LIKE sfaa_t.sfaa072  #保税否
END RECORD
   #161124-00048#12 add(e)
   DEFINE l_wc       STRING
   DEFINE l_wc1      STRING   
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_b_date   LIKE xcbh_t.xcbh001
   DEFINE l_e_date   LIKE xcbh_t.xcbh001
   DEFINE l_flag     LIKE type_t.chr1   #fengmy150116 add
   DEFINE l_glaald   LIKE glaa_t.glaald   
   DEFINE l_inaj011  LIKE inaj_t.inaj011
   DEFINE l_inaj012  LIKE inaj_t.inaj012
   DEFINE l_sffb030  LIKE sffb_t.sffb030  #fengmy151026 add
   DEFINE l_sffb017  LIKE sffb_t.sffb017  #161202-00021#1 add  --(4)--
   DEFINE l_ooef017  LIKE ooef_t.ooef017  #170210-00024#1 add
   #170224-00023#1-s
   DEFINE l_ld       LIKE glaa_t.glaald
   DEFINE l_docno    LIKE xcbh_t.xcbhdocno
   DEFINE l_date     LIKE xcbh_t.xcbh001
   DEFINE l_prog     LIKE gzzz_t.gzzz001
   #170224-00023#1-e
   
   LET l_flag = 'N'                     #fengmy150116 add
   CALL s_transaction_begin()
   
   LET l_b_date = g_xcbh_m.xcbh001 USING 'YYYY/MM/01'
   LET l_e_date = s_date_get_last_date(g_xcbh_m.xcbh001)
   LET l_wc = s_chr_replace(g_wc,'sfaasite','xcbhsite',0)
   LET l_wc1 = s_chr_replace(g_wc,'sfaasite','xcbisite',0)
#axct200检查若有同年期同法人的，则提示是否删除
   LET g_sql = "SELECT COUNT(*) FROM xcbh_t ",
               " WHERE xcbhent = '",g_enterprise,"'",
               "   AND xcbh001 BETWEEN '",l_b_date,"' AND '",l_e_date,"'",
               "   AND xcbhcomp IN ",g_wc_cs_comp,   #170202-00005#1 add
               "   AND ",g_wc1,
               "   AND ",l_wc
 
   PREPARE xcbh_cnt_pre FROM g_sql
   DECLARE xcbh_cnt_cs CURSOR FOR xcbh_cnt_pre 
 
   LET g_sql = "DELETE FROM xcbh_t ",
               " WHERE xcbhent = '",g_enterprise,"'",
               "   AND xcbh001 BETWEEN '",l_b_date,"' AND '",l_e_date,"'",
               "   AND xcbhcomp IN ",g_wc_cs_comp,   #170202-00005#1 add
               "   AND ",g_wc1,
               "   AND ",l_wc
 
   PREPARE xcbh_del_pre FROM g_sql
#   DECLARE xcbh_del_cs CURSOR FOR xcbh_del_pre 
   
   #170224-00023#1-s
   LET g_sql = " SELECT glaald,xcbhdocno,xcbh001 FROM xcbh_t ",
               "   LEFT JOIN glaa_t ON glaaent=xcbhent AND glaacomp=xcbhcomp AND glaa014='Y' ",
               "  WHERE xcbhent = ",g_enterprise,
               "    AND xcbh001 BETWEEN '",l_b_date,"' AND '",l_e_date,"'",
               "    AND xcbhcomp IN ",g_wc_cs_comp,
               "    AND ",g_wc1,
               "    AND ",l_wc
   PREPARE del_docno_pre FROM g_sql
   DECLARE del_docno_cur CURSOR FOR del_docno_pre
   #170224-00023#1-s

   LET g_sql = "DELETE FROM xcbi_t ",
               " WHERE xcbient = '",g_enterprise,"'",
               "   AND xcbidocno IN (",
               "   SELECT xcbhdocno FROM xcbh_t ",
               "    WHERE xcbhent = '",g_enterprise,"'",
               "      AND xcbh001 BETWEEN '",l_b_date,"' AND '",l_e_date,"'",
               "      AND xcbhcomp IN ",g_wc_cs_comp,   #170202-00005#1 add
               "      AND ",g_wc1,
               "      AND ",l_wc1,")"
 
   PREPARE xcbi_del_pre FROM g_sql
#   DECLARE xcbi_del_cs CURSOR FOR xcbi_del_pre 

   LET l_cnt = 0
   OPEN xcbh_cnt_cs
   FETCH xcbh_cnt_cs INTO l_cnt
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','1')
      RETURN 
   END IF   
   
   IF l_cnt > 0 THEN
      IF cl_ask_confirm('axc-00599') THEN
        #EXECUTE xcbh_del_pre    #161012-00030#1 mark
         EXECUTE xcbi_del_pre    #161012-00030#1 add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
           #LET g_errparam.extend = 'DELETE xcbh_t'   #161012-00030#1 mark
            LET g_errparam.extend = 'DELETE xcbi_t'   #161012-00030#1 add
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','1')
            RETURN 
         END IF 
         #170224-00023#1-s
         FOREACH del_docno_cur INTO l_ld,l_docno,l_date
            LET l_prog = g_prog
            LET g_prog = 'axct200'
            CALL s_aooi200_fin_del_docno(l_ld,l_docno,l_date) RETURNING l_success
            LET g_prog = l_prog
         END FOREACH
         #170224-00023#1-e
        #EXECUTE xcbi_del_pre    #161012-00030#1 mark
         EXECUTE xcbh_del_pre    #161012-00030#1 add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
           #LET g_errparam.extend = 'DELETE xcbi_t'   #161012-00030#1 mark
            LET g_errparam.extend = 'DELETE xcbh_t'   #161012-00030#1 add
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','1')
            RETURN 
         END IF         
      ELSE
         CALL s_transaction_end('N','1')
         RETURN
      END IF
   END IF
   
   LET g_wc1 = s_chr_replace(g_wc1,"xcbhcomp","ooef017",0)  #170210-00024#1 mod sfaasite->ooef017
   CASE g_xcbh_m.sum_source                  #fengmy151029 add
      WHEN 1                                 #fengmy151029 add
     #LET g_sql = "SELECT * FROM sfaa_t ",   #150907-00015#1 mark
     #150907-00015#1--add--start-------
#      LET g_sql = "SELECT UNIQUE sfaa_t.*,sffb030 FROM sfaa_t ",     #161124-00048#12 mark
     #161124-00048#12 add(s)
     LET g_sql =  "SELECT UNIQUE sfaaent,sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,sfaacrtdt,sfaamodid,",
                  "              sfaamoddt,sfaacnfid,sfaacnfdt,sfaapstid,sfaapstdt,sfaastus,sfaasite,",
                  "              sfaadocno,sfaadocdt,sfaa001,sfaa002,sfaa003,sfaa004,sfaa005,sfaa006,",
                  "              sfaa007,sfaa008,sfaa009,sfaa010,sfaa011,sfaa012,sfaa013,sfaa014,sfaa015,",
                  "              sfaa016,sfaa017,sfaa018,sfaa019,sfaa020,sfaa021,sfaa022,sfaa023,sfaa024,",
                  "              sfaa025,sfaa026,sfaa027,sfaa028,sfaa029,sfaa030,sfaa031,sfaa032,sfaa033,",
                  "              sfaa034,sfaa035,sfaa036,sfaa037,sfaa038,sfaa039,sfaa040,sfaa041,sfaa042,",
                  "              sfaa043,sfaa044,sfaa045,sfaa046,sfaa047,sfaa048,sfaa049,sfaa050,sfaa051,",
                  "              sfaa052,sfaa053,sfaa054,sfaa055,sfaa056,sfaa057,sfaa058,sfaa059,sfaa060,",
                  "              sfaa061,sfaa062,sfaa063,sfaa064,sfaa065,sfaa066,sfaa067,sfaa068,sfaa069,",
                  "              sfaa070,sfaa071,sfaa072,sffb030 FROM sfaa_t ",
     #161124-00048#12 add(e)
                  "  LEFT OUTER JOIN sffb_t ON (sfaadocno = sffb005 AND sfaaent = sffbent AND sfaasite = sffbsite )",
     #150907-00015#1--add--end---------
                  " WHERE sfaaent = '",g_enterprise,"'",
                  "   AND sfaadocno IN ( ",
                  "SELECT sfec001 FROM sfec_t,sfea_t ",
                  " WHERE sfeaent = sfecent ",  #170210-00024#1 mod ‘=’号前的sfecent->sfeaent
                  "   AND sfeadocno =sfecdocno ",
                  "   AND sfeaent = '",g_enterprise,"'",
                  "   AND sfea001 BETWEEN '",l_b_date,"' AND '",l_e_date,"'",
                  "   AND sfeastus = 'S' )",
                  "   AND sfaasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooefstus ='Y' AND ooef017 IN ",g_wc_cs_comp,")",  #170202-00005#1 add
                  #"   AND ",g_wc1, #170210-00024#1 mark
                  "   AND sfaasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooefstus ='Y' AND ",g_wc1,")",  #170210-00024#1 add
                  "   AND ",g_wc2,
                  "   AND ",g_wc
                  
       IF g_xcbh_m.Outsourcing = 'N' THEN 
          LET g_sql = g_sql," AND sfaa057 != '2'"
       END IF
       LET g_sql = g_sql," ORDER BY sfaasite"   
       
       PREPARE sfaa_pre FROM g_sql
       DECLARE sfaa_cur CURSOR FOR sfaa_pre 
   
       CALL cl_err_collect_init() 
      #FOREACH sfaa_cur INTO l_sfaa.*             #150907-00015#1 mark
       FOREACH sfaa_cur INTO l_sfaa.*,l_sffb030   #150907-00015#1 add
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "FOREACH:"
             LET g_errparam.popup = TRUE
             CALL cl_err()
             CALL s_transaction_end('N','1')
             RETURN 
          END IF
          
          #170210-00024#1 add-s
          #据点所属法人
          LET l_ooef017 = ''
          SELECT ooef017 INTO l_ooef017 FROM ooef_t
           WHERE ooefent = g_enterprise
             AND ooef001 = l_sfaa.sfaasite
          #170210-00024#1 add-e
          
          LET l_flag = 'Y'   #fengmy150116 add
          IF cl_null(l_site_t) OR l_sfaa.sfaasite <> l_site_t THEN 
             #單頭
             LET l_glaald = ''
             SELECT glaald INTO l_glaald
               FROM glaa_t 
              WHERE glaaent  = g_enterprise
                AND glaacomp = l_ooef017  #170210-00024#1 mod l_sfaa.sfaasite->l_ooef017
                AND glaa014 = 'Y'
                
             CALL s_aooi200_fin_gen_docno(l_glaald,'','',g_xcbh_m.xcbhdocno,g_xcbh_m.xcbh001,'axct200')
             RETURNING l_success,l_xcbh.xcbhdocno
             IF l_success  = 0  THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'apm-00003'
                LET g_errparam.extend = g_xcbh_m.xcbhdocno
                LET g_errparam.popup = TRUE
                CALL cl_err()
   
                CALL s_transaction_end('N','1')
                RETURN 
             END IF
             
             LET l_xcbh.xcbhent  = g_enterprise
             LET l_xcbh.xcbhsite = l_sfaa.sfaasite
             LET l_xcbh.xcbhcomp = l_ooef017  #170210-00024#1 mod l_sfaa.sfaasite->l_ooef017
             LET l_xcbh.xcbh001 = g_xcbh_m.xcbh001
             LET l_xcbh.xcbh002 = ''
             LET l_xcbh.xcbhownid = g_user
             LET l_xcbh.xcbhowndp = g_dept
             LET l_xcbh.xcbhcrtid = g_user
             LET l_xcbh.xcbhcrtdp = g_dept 
             LET l_xcbh.xcbhcrtdt = cl_get_current()
             LET l_xcbh.xcbhmodid = ""
             LET l_xcbh.xcbhmoddt = ""
             LET l_xcbh.xcbhcnfid = ""
             LET l_xcbh.xcbhcnfdt = ""
             LET l_xcbh.xcbhstus = "N"
             
#             INSERT INTO xcbh_t VALUES(l_xcbh.*)  #161124-00048#12 mark
             #161124-00048#12 add(s)
             INSERT INTO xcbh_t(xcbhent,xcbhsite,xcbhcomp,xcbhdocno,xcbh001,xcbh002,xcbhownid,xcbhowndp,xcbhcrtid,
                                xcbhcrtdp,xcbhcrtdt,xcbhmodid,xcbhmoddt,xcbhcnfid,xcbhcnfdt,xcbhpstid,xcbhpstdt,xcbhstus) 
                         VALUES(l_xcbh.xcbhent,l_xcbh.xcbhsite,l_xcbh.xcbhcomp,l_xcbh.xcbhdocno,l_xcbh.xcbh001,l_xcbh.xcbh002,l_xcbh.xcbhownid,l_xcbh.xcbhowndp,l_xcbh.xcbhcrtid,
                                l_xcbh.xcbhcrtdp,l_xcbh.xcbhcrtdt,l_xcbh.xcbhmodid,l_xcbh.xcbhmoddt,l_xcbh.xcbhcnfid,l_xcbh.xcbhcnfdt,l_xcbh.xcbhpstid,l_xcbh.xcbhpstdt,l_xcbh.xcbhstus)
             #161124-00048#12 add(e)
             IF SQLCA.SQLcode  THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "l_xcbh"
                LET g_errparam.popup = TRUE
                CALL cl_err()
     
                CALL s_transaction_end('N','1')
                RETURN                        
             END IF
          END IF 
          
          LET l_site_t = l_sfaa.sfaasite
          
          #單身
          LET l_xcbi.xcbient = g_enterprise
          LET l_xcbi.xcbisite = l_sfaa.sfaasite
          LET l_xcbi.xcbicomp = l_ooef017  #170210-00024#1 mod l_sfaa.sfaasite->l_ooef017
          LET l_xcbi.xcbidocno = l_xcbh.xcbhdocno
          
          SELECT MAX(xcbiseq)+1 INTO l_xcbi.xcbiseq
            FROM xcbi_t
           WHERE xcbient = g_enterprise
             AND xcbidocno = l_xcbh.xcbhdocno
          IF cl_null(l_xcbi.xcbiseq) THEN 
             LET l_xcbi.xcbiseq = 1 
          END IF
          #150907-00015#1--mark--start---------------
          #IF g_xcbh_m.Outsourcing = 'Y' THEN   #委外工单按成本中心来源 1：交易对象=sfaa017   2：成本中心=sfaa068
          #   IF g_xcbh_m.xcbi001 = '1' THEN 
          #      LET l_xcbi.xcbi001 = l_sfaa.sfaa017
          #   ELSE
          #      LET l_xcbi.xcbi001 = l_sfaa.sfaa068   
          #   END IF          
          #ELSE                                 #非委外工单，成本中心一律取sfaa068
          #   LET l_xcbi.xcbi001 = l_sfaa.sfaa068
          #END IF    
          #150907-00015#1--mark--end-----------------      
          #150907-00015#1--add---start---------------
          IF g_xcbh_m.Outsourcing = 'Y' THEN   #委外工单按成本中心来源 1：報工單=sffb030  2：交易对象=sfaa017  3：成本中心=sfaa068
             CASE g_xcbh_m.xcbi001
	 	          WHEN '1' 
	 	             LET l_xcbi.xcbi001 = l_sffb030
                WHEN '2' 
                   LET l_xcbi.xcbi001 = l_sfaa.sfaa017
                WHEN '3'
                   LET l_xcbi.xcbi001 = l_sfaa.sfaa068        
                OTHERWISE 
                   LET l_xcbi.xcbi001 = l_sffb030
             END CASE             
          ELSE                                 #非委外工单，成本中心一律取sfbb030
            #LET l_xcbi.xcbi001 = l_sffb030      #170215-00026#1 mark
             LET l_xcbi.xcbi001 = l_sfaa.sfaa068 #170215-00026#1 add
          END IF              
          #150907-00015#1--add---end-----------------
          IF cl_null(l_xcbi.xcbi001) THEN LET l_xcbi.xcbi001 = ' ' END IF  #fengmy150731 
          LET l_xcbi.xcbi002 = l_sfaa.sfaadocno
          LET l_xcbi.xcbi009 = ''
   #期间入库量要从inaj抓       
          LET l_inaj012 = ''
          LET l_inaj011 = 0
          SELECT inaj012,SUM(inaj011) INTO l_inaj012,l_inaj011
            FROM inaj_t
           WHERE inajent = g_enterprise
             AND inaj020 = l_sfaa.sfaadocno
             AND inaj022 BETWEEN l_b_date AND l_e_date
   #          AND inaj036 IN ('103','104','105','106','107','110','111','112','113','114')
             AND inaj036 IN ('103','104','105','106','110','111','112','113')
           GROUP BY inaj012     
           IF NOT cl_null(l_inaj012) THEN    #170213-00017#1 add
              CALL s_aooi250_convert_qty(l_sfaa.sfaa010,l_inaj012,l_sfaa.sfaa013,l_inaj011)
                   RETURNING l_success,l_xcbi.xcbi100  
           END IF      #170213-00017#1 add
           IF cl_null(l_xcbi.xcbi100) THEN LET l_xcbi.xcbi100 = 0 END IF
   #       LET l_xcbi.xcbi100 = l_sfaa.sfaa050 
          #170209-00001#1 20170209 by stellar add ----- (S)
          #LET l_xcbi.xcbi101 = l_sfaa.sfaa012 - l_sfaa.sfaa050

          #抓取計算年月後的入庫量
          LET l_inaj012 = ''
          LET l_inaj011 = 0
          SELECT inaj012,SUM(inaj011) INTO l_inaj012,l_inaj011
            FROM inaj_t
           WHERE inajent = g_enterprise
             AND inaj020 = l_sfaa.sfaadocno
             AND inaj022 > l_e_date
             AND inaj036 IN ('103','104','105','106','110','111','112','113')
           GROUP BY inaj012     
           IF cl_null(l_inaj011) THEN LET l_inaj011 = 0 END IF
           IF NOT cl_null(l_inaj012) THEN    #170213-00017#1 add
              CALL s_aooi250_convert_qty(l_sfaa.sfaa010,l_inaj012,l_sfaa.sfaa013,l_inaj011)
                   RETURNING l_success,l_inaj011  
           END IF      #170213-00017#1 add
           
          #期末在製數量 = 生產數量 - (已入庫數量 - 計算年月後的入庫數量)
          LET l_xcbi.xcbi101 = l_sfaa.sfaa012 - (l_sfaa.sfaa050 - l_inaj011)
          ##170209-00001#1 20170209 by stellar add ----- (E)
          LET l_xcbi.xcbi102 = 0
          LET l_xcbi.xcbi103 = l_xcbi.xcbi101 * l_xcbi.xcbi102
          LET l_xcbi.xcbi104 = l_xcbi.xcbi100 + l_xcbi.xcbi103
          #实际工时和机时从报工单取
          #170411-00074#1---add---s
          IF g_xcbh_m.Outsourcing = 'N' THEN
             SELECT SUM(sffb014),SUM(sffb015)
               INTO l_xcbi.xcbi201,l_xcbi.xcbi202
               FROM sffb_t
              WHERE sffbent  = g_enterprise
                AND sffb005  = l_sfaa.sfaadocno
                AND sffbstus = 'Y'      
                AND sffb012 BETWEEN l_b_date AND l_e_date
                AND NOT EXISTS(SELECT 1 FROM sfcb_t 
                                WHERE sfcbent = sffbent 
                                  AND sfcbdocno = sffb005 
                                  AND sfcb001 = sffb006
                                  AND sfcb003 = sffb007
                                  AND sfcb004 = sffb008 
                                  AND sfcb012 = 'Y')                
          ELSE
          #170411-00074#1---add---e
             SELECT SUM(sffb014),SUM(sffb015)
               INTO l_xcbi.xcbi201,l_xcbi.xcbi202
               FROM sffb_t
              WHERE sffbent  = g_enterprise
                AND sffb005  = l_sfaa.sfaadocno
                AND sffbstus = 'Y'      
                AND sffb012 BETWEEN l_b_date AND l_e_date #161109-00071#1 add          
          END IF #170411-00074#1 
          IF l_xcbi.xcbi201 IS NULL THEN LET l_xcbi.xcbi201 = 0 END IF
          IF l_xcbi.xcbi202 IS NULL THEN LET l_xcbi.xcbi202 = 0 END IF
          
          SELECT imae051,imae052 INTO l_xcbi.xcbi203,l_xcbi.xcbi204
            FROM imae_t
           WHERE imaeent  = g_enterprise
             AND imaesite = l_sfaa.sfaasite 
             AND imae001  = l_sfaa.sfaa010
   
          LET l_xcbi.xcbi203 = l_xcbi.xcbi203 * l_xcbi.xcbi100
          LET l_xcbi.xcbi204 = l_xcbi.xcbi204 * l_xcbi.xcbi100
          
          IF l_xcbi.xcbi203 IS NULL THEN LET l_xcbi.xcbi203 = 0 END IF
          IF l_xcbi.xcbi204 IS NULL THEN LET l_xcbi.xcbi204 = 0 END IF
    
#          INSERT INTO xcbi_t VALUES(l_xcbi.*) #161124-00048#12 mark
          #161124-00048#12 add(s)
          INSERT INTO xcbi_t(xcbient,xcbisite,xcbicomp,xcbidocno,xcbiseq,xcbi001,xcbi002,xcbi009,
                             xcbi100,xcbi101,xcbi102,xcbi103,xcbi104,xcbi201,xcbi202,xcbi203,xcbi204) 
                      VALUES(l_xcbi.xcbient,l_xcbi.xcbisite,l_xcbi.xcbicomp,l_xcbi.xcbidocno,l_xcbi.xcbiseq,l_xcbi.xcbi001,l_xcbi.xcbi002,l_xcbi.xcbi009,
                             l_xcbi.xcbi100,l_xcbi.xcbi101,l_xcbi.xcbi102,l_xcbi.xcbi103,l_xcbi.xcbi104,l_xcbi.xcbi201,l_xcbi.xcbi202,l_xcbi.xcbi203,l_xcbi.xcbi204)
          #161124-00048#12 add(e)
          
          IF SQLCA.SQLcode  THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "l_xcbi"
             LET g_errparam.popup = TRUE
             CALL cl_err()
     
             CALL s_transaction_end('N','1')
             RETURN          
          END IF
       END FOREACH 
       
      WHEN 2  #fengmy151029 add
   #   LET g_sql = "SELECT * FROM sfaa_t ",                #fengmy151026 mark 加入成本中心sffb030
#      LET g_sql = "SELECT UNIQUE sfaa_t.*,sffb030 FROM sfaa_t,sffb_t ",  #fengmy151026 加入成本中心sffb030 #161124-00048#12 mark
      #161124-00048#12 add(s)
       LET g_sql = "SELECT UNIQUE sfaaent,sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,sfaacrtdt,sfaamodid,",
                  "              sfaamoddt,sfaacnfid,sfaacnfdt,sfaapstid,sfaapstdt,sfaastus,sfaasite,",
                  "              sfaadocno,sfaadocdt,sfaa001,sfaa002,sfaa003,sfaa004,sfaa005,sfaa006,",
                  "              sfaa007,sfaa008,sfaa009,sfaa010,sfaa011,sfaa012,sfaa013,sfaa014,sfaa015,",
                  "              sfaa016,sfaa017,sfaa018,sfaa019,sfaa020,sfaa021,sfaa022,sfaa023,sfaa024,",
                  "              sfaa025,sfaa026,sfaa027,sfaa028,sfaa029,sfaa030,sfaa031,sfaa032,sfaa033,",
                  "              sfaa034,sfaa035,sfaa036,sfaa037,sfaa038,sfaa039,sfaa040,sfaa041,sfaa042,",
                  "              sfaa043,sfaa044,sfaa045,sfaa046,sfaa047,sfaa048,sfaa049,sfaa050,sfaa051,",
                  "              sfaa052,sfaa053,sfaa054,sfaa055,sfaa056,sfaa057,sfaa058,sfaa059,sfaa060,",
                  "              sfaa061,sfaa062,sfaa063,sfaa064,sfaa065,sfaa066,sfaa067,sfaa068,sfaa069,",
                  "              sfaa070,sfaa071,sfaa072,sffb030 FROM sfaa_t,sffb_t",
      #161124-00048#12 add(e)
                  " WHERE sfaaent = '",g_enterprise,"'",
                  #161202-00021#1--(1)--modi--start-------
                  #"   AND sfaadocno IN ( ",
                  #"SELECT sfec001 FROM sfec_t,sfea_t ",
                  #" WHERE sfecent = sfecent ",
                  #"   AND sfeadocno =sfecdocno ",
                  #"   AND sfeaent = '",g_enterprise,"'",
                  #"   AND sfea001 BETWEEN '",l_b_date,"' AND '",l_e_date,"'",
                  #"   AND sfeastus = 'S' )",
                  "   AND sfaastus <> 'X' ",
                  "   AND sffb012 BETWEEN '",l_b_date,"' AND '",l_e_date,"'",
                  #161202-00021#1--(1)--modi--end------- 
                  #fengmy151026-----begin
                  "   AND sfaadocno = sffb005 ",
                  "   AND sfaaent = sffbent ",
                  "   AND sfaasite = sffbsite ",
                  #fengmy151026-----end
                  "   AND sfaasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooefstus ='Y' AND ooef017 IN ",g_wc_cs_comp,")",  #170202-00005#1 add
                  #"   AND ",g_wc1, #170210-00024#1 mark
                  "   AND sfaasite IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooefstus ='Y' AND ",g_wc1,")",  #170210-00024#1 add
                  "   AND ",g_wc2,
                  "   AND ",g_wc
                  
       IF g_xcbh_m.Outsourcing = 'N' THEN 
          LET g_sql = g_sql," AND sfaa057 != '2'"
       END IF
       LET g_sql = g_sql," ORDER BY sfaasite"   
       
       PREPARE sfaa_pre1 FROM g_sql               #fengmy151029 mod pre
       DECLARE sfaa_cur1 CURSOR FOR sfaa_pre1     #fengmy151029 mod pre&cur
   
       CALL cl_err_collect_init() 
   #    FOREACH sfaa_cur INTO l_sfaa.*    #fengmy151026 mark
       FOREACH sfaa_cur1 INTO l_sfaa.*,l_sffb030    #fengmy151026 
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "FOREACH:"
             LET g_errparam.popup = TRUE
             CALL cl_err()
             CALL s_transaction_end('N','1')
             RETURN 
          END IF
          
          #170210-00024#1 add-s
          #据点所属法人
          LET l_ooef017 = ''
          SELECT ooef017 INTO l_ooef017 FROM ooef_t
           WHERE ooefent = g_enterprise
             AND ooef001 = l_sfaa.sfaasite
          #170210-00024#1 add-e
          
          LET l_flag = 'Y'   #fengmy150116 add
          IF cl_null(l_site_t) OR l_sfaa.sfaasite <> l_site_t THEN 
             #單頭
             LET l_glaald = ''
             SELECT glaald INTO l_glaald
               FROM glaa_t 
              WHERE glaaent  = g_enterprise
                AND glaacomp = l_ooef017  #170210-00024#1 mod l_sfaa.sfaasite->l_ooef017
                AND glaa014 = 'Y'
                
             CALL s_aooi200_fin_gen_docno(l_glaald,'','',g_xcbh_m.xcbhdocno,g_xcbh_m.xcbh001,'axct200')
             RETURNING l_success,l_xcbh.xcbhdocno
             IF l_success  = 0  THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'apm-00003'
                LET g_errparam.extend = g_xcbh_m.xcbhdocno
                LET g_errparam.popup = TRUE
                CALL cl_err()
   
                CALL s_transaction_end('N','1')
                RETURN 
             END IF
             
             LET l_xcbh.xcbhent  = g_enterprise
             LET l_xcbh.xcbhsite = l_sfaa.sfaasite
             LET l_xcbh.xcbhcomp = l_ooef017  #170210-00024#1 mod l_sfaa.sfaasite->l_ooef017
             LET l_xcbh.xcbh001 = g_xcbh_m.xcbh001
             LET l_xcbh.xcbh002 = ''
             LET l_xcbh.xcbhownid = g_user
             LET l_xcbh.xcbhowndp = g_dept
             LET l_xcbh.xcbhcrtid = g_user
             LET l_xcbh.xcbhcrtdp = g_dept 
             LET l_xcbh.xcbhcrtdt = cl_get_current()
             LET l_xcbh.xcbhmodid = ""
             LET l_xcbh.xcbhmoddt = ""
             LET l_xcbh.xcbhcnfid = ""
             LET l_xcbh.xcbhcnfdt = ""
             LET l_xcbh.xcbhstus = "N"
             
#             INSERT INTO xcbh_t VALUES(l_xcbh.*)  #161124-00048#12 mark
             #161124-00048#12 add(s)
             INSERT INTO xcbh_t(xcbhent,xcbhsite,xcbhcomp,xcbhdocno,xcbh001,xcbh002,xcbhownid,xcbhowndp,xcbhcrtid,
                                xcbhcrtdp,xcbhcrtdt,xcbhmodid,xcbhmoddt,xcbhcnfid,xcbhcnfdt,xcbhpstid,xcbhpstdt,xcbhstus) 
                         VALUES(l_xcbh.xcbhent,l_xcbh.xcbhsite,l_xcbh.xcbhcomp,l_xcbh.xcbhdocno,l_xcbh.xcbh001,l_xcbh.xcbh002,l_xcbh.xcbhownid,l_xcbh.xcbhowndp,l_xcbh.xcbhcrtid,
                                l_xcbh.xcbhcrtdp,l_xcbh.xcbhcrtdt,l_xcbh.xcbhmodid,l_xcbh.xcbhmoddt,l_xcbh.xcbhcnfid,l_xcbh.xcbhcnfdt,l_xcbh.xcbhpstid,l_xcbh.xcbhpstdt,l_xcbh.xcbhstus)
             #161124-00048#12 add(e)
             IF SQLCA.SQLcode  THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "l_xcbh"
                LET g_errparam.popup = TRUE
                CALL cl_err()
     
                CALL s_transaction_end('N','1')
                RETURN                        
             END IF
          END IF 
          
          LET l_site_t = l_sfaa.sfaasite
          
          #單身
          INITIALIZE l_xcbi.* TO NULL   #161202-00021#1 add --(2)--
          LET l_xcbi.xcbient = g_enterprise
          LET l_xcbi.xcbisite = l_sfaa.sfaasite
          LET l_xcbi.xcbicomp = l_ooef017  #170210-00024#1 mod l_sfaa.sfaasite->l_ooef017
          LET l_xcbi.xcbidocno = l_xcbh.xcbhdocno
          
          SELECT MAX(xcbiseq)+1 INTO l_xcbi.xcbiseq
            FROM xcbi_t
           WHERE xcbient = g_enterprise
             AND xcbidocno = l_xcbh.xcbhdocno
          IF cl_null(l_xcbi.xcbiseq) THEN 
             LET l_xcbi.xcbiseq = 1 
          END IF
          
          #成本中心
          
          IF g_xcbh_m.Outsourcing = 'Y' THEN   #委外工单按成本中心来源 1：報工單=sffb030  2：交易对象=sfaa017  3：成本中心=sfaa068
             #150907-00015#1--mark--start-----------            
             #IF g_xcbh_m.xcbi001 = '1' THEN 
             #   LET l_xcbi.xcbi001 = l_sfaa.sfaa017
             #ELSE
#            #    LET l_xcbi.xcbi001 = l_sfaa.sfaa068     #fengmy151029 mark
             #   LET l_xcbi.xcbi001 = l_sffb030           #fengmy151029 add
             #END IF          
             #150907-00015#1--mark--end-------------
             #150907-00015#1--add---start-----------
             CASE g_xcbh_m.xcbi001
	 	          WHEN '1' 
	 	             LET l_xcbi.xcbi001 = l_sffb030
                WHEN '2' 
                   LET l_xcbi.xcbi001 = l_sfaa.sfaa017
                WHEN '3'
                   LET l_xcbi.xcbi001 = l_sfaa.sfaa068        
                OTHERWISE 
                   LET l_xcbi.xcbi001 = l_sffb030
             END CASE  
             #150907-00015#1--add---end-------------
          ELSE                                 #非委外工单，成本中心一律取sfbb030
#            LET l_xcbi.xcbi001 = l_sfaa.sfaa068     #fengmy151029 mark
             LET l_xcbi.xcbi001 = l_sffb030          #fengmy151029 add
          END IF
          IF cl_null(l_xcbi.xcbi001) THEN LET l_xcbi.xcbi001 = ' ' END IF  #fengmy150731 
          LET l_xcbi.xcbi002 = l_sfaa.sfaadocno
          LET l_xcbi.xcbi009 = ''
   #期间入库量要从inaj抓       
          LET l_inaj012 = ''
          LET l_inaj011 = 0
   #fengmy151026--------begin
   #       SELECT inaj012,SUM(inaj011) INTO l_inaj012,l_inaj011
   #         FROM inaj_t
   #        WHERE inajent = g_enterprise
   #          AND inaj020 = l_sfaa.sfaadocno
   #          AND inaj022 BETWEEN l_b_date AND l_e_date
   ##          AND inaj036 IN ('103','104','105','106','107','110','111','112','113','114')
   #          AND inaj036 IN ('103','104','105','106','110','111','112','113')
   #        GROUP BY inaj012
#170209-00001#1 --begin
#         SELECT inaj012,SUM(inaj011) INTO l_inaj012,l_inaj011
#           FROM inaj_t,sffb_t
#          WHERE inajent = g_enterprise
#            AND inaj020 = l_sfaa.sfaadocno
#            AND inaj022 BETWEEN l_b_date AND l_e_date
#  #          AND inaj036 IN ('103','104','105','106','107','110','111','112','113','114')
#            AND inaj036 IN ('103','104','105','106','110','111','112','113')
#            AND inajent = sffbent AND inajsite = sffbsite AND inaj020 = sffb005
#            AND sffb030 = l_sffb030 
#          GROUP BY inaj012
          SELECT inaj012,SUM(inaj011) INTO l_inaj012,l_inaj011
            FROM inaj_t
           WHERE inajent = g_enterprise
             AND inaj020 = l_sfaa.sfaadocno
             AND inaj022 BETWEEN l_b_date AND l_e_date
             AND inaj036 IN ('103','104','105','106','110','111','112','113')
             AND EXISTS (SELECT 1 FROM sffb_t
                          WHERE inajent = sffbent AND inajsite = sffbsite AND inaj020 = sffb005
                            AND sffb030 = l_sffb030) 
           GROUP BY inaj012
#170209-00001#1 --end 
   #fengmy151026--------end       
          IF NOT cl_null(l_inaj012) THEN #161202-00021#1 --(3)--
             CALL s_aooi250_convert_qty(l_sfaa.sfaa010,l_inaj012,l_sfaa.sfaa013,l_inaj011)
                RETURNING l_success,l_xcbi.xcbi100
          END IF   #161202-00021#1  --(3)--
                
           IF cl_null(l_xcbi.xcbi100) THEN LET l_xcbi.xcbi100 = 0 END IF
   #       LET l_xcbi.xcbi100 = l_sfaa.sfaa050
          #170209-00001#1 20170209 by stellar add ----- (S)
          #LET l_xcbi.xcbi101 = l_sfaa.sfaa012 - l_sfaa.sfaa050

          #抓取計算年月後的入庫量
          LET l_inaj012 = ''
          LET l_inaj011 = 0
          SELECT inaj012,SUM(inaj011) INTO l_inaj012,l_inaj011
            FROM inaj_t
           WHERE inajent = g_enterprise
             AND inaj020 = l_sfaa.sfaadocno
             AND inaj022 > l_e_date
             AND inaj036 IN ('103','104','105','106','110','111','112','113')
             AND EXISTS (SELECT 1 FROM sffb_t
                          WHERE inajent = sffbent AND inajsite = sffbsite AND inaj020 = sffb005
                            AND sffb030 = l_sffb030) 
           GROUP BY inaj012     
           IF cl_null(l_inaj011) THEN LET l_inaj011 = 0 END IF
           IF NOT cl_null(l_inaj012) THEN    #170213-00017#1 add
              CALL s_aooi250_convert_qty(l_sfaa.sfaa010,l_inaj012,l_sfaa.sfaa013,l_inaj011)
                   RETURNING l_success,l_inaj011  
           END IF    #170213-00017#1 add
 
          #期末在製數量 = 生產數量 - (已入庫數量 - 計算年月後的入庫數量)
          LET l_xcbi.xcbi101 = l_sfaa.sfaa012 - (l_sfaa.sfaa050 - l_inaj011)
          #170209-00001#1 20170209 by stellar add ----- (E)   
          LET l_xcbi.xcbi101 = l_sfaa.sfaa012 - l_sfaa.sfaa050
          LET l_xcbi.xcbi102 = 0
          LET l_xcbi.xcbi103 = l_xcbi.xcbi101 * l_xcbi.xcbi102
          LET l_xcbi.xcbi104 = l_xcbi.xcbi100 + l_xcbi.xcbi103
   #实际工时和机时从报工单取
          #170411-00074#1---add---s
          IF g_xcbh_m.Outsourcing = 'N' THEN
             SELECT SUM(sffb014),SUM(sffb015),SUM(sffb017)   
               INTO l_xcbi.xcbi201,l_xcbi.xcbi202,l_sffb017  
               FROM sffb_t
              WHERE sffbent  = g_enterprise
                AND sffb005  = l_sfaa.sfaadocno
                AND sffb030  = l_sffb030   
                AND sffbstus = 'Y' 
                AND sffb012 BETWEEN l_b_date AND l_e_date 
                AND NOT EXISTS(SELECT 1 FROM sfcb_t 
                                WHERE sfcbent = sffbent 
                                  AND sfcbdocno = sffb005 
                                  AND sfcb001 = sffb006
                                  AND sfcb003 = sffb007
                                  AND sfcb004 = sffb008 
                                  AND sfcb012 = 'Y')                
          ELSE
          #170411-00074#1---add---e
             SELECT SUM(sffb014),SUM(sffb015),SUM(sffb017)   #161202-00021#1 add sffb017 --(4)--
               INTO l_xcbi.xcbi201,l_xcbi.xcbi202,l_sffb017  #161202-00021#1 add sffb017 --(4)--
               FROM sffb_t
              WHERE sffbent  = g_enterprise
                AND sffb005  = l_sfaa.sfaadocno
                AND sffb030  = l_sffb030   #fengmy151026 add 
                AND sffbstus = 'Y' 
                AND sffb012 BETWEEN l_b_date AND l_e_date  #161202-00021#1 add --(4)--             
          END IF  #170411-00074#1
          IF l_xcbi.xcbi201 IS NULL THEN LET l_xcbi.xcbi201 = 0 END IF
          IF l_xcbi.xcbi202 IS NULL THEN LET l_xcbi.xcbi202 = 0 END IF
          #161202-00021#1--(4)--add ----- (S)
          IF cl_null(l_xcbi.xcbi104) OR l_xcbi.xcbi104 = 0 THEN
             LET l_xcbi.xcbi104 = l_sffb017  
          END IF
          #161202-00021#1--(4)--add ----- (E)          
          
          SELECT imae051,imae052 INTO l_xcbi.xcbi203,l_xcbi.xcbi204
            FROM imae_t
           WHERE imaeent  = g_enterprise
             AND imaesite = l_sfaa.sfaasite 
             AND imae001  = l_sfaa.sfaa010
   
          LET l_xcbi.xcbi203 = l_xcbi.xcbi203 * l_xcbi.xcbi100
          LET l_xcbi.xcbi204 = l_xcbi.xcbi204 * l_xcbi.xcbi100
          
          IF l_xcbi.xcbi203 IS NULL THEN LET l_xcbi.xcbi203 = 0 END IF
          IF l_xcbi.xcbi204 IS NULL THEN LET l_xcbi.xcbi204 = 0 END IF
    
#          INSERT INTO xcbi_t VALUES(l_xcbi.*) #161124-00048#12 mark
          #161124-00048#12 add(s)
          INSERT INTO xcbi_t(xcbient,xcbisite,xcbicomp,xcbidocno,xcbiseq,xcbi001,xcbi002,xcbi009,
                             xcbi100,xcbi101,xcbi102,xcbi103,xcbi104,xcbi201,xcbi202,xcbi203,xcbi204) 
                      VALUES(l_xcbi.xcbient,l_xcbi.xcbisite,l_xcbi.xcbicomp,l_xcbi.xcbidocno,l_xcbi.xcbiseq,l_xcbi.xcbi001,l_xcbi.xcbi002,l_xcbi.xcbi009,
                             l_xcbi.xcbi100,l_xcbi.xcbi101,l_xcbi.xcbi102,l_xcbi.xcbi103,l_xcbi.xcbi104,l_xcbi.xcbi201,l_xcbi.xcbi202,l_xcbi.xcbi203,l_xcbi.xcbi204)
          #161124-00048#12 add(e)
          
          IF SQLCA.SQLcode  THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "l_xcbi"
             LET g_errparam.popup = TRUE
             CALL cl_err()
     
             CALL s_transaction_end('N','1')
             RETURN          
          END IF
       END FOREACH 
   END CASE #fengmy151029---end 
#fengmy150116 ----begin
    IF l_flag = 'N' THEN 
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = ""
       LET g_errparam.code   = 'axc-00530' 
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CALL s_transaction_end('N','0')  
    ELSE 
#fengmy150116 ----begin      
       CALL s_transaction_end('Y','1')
    END IF    #fengmy150116
    CALL cl_err_collect_show() 
END FUNCTION

 
{</section>}
 
